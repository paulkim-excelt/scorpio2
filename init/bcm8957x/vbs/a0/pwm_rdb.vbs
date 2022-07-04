

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


'' @REGISTER : PWM_pwmctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_opendrain                              [18:15]          get_pwm_opendrain
''                                                             set_pwm_opendrain
''                                                             read_pwm_opendrain
''                                                             write_pwm_opendrain
''---------------------------------------------------------------------------------
'' pwm_out_polarity                           [11:8]           get_pwm_out_polarity
''                                                             set_pwm_out_polarity
''                                                             read_pwm_out_polarity
''                                                             write_pwm_out_polarity
''---------------------------------------------------------------------------------
'' pwm_enable                                 [3:0]            get_pwm_enable
''                                                             set_pwm_enable
''                                                             read_pwm_enable
''                                                             write_pwm_enable
''---------------------------------------------------------------------------------
Class REGISTER_PWM_pwmctl
    Private write_pwm_opendrain_value
    Private read_pwm_opendrain_value
    Private flag_pwm_opendrain
    Private write_pwm_out_polarity_value
    Private read_pwm_out_polarity_value
    Private flag_pwm_out_polarity
    Private write_pwm_enable_value
    Private read_pwm_enable_value
    Private flag_pwm_enable

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

    Property Get get_pwm_opendrain
        get_pwm_opendrain = read_pwm_opendrain_value
    End Property

    Property Let set_pwm_opendrain(aData)
        write_pwm_opendrain_value = aData
        flag_pwm_opendrain        = &H1
    End Property

    Property Get read_pwm_opendrain
        read
        read_pwm_opendrain = read_pwm_opendrain_value
    End Property

    Property Let write_pwm_opendrain(aData)
        set_pwm_opendrain = aData
        write
    End Property

    Property Get get_pwm_out_polarity
        get_pwm_out_polarity = read_pwm_out_polarity_value
    End Property

    Property Let set_pwm_out_polarity(aData)
        write_pwm_out_polarity_value = aData
        flag_pwm_out_polarity        = &H1
    End Property

    Property Get read_pwm_out_polarity
        read
        read_pwm_out_polarity = read_pwm_out_polarity_value
    End Property

    Property Let write_pwm_out_polarity(aData)
        set_pwm_out_polarity = aData
        write
    End Property

    Property Get get_pwm_enable
        get_pwm_enable = read_pwm_enable_value
    End Property

    Property Let set_pwm_enable(aData)
        write_pwm_enable_value = aData
        flag_pwm_enable        = &H1
    End Property

    Property Get read_pwm_enable
        read
        read_pwm_enable = read_pwm_enable_value
    End Property

    Property Let write_pwm_enable(aData)
        set_pwm_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwm_opendrain_value = rightShift(data_low, 15) and &Hf
        read_pwm_out_polarity_value = rightShift(data_low, 8) and &Hf
        pwm_enable_mask = &Hf
        if data_low > LONG_MAX then
            if pwm_enable_mask = mask then
                read_pwm_enable_value = data_low
            else
                read_pwm_enable_value = (data_low - H8000_0000) and pwm_enable_mask
            end If
        else
            read_pwm_enable_value = data_low and pwm_enable_mask
        end If

    End Sub

    Sub write
        If flag_pwm_opendrain = &H0 or flag_pwm_out_polarity = &H0 or flag_pwm_enable = &H0 Then read
        If flag_pwm_opendrain = &H0 Then write_pwm_opendrain_value = get_pwm_opendrain
        If flag_pwm_out_polarity = &H0 Then write_pwm_out_polarity_value = get_pwm_out_polarity
        If flag_pwm_enable = &H0 Then write_pwm_enable_value = get_pwm_enable

        regValue = leftShift((write_pwm_opendrain_value and &Hf), 15) + leftShift((write_pwm_out_polarity_value and &Hf), 8) + leftShift((write_pwm_enable_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwm_opendrain_value = rightShift(data_low, 15) and &Hf
        read_pwm_out_polarity_value = rightShift(data_low, 8) and &Hf
        pwm_enable_mask = &Hf
        if data_low > LONG_MAX then
            if pwm_enable_mask = mask then
                read_pwm_enable_value = data_low
            else
                read_pwm_enable_value = (data_low - H8000_0000) and pwm_enable_mask
            end If
        else
            read_pwm_enable_value = data_low and pwm_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_opendrain_value = &H0
        flag_pwm_opendrain        = &H0
        write_pwm_out_polarity_value = &H0
        flag_pwm_out_polarity        = &H0
        write_pwm_enable_value = &H0
        flag_pwm_enable        = &H0
    End Sub
End Class


'' @REGISTER : PWM_period_cnt_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_period_cnt_0                           [15:0]           get_pwm_period_cnt_0
''                                                             set_pwm_period_cnt_0
''                                                             read_pwm_period_cnt_0
''                                                             write_pwm_period_cnt_0
''---------------------------------------------------------------------------------
Class REGISTER_PWM_period_cnt_0
    Private write_pwm_period_cnt_0_value
    Private read_pwm_period_cnt_0_value
    Private flag_pwm_period_cnt_0

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

    Property Get get_pwm_period_cnt_0
        get_pwm_period_cnt_0 = read_pwm_period_cnt_0_value
    End Property

    Property Let set_pwm_period_cnt_0(aData)
        write_pwm_period_cnt_0_value = aData
        flag_pwm_period_cnt_0        = &H1
    End Property

    Property Get read_pwm_period_cnt_0
        read
        read_pwm_period_cnt_0 = read_pwm_period_cnt_0_value
    End Property

    Property Let write_pwm_period_cnt_0(aData)
        set_pwm_period_cnt_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_0_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_0_mask = mask then
                read_pwm_period_cnt_0_value = data_low
            else
                read_pwm_period_cnt_0_value = (data_low - H8000_0000) and pwm_period_cnt_0_mask
            end If
        else
            read_pwm_period_cnt_0_value = data_low and pwm_period_cnt_0_mask
        end If

    End Sub

    Sub write
        If flag_pwm_period_cnt_0 = &H0 Then read
        If flag_pwm_period_cnt_0 = &H0 Then write_pwm_period_cnt_0_value = get_pwm_period_cnt_0

        regValue = leftShift((write_pwm_period_cnt_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_0_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_0_mask = mask then
                read_pwm_period_cnt_0_value = data_low
            else
                read_pwm_period_cnt_0_value = (data_low - H8000_0000) and pwm_period_cnt_0_mask
            end If
        else
            read_pwm_period_cnt_0_value = data_low and pwm_period_cnt_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_period_cnt_0_value = &H0
        flag_pwm_period_cnt_0        = &H0
    End Sub
End Class


'' @REGISTER : PWM_duty_cnt_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_duty_cnt_0                             [15:0]           get_pwm_duty_cnt_0
''                                                             set_pwm_duty_cnt_0
''                                                             read_pwm_duty_cnt_0
''                                                             write_pwm_duty_cnt_0
''---------------------------------------------------------------------------------
Class REGISTER_PWM_duty_cnt_0
    Private write_pwm_duty_cnt_0_value
    Private read_pwm_duty_cnt_0_value
    Private flag_pwm_duty_cnt_0

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

    Property Get get_pwm_duty_cnt_0
        get_pwm_duty_cnt_0 = read_pwm_duty_cnt_0_value
    End Property

    Property Let set_pwm_duty_cnt_0(aData)
        write_pwm_duty_cnt_0_value = aData
        flag_pwm_duty_cnt_0        = &H1
    End Property

    Property Get read_pwm_duty_cnt_0
        read
        read_pwm_duty_cnt_0 = read_pwm_duty_cnt_0_value
    End Property

    Property Let write_pwm_duty_cnt_0(aData)
        set_pwm_duty_cnt_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_0_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_0_mask = mask then
                read_pwm_duty_cnt_0_value = data_low
            else
                read_pwm_duty_cnt_0_value = (data_low - H8000_0000) and pwm_duty_cnt_0_mask
            end If
        else
            read_pwm_duty_cnt_0_value = data_low and pwm_duty_cnt_0_mask
        end If

    End Sub

    Sub write
        If flag_pwm_duty_cnt_0 = &H0 Then read
        If flag_pwm_duty_cnt_0 = &H0 Then write_pwm_duty_cnt_0_value = get_pwm_duty_cnt_0

        regValue = leftShift((write_pwm_duty_cnt_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_0_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_0_mask = mask then
                read_pwm_duty_cnt_0_value = data_low
            else
                read_pwm_duty_cnt_0_value = (data_low - H8000_0000) and pwm_duty_cnt_0_mask
            end If
        else
            read_pwm_duty_cnt_0_value = data_low and pwm_duty_cnt_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_duty_cnt_0_value = &H0
        flag_pwm_duty_cnt_0        = &H0
    End Sub
End Class


'' @REGISTER : PWM_period_cnt_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_period_cnt_1                           [15:0]           get_pwm_period_cnt_1
''                                                             set_pwm_period_cnt_1
''                                                             read_pwm_period_cnt_1
''                                                             write_pwm_period_cnt_1
''---------------------------------------------------------------------------------
Class REGISTER_PWM_period_cnt_1
    Private write_pwm_period_cnt_1_value
    Private read_pwm_period_cnt_1_value
    Private flag_pwm_period_cnt_1

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

    Property Get get_pwm_period_cnt_1
        get_pwm_period_cnt_1 = read_pwm_period_cnt_1_value
    End Property

    Property Let set_pwm_period_cnt_1(aData)
        write_pwm_period_cnt_1_value = aData
        flag_pwm_period_cnt_1        = &H1
    End Property

    Property Get read_pwm_period_cnt_1
        read
        read_pwm_period_cnt_1 = read_pwm_period_cnt_1_value
    End Property

    Property Let write_pwm_period_cnt_1(aData)
        set_pwm_period_cnt_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_1_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_1_mask = mask then
                read_pwm_period_cnt_1_value = data_low
            else
                read_pwm_period_cnt_1_value = (data_low - H8000_0000) and pwm_period_cnt_1_mask
            end If
        else
            read_pwm_period_cnt_1_value = data_low and pwm_period_cnt_1_mask
        end If

    End Sub

    Sub write
        If flag_pwm_period_cnt_1 = &H0 Then read
        If flag_pwm_period_cnt_1 = &H0 Then write_pwm_period_cnt_1_value = get_pwm_period_cnt_1

        regValue = leftShift((write_pwm_period_cnt_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_1_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_1_mask = mask then
                read_pwm_period_cnt_1_value = data_low
            else
                read_pwm_period_cnt_1_value = (data_low - H8000_0000) and pwm_period_cnt_1_mask
            end If
        else
            read_pwm_period_cnt_1_value = data_low and pwm_period_cnt_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_period_cnt_1_value = &H0
        flag_pwm_period_cnt_1        = &H0
    End Sub
End Class


'' @REGISTER : PWM_duty_cnt_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_duty_cnt_1                             [15:0]           get_pwm_duty_cnt_1
''                                                             set_pwm_duty_cnt_1
''                                                             read_pwm_duty_cnt_1
''                                                             write_pwm_duty_cnt_1
''---------------------------------------------------------------------------------
Class REGISTER_PWM_duty_cnt_1
    Private write_pwm_duty_cnt_1_value
    Private read_pwm_duty_cnt_1_value
    Private flag_pwm_duty_cnt_1

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

    Property Get get_pwm_duty_cnt_1
        get_pwm_duty_cnt_1 = read_pwm_duty_cnt_1_value
    End Property

    Property Let set_pwm_duty_cnt_1(aData)
        write_pwm_duty_cnt_1_value = aData
        flag_pwm_duty_cnt_1        = &H1
    End Property

    Property Get read_pwm_duty_cnt_1
        read
        read_pwm_duty_cnt_1 = read_pwm_duty_cnt_1_value
    End Property

    Property Let write_pwm_duty_cnt_1(aData)
        set_pwm_duty_cnt_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_1_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_1_mask = mask then
                read_pwm_duty_cnt_1_value = data_low
            else
                read_pwm_duty_cnt_1_value = (data_low - H8000_0000) and pwm_duty_cnt_1_mask
            end If
        else
            read_pwm_duty_cnt_1_value = data_low and pwm_duty_cnt_1_mask
        end If

    End Sub

    Sub write
        If flag_pwm_duty_cnt_1 = &H0 Then read
        If flag_pwm_duty_cnt_1 = &H0 Then write_pwm_duty_cnt_1_value = get_pwm_duty_cnt_1

        regValue = leftShift((write_pwm_duty_cnt_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_1_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_1_mask = mask then
                read_pwm_duty_cnt_1_value = data_low
            else
                read_pwm_duty_cnt_1_value = (data_low - H8000_0000) and pwm_duty_cnt_1_mask
            end If
        else
            read_pwm_duty_cnt_1_value = data_low and pwm_duty_cnt_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_duty_cnt_1_value = &H0
        flag_pwm_duty_cnt_1        = &H0
    End Sub
End Class


'' @REGISTER : PWM_period_cnt_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_period_cnt_2                           [15:0]           get_pwm_period_cnt_2
''                                                             set_pwm_period_cnt_2
''                                                             read_pwm_period_cnt_2
''                                                             write_pwm_period_cnt_2
''---------------------------------------------------------------------------------
Class REGISTER_PWM_period_cnt_2
    Private write_pwm_period_cnt_2_value
    Private read_pwm_period_cnt_2_value
    Private flag_pwm_period_cnt_2

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

    Property Get get_pwm_period_cnt_2
        get_pwm_period_cnt_2 = read_pwm_period_cnt_2_value
    End Property

    Property Let set_pwm_period_cnt_2(aData)
        write_pwm_period_cnt_2_value = aData
        flag_pwm_period_cnt_2        = &H1
    End Property

    Property Get read_pwm_period_cnt_2
        read
        read_pwm_period_cnt_2 = read_pwm_period_cnt_2_value
    End Property

    Property Let write_pwm_period_cnt_2(aData)
        set_pwm_period_cnt_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_2_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_2_mask = mask then
                read_pwm_period_cnt_2_value = data_low
            else
                read_pwm_period_cnt_2_value = (data_low - H8000_0000) and pwm_period_cnt_2_mask
            end If
        else
            read_pwm_period_cnt_2_value = data_low and pwm_period_cnt_2_mask
        end If

    End Sub

    Sub write
        If flag_pwm_period_cnt_2 = &H0 Then read
        If flag_pwm_period_cnt_2 = &H0 Then write_pwm_period_cnt_2_value = get_pwm_period_cnt_2

        regValue = leftShift((write_pwm_period_cnt_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_2_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_2_mask = mask then
                read_pwm_period_cnt_2_value = data_low
            else
                read_pwm_period_cnt_2_value = (data_low - H8000_0000) and pwm_period_cnt_2_mask
            end If
        else
            read_pwm_period_cnt_2_value = data_low and pwm_period_cnt_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_period_cnt_2_value = &H0
        flag_pwm_period_cnt_2        = &H0
    End Sub
End Class


'' @REGISTER : PWM_duty_cnt_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_duty_cnt_2                             [15:0]           get_pwm_duty_cnt_2
''                                                             set_pwm_duty_cnt_2
''                                                             read_pwm_duty_cnt_2
''                                                             write_pwm_duty_cnt_2
''---------------------------------------------------------------------------------
Class REGISTER_PWM_duty_cnt_2
    Private write_pwm_duty_cnt_2_value
    Private read_pwm_duty_cnt_2_value
    Private flag_pwm_duty_cnt_2

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

    Property Get get_pwm_duty_cnt_2
        get_pwm_duty_cnt_2 = read_pwm_duty_cnt_2_value
    End Property

    Property Let set_pwm_duty_cnt_2(aData)
        write_pwm_duty_cnt_2_value = aData
        flag_pwm_duty_cnt_2        = &H1
    End Property

    Property Get read_pwm_duty_cnt_2
        read
        read_pwm_duty_cnt_2 = read_pwm_duty_cnt_2_value
    End Property

    Property Let write_pwm_duty_cnt_2(aData)
        set_pwm_duty_cnt_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_2_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_2_mask = mask then
                read_pwm_duty_cnt_2_value = data_low
            else
                read_pwm_duty_cnt_2_value = (data_low - H8000_0000) and pwm_duty_cnt_2_mask
            end If
        else
            read_pwm_duty_cnt_2_value = data_low and pwm_duty_cnt_2_mask
        end If

    End Sub

    Sub write
        If flag_pwm_duty_cnt_2 = &H0 Then read
        If flag_pwm_duty_cnt_2 = &H0 Then write_pwm_duty_cnt_2_value = get_pwm_duty_cnt_2

        regValue = leftShift((write_pwm_duty_cnt_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_2_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_2_mask = mask then
                read_pwm_duty_cnt_2_value = data_low
            else
                read_pwm_duty_cnt_2_value = (data_low - H8000_0000) and pwm_duty_cnt_2_mask
            end If
        else
            read_pwm_duty_cnt_2_value = data_low and pwm_duty_cnt_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_duty_cnt_2_value = &H0
        flag_pwm_duty_cnt_2        = &H0
    End Sub
End Class


'' @REGISTER : PWM_period_cnt_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_period_cnt_3                           [15:0]           get_pwm_period_cnt_3
''                                                             set_pwm_period_cnt_3
''                                                             read_pwm_period_cnt_3
''                                                             write_pwm_period_cnt_3
''---------------------------------------------------------------------------------
Class REGISTER_PWM_period_cnt_3
    Private write_pwm_period_cnt_3_value
    Private read_pwm_period_cnt_3_value
    Private flag_pwm_period_cnt_3

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

    Property Get get_pwm_period_cnt_3
        get_pwm_period_cnt_3 = read_pwm_period_cnt_3_value
    End Property

    Property Let set_pwm_period_cnt_3(aData)
        write_pwm_period_cnt_3_value = aData
        flag_pwm_period_cnt_3        = &H1
    End Property

    Property Get read_pwm_period_cnt_3
        read
        read_pwm_period_cnt_3 = read_pwm_period_cnt_3_value
    End Property

    Property Let write_pwm_period_cnt_3(aData)
        set_pwm_period_cnt_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_3_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_3_mask = mask then
                read_pwm_period_cnt_3_value = data_low
            else
                read_pwm_period_cnt_3_value = (data_low - H8000_0000) and pwm_period_cnt_3_mask
            end If
        else
            read_pwm_period_cnt_3_value = data_low and pwm_period_cnt_3_mask
        end If

    End Sub

    Sub write
        If flag_pwm_period_cnt_3 = &H0 Then read
        If flag_pwm_period_cnt_3 = &H0 Then write_pwm_period_cnt_3_value = get_pwm_period_cnt_3

        regValue = leftShift((write_pwm_period_cnt_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_period_cnt_3_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_period_cnt_3_mask = mask then
                read_pwm_period_cnt_3_value = data_low
            else
                read_pwm_period_cnt_3_value = (data_low - H8000_0000) and pwm_period_cnt_3_mask
            end If
        else
            read_pwm_period_cnt_3_value = data_low and pwm_period_cnt_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_period_cnt_3_value = &H0
        flag_pwm_period_cnt_3        = &H0
    End Sub
End Class


'' @REGISTER : PWM_duty_cnt_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm_duty_cnt_3                             [15:0]           get_pwm_duty_cnt_3
''                                                             set_pwm_duty_cnt_3
''                                                             read_pwm_duty_cnt_3
''                                                             write_pwm_duty_cnt_3
''---------------------------------------------------------------------------------
Class REGISTER_PWM_duty_cnt_3
    Private write_pwm_duty_cnt_3_value
    Private read_pwm_duty_cnt_3_value
    Private flag_pwm_duty_cnt_3

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

    Property Get get_pwm_duty_cnt_3
        get_pwm_duty_cnt_3 = read_pwm_duty_cnt_3_value
    End Property

    Property Let set_pwm_duty_cnt_3(aData)
        write_pwm_duty_cnt_3_value = aData
        flag_pwm_duty_cnt_3        = &H1
    End Property

    Property Get read_pwm_duty_cnt_3
        read
        read_pwm_duty_cnt_3 = read_pwm_duty_cnt_3_value
    End Property

    Property Let write_pwm_duty_cnt_3(aData)
        set_pwm_duty_cnt_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_3_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_3_mask = mask then
                read_pwm_duty_cnt_3_value = data_low
            else
                read_pwm_duty_cnt_3_value = (data_low - H8000_0000) and pwm_duty_cnt_3_mask
            end If
        else
            read_pwm_duty_cnt_3_value = data_low and pwm_duty_cnt_3_mask
        end If

    End Sub

    Sub write
        If flag_pwm_duty_cnt_3 = &H0 Then read
        If flag_pwm_duty_cnt_3 = &H0 Then write_pwm_duty_cnt_3_value = get_pwm_duty_cnt_3

        regValue = leftShift((write_pwm_duty_cnt_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwm_duty_cnt_3_mask = &Hffff
        if data_low > LONG_MAX then
            if pwm_duty_cnt_3_mask = mask then
                read_pwm_duty_cnt_3_value = data_low
            else
                read_pwm_duty_cnt_3_value = (data_low - H8000_0000) and pwm_duty_cnt_3_mask
            end If
        else
            read_pwm_duty_cnt_3_value = data_low and pwm_duty_cnt_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm_duty_cnt_3_value = &H0
        flag_pwm_duty_cnt_3        = &H0
    End Sub
End Class


'' @REGISTER : PWM_prescale
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwm0_prescale                              [23:18]          get_pwm0_prescale
''                                                             set_pwm0_prescale
''                                                             read_pwm0_prescale
''                                                             write_pwm0_prescale
''---------------------------------------------------------------------------------
'' pwm1_prescale                              [17:12]          get_pwm1_prescale
''                                                             set_pwm1_prescale
''                                                             read_pwm1_prescale
''                                                             write_pwm1_prescale
''---------------------------------------------------------------------------------
'' pwm2_prescale                              [11:6]           get_pwm2_prescale
''                                                             set_pwm2_prescale
''                                                             read_pwm2_prescale
''                                                             write_pwm2_prescale
''---------------------------------------------------------------------------------
'' pwm3_prescale                              [5:0]            get_pwm3_prescale
''                                                             set_pwm3_prescale
''                                                             read_pwm3_prescale
''                                                             write_pwm3_prescale
''---------------------------------------------------------------------------------
Class REGISTER_PWM_prescale
    Private write_pwm0_prescale_value
    Private read_pwm0_prescale_value
    Private flag_pwm0_prescale
    Private write_pwm1_prescale_value
    Private read_pwm1_prescale_value
    Private flag_pwm1_prescale
    Private write_pwm2_prescale_value
    Private read_pwm2_prescale_value
    Private flag_pwm2_prescale
    Private write_pwm3_prescale_value
    Private read_pwm3_prescale_value
    Private flag_pwm3_prescale

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

    Property Get get_pwm0_prescale
        get_pwm0_prescale = read_pwm0_prescale_value
    End Property

    Property Let set_pwm0_prescale(aData)
        write_pwm0_prescale_value = aData
        flag_pwm0_prescale        = &H1
    End Property

    Property Get read_pwm0_prescale
        read
        read_pwm0_prescale = read_pwm0_prescale_value
    End Property

    Property Let write_pwm0_prescale(aData)
        set_pwm0_prescale = aData
        write
    End Property

    Property Get get_pwm1_prescale
        get_pwm1_prescale = read_pwm1_prescale_value
    End Property

    Property Let set_pwm1_prescale(aData)
        write_pwm1_prescale_value = aData
        flag_pwm1_prescale        = &H1
    End Property

    Property Get read_pwm1_prescale
        read
        read_pwm1_prescale = read_pwm1_prescale_value
    End Property

    Property Let write_pwm1_prescale(aData)
        set_pwm1_prescale = aData
        write
    End Property

    Property Get get_pwm2_prescale
        get_pwm2_prescale = read_pwm2_prescale_value
    End Property

    Property Let set_pwm2_prescale(aData)
        write_pwm2_prescale_value = aData
        flag_pwm2_prescale        = &H1
    End Property

    Property Get read_pwm2_prescale
        read
        read_pwm2_prescale = read_pwm2_prescale_value
    End Property

    Property Let write_pwm2_prescale(aData)
        set_pwm2_prescale = aData
        write
    End Property

    Property Get get_pwm3_prescale
        get_pwm3_prescale = read_pwm3_prescale_value
    End Property

    Property Let set_pwm3_prescale(aData)
        write_pwm3_prescale_value = aData
        flag_pwm3_prescale        = &H1
    End Property

    Property Get read_pwm3_prescale
        read
        read_pwm3_prescale = read_pwm3_prescale_value
    End Property

    Property Let write_pwm3_prescale(aData)
        set_pwm3_prescale = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwm0_prescale_value = rightShift(data_low, 18) and &H3f
        read_pwm1_prescale_value = rightShift(data_low, 12) and &H3f
        read_pwm2_prescale_value = rightShift(data_low, 6) and &H3f
        pwm3_prescale_mask = &H3f
        if data_low > LONG_MAX then
            if pwm3_prescale_mask = mask then
                read_pwm3_prescale_value = data_low
            else
                read_pwm3_prescale_value = (data_low - H8000_0000) and pwm3_prescale_mask
            end If
        else
            read_pwm3_prescale_value = data_low and pwm3_prescale_mask
        end If

    End Sub

    Sub write
        If flag_pwm0_prescale = &H0 or flag_pwm1_prescale = &H0 or flag_pwm2_prescale = &H0 or flag_pwm3_prescale = &H0 Then read
        If flag_pwm0_prescale = &H0 Then write_pwm0_prescale_value = get_pwm0_prescale
        If flag_pwm1_prescale = &H0 Then write_pwm1_prescale_value = get_pwm1_prescale
        If flag_pwm2_prescale = &H0 Then write_pwm2_prescale_value = get_pwm2_prescale
        If flag_pwm3_prescale = &H0 Then write_pwm3_prescale_value = get_pwm3_prescale

        regValue = leftShift((write_pwm0_prescale_value and &H3f), 18) + leftShift((write_pwm1_prescale_value and &H3f), 12) + leftShift((write_pwm2_prescale_value and &H3f), 6) + leftShift((write_pwm3_prescale_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwm0_prescale_value = rightShift(data_low, 18) and &H3f
        read_pwm1_prescale_value = rightShift(data_low, 12) and &H3f
        read_pwm2_prescale_value = rightShift(data_low, 6) and &H3f
        pwm3_prescale_mask = &H3f
        if data_low > LONG_MAX then
            if pwm3_prescale_mask = mask then
                read_pwm3_prescale_value = data_low
            else
                read_pwm3_prescale_value = (data_low - H8000_0000) and pwm3_prescale_mask
            end If
        else
            read_pwm3_prescale_value = data_low and pwm3_prescale_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwm0_prescale_value = &H0
        flag_pwm0_prescale        = &H0
        write_pwm1_prescale_value = &H0
        flag_pwm1_prescale        = &H0
        write_pwm2_prescale_value = &H0
        flag_pwm2_prescale        = &H0
        write_pwm3_prescale_value = &H0
        flag_pwm3_prescale        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PWM_INSTANCE

    Public pwmctl
    Public period_cnt_0
    Public duty_cnt_0
    Public period_cnt_1
    Public duty_cnt_1
    Public period_cnt_2
    Public duty_cnt_2
    Public period_cnt_3
    Public duty_cnt_3
    Public prescale


    Public default function Init(aBaseAddr)
        Set pwmctl = (New REGISTER_PWM_pwmctl)(aBaseAddr, 32)
        Set period_cnt_0 = (New REGISTER_PWM_period_cnt_0)(aBaseAddr, 32)
        Set duty_cnt_0 = (New REGISTER_PWM_duty_cnt_0)(aBaseAddr, 32)
        Set period_cnt_1 = (New REGISTER_PWM_period_cnt_1)(aBaseAddr, 32)
        Set duty_cnt_1 = (New REGISTER_PWM_duty_cnt_1)(aBaseAddr, 32)
        Set period_cnt_2 = (New REGISTER_PWM_period_cnt_2)(aBaseAddr, 32)
        Set duty_cnt_2 = (New REGISTER_PWM_duty_cnt_2)(aBaseAddr, 32)
        Set period_cnt_3 = (New REGISTER_PWM_period_cnt_3)(aBaseAddr, 32)
        Set duty_cnt_3 = (New REGISTER_PWM_duty_cnt_3)(aBaseAddr, 32)
        Set prescale = (New REGISTER_PWM_prescale)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PWM = CreateObject("System.Collections.ArrayList")
PWM.Add ((New PWM_INSTANCE)(&H4014b000))


