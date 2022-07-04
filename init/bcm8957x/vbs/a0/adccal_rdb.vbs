

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


'' @REGISTER : ADCCAL_mode_ctl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEST_MODE                                  [15:13]          get_TEST_MODE
''                                                             set_TEST_MODE
''                                                             read_TEST_MODE
''                                                             write_TEST_MODE
''---------------------------------------------------------------------------------
'' TEST_MODE_DEC_M                            [12:8]           get_TEST_MODE_DEC_M
''                                                             set_TEST_MODE_DEC_M
''                                                             read_TEST_MODE_DEC_M
''                                                             write_TEST_MODE_DEC_M
''---------------------------------------------------------------------------------
'' TEST_MODE_DEC_N                            [7:0]            get_TEST_MODE_DEC_N
''                                                             set_TEST_MODE_DEC_N
''                                                             read_TEST_MODE_DEC_N
''                                                             write_TEST_MODE_DEC_N
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_mode_ctl_1
    Private write_TEST_MODE_value
    Private read_TEST_MODE_value
    Private flag_TEST_MODE
    Private write_TEST_MODE_DEC_M_value
    Private read_TEST_MODE_DEC_M_value
    Private flag_TEST_MODE_DEC_M
    Private write_TEST_MODE_DEC_N_value
    Private read_TEST_MODE_DEC_N_value
    Private flag_TEST_MODE_DEC_N

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

    Property Get get_TEST_MODE
        get_TEST_MODE = read_TEST_MODE_value
    End Property

    Property Let set_TEST_MODE(aData)
        write_TEST_MODE_value = aData
        flag_TEST_MODE        = &H1
    End Property

    Property Get read_TEST_MODE
        read
        read_TEST_MODE = read_TEST_MODE_value
    End Property

    Property Let write_TEST_MODE(aData)
        set_TEST_MODE = aData
        write
    End Property

    Property Get get_TEST_MODE_DEC_M
        get_TEST_MODE_DEC_M = read_TEST_MODE_DEC_M_value
    End Property

    Property Let set_TEST_MODE_DEC_M(aData)
        write_TEST_MODE_DEC_M_value = aData
        flag_TEST_MODE_DEC_M        = &H1
    End Property

    Property Get read_TEST_MODE_DEC_M
        read
        read_TEST_MODE_DEC_M = read_TEST_MODE_DEC_M_value
    End Property

    Property Let write_TEST_MODE_DEC_M(aData)
        set_TEST_MODE_DEC_M = aData
        write
    End Property

    Property Get get_TEST_MODE_DEC_N
        get_TEST_MODE_DEC_N = read_TEST_MODE_DEC_N_value
    End Property

    Property Let set_TEST_MODE_DEC_N(aData)
        write_TEST_MODE_DEC_N_value = aData
        flag_TEST_MODE_DEC_N        = &H1
    End Property

    Property Get read_TEST_MODE_DEC_N
        read
        read_TEST_MODE_DEC_N = read_TEST_MODE_DEC_N_value
    End Property

    Property Let write_TEST_MODE_DEC_N(aData)
        set_TEST_MODE_DEC_N = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEST_MODE_value = rightShift(data_low, 13) and &H7
        read_TEST_MODE_DEC_M_value = rightShift(data_low, 8) and &H1f
        TEST_MODE_DEC_N_mask = &Hff
        if data_low > LONG_MAX then
            if TEST_MODE_DEC_N_mask = mask then
                read_TEST_MODE_DEC_N_value = data_low
            else
                read_TEST_MODE_DEC_N_value = (data_low - H8000_0000) and TEST_MODE_DEC_N_mask
            end If
        else
            read_TEST_MODE_DEC_N_value = data_low and TEST_MODE_DEC_N_mask
        end If

    End Sub

    Sub write
        If flag_TEST_MODE = &H0 or flag_TEST_MODE_DEC_M = &H0 or flag_TEST_MODE_DEC_N = &H0 Then read
        If flag_TEST_MODE = &H0 Then write_TEST_MODE_value = get_TEST_MODE
        If flag_TEST_MODE_DEC_M = &H0 Then write_TEST_MODE_DEC_M_value = get_TEST_MODE_DEC_M
        If flag_TEST_MODE_DEC_N = &H0 Then write_TEST_MODE_DEC_N_value = get_TEST_MODE_DEC_N

        regValue = leftShift((write_TEST_MODE_value and &H7), 13) + leftShift((write_TEST_MODE_DEC_M_value and &H1f), 8) + leftShift((write_TEST_MODE_DEC_N_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEST_MODE_value = rightShift(data_low, 13) and &H7
        read_TEST_MODE_DEC_M_value = rightShift(data_low, 8) and &H1f
        TEST_MODE_DEC_N_mask = &Hff
        if data_low > LONG_MAX then
            if TEST_MODE_DEC_N_mask = mask then
                read_TEST_MODE_DEC_N_value = data_low
            else
                read_TEST_MODE_DEC_N_value = (data_low - H8000_0000) and TEST_MODE_DEC_N_mask
            end If
        else
            read_TEST_MODE_DEC_N_value = data_low and TEST_MODE_DEC_N_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEST_MODE_value = &H0
        flag_TEST_MODE        = &H0
        write_TEST_MODE_DEC_M_value = &H0
        flag_TEST_MODE_DEC_M        = &H0
        write_TEST_MODE_DEC_N_value = &H0
        flag_TEST_MODE_DEC_N        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_mode_ctl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEST_MODE_LANE                             [8:8]            get_TEST_MODE_LANE
''                                                             set_TEST_MODE_LANE
''                                                             read_TEST_MODE_LANE
''                                                             write_TEST_MODE_LANE
''---------------------------------------------------------------------------------
'' OFFSET_BINARY                              [2:2]            get_OFFSET_BINARY
''                                                             set_OFFSET_BINARY
''                                                             read_OFFSET_BINARY
''                                                             write_OFFSET_BINARY
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_mode_ctl_2
    Private write_TEST_MODE_LANE_value
    Private read_TEST_MODE_LANE_value
    Private flag_TEST_MODE_LANE
    Private write_OFFSET_BINARY_value
    Private read_OFFSET_BINARY_value
    Private flag_OFFSET_BINARY

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

    Property Get get_TEST_MODE_LANE
        get_TEST_MODE_LANE = read_TEST_MODE_LANE_value
    End Property

    Property Let set_TEST_MODE_LANE(aData)
        write_TEST_MODE_LANE_value = aData
        flag_TEST_MODE_LANE        = &H1
    End Property

    Property Get read_TEST_MODE_LANE
        read
        read_TEST_MODE_LANE = read_TEST_MODE_LANE_value
    End Property

    Property Let write_TEST_MODE_LANE(aData)
        set_TEST_MODE_LANE = aData
        write
    End Property

    Property Get get_OFFSET_BINARY
        get_OFFSET_BINARY = read_OFFSET_BINARY_value
    End Property

    Property Let set_OFFSET_BINARY(aData)
        write_OFFSET_BINARY_value = aData
        flag_OFFSET_BINARY        = &H1
    End Property

    Property Get read_OFFSET_BINARY
        read
        read_OFFSET_BINARY = read_OFFSET_BINARY_value
    End Property

    Property Let write_OFFSET_BINARY(aData)
        set_OFFSET_BINARY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEST_MODE_LANE_value = rightShift(data_low, 8) and &H1
        read_OFFSET_BINARY_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_TEST_MODE_LANE = &H0 or flag_OFFSET_BINARY = &H0 Then read
        If flag_TEST_MODE_LANE = &H0 Then write_TEST_MODE_LANE_value = get_TEST_MODE_LANE
        If flag_OFFSET_BINARY = &H0 Then write_OFFSET_BINARY_value = get_OFFSET_BINARY

        regValue = leftShift((write_TEST_MODE_LANE_value and &H1), 8) + leftShift((write_OFFSET_BINARY_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEST_MODE_LANE_value = rightShift(data_low, 8) and &H1
        read_OFFSET_BINARY_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEST_MODE_LANE_value = &H0
        flag_TEST_MODE_LANE        = &H0
        write_OFFSET_BINARY_value = &H0
        flag_OFFSET_BINARY        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_fgcal_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FGCAL_HALTED                               [15:15]          get_FGCAL_HALTED
''                                                             set_FGCAL_HALTED
''                                                             read_FGCAL_HALTED
''                                                             write_FGCAL_HALTED
''---------------------------------------------------------------------------------
'' GAIN_UPDATE_EN                             [2:2]            get_GAIN_UPDATE_EN
''                                                             set_GAIN_UPDATE_EN
''                                                             read_GAIN_UPDATE_EN
''                                                             write_GAIN_UPDATE_EN
''---------------------------------------------------------------------------------
'' FGCAL_OVR                                  [1:1]            get_FGCAL_OVR
''                                                             set_FGCAL_OVR
''                                                             read_FGCAL_OVR
''                                                             write_FGCAL_OVR
''---------------------------------------------------------------------------------
'' FGCAL_START                                [0:0]            get_FGCAL_START
''                                                             set_FGCAL_START
''                                                             read_FGCAL_START
''                                                             write_FGCAL_START
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_fgcal_ctl
    Private write_FGCAL_HALTED_value
    Private read_FGCAL_HALTED_value
    Private flag_FGCAL_HALTED
    Private write_GAIN_UPDATE_EN_value
    Private read_GAIN_UPDATE_EN_value
    Private flag_GAIN_UPDATE_EN
    Private write_FGCAL_OVR_value
    Private read_FGCAL_OVR_value
    Private flag_FGCAL_OVR
    Private write_FGCAL_START_value
    Private read_FGCAL_START_value
    Private flag_FGCAL_START

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

    Property Get get_FGCAL_HALTED
        get_FGCAL_HALTED = read_FGCAL_HALTED_value
    End Property

    Property Let set_FGCAL_HALTED(aData)
        write_FGCAL_HALTED_value = aData
        flag_FGCAL_HALTED        = &H1
    End Property

    Property Get read_FGCAL_HALTED
        read
        read_FGCAL_HALTED = read_FGCAL_HALTED_value
    End Property

    Property Let write_FGCAL_HALTED(aData)
        set_FGCAL_HALTED = aData
        write
    End Property

    Property Get get_GAIN_UPDATE_EN
        get_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let set_GAIN_UPDATE_EN(aData)
        write_GAIN_UPDATE_EN_value = aData
        flag_GAIN_UPDATE_EN        = &H1
    End Property

    Property Get read_GAIN_UPDATE_EN
        read
        read_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let write_GAIN_UPDATE_EN(aData)
        set_GAIN_UPDATE_EN = aData
        write
    End Property

    Property Get get_FGCAL_OVR
        get_FGCAL_OVR = read_FGCAL_OVR_value
    End Property

    Property Let set_FGCAL_OVR(aData)
        write_FGCAL_OVR_value = aData
        flag_FGCAL_OVR        = &H1
    End Property

    Property Get read_FGCAL_OVR
        read
        read_FGCAL_OVR = read_FGCAL_OVR_value
    End Property

    Property Let write_FGCAL_OVR(aData)
        set_FGCAL_OVR = aData
        write
    End Property

    Property Get get_FGCAL_START
        get_FGCAL_START = read_FGCAL_START_value
    End Property

    Property Let set_FGCAL_START(aData)
        write_FGCAL_START_value = aData
        flag_FGCAL_START        = &H1
    End Property

    Property Get read_FGCAL_START
        read
        read_FGCAL_START = read_FGCAL_START_value
    End Property

    Property Let write_FGCAL_START(aData)
        set_FGCAL_START = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FGCAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 2) and &H1
        read_FGCAL_OVR_value = rightShift(data_low, 1) and &H1
        FGCAL_START_mask = &H1
        if data_low > LONG_MAX then
            if FGCAL_START_mask = mask then
                read_FGCAL_START_value = data_low
            else
                read_FGCAL_START_value = (data_low - H8000_0000) and FGCAL_START_mask
            end If
        else
            read_FGCAL_START_value = data_low and FGCAL_START_mask
        end If

    End Sub

    Sub write
        If flag_FGCAL_HALTED = &H0 or flag_GAIN_UPDATE_EN = &H0 or flag_FGCAL_OVR = &H0 or flag_FGCAL_START = &H0 Then read
        If flag_FGCAL_HALTED = &H0 Then write_FGCAL_HALTED_value = get_FGCAL_HALTED
        If flag_GAIN_UPDATE_EN = &H0 Then write_GAIN_UPDATE_EN_value = get_GAIN_UPDATE_EN
        If flag_FGCAL_OVR = &H0 Then write_FGCAL_OVR_value = get_FGCAL_OVR
        If flag_FGCAL_START = &H0 Then write_FGCAL_START_value = get_FGCAL_START

        regValue = leftShift((write_FGCAL_HALTED_value and &H1), 15) + leftShift((write_GAIN_UPDATE_EN_value and &H1), 2) + leftShift((write_FGCAL_OVR_value and &H1), 1) + leftShift((write_FGCAL_START_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FGCAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 2) and &H1
        read_FGCAL_OVR_value = rightShift(data_low, 1) and &H1
        FGCAL_START_mask = &H1
        if data_low > LONG_MAX then
            if FGCAL_START_mask = mask then
                read_FGCAL_START_value = data_low
            else
                read_FGCAL_START_value = (data_low - H8000_0000) and FGCAL_START_mask
            end If
        else
            read_FGCAL_START_value = data_low and FGCAL_START_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FGCAL_HALTED_value = &H0
        flag_FGCAL_HALTED        = &H0
        write_GAIN_UPDATE_EN_value = &H0
        flag_GAIN_UPDATE_EN        = &H0
        write_FGCAL_OVR_value = &H0
        flag_FGCAL_OVR        = &H0
        write_FGCAL_START_value = &H0
        flag_FGCAL_START        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_fgcal_ovr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FGCAL_DONE                                 [15:15]          get_FGCAL_DONE
''                                                             set_FGCAL_DONE
''                                                             read_FGCAL_DONE
''                                                             write_FGCAL_DONE
''---------------------------------------------------------------------------------
'' FGCAL_TYPE                                 [11:8]           get_FGCAL_TYPE
''                                                             set_FGCAL_TYPE
''                                                             read_FGCAL_TYPE
''                                                             write_FGCAL_TYPE
''---------------------------------------------------------------------------------
'' FGCAL_MEAS                                 [4:0]            get_FGCAL_MEAS
''                                                             set_FGCAL_MEAS
''                                                             read_FGCAL_MEAS
''                                                             write_FGCAL_MEAS
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_fgcal_ovr
    Private write_FGCAL_DONE_value
    Private read_FGCAL_DONE_value
    Private flag_FGCAL_DONE
    Private write_FGCAL_TYPE_value
    Private read_FGCAL_TYPE_value
    Private flag_FGCAL_TYPE
    Private write_FGCAL_MEAS_value
    Private read_FGCAL_MEAS_value
    Private flag_FGCAL_MEAS

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

    Property Get get_FGCAL_DONE
        get_FGCAL_DONE = read_FGCAL_DONE_value
    End Property

    Property Let set_FGCAL_DONE(aData)
        write_FGCAL_DONE_value = aData
        flag_FGCAL_DONE        = &H1
    End Property

    Property Get read_FGCAL_DONE
        read
        read_FGCAL_DONE = read_FGCAL_DONE_value
    End Property

    Property Let write_FGCAL_DONE(aData)
        set_FGCAL_DONE = aData
        write
    End Property

    Property Get get_FGCAL_TYPE
        get_FGCAL_TYPE = read_FGCAL_TYPE_value
    End Property

    Property Let set_FGCAL_TYPE(aData)
        write_FGCAL_TYPE_value = aData
        flag_FGCAL_TYPE        = &H1
    End Property

    Property Get read_FGCAL_TYPE
        read
        read_FGCAL_TYPE = read_FGCAL_TYPE_value
    End Property

    Property Let write_FGCAL_TYPE(aData)
        set_FGCAL_TYPE = aData
        write
    End Property

    Property Get get_FGCAL_MEAS
        get_FGCAL_MEAS = read_FGCAL_MEAS_value
    End Property

    Property Let set_FGCAL_MEAS(aData)
        write_FGCAL_MEAS_value = aData
        flag_FGCAL_MEAS        = &H1
    End Property

    Property Get read_FGCAL_MEAS
        read
        read_FGCAL_MEAS = read_FGCAL_MEAS_value
    End Property

    Property Let write_FGCAL_MEAS(aData)
        set_FGCAL_MEAS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FGCAL_DONE_value = rightShift(data_low, 15) and &H1
        read_FGCAL_TYPE_value = rightShift(data_low, 8) and &Hf
        FGCAL_MEAS_mask = &H1f
        if data_low > LONG_MAX then
            if FGCAL_MEAS_mask = mask then
                read_FGCAL_MEAS_value = data_low
            else
                read_FGCAL_MEAS_value = (data_low - H8000_0000) and FGCAL_MEAS_mask
            end If
        else
            read_FGCAL_MEAS_value = data_low and FGCAL_MEAS_mask
        end If

    End Sub

    Sub write
        If flag_FGCAL_DONE = &H0 or flag_FGCAL_TYPE = &H0 or flag_FGCAL_MEAS = &H0 Then read
        If flag_FGCAL_DONE = &H0 Then write_FGCAL_DONE_value = get_FGCAL_DONE
        If flag_FGCAL_TYPE = &H0 Then write_FGCAL_TYPE_value = get_FGCAL_TYPE
        If flag_FGCAL_MEAS = &H0 Then write_FGCAL_MEAS_value = get_FGCAL_MEAS

        regValue = leftShift((write_FGCAL_DONE_value and &H1), 15) + leftShift((write_FGCAL_TYPE_value and &Hf), 8) + leftShift((write_FGCAL_MEAS_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FGCAL_DONE_value = rightShift(data_low, 15) and &H1
        read_FGCAL_TYPE_value = rightShift(data_low, 8) and &Hf
        FGCAL_MEAS_mask = &H1f
        if data_low > LONG_MAX then
            if FGCAL_MEAS_mask = mask then
                read_FGCAL_MEAS_value = data_low
            else
                read_FGCAL_MEAS_value = (data_low - H8000_0000) and FGCAL_MEAS_mask
            end If
        else
            read_FGCAL_MEAS_value = data_low and FGCAL_MEAS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FGCAL_DONE_value = &H0
        flag_FGCAL_DONE        = &H0
        write_FGCAL_TYPE_value = &H0
        flag_FGCAL_TYPE        = &H0
        write_FGCAL_MEAS_value = &H0
        flag_FGCAL_MEAS        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln0_stg1_gain_cal_ctl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GAIN_CAL_HALTED                            [15:15]          get_GAIN_CAL_HALTED
''                                                             set_GAIN_CAL_HALTED
''                                                             read_GAIN_CAL_HALTED
''                                                             write_GAIN_CAL_HALTED
''---------------------------------------------------------------------------------
'' NMAX                                       [12:8]           get_NMAX
''                                                             set_NMAX
''                                                             read_NMAX
''                                                             write_NMAX
''---------------------------------------------------------------------------------
'' NLSB                                       [6:2]            get_NLSB
''                                                             set_NLSB
''                                                             read_NLSB
''                                                             write_NLSB
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln0_stg1_gain_cal_ctl_1
    Private write_GAIN_CAL_HALTED_value
    Private read_GAIN_CAL_HALTED_value
    Private flag_GAIN_CAL_HALTED
    Private write_NMAX_value
    Private read_NMAX_value
    Private flag_NMAX
    Private write_NLSB_value
    Private read_NLSB_value
    Private flag_NLSB

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

    Property Get get_GAIN_CAL_HALTED
        get_GAIN_CAL_HALTED = read_GAIN_CAL_HALTED_value
    End Property

    Property Let set_GAIN_CAL_HALTED(aData)
        write_GAIN_CAL_HALTED_value = aData
        flag_GAIN_CAL_HALTED        = &H1
    End Property

    Property Get read_GAIN_CAL_HALTED
        read
        read_GAIN_CAL_HALTED = read_GAIN_CAL_HALTED_value
    End Property

    Property Let write_GAIN_CAL_HALTED(aData)
        set_GAIN_CAL_HALTED = aData
        write
    End Property

    Property Get get_NMAX
        get_NMAX = read_NMAX_value
    End Property

    Property Let set_NMAX(aData)
        write_NMAX_value = aData
        flag_NMAX        = &H1
    End Property

    Property Get read_NMAX
        read
        read_NMAX = read_NMAX_value
    End Property

    Property Let write_NMAX(aData)
        set_NMAX = aData
        write
    End Property

    Property Get get_NLSB
        get_NLSB = read_NLSB_value
    End Property

    Property Let set_NLSB(aData)
        write_NLSB_value = aData
        flag_NLSB        = &H1
    End Property

    Property Get read_NLSB
        read
        read_NLSB = read_NLSB_value
    End Property

    Property Let write_NLSB(aData)
        set_NLSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GAIN_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_NMAX_value = rightShift(data_low, 8) and &H1f
        read_NLSB_value = rightShift(data_low, 2) and &H1f

    End Sub

    Sub write
        If flag_GAIN_CAL_HALTED = &H0 or flag_NMAX = &H0 or flag_NLSB = &H0 Then read
        If flag_GAIN_CAL_HALTED = &H0 Then write_GAIN_CAL_HALTED_value = get_GAIN_CAL_HALTED
        If flag_NMAX = &H0 Then write_NMAX_value = get_NMAX
        If flag_NLSB = &H0 Then write_NLSB_value = get_NLSB

        regValue = leftShift((write_GAIN_CAL_HALTED_value and &H1), 15) + leftShift((write_NMAX_value and &H1f), 8) + leftShift((write_NLSB_value and &H1f), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GAIN_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_NMAX_value = rightShift(data_low, 8) and &H1f
        read_NLSB_value = rightShift(data_low, 2) and &H1f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GAIN_CAL_HALTED_value = &H0
        flag_GAIN_CAL_HALTED        = &H0
        write_NMAX_value = &H0
        flag_NMAX        = &H0
        write_NLSB_value = &H0
        flag_NLSB        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln0_stg1_gain_cal_ctl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DREFCAL0                                   [13:4]           get_DREFCAL0
''                                                             set_DREFCAL0
''                                                             read_DREFCAL0
''                                                             write_DREFCAL0
''---------------------------------------------------------------------------------
'' GAIN_UPDATE_EN                             [1:1]            get_GAIN_UPDATE_EN
''                                                             set_GAIN_UPDATE_EN
''                                                             read_GAIN_UPDATE_EN
''                                                             write_GAIN_UPDATE_EN
''---------------------------------------------------------------------------------
'' GAIN_CAL_EN                                [0:0]            get_GAIN_CAL_EN
''                                                             set_GAIN_CAL_EN
''                                                             read_GAIN_CAL_EN
''                                                             write_GAIN_CAL_EN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln0_stg1_gain_cal_ctl_2
    Private write_DREFCAL0_value
    Private read_DREFCAL0_value
    Private flag_DREFCAL0
    Private write_GAIN_UPDATE_EN_value
    Private read_GAIN_UPDATE_EN_value
    Private flag_GAIN_UPDATE_EN
    Private write_GAIN_CAL_EN_value
    Private read_GAIN_CAL_EN_value
    Private flag_GAIN_CAL_EN

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

    Property Get get_DREFCAL0
        get_DREFCAL0 = read_DREFCAL0_value
    End Property

    Property Let set_DREFCAL0(aData)
        write_DREFCAL0_value = aData
        flag_DREFCAL0        = &H1
    End Property

    Property Get read_DREFCAL0
        read
        read_DREFCAL0 = read_DREFCAL0_value
    End Property

    Property Let write_DREFCAL0(aData)
        set_DREFCAL0 = aData
        write
    End Property

    Property Get get_GAIN_UPDATE_EN
        get_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let set_GAIN_UPDATE_EN(aData)
        write_GAIN_UPDATE_EN_value = aData
        flag_GAIN_UPDATE_EN        = &H1
    End Property

    Property Get read_GAIN_UPDATE_EN
        read
        read_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let write_GAIN_UPDATE_EN(aData)
        set_GAIN_UPDATE_EN = aData
        write
    End Property

    Property Get get_GAIN_CAL_EN
        get_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let set_GAIN_CAL_EN(aData)
        write_GAIN_CAL_EN_value = aData
        flag_GAIN_CAL_EN        = &H1
    End Property

    Property Get read_GAIN_CAL_EN
        read
        read_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let write_GAIN_CAL_EN(aData)
        set_GAIN_CAL_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DREFCAL0_value = rightShift(data_low, 4) and &H3ff
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_EN_mask = mask then
                read_GAIN_CAL_EN_value = data_low
            else
                read_GAIN_CAL_EN_value = (data_low - H8000_0000) and GAIN_CAL_EN_mask
            end If
        else
            read_GAIN_CAL_EN_value = data_low and GAIN_CAL_EN_mask
        end If

    End Sub

    Sub write
        If flag_DREFCAL0 = &H0 or flag_GAIN_UPDATE_EN = &H0 or flag_GAIN_CAL_EN = &H0 Then read
        If flag_DREFCAL0 = &H0 Then write_DREFCAL0_value = get_DREFCAL0
        If flag_GAIN_UPDATE_EN = &H0 Then write_GAIN_UPDATE_EN_value = get_GAIN_UPDATE_EN
        If flag_GAIN_CAL_EN = &H0 Then write_GAIN_CAL_EN_value = get_GAIN_CAL_EN

        regValue = leftShift((write_DREFCAL0_value and &H3ff), 4) + leftShift((write_GAIN_UPDATE_EN_value and &H1), 1) + leftShift((write_GAIN_CAL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DREFCAL0_value = rightShift(data_low, 4) and &H3ff
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_EN_mask = mask then
                read_GAIN_CAL_EN_value = data_low
            else
                read_GAIN_CAL_EN_value = (data_low - H8000_0000) and GAIN_CAL_EN_mask
            end If
        else
            read_GAIN_CAL_EN_value = data_low and GAIN_CAL_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DREFCAL0_value = &H0
        flag_DREFCAL0        = &H0
        write_GAIN_UPDATE_EN_value = &H0
        flag_GAIN_UPDATE_EN        = &H0
        write_GAIN_CAL_EN_value = &H0
        flag_GAIN_CAL_EN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln1_stg1_gain_cal_ctl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GAIN_CAL_HALTED                            [15:15]          get_GAIN_CAL_HALTED
''                                                             set_GAIN_CAL_HALTED
''                                                             read_GAIN_CAL_HALTED
''                                                             write_GAIN_CAL_HALTED
''---------------------------------------------------------------------------------
'' NMAX                                       [12:8]           get_NMAX
''                                                             set_NMAX
''                                                             read_NMAX
''                                                             write_NMAX
''---------------------------------------------------------------------------------
'' NLSB                                       [6:2]            get_NLSB
''                                                             set_NLSB
''                                                             read_NLSB
''                                                             write_NLSB
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln1_stg1_gain_cal_ctl_1
    Private write_GAIN_CAL_HALTED_value
    Private read_GAIN_CAL_HALTED_value
    Private flag_GAIN_CAL_HALTED
    Private write_NMAX_value
    Private read_NMAX_value
    Private flag_NMAX
    Private write_NLSB_value
    Private read_NLSB_value
    Private flag_NLSB

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

    Property Get get_GAIN_CAL_HALTED
        get_GAIN_CAL_HALTED = read_GAIN_CAL_HALTED_value
    End Property

    Property Let set_GAIN_CAL_HALTED(aData)
        write_GAIN_CAL_HALTED_value = aData
        flag_GAIN_CAL_HALTED        = &H1
    End Property

    Property Get read_GAIN_CAL_HALTED
        read
        read_GAIN_CAL_HALTED = read_GAIN_CAL_HALTED_value
    End Property

    Property Let write_GAIN_CAL_HALTED(aData)
        set_GAIN_CAL_HALTED = aData
        write
    End Property

    Property Get get_NMAX
        get_NMAX = read_NMAX_value
    End Property

    Property Let set_NMAX(aData)
        write_NMAX_value = aData
        flag_NMAX        = &H1
    End Property

    Property Get read_NMAX
        read
        read_NMAX = read_NMAX_value
    End Property

    Property Let write_NMAX(aData)
        set_NMAX = aData
        write
    End Property

    Property Get get_NLSB
        get_NLSB = read_NLSB_value
    End Property

    Property Let set_NLSB(aData)
        write_NLSB_value = aData
        flag_NLSB        = &H1
    End Property

    Property Get read_NLSB
        read
        read_NLSB = read_NLSB_value
    End Property

    Property Let write_NLSB(aData)
        set_NLSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GAIN_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_NMAX_value = rightShift(data_low, 8) and &H1f
        read_NLSB_value = rightShift(data_low, 2) and &H1f

    End Sub

    Sub write
        If flag_GAIN_CAL_HALTED = &H0 or flag_NMAX = &H0 or flag_NLSB = &H0 Then read
        If flag_GAIN_CAL_HALTED = &H0 Then write_GAIN_CAL_HALTED_value = get_GAIN_CAL_HALTED
        If flag_NMAX = &H0 Then write_NMAX_value = get_NMAX
        If flag_NLSB = &H0 Then write_NLSB_value = get_NLSB

        regValue = leftShift((write_GAIN_CAL_HALTED_value and &H1), 15) + leftShift((write_NMAX_value and &H1f), 8) + leftShift((write_NLSB_value and &H1f), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GAIN_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_NMAX_value = rightShift(data_low, 8) and &H1f
        read_NLSB_value = rightShift(data_low, 2) and &H1f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GAIN_CAL_HALTED_value = &H0
        flag_GAIN_CAL_HALTED        = &H0
        write_NMAX_value = &H0
        flag_NMAX        = &H0
        write_NLSB_value = &H0
        flag_NLSB        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln1_stg1_gain_cal_ctl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DREFCAL0                                   [13:4]           get_DREFCAL0
''                                                             set_DREFCAL0
''                                                             read_DREFCAL0
''                                                             write_DREFCAL0
''---------------------------------------------------------------------------------
'' GAIN_UPDATE_EN                             [1:1]            get_GAIN_UPDATE_EN
''                                                             set_GAIN_UPDATE_EN
''                                                             read_GAIN_UPDATE_EN
''                                                             write_GAIN_UPDATE_EN
''---------------------------------------------------------------------------------
'' GAIN_CAL_EN                                [0:0]            get_GAIN_CAL_EN
''                                                             set_GAIN_CAL_EN
''                                                             read_GAIN_CAL_EN
''                                                             write_GAIN_CAL_EN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln1_stg1_gain_cal_ctl_2
    Private write_DREFCAL0_value
    Private read_DREFCAL0_value
    Private flag_DREFCAL0
    Private write_GAIN_UPDATE_EN_value
    Private read_GAIN_UPDATE_EN_value
    Private flag_GAIN_UPDATE_EN
    Private write_GAIN_CAL_EN_value
    Private read_GAIN_CAL_EN_value
    Private flag_GAIN_CAL_EN

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

    Property Get get_DREFCAL0
        get_DREFCAL0 = read_DREFCAL0_value
    End Property

    Property Let set_DREFCAL0(aData)
        write_DREFCAL0_value = aData
        flag_DREFCAL0        = &H1
    End Property

    Property Get read_DREFCAL0
        read
        read_DREFCAL0 = read_DREFCAL0_value
    End Property

    Property Let write_DREFCAL0(aData)
        set_DREFCAL0 = aData
        write
    End Property

    Property Get get_GAIN_UPDATE_EN
        get_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let set_GAIN_UPDATE_EN(aData)
        write_GAIN_UPDATE_EN_value = aData
        flag_GAIN_UPDATE_EN        = &H1
    End Property

    Property Get read_GAIN_UPDATE_EN
        read
        read_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let write_GAIN_UPDATE_EN(aData)
        set_GAIN_UPDATE_EN = aData
        write
    End Property

    Property Get get_GAIN_CAL_EN
        get_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let set_GAIN_CAL_EN(aData)
        write_GAIN_CAL_EN_value = aData
        flag_GAIN_CAL_EN        = &H1
    End Property

    Property Get read_GAIN_CAL_EN
        read
        read_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let write_GAIN_CAL_EN(aData)
        set_GAIN_CAL_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DREFCAL0_value = rightShift(data_low, 4) and &H3ff
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_EN_mask = mask then
                read_GAIN_CAL_EN_value = data_low
            else
                read_GAIN_CAL_EN_value = (data_low - H8000_0000) and GAIN_CAL_EN_mask
            end If
        else
            read_GAIN_CAL_EN_value = data_low and GAIN_CAL_EN_mask
        end If

    End Sub

    Sub write
        If flag_DREFCAL0 = &H0 or flag_GAIN_UPDATE_EN = &H0 or flag_GAIN_CAL_EN = &H0 Then read
        If flag_DREFCAL0 = &H0 Then write_DREFCAL0_value = get_DREFCAL0
        If flag_GAIN_UPDATE_EN = &H0 Then write_GAIN_UPDATE_EN_value = get_GAIN_UPDATE_EN
        If flag_GAIN_CAL_EN = &H0 Then write_GAIN_CAL_EN_value = get_GAIN_CAL_EN

        regValue = leftShift((write_DREFCAL0_value and &H3ff), 4) + leftShift((write_GAIN_UPDATE_EN_value and &H1), 1) + leftShift((write_GAIN_CAL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DREFCAL0_value = rightShift(data_low, 4) and &H3ff
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_EN_mask = mask then
                read_GAIN_CAL_EN_value = data_low
            else
                read_GAIN_CAL_EN_value = (data_low - H8000_0000) and GAIN_CAL_EN_mask
            end If
        else
            read_GAIN_CAL_EN_value = data_low and GAIN_CAL_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DREFCAL0_value = &H0
        flag_DREFCAL0        = &H0
        write_GAIN_UPDATE_EN_value = &H0
        flag_GAIN_UPDATE_EN        = &H0
        write_GAIN_CAL_EN_value = &H0
        flag_GAIN_CAL_EN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_gain_cal_integr_ind
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LANE                                       [8:8]            get_LANE
''                                                             set_LANE
''                                                             read_LANE
''                                                             write_LANE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_gain_cal_integr_ind
    Private write_LANE_value
    Private read_LANE_value
    Private flag_LANE

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

    Property Get get_LANE
        get_LANE = read_LANE_value
    End Property

    Property Let set_LANE(aData)
        write_LANE_value = aData
        flag_LANE        = &H1
    End Property

    Property Get read_LANE
        read
        read_LANE = read_LANE_value
    End Property

    Property Let write_LANE(aData)
        set_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_LANE = &H0 Then read
        If flag_LANE = &H0 Then write_LANE_value = get_LANE

        regValue = leftShift((write_LANE_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LANE_value = &H0
        flag_LANE        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_gain_cal_integr_data_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [7:0]            get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_gain_cal_integr_data_hi
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_gain_cal_integr_data_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [15:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_gain_cal_integr_data_lo
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_gain_cal_dg_ind
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DREFCAL_NEGATE                             [15:15]          get_DREFCAL_NEGATE
''                                                             set_DREFCAL_NEGATE
''                                                             read_DREFCAL_NEGATE
''                                                             write_DREFCAL_NEGATE
''---------------------------------------------------------------------------------
'' LANE                                       [8:8]            get_LANE
''                                                             set_LANE
''                                                             read_LANE
''                                                             write_LANE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_gain_cal_dg_ind
    Private write_DREFCAL_NEGATE_value
    Private read_DREFCAL_NEGATE_value
    Private flag_DREFCAL_NEGATE
    Private write_LANE_value
    Private read_LANE_value
    Private flag_LANE

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

    Property Get get_DREFCAL_NEGATE
        get_DREFCAL_NEGATE = read_DREFCAL_NEGATE_value
    End Property

    Property Let set_DREFCAL_NEGATE(aData)
        write_DREFCAL_NEGATE_value = aData
        flag_DREFCAL_NEGATE        = &H1
    End Property

    Property Get read_DREFCAL_NEGATE
        read
        read_DREFCAL_NEGATE = read_DREFCAL_NEGATE_value
    End Property

    Property Let write_DREFCAL_NEGATE(aData)
        set_DREFCAL_NEGATE = aData
        write
    End Property

    Property Get get_LANE
        get_LANE = read_LANE_value
    End Property

    Property Let set_LANE(aData)
        write_LANE_value = aData
        flag_LANE        = &H1
    End Property

    Property Get read_LANE
        read
        read_LANE = read_LANE_value
    End Property

    Property Let write_LANE(aData)
        set_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DREFCAL_NEGATE_value = rightShift(data_low, 15) and &H1
        read_LANE_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_DREFCAL_NEGATE = &H0 or flag_LANE = &H0 Then read
        If flag_DREFCAL_NEGATE = &H0 Then write_DREFCAL_NEGATE_value = get_DREFCAL_NEGATE
        If flag_LANE = &H0 Then write_LANE_value = get_LANE

        regValue = leftShift((write_DREFCAL_NEGATE_value and &H1), 15) + leftShift((write_LANE_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DREFCAL_NEGATE_value = rightShift(data_low, 15) and &H1
        read_LANE_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DREFCAL_NEGATE_value = &H0
        flag_DREFCAL_NEGATE        = &H0
        write_LANE_value = &H0
        flag_LANE        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_gain_cal_dg_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [11:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_gain_cal_dg_data
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln0_offset_cal_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OFFSET_CAL_HALTED                          [15:15]          get_OFFSET_CAL_HALTED
''                                                             set_OFFSET_CAL_HALTED
''                                                             read_OFFSET_CAL_HALTED
''                                                             write_OFFSET_CAL_HALTED
''---------------------------------------------------------------------------------
'' MU                                         [10:8]           get_MU
''                                                             set_MU
''                                                             read_MU
''                                                             write_MU
''---------------------------------------------------------------------------------
'' DOFFSET_EN                                 [4:4]            get_DOFFSET_EN
''                                                             set_DOFFSET_EN
''                                                             read_DOFFSET_EN
''                                                             write_DOFFSET_EN
''---------------------------------------------------------------------------------
'' OFFSET_CAL_EN                              [0:0]            get_OFFSET_CAL_EN
''                                                             set_OFFSET_CAL_EN
''                                                             read_OFFSET_CAL_EN
''                                                             write_OFFSET_CAL_EN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln0_offset_cal_ctl
    Private write_OFFSET_CAL_HALTED_value
    Private read_OFFSET_CAL_HALTED_value
    Private flag_OFFSET_CAL_HALTED
    Private write_MU_value
    Private read_MU_value
    Private flag_MU
    Private write_DOFFSET_EN_value
    Private read_DOFFSET_EN_value
    Private flag_DOFFSET_EN
    Private write_OFFSET_CAL_EN_value
    Private read_OFFSET_CAL_EN_value
    Private flag_OFFSET_CAL_EN

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

    Property Get get_OFFSET_CAL_HALTED
        get_OFFSET_CAL_HALTED = read_OFFSET_CAL_HALTED_value
    End Property

    Property Let set_OFFSET_CAL_HALTED(aData)
        write_OFFSET_CAL_HALTED_value = aData
        flag_OFFSET_CAL_HALTED        = &H1
    End Property

    Property Get read_OFFSET_CAL_HALTED
        read
        read_OFFSET_CAL_HALTED = read_OFFSET_CAL_HALTED_value
    End Property

    Property Let write_OFFSET_CAL_HALTED(aData)
        set_OFFSET_CAL_HALTED = aData
        write
    End Property

    Property Get get_MU
        get_MU = read_MU_value
    End Property

    Property Let set_MU(aData)
        write_MU_value = aData
        flag_MU        = &H1
    End Property

    Property Get read_MU
        read
        read_MU = read_MU_value
    End Property

    Property Let write_MU(aData)
        set_MU = aData
        write
    End Property

    Property Get get_DOFFSET_EN
        get_DOFFSET_EN = read_DOFFSET_EN_value
    End Property

    Property Let set_DOFFSET_EN(aData)
        write_DOFFSET_EN_value = aData
        flag_DOFFSET_EN        = &H1
    End Property

    Property Get read_DOFFSET_EN
        read
        read_DOFFSET_EN = read_DOFFSET_EN_value
    End Property

    Property Let write_DOFFSET_EN(aData)
        set_DOFFSET_EN = aData
        write
    End Property

    Property Get get_OFFSET_CAL_EN
        get_OFFSET_CAL_EN = read_OFFSET_CAL_EN_value
    End Property

    Property Let set_OFFSET_CAL_EN(aData)
        write_OFFSET_CAL_EN_value = aData
        flag_OFFSET_CAL_EN        = &H1
    End Property

    Property Get read_OFFSET_CAL_EN
        read
        read_OFFSET_CAL_EN = read_OFFSET_CAL_EN_value
    End Property

    Property Let write_OFFSET_CAL_EN(aData)
        set_OFFSET_CAL_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OFFSET_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_MU_value = rightShift(data_low, 8) and &H7
        read_DOFFSET_EN_value = rightShift(data_low, 4) and &H1
        OFFSET_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if OFFSET_CAL_EN_mask = mask then
                read_OFFSET_CAL_EN_value = data_low
            else
                read_OFFSET_CAL_EN_value = (data_low - H8000_0000) and OFFSET_CAL_EN_mask
            end If
        else
            read_OFFSET_CAL_EN_value = data_low and OFFSET_CAL_EN_mask
        end If

    End Sub

    Sub write
        If flag_OFFSET_CAL_HALTED = &H0 or flag_MU = &H0 or flag_DOFFSET_EN = &H0 or flag_OFFSET_CAL_EN = &H0 Then read
        If flag_OFFSET_CAL_HALTED = &H0 Then write_OFFSET_CAL_HALTED_value = get_OFFSET_CAL_HALTED
        If flag_MU = &H0 Then write_MU_value = get_MU
        If flag_DOFFSET_EN = &H0 Then write_DOFFSET_EN_value = get_DOFFSET_EN
        If flag_OFFSET_CAL_EN = &H0 Then write_OFFSET_CAL_EN_value = get_OFFSET_CAL_EN

        regValue = leftShift((write_OFFSET_CAL_HALTED_value and &H1), 15) + leftShift((write_MU_value and &H7), 8) + leftShift((write_DOFFSET_EN_value and &H1), 4) + leftShift((write_OFFSET_CAL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OFFSET_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_MU_value = rightShift(data_low, 8) and &H7
        read_DOFFSET_EN_value = rightShift(data_low, 4) and &H1
        OFFSET_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if OFFSET_CAL_EN_mask = mask then
                read_OFFSET_CAL_EN_value = data_low
            else
                read_OFFSET_CAL_EN_value = (data_low - H8000_0000) and OFFSET_CAL_EN_mask
            end If
        else
            read_OFFSET_CAL_EN_value = data_low and OFFSET_CAL_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OFFSET_CAL_HALTED_value = &H0
        flag_OFFSET_CAL_HALTED        = &H0
        write_MU_value = &H0
        flag_MU        = &H0
        write_DOFFSET_EN_value = &H0
        flag_DOFFSET_EN        = &H0
        write_OFFSET_CAL_EN_value = &H0
        flag_OFFSET_CAL_EN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln1_offset_cal_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OFFSET_CAL_HALTED                          [15:15]          get_OFFSET_CAL_HALTED
''                                                             set_OFFSET_CAL_HALTED
''                                                             read_OFFSET_CAL_HALTED
''                                                             write_OFFSET_CAL_HALTED
''---------------------------------------------------------------------------------
'' MU                                         [10:8]           get_MU
''                                                             set_MU
''                                                             read_MU
''                                                             write_MU
''---------------------------------------------------------------------------------
'' DOFFSET_EN                                 [4:4]            get_DOFFSET_EN
''                                                             set_DOFFSET_EN
''                                                             read_DOFFSET_EN
''                                                             write_DOFFSET_EN
''---------------------------------------------------------------------------------
'' OFFSET_CAL_EN                              [0:0]            get_OFFSET_CAL_EN
''                                                             set_OFFSET_CAL_EN
''                                                             read_OFFSET_CAL_EN
''                                                             write_OFFSET_CAL_EN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln1_offset_cal_ctl
    Private write_OFFSET_CAL_HALTED_value
    Private read_OFFSET_CAL_HALTED_value
    Private flag_OFFSET_CAL_HALTED
    Private write_MU_value
    Private read_MU_value
    Private flag_MU
    Private write_DOFFSET_EN_value
    Private read_DOFFSET_EN_value
    Private flag_DOFFSET_EN
    Private write_OFFSET_CAL_EN_value
    Private read_OFFSET_CAL_EN_value
    Private flag_OFFSET_CAL_EN

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

    Property Get get_OFFSET_CAL_HALTED
        get_OFFSET_CAL_HALTED = read_OFFSET_CAL_HALTED_value
    End Property

    Property Let set_OFFSET_CAL_HALTED(aData)
        write_OFFSET_CAL_HALTED_value = aData
        flag_OFFSET_CAL_HALTED        = &H1
    End Property

    Property Get read_OFFSET_CAL_HALTED
        read
        read_OFFSET_CAL_HALTED = read_OFFSET_CAL_HALTED_value
    End Property

    Property Let write_OFFSET_CAL_HALTED(aData)
        set_OFFSET_CAL_HALTED = aData
        write
    End Property

    Property Get get_MU
        get_MU = read_MU_value
    End Property

    Property Let set_MU(aData)
        write_MU_value = aData
        flag_MU        = &H1
    End Property

    Property Get read_MU
        read
        read_MU = read_MU_value
    End Property

    Property Let write_MU(aData)
        set_MU = aData
        write
    End Property

    Property Get get_DOFFSET_EN
        get_DOFFSET_EN = read_DOFFSET_EN_value
    End Property

    Property Let set_DOFFSET_EN(aData)
        write_DOFFSET_EN_value = aData
        flag_DOFFSET_EN        = &H1
    End Property

    Property Get read_DOFFSET_EN
        read
        read_DOFFSET_EN = read_DOFFSET_EN_value
    End Property

    Property Let write_DOFFSET_EN(aData)
        set_DOFFSET_EN = aData
        write
    End Property

    Property Get get_OFFSET_CAL_EN
        get_OFFSET_CAL_EN = read_OFFSET_CAL_EN_value
    End Property

    Property Let set_OFFSET_CAL_EN(aData)
        write_OFFSET_CAL_EN_value = aData
        flag_OFFSET_CAL_EN        = &H1
    End Property

    Property Get read_OFFSET_CAL_EN
        read
        read_OFFSET_CAL_EN = read_OFFSET_CAL_EN_value
    End Property

    Property Let write_OFFSET_CAL_EN(aData)
        set_OFFSET_CAL_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OFFSET_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_MU_value = rightShift(data_low, 8) and &H7
        read_DOFFSET_EN_value = rightShift(data_low, 4) and &H1
        OFFSET_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if OFFSET_CAL_EN_mask = mask then
                read_OFFSET_CAL_EN_value = data_low
            else
                read_OFFSET_CAL_EN_value = (data_low - H8000_0000) and OFFSET_CAL_EN_mask
            end If
        else
            read_OFFSET_CAL_EN_value = data_low and OFFSET_CAL_EN_mask
        end If

    End Sub

    Sub write
        If flag_OFFSET_CAL_HALTED = &H0 or flag_MU = &H0 or flag_DOFFSET_EN = &H0 or flag_OFFSET_CAL_EN = &H0 Then read
        If flag_OFFSET_CAL_HALTED = &H0 Then write_OFFSET_CAL_HALTED_value = get_OFFSET_CAL_HALTED
        If flag_MU = &H0 Then write_MU_value = get_MU
        If flag_DOFFSET_EN = &H0 Then write_DOFFSET_EN_value = get_DOFFSET_EN
        If flag_OFFSET_CAL_EN = &H0 Then write_OFFSET_CAL_EN_value = get_OFFSET_CAL_EN

        regValue = leftShift((write_OFFSET_CAL_HALTED_value and &H1), 15) + leftShift((write_MU_value and &H7), 8) + leftShift((write_DOFFSET_EN_value and &H1), 4) + leftShift((write_OFFSET_CAL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_OFFSET_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_MU_value = rightShift(data_low, 8) and &H7
        read_DOFFSET_EN_value = rightShift(data_low, 4) and &H1
        OFFSET_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if OFFSET_CAL_EN_mask = mask then
                read_OFFSET_CAL_EN_value = data_low
            else
                read_OFFSET_CAL_EN_value = (data_low - H8000_0000) and OFFSET_CAL_EN_mask
            end If
        else
            read_OFFSET_CAL_EN_value = data_low and OFFSET_CAL_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OFFSET_CAL_HALTED_value = &H0
        flag_OFFSET_CAL_HALTED        = &H0
        write_MU_value = &H0
        flag_MU        = &H0
        write_DOFFSET_EN_value = &H0
        flag_DOFFSET_EN        = &H0
        write_OFFSET_CAL_EN_value = &H0
        flag_OFFSET_CAL_EN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_offset_cal_integr_ind
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LANE                                       [8:8]            get_LANE
''                                                             set_LANE
''                                                             read_LANE
''                                                             write_LANE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_offset_cal_integr_ind
    Private write_LANE_value
    Private read_LANE_value
    Private flag_LANE

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

    Property Get get_LANE
        get_LANE = read_LANE_value
    End Property

    Property Let set_LANE(aData)
        write_LANE_value = aData
        flag_LANE        = &H1
    End Property

    Property Get read_LANE
        read
        read_LANE = read_LANE_value
    End Property

    Property Let write_LANE(aData)
        set_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_LANE = &H0 Then read
        If flag_LANE = &H0 Then write_LANE_value = get_LANE

        regValue = leftShift((write_LANE_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LANE_value = &H0
        flag_LANE        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_offset_cal_integr_data_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [10:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_offset_cal_integr_data_hi
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &H7ff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &H7ff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_offset_cal_integr_data_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [15:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_offset_cal_integr_data_lo
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_offset_cal_doffset_ind
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LANE                                       [8:8]            get_LANE
''                                                             set_LANE
''                                                             read_LANE
''                                                             write_LANE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_offset_cal_doffset_ind
    Private write_LANE_value
    Private read_LANE_value
    Private flag_LANE

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

    Property Get get_LANE
        get_LANE = read_LANE_value
    End Property

    Property Let set_LANE(aData)
        write_LANE_value = aData
        flag_LANE        = &H1
    End Property

    Property Get read_LANE
        read
        read_LANE = read_LANE_value
    End Property

    Property Let write_LANE(aData)
        set_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_LANE = &H0 Then read
        If flag_LANE = &H0 Then write_LANE_value = get_LANE

        regValue = leftShift((write_LANE_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LANE_value = &H0
        flag_LANE        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_offset_cal_doffset_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [11:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_offset_cal_doffset_data
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hfff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_lgain_cal_ctl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GAIN_CAL_HALTED                            [15:15]          get_GAIN_CAL_HALTED
''                                                             set_GAIN_CAL_HALTED
''                                                             read_GAIN_CAL_HALTED
''                                                             write_GAIN_CAL_HALTED
''---------------------------------------------------------------------------------
'' NMAX                                       [12:8]           get_NMAX
''                                                             set_NMAX
''                                                             read_NMAX
''                                                             write_NMAX
''---------------------------------------------------------------------------------
'' MU                                         [5:2]            get_MU
''                                                             set_MU
''                                                             read_MU
''                                                             write_MU
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_lgain_cal_ctl_1
    Private write_GAIN_CAL_HALTED_value
    Private read_GAIN_CAL_HALTED_value
    Private flag_GAIN_CAL_HALTED
    Private write_NMAX_value
    Private read_NMAX_value
    Private flag_NMAX
    Private write_MU_value
    Private read_MU_value
    Private flag_MU

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

    Property Get get_GAIN_CAL_HALTED
        get_GAIN_CAL_HALTED = read_GAIN_CAL_HALTED_value
    End Property

    Property Let set_GAIN_CAL_HALTED(aData)
        write_GAIN_CAL_HALTED_value = aData
        flag_GAIN_CAL_HALTED        = &H1
    End Property

    Property Get read_GAIN_CAL_HALTED
        read
        read_GAIN_CAL_HALTED = read_GAIN_CAL_HALTED_value
    End Property

    Property Let write_GAIN_CAL_HALTED(aData)
        set_GAIN_CAL_HALTED = aData
        write
    End Property

    Property Get get_NMAX
        get_NMAX = read_NMAX_value
    End Property

    Property Let set_NMAX(aData)
        write_NMAX_value = aData
        flag_NMAX        = &H1
    End Property

    Property Get read_NMAX
        read
        read_NMAX = read_NMAX_value
    End Property

    Property Let write_NMAX(aData)
        set_NMAX = aData
        write
    End Property

    Property Get get_MU
        get_MU = read_MU_value
    End Property

    Property Let set_MU(aData)
        write_MU_value = aData
        flag_MU        = &H1
    End Property

    Property Get read_MU
        read
        read_MU = read_MU_value
    End Property

    Property Let write_MU(aData)
        set_MU = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GAIN_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_NMAX_value = rightShift(data_low, 8) and &H1f
        read_MU_value = rightShift(data_low, 2) and &Hf

    End Sub

    Sub write
        If flag_GAIN_CAL_HALTED = &H0 or flag_NMAX = &H0 or flag_MU = &H0 Then read
        If flag_GAIN_CAL_HALTED = &H0 Then write_GAIN_CAL_HALTED_value = get_GAIN_CAL_HALTED
        If flag_NMAX = &H0 Then write_NMAX_value = get_NMAX
        If flag_MU = &H0 Then write_MU_value = get_MU

        regValue = leftShift((write_GAIN_CAL_HALTED_value and &H1), 15) + leftShift((write_NMAX_value and &H1f), 8) + leftShift((write_MU_value and &Hf), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GAIN_CAL_HALTED_value = rightShift(data_low, 15) and &H1
        read_NMAX_value = rightShift(data_low, 8) and &H1f
        read_MU_value = rightShift(data_low, 2) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GAIN_CAL_HALTED_value = &H0
        flag_GAIN_CAL_HALTED        = &H0
        write_NMAX_value = &H0
        flag_NMAX        = &H0
        write_MU_value = &H0
        flag_MU        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_lgain_cal_ctl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MODE                                       [5:4]            get_MODE
''                                                             set_MODE
''                                                             read_MODE
''                                                             write_MODE
''---------------------------------------------------------------------------------
'' GAIN_UPDATE_EN                             [1:1]            get_GAIN_UPDATE_EN
''                                                             set_GAIN_UPDATE_EN
''                                                             read_GAIN_UPDATE_EN
''                                                             write_GAIN_UPDATE_EN
''---------------------------------------------------------------------------------
'' GAIN_CAL_EN                                [0:0]            get_GAIN_CAL_EN
''                                                             set_GAIN_CAL_EN
''                                                             read_GAIN_CAL_EN
''                                                             write_GAIN_CAL_EN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_lgain_cal_ctl_2
    Private write_MODE_value
    Private read_MODE_value
    Private flag_MODE
    Private write_GAIN_UPDATE_EN_value
    Private read_GAIN_UPDATE_EN_value
    Private flag_GAIN_UPDATE_EN
    Private write_GAIN_CAL_EN_value
    Private read_GAIN_CAL_EN_value
    Private flag_GAIN_CAL_EN

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

    Property Get get_MODE
        get_MODE = read_MODE_value
    End Property

    Property Let set_MODE(aData)
        write_MODE_value = aData
        flag_MODE        = &H1
    End Property

    Property Get read_MODE
        read
        read_MODE = read_MODE_value
    End Property

    Property Let write_MODE(aData)
        set_MODE = aData
        write
    End Property

    Property Get get_GAIN_UPDATE_EN
        get_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let set_GAIN_UPDATE_EN(aData)
        write_GAIN_UPDATE_EN_value = aData
        flag_GAIN_UPDATE_EN        = &H1
    End Property

    Property Get read_GAIN_UPDATE_EN
        read
        read_GAIN_UPDATE_EN = read_GAIN_UPDATE_EN_value
    End Property

    Property Let write_GAIN_UPDATE_EN(aData)
        set_GAIN_UPDATE_EN = aData
        write
    End Property

    Property Get get_GAIN_CAL_EN
        get_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let set_GAIN_CAL_EN(aData)
        write_GAIN_CAL_EN_value = aData
        flag_GAIN_CAL_EN        = &H1
    End Property

    Property Get read_GAIN_CAL_EN
        read
        read_GAIN_CAL_EN = read_GAIN_CAL_EN_value
    End Property

    Property Let write_GAIN_CAL_EN(aData)
        set_GAIN_CAL_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MODE_value = rightShift(data_low, 4) and &H3
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_EN_mask = mask then
                read_GAIN_CAL_EN_value = data_low
            else
                read_GAIN_CAL_EN_value = (data_low - H8000_0000) and GAIN_CAL_EN_mask
            end If
        else
            read_GAIN_CAL_EN_value = data_low and GAIN_CAL_EN_mask
        end If

    End Sub

    Sub write
        If flag_MODE = &H0 or flag_GAIN_UPDATE_EN = &H0 or flag_GAIN_CAL_EN = &H0 Then read
        If flag_MODE = &H0 Then write_MODE_value = get_MODE
        If flag_GAIN_UPDATE_EN = &H0 Then write_GAIN_UPDATE_EN_value = get_GAIN_UPDATE_EN
        If flag_GAIN_CAL_EN = &H0 Then write_GAIN_CAL_EN_value = get_GAIN_CAL_EN

        regValue = leftShift((write_MODE_value and &H3), 4) + leftShift((write_GAIN_UPDATE_EN_value and &H1), 1) + leftShift((write_GAIN_CAL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MODE_value = rightShift(data_low, 4) and &H3
        read_GAIN_UPDATE_EN_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_EN_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_EN_mask = mask then
                read_GAIN_CAL_EN_value = data_low
            else
                read_GAIN_CAL_EN_value = (data_low - H8000_0000) and GAIN_CAL_EN_mask
            end If
        else
            read_GAIN_CAL_EN_value = data_low and GAIN_CAL_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MODE_value = &H0
        flag_MODE        = &H0
        write_GAIN_UPDATE_EN_value = &H0
        flag_GAIN_UPDATE_EN        = &H0
        write_GAIN_CAL_EN_value = &H0
        flag_GAIN_CAL_EN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln0_magn_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAGN                                       [12:0]           get_MAGN
''                                                             set_MAGN
''                                                             read_MAGN
''                                                             write_MAGN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln0_magn_ctl
    Private write_MAGN_value
    Private read_MAGN_value
    Private flag_MAGN

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

    Property Get get_MAGN
        get_MAGN = read_MAGN_value
    End Property

    Property Let set_MAGN(aData)
        write_MAGN_value = aData
        flag_MAGN        = &H1
    End Property

    Property Get read_MAGN
        read
        read_MAGN = read_MAGN_value
    End Property

    Property Let write_MAGN(aData)
        set_MAGN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAGN_mask = &H1fff
        if data_low > LONG_MAX then
            if MAGN_mask = mask then
                read_MAGN_value = data_low
            else
                read_MAGN_value = (data_low - H8000_0000) and MAGN_mask
            end If
        else
            read_MAGN_value = data_low and MAGN_mask
        end If

    End Sub

    Sub write
        If flag_MAGN = &H0 Then read
        If flag_MAGN = &H0 Then write_MAGN_value = get_MAGN

        regValue = leftShift((write_MAGN_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAGN_mask = &H1fff
        if data_low > LONG_MAX then
            if MAGN_mask = mask then
                read_MAGN_value = data_low
            else
                read_MAGN_value = (data_low - H8000_0000) and MAGN_mask
            end If
        else
            read_MAGN_value = data_low and MAGN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAGN_value = &H0
        flag_MAGN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_ln1_magn_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAGN                                       [12:0]           get_MAGN
''                                                             set_MAGN
''                                                             read_MAGN
''                                                             write_MAGN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_ln1_magn_ctl
    Private write_MAGN_value
    Private read_MAGN_value
    Private flag_MAGN

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

    Property Get get_MAGN
        get_MAGN = read_MAGN_value
    End Property

    Property Let set_MAGN(aData)
        write_MAGN_value = aData
        flag_MAGN        = &H1
    End Property

    Property Get read_MAGN
        read
        read_MAGN = read_MAGN_value
    End Property

    Property Let write_MAGN(aData)
        set_MAGN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAGN_mask = &H1fff
        if data_low > LONG_MAX then
            if MAGN_mask = mask then
                read_MAGN_value = data_low
            else
                read_MAGN_value = (data_low - H8000_0000) and MAGN_mask
            end If
        else
            read_MAGN_value = data_low and MAGN_mask
        end If

    End Sub

    Sub write
        If flag_MAGN = &H0 Then read
        If flag_MAGN = &H0 Then write_MAGN_value = get_MAGN

        regValue = leftShift((write_MAGN_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAGN_mask = &H1fff
        if data_low > LONG_MAX then
            if MAGN_mask = mask then
                read_MAGN_value = data_low
            else
                read_MAGN_value = (data_low - H8000_0000) and MAGN_mask
            end If
        else
            read_MAGN_value = data_low and MAGN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAGN_value = &H0
        flag_MAGN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_lgain_cal_magn_ind
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LANE                                       [8:8]            get_LANE
''                                                             set_LANE
''                                                             read_LANE
''                                                             write_LANE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_lgain_cal_magn_ind
    Private write_LANE_value
    Private read_LANE_value
    Private flag_LANE

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

    Property Get get_LANE
        get_LANE = read_LANE_value
    End Property

    Property Let set_LANE(aData)
        write_LANE_value = aData
        flag_LANE        = &H1
    End Property

    Property Get read_LANE
        read
        read_LANE = read_LANE_value
    End Property

    Property Let write_LANE(aData)
        set_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_LANE = &H0 Then read
        If flag_LANE = &H0 Then write_LANE_value = get_LANE

        regValue = leftShift((write_LANE_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LANE_value = &H0
        flag_LANE        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_lgain_cal_magn_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [12:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_lgain_cal_magn_data
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &H1fff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &H1fff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_lgain_cal_dg_accum_ind
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LANE                                       [8:8]            get_LANE
''                                                             set_LANE
''                                                             read_LANE
''                                                             write_LANE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_lgain_cal_dg_accum_ind
    Private write_LANE_value
    Private read_LANE_value
    Private flag_LANE

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

    Property Get get_LANE
        get_LANE = read_LANE_value
    End Property

    Property Let set_LANE(aData)
        write_LANE_value = aData
        flag_LANE        = &H1
    End Property

    Property Get read_LANE
        read
        read_LANE = read_LANE_value
    End Property

    Property Let write_LANE(aData)
        set_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_LANE = &H0 Then read
        If flag_LANE = &H0 Then write_LANE_value = get_LANE

        regValue = leftShift((write_LANE_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LANE_value = &H0
        flag_LANE        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_lgain_cal_dg_accum_data_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [6:0]            get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_lgain_cal_dg_accum_data_hi
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &H7f
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &H7f
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_lgain_cal_dg_accum_data_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA                                       [15:0]           get_DATA
''                                                             set_DATA
''                                                             read_DATA
''                                                             write_DATA
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_lgain_cal_dg_accum_data_lo
    Private write_DATA_value
    Private read_DATA_value
    Private flag_DATA

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

    Property Get get_DATA
        get_DATA = read_DATA_value
    End Property

    Property Let set_DATA(aData)
        write_DATA_value = aData
        flag_DATA        = &H1
    End Property

    Property Get read_DATA
        read
        read_DATA = read_DATA_value
    End Property

    Property Let write_DATA(aData)
        set_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

    End Sub

    Sub write
        If flag_DATA = &H0 Then read
        If flag_DATA = &H0 Then write_DATA_value = get_DATA

        regValue = leftShift((write_DATA_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_mask = mask then
                read_DATA_value = data_low
            else
                read_DATA_value = (data_low - H8000_0000) and DATA_mask
            end If
        else
            read_DATA_value = data_low and DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_value = &H0
        flag_DATA        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_saturation_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADC_DOUT_SAT                               [9:9]            get_ADC_DOUT_SAT
''                                                             set_ADC_DOUT_SAT
''                                                             read_ADC_DOUT_SAT
''                                                             write_ADC_DOUT_SAT
''---------------------------------------------------------------------------------
'' LGC_dG_SAT                                 [8:8]            get_LGC_dG_SAT
''                                                             set_LGC_dG_SAT
''                                                             read_LGC_dG_SAT
''                                                             write_LGC_dG_SAT
''---------------------------------------------------------------------------------
'' LGC_INTEGR_SAT                             [7:7]            get_LGC_INTEGR_SAT
''                                                             set_LGC_INTEGR_SAT
''                                                             read_LGC_INTEGR_SAT
''                                                             write_LGC_INTEGR_SAT
''---------------------------------------------------------------------------------
'' DOUT_NODC_SAT                              [6:6]            get_DOUT_NODC_SAT
''                                                             set_DOUT_NODC_SAT
''                                                             read_DOUT_NODC_SAT
''                                                             write_DOUT_NODC_SAT
''---------------------------------------------------------------------------------
'' LOC_INTEGR_SAT                             [5:5]            get_LOC_INTEGR_SAT
''                                                             set_LOC_INTEGR_SAT
''                                                             read_LOC_INTEGR_SAT
''                                                             write_LOC_INTEGR_SAT
''---------------------------------------------------------------------------------
'' INTRA_DOUT_SAT                             [4:4]            get_INTRA_DOUT_SAT
''                                                             set_INTRA_DOUT_SAT
''                                                             read_INTRA_DOUT_SAT
''                                                             write_INTRA_DOUT_SAT
''---------------------------------------------------------------------------------
'' STAGE_DOUT_SAT                             [3:3]            get_STAGE_DOUT_SAT
''                                                             set_STAGE_DOUT_SAT
''                                                             read_STAGE_DOUT_SAT
''                                                             write_STAGE_DOUT_SAT
''---------------------------------------------------------------------------------
'' DREFCAL_SAT                                [2:2]            get_DREFCAL_SAT
''                                                             set_DREFCAL_SAT
''                                                             read_DREFCAL_SAT
''                                                             write_DREFCAL_SAT
''---------------------------------------------------------------------------------
'' GAIN_CAL_DG_SAT                            [1:1]            get_GAIN_CAL_DG_SAT
''                                                             set_GAIN_CAL_DG_SAT
''                                                             read_GAIN_CAL_DG_SAT
''                                                             write_GAIN_CAL_DG_SAT
''---------------------------------------------------------------------------------
'' GAIN_CAL_INTEGR_SAT                        [0:0]            get_GAIN_CAL_INTEGR_SAT
''                                                             set_GAIN_CAL_INTEGR_SAT
''                                                             read_GAIN_CAL_INTEGR_SAT
''                                                             write_GAIN_CAL_INTEGR_SAT
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_saturation_status
    Private write_ADC_DOUT_SAT_value
    Private read_ADC_DOUT_SAT_value
    Private flag_ADC_DOUT_SAT
    Private write_LGC_dG_SAT_value
    Private read_LGC_dG_SAT_value
    Private flag_LGC_dG_SAT
    Private write_LGC_INTEGR_SAT_value
    Private read_LGC_INTEGR_SAT_value
    Private flag_LGC_INTEGR_SAT
    Private write_DOUT_NODC_SAT_value
    Private read_DOUT_NODC_SAT_value
    Private flag_DOUT_NODC_SAT
    Private write_LOC_INTEGR_SAT_value
    Private read_LOC_INTEGR_SAT_value
    Private flag_LOC_INTEGR_SAT
    Private write_INTRA_DOUT_SAT_value
    Private read_INTRA_DOUT_SAT_value
    Private flag_INTRA_DOUT_SAT
    Private write_STAGE_DOUT_SAT_value
    Private read_STAGE_DOUT_SAT_value
    Private flag_STAGE_DOUT_SAT
    Private write_DREFCAL_SAT_value
    Private read_DREFCAL_SAT_value
    Private flag_DREFCAL_SAT
    Private write_GAIN_CAL_DG_SAT_value
    Private read_GAIN_CAL_DG_SAT_value
    Private flag_GAIN_CAL_DG_SAT
    Private write_GAIN_CAL_INTEGR_SAT_value
    Private read_GAIN_CAL_INTEGR_SAT_value
    Private flag_GAIN_CAL_INTEGR_SAT

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

    Property Get get_ADC_DOUT_SAT
        get_ADC_DOUT_SAT = read_ADC_DOUT_SAT_value
    End Property

    Property Let set_ADC_DOUT_SAT(aData)
        write_ADC_DOUT_SAT_value = aData
        flag_ADC_DOUT_SAT        = &H1
    End Property

    Property Get read_ADC_DOUT_SAT
        read
        read_ADC_DOUT_SAT = read_ADC_DOUT_SAT_value
    End Property

    Property Let write_ADC_DOUT_SAT(aData)
        set_ADC_DOUT_SAT = aData
        write
    End Property

    Property Get get_LGC_dG_SAT
        get_LGC_dG_SAT = read_LGC_dG_SAT_value
    End Property

    Property Let set_LGC_dG_SAT(aData)
        write_LGC_dG_SAT_value = aData
        flag_LGC_dG_SAT        = &H1
    End Property

    Property Get read_LGC_dG_SAT
        read
        read_LGC_dG_SAT = read_LGC_dG_SAT_value
    End Property

    Property Let write_LGC_dG_SAT(aData)
        set_LGC_dG_SAT = aData
        write
    End Property

    Property Get get_LGC_INTEGR_SAT
        get_LGC_INTEGR_SAT = read_LGC_INTEGR_SAT_value
    End Property

    Property Let set_LGC_INTEGR_SAT(aData)
        write_LGC_INTEGR_SAT_value = aData
        flag_LGC_INTEGR_SAT        = &H1
    End Property

    Property Get read_LGC_INTEGR_SAT
        read
        read_LGC_INTEGR_SAT = read_LGC_INTEGR_SAT_value
    End Property

    Property Let write_LGC_INTEGR_SAT(aData)
        set_LGC_INTEGR_SAT = aData
        write
    End Property

    Property Get get_DOUT_NODC_SAT
        get_DOUT_NODC_SAT = read_DOUT_NODC_SAT_value
    End Property

    Property Let set_DOUT_NODC_SAT(aData)
        write_DOUT_NODC_SAT_value = aData
        flag_DOUT_NODC_SAT        = &H1
    End Property

    Property Get read_DOUT_NODC_SAT
        read
        read_DOUT_NODC_SAT = read_DOUT_NODC_SAT_value
    End Property

    Property Let write_DOUT_NODC_SAT(aData)
        set_DOUT_NODC_SAT = aData
        write
    End Property

    Property Get get_LOC_INTEGR_SAT
        get_LOC_INTEGR_SAT = read_LOC_INTEGR_SAT_value
    End Property

    Property Let set_LOC_INTEGR_SAT(aData)
        write_LOC_INTEGR_SAT_value = aData
        flag_LOC_INTEGR_SAT        = &H1
    End Property

    Property Get read_LOC_INTEGR_SAT
        read
        read_LOC_INTEGR_SAT = read_LOC_INTEGR_SAT_value
    End Property

    Property Let write_LOC_INTEGR_SAT(aData)
        set_LOC_INTEGR_SAT = aData
        write
    End Property

    Property Get get_INTRA_DOUT_SAT
        get_INTRA_DOUT_SAT = read_INTRA_DOUT_SAT_value
    End Property

    Property Let set_INTRA_DOUT_SAT(aData)
        write_INTRA_DOUT_SAT_value = aData
        flag_INTRA_DOUT_SAT        = &H1
    End Property

    Property Get read_INTRA_DOUT_SAT
        read
        read_INTRA_DOUT_SAT = read_INTRA_DOUT_SAT_value
    End Property

    Property Let write_INTRA_DOUT_SAT(aData)
        set_INTRA_DOUT_SAT = aData
        write
    End Property

    Property Get get_STAGE_DOUT_SAT
        get_STAGE_DOUT_SAT = read_STAGE_DOUT_SAT_value
    End Property

    Property Let set_STAGE_DOUT_SAT(aData)
        write_STAGE_DOUT_SAT_value = aData
        flag_STAGE_DOUT_SAT        = &H1
    End Property

    Property Get read_STAGE_DOUT_SAT
        read
        read_STAGE_DOUT_SAT = read_STAGE_DOUT_SAT_value
    End Property

    Property Let write_STAGE_DOUT_SAT(aData)
        set_STAGE_DOUT_SAT = aData
        write
    End Property

    Property Get get_DREFCAL_SAT
        get_DREFCAL_SAT = read_DREFCAL_SAT_value
    End Property

    Property Let set_DREFCAL_SAT(aData)
        write_DREFCAL_SAT_value = aData
        flag_DREFCAL_SAT        = &H1
    End Property

    Property Get read_DREFCAL_SAT
        read
        read_DREFCAL_SAT = read_DREFCAL_SAT_value
    End Property

    Property Let write_DREFCAL_SAT(aData)
        set_DREFCAL_SAT = aData
        write
    End Property

    Property Get get_GAIN_CAL_DG_SAT
        get_GAIN_CAL_DG_SAT = read_GAIN_CAL_DG_SAT_value
    End Property

    Property Let set_GAIN_CAL_DG_SAT(aData)
        write_GAIN_CAL_DG_SAT_value = aData
        flag_GAIN_CAL_DG_SAT        = &H1
    End Property

    Property Get read_GAIN_CAL_DG_SAT
        read
        read_GAIN_CAL_DG_SAT = read_GAIN_CAL_DG_SAT_value
    End Property

    Property Let write_GAIN_CAL_DG_SAT(aData)
        set_GAIN_CAL_DG_SAT = aData
        write
    End Property

    Property Get get_GAIN_CAL_INTEGR_SAT
        get_GAIN_CAL_INTEGR_SAT = read_GAIN_CAL_INTEGR_SAT_value
    End Property

    Property Let set_GAIN_CAL_INTEGR_SAT(aData)
        write_GAIN_CAL_INTEGR_SAT_value = aData
        flag_GAIN_CAL_INTEGR_SAT        = &H1
    End Property

    Property Get read_GAIN_CAL_INTEGR_SAT
        read
        read_GAIN_CAL_INTEGR_SAT = read_GAIN_CAL_INTEGR_SAT_value
    End Property

    Property Let write_GAIN_CAL_INTEGR_SAT(aData)
        set_GAIN_CAL_INTEGR_SAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ADC_DOUT_SAT_value = rightShift(data_low, 9) and &H1
        read_LGC_dG_SAT_value = rightShift(data_low, 8) and &H1
        read_LGC_INTEGR_SAT_value = rightShift(data_low, 7) and &H1
        read_DOUT_NODC_SAT_value = rightShift(data_low, 6) and &H1
        read_LOC_INTEGR_SAT_value = rightShift(data_low, 5) and &H1
        read_INTRA_DOUT_SAT_value = rightShift(data_low, 4) and &H1
        read_STAGE_DOUT_SAT_value = rightShift(data_low, 3) and &H1
        read_DREFCAL_SAT_value = rightShift(data_low, 2) and &H1
        read_GAIN_CAL_DG_SAT_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_INTEGR_SAT_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_INTEGR_SAT_mask = mask then
                read_GAIN_CAL_INTEGR_SAT_value = data_low
            else
                read_GAIN_CAL_INTEGR_SAT_value = (data_low - H8000_0000) and GAIN_CAL_INTEGR_SAT_mask
            end If
        else
            read_GAIN_CAL_INTEGR_SAT_value = data_low and GAIN_CAL_INTEGR_SAT_mask
        end If

    End Sub

    Sub write
        If flag_ADC_DOUT_SAT = &H0 or flag_LGC_dG_SAT = &H0 or flag_LGC_INTEGR_SAT = &H0 or flag_DOUT_NODC_SAT = &H0 or flag_LOC_INTEGR_SAT = &H0 or flag_INTRA_DOUT_SAT = &H0 or flag_STAGE_DOUT_SAT = &H0 or flag_DREFCAL_SAT = &H0 or flag_GAIN_CAL_DG_SAT = &H0 or flag_GAIN_CAL_INTEGR_SAT = &H0 Then read
        If flag_ADC_DOUT_SAT = &H0 Then write_ADC_DOUT_SAT_value = get_ADC_DOUT_SAT
        If flag_LGC_dG_SAT = &H0 Then write_LGC_dG_SAT_value = get_LGC_dG_SAT
        If flag_LGC_INTEGR_SAT = &H0 Then write_LGC_INTEGR_SAT_value = get_LGC_INTEGR_SAT
        If flag_DOUT_NODC_SAT = &H0 Then write_DOUT_NODC_SAT_value = get_DOUT_NODC_SAT
        If flag_LOC_INTEGR_SAT = &H0 Then write_LOC_INTEGR_SAT_value = get_LOC_INTEGR_SAT
        If flag_INTRA_DOUT_SAT = &H0 Then write_INTRA_DOUT_SAT_value = get_INTRA_DOUT_SAT
        If flag_STAGE_DOUT_SAT = &H0 Then write_STAGE_DOUT_SAT_value = get_STAGE_DOUT_SAT
        If flag_DREFCAL_SAT = &H0 Then write_DREFCAL_SAT_value = get_DREFCAL_SAT
        If flag_GAIN_CAL_DG_SAT = &H0 Then write_GAIN_CAL_DG_SAT_value = get_GAIN_CAL_DG_SAT
        If flag_GAIN_CAL_INTEGR_SAT = &H0 Then write_GAIN_CAL_INTEGR_SAT_value = get_GAIN_CAL_INTEGR_SAT

        regValue = leftShift((write_ADC_DOUT_SAT_value and &H1), 9) + leftShift((write_LGC_dG_SAT_value and &H1), 8) + leftShift((write_LGC_INTEGR_SAT_value and &H1), 7) + leftShift((write_DOUT_NODC_SAT_value and &H1), 6) + leftShift((write_LOC_INTEGR_SAT_value and &H1), 5) + leftShift((write_INTRA_DOUT_SAT_value and &H1), 4) + leftShift((write_STAGE_DOUT_SAT_value and &H1), 3) + leftShift((write_DREFCAL_SAT_value and &H1), 2) + leftShift((write_GAIN_CAL_DG_SAT_value and &H1), 1) + leftShift((write_GAIN_CAL_INTEGR_SAT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ADC_DOUT_SAT_value = rightShift(data_low, 9) and &H1
        read_LGC_dG_SAT_value = rightShift(data_low, 8) and &H1
        read_LGC_INTEGR_SAT_value = rightShift(data_low, 7) and &H1
        read_DOUT_NODC_SAT_value = rightShift(data_low, 6) and &H1
        read_LOC_INTEGR_SAT_value = rightShift(data_low, 5) and &H1
        read_INTRA_DOUT_SAT_value = rightShift(data_low, 4) and &H1
        read_STAGE_DOUT_SAT_value = rightShift(data_low, 3) and &H1
        read_DREFCAL_SAT_value = rightShift(data_low, 2) and &H1
        read_GAIN_CAL_DG_SAT_value = rightShift(data_low, 1) and &H1
        GAIN_CAL_INTEGR_SAT_mask = &H1
        if data_low > LONG_MAX then
            if GAIN_CAL_INTEGR_SAT_mask = mask then
                read_GAIN_CAL_INTEGR_SAT_value = data_low
            else
                read_GAIN_CAL_INTEGR_SAT_value = (data_low - H8000_0000) and GAIN_CAL_INTEGR_SAT_mask
            end If
        else
            read_GAIN_CAL_INTEGR_SAT_value = data_low and GAIN_CAL_INTEGR_SAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADC_DOUT_SAT_value = &H0
        flag_ADC_DOUT_SAT        = &H0
        write_LGC_dG_SAT_value = &H0
        flag_LGC_dG_SAT        = &H0
        write_LGC_INTEGR_SAT_value = &H0
        flag_LGC_INTEGR_SAT        = &H0
        write_DOUT_NODC_SAT_value = &H0
        flag_DOUT_NODC_SAT        = &H0
        write_LOC_INTEGR_SAT_value = &H0
        flag_LOC_INTEGR_SAT        = &H0
        write_INTRA_DOUT_SAT_value = &H0
        flag_INTRA_DOUT_SAT        = &H0
        write_STAGE_DOUT_SAT_value = &H0
        flag_STAGE_DOUT_SAT        = &H0
        write_DREFCAL_SAT_value = &H0
        flag_DREFCAL_SAT        = &H0
        write_GAIN_CAL_DG_SAT_value = &H0
        flag_GAIN_CAL_DG_SAT        = &H0
        write_GAIN_CAL_INTEGR_SAT_value = &H0
        flag_GAIN_CAL_INTEGR_SAT        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_testport_ind
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LANE                                       [8:8]            get_LANE
''                                                             set_LANE
''                                                             read_LANE
''                                                             write_LANE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_testport_ind
    Private write_LANE_value
    Private read_LANE_value
    Private flag_LANE

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

    Property Get get_LANE
        get_LANE = read_LANE_value
    End Property

    Property Let set_LANE(aData)
        write_LANE_value = aData
        flag_LANE        = &H1
    End Property

    Property Get read_LANE
        read
        read_LANE = read_LANE_value
    End Property

    Property Let write_LANE(aData)
        set_LANE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_LANE = &H0 Then read
        If flag_LANE = &H0 Then write_LANE_value = get_LANE

        regValue = leftShift((write_LANE_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LANE_value = &H0
        flag_LANE        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_testport_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LANE_GAIN_CAL_ST                           [10:8]           get_LANE_GAIN_CAL_ST
''                                                             set_LANE_GAIN_CAL_ST
''                                                             read_LANE_GAIN_CAL_ST
''                                                             write_LANE_GAIN_CAL_ST
''---------------------------------------------------------------------------------
'' LANE_OFFSET_CAL_ST                         [5:4]            get_LANE_OFFSET_CAL_ST
''                                                             set_LANE_OFFSET_CAL_ST
''                                                             read_LANE_OFFSET_CAL_ST
''                                                             write_LANE_OFFSET_CAL_ST
''---------------------------------------------------------------------------------
'' GAIN_CAL_ST                                [2:0]            get_GAIN_CAL_ST
''                                                             set_GAIN_CAL_ST
''                                                             read_GAIN_CAL_ST
''                                                             write_GAIN_CAL_ST
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_testport_data
    Private write_LANE_GAIN_CAL_ST_value
    Private read_LANE_GAIN_CAL_ST_value
    Private flag_LANE_GAIN_CAL_ST
    Private write_LANE_OFFSET_CAL_ST_value
    Private read_LANE_OFFSET_CAL_ST_value
    Private flag_LANE_OFFSET_CAL_ST
    Private write_GAIN_CAL_ST_value
    Private read_GAIN_CAL_ST_value
    Private flag_GAIN_CAL_ST

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

    Property Get get_LANE_GAIN_CAL_ST
        get_LANE_GAIN_CAL_ST = read_LANE_GAIN_CAL_ST_value
    End Property

    Property Let set_LANE_GAIN_CAL_ST(aData)
        write_LANE_GAIN_CAL_ST_value = aData
        flag_LANE_GAIN_CAL_ST        = &H1
    End Property

    Property Get read_LANE_GAIN_CAL_ST
        read
        read_LANE_GAIN_CAL_ST = read_LANE_GAIN_CAL_ST_value
    End Property

    Property Let write_LANE_GAIN_CAL_ST(aData)
        set_LANE_GAIN_CAL_ST = aData
        write
    End Property

    Property Get get_LANE_OFFSET_CAL_ST
        get_LANE_OFFSET_CAL_ST = read_LANE_OFFSET_CAL_ST_value
    End Property

    Property Let set_LANE_OFFSET_CAL_ST(aData)
        write_LANE_OFFSET_CAL_ST_value = aData
        flag_LANE_OFFSET_CAL_ST        = &H1
    End Property

    Property Get read_LANE_OFFSET_CAL_ST
        read
        read_LANE_OFFSET_CAL_ST = read_LANE_OFFSET_CAL_ST_value
    End Property

    Property Let write_LANE_OFFSET_CAL_ST(aData)
        set_LANE_OFFSET_CAL_ST = aData
        write
    End Property

    Property Get get_GAIN_CAL_ST
        get_GAIN_CAL_ST = read_GAIN_CAL_ST_value
    End Property

    Property Let set_GAIN_CAL_ST(aData)
        write_GAIN_CAL_ST_value = aData
        flag_GAIN_CAL_ST        = &H1
    End Property

    Property Get read_GAIN_CAL_ST
        read
        read_GAIN_CAL_ST = read_GAIN_CAL_ST_value
    End Property

    Property Let write_GAIN_CAL_ST(aData)
        set_GAIN_CAL_ST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_GAIN_CAL_ST_value = rightShift(data_low, 8) and &H7
        read_LANE_OFFSET_CAL_ST_value = rightShift(data_low, 4) and &H3
        GAIN_CAL_ST_mask = &H7
        if data_low > LONG_MAX then
            if GAIN_CAL_ST_mask = mask then
                read_GAIN_CAL_ST_value = data_low
            else
                read_GAIN_CAL_ST_value = (data_low - H8000_0000) and GAIN_CAL_ST_mask
            end If
        else
            read_GAIN_CAL_ST_value = data_low and GAIN_CAL_ST_mask
        end If

    End Sub

    Sub write
        If flag_LANE_GAIN_CAL_ST = &H0 or flag_LANE_OFFSET_CAL_ST = &H0 or flag_GAIN_CAL_ST = &H0 Then read
        If flag_LANE_GAIN_CAL_ST = &H0 Then write_LANE_GAIN_CAL_ST_value = get_LANE_GAIN_CAL_ST
        If flag_LANE_OFFSET_CAL_ST = &H0 Then write_LANE_OFFSET_CAL_ST_value = get_LANE_OFFSET_CAL_ST
        If flag_GAIN_CAL_ST = &H0 Then write_GAIN_CAL_ST_value = get_GAIN_CAL_ST

        regValue = leftShift((write_LANE_GAIN_CAL_ST_value and &H7), 8) + leftShift((write_LANE_OFFSET_CAL_ST_value and &H3), 4) + leftShift((write_GAIN_CAL_ST_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LANE_GAIN_CAL_ST_value = rightShift(data_low, 8) and &H7
        read_LANE_OFFSET_CAL_ST_value = rightShift(data_low, 4) and &H3
        GAIN_CAL_ST_mask = &H7
        if data_low > LONG_MAX then
            if GAIN_CAL_ST_mask = mask then
                read_GAIN_CAL_ST_value = data_low
            else
                read_GAIN_CAL_ST_value = (data_low - H8000_0000) and GAIN_CAL_ST_mask
            end If
        else
            read_GAIN_CAL_ST_value = data_low and GAIN_CAL_ST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LANE_GAIN_CAL_ST_value = &H0
        flag_LANE_GAIN_CAL_ST        = &H0
        write_LANE_OFFSET_CAL_ST_value = &H0
        flag_LANE_OFFSET_CAL_ST        = &H0
        write_GAIN_CAL_ST_value = &H0
        flag_GAIN_CAL_ST        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_cha_clock_enable_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LN1_CLK_EN                                 [5:5]            get_LN1_CLK_EN
''                                                             set_LN1_CLK_EN
''                                                             read_LN1_CLK_EN
''                                                             write_LN1_CLK_EN
''---------------------------------------------------------------------------------
'' LN0_CLK_EN                                 [4:4]            get_LN0_CLK_EN
''                                                             set_LN0_CLK_EN
''                                                             read_LN0_CLK_EN
''                                                             write_LN0_CLK_EN
''---------------------------------------------------------------------------------
'' LANE_GAIN_CAL_CLK_EN                       [2:2]            get_LANE_GAIN_CAL_CLK_EN
''                                                             set_LANE_GAIN_CAL_CLK_EN
''                                                             read_LANE_GAIN_CAL_CLK_EN
''                                                             write_LANE_GAIN_CAL_CLK_EN
''---------------------------------------------------------------------------------
'' OFFSET_CAL_CLK_EN                          [1:1]            get_OFFSET_CAL_CLK_EN
''                                                             set_OFFSET_CAL_CLK_EN
''                                                             read_OFFSET_CAL_CLK_EN
''                                                             write_OFFSET_CAL_CLK_EN
''---------------------------------------------------------------------------------
'' MDAC_GAIN_CAL_CLK_EN                       [0:0]            get_MDAC_GAIN_CAL_CLK_EN
''                                                             set_MDAC_GAIN_CAL_CLK_EN
''                                                             read_MDAC_GAIN_CAL_CLK_EN
''                                                             write_MDAC_GAIN_CAL_CLK_EN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_cha_clock_enable_ctl
    Private write_LN1_CLK_EN_value
    Private read_LN1_CLK_EN_value
    Private flag_LN1_CLK_EN
    Private write_LN0_CLK_EN_value
    Private read_LN0_CLK_EN_value
    Private flag_LN0_CLK_EN
    Private write_LANE_GAIN_CAL_CLK_EN_value
    Private read_LANE_GAIN_CAL_CLK_EN_value
    Private flag_LANE_GAIN_CAL_CLK_EN
    Private write_OFFSET_CAL_CLK_EN_value
    Private read_OFFSET_CAL_CLK_EN_value
    Private flag_OFFSET_CAL_CLK_EN
    Private write_MDAC_GAIN_CAL_CLK_EN_value
    Private read_MDAC_GAIN_CAL_CLK_EN_value
    Private flag_MDAC_GAIN_CAL_CLK_EN

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

    Property Get get_LN1_CLK_EN
        get_LN1_CLK_EN = read_LN1_CLK_EN_value
    End Property

    Property Let set_LN1_CLK_EN(aData)
        write_LN1_CLK_EN_value = aData
        flag_LN1_CLK_EN        = &H1
    End Property

    Property Get read_LN1_CLK_EN
        read
        read_LN1_CLK_EN = read_LN1_CLK_EN_value
    End Property

    Property Let write_LN1_CLK_EN(aData)
        set_LN1_CLK_EN = aData
        write
    End Property

    Property Get get_LN0_CLK_EN
        get_LN0_CLK_EN = read_LN0_CLK_EN_value
    End Property

    Property Let set_LN0_CLK_EN(aData)
        write_LN0_CLK_EN_value = aData
        flag_LN0_CLK_EN        = &H1
    End Property

    Property Get read_LN0_CLK_EN
        read
        read_LN0_CLK_EN = read_LN0_CLK_EN_value
    End Property

    Property Let write_LN0_CLK_EN(aData)
        set_LN0_CLK_EN = aData
        write
    End Property

    Property Get get_LANE_GAIN_CAL_CLK_EN
        get_LANE_GAIN_CAL_CLK_EN = read_LANE_GAIN_CAL_CLK_EN_value
    End Property

    Property Let set_LANE_GAIN_CAL_CLK_EN(aData)
        write_LANE_GAIN_CAL_CLK_EN_value = aData
        flag_LANE_GAIN_CAL_CLK_EN        = &H1
    End Property

    Property Get read_LANE_GAIN_CAL_CLK_EN
        read
        read_LANE_GAIN_CAL_CLK_EN = read_LANE_GAIN_CAL_CLK_EN_value
    End Property

    Property Let write_LANE_GAIN_CAL_CLK_EN(aData)
        set_LANE_GAIN_CAL_CLK_EN = aData
        write
    End Property

    Property Get get_OFFSET_CAL_CLK_EN
        get_OFFSET_CAL_CLK_EN = read_OFFSET_CAL_CLK_EN_value
    End Property

    Property Let set_OFFSET_CAL_CLK_EN(aData)
        write_OFFSET_CAL_CLK_EN_value = aData
        flag_OFFSET_CAL_CLK_EN        = &H1
    End Property

    Property Get read_OFFSET_CAL_CLK_EN
        read
        read_OFFSET_CAL_CLK_EN = read_OFFSET_CAL_CLK_EN_value
    End Property

    Property Let write_OFFSET_CAL_CLK_EN(aData)
        set_OFFSET_CAL_CLK_EN = aData
        write
    End Property

    Property Get get_MDAC_GAIN_CAL_CLK_EN
        get_MDAC_GAIN_CAL_CLK_EN = read_MDAC_GAIN_CAL_CLK_EN_value
    End Property

    Property Let set_MDAC_GAIN_CAL_CLK_EN(aData)
        write_MDAC_GAIN_CAL_CLK_EN_value = aData
        flag_MDAC_GAIN_CAL_CLK_EN        = &H1
    End Property

    Property Get read_MDAC_GAIN_CAL_CLK_EN
        read
        read_MDAC_GAIN_CAL_CLK_EN = read_MDAC_GAIN_CAL_CLK_EN_value
    End Property

    Property Let write_MDAC_GAIN_CAL_CLK_EN(aData)
        set_MDAC_GAIN_CAL_CLK_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LN1_CLK_EN_value = rightShift(data_low, 5) and &H1
        read_LN0_CLK_EN_value = rightShift(data_low, 4) and &H1
        read_LANE_GAIN_CAL_CLK_EN_value = rightShift(data_low, 2) and &H1
        read_OFFSET_CAL_CLK_EN_value = rightShift(data_low, 1) and &H1
        MDAC_GAIN_CAL_CLK_EN_mask = &H1
        if data_low > LONG_MAX then
            if MDAC_GAIN_CAL_CLK_EN_mask = mask then
                read_MDAC_GAIN_CAL_CLK_EN_value = data_low
            else
                read_MDAC_GAIN_CAL_CLK_EN_value = (data_low - H8000_0000) and MDAC_GAIN_CAL_CLK_EN_mask
            end If
        else
            read_MDAC_GAIN_CAL_CLK_EN_value = data_low and MDAC_GAIN_CAL_CLK_EN_mask
        end If

    End Sub

    Sub write
        If flag_LN1_CLK_EN = &H0 or flag_LN0_CLK_EN = &H0 or flag_LANE_GAIN_CAL_CLK_EN = &H0 or flag_OFFSET_CAL_CLK_EN = &H0 or flag_MDAC_GAIN_CAL_CLK_EN = &H0 Then read
        If flag_LN1_CLK_EN = &H0 Then write_LN1_CLK_EN_value = get_LN1_CLK_EN
        If flag_LN0_CLK_EN = &H0 Then write_LN0_CLK_EN_value = get_LN0_CLK_EN
        If flag_LANE_GAIN_CAL_CLK_EN = &H0 Then write_LANE_GAIN_CAL_CLK_EN_value = get_LANE_GAIN_CAL_CLK_EN
        If flag_OFFSET_CAL_CLK_EN = &H0 Then write_OFFSET_CAL_CLK_EN_value = get_OFFSET_CAL_CLK_EN
        If flag_MDAC_GAIN_CAL_CLK_EN = &H0 Then write_MDAC_GAIN_CAL_CLK_EN_value = get_MDAC_GAIN_CAL_CLK_EN

        regValue = leftShift((write_LN1_CLK_EN_value and &H1), 5) + leftShift((write_LN0_CLK_EN_value and &H1), 4) + leftShift((write_LANE_GAIN_CAL_CLK_EN_value and &H1), 2) + leftShift((write_OFFSET_CAL_CLK_EN_value and &H1), 1) + leftShift((write_MDAC_GAIN_CAL_CLK_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LN1_CLK_EN_value = rightShift(data_low, 5) and &H1
        read_LN0_CLK_EN_value = rightShift(data_low, 4) and &H1
        read_LANE_GAIN_CAL_CLK_EN_value = rightShift(data_low, 2) and &H1
        read_OFFSET_CAL_CLK_EN_value = rightShift(data_low, 1) and &H1
        MDAC_GAIN_CAL_CLK_EN_mask = &H1
        if data_low > LONG_MAX then
            if MDAC_GAIN_CAL_CLK_EN_mask = mask then
                read_MDAC_GAIN_CAL_CLK_EN_value = data_low
            else
                read_MDAC_GAIN_CAL_CLK_EN_value = (data_low - H8000_0000) and MDAC_GAIN_CAL_CLK_EN_mask
            end If
        else
            read_MDAC_GAIN_CAL_CLK_EN_value = data_low and MDAC_GAIN_CAL_CLK_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LN1_CLK_EN_value = &H0
        flag_LN1_CLK_EN        = &H0
        write_LN0_CLK_EN_value = &H0
        flag_LN0_CLK_EN        = &H0
        write_LANE_GAIN_CAL_CLK_EN_value = &H0
        flag_LANE_GAIN_CAL_CLK_EN        = &H0
        write_OFFSET_CAL_CLK_EN_value = &H0
        flag_OFFSET_CAL_CLK_EN        = &H0
        write_MDAC_GAIN_CAL_CLK_EN_value = &H0
        flag_MDAC_GAIN_CAL_CLK_EN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_rxlpi_disable_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LGAIN_CAL_RXLPI_DISABLE_EN                 [4:4]            get_LGAIN_CAL_RXLPI_DISABLE_EN
''                                                             set_LGAIN_CAL_RXLPI_DISABLE_EN
''                                                             read_LGAIN_CAL_RXLPI_DISABLE_EN
''                                                             write_LGAIN_CAL_RXLPI_DISABLE_EN
''---------------------------------------------------------------------------------
'' OFFSET_CAL_RXLPI_DISABLE_EN                [0:0]            get_OFFSET_CAL_RXLPI_DISABLE_EN
''                                                             set_OFFSET_CAL_RXLPI_DISABLE_EN
''                                                             read_OFFSET_CAL_RXLPI_DISABLE_EN
''                                                             write_OFFSET_CAL_RXLPI_DISABLE_EN
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_rxlpi_disable_ctl
    Private write_LGAIN_CAL_RXLPI_DISABLE_EN_value
    Private read_LGAIN_CAL_RXLPI_DISABLE_EN_value
    Private flag_LGAIN_CAL_RXLPI_DISABLE_EN
    Private write_OFFSET_CAL_RXLPI_DISABLE_EN_value
    Private read_OFFSET_CAL_RXLPI_DISABLE_EN_value
    Private flag_OFFSET_CAL_RXLPI_DISABLE_EN

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

    Property Get get_LGAIN_CAL_RXLPI_DISABLE_EN
        get_LGAIN_CAL_RXLPI_DISABLE_EN = read_LGAIN_CAL_RXLPI_DISABLE_EN_value
    End Property

    Property Let set_LGAIN_CAL_RXLPI_DISABLE_EN(aData)
        write_LGAIN_CAL_RXLPI_DISABLE_EN_value = aData
        flag_LGAIN_CAL_RXLPI_DISABLE_EN        = &H1
    End Property

    Property Get read_LGAIN_CAL_RXLPI_DISABLE_EN
        read
        read_LGAIN_CAL_RXLPI_DISABLE_EN = read_LGAIN_CAL_RXLPI_DISABLE_EN_value
    End Property

    Property Let write_LGAIN_CAL_RXLPI_DISABLE_EN(aData)
        set_LGAIN_CAL_RXLPI_DISABLE_EN = aData
        write
    End Property

    Property Get get_OFFSET_CAL_RXLPI_DISABLE_EN
        get_OFFSET_CAL_RXLPI_DISABLE_EN = read_OFFSET_CAL_RXLPI_DISABLE_EN_value
    End Property

    Property Let set_OFFSET_CAL_RXLPI_DISABLE_EN(aData)
        write_OFFSET_CAL_RXLPI_DISABLE_EN_value = aData
        flag_OFFSET_CAL_RXLPI_DISABLE_EN        = &H1
    End Property

    Property Get read_OFFSET_CAL_RXLPI_DISABLE_EN
        read
        read_OFFSET_CAL_RXLPI_DISABLE_EN = read_OFFSET_CAL_RXLPI_DISABLE_EN_value
    End Property

    Property Let write_OFFSET_CAL_RXLPI_DISABLE_EN(aData)
        set_OFFSET_CAL_RXLPI_DISABLE_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LGAIN_CAL_RXLPI_DISABLE_EN_value = rightShift(data_low, 4) and &H1
        OFFSET_CAL_RXLPI_DISABLE_EN_mask = &H1
        if data_low > LONG_MAX then
            if OFFSET_CAL_RXLPI_DISABLE_EN_mask = mask then
                read_OFFSET_CAL_RXLPI_DISABLE_EN_value = data_low
            else
                read_OFFSET_CAL_RXLPI_DISABLE_EN_value = (data_low - H8000_0000) and OFFSET_CAL_RXLPI_DISABLE_EN_mask
            end If
        else
            read_OFFSET_CAL_RXLPI_DISABLE_EN_value = data_low and OFFSET_CAL_RXLPI_DISABLE_EN_mask
        end If

    End Sub

    Sub write
        If flag_LGAIN_CAL_RXLPI_DISABLE_EN = &H0 or flag_OFFSET_CAL_RXLPI_DISABLE_EN = &H0 Then read
        If flag_LGAIN_CAL_RXLPI_DISABLE_EN = &H0 Then write_LGAIN_CAL_RXLPI_DISABLE_EN_value = get_LGAIN_CAL_RXLPI_DISABLE_EN
        If flag_OFFSET_CAL_RXLPI_DISABLE_EN = &H0 Then write_OFFSET_CAL_RXLPI_DISABLE_EN_value = get_OFFSET_CAL_RXLPI_DISABLE_EN

        regValue = leftShift((write_LGAIN_CAL_RXLPI_DISABLE_EN_value and &H1), 4) + leftShift((write_OFFSET_CAL_RXLPI_DISABLE_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LGAIN_CAL_RXLPI_DISABLE_EN_value = rightShift(data_low, 4) and &H1
        OFFSET_CAL_RXLPI_DISABLE_EN_mask = &H1
        if data_low > LONG_MAX then
            if OFFSET_CAL_RXLPI_DISABLE_EN_mask = mask then
                read_OFFSET_CAL_RXLPI_DISABLE_EN_value = data_low
            else
                read_OFFSET_CAL_RXLPI_DISABLE_EN_value = (data_low - H8000_0000) and OFFSET_CAL_RXLPI_DISABLE_EN_mask
            end If
        else
            read_OFFSET_CAL_RXLPI_DISABLE_EN_value = data_low and OFFSET_CAL_RXLPI_DISABLE_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LGAIN_CAL_RXLPI_DISABLE_EN_value = &H0
        flag_LGAIN_CAL_RXLPI_DISABLE_EN        = &H0
        write_OFFSET_CAL_RXLPI_DISABLE_EN_value = &H0
        flag_OFFSET_CAL_RXLPI_DISABLE_EN        = &H0
    End Sub
End Class


'' @REGISTER : ADCCAL_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [0:0]            get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_ADCCAL_spare_end_addr
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &H1
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &H1
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class ADCCAL_INSTANCE

    Public mode_ctl_1
    Public mode_ctl_2
    Public cha_fgcal_ctl
    Public cha_fgcal_ovr
    Public cha_ln0_stg1_gain_cal_ctl_1
    Public cha_ln0_stg1_gain_cal_ctl_2
    Public cha_ln1_stg1_gain_cal_ctl_1
    Public cha_ln1_stg1_gain_cal_ctl_2
    Public gain_cal_integr_ind
    Public gain_cal_integr_data_hi
    Public gain_cal_integr_data_lo
    Public gain_cal_dg_ind
    Public gain_cal_dg_data
    Public cha_ln0_offset_cal_ctl
    Public cha_ln1_offset_cal_ctl
    Public offset_cal_integr_ind
    Public offset_cal_integr_data_hi
    Public offset_cal_integr_data_lo
    Public offset_cal_doffset_ind
    Public offset_cal_doffset_data
    Public cha_lgain_cal_ctl_1
    Public cha_lgain_cal_ctl_2
    Public cha_ln0_magn_ctl
    Public cha_ln1_magn_ctl
    Public lgain_cal_magn_ind
    Public lgain_cal_magn_data
    Public lgain_cal_dg_accum_ind
    Public lgain_cal_dg_accum_data_hi
    Public lgain_cal_dg_accum_data_lo
    Public saturation_status
    Public testport_ind
    Public testport_data
    Public cha_clock_enable_ctl
    Public rxlpi_disable_ctl
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set mode_ctl_1 = (New REGISTER_ADCCAL_mode_ctl_1)(aBaseAddr, 16)
        Set mode_ctl_2 = (New REGISTER_ADCCAL_mode_ctl_2)(aBaseAddr, 16)
        Set cha_fgcal_ctl = (New REGISTER_ADCCAL_cha_fgcal_ctl)(aBaseAddr, 16)
        Set cha_fgcal_ovr = (New REGISTER_ADCCAL_cha_fgcal_ovr)(aBaseAddr, 16)
        Set cha_ln0_stg1_gain_cal_ctl_1 = (New REGISTER_ADCCAL_cha_ln0_stg1_gain_cal_ctl_1)(aBaseAddr, 16)
        Set cha_ln0_stg1_gain_cal_ctl_2 = (New REGISTER_ADCCAL_cha_ln0_stg1_gain_cal_ctl_2)(aBaseAddr, 16)
        Set cha_ln1_stg1_gain_cal_ctl_1 = (New REGISTER_ADCCAL_cha_ln1_stg1_gain_cal_ctl_1)(aBaseAddr, 16)
        Set cha_ln1_stg1_gain_cal_ctl_2 = (New REGISTER_ADCCAL_cha_ln1_stg1_gain_cal_ctl_2)(aBaseAddr, 16)
        Set gain_cal_integr_ind = (New REGISTER_ADCCAL_gain_cal_integr_ind)(aBaseAddr, 16)
        Set gain_cal_integr_data_hi = (New REGISTER_ADCCAL_gain_cal_integr_data_hi)(aBaseAddr, 16)
        Set gain_cal_integr_data_lo = (New REGISTER_ADCCAL_gain_cal_integr_data_lo)(aBaseAddr, 16)
        Set gain_cal_dg_ind = (New REGISTER_ADCCAL_gain_cal_dg_ind)(aBaseAddr, 16)
        Set gain_cal_dg_data = (New REGISTER_ADCCAL_gain_cal_dg_data)(aBaseAddr, 16)
        Set cha_ln0_offset_cal_ctl = (New REGISTER_ADCCAL_cha_ln0_offset_cal_ctl)(aBaseAddr, 16)
        Set cha_ln1_offset_cal_ctl = (New REGISTER_ADCCAL_cha_ln1_offset_cal_ctl)(aBaseAddr, 16)
        Set offset_cal_integr_ind = (New REGISTER_ADCCAL_offset_cal_integr_ind)(aBaseAddr, 16)
        Set offset_cal_integr_data_hi = (New REGISTER_ADCCAL_offset_cal_integr_data_hi)(aBaseAddr, 16)
        Set offset_cal_integr_data_lo = (New REGISTER_ADCCAL_offset_cal_integr_data_lo)(aBaseAddr, 16)
        Set offset_cal_doffset_ind = (New REGISTER_ADCCAL_offset_cal_doffset_ind)(aBaseAddr, 16)
        Set offset_cal_doffset_data = (New REGISTER_ADCCAL_offset_cal_doffset_data)(aBaseAddr, 16)
        Set cha_lgain_cal_ctl_1 = (New REGISTER_ADCCAL_cha_lgain_cal_ctl_1)(aBaseAddr, 16)
        Set cha_lgain_cal_ctl_2 = (New REGISTER_ADCCAL_cha_lgain_cal_ctl_2)(aBaseAddr, 16)
        Set cha_ln0_magn_ctl = (New REGISTER_ADCCAL_cha_ln0_magn_ctl)(aBaseAddr, 16)
        Set cha_ln1_magn_ctl = (New REGISTER_ADCCAL_cha_ln1_magn_ctl)(aBaseAddr, 16)
        Set lgain_cal_magn_ind = (New REGISTER_ADCCAL_lgain_cal_magn_ind)(aBaseAddr, 16)
        Set lgain_cal_magn_data = (New REGISTER_ADCCAL_lgain_cal_magn_data)(aBaseAddr, 16)
        Set lgain_cal_dg_accum_ind = (New REGISTER_ADCCAL_lgain_cal_dg_accum_ind)(aBaseAddr, 16)
        Set lgain_cal_dg_accum_data_hi = (New REGISTER_ADCCAL_lgain_cal_dg_accum_data_hi)(aBaseAddr, 16)
        Set lgain_cal_dg_accum_data_lo = (New REGISTER_ADCCAL_lgain_cal_dg_accum_data_lo)(aBaseAddr, 16)
        Set saturation_status = (New REGISTER_ADCCAL_saturation_status)(aBaseAddr, 16)
        Set testport_ind = (New REGISTER_ADCCAL_testport_ind)(aBaseAddr, 16)
        Set testport_data = (New REGISTER_ADCCAL_testport_data)(aBaseAddr, 16)
        Set cha_clock_enable_ctl = (New REGISTER_ADCCAL_cha_clock_enable_ctl)(aBaseAddr, 16)
        Set rxlpi_disable_ctl = (New REGISTER_ADCCAL_rxlpi_disable_ctl)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_ADCCAL_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set ADCCAL = CreateObject("System.Collections.ArrayList")
ADCCAL.Add ((New ADCCAL_INSTANCE)(&H49034a00))


