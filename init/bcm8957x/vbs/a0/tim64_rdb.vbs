

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


'' @REGISTER : TIM64_timer1loadmsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER1LOAD_MSB                             [31:0]           get_TIMER1LOAD_MSB
''                                                             set_TIMER1LOAD_MSB
''                                                             read_TIMER1LOAD_MSB
''                                                             write_TIMER1LOAD_MSB
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1loadmsb
    Private write_TIMER1LOAD_MSB_value
    Private read_TIMER1LOAD_MSB_value
    Private flag_TIMER1LOAD_MSB

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

    Property Get get_TIMER1LOAD_MSB
        get_TIMER1LOAD_MSB = read_TIMER1LOAD_MSB_value
    End Property

    Property Let set_TIMER1LOAD_MSB(aData)
        write_TIMER1LOAD_MSB_value = aData
        flag_TIMER1LOAD_MSB        = &H1
    End Property

    Property Get read_TIMER1LOAD_MSB
        read
        read_TIMER1LOAD_MSB = read_TIMER1LOAD_MSB_value
    End Property

    Property Let write_TIMER1LOAD_MSB(aData)
        set_TIMER1LOAD_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1LOAD_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1LOAD_MSB_mask = mask then
                read_TIMER1LOAD_MSB_value = data_low
            else
                read_TIMER1LOAD_MSB_value = (data_low - H8000_0000) and TIMER1LOAD_MSB_mask
            end If
        else
            read_TIMER1LOAD_MSB_value = data_low and TIMER1LOAD_MSB_mask
        end If

    End Sub

    Sub write
        If flag_TIMER1LOAD_MSB = &H0 Then read
        If flag_TIMER1LOAD_MSB = &H0 Then write_TIMER1LOAD_MSB_value = get_TIMER1LOAD_MSB

        regValue = leftShift(write_TIMER1LOAD_MSB_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1LOAD_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1LOAD_MSB_mask = mask then
                read_TIMER1LOAD_MSB_value = data_low
            else
                read_TIMER1LOAD_MSB_value = (data_low - H8000_0000) and TIMER1LOAD_MSB_mask
            end If
        else
            read_TIMER1LOAD_MSB_value = data_low and TIMER1LOAD_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER1LOAD_MSB_value = &H0
        flag_TIMER1LOAD_MSB        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1load
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER1LOAD                                 [31:0]           get_TIMER1LOAD
''                                                             set_TIMER1LOAD
''                                                             read_TIMER1LOAD
''                                                             write_TIMER1LOAD
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1load
    Private write_TIMER1LOAD_value
    Private read_TIMER1LOAD_value
    Private flag_TIMER1LOAD

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

    Property Get get_TIMER1LOAD
        get_TIMER1LOAD = read_TIMER1LOAD_value
    End Property

    Property Let set_TIMER1LOAD(aData)
        write_TIMER1LOAD_value = aData
        flag_TIMER1LOAD        = &H1
    End Property

    Property Get read_TIMER1LOAD
        read
        read_TIMER1LOAD = read_TIMER1LOAD_value
    End Property

    Property Let write_TIMER1LOAD(aData)
        set_TIMER1LOAD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1LOAD_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1LOAD_mask = mask then
                read_TIMER1LOAD_value = data_low
            else
                read_TIMER1LOAD_value = (data_low - H8000_0000) and TIMER1LOAD_mask
            end If
        else
            read_TIMER1LOAD_value = data_low and TIMER1LOAD_mask
        end If

    End Sub

    Sub write
        If flag_TIMER1LOAD = &H0 Then read
        If flag_TIMER1LOAD = &H0 Then write_TIMER1LOAD_value = get_TIMER1LOAD

        regValue = leftShift(write_TIMER1LOAD_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1LOAD_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1LOAD_mask = mask then
                read_TIMER1LOAD_value = data_low
            else
                read_TIMER1LOAD_value = (data_low - H8000_0000) and TIMER1LOAD_mask
            end If
        else
            read_TIMER1LOAD_value = data_low and TIMER1LOAD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER1LOAD_value = &H0
        flag_TIMER1LOAD        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1valuemsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER1VALUE_MSB                            [31:0]           get_TIMER1VALUE_MSB
''                                                             set_TIMER1VALUE_MSB
''                                                             read_TIMER1VALUE_MSB
''                                                             write_TIMER1VALUE_MSB
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1valuemsb
    Private write_TIMER1VALUE_MSB_value
    Private read_TIMER1VALUE_MSB_value
    Private flag_TIMER1VALUE_MSB

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

    Property Get get_TIMER1VALUE_MSB
        get_TIMER1VALUE_MSB = read_TIMER1VALUE_MSB_value
    End Property

    Property Let set_TIMER1VALUE_MSB(aData)
        write_TIMER1VALUE_MSB_value = aData
        flag_TIMER1VALUE_MSB        = &H1
    End Property

    Property Get read_TIMER1VALUE_MSB
        read
        read_TIMER1VALUE_MSB = read_TIMER1VALUE_MSB_value
    End Property

    Property Let write_TIMER1VALUE_MSB(aData)
        set_TIMER1VALUE_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1VALUE_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1VALUE_MSB_mask = mask then
                read_TIMER1VALUE_MSB_value = data_low
            else
                read_TIMER1VALUE_MSB_value = (data_low - H8000_0000) and TIMER1VALUE_MSB_mask
            end If
        else
            read_TIMER1VALUE_MSB_value = data_low and TIMER1VALUE_MSB_mask
        end If

    End Sub

    Sub write
        If flag_TIMER1VALUE_MSB = &H0 Then read
        If flag_TIMER1VALUE_MSB = &H0 Then write_TIMER1VALUE_MSB_value = get_TIMER1VALUE_MSB

        regValue = leftShift(write_TIMER1VALUE_MSB_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1VALUE_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1VALUE_MSB_mask = mask then
                read_TIMER1VALUE_MSB_value = data_low
            else
                read_TIMER1VALUE_MSB_value = (data_low - H8000_0000) and TIMER1VALUE_MSB_mask
            end If
        else
            read_TIMER1VALUE_MSB_value = data_low and TIMER1VALUE_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER1VALUE_MSB_value = &H0
        flag_TIMER1VALUE_MSB        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER1VALUE                                [31:0]           get_TIMER1VALUE
''                                                             set_TIMER1VALUE
''                                                             read_TIMER1VALUE
''                                                             write_TIMER1VALUE
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1value
    Private write_TIMER1VALUE_value
    Private read_TIMER1VALUE_value
    Private flag_TIMER1VALUE

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

    Property Get get_TIMER1VALUE
        get_TIMER1VALUE = read_TIMER1VALUE_value
    End Property

    Property Let set_TIMER1VALUE(aData)
        write_TIMER1VALUE_value = aData
        flag_TIMER1VALUE        = &H1
    End Property

    Property Get read_TIMER1VALUE
        read
        read_TIMER1VALUE = read_TIMER1VALUE_value
    End Property

    Property Let write_TIMER1VALUE(aData)
        set_TIMER1VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1VALUE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1VALUE_mask = mask then
                read_TIMER1VALUE_value = data_low
            else
                read_TIMER1VALUE_value = (data_low - H8000_0000) and TIMER1VALUE_mask
            end If
        else
            read_TIMER1VALUE_value = data_low and TIMER1VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TIMER1VALUE = &H0 Then read
        If flag_TIMER1VALUE = &H0 Then write_TIMER1VALUE_value = get_TIMER1VALUE

        regValue = leftShift(write_TIMER1VALUE_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1VALUE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1VALUE_mask = mask then
                read_TIMER1VALUE_value = data_low
            else
                read_TIMER1VALUE_value = (data_low - H8000_0000) and TIMER1VALUE_mask
            end If
        else
            read_TIMER1VALUE_value = data_low and TIMER1VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER1VALUE_value = &H0
        flag_TIMER1VALUE        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Timer1En                                   [7:7]            get_Timer1En
''                                                             set_Timer1En
''                                                             read_Timer1En
''                                                             write_Timer1En
''---------------------------------------------------------------------------------
'' Timer1Mode                                 [6:6]            get_Timer1Mode
''                                                             set_Timer1Mode
''                                                             read_Timer1Mode
''                                                             write_Timer1Mode
''---------------------------------------------------------------------------------
'' IntEnable1                                 [5:5]            get_IntEnable1
''                                                             set_IntEnable1
''                                                             read_IntEnable1
''                                                             write_IntEnable1
''---------------------------------------------------------------------------------
'' Timer1Pre                                  [3:2]            get_Timer1Pre
''                                                             set_Timer1Pre
''                                                             read_Timer1Pre
''                                                             write_Timer1Pre
''---------------------------------------------------------------------------------
'' OneShot_Timer1                             [0:0]            get_OneShot_Timer1
''                                                             set_OneShot_Timer1
''                                                             read_OneShot_Timer1
''                                                             write_OneShot_Timer1
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1control
    Private write_Timer1En_value
    Private read_Timer1En_value
    Private flag_Timer1En
    Private write_Timer1Mode_value
    Private read_Timer1Mode_value
    Private flag_Timer1Mode
    Private write_IntEnable1_value
    Private read_IntEnable1_value
    Private flag_IntEnable1
    Private write_Timer1Pre_value
    Private read_Timer1Pre_value
    Private flag_Timer1Pre
    Private write_OneShot_Timer1_value
    Private read_OneShot_Timer1_value
    Private flag_OneShot_Timer1

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

    Property Get get_Timer1En
        get_Timer1En = read_Timer1En_value
    End Property

    Property Let set_Timer1En(aData)
        write_Timer1En_value = aData
        flag_Timer1En        = &H1
    End Property

    Property Get read_Timer1En
        read
        read_Timer1En = read_Timer1En_value
    End Property

    Property Let write_Timer1En(aData)
        set_Timer1En = aData
        write
    End Property

    Property Get get_Timer1Mode
        get_Timer1Mode = read_Timer1Mode_value
    End Property

    Property Let set_Timer1Mode(aData)
        write_Timer1Mode_value = aData
        flag_Timer1Mode        = &H1
    End Property

    Property Get read_Timer1Mode
        read
        read_Timer1Mode = read_Timer1Mode_value
    End Property

    Property Let write_Timer1Mode(aData)
        set_Timer1Mode = aData
        write
    End Property

    Property Get get_IntEnable1
        get_IntEnable1 = read_IntEnable1_value
    End Property

    Property Let set_IntEnable1(aData)
        write_IntEnable1_value = aData
        flag_IntEnable1        = &H1
    End Property

    Property Get read_IntEnable1
        read
        read_IntEnable1 = read_IntEnable1_value
    End Property

    Property Let write_IntEnable1(aData)
        set_IntEnable1 = aData
        write
    End Property

    Property Get get_Timer1Pre
        get_Timer1Pre = read_Timer1Pre_value
    End Property

    Property Let set_Timer1Pre(aData)
        write_Timer1Pre_value = aData
        flag_Timer1Pre        = &H1
    End Property

    Property Get read_Timer1Pre
        read
        read_Timer1Pre = read_Timer1Pre_value
    End Property

    Property Let write_Timer1Pre(aData)
        set_Timer1Pre = aData
        write
    End Property

    Property Get get_OneShot_Timer1
        get_OneShot_Timer1 = read_OneShot_Timer1_value
    End Property

    Property Let set_OneShot_Timer1(aData)
        write_OneShot_Timer1_value = aData
        flag_OneShot_Timer1        = &H1
    End Property

    Property Get read_OneShot_Timer1
        read
        read_OneShot_Timer1 = read_OneShot_Timer1_value
    End Property

    Property Let write_OneShot_Timer1(aData)
        set_OneShot_Timer1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Timer1En_value = rightShift(data_low, 7) and &H1
        read_Timer1Mode_value = rightShift(data_low, 6) and &H1
        read_IntEnable1_value = rightShift(data_low, 5) and &H1
        read_Timer1Pre_value = rightShift(data_low, 2) and &H3
        OneShot_Timer1_mask = &H1
        if data_low > LONG_MAX then
            if OneShot_Timer1_mask = mask then
                read_OneShot_Timer1_value = data_low
            else
                read_OneShot_Timer1_value = (data_low - H8000_0000) and OneShot_Timer1_mask
            end If
        else
            read_OneShot_Timer1_value = data_low and OneShot_Timer1_mask
        end If

    End Sub

    Sub write
        If flag_Timer1En = &H0 or flag_Timer1Mode = &H0 or flag_IntEnable1 = &H0 or flag_Timer1Pre = &H0 or flag_OneShot_Timer1 = &H0 Then read
        If flag_Timer1En = &H0 Then write_Timer1En_value = get_Timer1En
        If flag_Timer1Mode = &H0 Then write_Timer1Mode_value = get_Timer1Mode
        If flag_IntEnable1 = &H0 Then write_IntEnable1_value = get_IntEnable1
        If flag_Timer1Pre = &H0 Then write_Timer1Pre_value = get_Timer1Pre
        If flag_OneShot_Timer1 = &H0 Then write_OneShot_Timer1_value = get_OneShot_Timer1

        regValue = leftShift((write_Timer1En_value and &H1), 7) + leftShift((write_Timer1Mode_value and &H1), 6) + leftShift((write_IntEnable1_value and &H1), 5) + leftShift((write_Timer1Pre_value and &H3), 2) + leftShift((write_OneShot_Timer1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Timer1En_value = rightShift(data_low, 7) and &H1
        read_Timer1Mode_value = rightShift(data_low, 6) and &H1
        read_IntEnable1_value = rightShift(data_low, 5) and &H1
        read_Timer1Pre_value = rightShift(data_low, 2) and &H3
        OneShot_Timer1_mask = &H1
        if data_low > LONG_MAX then
            if OneShot_Timer1_mask = mask then
                read_OneShot_Timer1_value = data_low
            else
                read_OneShot_Timer1_value = (data_low - H8000_0000) and OneShot_Timer1_mask
            end If
        else
            read_OneShot_Timer1_value = data_low and OneShot_Timer1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Timer1En_value = &H0
        flag_Timer1En        = &H0
        write_Timer1Mode_value = &H0
        flag_Timer1Mode        = &H0
        write_IntEnable1_value = &H0
        flag_IntEnable1        = &H0
        write_Timer1Pre_value = &H0
        flag_Timer1Pre        = &H0
        write_OneShot_Timer1_value = &H0
        flag_OneShot_Timer1        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1intclr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER1INTCLR                               [0:0]            get_TIMER1INTCLR
''                                                             set_TIMER1INTCLR
''                                                             read_TIMER1INTCLR
''                                                             write_TIMER1INTCLR
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1intclr
    Private write_TIMER1INTCLR_value
    Private read_TIMER1INTCLR_value
    Private flag_TIMER1INTCLR

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

    Property Get get_TIMER1INTCLR
        get_TIMER1INTCLR = read_TIMER1INTCLR_value
    End Property

    Property Let set_TIMER1INTCLR(aData)
        write_TIMER1INTCLR_value = aData
        flag_TIMER1INTCLR        = &H1
    End Property

    Property Get read_TIMER1INTCLR
        read
        read_TIMER1INTCLR = read_TIMER1INTCLR_value
    End Property

    Property Let write_TIMER1INTCLR(aData)
        set_TIMER1INTCLR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1INTCLR_mask = &H1
        if data_low > LONG_MAX then
            if TIMER1INTCLR_mask = mask then
                read_TIMER1INTCLR_value = data_low
            else
                read_TIMER1INTCLR_value = (data_low - H8000_0000) and TIMER1INTCLR_mask
            end If
        else
            read_TIMER1INTCLR_value = data_low and TIMER1INTCLR_mask
        end If

    End Sub

    Sub write
        If flag_TIMER1INTCLR = &H0 Then read
        If flag_TIMER1INTCLR = &H0 Then write_TIMER1INTCLR_value = get_TIMER1INTCLR

        regValue = leftShift((write_TIMER1INTCLR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1INTCLR_mask = &H1
        if data_low > LONG_MAX then
            if TIMER1INTCLR_mask = mask then
                read_TIMER1INTCLR_value = data_low
            else
                read_TIMER1INTCLR_value = (data_low - H8000_0000) and TIMER1INTCLR_mask
            end If
        else
            read_TIMER1INTCLR_value = data_low and TIMER1INTCLR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER1INTCLR_value = &H0
        flag_TIMER1INTCLR        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1ris
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Timer1RIS                                  [0:0]            get_Timer1RIS
''                                                             set_Timer1RIS
''                                                             read_Timer1RIS
''                                                             write_Timer1RIS
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1ris
    Private write_Timer1RIS_value
    Private read_Timer1RIS_value
    Private flag_Timer1RIS

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

    Property Get get_Timer1RIS
        get_Timer1RIS = read_Timer1RIS_value
    End Property

    Property Let set_Timer1RIS(aData)
        write_Timer1RIS_value = aData
        flag_Timer1RIS        = &H1
    End Property

    Property Get read_Timer1RIS
        read
        read_Timer1RIS = read_Timer1RIS_value
    End Property

    Property Let write_Timer1RIS(aData)
        set_Timer1RIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer1RIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer1RIS_mask = mask then
                read_Timer1RIS_value = data_low
            else
                read_Timer1RIS_value = (data_low - H8000_0000) and Timer1RIS_mask
            end If
        else
            read_Timer1RIS_value = data_low and Timer1RIS_mask
        end If

    End Sub

    Sub write
        If flag_Timer1RIS = &H0 Then read
        If flag_Timer1RIS = &H0 Then write_Timer1RIS_value = get_Timer1RIS

        regValue = leftShift((write_Timer1RIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer1RIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer1RIS_mask = mask then
                read_Timer1RIS_value = data_low
            else
                read_Timer1RIS_value = (data_low - H8000_0000) and Timer1RIS_mask
            end If
        else
            read_Timer1RIS_value = data_low and Timer1RIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Timer1RIS_value = &H0
        flag_Timer1RIS        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1mis
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Timer1MIS                                  [0:0]            get_Timer1MIS
''                                                             set_Timer1MIS
''                                                             read_Timer1MIS
''                                                             write_Timer1MIS
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1mis
    Private write_Timer1MIS_value
    Private read_Timer1MIS_value
    Private flag_Timer1MIS

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

    Property Get get_Timer1MIS
        get_Timer1MIS = read_Timer1MIS_value
    End Property

    Property Let set_Timer1MIS(aData)
        write_Timer1MIS_value = aData
        flag_Timer1MIS        = &H1
    End Property

    Property Get read_Timer1MIS
        read
        read_Timer1MIS = read_Timer1MIS_value
    End Property

    Property Let write_Timer1MIS(aData)
        set_Timer1MIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer1MIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer1MIS_mask = mask then
                read_Timer1MIS_value = data_low
            else
                read_Timer1MIS_value = (data_low - H8000_0000) and Timer1MIS_mask
            end If
        else
            read_Timer1MIS_value = data_low and Timer1MIS_mask
        end If

    End Sub

    Sub write
        If flag_Timer1MIS = &H0 Then read
        If flag_Timer1MIS = &H0 Then write_Timer1MIS_value = get_Timer1MIS

        regValue = leftShift((write_Timer1MIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer1MIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer1MIS_mask = mask then
                read_Timer1MIS_value = data_low
            else
                read_Timer1MIS_value = (data_low - H8000_0000) and Timer1MIS_mask
            end If
        else
            read_Timer1MIS_value = data_low and Timer1MIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Timer1MIS_value = &H0
        flag_Timer1MIS        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1bgloadmsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER1BGLoad_MSB                           [31:0]           get_TIMER1BGLoad_MSB
''                                                             set_TIMER1BGLoad_MSB
''                                                             read_TIMER1BGLoad_MSB
''                                                             write_TIMER1BGLoad_MSB
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1bgloadmsb
    Private write_TIMER1BGLoad_MSB_value
    Private read_TIMER1BGLoad_MSB_value
    Private flag_TIMER1BGLoad_MSB

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

    Property Get get_TIMER1BGLoad_MSB
        get_TIMER1BGLoad_MSB = read_TIMER1BGLoad_MSB_value
    End Property

    Property Let set_TIMER1BGLoad_MSB(aData)
        write_TIMER1BGLoad_MSB_value = aData
        flag_TIMER1BGLoad_MSB        = &H1
    End Property

    Property Get read_TIMER1BGLoad_MSB
        read
        read_TIMER1BGLoad_MSB = read_TIMER1BGLoad_MSB_value
    End Property

    Property Let write_TIMER1BGLoad_MSB(aData)
        set_TIMER1BGLoad_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1BGLoad_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1BGLoad_MSB_mask = mask then
                read_TIMER1BGLoad_MSB_value = data_low
            else
                read_TIMER1BGLoad_MSB_value = (data_low - H8000_0000) and TIMER1BGLoad_MSB_mask
            end If
        else
            read_TIMER1BGLoad_MSB_value = data_low and TIMER1BGLoad_MSB_mask
        end If

    End Sub

    Sub write
        If flag_TIMER1BGLoad_MSB = &H0 Then read
        If flag_TIMER1BGLoad_MSB = &H0 Then write_TIMER1BGLoad_MSB_value = get_TIMER1BGLoad_MSB

        regValue = leftShift(write_TIMER1BGLoad_MSB_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1BGLoad_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1BGLoad_MSB_mask = mask then
                read_TIMER1BGLoad_MSB_value = data_low
            else
                read_TIMER1BGLoad_MSB_value = (data_low - H8000_0000) and TIMER1BGLoad_MSB_mask
            end If
        else
            read_TIMER1BGLoad_MSB_value = data_low and TIMER1BGLoad_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER1BGLoad_MSB_value = &H0
        flag_TIMER1BGLoad_MSB        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer1bgload
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER1BGLoad                               [31:0]           get_TIMER1BGLoad
''                                                             set_TIMER1BGLoad
''                                                             read_TIMER1BGLoad
''                                                             write_TIMER1BGLoad
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer1bgload
    Private write_TIMER1BGLoad_value
    Private read_TIMER1BGLoad_value
    Private flag_TIMER1BGLoad

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

    Property Get get_TIMER1BGLoad
        get_TIMER1BGLoad = read_TIMER1BGLoad_value
    End Property

    Property Let set_TIMER1BGLoad(aData)
        write_TIMER1BGLoad_value = aData
        flag_TIMER1BGLoad        = &H1
    End Property

    Property Get read_TIMER1BGLoad
        read
        read_TIMER1BGLoad = read_TIMER1BGLoad_value
    End Property

    Property Let write_TIMER1BGLoad(aData)
        set_TIMER1BGLoad = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1BGLoad_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1BGLoad_mask = mask then
                read_TIMER1BGLoad_value = data_low
            else
                read_TIMER1BGLoad_value = (data_low - H8000_0000) and TIMER1BGLoad_mask
            end If
        else
            read_TIMER1BGLoad_value = data_low and TIMER1BGLoad_mask
        end If

    End Sub

    Sub write
        If flag_TIMER1BGLoad = &H0 Then read
        If flag_TIMER1BGLoad = &H0 Then write_TIMER1BGLoad_value = get_TIMER1BGLoad

        regValue = leftShift(write_TIMER1BGLoad_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER1BGLoad_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER1BGLoad_mask = mask then
                read_TIMER1BGLoad_value = data_low
            else
                read_TIMER1BGLoad_value = (data_low - H8000_0000) and TIMER1BGLoad_mask
            end If
        else
            read_TIMER1BGLoad_value = data_low and TIMER1BGLoad_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER1BGLoad_value = &H0
        flag_TIMER1BGLoad        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2loadmsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER2LOAD_MSB                             [31:0]           get_TIMER2LOAD_MSB
''                                                             set_TIMER2LOAD_MSB
''                                                             read_TIMER2LOAD_MSB
''                                                             write_TIMER2LOAD_MSB
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2loadmsb
    Private write_TIMER2LOAD_MSB_value
    Private read_TIMER2LOAD_MSB_value
    Private flag_TIMER2LOAD_MSB

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

    Property Get get_TIMER2LOAD_MSB
        get_TIMER2LOAD_MSB = read_TIMER2LOAD_MSB_value
    End Property

    Property Let set_TIMER2LOAD_MSB(aData)
        write_TIMER2LOAD_MSB_value = aData
        flag_TIMER2LOAD_MSB        = &H1
    End Property

    Property Get read_TIMER2LOAD_MSB
        read
        read_TIMER2LOAD_MSB = read_TIMER2LOAD_MSB_value
    End Property

    Property Let write_TIMER2LOAD_MSB(aData)
        set_TIMER2LOAD_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2LOAD_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2LOAD_MSB_mask = mask then
                read_TIMER2LOAD_MSB_value = data_low
            else
                read_TIMER2LOAD_MSB_value = (data_low - H8000_0000) and TIMER2LOAD_MSB_mask
            end If
        else
            read_TIMER2LOAD_MSB_value = data_low and TIMER2LOAD_MSB_mask
        end If

    End Sub

    Sub write
        If flag_TIMER2LOAD_MSB = &H0 Then read
        If flag_TIMER2LOAD_MSB = &H0 Then write_TIMER2LOAD_MSB_value = get_TIMER2LOAD_MSB

        regValue = leftShift(write_TIMER2LOAD_MSB_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2LOAD_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2LOAD_MSB_mask = mask then
                read_TIMER2LOAD_MSB_value = data_low
            else
                read_TIMER2LOAD_MSB_value = (data_low - H8000_0000) and TIMER2LOAD_MSB_mask
            end If
        else
            read_TIMER2LOAD_MSB_value = data_low and TIMER2LOAD_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER2LOAD_MSB_value = &H0
        flag_TIMER2LOAD_MSB        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2load
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER2LOAD                                 [31:0]           get_TIMER2LOAD
''                                                             set_TIMER2LOAD
''                                                             read_TIMER2LOAD
''                                                             write_TIMER2LOAD
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2load
    Private write_TIMER2LOAD_value
    Private read_TIMER2LOAD_value
    Private flag_TIMER2LOAD

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

    Property Get get_TIMER2LOAD
        get_TIMER2LOAD = read_TIMER2LOAD_value
    End Property

    Property Let set_TIMER2LOAD(aData)
        write_TIMER2LOAD_value = aData
        flag_TIMER2LOAD        = &H1
    End Property

    Property Get read_TIMER2LOAD
        read
        read_TIMER2LOAD = read_TIMER2LOAD_value
    End Property

    Property Let write_TIMER2LOAD(aData)
        set_TIMER2LOAD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2LOAD_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2LOAD_mask = mask then
                read_TIMER2LOAD_value = data_low
            else
                read_TIMER2LOAD_value = (data_low - H8000_0000) and TIMER2LOAD_mask
            end If
        else
            read_TIMER2LOAD_value = data_low and TIMER2LOAD_mask
        end If

    End Sub

    Sub write
        If flag_TIMER2LOAD = &H0 Then read
        If flag_TIMER2LOAD = &H0 Then write_TIMER2LOAD_value = get_TIMER2LOAD

        regValue = leftShift(write_TIMER2LOAD_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2LOAD_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2LOAD_mask = mask then
                read_TIMER2LOAD_value = data_low
            else
                read_TIMER2LOAD_value = (data_low - H8000_0000) and TIMER2LOAD_mask
            end If
        else
            read_TIMER2LOAD_value = data_low and TIMER2LOAD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER2LOAD_value = &H0
        flag_TIMER2LOAD        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2valuemsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER2VALUE_MSB                            [31:0]           get_TIMER2VALUE_MSB
''                                                             set_TIMER2VALUE_MSB
''                                                             read_TIMER2VALUE_MSB
''                                                             write_TIMER2VALUE_MSB
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2valuemsb
    Private write_TIMER2VALUE_MSB_value
    Private read_TIMER2VALUE_MSB_value
    Private flag_TIMER2VALUE_MSB

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

    Property Get get_TIMER2VALUE_MSB
        get_TIMER2VALUE_MSB = read_TIMER2VALUE_MSB_value
    End Property

    Property Let set_TIMER2VALUE_MSB(aData)
        write_TIMER2VALUE_MSB_value = aData
        flag_TIMER2VALUE_MSB        = &H1
    End Property

    Property Get read_TIMER2VALUE_MSB
        read
        read_TIMER2VALUE_MSB = read_TIMER2VALUE_MSB_value
    End Property

    Property Let write_TIMER2VALUE_MSB(aData)
        set_TIMER2VALUE_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2VALUE_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2VALUE_MSB_mask = mask then
                read_TIMER2VALUE_MSB_value = data_low
            else
                read_TIMER2VALUE_MSB_value = (data_low - H8000_0000) and TIMER2VALUE_MSB_mask
            end If
        else
            read_TIMER2VALUE_MSB_value = data_low and TIMER2VALUE_MSB_mask
        end If

    End Sub

    Sub write
        If flag_TIMER2VALUE_MSB = &H0 Then read
        If flag_TIMER2VALUE_MSB = &H0 Then write_TIMER2VALUE_MSB_value = get_TIMER2VALUE_MSB

        regValue = leftShift(write_TIMER2VALUE_MSB_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2VALUE_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2VALUE_MSB_mask = mask then
                read_TIMER2VALUE_MSB_value = data_low
            else
                read_TIMER2VALUE_MSB_value = (data_low - H8000_0000) and TIMER2VALUE_MSB_mask
            end If
        else
            read_TIMER2VALUE_MSB_value = data_low and TIMER2VALUE_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER2VALUE_MSB_value = &H0
        flag_TIMER2VALUE_MSB        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER2VALUE                                [31:0]           get_TIMER2VALUE
''                                                             set_TIMER2VALUE
''                                                             read_TIMER2VALUE
''                                                             write_TIMER2VALUE
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2value
    Private write_TIMER2VALUE_value
    Private read_TIMER2VALUE_value
    Private flag_TIMER2VALUE

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

    Property Get get_TIMER2VALUE
        get_TIMER2VALUE = read_TIMER2VALUE_value
    End Property

    Property Let set_TIMER2VALUE(aData)
        write_TIMER2VALUE_value = aData
        flag_TIMER2VALUE        = &H1
    End Property

    Property Get read_TIMER2VALUE
        read
        read_TIMER2VALUE = read_TIMER2VALUE_value
    End Property

    Property Let write_TIMER2VALUE(aData)
        set_TIMER2VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2VALUE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2VALUE_mask = mask then
                read_TIMER2VALUE_value = data_low
            else
                read_TIMER2VALUE_value = (data_low - H8000_0000) and TIMER2VALUE_mask
            end If
        else
            read_TIMER2VALUE_value = data_low and TIMER2VALUE_mask
        end If

    End Sub

    Sub write
        If flag_TIMER2VALUE = &H0 Then read
        If flag_TIMER2VALUE = &H0 Then write_TIMER2VALUE_value = get_TIMER2VALUE

        regValue = leftShift(write_TIMER2VALUE_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2VALUE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2VALUE_mask = mask then
                read_TIMER2VALUE_value = data_low
            else
                read_TIMER2VALUE_value = (data_low - H8000_0000) and TIMER2VALUE_mask
            end If
        else
            read_TIMER2VALUE_value = data_low and TIMER2VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER2VALUE_value = &H0
        flag_TIMER2VALUE        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Timer2En                                   [7:7]            get_Timer2En
''                                                             set_Timer2En
''                                                             read_Timer2En
''                                                             write_Timer2En
''---------------------------------------------------------------------------------
'' Timer2Mode                                 [6:6]            get_Timer2Mode
''                                                             set_Timer2Mode
''                                                             read_Timer2Mode
''                                                             write_Timer2Mode
''---------------------------------------------------------------------------------
'' IntEnable2                                 [5:5]            get_IntEnable2
''                                                             set_IntEnable2
''                                                             read_IntEnable2
''                                                             write_IntEnable2
''---------------------------------------------------------------------------------
'' Timer2Pre                                  [3:2]            get_Timer2Pre
''                                                             set_Timer2Pre
''                                                             read_Timer2Pre
''                                                             write_Timer2Pre
''---------------------------------------------------------------------------------
'' OneShot_Timer2                             [0:0]            get_OneShot_Timer2
''                                                             set_OneShot_Timer2
''                                                             read_OneShot_Timer2
''                                                             write_OneShot_Timer2
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2control
    Private write_Timer2En_value
    Private read_Timer2En_value
    Private flag_Timer2En
    Private write_Timer2Mode_value
    Private read_Timer2Mode_value
    Private flag_Timer2Mode
    Private write_IntEnable2_value
    Private read_IntEnable2_value
    Private flag_IntEnable2
    Private write_Timer2Pre_value
    Private read_Timer2Pre_value
    Private flag_Timer2Pre
    Private write_OneShot_Timer2_value
    Private read_OneShot_Timer2_value
    Private flag_OneShot_Timer2

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

    Property Get get_Timer2En
        get_Timer2En = read_Timer2En_value
    End Property

    Property Let set_Timer2En(aData)
        write_Timer2En_value = aData
        flag_Timer2En        = &H1
    End Property

    Property Get read_Timer2En
        read
        read_Timer2En = read_Timer2En_value
    End Property

    Property Let write_Timer2En(aData)
        set_Timer2En = aData
        write
    End Property

    Property Get get_Timer2Mode
        get_Timer2Mode = read_Timer2Mode_value
    End Property

    Property Let set_Timer2Mode(aData)
        write_Timer2Mode_value = aData
        flag_Timer2Mode        = &H1
    End Property

    Property Get read_Timer2Mode
        read
        read_Timer2Mode = read_Timer2Mode_value
    End Property

    Property Let write_Timer2Mode(aData)
        set_Timer2Mode = aData
        write
    End Property

    Property Get get_IntEnable2
        get_IntEnable2 = read_IntEnable2_value
    End Property

    Property Let set_IntEnable2(aData)
        write_IntEnable2_value = aData
        flag_IntEnable2        = &H1
    End Property

    Property Get read_IntEnable2
        read
        read_IntEnable2 = read_IntEnable2_value
    End Property

    Property Let write_IntEnable2(aData)
        set_IntEnable2 = aData
        write
    End Property

    Property Get get_Timer2Pre
        get_Timer2Pre = read_Timer2Pre_value
    End Property

    Property Let set_Timer2Pre(aData)
        write_Timer2Pre_value = aData
        flag_Timer2Pre        = &H1
    End Property

    Property Get read_Timer2Pre
        read
        read_Timer2Pre = read_Timer2Pre_value
    End Property

    Property Let write_Timer2Pre(aData)
        set_Timer2Pre = aData
        write
    End Property

    Property Get get_OneShot_Timer2
        get_OneShot_Timer2 = read_OneShot_Timer2_value
    End Property

    Property Let set_OneShot_Timer2(aData)
        write_OneShot_Timer2_value = aData
        flag_OneShot_Timer2        = &H1
    End Property

    Property Get read_OneShot_Timer2
        read
        read_OneShot_Timer2 = read_OneShot_Timer2_value
    End Property

    Property Let write_OneShot_Timer2(aData)
        set_OneShot_Timer2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Timer2En_value = rightShift(data_low, 7) and &H1
        read_Timer2Mode_value = rightShift(data_low, 6) and &H1
        read_IntEnable2_value = rightShift(data_low, 5) and &H1
        read_Timer2Pre_value = rightShift(data_low, 2) and &H3
        OneShot_Timer2_mask = &H1
        if data_low > LONG_MAX then
            if OneShot_Timer2_mask = mask then
                read_OneShot_Timer2_value = data_low
            else
                read_OneShot_Timer2_value = (data_low - H8000_0000) and OneShot_Timer2_mask
            end If
        else
            read_OneShot_Timer2_value = data_low and OneShot_Timer2_mask
        end If

    End Sub

    Sub write
        If flag_Timer2En = &H0 or flag_Timer2Mode = &H0 or flag_IntEnable2 = &H0 or flag_Timer2Pre = &H0 or flag_OneShot_Timer2 = &H0 Then read
        If flag_Timer2En = &H0 Then write_Timer2En_value = get_Timer2En
        If flag_Timer2Mode = &H0 Then write_Timer2Mode_value = get_Timer2Mode
        If flag_IntEnable2 = &H0 Then write_IntEnable2_value = get_IntEnable2
        If flag_Timer2Pre = &H0 Then write_Timer2Pre_value = get_Timer2Pre
        If flag_OneShot_Timer2 = &H0 Then write_OneShot_Timer2_value = get_OneShot_Timer2

        regValue = leftShift((write_Timer2En_value and &H1), 7) + leftShift((write_Timer2Mode_value and &H1), 6) + leftShift((write_IntEnable2_value and &H1), 5) + leftShift((write_Timer2Pre_value and &H3), 2) + leftShift((write_OneShot_Timer2_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Timer2En_value = rightShift(data_low, 7) and &H1
        read_Timer2Mode_value = rightShift(data_low, 6) and &H1
        read_IntEnable2_value = rightShift(data_low, 5) and &H1
        read_Timer2Pre_value = rightShift(data_low, 2) and &H3
        OneShot_Timer2_mask = &H1
        if data_low > LONG_MAX then
            if OneShot_Timer2_mask = mask then
                read_OneShot_Timer2_value = data_low
            else
                read_OneShot_Timer2_value = (data_low - H8000_0000) and OneShot_Timer2_mask
            end If
        else
            read_OneShot_Timer2_value = data_low and OneShot_Timer2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Timer2En_value = &H0
        flag_Timer2En        = &H0
        write_Timer2Mode_value = &H0
        flag_Timer2Mode        = &H0
        write_IntEnable2_value = &H0
        flag_IntEnable2        = &H0
        write_Timer2Pre_value = &H0
        flag_Timer2Pre        = &H0
        write_OneShot_Timer2_value = &H0
        flag_OneShot_Timer2        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2intclr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER2INTCLR                               [0:0]            get_TIMER2INTCLR
''                                                             set_TIMER2INTCLR
''                                                             read_TIMER2INTCLR
''                                                             write_TIMER2INTCLR
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2intclr
    Private write_TIMER2INTCLR_value
    Private read_TIMER2INTCLR_value
    Private flag_TIMER2INTCLR

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

    Property Get get_TIMER2INTCLR
        get_TIMER2INTCLR = read_TIMER2INTCLR_value
    End Property

    Property Let set_TIMER2INTCLR(aData)
        write_TIMER2INTCLR_value = aData
        flag_TIMER2INTCLR        = &H1
    End Property

    Property Get read_TIMER2INTCLR
        read
        read_TIMER2INTCLR = read_TIMER2INTCLR_value
    End Property

    Property Let write_TIMER2INTCLR(aData)
        set_TIMER2INTCLR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2INTCLR_mask = &H1
        if data_low > LONG_MAX then
            if TIMER2INTCLR_mask = mask then
                read_TIMER2INTCLR_value = data_low
            else
                read_TIMER2INTCLR_value = (data_low - H8000_0000) and TIMER2INTCLR_mask
            end If
        else
            read_TIMER2INTCLR_value = data_low and TIMER2INTCLR_mask
        end If

    End Sub

    Sub write
        If flag_TIMER2INTCLR = &H0 Then read
        If flag_TIMER2INTCLR = &H0 Then write_TIMER2INTCLR_value = get_TIMER2INTCLR

        regValue = leftShift((write_TIMER2INTCLR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2INTCLR_mask = &H1
        if data_low > LONG_MAX then
            if TIMER2INTCLR_mask = mask then
                read_TIMER2INTCLR_value = data_low
            else
                read_TIMER2INTCLR_value = (data_low - H8000_0000) and TIMER2INTCLR_mask
            end If
        else
            read_TIMER2INTCLR_value = data_low and TIMER2INTCLR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER2INTCLR_value = &H0
        flag_TIMER2INTCLR        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2ris
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Timer2RIS                                  [0:0]            get_Timer2RIS
''                                                             set_Timer2RIS
''                                                             read_Timer2RIS
''                                                             write_Timer2RIS
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2ris
    Private write_Timer2RIS_value
    Private read_Timer2RIS_value
    Private flag_Timer2RIS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H58
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Timer2RIS
        get_Timer2RIS = read_Timer2RIS_value
    End Property

    Property Let set_Timer2RIS(aData)
        write_Timer2RIS_value = aData
        flag_Timer2RIS        = &H1
    End Property

    Property Get read_Timer2RIS
        read
        read_Timer2RIS = read_Timer2RIS_value
    End Property

    Property Let write_Timer2RIS(aData)
        set_Timer2RIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer2RIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer2RIS_mask = mask then
                read_Timer2RIS_value = data_low
            else
                read_Timer2RIS_value = (data_low - H8000_0000) and Timer2RIS_mask
            end If
        else
            read_Timer2RIS_value = data_low and Timer2RIS_mask
        end If

    End Sub

    Sub write
        If flag_Timer2RIS = &H0 Then read
        If flag_Timer2RIS = &H0 Then write_Timer2RIS_value = get_Timer2RIS

        regValue = leftShift((write_Timer2RIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer2RIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer2RIS_mask = mask then
                read_Timer2RIS_value = data_low
            else
                read_Timer2RIS_value = (data_low - H8000_0000) and Timer2RIS_mask
            end If
        else
            read_Timer2RIS_value = data_low and Timer2RIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Timer2RIS_value = &H0
        flag_Timer2RIS        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2mis
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Timer2MIS                                  [0:0]            get_Timer2MIS
''                                                             set_Timer2MIS
''                                                             read_Timer2MIS
''                                                             write_Timer2MIS
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2mis
    Private write_Timer2MIS_value
    Private read_Timer2MIS_value
    Private flag_Timer2MIS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Timer2MIS
        get_Timer2MIS = read_Timer2MIS_value
    End Property

    Property Let set_Timer2MIS(aData)
        write_Timer2MIS_value = aData
        flag_Timer2MIS        = &H1
    End Property

    Property Get read_Timer2MIS
        read
        read_Timer2MIS = read_Timer2MIS_value
    End Property

    Property Let write_Timer2MIS(aData)
        set_Timer2MIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer2MIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer2MIS_mask = mask then
                read_Timer2MIS_value = data_low
            else
                read_Timer2MIS_value = (data_low - H8000_0000) and Timer2MIS_mask
            end If
        else
            read_Timer2MIS_value = data_low and Timer2MIS_mask
        end If

    End Sub

    Sub write
        If flag_Timer2MIS = &H0 Then read
        If flag_Timer2MIS = &H0 Then write_Timer2MIS_value = get_Timer2MIS

        regValue = leftShift((write_Timer2MIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Timer2MIS_mask = &H1
        if data_low > LONG_MAX then
            if Timer2MIS_mask = mask then
                read_Timer2MIS_value = data_low
            else
                read_Timer2MIS_value = (data_low - H8000_0000) and Timer2MIS_mask
            end If
        else
            read_Timer2MIS_value = data_low and Timer2MIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Timer2MIS_value = &H0
        flag_Timer2MIS        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2bgloadmsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER2BGLoad_MSB                           [31:0]           get_TIMER2BGLoad_MSB
''                                                             set_TIMER2BGLoad_MSB
''                                                             read_TIMER2BGLoad_MSB
''                                                             write_TIMER2BGLoad_MSB
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2bgloadmsb
    Private write_TIMER2BGLoad_MSB_value
    Private read_TIMER2BGLoad_MSB_value
    Private flag_TIMER2BGLoad_MSB

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

    Property Get get_TIMER2BGLoad_MSB
        get_TIMER2BGLoad_MSB = read_TIMER2BGLoad_MSB_value
    End Property

    Property Let set_TIMER2BGLoad_MSB(aData)
        write_TIMER2BGLoad_MSB_value = aData
        flag_TIMER2BGLoad_MSB        = &H1
    End Property

    Property Get read_TIMER2BGLoad_MSB
        read
        read_TIMER2BGLoad_MSB = read_TIMER2BGLoad_MSB_value
    End Property

    Property Let write_TIMER2BGLoad_MSB(aData)
        set_TIMER2BGLoad_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2BGLoad_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2BGLoad_MSB_mask = mask then
                read_TIMER2BGLoad_MSB_value = data_low
            else
                read_TIMER2BGLoad_MSB_value = (data_low - H8000_0000) and TIMER2BGLoad_MSB_mask
            end If
        else
            read_TIMER2BGLoad_MSB_value = data_low and TIMER2BGLoad_MSB_mask
        end If

    End Sub

    Sub write
        If flag_TIMER2BGLoad_MSB = &H0 Then read
        If flag_TIMER2BGLoad_MSB = &H0 Then write_TIMER2BGLoad_MSB_value = get_TIMER2BGLoad_MSB

        regValue = leftShift(write_TIMER2BGLoad_MSB_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2BGLoad_MSB_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2BGLoad_MSB_mask = mask then
                read_TIMER2BGLoad_MSB_value = data_low
            else
                read_TIMER2BGLoad_MSB_value = (data_low - H8000_0000) and TIMER2BGLoad_MSB_mask
            end If
        else
            read_TIMER2BGLoad_MSB_value = data_low and TIMER2BGLoad_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER2BGLoad_MSB_value = &H0
        flag_TIMER2BGLoad_MSB        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timer2bgload
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMER2BGLoad                               [31:0]           get_TIMER2BGLoad
''                                                             set_TIMER2BGLoad
''                                                             read_TIMER2BGLoad
''                                                             write_TIMER2BGLoad
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timer2bgload
    Private write_TIMER2BGLoad_value
    Private read_TIMER2BGLoad_value
    Private flag_TIMER2BGLoad

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H64
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TIMER2BGLoad
        get_TIMER2BGLoad = read_TIMER2BGLoad_value
    End Property

    Property Let set_TIMER2BGLoad(aData)
        write_TIMER2BGLoad_value = aData
        flag_TIMER2BGLoad        = &H1
    End Property

    Property Get read_TIMER2BGLoad
        read
        read_TIMER2BGLoad = read_TIMER2BGLoad_value
    End Property

    Property Let write_TIMER2BGLoad(aData)
        set_TIMER2BGLoad = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2BGLoad_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2BGLoad_mask = mask then
                read_TIMER2BGLoad_value = data_low
            else
                read_TIMER2BGLoad_value = (data_low - H8000_0000) and TIMER2BGLoad_mask
            end If
        else
            read_TIMER2BGLoad_value = data_low and TIMER2BGLoad_mask
        end If

    End Sub

    Sub write
        If flag_TIMER2BGLoad = &H0 Then read
        If flag_TIMER2BGLoad = &H0 Then write_TIMER2BGLoad_value = get_TIMER2BGLoad

        regValue = leftShift(write_TIMER2BGLoad_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIMER2BGLoad_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TIMER2BGLoad_mask = mask then
                read_TIMER2BGLoad_value = data_low
            else
                read_TIMER2BGLoad_value = (data_low - H8000_0000) and TIMER2BGLoad_mask
            end If
        else
            read_TIMER2BGLoad_value = data_low and TIMER2BGLoad_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMER2BGLoad_value = &H0
        flag_TIMER2BGLoad        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timeritcr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ITEN                                       [0:0]            get_ITEN
''                                                             set_ITEN
''                                                             read_ITEN
''                                                             write_ITEN
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timeritcr
    Private write_ITEN_value
    Private read_ITEN_value
    Private flag_ITEN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ITEN
        get_ITEN = read_ITEN_value
    End Property

    Property Let set_ITEN(aData)
        write_ITEN_value = aData
        flag_ITEN        = &H1
    End Property

    Property Get read_ITEN
        read
        read_ITEN = read_ITEN_value
    End Property

    Property Let write_ITEN(aData)
        set_ITEN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ITEN_mask = &H1
        if data_low > LONG_MAX then
            if ITEN_mask = mask then
                read_ITEN_value = data_low
            else
                read_ITEN_value = (data_low - H8000_0000) and ITEN_mask
            end If
        else
            read_ITEN_value = data_low and ITEN_mask
        end If

    End Sub

    Sub write
        If flag_ITEN = &H0 Then read
        If flag_ITEN = &H0 Then write_ITEN_value = get_ITEN

        regValue = leftShift((write_ITEN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ITEN_mask = &H1
        if data_low > LONG_MAX then
            if ITEN_mask = mask then
                read_ITEN_value = data_low
            else
                read_ITEN_value = (data_low - H8000_0000) and ITEN_mask
            end If
        else
            read_ITEN_value = data_low and ITEN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ITEN_value = &H0
        flag_ITEN        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timeritop
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIMINT2                                    [1:1]            get_TIMINT2
''                                                             set_TIMINT2
''                                                             read_TIMINT2
''                                                             write_TIMINT2
''---------------------------------------------------------------------------------
'' TIMINT1                                    [0:0]            get_TIMINT1
''                                                             set_TIMINT1
''                                                             read_TIMINT1
''                                                             write_TIMINT1
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timeritop
    Private write_TIMINT2_value
    Private read_TIMINT2_value
    Private flag_TIMINT2
    Private write_TIMINT1_value
    Private read_TIMINT1_value
    Private flag_TIMINT1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TIMINT2
        get_TIMINT2 = read_TIMINT2_value
    End Property

    Property Let set_TIMINT2(aData)
        write_TIMINT2_value = aData
        flag_TIMINT2        = &H1
    End Property

    Property Get read_TIMINT2
        read
        read_TIMINT2 = read_TIMINT2_value
    End Property

    Property Let write_TIMINT2(aData)
        set_TIMINT2 = aData
        write
    End Property

    Property Get get_TIMINT1
        get_TIMINT1 = read_TIMINT1_value
    End Property

    Property Let set_TIMINT1(aData)
        write_TIMINT1_value = aData
        flag_TIMINT1        = &H1
    End Property

    Property Get read_TIMINT1
        read
        read_TIMINT1 = read_TIMINT1_value
    End Property

    Property Let write_TIMINT1(aData)
        set_TIMINT1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TIMINT2_value = rightShift(data_low, 1) and &H1
        TIMINT1_mask = &H1
        if data_low > LONG_MAX then
            if TIMINT1_mask = mask then
                read_TIMINT1_value = data_low
            else
                read_TIMINT1_value = (data_low - H8000_0000) and TIMINT1_mask
            end If
        else
            read_TIMINT1_value = data_low and TIMINT1_mask
        end If

    End Sub

    Sub write
        If flag_TIMINT2 = &H0 or flag_TIMINT1 = &H0 Then read
        If flag_TIMINT2 = &H0 Then write_TIMINT2_value = get_TIMINT2
        If flag_TIMINT1 = &H0 Then write_TIMINT1_value = get_TIMINT1

        regValue = leftShift((write_TIMINT2_value and &H1), 1) + leftShift((write_TIMINT1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TIMINT2_value = rightShift(data_low, 1) and &H1
        TIMINT1_mask = &H1
        if data_low > LONG_MAX then
            if TIMINT1_mask = mask then
                read_TIMINT1_value = data_low
            else
                read_TIMINT1_value = (data_low - H8000_0000) and TIMINT1_mask
            end If
        else
            read_TIMINT1_value = data_low and TIMINT1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIMINT2_value = &H0
        flag_TIMINT2        = &H0
        write_TIMINT1_value = &H0
        flag_TIMINT1        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerperiphid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PartNumber0                                [7:0]            get_PartNumber0
''                                                             set_PartNumber0
''                                                             read_PartNumber0
''                                                             write_PartNumber0
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerperiphid0
    Private write_PartNumber0_value
    Private read_PartNumber0_value
    Private flag_PartNumber0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PartNumber0
        get_PartNumber0 = read_PartNumber0_value
    End Property

    Property Let set_PartNumber0(aData)
        write_PartNumber0_value = aData
        flag_PartNumber0        = &H1
    End Property

    Property Get read_PartNumber0
        read
        read_PartNumber0 = read_PartNumber0_value
    End Property

    Property Let write_PartNumber0(aData)
        set_PartNumber0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PartNumber0_mask = &Hff
        if data_low > LONG_MAX then
            if PartNumber0_mask = mask then
                read_PartNumber0_value = data_low
            else
                read_PartNumber0_value = (data_low - H8000_0000) and PartNumber0_mask
            end If
        else
            read_PartNumber0_value = data_low and PartNumber0_mask
        end If

    End Sub

    Sub write
        If flag_PartNumber0 = &H0 Then read
        If flag_PartNumber0 = &H0 Then write_PartNumber0_value = get_PartNumber0

        regValue = leftShift((write_PartNumber0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PartNumber0_mask = &Hff
        if data_low > LONG_MAX then
            if PartNumber0_mask = mask then
                read_PartNumber0_value = data_low
            else
                read_PartNumber0_value = (data_low - H8000_0000) and PartNumber0_mask
            end If
        else
            read_PartNumber0_value = data_low and PartNumber0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PartNumber0_value = &H0
        flag_PartNumber0        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerperiphid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Designer0                                  [7:4]            get_Designer0
''                                                             set_Designer0
''                                                             read_Designer0
''                                                             write_Designer0
''---------------------------------------------------------------------------------
'' PartNumber1                                [3:0]            get_PartNumber1
''                                                             set_PartNumber1
''                                                             read_PartNumber1
''                                                             write_PartNumber1
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerperiphid1
    Private write_Designer0_value
    Private read_Designer0_value
    Private flag_Designer0
    Private write_PartNumber1_value
    Private read_PartNumber1_value
    Private flag_PartNumber1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Designer0
        get_Designer0 = read_Designer0_value
    End Property

    Property Let set_Designer0(aData)
        write_Designer0_value = aData
        flag_Designer0        = &H1
    End Property

    Property Get read_Designer0
        read
        read_Designer0 = read_Designer0_value
    End Property

    Property Let write_Designer0(aData)
        set_Designer0 = aData
        write
    End Property

    Property Get get_PartNumber1
        get_PartNumber1 = read_PartNumber1_value
    End Property

    Property Let set_PartNumber1(aData)
        write_PartNumber1_value = aData
        flag_PartNumber1        = &H1
    End Property

    Property Get read_PartNumber1
        read
        read_PartNumber1 = read_PartNumber1_value
    End Property

    Property Let write_PartNumber1(aData)
        set_PartNumber1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        PartNumber1_mask = &Hf
        if data_low > LONG_MAX then
            if PartNumber1_mask = mask then
                read_PartNumber1_value = data_low
            else
                read_PartNumber1_value = (data_low - H8000_0000) and PartNumber1_mask
            end If
        else
            read_PartNumber1_value = data_low and PartNumber1_mask
        end If

    End Sub

    Sub write
        If flag_Designer0 = &H0 or flag_PartNumber1 = &H0 Then read
        If flag_Designer0 = &H0 Then write_Designer0_value = get_Designer0
        If flag_PartNumber1 = &H0 Then write_PartNumber1_value = get_PartNumber1

        regValue = leftShift((write_Designer0_value and &Hf), 4) + leftShift((write_PartNumber1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        PartNumber1_mask = &Hf
        if data_low > LONG_MAX then
            if PartNumber1_mask = mask then
                read_PartNumber1_value = data_low
            else
                read_PartNumber1_value = (data_low - H8000_0000) and PartNumber1_mask
            end If
        else
            read_PartNumber1_value = data_low and PartNumber1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Designer0_value = &H0
        flag_Designer0        = &H0
        write_PartNumber1_value = &H0
        flag_PartNumber1        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerperiphid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Revision                                   [7:4]            get_Revision
''                                                             set_Revision
''                                                             read_Revision
''                                                             write_Revision
''---------------------------------------------------------------------------------
'' Designer1                                  [3:0]            get_Designer1
''                                                             set_Designer1
''                                                             read_Designer1
''                                                             write_Designer1
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerperiphid2
    Private write_Revision_value
    Private read_Revision_value
    Private flag_Revision
    Private write_Designer1_value
    Private read_Designer1_value
    Private flag_Designer1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Revision
        get_Revision = read_Revision_value
    End Property

    Property Let set_Revision(aData)
        write_Revision_value = aData
        flag_Revision        = &H1
    End Property

    Property Get read_Revision
        read
        read_Revision = read_Revision_value
    End Property

    Property Let write_Revision(aData)
        set_Revision = aData
        write
    End Property

    Property Get get_Designer1
        get_Designer1 = read_Designer1_value
    End Property

    Property Let set_Designer1(aData)
        write_Designer1_value = aData
        flag_Designer1        = &H1
    End Property

    Property Get read_Designer1
        read
        read_Designer1 = read_Designer1_value
    End Property

    Property Let write_Designer1(aData)
        set_Designer1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

    End Sub

    Sub write
        If flag_Revision = &H0 or flag_Designer1 = &H0 Then read
        If flag_Revision = &H0 Then write_Revision_value = get_Revision
        If flag_Designer1 = &H0 Then write_Designer1_value = get_Designer1

        regValue = leftShift((write_Revision_value and &Hf), 4) + leftShift((write_Designer1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Revision_value = &H0
        flag_Revision        = &H0
        write_Designer1_value = &H0
        flag_Designer1        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerperiphid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Configuration                              [7:0]            get_Configuration
''                                                             set_Configuration
''                                                             read_Configuration
''                                                             write_Configuration
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerperiphid3
    Private write_Configuration_value
    Private read_Configuration_value
    Private flag_Configuration

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Configuration
        get_Configuration = read_Configuration_value
    End Property

    Property Let set_Configuration(aData)
        write_Configuration_value = aData
        flag_Configuration        = &H1
    End Property

    Property Get read_Configuration
        read
        read_Configuration = read_Configuration_value
    End Property

    Property Let write_Configuration(aData)
        set_Configuration = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

    End Sub

    Sub write
        If flag_Configuration = &H0 Then read
        If flag_Configuration = &H0 Then write_Configuration_value = get_Configuration

        regValue = leftShift((write_Configuration_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Configuration_value = &H0
        flag_Configuration        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerpcellid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TimerPCellID0                              [7:0]            get_TimerPCellID0
''                                                             set_TimerPCellID0
''                                                             read_TimerPCellID0
''                                                             write_TimerPCellID0
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerpcellid0
    Private write_TimerPCellID0_value
    Private read_TimerPCellID0_value
    Private flag_TimerPCellID0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TimerPCellID0
        get_TimerPCellID0 = read_TimerPCellID0_value
    End Property

    Property Let set_TimerPCellID0(aData)
        write_TimerPCellID0_value = aData
        flag_TimerPCellID0        = &H1
    End Property

    Property Get read_TimerPCellID0
        read
        read_TimerPCellID0 = read_TimerPCellID0_value
    End Property

    Property Let write_TimerPCellID0(aData)
        set_TimerPCellID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID0_mask = mask then
                read_TimerPCellID0_value = data_low
            else
                read_TimerPCellID0_value = (data_low - H8000_0000) and TimerPCellID0_mask
            end If
        else
            read_TimerPCellID0_value = data_low and TimerPCellID0_mask
        end If

    End Sub

    Sub write
        If flag_TimerPCellID0 = &H0 Then read
        If flag_TimerPCellID0 = &H0 Then write_TimerPCellID0_value = get_TimerPCellID0

        regValue = leftShift((write_TimerPCellID0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID0_mask = mask then
                read_TimerPCellID0_value = data_low
            else
                read_TimerPCellID0_value = (data_low - H8000_0000) and TimerPCellID0_mask
            end If
        else
            read_TimerPCellID0_value = data_low and TimerPCellID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TimerPCellID0_value = &H0
        flag_TimerPCellID0        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerpcellid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TimerPCellID1                              [7:0]            get_TimerPCellID1
''                                                             set_TimerPCellID1
''                                                             read_TimerPCellID1
''                                                             write_TimerPCellID1
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerpcellid1
    Private write_TimerPCellID1_value
    Private read_TimerPCellID1_value
    Private flag_TimerPCellID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TimerPCellID1
        get_TimerPCellID1 = read_TimerPCellID1_value
    End Property

    Property Let set_TimerPCellID1(aData)
        write_TimerPCellID1_value = aData
        flag_TimerPCellID1        = &H1
    End Property

    Property Get read_TimerPCellID1
        read
        read_TimerPCellID1 = read_TimerPCellID1_value
    End Property

    Property Let write_TimerPCellID1(aData)
        set_TimerPCellID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID1_mask = mask then
                read_TimerPCellID1_value = data_low
            else
                read_TimerPCellID1_value = (data_low - H8000_0000) and TimerPCellID1_mask
            end If
        else
            read_TimerPCellID1_value = data_low and TimerPCellID1_mask
        end If

    End Sub

    Sub write
        If flag_TimerPCellID1 = &H0 Then read
        If flag_TimerPCellID1 = &H0 Then write_TimerPCellID1_value = get_TimerPCellID1

        regValue = leftShift((write_TimerPCellID1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID1_mask = mask then
                read_TimerPCellID1_value = data_low
            else
                read_TimerPCellID1_value = (data_low - H8000_0000) and TimerPCellID1_mask
            end If
        else
            read_TimerPCellID1_value = data_low and TimerPCellID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TimerPCellID1_value = &H0
        flag_TimerPCellID1        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerpcellid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TimerPCellID2                              [7:0]            get_TimerPCellID2
''                                                             set_TimerPCellID2
''                                                             read_TimerPCellID2
''                                                             write_TimerPCellID2
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerpcellid2
    Private write_TimerPCellID2_value
    Private read_TimerPCellID2_value
    Private flag_TimerPCellID2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TimerPCellID2
        get_TimerPCellID2 = read_TimerPCellID2_value
    End Property

    Property Let set_TimerPCellID2(aData)
        write_TimerPCellID2_value = aData
        flag_TimerPCellID2        = &H1
    End Property

    Property Get read_TimerPCellID2
        read
        read_TimerPCellID2 = read_TimerPCellID2_value
    End Property

    Property Let write_TimerPCellID2(aData)
        set_TimerPCellID2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID2_mask = mask then
                read_TimerPCellID2_value = data_low
            else
                read_TimerPCellID2_value = (data_low - H8000_0000) and TimerPCellID2_mask
            end If
        else
            read_TimerPCellID2_value = data_low and TimerPCellID2_mask
        end If

    End Sub

    Sub write
        If flag_TimerPCellID2 = &H0 Then read
        If flag_TimerPCellID2 = &H0 Then write_TimerPCellID2_value = get_TimerPCellID2

        regValue = leftShift((write_TimerPCellID2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID2_mask = mask then
                read_TimerPCellID2_value = data_low
            else
                read_TimerPCellID2_value = (data_low - H8000_0000) and TimerPCellID2_mask
            end If
        else
            read_TimerPCellID2_value = data_low and TimerPCellID2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TimerPCellID2_value = &H0
        flag_TimerPCellID2        = &H0
    End Sub
End Class


'' @REGISTER : TIM64_timerpcellid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TimerPCellID3                              [7:0]            get_TimerPCellID3
''                                                             set_TimerPCellID3
''                                                             read_TimerPCellID3
''                                                             write_TimerPCellID3
''---------------------------------------------------------------------------------
Class REGISTER_TIM64_timerpcellid3
    Private write_TimerPCellID3_value
    Private read_TimerPCellID3_value
    Private flag_TimerPCellID3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TimerPCellID3
        get_TimerPCellID3 = read_TimerPCellID3_value
    End Property

    Property Let set_TimerPCellID3(aData)
        write_TimerPCellID3_value = aData
        flag_TimerPCellID3        = &H1
    End Property

    Property Get read_TimerPCellID3
        read
        read_TimerPCellID3 = read_TimerPCellID3_value
    End Property

    Property Let write_TimerPCellID3(aData)
        set_TimerPCellID3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID3_mask = mask then
                read_TimerPCellID3_value = data_low
            else
                read_TimerPCellID3_value = (data_low - H8000_0000) and TimerPCellID3_mask
            end If
        else
            read_TimerPCellID3_value = data_low and TimerPCellID3_mask
        end If

    End Sub

    Sub write
        If flag_TimerPCellID3 = &H0 Then read
        If flag_TimerPCellID3 = &H0 Then write_TimerPCellID3_value = get_TimerPCellID3

        regValue = leftShift((write_TimerPCellID3_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TimerPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if TimerPCellID3_mask = mask then
                read_TimerPCellID3_value = data_low
            else
                read_TimerPCellID3_value = (data_low - H8000_0000) and TimerPCellID3_mask
            end If
        else
            read_TimerPCellID3_value = data_low and TimerPCellID3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TimerPCellID3_value = &H0
        flag_TimerPCellID3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class TIM64_INSTANCE

    Public timer1loadmsb
    Public timer1load
    Public timer1valuemsb
    Public timer1value
    Public timer1control
    Public timer1intclr
    Public timer1ris
    Public timer1mis
    Public timer1bgloadmsb
    Public timer1bgload
    Public timer2loadmsb
    Public timer2load
    Public timer2valuemsb
    Public timer2value
    Public timer2control
    Public timer2intclr
    Public timer2ris
    Public timer2mis
    Public timer2bgloadmsb
    Public timer2bgload
    Public timeritcr
    Public timeritop
    Public timerperiphid0
    Public timerperiphid1
    Public timerperiphid2
    Public timerperiphid3
    Public timerpcellid0
    Public timerpcellid1
    Public timerpcellid2
    Public timerpcellid3


    Public default function Init(aBaseAddr)
        Set timer1loadmsb = (New REGISTER_TIM64_timer1loadmsb)(aBaseAddr, 32)
        Set timer1load = (New REGISTER_TIM64_timer1load)(aBaseAddr, 32)
        Set timer1valuemsb = (New REGISTER_TIM64_timer1valuemsb)(aBaseAddr, 32)
        Set timer1value = (New REGISTER_TIM64_timer1value)(aBaseAddr, 32)
        Set timer1control = (New REGISTER_TIM64_timer1control)(aBaseAddr, 32)
        Set timer1intclr = (New REGISTER_TIM64_timer1intclr)(aBaseAddr, 32)
        Set timer1ris = (New REGISTER_TIM64_timer1ris)(aBaseAddr, 32)
        Set timer1mis = (New REGISTER_TIM64_timer1mis)(aBaseAddr, 32)
        Set timer1bgloadmsb = (New REGISTER_TIM64_timer1bgloadmsb)(aBaseAddr, 32)
        Set timer1bgload = (New REGISTER_TIM64_timer1bgload)(aBaseAddr, 32)
        Set timer2loadmsb = (New REGISTER_TIM64_timer2loadmsb)(aBaseAddr, 32)
        Set timer2load = (New REGISTER_TIM64_timer2load)(aBaseAddr, 32)
        Set timer2valuemsb = (New REGISTER_TIM64_timer2valuemsb)(aBaseAddr, 32)
        Set timer2value = (New REGISTER_TIM64_timer2value)(aBaseAddr, 32)
        Set timer2control = (New REGISTER_TIM64_timer2control)(aBaseAddr, 32)
        Set timer2intclr = (New REGISTER_TIM64_timer2intclr)(aBaseAddr, 32)
        Set timer2ris = (New REGISTER_TIM64_timer2ris)(aBaseAddr, 32)
        Set timer2mis = (New REGISTER_TIM64_timer2mis)(aBaseAddr, 32)
        Set timer2bgloadmsb = (New REGISTER_TIM64_timer2bgloadmsb)(aBaseAddr, 32)
        Set timer2bgload = (New REGISTER_TIM64_timer2bgload)(aBaseAddr, 32)
        Set timeritcr = (New REGISTER_TIM64_timeritcr)(aBaseAddr, 32)
        Set timeritop = (New REGISTER_TIM64_timeritop)(aBaseAddr, 32)
        Set timerperiphid0 = (New REGISTER_TIM64_timerperiphid0)(aBaseAddr, 32)
        Set timerperiphid1 = (New REGISTER_TIM64_timerperiphid1)(aBaseAddr, 32)
        Set timerperiphid2 = (New REGISTER_TIM64_timerperiphid2)(aBaseAddr, 32)
        Set timerperiphid3 = (New REGISTER_TIM64_timerperiphid3)(aBaseAddr, 32)
        Set timerpcellid0 = (New REGISTER_TIM64_timerpcellid0)(aBaseAddr, 32)
        Set timerpcellid1 = (New REGISTER_TIM64_timerpcellid1)(aBaseAddr, 32)
        Set timerpcellid2 = (New REGISTER_TIM64_timerpcellid2)(aBaseAddr, 32)
        Set timerpcellid3 = (New REGISTER_TIM64_timerpcellid3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TIM64 = CreateObject("System.Collections.ArrayList")
TIM64.Add ((New TIM64_INSTANCE)(&H40142000))
TIM64.Add ((New TIM64_INSTANCE)(&H4c016000))
TIM64.Add ((New TIM64_INSTANCE)(&H4c017000))


