

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


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_oui_upper_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OUSX1D                                     [7:0]            get_OUSX1D
''                                                             set_OUSX1D
''                                                             read_OUSX1D
''                                                             write_OUSX1D
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_oui_upper_sgmiiplusr_x1
    Private write_OUSX1D_value
    Private read_OUSX1D_value
    Private flag_OUSX1D

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

    Property Get get_OUSX1D
        get_OUSX1D = read_OUSX1D_value
    End Property

    Property Let set_OUSX1D(aData)
        write_OUSX1D_value = aData
        flag_OUSX1D        = &H1
    End Property

    Property Get read_OUSX1D
        read
        read_OUSX1D = read_OUSX1D_value
    End Property

    Property Let write_OUSX1D(aData)
        set_OUSX1D = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OUSX1D_mask = &Hff
        if data_low > LONG_MAX then
            if OUSX1D_mask = mask then
                read_OUSX1D_value = data_low
            else
                read_OUSX1D_value = (data_low - H8000_0000) and OUSX1D_mask
            end If
        else
            read_OUSX1D_value = data_low and OUSX1D_mask
        end If

    End Sub

    Sub write
        If flag_OUSX1D = &H0 Then read
        If flag_OUSX1D = &H0 Then write_OUSX1D_value = get_OUSX1D

        regValue = leftShift((write_OUSX1D_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OUSX1D_mask = &Hff
        if data_low > LONG_MAX then
            if OUSX1D_mask = mask then
                read_OUSX1D_value = data_low
            else
                read_OUSX1D_value = (data_low - H8000_0000) and OUSX1D_mask
            end If
        else
            read_OUSX1D_value = data_low and OUSX1D_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OUSX1D_value = &H0
        flag_OUSX1D        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_oui_lower_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' OLSX1D                                     [15:0]           get_OLSX1D
''                                                             set_OLSX1D
''                                                             read_OLSX1D
''                                                             write_OLSX1D
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_oui_lower_sgmiiplusr_x1
    Private write_OLSX1D_value
    Private read_OLSX1D_value
    Private flag_OLSX1D

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

    Property Get get_OLSX1D
        get_OLSX1D = read_OLSX1D_value
    End Property

    Property Let set_OLSX1D(aData)
        write_OLSX1D_value = aData
        flag_OLSX1D        = &H1
    End Property

    Property Get read_OLSX1D
        read
        read_OLSX1D = read_OLSX1D_value
    End Property

    Property Let write_OLSX1D(aData)
        set_OLSX1D = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OLSX1D_mask = &Hffff
        if data_low > LONG_MAX then
            if OLSX1D_mask = mask then
                read_OLSX1D_value = data_low
            else
                read_OLSX1D_value = (data_low - H8000_0000) and OLSX1D_mask
            end If
        else
            read_OLSX1D_value = data_low and OLSX1D_mask
        end If

    End Sub

    Sub write
        If flag_OLSX1D = &H0 Then read
        If flag_OLSX1D = &H0 Then write_OLSX1D_value = get_OLSX1D

        regValue = leftShift((write_OLSX1D_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        OLSX1D_mask = &Hffff
        if data_low > LONG_MAX then
            if OLSX1D_mask = mask then
                read_OLSX1D_value = data_low
            else
                read_OLSX1D_value = (data_low - H8000_0000) and OLSX1D_mask
            end If
        else
            read_OLSX1D_value = data_low and OLSX1D_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_OLSX1D_value = &H0
        flag_OLSX1D        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_bam_speed_pri_5_0_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' an_priority_1GKX                           [11:10]          get_an_priority_1GKX
''                                                             set_an_priority_1GKX
''                                                             read_an_priority_1GKX
''                                                             write_an_priority_1GKX
''---------------------------------------------------------------------------------
'' an_priority_2p5GX1                         [9:8]            get_an_priority_2p5GX1
''                                                             set_an_priority_2p5GX1
''                                                             read_an_priority_2p5GX1
''                                                             write_an_priority_2p5GX1
''---------------------------------------------------------------------------------
'' an_priority_10M                            [5:4]            get_an_priority_10M
''                                                             set_an_priority_10M
''                                                             read_an_priority_10M
''                                                             write_an_priority_10M
''---------------------------------------------------------------------------------
'' an_priority_100M                           [3:2]            get_an_priority_100M
''                                                             set_an_priority_100M
''                                                             read_an_priority_100M
''                                                             write_an_priority_100M
''---------------------------------------------------------------------------------
'' an_priority_1000M                          [1:0]            get_an_priority_1000M
''                                                             set_an_priority_1000M
''                                                             read_an_priority_1000M
''                                                             write_an_priority_1000M
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_bam_speed_pri_5_0_sgmiiplusr_x1
    Private write_an_priority_1GKX_value
    Private read_an_priority_1GKX_value
    Private flag_an_priority_1GKX
    Private write_an_priority_2p5GX1_value
    Private read_an_priority_2p5GX1_value
    Private flag_an_priority_2p5GX1
    Private write_an_priority_10M_value
    Private read_an_priority_10M_value
    Private flag_an_priority_10M
    Private write_an_priority_100M_value
    Private read_an_priority_100M_value
    Private flag_an_priority_100M
    Private write_an_priority_1000M_value
    Private read_an_priority_1000M_value
    Private flag_an_priority_1000M

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

    Property Get get_an_priority_1GKX
        get_an_priority_1GKX = read_an_priority_1GKX_value
    End Property

    Property Let set_an_priority_1GKX(aData)
        write_an_priority_1GKX_value = aData
        flag_an_priority_1GKX        = &H1
    End Property

    Property Get read_an_priority_1GKX
        read
        read_an_priority_1GKX = read_an_priority_1GKX_value
    End Property

    Property Let write_an_priority_1GKX(aData)
        set_an_priority_1GKX = aData
        write
    End Property

    Property Get get_an_priority_2p5GX1
        get_an_priority_2p5GX1 = read_an_priority_2p5GX1_value
    End Property

    Property Let set_an_priority_2p5GX1(aData)
        write_an_priority_2p5GX1_value = aData
        flag_an_priority_2p5GX1        = &H1
    End Property

    Property Get read_an_priority_2p5GX1
        read
        read_an_priority_2p5GX1 = read_an_priority_2p5GX1_value
    End Property

    Property Let write_an_priority_2p5GX1(aData)
        set_an_priority_2p5GX1 = aData
        write
    End Property

    Property Get get_an_priority_10M
        get_an_priority_10M = read_an_priority_10M_value
    End Property

    Property Let set_an_priority_10M(aData)
        write_an_priority_10M_value = aData
        flag_an_priority_10M        = &H1
    End Property

    Property Get read_an_priority_10M
        read
        read_an_priority_10M = read_an_priority_10M_value
    End Property

    Property Let write_an_priority_10M(aData)
        set_an_priority_10M = aData
        write
    End Property

    Property Get get_an_priority_100M
        get_an_priority_100M = read_an_priority_100M_value
    End Property

    Property Let set_an_priority_100M(aData)
        write_an_priority_100M_value = aData
        flag_an_priority_100M        = &H1
    End Property

    Property Get read_an_priority_100M
        read
        read_an_priority_100M = read_an_priority_100M_value
    End Property

    Property Let write_an_priority_100M(aData)
        set_an_priority_100M = aData
        write
    End Property

    Property Get get_an_priority_1000M
        get_an_priority_1000M = read_an_priority_1000M_value
    End Property

    Property Let set_an_priority_1000M(aData)
        write_an_priority_1000M_value = aData
        flag_an_priority_1000M        = &H1
    End Property

    Property Get read_an_priority_1000M
        read
        read_an_priority_1000M = read_an_priority_1000M_value
    End Property

    Property Let write_an_priority_1000M(aData)
        set_an_priority_1000M = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_priority_1GKX_value = rightShift(data_low, 10) and &H3
        read_an_priority_2p5GX1_value = rightShift(data_low, 8) and &H3
        read_an_priority_10M_value = rightShift(data_low, 4) and &H3
        read_an_priority_100M_value = rightShift(data_low, 2) and &H3
        an_priority_1000M_mask = &H3
        if data_low > LONG_MAX then
            if an_priority_1000M_mask = mask then
                read_an_priority_1000M_value = data_low
            else
                read_an_priority_1000M_value = (data_low - H8000_0000) and an_priority_1000M_mask
            end If
        else
            read_an_priority_1000M_value = data_low and an_priority_1000M_mask
        end If

    End Sub

    Sub write
        If flag_an_priority_1GKX = &H0 or flag_an_priority_2p5GX1 = &H0 or flag_an_priority_10M = &H0 or flag_an_priority_100M = &H0 or flag_an_priority_1000M = &H0 Then read
        If flag_an_priority_1GKX = &H0 Then write_an_priority_1GKX_value = get_an_priority_1GKX
        If flag_an_priority_2p5GX1 = &H0 Then write_an_priority_2p5GX1_value = get_an_priority_2p5GX1
        If flag_an_priority_10M = &H0 Then write_an_priority_10M_value = get_an_priority_10M
        If flag_an_priority_100M = &H0 Then write_an_priority_100M_value = get_an_priority_100M
        If flag_an_priority_1000M = &H0 Then write_an_priority_1000M_value = get_an_priority_1000M

        regValue = leftShift((write_an_priority_1GKX_value and &H3), 10) + leftShift((write_an_priority_2p5GX1_value and &H3), 8) + leftShift((write_an_priority_10M_value and &H3), 4) + leftShift((write_an_priority_100M_value and &H3), 2) + leftShift((write_an_priority_1000M_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_priority_1GKX_value = rightShift(data_low, 10) and &H3
        read_an_priority_2p5GX1_value = rightShift(data_low, 8) and &H3
        read_an_priority_10M_value = rightShift(data_low, 4) and &H3
        read_an_priority_100M_value = rightShift(data_low, 2) and &H3
        an_priority_1000M_mask = &H3
        if data_low > LONG_MAX then
            if an_priority_1000M_mask = mask then
                read_an_priority_1000M_value = data_low
            else
                read_an_priority_1000M_value = (data_low - H8000_0000) and an_priority_1000M_mask
            end If
        else
            read_an_priority_1000M_value = data_low and an_priority_1000M_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_an_priority_1GKX_value = &H0
        flag_an_priority_1GKX        = &H0
        write_an_priority_2p5GX1_value = &H0
        flag_an_priority_2p5GX1        = &H0
        write_an_priority_10M_value = &H0
        flag_an_priority_10M        = &H0
        write_an_priority_100M_value = &H0
        flag_an_priority_100M        = &H0
        write_an_priority_1000M_value = &H0
        flag_an_priority_1000M        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_bam_speed_pri_11_6_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' an_priority_10GKR                          [11:10]          get_an_priority_10GKR
''                                                             set_an_priority_10GKR
''                                                             read_an_priority_10GKR
''                                                             write_an_priority_10GKR
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_bam_speed_pri_11_6_sgmiiplusr_x1
    Private write_an_priority_10GKR_value
    Private read_an_priority_10GKR_value
    Private flag_an_priority_10GKR

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

    Property Get get_an_priority_10GKR
        get_an_priority_10GKR = read_an_priority_10GKR_value
    End Property

    Property Let set_an_priority_10GKR(aData)
        write_an_priority_10GKR_value = aData
        flag_an_priority_10GKR        = &H1
    End Property

    Property Get read_an_priority_10GKR
        read
        read_an_priority_10GKR = read_an_priority_10GKR_value
    End Property

    Property Let write_an_priority_10GKR(aData)
        set_an_priority_10GKR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_priority_10GKR_value = rightShift(data_low, 10) and &H3

    End Sub

    Sub write
        If flag_an_priority_10GKR = &H0 Then read
        If flag_an_priority_10GKR = &H0 Then write_an_priority_10GKR_value = get_an_priority_10GKR

        regValue = leftShift((write_an_priority_10GKR_value and &H3), 10)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_priority_10GKR_value = rightShift(data_low, 10) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_an_priority_10GKR_value = &H0
        flag_an_priority_10GKR        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_config_control_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ram_base                                   [15:0]           get_ram_base
''                                                             set_ram_base
''                                                             read_ram_base
''                                                             write_ram_base
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_config_control_sgmiiplusr_x1
    Private write_ram_base_value
    Private read_ram_base_value
    Private flag_ram_base

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

    Property Get get_ram_base
        get_ram_base = read_ram_base_value
    End Property

    Property Let set_ram_base(aData)
        write_ram_base_value = aData
        flag_ram_base        = &H1
    End Property

    Property Get read_ram_base
        read
        read_ram_base = read_ram_base_value
    End Property

    Property Let write_ram_base(aData)
        set_ram_base = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ram_base_mask = &Hffff
        if data_low > LONG_MAX then
            if ram_base_mask = mask then
                read_ram_base_value = data_low
            else
                read_ram_base_value = (data_low - H8000_0000) and ram_base_mask
            end If
        else
            read_ram_base_value = data_low and ram_base_mask
        end If

    End Sub

    Sub write
        If flag_ram_base = &H0 Then read
        If flag_ram_base = &H0 Then write_ram_base_value = get_ram_base

        regValue = leftShift((write_ram_base_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ram_base_mask = &Hffff
        if data_low > LONG_MAX then
            if ram_base_mask = mask then
                read_ram_base_value = data_low
            else
                read_ram_base_value = (data_low - H8000_0000) and ram_base_mask
            end If
        else
            read_ram_base_value = data_low and ram_base_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ram_base_value = &H0
        flag_ram_base        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_pll_reset_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_reset_timer_period                     [15:0]           get_pll_reset_timer_period
''                                                             set_pll_reset_timer_period
''                                                             read_pll_reset_timer_period
''                                                             write_pll_reset_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_pll_reset_timer
    Private write_pll_reset_timer_period_value
    Private read_pll_reset_timer_period_value
    Private flag_pll_reset_timer_period

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

    Property Get get_pll_reset_timer_period
        get_pll_reset_timer_period = read_pll_reset_timer_period_value
    End Property

    Property Let set_pll_reset_timer_period(aData)
        write_pll_reset_timer_period_value = aData
        flag_pll_reset_timer_period        = &H1
    End Property

    Property Get read_pll_reset_timer_period
        read
        read_pll_reset_timer_period = read_pll_reset_timer_period_value
    End Property

    Property Let write_pll_reset_timer_period(aData)
        set_pll_reset_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_reset_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_reset_timer_period_mask = mask then
                read_pll_reset_timer_period_value = data_low
            else
                read_pll_reset_timer_period_value = (data_low - H8000_0000) and pll_reset_timer_period_mask
            end If
        else
            read_pll_reset_timer_period_value = data_low and pll_reset_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_pll_reset_timer_period = &H0 Then read
        If flag_pll_reset_timer_period = &H0 Then write_pll_reset_timer_period_value = get_pll_reset_timer_period

        regValue = leftShift((write_pll_reset_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_reset_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_reset_timer_period_mask = mask then
                read_pll_reset_timer_period_value = data_low
            else
                read_pll_reset_timer_period_value = (data_low - H8000_0000) and pll_reset_timer_period_mask
            end If
        else
            read_pll_reset_timer_period_value = data_low and pll_reset_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_reset_timer_period_value = &H0
        flag_pll_reset_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_tx_reset_timer_period
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_reset_timer_period                      [15:0]           get_tx_reset_timer_period
''                                                             set_tx_reset_timer_period
''                                                             read_tx_reset_timer_period
''                                                             write_tx_reset_timer_period
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_tx_reset_timer_period
    Private write_tx_reset_timer_period_value
    Private read_tx_reset_timer_period_value
    Private flag_tx_reset_timer_period

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

    Property Get get_tx_reset_timer_period
        get_tx_reset_timer_period = read_tx_reset_timer_period_value
    End Property

    Property Let set_tx_reset_timer_period(aData)
        write_tx_reset_timer_period_value = aData
        flag_tx_reset_timer_period        = &H1
    End Property

    Property Get read_tx_reset_timer_period
        read
        read_tx_reset_timer_period = read_tx_reset_timer_period_value
    End Property

    Property Let write_tx_reset_timer_period(aData)
        set_tx_reset_timer_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_reset_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_reset_timer_period_mask = mask then
                read_tx_reset_timer_period_value = data_low
            else
                read_tx_reset_timer_period_value = (data_low - H8000_0000) and tx_reset_timer_period_mask
            end If
        else
            read_tx_reset_timer_period_value = data_low and tx_reset_timer_period_mask
        end If

    End Sub

    Sub write
        If flag_tx_reset_timer_period = &H0 Then read
        If flag_tx_reset_timer_period = &H0 Then write_tx_reset_timer_period_value = get_tx_reset_timer_period

        regValue = leftShift((write_tx_reset_timer_period_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_reset_timer_period_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_reset_timer_period_mask = mask then
                read_tx_reset_timer_period_value = data_low
            else
                read_tx_reset_timer_period_value = (data_low - H8000_0000) and tx_reset_timer_period_mask
            end If
        else
            read_tx_reset_timer_period_value = data_low and tx_reset_timer_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_reset_timer_period_value = &H0
        flag_tx_reset_timer_period        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_pmd_core_mode_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCMSX1O                                    [8:8]            get_PCMSX1O
''                                                             set_PCMSX1O
''                                                             read_PCMSX1O
''                                                             write_PCMSX1O
''---------------------------------------------------------------------------------
'' PCMSX11                                    [7:0]            get_PCMSX11
''                                                             set_PCMSX11
''                                                             read_PCMSX11
''                                                             write_PCMSX11
''---------------------------------------------------------------------------------
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_pmd_core_mode_sgmiiplusr_x1
    Private write_PCMSX1O_value
    Private read_PCMSX1O_value
    Private flag_PCMSX1O
    Private write_PCMSX11_value
    Private read_PCMSX11_value
    Private flag_PCMSX11

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

    Property Get get_PCMSX1O
        get_PCMSX1O = read_PCMSX1O_value
    End Property

    Property Let set_PCMSX1O(aData)
        write_PCMSX1O_value = aData
        flag_PCMSX1O        = &H1
    End Property

    Property Get read_PCMSX1O
        read
        read_PCMSX1O = read_PCMSX1O_value
    End Property

    Property Let write_PCMSX1O(aData)
        set_PCMSX1O = aData
        write
    End Property

    Property Get get_PCMSX11
        get_PCMSX11 = read_PCMSX11_value
    End Property

    Property Let set_PCMSX11(aData)
        write_PCMSX11_value = aData
        flag_PCMSX11        = &H1
    End Property

    Property Get read_PCMSX11
        read
        read_PCMSX11 = read_PCMSX11_value
    End Property

    Property Let write_PCMSX11(aData)
        set_PCMSX11 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PCMSX1O_value = rightShift(data_low, 8) and &H1
        PCMSX11_mask = &Hff
        if data_low > LONG_MAX then
            if PCMSX11_mask = mask then
                read_PCMSX11_value = data_low
            else
                read_PCMSX11_value = (data_low - H8000_0000) and PCMSX11_mask
            end If
        else
            read_PCMSX11_value = data_low and PCMSX11_mask
        end If

    End Sub

    Sub write
        If flag_PCMSX1O = &H0 or flag_PCMSX11 = &H0 Then read
        If flag_PCMSX1O = &H0 Then write_PCMSX1O_value = get_PCMSX1O
        If flag_PCMSX11 = &H0 Then write_PCMSX11_value = get_PCMSX11

        regValue = leftShift((write_PCMSX1O_value and &H1), 8) + leftShift((write_PCMSX11_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PCMSX1O_value = rightShift(data_low, 8) and &H1
        PCMSX11_mask = &Hff
        if data_low > LONG_MAX then
            if PCMSX11_mask = mask then
                read_PCMSX11_value = data_low
            else
                read_PCMSX11_value = (data_low - H8000_0000) and PCMSX11_mask
            end If
        else
            read_PCMSX11_value = data_low and PCMSX11_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCMSX1O_value = &H0
        flag_PCMSX1O        = &H0
        write_PCMSX11_value = &H0
        flag_PCMSX11        = &H0
    End Sub
End Class


'' @REGISTER : AN_X1_CONTROL_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_blockaddress
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

Class AN_X1_CONTROL_SGMIIPLUSR_X1_INSTANCE

    Public oui_upper_sgmiiplusr_x1
    Public oui_lower_sgmiiplusr_x1
    Public bam_speed_pri_5_0_sgmiiplusr_x1
    Public bam_speed_pri_11_6_sgmiiplusr_x1
    Public config_control_sgmiiplusr_x1
    Public pll_reset_timer
    Public tx_reset_timer_period
    Public pmd_core_mode_sgmiiplusr_x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set oui_upper_sgmiiplusr_x1 = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_oui_upper_sgmiiplusr_x1)(aBaseAddr, 16)
        Set oui_lower_sgmiiplusr_x1 = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_oui_lower_sgmiiplusr_x1)(aBaseAddr, 16)
        Set bam_speed_pri_5_0_sgmiiplusr_x1 = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_bam_speed_pri_5_0_sgmiiplusr_x1)(aBaseAddr, 16)
        Set bam_speed_pri_11_6_sgmiiplusr_x1 = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_bam_speed_pri_11_6_sgmiiplusr_x1)(aBaseAddr, 16)
        Set config_control_sgmiiplusr_x1 = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_config_control_sgmiiplusr_x1)(aBaseAddr, 16)
        Set pll_reset_timer = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_pll_reset_timer)(aBaseAddr, 16)
        Set tx_reset_timer_period = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_tx_reset_timer_period)(aBaseAddr, 16)
        Set pmd_core_mode_sgmiiplusr_x1 = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_pmd_core_mode_sgmiiplusr_x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_AN_X1_CONTROL_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AN_X1_CONTROL_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
AN_X1_CONTROL_SGMIIPLUSR_X1.Add ((New AN_X1_CONTROL_SGMIIPLUSR_X1_INSTANCE)(&H4aed2480))


