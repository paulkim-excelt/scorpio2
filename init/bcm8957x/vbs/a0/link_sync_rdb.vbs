

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


'' @REGISTER : LINK_SYNC_sigdet_threshold
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTO_THRESHOLD                             [15:12]          get_AUTO_THRESHOLD
''                                                             set_AUTO_THRESHOLD
''                                                             read_AUTO_THRESHOLD
''                                                             write_AUTO_THRESHOLD
''---------------------------------------------------------------------------------
'' THRESHOLD                                  [11:0]           get_THRESHOLD
''                                                             set_THRESHOLD
''                                                             read_THRESHOLD
''                                                             write_THRESHOLD
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_sigdet_threshold
    Private write_AUTO_THRESHOLD_value
    Private read_AUTO_THRESHOLD_value
    Private flag_AUTO_THRESHOLD
    Private write_THRESHOLD_value
    Private read_THRESHOLD_value
    Private flag_THRESHOLD

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

    Property Get get_AUTO_THRESHOLD
        get_AUTO_THRESHOLD = read_AUTO_THRESHOLD_value
    End Property

    Property Let set_AUTO_THRESHOLD(aData)
        write_AUTO_THRESHOLD_value = aData
        flag_AUTO_THRESHOLD        = &H1
    End Property

    Property Get read_AUTO_THRESHOLD
        read
        read_AUTO_THRESHOLD = read_AUTO_THRESHOLD_value
    End Property

    Property Let write_AUTO_THRESHOLD(aData)
        set_AUTO_THRESHOLD = aData
        write
    End Property

    Property Get get_THRESHOLD
        get_THRESHOLD = read_THRESHOLD_value
    End Property

    Property Let set_THRESHOLD(aData)
        write_THRESHOLD_value = aData
        flag_THRESHOLD        = &H1
    End Property

    Property Get read_THRESHOLD
        read
        read_THRESHOLD = read_THRESHOLD_value
    End Property

    Property Let write_THRESHOLD(aData)
        set_THRESHOLD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTO_THRESHOLD_value = rightShift(data_low, 12) and &Hf
        THRESHOLD_mask = &Hfff
        if data_low > LONG_MAX then
            if THRESHOLD_mask = mask then
                read_THRESHOLD_value = data_low
            else
                read_THRESHOLD_value = (data_low - H8000_0000) and THRESHOLD_mask
            end If
        else
            read_THRESHOLD_value = data_low and THRESHOLD_mask
        end If

    End Sub

    Sub write
        If flag_AUTO_THRESHOLD = &H0 or flag_THRESHOLD = &H0 Then read
        If flag_AUTO_THRESHOLD = &H0 Then write_AUTO_THRESHOLD_value = get_AUTO_THRESHOLD
        If flag_THRESHOLD = &H0 Then write_THRESHOLD_value = get_THRESHOLD

        regValue = leftShift((write_AUTO_THRESHOLD_value and &Hf), 12) + leftShift((write_THRESHOLD_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTO_THRESHOLD_value = rightShift(data_low, 12) and &Hf
        THRESHOLD_mask = &Hfff
        if data_low > LONG_MAX then
            if THRESHOLD_mask = mask then
                read_THRESHOLD_value = data_low
            else
                read_THRESHOLD_value = (data_low - H8000_0000) and THRESHOLD_mask
            end If
        else
            read_THRESHOLD_value = data_low and THRESHOLD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTO_THRESHOLD_value = &H0
        flag_AUTO_THRESHOLD        = &H0
        write_THRESHOLD_value = &H0
        flag_THRESHOLD        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_sigdet_window
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WINDOW_HIGH                                [15:8]           get_WINDOW_HIGH
''                                                             set_WINDOW_HIGH
''                                                             read_WINDOW_HIGH
''                                                             write_WINDOW_HIGH
''---------------------------------------------------------------------------------
'' WINDOW_LOW                                 [7:0]            get_WINDOW_LOW
''                                                             set_WINDOW_LOW
''                                                             read_WINDOW_LOW
''                                                             write_WINDOW_LOW
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_sigdet_window
    Private write_WINDOW_HIGH_value
    Private read_WINDOW_HIGH_value
    Private flag_WINDOW_HIGH
    Private write_WINDOW_LOW_value
    Private read_WINDOW_LOW_value
    Private flag_WINDOW_LOW

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

    Property Get get_WINDOW_HIGH
        get_WINDOW_HIGH = read_WINDOW_HIGH_value
    End Property

    Property Let set_WINDOW_HIGH(aData)
        write_WINDOW_HIGH_value = aData
        flag_WINDOW_HIGH        = &H1
    End Property

    Property Get read_WINDOW_HIGH
        read
        read_WINDOW_HIGH = read_WINDOW_HIGH_value
    End Property

    Property Let write_WINDOW_HIGH(aData)
        set_WINDOW_HIGH = aData
        write
    End Property

    Property Get get_WINDOW_LOW
        get_WINDOW_LOW = read_WINDOW_LOW_value
    End Property

    Property Let set_WINDOW_LOW(aData)
        write_WINDOW_LOW_value = aData
        flag_WINDOW_LOW        = &H1
    End Property

    Property Get read_WINDOW_LOW
        read
        read_WINDOW_LOW = read_WINDOW_LOW_value
    End Property

    Property Let write_WINDOW_LOW(aData)
        set_WINDOW_LOW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_WINDOW_HIGH_value = rightShift(data_low, 8) and &Hff
        WINDOW_LOW_mask = &Hff
        if data_low > LONG_MAX then
            if WINDOW_LOW_mask = mask then
                read_WINDOW_LOW_value = data_low
            else
                read_WINDOW_LOW_value = (data_low - H8000_0000) and WINDOW_LOW_mask
            end If
        else
            read_WINDOW_LOW_value = data_low and WINDOW_LOW_mask
        end If

    End Sub

    Sub write
        If flag_WINDOW_HIGH = &H0 or flag_WINDOW_LOW = &H0 Then read
        If flag_WINDOW_HIGH = &H0 Then write_WINDOW_HIGH_value = get_WINDOW_HIGH
        If flag_WINDOW_LOW = &H0 Then write_WINDOW_LOW_value = get_WINDOW_LOW

        regValue = leftShift((write_WINDOW_HIGH_value and &Hff), 8) + leftShift((write_WINDOW_LOW_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_WINDOW_HIGH_value = rightShift(data_low, 8) and &Hff
        WINDOW_LOW_mask = &Hff
        if data_low > LONG_MAX then
            if WINDOW_LOW_mask = mask then
                read_WINDOW_LOW_value = data_low
            else
                read_WINDOW_LOW_value = (data_low - H8000_0000) and WINDOW_LOW_mask
            end If
        else
            read_WINDOW_LOW_value = data_low and WINDOW_LOW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WINDOW_HIGH_value = &H0
        flag_WINDOW_HIGH        = &H0
        write_WINDOW_LOW_value = &H0
        flag_WINDOW_LOW        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_control_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTOSPEED_EN                               [15:15]          get_AUTOSPEED_EN
''                                                             set_AUTOSPEED_EN
''                                                             read_AUTOSPEED_EN
''                                                             write_AUTOSPEED_EN
''---------------------------------------------------------------------------------
'' AUTOSPEED_PER                              [14:14]          get_AUTOSPEED_PER
''                                                             set_AUTOSPEED_PER
''                                                             read_AUTOSPEED_PER
''                                                             write_AUTOSPEED_PER
''---------------------------------------------------------------------------------
'' AUTOSPEED_MS                               [13:13]          get_AUTOSPEED_MS
''                                                             set_AUTOSPEED_MS
''                                                             read_AUTOSPEED_MS
''                                                             write_AUTOSPEED_MS
''---------------------------------------------------------------------------------
'' AUTOSPEED_RX_SYMBOL_ORDER                  [12:12]          get_AUTOSPEED_RX_SYMBOL_ORDER
''                                                             set_AUTOSPEED_RX_SYMBOL_ORDER
''                                                             read_AUTOSPEED_RX_SYMBOL_ORDER
''                                                             write_AUTOSPEED_RX_SYMBOL_ORDER
''---------------------------------------------------------------------------------
'' AUTOSPEED_TX_SYMBOL_ORDER                  [11:11]          get_AUTOSPEED_TX_SYMBOL_ORDER
''                                                             set_AUTOSPEED_TX_SYMBOL_ORDER
''                                                             read_AUTOSPEED_TX_SYMBOL_ORDER
''                                                             write_AUTOSPEED_TX_SYMBOL_ORDER
''---------------------------------------------------------------------------------
'' NUMBER_OF_AUTOSPEED_ATTEMPTS               [10:8]           get_NUMBER_OF_AUTOSPEED_ATTEMPTS
''                                                             set_NUMBER_OF_AUTOSPEED_ATTEMPTS
''                                                             read_NUMBER_OF_AUTOSPEED_ATTEMPTS
''                                                             write_NUMBER_OF_AUTOSPEED_ATTEMPTS
''---------------------------------------------------------------------------------
'' AUTOSPEED_INITIAL_SPEED                    [7:7]            get_AUTOSPEED_INITIAL_SPEED
''                                                             set_AUTOSPEED_INITIAL_SPEED
''                                                             read_AUTOSPEED_INITIAL_SPEED
''                                                             write_AUTOSPEED_INITIAL_SPEED
''---------------------------------------------------------------------------------
'' SYNC_1000T1_DETECT_VALUE                   [6:6]            get_SYNC_1000T1_DETECT_VALUE
''                                                             set_SYNC_1000T1_DETECT_VALUE
''                                                             read_SYNC_1000T1_DETECT_VALUE
''                                                             write_SYNC_1000T1_DETECT_VALUE
''---------------------------------------------------------------------------------
'' SYNC_1000T1_DETECT_FORCE                   [5:5]            get_SYNC_1000T1_DETECT_FORCE
''                                                             set_SYNC_1000T1_DETECT_FORCE
''                                                             read_SYNC_1000T1_DETECT_FORCE
''                                                             write_SYNC_1000T1_DETECT_FORCE
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_VALUE                  [4:4]            get_LEGACY_100T1_DETECT_VALUE
''                                                             set_LEGACY_100T1_DETECT_VALUE
''                                                             read_LEGACY_100T1_DETECT_VALUE
''                                                             write_LEGACY_100T1_DETECT_VALUE
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_FORCE                  [3:3]            get_LEGACY_100T1_DETECT_FORCE
''                                                             set_LEGACY_100T1_DETECT_FORCE
''                                                             read_LEGACY_100T1_DETECT_FORCE
''                                                             write_LEGACY_100T1_DETECT_FORCE
''---------------------------------------------------------------------------------
'' SYNC_LINK_CTRL_100T1_VALUE                 [2:2]            get_SYNC_LINK_CTRL_100T1_VALUE
''                                                             set_SYNC_LINK_CTRL_100T1_VALUE
''                                                             read_SYNC_LINK_CTRL_100T1_VALUE
''                                                             write_SYNC_LINK_CTRL_100T1_VALUE
''---------------------------------------------------------------------------------
'' SYNC_LINK_CTRL_1000T1_VALUE                [1:1]            get_SYNC_LINK_CTRL_1000T1_VALUE
''                                                             set_SYNC_LINK_CTRL_1000T1_VALUE
''                                                             read_SYNC_LINK_CTRL_1000T1_VALUE
''                                                             write_SYNC_LINK_CTRL_1000T1_VALUE
''---------------------------------------------------------------------------------
'' SYNC_LINK_CTRL_FORCE                       [0:0]            get_SYNC_LINK_CTRL_FORCE
''                                                             set_SYNC_LINK_CTRL_FORCE
''                                                             read_SYNC_LINK_CTRL_FORCE
''                                                             write_SYNC_LINK_CTRL_FORCE
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_control_a
    Private write_AUTOSPEED_EN_value
    Private read_AUTOSPEED_EN_value
    Private flag_AUTOSPEED_EN
    Private write_AUTOSPEED_PER_value
    Private read_AUTOSPEED_PER_value
    Private flag_AUTOSPEED_PER
    Private write_AUTOSPEED_MS_value
    Private read_AUTOSPEED_MS_value
    Private flag_AUTOSPEED_MS
    Private write_AUTOSPEED_RX_SYMBOL_ORDER_value
    Private read_AUTOSPEED_RX_SYMBOL_ORDER_value
    Private flag_AUTOSPEED_RX_SYMBOL_ORDER
    Private write_AUTOSPEED_TX_SYMBOL_ORDER_value
    Private read_AUTOSPEED_TX_SYMBOL_ORDER_value
    Private flag_AUTOSPEED_TX_SYMBOL_ORDER
    Private write_NUMBER_OF_AUTOSPEED_ATTEMPTS_value
    Private read_NUMBER_OF_AUTOSPEED_ATTEMPTS_value
    Private flag_NUMBER_OF_AUTOSPEED_ATTEMPTS
    Private write_AUTOSPEED_INITIAL_SPEED_value
    Private read_AUTOSPEED_INITIAL_SPEED_value
    Private flag_AUTOSPEED_INITIAL_SPEED
    Private write_SYNC_1000T1_DETECT_VALUE_value
    Private read_SYNC_1000T1_DETECT_VALUE_value
    Private flag_SYNC_1000T1_DETECT_VALUE
    Private write_SYNC_1000T1_DETECT_FORCE_value
    Private read_SYNC_1000T1_DETECT_FORCE_value
    Private flag_SYNC_1000T1_DETECT_FORCE
    Private write_LEGACY_100T1_DETECT_VALUE_value
    Private read_LEGACY_100T1_DETECT_VALUE_value
    Private flag_LEGACY_100T1_DETECT_VALUE
    Private write_LEGACY_100T1_DETECT_FORCE_value
    Private read_LEGACY_100T1_DETECT_FORCE_value
    Private flag_LEGACY_100T1_DETECT_FORCE
    Private write_SYNC_LINK_CTRL_100T1_VALUE_value
    Private read_SYNC_LINK_CTRL_100T1_VALUE_value
    Private flag_SYNC_LINK_CTRL_100T1_VALUE
    Private write_SYNC_LINK_CTRL_1000T1_VALUE_value
    Private read_SYNC_LINK_CTRL_1000T1_VALUE_value
    Private flag_SYNC_LINK_CTRL_1000T1_VALUE
    Private write_SYNC_LINK_CTRL_FORCE_value
    Private read_SYNC_LINK_CTRL_FORCE_value
    Private flag_SYNC_LINK_CTRL_FORCE

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

    Property Get get_AUTOSPEED_EN
        get_AUTOSPEED_EN = read_AUTOSPEED_EN_value
    End Property

    Property Let set_AUTOSPEED_EN(aData)
        write_AUTOSPEED_EN_value = aData
        flag_AUTOSPEED_EN        = &H1
    End Property

    Property Get read_AUTOSPEED_EN
        read
        read_AUTOSPEED_EN = read_AUTOSPEED_EN_value
    End Property

    Property Let write_AUTOSPEED_EN(aData)
        set_AUTOSPEED_EN = aData
        write
    End Property

    Property Get get_AUTOSPEED_PER
        get_AUTOSPEED_PER = read_AUTOSPEED_PER_value
    End Property

    Property Let set_AUTOSPEED_PER(aData)
        write_AUTOSPEED_PER_value = aData
        flag_AUTOSPEED_PER        = &H1
    End Property

    Property Get read_AUTOSPEED_PER
        read
        read_AUTOSPEED_PER = read_AUTOSPEED_PER_value
    End Property

    Property Let write_AUTOSPEED_PER(aData)
        set_AUTOSPEED_PER = aData
        write
    End Property

    Property Get get_AUTOSPEED_MS
        get_AUTOSPEED_MS = read_AUTOSPEED_MS_value
    End Property

    Property Let set_AUTOSPEED_MS(aData)
        write_AUTOSPEED_MS_value = aData
        flag_AUTOSPEED_MS        = &H1
    End Property

    Property Get read_AUTOSPEED_MS
        read
        read_AUTOSPEED_MS = read_AUTOSPEED_MS_value
    End Property

    Property Let write_AUTOSPEED_MS(aData)
        set_AUTOSPEED_MS = aData
        write
    End Property

    Property Get get_AUTOSPEED_RX_SYMBOL_ORDER
        get_AUTOSPEED_RX_SYMBOL_ORDER = read_AUTOSPEED_RX_SYMBOL_ORDER_value
    End Property

    Property Let set_AUTOSPEED_RX_SYMBOL_ORDER(aData)
        write_AUTOSPEED_RX_SYMBOL_ORDER_value = aData
        flag_AUTOSPEED_RX_SYMBOL_ORDER        = &H1
    End Property

    Property Get read_AUTOSPEED_RX_SYMBOL_ORDER
        read
        read_AUTOSPEED_RX_SYMBOL_ORDER = read_AUTOSPEED_RX_SYMBOL_ORDER_value
    End Property

    Property Let write_AUTOSPEED_RX_SYMBOL_ORDER(aData)
        set_AUTOSPEED_RX_SYMBOL_ORDER = aData
        write
    End Property

    Property Get get_AUTOSPEED_TX_SYMBOL_ORDER
        get_AUTOSPEED_TX_SYMBOL_ORDER = read_AUTOSPEED_TX_SYMBOL_ORDER_value
    End Property

    Property Let set_AUTOSPEED_TX_SYMBOL_ORDER(aData)
        write_AUTOSPEED_TX_SYMBOL_ORDER_value = aData
        flag_AUTOSPEED_TX_SYMBOL_ORDER        = &H1
    End Property

    Property Get read_AUTOSPEED_TX_SYMBOL_ORDER
        read
        read_AUTOSPEED_TX_SYMBOL_ORDER = read_AUTOSPEED_TX_SYMBOL_ORDER_value
    End Property

    Property Let write_AUTOSPEED_TX_SYMBOL_ORDER(aData)
        set_AUTOSPEED_TX_SYMBOL_ORDER = aData
        write
    End Property

    Property Get get_NUMBER_OF_AUTOSPEED_ATTEMPTS
        get_NUMBER_OF_AUTOSPEED_ATTEMPTS = read_NUMBER_OF_AUTOSPEED_ATTEMPTS_value
    End Property

    Property Let set_NUMBER_OF_AUTOSPEED_ATTEMPTS(aData)
        write_NUMBER_OF_AUTOSPEED_ATTEMPTS_value = aData
        flag_NUMBER_OF_AUTOSPEED_ATTEMPTS        = &H1
    End Property

    Property Get read_NUMBER_OF_AUTOSPEED_ATTEMPTS
        read
        read_NUMBER_OF_AUTOSPEED_ATTEMPTS = read_NUMBER_OF_AUTOSPEED_ATTEMPTS_value
    End Property

    Property Let write_NUMBER_OF_AUTOSPEED_ATTEMPTS(aData)
        set_NUMBER_OF_AUTOSPEED_ATTEMPTS = aData
        write
    End Property

    Property Get get_AUTOSPEED_INITIAL_SPEED
        get_AUTOSPEED_INITIAL_SPEED = read_AUTOSPEED_INITIAL_SPEED_value
    End Property

    Property Let set_AUTOSPEED_INITIAL_SPEED(aData)
        write_AUTOSPEED_INITIAL_SPEED_value = aData
        flag_AUTOSPEED_INITIAL_SPEED        = &H1
    End Property

    Property Get read_AUTOSPEED_INITIAL_SPEED
        read
        read_AUTOSPEED_INITIAL_SPEED = read_AUTOSPEED_INITIAL_SPEED_value
    End Property

    Property Let write_AUTOSPEED_INITIAL_SPEED(aData)
        set_AUTOSPEED_INITIAL_SPEED = aData
        write
    End Property

    Property Get get_SYNC_1000T1_DETECT_VALUE
        get_SYNC_1000T1_DETECT_VALUE = read_SYNC_1000T1_DETECT_VALUE_value
    End Property

    Property Let set_SYNC_1000T1_DETECT_VALUE(aData)
        write_SYNC_1000T1_DETECT_VALUE_value = aData
        flag_SYNC_1000T1_DETECT_VALUE        = &H1
    End Property

    Property Get read_SYNC_1000T1_DETECT_VALUE
        read
        read_SYNC_1000T1_DETECT_VALUE = read_SYNC_1000T1_DETECT_VALUE_value
    End Property

    Property Let write_SYNC_1000T1_DETECT_VALUE(aData)
        set_SYNC_1000T1_DETECT_VALUE = aData
        write
    End Property

    Property Get get_SYNC_1000T1_DETECT_FORCE
        get_SYNC_1000T1_DETECT_FORCE = read_SYNC_1000T1_DETECT_FORCE_value
    End Property

    Property Let set_SYNC_1000T1_DETECT_FORCE(aData)
        write_SYNC_1000T1_DETECT_FORCE_value = aData
        flag_SYNC_1000T1_DETECT_FORCE        = &H1
    End Property

    Property Get read_SYNC_1000T1_DETECT_FORCE
        read
        read_SYNC_1000T1_DETECT_FORCE = read_SYNC_1000T1_DETECT_FORCE_value
    End Property

    Property Let write_SYNC_1000T1_DETECT_FORCE(aData)
        set_SYNC_1000T1_DETECT_FORCE = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECT_VALUE
        get_LEGACY_100T1_DETECT_VALUE = read_LEGACY_100T1_DETECT_VALUE_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_VALUE(aData)
        write_LEGACY_100T1_DETECT_VALUE_value = aData
        flag_LEGACY_100T1_DETECT_VALUE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_VALUE
        read
        read_LEGACY_100T1_DETECT_VALUE = read_LEGACY_100T1_DETECT_VALUE_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_VALUE(aData)
        set_LEGACY_100T1_DETECT_VALUE = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECT_FORCE
        get_LEGACY_100T1_DETECT_FORCE = read_LEGACY_100T1_DETECT_FORCE_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_FORCE(aData)
        write_LEGACY_100T1_DETECT_FORCE_value = aData
        flag_LEGACY_100T1_DETECT_FORCE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_FORCE
        read
        read_LEGACY_100T1_DETECT_FORCE = read_LEGACY_100T1_DETECT_FORCE_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_FORCE(aData)
        set_LEGACY_100T1_DETECT_FORCE = aData
        write
    End Property

    Property Get get_SYNC_LINK_CTRL_100T1_VALUE
        get_SYNC_LINK_CTRL_100T1_VALUE = read_SYNC_LINK_CTRL_100T1_VALUE_value
    End Property

    Property Let set_SYNC_LINK_CTRL_100T1_VALUE(aData)
        write_SYNC_LINK_CTRL_100T1_VALUE_value = aData
        flag_SYNC_LINK_CTRL_100T1_VALUE        = &H1
    End Property

    Property Get read_SYNC_LINK_CTRL_100T1_VALUE
        read
        read_SYNC_LINK_CTRL_100T1_VALUE = read_SYNC_LINK_CTRL_100T1_VALUE_value
    End Property

    Property Let write_SYNC_LINK_CTRL_100T1_VALUE(aData)
        set_SYNC_LINK_CTRL_100T1_VALUE = aData
        write
    End Property

    Property Get get_SYNC_LINK_CTRL_1000T1_VALUE
        get_SYNC_LINK_CTRL_1000T1_VALUE = read_SYNC_LINK_CTRL_1000T1_VALUE_value
    End Property

    Property Let set_SYNC_LINK_CTRL_1000T1_VALUE(aData)
        write_SYNC_LINK_CTRL_1000T1_VALUE_value = aData
        flag_SYNC_LINK_CTRL_1000T1_VALUE        = &H1
    End Property

    Property Get read_SYNC_LINK_CTRL_1000T1_VALUE
        read
        read_SYNC_LINK_CTRL_1000T1_VALUE = read_SYNC_LINK_CTRL_1000T1_VALUE_value
    End Property

    Property Let write_SYNC_LINK_CTRL_1000T1_VALUE(aData)
        set_SYNC_LINK_CTRL_1000T1_VALUE = aData
        write
    End Property

    Property Get get_SYNC_LINK_CTRL_FORCE
        get_SYNC_LINK_CTRL_FORCE = read_SYNC_LINK_CTRL_FORCE_value
    End Property

    Property Let set_SYNC_LINK_CTRL_FORCE(aData)
        write_SYNC_LINK_CTRL_FORCE_value = aData
        flag_SYNC_LINK_CTRL_FORCE        = &H1
    End Property

    Property Get read_SYNC_LINK_CTRL_FORCE
        read
        read_SYNC_LINK_CTRL_FORCE = read_SYNC_LINK_CTRL_FORCE_value
    End Property

    Property Let write_SYNC_LINK_CTRL_FORCE(aData)
        set_SYNC_LINK_CTRL_FORCE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTOSPEED_EN_value = rightShift(data_low, 15) and &H1
        read_AUTOSPEED_PER_value = rightShift(data_low, 14) and &H1
        read_AUTOSPEED_MS_value = rightShift(data_low, 13) and &H1
        read_AUTOSPEED_RX_SYMBOL_ORDER_value = rightShift(data_low, 12) and &H1
        read_AUTOSPEED_TX_SYMBOL_ORDER_value = rightShift(data_low, 11) and &H1
        read_NUMBER_OF_AUTOSPEED_ATTEMPTS_value = rightShift(data_low, 8) and &H7
        read_AUTOSPEED_INITIAL_SPEED_value = rightShift(data_low, 7) and &H1
        read_SYNC_1000T1_DETECT_VALUE_value = rightShift(data_low, 6) and &H1
        read_SYNC_1000T1_DETECT_FORCE_value = rightShift(data_low, 5) and &H1
        read_LEGACY_100T1_DETECT_VALUE_value = rightShift(data_low, 4) and &H1
        read_LEGACY_100T1_DETECT_FORCE_value = rightShift(data_low, 3) and &H1
        read_SYNC_LINK_CTRL_100T1_VALUE_value = rightShift(data_low, 2) and &H1
        read_SYNC_LINK_CTRL_1000T1_VALUE_value = rightShift(data_low, 1) and &H1
        SYNC_LINK_CTRL_FORCE_mask = &H1
        if data_low > LONG_MAX then
            if SYNC_LINK_CTRL_FORCE_mask = mask then
                read_SYNC_LINK_CTRL_FORCE_value = data_low
            else
                read_SYNC_LINK_CTRL_FORCE_value = (data_low - H8000_0000) and SYNC_LINK_CTRL_FORCE_mask
            end If
        else
            read_SYNC_LINK_CTRL_FORCE_value = data_low and SYNC_LINK_CTRL_FORCE_mask
        end If

    End Sub

    Sub write
        If flag_AUTOSPEED_EN = &H0 or flag_AUTOSPEED_PER = &H0 or flag_AUTOSPEED_MS = &H0 or flag_AUTOSPEED_RX_SYMBOL_ORDER = &H0 or flag_AUTOSPEED_TX_SYMBOL_ORDER = &H0 or flag_NUMBER_OF_AUTOSPEED_ATTEMPTS = &H0 or flag_AUTOSPEED_INITIAL_SPEED = &H0 or flag_SYNC_1000T1_DETECT_VALUE = &H0 or flag_SYNC_1000T1_DETECT_FORCE = &H0 or flag_LEGACY_100T1_DETECT_VALUE = &H0 or flag_LEGACY_100T1_DETECT_FORCE = &H0 or flag_SYNC_LINK_CTRL_100T1_VALUE = &H0 or flag_SYNC_LINK_CTRL_1000T1_VALUE = &H0 or flag_SYNC_LINK_CTRL_FORCE = &H0 Then read
        If flag_AUTOSPEED_EN = &H0 Then write_AUTOSPEED_EN_value = get_AUTOSPEED_EN
        If flag_AUTOSPEED_PER = &H0 Then write_AUTOSPEED_PER_value = get_AUTOSPEED_PER
        If flag_AUTOSPEED_MS = &H0 Then write_AUTOSPEED_MS_value = get_AUTOSPEED_MS
        If flag_AUTOSPEED_RX_SYMBOL_ORDER = &H0 Then write_AUTOSPEED_RX_SYMBOL_ORDER_value = get_AUTOSPEED_RX_SYMBOL_ORDER
        If flag_AUTOSPEED_TX_SYMBOL_ORDER = &H0 Then write_AUTOSPEED_TX_SYMBOL_ORDER_value = get_AUTOSPEED_TX_SYMBOL_ORDER
        If flag_NUMBER_OF_AUTOSPEED_ATTEMPTS = &H0 Then write_NUMBER_OF_AUTOSPEED_ATTEMPTS_value = get_NUMBER_OF_AUTOSPEED_ATTEMPTS
        If flag_AUTOSPEED_INITIAL_SPEED = &H0 Then write_AUTOSPEED_INITIAL_SPEED_value = get_AUTOSPEED_INITIAL_SPEED
        If flag_SYNC_1000T1_DETECT_VALUE = &H0 Then write_SYNC_1000T1_DETECT_VALUE_value = get_SYNC_1000T1_DETECT_VALUE
        If flag_SYNC_1000T1_DETECT_FORCE = &H0 Then write_SYNC_1000T1_DETECT_FORCE_value = get_SYNC_1000T1_DETECT_FORCE
        If flag_LEGACY_100T1_DETECT_VALUE = &H0 Then write_LEGACY_100T1_DETECT_VALUE_value = get_LEGACY_100T1_DETECT_VALUE
        If flag_LEGACY_100T1_DETECT_FORCE = &H0 Then write_LEGACY_100T1_DETECT_FORCE_value = get_LEGACY_100T1_DETECT_FORCE
        If flag_SYNC_LINK_CTRL_100T1_VALUE = &H0 Then write_SYNC_LINK_CTRL_100T1_VALUE_value = get_SYNC_LINK_CTRL_100T1_VALUE
        If flag_SYNC_LINK_CTRL_1000T1_VALUE = &H0 Then write_SYNC_LINK_CTRL_1000T1_VALUE_value = get_SYNC_LINK_CTRL_1000T1_VALUE
        If flag_SYNC_LINK_CTRL_FORCE = &H0 Then write_SYNC_LINK_CTRL_FORCE_value = get_SYNC_LINK_CTRL_FORCE

        regValue = leftShift((write_AUTOSPEED_EN_value and &H1), 15) + leftShift((write_AUTOSPEED_PER_value and &H1), 14) + leftShift((write_AUTOSPEED_MS_value and &H1), 13) + leftShift((write_AUTOSPEED_RX_SYMBOL_ORDER_value and &H1), 12) + leftShift((write_AUTOSPEED_TX_SYMBOL_ORDER_value and &H1), 11) + leftShift((write_NUMBER_OF_AUTOSPEED_ATTEMPTS_value and &H7), 8) + leftShift((write_AUTOSPEED_INITIAL_SPEED_value and &H1), 7) + leftShift((write_SYNC_1000T1_DETECT_VALUE_value and &H1), 6) + leftShift((write_SYNC_1000T1_DETECT_FORCE_value and &H1), 5) + leftShift((write_LEGACY_100T1_DETECT_VALUE_value and &H1), 4) + leftShift((write_LEGACY_100T1_DETECT_FORCE_value and &H1), 3) + leftShift((write_SYNC_LINK_CTRL_100T1_VALUE_value and &H1), 2) + leftShift((write_SYNC_LINK_CTRL_1000T1_VALUE_value and &H1), 1) + leftShift((write_SYNC_LINK_CTRL_FORCE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTOSPEED_EN_value = rightShift(data_low, 15) and &H1
        read_AUTOSPEED_PER_value = rightShift(data_low, 14) and &H1
        read_AUTOSPEED_MS_value = rightShift(data_low, 13) and &H1
        read_AUTOSPEED_RX_SYMBOL_ORDER_value = rightShift(data_low, 12) and &H1
        read_AUTOSPEED_TX_SYMBOL_ORDER_value = rightShift(data_low, 11) and &H1
        read_NUMBER_OF_AUTOSPEED_ATTEMPTS_value = rightShift(data_low, 8) and &H7
        read_AUTOSPEED_INITIAL_SPEED_value = rightShift(data_low, 7) and &H1
        read_SYNC_1000T1_DETECT_VALUE_value = rightShift(data_low, 6) and &H1
        read_SYNC_1000T1_DETECT_FORCE_value = rightShift(data_low, 5) and &H1
        read_LEGACY_100T1_DETECT_VALUE_value = rightShift(data_low, 4) and &H1
        read_LEGACY_100T1_DETECT_FORCE_value = rightShift(data_low, 3) and &H1
        read_SYNC_LINK_CTRL_100T1_VALUE_value = rightShift(data_low, 2) and &H1
        read_SYNC_LINK_CTRL_1000T1_VALUE_value = rightShift(data_low, 1) and &H1
        SYNC_LINK_CTRL_FORCE_mask = &H1
        if data_low > LONG_MAX then
            if SYNC_LINK_CTRL_FORCE_mask = mask then
                read_SYNC_LINK_CTRL_FORCE_value = data_low
            else
                read_SYNC_LINK_CTRL_FORCE_value = (data_low - H8000_0000) and SYNC_LINK_CTRL_FORCE_mask
            end If
        else
            read_SYNC_LINK_CTRL_FORCE_value = data_low and SYNC_LINK_CTRL_FORCE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTOSPEED_EN_value = &H0
        flag_AUTOSPEED_EN        = &H0
        write_AUTOSPEED_PER_value = &H0
        flag_AUTOSPEED_PER        = &H0
        write_AUTOSPEED_MS_value = &H0
        flag_AUTOSPEED_MS        = &H0
        write_AUTOSPEED_RX_SYMBOL_ORDER_value = &H0
        flag_AUTOSPEED_RX_SYMBOL_ORDER        = &H0
        write_AUTOSPEED_TX_SYMBOL_ORDER_value = &H0
        flag_AUTOSPEED_TX_SYMBOL_ORDER        = &H0
        write_NUMBER_OF_AUTOSPEED_ATTEMPTS_value = &H0
        flag_NUMBER_OF_AUTOSPEED_ATTEMPTS        = &H0
        write_AUTOSPEED_INITIAL_SPEED_value = &H0
        flag_AUTOSPEED_INITIAL_SPEED        = &H0
        write_SYNC_1000T1_DETECT_VALUE_value = &H0
        flag_SYNC_1000T1_DETECT_VALUE        = &H0
        write_SYNC_1000T1_DETECT_FORCE_value = &H0
        flag_SYNC_1000T1_DETECT_FORCE        = &H0
        write_LEGACY_100T1_DETECT_VALUE_value = &H0
        flag_LEGACY_100T1_DETECT_VALUE        = &H0
        write_LEGACY_100T1_DETECT_FORCE_value = &H0
        flag_LEGACY_100T1_DETECT_FORCE        = &H0
        write_SYNC_LINK_CTRL_100T1_VALUE_value = &H0
        flag_SYNC_LINK_CTRL_100T1_VALUE        = &H0
        write_SYNC_LINK_CTRL_1000T1_VALUE_value = &H0
        flag_SYNC_LINK_CTRL_1000T1_VALUE        = &H0
        write_SYNC_LINK_CTRL_FORCE_value = &H0
        flag_SYNC_LINK_CTRL_FORCE        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_control_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MF_FORCE_CONFIG_POLARITY                   [15:15]          get_MF_FORCE_CONFIG_POLARITY
''                                                             set_MF_FORCE_CONFIG_POLARITY
''                                                             read_MF_FORCE_CONFIG_POLARITY
''                                                             write_MF_FORCE_CONFIG_POLARITY
''---------------------------------------------------------------------------------
'' MF_ODDEVEN_SWAP                            [14:14]          get_MF_ODDEVEN_SWAP
''                                                             set_MF_ODDEVEN_SWAP
''                                                             read_MF_ODDEVEN_SWAP
''                                                             write_MF_ODDEVEN_SWAP
''---------------------------------------------------------------------------------
'' MF_ENABLE                                  [13:13]          get_MF_ENABLE
''                                                             set_MF_ENABLE
''                                                             read_MF_ENABLE
''                                                             write_MF_ENABLE
''---------------------------------------------------------------------------------
'' MF_INPUT_SHIFT                             [12:11]          get_MF_INPUT_SHIFT
''                                                             set_MF_INPUT_SHIFT
''                                                             read_MF_INPUT_SHIFT
''                                                             write_MF_INPUT_SHIFT
''---------------------------------------------------------------------------------
'' MF_ONE_PEAK_EN                             [10:10]          get_MF_ONE_PEAK_EN
''                                                             set_MF_ONE_PEAK_EN
''                                                             read_MF_ONE_PEAK_EN
''                                                             write_MF_ONE_PEAK_EN
''---------------------------------------------------------------------------------
'' MF_CLK_OVERRIDE_EN                         [9:9]            get_MF_CLK_OVERRIDE_EN
''                                                             set_MF_CLK_OVERRIDE_EN
''                                                             read_MF_CLK_OVERRIDE_EN
''                                                             write_MF_CLK_OVERRIDE_EN
''---------------------------------------------------------------------------------
'' LINK_SYNC_TEST_MODE                        [8:5]            get_LINK_SYNC_TEST_MODE
''                                                             set_LINK_SYNC_TEST_MODE
''                                                             read_LINK_SYNC_TEST_MODE
''                                                             write_LINK_SYNC_TEST_MODE
''---------------------------------------------------------------------------------
'' LINK_FAIL_INHIBIT_TIMER_CONTROL            [4:3]            get_LINK_FAIL_INHIBIT_TIMER_CONTROL
''                                                             set_LINK_FAIL_INHIBIT_TIMER_CONTROL
''                                                             read_LINK_FAIL_INHIBIT_TIMER_CONTROL
''                                                             write_LINK_FAIL_INHIBIT_TIMER_CONTROL
''---------------------------------------------------------------------------------
'' BREAK_LINK_TIMER_ACCEL                     [2:2]            get_BREAK_LINK_TIMER_ACCEL
''                                                             set_BREAK_LINK_TIMER_ACCEL
''                                                             read_BREAK_LINK_TIMER_ACCEL
''                                                             write_BREAK_LINK_TIMER_ACCEL
''---------------------------------------------------------------------------------
'' LINK_MONITOR_STATE_VALUE                   [1:1]            get_LINK_MONITOR_STATE_VALUE
''                                                             set_LINK_MONITOR_STATE_VALUE
''                                                             read_LINK_MONITOR_STATE_VALUE
''                                                             write_LINK_MONITOR_STATE_VALUE
''---------------------------------------------------------------------------------
'' LINK_MONITOR_STATE_FORCE                   [0:0]            get_LINK_MONITOR_STATE_FORCE
''                                                             set_LINK_MONITOR_STATE_FORCE
''                                                             read_LINK_MONITOR_STATE_FORCE
''                                                             write_LINK_MONITOR_STATE_FORCE
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_control_b
    Private write_MF_FORCE_CONFIG_POLARITY_value
    Private read_MF_FORCE_CONFIG_POLARITY_value
    Private flag_MF_FORCE_CONFIG_POLARITY
    Private write_MF_ODDEVEN_SWAP_value
    Private read_MF_ODDEVEN_SWAP_value
    Private flag_MF_ODDEVEN_SWAP
    Private write_MF_ENABLE_value
    Private read_MF_ENABLE_value
    Private flag_MF_ENABLE
    Private write_MF_INPUT_SHIFT_value
    Private read_MF_INPUT_SHIFT_value
    Private flag_MF_INPUT_SHIFT
    Private write_MF_ONE_PEAK_EN_value
    Private read_MF_ONE_PEAK_EN_value
    Private flag_MF_ONE_PEAK_EN
    Private write_MF_CLK_OVERRIDE_EN_value
    Private read_MF_CLK_OVERRIDE_EN_value
    Private flag_MF_CLK_OVERRIDE_EN
    Private write_LINK_SYNC_TEST_MODE_value
    Private read_LINK_SYNC_TEST_MODE_value
    Private flag_LINK_SYNC_TEST_MODE
    Private write_LINK_FAIL_INHIBIT_TIMER_CONTROL_value
    Private read_LINK_FAIL_INHIBIT_TIMER_CONTROL_value
    Private flag_LINK_FAIL_INHIBIT_TIMER_CONTROL
    Private write_BREAK_LINK_TIMER_ACCEL_value
    Private read_BREAK_LINK_TIMER_ACCEL_value
    Private flag_BREAK_LINK_TIMER_ACCEL
    Private write_LINK_MONITOR_STATE_VALUE_value
    Private read_LINK_MONITOR_STATE_VALUE_value
    Private flag_LINK_MONITOR_STATE_VALUE
    Private write_LINK_MONITOR_STATE_FORCE_value
    Private read_LINK_MONITOR_STATE_FORCE_value
    Private flag_LINK_MONITOR_STATE_FORCE

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

    Property Get get_MF_FORCE_CONFIG_POLARITY
        get_MF_FORCE_CONFIG_POLARITY = read_MF_FORCE_CONFIG_POLARITY_value
    End Property

    Property Let set_MF_FORCE_CONFIG_POLARITY(aData)
        write_MF_FORCE_CONFIG_POLARITY_value = aData
        flag_MF_FORCE_CONFIG_POLARITY        = &H1
    End Property

    Property Get read_MF_FORCE_CONFIG_POLARITY
        read
        read_MF_FORCE_CONFIG_POLARITY = read_MF_FORCE_CONFIG_POLARITY_value
    End Property

    Property Let write_MF_FORCE_CONFIG_POLARITY(aData)
        set_MF_FORCE_CONFIG_POLARITY = aData
        write
    End Property

    Property Get get_MF_ODDEVEN_SWAP
        get_MF_ODDEVEN_SWAP = read_MF_ODDEVEN_SWAP_value
    End Property

    Property Let set_MF_ODDEVEN_SWAP(aData)
        write_MF_ODDEVEN_SWAP_value = aData
        flag_MF_ODDEVEN_SWAP        = &H1
    End Property

    Property Get read_MF_ODDEVEN_SWAP
        read
        read_MF_ODDEVEN_SWAP = read_MF_ODDEVEN_SWAP_value
    End Property

    Property Let write_MF_ODDEVEN_SWAP(aData)
        set_MF_ODDEVEN_SWAP = aData
        write
    End Property

    Property Get get_MF_ENABLE
        get_MF_ENABLE = read_MF_ENABLE_value
    End Property

    Property Let set_MF_ENABLE(aData)
        write_MF_ENABLE_value = aData
        flag_MF_ENABLE        = &H1
    End Property

    Property Get read_MF_ENABLE
        read
        read_MF_ENABLE = read_MF_ENABLE_value
    End Property

    Property Let write_MF_ENABLE(aData)
        set_MF_ENABLE = aData
        write
    End Property

    Property Get get_MF_INPUT_SHIFT
        get_MF_INPUT_SHIFT = read_MF_INPUT_SHIFT_value
    End Property

    Property Let set_MF_INPUT_SHIFT(aData)
        write_MF_INPUT_SHIFT_value = aData
        flag_MF_INPUT_SHIFT        = &H1
    End Property

    Property Get read_MF_INPUT_SHIFT
        read
        read_MF_INPUT_SHIFT = read_MF_INPUT_SHIFT_value
    End Property

    Property Let write_MF_INPUT_SHIFT(aData)
        set_MF_INPUT_SHIFT = aData
        write
    End Property

    Property Get get_MF_ONE_PEAK_EN
        get_MF_ONE_PEAK_EN = read_MF_ONE_PEAK_EN_value
    End Property

    Property Let set_MF_ONE_PEAK_EN(aData)
        write_MF_ONE_PEAK_EN_value = aData
        flag_MF_ONE_PEAK_EN        = &H1
    End Property

    Property Get read_MF_ONE_PEAK_EN
        read
        read_MF_ONE_PEAK_EN = read_MF_ONE_PEAK_EN_value
    End Property

    Property Let write_MF_ONE_PEAK_EN(aData)
        set_MF_ONE_PEAK_EN = aData
        write
    End Property

    Property Get get_MF_CLK_OVERRIDE_EN
        get_MF_CLK_OVERRIDE_EN = read_MF_CLK_OVERRIDE_EN_value
    End Property

    Property Let set_MF_CLK_OVERRIDE_EN(aData)
        write_MF_CLK_OVERRIDE_EN_value = aData
        flag_MF_CLK_OVERRIDE_EN        = &H1
    End Property

    Property Get read_MF_CLK_OVERRIDE_EN
        read
        read_MF_CLK_OVERRIDE_EN = read_MF_CLK_OVERRIDE_EN_value
    End Property

    Property Let write_MF_CLK_OVERRIDE_EN(aData)
        set_MF_CLK_OVERRIDE_EN = aData
        write
    End Property

    Property Get get_LINK_SYNC_TEST_MODE
        get_LINK_SYNC_TEST_MODE = read_LINK_SYNC_TEST_MODE_value
    End Property

    Property Let set_LINK_SYNC_TEST_MODE(aData)
        write_LINK_SYNC_TEST_MODE_value = aData
        flag_LINK_SYNC_TEST_MODE        = &H1
    End Property

    Property Get read_LINK_SYNC_TEST_MODE
        read
        read_LINK_SYNC_TEST_MODE = read_LINK_SYNC_TEST_MODE_value
    End Property

    Property Let write_LINK_SYNC_TEST_MODE(aData)
        set_LINK_SYNC_TEST_MODE = aData
        write
    End Property

    Property Get get_LINK_FAIL_INHIBIT_TIMER_CONTROL
        get_LINK_FAIL_INHIBIT_TIMER_CONTROL = read_LINK_FAIL_INHIBIT_TIMER_CONTROL_value
    End Property

    Property Let set_LINK_FAIL_INHIBIT_TIMER_CONTROL(aData)
        write_LINK_FAIL_INHIBIT_TIMER_CONTROL_value = aData
        flag_LINK_FAIL_INHIBIT_TIMER_CONTROL        = &H1
    End Property

    Property Get read_LINK_FAIL_INHIBIT_TIMER_CONTROL
        read
        read_LINK_FAIL_INHIBIT_TIMER_CONTROL = read_LINK_FAIL_INHIBIT_TIMER_CONTROL_value
    End Property

    Property Let write_LINK_FAIL_INHIBIT_TIMER_CONTROL(aData)
        set_LINK_FAIL_INHIBIT_TIMER_CONTROL = aData
        write
    End Property

    Property Get get_BREAK_LINK_TIMER_ACCEL
        get_BREAK_LINK_TIMER_ACCEL = read_BREAK_LINK_TIMER_ACCEL_value
    End Property

    Property Let set_BREAK_LINK_TIMER_ACCEL(aData)
        write_BREAK_LINK_TIMER_ACCEL_value = aData
        flag_BREAK_LINK_TIMER_ACCEL        = &H1
    End Property

    Property Get read_BREAK_LINK_TIMER_ACCEL
        read
        read_BREAK_LINK_TIMER_ACCEL = read_BREAK_LINK_TIMER_ACCEL_value
    End Property

    Property Let write_BREAK_LINK_TIMER_ACCEL(aData)
        set_BREAK_LINK_TIMER_ACCEL = aData
        write
    End Property

    Property Get get_LINK_MONITOR_STATE_VALUE
        get_LINK_MONITOR_STATE_VALUE = read_LINK_MONITOR_STATE_VALUE_value
    End Property

    Property Let set_LINK_MONITOR_STATE_VALUE(aData)
        write_LINK_MONITOR_STATE_VALUE_value = aData
        flag_LINK_MONITOR_STATE_VALUE        = &H1
    End Property

    Property Get read_LINK_MONITOR_STATE_VALUE
        read
        read_LINK_MONITOR_STATE_VALUE = read_LINK_MONITOR_STATE_VALUE_value
    End Property

    Property Let write_LINK_MONITOR_STATE_VALUE(aData)
        set_LINK_MONITOR_STATE_VALUE = aData
        write
    End Property

    Property Get get_LINK_MONITOR_STATE_FORCE
        get_LINK_MONITOR_STATE_FORCE = read_LINK_MONITOR_STATE_FORCE_value
    End Property

    Property Let set_LINK_MONITOR_STATE_FORCE(aData)
        write_LINK_MONITOR_STATE_FORCE_value = aData
        flag_LINK_MONITOR_STATE_FORCE        = &H1
    End Property

    Property Get read_LINK_MONITOR_STATE_FORCE
        read
        read_LINK_MONITOR_STATE_FORCE = read_LINK_MONITOR_STATE_FORCE_value
    End Property

    Property Let write_LINK_MONITOR_STATE_FORCE(aData)
        set_LINK_MONITOR_STATE_FORCE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MF_FORCE_CONFIG_POLARITY_value = rightShift(data_low, 15) and &H1
        read_MF_ODDEVEN_SWAP_value = rightShift(data_low, 14) and &H1
        read_MF_ENABLE_value = rightShift(data_low, 13) and &H1
        read_MF_INPUT_SHIFT_value = rightShift(data_low, 11) and &H3
        read_MF_ONE_PEAK_EN_value = rightShift(data_low, 10) and &H1
        read_MF_CLK_OVERRIDE_EN_value = rightShift(data_low, 9) and &H1
        read_LINK_SYNC_TEST_MODE_value = rightShift(data_low, 5) and &Hf
        read_LINK_FAIL_INHIBIT_TIMER_CONTROL_value = rightShift(data_low, 3) and &H3
        read_BREAK_LINK_TIMER_ACCEL_value = rightShift(data_low, 2) and &H1
        read_LINK_MONITOR_STATE_VALUE_value = rightShift(data_low, 1) and &H1
        LINK_MONITOR_STATE_FORCE_mask = &H1
        if data_low > LONG_MAX then
            if LINK_MONITOR_STATE_FORCE_mask = mask then
                read_LINK_MONITOR_STATE_FORCE_value = data_low
            else
                read_LINK_MONITOR_STATE_FORCE_value = (data_low - H8000_0000) and LINK_MONITOR_STATE_FORCE_mask
            end If
        else
            read_LINK_MONITOR_STATE_FORCE_value = data_low and LINK_MONITOR_STATE_FORCE_mask
        end If

    End Sub

    Sub write
        If flag_MF_FORCE_CONFIG_POLARITY = &H0 or flag_MF_ODDEVEN_SWAP = &H0 or flag_MF_ENABLE = &H0 or flag_MF_INPUT_SHIFT = &H0 or flag_MF_ONE_PEAK_EN = &H0 or flag_MF_CLK_OVERRIDE_EN = &H0 or flag_LINK_SYNC_TEST_MODE = &H0 or flag_LINK_FAIL_INHIBIT_TIMER_CONTROL = &H0 or flag_BREAK_LINK_TIMER_ACCEL = &H0 or flag_LINK_MONITOR_STATE_VALUE = &H0 or flag_LINK_MONITOR_STATE_FORCE = &H0 Then read
        If flag_MF_FORCE_CONFIG_POLARITY = &H0 Then write_MF_FORCE_CONFIG_POLARITY_value = get_MF_FORCE_CONFIG_POLARITY
        If flag_MF_ODDEVEN_SWAP = &H0 Then write_MF_ODDEVEN_SWAP_value = get_MF_ODDEVEN_SWAP
        If flag_MF_ENABLE = &H0 Then write_MF_ENABLE_value = get_MF_ENABLE
        If flag_MF_INPUT_SHIFT = &H0 Then write_MF_INPUT_SHIFT_value = get_MF_INPUT_SHIFT
        If flag_MF_ONE_PEAK_EN = &H0 Then write_MF_ONE_PEAK_EN_value = get_MF_ONE_PEAK_EN
        If flag_MF_CLK_OVERRIDE_EN = &H0 Then write_MF_CLK_OVERRIDE_EN_value = get_MF_CLK_OVERRIDE_EN
        If flag_LINK_SYNC_TEST_MODE = &H0 Then write_LINK_SYNC_TEST_MODE_value = get_LINK_SYNC_TEST_MODE
        If flag_LINK_FAIL_INHIBIT_TIMER_CONTROL = &H0 Then write_LINK_FAIL_INHIBIT_TIMER_CONTROL_value = get_LINK_FAIL_INHIBIT_TIMER_CONTROL
        If flag_BREAK_LINK_TIMER_ACCEL = &H0 Then write_BREAK_LINK_TIMER_ACCEL_value = get_BREAK_LINK_TIMER_ACCEL
        If flag_LINK_MONITOR_STATE_VALUE = &H0 Then write_LINK_MONITOR_STATE_VALUE_value = get_LINK_MONITOR_STATE_VALUE
        If flag_LINK_MONITOR_STATE_FORCE = &H0 Then write_LINK_MONITOR_STATE_FORCE_value = get_LINK_MONITOR_STATE_FORCE

        regValue = leftShift((write_MF_FORCE_CONFIG_POLARITY_value and &H1), 15) + leftShift((write_MF_ODDEVEN_SWAP_value and &H1), 14) + leftShift((write_MF_ENABLE_value and &H1), 13) + leftShift((write_MF_INPUT_SHIFT_value and &H3), 11) + leftShift((write_MF_ONE_PEAK_EN_value and &H1), 10) + leftShift((write_MF_CLK_OVERRIDE_EN_value and &H1), 9) + leftShift((write_LINK_SYNC_TEST_MODE_value and &Hf), 5) + leftShift((write_LINK_FAIL_INHIBIT_TIMER_CONTROL_value and &H3), 3) + leftShift((write_BREAK_LINK_TIMER_ACCEL_value and &H1), 2) + leftShift((write_LINK_MONITOR_STATE_VALUE_value and &H1), 1) + leftShift((write_LINK_MONITOR_STATE_FORCE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MF_FORCE_CONFIG_POLARITY_value = rightShift(data_low, 15) and &H1
        read_MF_ODDEVEN_SWAP_value = rightShift(data_low, 14) and &H1
        read_MF_ENABLE_value = rightShift(data_low, 13) and &H1
        read_MF_INPUT_SHIFT_value = rightShift(data_low, 11) and &H3
        read_MF_ONE_PEAK_EN_value = rightShift(data_low, 10) and &H1
        read_MF_CLK_OVERRIDE_EN_value = rightShift(data_low, 9) and &H1
        read_LINK_SYNC_TEST_MODE_value = rightShift(data_low, 5) and &Hf
        read_LINK_FAIL_INHIBIT_TIMER_CONTROL_value = rightShift(data_low, 3) and &H3
        read_BREAK_LINK_TIMER_ACCEL_value = rightShift(data_low, 2) and &H1
        read_LINK_MONITOR_STATE_VALUE_value = rightShift(data_low, 1) and &H1
        LINK_MONITOR_STATE_FORCE_mask = &H1
        if data_low > LONG_MAX then
            if LINK_MONITOR_STATE_FORCE_mask = mask then
                read_LINK_MONITOR_STATE_FORCE_value = data_low
            else
                read_LINK_MONITOR_STATE_FORCE_value = (data_low - H8000_0000) and LINK_MONITOR_STATE_FORCE_mask
            end If
        else
            read_LINK_MONITOR_STATE_FORCE_value = data_low and LINK_MONITOR_STATE_FORCE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MF_FORCE_CONFIG_POLARITY_value = &H0
        flag_MF_FORCE_CONFIG_POLARITY        = &H0
        write_MF_ODDEVEN_SWAP_value = &H0
        flag_MF_ODDEVEN_SWAP        = &H0
        write_MF_ENABLE_value = &H0
        flag_MF_ENABLE        = &H0
        write_MF_INPUT_SHIFT_value = &H0
        flag_MF_INPUT_SHIFT        = &H0
        write_MF_ONE_PEAK_EN_value = &H0
        flag_MF_ONE_PEAK_EN        = &H0
        write_MF_CLK_OVERRIDE_EN_value = &H0
        flag_MF_CLK_OVERRIDE_EN        = &H0
        write_LINK_SYNC_TEST_MODE_value = &H0
        flag_LINK_SYNC_TEST_MODE        = &H0
        write_LINK_FAIL_INHIBIT_TIMER_CONTROL_value = &H0
        flag_LINK_FAIL_INHIBIT_TIMER_CONTROL        = &H0
        write_BREAK_LINK_TIMER_ACCEL_value = &H0
        flag_BREAK_LINK_TIMER_ACCEL        = &H0
        write_LINK_MONITOR_STATE_VALUE_value = &H0
        flag_LINK_MONITOR_STATE_VALUE        = &H0
        write_LINK_MONITOR_STATE_FORCE_value = &H0
        flag_LINK_MONITOR_STATE_FORCE        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_control_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MF_WDOG_TIMER_DISABLE                      [15:15]          get_MF_WDOG_TIMER_DISABLE
''                                                             set_MF_WDOG_TIMER_DISABLE
''                                                             read_MF_WDOG_TIMER_DISABLE
''                                                             write_MF_WDOG_TIMER_DISABLE
''---------------------------------------------------------------------------------
'' MF_SKIP_DISABLE                            [14:14]          get_MF_SKIP_DISABLE
''                                                             set_MF_SKIP_DISABLE
''                                                             read_MF_SKIP_DISABLE
''                                                             write_MF_SKIP_DISABLE
''---------------------------------------------------------------------------------
'' LYNKSYNC_PGA_FINE                          [13:8]           get_LYNKSYNC_PGA_FINE
''                                                             set_LYNKSYNC_PGA_FINE
''                                                             read_LYNKSYNC_PGA_FINE
''                                                             write_LYNKSYNC_PGA_FINE
''---------------------------------------------------------------------------------
'' MF_SIGDET_CLEAR_TIMER_SEL                  [7:5]            get_MF_SIGDET_CLEAR_TIMER_SEL
''                                                             set_MF_SIGDET_CLEAR_TIMER_SEL
''                                                             read_MF_SIGDET_CLEAR_TIMER_SEL
''                                                             write_MF_SIGDET_CLEAR_TIMER_SEL
''---------------------------------------------------------------------------------
'' LYNKSYNC_PGA_COARSE                        [4:0]            get_LYNKSYNC_PGA_COARSE
''                                                             set_LYNKSYNC_PGA_COARSE
''                                                             read_LYNKSYNC_PGA_COARSE
''                                                             write_LYNKSYNC_PGA_COARSE
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_control_c
    Private write_MF_WDOG_TIMER_DISABLE_value
    Private read_MF_WDOG_TIMER_DISABLE_value
    Private flag_MF_WDOG_TIMER_DISABLE
    Private write_MF_SKIP_DISABLE_value
    Private read_MF_SKIP_DISABLE_value
    Private flag_MF_SKIP_DISABLE
    Private write_LYNKSYNC_PGA_FINE_value
    Private read_LYNKSYNC_PGA_FINE_value
    Private flag_LYNKSYNC_PGA_FINE
    Private write_MF_SIGDET_CLEAR_TIMER_SEL_value
    Private read_MF_SIGDET_CLEAR_TIMER_SEL_value
    Private flag_MF_SIGDET_CLEAR_TIMER_SEL
    Private write_LYNKSYNC_PGA_COARSE_value
    Private read_LYNKSYNC_PGA_COARSE_value
    Private flag_LYNKSYNC_PGA_COARSE

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

    Property Get get_MF_WDOG_TIMER_DISABLE
        get_MF_WDOG_TIMER_DISABLE = read_MF_WDOG_TIMER_DISABLE_value
    End Property

    Property Let set_MF_WDOG_TIMER_DISABLE(aData)
        write_MF_WDOG_TIMER_DISABLE_value = aData
        flag_MF_WDOG_TIMER_DISABLE        = &H1
    End Property

    Property Get read_MF_WDOG_TIMER_DISABLE
        read
        read_MF_WDOG_TIMER_DISABLE = read_MF_WDOG_TIMER_DISABLE_value
    End Property

    Property Let write_MF_WDOG_TIMER_DISABLE(aData)
        set_MF_WDOG_TIMER_DISABLE = aData
        write
    End Property

    Property Get get_MF_SKIP_DISABLE
        get_MF_SKIP_DISABLE = read_MF_SKIP_DISABLE_value
    End Property

    Property Let set_MF_SKIP_DISABLE(aData)
        write_MF_SKIP_DISABLE_value = aData
        flag_MF_SKIP_DISABLE        = &H1
    End Property

    Property Get read_MF_SKIP_DISABLE
        read
        read_MF_SKIP_DISABLE = read_MF_SKIP_DISABLE_value
    End Property

    Property Let write_MF_SKIP_DISABLE(aData)
        set_MF_SKIP_DISABLE = aData
        write
    End Property

    Property Get get_LYNKSYNC_PGA_FINE
        get_LYNKSYNC_PGA_FINE = read_LYNKSYNC_PGA_FINE_value
    End Property

    Property Let set_LYNKSYNC_PGA_FINE(aData)
        write_LYNKSYNC_PGA_FINE_value = aData
        flag_LYNKSYNC_PGA_FINE        = &H1
    End Property

    Property Get read_LYNKSYNC_PGA_FINE
        read
        read_LYNKSYNC_PGA_FINE = read_LYNKSYNC_PGA_FINE_value
    End Property

    Property Let write_LYNKSYNC_PGA_FINE(aData)
        set_LYNKSYNC_PGA_FINE = aData
        write
    End Property

    Property Get get_MF_SIGDET_CLEAR_TIMER_SEL
        get_MF_SIGDET_CLEAR_TIMER_SEL = read_MF_SIGDET_CLEAR_TIMER_SEL_value
    End Property

    Property Let set_MF_SIGDET_CLEAR_TIMER_SEL(aData)
        write_MF_SIGDET_CLEAR_TIMER_SEL_value = aData
        flag_MF_SIGDET_CLEAR_TIMER_SEL        = &H1
    End Property

    Property Get read_MF_SIGDET_CLEAR_TIMER_SEL
        read
        read_MF_SIGDET_CLEAR_TIMER_SEL = read_MF_SIGDET_CLEAR_TIMER_SEL_value
    End Property

    Property Let write_MF_SIGDET_CLEAR_TIMER_SEL(aData)
        set_MF_SIGDET_CLEAR_TIMER_SEL = aData
        write
    End Property

    Property Get get_LYNKSYNC_PGA_COARSE
        get_LYNKSYNC_PGA_COARSE = read_LYNKSYNC_PGA_COARSE_value
    End Property

    Property Let set_LYNKSYNC_PGA_COARSE(aData)
        write_LYNKSYNC_PGA_COARSE_value = aData
        flag_LYNKSYNC_PGA_COARSE        = &H1
    End Property

    Property Get read_LYNKSYNC_PGA_COARSE
        read
        read_LYNKSYNC_PGA_COARSE = read_LYNKSYNC_PGA_COARSE_value
    End Property

    Property Let write_LYNKSYNC_PGA_COARSE(aData)
        set_LYNKSYNC_PGA_COARSE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MF_WDOG_TIMER_DISABLE_value = rightShift(data_low, 15) and &H1
        read_MF_SKIP_DISABLE_value = rightShift(data_low, 14) and &H1
        read_LYNKSYNC_PGA_FINE_value = rightShift(data_low, 8) and &H3f
        read_MF_SIGDET_CLEAR_TIMER_SEL_value = rightShift(data_low, 5) and &H7
        LYNKSYNC_PGA_COARSE_mask = &H1f
        if data_low > LONG_MAX then
            if LYNKSYNC_PGA_COARSE_mask = mask then
                read_LYNKSYNC_PGA_COARSE_value = data_low
            else
                read_LYNKSYNC_PGA_COARSE_value = (data_low - H8000_0000) and LYNKSYNC_PGA_COARSE_mask
            end If
        else
            read_LYNKSYNC_PGA_COARSE_value = data_low and LYNKSYNC_PGA_COARSE_mask
        end If

    End Sub

    Sub write
        If flag_MF_WDOG_TIMER_DISABLE = &H0 or flag_MF_SKIP_DISABLE = &H0 or flag_LYNKSYNC_PGA_FINE = &H0 or flag_MF_SIGDET_CLEAR_TIMER_SEL = &H0 or flag_LYNKSYNC_PGA_COARSE = &H0 Then read
        If flag_MF_WDOG_TIMER_DISABLE = &H0 Then write_MF_WDOG_TIMER_DISABLE_value = get_MF_WDOG_TIMER_DISABLE
        If flag_MF_SKIP_DISABLE = &H0 Then write_MF_SKIP_DISABLE_value = get_MF_SKIP_DISABLE
        If flag_LYNKSYNC_PGA_FINE = &H0 Then write_LYNKSYNC_PGA_FINE_value = get_LYNKSYNC_PGA_FINE
        If flag_MF_SIGDET_CLEAR_TIMER_SEL = &H0 Then write_MF_SIGDET_CLEAR_TIMER_SEL_value = get_MF_SIGDET_CLEAR_TIMER_SEL
        If flag_LYNKSYNC_PGA_COARSE = &H0 Then write_LYNKSYNC_PGA_COARSE_value = get_LYNKSYNC_PGA_COARSE

        regValue = leftShift((write_MF_WDOG_TIMER_DISABLE_value and &H1), 15) + leftShift((write_MF_SKIP_DISABLE_value and &H1), 14) + leftShift((write_LYNKSYNC_PGA_FINE_value and &H3f), 8) + leftShift((write_MF_SIGDET_CLEAR_TIMER_SEL_value and &H7), 5) + leftShift((write_LYNKSYNC_PGA_COARSE_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MF_WDOG_TIMER_DISABLE_value = rightShift(data_low, 15) and &H1
        read_MF_SKIP_DISABLE_value = rightShift(data_low, 14) and &H1
        read_LYNKSYNC_PGA_FINE_value = rightShift(data_low, 8) and &H3f
        read_MF_SIGDET_CLEAR_TIMER_SEL_value = rightShift(data_low, 5) and &H7
        LYNKSYNC_PGA_COARSE_mask = &H1f
        if data_low > LONG_MAX then
            if LYNKSYNC_PGA_COARSE_mask = mask then
                read_LYNKSYNC_PGA_COARSE_value = data_low
            else
                read_LYNKSYNC_PGA_COARSE_value = (data_low - H8000_0000) and LYNKSYNC_PGA_COARSE_mask
            end If
        else
            read_LYNKSYNC_PGA_COARSE_value = data_low and LYNKSYNC_PGA_COARSE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MF_WDOG_TIMER_DISABLE_value = &H0
        flag_MF_WDOG_TIMER_DISABLE        = &H0
        write_MF_SKIP_DISABLE_value = &H0
        flag_MF_SKIP_DISABLE        = &H0
        write_LYNKSYNC_PGA_FINE_value = &H0
        flag_LYNKSYNC_PGA_FINE        = &H0
        write_MF_SIGDET_CLEAR_TIMER_SEL_value = &H0
        flag_MF_SIGDET_CLEAR_TIMER_SEL        = &H0
        write_LYNKSYNC_PGA_COARSE_value = &H0
        flag_LYNKSYNC_PGA_COARSE        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_status_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_STATUS                 [15:15]          get_LEGACY_100T1_DETECT_STATUS
''                                                             set_LEGACY_100T1_DETECT_STATUS
''                                                             read_LEGACY_100T1_DETECT_STATUS
''                                                             write_LEGACY_100T1_DETECT_STATUS
''---------------------------------------------------------------------------------
'' AUTOSPEED_FSM_STAT                         [14:12]          get_AUTOSPEED_FSM_STAT
''                                                             set_AUTOSPEED_FSM_STAT
''                                                             read_AUTOSPEED_FSM_STAT
''                                                             write_AUTOSPEED_FSM_STAT
''---------------------------------------------------------------------------------
'' STATUS_A_SPARE_1                           [11:11]          get_STATUS_A_SPARE_1
''                                                             set_STATUS_A_SPARE_1
''                                                             read_STATUS_A_SPARE_1
''                                                             write_STATUS_A_SPARE_1
''---------------------------------------------------------------------------------
'' SYNC_LINK_FSM_STAT                         [10:8]           get_SYNC_LINK_FSM_STAT
''                                                             set_SYNC_LINK_FSM_STAT
''                                                             read_SYNC_LINK_FSM_STAT
''                                                             write_SYNC_LINK_FSM_STAT
''---------------------------------------------------------------------------------
'' AUTOSPEED_ATTEMPTS_COUNTER_VALUE           [7:5]            get_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
''                                                             set_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
''                                                             read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
''                                                             write_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
''---------------------------------------------------------------------------------
'' AUTOSPEED_CHANGED_SPEED                    [4:4]            get_AUTOSPEED_CHANGED_SPEED
''                                                             set_AUTOSPEED_CHANGED_SPEED
''                                                             read_AUTOSPEED_CHANGED_SPEED
''                                                             write_AUTOSPEED_CHANGED_SPEED
''---------------------------------------------------------------------------------
'' STATUS_A_SPARE_0                           [3:2]            get_STATUS_A_SPARE_0
''                                                             set_STATUS_A_SPARE_0
''                                                             read_STATUS_A_SPARE_0
''                                                             write_STATUS_A_SPARE_0
''---------------------------------------------------------------------------------
'' SYNC_LINK_CONTROL_100T1_STAT               [1:1]            get_SYNC_LINK_CONTROL_100T1_STAT
''                                                             set_SYNC_LINK_CONTROL_100T1_STAT
''                                                             read_SYNC_LINK_CONTROL_100T1_STAT
''                                                             write_SYNC_LINK_CONTROL_100T1_STAT
''---------------------------------------------------------------------------------
'' SYNC_LINK_CONTROL_1000T1_STAT              [0:0]            get_SYNC_LINK_CONTROL_1000T1_STAT
''                                                             set_SYNC_LINK_CONTROL_1000T1_STAT
''                                                             read_SYNC_LINK_CONTROL_1000T1_STAT
''                                                             write_SYNC_LINK_CONTROL_1000T1_STAT
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_status_a
    Private write_LEGACY_100T1_DETECT_STATUS_value
    Private read_LEGACY_100T1_DETECT_STATUS_value
    Private flag_LEGACY_100T1_DETECT_STATUS
    Private write_AUTOSPEED_FSM_STAT_value
    Private read_AUTOSPEED_FSM_STAT_value
    Private flag_AUTOSPEED_FSM_STAT
    Private write_STATUS_A_SPARE_1_value
    Private read_STATUS_A_SPARE_1_value
    Private flag_STATUS_A_SPARE_1
    Private write_SYNC_LINK_FSM_STAT_value
    Private read_SYNC_LINK_FSM_STAT_value
    Private flag_SYNC_LINK_FSM_STAT
    Private write_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value
    Private read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value
    Private flag_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
    Private write_AUTOSPEED_CHANGED_SPEED_value
    Private read_AUTOSPEED_CHANGED_SPEED_value
    Private flag_AUTOSPEED_CHANGED_SPEED
    Private write_STATUS_A_SPARE_0_value
    Private read_STATUS_A_SPARE_0_value
    Private flag_STATUS_A_SPARE_0
    Private write_SYNC_LINK_CONTROL_100T1_STAT_value
    Private read_SYNC_LINK_CONTROL_100T1_STAT_value
    Private flag_SYNC_LINK_CONTROL_100T1_STAT
    Private write_SYNC_LINK_CONTROL_1000T1_STAT_value
    Private read_SYNC_LINK_CONTROL_1000T1_STAT_value
    Private flag_SYNC_LINK_CONTROL_1000T1_STAT

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

    Property Get get_LEGACY_100T1_DETECT_STATUS
        get_LEGACY_100T1_DETECT_STATUS = read_LEGACY_100T1_DETECT_STATUS_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_STATUS(aData)
        write_LEGACY_100T1_DETECT_STATUS_value = aData
        flag_LEGACY_100T1_DETECT_STATUS        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_STATUS
        read
        read_LEGACY_100T1_DETECT_STATUS = read_LEGACY_100T1_DETECT_STATUS_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_STATUS(aData)
        set_LEGACY_100T1_DETECT_STATUS = aData
        write
    End Property

    Property Get get_AUTOSPEED_FSM_STAT
        get_AUTOSPEED_FSM_STAT = read_AUTOSPEED_FSM_STAT_value
    End Property

    Property Let set_AUTOSPEED_FSM_STAT(aData)
        write_AUTOSPEED_FSM_STAT_value = aData
        flag_AUTOSPEED_FSM_STAT        = &H1
    End Property

    Property Get read_AUTOSPEED_FSM_STAT
        read
        read_AUTOSPEED_FSM_STAT = read_AUTOSPEED_FSM_STAT_value
    End Property

    Property Let write_AUTOSPEED_FSM_STAT(aData)
        set_AUTOSPEED_FSM_STAT = aData
        write
    End Property

    Property Get get_STATUS_A_SPARE_1
        get_STATUS_A_SPARE_1 = read_STATUS_A_SPARE_1_value
    End Property

    Property Let set_STATUS_A_SPARE_1(aData)
        write_STATUS_A_SPARE_1_value = aData
        flag_STATUS_A_SPARE_1        = &H1
    End Property

    Property Get read_STATUS_A_SPARE_1
        read
        read_STATUS_A_SPARE_1 = read_STATUS_A_SPARE_1_value
    End Property

    Property Let write_STATUS_A_SPARE_1(aData)
        set_STATUS_A_SPARE_1 = aData
        write
    End Property

    Property Get get_SYNC_LINK_FSM_STAT
        get_SYNC_LINK_FSM_STAT = read_SYNC_LINK_FSM_STAT_value
    End Property

    Property Let set_SYNC_LINK_FSM_STAT(aData)
        write_SYNC_LINK_FSM_STAT_value = aData
        flag_SYNC_LINK_FSM_STAT        = &H1
    End Property

    Property Get read_SYNC_LINK_FSM_STAT
        read
        read_SYNC_LINK_FSM_STAT = read_SYNC_LINK_FSM_STAT_value
    End Property

    Property Let write_SYNC_LINK_FSM_STAT(aData)
        set_SYNC_LINK_FSM_STAT = aData
        write
    End Property

    Property Get get_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
        get_AUTOSPEED_ATTEMPTS_COUNTER_VALUE = read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value
    End Property

    Property Let set_AUTOSPEED_ATTEMPTS_COUNTER_VALUE(aData)
        write_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value = aData
        flag_AUTOSPEED_ATTEMPTS_COUNTER_VALUE        = &H1
    End Property

    Property Get read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
        read
        read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE = read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value
    End Property

    Property Let write_AUTOSPEED_ATTEMPTS_COUNTER_VALUE(aData)
        set_AUTOSPEED_ATTEMPTS_COUNTER_VALUE = aData
        write
    End Property

    Property Get get_AUTOSPEED_CHANGED_SPEED
        get_AUTOSPEED_CHANGED_SPEED = read_AUTOSPEED_CHANGED_SPEED_value
    End Property

    Property Let set_AUTOSPEED_CHANGED_SPEED(aData)
        write_AUTOSPEED_CHANGED_SPEED_value = aData
        flag_AUTOSPEED_CHANGED_SPEED        = &H1
    End Property

    Property Get read_AUTOSPEED_CHANGED_SPEED
        read
        read_AUTOSPEED_CHANGED_SPEED = read_AUTOSPEED_CHANGED_SPEED_value
    End Property

    Property Let write_AUTOSPEED_CHANGED_SPEED(aData)
        set_AUTOSPEED_CHANGED_SPEED = aData
        write
    End Property

    Property Get get_STATUS_A_SPARE_0
        get_STATUS_A_SPARE_0 = read_STATUS_A_SPARE_0_value
    End Property

    Property Let set_STATUS_A_SPARE_0(aData)
        write_STATUS_A_SPARE_0_value = aData
        flag_STATUS_A_SPARE_0        = &H1
    End Property

    Property Get read_STATUS_A_SPARE_0
        read
        read_STATUS_A_SPARE_0 = read_STATUS_A_SPARE_0_value
    End Property

    Property Let write_STATUS_A_SPARE_0(aData)
        set_STATUS_A_SPARE_0 = aData
        write
    End Property

    Property Get get_SYNC_LINK_CONTROL_100T1_STAT
        get_SYNC_LINK_CONTROL_100T1_STAT = read_SYNC_LINK_CONTROL_100T1_STAT_value
    End Property

    Property Let set_SYNC_LINK_CONTROL_100T1_STAT(aData)
        write_SYNC_LINK_CONTROL_100T1_STAT_value = aData
        flag_SYNC_LINK_CONTROL_100T1_STAT        = &H1
    End Property

    Property Get read_SYNC_LINK_CONTROL_100T1_STAT
        read
        read_SYNC_LINK_CONTROL_100T1_STAT = read_SYNC_LINK_CONTROL_100T1_STAT_value
    End Property

    Property Let write_SYNC_LINK_CONTROL_100T1_STAT(aData)
        set_SYNC_LINK_CONTROL_100T1_STAT = aData
        write
    End Property

    Property Get get_SYNC_LINK_CONTROL_1000T1_STAT
        get_SYNC_LINK_CONTROL_1000T1_STAT = read_SYNC_LINK_CONTROL_1000T1_STAT_value
    End Property

    Property Let set_SYNC_LINK_CONTROL_1000T1_STAT(aData)
        write_SYNC_LINK_CONTROL_1000T1_STAT_value = aData
        flag_SYNC_LINK_CONTROL_1000T1_STAT        = &H1
    End Property

    Property Get read_SYNC_LINK_CONTROL_1000T1_STAT
        read
        read_SYNC_LINK_CONTROL_1000T1_STAT = read_SYNC_LINK_CONTROL_1000T1_STAT_value
    End Property

    Property Let write_SYNC_LINK_CONTROL_1000T1_STAT(aData)
        set_SYNC_LINK_CONTROL_1000T1_STAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LEGACY_100T1_DETECT_STATUS_value = rightShift(data_low, 15) and &H1
        read_AUTOSPEED_FSM_STAT_value = rightShift(data_low, 12) and &H7
        read_STATUS_A_SPARE_1_value = rightShift(data_low, 11) and &H1
        read_SYNC_LINK_FSM_STAT_value = rightShift(data_low, 8) and &H7
        read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value = rightShift(data_low, 5) and &H7
        read_AUTOSPEED_CHANGED_SPEED_value = rightShift(data_low, 4) and &H1
        read_STATUS_A_SPARE_0_value = rightShift(data_low, 2) and &H3
        read_SYNC_LINK_CONTROL_100T1_STAT_value = rightShift(data_low, 1) and &H1
        SYNC_LINK_CONTROL_1000T1_STAT_mask = &H1
        if data_low > LONG_MAX then
            if SYNC_LINK_CONTROL_1000T1_STAT_mask = mask then
                read_SYNC_LINK_CONTROL_1000T1_STAT_value = data_low
            else
                read_SYNC_LINK_CONTROL_1000T1_STAT_value = (data_low - H8000_0000) and SYNC_LINK_CONTROL_1000T1_STAT_mask
            end If
        else
            read_SYNC_LINK_CONTROL_1000T1_STAT_value = data_low and SYNC_LINK_CONTROL_1000T1_STAT_mask
        end If

    End Sub

    Sub write
        If flag_LEGACY_100T1_DETECT_STATUS = &H0 or flag_AUTOSPEED_FSM_STAT = &H0 or flag_STATUS_A_SPARE_1 = &H0 or flag_SYNC_LINK_FSM_STAT = &H0 or flag_AUTOSPEED_ATTEMPTS_COUNTER_VALUE = &H0 or flag_AUTOSPEED_CHANGED_SPEED = &H0 or flag_STATUS_A_SPARE_0 = &H0 or flag_SYNC_LINK_CONTROL_100T1_STAT = &H0 or flag_SYNC_LINK_CONTROL_1000T1_STAT = &H0 Then read
        If flag_LEGACY_100T1_DETECT_STATUS = &H0 Then write_LEGACY_100T1_DETECT_STATUS_value = get_LEGACY_100T1_DETECT_STATUS
        If flag_AUTOSPEED_FSM_STAT = &H0 Then write_AUTOSPEED_FSM_STAT_value = get_AUTOSPEED_FSM_STAT
        If flag_STATUS_A_SPARE_1 = &H0 Then write_STATUS_A_SPARE_1_value = get_STATUS_A_SPARE_1
        If flag_SYNC_LINK_FSM_STAT = &H0 Then write_SYNC_LINK_FSM_STAT_value = get_SYNC_LINK_FSM_STAT
        If flag_AUTOSPEED_ATTEMPTS_COUNTER_VALUE = &H0 Then write_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value = get_AUTOSPEED_ATTEMPTS_COUNTER_VALUE
        If flag_AUTOSPEED_CHANGED_SPEED = &H0 Then write_AUTOSPEED_CHANGED_SPEED_value = get_AUTOSPEED_CHANGED_SPEED
        If flag_STATUS_A_SPARE_0 = &H0 Then write_STATUS_A_SPARE_0_value = get_STATUS_A_SPARE_0
        If flag_SYNC_LINK_CONTROL_100T1_STAT = &H0 Then write_SYNC_LINK_CONTROL_100T1_STAT_value = get_SYNC_LINK_CONTROL_100T1_STAT
        If flag_SYNC_LINK_CONTROL_1000T1_STAT = &H0 Then write_SYNC_LINK_CONTROL_1000T1_STAT_value = get_SYNC_LINK_CONTROL_1000T1_STAT

        regValue = leftShift((write_LEGACY_100T1_DETECT_STATUS_value and &H1), 15) + leftShift((write_AUTOSPEED_FSM_STAT_value and &H7), 12) + leftShift((write_STATUS_A_SPARE_1_value and &H1), 11) + leftShift((write_SYNC_LINK_FSM_STAT_value and &H7), 8) + leftShift((write_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value and &H7), 5) + leftShift((write_AUTOSPEED_CHANGED_SPEED_value and &H1), 4) + leftShift((write_STATUS_A_SPARE_0_value and &H3), 2) + leftShift((write_SYNC_LINK_CONTROL_100T1_STAT_value and &H1), 1) + leftShift((write_SYNC_LINK_CONTROL_1000T1_STAT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LEGACY_100T1_DETECT_STATUS_value = rightShift(data_low, 15) and &H1
        read_AUTOSPEED_FSM_STAT_value = rightShift(data_low, 12) and &H7
        read_STATUS_A_SPARE_1_value = rightShift(data_low, 11) and &H1
        read_SYNC_LINK_FSM_STAT_value = rightShift(data_low, 8) and &H7
        read_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value = rightShift(data_low, 5) and &H7
        read_AUTOSPEED_CHANGED_SPEED_value = rightShift(data_low, 4) and &H1
        read_STATUS_A_SPARE_0_value = rightShift(data_low, 2) and &H3
        read_SYNC_LINK_CONTROL_100T1_STAT_value = rightShift(data_low, 1) and &H1
        SYNC_LINK_CONTROL_1000T1_STAT_mask = &H1
        if data_low > LONG_MAX then
            if SYNC_LINK_CONTROL_1000T1_STAT_mask = mask then
                read_SYNC_LINK_CONTROL_1000T1_STAT_value = data_low
            else
                read_SYNC_LINK_CONTROL_1000T1_STAT_value = (data_low - H8000_0000) and SYNC_LINK_CONTROL_1000T1_STAT_mask
            end If
        else
            read_SYNC_LINK_CONTROL_1000T1_STAT_value = data_low and SYNC_LINK_CONTROL_1000T1_STAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LEGACY_100T1_DETECT_STATUS_value = &H0
        flag_LEGACY_100T1_DETECT_STATUS        = &H0
        write_AUTOSPEED_FSM_STAT_value = &H0
        flag_AUTOSPEED_FSM_STAT        = &H0
        write_STATUS_A_SPARE_1_value = &H0
        flag_STATUS_A_SPARE_1        = &H0
        write_SYNC_LINK_FSM_STAT_value = &H0
        flag_SYNC_LINK_FSM_STAT        = &H0
        write_AUTOSPEED_ATTEMPTS_COUNTER_VALUE_value = &H0
        flag_AUTOSPEED_ATTEMPTS_COUNTER_VALUE        = &H0
        write_AUTOSPEED_CHANGED_SPEED_value = &H0
        flag_AUTOSPEED_CHANGED_SPEED        = &H0
        write_STATUS_A_SPARE_0_value = &H0
        flag_STATUS_A_SPARE_0        = &H0
        write_SYNC_LINK_CONTROL_100T1_STAT_value = &H0
        flag_SYNC_LINK_CONTROL_100T1_STAT        = &H0
        write_SYNC_LINK_CONTROL_1000T1_STAT_value = &H0
        flag_SYNC_LINK_CONTROL_1000T1_STAT        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_status_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' STATUS_B_SPARE_1                           [15:10]          get_STATUS_B_SPARE_1
''                                                             set_STATUS_B_SPARE_1
''                                                             read_STATUS_B_SPARE_1
''                                                             write_STATUS_B_SPARE_1
''---------------------------------------------------------------------------------
'' SEND_S_SIGPOL_STAT                         [9:9]            get_SEND_S_SIGPOL_STAT
''                                                             set_SEND_S_SIGPOL_STAT
''                                                             read_SEND_S_SIGPOL_STAT
''                                                             write_SEND_S_SIGPOL_STAT
''---------------------------------------------------------------------------------
'' SEND_S_SIGDET_STAT                         [8:8]            get_SEND_S_SIGDET_STAT
''                                                             set_SEND_S_SIGDET_STAT
''                                                             read_SEND_S_SIGDET_STAT
''                                                             write_SEND_S_SIGDET_STAT
''---------------------------------------------------------------------------------
'' STATUS_B_SPARE_0                           [7:1]            get_STATUS_B_SPARE_0
''                                                             set_STATUS_B_SPARE_0
''                                                             read_STATUS_B_SPARE_0
''                                                             write_STATUS_B_SPARE_0
''---------------------------------------------------------------------------------
'' LINK_STAT                                  [0:0]            get_LINK_STAT
''                                                             set_LINK_STAT
''                                                             read_LINK_STAT
''                                                             write_LINK_STAT
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_status_b
    Private write_STATUS_B_SPARE_1_value
    Private read_STATUS_B_SPARE_1_value
    Private flag_STATUS_B_SPARE_1
    Private write_SEND_S_SIGPOL_STAT_value
    Private read_SEND_S_SIGPOL_STAT_value
    Private flag_SEND_S_SIGPOL_STAT
    Private write_SEND_S_SIGDET_STAT_value
    Private read_SEND_S_SIGDET_STAT_value
    Private flag_SEND_S_SIGDET_STAT
    Private write_STATUS_B_SPARE_0_value
    Private read_STATUS_B_SPARE_0_value
    Private flag_STATUS_B_SPARE_0
    Private write_LINK_STAT_value
    Private read_LINK_STAT_value
    Private flag_LINK_STAT

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

    Property Get get_STATUS_B_SPARE_1
        get_STATUS_B_SPARE_1 = read_STATUS_B_SPARE_1_value
    End Property

    Property Let set_STATUS_B_SPARE_1(aData)
        write_STATUS_B_SPARE_1_value = aData
        flag_STATUS_B_SPARE_1        = &H1
    End Property

    Property Get read_STATUS_B_SPARE_1
        read
        read_STATUS_B_SPARE_1 = read_STATUS_B_SPARE_1_value
    End Property

    Property Let write_STATUS_B_SPARE_1(aData)
        set_STATUS_B_SPARE_1 = aData
        write
    End Property

    Property Get get_SEND_S_SIGPOL_STAT
        get_SEND_S_SIGPOL_STAT = read_SEND_S_SIGPOL_STAT_value
    End Property

    Property Let set_SEND_S_SIGPOL_STAT(aData)
        write_SEND_S_SIGPOL_STAT_value = aData
        flag_SEND_S_SIGPOL_STAT        = &H1
    End Property

    Property Get read_SEND_S_SIGPOL_STAT
        read
        read_SEND_S_SIGPOL_STAT = read_SEND_S_SIGPOL_STAT_value
    End Property

    Property Let write_SEND_S_SIGPOL_STAT(aData)
        set_SEND_S_SIGPOL_STAT = aData
        write
    End Property

    Property Get get_SEND_S_SIGDET_STAT
        get_SEND_S_SIGDET_STAT = read_SEND_S_SIGDET_STAT_value
    End Property

    Property Let set_SEND_S_SIGDET_STAT(aData)
        write_SEND_S_SIGDET_STAT_value = aData
        flag_SEND_S_SIGDET_STAT        = &H1
    End Property

    Property Get read_SEND_S_SIGDET_STAT
        read
        read_SEND_S_SIGDET_STAT = read_SEND_S_SIGDET_STAT_value
    End Property

    Property Let write_SEND_S_SIGDET_STAT(aData)
        set_SEND_S_SIGDET_STAT = aData
        write
    End Property

    Property Get get_STATUS_B_SPARE_0
        get_STATUS_B_SPARE_0 = read_STATUS_B_SPARE_0_value
    End Property

    Property Let set_STATUS_B_SPARE_0(aData)
        write_STATUS_B_SPARE_0_value = aData
        flag_STATUS_B_SPARE_0        = &H1
    End Property

    Property Get read_STATUS_B_SPARE_0
        read
        read_STATUS_B_SPARE_0 = read_STATUS_B_SPARE_0_value
    End Property

    Property Let write_STATUS_B_SPARE_0(aData)
        set_STATUS_B_SPARE_0 = aData
        write
    End Property

    Property Get get_LINK_STAT
        get_LINK_STAT = read_LINK_STAT_value
    End Property

    Property Let set_LINK_STAT(aData)
        write_LINK_STAT_value = aData
        flag_LINK_STAT        = &H1
    End Property

    Property Get read_LINK_STAT
        read
        read_LINK_STAT = read_LINK_STAT_value
    End Property

    Property Let write_LINK_STAT(aData)
        set_LINK_STAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_STATUS_B_SPARE_1_value = rightShift(data_low, 10) and &H3f
        read_SEND_S_SIGPOL_STAT_value = rightShift(data_low, 9) and &H1
        read_SEND_S_SIGDET_STAT_value = rightShift(data_low, 8) and &H1
        read_STATUS_B_SPARE_0_value = rightShift(data_low, 1) and &H7f
        LINK_STAT_mask = &H1
        if data_low > LONG_MAX then
            if LINK_STAT_mask = mask then
                read_LINK_STAT_value = data_low
            else
                read_LINK_STAT_value = (data_low - H8000_0000) and LINK_STAT_mask
            end If
        else
            read_LINK_STAT_value = data_low and LINK_STAT_mask
        end If

    End Sub

    Sub write
        If flag_STATUS_B_SPARE_1 = &H0 or flag_SEND_S_SIGPOL_STAT = &H0 or flag_SEND_S_SIGDET_STAT = &H0 or flag_STATUS_B_SPARE_0 = &H0 or flag_LINK_STAT = &H0 Then read
        If flag_STATUS_B_SPARE_1 = &H0 Then write_STATUS_B_SPARE_1_value = get_STATUS_B_SPARE_1
        If flag_SEND_S_SIGPOL_STAT = &H0 Then write_SEND_S_SIGPOL_STAT_value = get_SEND_S_SIGPOL_STAT
        If flag_SEND_S_SIGDET_STAT = &H0 Then write_SEND_S_SIGDET_STAT_value = get_SEND_S_SIGDET_STAT
        If flag_STATUS_B_SPARE_0 = &H0 Then write_STATUS_B_SPARE_0_value = get_STATUS_B_SPARE_0
        If flag_LINK_STAT = &H0 Then write_LINK_STAT_value = get_LINK_STAT

        regValue = leftShift((write_STATUS_B_SPARE_1_value and &H3f), 10) + leftShift((write_SEND_S_SIGPOL_STAT_value and &H1), 9) + leftShift((write_SEND_S_SIGDET_STAT_value and &H1), 8) + leftShift((write_STATUS_B_SPARE_0_value and &H7f), 1) + leftShift((write_LINK_STAT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_STATUS_B_SPARE_1_value = rightShift(data_low, 10) and &H3f
        read_SEND_S_SIGPOL_STAT_value = rightShift(data_low, 9) and &H1
        read_SEND_S_SIGDET_STAT_value = rightShift(data_low, 8) and &H1
        read_STATUS_B_SPARE_0_value = rightShift(data_low, 1) and &H7f
        LINK_STAT_mask = &H1
        if data_low > LONG_MAX then
            if LINK_STAT_mask = mask then
                read_LINK_STAT_value = data_low
            else
                read_LINK_STAT_value = (data_low - H8000_0000) and LINK_STAT_mask
            end If
        else
            read_LINK_STAT_value = data_low and LINK_STAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_STATUS_B_SPARE_1_value = &H0
        flag_STATUS_B_SPARE_1        = &H0
        write_SEND_S_SIGPOL_STAT_value = &H0
        flag_SEND_S_SIGPOL_STAT        = &H0
        write_SEND_S_SIGDET_STAT_value = &H0
        flag_SEND_S_SIGDET_STAT        = &H0
        write_STATUS_B_SPARE_0_value = &H0
        flag_STATUS_B_SPARE_0        = &H0
        write_LINK_STAT_value = &H0
        flag_LINK_STAT        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_legacy_100t1_detect_threshold
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VALUE                                      [15:0]           get_VALUE
''                                                             set_VALUE
''                                                             read_VALUE
''                                                             write_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_legacy_100t1_detect_threshold
    Private write_VALUE_value
    Private read_VALUE_value
    Private flag_VALUE

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

    Property Get get_VALUE
        get_VALUE = read_VALUE_value
    End Property

    Property Let set_VALUE(aData)
        write_VALUE_value = aData
        flag_VALUE        = &H1
    End Property

    Property Get read_VALUE
        read
        read_VALUE = read_VALUE_value
    End Property

    Property Let write_VALUE(aData)
        set_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

    End Sub

    Sub write
        If flag_VALUE = &H0 Then read
        If flag_VALUE = &H0 Then write_VALUE_value = get_VALUE

        regValue = leftShift((write_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VALUE_value = &H0
        flag_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_autospeed_grace_timer_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER_VALUE                                [15:0]           get_TIMER_VALUE
''                                                             set_TIMER_VALUE
''                                                             read_TIMER_VALUE
''                                                             write_TIMER_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_autospeed_grace_timer_value
    Private write_TIMER_VALUE_value
    Private read_TIMER_VALUE_value
    Private flag_TIMER_VALUE

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

    Property Get get_TIMER_VALUE
        get_TIMER_VALUE = read_TIMER_VALUE_value
    End Property

    Property Let set_TIMER_VALUE(aData)
        write_TIMER_VALUE_value = aData
        flag_TIMER_VALUE        = &H1
    End Property

    Property Get read_TIMER_VALUE
        read
        read_TIMER_VALUE = read_TIMER_VALUE_value
    End Property

    Property Let write_TIMER_VALUE(aData)
        set_TIMER_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TIMER_VALUE_mask = mask then
                read_TIMER_VALUE_value = data_low
            else
                read_TIMER_VALUE_value = (data_low - H8000_0000) and TIMER_VALUE_mask
            end If
        else
            read_TIMER_VALUE_value = data_low and TIMER_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TIMER_VALUE = &H0 Then read
        If flag_TIMER_VALUE = &H0 Then write_TIMER_VALUE_value = get_TIMER_VALUE

        regValue = leftShift((write_TIMER_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TIMER_VALUE_mask = mask then
                read_TIMER_VALUE_value = data_low
            else
                read_TIMER_VALUE_value = (data_low - H8000_0000) and TIMER_VALUE_mask
            end If
        else
            read_TIMER_VALUE_value = data_low and TIMER_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER_VALUE_value = &H0
        flag_TIMER_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_autospeed_link_inhibit_timer_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER_VALUE                                [15:0]           get_TIMER_VALUE
''                                                             set_TIMER_VALUE
''                                                             read_TIMER_VALUE
''                                                             write_TIMER_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_autospeed_link_inhibit_timer_value
    Private write_TIMER_VALUE_value
    Private read_TIMER_VALUE_value
    Private flag_TIMER_VALUE

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

    Property Get get_TIMER_VALUE
        get_TIMER_VALUE = read_TIMER_VALUE_value
    End Property

    Property Let set_TIMER_VALUE(aData)
        write_TIMER_VALUE_value = aData
        flag_TIMER_VALUE        = &H1
    End Property

    Property Get read_TIMER_VALUE
        read
        read_TIMER_VALUE = read_TIMER_VALUE_value
    End Property

    Property Let write_TIMER_VALUE(aData)
        set_TIMER_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TIMER_VALUE_mask = mask then
                read_TIMER_VALUE_value = data_low
            else
                read_TIMER_VALUE_value = (data_low - H8000_0000) and TIMER_VALUE_mask
            end If
        else
            read_TIMER_VALUE_value = data_low and TIMER_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TIMER_VALUE = &H0 Then read
        If flag_TIMER_VALUE = &H0 Then write_TIMER_VALUE_value = get_TIMER_VALUE

        regValue = leftShift((write_TIMER_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TIMER_VALUE_mask = mask then
                read_TIMER_VALUE_value = data_low
            else
                read_TIMER_VALUE_value = (data_low - H8000_0000) and TIMER_VALUE_mask
            end If
        else
            read_TIMER_VALUE_value = data_low and TIMER_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER_VALUE_value = &H0
        flag_TIMER_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_autospeed_wait_timer_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER_VALUE                                [15:0]           get_TIMER_VALUE
''                                                             set_TIMER_VALUE
''                                                             read_TIMER_VALUE
''                                                             write_TIMER_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_autospeed_wait_timer_value
    Private write_TIMER_VALUE_value
    Private read_TIMER_VALUE_value
    Private flag_TIMER_VALUE

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

    Property Get get_TIMER_VALUE
        get_TIMER_VALUE = read_TIMER_VALUE_value
    End Property

    Property Let set_TIMER_VALUE(aData)
        write_TIMER_VALUE_value = aData
        flag_TIMER_VALUE        = &H1
    End Property

    Property Get read_TIMER_VALUE
        read
        read_TIMER_VALUE = read_TIMER_VALUE_value
    End Property

    Property Let write_TIMER_VALUE(aData)
        set_TIMER_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TIMER_VALUE_mask = mask then
                read_TIMER_VALUE_value = data_low
            else
                read_TIMER_VALUE_value = (data_low - H8000_0000) and TIMER_VALUE_mask
            end If
        else
            read_TIMER_VALUE_value = data_low and TIMER_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TIMER_VALUE = &H0 Then read
        If flag_TIMER_VALUE = &H0 Then write_TIMER_VALUE_value = get_TIMER_VALUE

        regValue = leftShift((write_TIMER_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if TIMER_VALUE_mask = mask then
                read_TIMER_VALUE_value = data_low
            else
                read_TIMER_VALUE_value = (data_low - H8000_0000) and TIMER_VALUE_mask
            end If
        else
            read_TIMER_VALUE_value = data_low and TIMER_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER_VALUE_value = &H0
        flag_TIMER_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : LINK_SYNC_spare_register
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REGISTER                             [15:0]           get_SPARE_REGISTER
''                                                             set_SPARE_REGISTER
''                                                             read_SPARE_REGISTER
''                                                             write_SPARE_REGISTER
''---------------------------------------------------------------------------------
Class REGISTER_LINK_SYNC_spare_register
    Private write_SPARE_REGISTER_value
    Private read_SPARE_REGISTER_value
    Private flag_SPARE_REGISTER

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

    Property Get get_SPARE_REGISTER
        get_SPARE_REGISTER = read_SPARE_REGISTER_value
    End Property

    Property Let set_SPARE_REGISTER(aData)
        write_SPARE_REGISTER_value = aData
        flag_SPARE_REGISTER        = &H1
    End Property

    Property Get read_SPARE_REGISTER
        read
        read_SPARE_REGISTER = read_SPARE_REGISTER_value
    End Property

    Property Let write_SPARE_REGISTER(aData)
        set_SPARE_REGISTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REGISTER_mask = mask then
                read_SPARE_REGISTER_value = data_low
            else
                read_SPARE_REGISTER_value = (data_low - H8000_0000) and SPARE_REGISTER_mask
            end If
        else
            read_SPARE_REGISTER_value = data_low and SPARE_REGISTER_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REGISTER = &H0 Then read
        If flag_SPARE_REGISTER = &H0 Then write_SPARE_REGISTER_value = get_SPARE_REGISTER

        regValue = leftShift((write_SPARE_REGISTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REGISTER_mask = mask then
                read_SPARE_REGISTER_value = data_low
            else
                read_SPARE_REGISTER_value = (data_low - H8000_0000) and SPARE_REGISTER_mask
            end If
        else
            read_SPARE_REGISTER_value = data_low and SPARE_REGISTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_REGISTER_value = &H0
        flag_SPARE_REGISTER        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class LINK_SYNC_INSTANCE

    Public sigdet_threshold
    Public sigdet_window
    Public control_a
    Public control_b
    Public control_c
    Public status_a
    Public status_b
    Public legacy_100t1_detect_threshold
    Public autospeed_grace_timer_value
    Public autospeed_link_inhibit_timer_value
    Public autospeed_wait_timer_value
    Public spare_register


    Public default function Init(aBaseAddr)
        Set sigdet_threshold = (New REGISTER_LINK_SYNC_sigdet_threshold)(aBaseAddr, 16)
        Set sigdet_window = (New REGISTER_LINK_SYNC_sigdet_window)(aBaseAddr, 16)
        Set control_a = (New REGISTER_LINK_SYNC_control_a)(aBaseAddr, 16)
        Set control_b = (New REGISTER_LINK_SYNC_control_b)(aBaseAddr, 16)
        Set control_c = (New REGISTER_LINK_SYNC_control_c)(aBaseAddr, 16)
        Set status_a = (New REGISTER_LINK_SYNC_status_a)(aBaseAddr, 16)
        Set status_b = (New REGISTER_LINK_SYNC_status_b)(aBaseAddr, 16)
        Set legacy_100t1_detect_threshold = (New REGISTER_LINK_SYNC_legacy_100t1_detect_threshold)(aBaseAddr, 16)
        Set autospeed_grace_timer_value = (New REGISTER_LINK_SYNC_autospeed_grace_timer_value)(aBaseAddr, 16)
        Set autospeed_link_inhibit_timer_value = (New REGISTER_LINK_SYNC_autospeed_link_inhibit_timer_value)(aBaseAddr, 16)
        Set autospeed_wait_timer_value = (New REGISTER_LINK_SYNC_autospeed_wait_timer_value)(aBaseAddr, 16)
        Set spare_register = (New REGISTER_LINK_SYNC_spare_register)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set LINK_SYNC = CreateObject("System.Collections.ArrayList")
LINK_SYNC.Add ((New LINK_SYNC_INSTANCE)(&H49031e00))


