

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


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REG25_CLOC0                                [13:0]           get_REG25_CLOC0
''                                                             set_REG25_CLOC0
''                                                             read_REG25_CLOC0
''                                                             write_REG25_CLOC0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit0
    Private write_REG25_CLOC0_value
    Private read_REG25_CLOC0_value
    Private flag_REG25_CLOC0

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

    Property Get get_REG25_CLOC0
        get_REG25_CLOC0 = read_REG25_CLOC0_value
    End Property

    Property Let set_REG25_CLOC0(aData)
        write_REG25_CLOC0_value = aData
        flag_REG25_CLOC0        = &H1
    End Property

    Property Get read_REG25_CLOC0
        read
        read_REG25_CLOC0 = read_REG25_CLOC0_value
    End Property

    Property Let write_REG25_CLOC0(aData)
        set_REG25_CLOC0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG25_CLOC0_mask = &H3fff
        if data_low > LONG_MAX then
            if REG25_CLOC0_mask = mask then
                read_REG25_CLOC0_value = data_low
            else
                read_REG25_CLOC0_value = (data_low - H8000_0000) and REG25_CLOC0_mask
            end If
        else
            read_REG25_CLOC0_value = data_low and REG25_CLOC0_mask
        end If

    End Sub

    Sub write
        If flag_REG25_CLOC0 = &H0 Then read
        If flag_REG25_CLOC0 = &H0 Then write_REG25_CLOC0_value = get_REG25_CLOC0

        regValue = leftShift((write_REG25_CLOC0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REG25_CLOC0_mask = &H3fff
        if data_low > LONG_MAX then
            if REG25_CLOC0_mask = mask then
                read_REG25_CLOC0_value = data_low
            else
                read_REG25_CLOC0_value = (data_low - H8000_0000) and REG25_CLOC0_mask
            end If
        else
            read_REG25_CLOC0_value = data_low and REG25_CLOC0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REG25_CLOC0_value = &H0
        flag_REG25_CLOC0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg2p5G_CGC                                [12:0]           get_reg2p5G_CGC
''                                                             set_reg2p5G_CGC
''                                                             read_reg2p5G_CGC
''                                                             write_reg2p5G_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit1
    Private write_reg2p5G_CGC_value
    Private read_reg2p5G_CGC_value
    Private flag_reg2p5G_CGC

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

    Property Get get_reg2p5G_CGC
        get_reg2p5G_CGC = read_reg2p5G_CGC_value
    End Property

    Property Let set_reg2p5G_CGC(aData)
        write_reg2p5G_CGC_value = aData
        flag_reg2p5G_CGC        = &H1
    End Property

    Property Get read_reg2p5G_CGC
        read
        read_reg2p5G_CGC = read_reg2p5G_CGC_value
    End Property

    Property Let write_reg2p5G_CGC(aData)
        set_reg2p5G_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg2p5G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg2p5G_CGC_mask = mask then
                read_reg2p5G_CGC_value = data_low
            else
                read_reg2p5G_CGC_value = (data_low - H8000_0000) and reg2p5G_CGC_mask
            end If
        else
            read_reg2p5G_CGC_value = data_low and reg2p5G_CGC_mask
        end If

    End Sub

    Sub write
        If flag_reg2p5G_CGC = &H0 Then read
        If flag_reg2p5G_CGC = &H0 Then write_reg2p5G_CGC_value = get_reg2p5G_CGC

        regValue = leftShift((write_reg2p5G_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg2p5G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg2p5G_CGC_mask = mask then
                read_reg2p5G_CGC_value = data_low
            else
                read_reg2p5G_CGC_value = (data_low - H8000_0000) and reg2p5G_CGC_mask
            end If
        else
            read_reg2p5G_CGC_value = data_low and reg2p5G_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg2p5G_CGC_value = &H0
        flag_reg2p5G_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg2p5G_loopcnt0                           [15:8]           get_reg2p5G_loopcnt0
''                                                             set_reg2p5G_loopcnt0
''                                                             read_reg2p5G_loopcnt0
''                                                             write_reg2p5G_loopcnt0
''---------------------------------------------------------------------------------
'' REG25_CLOC1                                [7:0]            get_REG25_CLOC1
''                                                             set_REG25_CLOC1
''                                                             read_REG25_CLOC1
''                                                             write_REG25_CLOC1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit2
    Private write_reg2p5G_loopcnt0_value
    Private read_reg2p5G_loopcnt0_value
    Private flag_reg2p5G_loopcnt0
    Private write_REG25_CLOC1_value
    Private read_REG25_CLOC1_value
    Private flag_REG25_CLOC1

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

    Property Get get_reg2p5G_loopcnt0
        get_reg2p5G_loopcnt0 = read_reg2p5G_loopcnt0_value
    End Property

    Property Let set_reg2p5G_loopcnt0(aData)
        write_reg2p5G_loopcnt0_value = aData
        flag_reg2p5G_loopcnt0        = &H1
    End Property

    Property Get read_reg2p5G_loopcnt0
        read
        read_reg2p5G_loopcnt0 = read_reg2p5G_loopcnt0_value
    End Property

    Property Let write_reg2p5G_loopcnt0(aData)
        set_reg2p5G_loopcnt0 = aData
        write
    End Property

    Property Get get_REG25_CLOC1
        get_REG25_CLOC1 = read_REG25_CLOC1_value
    End Property

    Property Let set_REG25_CLOC1(aData)
        write_REG25_CLOC1_value = aData
        flag_REG25_CLOC1        = &H1
    End Property

    Property Get read_REG25_CLOC1
        read
        read_REG25_CLOC1 = read_REG25_CLOC1_value
    End Property

    Property Let write_REG25_CLOC1(aData)
        set_REG25_CLOC1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg2p5G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        REG25_CLOC1_mask = &Hff
        if data_low > LONG_MAX then
            if REG25_CLOC1_mask = mask then
                read_REG25_CLOC1_value = data_low
            else
                read_REG25_CLOC1_value = (data_low - H8000_0000) and REG25_CLOC1_mask
            end If
        else
            read_REG25_CLOC1_value = data_low and REG25_CLOC1_mask
        end If

    End Sub

    Sub write
        If flag_reg2p5G_loopcnt0 = &H0 or flag_REG25_CLOC1 = &H0 Then read
        If flag_reg2p5G_loopcnt0 = &H0 Then write_reg2p5G_loopcnt0_value = get_reg2p5G_loopcnt0
        If flag_REG25_CLOC1 = &H0 Then write_REG25_CLOC1_value = get_REG25_CLOC1

        regValue = leftShift((write_reg2p5G_loopcnt0_value and &Hff), 8) + leftShift((write_REG25_CLOC1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg2p5G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        REG25_CLOC1_mask = &Hff
        if data_low > LONG_MAX then
            if REG25_CLOC1_mask = mask then
                read_REG25_CLOC1_value = data_low
            else
                read_REG25_CLOC1_value = (data_low - H8000_0000) and REG25_CLOC1_mask
            end If
        else
            read_REG25_CLOC1_value = data_low and REG25_CLOC1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg2p5G_loopcnt0_value = &H0
        flag_reg2p5G_loopcnt0        = &H0
        write_REG25_CLOC1_value = &H0
        flag_REG25_CLOC1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg2p5G_loopcnt1                           [5:0]            get_reg2p5G_loopcnt1
''                                                             set_reg2p5G_loopcnt1
''                                                             read_reg2p5G_loopcnt1
''                                                             write_reg2p5G_loopcnt1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit3
    Private write_reg2p5G_loopcnt1_value
    Private read_reg2p5G_loopcnt1_value
    Private flag_reg2p5G_loopcnt1

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

    Property Get get_reg2p5G_loopcnt1
        get_reg2p5G_loopcnt1 = read_reg2p5G_loopcnt1_value
    End Property

    Property Let set_reg2p5G_loopcnt1(aData)
        write_reg2p5G_loopcnt1_value = aData
        flag_reg2p5G_loopcnt1        = &H1
    End Property

    Property Get read_reg2p5G_loopcnt1
        read
        read_reg2p5G_loopcnt1 = read_reg2p5G_loopcnt1_value
    End Property

    Property Let write_reg2p5G_loopcnt1(aData)
        set_reg2p5G_loopcnt1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg2p5G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg2p5G_loopcnt1_mask = mask then
                read_reg2p5G_loopcnt1_value = data_low
            else
                read_reg2p5G_loopcnt1_value = (data_low - H8000_0000) and reg2p5G_loopcnt1_mask
            end If
        else
            read_reg2p5G_loopcnt1_value = data_low and reg2p5G_loopcnt1_mask
        end If

    End Sub

    Sub write
        If flag_reg2p5G_loopcnt1 = &H0 Then read
        If flag_reg2p5G_loopcnt1 = &H0 Then write_reg2p5G_loopcnt1_value = get_reg2p5G_loopcnt1

        regValue = leftShift((write_reg2p5G_loopcnt1_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg2p5G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg2p5G_loopcnt1_mask = mask then
                read_reg2p5G_loopcnt1_value = data_low
            else
                read_reg2p5G_loopcnt1_value = (data_low - H8000_0000) and reg2p5G_loopcnt1_mask
            end If
        else
            read_reg2p5G_loopcnt1_value = data_low and reg2p5G_loopcnt1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg2p5G_loopcnt1_value = &H0
        flag_reg2p5G_loopcnt1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10G_ClockCount0                         [13:0]           get_reg10G_ClockCount0
''                                                             set_reg10G_ClockCount0
''                                                             read_reg10G_ClockCount0
''                                                             write_reg10G_ClockCount0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit0
    Private write_reg10G_ClockCount0_value
    Private read_reg10G_ClockCount0_value
    Private flag_reg10G_ClockCount0

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

    Property Get get_reg10G_ClockCount0
        get_reg10G_ClockCount0 = read_reg10G_ClockCount0_value
    End Property

    Property Let set_reg10G_ClockCount0(aData)
        write_reg10G_ClockCount0_value = aData
        flag_reg10G_ClockCount0        = &H1
    End Property

    Property Get read_reg10G_ClockCount0
        read
        read_reg10G_ClockCount0 = read_reg10G_ClockCount0_value
    End Property

    Property Let write_reg10G_ClockCount0(aData)
        set_reg10G_ClockCount0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10G_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg10G_ClockCount0_mask = mask then
                read_reg10G_ClockCount0_value = data_low
            else
                read_reg10G_ClockCount0_value = (data_low - H8000_0000) and reg10G_ClockCount0_mask
            end If
        else
            read_reg10G_ClockCount0_value = data_low and reg10G_ClockCount0_mask
        end If

    End Sub

    Sub write
        If flag_reg10G_ClockCount0 = &H0 Then read
        If flag_reg10G_ClockCount0 = &H0 Then write_reg10G_ClockCount0_value = get_reg10G_ClockCount0

        regValue = leftShift((write_reg10G_ClockCount0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10G_ClockCount0_mask = &H3fff
        if data_low > LONG_MAX then
            if reg10G_ClockCount0_mask = mask then
                read_reg10G_ClockCount0_value = data_low
            else
                read_reg10G_ClockCount0_value = (data_low - H8000_0000) and reg10G_ClockCount0_mask
            end If
        else
            read_reg10G_ClockCount0_value = data_low and reg10G_ClockCount0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10G_ClockCount0_value = &H0
        flag_reg10G_ClockCount0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10G_CGC                                 [12:0]           get_reg10G_CGC
''                                                             set_reg10G_CGC
''                                                             read_reg10G_CGC
''                                                             write_reg10G_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit1
    Private write_reg10G_CGC_value
    Private read_reg10G_CGC_value
    Private flag_reg10G_CGC

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

    Property Get get_reg10G_CGC
        get_reg10G_CGC = read_reg10G_CGC_value
    End Property

    Property Let set_reg10G_CGC(aData)
        write_reg10G_CGC_value = aData
        flag_reg10G_CGC        = &H1
    End Property

    Property Get read_reg10G_CGC
        read
        read_reg10G_CGC = read_reg10G_CGC_value
    End Property

    Property Let write_reg10G_CGC(aData)
        set_reg10G_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg10G_CGC_mask = mask then
                read_reg10G_CGC_value = data_low
            else
                read_reg10G_CGC_value = (data_low - H8000_0000) and reg10G_CGC_mask
            end If
        else
            read_reg10G_CGC_value = data_low and reg10G_CGC_mask
        end If

    End Sub

    Sub write
        If flag_reg10G_CGC = &H0 Then read
        If flag_reg10G_CGC = &H0 Then write_reg10G_CGC_value = get_reg10G_CGC

        regValue = leftShift((write_reg10G_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10G_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if reg10G_CGC_mask = mask then
                read_reg10G_CGC_value = data_low
            else
                read_reg10G_CGC_value = (data_low - H8000_0000) and reg10G_CGC_mask
            end If
        else
            read_reg10G_CGC_value = data_low and reg10G_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10G_CGC_value = &H0
        flag_reg10G_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10G_loopcnt0                            [15:8]           get_reg10G_loopcnt0
''                                                             set_reg10G_loopcnt0
''                                                             read_reg10G_loopcnt0
''                                                             write_reg10G_loopcnt0
''---------------------------------------------------------------------------------
'' reg10G_ClockCount1                         [7:0]            get_reg10G_ClockCount1
''                                                             set_reg10G_ClockCount1
''                                                             read_reg10G_ClockCount1
''                                                             write_reg10G_ClockCount1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit2
    Private write_reg10G_loopcnt0_value
    Private read_reg10G_loopcnt0_value
    Private flag_reg10G_loopcnt0
    Private write_reg10G_ClockCount1_value
    Private read_reg10G_ClockCount1_value
    Private flag_reg10G_ClockCount1

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

    Property Get get_reg10G_loopcnt0
        get_reg10G_loopcnt0 = read_reg10G_loopcnt0_value
    End Property

    Property Let set_reg10G_loopcnt0(aData)
        write_reg10G_loopcnt0_value = aData
        flag_reg10G_loopcnt0        = &H1
    End Property

    Property Get read_reg10G_loopcnt0
        read
        read_reg10G_loopcnt0 = read_reg10G_loopcnt0_value
    End Property

    Property Let write_reg10G_loopcnt0(aData)
        set_reg10G_loopcnt0 = aData
        write
    End Property

    Property Get get_reg10G_ClockCount1
        get_reg10G_ClockCount1 = read_reg10G_ClockCount1_value
    End Property

    Property Let set_reg10G_ClockCount1(aData)
        write_reg10G_ClockCount1_value = aData
        flag_reg10G_ClockCount1        = &H1
    End Property

    Property Get read_reg10G_ClockCount1
        read
        read_reg10G_ClockCount1 = read_reg10G_ClockCount1_value
    End Property

    Property Let write_reg10G_ClockCount1(aData)
        set_reg10G_ClockCount1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg10G_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg10G_ClockCount1_mask = mask then
                read_reg10G_ClockCount1_value = data_low
            else
                read_reg10G_ClockCount1_value = (data_low - H8000_0000) and reg10G_ClockCount1_mask
            end If
        else
            read_reg10G_ClockCount1_value = data_low and reg10G_ClockCount1_mask
        end If

    End Sub

    Sub write
        If flag_reg10G_loopcnt0 = &H0 or flag_reg10G_ClockCount1 = &H0 Then read
        If flag_reg10G_loopcnt0 = &H0 Then write_reg10G_loopcnt0_value = get_reg10G_loopcnt0
        If flag_reg10G_ClockCount1 = &H0 Then write_reg10G_ClockCount1_value = get_reg10G_ClockCount1

        regValue = leftShift((write_reg10G_loopcnt0_value and &Hff), 8) + leftShift((write_reg10G_ClockCount1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg10G_loopcnt0_value = rightShift(data_low, 8) and &Hff
        reg10G_ClockCount1_mask = &Hff
        if data_low > LONG_MAX then
            if reg10G_ClockCount1_mask = mask then
                read_reg10G_ClockCount1_value = data_low
            else
                read_reg10G_ClockCount1_value = (data_low - H8000_0000) and reg10G_ClockCount1_mask
            end If
        else
            read_reg10G_ClockCount1_value = data_low and reg10G_ClockCount1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10G_loopcnt0_value = &H0
        flag_reg10G_loopcnt0        = &H0
        write_reg10G_ClockCount1_value = &H0
        flag_reg10G_ClockCount1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg10G_loopcnt1                            [5:0]            get_reg10G_loopcnt1
''                                                             set_reg10G_loopcnt1
''                                                             read_reg10G_loopcnt1
''                                                             write_reg10G_loopcnt1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit3
    Private write_reg10G_loopcnt1_value
    Private read_reg10G_loopcnt1_value
    Private flag_reg10G_loopcnt1

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

    Property Get get_reg10G_loopcnt1
        get_reg10G_loopcnt1 = read_reg10G_loopcnt1_value
    End Property

    Property Let set_reg10G_loopcnt1(aData)
        write_reg10G_loopcnt1_value = aData
        flag_reg10G_loopcnt1        = &H1
    End Property

    Property Get read_reg10G_loopcnt1
        read
        read_reg10G_loopcnt1 = read_reg10G_loopcnt1_value
    End Property

    Property Let write_reg10G_loopcnt1(aData)
        set_reg10G_loopcnt1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg10G_loopcnt1_mask = mask then
                read_reg10G_loopcnt1_value = data_low
            else
                read_reg10G_loopcnt1_value = (data_low - H8000_0000) and reg10G_loopcnt1_mask
            end If
        else
            read_reg10G_loopcnt1_value = data_low and reg10G_loopcnt1_mask
        end If

    End Sub

    Sub write
        If flag_reg10G_loopcnt1 = &H0 Then read
        If flag_reg10G_loopcnt1 = &H0 Then write_reg10G_loopcnt1_value = get_reg10G_loopcnt1

        regValue = leftShift((write_reg10G_loopcnt1_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reg10G_loopcnt1_mask = &H3f
        if data_low > LONG_MAX then
            if reg10G_loopcnt1_mask = mask then
                read_reg10G_loopcnt1_value = data_low
            else
                read_reg10G_loopcnt1_value = (data_low - H8000_0000) and reg10G_loopcnt1_mask
            end If
        else
            read_reg10G_loopcnt1_value = data_low and reg10G_loopcnt1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg10G_loopcnt1_value = &H0
        flag_reg10G_loopcnt1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_clockcount0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REGU_CLOC0                                 [13:0]           get_REGU_CLOC0
''                                                             set_REGU_CLOC0
''                                                             read_REGU_CLOC0
''                                                             write_REGU_CLOC0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_clockcount0
    Private write_REGU_CLOC0_value
    Private read_REGU_CLOC0_value
    Private flag_REGU_CLOC0

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

    Property Get get_REGU_CLOC0
        get_REGU_CLOC0 = read_REGU_CLOC0_value
    End Property

    Property Let set_REGU_CLOC0(aData)
        write_REGU_CLOC0_value = aData
        flag_REGU_CLOC0        = &H1
    End Property

    Property Get read_REGU_CLOC0
        read
        read_REGU_CLOC0 = read_REGU_CLOC0_value
    End Property

    Property Let write_REGU_CLOC0(aData)
        set_REGU_CLOC0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REGU_CLOC0_mask = &H3fff
        if data_low > LONG_MAX then
            if REGU_CLOC0_mask = mask then
                read_REGU_CLOC0_value = data_low
            else
                read_REGU_CLOC0_value = (data_low - H8000_0000) and REGU_CLOC0_mask
            end If
        else
            read_REGU_CLOC0_value = data_low and REGU_CLOC0_mask
        end If

    End Sub

    Sub write
        If flag_REGU_CLOC0 = &H0 Then read
        If flag_REGU_CLOC0 = &H0 Then write_REGU_CLOC0_value = get_REGU_CLOC0

        regValue = leftShift((write_REGU_CLOC0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REGU_CLOC0_mask = &H3fff
        if data_low > LONG_MAX then
            if REGU_CLOC0_mask = mask then
                read_REGU_CLOC0_value = data_low
            else
                read_REGU_CLOC0_value = (data_low - H8000_0000) and REGU_CLOC0_mask
            end If
        else
            read_REGU_CLOC0_value = data_low and REGU_CLOC0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REGU_CLOC0_value = &H0
        flag_REGU_CLOC0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_pcs_clockcount0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RPC0                                       [13:0]           get_RPC0
''                                                             set_RPC0
''                                                             read_RPC0
''                                                             write_RPC0
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_pcs_clockcount0
    Private write_RPC0_value
    Private read_RPC0_value
    Private flag_RPC0

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

    Property Get get_RPC0
        get_RPC0 = read_RPC0_value
    End Property

    Property Let set_RPC0(aData)
        write_RPC0_value = aData
        flag_RPC0        = &H1
    End Property

    Property Get read_RPC0
        read
        read_RPC0 = read_RPC0_value
    End Property

    Property Let write_RPC0(aData)
        set_RPC0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RPC0_mask = &H3fff
        if data_low > LONG_MAX then
            if RPC0_mask = mask then
                read_RPC0_value = data_low
            else
                read_RPC0_value = (data_low - H8000_0000) and RPC0_mask
            end If
        else
            read_RPC0_value = data_low and RPC0_mask
        end If

    End Sub

    Sub write
        If flag_RPC0 = &H0 Then read
        If flag_RPC0 = &H0 Then write_RPC0_value = get_RPC0

        regValue = leftShift((write_RPC0_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RPC0_mask = &H3fff
        if data_low > LONG_MAX then
            if RPC0_mask = mask then
                read_RPC0_value = data_low
            else
                read_RPC0_value = (data_low - H8000_0000) and RPC0_mask
            end If
        else
            read_RPC0_value = data_low and RPC0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RPC0_value = &H0
        flag_RPC0        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_cgc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' regUserDefinedSpd_CGC                      [12:0]           get_regUserDefinedSpd_CGC
''                                                             set_regUserDefinedSpd_CGC
''                                                             read_regUserDefinedSpd_CGC
''                                                             write_regUserDefinedSpd_CGC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_cgc
    Private write_regUserDefinedSpd_CGC_value
    Private read_regUserDefinedSpd_CGC_value
    Private flag_regUserDefinedSpd_CGC

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

    Property Get get_regUserDefinedSpd_CGC
        get_regUserDefinedSpd_CGC = read_regUserDefinedSpd_CGC_value
    End Property

    Property Let set_regUserDefinedSpd_CGC(aData)
        write_regUserDefinedSpd_CGC_value = aData
        flag_regUserDefinedSpd_CGC        = &H1
    End Property

    Property Get read_regUserDefinedSpd_CGC
        read
        read_regUserDefinedSpd_CGC = read_regUserDefinedSpd_CGC_value
    End Property

    Property Let write_regUserDefinedSpd_CGC(aData)
        set_regUserDefinedSpd_CGC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        regUserDefinedSpd_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if regUserDefinedSpd_CGC_mask = mask then
                read_regUserDefinedSpd_CGC_value = data_low
            else
                read_regUserDefinedSpd_CGC_value = (data_low - H8000_0000) and regUserDefinedSpd_CGC_mask
            end If
        else
            read_regUserDefinedSpd_CGC_value = data_low and regUserDefinedSpd_CGC_mask
        end If

    End Sub

    Sub write
        If flag_regUserDefinedSpd_CGC = &H0 Then read
        If flag_regUserDefinedSpd_CGC = &H0 Then write_regUserDefinedSpd_CGC_value = get_regUserDefinedSpd_CGC

        regValue = leftShift((write_regUserDefinedSpd_CGC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        regUserDefinedSpd_CGC_mask = &H1fff
        if data_low > LONG_MAX then
            if regUserDefinedSpd_CGC_mask = mask then
                read_regUserDefinedSpd_CGC_value = data_low
            else
                read_regUserDefinedSpd_CGC_value = (data_low - H8000_0000) and regUserDefinedSpd_CGC_mask
            end If
        else
            read_regUserDefinedSpd_CGC_value = data_low and regUserDefinedSpd_CGC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_regUserDefinedSpd_CGC_value = &H0
        flag_regUserDefinedSpd_CGC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_pcs_cgc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RPC                                        [12:0]           get_RPC
''                                                             set_RPC
''                                                             read_RPC
''                                                             write_RPC
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_pcs_cgc
    Private write_RPC_value
    Private read_RPC_value
    Private flag_RPC

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

    Property Get get_RPC
        get_RPC = read_RPC_value
    End Property

    Property Let set_RPC(aData)
        write_RPC_value = aData
        flag_RPC        = &H1
    End Property

    Property Get read_RPC
        read
        read_RPC = read_RPC_value
    End Property

    Property Let write_RPC(aData)
        set_RPC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RPC_mask = &H1fff
        if data_low > LONG_MAX then
            if RPC_mask = mask then
                read_RPC_value = data_low
            else
                read_RPC_value = (data_low - H8000_0000) and RPC_mask
            end If
        else
            read_RPC_value = data_low and RPC_mask
        end If

    End Sub

    Sub write
        If flag_RPC = &H0 Then read
        If flag_RPC = &H0 Then write_RPC_value = get_RPC

        regValue = leftShift((write_RPC_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RPC_mask = &H1fff
        if data_low > LONG_MAX then
            if RPC_mask = mask then
                read_RPC_value = data_low
            else
                read_RPC_value = (data_low - H8000_0000) and RPC_mask
            end If
        else
            read_RPC_value = data_low and RPC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RPC_value = &H0
        flag_RPC        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_clockcount1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REGU_CLOC1                                 [7:0]            get_REGU_CLOC1
''                                                             set_REGU_CLOC1
''                                                             read_REGU_CLOC1
''                                                             write_REGU_CLOC1
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_clockcount1
    Private write_REGU_CLOC1_value
    Private read_REGU_CLOC1_value
    Private flag_REGU_CLOC1

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

    Property Get get_REGU_CLOC1
        get_REGU_CLOC1 = read_REGU_CLOC1_value
    End Property

    Property Let set_REGU_CLOC1(aData)
        write_REGU_CLOC1_value = aData
        flag_REGU_CLOC1        = &H1
    End Property

    Property Get read_REGU_CLOC1
        read
        read_REGU_CLOC1 = read_REGU_CLOC1_value
    End Property

    Property Let write_REGU_CLOC1(aData)
        set_REGU_CLOC1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REGU_CLOC1_mask = &Hff
        if data_low > LONG_MAX then
            if REGU_CLOC1_mask = mask then
                read_REGU_CLOC1_value = data_low
            else
                read_REGU_CLOC1_value = (data_low - H8000_0000) and REGU_CLOC1_mask
            end If
        else
            read_REGU_CLOC1_value = data_low and REGU_CLOC1_mask
        end If

    End Sub

    Sub write
        If flag_REGU_CLOC1 = &H0 Then read
        If flag_REGU_CLOC1 = &H0 Then write_REGU_CLOC1_value = get_REGU_CLOC1

        regValue = leftShift((write_REGU_CLOC1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        REGU_CLOC1_mask = &Hff
        if data_low > LONG_MAX then
            if REGU_CLOC1_mask = mask then
                read_REGU_CLOC1_value = data_low
            else
                read_REGU_CLOC1_value = (data_low - H8000_0000) and REGU_CLOC1_mask
            end If
        else
            read_REGU_CLOC1_value = data_low and REGU_CLOC1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REGU_CLOC1_value = &H0
        flag_REGU_CLOC1        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_loopcnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' REGU_LOOP0                                 [13:6]           get_REGU_LOOP0
''                                                             set_REGU_LOOP0
''                                                             read_REGU_LOOP0
''                                                             write_REGU_LOOP0
''---------------------------------------------------------------------------------
'' REGU_LOOP11                                [5:0]            get_REGU_LOOP11
''                                                             set_REGU_LOOP11
''                                                             read_REGU_LOOP11
''                                                             write_REGU_LOOP11
''---------------------------------------------------------------------------------
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_loopcnt
    Private write_REGU_LOOP0_value
    Private read_REGU_LOOP0_value
    Private flag_REGU_LOOP0
    Private write_REGU_LOOP11_value
    Private read_REGU_LOOP11_value
    Private flag_REGU_LOOP11

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

    Property Get get_REGU_LOOP0
        get_REGU_LOOP0 = read_REGU_LOOP0_value
    End Property

    Property Let set_REGU_LOOP0(aData)
        write_REGU_LOOP0_value = aData
        flag_REGU_LOOP0        = &H1
    End Property

    Property Get read_REGU_LOOP0
        read
        read_REGU_LOOP0 = read_REGU_LOOP0_value
    End Property

    Property Let write_REGU_LOOP0(aData)
        set_REGU_LOOP0 = aData
        write
    End Property

    Property Get get_REGU_LOOP11
        get_REGU_LOOP11 = read_REGU_LOOP11_value
    End Property

    Property Let set_REGU_LOOP11(aData)
        write_REGU_LOOP11_value = aData
        flag_REGU_LOOP11        = &H1
    End Property

    Property Get read_REGU_LOOP11
        read
        read_REGU_LOOP11 = read_REGU_LOOP11_value
    End Property

    Property Let write_REGU_LOOP11(aData)
        set_REGU_LOOP11 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_REGU_LOOP0_value = rightShift(data_low, 6) and &Hff
        REGU_LOOP11_mask = &H3f
        if data_low > LONG_MAX then
            if REGU_LOOP11_mask = mask then
                read_REGU_LOOP11_value = data_low
            else
                read_REGU_LOOP11_value = (data_low - H8000_0000) and REGU_LOOP11_mask
            end If
        else
            read_REGU_LOOP11_value = data_low and REGU_LOOP11_mask
        end If

    End Sub

    Sub write
        If flag_REGU_LOOP0 = &H0 or flag_REGU_LOOP11 = &H0 Then read
        If flag_REGU_LOOP0 = &H0 Then write_REGU_LOOP0_value = get_REGU_LOOP0
        If flag_REGU_LOOP11 = &H0 Then write_REGU_LOOP11_value = get_REGU_LOOP11

        regValue = leftShift((write_REGU_LOOP0_value and &Hff), 6) + leftShift((write_REGU_LOOP11_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_REGU_LOOP0_value = rightShift(data_low, 6) and &Hff
        REGU_LOOP11_mask = &H3f
        if data_low > LONG_MAX then
            if REGU_LOOP11_mask = mask then
                read_REGU_LOOP11_value = data_low
            else
                read_REGU_LOOP11_value = (data_low - H8000_0000) and REGU_LOOP11_mask
            end If
        else
            read_REGU_LOOP11_value = data_low and REGU_LOOP11_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_REGU_LOOP0_value = &H0
        flag_REGU_LOOP0        = &H0
        write_REGU_LOOP11_value = &H0
        flag_REGU_LOOP11        = &H0
    End Sub
End Class


'' @REGISTER : TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_blockaddress
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

Class TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_INSTANCE

    Public reg2p5g_credit0
    Public reg2p5g_credit1
    Public reg2p5g_credit2
    Public reg2p5g_credit3
    Public reg10g_credit0
    Public reg10g_credit1
    Public reg10g_credit2
    Public reg10g_credit3
    Public reguserdefinedspd_clockcount0
    Public reguserdefinedspd_pcs_clockcount0
    Public reguserdefinedspd_cgc
    Public reguserdefinedspd_pcs_cgc
    Public reguserdefinedspd_clockcount1
    Public reguserdefinedspd_loopcnt
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set reg2p5g_credit0 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit0)(aBaseAddr, 16)
        Set reg2p5g_credit1 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit1)(aBaseAddr, 16)
        Set reg2p5g_credit2 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit2)(aBaseAddr, 16)
        Set reg2p5g_credit3 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg2p5g_credit3)(aBaseAddr, 16)
        Set reg10g_credit0 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit0)(aBaseAddr, 16)
        Set reg10g_credit1 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit1)(aBaseAddr, 16)
        Set reg10g_credit2 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit2)(aBaseAddr, 16)
        Set reg10g_credit3 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reg10g_credit3)(aBaseAddr, 16)
        Set reguserdefinedspd_clockcount0 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_clockcount0)(aBaseAddr, 16)
        Set reguserdefinedspd_pcs_clockcount0 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_pcs_clockcount0)(aBaseAddr, 16)
        Set reguserdefinedspd_cgc = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_cgc)(aBaseAddr, 16)
        Set reguserdefinedspd_pcs_cgc = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_pcs_cgc)(aBaseAddr, 16)
        Set reguserdefinedspd_clockcount1 = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_clockcount1)(aBaseAddr, 16)
        Set reguserdefinedspd_loopcnt = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_reguserdefinedspd_loopcnt)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1.Add ((New TX_X1_CREDIT_GEN2_SGMIIPLUSR_X1_INSTANCE)(&H4aed24e0))


