

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


'' @REGISTER : TEST_tpc_decimate_rate
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_DECIMATE_RATE                          [15:0]           get_TPC_DECIMATE_RATE
''                                                             set_TPC_DECIMATE_RATE
''                                                             read_TPC_DECIMATE_RATE
''                                                             write_TPC_DECIMATE_RATE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_decimate_rate
    Private write_TPC_DECIMATE_RATE_value
    Private read_TPC_DECIMATE_RATE_value
    Private flag_TPC_DECIMATE_RATE

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

    Property Get get_TPC_DECIMATE_RATE
        get_TPC_DECIMATE_RATE = read_TPC_DECIMATE_RATE_value
    End Property

    Property Let set_TPC_DECIMATE_RATE(aData)
        write_TPC_DECIMATE_RATE_value = aData
        flag_TPC_DECIMATE_RATE        = &H1
    End Property

    Property Get read_TPC_DECIMATE_RATE
        read
        read_TPC_DECIMATE_RATE = read_TPC_DECIMATE_RATE_value
    End Property

    Property Let write_TPC_DECIMATE_RATE(aData)
        set_TPC_DECIMATE_RATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_DECIMATE_RATE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_DECIMATE_RATE_mask = mask then
                read_TPC_DECIMATE_RATE_value = data_low
            else
                read_TPC_DECIMATE_RATE_value = (data_low - H8000_0000) and TPC_DECIMATE_RATE_mask
            end If
        else
            read_TPC_DECIMATE_RATE_value = data_low and TPC_DECIMATE_RATE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_DECIMATE_RATE = &H0 Then read
        If flag_TPC_DECIMATE_RATE = &H0 Then write_TPC_DECIMATE_RATE_value = get_TPC_DECIMATE_RATE

        regValue = leftShift((write_TPC_DECIMATE_RATE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_DECIMATE_RATE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_DECIMATE_RATE_mask = mask then
                read_TPC_DECIMATE_RATE_value = data_low
            else
                read_TPC_DECIMATE_RATE_value = (data_low - H8000_0000) and TPC_DECIMATE_RATE_mask
            end If
        else
            read_TPC_DECIMATE_RATE_value = data_low and TPC_DECIMATE_RATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_DECIMATE_RATE_value = &H0
        flag_TPC_DECIMATE_RATE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_trigger_mode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_LATCH                          [5:5]            get_TPC_TRIGGER_LATCH
''                                                             set_TPC_TRIGGER_LATCH
''                                                             read_TPC_TRIGGER_LATCH
''                                                             write_TPC_TRIGGER_LATCH
''---------------------------------------------------------------------------------
'' TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL   [4:4]            get_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
''                                                             set_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
''                                                             read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
''                                                             write_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
''---------------------------------------------------------------------------------
'' TPC_CAPTURE_ENABLE                         [3:3]            get_TPC_CAPTURE_ENABLE
''                                                             set_TPC_CAPTURE_ENABLE
''                                                             read_TPC_CAPTURE_ENABLE
''                                                             write_TPC_CAPTURE_ENABLE
''---------------------------------------------------------------------------------
'' TPC_CAPTURE_MODE                           [2:1]            get_TPC_CAPTURE_MODE
''                                                             set_TPC_CAPTURE_MODE
''                                                             read_TPC_CAPTURE_MODE
''                                                             write_TPC_CAPTURE_MODE
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_MODE                           [0:0]            get_TPC_TRIGGER_MODE
''                                                             set_TPC_TRIGGER_MODE
''                                                             read_TPC_TRIGGER_MODE
''                                                             write_TPC_TRIGGER_MODE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_trigger_mode
    Private write_TPC_TRIGGER_LATCH_value
    Private read_TPC_TRIGGER_LATCH_value
    Private flag_TPC_TRIGGER_LATCH
    Private write_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value
    Private read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value
    Private flag_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
    Private write_TPC_CAPTURE_ENABLE_value
    Private read_TPC_CAPTURE_ENABLE_value
    Private flag_TPC_CAPTURE_ENABLE
    Private write_TPC_CAPTURE_MODE_value
    Private read_TPC_CAPTURE_MODE_value
    Private flag_TPC_CAPTURE_MODE
    Private write_TPC_TRIGGER_MODE_value
    Private read_TPC_TRIGGER_MODE_value
    Private flag_TPC_TRIGGER_MODE

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

    Property Get get_TPC_TRIGGER_LATCH
        get_TPC_TRIGGER_LATCH = read_TPC_TRIGGER_LATCH_value
    End Property

    Property Let set_TPC_TRIGGER_LATCH(aData)
        write_TPC_TRIGGER_LATCH_value = aData
        flag_TPC_TRIGGER_LATCH        = &H1
    End Property

    Property Get read_TPC_TRIGGER_LATCH
        read
        read_TPC_TRIGGER_LATCH = read_TPC_TRIGGER_LATCH_value
    End Property

    Property Let write_TPC_TRIGGER_LATCH(aData)
        set_TPC_TRIGGER_LATCH = aData
        write
    End Property

    Property Get get_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
        get_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL = read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value
    End Property

    Property Let set_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL(aData)
        write_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value = aData
        flag_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL        = &H1
    End Property

    Property Get read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
        read
        read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL = read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value
    End Property

    Property Let write_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL(aData)
        set_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL = aData
        write
    End Property

    Property Get get_TPC_CAPTURE_ENABLE
        get_TPC_CAPTURE_ENABLE = read_TPC_CAPTURE_ENABLE_value
    End Property

    Property Let set_TPC_CAPTURE_ENABLE(aData)
        write_TPC_CAPTURE_ENABLE_value = aData
        flag_TPC_CAPTURE_ENABLE        = &H1
    End Property

    Property Get read_TPC_CAPTURE_ENABLE
        read
        read_TPC_CAPTURE_ENABLE = read_TPC_CAPTURE_ENABLE_value
    End Property

    Property Let write_TPC_CAPTURE_ENABLE(aData)
        set_TPC_CAPTURE_ENABLE = aData
        write
    End Property

    Property Get get_TPC_CAPTURE_MODE
        get_TPC_CAPTURE_MODE = read_TPC_CAPTURE_MODE_value
    End Property

    Property Let set_TPC_CAPTURE_MODE(aData)
        write_TPC_CAPTURE_MODE_value = aData
        flag_TPC_CAPTURE_MODE        = &H1
    End Property

    Property Get read_TPC_CAPTURE_MODE
        read
        read_TPC_CAPTURE_MODE = read_TPC_CAPTURE_MODE_value
    End Property

    Property Let write_TPC_CAPTURE_MODE(aData)
        set_TPC_CAPTURE_MODE = aData
        write
    End Property

    Property Get get_TPC_TRIGGER_MODE
        get_TPC_TRIGGER_MODE = read_TPC_TRIGGER_MODE_value
    End Property

    Property Let set_TPC_TRIGGER_MODE(aData)
        write_TPC_TRIGGER_MODE_value = aData
        flag_TPC_TRIGGER_MODE        = &H1
    End Property

    Property Get read_TPC_TRIGGER_MODE
        read
        read_TPC_TRIGGER_MODE = read_TPC_TRIGGER_MODE_value
    End Property

    Property Let write_TPC_TRIGGER_MODE(aData)
        set_TPC_TRIGGER_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC_TRIGGER_LATCH_value = rightShift(data_low, 5) and &H1
        read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value = rightShift(data_low, 4) and &H1
        read_TPC_CAPTURE_ENABLE_value = rightShift(data_low, 3) and &H1
        read_TPC_CAPTURE_MODE_value = rightShift(data_low, 1) and &H3
        TPC_TRIGGER_MODE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_TRIGGER_MODE_mask = mask then
                read_TPC_TRIGGER_MODE_value = data_low
            else
                read_TPC_TRIGGER_MODE_value = (data_low - H8000_0000) and TPC_TRIGGER_MODE_mask
            end If
        else
            read_TPC_TRIGGER_MODE_value = data_low and TPC_TRIGGER_MODE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_TRIGGER_LATCH = &H0 or flag_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL = &H0 or flag_TPC_CAPTURE_ENABLE = &H0 or flag_TPC_CAPTURE_MODE = &H0 or flag_TPC_TRIGGER_MODE = &H0 Then read
        If flag_TPC_TRIGGER_LATCH = &H0 Then write_TPC_TRIGGER_LATCH_value = get_TPC_TRIGGER_LATCH
        If flag_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL = &H0 Then write_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value = get_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL
        If flag_TPC_CAPTURE_ENABLE = &H0 Then write_TPC_CAPTURE_ENABLE_value = get_TPC_CAPTURE_ENABLE
        If flag_TPC_CAPTURE_MODE = &H0 Then write_TPC_CAPTURE_MODE_value = get_TPC_CAPTURE_MODE
        If flag_TPC_TRIGGER_MODE = &H0 Then write_TPC_TRIGGER_MODE_value = get_TPC_TRIGGER_MODE

        regValue = leftShift((write_TPC_TRIGGER_LATCH_value and &H1), 5) + leftShift((write_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value and &H1), 4) + leftShift((write_TPC_CAPTURE_ENABLE_value and &H1), 3) + leftShift((write_TPC_CAPTURE_MODE_value and &H3), 1) + leftShift((write_TPC_TRIGGER_MODE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC_TRIGGER_LATCH_value = rightShift(data_low, 5) and &H1
        read_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value = rightShift(data_low, 4) and &H1
        read_TPC_CAPTURE_ENABLE_value = rightShift(data_low, 3) and &H1
        read_TPC_CAPTURE_MODE_value = rightShift(data_low, 1) and &H3
        TPC_TRIGGER_MODE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_TRIGGER_MODE_mask = mask then
                read_TPC_TRIGGER_MODE_value = data_low
            else
                read_TPC_TRIGGER_MODE_value = (data_low - H8000_0000) and TPC_TRIGGER_MODE_mask
            end If
        else
            read_TPC_TRIGGER_MODE_value = data_low and TPC_TRIGGER_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_TRIGGER_LATCH_value = &H0
        flag_TPC_TRIGGER_LATCH        = &H0
        write_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL_value = &H0
        flag_TPC_CAPTURE_OR_TRIGGER_SELECT_FROM_PHYCONTROL        = &H0
        write_TPC_CAPTURE_ENABLE_value = &H0
        flag_TPC_CAPTURE_ENABLE        = &H0
        write_TPC_CAPTURE_MODE_value = &H0
        flag_TPC_CAPTURE_MODE        = &H0
        write_TPC_TRIGGER_MODE_value = &H0
        flag_TPC_TRIGGER_MODE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_post_trigger_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_POST_TRIGGER_COUNT                     [15:0]           get_TPC_POST_TRIGGER_COUNT
''                                                             set_TPC_POST_TRIGGER_COUNT
''                                                             read_TPC_POST_TRIGGER_COUNT
''                                                             write_TPC_POST_TRIGGER_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_post_trigger_count
    Private write_TPC_POST_TRIGGER_COUNT_value
    Private read_TPC_POST_TRIGGER_COUNT_value
    Private flag_TPC_POST_TRIGGER_COUNT

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

    Property Get get_TPC_POST_TRIGGER_COUNT
        get_TPC_POST_TRIGGER_COUNT = read_TPC_POST_TRIGGER_COUNT_value
    End Property

    Property Let set_TPC_POST_TRIGGER_COUNT(aData)
        write_TPC_POST_TRIGGER_COUNT_value = aData
        flag_TPC_POST_TRIGGER_COUNT        = &H1
    End Property

    Property Get read_TPC_POST_TRIGGER_COUNT
        read
        read_TPC_POST_TRIGGER_COUNT = read_TPC_POST_TRIGGER_COUNT_value
    End Property

    Property Let write_TPC_POST_TRIGGER_COUNT(aData)
        set_TPC_POST_TRIGGER_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_POST_TRIGGER_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_POST_TRIGGER_COUNT_mask = mask then
                read_TPC_POST_TRIGGER_COUNT_value = data_low
            else
                read_TPC_POST_TRIGGER_COUNT_value = (data_low - H8000_0000) and TPC_POST_TRIGGER_COUNT_mask
            end If
        else
            read_TPC_POST_TRIGGER_COUNT_value = data_low and TPC_POST_TRIGGER_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_TPC_POST_TRIGGER_COUNT = &H0 Then read
        If flag_TPC_POST_TRIGGER_COUNT = &H0 Then write_TPC_POST_TRIGGER_COUNT_value = get_TPC_POST_TRIGGER_COUNT

        regValue = leftShift((write_TPC_POST_TRIGGER_COUNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_POST_TRIGGER_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_POST_TRIGGER_COUNT_mask = mask then
                read_TPC_POST_TRIGGER_COUNT_value = data_low
            else
                read_TPC_POST_TRIGGER_COUNT_value = (data_low - H8000_0000) and TPC_POST_TRIGGER_COUNT_mask
            end If
        else
            read_TPC_POST_TRIGGER_COUNT_value = data_low and TPC_POST_TRIGGER_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_POST_TRIGGER_COUNT_value = &H0
        flag_TPC_POST_TRIGGER_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_trigger_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT     [15:15]          get_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
''                                                             set_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
''                                                             read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
''                                                             write_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
''---------------------------------------------------------------------------------
'' TPC_MAIN_CLOCK_SELECT                      [14:13]          get_TPC_MAIN_CLOCK_SELECT
''                                                             set_TPC_MAIN_CLOCK_SELECT
''                                                             read_TPC_MAIN_CLOCK_SELECT
''                                                             write_TPC_MAIN_CLOCK_SELECT
''---------------------------------------------------------------------------------
'' TPC_MAIN_CLOCK_INVERT                      [12:12]          get_TPC_MAIN_CLOCK_INVERT
''                                                             set_TPC_MAIN_CLOCK_INVERT
''                                                             read_TPC_MAIN_CLOCK_INVERT
''                                                             write_TPC_MAIN_CLOCK_INVERT
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_LATCH                          [11:11]          get_TPC_TRIGGER_LATCH
''                                                             set_TPC_TRIGGER_LATCH
''                                                             read_TPC_TRIGGER_LATCH
''                                                             write_TPC_TRIGGER_LATCH
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_EVENT_ENABLE_FROM_DSP          [10:10]          get_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
''                                                             set_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
''                                                             read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
''                                                             write_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS      [9:9]            get_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
''                                                             set_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
''                                                             read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
''                                                             write_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_SELECTION                      [8:0]            get_TPC_TRIGGER_SELECTION
''                                                             set_TPC_TRIGGER_SELECTION
''                                                             read_TPC_TRIGGER_SELECTION
''                                                             write_TPC_TRIGGER_SELECTION
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_trigger_select
    Private write_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value
    Private read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value
    Private flag_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
    Private write_TPC_MAIN_CLOCK_SELECT_value
    Private read_TPC_MAIN_CLOCK_SELECT_value
    Private flag_TPC_MAIN_CLOCK_SELECT
    Private write_TPC_MAIN_CLOCK_INVERT_value
    Private read_TPC_MAIN_CLOCK_INVERT_value
    Private flag_TPC_MAIN_CLOCK_INVERT
    Private write_TPC_TRIGGER_LATCH_value
    Private read_TPC_TRIGGER_LATCH_value
    Private flag_TPC_TRIGGER_LATCH
    Private write_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value
    Private read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value
    Private flag_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
    Private write_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value
    Private read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value
    Private flag_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
    Private write_TPC_TRIGGER_SELECTION_value
    Private read_TPC_TRIGGER_SELECTION_value
    Private flag_TPC_TRIGGER_SELECTION

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

    Property Get get_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
        get_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT = read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value
    End Property

    Property Let set_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT(aData)
        write_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value = aData
        flag_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT        = &H1
    End Property

    Property Get read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
        read
        read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT = read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value
    End Property

    Property Let write_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT(aData)
        set_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT = aData
        write
    End Property

    Property Get get_TPC_MAIN_CLOCK_SELECT
        get_TPC_MAIN_CLOCK_SELECT = read_TPC_MAIN_CLOCK_SELECT_value
    End Property

    Property Let set_TPC_MAIN_CLOCK_SELECT(aData)
        write_TPC_MAIN_CLOCK_SELECT_value = aData
        flag_TPC_MAIN_CLOCK_SELECT        = &H1
    End Property

    Property Get read_TPC_MAIN_CLOCK_SELECT
        read
        read_TPC_MAIN_CLOCK_SELECT = read_TPC_MAIN_CLOCK_SELECT_value
    End Property

    Property Let write_TPC_MAIN_CLOCK_SELECT(aData)
        set_TPC_MAIN_CLOCK_SELECT = aData
        write
    End Property

    Property Get get_TPC_MAIN_CLOCK_INVERT
        get_TPC_MAIN_CLOCK_INVERT = read_TPC_MAIN_CLOCK_INVERT_value
    End Property

    Property Let set_TPC_MAIN_CLOCK_INVERT(aData)
        write_TPC_MAIN_CLOCK_INVERT_value = aData
        flag_TPC_MAIN_CLOCK_INVERT        = &H1
    End Property

    Property Get read_TPC_MAIN_CLOCK_INVERT
        read
        read_TPC_MAIN_CLOCK_INVERT = read_TPC_MAIN_CLOCK_INVERT_value
    End Property

    Property Let write_TPC_MAIN_CLOCK_INVERT(aData)
        set_TPC_MAIN_CLOCK_INVERT = aData
        write
    End Property

    Property Get get_TPC_TRIGGER_LATCH
        get_TPC_TRIGGER_LATCH = read_TPC_TRIGGER_LATCH_value
    End Property

    Property Let set_TPC_TRIGGER_LATCH(aData)
        write_TPC_TRIGGER_LATCH_value = aData
        flag_TPC_TRIGGER_LATCH        = &H1
    End Property

    Property Get read_TPC_TRIGGER_LATCH
        read
        read_TPC_TRIGGER_LATCH = read_TPC_TRIGGER_LATCH_value
    End Property

    Property Let write_TPC_TRIGGER_LATCH(aData)
        set_TPC_TRIGGER_LATCH = aData
        write
    End Property

    Property Get get_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
        get_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP = read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value
    End Property

    Property Let set_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP(aData)
        write_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value = aData
        flag_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP        = &H1
    End Property

    Property Get read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
        read
        read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP = read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value
    End Property

    Property Let write_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP(aData)
        set_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP = aData
        write
    End Property

    Property Get get_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
        get_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS = read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let set_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS(aData)
        write_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value = aData
        flag_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS        = &H1
    End Property

    Property Get read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
        read
        read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS = read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let write_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS(aData)
        set_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS = aData
        write
    End Property

    Property Get get_TPC_TRIGGER_SELECTION
        get_TPC_TRIGGER_SELECTION = read_TPC_TRIGGER_SELECTION_value
    End Property

    Property Let set_TPC_TRIGGER_SELECTION(aData)
        write_TPC_TRIGGER_SELECTION_value = aData
        flag_TPC_TRIGGER_SELECTION        = &H1
    End Property

    Property Get read_TPC_TRIGGER_SELECTION
        read
        read_TPC_TRIGGER_SELECTION = read_TPC_TRIGGER_SELECTION_value
    End Property

    Property Let write_TPC_TRIGGER_SELECTION(aData)
        set_TPC_TRIGGER_SELECTION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value = rightShift(data_low, 15) and &H1
        read_TPC_MAIN_CLOCK_SELECT_value = rightShift(data_low, 13) and &H3
        read_TPC_MAIN_CLOCK_INVERT_value = rightShift(data_low, 12) and &H1
        read_TPC_TRIGGER_LATCH_value = rightShift(data_low, 11) and &H1
        read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value = rightShift(data_low, 10) and &H1
        read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 9) and &H1
        TPC_TRIGGER_SELECTION_mask = &H1ff
        if data_low > LONG_MAX then
            if TPC_TRIGGER_SELECTION_mask = mask then
                read_TPC_TRIGGER_SELECTION_value = data_low
            else
                read_TPC_TRIGGER_SELECTION_value = (data_low - H8000_0000) and TPC_TRIGGER_SELECTION_mask
            end If
        else
            read_TPC_TRIGGER_SELECTION_value = data_low and TPC_TRIGGER_SELECTION_mask
        end If

    End Sub

    Sub write
        If flag_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT = &H0 or flag_TPC_MAIN_CLOCK_SELECT = &H0 or flag_TPC_MAIN_CLOCK_INVERT = &H0 or flag_TPC_TRIGGER_LATCH = &H0 or flag_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP = &H0 or flag_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS = &H0 or flag_TPC_TRIGGER_SELECTION = &H0 Then read
        If flag_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT = &H0 Then write_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value = get_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT
        If flag_TPC_MAIN_CLOCK_SELECT = &H0 Then write_TPC_MAIN_CLOCK_SELECT_value = get_TPC_MAIN_CLOCK_SELECT
        If flag_TPC_MAIN_CLOCK_INVERT = &H0 Then write_TPC_MAIN_CLOCK_INVERT_value = get_TPC_MAIN_CLOCK_INVERT
        If flag_TPC_TRIGGER_LATCH = &H0 Then write_TPC_TRIGGER_LATCH_value = get_TPC_TRIGGER_LATCH
        If flag_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP = &H0 Then write_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value = get_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP
        If flag_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS = &H0 Then write_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value = get_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS
        If flag_TPC_TRIGGER_SELECTION = &H0 Then write_TPC_TRIGGER_SELECTION_value = get_TPC_TRIGGER_SELECTION

        regValue = leftShift((write_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value and &H1), 15) + leftShift((write_TPC_MAIN_CLOCK_SELECT_value and &H3), 13) + leftShift((write_TPC_MAIN_CLOCK_INVERT_value and &H1), 12) + leftShift((write_TPC_TRIGGER_LATCH_value and &H1), 11) + leftShift((write_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value and &H1), 10) + leftShift((write_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value and &H1), 9) + leftShift((write_TPC_TRIGGER_SELECTION_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value = rightShift(data_low, 15) and &H1
        read_TPC_MAIN_CLOCK_SELECT_value = rightShift(data_low, 13) and &H3
        read_TPC_MAIN_CLOCK_INVERT_value = rightShift(data_low, 12) and &H1
        read_TPC_TRIGGER_LATCH_value = rightShift(data_low, 11) and &H1
        read_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value = rightShift(data_low, 10) and &H1
        read_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 9) and &H1
        TPC_TRIGGER_SELECTION_mask = &H1ff
        if data_low > LONG_MAX then
            if TPC_TRIGGER_SELECTION_mask = mask then
                read_TPC_TRIGGER_SELECTION_value = data_low
            else
                read_TPC_TRIGGER_SELECTION_value = (data_low - H8000_0000) and TPC_TRIGGER_SELECTION_mask
            end If
        else
            read_TPC_TRIGGER_SELECTION_value = data_low and TPC_TRIGGER_SELECTION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT_value = &H0
        flag_TPC_TRIGGER_EVENT_THROUGH_REGISTER_BIT        = &H0
        write_TPC_MAIN_CLOCK_SELECT_value = &H0
        flag_TPC_MAIN_CLOCK_SELECT        = &H0
        write_TPC_MAIN_CLOCK_INVERT_value = &H0
        flag_TPC_MAIN_CLOCK_INVERT        = &H0
        write_TPC_TRIGGER_LATCH_value = &H0
        flag_TPC_TRIGGER_LATCH        = &H0
        write_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP_value = &H0
        flag_TPC_TRIGGER_EVENT_ENABLE_FROM_DSP        = &H0
        write_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS_value = &H0
        flag_TPC_TRIGGER_EVENT_ENABLE_FROM_BR_GPCS        = &H0
        write_TPC_TRIGGER_SELECTION_value = &H0
        flag_TPC_TRIGGER_SELECTION        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc1_data_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC1_CLK_SELECT                            [15:13]          get_TPC1_CLK_SELECT
''                                                             set_TPC1_CLK_SELECT
''                                                             read_TPC1_CLK_SELECT
''                                                             write_TPC1_CLK_SELECT
''---------------------------------------------------------------------------------
'' TPC1_CLK_INVERT                            [12:12]          get_TPC1_CLK_INVERT
''                                                             set_TPC1_CLK_INVERT
''                                                             read_TPC1_CLK_INVERT
''                                                             write_TPC1_CLK_INVERT
''---------------------------------------------------------------------------------
'' TPC1_DATA_SELECT_ENABLE_FROM_DSP           [11:11]          get_TPC1_DATA_SELECT_ENABLE_FROM_DSP
''                                                             set_TPC1_DATA_SELECT_ENABLE_FROM_DSP
''                                                             read_TPC1_DATA_SELECT_ENABLE_FROM_DSP
''                                                             write_TPC1_DATA_SELECT_ENABLE_FROM_DSP
''---------------------------------------------------------------------------------
'' TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS       [10:10]          get_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             set_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             write_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
''---------------------------------------------------------------------------------
'' not_used                                   [9:8]            get_not_used
''                                                             set_not_used
''                                                             read_not_used
''                                                             write_not_used
''---------------------------------------------------------------------------------
'' TPC1_DATA_SELECTION                        [7:0]            get_TPC1_DATA_SELECTION
''                                                             set_TPC1_DATA_SELECTION
''                                                             read_TPC1_DATA_SELECTION
''                                                             write_TPC1_DATA_SELECTION
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc1_data_select
    Private write_TPC1_CLK_SELECT_value
    Private read_TPC1_CLK_SELECT_value
    Private flag_TPC1_CLK_SELECT
    Private write_TPC1_CLK_INVERT_value
    Private read_TPC1_CLK_INVERT_value
    Private flag_TPC1_CLK_INVERT
    Private write_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value
    Private read_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value
    Private flag_TPC1_DATA_SELECT_ENABLE_FROM_DSP
    Private write_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    Private read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    Private flag_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
    Private write_not_used_value
    Private read_not_used_value
    Private flag_not_used
    Private write_TPC1_DATA_SELECTION_value
    Private read_TPC1_DATA_SELECTION_value
    Private flag_TPC1_DATA_SELECTION

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

    Property Get get_TPC1_CLK_SELECT
        get_TPC1_CLK_SELECT = read_TPC1_CLK_SELECT_value
    End Property

    Property Let set_TPC1_CLK_SELECT(aData)
        write_TPC1_CLK_SELECT_value = aData
        flag_TPC1_CLK_SELECT        = &H1
    End Property

    Property Get read_TPC1_CLK_SELECT
        read
        read_TPC1_CLK_SELECT = read_TPC1_CLK_SELECT_value
    End Property

    Property Let write_TPC1_CLK_SELECT(aData)
        set_TPC1_CLK_SELECT = aData
        write
    End Property

    Property Get get_TPC1_CLK_INVERT
        get_TPC1_CLK_INVERT = read_TPC1_CLK_INVERT_value
    End Property

    Property Let set_TPC1_CLK_INVERT(aData)
        write_TPC1_CLK_INVERT_value = aData
        flag_TPC1_CLK_INVERT        = &H1
    End Property

    Property Get read_TPC1_CLK_INVERT
        read
        read_TPC1_CLK_INVERT = read_TPC1_CLK_INVERT_value
    End Property

    Property Let write_TPC1_CLK_INVERT(aData)
        set_TPC1_CLK_INVERT = aData
        write
    End Property

    Property Get get_TPC1_DATA_SELECT_ENABLE_FROM_DSP
        get_TPC1_DATA_SELECT_ENABLE_FROM_DSP = read_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value
    End Property

    Property Let set_TPC1_DATA_SELECT_ENABLE_FROM_DSP(aData)
        write_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value = aData
        flag_TPC1_DATA_SELECT_ENABLE_FROM_DSP        = &H1
    End Property

    Property Get read_TPC1_DATA_SELECT_ENABLE_FROM_DSP
        read
        read_TPC1_DATA_SELECT_ENABLE_FROM_DSP = read_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value
    End Property

    Property Let write_TPC1_DATA_SELECT_ENABLE_FROM_DSP(aData)
        set_TPC1_DATA_SELECT_ENABLE_FROM_DSP = aData
        write
    End Property

    Property Get get_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
        get_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS = read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let set_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS(aData)
        write_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = aData
        flag_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS        = &H1
    End Property

    Property Get read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
        read
        read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS = read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let write_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS(aData)
        set_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS = aData
        write
    End Property

    Property Get get_not_used
        get_not_used = read_not_used_value
    End Property

    Property Let set_not_used(aData)
        write_not_used_value = aData
        flag_not_used        = &H1
    End Property

    Property Get read_not_used
        read
        read_not_used = read_not_used_value
    End Property

    Property Let write_not_used(aData)
        set_not_used = aData
        write
    End Property

    Property Get get_TPC1_DATA_SELECTION
        get_TPC1_DATA_SELECTION = read_TPC1_DATA_SELECTION_value
    End Property

    Property Let set_TPC1_DATA_SELECTION(aData)
        write_TPC1_DATA_SELECTION_value = aData
        flag_TPC1_DATA_SELECTION        = &H1
    End Property

    Property Get read_TPC1_DATA_SELECTION
        read
        read_TPC1_DATA_SELECTION = read_TPC1_DATA_SELECTION_value
    End Property

    Property Let write_TPC1_DATA_SELECTION(aData)
        set_TPC1_DATA_SELECTION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC1_CLK_SELECT_value = rightShift(data_low, 13) and &H7
        read_TPC1_CLK_INVERT_value = rightShift(data_low, 12) and &H1
        read_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value = rightShift(data_low, 11) and &H1
        read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 10) and &H1
        read_not_used_value = rightShift(data_low, 8) and &H3
        TPC1_DATA_SELECTION_mask = &Hff
        if data_low > LONG_MAX then
            if TPC1_DATA_SELECTION_mask = mask then
                read_TPC1_DATA_SELECTION_value = data_low
            else
                read_TPC1_DATA_SELECTION_value = (data_low - H8000_0000) and TPC1_DATA_SELECTION_mask
            end If
        else
            read_TPC1_DATA_SELECTION_value = data_low and TPC1_DATA_SELECTION_mask
        end If

    End Sub

    Sub write
        If flag_TPC1_CLK_SELECT = &H0 or flag_TPC1_CLK_INVERT = &H0 or flag_TPC1_DATA_SELECT_ENABLE_FROM_DSP = &H0 or flag_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS = &H0 or flag_not_used = &H0 or flag_TPC1_DATA_SELECTION = &H0 Then read
        If flag_TPC1_CLK_SELECT = &H0 Then write_TPC1_CLK_SELECT_value = get_TPC1_CLK_SELECT
        If flag_TPC1_CLK_INVERT = &H0 Then write_TPC1_CLK_INVERT_value = get_TPC1_CLK_INVERT
        If flag_TPC1_DATA_SELECT_ENABLE_FROM_DSP = &H0 Then write_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value = get_TPC1_DATA_SELECT_ENABLE_FROM_DSP
        If flag_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS = &H0 Then write_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = get_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS
        If flag_not_used = &H0 Then write_not_used_value = get_not_used
        If flag_TPC1_DATA_SELECTION = &H0 Then write_TPC1_DATA_SELECTION_value = get_TPC1_DATA_SELECTION

        regValue = leftShift((write_TPC1_CLK_SELECT_value and &H7), 13) + leftShift((write_TPC1_CLK_INVERT_value and &H1), 12) + leftShift((write_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value and &H1), 11) + leftShift((write_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value and &H1), 10) + leftShift((write_not_used_value and &H3), 8) + leftShift((write_TPC1_DATA_SELECTION_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC1_CLK_SELECT_value = rightShift(data_low, 13) and &H7
        read_TPC1_CLK_INVERT_value = rightShift(data_low, 12) and &H1
        read_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value = rightShift(data_low, 11) and &H1
        read_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 10) and &H1
        read_not_used_value = rightShift(data_low, 8) and &H3
        TPC1_DATA_SELECTION_mask = &Hff
        if data_low > LONG_MAX then
            if TPC1_DATA_SELECTION_mask = mask then
                read_TPC1_DATA_SELECTION_value = data_low
            else
                read_TPC1_DATA_SELECTION_value = (data_low - H8000_0000) and TPC1_DATA_SELECTION_mask
            end If
        else
            read_TPC1_DATA_SELECTION_value = data_low and TPC1_DATA_SELECTION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC1_CLK_SELECT_value = &H0
        flag_TPC1_CLK_SELECT        = &H0
        write_TPC1_CLK_INVERT_value = &H0
        flag_TPC1_CLK_INVERT        = &H0
        write_TPC1_DATA_SELECT_ENABLE_FROM_DSP_value = &H0
        flag_TPC1_DATA_SELECT_ENABLE_FROM_DSP        = &H0
        write_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = &H0
        flag_TPC1_DATA_SELECT_ENABLE_FROM_BR_GPCS        = &H0
        write_not_used_value = &H0
        flag_not_used        = &H0
        write_TPC1_DATA_SELECTION_value = &H0
        flag_TPC1_DATA_SELECTION        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_data_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_CLK_SELECT                            [15:13]          get_TPC2_CLK_SELECT
''                                                             set_TPC2_CLK_SELECT
''                                                             read_TPC2_CLK_SELECT
''                                                             write_TPC2_CLK_SELECT
''---------------------------------------------------------------------------------
'' TPC2_CLK_INVERT                            [12:12]          get_TPC2_CLK_INVERT
''                                                             set_TPC2_CLK_INVERT
''                                                             read_TPC2_CLK_INVERT
''                                                             write_TPC2_CLK_INVERT
''---------------------------------------------------------------------------------
'' TPC2_DATA_SELECT_ENABLE_FROM_DSP           [11:11]          get_TPC2_DATA_SELECT_ENABLE_FROM_DSP
''                                                             set_TPC2_DATA_SELECT_ENABLE_FROM_DSP
''                                                             read_TPC2_DATA_SELECT_ENABLE_FROM_DSP
''                                                             write_TPC2_DATA_SELECT_ENABLE_FROM_DSP
''---------------------------------------------------------------------------------
'' TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS       [10:10]          get_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             set_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             write_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
''---------------------------------------------------------------------------------
'' not_used                                   [9:8]            get_not_used
''                                                             set_not_used
''                                                             read_not_used
''                                                             write_not_used
''---------------------------------------------------------------------------------
'' TPC2_DATA_SELECTION                        [7:0]            get_TPC2_DATA_SELECTION
''                                                             set_TPC2_DATA_SELECTION
''                                                             read_TPC2_DATA_SELECTION
''                                                             write_TPC2_DATA_SELECTION
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_data_select
    Private write_TPC2_CLK_SELECT_value
    Private read_TPC2_CLK_SELECT_value
    Private flag_TPC2_CLK_SELECT
    Private write_TPC2_CLK_INVERT_value
    Private read_TPC2_CLK_INVERT_value
    Private flag_TPC2_CLK_INVERT
    Private write_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value
    Private read_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value
    Private flag_TPC2_DATA_SELECT_ENABLE_FROM_DSP
    Private write_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    Private read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    Private flag_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
    Private write_not_used_value
    Private read_not_used_value
    Private flag_not_used
    Private write_TPC2_DATA_SELECTION_value
    Private read_TPC2_DATA_SELECTION_value
    Private flag_TPC2_DATA_SELECTION

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

    Property Get get_TPC2_CLK_SELECT
        get_TPC2_CLK_SELECT = read_TPC2_CLK_SELECT_value
    End Property

    Property Let set_TPC2_CLK_SELECT(aData)
        write_TPC2_CLK_SELECT_value = aData
        flag_TPC2_CLK_SELECT        = &H1
    End Property

    Property Get read_TPC2_CLK_SELECT
        read
        read_TPC2_CLK_SELECT = read_TPC2_CLK_SELECT_value
    End Property

    Property Let write_TPC2_CLK_SELECT(aData)
        set_TPC2_CLK_SELECT = aData
        write
    End Property

    Property Get get_TPC2_CLK_INVERT
        get_TPC2_CLK_INVERT = read_TPC2_CLK_INVERT_value
    End Property

    Property Let set_TPC2_CLK_INVERT(aData)
        write_TPC2_CLK_INVERT_value = aData
        flag_TPC2_CLK_INVERT        = &H1
    End Property

    Property Get read_TPC2_CLK_INVERT
        read
        read_TPC2_CLK_INVERT = read_TPC2_CLK_INVERT_value
    End Property

    Property Let write_TPC2_CLK_INVERT(aData)
        set_TPC2_CLK_INVERT = aData
        write
    End Property

    Property Get get_TPC2_DATA_SELECT_ENABLE_FROM_DSP
        get_TPC2_DATA_SELECT_ENABLE_FROM_DSP = read_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value
    End Property

    Property Let set_TPC2_DATA_SELECT_ENABLE_FROM_DSP(aData)
        write_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value = aData
        flag_TPC2_DATA_SELECT_ENABLE_FROM_DSP        = &H1
    End Property

    Property Get read_TPC2_DATA_SELECT_ENABLE_FROM_DSP
        read
        read_TPC2_DATA_SELECT_ENABLE_FROM_DSP = read_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value
    End Property

    Property Let write_TPC2_DATA_SELECT_ENABLE_FROM_DSP(aData)
        set_TPC2_DATA_SELECT_ENABLE_FROM_DSP = aData
        write
    End Property

    Property Get get_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
        get_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS = read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let set_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS(aData)
        write_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = aData
        flag_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS        = &H1
    End Property

    Property Get read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
        read
        read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS = read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let write_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS(aData)
        set_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS = aData
        write
    End Property

    Property Get get_not_used
        get_not_used = read_not_used_value
    End Property

    Property Let set_not_used(aData)
        write_not_used_value = aData
        flag_not_used        = &H1
    End Property

    Property Get read_not_used
        read
        read_not_used = read_not_used_value
    End Property

    Property Let write_not_used(aData)
        set_not_used = aData
        write
    End Property

    Property Get get_TPC2_DATA_SELECTION
        get_TPC2_DATA_SELECTION = read_TPC2_DATA_SELECTION_value
    End Property

    Property Let set_TPC2_DATA_SELECTION(aData)
        write_TPC2_DATA_SELECTION_value = aData
        flag_TPC2_DATA_SELECTION        = &H1
    End Property

    Property Get read_TPC2_DATA_SELECTION
        read
        read_TPC2_DATA_SELECTION = read_TPC2_DATA_SELECTION_value
    End Property

    Property Let write_TPC2_DATA_SELECTION(aData)
        set_TPC2_DATA_SELECTION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_CLK_SELECT_value = rightShift(data_low, 13) and &H7
        read_TPC2_CLK_INVERT_value = rightShift(data_low, 12) and &H1
        read_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value = rightShift(data_low, 11) and &H1
        read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 10) and &H1
        read_not_used_value = rightShift(data_low, 8) and &H3
        TPC2_DATA_SELECTION_mask = &Hff
        if data_low > LONG_MAX then
            if TPC2_DATA_SELECTION_mask = mask then
                read_TPC2_DATA_SELECTION_value = data_low
            else
                read_TPC2_DATA_SELECTION_value = (data_low - H8000_0000) and TPC2_DATA_SELECTION_mask
            end If
        else
            read_TPC2_DATA_SELECTION_value = data_low and TPC2_DATA_SELECTION_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_CLK_SELECT = &H0 or flag_TPC2_CLK_INVERT = &H0 or flag_TPC2_DATA_SELECT_ENABLE_FROM_DSP = &H0 or flag_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS = &H0 or flag_not_used = &H0 or flag_TPC2_DATA_SELECTION = &H0 Then read
        If flag_TPC2_CLK_SELECT = &H0 Then write_TPC2_CLK_SELECT_value = get_TPC2_CLK_SELECT
        If flag_TPC2_CLK_INVERT = &H0 Then write_TPC2_CLK_INVERT_value = get_TPC2_CLK_INVERT
        If flag_TPC2_DATA_SELECT_ENABLE_FROM_DSP = &H0 Then write_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value = get_TPC2_DATA_SELECT_ENABLE_FROM_DSP
        If flag_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS = &H0 Then write_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = get_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS
        If flag_not_used = &H0 Then write_not_used_value = get_not_used
        If flag_TPC2_DATA_SELECTION = &H0 Then write_TPC2_DATA_SELECTION_value = get_TPC2_DATA_SELECTION

        regValue = leftShift((write_TPC2_CLK_SELECT_value and &H7), 13) + leftShift((write_TPC2_CLK_INVERT_value and &H1), 12) + leftShift((write_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value and &H1), 11) + leftShift((write_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value and &H1), 10) + leftShift((write_not_used_value and &H3), 8) + leftShift((write_TPC2_DATA_SELECTION_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_CLK_SELECT_value = rightShift(data_low, 13) and &H7
        read_TPC2_CLK_INVERT_value = rightShift(data_low, 12) and &H1
        read_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value = rightShift(data_low, 11) and &H1
        read_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 10) and &H1
        read_not_used_value = rightShift(data_low, 8) and &H3
        TPC2_DATA_SELECTION_mask = &Hff
        if data_low > LONG_MAX then
            if TPC2_DATA_SELECTION_mask = mask then
                read_TPC2_DATA_SELECTION_value = data_low
            else
                read_TPC2_DATA_SELECTION_value = (data_low - H8000_0000) and TPC2_DATA_SELECTION_mask
            end If
        else
            read_TPC2_DATA_SELECTION_value = data_low and TPC2_DATA_SELECTION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_CLK_SELECT_value = &H0
        flag_TPC2_CLK_SELECT        = &H0
        write_TPC2_CLK_INVERT_value = &H0
        flag_TPC2_CLK_INVERT        = &H0
        write_TPC2_DATA_SELECT_ENABLE_FROM_DSP_value = &H0
        flag_TPC2_DATA_SELECT_ENABLE_FROM_DSP        = &H0
        write_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = &H0
        flag_TPC2_DATA_SELECT_ENABLE_FROM_BR_GPCS        = &H0
        write_not_used_value = &H0
        flag_not_used        = &H0
        write_TPC2_DATA_SELECTION_value = &H0
        flag_TPC2_DATA_SELECTION        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_read_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_READ_ENABLE                        [0:0]            get_TPC_RAM_READ_ENABLE
''                                                             set_TPC_RAM_READ_ENABLE
''                                                             read_TPC_RAM_READ_ENABLE
''                                                             write_TPC_RAM_READ_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_read_enable
    Private write_TPC_RAM_READ_ENABLE_value
    Private read_TPC_RAM_READ_ENABLE_value
    Private flag_TPC_RAM_READ_ENABLE

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

    Property Get get_TPC_RAM_READ_ENABLE
        get_TPC_RAM_READ_ENABLE = read_TPC_RAM_READ_ENABLE_value
    End Property

    Property Let set_TPC_RAM_READ_ENABLE(aData)
        write_TPC_RAM_READ_ENABLE_value = aData
        flag_TPC_RAM_READ_ENABLE        = &H1
    End Property

    Property Get read_TPC_RAM_READ_ENABLE
        read
        read_TPC_RAM_READ_ENABLE = read_TPC_RAM_READ_ENABLE_value
    End Property

    Property Let write_TPC_RAM_READ_ENABLE(aData)
        set_TPC_RAM_READ_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_READ_ENABLE_mask = mask then
                read_TPC_RAM_READ_ENABLE_value = data_low
            else
                read_TPC_RAM_READ_ENABLE_value = (data_low - H8000_0000) and TPC_RAM_READ_ENABLE_mask
            end If
        else
            read_TPC_RAM_READ_ENABLE_value = data_low and TPC_RAM_READ_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_READ_ENABLE = &H0 Then read
        If flag_TPC_RAM_READ_ENABLE = &H0 Then write_TPC_RAM_READ_ENABLE_value = get_TPC_RAM_READ_ENABLE

        regValue = leftShift((write_TPC_RAM_READ_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_READ_ENABLE_mask = mask then
                read_TPC_RAM_READ_ENABLE_value = data_low
            else
                read_TPC_RAM_READ_ENABLE_value = (data_low - H8000_0000) and TPC_RAM_READ_ENABLE_mask
            end If
        else
            read_TPC_RAM_READ_ENABLE_value = data_low and TPC_RAM_READ_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_READ_ENABLE_value = &H0
        flag_TPC_RAM_READ_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_read_burst_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_READ_BURST_ENABLE                      [0:0]            get_TPC_READ_BURST_ENABLE
''                                                             set_TPC_READ_BURST_ENABLE
''                                                             read_TPC_READ_BURST_ENABLE
''                                                             write_TPC_READ_BURST_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_read_burst_enable
    Private write_TPC_READ_BURST_ENABLE_value
    Private read_TPC_READ_BURST_ENABLE_value
    Private flag_TPC_READ_BURST_ENABLE

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

    Property Get get_TPC_READ_BURST_ENABLE
        get_TPC_READ_BURST_ENABLE = read_TPC_READ_BURST_ENABLE_value
    End Property

    Property Let set_TPC_READ_BURST_ENABLE(aData)
        write_TPC_READ_BURST_ENABLE_value = aData
        flag_TPC_READ_BURST_ENABLE        = &H1
    End Property

    Property Get read_TPC_READ_BURST_ENABLE
        read
        read_TPC_READ_BURST_ENABLE = read_TPC_READ_BURST_ENABLE_value
    End Property

    Property Let write_TPC_READ_BURST_ENABLE(aData)
        set_TPC_READ_BURST_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_BURST_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_READ_BURST_ENABLE_mask = mask then
                read_TPC_READ_BURST_ENABLE_value = data_low
            else
                read_TPC_READ_BURST_ENABLE_value = (data_low - H8000_0000) and TPC_READ_BURST_ENABLE_mask
            end If
        else
            read_TPC_READ_BURST_ENABLE_value = data_low and TPC_READ_BURST_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_READ_BURST_ENABLE = &H0 Then read
        If flag_TPC_READ_BURST_ENABLE = &H0 Then write_TPC_READ_BURST_ENABLE_value = get_TPC_READ_BURST_ENABLE

        regValue = leftShift((write_TPC_READ_BURST_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_BURST_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_READ_BURST_ENABLE_mask = mask then
                read_TPC_READ_BURST_ENABLE_value = data_low
            else
                read_TPC_READ_BURST_ENABLE_value = (data_low - H8000_0000) and TPC_READ_BURST_ENABLE_mask
            end If
        else
            read_TPC_READ_BURST_ENABLE_value = data_low and TPC_READ_BURST_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_READ_BURST_ENABLE_value = &H0
        flag_TPC_READ_BURST_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_read_override_mode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_READ_OVERRIDE_MODE                     [0:0]            get_TPC_READ_OVERRIDE_MODE
''                                                             set_TPC_READ_OVERRIDE_MODE
''                                                             read_TPC_READ_OVERRIDE_MODE
''                                                             write_TPC_READ_OVERRIDE_MODE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_read_override_mode
    Private write_TPC_READ_OVERRIDE_MODE_value
    Private read_TPC_READ_OVERRIDE_MODE_value
    Private flag_TPC_READ_OVERRIDE_MODE

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

    Property Get get_TPC_READ_OVERRIDE_MODE
        get_TPC_READ_OVERRIDE_MODE = read_TPC_READ_OVERRIDE_MODE_value
    End Property

    Property Let set_TPC_READ_OVERRIDE_MODE(aData)
        write_TPC_READ_OVERRIDE_MODE_value = aData
        flag_TPC_READ_OVERRIDE_MODE        = &H1
    End Property

    Property Get read_TPC_READ_OVERRIDE_MODE
        read
        read_TPC_READ_OVERRIDE_MODE = read_TPC_READ_OVERRIDE_MODE_value
    End Property

    Property Let write_TPC_READ_OVERRIDE_MODE(aData)
        set_TPC_READ_OVERRIDE_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_OVERRIDE_MODE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_READ_OVERRIDE_MODE_mask = mask then
                read_TPC_READ_OVERRIDE_MODE_value = data_low
            else
                read_TPC_READ_OVERRIDE_MODE_value = (data_low - H8000_0000) and TPC_READ_OVERRIDE_MODE_mask
            end If
        else
            read_TPC_READ_OVERRIDE_MODE_value = data_low and TPC_READ_OVERRIDE_MODE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_READ_OVERRIDE_MODE = &H0 Then read
        If flag_TPC_READ_OVERRIDE_MODE = &H0 Then write_TPC_READ_OVERRIDE_MODE_value = get_TPC_READ_OVERRIDE_MODE

        regValue = leftShift((write_TPC_READ_OVERRIDE_MODE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_OVERRIDE_MODE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_READ_OVERRIDE_MODE_mask = mask then
                read_TPC_READ_OVERRIDE_MODE_value = data_low
            else
                read_TPC_READ_OVERRIDE_MODE_value = (data_low - H8000_0000) and TPC_READ_OVERRIDE_MODE_mask
            end If
        else
            read_TPC_READ_OVERRIDE_MODE_value = data_low and TPC_READ_OVERRIDE_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_READ_OVERRIDE_MODE_value = &H0
        flag_TPC_READ_OVERRIDE_MODE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_read_start_address_override
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_READ_START_ADDRESS_OVERRIDE            [15:0]           get_TPC_READ_START_ADDRESS_OVERRIDE
''                                                             set_TPC_READ_START_ADDRESS_OVERRIDE
''                                                             read_TPC_READ_START_ADDRESS_OVERRIDE
''                                                             write_TPC_READ_START_ADDRESS_OVERRIDE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_read_start_address_override
    Private write_TPC_READ_START_ADDRESS_OVERRIDE_value
    Private read_TPC_READ_START_ADDRESS_OVERRIDE_value
    Private flag_TPC_READ_START_ADDRESS_OVERRIDE

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

    Property Get get_TPC_READ_START_ADDRESS_OVERRIDE
        get_TPC_READ_START_ADDRESS_OVERRIDE = read_TPC_READ_START_ADDRESS_OVERRIDE_value
    End Property

    Property Let set_TPC_READ_START_ADDRESS_OVERRIDE(aData)
        write_TPC_READ_START_ADDRESS_OVERRIDE_value = aData
        flag_TPC_READ_START_ADDRESS_OVERRIDE        = &H1
    End Property

    Property Get read_TPC_READ_START_ADDRESS_OVERRIDE
        read
        read_TPC_READ_START_ADDRESS_OVERRIDE = read_TPC_READ_START_ADDRESS_OVERRIDE_value
    End Property

    Property Let write_TPC_READ_START_ADDRESS_OVERRIDE(aData)
        set_TPC_READ_START_ADDRESS_OVERRIDE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_START_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_READ_START_ADDRESS_OVERRIDE_mask = mask then
                read_TPC_READ_START_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC_READ_START_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC_READ_START_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC_READ_START_ADDRESS_OVERRIDE_value = data_low and TPC_READ_START_ADDRESS_OVERRIDE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_READ_START_ADDRESS_OVERRIDE = &H0 Then read
        If flag_TPC_READ_START_ADDRESS_OVERRIDE = &H0 Then write_TPC_READ_START_ADDRESS_OVERRIDE_value = get_TPC_READ_START_ADDRESS_OVERRIDE

        regValue = leftShift((write_TPC_READ_START_ADDRESS_OVERRIDE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_START_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_READ_START_ADDRESS_OVERRIDE_mask = mask then
                read_TPC_READ_START_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC_READ_START_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC_READ_START_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC_READ_START_ADDRESS_OVERRIDE_value = data_low and TPC_READ_START_ADDRESS_OVERRIDE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_READ_START_ADDRESS_OVERRIDE_value = &H0
        flag_TPC_READ_START_ADDRESS_OVERRIDE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_read_end_address_override
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_READ_END_ADDRESS_OVERRIDE              [15:0]           get_TPC_READ_END_ADDRESS_OVERRIDE
''                                                             set_TPC_READ_END_ADDRESS_OVERRIDE
''                                                             read_TPC_READ_END_ADDRESS_OVERRIDE
''                                                             write_TPC_READ_END_ADDRESS_OVERRIDE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_read_end_address_override
    Private write_TPC_READ_END_ADDRESS_OVERRIDE_value
    Private read_TPC_READ_END_ADDRESS_OVERRIDE_value
    Private flag_TPC_READ_END_ADDRESS_OVERRIDE

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

    Property Get get_TPC_READ_END_ADDRESS_OVERRIDE
        get_TPC_READ_END_ADDRESS_OVERRIDE = read_TPC_READ_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let set_TPC_READ_END_ADDRESS_OVERRIDE(aData)
        write_TPC_READ_END_ADDRESS_OVERRIDE_value = aData
        flag_TPC_READ_END_ADDRESS_OVERRIDE        = &H1
    End Property

    Property Get read_TPC_READ_END_ADDRESS_OVERRIDE
        read
        read_TPC_READ_END_ADDRESS_OVERRIDE = read_TPC_READ_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let write_TPC_READ_END_ADDRESS_OVERRIDE(aData)
        set_TPC_READ_END_ADDRESS_OVERRIDE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_END_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_READ_END_ADDRESS_OVERRIDE_mask = mask then
                read_TPC_READ_END_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC_READ_END_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC_READ_END_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC_READ_END_ADDRESS_OVERRIDE_value = data_low and TPC_READ_END_ADDRESS_OVERRIDE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_READ_END_ADDRESS_OVERRIDE = &H0 Then read
        If flag_TPC_READ_END_ADDRESS_OVERRIDE = &H0 Then write_TPC_READ_END_ADDRESS_OVERRIDE_value = get_TPC_READ_END_ADDRESS_OVERRIDE

        regValue = leftShift((write_TPC_READ_END_ADDRESS_OVERRIDE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_READ_END_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_READ_END_ADDRESS_OVERRIDE_mask = mask then
                read_TPC_READ_END_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC_READ_END_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC_READ_END_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC_READ_END_ADDRESS_OVERRIDE_value = data_low and TPC_READ_END_ADDRESS_OVERRIDE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_READ_END_ADDRESS_OVERRIDE_value = &H0
        flag_TPC_READ_END_ADDRESS_OVERRIDE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_read_start_address_override
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_READ_START_ADDRESS_OVERRIDE           [15:0]           get_TPC2_READ_START_ADDRESS_OVERRIDE
''                                                             set_TPC2_READ_START_ADDRESS_OVERRIDE
''                                                             read_TPC2_READ_START_ADDRESS_OVERRIDE
''                                                             write_TPC2_READ_START_ADDRESS_OVERRIDE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_read_start_address_override
    Private write_TPC2_READ_START_ADDRESS_OVERRIDE_value
    Private read_TPC2_READ_START_ADDRESS_OVERRIDE_value
    Private flag_TPC2_READ_START_ADDRESS_OVERRIDE

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

    Property Get get_TPC2_READ_START_ADDRESS_OVERRIDE
        get_TPC2_READ_START_ADDRESS_OVERRIDE = read_TPC2_READ_START_ADDRESS_OVERRIDE_value
    End Property

    Property Let set_TPC2_READ_START_ADDRESS_OVERRIDE(aData)
        write_TPC2_READ_START_ADDRESS_OVERRIDE_value = aData
        flag_TPC2_READ_START_ADDRESS_OVERRIDE        = &H1
    End Property

    Property Get read_TPC2_READ_START_ADDRESS_OVERRIDE
        read
        read_TPC2_READ_START_ADDRESS_OVERRIDE = read_TPC2_READ_START_ADDRESS_OVERRIDE_value
    End Property

    Property Let write_TPC2_READ_START_ADDRESS_OVERRIDE(aData)
        set_TPC2_READ_START_ADDRESS_OVERRIDE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_READ_START_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_READ_START_ADDRESS_OVERRIDE_mask = mask then
                read_TPC2_READ_START_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC2_READ_START_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC2_READ_START_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC2_READ_START_ADDRESS_OVERRIDE_value = data_low and TPC2_READ_START_ADDRESS_OVERRIDE_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_READ_START_ADDRESS_OVERRIDE = &H0 Then read
        If flag_TPC2_READ_START_ADDRESS_OVERRIDE = &H0 Then write_TPC2_READ_START_ADDRESS_OVERRIDE_value = get_TPC2_READ_START_ADDRESS_OVERRIDE

        regValue = leftShift((write_TPC2_READ_START_ADDRESS_OVERRIDE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_READ_START_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_READ_START_ADDRESS_OVERRIDE_mask = mask then
                read_TPC2_READ_START_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC2_READ_START_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC2_READ_START_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC2_READ_START_ADDRESS_OVERRIDE_value = data_low and TPC2_READ_START_ADDRESS_OVERRIDE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_READ_START_ADDRESS_OVERRIDE_value = &H0
        flag_TPC2_READ_START_ADDRESS_OVERRIDE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_read_end_address_override
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_READ_END_ADDRESS_OVERRIDE             [15:0]           get_TPC2_READ_END_ADDRESS_OVERRIDE
''                                                             set_TPC2_READ_END_ADDRESS_OVERRIDE
''                                                             read_TPC2_READ_END_ADDRESS_OVERRIDE
''                                                             write_TPC2_READ_END_ADDRESS_OVERRIDE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_read_end_address_override
    Private write_TPC2_READ_END_ADDRESS_OVERRIDE_value
    Private read_TPC2_READ_END_ADDRESS_OVERRIDE_value
    Private flag_TPC2_READ_END_ADDRESS_OVERRIDE

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

    Property Get get_TPC2_READ_END_ADDRESS_OVERRIDE
        get_TPC2_READ_END_ADDRESS_OVERRIDE = read_TPC2_READ_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let set_TPC2_READ_END_ADDRESS_OVERRIDE(aData)
        write_TPC2_READ_END_ADDRESS_OVERRIDE_value = aData
        flag_TPC2_READ_END_ADDRESS_OVERRIDE        = &H1
    End Property

    Property Get read_TPC2_READ_END_ADDRESS_OVERRIDE
        read
        read_TPC2_READ_END_ADDRESS_OVERRIDE = read_TPC2_READ_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let write_TPC2_READ_END_ADDRESS_OVERRIDE(aData)
        set_TPC2_READ_END_ADDRESS_OVERRIDE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_READ_END_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_READ_END_ADDRESS_OVERRIDE_mask = mask then
                read_TPC2_READ_END_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC2_READ_END_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC2_READ_END_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC2_READ_END_ADDRESS_OVERRIDE_value = data_low and TPC2_READ_END_ADDRESS_OVERRIDE_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_READ_END_ADDRESS_OVERRIDE = &H0 Then read
        If flag_TPC2_READ_END_ADDRESS_OVERRIDE = &H0 Then write_TPC2_READ_END_ADDRESS_OVERRIDE_value = get_TPC2_READ_END_ADDRESS_OVERRIDE

        regValue = leftShift((write_TPC2_READ_END_ADDRESS_OVERRIDE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_READ_END_ADDRESS_OVERRIDE_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_READ_END_ADDRESS_OVERRIDE_mask = mask then
                read_TPC2_READ_END_ADDRESS_OVERRIDE_value = data_low
            else
                read_TPC2_READ_END_ADDRESS_OVERRIDE_value = (data_low - H8000_0000) and TPC2_READ_END_ADDRESS_OVERRIDE_mask
            end If
        else
            read_TPC2_READ_END_ADDRESS_OVERRIDE_value = data_low and TPC2_READ_END_ADDRESS_OVERRIDE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_READ_END_ADDRESS_OVERRIDE_value = &H0
        flag_TPC2_READ_END_ADDRESS_OVERRIDE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_write_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_TM                                 [15:9]           get_TPC_RAM_TM
''                                                             set_TPC_RAM_TM
''                                                             read_TPC_RAM_TM
''                                                             write_TPC_RAM_TM
''---------------------------------------------------------------------------------
'' TPC_RAM_POWEROKIN                          [8:8]            get_TPC_RAM_POWEROKIN
''                                                             set_TPC_RAM_POWEROKIN
''                                                             read_TPC_RAM_POWEROKIN
''                                                             write_TPC_RAM_POWEROKIN
''---------------------------------------------------------------------------------
'' TPC_RAM_POWERONIN                          [7:7]            get_TPC_RAM_POWERONIN
''                                                             set_TPC_RAM_POWERONIN
''                                                             read_TPC_RAM_POWERONIN
''                                                             write_TPC_RAM_POWERONIN
''---------------------------------------------------------------------------------
'' TPC_RAM_ISO                                [6:6]            get_TPC_RAM_ISO
''                                                             set_TPC_RAM_ISO
''                                                             read_TPC_RAM_ISO
''                                                             write_TPC_RAM_ISO
''---------------------------------------------------------------------------------
'' TPC_RAM_PDA                                [5:5]            get_TPC_RAM_PDA
''                                                             set_TPC_RAM_PDA
''                                                             read_TPC_RAM_PDA
''                                                             write_TPC_RAM_PDA
''---------------------------------------------------------------------------------
'' TPC_RAM_OVSTB                              [4:4]            get_TPC_RAM_OVSTB
''                                                             set_TPC_RAM_OVSTB
''                                                             read_TPC_RAM_OVSTB
''                                                             write_TPC_RAM_OVSTB
''---------------------------------------------------------------------------------
'' TPC_RAM_WRITE_MODE                         [1:1]            get_TPC_RAM_WRITE_MODE
''                                                             set_TPC_RAM_WRITE_MODE
''                                                             read_TPC_RAM_WRITE_MODE
''                                                             write_TPC_RAM_WRITE_MODE
''---------------------------------------------------------------------------------
'' TPC_RAM_WRITE_ENABLE                       [0:0]            get_TPC_RAM_WRITE_ENABLE
''                                                             set_TPC_RAM_WRITE_ENABLE
''                                                             read_TPC_RAM_WRITE_ENABLE
''                                                             write_TPC_RAM_WRITE_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_write_control
    Private write_TPC_RAM_TM_value
    Private read_TPC_RAM_TM_value
    Private flag_TPC_RAM_TM
    Private write_TPC_RAM_POWEROKIN_value
    Private read_TPC_RAM_POWEROKIN_value
    Private flag_TPC_RAM_POWEROKIN
    Private write_TPC_RAM_POWERONIN_value
    Private read_TPC_RAM_POWERONIN_value
    Private flag_TPC_RAM_POWERONIN
    Private write_TPC_RAM_ISO_value
    Private read_TPC_RAM_ISO_value
    Private flag_TPC_RAM_ISO
    Private write_TPC_RAM_PDA_value
    Private read_TPC_RAM_PDA_value
    Private flag_TPC_RAM_PDA
    Private write_TPC_RAM_OVSTB_value
    Private read_TPC_RAM_OVSTB_value
    Private flag_TPC_RAM_OVSTB
    Private write_TPC_RAM_WRITE_MODE_value
    Private read_TPC_RAM_WRITE_MODE_value
    Private flag_TPC_RAM_WRITE_MODE
    Private write_TPC_RAM_WRITE_ENABLE_value
    Private read_TPC_RAM_WRITE_ENABLE_value
    Private flag_TPC_RAM_WRITE_ENABLE

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

    Property Get get_TPC_RAM_TM
        get_TPC_RAM_TM = read_TPC_RAM_TM_value
    End Property

    Property Let set_TPC_RAM_TM(aData)
        write_TPC_RAM_TM_value = aData
        flag_TPC_RAM_TM        = &H1
    End Property

    Property Get read_TPC_RAM_TM
        read
        read_TPC_RAM_TM = read_TPC_RAM_TM_value
    End Property

    Property Let write_TPC_RAM_TM(aData)
        set_TPC_RAM_TM = aData
        write
    End Property

    Property Get get_TPC_RAM_POWEROKIN
        get_TPC_RAM_POWEROKIN = read_TPC_RAM_POWEROKIN_value
    End Property

    Property Let set_TPC_RAM_POWEROKIN(aData)
        write_TPC_RAM_POWEROKIN_value = aData
        flag_TPC_RAM_POWEROKIN        = &H1
    End Property

    Property Get read_TPC_RAM_POWEROKIN
        read
        read_TPC_RAM_POWEROKIN = read_TPC_RAM_POWEROKIN_value
    End Property

    Property Let write_TPC_RAM_POWEROKIN(aData)
        set_TPC_RAM_POWEROKIN = aData
        write
    End Property

    Property Get get_TPC_RAM_POWERONIN
        get_TPC_RAM_POWERONIN = read_TPC_RAM_POWERONIN_value
    End Property

    Property Let set_TPC_RAM_POWERONIN(aData)
        write_TPC_RAM_POWERONIN_value = aData
        flag_TPC_RAM_POWERONIN        = &H1
    End Property

    Property Get read_TPC_RAM_POWERONIN
        read
        read_TPC_RAM_POWERONIN = read_TPC_RAM_POWERONIN_value
    End Property

    Property Let write_TPC_RAM_POWERONIN(aData)
        set_TPC_RAM_POWERONIN = aData
        write
    End Property

    Property Get get_TPC_RAM_ISO
        get_TPC_RAM_ISO = read_TPC_RAM_ISO_value
    End Property

    Property Let set_TPC_RAM_ISO(aData)
        write_TPC_RAM_ISO_value = aData
        flag_TPC_RAM_ISO        = &H1
    End Property

    Property Get read_TPC_RAM_ISO
        read
        read_TPC_RAM_ISO = read_TPC_RAM_ISO_value
    End Property

    Property Let write_TPC_RAM_ISO(aData)
        set_TPC_RAM_ISO = aData
        write
    End Property

    Property Get get_TPC_RAM_PDA
        get_TPC_RAM_PDA = read_TPC_RAM_PDA_value
    End Property

    Property Let set_TPC_RAM_PDA(aData)
        write_TPC_RAM_PDA_value = aData
        flag_TPC_RAM_PDA        = &H1
    End Property

    Property Get read_TPC_RAM_PDA
        read
        read_TPC_RAM_PDA = read_TPC_RAM_PDA_value
    End Property

    Property Let write_TPC_RAM_PDA(aData)
        set_TPC_RAM_PDA = aData
        write
    End Property

    Property Get get_TPC_RAM_OVSTB
        get_TPC_RAM_OVSTB = read_TPC_RAM_OVSTB_value
    End Property

    Property Let set_TPC_RAM_OVSTB(aData)
        write_TPC_RAM_OVSTB_value = aData
        flag_TPC_RAM_OVSTB        = &H1
    End Property

    Property Get read_TPC_RAM_OVSTB
        read
        read_TPC_RAM_OVSTB = read_TPC_RAM_OVSTB_value
    End Property

    Property Let write_TPC_RAM_OVSTB(aData)
        set_TPC_RAM_OVSTB = aData
        write
    End Property

    Property Get get_TPC_RAM_WRITE_MODE
        get_TPC_RAM_WRITE_MODE = read_TPC_RAM_WRITE_MODE_value
    End Property

    Property Let set_TPC_RAM_WRITE_MODE(aData)
        write_TPC_RAM_WRITE_MODE_value = aData
        flag_TPC_RAM_WRITE_MODE        = &H1
    End Property

    Property Get read_TPC_RAM_WRITE_MODE
        read
        read_TPC_RAM_WRITE_MODE = read_TPC_RAM_WRITE_MODE_value
    End Property

    Property Let write_TPC_RAM_WRITE_MODE(aData)
        set_TPC_RAM_WRITE_MODE = aData
        write
    End Property

    Property Get get_TPC_RAM_WRITE_ENABLE
        get_TPC_RAM_WRITE_ENABLE = read_TPC_RAM_WRITE_ENABLE_value
    End Property

    Property Let set_TPC_RAM_WRITE_ENABLE(aData)
        write_TPC_RAM_WRITE_ENABLE_value = aData
        flag_TPC_RAM_WRITE_ENABLE        = &H1
    End Property

    Property Get read_TPC_RAM_WRITE_ENABLE
        read
        read_TPC_RAM_WRITE_ENABLE = read_TPC_RAM_WRITE_ENABLE_value
    End Property

    Property Let write_TPC_RAM_WRITE_ENABLE(aData)
        set_TPC_RAM_WRITE_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC_RAM_TM_value = rightShift(data_low, 9) and &H7f
        read_TPC_RAM_POWEROKIN_value = rightShift(data_low, 8) and &H1
        read_TPC_RAM_POWERONIN_value = rightShift(data_low, 7) and &H1
        read_TPC_RAM_ISO_value = rightShift(data_low, 6) and &H1
        read_TPC_RAM_PDA_value = rightShift(data_low, 5) and &H1
        read_TPC_RAM_OVSTB_value = rightShift(data_low, 4) and &H1
        read_TPC_RAM_WRITE_MODE_value = rightShift(data_low, 1) and &H1
        TPC_RAM_WRITE_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_WRITE_ENABLE_mask = mask then
                read_TPC_RAM_WRITE_ENABLE_value = data_low
            else
                read_TPC_RAM_WRITE_ENABLE_value = (data_low - H8000_0000) and TPC_RAM_WRITE_ENABLE_mask
            end If
        else
            read_TPC_RAM_WRITE_ENABLE_value = data_low and TPC_RAM_WRITE_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_TM = &H0 or flag_TPC_RAM_POWEROKIN = &H0 or flag_TPC_RAM_POWERONIN = &H0 or flag_TPC_RAM_ISO = &H0 or flag_TPC_RAM_PDA = &H0 or flag_TPC_RAM_OVSTB = &H0 or flag_TPC_RAM_WRITE_MODE = &H0 or flag_TPC_RAM_WRITE_ENABLE = &H0 Then read
        If flag_TPC_RAM_TM = &H0 Then write_TPC_RAM_TM_value = get_TPC_RAM_TM
        If flag_TPC_RAM_POWEROKIN = &H0 Then write_TPC_RAM_POWEROKIN_value = get_TPC_RAM_POWEROKIN
        If flag_TPC_RAM_POWERONIN = &H0 Then write_TPC_RAM_POWERONIN_value = get_TPC_RAM_POWERONIN
        If flag_TPC_RAM_ISO = &H0 Then write_TPC_RAM_ISO_value = get_TPC_RAM_ISO
        If flag_TPC_RAM_PDA = &H0 Then write_TPC_RAM_PDA_value = get_TPC_RAM_PDA
        If flag_TPC_RAM_OVSTB = &H0 Then write_TPC_RAM_OVSTB_value = get_TPC_RAM_OVSTB
        If flag_TPC_RAM_WRITE_MODE = &H0 Then write_TPC_RAM_WRITE_MODE_value = get_TPC_RAM_WRITE_MODE
        If flag_TPC_RAM_WRITE_ENABLE = &H0 Then write_TPC_RAM_WRITE_ENABLE_value = get_TPC_RAM_WRITE_ENABLE

        regValue = leftShift((write_TPC_RAM_TM_value and &H7f), 9) + leftShift((write_TPC_RAM_POWEROKIN_value and &H1), 8) + leftShift((write_TPC_RAM_POWERONIN_value and &H1), 7) + leftShift((write_TPC_RAM_ISO_value and &H1), 6) + leftShift((write_TPC_RAM_PDA_value and &H1), 5) + leftShift((write_TPC_RAM_OVSTB_value and &H1), 4) + leftShift((write_TPC_RAM_WRITE_MODE_value and &H1), 1) + leftShift((write_TPC_RAM_WRITE_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC_RAM_TM_value = rightShift(data_low, 9) and &H7f
        read_TPC_RAM_POWEROKIN_value = rightShift(data_low, 8) and &H1
        read_TPC_RAM_POWERONIN_value = rightShift(data_low, 7) and &H1
        read_TPC_RAM_ISO_value = rightShift(data_low, 6) and &H1
        read_TPC_RAM_PDA_value = rightShift(data_low, 5) and &H1
        read_TPC_RAM_OVSTB_value = rightShift(data_low, 4) and &H1
        read_TPC_RAM_WRITE_MODE_value = rightShift(data_low, 1) and &H1
        TPC_RAM_WRITE_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_WRITE_ENABLE_mask = mask then
                read_TPC_RAM_WRITE_ENABLE_value = data_low
            else
                read_TPC_RAM_WRITE_ENABLE_value = (data_low - H8000_0000) and TPC_RAM_WRITE_ENABLE_mask
            end If
        else
            read_TPC_RAM_WRITE_ENABLE_value = data_low and TPC_RAM_WRITE_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_TM_value = &H0
        flag_TPC_RAM_TM        = &H0
        write_TPC_RAM_POWEROKIN_value = &H0
        flag_TPC_RAM_POWEROKIN        = &H0
        write_TPC_RAM_POWERONIN_value = &H0
        flag_TPC_RAM_POWERONIN        = &H0
        write_TPC_RAM_ISO_value = &H0
        flag_TPC_RAM_ISO        = &H0
        write_TPC_RAM_PDA_value = &H0
        flag_TPC_RAM_PDA        = &H0
        write_TPC_RAM_OVSTB_value = &H0
        flag_TPC_RAM_OVSTB        = &H0
        write_TPC_RAM_WRITE_MODE_value = &H0
        flag_TPC_RAM_WRITE_MODE        = &H0
        write_TPC_RAM_WRITE_ENABLE_value = &H0
        flag_TPC_RAM_WRITE_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_status_register
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RUN_LOGIC_ANALYZER_FROM_PHYCONTROL         [3:3]            get_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
''                                                             set_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
''                                                             read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
''                                                             write_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
''---------------------------------------------------------------------------------
'' TPC_CAPTURE_DONE                           [2:2]            get_TPC_CAPTURE_DONE
''                                                             set_TPC_CAPTURE_DONE
''                                                             read_TPC_CAPTURE_DONE
''                                                             write_TPC_CAPTURE_DONE
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_EVENT                          [1:1]            get_TPC_TRIGGER_EVENT
''                                                             set_TPC_TRIGGER_EVENT
''                                                             read_TPC_TRIGGER_EVENT
''                                                             write_TPC_TRIGGER_EVENT
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_ACTIVE                         [0:0]            get_TPC_TRIGGER_ACTIVE
''                                                             set_TPC_TRIGGER_ACTIVE
''                                                             read_TPC_TRIGGER_ACTIVE
''                                                             write_TPC_TRIGGER_ACTIVE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_status_register
    Private write_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value
    Private read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value
    Private flag_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
    Private write_TPC_CAPTURE_DONE_value
    Private read_TPC_CAPTURE_DONE_value
    Private flag_TPC_CAPTURE_DONE
    Private write_TPC_TRIGGER_EVENT_value
    Private read_TPC_TRIGGER_EVENT_value
    Private flag_TPC_TRIGGER_EVENT
    Private write_TPC_TRIGGER_ACTIVE_value
    Private read_TPC_TRIGGER_ACTIVE_value
    Private flag_TPC_TRIGGER_ACTIVE

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

    Property Get get_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
        get_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL = read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value
    End Property

    Property Let set_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL(aData)
        write_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value = aData
        flag_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL        = &H1
    End Property

    Property Get read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
        read
        read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL = read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value
    End Property

    Property Let write_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL(aData)
        set_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL = aData
        write
    End Property

    Property Get get_TPC_CAPTURE_DONE
        get_TPC_CAPTURE_DONE = read_TPC_CAPTURE_DONE_value
    End Property

    Property Let set_TPC_CAPTURE_DONE(aData)
        write_TPC_CAPTURE_DONE_value = aData
        flag_TPC_CAPTURE_DONE        = &H1
    End Property

    Property Get read_TPC_CAPTURE_DONE
        read
        read_TPC_CAPTURE_DONE = read_TPC_CAPTURE_DONE_value
    End Property

    Property Let write_TPC_CAPTURE_DONE(aData)
        set_TPC_CAPTURE_DONE = aData
        write
    End Property

    Property Get get_TPC_TRIGGER_EVENT
        get_TPC_TRIGGER_EVENT = read_TPC_TRIGGER_EVENT_value
    End Property

    Property Let set_TPC_TRIGGER_EVENT(aData)
        write_TPC_TRIGGER_EVENT_value = aData
        flag_TPC_TRIGGER_EVENT        = &H1
    End Property

    Property Get read_TPC_TRIGGER_EVENT
        read
        read_TPC_TRIGGER_EVENT = read_TPC_TRIGGER_EVENT_value
    End Property

    Property Let write_TPC_TRIGGER_EVENT(aData)
        set_TPC_TRIGGER_EVENT = aData
        write
    End Property

    Property Get get_TPC_TRIGGER_ACTIVE
        get_TPC_TRIGGER_ACTIVE = read_TPC_TRIGGER_ACTIVE_value
    End Property

    Property Let set_TPC_TRIGGER_ACTIVE(aData)
        write_TPC_TRIGGER_ACTIVE_value = aData
        flag_TPC_TRIGGER_ACTIVE        = &H1
    End Property

    Property Get read_TPC_TRIGGER_ACTIVE
        read
        read_TPC_TRIGGER_ACTIVE = read_TPC_TRIGGER_ACTIVE_value
    End Property

    Property Let write_TPC_TRIGGER_ACTIVE(aData)
        set_TPC_TRIGGER_ACTIVE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value = rightShift(data_low, 3) and &H1
        read_TPC_CAPTURE_DONE_value = rightShift(data_low, 2) and &H1
        read_TPC_TRIGGER_EVENT_value = rightShift(data_low, 1) and &H1
        TPC_TRIGGER_ACTIVE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_TRIGGER_ACTIVE_mask = mask then
                read_TPC_TRIGGER_ACTIVE_value = data_low
            else
                read_TPC_TRIGGER_ACTIVE_value = (data_low - H8000_0000) and TPC_TRIGGER_ACTIVE_mask
            end If
        else
            read_TPC_TRIGGER_ACTIVE_value = data_low and TPC_TRIGGER_ACTIVE_mask
        end If

    End Sub

    Sub write
        If flag_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL = &H0 or flag_TPC_CAPTURE_DONE = &H0 or flag_TPC_TRIGGER_EVENT = &H0 or flag_TPC_TRIGGER_ACTIVE = &H0 Then read
        If flag_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL = &H0 Then write_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value = get_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL
        If flag_TPC_CAPTURE_DONE = &H0 Then write_TPC_CAPTURE_DONE_value = get_TPC_CAPTURE_DONE
        If flag_TPC_TRIGGER_EVENT = &H0 Then write_TPC_TRIGGER_EVENT_value = get_TPC_TRIGGER_EVENT
        If flag_TPC_TRIGGER_ACTIVE = &H0 Then write_TPC_TRIGGER_ACTIVE_value = get_TPC_TRIGGER_ACTIVE

        regValue = leftShift((write_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value and &H1), 3) + leftShift((write_TPC_CAPTURE_DONE_value and &H1), 2) + leftShift((write_TPC_TRIGGER_EVENT_value and &H1), 1) + leftShift((write_TPC_TRIGGER_ACTIVE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value = rightShift(data_low, 3) and &H1
        read_TPC_CAPTURE_DONE_value = rightShift(data_low, 2) and &H1
        read_TPC_TRIGGER_EVENT_value = rightShift(data_low, 1) and &H1
        TPC_TRIGGER_ACTIVE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_TRIGGER_ACTIVE_mask = mask then
                read_TPC_TRIGGER_ACTIVE_value = data_low
            else
                read_TPC_TRIGGER_ACTIVE_value = (data_low - H8000_0000) and TPC_TRIGGER_ACTIVE_mask
            end If
        else
            read_TPC_TRIGGER_ACTIVE_value = data_low and TPC_TRIGGER_ACTIVE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL_value = &H0
        flag_RUN_LOGIC_ANALYZER_FROM_PHYCONTROL        = &H0
        write_TPC_CAPTURE_DONE_value = &H0
        flag_TPC_CAPTURE_DONE        = &H0
        write_TPC_TRIGGER_EVENT_value = &H0
        flag_TPC_TRIGGER_EVENT        = &H0
        write_TPC_TRIGGER_ACTIVE_value = &H0
        flag_TPC_TRIGGER_ACTIVE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_status_register
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_RAM_WRAP_AROUND                       [5:5]            get_TPC2_RAM_WRAP_AROUND
''                                                             set_TPC2_RAM_WRAP_AROUND
''                                                             read_TPC2_RAM_WRAP_AROUND
''                                                             write_TPC2_RAM_WRAP_AROUND
''---------------------------------------------------------------------------------
'' TPC_RAM_WRAP_AROUND                        [4:4]            get_TPC_RAM_WRAP_AROUND
''                                                             set_TPC_RAM_WRAP_AROUND
''                                                             read_TPC_RAM_WRAP_AROUND
''                                                             write_TPC_RAM_WRAP_AROUND
''---------------------------------------------------------------------------------
'' TPC_RAM_WRITE_ACTIVE                       [3:3]            get_TPC_RAM_WRITE_ACTIVE
''                                                             set_TPC_RAM_WRITE_ACTIVE
''                                                             read_TPC_RAM_WRITE_ACTIVE
''                                                             write_TPC_RAM_WRITE_ACTIVE
''---------------------------------------------------------------------------------
'' TPC_RAM_WRITE_DONE                         [2:2]            get_TPC_RAM_WRITE_DONE
''                                                             set_TPC_RAM_WRITE_DONE
''                                                             read_TPC_RAM_WRITE_DONE
''                                                             write_TPC_RAM_WRITE_DONE
''---------------------------------------------------------------------------------
'' TPC_RAM_READ_ACTIVE                        [1:1]            get_TPC_RAM_READ_ACTIVE
''                                                             set_TPC_RAM_READ_ACTIVE
''                                                             read_TPC_RAM_READ_ACTIVE
''                                                             write_TPC_RAM_READ_ACTIVE
''---------------------------------------------------------------------------------
'' TPC_RAM_READ_DONE                          [0:0]            get_TPC_RAM_READ_DONE
''                                                             set_TPC_RAM_READ_DONE
''                                                             read_TPC_RAM_READ_DONE
''                                                             write_TPC_RAM_READ_DONE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_status_register
    Private write_TPC2_RAM_WRAP_AROUND_value
    Private read_TPC2_RAM_WRAP_AROUND_value
    Private flag_TPC2_RAM_WRAP_AROUND
    Private write_TPC_RAM_WRAP_AROUND_value
    Private read_TPC_RAM_WRAP_AROUND_value
    Private flag_TPC_RAM_WRAP_AROUND
    Private write_TPC_RAM_WRITE_ACTIVE_value
    Private read_TPC_RAM_WRITE_ACTIVE_value
    Private flag_TPC_RAM_WRITE_ACTIVE
    Private write_TPC_RAM_WRITE_DONE_value
    Private read_TPC_RAM_WRITE_DONE_value
    Private flag_TPC_RAM_WRITE_DONE
    Private write_TPC_RAM_READ_ACTIVE_value
    Private read_TPC_RAM_READ_ACTIVE_value
    Private flag_TPC_RAM_READ_ACTIVE
    Private write_TPC_RAM_READ_DONE_value
    Private read_TPC_RAM_READ_DONE_value
    Private flag_TPC_RAM_READ_DONE

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

    Property Get get_TPC2_RAM_WRAP_AROUND
        get_TPC2_RAM_WRAP_AROUND = read_TPC2_RAM_WRAP_AROUND_value
    End Property

    Property Let set_TPC2_RAM_WRAP_AROUND(aData)
        write_TPC2_RAM_WRAP_AROUND_value = aData
        flag_TPC2_RAM_WRAP_AROUND        = &H1
    End Property

    Property Get read_TPC2_RAM_WRAP_AROUND
        read
        read_TPC2_RAM_WRAP_AROUND = read_TPC2_RAM_WRAP_AROUND_value
    End Property

    Property Let write_TPC2_RAM_WRAP_AROUND(aData)
        set_TPC2_RAM_WRAP_AROUND = aData
        write
    End Property

    Property Get get_TPC_RAM_WRAP_AROUND
        get_TPC_RAM_WRAP_AROUND = read_TPC_RAM_WRAP_AROUND_value
    End Property

    Property Let set_TPC_RAM_WRAP_AROUND(aData)
        write_TPC_RAM_WRAP_AROUND_value = aData
        flag_TPC_RAM_WRAP_AROUND        = &H1
    End Property

    Property Get read_TPC_RAM_WRAP_AROUND
        read
        read_TPC_RAM_WRAP_AROUND = read_TPC_RAM_WRAP_AROUND_value
    End Property

    Property Let write_TPC_RAM_WRAP_AROUND(aData)
        set_TPC_RAM_WRAP_AROUND = aData
        write
    End Property

    Property Get get_TPC_RAM_WRITE_ACTIVE
        get_TPC_RAM_WRITE_ACTIVE = read_TPC_RAM_WRITE_ACTIVE_value
    End Property

    Property Let set_TPC_RAM_WRITE_ACTIVE(aData)
        write_TPC_RAM_WRITE_ACTIVE_value = aData
        flag_TPC_RAM_WRITE_ACTIVE        = &H1
    End Property

    Property Get read_TPC_RAM_WRITE_ACTIVE
        read
        read_TPC_RAM_WRITE_ACTIVE = read_TPC_RAM_WRITE_ACTIVE_value
    End Property

    Property Let write_TPC_RAM_WRITE_ACTIVE(aData)
        set_TPC_RAM_WRITE_ACTIVE = aData
        write
    End Property

    Property Get get_TPC_RAM_WRITE_DONE
        get_TPC_RAM_WRITE_DONE = read_TPC_RAM_WRITE_DONE_value
    End Property

    Property Let set_TPC_RAM_WRITE_DONE(aData)
        write_TPC_RAM_WRITE_DONE_value = aData
        flag_TPC_RAM_WRITE_DONE        = &H1
    End Property

    Property Get read_TPC_RAM_WRITE_DONE
        read
        read_TPC_RAM_WRITE_DONE = read_TPC_RAM_WRITE_DONE_value
    End Property

    Property Let write_TPC_RAM_WRITE_DONE(aData)
        set_TPC_RAM_WRITE_DONE = aData
        write
    End Property

    Property Get get_TPC_RAM_READ_ACTIVE
        get_TPC_RAM_READ_ACTIVE = read_TPC_RAM_READ_ACTIVE_value
    End Property

    Property Let set_TPC_RAM_READ_ACTIVE(aData)
        write_TPC_RAM_READ_ACTIVE_value = aData
        flag_TPC_RAM_READ_ACTIVE        = &H1
    End Property

    Property Get read_TPC_RAM_READ_ACTIVE
        read
        read_TPC_RAM_READ_ACTIVE = read_TPC_RAM_READ_ACTIVE_value
    End Property

    Property Let write_TPC_RAM_READ_ACTIVE(aData)
        set_TPC_RAM_READ_ACTIVE = aData
        write
    End Property

    Property Get get_TPC_RAM_READ_DONE
        get_TPC_RAM_READ_DONE = read_TPC_RAM_READ_DONE_value
    End Property

    Property Let set_TPC_RAM_READ_DONE(aData)
        write_TPC_RAM_READ_DONE_value = aData
        flag_TPC_RAM_READ_DONE        = &H1
    End Property

    Property Get read_TPC_RAM_READ_DONE
        read
        read_TPC_RAM_READ_DONE = read_TPC_RAM_READ_DONE_value
    End Property

    Property Let write_TPC_RAM_READ_DONE(aData)
        set_TPC_RAM_READ_DONE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_RAM_WRAP_AROUND_value = rightShift(data_low, 5) and &H1
        read_TPC_RAM_WRAP_AROUND_value = rightShift(data_low, 4) and &H1
        read_TPC_RAM_WRITE_ACTIVE_value = rightShift(data_low, 3) and &H1
        read_TPC_RAM_WRITE_DONE_value = rightShift(data_low, 2) and &H1
        read_TPC_RAM_READ_ACTIVE_value = rightShift(data_low, 1) and &H1
        TPC_RAM_READ_DONE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DONE_mask = mask then
                read_TPC_RAM_READ_DONE_value = data_low
            else
                read_TPC_RAM_READ_DONE_value = (data_low - H8000_0000) and TPC_RAM_READ_DONE_mask
            end If
        else
            read_TPC_RAM_READ_DONE_value = data_low and TPC_RAM_READ_DONE_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_RAM_WRAP_AROUND = &H0 or flag_TPC_RAM_WRAP_AROUND = &H0 or flag_TPC_RAM_WRITE_ACTIVE = &H0 or flag_TPC_RAM_WRITE_DONE = &H0 or flag_TPC_RAM_READ_ACTIVE = &H0 or flag_TPC_RAM_READ_DONE = &H0 Then read
        If flag_TPC2_RAM_WRAP_AROUND = &H0 Then write_TPC2_RAM_WRAP_AROUND_value = get_TPC2_RAM_WRAP_AROUND
        If flag_TPC_RAM_WRAP_AROUND = &H0 Then write_TPC_RAM_WRAP_AROUND_value = get_TPC_RAM_WRAP_AROUND
        If flag_TPC_RAM_WRITE_ACTIVE = &H0 Then write_TPC_RAM_WRITE_ACTIVE_value = get_TPC_RAM_WRITE_ACTIVE
        If flag_TPC_RAM_WRITE_DONE = &H0 Then write_TPC_RAM_WRITE_DONE_value = get_TPC_RAM_WRITE_DONE
        If flag_TPC_RAM_READ_ACTIVE = &H0 Then write_TPC_RAM_READ_ACTIVE_value = get_TPC_RAM_READ_ACTIVE
        If flag_TPC_RAM_READ_DONE = &H0 Then write_TPC_RAM_READ_DONE_value = get_TPC_RAM_READ_DONE

        regValue = leftShift((write_TPC2_RAM_WRAP_AROUND_value and &H1), 5) + leftShift((write_TPC_RAM_WRAP_AROUND_value and &H1), 4) + leftShift((write_TPC_RAM_WRITE_ACTIVE_value and &H1), 3) + leftShift((write_TPC_RAM_WRITE_DONE_value and &H1), 2) + leftShift((write_TPC_RAM_READ_ACTIVE_value and &H1), 1) + leftShift((write_TPC_RAM_READ_DONE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_RAM_WRAP_AROUND_value = rightShift(data_low, 5) and &H1
        read_TPC_RAM_WRAP_AROUND_value = rightShift(data_low, 4) and &H1
        read_TPC_RAM_WRITE_ACTIVE_value = rightShift(data_low, 3) and &H1
        read_TPC_RAM_WRITE_DONE_value = rightShift(data_low, 2) and &H1
        read_TPC_RAM_READ_ACTIVE_value = rightShift(data_low, 1) and &H1
        TPC_RAM_READ_DONE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DONE_mask = mask then
                read_TPC_RAM_READ_DONE_value = data_low
            else
                read_TPC_RAM_READ_DONE_value = (data_low - H8000_0000) and TPC_RAM_READ_DONE_mask
            end If
        else
            read_TPC_RAM_READ_DONE_value = data_low and TPC_RAM_READ_DONE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_RAM_WRAP_AROUND_value = &H0
        flag_TPC2_RAM_WRAP_AROUND        = &H0
        write_TPC_RAM_WRAP_AROUND_value = &H0
        flag_TPC_RAM_WRAP_AROUND        = &H0
        write_TPC_RAM_WRITE_ACTIVE_value = &H0
        flag_TPC_RAM_WRITE_ACTIVE        = &H0
        write_TPC_RAM_WRITE_DONE_value = &H0
        flag_TPC_RAM_WRITE_DONE        = &H0
        write_TPC_RAM_READ_ACTIVE_value = &H0
        flag_TPC_RAM_READ_ACTIVE        = &H0
        write_TPC_RAM_READ_DONE_value = &H0
        flag_TPC_RAM_READ_DONE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_trigger_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_ADDRESS                        [15:0]           get_TPC_TRIGGER_ADDRESS
''                                                             set_TPC_TRIGGER_ADDRESS
''                                                             read_TPC_TRIGGER_ADDRESS
''                                                             write_TPC_TRIGGER_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_trigger_address
    Private write_TPC_TRIGGER_ADDRESS_value
    Private read_TPC_TRIGGER_ADDRESS_value
    Private flag_TPC_TRIGGER_ADDRESS

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

    Property Get get_TPC_TRIGGER_ADDRESS
        get_TPC_TRIGGER_ADDRESS = read_TPC_TRIGGER_ADDRESS_value
    End Property

    Property Let set_TPC_TRIGGER_ADDRESS(aData)
        write_TPC_TRIGGER_ADDRESS_value = aData
        flag_TPC_TRIGGER_ADDRESS        = &H1
    End Property

    Property Get read_TPC_TRIGGER_ADDRESS
        read
        read_TPC_TRIGGER_ADDRESS = read_TPC_TRIGGER_ADDRESS_value
    End Property

    Property Let write_TPC_TRIGGER_ADDRESS(aData)
        set_TPC_TRIGGER_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_TRIGGER_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_TRIGGER_ADDRESS_mask = mask then
                read_TPC_TRIGGER_ADDRESS_value = data_low
            else
                read_TPC_TRIGGER_ADDRESS_value = (data_low - H8000_0000) and TPC_TRIGGER_ADDRESS_mask
            end If
        else
            read_TPC_TRIGGER_ADDRESS_value = data_low and TPC_TRIGGER_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_TRIGGER_ADDRESS = &H0 Then read
        If flag_TPC_TRIGGER_ADDRESS = &H0 Then write_TPC_TRIGGER_ADDRESS_value = get_TPC_TRIGGER_ADDRESS

        regValue = leftShift((write_TPC_TRIGGER_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_TRIGGER_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_TRIGGER_ADDRESS_mask = mask then
                read_TPC_TRIGGER_ADDRESS_value = data_low
            else
                read_TPC_TRIGGER_ADDRESS_value = (data_low - H8000_0000) and TPC_TRIGGER_ADDRESS_mask
            end If
        else
            read_TPC_TRIGGER_ADDRESS_value = data_low and TPC_TRIGGER_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_TRIGGER_ADDRESS_value = &H0
        flag_TPC_TRIGGER_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_start_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_START_ADDRESS                          [15:0]           get_TPC_START_ADDRESS
''                                                             set_TPC_START_ADDRESS
''                                                             read_TPC_START_ADDRESS
''                                                             write_TPC_START_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_start_address
    Private write_TPC_START_ADDRESS_value
    Private read_TPC_START_ADDRESS_value
    Private flag_TPC_START_ADDRESS

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

    Property Get get_TPC_START_ADDRESS
        get_TPC_START_ADDRESS = read_TPC_START_ADDRESS_value
    End Property

    Property Let set_TPC_START_ADDRESS(aData)
        write_TPC_START_ADDRESS_value = aData
        flag_TPC_START_ADDRESS        = &H1
    End Property

    Property Get read_TPC_START_ADDRESS
        read
        read_TPC_START_ADDRESS = read_TPC_START_ADDRESS_value
    End Property

    Property Let write_TPC_START_ADDRESS(aData)
        set_TPC_START_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_START_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_START_ADDRESS_mask = mask then
                read_TPC_START_ADDRESS_value = data_low
            else
                read_TPC_START_ADDRESS_value = (data_low - H8000_0000) and TPC_START_ADDRESS_mask
            end If
        else
            read_TPC_START_ADDRESS_value = data_low and TPC_START_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_START_ADDRESS = &H0 Then read
        If flag_TPC_START_ADDRESS = &H0 Then write_TPC_START_ADDRESS_value = get_TPC_START_ADDRESS

        regValue = leftShift((write_TPC_START_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_START_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_START_ADDRESS_mask = mask then
                read_TPC_START_ADDRESS_value = data_low
            else
                read_TPC_START_ADDRESS_value = (data_low - H8000_0000) and TPC_START_ADDRESS_mask
            end If
        else
            read_TPC_START_ADDRESS_value = data_low and TPC_START_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_START_ADDRESS_value = &H0
        flag_TPC_START_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_end_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_END_ADDRESS                            [15:0]           get_TPC_END_ADDRESS
''                                                             set_TPC_END_ADDRESS
''                                                             read_TPC_END_ADDRESS
''                                                             write_TPC_END_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_end_address
    Private write_TPC_END_ADDRESS_value
    Private read_TPC_END_ADDRESS_value
    Private flag_TPC_END_ADDRESS

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

    Property Get get_TPC_END_ADDRESS
        get_TPC_END_ADDRESS = read_TPC_END_ADDRESS_value
    End Property

    Property Let set_TPC_END_ADDRESS(aData)
        write_TPC_END_ADDRESS_value = aData
        flag_TPC_END_ADDRESS        = &H1
    End Property

    Property Get read_TPC_END_ADDRESS
        read
        read_TPC_END_ADDRESS = read_TPC_END_ADDRESS_value
    End Property

    Property Let write_TPC_END_ADDRESS(aData)
        set_TPC_END_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_END_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_END_ADDRESS_mask = mask then
                read_TPC_END_ADDRESS_value = data_low
            else
                read_TPC_END_ADDRESS_value = (data_low - H8000_0000) and TPC_END_ADDRESS_mask
            end If
        else
            read_TPC_END_ADDRESS_value = data_low and TPC_END_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_END_ADDRESS = &H0 Then read
        If flag_TPC_END_ADDRESS = &H0 Then write_TPC_END_ADDRESS_value = get_TPC_END_ADDRESS

        regValue = leftShift((write_TPC_END_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_END_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_END_ADDRESS_mask = mask then
                read_TPC_END_ADDRESS_value = data_low
            else
                read_TPC_END_ADDRESS_value = (data_low - H8000_0000) and TPC_END_ADDRESS_mask
            end If
        else
            read_TPC_END_ADDRESS_value = data_low and TPC_END_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_END_ADDRESS_value = &H0
        flag_TPC_END_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_current_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_CURRENT_ADDRESS                        [15:0]           get_TPC_CURRENT_ADDRESS
''                                                             set_TPC_CURRENT_ADDRESS
''                                                             read_TPC_CURRENT_ADDRESS
''                                                             write_TPC_CURRENT_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_current_address
    Private write_TPC_CURRENT_ADDRESS_value
    Private read_TPC_CURRENT_ADDRESS_value
    Private flag_TPC_CURRENT_ADDRESS

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

    Property Get get_TPC_CURRENT_ADDRESS
        get_TPC_CURRENT_ADDRESS = read_TPC_CURRENT_ADDRESS_value
    End Property

    Property Let set_TPC_CURRENT_ADDRESS(aData)
        write_TPC_CURRENT_ADDRESS_value = aData
        flag_TPC_CURRENT_ADDRESS        = &H1
    End Property

    Property Get read_TPC_CURRENT_ADDRESS
        read
        read_TPC_CURRENT_ADDRESS = read_TPC_CURRENT_ADDRESS_value
    End Property

    Property Let write_TPC_CURRENT_ADDRESS(aData)
        set_TPC_CURRENT_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_CURRENT_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_CURRENT_ADDRESS_mask = mask then
                read_TPC_CURRENT_ADDRESS_value = data_low
            else
                read_TPC_CURRENT_ADDRESS_value = (data_low - H8000_0000) and TPC_CURRENT_ADDRESS_mask
            end If
        else
            read_TPC_CURRENT_ADDRESS_value = data_low and TPC_CURRENT_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_CURRENT_ADDRESS = &H0 Then read
        If flag_TPC_CURRENT_ADDRESS = &H0 Then write_TPC_CURRENT_ADDRESS_value = get_TPC_CURRENT_ADDRESS

        regValue = leftShift((write_TPC_CURRENT_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_CURRENT_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_CURRENT_ADDRESS_mask = mask then
                read_TPC_CURRENT_ADDRESS_value = data_low
            else
                read_TPC_CURRENT_ADDRESS_value = (data_low - H8000_0000) and TPC_CURRENT_ADDRESS_mask
            end If
        else
            read_TPC_CURRENT_ADDRESS_value = data_low and TPC_CURRENT_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_CURRENT_ADDRESS_value = &H0
        flag_TPC_CURRENT_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_trigger_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_TRIGGER_ADDRESS                       [15:0]           get_TPC2_TRIGGER_ADDRESS
''                                                             set_TPC2_TRIGGER_ADDRESS
''                                                             read_TPC2_TRIGGER_ADDRESS
''                                                             write_TPC2_TRIGGER_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_trigger_address
    Private write_TPC2_TRIGGER_ADDRESS_value
    Private read_TPC2_TRIGGER_ADDRESS_value
    Private flag_TPC2_TRIGGER_ADDRESS

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

    Property Get get_TPC2_TRIGGER_ADDRESS
        get_TPC2_TRIGGER_ADDRESS = read_TPC2_TRIGGER_ADDRESS_value
    End Property

    Property Let set_TPC2_TRIGGER_ADDRESS(aData)
        write_TPC2_TRIGGER_ADDRESS_value = aData
        flag_TPC2_TRIGGER_ADDRESS        = &H1
    End Property

    Property Get read_TPC2_TRIGGER_ADDRESS
        read
        read_TPC2_TRIGGER_ADDRESS = read_TPC2_TRIGGER_ADDRESS_value
    End Property

    Property Let write_TPC2_TRIGGER_ADDRESS(aData)
        set_TPC2_TRIGGER_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_TRIGGER_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_TRIGGER_ADDRESS_mask = mask then
                read_TPC2_TRIGGER_ADDRESS_value = data_low
            else
                read_TPC2_TRIGGER_ADDRESS_value = (data_low - H8000_0000) and TPC2_TRIGGER_ADDRESS_mask
            end If
        else
            read_TPC2_TRIGGER_ADDRESS_value = data_low and TPC2_TRIGGER_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_TRIGGER_ADDRESS = &H0 Then read
        If flag_TPC2_TRIGGER_ADDRESS = &H0 Then write_TPC2_TRIGGER_ADDRESS_value = get_TPC2_TRIGGER_ADDRESS

        regValue = leftShift((write_TPC2_TRIGGER_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_TRIGGER_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_TRIGGER_ADDRESS_mask = mask then
                read_TPC2_TRIGGER_ADDRESS_value = data_low
            else
                read_TPC2_TRIGGER_ADDRESS_value = (data_low - H8000_0000) and TPC2_TRIGGER_ADDRESS_mask
            end If
        else
            read_TPC2_TRIGGER_ADDRESS_value = data_low and TPC2_TRIGGER_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_TRIGGER_ADDRESS_value = &H0
        flag_TPC2_TRIGGER_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_start_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_START_ADDRESS                         [15:0]           get_TPC2_START_ADDRESS
''                                                             set_TPC2_START_ADDRESS
''                                                             read_TPC2_START_ADDRESS
''                                                             write_TPC2_START_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_start_address
    Private write_TPC2_START_ADDRESS_value
    Private read_TPC2_START_ADDRESS_value
    Private flag_TPC2_START_ADDRESS

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

    Property Get get_TPC2_START_ADDRESS
        get_TPC2_START_ADDRESS = read_TPC2_START_ADDRESS_value
    End Property

    Property Let set_TPC2_START_ADDRESS(aData)
        write_TPC2_START_ADDRESS_value = aData
        flag_TPC2_START_ADDRESS        = &H1
    End Property

    Property Get read_TPC2_START_ADDRESS
        read
        read_TPC2_START_ADDRESS = read_TPC2_START_ADDRESS_value
    End Property

    Property Let write_TPC2_START_ADDRESS(aData)
        set_TPC2_START_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_START_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_START_ADDRESS_mask = mask then
                read_TPC2_START_ADDRESS_value = data_low
            else
                read_TPC2_START_ADDRESS_value = (data_low - H8000_0000) and TPC2_START_ADDRESS_mask
            end If
        else
            read_TPC2_START_ADDRESS_value = data_low and TPC2_START_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_START_ADDRESS = &H0 Then read
        If flag_TPC2_START_ADDRESS = &H0 Then write_TPC2_START_ADDRESS_value = get_TPC2_START_ADDRESS

        regValue = leftShift((write_TPC2_START_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_START_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_START_ADDRESS_mask = mask then
                read_TPC2_START_ADDRESS_value = data_low
            else
                read_TPC2_START_ADDRESS_value = (data_low - H8000_0000) and TPC2_START_ADDRESS_mask
            end If
        else
            read_TPC2_START_ADDRESS_value = data_low and TPC2_START_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_START_ADDRESS_value = &H0
        flag_TPC2_START_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_end_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_END_ADDRESS                           [15:0]           get_TPC2_END_ADDRESS
''                                                             set_TPC2_END_ADDRESS
''                                                             read_TPC2_END_ADDRESS
''                                                             write_TPC2_END_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_end_address
    Private write_TPC2_END_ADDRESS_value
    Private read_TPC2_END_ADDRESS_value
    Private flag_TPC2_END_ADDRESS

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

    Property Get get_TPC2_END_ADDRESS
        get_TPC2_END_ADDRESS = read_TPC2_END_ADDRESS_value
    End Property

    Property Let set_TPC2_END_ADDRESS(aData)
        write_TPC2_END_ADDRESS_value = aData
        flag_TPC2_END_ADDRESS        = &H1
    End Property

    Property Get read_TPC2_END_ADDRESS
        read
        read_TPC2_END_ADDRESS = read_TPC2_END_ADDRESS_value
    End Property

    Property Let write_TPC2_END_ADDRESS(aData)
        set_TPC2_END_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_END_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_END_ADDRESS_mask = mask then
                read_TPC2_END_ADDRESS_value = data_low
            else
                read_TPC2_END_ADDRESS_value = (data_low - H8000_0000) and TPC2_END_ADDRESS_mask
            end If
        else
            read_TPC2_END_ADDRESS_value = data_low and TPC2_END_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_END_ADDRESS = &H0 Then read
        If flag_TPC2_END_ADDRESS = &H0 Then write_TPC2_END_ADDRESS_value = get_TPC2_END_ADDRESS

        regValue = leftShift((write_TPC2_END_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_END_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_END_ADDRESS_mask = mask then
                read_TPC2_END_ADDRESS_value = data_low
            else
                read_TPC2_END_ADDRESS_value = (data_low - H8000_0000) and TPC2_END_ADDRESS_mask
            end If
        else
            read_TPC2_END_ADDRESS_value = data_low and TPC2_END_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_END_ADDRESS_value = &H0
        flag_TPC2_END_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_current_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_CURRENT_ADDRESS                       [15:0]           get_TPC2_CURRENT_ADDRESS
''                                                             set_TPC2_CURRENT_ADDRESS
''                                                             read_TPC2_CURRENT_ADDRESS
''                                                             write_TPC2_CURRENT_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_current_address
    Private write_TPC2_CURRENT_ADDRESS_value
    Private read_TPC2_CURRENT_ADDRESS_value
    Private flag_TPC2_CURRENT_ADDRESS

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

    Property Get get_TPC2_CURRENT_ADDRESS
        get_TPC2_CURRENT_ADDRESS = read_TPC2_CURRENT_ADDRESS_value
    End Property

    Property Let set_TPC2_CURRENT_ADDRESS(aData)
        write_TPC2_CURRENT_ADDRESS_value = aData
        flag_TPC2_CURRENT_ADDRESS        = &H1
    End Property

    Property Get read_TPC2_CURRENT_ADDRESS
        read
        read_TPC2_CURRENT_ADDRESS = read_TPC2_CURRENT_ADDRESS_value
    End Property

    Property Let write_TPC2_CURRENT_ADDRESS(aData)
        set_TPC2_CURRENT_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_CURRENT_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_CURRENT_ADDRESS_mask = mask then
                read_TPC2_CURRENT_ADDRESS_value = data_low
            else
                read_TPC2_CURRENT_ADDRESS_value = (data_low - H8000_0000) and TPC2_CURRENT_ADDRESS_mask
            end If
        else
            read_TPC2_CURRENT_ADDRESS_value = data_low and TPC2_CURRENT_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_CURRENT_ADDRESS = &H0 Then read
        If flag_TPC2_CURRENT_ADDRESS = &H0 Then write_TPC2_CURRENT_ADDRESS_value = get_TPC2_CURRENT_ADDRESS

        regValue = leftShift((write_TPC2_CURRENT_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_CURRENT_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_CURRENT_ADDRESS_mask = mask then
                read_TPC2_CURRENT_ADDRESS_value = data_low
            else
                read_TPC2_CURRENT_ADDRESS_value = (data_low - H8000_0000) and TPC2_CURRENT_ADDRESS_mask
            end If
        else
            read_TPC2_CURRENT_ADDRESS_value = data_low and TPC2_CURRENT_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_CURRENT_ADDRESS_value = &H0
        flag_TPC2_CURRENT_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_control_fsm_lsbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_CONTROL_FSM_LSBS                   [15:0]           get_TPC_RAM_CONTROL_FSM_LSBS
''                                                             set_TPC_RAM_CONTROL_FSM_LSBS
''                                                             read_TPC_RAM_CONTROL_FSM_LSBS
''                                                             write_TPC_RAM_CONTROL_FSM_LSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_control_fsm_lsbs
    Private write_TPC_RAM_CONTROL_FSM_LSBS_value
    Private read_TPC_RAM_CONTROL_FSM_LSBS_value
    Private flag_TPC_RAM_CONTROL_FSM_LSBS

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

    Property Get get_TPC_RAM_CONTROL_FSM_LSBS
        get_TPC_RAM_CONTROL_FSM_LSBS = read_TPC_RAM_CONTROL_FSM_LSBS_value
    End Property

    Property Let set_TPC_RAM_CONTROL_FSM_LSBS(aData)
        write_TPC_RAM_CONTROL_FSM_LSBS_value = aData
        flag_TPC_RAM_CONTROL_FSM_LSBS        = &H1
    End Property

    Property Get read_TPC_RAM_CONTROL_FSM_LSBS
        read
        read_TPC_RAM_CONTROL_FSM_LSBS = read_TPC_RAM_CONTROL_FSM_LSBS_value
    End Property

    Property Let write_TPC_RAM_CONTROL_FSM_LSBS(aData)
        set_TPC_RAM_CONTROL_FSM_LSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_CONTROL_FSM_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_CONTROL_FSM_LSBS_mask = mask then
                read_TPC_RAM_CONTROL_FSM_LSBS_value = data_low
            else
                read_TPC_RAM_CONTROL_FSM_LSBS_value = (data_low - H8000_0000) and TPC_RAM_CONTROL_FSM_LSBS_mask
            end If
        else
            read_TPC_RAM_CONTROL_FSM_LSBS_value = data_low and TPC_RAM_CONTROL_FSM_LSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_CONTROL_FSM_LSBS = &H0 Then read
        If flag_TPC_RAM_CONTROL_FSM_LSBS = &H0 Then write_TPC_RAM_CONTROL_FSM_LSBS_value = get_TPC_RAM_CONTROL_FSM_LSBS

        regValue = leftShift((write_TPC_RAM_CONTROL_FSM_LSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_CONTROL_FSM_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_CONTROL_FSM_LSBS_mask = mask then
                read_TPC_RAM_CONTROL_FSM_LSBS_value = data_low
            else
                read_TPC_RAM_CONTROL_FSM_LSBS_value = (data_low - H8000_0000) and TPC_RAM_CONTROL_FSM_LSBS_mask
            end If
        else
            read_TPC_RAM_CONTROL_FSM_LSBS_value = data_low and TPC_RAM_CONTROL_FSM_LSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_CONTROL_FSM_LSBS_value = &H0
        flag_TPC_RAM_CONTROL_FSM_LSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_control_fsm_msbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_CONTROL_FSM_MSBS                   [15:0]           get_TPC_RAM_CONTROL_FSM_MSBS
''                                                             set_TPC_RAM_CONTROL_FSM_MSBS
''                                                             read_TPC_RAM_CONTROL_FSM_MSBS
''                                                             write_TPC_RAM_CONTROL_FSM_MSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_control_fsm_msbs
    Private write_TPC_RAM_CONTROL_FSM_MSBS_value
    Private read_TPC_RAM_CONTROL_FSM_MSBS_value
    Private flag_TPC_RAM_CONTROL_FSM_MSBS

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

    Property Get get_TPC_RAM_CONTROL_FSM_MSBS
        get_TPC_RAM_CONTROL_FSM_MSBS = read_TPC_RAM_CONTROL_FSM_MSBS_value
    End Property

    Property Let set_TPC_RAM_CONTROL_FSM_MSBS(aData)
        write_TPC_RAM_CONTROL_FSM_MSBS_value = aData
        flag_TPC_RAM_CONTROL_FSM_MSBS        = &H1
    End Property

    Property Get read_TPC_RAM_CONTROL_FSM_MSBS
        read
        read_TPC_RAM_CONTROL_FSM_MSBS = read_TPC_RAM_CONTROL_FSM_MSBS_value
    End Property

    Property Let write_TPC_RAM_CONTROL_FSM_MSBS(aData)
        set_TPC_RAM_CONTROL_FSM_MSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_CONTROL_FSM_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_CONTROL_FSM_MSBS_mask = mask then
                read_TPC_RAM_CONTROL_FSM_MSBS_value = data_low
            else
                read_TPC_RAM_CONTROL_FSM_MSBS_value = (data_low - H8000_0000) and TPC_RAM_CONTROL_FSM_MSBS_mask
            end If
        else
            read_TPC_RAM_CONTROL_FSM_MSBS_value = data_low and TPC_RAM_CONTROL_FSM_MSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_CONTROL_FSM_MSBS = &H0 Then read
        If flag_TPC_RAM_CONTROL_FSM_MSBS = &H0 Then write_TPC_RAM_CONTROL_FSM_MSBS_value = get_TPC_RAM_CONTROL_FSM_MSBS

        regValue = leftShift((write_TPC_RAM_CONTROL_FSM_MSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_CONTROL_FSM_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_CONTROL_FSM_MSBS_mask = mask then
                read_TPC_RAM_CONTROL_FSM_MSBS_value = data_low
            else
                read_TPC_RAM_CONTROL_FSM_MSBS_value = (data_low - H8000_0000) and TPC_RAM_CONTROL_FSM_MSBS_mask
            end If
        else
            read_TPC_RAM_CONTROL_FSM_MSBS_value = data_low and TPC_RAM_CONTROL_FSM_MSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_CONTROL_FSM_MSBS_value = &H0
        flag_TPC_RAM_CONTROL_FSM_MSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_ram_control_fsm_lsbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_RAM_CONTROL_FSM_LSBS                  [15:0]           get_TPC2_RAM_CONTROL_FSM_LSBS
''                                                             set_TPC2_RAM_CONTROL_FSM_LSBS
''                                                             read_TPC2_RAM_CONTROL_FSM_LSBS
''                                                             write_TPC2_RAM_CONTROL_FSM_LSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_ram_control_fsm_lsbs
    Private write_TPC2_RAM_CONTROL_FSM_LSBS_value
    Private read_TPC2_RAM_CONTROL_FSM_LSBS_value
    Private flag_TPC2_RAM_CONTROL_FSM_LSBS

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

    Property Get get_TPC2_RAM_CONTROL_FSM_LSBS
        get_TPC2_RAM_CONTROL_FSM_LSBS = read_TPC2_RAM_CONTROL_FSM_LSBS_value
    End Property

    Property Let set_TPC2_RAM_CONTROL_FSM_LSBS(aData)
        write_TPC2_RAM_CONTROL_FSM_LSBS_value = aData
        flag_TPC2_RAM_CONTROL_FSM_LSBS        = &H1
    End Property

    Property Get read_TPC2_RAM_CONTROL_FSM_LSBS
        read
        read_TPC2_RAM_CONTROL_FSM_LSBS = read_TPC2_RAM_CONTROL_FSM_LSBS_value
    End Property

    Property Let write_TPC2_RAM_CONTROL_FSM_LSBS(aData)
        set_TPC2_RAM_CONTROL_FSM_LSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_RAM_CONTROL_FSM_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_RAM_CONTROL_FSM_LSBS_mask = mask then
                read_TPC2_RAM_CONTROL_FSM_LSBS_value = data_low
            else
                read_TPC2_RAM_CONTROL_FSM_LSBS_value = (data_low - H8000_0000) and TPC2_RAM_CONTROL_FSM_LSBS_mask
            end If
        else
            read_TPC2_RAM_CONTROL_FSM_LSBS_value = data_low and TPC2_RAM_CONTROL_FSM_LSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_RAM_CONTROL_FSM_LSBS = &H0 Then read
        If flag_TPC2_RAM_CONTROL_FSM_LSBS = &H0 Then write_TPC2_RAM_CONTROL_FSM_LSBS_value = get_TPC2_RAM_CONTROL_FSM_LSBS

        regValue = leftShift((write_TPC2_RAM_CONTROL_FSM_LSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_RAM_CONTROL_FSM_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_RAM_CONTROL_FSM_LSBS_mask = mask then
                read_TPC2_RAM_CONTROL_FSM_LSBS_value = data_low
            else
                read_TPC2_RAM_CONTROL_FSM_LSBS_value = (data_low - H8000_0000) and TPC2_RAM_CONTROL_FSM_LSBS_mask
            end If
        else
            read_TPC2_RAM_CONTROL_FSM_LSBS_value = data_low and TPC2_RAM_CONTROL_FSM_LSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_RAM_CONTROL_FSM_LSBS_value = &H0
        flag_TPC2_RAM_CONTROL_FSM_LSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_ram_control_fsm_msbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_RAM_CONTROL_FSM_MSBS                  [15:0]           get_TPC2_RAM_CONTROL_FSM_MSBS
''                                                             set_TPC2_RAM_CONTROL_FSM_MSBS
''                                                             read_TPC2_RAM_CONTROL_FSM_MSBS
''                                                             write_TPC2_RAM_CONTROL_FSM_MSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_ram_control_fsm_msbs
    Private write_TPC2_RAM_CONTROL_FSM_MSBS_value
    Private read_TPC2_RAM_CONTROL_FSM_MSBS_value
    Private flag_TPC2_RAM_CONTROL_FSM_MSBS

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

    Property Get get_TPC2_RAM_CONTROL_FSM_MSBS
        get_TPC2_RAM_CONTROL_FSM_MSBS = read_TPC2_RAM_CONTROL_FSM_MSBS_value
    End Property

    Property Let set_TPC2_RAM_CONTROL_FSM_MSBS(aData)
        write_TPC2_RAM_CONTROL_FSM_MSBS_value = aData
        flag_TPC2_RAM_CONTROL_FSM_MSBS        = &H1
    End Property

    Property Get read_TPC2_RAM_CONTROL_FSM_MSBS
        read
        read_TPC2_RAM_CONTROL_FSM_MSBS = read_TPC2_RAM_CONTROL_FSM_MSBS_value
    End Property

    Property Let write_TPC2_RAM_CONTROL_FSM_MSBS(aData)
        set_TPC2_RAM_CONTROL_FSM_MSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_RAM_CONTROL_FSM_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_RAM_CONTROL_FSM_MSBS_mask = mask then
                read_TPC2_RAM_CONTROL_FSM_MSBS_value = data_low
            else
                read_TPC2_RAM_CONTROL_FSM_MSBS_value = (data_low - H8000_0000) and TPC2_RAM_CONTROL_FSM_MSBS_mask
            end If
        else
            read_TPC2_RAM_CONTROL_FSM_MSBS_value = data_low and TPC2_RAM_CONTROL_FSM_MSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_RAM_CONTROL_FSM_MSBS = &H0 Then read
        If flag_TPC2_RAM_CONTROL_FSM_MSBS = &H0 Then write_TPC2_RAM_CONTROL_FSM_MSBS_value = get_TPC2_RAM_CONTROL_FSM_MSBS

        regValue = leftShift((write_TPC2_RAM_CONTROL_FSM_MSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC2_RAM_CONTROL_FSM_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC2_RAM_CONTROL_FSM_MSBS_mask = mask then
                read_TPC2_RAM_CONTROL_FSM_MSBS_value = data_low
            else
                read_TPC2_RAM_CONTROL_FSM_MSBS_value = (data_low - H8000_0000) and TPC2_RAM_CONTROL_FSM_MSBS_mask
            end If
        else
            read_TPC2_RAM_CONTROL_FSM_MSBS_value = data_low and TPC2_RAM_CONTROL_FSM_MSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_RAM_CONTROL_FSM_MSBS_value = &H0
        flag_TPC2_RAM_CONTROL_FSM_MSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_main_fsm_lsbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_MAIN_FSM_LSBS                          [15:0]           get_TPC_MAIN_FSM_LSBS
''                                                             set_TPC_MAIN_FSM_LSBS
''                                                             read_TPC_MAIN_FSM_LSBS
''                                                             write_TPC_MAIN_FSM_LSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_main_fsm_lsbs
    Private write_TPC_MAIN_FSM_LSBS_value
    Private read_TPC_MAIN_FSM_LSBS_value
    Private flag_TPC_MAIN_FSM_LSBS

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

    Property Get get_TPC_MAIN_FSM_LSBS
        get_TPC_MAIN_FSM_LSBS = read_TPC_MAIN_FSM_LSBS_value
    End Property

    Property Let set_TPC_MAIN_FSM_LSBS(aData)
        write_TPC_MAIN_FSM_LSBS_value = aData
        flag_TPC_MAIN_FSM_LSBS        = &H1
    End Property

    Property Get read_TPC_MAIN_FSM_LSBS
        read
        read_TPC_MAIN_FSM_LSBS = read_TPC_MAIN_FSM_LSBS_value
    End Property

    Property Let write_TPC_MAIN_FSM_LSBS(aData)
        set_TPC_MAIN_FSM_LSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_MAIN_FSM_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_MAIN_FSM_LSBS_mask = mask then
                read_TPC_MAIN_FSM_LSBS_value = data_low
            else
                read_TPC_MAIN_FSM_LSBS_value = (data_low - H8000_0000) and TPC_MAIN_FSM_LSBS_mask
            end If
        else
            read_TPC_MAIN_FSM_LSBS_value = data_low and TPC_MAIN_FSM_LSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_MAIN_FSM_LSBS = &H0 Then read
        If flag_TPC_MAIN_FSM_LSBS = &H0 Then write_TPC_MAIN_FSM_LSBS_value = get_TPC_MAIN_FSM_LSBS

        regValue = leftShift((write_TPC_MAIN_FSM_LSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_MAIN_FSM_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_MAIN_FSM_LSBS_mask = mask then
                read_TPC_MAIN_FSM_LSBS_value = data_low
            else
                read_TPC_MAIN_FSM_LSBS_value = (data_low - H8000_0000) and TPC_MAIN_FSM_LSBS_mask
            end If
        else
            read_TPC_MAIN_FSM_LSBS_value = data_low and TPC_MAIN_FSM_LSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_MAIN_FSM_LSBS_value = &H0
        flag_TPC_MAIN_FSM_LSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_main_fsm_msbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_MAIN_FSM_MSBS                          [15:0]           get_TPC_MAIN_FSM_MSBS
''                                                             set_TPC_MAIN_FSM_MSBS
''                                                             read_TPC_MAIN_FSM_MSBS
''                                                             write_TPC_MAIN_FSM_MSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_main_fsm_msbs
    Private write_TPC_MAIN_FSM_MSBS_value
    Private read_TPC_MAIN_FSM_MSBS_value
    Private flag_TPC_MAIN_FSM_MSBS

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

    Property Get get_TPC_MAIN_FSM_MSBS
        get_TPC_MAIN_FSM_MSBS = read_TPC_MAIN_FSM_MSBS_value
    End Property

    Property Let set_TPC_MAIN_FSM_MSBS(aData)
        write_TPC_MAIN_FSM_MSBS_value = aData
        flag_TPC_MAIN_FSM_MSBS        = &H1
    End Property

    Property Get read_TPC_MAIN_FSM_MSBS
        read
        read_TPC_MAIN_FSM_MSBS = read_TPC_MAIN_FSM_MSBS_value
    End Property

    Property Let write_TPC_MAIN_FSM_MSBS(aData)
        set_TPC_MAIN_FSM_MSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_MAIN_FSM_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_MAIN_FSM_MSBS_mask = mask then
                read_TPC_MAIN_FSM_MSBS_value = data_low
            else
                read_TPC_MAIN_FSM_MSBS_value = (data_low - H8000_0000) and TPC_MAIN_FSM_MSBS_mask
            end If
        else
            read_TPC_MAIN_FSM_MSBS_value = data_low and TPC_MAIN_FSM_MSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_MAIN_FSM_MSBS = &H0 Then read
        If flag_TPC_MAIN_FSM_MSBS = &H0 Then write_TPC_MAIN_FSM_MSBS_value = get_TPC_MAIN_FSM_MSBS

        regValue = leftShift((write_TPC_MAIN_FSM_MSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_MAIN_FSM_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_MAIN_FSM_MSBS_mask = mask then
                read_TPC_MAIN_FSM_MSBS_value = data_low
            else
                read_TPC_MAIN_FSM_MSBS_value = (data_low - H8000_0000) and TPC_MAIN_FSM_MSBS_mask
            end If
        else
            read_TPC_MAIN_FSM_MSBS_value = data_low and TPC_MAIN_FSM_MSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_MAIN_FSM_MSBS_value = &H0
        flag_TPC_MAIN_FSM_MSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_read_data_lsbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_READ_DATA_LSBS                     [15:0]           get_TPC_RAM_READ_DATA_LSBS
''                                                             set_TPC_RAM_READ_DATA_LSBS
''                                                             read_TPC_RAM_READ_DATA_LSBS
''                                                             write_TPC_RAM_READ_DATA_LSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_read_data_lsbs
    Private write_TPC_RAM_READ_DATA_LSBS_value
    Private read_TPC_RAM_READ_DATA_LSBS_value
    Private flag_TPC_RAM_READ_DATA_LSBS

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

    Property Get get_TPC_RAM_READ_DATA_LSBS
        get_TPC_RAM_READ_DATA_LSBS = read_TPC_RAM_READ_DATA_LSBS_value
    End Property

    Property Let set_TPC_RAM_READ_DATA_LSBS(aData)
        write_TPC_RAM_READ_DATA_LSBS_value = aData
        flag_TPC_RAM_READ_DATA_LSBS        = &H1
    End Property

    Property Get read_TPC_RAM_READ_DATA_LSBS
        read
        read_TPC_RAM_READ_DATA_LSBS = read_TPC_RAM_READ_DATA_LSBS_value
    End Property

    Property Let write_TPC_RAM_READ_DATA_LSBS(aData)
        set_TPC_RAM_READ_DATA_LSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_DATA_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DATA_LSBS_mask = mask then
                read_TPC_RAM_READ_DATA_LSBS_value = data_low
            else
                read_TPC_RAM_READ_DATA_LSBS_value = (data_low - H8000_0000) and TPC_RAM_READ_DATA_LSBS_mask
            end If
        else
            read_TPC_RAM_READ_DATA_LSBS_value = data_low and TPC_RAM_READ_DATA_LSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_READ_DATA_LSBS = &H0 Then read
        If flag_TPC_RAM_READ_DATA_LSBS = &H0 Then write_TPC_RAM_READ_DATA_LSBS_value = get_TPC_RAM_READ_DATA_LSBS

        regValue = leftShift((write_TPC_RAM_READ_DATA_LSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_DATA_LSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DATA_LSBS_mask = mask then
                read_TPC_RAM_READ_DATA_LSBS_value = data_low
            else
                read_TPC_RAM_READ_DATA_LSBS_value = (data_low - H8000_0000) and TPC_RAM_READ_DATA_LSBS_mask
            end If
        else
            read_TPC_RAM_READ_DATA_LSBS_value = data_low and TPC_RAM_READ_DATA_LSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_READ_DATA_LSBS_value = &H0
        flag_TPC_RAM_READ_DATA_LSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_read_data_msbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_READ_DATA_MSBS                     [15:0]           get_TPC_RAM_READ_DATA_MSBS
''                                                             set_TPC_RAM_READ_DATA_MSBS
''                                                             read_TPC_RAM_READ_DATA_MSBS
''                                                             write_TPC_RAM_READ_DATA_MSBS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_read_data_msbs
    Private write_TPC_RAM_READ_DATA_MSBS_value
    Private read_TPC_RAM_READ_DATA_MSBS_value
    Private flag_TPC_RAM_READ_DATA_MSBS

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

    Property Get get_TPC_RAM_READ_DATA_MSBS
        get_TPC_RAM_READ_DATA_MSBS = read_TPC_RAM_READ_DATA_MSBS_value
    End Property

    Property Let set_TPC_RAM_READ_DATA_MSBS(aData)
        write_TPC_RAM_READ_DATA_MSBS_value = aData
        flag_TPC_RAM_READ_DATA_MSBS        = &H1
    End Property

    Property Get read_TPC_RAM_READ_DATA_MSBS
        read
        read_TPC_RAM_READ_DATA_MSBS = read_TPC_RAM_READ_DATA_MSBS_value
    End Property

    Property Let write_TPC_RAM_READ_DATA_MSBS(aData)
        set_TPC_RAM_READ_DATA_MSBS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_DATA_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DATA_MSBS_mask = mask then
                read_TPC_RAM_READ_DATA_MSBS_value = data_low
            else
                read_TPC_RAM_READ_DATA_MSBS_value = (data_low - H8000_0000) and TPC_RAM_READ_DATA_MSBS_mask
            end If
        else
            read_TPC_RAM_READ_DATA_MSBS_value = data_low and TPC_RAM_READ_DATA_MSBS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_READ_DATA_MSBS = &H0 Then read
        If flag_TPC_RAM_READ_DATA_MSBS = &H0 Then write_TPC_RAM_READ_DATA_MSBS_value = get_TPC_RAM_READ_DATA_MSBS

        regValue = leftShift((write_TPC_RAM_READ_DATA_MSBS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_DATA_MSBS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DATA_MSBS_mask = mask then
                read_TPC_RAM_READ_DATA_MSBS_value = data_low
            else
                read_TPC_RAM_READ_DATA_MSBS_value = (data_low - H8000_0000) and TPC_RAM_READ_DATA_MSBS_mask
            end If
        else
            read_TPC_RAM_READ_DATA_MSBS_value = data_low and TPC_RAM_READ_DATA_MSBS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_READ_DATA_MSBS_value = &H0
        flag_TPC_RAM_READ_DATA_MSBS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_read_data_valid
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_READ_DATA_VALID                    [0:0]            get_TPC_RAM_READ_DATA_VALID
''                                                             set_TPC_RAM_READ_DATA_VALID
''                                                             read_TPC_RAM_READ_DATA_VALID
''                                                             write_TPC_RAM_READ_DATA_VALID
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_read_data_valid
    Private write_TPC_RAM_READ_DATA_VALID_value
    Private read_TPC_RAM_READ_DATA_VALID_value
    Private flag_TPC_RAM_READ_DATA_VALID

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TPC_RAM_READ_DATA_VALID
        get_TPC_RAM_READ_DATA_VALID = read_TPC_RAM_READ_DATA_VALID_value
    End Property

    Property Let set_TPC_RAM_READ_DATA_VALID(aData)
        write_TPC_RAM_READ_DATA_VALID_value = aData
        flag_TPC_RAM_READ_DATA_VALID        = &H1
    End Property

    Property Get read_TPC_RAM_READ_DATA_VALID
        read
        read_TPC_RAM_READ_DATA_VALID = read_TPC_RAM_READ_DATA_VALID_value
    End Property

    Property Let write_TPC_RAM_READ_DATA_VALID(aData)
        set_TPC_RAM_READ_DATA_VALID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_DATA_VALID_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DATA_VALID_mask = mask then
                read_TPC_RAM_READ_DATA_VALID_value = data_low
            else
                read_TPC_RAM_READ_DATA_VALID_value = (data_low - H8000_0000) and TPC_RAM_READ_DATA_VALID_mask
            end If
        else
            read_TPC_RAM_READ_DATA_VALID_value = data_low and TPC_RAM_READ_DATA_VALID_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_READ_DATA_VALID = &H0 Then read
        If flag_TPC_RAM_READ_DATA_VALID = &H0 Then write_TPC_RAM_READ_DATA_VALID_value = get_TPC_RAM_READ_DATA_VALID

        regValue = leftShift((write_TPC_RAM_READ_DATA_VALID_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_DATA_VALID_mask = &H1
        if data_low > LONG_MAX then
            if TPC_RAM_READ_DATA_VALID_mask = mask then
                read_TPC_RAM_READ_DATA_VALID_value = data_low
            else
                read_TPC_RAM_READ_DATA_VALID_value = (data_low - H8000_0000) and TPC_RAM_READ_DATA_VALID_mask
            end If
        else
            read_TPC_RAM_READ_DATA_VALID_value = data_low and TPC_RAM_READ_DATA_VALID_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_READ_DATA_VALID_value = &H0
        flag_TPC_RAM_READ_DATA_VALID        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_ram_read_address
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_RAM_READ_ADDRESS                       [15:0]           get_TPC_RAM_READ_ADDRESS
''                                                             set_TPC_RAM_READ_ADDRESS
''                                                             read_TPC_RAM_READ_ADDRESS
''                                                             write_TPC_RAM_READ_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_ram_read_address
    Private write_TPC_RAM_READ_ADDRESS_value
    Private read_TPC_RAM_READ_ADDRESS_value
    Private flag_TPC_RAM_READ_ADDRESS

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

    Property Get get_TPC_RAM_READ_ADDRESS
        get_TPC_RAM_READ_ADDRESS = read_TPC_RAM_READ_ADDRESS_value
    End Property

    Property Let set_TPC_RAM_READ_ADDRESS(aData)
        write_TPC_RAM_READ_ADDRESS_value = aData
        flag_TPC_RAM_READ_ADDRESS        = &H1
    End Property

    Property Get read_TPC_RAM_READ_ADDRESS
        read
        read_TPC_RAM_READ_ADDRESS = read_TPC_RAM_READ_ADDRESS_value
    End Property

    Property Let write_TPC_RAM_READ_ADDRESS(aData)
        set_TPC_RAM_READ_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_READ_ADDRESS_mask = mask then
                read_TPC_RAM_READ_ADDRESS_value = data_low
            else
                read_TPC_RAM_READ_ADDRESS_value = (data_low - H8000_0000) and TPC_RAM_READ_ADDRESS_mask
            end If
        else
            read_TPC_RAM_READ_ADDRESS_value = data_low and TPC_RAM_READ_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_TPC_RAM_READ_ADDRESS = &H0 Then read
        If flag_TPC_RAM_READ_ADDRESS = &H0 Then write_TPC_RAM_READ_ADDRESS_value = get_TPC_RAM_READ_ADDRESS

        regValue = leftShift((write_TPC_RAM_READ_ADDRESS_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_RAM_READ_ADDRESS_mask = &Hffff
        if data_low > LONG_MAX then
            if TPC_RAM_READ_ADDRESS_mask = mask then
                read_TPC_RAM_READ_ADDRESS_value = data_low
            else
                read_TPC_RAM_READ_ADDRESS_value = (data_low - H8000_0000) and TPC_RAM_READ_ADDRESS_mask
            end If
        else
            read_TPC_RAM_READ_ADDRESS_value = data_low and TPC_RAM_READ_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_RAM_READ_ADDRESS_value = &H0
        flag_TPC_RAM_READ_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_trigger_active
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC_TRIGGER_ACTIVE                         [0:0]            get_TPC_TRIGGER_ACTIVE
''                                                             set_TPC_TRIGGER_ACTIVE
''                                                             read_TPC_TRIGGER_ACTIVE
''                                                             write_TPC_TRIGGER_ACTIVE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_trigger_active
    Private write_TPC_TRIGGER_ACTIVE_value
    Private read_TPC_TRIGGER_ACTIVE_value
    Private flag_TPC_TRIGGER_ACTIVE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TPC_TRIGGER_ACTIVE
        get_TPC_TRIGGER_ACTIVE = read_TPC_TRIGGER_ACTIVE_value
    End Property

    Property Let set_TPC_TRIGGER_ACTIVE(aData)
        write_TPC_TRIGGER_ACTIVE_value = aData
        flag_TPC_TRIGGER_ACTIVE        = &H1
    End Property

    Property Get read_TPC_TRIGGER_ACTIVE
        read
        read_TPC_TRIGGER_ACTIVE = read_TPC_TRIGGER_ACTIVE_value
    End Property

    Property Let write_TPC_TRIGGER_ACTIVE(aData)
        set_TPC_TRIGGER_ACTIVE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_TRIGGER_ACTIVE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_TRIGGER_ACTIVE_mask = mask then
                read_TPC_TRIGGER_ACTIVE_value = data_low
            else
                read_TPC_TRIGGER_ACTIVE_value = (data_low - H8000_0000) and TPC_TRIGGER_ACTIVE_mask
            end If
        else
            read_TPC_TRIGGER_ACTIVE_value = data_low and TPC_TRIGGER_ACTIVE_mask
        end If

    End Sub

    Sub write
        If flag_TPC_TRIGGER_ACTIVE = &H0 Then read
        If flag_TPC_TRIGGER_ACTIVE = &H0 Then write_TPC_TRIGGER_ACTIVE_value = get_TPC_TRIGGER_ACTIVE

        regValue = leftShift((write_TPC_TRIGGER_ACTIVE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TPC_TRIGGER_ACTIVE_mask = &H1
        if data_low > LONG_MAX then
            if TPC_TRIGGER_ACTIVE_mask = mask then
                read_TPC_TRIGGER_ACTIVE_value = data_low
            else
                read_TPC_TRIGGER_ACTIVE_value = (data_low - H8000_0000) and TPC_TRIGGER_ACTIVE_mask
            end If
        else
            read_TPC_TRIGGER_ACTIVE_value = data_low and TPC_TRIGGER_ACTIVE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC_TRIGGER_ACTIVE_value = &H0
        flag_TPC_TRIGGER_ACTIVE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc_data_capture_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_DATA_CAPTURE_ENABLE                   [1:1]            get_TPC2_DATA_CAPTURE_ENABLE
''                                                             set_TPC2_DATA_CAPTURE_ENABLE
''                                                             read_TPC2_DATA_CAPTURE_ENABLE
''                                                             write_TPC2_DATA_CAPTURE_ENABLE
''---------------------------------------------------------------------------------
'' TPC1_DATA_CAPTURE_ENABLE                   [0:0]            get_TPC1_DATA_CAPTURE_ENABLE
''                                                             set_TPC1_DATA_CAPTURE_ENABLE
''                                                             read_TPC1_DATA_CAPTURE_ENABLE
''                                                             write_TPC1_DATA_CAPTURE_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc_data_capture_enable
    Private write_TPC2_DATA_CAPTURE_ENABLE_value
    Private read_TPC2_DATA_CAPTURE_ENABLE_value
    Private flag_TPC2_DATA_CAPTURE_ENABLE
    Private write_TPC1_DATA_CAPTURE_ENABLE_value
    Private read_TPC1_DATA_CAPTURE_ENABLE_value
    Private flag_TPC1_DATA_CAPTURE_ENABLE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H46
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TPC2_DATA_CAPTURE_ENABLE
        get_TPC2_DATA_CAPTURE_ENABLE = read_TPC2_DATA_CAPTURE_ENABLE_value
    End Property

    Property Let set_TPC2_DATA_CAPTURE_ENABLE(aData)
        write_TPC2_DATA_CAPTURE_ENABLE_value = aData
        flag_TPC2_DATA_CAPTURE_ENABLE        = &H1
    End Property

    Property Get read_TPC2_DATA_CAPTURE_ENABLE
        read
        read_TPC2_DATA_CAPTURE_ENABLE = read_TPC2_DATA_CAPTURE_ENABLE_value
    End Property

    Property Let write_TPC2_DATA_CAPTURE_ENABLE(aData)
        set_TPC2_DATA_CAPTURE_ENABLE = aData
        write
    End Property

    Property Get get_TPC1_DATA_CAPTURE_ENABLE
        get_TPC1_DATA_CAPTURE_ENABLE = read_TPC1_DATA_CAPTURE_ENABLE_value
    End Property

    Property Let set_TPC1_DATA_CAPTURE_ENABLE(aData)
        write_TPC1_DATA_CAPTURE_ENABLE_value = aData
        flag_TPC1_DATA_CAPTURE_ENABLE        = &H1
    End Property

    Property Get read_TPC1_DATA_CAPTURE_ENABLE
        read
        read_TPC1_DATA_CAPTURE_ENABLE = read_TPC1_DATA_CAPTURE_ENABLE_value
    End Property

    Property Let write_TPC1_DATA_CAPTURE_ENABLE(aData)
        set_TPC1_DATA_CAPTURE_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_DATA_CAPTURE_ENABLE_value = rightShift(data_low, 1) and &H1
        TPC1_DATA_CAPTURE_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC1_DATA_CAPTURE_ENABLE_mask = mask then
                read_TPC1_DATA_CAPTURE_ENABLE_value = data_low
            else
                read_TPC1_DATA_CAPTURE_ENABLE_value = (data_low - H8000_0000) and TPC1_DATA_CAPTURE_ENABLE_mask
            end If
        else
            read_TPC1_DATA_CAPTURE_ENABLE_value = data_low and TPC1_DATA_CAPTURE_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_DATA_CAPTURE_ENABLE = &H0 or flag_TPC1_DATA_CAPTURE_ENABLE = &H0 Then read
        If flag_TPC2_DATA_CAPTURE_ENABLE = &H0 Then write_TPC2_DATA_CAPTURE_ENABLE_value = get_TPC2_DATA_CAPTURE_ENABLE
        If flag_TPC1_DATA_CAPTURE_ENABLE = &H0 Then write_TPC1_DATA_CAPTURE_ENABLE_value = get_TPC1_DATA_CAPTURE_ENABLE

        regValue = leftShift((write_TPC2_DATA_CAPTURE_ENABLE_value and &H1), 1) + leftShift((write_TPC1_DATA_CAPTURE_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_DATA_CAPTURE_ENABLE_value = rightShift(data_low, 1) and &H1
        TPC1_DATA_CAPTURE_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if TPC1_DATA_CAPTURE_ENABLE_mask = mask then
                read_TPC1_DATA_CAPTURE_ENABLE_value = data_low
            else
                read_TPC1_DATA_CAPTURE_ENABLE_value = (data_low - H8000_0000) and TPC1_DATA_CAPTURE_ENABLE_mask
            end If
        else
            read_TPC1_DATA_CAPTURE_ENABLE_value = data_low and TPC1_DATA_CAPTURE_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_DATA_CAPTURE_ENABLE_value = &H0
        flag_TPC2_DATA_CAPTURE_ENABLE        = &H0
        write_TPC1_DATA_CAPTURE_ENABLE_value = &H0
        flag_TPC1_DATA_CAPTURE_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc1_ram_end_address_override
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC1_RAM_END_ADDRESS_OVERRIDE              [15:15]          get_TPC1_RAM_END_ADDRESS_OVERRIDE
''                                                             set_TPC1_RAM_END_ADDRESS_OVERRIDE
''                                                             read_TPC1_RAM_END_ADDRESS_OVERRIDE
''                                                             write_TPC1_RAM_END_ADDRESS_OVERRIDE
''---------------------------------------------------------------------------------
'' TPC1_RAM_END_ADDRESS_VALUE                 [14:0]           get_TPC1_RAM_END_ADDRESS_VALUE
''                                                             set_TPC1_RAM_END_ADDRESS_VALUE
''                                                             read_TPC1_RAM_END_ADDRESS_VALUE
''                                                             write_TPC1_RAM_END_ADDRESS_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc1_ram_end_address_override
    Private write_TPC1_RAM_END_ADDRESS_OVERRIDE_value
    Private read_TPC1_RAM_END_ADDRESS_OVERRIDE_value
    Private flag_TPC1_RAM_END_ADDRESS_OVERRIDE
    Private write_TPC1_RAM_END_ADDRESS_VALUE_value
    Private read_TPC1_RAM_END_ADDRESS_VALUE_value
    Private flag_TPC1_RAM_END_ADDRESS_VALUE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TPC1_RAM_END_ADDRESS_OVERRIDE
        get_TPC1_RAM_END_ADDRESS_OVERRIDE = read_TPC1_RAM_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let set_TPC1_RAM_END_ADDRESS_OVERRIDE(aData)
        write_TPC1_RAM_END_ADDRESS_OVERRIDE_value = aData
        flag_TPC1_RAM_END_ADDRESS_OVERRIDE        = &H1
    End Property

    Property Get read_TPC1_RAM_END_ADDRESS_OVERRIDE
        read
        read_TPC1_RAM_END_ADDRESS_OVERRIDE = read_TPC1_RAM_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let write_TPC1_RAM_END_ADDRESS_OVERRIDE(aData)
        set_TPC1_RAM_END_ADDRESS_OVERRIDE = aData
        write
    End Property

    Property Get get_TPC1_RAM_END_ADDRESS_VALUE
        get_TPC1_RAM_END_ADDRESS_VALUE = read_TPC1_RAM_END_ADDRESS_VALUE_value
    End Property

    Property Let set_TPC1_RAM_END_ADDRESS_VALUE(aData)
        write_TPC1_RAM_END_ADDRESS_VALUE_value = aData
        flag_TPC1_RAM_END_ADDRESS_VALUE        = &H1
    End Property

    Property Get read_TPC1_RAM_END_ADDRESS_VALUE
        read
        read_TPC1_RAM_END_ADDRESS_VALUE = read_TPC1_RAM_END_ADDRESS_VALUE_value
    End Property

    Property Let write_TPC1_RAM_END_ADDRESS_VALUE(aData)
        set_TPC1_RAM_END_ADDRESS_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC1_RAM_END_ADDRESS_OVERRIDE_value = rightShift(data_low, 15) and &H1
        TPC1_RAM_END_ADDRESS_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if TPC1_RAM_END_ADDRESS_VALUE_mask = mask then
                read_TPC1_RAM_END_ADDRESS_VALUE_value = data_low
            else
                read_TPC1_RAM_END_ADDRESS_VALUE_value = (data_low - H8000_0000) and TPC1_RAM_END_ADDRESS_VALUE_mask
            end If
        else
            read_TPC1_RAM_END_ADDRESS_VALUE_value = data_low and TPC1_RAM_END_ADDRESS_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TPC1_RAM_END_ADDRESS_OVERRIDE = &H0 or flag_TPC1_RAM_END_ADDRESS_VALUE = &H0 Then read
        If flag_TPC1_RAM_END_ADDRESS_OVERRIDE = &H0 Then write_TPC1_RAM_END_ADDRESS_OVERRIDE_value = get_TPC1_RAM_END_ADDRESS_OVERRIDE
        If flag_TPC1_RAM_END_ADDRESS_VALUE = &H0 Then write_TPC1_RAM_END_ADDRESS_VALUE_value = get_TPC1_RAM_END_ADDRESS_VALUE

        regValue = leftShift((write_TPC1_RAM_END_ADDRESS_OVERRIDE_value and &H1), 15) + leftShift((write_TPC1_RAM_END_ADDRESS_VALUE_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC1_RAM_END_ADDRESS_OVERRIDE_value = rightShift(data_low, 15) and &H1
        TPC1_RAM_END_ADDRESS_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if TPC1_RAM_END_ADDRESS_VALUE_mask = mask then
                read_TPC1_RAM_END_ADDRESS_VALUE_value = data_low
            else
                read_TPC1_RAM_END_ADDRESS_VALUE_value = (data_low - H8000_0000) and TPC1_RAM_END_ADDRESS_VALUE_mask
            end If
        else
            read_TPC1_RAM_END_ADDRESS_VALUE_value = data_low and TPC1_RAM_END_ADDRESS_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC1_RAM_END_ADDRESS_OVERRIDE_value = &H0
        flag_TPC1_RAM_END_ADDRESS_OVERRIDE        = &H0
        write_TPC1_RAM_END_ADDRESS_VALUE_value = &H0
        flag_TPC1_RAM_END_ADDRESS_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_tpc2_ram_end_address_override
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TPC2_RAM_END_ADDRESS_OVERRIDE              [15:15]          get_TPC2_RAM_END_ADDRESS_OVERRIDE
''                                                             set_TPC2_RAM_END_ADDRESS_OVERRIDE
''                                                             read_TPC2_RAM_END_ADDRESS_OVERRIDE
''                                                             write_TPC2_RAM_END_ADDRESS_OVERRIDE
''---------------------------------------------------------------------------------
'' TPC2_RAM_END_ADDRESS_VALUE                 [14:0]           get_TPC2_RAM_END_ADDRESS_VALUE
''                                                             set_TPC2_RAM_END_ADDRESS_VALUE
''                                                             read_TPC2_RAM_END_ADDRESS_VALUE
''                                                             write_TPC2_RAM_END_ADDRESS_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_tpc2_ram_end_address_override
    Private write_TPC2_RAM_END_ADDRESS_OVERRIDE_value
    Private read_TPC2_RAM_END_ADDRESS_OVERRIDE_value
    Private flag_TPC2_RAM_END_ADDRESS_OVERRIDE
    Private write_TPC2_RAM_END_ADDRESS_VALUE_value
    Private read_TPC2_RAM_END_ADDRESS_VALUE_value
    Private flag_TPC2_RAM_END_ADDRESS_VALUE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TPC2_RAM_END_ADDRESS_OVERRIDE
        get_TPC2_RAM_END_ADDRESS_OVERRIDE = read_TPC2_RAM_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let set_TPC2_RAM_END_ADDRESS_OVERRIDE(aData)
        write_TPC2_RAM_END_ADDRESS_OVERRIDE_value = aData
        flag_TPC2_RAM_END_ADDRESS_OVERRIDE        = &H1
    End Property

    Property Get read_TPC2_RAM_END_ADDRESS_OVERRIDE
        read
        read_TPC2_RAM_END_ADDRESS_OVERRIDE = read_TPC2_RAM_END_ADDRESS_OVERRIDE_value
    End Property

    Property Let write_TPC2_RAM_END_ADDRESS_OVERRIDE(aData)
        set_TPC2_RAM_END_ADDRESS_OVERRIDE = aData
        write
    End Property

    Property Get get_TPC2_RAM_END_ADDRESS_VALUE
        get_TPC2_RAM_END_ADDRESS_VALUE = read_TPC2_RAM_END_ADDRESS_VALUE_value
    End Property

    Property Let set_TPC2_RAM_END_ADDRESS_VALUE(aData)
        write_TPC2_RAM_END_ADDRESS_VALUE_value = aData
        flag_TPC2_RAM_END_ADDRESS_VALUE        = &H1
    End Property

    Property Get read_TPC2_RAM_END_ADDRESS_VALUE
        read
        read_TPC2_RAM_END_ADDRESS_VALUE = read_TPC2_RAM_END_ADDRESS_VALUE_value
    End Property

    Property Let write_TPC2_RAM_END_ADDRESS_VALUE(aData)
        set_TPC2_RAM_END_ADDRESS_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_RAM_END_ADDRESS_OVERRIDE_value = rightShift(data_low, 15) and &H1
        TPC2_RAM_END_ADDRESS_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if TPC2_RAM_END_ADDRESS_VALUE_mask = mask then
                read_TPC2_RAM_END_ADDRESS_VALUE_value = data_low
            else
                read_TPC2_RAM_END_ADDRESS_VALUE_value = (data_low - H8000_0000) and TPC2_RAM_END_ADDRESS_VALUE_mask
            end If
        else
            read_TPC2_RAM_END_ADDRESS_VALUE_value = data_low and TPC2_RAM_END_ADDRESS_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TPC2_RAM_END_ADDRESS_OVERRIDE = &H0 or flag_TPC2_RAM_END_ADDRESS_VALUE = &H0 Then read
        If flag_TPC2_RAM_END_ADDRESS_OVERRIDE = &H0 Then write_TPC2_RAM_END_ADDRESS_OVERRIDE_value = get_TPC2_RAM_END_ADDRESS_OVERRIDE
        If flag_TPC2_RAM_END_ADDRESS_VALUE = &H0 Then write_TPC2_RAM_END_ADDRESS_VALUE_value = get_TPC2_RAM_END_ADDRESS_VALUE

        regValue = leftShift((write_TPC2_RAM_END_ADDRESS_OVERRIDE_value and &H1), 15) + leftShift((write_TPC2_RAM_END_ADDRESS_VALUE_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TPC2_RAM_END_ADDRESS_OVERRIDE_value = rightShift(data_low, 15) and &H1
        TPC2_RAM_END_ADDRESS_VALUE_mask = &H7fff
        if data_low > LONG_MAX then
            if TPC2_RAM_END_ADDRESS_VALUE_mask = mask then
                read_TPC2_RAM_END_ADDRESS_VALUE_value = data_low
            else
                read_TPC2_RAM_END_ADDRESS_VALUE_value = (data_low - H8000_0000) and TPC2_RAM_END_ADDRESS_VALUE_mask
            end If
        else
            read_TPC2_RAM_END_ADDRESS_VALUE_value = data_low and TPC2_RAM_END_ADDRESS_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TPC2_RAM_END_ADDRESS_OVERRIDE_value = &H0
        flag_TPC2_RAM_END_ADDRESS_OVERRIDE        = &H0
        write_TPC2_RAM_END_ADDRESS_VALUE_value = &H0
        flag_TPC2_RAM_END_ADDRESS_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_trigger_threshold_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TRIGGER_THRESHOLD_VALUE                    [15:0]           get_TRIGGER_THRESHOLD_VALUE
''                                                             set_TRIGGER_THRESHOLD_VALUE
''                                                             read_TRIGGER_THRESHOLD_VALUE
''                                                             write_TRIGGER_THRESHOLD_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_TEST_trigger_threshold_value
    Private write_TRIGGER_THRESHOLD_VALUE_value
    Private read_TRIGGER_THRESHOLD_VALUE_value
    Private flag_TRIGGER_THRESHOLD_VALUE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TRIGGER_THRESHOLD_VALUE
        get_TRIGGER_THRESHOLD_VALUE = read_TRIGGER_THRESHOLD_VALUE_value
    End Property

    Property Let set_TRIGGER_THRESHOLD_VALUE(aData)
        write_TRIGGER_THRESHOLD_VALUE_value = aData
        flag_TRIGGER_THRESHOLD_VALUE        = &H1
    End Property

    Property Get read_TRIGGER_THRESHOLD_VALUE
        read
        read_TRIGGER_THRESHOLD_VALUE = read_TRIGGER_THRESHOLD_VALUE_value
    End Property

    Property Let write_TRIGGER_THRESHOLD_VALUE(aData)
        set_TRIGGER_THRESHOLD_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TRIGGER_THRESHOLD_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TRIGGER_THRESHOLD_VALUE_mask = mask then
                read_TRIGGER_THRESHOLD_VALUE_value = data_low
            else
                read_TRIGGER_THRESHOLD_VALUE_value = (data_low - H8000_0000) and TRIGGER_THRESHOLD_VALUE_mask
            end If
        else
            read_TRIGGER_THRESHOLD_VALUE_value = data_low and TRIGGER_THRESHOLD_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TRIGGER_THRESHOLD_VALUE = &H0 Then read
        If flag_TRIGGER_THRESHOLD_VALUE = &H0 Then write_TRIGGER_THRESHOLD_VALUE_value = get_TRIGGER_THRESHOLD_VALUE

        regValue = leftShift((write_TRIGGER_THRESHOLD_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TRIGGER_THRESHOLD_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TRIGGER_THRESHOLD_VALUE_mask = mask then
                read_TRIGGER_THRESHOLD_VALUE_value = data_low
            else
                read_TRIGGER_THRESHOLD_VALUE_value = (data_low - H8000_0000) and TRIGGER_THRESHOLD_VALUE_mask
            end If
        else
            read_TRIGGER_THRESHOLD_VALUE_value = data_low and TRIGGER_THRESHOLD_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TRIGGER_THRESHOLD_VALUE_value = &H0
        flag_TRIGGER_THRESHOLD_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : TEST_gphy_tpout_data_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GPHY_TPOUT_DATA_BUS_SWAP                   [15:15]          get_GPHY_TPOUT_DATA_BUS_SWAP
''                                                             set_GPHY_TPOUT_DATA_BUS_SWAP
''                                                             read_GPHY_TPOUT_DATA_BUS_SWAP
''                                                             write_GPHY_TPOUT_DATA_BUS_SWAP
''---------------------------------------------------------------------------------
'' TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS       [14:14]          get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
''                                                             set_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
''                                                             read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
''                                                             write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
''---------------------------------------------------------------------------------
'' TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS      [13:13]          get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             set_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
''                                                             write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
''---------------------------------------------------------------------------------
'' TPOUT_DATA_SELECT_ENABLE_FROM_DSP          [12:12]          get_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
''                                                             set_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
''                                                             read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
''                                                             write_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
''---------------------------------------------------------------------------------
'' GPHY_TPOUT_DECIMATION_RATE                 [11:10]          get_GPHY_TPOUT_DECIMATION_RATE
''                                                             set_GPHY_TPOUT_DECIMATION_RATE
''                                                             read_GPHY_TPOUT_DECIMATION_RATE
''                                                             write_GPHY_TPOUT_DECIMATION_RATE
''---------------------------------------------------------------------------------
'' GPHY_TPOUT_DATA_SELECT                     [9:0]            get_GPHY_TPOUT_DATA_SELECT
''                                                             set_GPHY_TPOUT_DATA_SELECT
''                                                             read_GPHY_TPOUT_DATA_SELECT
''                                                             write_GPHY_TPOUT_DATA_SELECT
''---------------------------------------------------------------------------------
Class REGISTER_TEST_gphy_tpout_data_select
    Private write_GPHY_TPOUT_DATA_BUS_SWAP_value
    Private read_GPHY_TPOUT_DATA_BUS_SWAP_value
    Private flag_GPHY_TPOUT_DATA_BUS_SWAP
    Private write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value
    Private read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value
    Private flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
    Private write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    Private read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    Private flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
    Private write_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value
    Private read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value
    Private flag_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
    Private write_GPHY_TPOUT_DECIMATION_RATE_value
    Private read_GPHY_TPOUT_DECIMATION_RATE_value
    Private flag_GPHY_TPOUT_DECIMATION_RATE
    Private write_GPHY_TPOUT_DATA_SELECT_value
    Private read_GPHY_TPOUT_DATA_SELECT_value
    Private flag_GPHY_TPOUT_DATA_SELECT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_GPHY_TPOUT_DATA_BUS_SWAP
        get_GPHY_TPOUT_DATA_BUS_SWAP = read_GPHY_TPOUT_DATA_BUS_SWAP_value
    End Property

    Property Let set_GPHY_TPOUT_DATA_BUS_SWAP(aData)
        write_GPHY_TPOUT_DATA_BUS_SWAP_value = aData
        flag_GPHY_TPOUT_DATA_BUS_SWAP        = &H1
    End Property

    Property Get read_GPHY_TPOUT_DATA_BUS_SWAP
        read
        read_GPHY_TPOUT_DATA_BUS_SWAP = read_GPHY_TPOUT_DATA_BUS_SWAP_value
    End Property

    Property Let write_GPHY_TPOUT_DATA_BUS_SWAP(aData)
        set_GPHY_TPOUT_DATA_BUS_SWAP = aData
        write
    End Property

    Property Get get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
        get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS = read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value
    End Property

    Property Let set_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS(aData)
        write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value = aData
        flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS        = &H1
    End Property

    Property Get read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
        read
        read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS = read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value
    End Property

    Property Let write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS(aData)
        set_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS = aData
        write
    End Property

    Property Get get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
        get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS = read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let set_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS(aData)
        write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = aData
        flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS        = &H1
    End Property

    Property Get read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
        read
        read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS = read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value
    End Property

    Property Let write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS(aData)
        set_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS = aData
        write
    End Property

    Property Get get_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
        get_TPOUT_DATA_SELECT_ENABLE_FROM_DSP = read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value
    End Property

    Property Let set_TPOUT_DATA_SELECT_ENABLE_FROM_DSP(aData)
        write_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value = aData
        flag_TPOUT_DATA_SELECT_ENABLE_FROM_DSP        = &H1
    End Property

    Property Get read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
        read
        read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP = read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value
    End Property

    Property Let write_TPOUT_DATA_SELECT_ENABLE_FROM_DSP(aData)
        set_TPOUT_DATA_SELECT_ENABLE_FROM_DSP = aData
        write
    End Property

    Property Get get_GPHY_TPOUT_DECIMATION_RATE
        get_GPHY_TPOUT_DECIMATION_RATE = read_GPHY_TPOUT_DECIMATION_RATE_value
    End Property

    Property Let set_GPHY_TPOUT_DECIMATION_RATE(aData)
        write_GPHY_TPOUT_DECIMATION_RATE_value = aData
        flag_GPHY_TPOUT_DECIMATION_RATE        = &H1
    End Property

    Property Get read_GPHY_TPOUT_DECIMATION_RATE
        read
        read_GPHY_TPOUT_DECIMATION_RATE = read_GPHY_TPOUT_DECIMATION_RATE_value
    End Property

    Property Let write_GPHY_TPOUT_DECIMATION_RATE(aData)
        set_GPHY_TPOUT_DECIMATION_RATE = aData
        write
    End Property

    Property Get get_GPHY_TPOUT_DATA_SELECT
        get_GPHY_TPOUT_DATA_SELECT = read_GPHY_TPOUT_DATA_SELECT_value
    End Property

    Property Let set_GPHY_TPOUT_DATA_SELECT(aData)
        write_GPHY_TPOUT_DATA_SELECT_value = aData
        flag_GPHY_TPOUT_DATA_SELECT        = &H1
    End Property

    Property Get read_GPHY_TPOUT_DATA_SELECT
        read
        read_GPHY_TPOUT_DATA_SELECT = read_GPHY_TPOUT_DATA_SELECT_value
    End Property

    Property Let write_GPHY_TPOUT_DATA_SELECT(aData)
        set_GPHY_TPOUT_DATA_SELECT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPHY_TPOUT_DATA_BUS_SWAP_value = rightShift(data_low, 15) and &H1
        read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value = rightShift(data_low, 14) and &H1
        read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 13) and &H1
        read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value = rightShift(data_low, 12) and &H1
        read_GPHY_TPOUT_DECIMATION_RATE_value = rightShift(data_low, 10) and &H3
        GPHY_TPOUT_DATA_SELECT_mask = &H3ff
        if data_low > LONG_MAX then
            if GPHY_TPOUT_DATA_SELECT_mask = mask then
                read_GPHY_TPOUT_DATA_SELECT_value = data_low
            else
                read_GPHY_TPOUT_DATA_SELECT_value = (data_low - H8000_0000) and GPHY_TPOUT_DATA_SELECT_mask
            end If
        else
            read_GPHY_TPOUT_DATA_SELECT_value = data_low and GPHY_TPOUT_DATA_SELECT_mask
        end If

    End Sub

    Sub write
        If flag_GPHY_TPOUT_DATA_BUS_SWAP = &H0 or flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS = &H0 or flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS = &H0 or flag_TPOUT_DATA_SELECT_ENABLE_FROM_DSP = &H0 or flag_GPHY_TPOUT_DECIMATION_RATE = &H0 or flag_GPHY_TPOUT_DATA_SELECT = &H0 Then read
        If flag_GPHY_TPOUT_DATA_BUS_SWAP = &H0 Then write_GPHY_TPOUT_DATA_BUS_SWAP_value = get_GPHY_TPOUT_DATA_BUS_SWAP
        If flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS = &H0 Then write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value = get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS
        If flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS = &H0 Then write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = get_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS
        If flag_TPOUT_DATA_SELECT_ENABLE_FROM_DSP = &H0 Then write_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value = get_TPOUT_DATA_SELECT_ENABLE_FROM_DSP
        If flag_GPHY_TPOUT_DECIMATION_RATE = &H0 Then write_GPHY_TPOUT_DECIMATION_RATE_value = get_GPHY_TPOUT_DECIMATION_RATE
        If flag_GPHY_TPOUT_DATA_SELECT = &H0 Then write_GPHY_TPOUT_DATA_SELECT_value = get_GPHY_TPOUT_DATA_SELECT

        regValue = leftShift((write_GPHY_TPOUT_DATA_BUS_SWAP_value and &H1), 15) + leftShift((write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value and &H1), 14) + leftShift((write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value and &H1), 13) + leftShift((write_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value and &H1), 12) + leftShift((write_GPHY_TPOUT_DECIMATION_RATE_value and &H3), 10) + leftShift((write_GPHY_TPOUT_DATA_SELECT_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GPHY_TPOUT_DATA_BUS_SWAP_value = rightShift(data_low, 15) and &H1
        read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value = rightShift(data_low, 14) and &H1
        read_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = rightShift(data_low, 13) and &H1
        read_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value = rightShift(data_low, 12) and &H1
        read_GPHY_TPOUT_DECIMATION_RATE_value = rightShift(data_low, 10) and &H3
        GPHY_TPOUT_DATA_SELECT_mask = &H3ff
        if data_low > LONG_MAX then
            if GPHY_TPOUT_DATA_SELECT_mask = mask then
                read_GPHY_TPOUT_DATA_SELECT_value = data_low
            else
                read_GPHY_TPOUT_DATA_SELECT_value = (data_low - H8000_0000) and GPHY_TPOUT_DATA_SELECT_mask
            end If
        else
            read_GPHY_TPOUT_DATA_SELECT_value = data_low and GPHY_TPOUT_DATA_SELECT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GPHY_TPOUT_DATA_BUS_SWAP_value = &H0
        flag_GPHY_TPOUT_DATA_BUS_SWAP        = &H0
        write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS_value = &H0
        flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_PCS        = &H0
        write_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS_value = &H0
        flag_TPOUT_DATA_SELECT_ENABLE_FROM_BR_GPCS        = &H0
        write_TPOUT_DATA_SELECT_ENABLE_FROM_DSP_value = &H0
        flag_TPOUT_DATA_SELECT_ENABLE_FROM_DSP        = &H0
        write_GPHY_TPOUT_DECIMATION_RATE_value = &H0
        flag_GPHY_TPOUT_DECIMATION_RATE        = &H0
        write_GPHY_TPOUT_DATA_SELECT_value = &H0
        flag_GPHY_TPOUT_DATA_SELECT        = &H0
    End Sub
End Class


'' @REGISTER : TEST_spare_end_addr
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
Class REGISTER_TEST_spare_end_addr
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
        offset = &Hdfe
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

Class TEST_INSTANCE

    Public tpc_decimate_rate
    Public tpc_trigger_mode
    Public tpc_post_trigger_count
    Public tpc_trigger_select
    Public tpc1_data_select
    Public tpc2_data_select
    Public tpc_ram_read_enable
    Public tpc_read_burst_enable
    Public tpc_read_override_mode
    Public tpc_read_start_address_override
    Public tpc_read_end_address_override
    Public tpc2_read_start_address_override
    Public tpc2_read_end_address_override
    Public tpc_ram_write_control
    Public tpc_status_register
    Public tpc_ram_status_register
    Public tpc_trigger_address
    Public tpc_start_address
    Public tpc_end_address
    Public tpc_current_address
    Public tpc2_trigger_address
    Public tpc2_start_address
    Public tpc2_end_address
    Public tpc2_current_address
    Public tpc_ram_control_fsm_lsbs
    Public tpc_ram_control_fsm_msbs
    Public tpc2_ram_control_fsm_lsbs
    Public tpc2_ram_control_fsm_msbs
    Public tpc_main_fsm_lsbs
    Public tpc_main_fsm_msbs
    Public tpc_ram_read_data_lsbs
    Public tpc_ram_read_data_msbs
    Public tpc_ram_read_data_valid
    Public tpc_ram_read_address
    Public tpc_trigger_active
    Public tpc_data_capture_enable
    Public tpc1_ram_end_address_override
    Public tpc2_ram_end_address_override
    Public trigger_threshold_value
    Public gphy_tpout_data_select
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set tpc_decimate_rate = (New REGISTER_TEST_tpc_decimate_rate)(aBaseAddr, 16)
        Set tpc_trigger_mode = (New REGISTER_TEST_tpc_trigger_mode)(aBaseAddr, 16)
        Set tpc_post_trigger_count = (New REGISTER_TEST_tpc_post_trigger_count)(aBaseAddr, 16)
        Set tpc_trigger_select = (New REGISTER_TEST_tpc_trigger_select)(aBaseAddr, 16)
        Set tpc1_data_select = (New REGISTER_TEST_tpc1_data_select)(aBaseAddr, 16)
        Set tpc2_data_select = (New REGISTER_TEST_tpc2_data_select)(aBaseAddr, 16)
        Set tpc_ram_read_enable = (New REGISTER_TEST_tpc_ram_read_enable)(aBaseAddr, 16)
        Set tpc_read_burst_enable = (New REGISTER_TEST_tpc_read_burst_enable)(aBaseAddr, 16)
        Set tpc_read_override_mode = (New REGISTER_TEST_tpc_read_override_mode)(aBaseAddr, 16)
        Set tpc_read_start_address_override = (New REGISTER_TEST_tpc_read_start_address_override)(aBaseAddr, 16)
        Set tpc_read_end_address_override = (New REGISTER_TEST_tpc_read_end_address_override)(aBaseAddr, 16)
        Set tpc2_read_start_address_override = (New REGISTER_TEST_tpc2_read_start_address_override)(aBaseAddr, 16)
        Set tpc2_read_end_address_override = (New REGISTER_TEST_tpc2_read_end_address_override)(aBaseAddr, 16)
        Set tpc_ram_write_control = (New REGISTER_TEST_tpc_ram_write_control)(aBaseAddr, 16)
        Set tpc_status_register = (New REGISTER_TEST_tpc_status_register)(aBaseAddr, 16)
        Set tpc_ram_status_register = (New REGISTER_TEST_tpc_ram_status_register)(aBaseAddr, 16)
        Set tpc_trigger_address = (New REGISTER_TEST_tpc_trigger_address)(aBaseAddr, 16)
        Set tpc_start_address = (New REGISTER_TEST_tpc_start_address)(aBaseAddr, 16)
        Set tpc_end_address = (New REGISTER_TEST_tpc_end_address)(aBaseAddr, 16)
        Set tpc_current_address = (New REGISTER_TEST_tpc_current_address)(aBaseAddr, 16)
        Set tpc2_trigger_address = (New REGISTER_TEST_tpc2_trigger_address)(aBaseAddr, 16)
        Set tpc2_start_address = (New REGISTER_TEST_tpc2_start_address)(aBaseAddr, 16)
        Set tpc2_end_address = (New REGISTER_TEST_tpc2_end_address)(aBaseAddr, 16)
        Set tpc2_current_address = (New REGISTER_TEST_tpc2_current_address)(aBaseAddr, 16)
        Set tpc_ram_control_fsm_lsbs = (New REGISTER_TEST_tpc_ram_control_fsm_lsbs)(aBaseAddr, 16)
        Set tpc_ram_control_fsm_msbs = (New REGISTER_TEST_tpc_ram_control_fsm_msbs)(aBaseAddr, 16)
        Set tpc2_ram_control_fsm_lsbs = (New REGISTER_TEST_tpc2_ram_control_fsm_lsbs)(aBaseAddr, 16)
        Set tpc2_ram_control_fsm_msbs = (New REGISTER_TEST_tpc2_ram_control_fsm_msbs)(aBaseAddr, 16)
        Set tpc_main_fsm_lsbs = (New REGISTER_TEST_tpc_main_fsm_lsbs)(aBaseAddr, 16)
        Set tpc_main_fsm_msbs = (New REGISTER_TEST_tpc_main_fsm_msbs)(aBaseAddr, 16)
        Set tpc_ram_read_data_lsbs = (New REGISTER_TEST_tpc_ram_read_data_lsbs)(aBaseAddr, 16)
        Set tpc_ram_read_data_msbs = (New REGISTER_TEST_tpc_ram_read_data_msbs)(aBaseAddr, 16)
        Set tpc_ram_read_data_valid = (New REGISTER_TEST_tpc_ram_read_data_valid)(aBaseAddr, 16)
        Set tpc_ram_read_address = (New REGISTER_TEST_tpc_ram_read_address)(aBaseAddr, 16)
        Set tpc_trigger_active = (New REGISTER_TEST_tpc_trigger_active)(aBaseAddr, 16)
        Set tpc_data_capture_enable = (New REGISTER_TEST_tpc_data_capture_enable)(aBaseAddr, 16)
        Set tpc1_ram_end_address_override = (New REGISTER_TEST_tpc1_ram_end_address_override)(aBaseAddr, 16)
        Set tpc2_ram_end_address_override = (New REGISTER_TEST_tpc2_ram_end_address_override)(aBaseAddr, 16)
        Set trigger_threshold_value = (New REGISTER_TEST_trigger_threshold_value)(aBaseAddr, 16)
        Set gphy_tpout_data_select = (New REGISTER_TEST_gphy_tpout_data_select)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_TEST_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TEST = CreateObject("System.Collections.ArrayList")
TEST.Add ((New TEST_INSTANCE)(&H49033000))


