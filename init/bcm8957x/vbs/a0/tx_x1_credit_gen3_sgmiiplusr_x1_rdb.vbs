

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


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg5G_ClockCount0                          [13:0]           get_reg5G_ClockCount0
''                                                             set_reg5G_ClockCount0
''                                                             read_reg5G_ClockCount0
''                                                             write_reg5G_ClockCount0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit0
    Private write_reg5G_ClockCount0_value
    Private read_reg5G_ClockCount0_value
    Private flag_reg5G_ClockCount0

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

    Property Get get_reg5G_ClockCount0
        get_reg5G_ClockCount0 = read_reg5G_ClockCount0_value
    End Property

    Property Let set_reg5G_ClockCount0(aData)
        write_reg5G_ClockCount0_value = aData
        flag_reg5G_ClockCount0        = &H1
    End Property

    Property Get read_reg5G_ClockCount0
        read
        read_reg5G_ClockCount0 = read_reg5G_ClockCount0_value
    End Property

    Property Let write_reg5G_ClockCount0(aData)
        set_reg5G_ClockCount0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg5G_ClockCount0_mask = mask then
                read_reg5G_ClockCount0_value = data_low
            else
                read_reg5G_ClockCount0_value = (data_low - H8000_0000) and reg5G_ClockCount0_mask
            end If
        else
            read_reg5G_ClockCount0_value = data_low and reg5G_ClockCount0_mask
        end If

    End Sub

    Sub write
        If flag_reg5G_ClockCount0 = &H0 Then read
        If flag_reg5G_ClockCount0 = &H0 Then write_reg5G_ClockCount0_value = get_reg5G_ClockCount0

        regValue = leftShift((write_reg5G_ClockCount0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg5G_ClockCount0_mask = mask then
                read_reg5G_ClockCount0_value = data_low
            else
                read_reg5G_ClockCount0_value = (data_low - H8000_0000) and reg5G_ClockCount0_mask
            end If
        else
            read_reg5G_ClockCount0_value = data_low and reg5G_ClockCount0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg5G_ClockCount0_value = &H0
        flag_reg5G_ClockCount0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg5G_CGC                                  [12:0]           get_reg5G_CGC
''                                                             set_reg5G_CGC
''                                                             read_reg5G_CGC
''                                                             write_reg5G_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit1
    Private write_reg5G_CGC_value
    Private read_reg5G_CGC_value
    Private flag_reg5G_CGC

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

    Property Get get_reg5G_CGC
        get_reg5G_CGC = read_reg5G_CGC_value
    End Property

    Property Let set_reg5G_CGC(aData)
        write_reg5G_CGC_value = aData
        flag_reg5G_CGC        = &H1
    End Property

    Property Get read_reg5G_CGC
        read
        read_reg5G_CGC = read_reg5G_CGC_value
    End Property

    Property Let write_reg5G_CGC(aData)
        set_reg5G_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg5G_CGC_mask = mask then
                read_reg5G_CGC_value = data_low
            else
                read_reg5G_CGC_value = (data_low - H8000_0000) and reg5G_CGC_mask
            end If
        else
            read_reg5G_CGC_value = data_low and reg5G_CGC_mask
        end If

    End Sub

    Sub write
        If flag_reg5G_CGC = &H0 Then read
        If flag_reg5G_CGC = &H0 Then write_reg5G_CGC_value = get_reg5G_CGC

        regValue = leftShift((write_reg5G_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg5G_CGC_mask = mask then
                read_reg5G_CGC_value = data_low
            else
                read_reg5G_CGC_value = (data_low - H8000_0000) and reg5G_CGC_mask
            end If
        else
            read_reg5G_CGC_value = data_low and reg5G_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg5G_CGC_value = &H0
        flag_reg5G_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg5G_loopcnt0                             [15:8]           get_reg5G_loopcnt0
''                                                             set_reg5G_loopcnt0
''                                                             read_reg5G_loopcnt0
''                                                             write_reg5G_loopcnt0
''---------------------------------------------------------------------------------
'' reg5G_ClockCount1                          [7:0]            get_reg5G_ClockCount1
''                                                             set_reg5G_ClockCount1
''                                                             read_reg5G_ClockCount1
''                                                             write_reg5G_ClockCount1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit2
    Private write_reg5G_loopcnt0_value
    Private read_reg5G_loopcnt0_value
    Private flag_reg5G_loopcnt0
    Private write_reg5G_ClockCount1_value
    Private read_reg5G_ClockCount1_value
    Private flag_reg5G_ClockCount1

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

    Property Get get_reg5G_loopcnt0
        get_reg5G_loopcnt0 = read_reg5G_loopcnt0_value
    End Property

    Property Let set_reg5G_loopcnt0(aData)
        write_reg5G_loopcnt0_value = aData
        flag_reg5G_loopcnt0        = &H1
    End Property

    Property Get read_reg5G_loopcnt0
        read
        read_reg5G_loopcnt0 = read_reg5G_loopcnt0_value
    End Property

    Property Let write_reg5G_loopcnt0(aData)
        set_reg5G_loopcnt0 = aData
        write
    End Property

    Property Get get_reg5G_ClockCount1
        get_reg5G_ClockCount1 = read_reg5G_ClockCount1_value
    End Property

    Property Let set_reg5G_ClockCount1(aData)
        write_reg5G_ClockCount1_value = aData
        flag_reg5G_ClockCount1        = &H1
    End Property

    Property Get read_reg5G_ClockCount1
        read
        read_reg5G_ClockCount1 = read_reg5G_ClockCount1_value
    End Property

    Property Let write_reg5G_ClockCount1(aData)
        set_reg5G_ClockCount1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg5G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg5G_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg5G_ClockCount1_mask = mask then
                read_reg5G_ClockCount1_value = data_low
            else
                read_reg5G_ClockCount1_value = (data_low - H8000_0000) and reg5G_ClockCount1_mask
            end If
        else
            read_reg5G_ClockCount1_value = data_low and reg5G_ClockCount1_mask
        end If

    End Sub

    Sub write
        If flag_reg5G_loopcnt0 = &H0 or flag_reg5G_ClockCount1 = &H0 Then read
        If flag_reg5G_loopcnt0 = &H0 Then write_reg5G_loopcnt0_value = get_reg5G_loopcnt0
        If flag_reg5G_ClockCount1 = &H0 Then write_reg5G_ClockCount1_value = get_reg5G_ClockCount1

        regValue = leftShift((write_reg5G_loopcnt0_value and &Hff), 8) + leftShift((write_reg5G_ClockCount1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg5G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg5G_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg5G_ClockCount1_mask = mask then
                read_reg5G_ClockCount1_value = data_low
            else
                read_reg5G_ClockCount1_value = (data_low - H8000_0000) and reg5G_ClockCount1_mask
            end If
        else
            read_reg5G_ClockCount1_value = data_low and reg5G_ClockCount1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg5G_loopcnt0_value = &H0
        flag_reg5G_loopcnt0        = &H0
        write_reg5G_ClockCount1_value = &H0
        flag_reg5G_ClockCount1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg5G_loopcnt1                             [5:0]            get_reg5G_loopcnt1
''                                                             set_reg5G_loopcnt1
''                                                             read_reg5G_loopcnt1
''                                                             write_reg5G_loopcnt1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit3
    Private write_reg5G_loopcnt1_value
    Private read_reg5G_loopcnt1_value
    Private flag_reg5G_loopcnt1

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

    Property Get get_reg5G_loopcnt1
        get_reg5G_loopcnt1 = read_reg5G_loopcnt1_value
    End Property

    Property Let set_reg5G_loopcnt1(aData)
        write_reg5G_loopcnt1_value = aData
        flag_reg5G_loopcnt1        = &H1
    End Property

    Property Get read_reg5G_loopcnt1
        read
        read_reg5G_loopcnt1 = read_reg5G_loopcnt1_value
    End Property

    Property Let write_reg5G_loopcnt1(aData)
        set_reg5G_loopcnt1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg5G_loopcnt1_mask = mask then
                read_reg5G_loopcnt1_value = data_low
            else
                read_reg5G_loopcnt1_value = (data_low - H8000_0000) and reg5G_loopcnt1_mask
            end If
        else
            read_reg5G_loopcnt1_value = data_low and reg5G_loopcnt1_mask
        end If

    End Sub

    Sub write
        If flag_reg5G_loopcnt1 = &H0 Then read
        If flag_reg5G_loopcnt1 = &H0 Then write_reg5G_loopcnt1_value = get_reg5G_loopcnt1

        regValue = leftShift((write_reg5G_loopcnt1_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg5G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg5G_loopcnt1_mask = mask then
                read_reg5G_loopcnt1_value = data_low
            else
                read_reg5G_loopcnt1_value = (data_low - H8000_0000) and reg5G_loopcnt1_mask
            end If
        else
            read_reg5G_loopcnt1_value = data_low and reg5G_loopcnt1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg5G_loopcnt1_value = &H0
        flag_reg5G_loopcnt1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R25C127C0                                  [13:0]           get_R25C127C0
''                                                             set_R25C127C0
''                                                             read_R25C127C0
''                                                             write_R25C127C0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit0
    Private write_R25C127C0_value
    Private read_R25C127C0_value
    Private flag_R25C127C0

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

    Property Get get_R25C127C0
        get_R25C127C0 = read_R25C127C0_value
    End Property

    Property Let set_R25C127C0(aData)
        write_R25C127C0_value = aData
        flag_R25C127C0        = &H1
    End Property

    Property Get read_R25C127C0
        read
        read_R25C127C0 = read_R25C127C0_value
    End Property

    Property Let write_R25C127C0(aData)
        set_R25C127C0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R25C127C0_mask = &H3fff
        if data_low > LONG_MAX then
            if R25C127C0_mask = mask then
                read_R25C127C0_value = data_low
            else
                read_R25C127C0_value = (data_low - H8000_0000) and R25C127C0_mask
            end If
        else
            read_R25C127C0_value = data_low and R25C127C0_mask
        end If

    End Sub

    Sub write
        If flag_R25C127C0 = &H0 Then read
        If flag_R25C127C0 = &H0 Then write_R25C127C0_value = get_R25C127C0

        regValue = leftShift((write_R25C127C0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R25C127C0_mask = &H3fff
        if data_low > LONG_MAX then
            if R25C127C0_mask = mask then
                read_R25C127C0_value = data_low
            else
                read_R25C127C0_value = (data_low - H8000_0000) and R25C127C0_mask
            end If
        else
            read_R25C127C0_value = data_low and R25C127C0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R25C127C0_value = &H0
        flag_R25C127C0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R25C127C                                   [12:0]           get_R25C127C
''                                                             set_R25C127C
''                                                             read_R25C127C
''                                                             write_R25C127C
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit1
    Private write_R25C127C_value
    Private read_R25C127C_value
    Private flag_R25C127C

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

    Property Get get_R25C127C
        get_R25C127C = read_R25C127C_value
    End Property

    Property Let set_R25C127C(aData)
        write_R25C127C_value = aData
        flag_R25C127C        = &H1
    End Property

    Property Get read_R25C127C
        read
        read_R25C127C = read_R25C127C_value
    End Property

    Property Let write_R25C127C(aData)
        set_R25C127C = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R25C127C_mask = &H1fff
        if data_low > LONG_MAX then
            if R25C127C_mask = mask then
                read_R25C127C_value = data_low
            else
                read_R25C127C_value = (data_low - H8000_0000) and R25C127C_mask
            end If
        else
            read_R25C127C_value = data_low and R25C127C_mask
        end If

    End Sub

    Sub write
        If flag_R25C127C = &H0 Then read
        If flag_R25C127C = &H0 Then write_R25C127C_value = get_R25C127C

        regValue = leftShift((write_R25C127C_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R25C127C_mask = &H1fff
        if data_low > LONG_MAX then
            if R25C127C_mask = mask then
                read_R25C127C_value = data_low
            else
                read_R25C127C_value = (data_low - H8000_0000) and R25C127C_mask
            end If
        else
            read_R25C127C_value = data_low and R25C127C_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R25C127C_value = &H0
        flag_R25C127C        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R25C127L0                                  [15:8]           get_R25C127L0
''                                                             set_R25C127L0
''                                                             read_R25C127L0
''                                                             write_R25C127L0
''---------------------------------------------------------------------------------
'' R25C127C1                                  [7:0]            get_R25C127C1
''                                                             set_R25C127C1
''                                                             read_R25C127C1
''                                                             write_R25C127C1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit2
    Private write_R25C127L0_value
    Private read_R25C127L0_value
    Private flag_R25C127L0
    Private write_R25C127C1_value
    Private read_R25C127C1_value
    Private flag_R25C127C1

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

    Property Get get_R25C127L0
        get_R25C127L0 = read_R25C127L0_value
    End Property

    Property Let set_R25C127L0(aData)
        write_R25C127L0_value = aData
        flag_R25C127L0        = &H1
    End Property

    Property Get read_R25C127L0
        read
        read_R25C127L0 = read_R25C127L0_value
    End Property

    Property Let write_R25C127L0(aData)
        set_R25C127L0 = aData
        write
    End Property

    Property Get get_R25C127C1
        get_R25C127C1 = read_R25C127C1_value
    End Property

    Property Let set_R25C127C1(aData)
        write_R25C127C1_value = aData
        flag_R25C127C1        = &H1
    End Property

    Property Get read_R25C127C1
        read
        read_R25C127C1 = read_R25C127C1_value
    End Property

    Property Let write_R25C127C1(aData)
        set_R25C127C1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R25C127L0_value = rightShift(data_low, 8) and &Hff
        R25C127C1_mask = &Hff
        if data_low > LONG_MAX then
            if R25C127C1_mask = mask then
                read_R25C127C1_value = data_low
            else
                read_R25C127C1_value = (data_low - H8000_0000) and R25C127C1_mask
            end If
        else
            read_R25C127C1_value = data_low and R25C127C1_mask
        end If

    End Sub

    Sub write
        If flag_R25C127L0 = &H0 or flag_R25C127C1 = &H0 Then read
        If flag_R25C127L0 = &H0 Then write_R25C127L0_value = get_R25C127L0
        If flag_R25C127C1 = &H0 Then write_R25C127C1_value = get_R25C127C1

        regValue = leftShift((write_R25C127L0_value and &Hff), 8) + leftShift((write_R25C127C1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R25C127L0_value = rightShift(data_low, 8) and &Hff
        R25C127C1_mask = &Hff
        if data_low > LONG_MAX then
            if R25C127C1_mask = mask then
                read_R25C127C1_value = data_low
            else
                read_R25C127C1_value = (data_low - H8000_0000) and R25C127C1_mask
            end If
        else
            read_R25C127C1_value = data_low and R25C127C1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R25C127L0_value = &H0
        flag_R25C127L0        = &H0
        write_R25C127C1_value = &H0
        flag_R25C127C1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R25C127L1                                  [5:0]            get_R25C127L1
''                                                             set_R25C127L1
''                                                             read_R25C127L1
''                                                             write_R25C127L1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit3
    Private write_R25C127L1_value
    Private read_R25C127L1_value
    Private flag_R25C127L1

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

    Property Get get_R25C127L1
        get_R25C127L1 = read_R25C127L1_value
    End Property

    Property Let set_R25C127L1(aData)
        write_R25C127L1_value = aData
        flag_R25C127L1        = &H1
    End Property

    Property Get read_R25C127L1
        read
        read_R25C127L1 = read_R25C127L1_value
    End Property

    Property Let write_R25C127L1(aData)
        set_R25C127L1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R25C127L1_mask = &H3f
        if data_low > LONG_MAX then
            if R25C127L1_mask = mask then
                read_R25C127L1_value = data_low
            else
                read_R25C127L1_value = (data_low - H8000_0000) and R25C127L1_mask
            end If
        else
            read_R25C127L1_value = data_low and R25C127L1_mask
        end If

    End Sub

    Sub write
        If flag_R25C127L1 = &H0 Then read
        If flag_R25C127L1 = &H0 Then write_R25C127L1_value = get_R25C127L1

        regValue = leftShift((write_R25C127L1_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R25C127L1_mask = &H3f
        if data_low > LONG_MAX then
            if R25C127L1_mask = mask then
                read_R25C127L1_value = data_low
            else
                read_R25C127L1_value = (data_low - H8000_0000) and R25C127L1_mask
            end If
        else
            read_R25C127L1_value = data_low and R25C127L1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R25C127L1_value = &H0
        flag_R25C127L1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R5C127C0                                   [13:0]           get_R5C127C0
''                                                             set_R5C127C0
''                                                             read_R5C127C0
''                                                             write_R5C127C0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit0
    Private write_R5C127C0_value
    Private read_R5C127C0_value
    Private flag_R5C127C0

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

    Property Get get_R5C127C0
        get_R5C127C0 = read_R5C127C0_value
    End Property

    Property Let set_R5C127C0(aData)
        write_R5C127C0_value = aData
        flag_R5C127C0        = &H1
    End Property

    Property Get read_R5C127C0
        read
        read_R5C127C0 = read_R5C127C0_value
    End Property

    Property Let write_R5C127C0(aData)
        set_R5C127C0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R5C127C0_mask = &H3fff
        if data_low > LONG_MAX then
            if R5C127C0_mask = mask then
                read_R5C127C0_value = data_low
            else
                read_R5C127C0_value = (data_low - H8000_0000) and R5C127C0_mask
            end If
        else
            read_R5C127C0_value = data_low and R5C127C0_mask
        end If

    End Sub

    Sub write
        If flag_R5C127C0 = &H0 Then read
        If flag_R5C127C0 = &H0 Then write_R5C127C0_value = get_R5C127C0

        regValue = leftShift((write_R5C127C0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R5C127C0_mask = &H3fff
        if data_low > LONG_MAX then
            if R5C127C0_mask = mask then
                read_R5C127C0_value = data_low
            else
                read_R5C127C0_value = (data_low - H8000_0000) and R5C127C0_mask
            end If
        else
            read_R5C127C0_value = data_low and R5C127C0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R5C127C0_value = &H0
        flag_R5C127C0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REG5_CL127_CGC                             [12:0]           get_REG5_CL127_CGC
''                                                             set_REG5_CL127_CGC
''                                                             read_REG5_CL127_CGC
''                                                             write_REG5_CL127_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit1
    Private write_REG5_CL127_CGC_value
    Private read_REG5_CL127_CGC_value
    Private flag_REG5_CL127_CGC

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

    Property Get get_REG5_CL127_CGC
        get_REG5_CL127_CGC = read_REG5_CL127_CGC_value
    End Property

    Property Let set_REG5_CL127_CGC(aData)
        write_REG5_CL127_CGC_value = aData
        flag_REG5_CL127_CGC        = &H1
    End Property

    Property Get read_REG5_CL127_CGC
        read
        read_REG5_CL127_CGC = read_REG5_CL127_CGC_value
    End Property

    Property Let write_REG5_CL127_CGC(aData)
        set_REG5_CL127_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG5_CL127_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if REG5_CL127_CGC_mask = mask then
                read_REG5_CL127_CGC_value = data_low
            else
                read_REG5_CL127_CGC_value = (data_low - H8000_0000) and REG5_CL127_CGC_mask
            end If
        else
            read_REG5_CL127_CGC_value = data_low and REG5_CL127_CGC_mask
        end If

    End Sub

    Sub write
        If flag_REG5_CL127_CGC = &H0 Then read
        If flag_REG5_CL127_CGC = &H0 Then write_REG5_CL127_CGC_value = get_REG5_CL127_CGC

        regValue = leftShift((write_REG5_CL127_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG5_CL127_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if REG5_CL127_CGC_mask = mask then
                read_REG5_CL127_CGC_value = data_low
            else
                read_REG5_CL127_CGC_value = (data_low - H8000_0000) and REG5_CL127_CGC_mask
            end If
        else
            read_REG5_CL127_CGC_value = data_low and REG5_CL127_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REG5_CL127_CGC_value = &H0
        flag_REG5_CL127_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R5C127L0                                   [15:8]           get_R5C127L0
''                                                             set_R5C127L0
''                                                             read_R5C127L0
''                                                             write_R5C127L0
''---------------------------------------------------------------------------------
'' R5C127C1                                   [7:0]            get_R5C127C1
''                                                             set_R5C127C1
''                                                             read_R5C127C1
''                                                             write_R5C127C1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit2
    Private write_R5C127L0_value
    Private read_R5C127L0_value
    Private flag_R5C127L0
    Private write_R5C127C1_value
    Private read_R5C127C1_value
    Private flag_R5C127C1

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

    Property Get get_R5C127L0
        get_R5C127L0 = read_R5C127L0_value
    End Property

    Property Let set_R5C127L0(aData)
        write_R5C127L0_value = aData
        flag_R5C127L0        = &H1
    End Property

    Property Get read_R5C127L0
        read
        read_R5C127L0 = read_R5C127L0_value
    End Property

    Property Let write_R5C127L0(aData)
        set_R5C127L0 = aData
        write
    End Property

    Property Get get_R5C127C1
        get_R5C127C1 = read_R5C127C1_value
    End Property

    Property Let set_R5C127C1(aData)
        write_R5C127C1_value = aData
        flag_R5C127C1        = &H1
    End Property

    Property Get read_R5C127C1
        read
        read_R5C127C1 = read_R5C127C1_value
    End Property

    Property Let write_R5C127C1(aData)
        set_R5C127C1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R5C127L0_value = rightShift(data_low, 8) and &Hff
        R5C127C1_mask = &Hff
        if data_low > LONG_MAX then
            if R5C127C1_mask = mask then
                read_R5C127C1_value = data_low
            else
                read_R5C127C1_value = (data_low - H8000_0000) and R5C127C1_mask
            end If
        else
            read_R5C127C1_value = data_low and R5C127C1_mask
        end If

    End Sub

    Sub write
        If flag_R5C127L0 = &H0 or flag_R5C127C1 = &H0 Then read
        If flag_R5C127L0 = &H0 Then write_R5C127L0_value = get_R5C127L0
        If flag_R5C127C1 = &H0 Then write_R5C127C1_value = get_R5C127C1

        regValue = leftShift((write_R5C127L0_value and &Hff), 8) + leftShift((write_R5C127C1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R5C127L0_value = rightShift(data_low, 8) and &Hff
        R5C127C1_mask = &Hff
        if data_low > LONG_MAX then
            if R5C127C1_mask = mask then
                read_R5C127C1_value = data_low
            else
                read_R5C127C1_value = (data_low - H8000_0000) and R5C127C1_mask
            end If
        else
            read_R5C127C1_value = data_low and R5C127C1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R5C127L0_value = &H0
        flag_R5C127L0        = &H0
        write_R5C127C1_value = &H0
        flag_R5C127C1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R5C127L1                                   [5:0]            get_R5C127L1
''                                                             set_R5C127L1
''                                                             read_R5C127L1
''                                                             write_R5C127L1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit3
    Private write_R5C127L1_value
    Private read_R5C127L1_value
    Private flag_R5C127L1

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

    Property Get get_R5C127L1
        get_R5C127L1 = read_R5C127L1_value
    End Property

    Property Let set_R5C127L1(aData)
        write_R5C127L1_value = aData
        flag_R5C127L1        = &H1
    End Property

    Property Get read_R5C127L1
        read
        read_R5C127L1 = read_R5C127L1_value
    End Property

    Property Let write_R5C127L1(aData)
        set_R5C127L1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R5C127L1_mask = &H3f
        if data_low > LONG_MAX then
            if R5C127L1_mask = mask then
                read_R5C127L1_value = data_low
            else
                read_R5C127L1_value = (data_low - H8000_0000) and R5C127L1_mask
            end If
        else
            read_R5C127L1_value = data_low and R5C127L1_mask
        end If

    End Sub

    Sub write
        If flag_R5C127L1 = &H0 Then read
        If flag_R5C127L1 = &H0 Then write_R5C127L1_value = get_R5C127L1

        regValue = leftShift((write_R5C127L1_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R5C127L1_mask = &H3f
        if data_low > LONG_MAX then
            if R5C127L1_mask = mask then
                read_R5C127L1_value = data_low
            else
                read_R5C127L1_value = (data_low - H8000_0000) and R5C127L1_mask
            end If
        else
            read_R5C127L1_value = data_low and R5C127L1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R5C127L1_value = &H0
        flag_R5C127L1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R1C127C0                                   [13:0]           get_R1C127C0
''                                                             set_R1C127C0
''                                                             read_R1C127C0
''                                                             write_R1C127C0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit0
    Private write_R1C127C0_value
    Private read_R1C127C0_value
    Private flag_R1C127C0

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

    Property Get get_R1C127C0
        get_R1C127C0 = read_R1C127C0_value
    End Property

    Property Let set_R1C127C0(aData)
        write_R1C127C0_value = aData
        flag_R1C127C0        = &H1
    End Property

    Property Get read_R1C127C0
        read
        read_R1C127C0 = read_R1C127C0_value
    End Property

    Property Let write_R1C127C0(aData)
        set_R1C127C0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R1C127C0_mask = &H3fff
        if data_low > LONG_MAX then
            if R1C127C0_mask = mask then
                read_R1C127C0_value = data_low
            else
                read_R1C127C0_value = (data_low - H8000_0000) and R1C127C0_mask
            end If
        else
            read_R1C127C0_value = data_low and R1C127C0_mask
        end If

    End Sub

    Sub write
        If flag_R1C127C0 = &H0 Then read
        If flag_R1C127C0 = &H0 Then write_R1C127C0_value = get_R1C127C0

        regValue = leftShift((write_R1C127C0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        R1C127C0_mask = &H3fff
        if data_low > LONG_MAX then
            if R1C127C0_mask = mask then
                read_R1C127C0_value = data_low
            else
                read_R1C127C0_value = (data_low - H8000_0000) and R1C127C0_mask
            end If
        else
            read_R1C127C0_value = data_low and R1C127C0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R1C127C0_value = &H0
        flag_R1C127C0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REG1_CL127_CGC                             [12:0]           get_REG1_CL127_CGC
''                                                             set_REG1_CL127_CGC
''                                                             read_REG1_CL127_CGC
''                                                             write_REG1_CL127_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit1
    Private write_REG1_CL127_CGC_value
    Private read_REG1_CL127_CGC_value
    Private flag_REG1_CL127_CGC

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

    Property Get get_REG1_CL127_CGC
        get_REG1_CL127_CGC = read_REG1_CL127_CGC_value
    End Property

    Property Let set_REG1_CL127_CGC(aData)
        write_REG1_CL127_CGC_value = aData
        flag_REG1_CL127_CGC        = &H1
    End Property

    Property Get read_REG1_CL127_CGC
        read
        read_REG1_CL127_CGC = read_REG1_CL127_CGC_value
    End Property

    Property Let write_REG1_CL127_CGC(aData)
        set_REG1_CL127_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG1_CL127_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if REG1_CL127_CGC_mask = mask then
                read_REG1_CL127_CGC_value = data_low
            else
                read_REG1_CL127_CGC_value = (data_low - H8000_0000) and REG1_CL127_CGC_mask
            end If
        else
            read_REG1_CL127_CGC_value = data_low and REG1_CL127_CGC_mask
        end If

    End Sub

    Sub write
        If flag_REG1_CL127_CGC = &H0 Then read
        If flag_REG1_CL127_CGC = &H0 Then write_REG1_CL127_CGC_value = get_REG1_CL127_CGC

        regValue = leftShift((write_REG1_CL127_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG1_CL127_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if REG1_CL127_CGC_mask = mask then
                read_REG1_CL127_CGC_value = data_low
            else
                read_REG1_CL127_CGC_value = (data_low - H8000_0000) and REG1_CL127_CGC_mask
            end If
        else
            read_REG1_CL127_CGC_value = data_low and REG1_CL127_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REG1_CL127_CGC_value = &H0
        flag_REG1_CL127_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R1C127L0                                   [15:8]           get_R1C127L0
''                                                             set_R1C127L0
''                                                             read_R1C127L0
''                                                             write_R1C127L0
''---------------------------------------------------------------------------------
'' R1C127C1                                   [7:0]            get_R1C127C1
''                                                             set_R1C127C1
''                                                             read_R1C127C1
''                                                             write_R1C127C1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit2
    Private write_R1C127L0_value
    Private read_R1C127L0_value
    Private flag_R1C127L0
    Private write_R1C127C1_value
    Private read_R1C127C1_value
    Private flag_R1C127C1

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

    Property Get get_R1C127L0
        get_R1C127L0 = read_R1C127L0_value
    End Property

    Property Let set_R1C127L0(aData)
        write_R1C127L0_value = aData
        flag_R1C127L0        = &H1
    End Property

    Property Get read_R1C127L0
        read
        read_R1C127L0 = read_R1C127L0_value
    End Property

    Property Let write_R1C127L0(aData)
        set_R1C127L0 = aData
        write
    End Property

    Property Get get_R1C127C1
        get_R1C127C1 = read_R1C127C1_value
    End Property

    Property Let set_R1C127C1(aData)
        write_R1C127C1_value = aData
        flag_R1C127C1        = &H1
    End Property

    Property Get read_R1C127C1
        read
        read_R1C127C1 = read_R1C127C1_value
    End Property

    Property Let write_R1C127C1(aData)
        set_R1C127C1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R1C127L0_value = rightShift(data_low, 8) and &Hff
        R1C127C1_mask = &Hff
        if data_low > LONG_MAX then
            if R1C127C1_mask = mask then
                read_R1C127C1_value = data_low
            else
                read_R1C127C1_value = (data_low - H8000_0000) and R1C127C1_mask
            end If
        else
            read_R1C127C1_value = data_low and R1C127C1_mask
        end If

    End Sub

    Sub write
        If flag_R1C127L0 = &H0 or flag_R1C127C1 = &H0 Then read
        If flag_R1C127L0 = &H0 Then write_R1C127L0_value = get_R1C127L0
        If flag_R1C127C1 = &H0 Then write_R1C127C1_value = get_R1C127C1

        regValue = leftShift((write_R1C127L0_value and &Hff), 8) + leftShift((write_R1C127C1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R1C127L0_value = rightShift(data_low, 8) and &Hff
        R1C127C1_mask = &Hff
        if data_low > LONG_MAX then
            if R1C127C1_mask = mask then
                read_R1C127C1_value = data_low
            else
                read_R1C127C1_value = (data_low - H8000_0000) and R1C127C1_mask
            end If
        else
            read_R1C127C1_value = data_low and R1C127C1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R1C127L0_value = &H0
        flag_R1C127L0        = &H0
        write_R1C127C1_value = &H0
        flag_R1C127C1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_blockaddress
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

Class TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_INSTANCE

    Public reg5g_credit0
    Public reg5g_credit1
    Public reg5g_credit2
    Public reg5g_credit3
    Public reg2p5g_cl127_credit0
    Public reg2p5g_cl127_credit1
    Public reg2p5g_cl127_credit2
    Public reg2p5g_cl127_credit3
    Public reg5g_cl127_credit0
    Public reg5g_cl127_credit1
    Public reg5g_cl127_credit2
    Public reg5g_cl127_credit3
    Public reg1g_cl127_credit0
    Public reg1g_cl127_credit1
    Public reg1g_cl127_credit2
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set reg5g_credit0 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit0)(aBaseAddr, 16)
        Set reg5g_credit1 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit1)(aBaseAddr, 16)
        Set reg5g_credit2 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit2)(aBaseAddr, 16)
        Set reg5g_credit3 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_credit3)(aBaseAddr, 16)
        Set reg2p5g_cl127_credit0 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit0)(aBaseAddr, 16)
        Set reg2p5g_cl127_credit1 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit1)(aBaseAddr, 16)
        Set reg2p5g_cl127_credit2 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit2)(aBaseAddr, 16)
        Set reg2p5g_cl127_credit3 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg2p5g_cl127_credit3)(aBaseAddr, 16)
        Set reg5g_cl127_credit0 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit0)(aBaseAddr, 16)
        Set reg5g_cl127_credit1 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit1)(aBaseAddr, 16)
        Set reg5g_cl127_credit2 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit2)(aBaseAddr, 16)
        Set reg5g_cl127_credit3 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg5g_cl127_credit3)(aBaseAddr, 16)
        Set reg1g_cl127_credit0 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit0)(aBaseAddr, 16)
        Set reg1g_cl127_credit1 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit1)(aBaseAddr, 16)
        Set reg1g_cl127_credit2 = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_reg1g_cl127_credit2)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1.Add ((New TX_X1_CREDIT_GEN3_SGMIIPLUSR_X1_INSTANCE)(&H4aed2500))


