

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


'' @REGISTER : AFE_rxconfig_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXCONFIG_15_0                              [15:0]           get_RXCONFIG_15_0
''                                                             set_RXCONFIG_15_0
''                                                             read_RXCONFIG_15_0
''                                                             write_RXCONFIG_15_0
''---------------------------------------------------------------------------------
Class REGISTER_AFE_rxconfig_0
    Private write_RXCONFIG_15_0_value
    Private read_RXCONFIG_15_0_value
    Private flag_RXCONFIG_15_0

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

    Property Get get_RXCONFIG_15_0
        get_RXCONFIG_15_0 = read_RXCONFIG_15_0_value
    End Property

    Property Let set_RXCONFIG_15_0(aData)
        write_RXCONFIG_15_0_value = aData
        flag_RXCONFIG_15_0        = &H1
    End Property

    Property Get read_RXCONFIG_15_0
        read
        read_RXCONFIG_15_0 = read_RXCONFIG_15_0_value
    End Property

    Property Let write_RXCONFIG_15_0(aData)
        set_RXCONFIG_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_15_0_mask = mask then
                read_RXCONFIG_15_0_value = data_low
            else
                read_RXCONFIG_15_0_value = (data_low - H8000_0000) and RXCONFIG_15_0_mask
            end If
        else
            read_RXCONFIG_15_0_value = data_low and RXCONFIG_15_0_mask
        end If

    End Sub

    Sub write
        If flag_RXCONFIG_15_0 = &H0 Then read
        If flag_RXCONFIG_15_0 = &H0 Then write_RXCONFIG_15_0_value = get_RXCONFIG_15_0

        regValue = leftShift((write_RXCONFIG_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_15_0_mask = mask then
                read_RXCONFIG_15_0_value = data_low
            else
                read_RXCONFIG_15_0_value = (data_low - H8000_0000) and RXCONFIG_15_0_mask
            end If
        else
            read_RXCONFIG_15_0_value = data_low and RXCONFIG_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXCONFIG_15_0_value = &H0
        flag_RXCONFIG_15_0        = &H0
    End Sub
End Class


'' @REGISTER : AFE_rxconfig_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXCONFIG_31_23                             [15:0]           get_RXCONFIG_31_23
''                                                             set_RXCONFIG_31_23
''                                                             read_RXCONFIG_31_23
''                                                             write_RXCONFIG_31_23
''---------------------------------------------------------------------------------
Class REGISTER_AFE_rxconfig_1
    Private write_RXCONFIG_31_23_value
    Private read_RXCONFIG_31_23_value
    Private flag_RXCONFIG_31_23

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

    Property Get get_RXCONFIG_31_23
        get_RXCONFIG_31_23 = read_RXCONFIG_31_23_value
    End Property

    Property Let set_RXCONFIG_31_23(aData)
        write_RXCONFIG_31_23_value = aData
        flag_RXCONFIG_31_23        = &H1
    End Property

    Property Get read_RXCONFIG_31_23
        read
        read_RXCONFIG_31_23 = read_RXCONFIG_31_23_value
    End Property

    Property Let write_RXCONFIG_31_23(aData)
        set_RXCONFIG_31_23 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_31_23_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_31_23_mask = mask then
                read_RXCONFIG_31_23_value = data_low
            else
                read_RXCONFIG_31_23_value = (data_low - H8000_0000) and RXCONFIG_31_23_mask
            end If
        else
            read_RXCONFIG_31_23_value = data_low and RXCONFIG_31_23_mask
        end If

    End Sub

    Sub write
        If flag_RXCONFIG_31_23 = &H0 Then read
        If flag_RXCONFIG_31_23 = &H0 Then write_RXCONFIG_31_23_value = get_RXCONFIG_31_23

        regValue = leftShift((write_RXCONFIG_31_23_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_31_23_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_31_23_mask = mask then
                read_RXCONFIG_31_23_value = data_low
            else
                read_RXCONFIG_31_23_value = (data_low - H8000_0000) and RXCONFIG_31_23_mask
            end If
        else
            read_RXCONFIG_31_23_value = data_low and RXCONFIG_31_23_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXCONFIG_31_23_value = &H0
        flag_RXCONFIG_31_23        = &H0
    End Sub
End Class


'' @REGISTER : AFE_rxconfig_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXCONFIG_47_32                             [15:0]           get_RXCONFIG_47_32
''                                                             set_RXCONFIG_47_32
''                                                             read_RXCONFIG_47_32
''                                                             write_RXCONFIG_47_32
''---------------------------------------------------------------------------------
Class REGISTER_AFE_rxconfig_2
    Private write_RXCONFIG_47_32_value
    Private read_RXCONFIG_47_32_value
    Private flag_RXCONFIG_47_32

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

    Property Get get_RXCONFIG_47_32
        get_RXCONFIG_47_32 = read_RXCONFIG_47_32_value
    End Property

    Property Let set_RXCONFIG_47_32(aData)
        write_RXCONFIG_47_32_value = aData
        flag_RXCONFIG_47_32        = &H1
    End Property

    Property Get read_RXCONFIG_47_32
        read
        read_RXCONFIG_47_32 = read_RXCONFIG_47_32_value
    End Property

    Property Let write_RXCONFIG_47_32(aData)
        set_RXCONFIG_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_47_32_mask = mask then
                read_RXCONFIG_47_32_value = data_low
            else
                read_RXCONFIG_47_32_value = (data_low - H8000_0000) and RXCONFIG_47_32_mask
            end If
        else
            read_RXCONFIG_47_32_value = data_low and RXCONFIG_47_32_mask
        end If

    End Sub

    Sub write
        If flag_RXCONFIG_47_32 = &H0 Then read
        If flag_RXCONFIG_47_32 = &H0 Then write_RXCONFIG_47_32_value = get_RXCONFIG_47_32

        regValue = leftShift((write_RXCONFIG_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_47_32_mask = mask then
                read_RXCONFIG_47_32_value = data_low
            else
                read_RXCONFIG_47_32_value = (data_low - H8000_0000) and RXCONFIG_47_32_mask
            end If
        else
            read_RXCONFIG_47_32_value = data_low and RXCONFIG_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXCONFIG_47_32_value = &H0
        flag_RXCONFIG_47_32        = &H0
    End Sub
End Class


'' @REGISTER : AFE_rxconfig_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXCONFIG_63_48                             [15:0]           get_RXCONFIG_63_48
''                                                             set_RXCONFIG_63_48
''                                                             read_RXCONFIG_63_48
''                                                             write_RXCONFIG_63_48
''---------------------------------------------------------------------------------
Class REGISTER_AFE_rxconfig_3
    Private write_RXCONFIG_63_48_value
    Private read_RXCONFIG_63_48_value
    Private flag_RXCONFIG_63_48

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

    Property Get get_RXCONFIG_63_48
        get_RXCONFIG_63_48 = read_RXCONFIG_63_48_value
    End Property

    Property Let set_RXCONFIG_63_48(aData)
        write_RXCONFIG_63_48_value = aData
        flag_RXCONFIG_63_48        = &H1
    End Property

    Property Get read_RXCONFIG_63_48
        read
        read_RXCONFIG_63_48 = read_RXCONFIG_63_48_value
    End Property

    Property Let write_RXCONFIG_63_48(aData)
        set_RXCONFIG_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_63_48_mask = mask then
                read_RXCONFIG_63_48_value = data_low
            else
                read_RXCONFIG_63_48_value = (data_low - H8000_0000) and RXCONFIG_63_48_mask
            end If
        else
            read_RXCONFIG_63_48_value = data_low and RXCONFIG_63_48_mask
        end If

    End Sub

    Sub write
        If flag_RXCONFIG_63_48 = &H0 Then read
        If flag_RXCONFIG_63_48 = &H0 Then write_RXCONFIG_63_48_value = get_RXCONFIG_63_48

        regValue = leftShift((write_RXCONFIG_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_63_48_mask = mask then
                read_RXCONFIG_63_48_value = data_low
            else
                read_RXCONFIG_63_48_value = (data_low - H8000_0000) and RXCONFIG_63_48_mask
            end If
        else
            read_RXCONFIG_63_48_value = data_low and RXCONFIG_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXCONFIG_63_48_value = &H0
        flag_RXCONFIG_63_48        = &H0
    End Sub
End Class


'' @REGISTER : AFE_rxconfig_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXCONFIG_79_64                             [15:0]           get_RXCONFIG_79_64
''                                                             set_RXCONFIG_79_64
''                                                             read_RXCONFIG_79_64
''                                                             write_RXCONFIG_79_64
''---------------------------------------------------------------------------------
Class REGISTER_AFE_rxconfig_4
    Private write_RXCONFIG_79_64_value
    Private read_RXCONFIG_79_64_value
    Private flag_RXCONFIG_79_64

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

    Property Get get_RXCONFIG_79_64
        get_RXCONFIG_79_64 = read_RXCONFIG_79_64_value
    End Property

    Property Let set_RXCONFIG_79_64(aData)
        write_RXCONFIG_79_64_value = aData
        flag_RXCONFIG_79_64        = &H1
    End Property

    Property Get read_RXCONFIG_79_64
        read
        read_RXCONFIG_79_64 = read_RXCONFIG_79_64_value
    End Property

    Property Let write_RXCONFIG_79_64(aData)
        set_RXCONFIG_79_64 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_79_64_mask = mask then
                read_RXCONFIG_79_64_value = data_low
            else
                read_RXCONFIG_79_64_value = (data_low - H8000_0000) and RXCONFIG_79_64_mask
            end If
        else
            read_RXCONFIG_79_64_value = data_low and RXCONFIG_79_64_mask
        end If

    End Sub

    Sub write
        If flag_RXCONFIG_79_64 = &H0 Then read
        If flag_RXCONFIG_79_64 = &H0 Then write_RXCONFIG_79_64_value = get_RXCONFIG_79_64

        regValue = leftShift((write_RXCONFIG_79_64_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCONFIG_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if RXCONFIG_79_64_mask = mask then
                read_RXCONFIG_79_64_value = data_low
            else
                read_RXCONFIG_79_64_value = (data_low - H8000_0000) and RXCONFIG_79_64_mask
            end If
        else
            read_RXCONFIG_79_64_value = data_low and RXCONFIG_79_64_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXCONFIG_79_64_value = &H0
        flag_RXCONFIG_79_64        = &H0
    End Sub
End Class


'' @REGISTER : AFE_rxconfig5_lp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXCONFIG_86_80                             [15:9]           get_RXCONFIG_86_80
''                                                             set_RXCONFIG_86_80
''                                                             read_RXCONFIG_86_80
''                                                             write_RXCONFIG_86_80
''---------------------------------------------------------------------------------
'' RX_LP_0                                    [8:6]            get_RX_LP_0
''                                                             set_RX_LP_0
''                                                             read_RX_LP_0
''                                                             write_RX_LP_0
''---------------------------------------------------------------------------------
'' RX_LP_1                                    [5:3]            get_RX_LP_1
''                                                             set_RX_LP_1
''                                                             read_RX_LP_1
''                                                             write_RX_LP_1
''---------------------------------------------------------------------------------
'' MODE_force                                 [2:0]            get_MODE_force
''                                                             set_MODE_force
''                                                             read_MODE_force
''                                                             write_MODE_force
''---------------------------------------------------------------------------------
Class REGISTER_AFE_rxconfig5_lp
    Private write_RXCONFIG_86_80_value
    Private read_RXCONFIG_86_80_value
    Private flag_RXCONFIG_86_80
    Private write_RX_LP_0_value
    Private read_RX_LP_0_value
    Private flag_RX_LP_0
    Private write_RX_LP_1_value
    Private read_RX_LP_1_value
    Private flag_RX_LP_1
    Private write_MODE_force_value
    Private read_MODE_force_value
    Private flag_MODE_force

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

    Property Get get_RXCONFIG_86_80
        get_RXCONFIG_86_80 = read_RXCONFIG_86_80_value
    End Property

    Property Let set_RXCONFIG_86_80(aData)
        write_RXCONFIG_86_80_value = aData
        flag_RXCONFIG_86_80        = &H1
    End Property

    Property Get read_RXCONFIG_86_80
        read
        read_RXCONFIG_86_80 = read_RXCONFIG_86_80_value
    End Property

    Property Let write_RXCONFIG_86_80(aData)
        set_RXCONFIG_86_80 = aData
        write
    End Property

    Property Get get_RX_LP_0
        get_RX_LP_0 = read_RX_LP_0_value
    End Property

    Property Let set_RX_LP_0(aData)
        write_RX_LP_0_value = aData
        flag_RX_LP_0        = &H1
    End Property

    Property Get read_RX_LP_0
        read
        read_RX_LP_0 = read_RX_LP_0_value
    End Property

    Property Let write_RX_LP_0(aData)
        set_RX_LP_0 = aData
        write
    End Property

    Property Get get_RX_LP_1
        get_RX_LP_1 = read_RX_LP_1_value
    End Property

    Property Let set_RX_LP_1(aData)
        write_RX_LP_1_value = aData
        flag_RX_LP_1        = &H1
    End Property

    Property Get read_RX_LP_1
        read
        read_RX_LP_1 = read_RX_LP_1_value
    End Property

    Property Let write_RX_LP_1(aData)
        set_RX_LP_1 = aData
        write
    End Property

    Property Get get_MODE_force
        get_MODE_force = read_MODE_force_value
    End Property

    Property Let set_MODE_force(aData)
        write_MODE_force_value = aData
        flag_MODE_force        = &H1
    End Property

    Property Get read_MODE_force
        read
        read_MODE_force = read_MODE_force_value
    End Property

    Property Let write_MODE_force(aData)
        set_MODE_force = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RXCONFIG_86_80_value = rightShift(data_low, 9) and &H7f
        read_RX_LP_0_value = rightShift(data_low, 6) and &H7
        read_RX_LP_1_value = rightShift(data_low, 3) and &H7
        MODE_force_mask = &H7
        if data_low > LONG_MAX then
            if MODE_force_mask = mask then
                read_MODE_force_value = data_low
            else
                read_MODE_force_value = (data_low - H8000_0000) and MODE_force_mask
            end If
        else
            read_MODE_force_value = data_low and MODE_force_mask
        end If

    End Sub

    Sub write
        If flag_RXCONFIG_86_80 = &H0 or flag_RX_LP_0 = &H0 or flag_RX_LP_1 = &H0 or flag_MODE_force = &H0 Then read
        If flag_RXCONFIG_86_80 = &H0 Then write_RXCONFIG_86_80_value = get_RXCONFIG_86_80
        If flag_RX_LP_0 = &H0 Then write_RX_LP_0_value = get_RX_LP_0
        If flag_RX_LP_1 = &H0 Then write_RX_LP_1_value = get_RX_LP_1
        If flag_MODE_force = &H0 Then write_MODE_force_value = get_MODE_force

        regValue = leftShift((write_RXCONFIG_86_80_value and &H7f), 9) + leftShift((write_RX_LP_0_value and &H7), 6) + leftShift((write_RX_LP_1_value and &H7), 3) + leftShift((write_MODE_force_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RXCONFIG_86_80_value = rightShift(data_low, 9) and &H7f
        read_RX_LP_0_value = rightShift(data_low, 6) and &H7
        read_RX_LP_1_value = rightShift(data_low, 3) and &H7
        MODE_force_mask = &H7
        if data_low > LONG_MAX then
            if MODE_force_mask = mask then
                read_MODE_force_value = data_low
            else
                read_MODE_force_value = (data_low - H8000_0000) and MODE_force_mask
            end If
        else
            read_MODE_force_value = data_low and MODE_force_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXCONFIG_86_80_value = &H0
        flag_RXCONFIG_86_80        = &H0
        write_RX_LP_0_value = &H0
        flag_RX_LP_0        = &H0
        write_RX_LP_1_value = &H0
        flag_RX_LP_1        = &H0
        write_MODE_force_value = &H0
        flag_MODE_force        = &H0
    End Sub
End Class


'' @REGISTER : AFE_tx_config_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_CONFIG_15_0                             [15:0]           get_TX_CONFIG_15_0
''                                                             set_TX_CONFIG_15_0
''                                                             read_TX_CONFIG_15_0
''                                                             write_TX_CONFIG_15_0
''---------------------------------------------------------------------------------
Class REGISTER_AFE_tx_config_0
    Private write_TX_CONFIG_15_0_value
    Private read_TX_CONFIG_15_0_value
    Private flag_TX_CONFIG_15_0

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

    Property Get get_TX_CONFIG_15_0
        get_TX_CONFIG_15_0 = read_TX_CONFIG_15_0_value
    End Property

    Property Let set_TX_CONFIG_15_0(aData)
        write_TX_CONFIG_15_0_value = aData
        flag_TX_CONFIG_15_0        = &H1
    End Property

    Property Get read_TX_CONFIG_15_0
        read
        read_TX_CONFIG_15_0 = read_TX_CONFIG_15_0_value
    End Property

    Property Let write_TX_CONFIG_15_0(aData)
        set_TX_CONFIG_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_CONFIG_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_CONFIG_15_0_mask = mask then
                read_TX_CONFIG_15_0_value = data_low
            else
                read_TX_CONFIG_15_0_value = (data_low - H8000_0000) and TX_CONFIG_15_0_mask
            end If
        else
            read_TX_CONFIG_15_0_value = data_low and TX_CONFIG_15_0_mask
        end If

    End Sub

    Sub write
        If flag_TX_CONFIG_15_0 = &H0 Then read
        If flag_TX_CONFIG_15_0 = &H0 Then write_TX_CONFIG_15_0_value = get_TX_CONFIG_15_0

        regValue = leftShift((write_TX_CONFIG_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_CONFIG_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_CONFIG_15_0_mask = mask then
                read_TX_CONFIG_15_0_value = data_low
            else
                read_TX_CONFIG_15_0_value = (data_low - H8000_0000) and TX_CONFIG_15_0_mask
            end If
        else
            read_TX_CONFIG_15_0_value = data_low and TX_CONFIG_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_CONFIG_15_0_value = &H0
        flag_TX_CONFIG_15_0        = &H0
    End Sub
End Class


'' @REGISTER : AFE_tx_config_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_BW_TUNE                                 [15:11]          get_TX_BW_TUNE
''                                                             set_TX_BW_TUNE
''                                                             read_TX_BW_TUNE
''                                                             write_TX_BW_TUNE
''---------------------------------------------------------------------------------
'' TX_CONFIG_26_16                            [10:0]           get_TX_CONFIG_26_16
''                                                             set_TX_CONFIG_26_16
''                                                             read_TX_CONFIG_26_16
''                                                             write_TX_CONFIG_26_16
''---------------------------------------------------------------------------------
Class REGISTER_AFE_tx_config_1
    Private write_TX_BW_TUNE_value
    Private read_TX_BW_TUNE_value
    Private flag_TX_BW_TUNE
    Private write_TX_CONFIG_26_16_value
    Private read_TX_CONFIG_26_16_value
    Private flag_TX_CONFIG_26_16

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

    Property Get get_TX_BW_TUNE
        get_TX_BW_TUNE = read_TX_BW_TUNE_value
    End Property

    Property Let set_TX_BW_TUNE(aData)
        write_TX_BW_TUNE_value = aData
        flag_TX_BW_TUNE        = &H1
    End Property

    Property Get read_TX_BW_TUNE
        read
        read_TX_BW_TUNE = read_TX_BW_TUNE_value
    End Property

    Property Let write_TX_BW_TUNE(aData)
        set_TX_BW_TUNE = aData
        write
    End Property

    Property Get get_TX_CONFIG_26_16
        get_TX_CONFIG_26_16 = read_TX_CONFIG_26_16_value
    End Property

    Property Let set_TX_CONFIG_26_16(aData)
        write_TX_CONFIG_26_16_value = aData
        flag_TX_CONFIG_26_16        = &H1
    End Property

    Property Get read_TX_CONFIG_26_16
        read
        read_TX_CONFIG_26_16 = read_TX_CONFIG_26_16_value
    End Property

    Property Let write_TX_CONFIG_26_16(aData)
        set_TX_CONFIG_26_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_BW_TUNE_value = rightShift(data_low, 11) and &H1f
        TX_CONFIG_26_16_mask = &H7ff
        if data_low > LONG_MAX then
            if TX_CONFIG_26_16_mask = mask then
                read_TX_CONFIG_26_16_value = data_low
            else
                read_TX_CONFIG_26_16_value = (data_low - H8000_0000) and TX_CONFIG_26_16_mask
            end If
        else
            read_TX_CONFIG_26_16_value = data_low and TX_CONFIG_26_16_mask
        end If

    End Sub

    Sub write
        If flag_TX_BW_TUNE = &H0 or flag_TX_CONFIG_26_16 = &H0 Then read
        If flag_TX_BW_TUNE = &H0 Then write_TX_BW_TUNE_value = get_TX_BW_TUNE
        If flag_TX_CONFIG_26_16 = &H0 Then write_TX_CONFIG_26_16_value = get_TX_CONFIG_26_16

        regValue = leftShift((write_TX_BW_TUNE_value and &H1f), 11) + leftShift((write_TX_CONFIG_26_16_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_BW_TUNE_value = rightShift(data_low, 11) and &H1f
        TX_CONFIG_26_16_mask = &H7ff
        if data_low > LONG_MAX then
            if TX_CONFIG_26_16_mask = mask then
                read_TX_CONFIG_26_16_value = data_low
            else
                read_TX_CONFIG_26_16_value = (data_low - H8000_0000) and TX_CONFIG_26_16_mask
            end If
        else
            read_TX_CONFIG_26_16_value = data_low and TX_CONFIG_26_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_BW_TUNE_value = &H0
        flag_TX_BW_TUNE        = &H0
        write_TX_CONFIG_26_16_value = &H0
        flag_TX_CONFIG_26_16        = &H0
    End Sub
End Class


'' @REGISTER : AFE_vdac_ictrl_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VDAC_current_ctrl_15_0                     [15:0]           get_VDAC_current_ctrl_15_0
''                                                             set_VDAC_current_ctrl_15_0
''                                                             read_VDAC_current_ctrl_15_0
''                                                             write_VDAC_current_ctrl_15_0
''---------------------------------------------------------------------------------
Class REGISTER_AFE_vdac_ictrl_0
    Private write_VDAC_current_ctrl_15_0_value
    Private read_VDAC_current_ctrl_15_0_value
    Private flag_VDAC_current_ctrl_15_0

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

    Property Get get_VDAC_current_ctrl_15_0
        get_VDAC_current_ctrl_15_0 = read_VDAC_current_ctrl_15_0_value
    End Property

    Property Let set_VDAC_current_ctrl_15_0(aData)
        write_VDAC_current_ctrl_15_0_value = aData
        flag_VDAC_current_ctrl_15_0        = &H1
    End Property

    Property Get read_VDAC_current_ctrl_15_0
        read
        read_VDAC_current_ctrl_15_0 = read_VDAC_current_ctrl_15_0_value
    End Property

    Property Let write_VDAC_current_ctrl_15_0(aData)
        set_VDAC_current_ctrl_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VDAC_current_ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if VDAC_current_ctrl_15_0_mask = mask then
                read_VDAC_current_ctrl_15_0_value = data_low
            else
                read_VDAC_current_ctrl_15_0_value = (data_low - H8000_0000) and VDAC_current_ctrl_15_0_mask
            end If
        else
            read_VDAC_current_ctrl_15_0_value = data_low and VDAC_current_ctrl_15_0_mask
        end If

    End Sub

    Sub write
        If flag_VDAC_current_ctrl_15_0 = &H0 Then read
        If flag_VDAC_current_ctrl_15_0 = &H0 Then write_VDAC_current_ctrl_15_0_value = get_VDAC_current_ctrl_15_0

        regValue = leftShift((write_VDAC_current_ctrl_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VDAC_current_ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if VDAC_current_ctrl_15_0_mask = mask then
                read_VDAC_current_ctrl_15_0_value = data_low
            else
                read_VDAC_current_ctrl_15_0_value = (data_low - H8000_0000) and VDAC_current_ctrl_15_0_mask
            end If
        else
            read_VDAC_current_ctrl_15_0_value = data_low and VDAC_current_ctrl_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VDAC_current_ctrl_15_0_value = &H0
        flag_VDAC_current_ctrl_15_0        = &H0
    End Sub
End Class


'' @REGISTER : AFE_vdac_ictrl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VDAC_current_ctrl_31_16                    [15:0]           get_VDAC_current_ctrl_31_16
''                                                             set_VDAC_current_ctrl_31_16
''                                                             read_VDAC_current_ctrl_31_16
''                                                             write_VDAC_current_ctrl_31_16
''---------------------------------------------------------------------------------
Class REGISTER_AFE_vdac_ictrl_1
    Private write_VDAC_current_ctrl_31_16_value
    Private read_VDAC_current_ctrl_31_16_value
    Private flag_VDAC_current_ctrl_31_16

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

    Property Get get_VDAC_current_ctrl_31_16
        get_VDAC_current_ctrl_31_16 = read_VDAC_current_ctrl_31_16_value
    End Property

    Property Let set_VDAC_current_ctrl_31_16(aData)
        write_VDAC_current_ctrl_31_16_value = aData
        flag_VDAC_current_ctrl_31_16        = &H1
    End Property

    Property Get read_VDAC_current_ctrl_31_16
        read
        read_VDAC_current_ctrl_31_16 = read_VDAC_current_ctrl_31_16_value
    End Property

    Property Let write_VDAC_current_ctrl_31_16(aData)
        set_VDAC_current_ctrl_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VDAC_current_ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if VDAC_current_ctrl_31_16_mask = mask then
                read_VDAC_current_ctrl_31_16_value = data_low
            else
                read_VDAC_current_ctrl_31_16_value = (data_low - H8000_0000) and VDAC_current_ctrl_31_16_mask
            end If
        else
            read_VDAC_current_ctrl_31_16_value = data_low and VDAC_current_ctrl_31_16_mask
        end If

    End Sub

    Sub write
        If flag_VDAC_current_ctrl_31_16 = &H0 Then read
        If flag_VDAC_current_ctrl_31_16 = &H0 Then write_VDAC_current_ctrl_31_16_value = get_VDAC_current_ctrl_31_16

        regValue = leftShift((write_VDAC_current_ctrl_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VDAC_current_ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if VDAC_current_ctrl_31_16_mask = mask then
                read_VDAC_current_ctrl_31_16_value = data_low
            else
                read_VDAC_current_ctrl_31_16_value = (data_low - H8000_0000) and VDAC_current_ctrl_31_16_mask
            end If
        else
            read_VDAC_current_ctrl_31_16_value = data_low and VDAC_current_ctrl_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VDAC_current_ctrl_31_16_value = &H0
        flag_VDAC_current_ctrl_31_16        = &H0
    End Sub
End Class


'' @REGISTER : AFE_vdac_ictrl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VDAC_current_ctrl_51_36                    [15:0]           get_VDAC_current_ctrl_51_36
''                                                             set_VDAC_current_ctrl_51_36
''                                                             read_VDAC_current_ctrl_51_36
''                                                             write_VDAC_current_ctrl_51_36
''---------------------------------------------------------------------------------
Class REGISTER_AFE_vdac_ictrl_2
    Private write_VDAC_current_ctrl_51_36_value
    Private read_VDAC_current_ctrl_51_36_value
    Private flag_VDAC_current_ctrl_51_36

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

    Property Get get_VDAC_current_ctrl_51_36
        get_VDAC_current_ctrl_51_36 = read_VDAC_current_ctrl_51_36_value
    End Property

    Property Let set_VDAC_current_ctrl_51_36(aData)
        write_VDAC_current_ctrl_51_36_value = aData
        flag_VDAC_current_ctrl_51_36        = &H1
    End Property

    Property Get read_VDAC_current_ctrl_51_36
        read
        read_VDAC_current_ctrl_51_36 = read_VDAC_current_ctrl_51_36_value
    End Property

    Property Let write_VDAC_current_ctrl_51_36(aData)
        set_VDAC_current_ctrl_51_36 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VDAC_current_ctrl_51_36_mask = &Hffff
        if data_low > LONG_MAX then
            if VDAC_current_ctrl_51_36_mask = mask then
                read_VDAC_current_ctrl_51_36_value = data_low
            else
                read_VDAC_current_ctrl_51_36_value = (data_low - H8000_0000) and VDAC_current_ctrl_51_36_mask
            end If
        else
            read_VDAC_current_ctrl_51_36_value = data_low and VDAC_current_ctrl_51_36_mask
        end If

    End Sub

    Sub write
        If flag_VDAC_current_ctrl_51_36 = &H0 Then read
        If flag_VDAC_current_ctrl_51_36 = &H0 Then write_VDAC_current_ctrl_51_36_value = get_VDAC_current_ctrl_51_36

        regValue = leftShift((write_VDAC_current_ctrl_51_36_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VDAC_current_ctrl_51_36_mask = &Hffff
        if data_low > LONG_MAX then
            if VDAC_current_ctrl_51_36_mask = mask then
                read_VDAC_current_ctrl_51_36_value = data_low
            else
                read_VDAC_current_ctrl_51_36_value = (data_low - H8000_0000) and VDAC_current_ctrl_51_36_mask
            end If
        else
            read_VDAC_current_ctrl_51_36_value = data_low and VDAC_current_ctrl_51_36_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VDAC_current_ctrl_51_36_value = &H0
        flag_VDAC_current_ctrl_51_36        = &H0
    End Sub
End Class


'' @REGISTER : AFE_vdac_others_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' current_ctrl_35_32_others                  [15:0]           get_current_ctrl_35_32_others
''                                                             set_current_ctrl_35_32_others
''                                                             read_current_ctrl_35_32_others
''                                                             write_current_ctrl_35_32_others
''---------------------------------------------------------------------------------
Class REGISTER_AFE_vdac_others_0
    Private write_current_ctrl_35_32_others_value
    Private read_current_ctrl_35_32_others_value
    Private flag_current_ctrl_35_32_others

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

    Property Get get_current_ctrl_35_32_others
        get_current_ctrl_35_32_others = read_current_ctrl_35_32_others_value
    End Property

    Property Let set_current_ctrl_35_32_others(aData)
        write_current_ctrl_35_32_others_value = aData
        flag_current_ctrl_35_32_others        = &H1
    End Property

    Property Get read_current_ctrl_35_32_others
        read
        read_current_ctrl_35_32_others = read_current_ctrl_35_32_others_value
    End Property

    Property Let write_current_ctrl_35_32_others(aData)
        set_current_ctrl_35_32_others = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        current_ctrl_35_32_others_mask = &Hffff
        if data_low > LONG_MAX then
            if current_ctrl_35_32_others_mask = mask then
                read_current_ctrl_35_32_others_value = data_low
            else
                read_current_ctrl_35_32_others_value = (data_low - H8000_0000) and current_ctrl_35_32_others_mask
            end If
        else
            read_current_ctrl_35_32_others_value = data_low and current_ctrl_35_32_others_mask
        end If

    End Sub

    Sub write
        If flag_current_ctrl_35_32_others = &H0 Then read
        If flag_current_ctrl_35_32_others = &H0 Then write_current_ctrl_35_32_others_value = get_current_ctrl_35_32_others

        regValue = leftShift((write_current_ctrl_35_32_others_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        current_ctrl_35_32_others_mask = &Hffff
        if data_low > LONG_MAX then
            if current_ctrl_35_32_others_mask = mask then
                read_current_ctrl_35_32_others_value = data_low
            else
                read_current_ctrl_35_32_others_value = (data_low - H8000_0000) and current_ctrl_35_32_others_mask
            end If
        else
            read_current_ctrl_35_32_others_value = data_low and current_ctrl_35_32_others_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_current_ctrl_35_32_others_value = &H0
        flag_current_ctrl_35_32_others        = &H0
    End Sub
End Class


'' @REGISTER : AFE_hpf_trim_others
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:10]          get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' RX_SAMPLE_WIDTH                            [9:7]            get_RX_SAMPLE_WIDTH
''                                                             set_RX_SAMPLE_WIDTH
''                                                             read_RX_SAMPLE_WIDTH
''                                                             write_RX_SAMPLE_WIDTH
''---------------------------------------------------------------------------------
'' IDAC_fine_tune                             [6:4]            get_IDAC_fine_tune
''                                                             set_IDAC_fine_tune
''                                                             read_IDAC_fine_tune
''                                                             write_IDAC_fine_tune
''---------------------------------------------------------------------------------
'' SOFT_SEL_TRIM_HPF                          [3:3]            get_SOFT_SEL_TRIM_HPF
''                                                             set_SOFT_SEL_TRIM_HPF
''                                                             read_SOFT_SEL_TRIM_HPF
''                                                             write_SOFT_SEL_TRIM_HPF
''---------------------------------------------------------------------------------
'' TRIM_HPF                                   [2:0]            get_TRIM_HPF
''                                                             set_TRIM_HPF
''                                                             read_TRIM_HPF
''                                                             write_TRIM_HPF
''---------------------------------------------------------------------------------
Class REGISTER_AFE_hpf_trim_others
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_RX_SAMPLE_WIDTH_value
    Private read_RX_SAMPLE_WIDTH_value
    Private flag_RX_SAMPLE_WIDTH
    Private write_IDAC_fine_tune_value
    Private read_IDAC_fine_tune_value
    Private flag_IDAC_fine_tune
    Private write_SOFT_SEL_TRIM_HPF_value
    Private read_SOFT_SEL_TRIM_HPF_value
    Private flag_SOFT_SEL_TRIM_HPF
    Private write_TRIM_HPF_value
    Private read_TRIM_HPF_value
    Private flag_TRIM_HPF

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_RX_SAMPLE_WIDTH
        get_RX_SAMPLE_WIDTH = read_RX_SAMPLE_WIDTH_value
    End Property

    Property Let set_RX_SAMPLE_WIDTH(aData)
        write_RX_SAMPLE_WIDTH_value = aData
        flag_RX_SAMPLE_WIDTH        = &H1
    End Property

    Property Get read_RX_SAMPLE_WIDTH
        read
        read_RX_SAMPLE_WIDTH = read_RX_SAMPLE_WIDTH_value
    End Property

    Property Let write_RX_SAMPLE_WIDTH(aData)
        set_RX_SAMPLE_WIDTH = aData
        write
    End Property

    Property Get get_IDAC_fine_tune
        get_IDAC_fine_tune = read_IDAC_fine_tune_value
    End Property

    Property Let set_IDAC_fine_tune(aData)
        write_IDAC_fine_tune_value = aData
        flag_IDAC_fine_tune        = &H1
    End Property

    Property Get read_IDAC_fine_tune
        read
        read_IDAC_fine_tune = read_IDAC_fine_tune_value
    End Property

    Property Let write_IDAC_fine_tune(aData)
        set_IDAC_fine_tune = aData
        write
    End Property

    Property Get get_SOFT_SEL_TRIM_HPF
        get_SOFT_SEL_TRIM_HPF = read_SOFT_SEL_TRIM_HPF_value
    End Property

    Property Let set_SOFT_SEL_TRIM_HPF(aData)
        write_SOFT_SEL_TRIM_HPF_value = aData
        flag_SOFT_SEL_TRIM_HPF        = &H1
    End Property

    Property Get read_SOFT_SEL_TRIM_HPF
        read
        read_SOFT_SEL_TRIM_HPF = read_SOFT_SEL_TRIM_HPF_value
    End Property

    Property Let write_SOFT_SEL_TRIM_HPF(aData)
        set_SOFT_SEL_TRIM_HPF = aData
        write
    End Property

    Property Get get_TRIM_HPF
        get_TRIM_HPF = read_TRIM_HPF_value
    End Property

    Property Let set_TRIM_HPF(aData)
        write_TRIM_HPF_value = aData
        flag_TRIM_HPF        = &H1
    End Property

    Property Get read_TRIM_HPF
        read
        read_TRIM_HPF = read_TRIM_HPF_value
    End Property

    Property Let write_TRIM_HPF(aData)
        set_TRIM_HPF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 10) and &H3f
        read_RX_SAMPLE_WIDTH_value = rightShift(data_low, 7) and &H7
        read_IDAC_fine_tune_value = rightShift(data_low, 4) and &H7
        read_SOFT_SEL_TRIM_HPF_value = rightShift(data_low, 3) and &H1
        TRIM_HPF_mask = &H7
        if data_low > LONG_MAX then
            if TRIM_HPF_mask = mask then
                read_TRIM_HPF_value = data_low
            else
                read_TRIM_HPF_value = (data_low - H8000_0000) and TRIM_HPF_mask
            end If
        else
            read_TRIM_HPF_value = data_low and TRIM_HPF_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 or flag_RX_SAMPLE_WIDTH = &H0 or flag_IDAC_fine_tune = &H0 or flag_SOFT_SEL_TRIM_HPF = &H0 or flag_TRIM_HPF = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_RX_SAMPLE_WIDTH = &H0 Then write_RX_SAMPLE_WIDTH_value = get_RX_SAMPLE_WIDTH
        If flag_IDAC_fine_tune = &H0 Then write_IDAC_fine_tune_value = get_IDAC_fine_tune
        If flag_SOFT_SEL_TRIM_HPF = &H0 Then write_SOFT_SEL_TRIM_HPF_value = get_SOFT_SEL_TRIM_HPF
        If flag_TRIM_HPF = &H0 Then write_TRIM_HPF_value = get_TRIM_HPF

        regValue = leftShift((write_Reserved_value and &H3f), 10) + leftShift((write_RX_SAMPLE_WIDTH_value and &H7), 7) + leftShift((write_IDAC_fine_tune_value and &H7), 4) + leftShift((write_SOFT_SEL_TRIM_HPF_value and &H1), 3) + leftShift((write_TRIM_HPF_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 10) and &H3f
        read_RX_SAMPLE_WIDTH_value = rightShift(data_low, 7) and &H7
        read_IDAC_fine_tune_value = rightShift(data_low, 4) and &H7
        read_SOFT_SEL_TRIM_HPF_value = rightShift(data_low, 3) and &H1
        TRIM_HPF_mask = &H7
        if data_low > LONG_MAX then
            if TRIM_HPF_mask = mask then
                read_TRIM_HPF_value = data_low
            else
                read_TRIM_HPF_value = (data_low - H8000_0000) and TRIM_HPF_mask
            end If
        else
            read_TRIM_HPF_value = data_low and TRIM_HPF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_RX_SAMPLE_WIDTH_value = &H0
        flag_RX_SAMPLE_WIDTH        = &H0
        write_IDAC_fine_tune_value = &H0
        flag_IDAC_fine_tune        = &H0
        write_SOFT_SEL_TRIM_HPF_value = &H0
        flag_SOFT_SEL_TRIM_HPF        = &H0
        write_TRIM_HPF_value = &H0
        flag_TRIM_HPF        = &H0
    End Sub
End Class


'' @REGISTER : AFE_tx_extra_config_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_EXTRA_CONFIG_15_0                       [15:0]           get_TX_EXTRA_CONFIG_15_0
''                                                             set_TX_EXTRA_CONFIG_15_0
''                                                             read_TX_EXTRA_CONFIG_15_0
''                                                             write_TX_EXTRA_CONFIG_15_0
''---------------------------------------------------------------------------------
Class REGISTER_AFE_tx_extra_config_0
    Private write_TX_EXTRA_CONFIG_15_0_value
    Private read_TX_EXTRA_CONFIG_15_0_value
    Private flag_TX_EXTRA_CONFIG_15_0

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

    Property Get get_TX_EXTRA_CONFIG_15_0
        get_TX_EXTRA_CONFIG_15_0 = read_TX_EXTRA_CONFIG_15_0_value
    End Property

    Property Let set_TX_EXTRA_CONFIG_15_0(aData)
        write_TX_EXTRA_CONFIG_15_0_value = aData
        flag_TX_EXTRA_CONFIG_15_0        = &H1
    End Property

    Property Get read_TX_EXTRA_CONFIG_15_0
        read
        read_TX_EXTRA_CONFIG_15_0 = read_TX_EXTRA_CONFIG_15_0_value
    End Property

    Property Let write_TX_EXTRA_CONFIG_15_0(aData)
        set_TX_EXTRA_CONFIG_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_EXTRA_CONFIG_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_EXTRA_CONFIG_15_0_mask = mask then
                read_TX_EXTRA_CONFIG_15_0_value = data_low
            else
                read_TX_EXTRA_CONFIG_15_0_value = (data_low - H8000_0000) and TX_EXTRA_CONFIG_15_0_mask
            end If
        else
            read_TX_EXTRA_CONFIG_15_0_value = data_low and TX_EXTRA_CONFIG_15_0_mask
        end If

    End Sub

    Sub write
        If flag_TX_EXTRA_CONFIG_15_0 = &H0 Then read
        If flag_TX_EXTRA_CONFIG_15_0 = &H0 Then write_TX_EXTRA_CONFIG_15_0_value = get_TX_EXTRA_CONFIG_15_0

        regValue = leftShift((write_TX_EXTRA_CONFIG_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_EXTRA_CONFIG_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_EXTRA_CONFIG_15_0_mask = mask then
                read_TX_EXTRA_CONFIG_15_0_value = data_low
            else
                read_TX_EXTRA_CONFIG_15_0_value = (data_low - H8000_0000) and TX_EXTRA_CONFIG_15_0_mask
            end If
        else
            read_TX_EXTRA_CONFIG_15_0_value = data_low and TX_EXTRA_CONFIG_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_EXTRA_CONFIG_15_0_value = &H0
        flag_TX_EXTRA_CONFIG_15_0        = &H0
    End Sub
End Class


'' @REGISTER : AFE_tx_extra_config_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_EXTRA_CONFIG_31_16                      [15:0]           get_TX_EXTRA_CONFIG_31_16
''                                                             set_TX_EXTRA_CONFIG_31_16
''                                                             read_TX_EXTRA_CONFIG_31_16
''                                                             write_TX_EXTRA_CONFIG_31_16
''---------------------------------------------------------------------------------
Class REGISTER_AFE_tx_extra_config_1
    Private write_TX_EXTRA_CONFIG_31_16_value
    Private read_TX_EXTRA_CONFIG_31_16_value
    Private flag_TX_EXTRA_CONFIG_31_16

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

    Property Get get_TX_EXTRA_CONFIG_31_16
        get_TX_EXTRA_CONFIG_31_16 = read_TX_EXTRA_CONFIG_31_16_value
    End Property

    Property Let set_TX_EXTRA_CONFIG_31_16(aData)
        write_TX_EXTRA_CONFIG_31_16_value = aData
        flag_TX_EXTRA_CONFIG_31_16        = &H1
    End Property

    Property Get read_TX_EXTRA_CONFIG_31_16
        read
        read_TX_EXTRA_CONFIG_31_16 = read_TX_EXTRA_CONFIG_31_16_value
    End Property

    Property Let write_TX_EXTRA_CONFIG_31_16(aData)
        set_TX_EXTRA_CONFIG_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_EXTRA_CONFIG_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_EXTRA_CONFIG_31_16_mask = mask then
                read_TX_EXTRA_CONFIG_31_16_value = data_low
            else
                read_TX_EXTRA_CONFIG_31_16_value = (data_low - H8000_0000) and TX_EXTRA_CONFIG_31_16_mask
            end If
        else
            read_TX_EXTRA_CONFIG_31_16_value = data_low and TX_EXTRA_CONFIG_31_16_mask
        end If

    End Sub

    Sub write
        If flag_TX_EXTRA_CONFIG_31_16 = &H0 Then read
        If flag_TX_EXTRA_CONFIG_31_16 = &H0 Then write_TX_EXTRA_CONFIG_31_16_value = get_TX_EXTRA_CONFIG_31_16

        regValue = leftShift((write_TX_EXTRA_CONFIG_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_EXTRA_CONFIG_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_EXTRA_CONFIG_31_16_mask = mask then
                read_TX_EXTRA_CONFIG_31_16_value = data_low
            else
                read_TX_EXTRA_CONFIG_31_16_value = (data_low - H8000_0000) and TX_EXTRA_CONFIG_31_16_mask
            end If
        else
            read_TX_EXTRA_CONFIG_31_16_value = data_low and TX_EXTRA_CONFIG_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_EXTRA_CONFIG_31_16_value = &H0
        flag_TX_EXTRA_CONFIG_31_16        = &H0
    End Sub
End Class


'' @REGISTER : AFE_tx_extra_config_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_EXTRA_CONFIG_47_32                      [15:0]           get_TX_EXTRA_CONFIG_47_32
''                                                             set_TX_EXTRA_CONFIG_47_32
''                                                             read_TX_EXTRA_CONFIG_47_32
''                                                             write_TX_EXTRA_CONFIG_47_32
''---------------------------------------------------------------------------------
Class REGISTER_AFE_tx_extra_config_2
    Private write_TX_EXTRA_CONFIG_47_32_value
    Private read_TX_EXTRA_CONFIG_47_32_value
    Private flag_TX_EXTRA_CONFIG_47_32

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

    Property Get get_TX_EXTRA_CONFIG_47_32
        get_TX_EXTRA_CONFIG_47_32 = read_TX_EXTRA_CONFIG_47_32_value
    End Property

    Property Let set_TX_EXTRA_CONFIG_47_32(aData)
        write_TX_EXTRA_CONFIG_47_32_value = aData
        flag_TX_EXTRA_CONFIG_47_32        = &H1
    End Property

    Property Get read_TX_EXTRA_CONFIG_47_32
        read
        read_TX_EXTRA_CONFIG_47_32 = read_TX_EXTRA_CONFIG_47_32_value
    End Property

    Property Let write_TX_EXTRA_CONFIG_47_32(aData)
        set_TX_EXTRA_CONFIG_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_EXTRA_CONFIG_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_EXTRA_CONFIG_47_32_mask = mask then
                read_TX_EXTRA_CONFIG_47_32_value = data_low
            else
                read_TX_EXTRA_CONFIG_47_32_value = (data_low - H8000_0000) and TX_EXTRA_CONFIG_47_32_mask
            end If
        else
            read_TX_EXTRA_CONFIG_47_32_value = data_low and TX_EXTRA_CONFIG_47_32_mask
        end If

    End Sub

    Sub write
        If flag_TX_EXTRA_CONFIG_47_32 = &H0 Then read
        If flag_TX_EXTRA_CONFIG_47_32 = &H0 Then write_TX_EXTRA_CONFIG_47_32_value = get_TX_EXTRA_CONFIG_47_32

        regValue = leftShift((write_TX_EXTRA_CONFIG_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_EXTRA_CONFIG_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_EXTRA_CONFIG_47_32_mask = mask then
                read_TX_EXTRA_CONFIG_47_32_value = data_low
            else
                read_TX_EXTRA_CONFIG_47_32_value = (data_low - H8000_0000) and TX_EXTRA_CONFIG_47_32_mask
            end If
        else
            read_TX_EXTRA_CONFIG_47_32_value = data_low and TX_EXTRA_CONFIG_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_EXTRA_CONFIG_47_32_value = &H0
        flag_TX_EXTRA_CONFIG_47_32        = &H0
    End Sub
End Class


'' @REGISTER : AFE_tempsen_others
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPSEN                                    [15:2]           get_TEMPSEN
''                                                             set_TEMPSEN
''                                                             read_TEMPSEN
''                                                             write_TEMPSEN
''---------------------------------------------------------------------------------
'' EXTRA_10BT                                 [1:0]            get_EXTRA_10BT
''                                                             set_EXTRA_10BT
''                                                             read_EXTRA_10BT
''                                                             write_EXTRA_10BT
''---------------------------------------------------------------------------------
Class REGISTER_AFE_tempsen_others
    Private write_TEMPSEN_value
    Private read_TEMPSEN_value
    Private flag_TEMPSEN
    Private write_EXTRA_10BT_value
    Private read_EXTRA_10BT_value
    Private flag_EXTRA_10BT

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

    Property Get get_TEMPSEN
        get_TEMPSEN = read_TEMPSEN_value
    End Property

    Property Let set_TEMPSEN(aData)
        write_TEMPSEN_value = aData
        flag_TEMPSEN        = &H1
    End Property

    Property Get read_TEMPSEN
        read
        read_TEMPSEN = read_TEMPSEN_value
    End Property

    Property Let write_TEMPSEN(aData)
        set_TEMPSEN = aData
        write
    End Property

    Property Get get_EXTRA_10BT
        get_EXTRA_10BT = read_EXTRA_10BT_value
    End Property

    Property Let set_EXTRA_10BT(aData)
        write_EXTRA_10BT_value = aData
        flag_EXTRA_10BT        = &H1
    End Property

    Property Get read_EXTRA_10BT
        read
        read_EXTRA_10BT = read_EXTRA_10BT_value
    End Property

    Property Let write_EXTRA_10BT(aData)
        set_EXTRA_10BT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPSEN_value = rightShift(data_low, 2) and &H3fff
        EXTRA_10BT_mask = &H3
        if data_low > LONG_MAX then
            if EXTRA_10BT_mask = mask then
                read_EXTRA_10BT_value = data_low
            else
                read_EXTRA_10BT_value = (data_low - H8000_0000) and EXTRA_10BT_mask
            end If
        else
            read_EXTRA_10BT_value = data_low and EXTRA_10BT_mask
        end If

    End Sub

    Sub write
        If flag_TEMPSEN = &H0 or flag_EXTRA_10BT = &H0 Then read
        If flag_TEMPSEN = &H0 Then write_TEMPSEN_value = get_TEMPSEN
        If flag_EXTRA_10BT = &H0 Then write_EXTRA_10BT_value = get_EXTRA_10BT

        regValue = leftShift((write_TEMPSEN_value and &H3fff), 2) + leftShift((write_EXTRA_10BT_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPSEN_value = rightShift(data_low, 2) and &H3fff
        EXTRA_10BT_mask = &H3
        if data_low > LONG_MAX then
            if EXTRA_10BT_mask = mask then
                read_EXTRA_10BT_value = data_low
            else
                read_EXTRA_10BT_value = (data_low - H8000_0000) and EXTRA_10BT_mask
            end If
        else
            read_EXTRA_10BT_value = data_low and EXTRA_10BT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPSEN_value = &H0
        flag_TEMPSEN        = &H0
        write_EXTRA_10BT_value = &H0
        flag_EXTRA_10BT        = &H0
    End Sub
End Class


'' @REGISTER : AFE_future_rsv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FUTURE_RSV                                 [15:0]           get_FUTURE_RSV
''                                                             set_FUTURE_RSV
''                                                             read_FUTURE_RSV
''                                                             write_FUTURE_RSV
''---------------------------------------------------------------------------------
Class REGISTER_AFE_future_rsv
    Private write_FUTURE_RSV_value
    Private read_FUTURE_RSV_value
    Private flag_FUTURE_RSV

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

    Property Get get_FUTURE_RSV
        get_FUTURE_RSV = read_FUTURE_RSV_value
    End Property

    Property Let set_FUTURE_RSV(aData)
        write_FUTURE_RSV_value = aData
        flag_FUTURE_RSV        = &H1
    End Property

    Property Get read_FUTURE_RSV
        read
        read_FUTURE_RSV = read_FUTURE_RSV_value
    End Property

    Property Let write_FUTURE_RSV(aData)
        set_FUTURE_RSV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FUTURE_RSV_mask = &Hffff
        if data_low > LONG_MAX then
            if FUTURE_RSV_mask = mask then
                read_FUTURE_RSV_value = data_low
            else
                read_FUTURE_RSV_value = (data_low - H8000_0000) and FUTURE_RSV_mask
            end If
        else
            read_FUTURE_RSV_value = data_low and FUTURE_RSV_mask
        end If

    End Sub

    Sub write
        If flag_FUTURE_RSV = &H0 Then read
        If flag_FUTURE_RSV = &H0 Then write_FUTURE_RSV_value = get_FUTURE_RSV

        regValue = leftShift((write_FUTURE_RSV_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FUTURE_RSV_mask = &Hffff
        if data_low > LONG_MAX then
            if FUTURE_RSV_mask = mask then
                read_FUTURE_RSV_value = data_low
            else
                read_FUTURE_RSV_value = (data_low - H8000_0000) and FUTURE_RSV_mask
            end If
        else
            read_FUTURE_RSV_value = data_low and FUTURE_RSV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FUTURE_RSV_value = &H0
        flag_FUTURE_RSV        = &H0
    End Sub
End Class


'' @REGISTER : AFE_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_spare_end_addr
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
        SPARE_mask = &Hffff
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

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
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

Class AFE_INSTANCE

    Public rxconfig_0
    Public rxconfig_1
    Public rxconfig_2
    Public rxconfig_3
    Public rxconfig_4
    Public rxconfig5_lp
    Public tx_config_0
    Public tx_config_1
    Public vdac_ictrl_0
    Public vdac_ictrl_1
    Public vdac_ictrl_2
    Public vdac_others_0
    Public hpf_trim_others
    Public tx_extra_config_0
    Public tx_extra_config_1
    Public tx_extra_config_2
    Public tempsen_others
    Public future_rsv
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set rxconfig_0 = (New REGISTER_AFE_rxconfig_0)(aBaseAddr, 16)
        Set rxconfig_1 = (New REGISTER_AFE_rxconfig_1)(aBaseAddr, 16)
        Set rxconfig_2 = (New REGISTER_AFE_rxconfig_2)(aBaseAddr, 16)
        Set rxconfig_3 = (New REGISTER_AFE_rxconfig_3)(aBaseAddr, 16)
        Set rxconfig_4 = (New REGISTER_AFE_rxconfig_4)(aBaseAddr, 16)
        Set rxconfig5_lp = (New REGISTER_AFE_rxconfig5_lp)(aBaseAddr, 16)
        Set tx_config_0 = (New REGISTER_AFE_tx_config_0)(aBaseAddr, 16)
        Set tx_config_1 = (New REGISTER_AFE_tx_config_1)(aBaseAddr, 16)
        Set vdac_ictrl_0 = (New REGISTER_AFE_vdac_ictrl_0)(aBaseAddr, 16)
        Set vdac_ictrl_1 = (New REGISTER_AFE_vdac_ictrl_1)(aBaseAddr, 16)
        Set vdac_ictrl_2 = (New REGISTER_AFE_vdac_ictrl_2)(aBaseAddr, 16)
        Set vdac_others_0 = (New REGISTER_AFE_vdac_others_0)(aBaseAddr, 16)
        Set hpf_trim_others = (New REGISTER_AFE_hpf_trim_others)(aBaseAddr, 16)
        Set tx_extra_config_0 = (New REGISTER_AFE_tx_extra_config_0)(aBaseAddr, 16)
        Set tx_extra_config_1 = (New REGISTER_AFE_tx_extra_config_1)(aBaseAddr, 16)
        Set tx_extra_config_2 = (New REGISTER_AFE_tx_extra_config_2)(aBaseAddr, 16)
        Set tempsen_others = (New REGISTER_AFE_tempsen_others)(aBaseAddr, 16)
        Set future_rsv = (New REGISTER_AFE_future_rsv)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_AFE_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AFE = CreateObject("System.Collections.ArrayList")
AFE.Add ((New AFE_INSTANCE)(&H4a4f23c0))
AFE.Add ((New AFE_INSTANCE)(&H494f23c0))
AFE.Add ((New AFE_INSTANCE)(&H498f23c0))
AFE.Add ((New AFE_INSTANCE)(&H49cf23c0))
AFE.Add ((New AFE_INSTANCE)(&H4a0f23c0))


