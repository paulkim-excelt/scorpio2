

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


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10M_ClockCount0                         [13:0]           get_reg10M_ClockCount0
''                                                             set_reg10M_ClockCount0
''                                                             read_reg10M_ClockCount0
''                                                             write_reg10M_ClockCount0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit0
    Private write_reg10M_ClockCount0_value
    Private read_reg10M_ClockCount0_value
    Private flag_reg10M_ClockCount0

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

    Property Get get_reg10M_ClockCount0
        get_reg10M_ClockCount0 = read_reg10M_ClockCount0_value
    End Property

    Property Let set_reg10M_ClockCount0(aData)
        write_reg10M_ClockCount0_value = aData
        flag_reg10M_ClockCount0        = &H1
    End Property

    Property Get read_reg10M_ClockCount0
        read
        read_reg10M_ClockCount0 = read_reg10M_ClockCount0_value
    End Property

    Property Let write_reg10M_ClockCount0(aData)
        set_reg10M_ClockCount0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10M_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg10M_ClockCount0_mask = mask then
                read_reg10M_ClockCount0_value = data_low
            else
                read_reg10M_ClockCount0_value = (data_low - H8000_0000) and reg10M_ClockCount0_mask
            end If
        else
            read_reg10M_ClockCount0_value = data_low and reg10M_ClockCount0_mask
        end If

    End Sub

    Sub write
        If flag_reg10M_ClockCount0 = &H0 Then read
        If flag_reg10M_ClockCount0 = &H0 Then write_reg10M_ClockCount0_value = get_reg10M_ClockCount0

        regValue = leftShift((write_reg10M_ClockCount0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10M_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg10M_ClockCount0_mask = mask then
                read_reg10M_ClockCount0_value = data_low
            else
                read_reg10M_ClockCount0_value = (data_low - H8000_0000) and reg10M_ClockCount0_mask
            end If
        else
            read_reg10M_ClockCount0_value = data_low and reg10M_ClockCount0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10M_ClockCount0_value = &H0
        flag_reg10M_ClockCount0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10M_loopcnt0                            [15:8]           get_reg10M_loopcnt0
''                                                             set_reg10M_loopcnt0
''                                                             read_reg10M_loopcnt0
''                                                             write_reg10M_loopcnt0
''---------------------------------------------------------------------------------
'' reg10M_ClockCount1                         [7:0]            get_reg10M_ClockCount1
''                                                             set_reg10M_ClockCount1
''                                                             read_reg10M_ClockCount1
''                                                             write_reg10M_ClockCount1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit1
    Private write_reg10M_loopcnt0_value
    Private read_reg10M_loopcnt0_value
    Private flag_reg10M_loopcnt0
    Private write_reg10M_ClockCount1_value
    Private read_reg10M_ClockCount1_value
    Private flag_reg10M_ClockCount1

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

    Property Get get_reg10M_loopcnt0
        get_reg10M_loopcnt0 = read_reg10M_loopcnt0_value
    End Property

    Property Let set_reg10M_loopcnt0(aData)
        write_reg10M_loopcnt0_value = aData
        flag_reg10M_loopcnt0        = &H1
    End Property

    Property Get read_reg10M_loopcnt0
        read
        read_reg10M_loopcnt0 = read_reg10M_loopcnt0_value
    End Property

    Property Let write_reg10M_loopcnt0(aData)
        set_reg10M_loopcnt0 = aData
        write
    End Property

    Property Get get_reg10M_ClockCount1
        get_reg10M_ClockCount1 = read_reg10M_ClockCount1_value
    End Property

    Property Let set_reg10M_ClockCount1(aData)
        write_reg10M_ClockCount1_value = aData
        flag_reg10M_ClockCount1        = &H1
    End Property

    Property Get read_reg10M_ClockCount1
        read
        read_reg10M_ClockCount1 = read_reg10M_ClockCount1_value
    End Property

    Property Let write_reg10M_ClockCount1(aData)
        set_reg10M_ClockCount1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10M_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg10M_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg10M_ClockCount1_mask = mask then
                read_reg10M_ClockCount1_value = data_low
            else
                read_reg10M_ClockCount1_value = (data_low - H8000_0000) and reg10M_ClockCount1_mask
            end If
        else
            read_reg10M_ClockCount1_value = data_low and reg10M_ClockCount1_mask
        end If

    End Sub

    Sub write
        If flag_reg10M_loopcnt0 = &H0 or flag_reg10M_ClockCount1 = &H0 Then read
        If flag_reg10M_loopcnt0 = &H0 Then write_reg10M_loopcnt0_value = get_reg10M_loopcnt0
        If flag_reg10M_ClockCount1 = &H0 Then write_reg10M_ClockCount1_value = get_reg10M_ClockCount1

        regValue = leftShift((write_reg10M_loopcnt0_value and &Hff), 8) + leftShift((write_reg10M_ClockCount1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10M_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg10M_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg10M_ClockCount1_mask = mask then
                read_reg10M_ClockCount1_value = data_low
            else
                read_reg10M_ClockCount1_value = (data_low - H8000_0000) and reg10M_ClockCount1_mask
            end If
        else
            read_reg10M_ClockCount1_value = data_low and reg10M_ClockCount1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10M_loopcnt0_value = &H0
        flag_reg10M_loopcnt0        = &H0
        write_reg10M_ClockCount1_value = &H0
        flag_reg10M_ClockCount1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R10PC0                                     [13:0]           get_R10PC0
''                                                             set_R10PC0
''                                                             read_R10PC0
''                                                             write_R10PC0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit2
    Private write_R10PC0_value
    Private read_R10PC0_value
    Private flag_R10PC0

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

    Property Get get_R10PC0
        get_R10PC0 = read_R10PC0_value
    End Property

    Property Let set_R10PC0(aData)
        write_R10PC0_value = aData
        flag_R10PC0        = &H1
    End Property

    Property Get read_R10PC0
        read
        read_R10PC0 = read_R10PC0_value
    End Property

    Property Let write_R10PC0(aData)
        set_R10PC0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R10PC0_mask = &H3fff
        if data_low > LONG_MAX then
            if R10PC0_mask = mask then
                read_R10PC0_value = data_low
            else
                read_R10PC0_value = (data_low - H8000_0000) and R10PC0_mask
            end If
        else
            read_R10PC0_value = data_low and R10PC0_mask
        end If

    End Sub

    Sub write
        If flag_R10PC0 = &H0 Then read
        If flag_R10PC0 = &H0 Then write_R10PC0_value = get_R10PC0

        regValue = leftShift((write_R10PC0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R10PC0_mask = &H3fff
        if data_low > LONG_MAX then
            if R10PC0_mask = mask then
                read_R10PC0_value = data_low
            else
                read_R10PC0_value = (data_low - H8000_0000) and R10PC0_mask
            end If
        else
            read_R10PC0_value = data_low and R10PC0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R10PC0_value = &H0
        flag_R10PC0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10M_loopcnt1_Lo                         [15:13]          get_reg10M_loopcnt1_Lo
''                                                             set_reg10M_loopcnt1_Lo
''                                                             read_reg10M_loopcnt1_Lo
''                                                             write_reg10M_loopcnt1_Lo
''---------------------------------------------------------------------------------
'' reg10M_CGC                                 [12:0]           get_reg10M_CGC
''                                                             set_reg10M_CGC
''                                                             read_reg10M_CGC
''                                                             write_reg10M_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit3
    Private write_reg10M_loopcnt1_Lo_value
    Private read_reg10M_loopcnt1_Lo_value
    Private flag_reg10M_loopcnt1_Lo
    Private write_reg10M_CGC_value
    Private read_reg10M_CGC_value
    Private flag_reg10M_CGC

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

    Property Get get_reg10M_loopcnt1_Lo
        get_reg10M_loopcnt1_Lo = read_reg10M_loopcnt1_Lo_value
    End Property

    Property Let set_reg10M_loopcnt1_Lo(aData)
        write_reg10M_loopcnt1_Lo_value = aData
        flag_reg10M_loopcnt1_Lo        = &H1
    End Property

    Property Get read_reg10M_loopcnt1_Lo
        read
        read_reg10M_loopcnt1_Lo = read_reg10M_loopcnt1_Lo_value
    End Property

    Property Let write_reg10M_loopcnt1_Lo(aData)
        set_reg10M_loopcnt1_Lo = aData
        write
    End Property

    Property Get get_reg10M_CGC
        get_reg10M_CGC = read_reg10M_CGC_value
    End Property

    Property Let set_reg10M_CGC(aData)
        write_reg10M_CGC_value = aData
        flag_reg10M_CGC        = &H1
    End Property

    Property Get read_reg10M_CGC
        read
        read_reg10M_CGC = read_reg10M_CGC_value
    End Property

    Property Let write_reg10M_CGC(aData)
        set_reg10M_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10M_loopcnt1_Lo_value = rightShift(data_low, 13) and &H7
        reg10M_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg10M_CGC_mask = mask then
                read_reg10M_CGC_value = data_low
            else
                read_reg10M_CGC_value = (data_low - H8000_0000) and reg10M_CGC_mask
            end If
        else
            read_reg10M_CGC_value = data_low and reg10M_CGC_mask
        end If

    End Sub

    Sub write
        If flag_reg10M_loopcnt1_Lo = &H0 or flag_reg10M_CGC = &H0 Then read
        If flag_reg10M_loopcnt1_Lo = &H0 Then write_reg10M_loopcnt1_Lo_value = get_reg10M_loopcnt1_Lo
        If flag_reg10M_CGC = &H0 Then write_reg10M_CGC_value = get_reg10M_CGC

        regValue = leftShift((write_reg10M_loopcnt1_Lo_value and &H7), 13) + leftShift((write_reg10M_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10M_loopcnt1_Lo_value = rightShift(data_low, 13) and &H7
        reg10M_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg10M_CGC_mask = mask then
                read_reg10M_CGC_value = data_low
            else
                read_reg10M_CGC_value = (data_low - H8000_0000) and reg10M_CGC_mask
            end If
        else
            read_reg10M_CGC_value = data_low and reg10M_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10M_loopcnt1_Lo_value = &H0
        flag_reg10M_loopcnt1_Lo        = &H0
        write_reg10M_CGC_value = &H0
        flag_reg10M_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10M_loopcnt1_Hi                         [15:13]          get_reg10M_loopcnt1_Hi
''                                                             set_reg10M_loopcnt1_Hi
''                                                             read_reg10M_loopcnt1_Hi
''                                                             write_reg10M_loopcnt1_Hi
''---------------------------------------------------------------------------------
'' reg10M_PCS_CGC                             [12:0]           get_reg10M_PCS_CGC
''                                                             set_reg10M_PCS_CGC
''                                                             read_reg10M_PCS_CGC
''                                                             write_reg10M_PCS_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit4
    Private write_reg10M_loopcnt1_Hi_value
    Private read_reg10M_loopcnt1_Hi_value
    Private flag_reg10M_loopcnt1_Hi
    Private write_reg10M_PCS_CGC_value
    Private read_reg10M_PCS_CGC_value
    Private flag_reg10M_PCS_CGC

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

    Property Get get_reg10M_loopcnt1_Hi
        get_reg10M_loopcnt1_Hi = read_reg10M_loopcnt1_Hi_value
    End Property

    Property Let set_reg10M_loopcnt1_Hi(aData)
        write_reg10M_loopcnt1_Hi_value = aData
        flag_reg10M_loopcnt1_Hi        = &H1
    End Property

    Property Get read_reg10M_loopcnt1_Hi
        read
        read_reg10M_loopcnt1_Hi = read_reg10M_loopcnt1_Hi_value
    End Property

    Property Let write_reg10M_loopcnt1_Hi(aData)
        set_reg10M_loopcnt1_Hi = aData
        write
    End Property

    Property Get get_reg10M_PCS_CGC
        get_reg10M_PCS_CGC = read_reg10M_PCS_CGC_value
    End Property

    Property Let set_reg10M_PCS_CGC(aData)
        write_reg10M_PCS_CGC_value = aData
        flag_reg10M_PCS_CGC        = &H1
    End Property

    Property Get read_reg10M_PCS_CGC
        read
        read_reg10M_PCS_CGC = read_reg10M_PCS_CGC_value
    End Property

    Property Let write_reg10M_PCS_CGC(aData)
        set_reg10M_PCS_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10M_loopcnt1_Hi_value = rightShift(data_low, 13) and &H7
        reg10M_PCS_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg10M_PCS_CGC_mask = mask then
                read_reg10M_PCS_CGC_value = data_low
            else
                read_reg10M_PCS_CGC_value = (data_low - H8000_0000) and reg10M_PCS_CGC_mask
            end If
        else
            read_reg10M_PCS_CGC_value = data_low and reg10M_PCS_CGC_mask
        end If

    End Sub

    Sub write
        If flag_reg10M_loopcnt1_Hi = &H0 or flag_reg10M_PCS_CGC = &H0 Then read
        If flag_reg10M_loopcnt1_Hi = &H0 Then write_reg10M_loopcnt1_Hi_value = get_reg10M_loopcnt1_Hi
        If flag_reg10M_PCS_CGC = &H0 Then write_reg10M_PCS_CGC_value = get_reg10M_PCS_CGC

        regValue = leftShift((write_reg10M_loopcnt1_Hi_value and &H7), 13) + leftShift((write_reg10M_PCS_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10M_loopcnt1_Hi_value = rightShift(data_low, 13) and &H7
        reg10M_PCS_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg10M_PCS_CGC_mask = mask then
                read_reg10M_PCS_CGC_value = data_low
            else
                read_reg10M_PCS_CGC_value = (data_low - H8000_0000) and reg10M_PCS_CGC_mask
            end If
        else
            read_reg10M_PCS_CGC_value = data_low and reg10M_PCS_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10M_loopcnt1_Hi_value = &H0
        flag_reg10M_loopcnt1_Hi        = &H0
        write_reg10M_PCS_CGC_value = &H0
        flag_reg10M_PCS_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REG100_CLOC0                               [13:0]           get_REG100_CLOC0
''                                                             set_REG100_CLOC0
''                                                             read_REG100_CLOC0
''                                                             write_REG100_CLOC0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit0
    Private write_REG100_CLOC0_value
    Private read_REG100_CLOC0_value
    Private flag_REG100_CLOC0

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

    Property Get get_REG100_CLOC0
        get_REG100_CLOC0 = read_REG100_CLOC0_value
    End Property

    Property Let set_REG100_CLOC0(aData)
        write_REG100_CLOC0_value = aData
        flag_REG100_CLOC0        = &H1
    End Property

    Property Get read_REG100_CLOC0
        read
        read_REG100_CLOC0 = read_REG100_CLOC0_value
    End Property

    Property Let write_REG100_CLOC0(aData)
        set_REG100_CLOC0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG100_CLOC0_mask = &H3fff
        if data_low > LONG_MAX then
            if REG100_CLOC0_mask = mask then
                read_REG100_CLOC0_value = data_low
            else
                read_REG100_CLOC0_value = (data_low - H8000_0000) and REG100_CLOC0_mask
            end If
        else
            read_REG100_CLOC0_value = data_low and REG100_CLOC0_mask
        end If

    End Sub

    Sub write
        If flag_REG100_CLOC0 = &H0 Then read
        If flag_REG100_CLOC0 = &H0 Then write_REG100_CLOC0_value = get_REG100_CLOC0

        regValue = leftShift((write_REG100_CLOC0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG100_CLOC0_mask = &H3fff
        if data_low > LONG_MAX then
            if REG100_CLOC0_mask = mask then
                read_REG100_CLOC0_value = data_low
            else
                read_REG100_CLOC0_value = (data_low - H8000_0000) and REG100_CLOC0_mask
            end If
        else
            read_REG100_CLOC0_value = data_low and REG100_CLOC0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REG100_CLOC0_value = &H0
        flag_REG100_CLOC0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg100M_loopcnt0                           [15:8]           get_reg100M_loopcnt0
''                                                             set_reg100M_loopcnt0
''                                                             read_reg100M_loopcnt0
''                                                             write_reg100M_loopcnt0
''---------------------------------------------------------------------------------
'' REG100_CLOC11                              [7:0]            get_REG100_CLOC11
''                                                             set_REG100_CLOC11
''                                                             read_REG100_CLOC11
''                                                             write_REG100_CLOC11
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit1
    Private write_reg100M_loopcnt0_value
    Private read_reg100M_loopcnt0_value
    Private flag_reg100M_loopcnt0
    Private write_REG100_CLOC11_value
    Private read_REG100_CLOC11_value
    Private flag_REG100_CLOC11

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

    Property Get get_reg100M_loopcnt0
        get_reg100M_loopcnt0 = read_reg100M_loopcnt0_value
    End Property

    Property Let set_reg100M_loopcnt0(aData)
        write_reg100M_loopcnt0_value = aData
        flag_reg100M_loopcnt0        = &H1
    End Property

    Property Get read_reg100M_loopcnt0
        read
        read_reg100M_loopcnt0 = read_reg100M_loopcnt0_value
    End Property

    Property Let write_reg100M_loopcnt0(aData)
        set_reg100M_loopcnt0 = aData
        write
    End Property

    Property Get get_REG100_CLOC11
        get_REG100_CLOC11 = read_REG100_CLOC11_value
    End Property

    Property Let set_REG100_CLOC11(aData)
        write_REG100_CLOC11_value = aData
        flag_REG100_CLOC11        = &H1
    End Property

    Property Get read_REG100_CLOC11
        read
        read_REG100_CLOC11 = read_REG100_CLOC11_value
    End Property

    Property Let write_REG100_CLOC11(aData)
        set_REG100_CLOC11 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg100M_loopcnt0_value = rightShift(data_low, 8) and &Hff
        REG100_CLOC11_mask = &Hff
        if data_low > LONG_MAX then
            if REG100_CLOC11_mask = mask then
                read_REG100_CLOC11_value = data_low
            else
                read_REG100_CLOC11_value = (data_low - H8000_0000) and REG100_CLOC11_mask
            end If
        else
            read_REG100_CLOC11_value = data_low and REG100_CLOC11_mask
        end If

    End Sub

    Sub write
        If flag_reg100M_loopcnt0 = &H0 or flag_REG100_CLOC11 = &H0 Then read
        If flag_reg100M_loopcnt0 = &H0 Then write_reg100M_loopcnt0_value = get_reg100M_loopcnt0
        If flag_REG100_CLOC11 = &H0 Then write_REG100_CLOC11_value = get_REG100_CLOC11

        regValue = leftShift((write_reg100M_loopcnt0_value and &Hff), 8) + leftShift((write_REG100_CLOC11_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg100M_loopcnt0_value = rightShift(data_low, 8) and &Hff
        REG100_CLOC11_mask = &Hff
        if data_low > LONG_MAX then
            if REG100_CLOC11_mask = mask then
                read_REG100_CLOC11_value = data_low
            else
                read_REG100_CLOC11_value = (data_low - H8000_0000) and REG100_CLOC11_mask
            end If
        else
            read_REG100_CLOC11_value = data_low and REG100_CLOC11_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg100M_loopcnt0_value = &H0
        flag_reg100M_loopcnt0        = &H0
        write_REG100_CLOC11_value = &H0
        flag_REG100_CLOC11        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R100PC0                                    [13:0]           get_R100PC0
''                                                             set_R100PC0
''                                                             read_R100PC0
''                                                             write_R100PC0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit2
    Private write_R100PC0_value
    Private read_R100PC0_value
    Private flag_R100PC0

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

    Property Get get_R100PC0
        get_R100PC0 = read_R100PC0_value
    End Property

    Property Let set_R100PC0(aData)
        write_R100PC0_value = aData
        flag_R100PC0        = &H1
    End Property

    Property Get read_R100PC0
        read
        read_R100PC0 = read_R100PC0_value
    End Property

    Property Let write_R100PC0(aData)
        set_R100PC0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R100PC0_mask = &H3fff
        if data_low > LONG_MAX then
            if R100PC0_mask = mask then
                read_R100PC0_value = data_low
            else
                read_R100PC0_value = (data_low - H8000_0000) and R100PC0_mask
            end If
        else
            read_R100PC0_value = data_low and R100PC0_mask
        end If

    End Sub

    Sub write
        If flag_R100PC0 = &H0 Then read
        If flag_R100PC0 = &H0 Then write_R100PC0_value = get_R100PC0

        regValue = leftShift((write_R100PC0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R100PC0_mask = &H3fff
        if data_low > LONG_MAX then
            if R100PC0_mask = mask then
                read_R100PC0_value = data_low
            else
                read_R100PC0_value = (data_low - H8000_0000) and R100PC0_mask
            end If
        else
            read_R100PC0_value = data_low and R100PC0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R100PC0_value = &H0
        flag_R100PC0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R100L1L                                    [15:13]          get_R100L1L
''                                                             set_R100L1L
''                                                             read_R100L1L
''                                                             write_R100L1L
''---------------------------------------------------------------------------------
'' reg100M_CGC                                [12:0]           get_reg100M_CGC
''                                                             set_reg100M_CGC
''                                                             read_reg100M_CGC
''                                                             write_reg100M_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit3
    Private write_R100L1L_value
    Private read_R100L1L_value
    Private flag_R100L1L
    Private write_reg100M_CGC_value
    Private read_reg100M_CGC_value
    Private flag_reg100M_CGC

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

    Property Get get_R100L1L
        get_R100L1L = read_R100L1L_value
    End Property

    Property Let set_R100L1L(aData)
        write_R100L1L_value = aData
        flag_R100L1L        = &H1
    End Property

    Property Get read_R100L1L
        read
        read_R100L1L = read_R100L1L_value
    End Property

    Property Let write_R100L1L(aData)
        set_R100L1L = aData
        write
    End Property

    Property Get get_reg100M_CGC
        get_reg100M_CGC = read_reg100M_CGC_value
    End Property

    Property Let set_reg100M_CGC(aData)
        write_reg100M_CGC_value = aData
        flag_reg100M_CGC        = &H1
    End Property

    Property Get read_reg100M_CGC
        read
        read_reg100M_CGC = read_reg100M_CGC_value
    End Property

    Property Let write_reg100M_CGC(aData)
        set_reg100M_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R100L1L_value = rightShift(data_low, 13) and &H7
        reg100M_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg100M_CGC_mask = mask then
                read_reg100M_CGC_value = data_low
            else
                read_reg100M_CGC_value = (data_low - H8000_0000) and reg100M_CGC_mask
            end If
        else
            read_reg100M_CGC_value = data_low and reg100M_CGC_mask
        end If

    End Sub

    Sub write
        If flag_R100L1L = &H0 or flag_reg100M_CGC = &H0 Then read
        If flag_R100L1L = &H0 Then write_R100L1L_value = get_R100L1L
        If flag_reg100M_CGC = &H0 Then write_reg100M_CGC_value = get_reg100M_CGC

        regValue = leftShift((write_R100L1L_value and &H7), 13) + leftShift((write_reg100M_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R100L1L_value = rightShift(data_low, 13) and &H7
        reg100M_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg100M_CGC_mask = mask then
                read_reg100M_CGC_value = data_low
            else
                read_reg100M_CGC_value = (data_low - H8000_0000) and reg100M_CGC_mask
            end If
        else
            read_reg100M_CGC_value = data_low and reg100M_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R100L1L_value = &H0
        flag_R100L1L        = &H0
        write_reg100M_CGC_value = &H0
        flag_reg100M_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R100L1H                                    [15:13]          get_R100L1H
''                                                             set_R100L1H
''                                                             read_R100L1H
''                                                             write_R100L1H
''---------------------------------------------------------------------------------
'' reg100M_PCS_CGC                            [12:0]           get_reg100M_PCS_CGC
''                                                             set_reg100M_PCS_CGC
''                                                             read_reg100M_PCS_CGC
''                                                             write_reg100M_PCS_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit4
    Private write_R100L1H_value
    Private read_R100L1H_value
    Private flag_R100L1H
    Private write_reg100M_PCS_CGC_value
    Private read_reg100M_PCS_CGC_value
    Private flag_reg100M_PCS_CGC

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

    Property Get get_R100L1H
        get_R100L1H = read_R100L1H_value
    End Property

    Property Let set_R100L1H(aData)
        write_R100L1H_value = aData
        flag_R100L1H        = &H1
    End Property

    Property Get read_R100L1H
        read
        read_R100L1H = read_R100L1H_value
    End Property

    Property Let write_R100L1H(aData)
        set_R100L1H = aData
        write
    End Property

    Property Get get_reg100M_PCS_CGC
        get_reg100M_PCS_CGC = read_reg100M_PCS_CGC_value
    End Property

    Property Let set_reg100M_PCS_CGC(aData)
        write_reg100M_PCS_CGC_value = aData
        flag_reg100M_PCS_CGC        = &H1
    End Property

    Property Get read_reg100M_PCS_CGC
        read
        read_reg100M_PCS_CGC = read_reg100M_PCS_CGC_value
    End Property

    Property Let write_reg100M_PCS_CGC(aData)
        set_reg100M_PCS_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R100L1H_value = rightShift(data_low, 13) and &H7
        reg100M_PCS_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg100M_PCS_CGC_mask = mask then
                read_reg100M_PCS_CGC_value = data_low
            else
                read_reg100M_PCS_CGC_value = (data_low - H8000_0000) and reg100M_PCS_CGC_mask
            end If
        else
            read_reg100M_PCS_CGC_value = data_low and reg100M_PCS_CGC_mask
        end If

    End Sub

    Sub write
        If flag_R100L1H = &H0 or flag_reg100M_PCS_CGC = &H0 Then read
        If flag_R100L1H = &H0 Then write_R100L1H_value = get_R100L1H
        If flag_reg100M_PCS_CGC = &H0 Then write_reg100M_PCS_CGC_value = get_reg100M_PCS_CGC

        regValue = leftShift((write_R100L1H_value and &H7), 13) + leftShift((write_reg100M_PCS_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R100L1H_value = rightShift(data_low, 13) and &H7
        reg100M_PCS_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg100M_PCS_CGC_mask = mask then
                read_reg100M_PCS_CGC_value = data_low
            else
                read_reg100M_PCS_CGC_value = (data_low - H8000_0000) and reg100M_PCS_CGC_mask
            end If
        else
            read_reg100M_PCS_CGC_value = data_low and reg100M_PCS_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R100L1H_value = &H0
        flag_R100L1H        = &H0
        write_reg100M_PCS_CGC_value = &H0
        flag_reg100M_PCS_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg1G_ClockCount0                          [13:0]           get_reg1G_ClockCount0
''                                                             set_reg1G_ClockCount0
''                                                             read_reg1G_ClockCount0
''                                                             write_reg1G_ClockCount0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit0
    Private write_reg1G_ClockCount0_value
    Private read_reg1G_ClockCount0_value
    Private flag_reg1G_ClockCount0

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

    Property Get get_reg1G_ClockCount0
        get_reg1G_ClockCount0 = read_reg1G_ClockCount0_value
    End Property

    Property Let set_reg1G_ClockCount0(aData)
        write_reg1G_ClockCount0_value = aData
        flag_reg1G_ClockCount0        = &H1
    End Property

    Property Get read_reg1G_ClockCount0
        read
        read_reg1G_ClockCount0 = read_reg1G_ClockCount0_value
    End Property

    Property Let write_reg1G_ClockCount0(aData)
        set_reg1G_ClockCount0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg1G_ClockCount0_mask = mask then
                read_reg1G_ClockCount0_value = data_low
            else
                read_reg1G_ClockCount0_value = (data_low - H8000_0000) and reg1G_ClockCount0_mask
            end If
        else
            read_reg1G_ClockCount0_value = data_low and reg1G_ClockCount0_mask
        end If

    End Sub

    Sub write
        If flag_reg1G_ClockCount0 = &H0 Then read
        If flag_reg1G_ClockCount0 = &H0 Then write_reg1G_ClockCount0_value = get_reg1G_ClockCount0

        regValue = leftShift((write_reg1G_ClockCount0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg1G_ClockCount0_mask = mask then
                read_reg1G_ClockCount0_value = data_low
            else
                read_reg1G_ClockCount0_value = (data_low - H8000_0000) and reg1G_ClockCount0_mask
            end If
        else
            read_reg1G_ClockCount0_value = data_low and reg1G_ClockCount0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg1G_ClockCount0_value = &H0
        flag_reg1G_ClockCount0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg1G_CGC                                  [12:0]           get_reg1G_CGC
''                                                             set_reg1G_CGC
''                                                             read_reg1G_CGC
''                                                             write_reg1G_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit1
    Private write_reg1G_CGC_value
    Private read_reg1G_CGC_value
    Private flag_reg1G_CGC

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

    Property Get get_reg1G_CGC
        get_reg1G_CGC = read_reg1G_CGC_value
    End Property

    Property Let set_reg1G_CGC(aData)
        write_reg1G_CGC_value = aData
        flag_reg1G_CGC        = &H1
    End Property

    Property Get read_reg1G_CGC
        read
        read_reg1G_CGC = read_reg1G_CGC_value
    End Property

    Property Let write_reg1G_CGC(aData)
        set_reg1G_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg1G_CGC_mask = mask then
                read_reg1G_CGC_value = data_low
            else
                read_reg1G_CGC_value = (data_low - H8000_0000) and reg1G_CGC_mask
            end If
        else
            read_reg1G_CGC_value = data_low and reg1G_CGC_mask
        end If

    End Sub

    Sub write
        If flag_reg1G_CGC = &H0 Then read
        If flag_reg1G_CGC = &H0 Then write_reg1G_CGC_value = get_reg1G_CGC

        regValue = leftShift((write_reg1G_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg1G_CGC_mask = mask then
                read_reg1G_CGC_value = data_low
            else
                read_reg1G_CGC_value = (data_low - H8000_0000) and reg1G_CGC_mask
            end If
        else
            read_reg1G_CGC_value = data_low and reg1G_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg1G_CGC_value = &H0
        flag_reg1G_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg1G_loopcnt0                             [15:8]           get_reg1G_loopcnt0
''                                                             set_reg1G_loopcnt0
''                                                             read_reg1G_loopcnt0
''                                                             write_reg1G_loopcnt0
''---------------------------------------------------------------------------------
'' reg1G_ClockCount1                          [7:0]            get_reg1G_ClockCount1
''                                                             set_reg1G_ClockCount1
''                                                             read_reg1G_ClockCount1
''                                                             write_reg1G_ClockCount1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit2
    Private write_reg1G_loopcnt0_value
    Private read_reg1G_loopcnt0_value
    Private flag_reg1G_loopcnt0
    Private write_reg1G_ClockCount1_value
    Private read_reg1G_ClockCount1_value
    Private flag_reg1G_ClockCount1

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

    Property Get get_reg1G_loopcnt0
        get_reg1G_loopcnt0 = read_reg1G_loopcnt0_value
    End Property

    Property Let set_reg1G_loopcnt0(aData)
        write_reg1G_loopcnt0_value = aData
        flag_reg1G_loopcnt0        = &H1
    End Property

    Property Get read_reg1G_loopcnt0
        read
        read_reg1G_loopcnt0 = read_reg1G_loopcnt0_value
    End Property

    Property Let write_reg1G_loopcnt0(aData)
        set_reg1G_loopcnt0 = aData
        write
    End Property

    Property Get get_reg1G_ClockCount1
        get_reg1G_ClockCount1 = read_reg1G_ClockCount1_value
    End Property

    Property Let set_reg1G_ClockCount1(aData)
        write_reg1G_ClockCount1_value = aData
        flag_reg1G_ClockCount1        = &H1
    End Property

    Property Get read_reg1G_ClockCount1
        read
        read_reg1G_ClockCount1 = read_reg1G_ClockCount1_value
    End Property

    Property Let write_reg1G_ClockCount1(aData)
        set_reg1G_ClockCount1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg1G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg1G_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg1G_ClockCount1_mask = mask then
                read_reg1G_ClockCount1_value = data_low
            else
                read_reg1G_ClockCount1_value = (data_low - H8000_0000) and reg1G_ClockCount1_mask
            end If
        else
            read_reg1G_ClockCount1_value = data_low and reg1G_ClockCount1_mask
        end If

    End Sub

    Sub write
        If flag_reg1G_loopcnt0 = &H0 or flag_reg1G_ClockCount1 = &H0 Then read
        If flag_reg1G_loopcnt0 = &H0 Then write_reg1G_loopcnt0_value = get_reg1G_loopcnt0
        If flag_reg1G_ClockCount1 = &H0 Then write_reg1G_ClockCount1_value = get_reg1G_ClockCount1

        regValue = leftShift((write_reg1G_loopcnt0_value and &Hff), 8) + leftShift((write_reg1G_ClockCount1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg1G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg1G_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg1G_ClockCount1_mask = mask then
                read_reg1G_ClockCount1_value = data_low
            else
                read_reg1G_ClockCount1_value = (data_low - H8000_0000) and reg1G_ClockCount1_mask
            end If
        else
            read_reg1G_ClockCount1_value = data_low and reg1G_ClockCount1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg1G_loopcnt0_value = &H0
        flag_reg1G_loopcnt0        = &H0
        write_reg1G_ClockCount1_value = &H0
        flag_reg1G_ClockCount1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg1G_loopcnt1                             [5:0]            get_reg1G_loopcnt1
''                                                             set_reg1G_loopcnt1
''                                                             read_reg1G_loopcnt1
''                                                             write_reg1G_loopcnt1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit3
    Private write_reg1G_loopcnt1_value
    Private read_reg1G_loopcnt1_value
    Private flag_reg1G_loopcnt1

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

    Property Get get_reg1G_loopcnt1
        get_reg1G_loopcnt1 = read_reg1G_loopcnt1_value
    End Property

    Property Let set_reg1G_loopcnt1(aData)
        write_reg1G_loopcnt1_value = aData
        flag_reg1G_loopcnt1        = &H1
    End Property

    Property Get read_reg1G_loopcnt1
        read
        read_reg1G_loopcnt1 = read_reg1G_loopcnt1_value
    End Property

    Property Let write_reg1G_loopcnt1(aData)
        set_reg1G_loopcnt1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg1G_loopcnt1_mask = mask then
                read_reg1G_loopcnt1_value = data_low
            else
                read_reg1G_loopcnt1_value = (data_low - H8000_0000) and reg1G_loopcnt1_mask
            end If
        else
            read_reg1G_loopcnt1_value = data_low and reg1G_loopcnt1_mask
        end If

    End Sub

    Sub write
        If flag_reg1G_loopcnt1 = &H0 Then read
        If flag_reg1G_loopcnt1 = &H0 Then write_reg1G_loopcnt1_value = get_reg1G_loopcnt1

        regValue = leftShift((write_reg1G_loopcnt1_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg1G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg1G_loopcnt1_mask = mask then
                read_reg1G_loopcnt1_value = data_low
            else
                read_reg1G_loopcnt1_value = (data_low - H8000_0000) and reg1G_loopcnt1_mask
            end If
        else
            read_reg1G_loopcnt1_value = data_low and reg1G_loopcnt1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg1G_loopcnt1_value = &H0
        flag_reg1G_loopcnt1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_blockaddress
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

Class TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_INSTANCE

    Public reg10m_credit0
    Public reg10m_credit1
    Public reg10m_credit2
    Public reg10m_credit3
    Public reg10m_credit4
    Public reg100m_credit0
    Public reg100m_credit1
    Public reg100m_credit2
    Public reg100m_credit3
    Public reg100m_credit4
    Public reg1g_credit0
    Public reg1g_credit1
    Public reg1g_credit2
    Public reg1g_credit3
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set reg10m_credit0 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit0)(aBaseAddr, 16)
        Set reg10m_credit1 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit1)(aBaseAddr, 16)
        Set reg10m_credit2 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit2)(aBaseAddr, 16)
        Set reg10m_credit3 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit3)(aBaseAddr, 16)
        Set reg10m_credit4 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg10m_credit4)(aBaseAddr, 16)
        Set reg100m_credit0 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit0)(aBaseAddr, 16)
        Set reg100m_credit1 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit1)(aBaseAddr, 16)
        Set reg100m_credit2 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit2)(aBaseAddr, 16)
        Set reg100m_credit3 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit3)(aBaseAddr, 16)
        Set reg100m_credit4 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg100m_credit4)(aBaseAddr, 16)
        Set reg1g_credit0 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit0)(aBaseAddr, 16)
        Set reg1g_credit1 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit1)(aBaseAddr, 16)
        Set reg1g_credit2 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit2)(aBaseAddr, 16)
        Set reg1g_credit3 = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_reg1g_credit3)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1.Add ((New TX_X1_CREDIT_GEN1_SGMIIPLUSR_X1_INSTANCE)(&H4aed24c0))


