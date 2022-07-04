

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


'' @REGISTER : CORE_MISC_base10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ISOLATE                                    [14:14]          get_ISOLATE
''                                                             set_ISOLATE
''                                                             read_ISOLATE
''                                                             write_ISOLATE
''---------------------------------------------------------------------------------
'' INT_DIS                                    [12:12]          get_INT_DIS
''                                                             set_INT_DIS
''                                                             read_INT_DIS
''                                                             write_INT_DIS
''---------------------------------------------------------------------------------
'' FORCE_INT                                  [11:11]          get_FORCE_INT
''                                                             set_FORCE_INT
''                                                             read_FORCE_INT
''                                                             write_FORCE_INT
''---------------------------------------------------------------------------------
'' RESET_SCRAMBLER                            [6:6]            get_RESET_SCRAMBLER
''                                                             set_RESET_SCRAMBLER
''                                                             read_RESET_SCRAMBLER
''                                                             write_RESET_SCRAMBLER
''---------------------------------------------------------------------------------
'' LED_TRAFFIC_EN                             [5:5]            get_LED_TRAFFIC_EN
''                                                             set_LED_TRAFFIC_EN
''                                                             read_LED_TRAFFIC_EN
''                                                             write_LED_TRAFFIC_EN
''---------------------------------------------------------------------------------
'' FORCE_LEDS_ON                              [4:4]            get_FORCE_LEDS_ON
''                                                             set_FORCE_LEDS_ON
''                                                             read_FORCE_LEDS_ON
''                                                             write_FORCE_LEDS_ON
''---------------------------------------------------------------------------------
'' FORCE_LEDS_OFF                             [3:3]            get_FORCE_LEDS_OFF
''                                                             set_FORCE_LEDS_OFF
''                                                             read_FORCE_LEDS_OFF
''                                                             write_FORCE_LEDS_OFF
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base10
    Private write_ISOLATE_value
    Private read_ISOLATE_value
    Private flag_ISOLATE
    Private write_INT_DIS_value
    Private read_INT_DIS_value
    Private flag_INT_DIS
    Private write_FORCE_INT_value
    Private read_FORCE_INT_value
    Private flag_FORCE_INT
    Private write_RESET_SCRAMBLER_value
    Private read_RESET_SCRAMBLER_value
    Private flag_RESET_SCRAMBLER
    Private write_LED_TRAFFIC_EN_value
    Private read_LED_TRAFFIC_EN_value
    Private flag_LED_TRAFFIC_EN
    Private write_FORCE_LEDS_ON_value
    Private read_FORCE_LEDS_ON_value
    Private flag_FORCE_LEDS_ON
    Private write_FORCE_LEDS_OFF_value
    Private read_FORCE_LEDS_OFF_value
    Private flag_FORCE_LEDS_OFF

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

    Property Get get_ISOLATE
        get_ISOLATE = read_ISOLATE_value
    End Property

    Property Let set_ISOLATE(aData)
        write_ISOLATE_value = aData
        flag_ISOLATE        = &H1
    End Property

    Property Get read_ISOLATE
        read
        read_ISOLATE = read_ISOLATE_value
    End Property

    Property Let write_ISOLATE(aData)
        set_ISOLATE = aData
        write
    End Property

    Property Get get_INT_DIS
        get_INT_DIS = read_INT_DIS_value
    End Property

    Property Let set_INT_DIS(aData)
        write_INT_DIS_value = aData
        flag_INT_DIS        = &H1
    End Property

    Property Get read_INT_DIS
        read
        read_INT_DIS = read_INT_DIS_value
    End Property

    Property Let write_INT_DIS(aData)
        set_INT_DIS = aData
        write
    End Property

    Property Get get_FORCE_INT
        get_FORCE_INT = read_FORCE_INT_value
    End Property

    Property Let set_FORCE_INT(aData)
        write_FORCE_INT_value = aData
        flag_FORCE_INT        = &H1
    End Property

    Property Get read_FORCE_INT
        read
        read_FORCE_INT = read_FORCE_INT_value
    End Property

    Property Let write_FORCE_INT(aData)
        set_FORCE_INT = aData
        write
    End Property

    Property Get get_RESET_SCRAMBLER
        get_RESET_SCRAMBLER = read_RESET_SCRAMBLER_value
    End Property

    Property Let set_RESET_SCRAMBLER(aData)
        write_RESET_SCRAMBLER_value = aData
        flag_RESET_SCRAMBLER        = &H1
    End Property

    Property Get read_RESET_SCRAMBLER
        read
        read_RESET_SCRAMBLER = read_RESET_SCRAMBLER_value
    End Property

    Property Let write_RESET_SCRAMBLER(aData)
        set_RESET_SCRAMBLER = aData
        write
    End Property

    Property Get get_LED_TRAFFIC_EN
        get_LED_TRAFFIC_EN = read_LED_TRAFFIC_EN_value
    End Property

    Property Let set_LED_TRAFFIC_EN(aData)
        write_LED_TRAFFIC_EN_value = aData
        flag_LED_TRAFFIC_EN        = &H1
    End Property

    Property Get read_LED_TRAFFIC_EN
        read
        read_LED_TRAFFIC_EN = read_LED_TRAFFIC_EN_value
    End Property

    Property Let write_LED_TRAFFIC_EN(aData)
        set_LED_TRAFFIC_EN = aData
        write
    End Property

    Property Get get_FORCE_LEDS_ON
        get_FORCE_LEDS_ON = read_FORCE_LEDS_ON_value
    End Property

    Property Let set_FORCE_LEDS_ON(aData)
        write_FORCE_LEDS_ON_value = aData
        flag_FORCE_LEDS_ON        = &H1
    End Property

    Property Get read_FORCE_LEDS_ON
        read
        read_FORCE_LEDS_ON = read_FORCE_LEDS_ON_value
    End Property

    Property Let write_FORCE_LEDS_ON(aData)
        set_FORCE_LEDS_ON = aData
        write
    End Property

    Property Get get_FORCE_LEDS_OFF
        get_FORCE_LEDS_OFF = read_FORCE_LEDS_OFF_value
    End Property

    Property Let set_FORCE_LEDS_OFF(aData)
        write_FORCE_LEDS_OFF_value = aData
        flag_FORCE_LEDS_OFF        = &H1
    End Property

    Property Get read_FORCE_LEDS_OFF
        read
        read_FORCE_LEDS_OFF = read_FORCE_LEDS_OFF_value
    End Property

    Property Let write_FORCE_LEDS_OFF(aData)
        set_FORCE_LEDS_OFF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ISOLATE_value = rightShift(data_low, 14) and &H1
        read_INT_DIS_value = rightShift(data_low, 12) and &H1
        read_FORCE_INT_value = rightShift(data_low, 11) and &H1
        read_RESET_SCRAMBLER_value = rightShift(data_low, 6) and &H1
        read_LED_TRAFFIC_EN_value = rightShift(data_low, 5) and &H1
        read_FORCE_LEDS_ON_value = rightShift(data_low, 4) and &H1
        read_FORCE_LEDS_OFF_value = rightShift(data_low, 3) and &H1

    End Sub

    Sub write
        If flag_ISOLATE = &H0 or flag_INT_DIS = &H0 or flag_FORCE_INT = &H0 or flag_RESET_SCRAMBLER = &H0 or flag_LED_TRAFFIC_EN = &H0 or flag_FORCE_LEDS_ON = &H0 or flag_FORCE_LEDS_OFF = &H0 Then read
        If flag_ISOLATE = &H0 Then write_ISOLATE_value = get_ISOLATE
        If flag_INT_DIS = &H0 Then write_INT_DIS_value = get_INT_DIS
        If flag_FORCE_INT = &H0 Then write_FORCE_INT_value = get_FORCE_INT
        If flag_RESET_SCRAMBLER = &H0 Then write_RESET_SCRAMBLER_value = get_RESET_SCRAMBLER
        If flag_LED_TRAFFIC_EN = &H0 Then write_LED_TRAFFIC_EN_value = get_LED_TRAFFIC_EN
        If flag_FORCE_LEDS_ON = &H0 Then write_FORCE_LEDS_ON_value = get_FORCE_LEDS_ON
        If flag_FORCE_LEDS_OFF = &H0 Then write_FORCE_LEDS_OFF_value = get_FORCE_LEDS_OFF

        regValue = leftShift((write_ISOLATE_value and &H1), 14) + leftShift((write_INT_DIS_value and &H1), 12) + leftShift((write_FORCE_INT_value and &H1), 11) + leftShift((write_RESET_SCRAMBLER_value and &H1), 6) + leftShift((write_LED_TRAFFIC_EN_value and &H1), 5) + leftShift((write_FORCE_LEDS_ON_value and &H1), 4) + leftShift((write_FORCE_LEDS_OFF_value and &H1), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ISOLATE_value = rightShift(data_low, 14) and &H1
        read_INT_DIS_value = rightShift(data_low, 12) and &H1
        read_FORCE_INT_value = rightShift(data_low, 11) and &H1
        read_RESET_SCRAMBLER_value = rightShift(data_low, 6) and &H1
        read_LED_TRAFFIC_EN_value = rightShift(data_low, 5) and &H1
        read_FORCE_LEDS_ON_value = rightShift(data_low, 4) and &H1
        read_FORCE_LEDS_OFF_value = rightShift(data_low, 3) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ISOLATE_value = &H0
        flag_ISOLATE        = &H0
        write_INT_DIS_value = &H0
        flag_INT_DIS        = &H0
        write_FORCE_INT_value = &H0
        flag_FORCE_INT        = &H0
        write_RESET_SCRAMBLER_value = &H0
        flag_RESET_SCRAMBLER        = &H0
        write_LED_TRAFFIC_EN_value = &H0
        flag_LED_TRAFFIC_EN        = &H0
        write_FORCE_LEDS_ON_value = &H0
        flag_FORCE_LEDS_ON        = &H0
        write_FORCE_LEDS_OFF_value = &H0
        flag_FORCE_LEDS_OFF        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' INT_STATUS                                 [12:12]          get_INT_STATUS
''                                                             set_INT_STATUS
''                                                             read_INT_STATUS
''                                                             write_INT_STATUS
''---------------------------------------------------------------------------------
'' RMT_RCVR_STATUS                            [11:11]          get_RMT_RCVR_STATUS
''                                                             set_RMT_RCVR_STATUS
''                                                             read_RMT_RCVR_STATUS
''                                                             write_RMT_RCVR_STATUS
''---------------------------------------------------------------------------------
'' LOCAL_RCVR_STATUS                          [10:10]          get_LOCAL_RCVR_STATUS
''                                                             set_LOCAL_RCVR_STATUS
''                                                             read_LOCAL_RCVR_STATUS
''                                                             write_LOCAL_RCVR_STATUS
''---------------------------------------------------------------------------------
'' LOCKED                                     [9:9]            get_LOCKED
''                                                             set_LOCKED
''                                                             read_LOCKED
''                                                             write_LOCKED
''---------------------------------------------------------------------------------
'' LINK_STATUS                                [8:8]            get_LINK_STATUS
''                                                             set_LINK_STATUS
''                                                             read_LINK_STATUS
''                                                             write_LINK_STATUS
''---------------------------------------------------------------------------------
'' CRC_ERR_DET                                [7:7]            get_CRC_ERR_DET
''                                                             set_CRC_ERR_DET
''                                                             read_CRC_ERR_DET
''                                                             write_CRC_ERR_DET
''---------------------------------------------------------------------------------
'' BAD_SSD_DET_CR                             [5:5]            get_BAD_SSD_DET_CR
''                                                             set_BAD_SSD_DET_CR
''                                                             read_BAD_SSD_DET_CR
''                                                             write_BAD_SSD_DET_CR
''---------------------------------------------------------------------------------
'' RCV_ERR_DET                                [3:3]            get_RCV_ERR_DET
''                                                             set_RCV_ERR_DET
''                                                             read_RCV_ERR_DET
''                                                             write_RCV_ERR_DET
''---------------------------------------------------------------------------------
'' TX_ERR_DET                                 [2:2]            get_TX_ERR_DET
''                                                             set_TX_ERR_DET
''                                                             read_TX_ERR_DET
''                                                             write_TX_ERR_DET
''---------------------------------------------------------------------------------
'' LOCK_ERR_DET                               [1:1]            get_LOCK_ERR_DET
''                                                             set_LOCK_ERR_DET
''                                                             read_LOCK_ERR_DET
''                                                             write_LOCK_ERR_DET
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base11
    Private write_INT_STATUS_value
    Private read_INT_STATUS_value
    Private flag_INT_STATUS
    Private write_RMT_RCVR_STATUS_value
    Private read_RMT_RCVR_STATUS_value
    Private flag_RMT_RCVR_STATUS
    Private write_LOCAL_RCVR_STATUS_value
    Private read_LOCAL_RCVR_STATUS_value
    Private flag_LOCAL_RCVR_STATUS
    Private write_LOCKED_value
    Private read_LOCKED_value
    Private flag_LOCKED
    Private write_LINK_STATUS_value
    Private read_LINK_STATUS_value
    Private flag_LINK_STATUS
    Private write_CRC_ERR_DET_value
    Private read_CRC_ERR_DET_value
    Private flag_CRC_ERR_DET
    Private write_BAD_SSD_DET_CR_value
    Private read_BAD_SSD_DET_CR_value
    Private flag_BAD_SSD_DET_CR
    Private write_RCV_ERR_DET_value
    Private read_RCV_ERR_DET_value
    Private flag_RCV_ERR_DET
    Private write_TX_ERR_DET_value
    Private read_TX_ERR_DET_value
    Private flag_TX_ERR_DET
    Private write_LOCK_ERR_DET_value
    Private read_LOCK_ERR_DET_value
    Private flag_LOCK_ERR_DET

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

    Property Get get_INT_STATUS
        get_INT_STATUS = read_INT_STATUS_value
    End Property

    Property Let set_INT_STATUS(aData)
        write_INT_STATUS_value = aData
        flag_INT_STATUS        = &H1
    End Property

    Property Get read_INT_STATUS
        read
        read_INT_STATUS = read_INT_STATUS_value
    End Property

    Property Let write_INT_STATUS(aData)
        set_INT_STATUS = aData
        write
    End Property

    Property Get get_RMT_RCVR_STATUS
        get_RMT_RCVR_STATUS = read_RMT_RCVR_STATUS_value
    End Property

    Property Let set_RMT_RCVR_STATUS(aData)
        write_RMT_RCVR_STATUS_value = aData
        flag_RMT_RCVR_STATUS        = &H1
    End Property

    Property Get read_RMT_RCVR_STATUS
        read
        read_RMT_RCVR_STATUS = read_RMT_RCVR_STATUS_value
    End Property

    Property Let write_RMT_RCVR_STATUS(aData)
        set_RMT_RCVR_STATUS = aData
        write
    End Property

    Property Get get_LOCAL_RCVR_STATUS
        get_LOCAL_RCVR_STATUS = read_LOCAL_RCVR_STATUS_value
    End Property

    Property Let set_LOCAL_RCVR_STATUS(aData)
        write_LOCAL_RCVR_STATUS_value = aData
        flag_LOCAL_RCVR_STATUS        = &H1
    End Property

    Property Get read_LOCAL_RCVR_STATUS
        read
        read_LOCAL_RCVR_STATUS = read_LOCAL_RCVR_STATUS_value
    End Property

    Property Let write_LOCAL_RCVR_STATUS(aData)
        set_LOCAL_RCVR_STATUS = aData
        write
    End Property

    Property Get get_LOCKED
        get_LOCKED = read_LOCKED_value
    End Property

    Property Let set_LOCKED(aData)
        write_LOCKED_value = aData
        flag_LOCKED        = &H1
    End Property

    Property Get read_LOCKED
        read
        read_LOCKED = read_LOCKED_value
    End Property

    Property Let write_LOCKED(aData)
        set_LOCKED = aData
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

    Property Get get_CRC_ERR_DET
        get_CRC_ERR_DET = read_CRC_ERR_DET_value
    End Property

    Property Let set_CRC_ERR_DET(aData)
        write_CRC_ERR_DET_value = aData
        flag_CRC_ERR_DET        = &H1
    End Property

    Property Get read_CRC_ERR_DET
        read
        read_CRC_ERR_DET = read_CRC_ERR_DET_value
    End Property

    Property Let write_CRC_ERR_DET(aData)
        set_CRC_ERR_DET = aData
        write
    End Property

    Property Get get_BAD_SSD_DET_CR
        get_BAD_SSD_DET_CR = read_BAD_SSD_DET_CR_value
    End Property

    Property Let set_BAD_SSD_DET_CR(aData)
        write_BAD_SSD_DET_CR_value = aData
        flag_BAD_SSD_DET_CR        = &H1
    End Property

    Property Get read_BAD_SSD_DET_CR
        read
        read_BAD_SSD_DET_CR = read_BAD_SSD_DET_CR_value
    End Property

    Property Let write_BAD_SSD_DET_CR(aData)
        set_BAD_SSD_DET_CR = aData
        write
    End Property

    Property Get get_RCV_ERR_DET
        get_RCV_ERR_DET = read_RCV_ERR_DET_value
    End Property

    Property Let set_RCV_ERR_DET(aData)
        write_RCV_ERR_DET_value = aData
        flag_RCV_ERR_DET        = &H1
    End Property

    Property Get read_RCV_ERR_DET
        read
        read_RCV_ERR_DET = read_RCV_ERR_DET_value
    End Property

    Property Let write_RCV_ERR_DET(aData)
        set_RCV_ERR_DET = aData
        write
    End Property

    Property Get get_TX_ERR_DET
        get_TX_ERR_DET = read_TX_ERR_DET_value
    End Property

    Property Let set_TX_ERR_DET(aData)
        write_TX_ERR_DET_value = aData
        flag_TX_ERR_DET        = &H1
    End Property

    Property Get read_TX_ERR_DET
        read
        read_TX_ERR_DET = read_TX_ERR_DET_value
    End Property

    Property Let write_TX_ERR_DET(aData)
        set_TX_ERR_DET = aData
        write
    End Property

    Property Get get_LOCK_ERR_DET
        get_LOCK_ERR_DET = read_LOCK_ERR_DET_value
    End Property

    Property Let set_LOCK_ERR_DET(aData)
        write_LOCK_ERR_DET_value = aData
        flag_LOCK_ERR_DET        = &H1
    End Property

    Property Get read_LOCK_ERR_DET
        read
        read_LOCK_ERR_DET = read_LOCK_ERR_DET_value
    End Property

    Property Let write_LOCK_ERR_DET(aData)
        set_LOCK_ERR_DET = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_INT_STATUS_value = rightShift(data_low, 12) and &H1
        read_RMT_RCVR_STATUS_value = rightShift(data_low, 11) and &H1
        read_LOCAL_RCVR_STATUS_value = rightShift(data_low, 10) and &H1
        read_LOCKED_value = rightShift(data_low, 9) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 8) and &H1
        read_CRC_ERR_DET_value = rightShift(data_low, 7) and &H1
        read_BAD_SSD_DET_CR_value = rightShift(data_low, 5) and &H1
        read_RCV_ERR_DET_value = rightShift(data_low, 3) and &H1
        read_TX_ERR_DET_value = rightShift(data_low, 2) and &H1
        read_LOCK_ERR_DET_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_INT_STATUS = &H0 or flag_RMT_RCVR_STATUS = &H0 or flag_LOCAL_RCVR_STATUS = &H0 or flag_LOCKED = &H0 or flag_LINK_STATUS = &H0 or flag_CRC_ERR_DET = &H0 or flag_BAD_SSD_DET_CR = &H0 or flag_RCV_ERR_DET = &H0 or flag_TX_ERR_DET = &H0 or flag_LOCK_ERR_DET = &H0 Then read
        If flag_INT_STATUS = &H0 Then write_INT_STATUS_value = get_INT_STATUS
        If flag_RMT_RCVR_STATUS = &H0 Then write_RMT_RCVR_STATUS_value = get_RMT_RCVR_STATUS
        If flag_LOCAL_RCVR_STATUS = &H0 Then write_LOCAL_RCVR_STATUS_value = get_LOCAL_RCVR_STATUS
        If flag_LOCKED = &H0 Then write_LOCKED_value = get_LOCKED
        If flag_LINK_STATUS = &H0 Then write_LINK_STATUS_value = get_LINK_STATUS
        If flag_CRC_ERR_DET = &H0 Then write_CRC_ERR_DET_value = get_CRC_ERR_DET
        If flag_BAD_SSD_DET_CR = &H0 Then write_BAD_SSD_DET_CR_value = get_BAD_SSD_DET_CR
        If flag_RCV_ERR_DET = &H0 Then write_RCV_ERR_DET_value = get_RCV_ERR_DET
        If flag_TX_ERR_DET = &H0 Then write_TX_ERR_DET_value = get_TX_ERR_DET
        If flag_LOCK_ERR_DET = &H0 Then write_LOCK_ERR_DET_value = get_LOCK_ERR_DET

        regValue = leftShift((write_INT_STATUS_value and &H1), 12) + leftShift((write_RMT_RCVR_STATUS_value and &H1), 11) + leftShift((write_LOCAL_RCVR_STATUS_value and &H1), 10) + leftShift((write_LOCKED_value and &H1), 9) + leftShift((write_LINK_STATUS_value and &H1), 8) + leftShift((write_CRC_ERR_DET_value and &H1), 7) + leftShift((write_BAD_SSD_DET_CR_value and &H1), 5) + leftShift((write_RCV_ERR_DET_value and &H1), 3) + leftShift((write_TX_ERR_DET_value and &H1), 2) + leftShift((write_LOCK_ERR_DET_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_INT_STATUS_value = rightShift(data_low, 12) and &H1
        read_RMT_RCVR_STATUS_value = rightShift(data_low, 11) and &H1
        read_LOCAL_RCVR_STATUS_value = rightShift(data_low, 10) and &H1
        read_LOCKED_value = rightShift(data_low, 9) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 8) and &H1
        read_CRC_ERR_DET_value = rightShift(data_low, 7) and &H1
        read_BAD_SSD_DET_CR_value = rightShift(data_low, 5) and &H1
        read_RCV_ERR_DET_value = rightShift(data_low, 3) and &H1
        read_TX_ERR_DET_value = rightShift(data_low, 2) and &H1
        read_LOCK_ERR_DET_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_INT_STATUS_value = &H0
        flag_INT_STATUS        = &H0
        write_RMT_RCVR_STATUS_value = &H0
        flag_RMT_RCVR_STATUS        = &H0
        write_LOCAL_RCVR_STATUS_value = &H0
        flag_LOCAL_RCVR_STATUS        = &H0
        write_LOCKED_value = &H0
        flag_LOCKED        = &H0
        write_LINK_STATUS_value = &H0
        flag_LINK_STATUS        = &H0
        write_CRC_ERR_DET_value = &H0
        flag_CRC_ERR_DET        = &H0
        write_BAD_SSD_DET_CR_value = &H0
        flag_BAD_SSD_DET_CR        = &H0
        write_RCV_ERR_DET_value = &H0
        flag_RCV_ERR_DET        = &H0
        write_TX_ERR_DET_value = &H0
        flag_TX_ERR_DET        = &H0
        write_LOCK_ERR_DET_value = &H0
        flag_LOCK_ERR_DET        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RCV_ERR_CNTR                               [15:0]           get_RCV_ERR_CNTR
''                                                             set_RCV_ERR_CNTR
''                                                             read_RCV_ERR_CNTR
''                                                             write_RCV_ERR_CNTR
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base12
    Private write_RCV_ERR_CNTR_value
    Private read_RCV_ERR_CNTR_value
    Private flag_RCV_ERR_CNTR

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

    Property Get get_RCV_ERR_CNTR
        get_RCV_ERR_CNTR = read_RCV_ERR_CNTR_value
    End Property

    Property Let set_RCV_ERR_CNTR(aData)
        write_RCV_ERR_CNTR_value = aData
        flag_RCV_ERR_CNTR        = &H1
    End Property

    Property Get read_RCV_ERR_CNTR
        read
        read_RCV_ERR_CNTR = read_RCV_ERR_CNTR_value
    End Property

    Property Let write_RCV_ERR_CNTR(aData)
        set_RCV_ERR_CNTR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RCV_ERR_CNTR_mask = &Hffff
        if data_low > LONG_MAX then
            if RCV_ERR_CNTR_mask = mask then
                read_RCV_ERR_CNTR_value = data_low
            else
                read_RCV_ERR_CNTR_value = (data_low - H8000_0000) and RCV_ERR_CNTR_mask
            end If
        else
            read_RCV_ERR_CNTR_value = data_low and RCV_ERR_CNTR_mask
        end If

    End Sub

    Sub write
        If flag_RCV_ERR_CNTR = &H0 Then read
        If flag_RCV_ERR_CNTR = &H0 Then write_RCV_ERR_CNTR_value = get_RCV_ERR_CNTR

        regValue = leftShift((write_RCV_ERR_CNTR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RCV_ERR_CNTR_mask = &Hffff
        if data_low > LONG_MAX then
            if RCV_ERR_CNTR_mask = mask then
                read_RCV_ERR_CNTR_value = data_low
            else
                read_RCV_ERR_CNTR_value = (data_low - H8000_0000) and RCV_ERR_CNTR_mask
            end If
        else
            read_RCV_ERR_CNTR_value = data_low and RCV_ERR_CNTR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RCV_ERR_CNTR_value = &H0
        flag_RCV_ERR_CNTR        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FALSE_CRS_CNTR                             [7:0]            get_FALSE_CRS_CNTR
''                                                             set_FALSE_CRS_CNTR
''                                                             read_FALSE_CRS_CNTR
''                                                             write_FALSE_CRS_CNTR
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base13
    Private write_FALSE_CRS_CNTR_value
    Private read_FALSE_CRS_CNTR_value
    Private flag_FALSE_CRS_CNTR

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

    Property Get get_FALSE_CRS_CNTR
        get_FALSE_CRS_CNTR = read_FALSE_CRS_CNTR_value
    End Property

    Property Let set_FALSE_CRS_CNTR(aData)
        write_FALSE_CRS_CNTR_value = aData
        flag_FALSE_CRS_CNTR        = &H1
    End Property

    Property Get read_FALSE_CRS_CNTR
        read
        read_FALSE_CRS_CNTR = read_FALSE_CRS_CNTR_value
    End Property

    Property Let write_FALSE_CRS_CNTR(aData)
        set_FALSE_CRS_CNTR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FALSE_CRS_CNTR_mask = &Hff
        if data_low > LONG_MAX then
            if FALSE_CRS_CNTR_mask = mask then
                read_FALSE_CRS_CNTR_value = data_low
            else
                read_FALSE_CRS_CNTR_value = (data_low - H8000_0000) and FALSE_CRS_CNTR_mask
            end If
        else
            read_FALSE_CRS_CNTR_value = data_low and FALSE_CRS_CNTR_mask
        end If

    End Sub

    Sub write
        If flag_FALSE_CRS_CNTR = &H0 Then read
        If flag_FALSE_CRS_CNTR = &H0 Then write_FALSE_CRS_CNTR_value = get_FALSE_CRS_CNTR

        regValue = leftShift((write_FALSE_CRS_CNTR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FALSE_CRS_CNTR_mask = &Hff
        if data_low > LONG_MAX then
            if FALSE_CRS_CNTR_mask = mask then
                read_FALSE_CRS_CNTR_value = data_low
            else
                read_FALSE_CRS_CNTR_value = (data_low - H8000_0000) and FALSE_CRS_CNTR_mask
            end If
        else
            read_FALSE_CRS_CNTR_value = data_low and FALSE_CRS_CNTR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FALSE_CRS_CNTR_value = &H0
        flag_FALSE_CRS_CNTR        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOCAL_RCVR_NOK_CNTR                        [15:8]           get_LOCAL_RCVR_NOK_CNTR
''                                                             set_LOCAL_RCVR_NOK_CNTR
''                                                             read_LOCAL_RCVR_NOK_CNTR
''                                                             write_LOCAL_RCVR_NOK_CNTR
''---------------------------------------------------------------------------------
'' REMOTE_RCVR_NOK_CNTR                       [7:0]            get_REMOTE_RCVR_NOK_CNTR
''                                                             set_REMOTE_RCVR_NOK_CNTR
''                                                             read_REMOTE_RCVR_NOK_CNTR
''                                                             write_REMOTE_RCVR_NOK_CNTR
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base14
    Private write_LOCAL_RCVR_NOK_CNTR_value
    Private read_LOCAL_RCVR_NOK_CNTR_value
    Private flag_LOCAL_RCVR_NOK_CNTR
    Private write_REMOTE_RCVR_NOK_CNTR_value
    Private read_REMOTE_RCVR_NOK_CNTR_value
    Private flag_REMOTE_RCVR_NOK_CNTR

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

    Property Get get_LOCAL_RCVR_NOK_CNTR
        get_LOCAL_RCVR_NOK_CNTR = read_LOCAL_RCVR_NOK_CNTR_value
    End Property

    Property Let set_LOCAL_RCVR_NOK_CNTR(aData)
        write_LOCAL_RCVR_NOK_CNTR_value = aData
        flag_LOCAL_RCVR_NOK_CNTR        = &H1
    End Property

    Property Get read_LOCAL_RCVR_NOK_CNTR
        read
        read_LOCAL_RCVR_NOK_CNTR = read_LOCAL_RCVR_NOK_CNTR_value
    End Property

    Property Let write_LOCAL_RCVR_NOK_CNTR(aData)
        set_LOCAL_RCVR_NOK_CNTR = aData
        write
    End Property

    Property Get get_REMOTE_RCVR_NOK_CNTR
        get_REMOTE_RCVR_NOK_CNTR = read_REMOTE_RCVR_NOK_CNTR_value
    End Property

    Property Let set_REMOTE_RCVR_NOK_CNTR(aData)
        write_REMOTE_RCVR_NOK_CNTR_value = aData
        flag_REMOTE_RCVR_NOK_CNTR        = &H1
    End Property

    Property Get read_REMOTE_RCVR_NOK_CNTR
        read
        read_REMOTE_RCVR_NOK_CNTR = read_REMOTE_RCVR_NOK_CNTR_value
    End Property

    Property Let write_REMOTE_RCVR_NOK_CNTR(aData)
        set_REMOTE_RCVR_NOK_CNTR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_RCVR_NOK_CNTR_value = rightShift(data_low, 8) and &Hff
        REMOTE_RCVR_NOK_CNTR_mask = &Hff
        if data_low > LONG_MAX then
            if REMOTE_RCVR_NOK_CNTR_mask = mask then
                read_REMOTE_RCVR_NOK_CNTR_value = data_low
            else
                read_REMOTE_RCVR_NOK_CNTR_value = (data_low - H8000_0000) and REMOTE_RCVR_NOK_CNTR_mask
            end If
        else
            read_REMOTE_RCVR_NOK_CNTR_value = data_low and REMOTE_RCVR_NOK_CNTR_mask
        end If

    End Sub

    Sub write
        If flag_LOCAL_RCVR_NOK_CNTR = &H0 or flag_REMOTE_RCVR_NOK_CNTR = &H0 Then read
        If flag_LOCAL_RCVR_NOK_CNTR = &H0 Then write_LOCAL_RCVR_NOK_CNTR_value = get_LOCAL_RCVR_NOK_CNTR
        If flag_REMOTE_RCVR_NOK_CNTR = &H0 Then write_REMOTE_RCVR_NOK_CNTR_value = get_REMOTE_RCVR_NOK_CNTR

        regValue = leftShift((write_LOCAL_RCVR_NOK_CNTR_value and &Hff), 8) + leftShift((write_REMOTE_RCVR_NOK_CNTR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LOCAL_RCVR_NOK_CNTR_value = rightShift(data_low, 8) and &Hff
        REMOTE_RCVR_NOK_CNTR_mask = &Hff
        if data_low > LONG_MAX then
            if REMOTE_RCVR_NOK_CNTR_mask = mask then
                read_REMOTE_RCVR_NOK_CNTR_value = data_low
            else
                read_REMOTE_RCVR_NOK_CNTR_value = (data_low - H8000_0000) and REMOTE_RCVR_NOK_CNTR_mask
            end If
        else
            read_REMOTE_RCVR_NOK_CNTR_value = data_low and REMOTE_RCVR_NOK_CNTR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOCAL_RCVR_NOK_CNTR_value = &H0
        flag_LOCAL_RCVR_NOK_CNTR        = &H0
        write_REMOTE_RCVR_NOK_CNTR_value = &H0
        flag_REMOTE_RCVR_NOK_CNTR        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp46
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GMII_FIFO_ELASTICITY                       [15:14]          get_GMII_FIFO_ELASTICITY
''                                                             set_GMII_FIFO_ELASTICITY
''                                                             read_GMII_FIFO_ELASTICITY
''                                                             write_GMII_FIFO_ELASTICITY
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp46
    Private write_GMII_FIFO_ELASTICITY_value
    Private read_GMII_FIFO_ELASTICITY_value
    Private flag_GMII_FIFO_ELASTICITY

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

    Property Get get_GMII_FIFO_ELASTICITY
        get_GMII_FIFO_ELASTICITY = read_GMII_FIFO_ELASTICITY_value
    End Property

    Property Let set_GMII_FIFO_ELASTICITY(aData)
        write_GMII_FIFO_ELASTICITY_value = aData
        flag_GMII_FIFO_ELASTICITY        = &H1
    End Property

    Property Get read_GMII_FIFO_ELASTICITY
        read
        read_GMII_FIFO_ELASTICITY = read_GMII_FIFO_ELASTICITY_value
    End Property

    Property Let write_GMII_FIFO_ELASTICITY(aData)
        set_GMII_FIFO_ELASTICITY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GMII_FIFO_ELASTICITY_value = rightShift(data_low, 14) and &H3

    End Sub

    Sub write
        If flag_GMII_FIFO_ELASTICITY = &H0 Then read
        If flag_GMII_FIFO_ELASTICITY = &H0 Then write_GMII_FIFO_ELASTICITY_value = get_GMII_FIFO_ELASTICITY

        regValue = leftShift((write_GMII_FIFO_ELASTICITY_value and &H3), 14)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GMII_FIFO_ELASTICITY_value = rightShift(data_low, 14) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GMII_FIFO_ELASTICITY_value = &H0
        flag_GMII_FIFO_ELASTICITY        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LINK_DOWN_COUNTER                          [7:0]            get_LINK_DOWN_COUNTER
''                                                             set_LINK_DOWN_COUNTER
''                                                             read_LINK_DOWN_COUNTER
''                                                             write_LINK_DOWN_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base17
    Private write_LINK_DOWN_COUNTER_value
    Private read_LINK_DOWN_COUNTER_value
    Private flag_LINK_DOWN_COUNTER

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

    Property Get get_LINK_DOWN_COUNTER
        get_LINK_DOWN_COUNTER = read_LINK_DOWN_COUNTER_value
    End Property

    Property Let set_LINK_DOWN_COUNTER(aData)
        write_LINK_DOWN_COUNTER_value = aData
        flag_LINK_DOWN_COUNTER        = &H1
    End Property

    Property Get read_LINK_DOWN_COUNTER
        read
        read_LINK_DOWN_COUNTER = read_LINK_DOWN_COUNTER_value
    End Property

    Property Let write_LINK_DOWN_COUNTER(aData)
        set_LINK_DOWN_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LINK_DOWN_COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if LINK_DOWN_COUNTER_mask = mask then
                read_LINK_DOWN_COUNTER_value = data_low
            else
                read_LINK_DOWN_COUNTER_value = (data_low - H8000_0000) and LINK_DOWN_COUNTER_mask
            end If
        else
            read_LINK_DOWN_COUNTER_value = data_low and LINK_DOWN_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_LINK_DOWN_COUNTER = &H0 Then read
        If flag_LINK_DOWN_COUNTER = &H0 Then write_LINK_DOWN_COUNTER_value = get_LINK_DOWN_COUNTER

        regValue = leftShift((write_LINK_DOWN_COUNTER_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LINK_DOWN_COUNTER_mask = &Hff
        if data_low > LONG_MAX then
            if LINK_DOWN_COUNTER_mask = mask then
                read_LINK_DOWN_COUNTER_value = data_low
            else
                read_LINK_DOWN_COUNTER_value = (data_low - H8000_0000) and LINK_DOWN_COUNTER_mask
            end If
        else
            read_LINK_DOWN_COUNTER_value = data_low and LINK_DOWN_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LINK_DOWN_COUNTER_value = &H0
        flag_LINK_DOWN_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base1a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LINK_UP                                    [14:14]          get_LINK_UP
''                                                             set_LINK_UP
''                                                             read_LINK_UP
''                                                             write_LINK_UP
''---------------------------------------------------------------------------------
'' LINK_DOWN                                  [13:13]          get_LINK_DOWN
''                                                             set_LINK_DOWN
''                                                             read_LINK_DOWN
''                                                             write_LINK_DOWN
''---------------------------------------------------------------------------------
'' EXCEED_HIGH_CNTR_THD                       [12:12]          get_EXCEED_HIGH_CNTR_THD
''                                                             set_EXCEED_HIGH_CNTR_THD
''                                                             read_EXCEED_HIGH_CNTR_THD
''                                                             write_EXCEED_HIGH_CNTR_THD
''---------------------------------------------------------------------------------
'' EXCEED_LOW_CNTR_THD                        [11:11]          get_EXCEED_LOW_CNTR_THD
''                                                             set_EXCEED_LOW_CNTR_THD
''                                                             read_EXCEED_LOW_CNTR_THD
''                                                             write_EXCEED_LOW_CNTR_THD
''---------------------------------------------------------------------------------
'' SCR_SYNC_ERROR                             [6:6]            get_SCR_SYNC_ERROR
''                                                             set_SCR_SYNC_ERROR
''                                                             read_SCR_SYNC_ERROR
''                                                             write_SCR_SYNC_ERROR
''---------------------------------------------------------------------------------
'' RMT_RCVR_STATUS_CHANGE                     [5:5]            get_RMT_RCVR_STATUS_CHANGE
''                                                             set_RMT_RCVR_STATUS_CHANGE
''                                                             read_RMT_RCVR_STATUS_CHANGE
''                                                             write_RMT_RCVR_STATUS_CHANGE
''---------------------------------------------------------------------------------
'' LOCAL_RCVR_STATUS_CHANGE                   [4:4]            get_LOCAL_RCVR_STATUS_CHANGE
''                                                             set_LOCAL_RCVR_STATUS_CHANGE
''                                                             read_LOCAL_RCVR_STATUS_CHANGE
''                                                             write_LOCAL_RCVR_STATUS_CHANGE
''---------------------------------------------------------------------------------
'' LINK_SPEED_CHANGE                          [2:2]            get_LINK_SPEED_CHANGE
''                                                             set_LINK_SPEED_CHANGE
''                                                             read_LINK_SPEED_CHANGE
''                                                             write_LINK_SPEED_CHANGE
''---------------------------------------------------------------------------------
'' LINK_STATUS_CHANGE                         [1:1]            get_LINK_STATUS_CHANGE
''                                                             set_LINK_STATUS_CHANGE
''                                                             read_LINK_STATUS_CHANGE
''                                                             write_LINK_STATUS_CHANGE
''---------------------------------------------------------------------------------
'' CRC_ERROR                                  [0:0]            get_CRC_ERROR
''                                                             set_CRC_ERROR
''                                                             read_CRC_ERROR
''                                                             write_CRC_ERROR
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base1a
    Private write_LINK_UP_value
    Private read_LINK_UP_value
    Private flag_LINK_UP
    Private write_LINK_DOWN_value
    Private read_LINK_DOWN_value
    Private flag_LINK_DOWN
    Private write_EXCEED_HIGH_CNTR_THD_value
    Private read_EXCEED_HIGH_CNTR_THD_value
    Private flag_EXCEED_HIGH_CNTR_THD
    Private write_EXCEED_LOW_CNTR_THD_value
    Private read_EXCEED_LOW_CNTR_THD_value
    Private flag_EXCEED_LOW_CNTR_THD
    Private write_SCR_SYNC_ERROR_value
    Private read_SCR_SYNC_ERROR_value
    Private flag_SCR_SYNC_ERROR
    Private write_RMT_RCVR_STATUS_CHANGE_value
    Private read_RMT_RCVR_STATUS_CHANGE_value
    Private flag_RMT_RCVR_STATUS_CHANGE
    Private write_LOCAL_RCVR_STATUS_CHANGE_value
    Private read_LOCAL_RCVR_STATUS_CHANGE_value
    Private flag_LOCAL_RCVR_STATUS_CHANGE
    Private write_LINK_SPEED_CHANGE_value
    Private read_LINK_SPEED_CHANGE_value
    Private flag_LINK_SPEED_CHANGE
    Private write_LINK_STATUS_CHANGE_value
    Private read_LINK_STATUS_CHANGE_value
    Private flag_LINK_STATUS_CHANGE
    Private write_CRC_ERROR_value
    Private read_CRC_ERROR_value
    Private flag_CRC_ERROR

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

    Property Get get_LINK_UP
        get_LINK_UP = read_LINK_UP_value
    End Property

    Property Let set_LINK_UP(aData)
        write_LINK_UP_value = aData
        flag_LINK_UP        = &H1
    End Property

    Property Get read_LINK_UP
        read
        read_LINK_UP = read_LINK_UP_value
    End Property

    Property Let write_LINK_UP(aData)
        set_LINK_UP = aData
        write
    End Property

    Property Get get_LINK_DOWN
        get_LINK_DOWN = read_LINK_DOWN_value
    End Property

    Property Let set_LINK_DOWN(aData)
        write_LINK_DOWN_value = aData
        flag_LINK_DOWN        = &H1
    End Property

    Property Get read_LINK_DOWN
        read
        read_LINK_DOWN = read_LINK_DOWN_value
    End Property

    Property Let write_LINK_DOWN(aData)
        set_LINK_DOWN = aData
        write
    End Property

    Property Get get_EXCEED_HIGH_CNTR_THD
        get_EXCEED_HIGH_CNTR_THD = read_EXCEED_HIGH_CNTR_THD_value
    End Property

    Property Let set_EXCEED_HIGH_CNTR_THD(aData)
        write_EXCEED_HIGH_CNTR_THD_value = aData
        flag_EXCEED_HIGH_CNTR_THD        = &H1
    End Property

    Property Get read_EXCEED_HIGH_CNTR_THD
        read
        read_EXCEED_HIGH_CNTR_THD = read_EXCEED_HIGH_CNTR_THD_value
    End Property

    Property Let write_EXCEED_HIGH_CNTR_THD(aData)
        set_EXCEED_HIGH_CNTR_THD = aData
        write
    End Property

    Property Get get_EXCEED_LOW_CNTR_THD
        get_EXCEED_LOW_CNTR_THD = read_EXCEED_LOW_CNTR_THD_value
    End Property

    Property Let set_EXCEED_LOW_CNTR_THD(aData)
        write_EXCEED_LOW_CNTR_THD_value = aData
        flag_EXCEED_LOW_CNTR_THD        = &H1
    End Property

    Property Get read_EXCEED_LOW_CNTR_THD
        read
        read_EXCEED_LOW_CNTR_THD = read_EXCEED_LOW_CNTR_THD_value
    End Property

    Property Let write_EXCEED_LOW_CNTR_THD(aData)
        set_EXCEED_LOW_CNTR_THD = aData
        write
    End Property

    Property Get get_SCR_SYNC_ERROR
        get_SCR_SYNC_ERROR = read_SCR_SYNC_ERROR_value
    End Property

    Property Let set_SCR_SYNC_ERROR(aData)
        write_SCR_SYNC_ERROR_value = aData
        flag_SCR_SYNC_ERROR        = &H1
    End Property

    Property Get read_SCR_SYNC_ERROR
        read
        read_SCR_SYNC_ERROR = read_SCR_SYNC_ERROR_value
    End Property

    Property Let write_SCR_SYNC_ERROR(aData)
        set_SCR_SYNC_ERROR = aData
        write
    End Property

    Property Get get_RMT_RCVR_STATUS_CHANGE
        get_RMT_RCVR_STATUS_CHANGE = read_RMT_RCVR_STATUS_CHANGE_value
    End Property

    Property Let set_RMT_RCVR_STATUS_CHANGE(aData)
        write_RMT_RCVR_STATUS_CHANGE_value = aData
        flag_RMT_RCVR_STATUS_CHANGE        = &H1
    End Property

    Property Get read_RMT_RCVR_STATUS_CHANGE
        read
        read_RMT_RCVR_STATUS_CHANGE = read_RMT_RCVR_STATUS_CHANGE_value
    End Property

    Property Let write_RMT_RCVR_STATUS_CHANGE(aData)
        set_RMT_RCVR_STATUS_CHANGE = aData
        write
    End Property

    Property Get get_LOCAL_RCVR_STATUS_CHANGE
        get_LOCAL_RCVR_STATUS_CHANGE = read_LOCAL_RCVR_STATUS_CHANGE_value
    End Property

    Property Let set_LOCAL_RCVR_STATUS_CHANGE(aData)
        write_LOCAL_RCVR_STATUS_CHANGE_value = aData
        flag_LOCAL_RCVR_STATUS_CHANGE        = &H1
    End Property

    Property Get read_LOCAL_RCVR_STATUS_CHANGE
        read
        read_LOCAL_RCVR_STATUS_CHANGE = read_LOCAL_RCVR_STATUS_CHANGE_value
    End Property

    Property Let write_LOCAL_RCVR_STATUS_CHANGE(aData)
        set_LOCAL_RCVR_STATUS_CHANGE = aData
        write
    End Property

    Property Get get_LINK_SPEED_CHANGE
        get_LINK_SPEED_CHANGE = read_LINK_SPEED_CHANGE_value
    End Property

    Property Let set_LINK_SPEED_CHANGE(aData)
        write_LINK_SPEED_CHANGE_value = aData
        flag_LINK_SPEED_CHANGE        = &H1
    End Property

    Property Get read_LINK_SPEED_CHANGE
        read
        read_LINK_SPEED_CHANGE = read_LINK_SPEED_CHANGE_value
    End Property

    Property Let write_LINK_SPEED_CHANGE(aData)
        set_LINK_SPEED_CHANGE = aData
        write
    End Property

    Property Get get_LINK_STATUS_CHANGE
        get_LINK_STATUS_CHANGE = read_LINK_STATUS_CHANGE_value
    End Property

    Property Let set_LINK_STATUS_CHANGE(aData)
        write_LINK_STATUS_CHANGE_value = aData
        flag_LINK_STATUS_CHANGE        = &H1
    End Property

    Property Get read_LINK_STATUS_CHANGE
        read
        read_LINK_STATUS_CHANGE = read_LINK_STATUS_CHANGE_value
    End Property

    Property Let write_LINK_STATUS_CHANGE(aData)
        set_LINK_STATUS_CHANGE = aData
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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LINK_UP_value = rightShift(data_low, 14) and &H1
        read_LINK_DOWN_value = rightShift(data_low, 13) and &H1
        read_EXCEED_HIGH_CNTR_THD_value = rightShift(data_low, 12) and &H1
        read_EXCEED_LOW_CNTR_THD_value = rightShift(data_low, 11) and &H1
        read_SCR_SYNC_ERROR_value = rightShift(data_low, 6) and &H1
        read_RMT_RCVR_STATUS_CHANGE_value = rightShift(data_low, 5) and &H1
        read_LOCAL_RCVR_STATUS_CHANGE_value = rightShift(data_low, 4) and &H1
        read_LINK_SPEED_CHANGE_value = rightShift(data_low, 2) and &H1
        read_LINK_STATUS_CHANGE_value = rightShift(data_low, 1) and &H1
        CRC_ERROR_mask = &H1
        if data_low > LONG_MAX then
            if CRC_ERROR_mask = mask then
                read_CRC_ERROR_value = data_low
            else
                read_CRC_ERROR_value = (data_low - H8000_0000) and CRC_ERROR_mask
            end If
        else
            read_CRC_ERROR_value = data_low and CRC_ERROR_mask
        end If

    End Sub

    Sub write
        If flag_LINK_UP = &H0 or flag_LINK_DOWN = &H0 or flag_EXCEED_HIGH_CNTR_THD = &H0 or flag_EXCEED_LOW_CNTR_THD = &H0 or flag_SCR_SYNC_ERROR = &H0 or flag_RMT_RCVR_STATUS_CHANGE = &H0 or flag_LOCAL_RCVR_STATUS_CHANGE = &H0 or flag_LINK_SPEED_CHANGE = &H0 or flag_LINK_STATUS_CHANGE = &H0 or flag_CRC_ERROR = &H0 Then read
        If flag_LINK_UP = &H0 Then write_LINK_UP_value = get_LINK_UP
        If flag_LINK_DOWN = &H0 Then write_LINK_DOWN_value = get_LINK_DOWN
        If flag_EXCEED_HIGH_CNTR_THD = &H0 Then write_EXCEED_HIGH_CNTR_THD_value = get_EXCEED_HIGH_CNTR_THD
        If flag_EXCEED_LOW_CNTR_THD = &H0 Then write_EXCEED_LOW_CNTR_THD_value = get_EXCEED_LOW_CNTR_THD
        If flag_SCR_SYNC_ERROR = &H0 Then write_SCR_SYNC_ERROR_value = get_SCR_SYNC_ERROR
        If flag_RMT_RCVR_STATUS_CHANGE = &H0 Then write_RMT_RCVR_STATUS_CHANGE_value = get_RMT_RCVR_STATUS_CHANGE
        If flag_LOCAL_RCVR_STATUS_CHANGE = &H0 Then write_LOCAL_RCVR_STATUS_CHANGE_value = get_LOCAL_RCVR_STATUS_CHANGE
        If flag_LINK_SPEED_CHANGE = &H0 Then write_LINK_SPEED_CHANGE_value = get_LINK_SPEED_CHANGE
        If flag_LINK_STATUS_CHANGE = &H0 Then write_LINK_STATUS_CHANGE_value = get_LINK_STATUS_CHANGE
        If flag_CRC_ERROR = &H0 Then write_CRC_ERROR_value = get_CRC_ERROR

        regValue = leftShift((write_LINK_UP_value and &H1), 14) + leftShift((write_LINK_DOWN_value and &H1), 13) + leftShift((write_EXCEED_HIGH_CNTR_THD_value and &H1), 12) + leftShift((write_EXCEED_LOW_CNTR_THD_value and &H1), 11) + leftShift((write_SCR_SYNC_ERROR_value and &H1), 6) + leftShift((write_RMT_RCVR_STATUS_CHANGE_value and &H1), 5) + leftShift((write_LOCAL_RCVR_STATUS_CHANGE_value and &H1), 4) + leftShift((write_LINK_SPEED_CHANGE_value and &H1), 2) + leftShift((write_LINK_STATUS_CHANGE_value and &H1), 1) + leftShift((write_CRC_ERROR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LINK_UP_value = rightShift(data_low, 14) and &H1
        read_LINK_DOWN_value = rightShift(data_low, 13) and &H1
        read_EXCEED_HIGH_CNTR_THD_value = rightShift(data_low, 12) and &H1
        read_EXCEED_LOW_CNTR_THD_value = rightShift(data_low, 11) and &H1
        read_SCR_SYNC_ERROR_value = rightShift(data_low, 6) and &H1
        read_RMT_RCVR_STATUS_CHANGE_value = rightShift(data_low, 5) and &H1
        read_LOCAL_RCVR_STATUS_CHANGE_value = rightShift(data_low, 4) and &H1
        read_LINK_SPEED_CHANGE_value = rightShift(data_low, 2) and &H1
        read_LINK_STATUS_CHANGE_value = rightShift(data_low, 1) and &H1
        CRC_ERROR_mask = &H1
        if data_low > LONG_MAX then
            if CRC_ERROR_mask = mask then
                read_CRC_ERROR_value = data_low
            else
                read_CRC_ERROR_value = (data_low - H8000_0000) and CRC_ERROR_mask
            end If
        else
            read_CRC_ERROR_value = data_low and CRC_ERROR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LINK_UP_value = &H0
        flag_LINK_UP        = &H0
        write_LINK_DOWN_value = &H0
        flag_LINK_DOWN        = &H0
        write_EXCEED_HIGH_CNTR_THD_value = &H0
        flag_EXCEED_HIGH_CNTR_THD        = &H0
        write_EXCEED_LOW_CNTR_THD_value = &H0
        flag_EXCEED_LOW_CNTR_THD        = &H0
        write_SCR_SYNC_ERROR_value = &H0
        flag_SCR_SYNC_ERROR        = &H0
        write_RMT_RCVR_STATUS_CHANGE_value = &H0
        flag_RMT_RCVR_STATUS_CHANGE        = &H0
        write_LOCAL_RCVR_STATUS_CHANGE_value = &H0
        flag_LOCAL_RCVR_STATUS_CHANGE        = &H0
        write_LINK_SPEED_CHANGE_value = &H0
        flag_LINK_SPEED_CHANGE        = &H0
        write_LINK_STATUS_CHANGE_value = &H0
        flag_LINK_STATUS_CHANGE        = &H0
        write_CRC_ERROR_value = &H0
        flag_CRC_ERROR        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base1b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' INT_MASK_VECTOR                            [15:0]           get_INT_MASK_VECTOR
''                                                             set_INT_MASK_VECTOR
''                                                             read_INT_MASK_VECTOR
''                                                             write_INT_MASK_VECTOR
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base1b
    Private write_INT_MASK_VECTOR_value
    Private read_INT_MASK_VECTOR_value
    Private flag_INT_MASK_VECTOR

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

    Property Get get_INT_MASK_VECTOR
        get_INT_MASK_VECTOR = read_INT_MASK_VECTOR_value
    End Property

    Property Let set_INT_MASK_VECTOR(aData)
        write_INT_MASK_VECTOR_value = aData
        flag_INT_MASK_VECTOR        = &H1
    End Property

    Property Get read_INT_MASK_VECTOR
        read
        read_INT_MASK_VECTOR = read_INT_MASK_VECTOR_value
    End Property

    Property Let write_INT_MASK_VECTOR(aData)
        set_INT_MASK_VECTOR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        INT_MASK_VECTOR_mask = &Hffff
        if data_low > LONG_MAX then
            if INT_MASK_VECTOR_mask = mask then
                read_INT_MASK_VECTOR_value = data_low
            else
                read_INT_MASK_VECTOR_value = (data_low - H8000_0000) and INT_MASK_VECTOR_mask
            end If
        else
            read_INT_MASK_VECTOR_value = data_low and INT_MASK_VECTOR_mask
        end If

    End Sub

    Sub write
        If flag_INT_MASK_VECTOR = &H0 Then read
        If flag_INT_MASK_VECTOR = &H0 Then write_INT_MASK_VECTOR_value = get_INT_MASK_VECTOR

        regValue = leftShift((write_INT_MASK_VECTOR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        INT_MASK_VECTOR_mask = &Hffff
        if data_low > LONG_MAX then
            if INT_MASK_VECTOR_mask = mask then
                read_INT_MASK_VECTOR_value = data_low
            else
                read_INT_MASK_VECTOR_value = (data_low - H8000_0000) and INT_MASK_VECTOR_mask
            end If
        else
            read_INT_MASK_VECTOR_value = data_low and INT_MASK_VECTOR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_INT_MASK_VECTOR_value = &H0
        flag_INT_MASK_VECTOR        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base1e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CRC_ERR_CNT                                [15:15]          get_CRC_ERR_CNT
''                                                             set_CRC_ERR_CNT
''                                                             read_CRC_ERR_CNT
''                                                             write_CRC_ERR_CNT
''---------------------------------------------------------------------------------
'' TX_ERR_CODE                                [14:14]          get_TX_ERR_CODE
''                                                             set_TX_ERR_CODE
''                                                             read_TX_ERR_CODE
''                                                             write_TX_ERR_CODE
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base1e
    Private write_CRC_ERR_CNT_value
    Private read_CRC_ERR_CNT_value
    Private flag_CRC_ERR_CNT
    Private write_TX_ERR_CODE_value
    Private read_TX_ERR_CODE_value
    Private flag_TX_ERR_CODE

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

    Property Get get_CRC_ERR_CNT
        get_CRC_ERR_CNT = read_CRC_ERR_CNT_value
    End Property

    Property Let set_CRC_ERR_CNT(aData)
        write_CRC_ERR_CNT_value = aData
        flag_CRC_ERR_CNT        = &H1
    End Property

    Property Get read_CRC_ERR_CNT
        read
        read_CRC_ERR_CNT = read_CRC_ERR_CNT_value
    End Property

    Property Let write_CRC_ERR_CNT(aData)
        set_CRC_ERR_CNT = aData
        write
    End Property

    Property Get get_TX_ERR_CODE
        get_TX_ERR_CODE = read_TX_ERR_CODE_value
    End Property

    Property Let set_TX_ERR_CODE(aData)
        write_TX_ERR_CODE_value = aData
        flag_TX_ERR_CODE        = &H1
    End Property

    Property Get read_TX_ERR_CODE
        read
        read_TX_ERR_CODE = read_TX_ERR_CODE_value
    End Property

    Property Let write_TX_ERR_CODE(aData)
        set_TX_ERR_CODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CRC_ERR_CNT_value = rightShift(data_low, 15) and &H1
        read_TX_ERR_CODE_value = rightShift(data_low, 14) and &H1

    End Sub

    Sub write
        If flag_CRC_ERR_CNT = &H0 or flag_TX_ERR_CODE = &H0 Then read
        If flag_CRC_ERR_CNT = &H0 Then write_CRC_ERR_CNT_value = get_CRC_ERR_CNT
        If flag_TX_ERR_CODE = &H0 Then write_TX_ERR_CODE_value = get_TX_ERR_CODE

        regValue = leftShift((write_CRC_ERR_CNT_value and &H1), 15) + leftShift((write_TX_ERR_CODE_value and &H1), 14)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CRC_ERR_CNT_value = rightShift(data_low, 15) and &H1
        read_TX_ERR_CODE_value = rightShift(data_low, 14) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CRC_ERR_CNT_value = &H0
        flag_CRC_ERR_CNT        = &H0
        write_TX_ERR_CODE_value = &H0
        flag_TX_ERR_CODE        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_base1f
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SAME_SCR_SEEDS                             [4:4]            get_SAME_SCR_SEEDS
''                                                             set_SAME_SCR_SEEDS
''                                                             read_SAME_SCR_SEEDS
''                                                             write_SAME_SCR_SEEDS
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_base1f
    Private write_SAME_SCR_SEEDS_value
    Private read_SAME_SCR_SEEDS_value
    Private flag_SAME_SCR_SEEDS

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

    Property Get get_SAME_SCR_SEEDS
        get_SAME_SCR_SEEDS = read_SAME_SCR_SEEDS_value
    End Property

    Property Let set_SAME_SCR_SEEDS(aData)
        write_SAME_SCR_SEEDS_value = aData
        flag_SAME_SCR_SEEDS        = &H1
    End Property

    Property Get read_SAME_SCR_SEEDS
        read
        read_SAME_SCR_SEEDS = read_SAME_SCR_SEEDS_value
    End Property

    Property Let write_SAME_SCR_SEEDS(aData)
        set_SAME_SCR_SEEDS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SAME_SCR_SEEDS_value = rightShift(data_low, 4) and &H1

    End Sub

    Sub write
        If flag_SAME_SCR_SEEDS = &H0 Then read
        If flag_SAME_SCR_SEEDS = &H0 Then write_SAME_SCR_SEEDS_value = get_SAME_SCR_SEEDS

        regValue = leftShift((write_SAME_SCR_SEEDS_value and &H1), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SAME_SCR_SEEDS_value = rightShift(data_low, 4) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SAME_SCR_SEEDS_value = &H0
        flag_SAME_SCR_SEEDS        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd1c_02
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHD1C_SEL                                  [14:10]          get_SHD1C_SEL
''                                                             set_SHD1C_SEL
''                                                             read_SHD1C_SEL
''                                                             write_SHD1C_SEL
''---------------------------------------------------------------------------------
'' LINK_LED                                   [0:0]            get_LINK_LED
''                                                             set_LINK_LED
''                                                             read_LINK_LED
''                                                             write_LINK_LED
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd1c_02
    Private write_SHD1C_SEL_value
    Private read_SHD1C_SEL_value
    Private flag_SHD1C_SEL
    Private write_LINK_LED_value
    Private read_LINK_LED_value
    Private flag_LINK_LED

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

    Property Get get_SHD1C_SEL
        get_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let set_SHD1C_SEL(aData)
        write_SHD1C_SEL_value = aData
        flag_SHD1C_SEL        = &H1
    End Property

    Property Get read_SHD1C_SEL
        read
        read_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let write_SHD1C_SEL(aData)
        set_SHD1C_SEL = aData
        write
    End Property

    Property Get get_LINK_LED
        get_LINK_LED = read_LINK_LED_value
    End Property

    Property Let set_LINK_LED(aData)
        write_LINK_LED_value = aData
        flag_LINK_LED        = &H1
    End Property

    Property Get read_LINK_LED
        read
        read_LINK_LED = read_LINK_LED_value
    End Property

    Property Let write_LINK_LED(aData)
        set_LINK_LED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        LINK_LED_mask = &H1
        if data_low > LONG_MAX then
            if LINK_LED_mask = mask then
                read_LINK_LED_value = data_low
            else
                read_LINK_LED_value = (data_low - H8000_0000) and LINK_LED_mask
            end If
        else
            read_LINK_LED_value = data_low and LINK_LED_mask
        end If

    End Sub

    Sub write
        If flag_SHD1C_SEL = &H0 or flag_LINK_LED = &H0 Then read
        If flag_SHD1C_SEL = &H0 Then write_SHD1C_SEL_value = get_SHD1C_SEL
        If flag_LINK_LED = &H0 Then write_LINK_LED_value = get_LINK_LED

        regValue = leftShift((write_SHD1C_SEL_value and &H1f), 10) + leftShift((write_LINK_LED_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        LINK_LED_mask = &H1
        if data_low > LONG_MAX then
            if LINK_LED_mask = mask then
                read_LINK_LED_value = data_low
            else
                read_LINK_LED_value = (data_low - H8000_0000) and LINK_LED_mask
            end If
        else
            read_LINK_LED_value = data_low and LINK_LED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHD1C_SEL_value = &H0
        flag_SHD1C_SEL        = &H0
        write_LINK_LED_value = &H0
        flag_LINK_LED        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd1c_08
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHD1C_SEL                                  [14:10]          get_SHD1C_SEL
''                                                             set_SHD1C_SEL
''                                                             read_SHD1C_SEL
''                                                             write_SHD1C_SEL
''---------------------------------------------------------------------------------
'' INTR_N                                     [6:6]            get_INTR_N
''                                                             set_INTR_N
''                                                             read_INTR_N
''                                                             write_INTR_N
''---------------------------------------------------------------------------------
'' LINKSPD_N                                  [4:3]            get_LINKSPD_N
''                                                             set_LINKSPD_N
''                                                             read_LINKSPD_N
''                                                             write_LINKSPD_N
''---------------------------------------------------------------------------------
'' TRANSMIT_LED                               [2:2]            get_TRANSMIT_LED
''                                                             set_TRANSMIT_LED
''                                                             read_TRANSMIT_LED
''                                                             write_TRANSMIT_LED
''---------------------------------------------------------------------------------
'' ACTIVITY_LED                               [1:1]            get_ACTIVITY_LED
''                                                             set_ACTIVITY_LED
''                                                             read_ACTIVITY_LED
''                                                             write_ACTIVITY_LED
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd1c_08
    Private write_SHD1C_SEL_value
    Private read_SHD1C_SEL_value
    Private flag_SHD1C_SEL
    Private write_INTR_N_value
    Private read_INTR_N_value
    Private flag_INTR_N
    Private write_LINKSPD_N_value
    Private read_LINKSPD_N_value
    Private flag_LINKSPD_N
    Private write_TRANSMIT_LED_value
    Private read_TRANSMIT_LED_value
    Private flag_TRANSMIT_LED
    Private write_ACTIVITY_LED_value
    Private read_ACTIVITY_LED_value
    Private flag_ACTIVITY_LED

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

    Property Get get_SHD1C_SEL
        get_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let set_SHD1C_SEL(aData)
        write_SHD1C_SEL_value = aData
        flag_SHD1C_SEL        = &H1
    End Property

    Property Get read_SHD1C_SEL
        read
        read_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let write_SHD1C_SEL(aData)
        set_SHD1C_SEL = aData
        write
    End Property

    Property Get get_INTR_N
        get_INTR_N = read_INTR_N_value
    End Property

    Property Let set_INTR_N(aData)
        write_INTR_N_value = aData
        flag_INTR_N        = &H1
    End Property

    Property Get read_INTR_N
        read
        read_INTR_N = read_INTR_N_value
    End Property

    Property Let write_INTR_N(aData)
        set_INTR_N = aData
        write
    End Property

    Property Get get_LINKSPD_N
        get_LINKSPD_N = read_LINKSPD_N_value
    End Property

    Property Let set_LINKSPD_N(aData)
        write_LINKSPD_N_value = aData
        flag_LINKSPD_N        = &H1
    End Property

    Property Get read_LINKSPD_N
        read
        read_LINKSPD_N = read_LINKSPD_N_value
    End Property

    Property Let write_LINKSPD_N(aData)
        set_LINKSPD_N = aData
        write
    End Property

    Property Get get_TRANSMIT_LED
        get_TRANSMIT_LED = read_TRANSMIT_LED_value
    End Property

    Property Let set_TRANSMIT_LED(aData)
        write_TRANSMIT_LED_value = aData
        flag_TRANSMIT_LED        = &H1
    End Property

    Property Get read_TRANSMIT_LED
        read
        read_TRANSMIT_LED = read_TRANSMIT_LED_value
    End Property

    Property Let write_TRANSMIT_LED(aData)
        set_TRANSMIT_LED = aData
        write
    End Property

    Property Get get_ACTIVITY_LED
        get_ACTIVITY_LED = read_ACTIVITY_LED_value
    End Property

    Property Let set_ACTIVITY_LED(aData)
        write_ACTIVITY_LED_value = aData
        flag_ACTIVITY_LED        = &H1
    End Property

    Property Get read_ACTIVITY_LED
        read
        read_ACTIVITY_LED = read_ACTIVITY_LED_value
    End Property

    Property Let write_ACTIVITY_LED(aData)
        set_ACTIVITY_LED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_INTR_N_value = rightShift(data_low, 6) and &H1
        read_LINKSPD_N_value = rightShift(data_low, 3) and &H3
        read_TRANSMIT_LED_value = rightShift(data_low, 2) and &H1
        read_ACTIVITY_LED_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_SHD1C_SEL = &H0 or flag_INTR_N = &H0 or flag_LINKSPD_N = &H0 or flag_TRANSMIT_LED = &H0 or flag_ACTIVITY_LED = &H0 Then read
        If flag_SHD1C_SEL = &H0 Then write_SHD1C_SEL_value = get_SHD1C_SEL
        If flag_INTR_N = &H0 Then write_INTR_N_value = get_INTR_N
        If flag_LINKSPD_N = &H0 Then write_LINKSPD_N_value = get_LINKSPD_N
        If flag_TRANSMIT_LED = &H0 Then write_TRANSMIT_LED_value = get_TRANSMIT_LED
        If flag_ACTIVITY_LED = &H0 Then write_ACTIVITY_LED_value = get_ACTIVITY_LED

        regValue = leftShift((write_SHD1C_SEL_value and &H1f), 10) + leftShift((write_INTR_N_value and &H1), 6) + leftShift((write_LINKSPD_N_value and &H3), 3) + leftShift((write_TRANSMIT_LED_value and &H1), 2) + leftShift((write_ACTIVITY_LED_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_INTR_N_value = rightShift(data_low, 6) and &H1
        read_LINKSPD_N_value = rightShift(data_low, 3) and &H3
        read_TRANSMIT_LED_value = rightShift(data_low, 2) and &H1
        read_ACTIVITY_LED_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHD1C_SEL_value = &H0
        flag_SHD1C_SEL        = &H0
        write_INTR_N_value = &H0
        flag_INTR_N        = &H0
        write_LINKSPD_N_value = &H0
        flag_LINKSPD_N        = &H0
        write_TRANSMIT_LED_value = &H0
        flag_TRANSMIT_LED        = &H0
        write_ACTIVITY_LED_value = &H0
        flag_ACTIVITY_LED        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd1c_09
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHD1C_SEL                                  [14:10]          get_SHD1C_SEL
''                                                             set_SHD1C_SEL
''                                                             read_SHD1C_SEL
''                                                             write_SHD1C_SEL
''---------------------------------------------------------------------------------
'' LPBK_LED_EN                                [9:9]            get_LPBK_LED_EN
''                                                             set_LPBK_LED_EN
''                                                             read_LPBK_LED_EN
''                                                             write_LPBK_LED_EN
''---------------------------------------------------------------------------------
'' ACT_LINK_MSB                               [8:8]            get_ACT_LINK_MSB
''                                                             set_ACT_LINK_MSB
''                                                             read_ACT_LINK_MSB
''                                                             write_ACT_LINK_MSB
''---------------------------------------------------------------------------------
'' SPARE_REG                                  [7:7]            get_SPARE_REG
''                                                             set_SPARE_REG
''                                                             read_SPARE_REG
''                                                             write_SPARE_REG
''---------------------------------------------------------------------------------
'' ACT_LINK_LSB                               [4:4]            get_ACT_LINK_LSB
''                                                             set_ACT_LINK_LSB
''                                                             read_ACT_LINK_LSB
''                                                             write_ACT_LINK_LSB
''---------------------------------------------------------------------------------
'' ACTIVITY_LED_EN                            [3:3]            get_ACTIVITY_LED_EN
''                                                             set_ACTIVITY_LED_EN
''                                                             read_ACTIVITY_LED_EN
''                                                             write_ACTIVITY_LED_EN
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd1c_09
    Private write_SHD1C_SEL_value
    Private read_SHD1C_SEL_value
    Private flag_SHD1C_SEL
    Private write_LPBK_LED_EN_value
    Private read_LPBK_LED_EN_value
    Private flag_LPBK_LED_EN
    Private write_ACT_LINK_MSB_value
    Private read_ACT_LINK_MSB_value
    Private flag_ACT_LINK_MSB
    Private write_SPARE_REG_value
    Private read_SPARE_REG_value
    Private flag_SPARE_REG
    Private write_ACT_LINK_LSB_value
    Private read_ACT_LINK_LSB_value
    Private flag_ACT_LINK_LSB
    Private write_ACTIVITY_LED_EN_value
    Private read_ACTIVITY_LED_EN_value
    Private flag_ACTIVITY_LED_EN

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

    Property Get get_SHD1C_SEL
        get_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let set_SHD1C_SEL(aData)
        write_SHD1C_SEL_value = aData
        flag_SHD1C_SEL        = &H1
    End Property

    Property Get read_SHD1C_SEL
        read
        read_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let write_SHD1C_SEL(aData)
        set_SHD1C_SEL = aData
        write
    End Property

    Property Get get_LPBK_LED_EN
        get_LPBK_LED_EN = read_LPBK_LED_EN_value
    End Property

    Property Let set_LPBK_LED_EN(aData)
        write_LPBK_LED_EN_value = aData
        flag_LPBK_LED_EN        = &H1
    End Property

    Property Get read_LPBK_LED_EN
        read
        read_LPBK_LED_EN = read_LPBK_LED_EN_value
    End Property

    Property Let write_LPBK_LED_EN(aData)
        set_LPBK_LED_EN = aData
        write
    End Property

    Property Get get_ACT_LINK_MSB
        get_ACT_LINK_MSB = read_ACT_LINK_MSB_value
    End Property

    Property Let set_ACT_LINK_MSB(aData)
        write_ACT_LINK_MSB_value = aData
        flag_ACT_LINK_MSB        = &H1
    End Property

    Property Get read_ACT_LINK_MSB
        read
        read_ACT_LINK_MSB = read_ACT_LINK_MSB_value
    End Property

    Property Let write_ACT_LINK_MSB(aData)
        set_ACT_LINK_MSB = aData
        write
    End Property

    Property Get get_SPARE_REG
        get_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let set_SPARE_REG(aData)
        write_SPARE_REG_value = aData
        flag_SPARE_REG        = &H1
    End Property

    Property Get read_SPARE_REG
        read
        read_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let write_SPARE_REG(aData)
        set_SPARE_REG = aData
        write
    End Property

    Property Get get_ACT_LINK_LSB
        get_ACT_LINK_LSB = read_ACT_LINK_LSB_value
    End Property

    Property Let set_ACT_LINK_LSB(aData)
        write_ACT_LINK_LSB_value = aData
        flag_ACT_LINK_LSB        = &H1
    End Property

    Property Get read_ACT_LINK_LSB
        read
        read_ACT_LINK_LSB = read_ACT_LINK_LSB_value
    End Property

    Property Let write_ACT_LINK_LSB(aData)
        set_ACT_LINK_LSB = aData
        write
    End Property

    Property Get get_ACTIVITY_LED_EN
        get_ACTIVITY_LED_EN = read_ACTIVITY_LED_EN_value
    End Property

    Property Let set_ACTIVITY_LED_EN(aData)
        write_ACTIVITY_LED_EN_value = aData
        flag_ACTIVITY_LED_EN        = &H1
    End Property

    Property Get read_ACTIVITY_LED_EN
        read
        read_ACTIVITY_LED_EN = read_ACTIVITY_LED_EN_value
    End Property

    Property Let write_ACTIVITY_LED_EN(aData)
        set_ACTIVITY_LED_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_LPBK_LED_EN_value = rightShift(data_low, 9) and &H1
        read_ACT_LINK_MSB_value = rightShift(data_low, 8) and &H1
        read_SPARE_REG_value = rightShift(data_low, 7) and &H1
        read_ACT_LINK_LSB_value = rightShift(data_low, 4) and &H1
        read_ACTIVITY_LED_EN_value = rightShift(data_low, 3) and &H1

    End Sub

    Sub write
        If flag_SHD1C_SEL = &H0 or flag_LPBK_LED_EN = &H0 or flag_ACT_LINK_MSB = &H0 or flag_SPARE_REG = &H0 or flag_ACT_LINK_LSB = &H0 or flag_ACTIVITY_LED_EN = &H0 Then read
        If flag_SHD1C_SEL = &H0 Then write_SHD1C_SEL_value = get_SHD1C_SEL
        If flag_LPBK_LED_EN = &H0 Then write_LPBK_LED_EN_value = get_LPBK_LED_EN
        If flag_ACT_LINK_MSB = &H0 Then write_ACT_LINK_MSB_value = get_ACT_LINK_MSB
        If flag_SPARE_REG = &H0 Then write_SPARE_REG_value = get_SPARE_REG
        If flag_ACT_LINK_LSB = &H0 Then write_ACT_LINK_LSB_value = get_ACT_LINK_LSB
        If flag_ACTIVITY_LED_EN = &H0 Then write_ACTIVITY_LED_EN_value = get_ACTIVITY_LED_EN

        regValue = leftShift((write_SHD1C_SEL_value and &H1f), 10) + leftShift((write_LPBK_LED_EN_value and &H1), 9) + leftShift((write_ACT_LINK_MSB_value and &H1), 8) + leftShift((write_SPARE_REG_value and &H1), 7) + leftShift((write_ACT_LINK_LSB_value and &H1), 4) + leftShift((write_ACTIVITY_LED_EN_value and &H1), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_LPBK_LED_EN_value = rightShift(data_low, 9) and &H1
        read_ACT_LINK_MSB_value = rightShift(data_low, 8) and &H1
        read_SPARE_REG_value = rightShift(data_low, 7) and &H1
        read_ACT_LINK_LSB_value = rightShift(data_low, 4) and &H1
        read_ACTIVITY_LED_EN_value = rightShift(data_low, 3) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHD1C_SEL_value = &H0
        flag_SHD1C_SEL        = &H0
        write_LPBK_LED_EN_value = &H0
        flag_LPBK_LED_EN        = &H0
        write_ACT_LINK_MSB_value = &H0
        flag_ACT_LINK_MSB        = &H0
        write_SPARE_REG_value = &H0
        flag_SPARE_REG        = &H0
        write_ACT_LINK_LSB_value = &H0
        flag_ACT_LINK_LSB        = &H0
        write_ACTIVITY_LED_EN_value = &H0
        flag_ACTIVITY_LED_EN        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd1c_0b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHD1C_SEL                                  [14:10]          get_SHD1C_SEL
''                                                             set_SHD1C_SEL
''                                                             read_SHD1C_SEL
''                                                             write_SHD1C_SEL
''---------------------------------------------------------------------------------
'' SOP_LED_SEL                                [1:1]            get_SOP_LED_SEL
''                                                             set_SOP_LED_SEL
''                                                             read_SOP_LED_SEL
''                                                             write_SOP_LED_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd1c_0b
    Private write_SHD1C_SEL_value
    Private read_SHD1C_SEL_value
    Private flag_SHD1C_SEL
    Private write_SOP_LED_SEL_value
    Private read_SOP_LED_SEL_value
    Private flag_SOP_LED_SEL

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

    Property Get get_SHD1C_SEL
        get_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let set_SHD1C_SEL(aData)
        write_SHD1C_SEL_value = aData
        flag_SHD1C_SEL        = &H1
    End Property

    Property Get read_SHD1C_SEL
        read
        read_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let write_SHD1C_SEL(aData)
        set_SHD1C_SEL = aData
        write
    End Property

    Property Get get_SOP_LED_SEL
        get_SOP_LED_SEL = read_SOP_LED_SEL_value
    End Property

    Property Let set_SOP_LED_SEL(aData)
        write_SOP_LED_SEL_value = aData
        flag_SOP_LED_SEL        = &H1
    End Property

    Property Get read_SOP_LED_SEL
        read
        read_SOP_LED_SEL = read_SOP_LED_SEL_value
    End Property

    Property Let write_SOP_LED_SEL(aData)
        set_SOP_LED_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_SOP_LED_SEL_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_SHD1C_SEL = &H0 or flag_SOP_LED_SEL = &H0 Then read
        If flag_SHD1C_SEL = &H0 Then write_SHD1C_SEL_value = get_SHD1C_SEL
        If flag_SOP_LED_SEL = &H0 Then write_SOP_LED_SEL_value = get_SOP_LED_SEL

        regValue = leftShift((write_SHD1C_SEL_value and &H1f), 10) + leftShift((write_SOP_LED_SEL_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_SOP_LED_SEL_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHD1C_SEL_value = &H0
        flag_SHD1C_SEL        = &H0
        write_SOP_LED_SEL_value = &H0
        flag_SOP_LED_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd1c_0d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHD1C_SEL                                  [14:10]          get_SHD1C_SEL
''                                                             set_SHD1C_SEL
''                                                             read_SHD1C_SEL
''                                                             write_SHD1C_SEL
''---------------------------------------------------------------------------------
'' PROG_LED21_HIZ                             [9:8]            get_PROG_LED21_HIZ
''                                                             set_PROG_LED21_HIZ
''                                                             read_PROG_LED21_HIZ
''                                                             write_PROG_LED21_HIZ
''---------------------------------------------------------------------------------
'' LED2_SEL                                   [7:4]            get_LED2_SEL
''                                                             set_LED2_SEL
''                                                             read_LED2_SEL
''                                                             write_LED2_SEL
''---------------------------------------------------------------------------------
'' LED1_SEL                                   [3:0]            get_LED1_SEL
''                                                             set_LED1_SEL
''                                                             read_LED1_SEL
''                                                             write_LED1_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd1c_0d
    Private write_SHD1C_SEL_value
    Private read_SHD1C_SEL_value
    Private flag_SHD1C_SEL
    Private write_PROG_LED21_HIZ_value
    Private read_PROG_LED21_HIZ_value
    Private flag_PROG_LED21_HIZ
    Private write_LED2_SEL_value
    Private read_LED2_SEL_value
    Private flag_LED2_SEL
    Private write_LED1_SEL_value
    Private read_LED1_SEL_value
    Private flag_LED1_SEL

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

    Property Get get_SHD1C_SEL
        get_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let set_SHD1C_SEL(aData)
        write_SHD1C_SEL_value = aData
        flag_SHD1C_SEL        = &H1
    End Property

    Property Get read_SHD1C_SEL
        read
        read_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let write_SHD1C_SEL(aData)
        set_SHD1C_SEL = aData
        write
    End Property

    Property Get get_PROG_LED21_HIZ
        get_PROG_LED21_HIZ = read_PROG_LED21_HIZ_value
    End Property

    Property Let set_PROG_LED21_HIZ(aData)
        write_PROG_LED21_HIZ_value = aData
        flag_PROG_LED21_HIZ        = &H1
    End Property

    Property Get read_PROG_LED21_HIZ
        read
        read_PROG_LED21_HIZ = read_PROG_LED21_HIZ_value
    End Property

    Property Let write_PROG_LED21_HIZ(aData)
        set_PROG_LED21_HIZ = aData
        write
    End Property

    Property Get get_LED2_SEL
        get_LED2_SEL = read_LED2_SEL_value
    End Property

    Property Let set_LED2_SEL(aData)
        write_LED2_SEL_value = aData
        flag_LED2_SEL        = &H1
    End Property

    Property Get read_LED2_SEL
        read
        read_LED2_SEL = read_LED2_SEL_value
    End Property

    Property Let write_LED2_SEL(aData)
        set_LED2_SEL = aData
        write
    End Property

    Property Get get_LED1_SEL
        get_LED1_SEL = read_LED1_SEL_value
    End Property

    Property Let set_LED1_SEL(aData)
        write_LED1_SEL_value = aData
        flag_LED1_SEL        = &H1
    End Property

    Property Get read_LED1_SEL
        read
        read_LED1_SEL = read_LED1_SEL_value
    End Property

    Property Let write_LED1_SEL(aData)
        set_LED1_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_PROG_LED21_HIZ_value = rightShift(data_low, 8) and &H3
        read_LED2_SEL_value = rightShift(data_low, 4) and &Hf
        LED1_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if LED1_SEL_mask = mask then
                read_LED1_SEL_value = data_low
            else
                read_LED1_SEL_value = (data_low - H8000_0000) and LED1_SEL_mask
            end If
        else
            read_LED1_SEL_value = data_low and LED1_SEL_mask
        end If

    End Sub

    Sub write
        If flag_SHD1C_SEL = &H0 or flag_PROG_LED21_HIZ = &H0 or flag_LED2_SEL = &H0 or flag_LED1_SEL = &H0 Then read
        If flag_SHD1C_SEL = &H0 Then write_SHD1C_SEL_value = get_SHD1C_SEL
        If flag_PROG_LED21_HIZ = &H0 Then write_PROG_LED21_HIZ_value = get_PROG_LED21_HIZ
        If flag_LED2_SEL = &H0 Then write_LED2_SEL_value = get_LED2_SEL
        If flag_LED1_SEL = &H0 Then write_LED1_SEL_value = get_LED1_SEL

        regValue = leftShift((write_SHD1C_SEL_value and &H1f), 10) + leftShift((write_PROG_LED21_HIZ_value and &H3), 8) + leftShift((write_LED2_SEL_value and &Hf), 4) + leftShift((write_LED1_SEL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_PROG_LED21_HIZ_value = rightShift(data_low, 8) and &H3
        read_LED2_SEL_value = rightShift(data_low, 4) and &Hf
        LED1_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if LED1_SEL_mask = mask then
                read_LED1_SEL_value = data_low
            else
                read_LED1_SEL_value = (data_low - H8000_0000) and LED1_SEL_mask
            end If
        else
            read_LED1_SEL_value = data_low and LED1_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHD1C_SEL_value = &H0
        flag_SHD1C_SEL        = &H0
        write_PROG_LED21_HIZ_value = &H0
        flag_PROG_LED21_HIZ        = &H0
        write_LED2_SEL_value = &H0
        flag_LED2_SEL        = &H0
        write_LED1_SEL_value = &H0
        flag_LED1_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd1c_0e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHD1C_SEL                                  [14:10]          get_SHD1C_SEL
''                                                             set_SHD1C_SEL
''                                                             read_SHD1C_SEL
''                                                             write_SHD1C_SEL
''---------------------------------------------------------------------------------
'' PROG_LED43_HIZ                             [9:8]            get_PROG_LED43_HIZ
''                                                             set_PROG_LED43_HIZ
''                                                             read_PROG_LED43_HIZ
''                                                             write_PROG_LED43_HIZ
''---------------------------------------------------------------------------------
'' LED4_SEL                                   [7:4]            get_LED4_SEL
''                                                             set_LED4_SEL
''                                                             read_LED4_SEL
''                                                             write_LED4_SEL
''---------------------------------------------------------------------------------
'' LED3_SEL                                   [3:0]            get_LED3_SEL
''                                                             set_LED3_SEL
''                                                             read_LED3_SEL
''                                                             write_LED3_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd1c_0e
    Private write_SHD1C_SEL_value
    Private read_SHD1C_SEL_value
    Private flag_SHD1C_SEL
    Private write_PROG_LED43_HIZ_value
    Private read_PROG_LED43_HIZ_value
    Private flag_PROG_LED43_HIZ
    Private write_LED4_SEL_value
    Private read_LED4_SEL_value
    Private flag_LED4_SEL
    Private write_LED3_SEL_value
    Private read_LED3_SEL_value
    Private flag_LED3_SEL

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

    Property Get get_SHD1C_SEL
        get_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let set_SHD1C_SEL(aData)
        write_SHD1C_SEL_value = aData
        flag_SHD1C_SEL        = &H1
    End Property

    Property Get read_SHD1C_SEL
        read
        read_SHD1C_SEL = read_SHD1C_SEL_value
    End Property

    Property Let write_SHD1C_SEL(aData)
        set_SHD1C_SEL = aData
        write
    End Property

    Property Get get_PROG_LED43_HIZ
        get_PROG_LED43_HIZ = read_PROG_LED43_HIZ_value
    End Property

    Property Let set_PROG_LED43_HIZ(aData)
        write_PROG_LED43_HIZ_value = aData
        flag_PROG_LED43_HIZ        = &H1
    End Property

    Property Get read_PROG_LED43_HIZ
        read
        read_PROG_LED43_HIZ = read_PROG_LED43_HIZ_value
    End Property

    Property Let write_PROG_LED43_HIZ(aData)
        set_PROG_LED43_HIZ = aData
        write
    End Property

    Property Get get_LED4_SEL
        get_LED4_SEL = read_LED4_SEL_value
    End Property

    Property Let set_LED4_SEL(aData)
        write_LED4_SEL_value = aData
        flag_LED4_SEL        = &H1
    End Property

    Property Get read_LED4_SEL
        read
        read_LED4_SEL = read_LED4_SEL_value
    End Property

    Property Let write_LED4_SEL(aData)
        set_LED4_SEL = aData
        write
    End Property

    Property Get get_LED3_SEL
        get_LED3_SEL = read_LED3_SEL_value
    End Property

    Property Let set_LED3_SEL(aData)
        write_LED3_SEL_value = aData
        flag_LED3_SEL        = &H1
    End Property

    Property Get read_LED3_SEL
        read
        read_LED3_SEL = read_LED3_SEL_value
    End Property

    Property Let write_LED3_SEL(aData)
        set_LED3_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_PROG_LED43_HIZ_value = rightShift(data_low, 8) and &H3
        read_LED4_SEL_value = rightShift(data_low, 4) and &Hf
        LED3_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if LED3_SEL_mask = mask then
                read_LED3_SEL_value = data_low
            else
                read_LED3_SEL_value = (data_low - H8000_0000) and LED3_SEL_mask
            end If
        else
            read_LED3_SEL_value = data_low and LED3_SEL_mask
        end If

    End Sub

    Sub write
        If flag_SHD1C_SEL = &H0 or flag_PROG_LED43_HIZ = &H0 or flag_LED4_SEL = &H0 or flag_LED3_SEL = &H0 Then read
        If flag_SHD1C_SEL = &H0 Then write_SHD1C_SEL_value = get_SHD1C_SEL
        If flag_PROG_LED43_HIZ = &H0 Then write_PROG_LED43_HIZ_value = get_PROG_LED43_HIZ
        If flag_LED4_SEL = &H0 Then write_LED4_SEL_value = get_LED4_SEL
        If flag_LED3_SEL = &H0 Then write_LED3_SEL_value = get_LED3_SEL

        regValue = leftShift((write_SHD1C_SEL_value and &H1f), 10) + leftShift((write_PROG_LED43_HIZ_value and &H3), 8) + leftShift((write_LED4_SEL_value and &Hf), 4) + leftShift((write_LED3_SEL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD1C_SEL_value = rightShift(data_low, 10) and &H1f
        read_PROG_LED43_HIZ_value = rightShift(data_low, 8) and &H3
        read_LED4_SEL_value = rightShift(data_low, 4) and &Hf
        LED3_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if LED3_SEL_mask = mask then
                read_LED3_SEL_value = data_low
            else
                read_LED3_SEL_value = (data_low - H8000_0000) and LED3_SEL_mask
            end If
        else
            read_LED3_SEL_value = data_low and LED3_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHD1C_SEL_value = &H0
        flag_SHD1C_SEL        = &H0
        write_PROG_LED43_HIZ_value = &H0
        flag_PROG_LED43_HIZ        = &H0
        write_LED4_SEL_value = &H0
        flag_LED4_SEL        = &H0
        write_LED3_SEL_value = &H0
        flag_LED3_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd18_000
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EXT_LPBK                                   [15:15]          get_EXT_LPBK
''                                                             set_EXT_LPBK
''                                                             read_EXT_LPBK
''                                                             write_EXT_LPBK
''---------------------------------------------------------------------------------
'' EXT_PKT_LEN                                [14:14]          get_EXT_PKT_LEN
''                                                             set_EXT_PKT_LEN
''                                                             read_EXT_PKT_LEN
''                                                             write_EXT_PKT_LEN
''---------------------------------------------------------------------------------
'' SHD18_SEL                                  [2:0]            get_SHD18_SEL
''                                                             set_SHD18_SEL
''                                                             read_SHD18_SEL
''                                                             write_SHD18_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd18_000
    Private write_EXT_LPBK_value
    Private read_EXT_LPBK_value
    Private flag_EXT_LPBK
    Private write_EXT_PKT_LEN_value
    Private read_EXT_PKT_LEN_value
    Private flag_EXT_PKT_LEN
    Private write_SHD18_SEL_value
    Private read_SHD18_SEL_value
    Private flag_SHD18_SEL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EXT_LPBK
        get_EXT_LPBK = read_EXT_LPBK_value
    End Property

    Property Let set_EXT_LPBK(aData)
        write_EXT_LPBK_value = aData
        flag_EXT_LPBK        = &H1
    End Property

    Property Get read_EXT_LPBK
        read
        read_EXT_LPBK = read_EXT_LPBK_value
    End Property

    Property Let write_EXT_LPBK(aData)
        set_EXT_LPBK = aData
        write
    End Property

    Property Get get_EXT_PKT_LEN
        get_EXT_PKT_LEN = read_EXT_PKT_LEN_value
    End Property

    Property Let set_EXT_PKT_LEN(aData)
        write_EXT_PKT_LEN_value = aData
        flag_EXT_PKT_LEN        = &H1
    End Property

    Property Get read_EXT_PKT_LEN
        read
        read_EXT_PKT_LEN = read_EXT_PKT_LEN_value
    End Property

    Property Let write_EXT_PKT_LEN(aData)
        set_EXT_PKT_LEN = aData
        write
    End Property

    Property Get get_SHD18_SEL
        get_SHD18_SEL = read_SHD18_SEL_value
    End Property

    Property Let set_SHD18_SEL(aData)
        write_SHD18_SEL_value = aData
        flag_SHD18_SEL        = &H1
    End Property

    Property Get read_SHD18_SEL
        read
        read_SHD18_SEL = read_SHD18_SEL_value
    End Property

    Property Let write_SHD18_SEL(aData)
        set_SHD18_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EXT_LPBK_value = rightShift(data_low, 15) and &H1
        read_EXT_PKT_LEN_value = rightShift(data_low, 14) and &H1
        SHD18_SEL_mask = &H7
        if data_low > LONG_MAX then
            if SHD18_SEL_mask = mask then
                read_SHD18_SEL_value = data_low
            else
                read_SHD18_SEL_value = (data_low - H8000_0000) and SHD18_SEL_mask
            end If
        else
            read_SHD18_SEL_value = data_low and SHD18_SEL_mask
        end If

    End Sub

    Sub write
        If flag_EXT_LPBK = &H0 or flag_EXT_PKT_LEN = &H0 or flag_SHD18_SEL = &H0 Then read
        If flag_EXT_LPBK = &H0 Then write_EXT_LPBK_value = get_EXT_LPBK
        If flag_EXT_PKT_LEN = &H0 Then write_EXT_PKT_LEN_value = get_EXT_PKT_LEN
        If flag_SHD18_SEL = &H0 Then write_SHD18_SEL_value = get_SHD18_SEL

        regValue = leftShift((write_EXT_LPBK_value and &H1), 15) + leftShift((write_EXT_PKT_LEN_value and &H1), 14) + leftShift((write_SHD18_SEL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EXT_LPBK_value = rightShift(data_low, 15) and &H1
        read_EXT_PKT_LEN_value = rightShift(data_low, 14) and &H1
        SHD18_SEL_mask = &H7
        if data_low > LONG_MAX then
            if SHD18_SEL_mask = mask then
                read_SHD18_SEL_value = data_low
            else
                read_SHD18_SEL_value = (data_low - H8000_0000) and SHD18_SEL_mask
            end If
        else
            read_SHD18_SEL_value = data_low and SHD18_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EXT_LPBK_value = &H0
        flag_EXT_LPBK        = &H0
        write_EXT_PKT_LEN_value = &H0
        flag_EXT_PKT_LEN        = &H0
        write_SHD18_SEL_value = &H0
        flag_SHD18_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd18_010
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SUPER_ISOLATE                              [5:5]            get_SUPER_ISOLATE
''                                                             set_SUPER_ISOLATE
''                                                             read_SUPER_ISOLATE
''                                                             write_SUPER_ISOLATE
''---------------------------------------------------------------------------------
'' SHD18_SEL                                  [2:0]            get_SHD18_SEL
''                                                             set_SHD18_SEL
''                                                             read_SHD18_SEL
''                                                             write_SHD18_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd18_010
    Private write_SUPER_ISOLATE_value
    Private read_SUPER_ISOLATE_value
    Private flag_SUPER_ISOLATE
    Private write_SHD18_SEL_value
    Private read_SHD18_SEL_value
    Private flag_SHD18_SEL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H54
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SUPER_ISOLATE
        get_SUPER_ISOLATE = read_SUPER_ISOLATE_value
    End Property

    Property Let set_SUPER_ISOLATE(aData)
        write_SUPER_ISOLATE_value = aData
        flag_SUPER_ISOLATE        = &H1
    End Property

    Property Get read_SUPER_ISOLATE
        read
        read_SUPER_ISOLATE = read_SUPER_ISOLATE_value
    End Property

    Property Let write_SUPER_ISOLATE(aData)
        set_SUPER_ISOLATE = aData
        write
    End Property

    Property Get get_SHD18_SEL
        get_SHD18_SEL = read_SHD18_SEL_value
    End Property

    Property Let set_SHD18_SEL(aData)
        write_SHD18_SEL_value = aData
        flag_SHD18_SEL        = &H1
    End Property

    Property Get read_SHD18_SEL
        read
        read_SHD18_SEL = read_SHD18_SEL_value
    End Property

    Property Let write_SHD18_SEL(aData)
        set_SHD18_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SUPER_ISOLATE_value = rightShift(data_low, 5) and &H1
        SHD18_SEL_mask = &H7
        if data_low > LONG_MAX then
            if SHD18_SEL_mask = mask then
                read_SHD18_SEL_value = data_low
            else
                read_SHD18_SEL_value = (data_low - H8000_0000) and SHD18_SEL_mask
            end If
        else
            read_SHD18_SEL_value = data_low and SHD18_SEL_mask
        end If

    End Sub

    Sub write
        If flag_SUPER_ISOLATE = &H0 or flag_SHD18_SEL = &H0 Then read
        If flag_SUPER_ISOLATE = &H0 Then write_SUPER_ISOLATE_value = get_SUPER_ISOLATE
        If flag_SHD18_SEL = &H0 Then write_SHD18_SEL_value = get_SHD18_SEL

        regValue = leftShift((write_SUPER_ISOLATE_value and &H1), 5) + leftShift((write_SHD18_SEL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SUPER_ISOLATE_value = rightShift(data_low, 5) and &H1
        SHD18_SEL_mask = &H7
        if data_low > LONG_MAX then
            if SHD18_SEL_mask = mask then
                read_SHD18_SEL_value = data_low
            else
                read_SHD18_SEL_value = (data_low - H8000_0000) and SHD18_SEL_mask
            end If
        else
            read_SHD18_SEL_value = data_low and SHD18_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SUPER_ISOLATE_value = &H0
        flag_SUPER_ISOLATE        = &H0
        write_SHD18_SEL_value = &H0
        flag_SHD18_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_shd18_111
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHD18_RDSEL                                [14:12]          get_SHD18_RDSEL
''                                                             set_SHD18_RDSEL
''                                                             read_SHD18_RDSEL
''                                                             write_SHD18_RDSEL
''---------------------------------------------------------------------------------
'' PKT_CNTR                                   [11:11]          get_PKT_CNTR
''                                                             set_PKT_CNTR
''                                                             read_PKT_CNTR
''                                                             write_PKT_CNTR
''---------------------------------------------------------------------------------
'' MDIO_ALL_PHY_SEL                           [3:3]            get_MDIO_ALL_PHY_SEL
''                                                             set_MDIO_ALL_PHY_SEL
''                                                             read_MDIO_ALL_PHY_SEL
''                                                             write_MDIO_ALL_PHY_SEL
''---------------------------------------------------------------------------------
'' SHD18_SEL                                  [2:0]            get_SHD18_SEL
''                                                             set_SHD18_SEL
''                                                             read_SHD18_SEL
''                                                             write_SHD18_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_shd18_111
    Private write_SHD18_RDSEL_value
    Private read_SHD18_RDSEL_value
    Private flag_SHD18_RDSEL
    Private write_PKT_CNTR_value
    Private read_PKT_CNTR_value
    Private flag_PKT_CNTR
    Private write_MDIO_ALL_PHY_SEL_value
    Private read_MDIO_ALL_PHY_SEL_value
    Private flag_MDIO_ALL_PHY_SEL
    Private write_SHD18_SEL_value
    Private read_SHD18_SEL_value
    Private flag_SHD18_SEL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SHD18_RDSEL
        get_SHD18_RDSEL = read_SHD18_RDSEL_value
    End Property

    Property Let set_SHD18_RDSEL(aData)
        write_SHD18_RDSEL_value = aData
        flag_SHD18_RDSEL        = &H1
    End Property

    Property Get read_SHD18_RDSEL
        read
        read_SHD18_RDSEL = read_SHD18_RDSEL_value
    End Property

    Property Let write_SHD18_RDSEL(aData)
        set_SHD18_RDSEL = aData
        write
    End Property

    Property Get get_PKT_CNTR
        get_PKT_CNTR = read_PKT_CNTR_value
    End Property

    Property Let set_PKT_CNTR(aData)
        write_PKT_CNTR_value = aData
        flag_PKT_CNTR        = &H1
    End Property

    Property Get read_PKT_CNTR
        read
        read_PKT_CNTR = read_PKT_CNTR_value
    End Property

    Property Let write_PKT_CNTR(aData)
        set_PKT_CNTR = aData
        write
    End Property

    Property Get get_MDIO_ALL_PHY_SEL
        get_MDIO_ALL_PHY_SEL = read_MDIO_ALL_PHY_SEL_value
    End Property

    Property Let set_MDIO_ALL_PHY_SEL(aData)
        write_MDIO_ALL_PHY_SEL_value = aData
        flag_MDIO_ALL_PHY_SEL        = &H1
    End Property

    Property Get read_MDIO_ALL_PHY_SEL
        read
        read_MDIO_ALL_PHY_SEL = read_MDIO_ALL_PHY_SEL_value
    End Property

    Property Let write_MDIO_ALL_PHY_SEL(aData)
        set_MDIO_ALL_PHY_SEL = aData
        write
    End Property

    Property Get get_SHD18_SEL
        get_SHD18_SEL = read_SHD18_SEL_value
    End Property

    Property Let set_SHD18_SEL(aData)
        write_SHD18_SEL_value = aData
        flag_SHD18_SEL        = &H1
    End Property

    Property Get read_SHD18_SEL
        read
        read_SHD18_SEL = read_SHD18_SEL_value
    End Property

    Property Let write_SHD18_SEL(aData)
        set_SHD18_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD18_RDSEL_value = rightShift(data_low, 12) and &H7
        read_PKT_CNTR_value = rightShift(data_low, 11) and &H1
        read_MDIO_ALL_PHY_SEL_value = rightShift(data_low, 3) and &H1
        SHD18_SEL_mask = &H7
        if data_low > LONG_MAX then
            if SHD18_SEL_mask = mask then
                read_SHD18_SEL_value = data_low
            else
                read_SHD18_SEL_value = (data_low - H8000_0000) and SHD18_SEL_mask
            end If
        else
            read_SHD18_SEL_value = data_low and SHD18_SEL_mask
        end If

    End Sub

    Sub write
        If flag_SHD18_RDSEL = &H0 or flag_PKT_CNTR = &H0 or flag_MDIO_ALL_PHY_SEL = &H0 or flag_SHD18_SEL = &H0 Then read
        If flag_SHD18_RDSEL = &H0 Then write_SHD18_RDSEL_value = get_SHD18_RDSEL
        If flag_PKT_CNTR = &H0 Then write_PKT_CNTR_value = get_PKT_CNTR
        If flag_MDIO_ALL_PHY_SEL = &H0 Then write_MDIO_ALL_PHY_SEL_value = get_MDIO_ALL_PHY_SEL
        If flag_SHD18_SEL = &H0 Then write_SHD18_SEL_value = get_SHD18_SEL

        regValue = leftShift((write_SHD18_RDSEL_value and &H7), 12) + leftShift((write_PKT_CNTR_value and &H1), 11) + leftShift((write_MDIO_ALL_PHY_SEL_value and &H1), 3) + leftShift((write_SHD18_SEL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SHD18_RDSEL_value = rightShift(data_low, 12) and &H7
        read_PKT_CNTR_value = rightShift(data_low, 11) and &H1
        read_MDIO_ALL_PHY_SEL_value = rightShift(data_low, 3) and &H1
        SHD18_SEL_mask = &H7
        if data_low > LONG_MAX then
            if SHD18_SEL_mask = mask then
                read_SHD18_SEL_value = data_low
            else
                read_SHD18_SEL_value = (data_low - H8000_0000) and SHD18_SEL_mask
            end If
        else
            read_SHD18_SEL_value = data_low and SHD18_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHD18_RDSEL_value = &H0
        flag_SHD18_RDSEL        = &H0
        write_PKT_CNTR_value = &H0
        flag_PKT_CNTR        = &H0
        write_MDIO_ALL_PHY_SEL_value = &H0
        flag_MDIO_ALL_PHY_SEL        = &H0
        write_SHD18_SEL_value = &H0
        flag_SHD18_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PKT_CNTR                                   [15:0]           get_PKT_CNTR
''                                                             set_PKT_CNTR
''                                                             read_PKT_CNTR
''                                                             write_PKT_CNTR
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp00
    Private write_PKT_CNTR_value
    Private read_PKT_CNTR_value
    Private flag_PKT_CNTR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PKT_CNTR
        get_PKT_CNTR = read_PKT_CNTR_value
    End Property

    Property Let set_PKT_CNTR(aData)
        write_PKT_CNTR_value = aData
        flag_PKT_CNTR        = &H1
    End Property

    Property Get read_PKT_CNTR
        read
        read_PKT_CNTR = read_PKT_CNTR_value
    End Property

    Property Let write_PKT_CNTR(aData)
        set_PKT_CNTR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKT_CNTR_mask = &Hffff
        if data_low > LONG_MAX then
            if PKT_CNTR_mask = mask then
                read_PKT_CNTR_value = data_low
            else
                read_PKT_CNTR_value = (data_low - H8000_0000) and PKT_CNTR_mask
            end If
        else
            read_PKT_CNTR_value = data_low and PKT_CNTR_mask
        end If

    End Sub

    Sub write
        If flag_PKT_CNTR = &H0 Then read
        If flag_PKT_CNTR = &H0 Then write_PKT_CNTR_value = get_PKT_CNTR

        regValue = leftShift((write_PKT_CNTR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKT_CNTR_mask = &Hffff
        if data_low > LONG_MAX then
            if PKT_CNTR_mask = mask then
                read_PKT_CNTR_value = data_low
            else
                read_PKT_CNTR_value = (data_low - H8000_0000) and PKT_CNTR_mask
            end If
        else
            read_PKT_CNTR_value = data_low and PKT_CNTR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PKT_CNTR_value = &H0
        flag_PKT_CNTR        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp03
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REG                                  [15:0]           get_SPARE_REG
''                                                             set_SPARE_REG
''                                                             read_SPARE_REG
''                                                             write_SPARE_REG
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp03
    Private write_SPARE_REG_value
    Private read_SPARE_REG_value
    Private flag_SPARE_REG

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H66
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_REG
        get_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let set_SPARE_REG(aData)
        write_SPARE_REG_value = aData
        flag_SPARE_REG        = &H1
    End Property

    Property Get read_SPARE_REG
        read
        read_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let write_SPARE_REG(aData)
        set_SPARE_REG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REG = &H0 Then read
        If flag_SPARE_REG = &H0 Then write_SPARE_REG_value = get_SPARE_REG

        regValue = leftShift((write_SPARE_REG_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_REG_value = &H0
        flag_SPARE_REG        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp42
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COPPER_LINK                                [11:11]          get_COPPER_LINK
''                                                             set_COPPER_LINK
''                                                             read_COPPER_LINK
''                                                             write_COPPER_LINK
''---------------------------------------------------------------------------------
'' COPPER_SPEED                               [10:9]           get_COPPER_SPEED
''                                                             set_COPPER_SPEED
''                                                             read_COPPER_SPEED
''                                                             write_COPPER_SPEED
''---------------------------------------------------------------------------------
'' OPERATING_MODE_STATUS                      [4:0]            get_OPERATING_MODE_STATUS
''                                                             set_OPERATING_MODE_STATUS
''                                                             read_OPERATING_MODE_STATUS
''                                                             write_OPERATING_MODE_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp42
    Private write_COPPER_LINK_value
    Private read_COPPER_LINK_value
    Private flag_COPPER_LINK
    Private write_COPPER_SPEED_value
    Private read_COPPER_SPEED_value
    Private flag_COPPER_SPEED
    Private write_OPERATING_MODE_STATUS_value
    Private read_OPERATING_MODE_STATUS_value
    Private flag_OPERATING_MODE_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_COPPER_LINK
        get_COPPER_LINK = read_COPPER_LINK_value
    End Property

    Property Let set_COPPER_LINK(aData)
        write_COPPER_LINK_value = aData
        flag_COPPER_LINK        = &H1
    End Property

    Property Get read_COPPER_LINK
        read
        read_COPPER_LINK = read_COPPER_LINK_value
    End Property

    Property Let write_COPPER_LINK(aData)
        set_COPPER_LINK = aData
        write
    End Property

    Property Get get_COPPER_SPEED
        get_COPPER_SPEED = read_COPPER_SPEED_value
    End Property

    Property Let set_COPPER_SPEED(aData)
        write_COPPER_SPEED_value = aData
        flag_COPPER_SPEED        = &H1
    End Property

    Property Get read_COPPER_SPEED
        read
        read_COPPER_SPEED = read_COPPER_SPEED_value
    End Property

    Property Let write_COPPER_SPEED(aData)
        set_COPPER_SPEED = aData
        write
    End Property

    Property Get get_OPERATING_MODE_STATUS
        get_OPERATING_MODE_STATUS = read_OPERATING_MODE_STATUS_value
    End Property

    Property Let set_OPERATING_MODE_STATUS(aData)
        write_OPERATING_MODE_STATUS_value = aData
        flag_OPERATING_MODE_STATUS        = &H1
    End Property

    Property Get read_OPERATING_MODE_STATUS
        read
        read_OPERATING_MODE_STATUS = read_OPERATING_MODE_STATUS_value
    End Property

    Property Let write_OPERATING_MODE_STATUS(aData)
        set_OPERATING_MODE_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COPPER_LINK_value = rightShift(data_low, 11) and &H1
        read_COPPER_SPEED_value = rightShift(data_low, 9) and &H3
        OPERATING_MODE_STATUS_mask = &H1f
        if data_low > LONG_MAX then
            if OPERATING_MODE_STATUS_mask = mask then
                read_OPERATING_MODE_STATUS_value = data_low
            else
                read_OPERATING_MODE_STATUS_value = (data_low - H8000_0000) and OPERATING_MODE_STATUS_mask
            end If
        else
            read_OPERATING_MODE_STATUS_value = data_low and OPERATING_MODE_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_COPPER_LINK = &H0 or flag_COPPER_SPEED = &H0 or flag_OPERATING_MODE_STATUS = &H0 Then read
        If flag_COPPER_LINK = &H0 Then write_COPPER_LINK_value = get_COPPER_LINK
        If flag_COPPER_SPEED = &H0 Then write_COPPER_SPEED_value = get_COPPER_SPEED
        If flag_OPERATING_MODE_STATUS = &H0 Then write_OPERATING_MODE_STATUS_value = get_OPERATING_MODE_STATUS

        regValue = leftShift((write_COPPER_LINK_value and &H1), 11) + leftShift((write_COPPER_SPEED_value and &H3), 9) + leftShift((write_OPERATING_MODE_STATUS_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COPPER_LINK_value = rightShift(data_low, 11) and &H1
        read_COPPER_SPEED_value = rightShift(data_low, 9) and &H3
        OPERATING_MODE_STATUS_mask = &H1f
        if data_low > LONG_MAX then
            if OPERATING_MODE_STATUS_mask = mask then
                read_OPERATING_MODE_STATUS_value = data_low
            else
                read_OPERATING_MODE_STATUS_value = (data_low - H8000_0000) and OPERATING_MODE_STATUS_mask
            end If
        else
            read_OPERATING_MODE_STATUS_value = data_low and OPERATING_MODE_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COPPER_LINK_value = &H0
        flag_COPPER_LINK        = &H0
        write_COPPER_SPEED_value = &H0
        flag_COPPER_SPEED        = &H0
        write_OPERATING_MODE_STATUS_value = &H0
        flag_OPERATING_MODE_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp60
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_TX_MIN_100T1                       [15:0]           get_PCS_DLY_TX_MIN_100T1
''                                                             set_PCS_DLY_TX_MIN_100T1
''                                                             read_PCS_DLY_TX_MIN_100T1
''                                                             write_PCS_DLY_TX_MIN_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp60
    Private write_PCS_DLY_TX_MIN_100T1_value
    Private read_PCS_DLY_TX_MIN_100T1_value
    Private flag_PCS_DLY_TX_MIN_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_TX_MIN_100T1
        get_PCS_DLY_TX_MIN_100T1 = read_PCS_DLY_TX_MIN_100T1_value
    End Property

    Property Let set_PCS_DLY_TX_MIN_100T1(aData)
        write_PCS_DLY_TX_MIN_100T1_value = aData
        flag_PCS_DLY_TX_MIN_100T1        = &H1
    End Property

    Property Get read_PCS_DLY_TX_MIN_100T1
        read
        read_PCS_DLY_TX_MIN_100T1 = read_PCS_DLY_TX_MIN_100T1_value
    End Property

    Property Let write_PCS_DLY_TX_MIN_100T1(aData)
        set_PCS_DLY_TX_MIN_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MIN_100T1_mask = mask then
                read_PCS_DLY_TX_MIN_100T1_value = data_low
            else
                read_PCS_DLY_TX_MIN_100T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MIN_100T1_mask
            end If
        else
            read_PCS_DLY_TX_MIN_100T1_value = data_low and PCS_DLY_TX_MIN_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_TX_MIN_100T1 = &H0 Then read
        If flag_PCS_DLY_TX_MIN_100T1 = &H0 Then write_PCS_DLY_TX_MIN_100T1_value = get_PCS_DLY_TX_MIN_100T1

        regValue = leftShift((write_PCS_DLY_TX_MIN_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MIN_100T1_mask = mask then
                read_PCS_DLY_TX_MIN_100T1_value = data_low
            else
                read_PCS_DLY_TX_MIN_100T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MIN_100T1_mask
            end If
        else
            read_PCS_DLY_TX_MIN_100T1_value = data_low and PCS_DLY_TX_MIN_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_TX_MIN_100T1_value = &H0
        flag_PCS_DLY_TX_MIN_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp61
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_TX_MAX_100T1                       [15:0]           get_PCS_DLY_TX_MAX_100T1
''                                                             set_PCS_DLY_TX_MAX_100T1
''                                                             read_PCS_DLY_TX_MAX_100T1
''                                                             write_PCS_DLY_TX_MAX_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp61
    Private write_PCS_DLY_TX_MAX_100T1_value
    Private read_PCS_DLY_TX_MAX_100T1_value
    Private flag_PCS_DLY_TX_MAX_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_TX_MAX_100T1
        get_PCS_DLY_TX_MAX_100T1 = read_PCS_DLY_TX_MAX_100T1_value
    End Property

    Property Let set_PCS_DLY_TX_MAX_100T1(aData)
        write_PCS_DLY_TX_MAX_100T1_value = aData
        flag_PCS_DLY_TX_MAX_100T1        = &H1
    End Property

    Property Get read_PCS_DLY_TX_MAX_100T1
        read
        read_PCS_DLY_TX_MAX_100T1 = read_PCS_DLY_TX_MAX_100T1_value
    End Property

    Property Let write_PCS_DLY_TX_MAX_100T1(aData)
        set_PCS_DLY_TX_MAX_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MAX_100T1_mask = mask then
                read_PCS_DLY_TX_MAX_100T1_value = data_low
            else
                read_PCS_DLY_TX_MAX_100T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MAX_100T1_mask
            end If
        else
            read_PCS_DLY_TX_MAX_100T1_value = data_low and PCS_DLY_TX_MAX_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_TX_MAX_100T1 = &H0 Then read
        If flag_PCS_DLY_TX_MAX_100T1 = &H0 Then write_PCS_DLY_TX_MAX_100T1_value = get_PCS_DLY_TX_MAX_100T1

        regValue = leftShift((write_PCS_DLY_TX_MAX_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MAX_100T1_mask = mask then
                read_PCS_DLY_TX_MAX_100T1_value = data_low
            else
                read_PCS_DLY_TX_MAX_100T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MAX_100T1_mask
            end If
        else
            read_PCS_DLY_TX_MAX_100T1_value = data_low and PCS_DLY_TX_MAX_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_TX_MAX_100T1_value = &H0
        flag_PCS_DLY_TX_MAX_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp62
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_RX_MIN_100T1                       [15:0]           get_PCS_DLY_RX_MIN_100T1
''                                                             set_PCS_DLY_RX_MIN_100T1
''                                                             read_PCS_DLY_RX_MIN_100T1
''                                                             write_PCS_DLY_RX_MIN_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp62
    Private write_PCS_DLY_RX_MIN_100T1_value
    Private read_PCS_DLY_RX_MIN_100T1_value
    Private flag_PCS_DLY_RX_MIN_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_RX_MIN_100T1
        get_PCS_DLY_RX_MIN_100T1 = read_PCS_DLY_RX_MIN_100T1_value
    End Property

    Property Let set_PCS_DLY_RX_MIN_100T1(aData)
        write_PCS_DLY_RX_MIN_100T1_value = aData
        flag_PCS_DLY_RX_MIN_100T1        = &H1
    End Property

    Property Get read_PCS_DLY_RX_MIN_100T1
        read
        read_PCS_DLY_RX_MIN_100T1 = read_PCS_DLY_RX_MIN_100T1_value
    End Property

    Property Let write_PCS_DLY_RX_MIN_100T1(aData)
        set_PCS_DLY_RX_MIN_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MIN_100T1_mask = mask then
                read_PCS_DLY_RX_MIN_100T1_value = data_low
            else
                read_PCS_DLY_RX_MIN_100T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MIN_100T1_mask
            end If
        else
            read_PCS_DLY_RX_MIN_100T1_value = data_low and PCS_DLY_RX_MIN_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_RX_MIN_100T1 = &H0 Then read
        If flag_PCS_DLY_RX_MIN_100T1 = &H0 Then write_PCS_DLY_RX_MIN_100T1_value = get_PCS_DLY_RX_MIN_100T1

        regValue = leftShift((write_PCS_DLY_RX_MIN_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MIN_100T1_mask = mask then
                read_PCS_DLY_RX_MIN_100T1_value = data_low
            else
                read_PCS_DLY_RX_MIN_100T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MIN_100T1_mask
            end If
        else
            read_PCS_DLY_RX_MIN_100T1_value = data_low and PCS_DLY_RX_MIN_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_RX_MIN_100T1_value = &H0
        flag_PCS_DLY_RX_MIN_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp63
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_RX_MAX_100T1                       [15:0]           get_PCS_DLY_RX_MAX_100T1
''                                                             set_PCS_DLY_RX_MAX_100T1
''                                                             read_PCS_DLY_RX_MAX_100T1
''                                                             write_PCS_DLY_RX_MAX_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp63
    Private write_PCS_DLY_RX_MAX_100T1_value
    Private read_PCS_DLY_RX_MAX_100T1_value
    Private flag_PCS_DLY_RX_MAX_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_RX_MAX_100T1
        get_PCS_DLY_RX_MAX_100T1 = read_PCS_DLY_RX_MAX_100T1_value
    End Property

    Property Let set_PCS_DLY_RX_MAX_100T1(aData)
        write_PCS_DLY_RX_MAX_100T1_value = aData
        flag_PCS_DLY_RX_MAX_100T1        = &H1
    End Property

    Property Get read_PCS_DLY_RX_MAX_100T1
        read
        read_PCS_DLY_RX_MAX_100T1 = read_PCS_DLY_RX_MAX_100T1_value
    End Property

    Property Let write_PCS_DLY_RX_MAX_100T1(aData)
        set_PCS_DLY_RX_MAX_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MAX_100T1_mask = mask then
                read_PCS_DLY_RX_MAX_100T1_value = data_low
            else
                read_PCS_DLY_RX_MAX_100T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MAX_100T1_mask
            end If
        else
            read_PCS_DLY_RX_MAX_100T1_value = data_low and PCS_DLY_RX_MAX_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_RX_MAX_100T1 = &H0 Then read
        If flag_PCS_DLY_RX_MAX_100T1 = &H0 Then write_PCS_DLY_RX_MAX_100T1_value = get_PCS_DLY_RX_MAX_100T1

        regValue = leftShift((write_PCS_DLY_RX_MAX_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MAX_100T1_mask = mask then
                read_PCS_DLY_RX_MAX_100T1_value = data_low
            else
                read_PCS_DLY_RX_MAX_100T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MAX_100T1_mask
            end If
        else
            read_PCS_DLY_RX_MAX_100T1_value = data_low and PCS_DLY_RX_MAX_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_RX_MAX_100T1_value = &H0
        flag_PCS_DLY_RX_MAX_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp64
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_TX_MIN_100T1                   [15:0]           get_PMA_PMD_DLY_TX_MIN_100T1
''                                                             set_PMA_PMD_DLY_TX_MIN_100T1
''                                                             read_PMA_PMD_DLY_TX_MIN_100T1
''                                                             write_PMA_PMD_DLY_TX_MIN_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp64
    Private write_PMA_PMD_DLY_TX_MIN_100T1_value
    Private read_PMA_PMD_DLY_TX_MIN_100T1_value
    Private flag_PMA_PMD_DLY_TX_MIN_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_TX_MIN_100T1
        get_PMA_PMD_DLY_TX_MIN_100T1 = read_PMA_PMD_DLY_TX_MIN_100T1_value
    End Property

    Property Let set_PMA_PMD_DLY_TX_MIN_100T1(aData)
        write_PMA_PMD_DLY_TX_MIN_100T1_value = aData
        flag_PMA_PMD_DLY_TX_MIN_100T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_TX_MIN_100T1
        read
        read_PMA_PMD_DLY_TX_MIN_100T1 = read_PMA_PMD_DLY_TX_MIN_100T1_value
    End Property

    Property Let write_PMA_PMD_DLY_TX_MIN_100T1(aData)
        set_PMA_PMD_DLY_TX_MIN_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MIN_100T1_mask = mask then
                read_PMA_PMD_DLY_TX_MIN_100T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MIN_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MIN_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MIN_100T1_value = data_low and PMA_PMD_DLY_TX_MIN_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_TX_MIN_100T1 = &H0 Then read
        If flag_PMA_PMD_DLY_TX_MIN_100T1 = &H0 Then write_PMA_PMD_DLY_TX_MIN_100T1_value = get_PMA_PMD_DLY_TX_MIN_100T1

        regValue = leftShift((write_PMA_PMD_DLY_TX_MIN_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MIN_100T1_mask = mask then
                read_PMA_PMD_DLY_TX_MIN_100T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MIN_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MIN_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MIN_100T1_value = data_low and PMA_PMD_DLY_TX_MIN_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_TX_MIN_100T1_value = &H0
        flag_PMA_PMD_DLY_TX_MIN_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp65
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_TX_MAX_100T1                   [15:0]           get_PMA_PMD_DLY_TX_MAX_100T1
''                                                             set_PMA_PMD_DLY_TX_MAX_100T1
''                                                             read_PMA_PMD_DLY_TX_MAX_100T1
''                                                             write_PMA_PMD_DLY_TX_MAX_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp65
    Private write_PMA_PMD_DLY_TX_MAX_100T1_value
    Private read_PMA_PMD_DLY_TX_MAX_100T1_value
    Private flag_PMA_PMD_DLY_TX_MAX_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hca
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_TX_MAX_100T1
        get_PMA_PMD_DLY_TX_MAX_100T1 = read_PMA_PMD_DLY_TX_MAX_100T1_value
    End Property

    Property Let set_PMA_PMD_DLY_TX_MAX_100T1(aData)
        write_PMA_PMD_DLY_TX_MAX_100T1_value = aData
        flag_PMA_PMD_DLY_TX_MAX_100T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_TX_MAX_100T1
        read
        read_PMA_PMD_DLY_TX_MAX_100T1 = read_PMA_PMD_DLY_TX_MAX_100T1_value
    End Property

    Property Let write_PMA_PMD_DLY_TX_MAX_100T1(aData)
        set_PMA_PMD_DLY_TX_MAX_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MAX_100T1_mask = mask then
                read_PMA_PMD_DLY_TX_MAX_100T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MAX_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MAX_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MAX_100T1_value = data_low and PMA_PMD_DLY_TX_MAX_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_TX_MAX_100T1 = &H0 Then read
        If flag_PMA_PMD_DLY_TX_MAX_100T1 = &H0 Then write_PMA_PMD_DLY_TX_MAX_100T1_value = get_PMA_PMD_DLY_TX_MAX_100T1

        regValue = leftShift((write_PMA_PMD_DLY_TX_MAX_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MAX_100T1_mask = mask then
                read_PMA_PMD_DLY_TX_MAX_100T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MAX_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MAX_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MAX_100T1_value = data_low and PMA_PMD_DLY_TX_MAX_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_TX_MAX_100T1_value = &H0
        flag_PMA_PMD_DLY_TX_MAX_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp66
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_RX_MIN_100T1                   [15:0]           get_PMA_PMD_DLY_RX_MIN_100T1
''                                                             set_PMA_PMD_DLY_RX_MIN_100T1
''                                                             read_PMA_PMD_DLY_RX_MIN_100T1
''                                                             write_PMA_PMD_DLY_RX_MIN_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp66
    Private write_PMA_PMD_DLY_RX_MIN_100T1_value
    Private read_PMA_PMD_DLY_RX_MIN_100T1_value
    Private flag_PMA_PMD_DLY_RX_MIN_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hcc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_RX_MIN_100T1
        get_PMA_PMD_DLY_RX_MIN_100T1 = read_PMA_PMD_DLY_RX_MIN_100T1_value
    End Property

    Property Let set_PMA_PMD_DLY_RX_MIN_100T1(aData)
        write_PMA_PMD_DLY_RX_MIN_100T1_value = aData
        flag_PMA_PMD_DLY_RX_MIN_100T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_RX_MIN_100T1
        read
        read_PMA_PMD_DLY_RX_MIN_100T1 = read_PMA_PMD_DLY_RX_MIN_100T1_value
    End Property

    Property Let write_PMA_PMD_DLY_RX_MIN_100T1(aData)
        set_PMA_PMD_DLY_RX_MIN_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MIN_100T1_mask = mask then
                read_PMA_PMD_DLY_RX_MIN_100T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MIN_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MIN_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MIN_100T1_value = data_low and PMA_PMD_DLY_RX_MIN_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_RX_MIN_100T1 = &H0 Then read
        If flag_PMA_PMD_DLY_RX_MIN_100T1 = &H0 Then write_PMA_PMD_DLY_RX_MIN_100T1_value = get_PMA_PMD_DLY_RX_MIN_100T1

        regValue = leftShift((write_PMA_PMD_DLY_RX_MIN_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MIN_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MIN_100T1_mask = mask then
                read_PMA_PMD_DLY_RX_MIN_100T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MIN_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MIN_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MIN_100T1_value = data_low and PMA_PMD_DLY_RX_MIN_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_RX_MIN_100T1_value = &H0
        flag_PMA_PMD_DLY_RX_MIN_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp67
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_RX_MAX_100T1                   [15:0]           get_PMA_PMD_DLY_RX_MAX_100T1
''                                                             set_PMA_PMD_DLY_RX_MAX_100T1
''                                                             read_PMA_PMD_DLY_RX_MAX_100T1
''                                                             write_PMA_PMD_DLY_RX_MAX_100T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp67
    Private write_PMA_PMD_DLY_RX_MAX_100T1_value
    Private read_PMA_PMD_DLY_RX_MAX_100T1_value
    Private flag_PMA_PMD_DLY_RX_MAX_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hce
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_RX_MAX_100T1
        get_PMA_PMD_DLY_RX_MAX_100T1 = read_PMA_PMD_DLY_RX_MAX_100T1_value
    End Property

    Property Let set_PMA_PMD_DLY_RX_MAX_100T1(aData)
        write_PMA_PMD_DLY_RX_MAX_100T1_value = aData
        flag_PMA_PMD_DLY_RX_MAX_100T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_RX_MAX_100T1
        read
        read_PMA_PMD_DLY_RX_MAX_100T1 = read_PMA_PMD_DLY_RX_MAX_100T1_value
    End Property

    Property Let write_PMA_PMD_DLY_RX_MAX_100T1(aData)
        set_PMA_PMD_DLY_RX_MAX_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MAX_100T1_mask = mask then
                read_PMA_PMD_DLY_RX_MAX_100T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MAX_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MAX_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MAX_100T1_value = data_low and PMA_PMD_DLY_RX_MAX_100T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_RX_MAX_100T1 = &H0 Then read
        If flag_PMA_PMD_DLY_RX_MAX_100T1 = &H0 Then write_PMA_PMD_DLY_RX_MAX_100T1_value = get_PMA_PMD_DLY_RX_MAX_100T1

        regValue = leftShift((write_PMA_PMD_DLY_RX_MAX_100T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MAX_100T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MAX_100T1_mask = mask then
                read_PMA_PMD_DLY_RX_MAX_100T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MAX_100T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MAX_100T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MAX_100T1_value = data_low and PMA_PMD_DLY_RX_MAX_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_RX_MAX_100T1_value = &H0
        flag_PMA_PMD_DLY_RX_MAX_100T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp68
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_TX_MIN_1000T1                      [15:0]           get_PCS_DLY_TX_MIN_1000T1
''                                                             set_PCS_DLY_TX_MIN_1000T1
''                                                             read_PCS_DLY_TX_MIN_1000T1
''                                                             write_PCS_DLY_TX_MIN_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp68
    Private write_PCS_DLY_TX_MIN_1000T1_value
    Private read_PCS_DLY_TX_MIN_1000T1_value
    Private flag_PCS_DLY_TX_MIN_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_TX_MIN_1000T1
        get_PCS_DLY_TX_MIN_1000T1 = read_PCS_DLY_TX_MIN_1000T1_value
    End Property

    Property Let set_PCS_DLY_TX_MIN_1000T1(aData)
        write_PCS_DLY_TX_MIN_1000T1_value = aData
        flag_PCS_DLY_TX_MIN_1000T1        = &H1
    End Property

    Property Get read_PCS_DLY_TX_MIN_1000T1
        read
        read_PCS_DLY_TX_MIN_1000T1 = read_PCS_DLY_TX_MIN_1000T1_value
    End Property

    Property Let write_PCS_DLY_TX_MIN_1000T1(aData)
        set_PCS_DLY_TX_MIN_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MIN_1000T1_mask = mask then
                read_PCS_DLY_TX_MIN_1000T1_value = data_low
            else
                read_PCS_DLY_TX_MIN_1000T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MIN_1000T1_mask
            end If
        else
            read_PCS_DLY_TX_MIN_1000T1_value = data_low and PCS_DLY_TX_MIN_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_TX_MIN_1000T1 = &H0 Then read
        If flag_PCS_DLY_TX_MIN_1000T1 = &H0 Then write_PCS_DLY_TX_MIN_1000T1_value = get_PCS_DLY_TX_MIN_1000T1

        regValue = leftShift((write_PCS_DLY_TX_MIN_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MIN_1000T1_mask = mask then
                read_PCS_DLY_TX_MIN_1000T1_value = data_low
            else
                read_PCS_DLY_TX_MIN_1000T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MIN_1000T1_mask
            end If
        else
            read_PCS_DLY_TX_MIN_1000T1_value = data_low and PCS_DLY_TX_MIN_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_TX_MIN_1000T1_value = &H0
        flag_PCS_DLY_TX_MIN_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp69
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_TX_MAX_1000T1                      [15:0]           get_PCS_DLY_TX_MAX_1000T1
''                                                             set_PCS_DLY_TX_MAX_1000T1
''                                                             read_PCS_DLY_TX_MAX_1000T1
''                                                             write_PCS_DLY_TX_MAX_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp69
    Private write_PCS_DLY_TX_MAX_1000T1_value
    Private read_PCS_DLY_TX_MAX_1000T1_value
    Private flag_PCS_DLY_TX_MAX_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_TX_MAX_1000T1
        get_PCS_DLY_TX_MAX_1000T1 = read_PCS_DLY_TX_MAX_1000T1_value
    End Property

    Property Let set_PCS_DLY_TX_MAX_1000T1(aData)
        write_PCS_DLY_TX_MAX_1000T1_value = aData
        flag_PCS_DLY_TX_MAX_1000T1        = &H1
    End Property

    Property Get read_PCS_DLY_TX_MAX_1000T1
        read
        read_PCS_DLY_TX_MAX_1000T1 = read_PCS_DLY_TX_MAX_1000T1_value
    End Property

    Property Let write_PCS_DLY_TX_MAX_1000T1(aData)
        set_PCS_DLY_TX_MAX_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MAX_1000T1_mask = mask then
                read_PCS_DLY_TX_MAX_1000T1_value = data_low
            else
                read_PCS_DLY_TX_MAX_1000T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MAX_1000T1_mask
            end If
        else
            read_PCS_DLY_TX_MAX_1000T1_value = data_low and PCS_DLY_TX_MAX_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_TX_MAX_1000T1 = &H0 Then read
        If flag_PCS_DLY_TX_MAX_1000T1 = &H0 Then write_PCS_DLY_TX_MAX_1000T1_value = get_PCS_DLY_TX_MAX_1000T1

        regValue = leftShift((write_PCS_DLY_TX_MAX_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_TX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_TX_MAX_1000T1_mask = mask then
                read_PCS_DLY_TX_MAX_1000T1_value = data_low
            else
                read_PCS_DLY_TX_MAX_1000T1_value = (data_low - H8000_0000) and PCS_DLY_TX_MAX_1000T1_mask
            end If
        else
            read_PCS_DLY_TX_MAX_1000T1_value = data_low and PCS_DLY_TX_MAX_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_TX_MAX_1000T1_value = &H0
        flag_PCS_DLY_TX_MAX_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp6a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_RX_MIN_1000T1                      [15:0]           get_PCS_DLY_RX_MIN_1000T1
''                                                             set_PCS_DLY_RX_MIN_1000T1
''                                                             read_PCS_DLY_RX_MIN_1000T1
''                                                             write_PCS_DLY_RX_MIN_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp6a
    Private write_PCS_DLY_RX_MIN_1000T1_value
    Private read_PCS_DLY_RX_MIN_1000T1_value
    Private flag_PCS_DLY_RX_MIN_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_RX_MIN_1000T1
        get_PCS_DLY_RX_MIN_1000T1 = read_PCS_DLY_RX_MIN_1000T1_value
    End Property

    Property Let set_PCS_DLY_RX_MIN_1000T1(aData)
        write_PCS_DLY_RX_MIN_1000T1_value = aData
        flag_PCS_DLY_RX_MIN_1000T1        = &H1
    End Property

    Property Get read_PCS_DLY_RX_MIN_1000T1
        read
        read_PCS_DLY_RX_MIN_1000T1 = read_PCS_DLY_RX_MIN_1000T1_value
    End Property

    Property Let write_PCS_DLY_RX_MIN_1000T1(aData)
        set_PCS_DLY_RX_MIN_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MIN_1000T1_mask = mask then
                read_PCS_DLY_RX_MIN_1000T1_value = data_low
            else
                read_PCS_DLY_RX_MIN_1000T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MIN_1000T1_mask
            end If
        else
            read_PCS_DLY_RX_MIN_1000T1_value = data_low and PCS_DLY_RX_MIN_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_RX_MIN_1000T1 = &H0 Then read
        If flag_PCS_DLY_RX_MIN_1000T1 = &H0 Then write_PCS_DLY_RX_MIN_1000T1_value = get_PCS_DLY_RX_MIN_1000T1

        regValue = leftShift((write_PCS_DLY_RX_MIN_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MIN_1000T1_mask = mask then
                read_PCS_DLY_RX_MIN_1000T1_value = data_low
            else
                read_PCS_DLY_RX_MIN_1000T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MIN_1000T1_mask
            end If
        else
            read_PCS_DLY_RX_MIN_1000T1_value = data_low and PCS_DLY_RX_MIN_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_RX_MIN_1000T1_value = &H0
        flag_PCS_DLY_RX_MIN_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp6b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DLY_RX_MAX_1000T1                      [15:0]           get_PCS_DLY_RX_MAX_1000T1
''                                                             set_PCS_DLY_RX_MAX_1000T1
''                                                             read_PCS_DLY_RX_MAX_1000T1
''                                                             write_PCS_DLY_RX_MAX_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp6b
    Private write_PCS_DLY_RX_MAX_1000T1_value
    Private read_PCS_DLY_RX_MAX_1000T1_value
    Private flag_PCS_DLY_RX_MAX_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_DLY_RX_MAX_1000T1
        get_PCS_DLY_RX_MAX_1000T1 = read_PCS_DLY_RX_MAX_1000T1_value
    End Property

    Property Let set_PCS_DLY_RX_MAX_1000T1(aData)
        write_PCS_DLY_RX_MAX_1000T1_value = aData
        flag_PCS_DLY_RX_MAX_1000T1        = &H1
    End Property

    Property Get read_PCS_DLY_RX_MAX_1000T1
        read
        read_PCS_DLY_RX_MAX_1000T1 = read_PCS_DLY_RX_MAX_1000T1_value
    End Property

    Property Let write_PCS_DLY_RX_MAX_1000T1(aData)
        set_PCS_DLY_RX_MAX_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MAX_1000T1_mask = mask then
                read_PCS_DLY_RX_MAX_1000T1_value = data_low
            else
                read_PCS_DLY_RX_MAX_1000T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MAX_1000T1_mask
            end If
        else
            read_PCS_DLY_RX_MAX_1000T1_value = data_low and PCS_DLY_RX_MAX_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DLY_RX_MAX_1000T1 = &H0 Then read
        If flag_PCS_DLY_RX_MAX_1000T1 = &H0 Then write_PCS_DLY_RX_MAX_1000T1_value = get_PCS_DLY_RX_MAX_1000T1

        regValue = leftShift((write_PCS_DLY_RX_MAX_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DLY_RX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DLY_RX_MAX_1000T1_mask = mask then
                read_PCS_DLY_RX_MAX_1000T1_value = data_low
            else
                read_PCS_DLY_RX_MAX_1000T1_value = (data_low - H8000_0000) and PCS_DLY_RX_MAX_1000T1_mask
            end If
        else
            read_PCS_DLY_RX_MAX_1000T1_value = data_low and PCS_DLY_RX_MAX_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DLY_RX_MAX_1000T1_value = &H0
        flag_PCS_DLY_RX_MAX_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp6c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_TX_MIN_1000T1                  [15:0]           get_PMA_PMD_DLY_TX_MIN_1000T1
''                                                             set_PMA_PMD_DLY_TX_MIN_1000T1
''                                                             read_PMA_PMD_DLY_TX_MIN_1000T1
''                                                             write_PMA_PMD_DLY_TX_MIN_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp6c
    Private write_PMA_PMD_DLY_TX_MIN_1000T1_value
    Private read_PMA_PMD_DLY_TX_MIN_1000T1_value
    Private flag_PMA_PMD_DLY_TX_MIN_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_TX_MIN_1000T1
        get_PMA_PMD_DLY_TX_MIN_1000T1 = read_PMA_PMD_DLY_TX_MIN_1000T1_value
    End Property

    Property Let set_PMA_PMD_DLY_TX_MIN_1000T1(aData)
        write_PMA_PMD_DLY_TX_MIN_1000T1_value = aData
        flag_PMA_PMD_DLY_TX_MIN_1000T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_TX_MIN_1000T1
        read
        read_PMA_PMD_DLY_TX_MIN_1000T1 = read_PMA_PMD_DLY_TX_MIN_1000T1_value
    End Property

    Property Let write_PMA_PMD_DLY_TX_MIN_1000T1(aData)
        set_PMA_PMD_DLY_TX_MIN_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MIN_1000T1_mask = mask then
                read_PMA_PMD_DLY_TX_MIN_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MIN_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MIN_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MIN_1000T1_value = data_low and PMA_PMD_DLY_TX_MIN_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_TX_MIN_1000T1 = &H0 Then read
        If flag_PMA_PMD_DLY_TX_MIN_1000T1 = &H0 Then write_PMA_PMD_DLY_TX_MIN_1000T1_value = get_PMA_PMD_DLY_TX_MIN_1000T1

        regValue = leftShift((write_PMA_PMD_DLY_TX_MIN_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MIN_1000T1_mask = mask then
                read_PMA_PMD_DLY_TX_MIN_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MIN_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MIN_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MIN_1000T1_value = data_low and PMA_PMD_DLY_TX_MIN_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_TX_MIN_1000T1_value = &H0
        flag_PMA_PMD_DLY_TX_MIN_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp6d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_TX_MAX_1000T1                  [15:0]           get_PMA_PMD_DLY_TX_MAX_1000T1
''                                                             set_PMA_PMD_DLY_TX_MAX_1000T1
''                                                             read_PMA_PMD_DLY_TX_MAX_1000T1
''                                                             write_PMA_PMD_DLY_TX_MAX_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp6d
    Private write_PMA_PMD_DLY_TX_MAX_1000T1_value
    Private read_PMA_PMD_DLY_TX_MAX_1000T1_value
    Private flag_PMA_PMD_DLY_TX_MAX_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hda
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_TX_MAX_1000T1
        get_PMA_PMD_DLY_TX_MAX_1000T1 = read_PMA_PMD_DLY_TX_MAX_1000T1_value
    End Property

    Property Let set_PMA_PMD_DLY_TX_MAX_1000T1(aData)
        write_PMA_PMD_DLY_TX_MAX_1000T1_value = aData
        flag_PMA_PMD_DLY_TX_MAX_1000T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_TX_MAX_1000T1
        read
        read_PMA_PMD_DLY_TX_MAX_1000T1 = read_PMA_PMD_DLY_TX_MAX_1000T1_value
    End Property

    Property Let write_PMA_PMD_DLY_TX_MAX_1000T1(aData)
        set_PMA_PMD_DLY_TX_MAX_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MAX_1000T1_mask = mask then
                read_PMA_PMD_DLY_TX_MAX_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MAX_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MAX_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MAX_1000T1_value = data_low and PMA_PMD_DLY_TX_MAX_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_TX_MAX_1000T1 = &H0 Then read
        If flag_PMA_PMD_DLY_TX_MAX_1000T1 = &H0 Then write_PMA_PMD_DLY_TX_MAX_1000T1_value = get_PMA_PMD_DLY_TX_MAX_1000T1

        regValue = leftShift((write_PMA_PMD_DLY_TX_MAX_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_TX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_TX_MAX_1000T1_mask = mask then
                read_PMA_PMD_DLY_TX_MAX_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_TX_MAX_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_TX_MAX_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_TX_MAX_1000T1_value = data_low and PMA_PMD_DLY_TX_MAX_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_TX_MAX_1000T1_value = &H0
        flag_PMA_PMD_DLY_TX_MAX_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp6e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_RX_MIN_1000T1                  [15:0]           get_PMA_PMD_DLY_RX_MIN_1000T1
''                                                             set_PMA_PMD_DLY_RX_MIN_1000T1
''                                                             read_PMA_PMD_DLY_RX_MIN_1000T1
''                                                             write_PMA_PMD_DLY_RX_MIN_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp6e
    Private write_PMA_PMD_DLY_RX_MIN_1000T1_value
    Private read_PMA_PMD_DLY_RX_MIN_1000T1_value
    Private flag_PMA_PMD_DLY_RX_MIN_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hdc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_RX_MIN_1000T1
        get_PMA_PMD_DLY_RX_MIN_1000T1 = read_PMA_PMD_DLY_RX_MIN_1000T1_value
    End Property

    Property Let set_PMA_PMD_DLY_RX_MIN_1000T1(aData)
        write_PMA_PMD_DLY_RX_MIN_1000T1_value = aData
        flag_PMA_PMD_DLY_RX_MIN_1000T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_RX_MIN_1000T1
        read
        read_PMA_PMD_DLY_RX_MIN_1000T1 = read_PMA_PMD_DLY_RX_MIN_1000T1_value
    End Property

    Property Let write_PMA_PMD_DLY_RX_MIN_1000T1(aData)
        set_PMA_PMD_DLY_RX_MIN_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MIN_1000T1_mask = mask then
                read_PMA_PMD_DLY_RX_MIN_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MIN_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MIN_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MIN_1000T1_value = data_low and PMA_PMD_DLY_RX_MIN_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_RX_MIN_1000T1 = &H0 Then read
        If flag_PMA_PMD_DLY_RX_MIN_1000T1 = &H0 Then write_PMA_PMD_DLY_RX_MIN_1000T1_value = get_PMA_PMD_DLY_RX_MIN_1000T1

        regValue = leftShift((write_PMA_PMD_DLY_RX_MIN_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MIN_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MIN_1000T1_mask = mask then
                read_PMA_PMD_DLY_RX_MIN_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MIN_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MIN_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MIN_1000T1_value = data_low and PMA_PMD_DLY_RX_MIN_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_RX_MIN_1000T1_value = &H0
        flag_PMA_PMD_DLY_RX_MIN_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp6f
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_DLY_RX_MAX_1000T1                  [15:0]           get_PMA_PMD_DLY_RX_MAX_1000T1
''                                                             set_PMA_PMD_DLY_RX_MAX_1000T1
''                                                             read_PMA_PMD_DLY_RX_MAX_1000T1
''                                                             write_PMA_PMD_DLY_RX_MAX_1000T1
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp6f
    Private write_PMA_PMD_DLY_RX_MAX_1000T1_value
    Private read_PMA_PMD_DLY_RX_MAX_1000T1_value
    Private flag_PMA_PMD_DLY_RX_MAX_1000T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hde
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA_PMD_DLY_RX_MAX_1000T1
        get_PMA_PMD_DLY_RX_MAX_1000T1 = read_PMA_PMD_DLY_RX_MAX_1000T1_value
    End Property

    Property Let set_PMA_PMD_DLY_RX_MAX_1000T1(aData)
        write_PMA_PMD_DLY_RX_MAX_1000T1_value = aData
        flag_PMA_PMD_DLY_RX_MAX_1000T1        = &H1
    End Property

    Property Get read_PMA_PMD_DLY_RX_MAX_1000T1
        read
        read_PMA_PMD_DLY_RX_MAX_1000T1 = read_PMA_PMD_DLY_RX_MAX_1000T1_value
    End Property

    Property Let write_PMA_PMD_DLY_RX_MAX_1000T1(aData)
        set_PMA_PMD_DLY_RX_MAX_1000T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MAX_1000T1_mask = mask then
                read_PMA_PMD_DLY_RX_MAX_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MAX_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MAX_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MAX_1000T1_value = data_low and PMA_PMD_DLY_RX_MAX_1000T1_mask
        end If

    End Sub

    Sub write
        If flag_PMA_PMD_DLY_RX_MAX_1000T1 = &H0 Then read
        If flag_PMA_PMD_DLY_RX_MAX_1000T1 = &H0 Then write_PMA_PMD_DLY_RX_MAX_1000T1_value = get_PMA_PMD_DLY_RX_MAX_1000T1

        regValue = leftShift((write_PMA_PMD_DLY_RX_MAX_1000T1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMA_PMD_DLY_RX_MAX_1000T1_mask = &Hffff
        if data_low > LONG_MAX then
            if PMA_PMD_DLY_RX_MAX_1000T1_mask = mask then
                read_PMA_PMD_DLY_RX_MAX_1000T1_value = data_low
            else
                read_PMA_PMD_DLY_RX_MAX_1000T1_value = (data_low - H8000_0000) and PMA_PMD_DLY_RX_MAX_1000T1_mask
            end If
        else
            read_PMA_PMD_DLY_RX_MAX_1000T1_value = data_low and PMA_PMD_DLY_RX_MAX_1000T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_DLY_RX_MAX_1000T1_value = &H0
        flag_PMA_PMD_DLY_RX_MAX_1000T1        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_exp70
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SOFT_RESET                                 [0:0]            get_SOFT_RESET
''                                                             set_SOFT_RESET
''                                                             read_SOFT_RESET
''                                                             write_SOFT_RESET
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_exp70
    Private write_SOFT_RESET_value
    Private read_SOFT_RESET_value
    Private flag_SOFT_RESET

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SOFT_RESET
        get_SOFT_RESET = read_SOFT_RESET_value
    End Property

    Property Let set_SOFT_RESET(aData)
        write_SOFT_RESET_value = aData
        flag_SOFT_RESET        = &H1
    End Property

    Property Get read_SOFT_RESET
        read
        read_SOFT_RESET = read_SOFT_RESET_value
    End Property

    Property Let write_SOFT_RESET(aData)
        set_SOFT_RESET = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SOFT_RESET_mask = &H1
        if data_low > LONG_MAX then
            if SOFT_RESET_mask = mask then
                read_SOFT_RESET_value = data_low
            else
                read_SOFT_RESET_value = (data_low - H8000_0000) and SOFT_RESET_mask
            end If
        else
            read_SOFT_RESET_value = data_low and SOFT_RESET_mask
        end If

    End Sub

    Sub write
        If flag_SOFT_RESET = &H0 Then read
        If flag_SOFT_RESET = &H0 Then write_SOFT_RESET_value = get_SOFT_RESET

        regValue = leftShift((write_SOFT_RESET_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SOFT_RESET_mask = &H1
        if data_low > LONG_MAX then
            if SOFT_RESET_mask = mask then
                read_SOFT_RESET_value = data_low
            else
                read_SOFT_RESET_value = (data_low - H8000_0000) and SOFT_RESET_mask
            end If
        else
            read_SOFT_RESET_value = data_low and SOFT_RESET_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SOFT_RESET_value = &H0
        flag_SOFT_RESET        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_expa9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REG                                  [15:0]           get_SPARE_REG
''                                                             set_SPARE_REG
''                                                             read_SPARE_REG
''                                                             write_SPARE_REG
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_expa9
    Private write_SPARE_REG_value
    Private read_SPARE_REG_value
    Private flag_SPARE_REG

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H152
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_REG
        get_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let set_SPARE_REG(aData)
        write_SPARE_REG_value = aData
        flag_SPARE_REG        = &H1
    End Property

    Property Get read_SPARE_REG
        read
        read_SPARE_REG = read_SPARE_REG_value
    End Property

    Property Let write_SPARE_REG(aData)
        set_SPARE_REG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REG = &H0 Then read
        If flag_SPARE_REG = &H0 Then write_SPARE_REG_value = get_SPARE_REG

        regValue = leftShift((write_SPARE_REG_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REG_mask = mask then
                read_SPARE_REG_value = data_low
            else
                read_SPARE_REG_value = (data_low - H8000_0000) and SPARE_REG_mask
            end If
        else
            read_SPARE_REG_value = data_low and SPARE_REG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_REG_value = &H0
        flag_SPARE_REG        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_expe3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PCS_DLY_100                             [15:8]           get_TX_PCS_DLY_100
''                                                             set_TX_PCS_DLY_100
''                                                             read_TX_PCS_DLY_100
''                                                             write_TX_PCS_DLY_100
''---------------------------------------------------------------------------------
'' TX_PCS_DLY_1000                            [7:0]            get_TX_PCS_DLY_1000
''                                                             set_TX_PCS_DLY_1000
''                                                             read_TX_PCS_DLY_1000
''                                                             write_TX_PCS_DLY_1000
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_expe3
    Private write_TX_PCS_DLY_100_value
    Private read_TX_PCS_DLY_100_value
    Private flag_TX_PCS_DLY_100
    Private write_TX_PCS_DLY_1000_value
    Private read_TX_PCS_DLY_1000_value
    Private flag_TX_PCS_DLY_1000

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H166
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PCS_DLY_100
        get_TX_PCS_DLY_100 = read_TX_PCS_DLY_100_value
    End Property

    Property Let set_TX_PCS_DLY_100(aData)
        write_TX_PCS_DLY_100_value = aData
        flag_TX_PCS_DLY_100        = &H1
    End Property

    Property Get read_TX_PCS_DLY_100
        read
        read_TX_PCS_DLY_100 = read_TX_PCS_DLY_100_value
    End Property

    Property Let write_TX_PCS_DLY_100(aData)
        set_TX_PCS_DLY_100 = aData
        write
    End Property

    Property Get get_TX_PCS_DLY_1000
        get_TX_PCS_DLY_1000 = read_TX_PCS_DLY_1000_value
    End Property

    Property Let set_TX_PCS_DLY_1000(aData)
        write_TX_PCS_DLY_1000_value = aData
        flag_TX_PCS_DLY_1000        = &H1
    End Property

    Property Get read_TX_PCS_DLY_1000
        read
        read_TX_PCS_DLY_1000 = read_TX_PCS_DLY_1000_value
    End Property

    Property Let write_TX_PCS_DLY_1000(aData)
        set_TX_PCS_DLY_1000 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PCS_DLY_100_value = rightShift(data_low, 8) and &Hff
        TX_PCS_DLY_1000_mask = &Hff
        if data_low > LONG_MAX then
            if TX_PCS_DLY_1000_mask = mask then
                read_TX_PCS_DLY_1000_value = data_low
            else
                read_TX_PCS_DLY_1000_value = (data_low - H8000_0000) and TX_PCS_DLY_1000_mask
            end If
        else
            read_TX_PCS_DLY_1000_value = data_low and TX_PCS_DLY_1000_mask
        end If

    End Sub

    Sub write
        If flag_TX_PCS_DLY_100 = &H0 or flag_TX_PCS_DLY_1000 = &H0 Then read
        If flag_TX_PCS_DLY_100 = &H0 Then write_TX_PCS_DLY_100_value = get_TX_PCS_DLY_100
        If flag_TX_PCS_DLY_1000 = &H0 Then write_TX_PCS_DLY_1000_value = get_TX_PCS_DLY_1000

        regValue = leftShift((write_TX_PCS_DLY_100_value and &Hff), 8) + leftShift((write_TX_PCS_DLY_1000_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PCS_DLY_100_value = rightShift(data_low, 8) and &Hff
        TX_PCS_DLY_1000_mask = &Hff
        if data_low > LONG_MAX then
            if TX_PCS_DLY_1000_mask = mask then
                read_TX_PCS_DLY_1000_value = data_low
            else
                read_TX_PCS_DLY_1000_value = (data_low - H8000_0000) and TX_PCS_DLY_1000_mask
            end If
        else
            read_TX_PCS_DLY_1000_value = data_low and TX_PCS_DLY_1000_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PCS_DLY_100_value = &H0
        flag_TX_PCS_DLY_100        = &H0
        write_TX_PCS_DLY_1000_value = &H0
        flag_TX_PCS_DLY_1000        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_expe6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PCS_DLY_100                             [15:8]           get_RX_PCS_DLY_100
''                                                             set_RX_PCS_DLY_100
''                                                             read_RX_PCS_DLY_100
''                                                             write_RX_PCS_DLY_100
''---------------------------------------------------------------------------------
'' RX_PCS_DLY_1000                            [7:0]            get_RX_PCS_DLY_1000
''                                                             set_RX_PCS_DLY_1000
''                                                             read_RX_PCS_DLY_1000
''                                                             write_RX_PCS_DLY_1000
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_expe6
    Private write_RX_PCS_DLY_100_value
    Private read_RX_PCS_DLY_100_value
    Private flag_RX_PCS_DLY_100
    Private write_RX_PCS_DLY_1000_value
    Private read_RX_PCS_DLY_1000_value
    Private flag_RX_PCS_DLY_1000

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RX_PCS_DLY_100
        get_RX_PCS_DLY_100 = read_RX_PCS_DLY_100_value
    End Property

    Property Let set_RX_PCS_DLY_100(aData)
        write_RX_PCS_DLY_100_value = aData
        flag_RX_PCS_DLY_100        = &H1
    End Property

    Property Get read_RX_PCS_DLY_100
        read
        read_RX_PCS_DLY_100 = read_RX_PCS_DLY_100_value
    End Property

    Property Let write_RX_PCS_DLY_100(aData)
        set_RX_PCS_DLY_100 = aData
        write
    End Property

    Property Get get_RX_PCS_DLY_1000
        get_RX_PCS_DLY_1000 = read_RX_PCS_DLY_1000_value
    End Property

    Property Let set_RX_PCS_DLY_1000(aData)
        write_RX_PCS_DLY_1000_value = aData
        flag_RX_PCS_DLY_1000        = &H1
    End Property

    Property Get read_RX_PCS_DLY_1000
        read
        read_RX_PCS_DLY_1000 = read_RX_PCS_DLY_1000_value
    End Property

    Property Let write_RX_PCS_DLY_1000(aData)
        set_RX_PCS_DLY_1000 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RX_PCS_DLY_100_value = rightShift(data_low, 8) and &Hff
        RX_PCS_DLY_1000_mask = &Hff
        if data_low > LONG_MAX then
            if RX_PCS_DLY_1000_mask = mask then
                read_RX_PCS_DLY_1000_value = data_low
            else
                read_RX_PCS_DLY_1000_value = (data_low - H8000_0000) and RX_PCS_DLY_1000_mask
            end If
        else
            read_RX_PCS_DLY_1000_value = data_low and RX_PCS_DLY_1000_mask
        end If

    End Sub

    Sub write
        If flag_RX_PCS_DLY_100 = &H0 or flag_RX_PCS_DLY_1000 = &H0 Then read
        If flag_RX_PCS_DLY_100 = &H0 Then write_RX_PCS_DLY_100_value = get_RX_PCS_DLY_100
        If flag_RX_PCS_DLY_1000 = &H0 Then write_RX_PCS_DLY_1000_value = get_RX_PCS_DLY_1000

        regValue = leftShift((write_RX_PCS_DLY_100_value and &Hff), 8) + leftShift((write_RX_PCS_DLY_1000_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RX_PCS_DLY_100_value = rightShift(data_low, 8) and &Hff
        RX_PCS_DLY_1000_mask = &Hff
        if data_low > LONG_MAX then
            if RX_PCS_DLY_1000_mask = mask then
                read_RX_PCS_DLY_1000_value = data_low
            else
                read_RX_PCS_DLY_1000_value = (data_low - H8000_0000) and RX_PCS_DLY_1000_mask
            end If
        else
            read_RX_PCS_DLY_1000_value = data_low and RX_PCS_DLY_1000_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PCS_DLY_100_value = &H0
        flag_RX_PCS_DLY_100        = &H0
        write_RX_PCS_DLY_1000_value = &H0
        flag_RX_PCS_DLY_1000        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_expe9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' P1588_TX_DLY_CYCLE                         [13:8]           get_P1588_TX_DLY_CYCLE
''                                                             set_P1588_TX_DLY_CYCLE
''                                                             read_P1588_TX_DLY_CYCLE
''                                                             write_P1588_TX_DLY_CYCLE
''---------------------------------------------------------------------------------
'' P1588_RX_DLY_CYCLE                         [5:0]            get_P1588_RX_DLY_CYCLE
''                                                             set_P1588_RX_DLY_CYCLE
''                                                             read_P1588_RX_DLY_CYCLE
''                                                             write_P1588_RX_DLY_CYCLE
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_expe9
    Private write_P1588_TX_DLY_CYCLE_value
    Private read_P1588_TX_DLY_CYCLE_value
    Private flag_P1588_TX_DLY_CYCLE
    Private write_P1588_RX_DLY_CYCLE_value
    Private read_P1588_RX_DLY_CYCLE_value
    Private flag_P1588_RX_DLY_CYCLE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H172
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_P1588_TX_DLY_CYCLE
        get_P1588_TX_DLY_CYCLE = read_P1588_TX_DLY_CYCLE_value
    End Property

    Property Let set_P1588_TX_DLY_CYCLE(aData)
        write_P1588_TX_DLY_CYCLE_value = aData
        flag_P1588_TX_DLY_CYCLE        = &H1
    End Property

    Property Get read_P1588_TX_DLY_CYCLE
        read
        read_P1588_TX_DLY_CYCLE = read_P1588_TX_DLY_CYCLE_value
    End Property

    Property Let write_P1588_TX_DLY_CYCLE(aData)
        set_P1588_TX_DLY_CYCLE = aData
        write
    End Property

    Property Get get_P1588_RX_DLY_CYCLE
        get_P1588_RX_DLY_CYCLE = read_P1588_RX_DLY_CYCLE_value
    End Property

    Property Let set_P1588_RX_DLY_CYCLE(aData)
        write_P1588_RX_DLY_CYCLE_value = aData
        flag_P1588_RX_DLY_CYCLE        = &H1
    End Property

    Property Get read_P1588_RX_DLY_CYCLE
        read
        read_P1588_RX_DLY_CYCLE = read_P1588_RX_DLY_CYCLE_value
    End Property

    Property Let write_P1588_RX_DLY_CYCLE(aData)
        set_P1588_RX_DLY_CYCLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_P1588_TX_DLY_CYCLE_value = rightShift(data_low, 8) and &H3f
        P1588_RX_DLY_CYCLE_mask = &H3f
        if data_low > LONG_MAX then
            if P1588_RX_DLY_CYCLE_mask = mask then
                read_P1588_RX_DLY_CYCLE_value = data_low
            else
                read_P1588_RX_DLY_CYCLE_value = (data_low - H8000_0000) and P1588_RX_DLY_CYCLE_mask
            end If
        else
            read_P1588_RX_DLY_CYCLE_value = data_low and P1588_RX_DLY_CYCLE_mask
        end If

    End Sub

    Sub write
        If flag_P1588_TX_DLY_CYCLE = &H0 or flag_P1588_RX_DLY_CYCLE = &H0 Then read
        If flag_P1588_TX_DLY_CYCLE = &H0 Then write_P1588_TX_DLY_CYCLE_value = get_P1588_TX_DLY_CYCLE
        If flag_P1588_RX_DLY_CYCLE = &H0 Then write_P1588_RX_DLY_CYCLE_value = get_P1588_RX_DLY_CYCLE

        regValue = leftShift((write_P1588_TX_DLY_CYCLE_value and &H3f), 8) + leftShift((write_P1588_RX_DLY_CYCLE_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_P1588_TX_DLY_CYCLE_value = rightShift(data_low, 8) and &H3f
        P1588_RX_DLY_CYCLE_mask = &H3f
        if data_low > LONG_MAX then
            if P1588_RX_DLY_CYCLE_mask = mask then
                read_P1588_RX_DLY_CYCLE_value = data_low
            else
                read_P1588_RX_DLY_CYCLE_value = (data_low - H8000_0000) and P1588_RX_DLY_CYCLE_mask
            end If
        else
            read_P1588_RX_DLY_CYCLE_value = data_low and P1588_RX_DLY_CYCLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_P1588_TX_DLY_CYCLE_value = &H0
        flag_P1588_TX_DLY_CYCLE        = &H0
        write_P1588_RX_DLY_CYCLE_value = &H0
        flag_P1588_RX_DLY_CYCLE        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_expe0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PMA_PMD_DLY_10                          [15:10]          get_TX_PMA_PMD_DLY_10
''                                                             set_TX_PMA_PMD_DLY_10
''                                                             read_TX_PMA_PMD_DLY_10
''                                                             write_TX_PMA_PMD_DLY_10
''---------------------------------------------------------------------------------
'' TX_PMA_PMD_DLY_100                         [9:5]            get_TX_PMA_PMD_DLY_100
''                                                             set_TX_PMA_PMD_DLY_100
''                                                             read_TX_PMA_PMD_DLY_100
''                                                             write_TX_PMA_PMD_DLY_100
''---------------------------------------------------------------------------------
'' TX_PMA_PMD_DLY_1000                        [4:0]            get_TX_PMA_PMD_DLY_1000
''                                                             set_TX_PMA_PMD_DLY_1000
''                                                             read_TX_PMA_PMD_DLY_1000
''                                                             write_TX_PMA_PMD_DLY_1000
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_expe0
    Private write_TX_PMA_PMD_DLY_10_value
    Private read_TX_PMA_PMD_DLY_10_value
    Private flag_TX_PMA_PMD_DLY_10
    Private write_TX_PMA_PMD_DLY_100_value
    Private read_TX_PMA_PMD_DLY_100_value
    Private flag_TX_PMA_PMD_DLY_100
    Private write_TX_PMA_PMD_DLY_1000_value
    Private read_TX_PMA_PMD_DLY_1000_value
    Private flag_TX_PMA_PMD_DLY_1000

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H174
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PMA_PMD_DLY_10
        get_TX_PMA_PMD_DLY_10 = read_TX_PMA_PMD_DLY_10_value
    End Property

    Property Let set_TX_PMA_PMD_DLY_10(aData)
        write_TX_PMA_PMD_DLY_10_value = aData
        flag_TX_PMA_PMD_DLY_10        = &H1
    End Property

    Property Get read_TX_PMA_PMD_DLY_10
        read
        read_TX_PMA_PMD_DLY_10 = read_TX_PMA_PMD_DLY_10_value
    End Property

    Property Let write_TX_PMA_PMD_DLY_10(aData)
        set_TX_PMA_PMD_DLY_10 = aData
        write
    End Property

    Property Get get_TX_PMA_PMD_DLY_100
        get_TX_PMA_PMD_DLY_100 = read_TX_PMA_PMD_DLY_100_value
    End Property

    Property Let set_TX_PMA_PMD_DLY_100(aData)
        write_TX_PMA_PMD_DLY_100_value = aData
        flag_TX_PMA_PMD_DLY_100        = &H1
    End Property

    Property Get read_TX_PMA_PMD_DLY_100
        read
        read_TX_PMA_PMD_DLY_100 = read_TX_PMA_PMD_DLY_100_value
    End Property

    Property Let write_TX_PMA_PMD_DLY_100(aData)
        set_TX_PMA_PMD_DLY_100 = aData
        write
    End Property

    Property Get get_TX_PMA_PMD_DLY_1000
        get_TX_PMA_PMD_DLY_1000 = read_TX_PMA_PMD_DLY_1000_value
    End Property

    Property Let set_TX_PMA_PMD_DLY_1000(aData)
        write_TX_PMA_PMD_DLY_1000_value = aData
        flag_TX_PMA_PMD_DLY_1000        = &H1
    End Property

    Property Get read_TX_PMA_PMD_DLY_1000
        read
        read_TX_PMA_PMD_DLY_1000 = read_TX_PMA_PMD_DLY_1000_value
    End Property

    Property Let write_TX_PMA_PMD_DLY_1000(aData)
        set_TX_PMA_PMD_DLY_1000 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PMA_PMD_DLY_10_value = rightShift(data_low, 10) and &H3f
        read_TX_PMA_PMD_DLY_100_value = rightShift(data_low, 5) and &H1f
        TX_PMA_PMD_DLY_1000_mask = &H1f
        if data_low > LONG_MAX then
            if TX_PMA_PMD_DLY_1000_mask = mask then
                read_TX_PMA_PMD_DLY_1000_value = data_low
            else
                read_TX_PMA_PMD_DLY_1000_value = (data_low - H8000_0000) and TX_PMA_PMD_DLY_1000_mask
            end If
        else
            read_TX_PMA_PMD_DLY_1000_value = data_low and TX_PMA_PMD_DLY_1000_mask
        end If

    End Sub

    Sub write
        If flag_TX_PMA_PMD_DLY_10 = &H0 or flag_TX_PMA_PMD_DLY_100 = &H0 or flag_TX_PMA_PMD_DLY_1000 = &H0 Then read
        If flag_TX_PMA_PMD_DLY_10 = &H0 Then write_TX_PMA_PMD_DLY_10_value = get_TX_PMA_PMD_DLY_10
        If flag_TX_PMA_PMD_DLY_100 = &H0 Then write_TX_PMA_PMD_DLY_100_value = get_TX_PMA_PMD_DLY_100
        If flag_TX_PMA_PMD_DLY_1000 = &H0 Then write_TX_PMA_PMD_DLY_1000_value = get_TX_PMA_PMD_DLY_1000

        regValue = leftShift((write_TX_PMA_PMD_DLY_10_value and &H3f), 10) + leftShift((write_TX_PMA_PMD_DLY_100_value and &H1f), 5) + leftShift((write_TX_PMA_PMD_DLY_1000_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PMA_PMD_DLY_10_value = rightShift(data_low, 10) and &H3f
        read_TX_PMA_PMD_DLY_100_value = rightShift(data_low, 5) and &H1f
        TX_PMA_PMD_DLY_1000_mask = &H1f
        if data_low > LONG_MAX then
            if TX_PMA_PMD_DLY_1000_mask = mask then
                read_TX_PMA_PMD_DLY_1000_value = data_low
            else
                read_TX_PMA_PMD_DLY_1000_value = (data_low - H8000_0000) and TX_PMA_PMD_DLY_1000_mask
            end If
        else
            read_TX_PMA_PMD_DLY_1000_value = data_low and TX_PMA_PMD_DLY_1000_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PMA_PMD_DLY_10_value = &H0
        flag_TX_PMA_PMD_DLY_10        = &H0
        write_TX_PMA_PMD_DLY_100_value = &H0
        flag_TX_PMA_PMD_DLY_100        = &H0
        write_TX_PMA_PMD_DLY_1000_value = &H0
        flag_TX_PMA_PMD_DLY_1000        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_expe2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PMA_PMD_DLY_10                          [13:7]           get_RX_PMA_PMD_DLY_10
''                                                             set_RX_PMA_PMD_DLY_10
''                                                             read_RX_PMA_PMD_DLY_10
''                                                             write_RX_PMA_PMD_DLY_10
''---------------------------------------------------------------------------------
'' RX_PMA_PMD_DLY_100_1000                    [6:0]            get_RX_PMA_PMD_DLY_100_1000
''                                                             set_RX_PMA_PMD_DLY_100_1000
''                                                             read_RX_PMA_PMD_DLY_100_1000
''                                                             write_RX_PMA_PMD_DLY_100_1000
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_expe2
    Private write_RX_PMA_PMD_DLY_10_value
    Private read_RX_PMA_PMD_DLY_10_value
    Private flag_RX_PMA_PMD_DLY_10
    Private write_RX_PMA_PMD_DLY_100_1000_value
    Private read_RX_PMA_PMD_DLY_100_1000_value
    Private flag_RX_PMA_PMD_DLY_100_1000

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H178
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RX_PMA_PMD_DLY_10
        get_RX_PMA_PMD_DLY_10 = read_RX_PMA_PMD_DLY_10_value
    End Property

    Property Let set_RX_PMA_PMD_DLY_10(aData)
        write_RX_PMA_PMD_DLY_10_value = aData
        flag_RX_PMA_PMD_DLY_10        = &H1
    End Property

    Property Get read_RX_PMA_PMD_DLY_10
        read
        read_RX_PMA_PMD_DLY_10 = read_RX_PMA_PMD_DLY_10_value
    End Property

    Property Let write_RX_PMA_PMD_DLY_10(aData)
        set_RX_PMA_PMD_DLY_10 = aData
        write
    End Property

    Property Get get_RX_PMA_PMD_DLY_100_1000
        get_RX_PMA_PMD_DLY_100_1000 = read_RX_PMA_PMD_DLY_100_1000_value
    End Property

    Property Let set_RX_PMA_PMD_DLY_100_1000(aData)
        write_RX_PMA_PMD_DLY_100_1000_value = aData
        flag_RX_PMA_PMD_DLY_100_1000        = &H1
    End Property

    Property Get read_RX_PMA_PMD_DLY_100_1000
        read
        read_RX_PMA_PMD_DLY_100_1000 = read_RX_PMA_PMD_DLY_100_1000_value
    End Property

    Property Let write_RX_PMA_PMD_DLY_100_1000(aData)
        set_RX_PMA_PMD_DLY_100_1000 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RX_PMA_PMD_DLY_10_value = rightShift(data_low, 7) and &H7f
        RX_PMA_PMD_DLY_100_1000_mask = &H7f
        if data_low > LONG_MAX then
            if RX_PMA_PMD_DLY_100_1000_mask = mask then
                read_RX_PMA_PMD_DLY_100_1000_value = data_low
            else
                read_RX_PMA_PMD_DLY_100_1000_value = (data_low - H8000_0000) and RX_PMA_PMD_DLY_100_1000_mask
            end If
        else
            read_RX_PMA_PMD_DLY_100_1000_value = data_low and RX_PMA_PMD_DLY_100_1000_mask
        end If

    End Sub

    Sub write
        If flag_RX_PMA_PMD_DLY_10 = &H0 or flag_RX_PMA_PMD_DLY_100_1000 = &H0 Then read
        If flag_RX_PMA_PMD_DLY_10 = &H0 Then write_RX_PMA_PMD_DLY_10_value = get_RX_PMA_PMD_DLY_10
        If flag_RX_PMA_PMD_DLY_100_1000 = &H0 Then write_RX_PMA_PMD_DLY_100_1000_value = get_RX_PMA_PMD_DLY_100_1000

        regValue = leftShift((write_RX_PMA_PMD_DLY_10_value and &H7f), 7) + leftShift((write_RX_PMA_PMD_DLY_100_1000_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RX_PMA_PMD_DLY_10_value = rightShift(data_low, 7) and &H7f
        RX_PMA_PMD_DLY_100_1000_mask = &H7f
        if data_low > LONG_MAX then
            if RX_PMA_PMD_DLY_100_1000_mask = mask then
                read_RX_PMA_PMD_DLY_100_1000_value = data_low
            else
                read_RX_PMA_PMD_DLY_100_1000_value = (data_low - H8000_0000) and RX_PMA_PMD_DLY_100_1000_mask
            end If
        else
            read_RX_PMA_PMD_DLY_100_1000_value = data_low and RX_PMA_PMD_DLY_100_1000_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PMA_PMD_DLY_10_value = &H0
        flag_RX_PMA_PMD_DLY_10        = &H0
        write_RX_PMA_PMD_DLY_100_1000_value = &H0
        flag_RX_PMA_PMD_DLY_100_1000        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_expea
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PCS_ADJ_MAX_DLY_CYCLE                   [12:10]          get_TX_PCS_ADJ_MAX_DLY_CYCLE
''                                                             set_TX_PCS_ADJ_MAX_DLY_CYCLE
''                                                             read_TX_PCS_ADJ_MAX_DLY_CYCLE
''                                                             write_TX_PCS_ADJ_MAX_DLY_CYCLE
''---------------------------------------------------------------------------------
'' TX_PCS_ADJ_MIN_DLY_CYCLE                   [9:7]            get_TX_PCS_ADJ_MIN_DLY_CYCLE
''                                                             set_TX_PCS_ADJ_MIN_DLY_CYCLE
''                                                             read_TX_PCS_ADJ_MIN_DLY_CYCLE
''                                                             write_TX_PCS_ADJ_MIN_DLY_CYCLE
''---------------------------------------------------------------------------------
'' RX_PCS_ADJ_MAX_DLY_CYCLE                   [6:4]            get_RX_PCS_ADJ_MAX_DLY_CYCLE
''                                                             set_RX_PCS_ADJ_MAX_DLY_CYCLE
''                                                             read_RX_PCS_ADJ_MAX_DLY_CYCLE
''                                                             write_RX_PCS_ADJ_MAX_DLY_CYCLE
''---------------------------------------------------------------------------------
'' RX_PCS_ADJ_MIN_DLY_CYCLE                   [3:1]            get_RX_PCS_ADJ_MIN_DLY_CYCLE
''                                                             set_RX_PCS_ADJ_MIN_DLY_CYCLE
''                                                             read_RX_PCS_ADJ_MIN_DLY_CYCLE
''                                                             write_RX_PCS_ADJ_MIN_DLY_CYCLE
''---------------------------------------------------------------------------------
'' FEATURE_802_3BF_ENABLE                     [0:0]            get_FEATURE_802_3BF_ENABLE
''                                                             set_FEATURE_802_3BF_ENABLE
''                                                             read_FEATURE_802_3BF_ENABLE
''                                                             write_FEATURE_802_3BF_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_expea
    Private write_TX_PCS_ADJ_MAX_DLY_CYCLE_value
    Private read_TX_PCS_ADJ_MAX_DLY_CYCLE_value
    Private flag_TX_PCS_ADJ_MAX_DLY_CYCLE
    Private write_TX_PCS_ADJ_MIN_DLY_CYCLE_value
    Private read_TX_PCS_ADJ_MIN_DLY_CYCLE_value
    Private flag_TX_PCS_ADJ_MIN_DLY_CYCLE
    Private write_RX_PCS_ADJ_MAX_DLY_CYCLE_value
    Private read_RX_PCS_ADJ_MAX_DLY_CYCLE_value
    Private flag_RX_PCS_ADJ_MAX_DLY_CYCLE
    Private write_RX_PCS_ADJ_MIN_DLY_CYCLE_value
    Private read_RX_PCS_ADJ_MIN_DLY_CYCLE_value
    Private flag_RX_PCS_ADJ_MIN_DLY_CYCLE
    Private write_FEATURE_802_3BF_ENABLE_value
    Private read_FEATURE_802_3BF_ENABLE_value
    Private flag_FEATURE_802_3BF_ENABLE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PCS_ADJ_MAX_DLY_CYCLE
        get_TX_PCS_ADJ_MAX_DLY_CYCLE = read_TX_PCS_ADJ_MAX_DLY_CYCLE_value
    End Property

    Property Let set_TX_PCS_ADJ_MAX_DLY_CYCLE(aData)
        write_TX_PCS_ADJ_MAX_DLY_CYCLE_value = aData
        flag_TX_PCS_ADJ_MAX_DLY_CYCLE        = &H1
    End Property

    Property Get read_TX_PCS_ADJ_MAX_DLY_CYCLE
        read
        read_TX_PCS_ADJ_MAX_DLY_CYCLE = read_TX_PCS_ADJ_MAX_DLY_CYCLE_value
    End Property

    Property Let write_TX_PCS_ADJ_MAX_DLY_CYCLE(aData)
        set_TX_PCS_ADJ_MAX_DLY_CYCLE = aData
        write
    End Property

    Property Get get_TX_PCS_ADJ_MIN_DLY_CYCLE
        get_TX_PCS_ADJ_MIN_DLY_CYCLE = read_TX_PCS_ADJ_MIN_DLY_CYCLE_value
    End Property

    Property Let set_TX_PCS_ADJ_MIN_DLY_CYCLE(aData)
        write_TX_PCS_ADJ_MIN_DLY_CYCLE_value = aData
        flag_TX_PCS_ADJ_MIN_DLY_CYCLE        = &H1
    End Property

    Property Get read_TX_PCS_ADJ_MIN_DLY_CYCLE
        read
        read_TX_PCS_ADJ_MIN_DLY_CYCLE = read_TX_PCS_ADJ_MIN_DLY_CYCLE_value
    End Property

    Property Let write_TX_PCS_ADJ_MIN_DLY_CYCLE(aData)
        set_TX_PCS_ADJ_MIN_DLY_CYCLE = aData
        write
    End Property

    Property Get get_RX_PCS_ADJ_MAX_DLY_CYCLE
        get_RX_PCS_ADJ_MAX_DLY_CYCLE = read_RX_PCS_ADJ_MAX_DLY_CYCLE_value
    End Property

    Property Let set_RX_PCS_ADJ_MAX_DLY_CYCLE(aData)
        write_RX_PCS_ADJ_MAX_DLY_CYCLE_value = aData
        flag_RX_PCS_ADJ_MAX_DLY_CYCLE        = &H1
    End Property

    Property Get read_RX_PCS_ADJ_MAX_DLY_CYCLE
        read
        read_RX_PCS_ADJ_MAX_DLY_CYCLE = read_RX_PCS_ADJ_MAX_DLY_CYCLE_value
    End Property

    Property Let write_RX_PCS_ADJ_MAX_DLY_CYCLE(aData)
        set_RX_PCS_ADJ_MAX_DLY_CYCLE = aData
        write
    End Property

    Property Get get_RX_PCS_ADJ_MIN_DLY_CYCLE
        get_RX_PCS_ADJ_MIN_DLY_CYCLE = read_RX_PCS_ADJ_MIN_DLY_CYCLE_value
    End Property

    Property Let set_RX_PCS_ADJ_MIN_DLY_CYCLE(aData)
        write_RX_PCS_ADJ_MIN_DLY_CYCLE_value = aData
        flag_RX_PCS_ADJ_MIN_DLY_CYCLE        = &H1
    End Property

    Property Get read_RX_PCS_ADJ_MIN_DLY_CYCLE
        read
        read_RX_PCS_ADJ_MIN_DLY_CYCLE = read_RX_PCS_ADJ_MIN_DLY_CYCLE_value
    End Property

    Property Let write_RX_PCS_ADJ_MIN_DLY_CYCLE(aData)
        set_RX_PCS_ADJ_MIN_DLY_CYCLE = aData
        write
    End Property

    Property Get get_FEATURE_802_3BF_ENABLE
        get_FEATURE_802_3BF_ENABLE = read_FEATURE_802_3BF_ENABLE_value
    End Property

    Property Let set_FEATURE_802_3BF_ENABLE(aData)
        write_FEATURE_802_3BF_ENABLE_value = aData
        flag_FEATURE_802_3BF_ENABLE        = &H1
    End Property

    Property Get read_FEATURE_802_3BF_ENABLE
        read
        read_FEATURE_802_3BF_ENABLE = read_FEATURE_802_3BF_ENABLE_value
    End Property

    Property Let write_FEATURE_802_3BF_ENABLE(aData)
        set_FEATURE_802_3BF_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PCS_ADJ_MAX_DLY_CYCLE_value = rightShift(data_low, 10) and &H7
        read_TX_PCS_ADJ_MIN_DLY_CYCLE_value = rightShift(data_low, 7) and &H7
        read_RX_PCS_ADJ_MAX_DLY_CYCLE_value = rightShift(data_low, 4) and &H7
        read_RX_PCS_ADJ_MIN_DLY_CYCLE_value = rightShift(data_low, 1) and &H7
        FEATURE_802_3BF_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if FEATURE_802_3BF_ENABLE_mask = mask then
                read_FEATURE_802_3BF_ENABLE_value = data_low
            else
                read_FEATURE_802_3BF_ENABLE_value = (data_low - H8000_0000) and FEATURE_802_3BF_ENABLE_mask
            end If
        else
            read_FEATURE_802_3BF_ENABLE_value = data_low and FEATURE_802_3BF_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_TX_PCS_ADJ_MAX_DLY_CYCLE = &H0 or flag_TX_PCS_ADJ_MIN_DLY_CYCLE = &H0 or flag_RX_PCS_ADJ_MAX_DLY_CYCLE = &H0 or flag_RX_PCS_ADJ_MIN_DLY_CYCLE = &H0 or flag_FEATURE_802_3BF_ENABLE = &H0 Then read
        If flag_TX_PCS_ADJ_MAX_DLY_CYCLE = &H0 Then write_TX_PCS_ADJ_MAX_DLY_CYCLE_value = get_TX_PCS_ADJ_MAX_DLY_CYCLE
        If flag_TX_PCS_ADJ_MIN_DLY_CYCLE = &H0 Then write_TX_PCS_ADJ_MIN_DLY_CYCLE_value = get_TX_PCS_ADJ_MIN_DLY_CYCLE
        If flag_RX_PCS_ADJ_MAX_DLY_CYCLE = &H0 Then write_RX_PCS_ADJ_MAX_DLY_CYCLE_value = get_RX_PCS_ADJ_MAX_DLY_CYCLE
        If flag_RX_PCS_ADJ_MIN_DLY_CYCLE = &H0 Then write_RX_PCS_ADJ_MIN_DLY_CYCLE_value = get_RX_PCS_ADJ_MIN_DLY_CYCLE
        If flag_FEATURE_802_3BF_ENABLE = &H0 Then write_FEATURE_802_3BF_ENABLE_value = get_FEATURE_802_3BF_ENABLE

        regValue = leftShift((write_TX_PCS_ADJ_MAX_DLY_CYCLE_value and &H7), 10) + leftShift((write_TX_PCS_ADJ_MIN_DLY_CYCLE_value and &H7), 7) + leftShift((write_RX_PCS_ADJ_MAX_DLY_CYCLE_value and &H7), 4) + leftShift((write_RX_PCS_ADJ_MIN_DLY_CYCLE_value and &H7), 1) + leftShift((write_FEATURE_802_3BF_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PCS_ADJ_MAX_DLY_CYCLE_value = rightShift(data_low, 10) and &H7
        read_TX_PCS_ADJ_MIN_DLY_CYCLE_value = rightShift(data_low, 7) and &H7
        read_RX_PCS_ADJ_MAX_DLY_CYCLE_value = rightShift(data_low, 4) and &H7
        read_RX_PCS_ADJ_MIN_DLY_CYCLE_value = rightShift(data_low, 1) and &H7
        FEATURE_802_3BF_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if FEATURE_802_3BF_ENABLE_mask = mask then
                read_FEATURE_802_3BF_ENABLE_value = data_low
            else
                read_FEATURE_802_3BF_ENABLE_value = (data_low - H8000_0000) and FEATURE_802_3BF_ENABLE_mask
            end If
        else
            read_FEATURE_802_3BF_ENABLE_value = data_low and FEATURE_802_3BF_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PCS_ADJ_MAX_DLY_CYCLE_value = &H0
        flag_TX_PCS_ADJ_MAX_DLY_CYCLE        = &H0
        write_TX_PCS_ADJ_MIN_DLY_CYCLE_value = &H0
        flag_TX_PCS_ADJ_MIN_DLY_CYCLE        = &H0
        write_RX_PCS_ADJ_MAX_DLY_CYCLE_value = &H0
        flag_RX_PCS_ADJ_MAX_DLY_CYCLE        = &H0
        write_RX_PCS_ADJ_MIN_DLY_CYCLE_value = &H0
        flag_RX_PCS_ADJ_MIN_DLY_CYCLE        = &H0
        write_FEATURE_802_3BF_ENABLE_value = &H0
        flag_FEATURE_802_3BF_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_tc1_lq_lfl_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK                                       [7:0]            get_MASK
''                                                             set_MASK
''                                                             read_MASK
''                                                             write_MASK
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_tc1_lq_lfl_mask
    Private write_MASK_value
    Private read_MASK_value
    Private flag_MASK

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MASK
        get_MASK = read_MASK_value
    End Property

    Property Let set_MASK(aData)
        write_MASK_value = aData
        flag_MASK        = &H1
    End Property

    Property Get read_MASK
        read
        read_MASK = read_MASK_value
    End Property

    Property Let write_MASK(aData)
        set_MASK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_mask = &Hff
        if data_low > LONG_MAX then
            if MASK_mask = mask then
                read_MASK_value = data_low
            else
                read_MASK_value = (data_low - H8000_0000) and MASK_mask
            end If
        else
            read_MASK_value = data_low and MASK_mask
        end If

    End Sub

    Sub write
        If flag_MASK = &H0 Then read
        If flag_MASK = &H0 Then write_MASK_value = get_MASK

        regValue = leftShift((write_MASK_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MASK_mask = &Hff
        if data_low > LONG_MAX then
            if MASK_mask = mask then
                read_MASK_value = data_low
            else
                read_MASK_value = (data_low - H8000_0000) and MASK_mask
            end If
        else
            read_MASK_value = data_low and MASK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_value = &H0
        flag_MASK        = &H0
    End Sub
End Class


'' @REGISTER : CORE_MISC_tc1_lq_lfl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LINK_LOSS_CNT                              [15:10]          get_LINK_LOSS_CNT
''                                                             set_LINK_LOSS_CNT
''                                                             read_LINK_LOSS_CNT
''                                                             write_LINK_LOSS_CNT
''---------------------------------------------------------------------------------
'' LINK_FAIL_CNT                              [9:0]            get_LINK_FAIL_CNT
''                                                             set_LINK_FAIL_CNT
''                                                             read_LINK_FAIL_CNT
''                                                             write_LINK_FAIL_CNT
''---------------------------------------------------------------------------------
Class REGISTER_CORE_MISC_tc1_lq_lfl
    Private write_LINK_LOSS_CNT_value
    Private read_LINK_LOSS_CNT_value
    Private flag_LINK_LOSS_CNT
    Private write_LINK_FAIL_CNT_value
    Private read_LINK_FAIL_CNT_value
    Private flag_LINK_FAIL_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LINK_LOSS_CNT
        get_LINK_LOSS_CNT = read_LINK_LOSS_CNT_value
    End Property

    Property Let set_LINK_LOSS_CNT(aData)
        write_LINK_LOSS_CNT_value = aData
        flag_LINK_LOSS_CNT        = &H1
    End Property

    Property Get read_LINK_LOSS_CNT
        read
        read_LINK_LOSS_CNT = read_LINK_LOSS_CNT_value
    End Property

    Property Let write_LINK_LOSS_CNT(aData)
        set_LINK_LOSS_CNT = aData
        write
    End Property

    Property Get get_LINK_FAIL_CNT
        get_LINK_FAIL_CNT = read_LINK_FAIL_CNT_value
    End Property

    Property Let set_LINK_FAIL_CNT(aData)
        write_LINK_FAIL_CNT_value = aData
        flag_LINK_FAIL_CNT        = &H1
    End Property

    Property Get read_LINK_FAIL_CNT
        read
        read_LINK_FAIL_CNT = read_LINK_FAIL_CNT_value
    End Property

    Property Let write_LINK_FAIL_CNT(aData)
        set_LINK_FAIL_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LINK_LOSS_CNT_value = rightShift(data_low, 10) and &H3f
        LINK_FAIL_CNT_mask = &H3ff
        if data_low > LONG_MAX then
            if LINK_FAIL_CNT_mask = mask then
                read_LINK_FAIL_CNT_value = data_low
            else
                read_LINK_FAIL_CNT_value = (data_low - H8000_0000) and LINK_FAIL_CNT_mask
            end If
        else
            read_LINK_FAIL_CNT_value = data_low and LINK_FAIL_CNT_mask
        end If

    End Sub

    Sub write
        If flag_LINK_LOSS_CNT = &H0 or flag_LINK_FAIL_CNT = &H0 Then read
        If flag_LINK_LOSS_CNT = &H0 Then write_LINK_LOSS_CNT_value = get_LINK_LOSS_CNT
        If flag_LINK_FAIL_CNT = &H0 Then write_LINK_FAIL_CNT_value = get_LINK_FAIL_CNT

        regValue = leftShift((write_LINK_LOSS_CNT_value and &H3f), 10) + leftShift((write_LINK_FAIL_CNT_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LINK_LOSS_CNT_value = rightShift(data_low, 10) and &H3f
        LINK_FAIL_CNT_mask = &H3ff
        if data_low > LONG_MAX then
            if LINK_FAIL_CNT_mask = mask then
                read_LINK_FAIL_CNT_value = data_low
            else
                read_LINK_FAIL_CNT_value = (data_low - H8000_0000) and LINK_FAIL_CNT_mask
            end If
        else
            read_LINK_FAIL_CNT_value = data_low and LINK_FAIL_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LINK_LOSS_CNT_value = &H0
        flag_LINK_LOSS_CNT        = &H0
        write_LINK_FAIL_CNT_value = &H0
        flag_LINK_FAIL_CNT        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CORE_MISC_INSTANCE

    Public base10
    Public base11
    Public base12
    Public base13
    Public base14
    Public exp46
    Public base17
    Public base1a
    Public base1b
    Public base1e
    Public base1f
    Public shd1c_02
    Public shd1c_08
    Public shd1c_09
    Public shd1c_0b
    Public shd1c_0d
    Public shd1c_0e
    Public shd18_000
    Public shd18_010
    Public shd18_111
    Public exp00
    Public exp03
    Public exp42
    Public exp60
    Public exp61
    Public exp62
    Public exp63
    Public exp64
    Public exp65
    Public exp66
    Public exp67
    Public exp68
    Public exp69
    Public exp6a
    Public exp6b
    Public exp6c
    Public exp6d
    Public exp6e
    Public exp6f
    Public exp70
    Public expa9
    Public expe3
    Public expe6
    Public expe9
    Public expe0
    Public expe2
    Public expea
    Public tc1_lq_lfl_mask
    Public tc1_lq_lfl


    Public default function Init(aBaseAddr)
        Set base10 = (New REGISTER_CORE_MISC_base10)(aBaseAddr, 16)
        Set base11 = (New REGISTER_CORE_MISC_base11)(aBaseAddr, 16)
        Set base12 = (New REGISTER_CORE_MISC_base12)(aBaseAddr, 16)
        Set base13 = (New REGISTER_CORE_MISC_base13)(aBaseAddr, 16)
        Set base14 = (New REGISTER_CORE_MISC_base14)(aBaseAddr, 16)
        Set exp46 = (New REGISTER_CORE_MISC_exp46)(aBaseAddr, 16)
        Set base17 = (New REGISTER_CORE_MISC_base17)(aBaseAddr, 16)
        Set base1a = (New REGISTER_CORE_MISC_base1a)(aBaseAddr, 16)
        Set base1b = (New REGISTER_CORE_MISC_base1b)(aBaseAddr, 16)
        Set base1e = (New REGISTER_CORE_MISC_base1e)(aBaseAddr, 16)
        Set base1f = (New REGISTER_CORE_MISC_base1f)(aBaseAddr, 16)
        Set shd1c_02 = (New REGISTER_CORE_MISC_shd1c_02)(aBaseAddr, 16)
        Set shd1c_08 = (New REGISTER_CORE_MISC_shd1c_08)(aBaseAddr, 16)
        Set shd1c_09 = (New REGISTER_CORE_MISC_shd1c_09)(aBaseAddr, 16)
        Set shd1c_0b = (New REGISTER_CORE_MISC_shd1c_0b)(aBaseAddr, 16)
        Set shd1c_0d = (New REGISTER_CORE_MISC_shd1c_0d)(aBaseAddr, 16)
        Set shd1c_0e = (New REGISTER_CORE_MISC_shd1c_0e)(aBaseAddr, 16)
        Set shd18_000 = (New REGISTER_CORE_MISC_shd18_000)(aBaseAddr, 16)
        Set shd18_010 = (New REGISTER_CORE_MISC_shd18_010)(aBaseAddr, 16)
        Set shd18_111 = (New REGISTER_CORE_MISC_shd18_111)(aBaseAddr, 16)
        Set exp00 = (New REGISTER_CORE_MISC_exp00)(aBaseAddr, 16)
        Set exp03 = (New REGISTER_CORE_MISC_exp03)(aBaseAddr, 16)
        Set exp42 = (New REGISTER_CORE_MISC_exp42)(aBaseAddr, 16)
        Set exp60 = (New REGISTER_CORE_MISC_exp60)(aBaseAddr, 16)
        Set exp61 = (New REGISTER_CORE_MISC_exp61)(aBaseAddr, 16)
        Set exp62 = (New REGISTER_CORE_MISC_exp62)(aBaseAddr, 16)
        Set exp63 = (New REGISTER_CORE_MISC_exp63)(aBaseAddr, 16)
        Set exp64 = (New REGISTER_CORE_MISC_exp64)(aBaseAddr, 16)
        Set exp65 = (New REGISTER_CORE_MISC_exp65)(aBaseAddr, 16)
        Set exp66 = (New REGISTER_CORE_MISC_exp66)(aBaseAddr, 16)
        Set exp67 = (New REGISTER_CORE_MISC_exp67)(aBaseAddr, 16)
        Set exp68 = (New REGISTER_CORE_MISC_exp68)(aBaseAddr, 16)
        Set exp69 = (New REGISTER_CORE_MISC_exp69)(aBaseAddr, 16)
        Set exp6a = (New REGISTER_CORE_MISC_exp6a)(aBaseAddr, 16)
        Set exp6b = (New REGISTER_CORE_MISC_exp6b)(aBaseAddr, 16)
        Set exp6c = (New REGISTER_CORE_MISC_exp6c)(aBaseAddr, 16)
        Set exp6d = (New REGISTER_CORE_MISC_exp6d)(aBaseAddr, 16)
        Set exp6e = (New REGISTER_CORE_MISC_exp6e)(aBaseAddr, 16)
        Set exp6f = (New REGISTER_CORE_MISC_exp6f)(aBaseAddr, 16)
        Set exp70 = (New REGISTER_CORE_MISC_exp70)(aBaseAddr, 16)
        Set expa9 = (New REGISTER_CORE_MISC_expa9)(aBaseAddr, 16)
        Set expe3 = (New REGISTER_CORE_MISC_expe3)(aBaseAddr, 16)
        Set expe6 = (New REGISTER_CORE_MISC_expe6)(aBaseAddr, 16)
        Set expe9 = (New REGISTER_CORE_MISC_expe9)(aBaseAddr, 16)
        Set expe0 = (New REGISTER_CORE_MISC_expe0)(aBaseAddr, 16)
        Set expe2 = (New REGISTER_CORE_MISC_expe2)(aBaseAddr, 16)
        Set expea = (New REGISTER_CORE_MISC_expea)(aBaseAddr, 16)
        Set tc1_lq_lfl_mask = (New REGISTER_CORE_MISC_tc1_lq_lfl_mask)(aBaseAddr, 16)
        Set tc1_lq_lfl = (New REGISTER_CORE_MISC_tc1_lq_lfl)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CORE_MISC = CreateObject("System.Collections.ArrayList")
CORE_MISC.Add ((New CORE_MISC_INSTANCE)(&H49032600))


