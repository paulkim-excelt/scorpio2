

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


'' @REGISTER : PCIE5__SGMIIPCIE_X1_lanectrl15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lane_ctrl15                                [15:0]           get_lane_ctrl15
''                                                             set_lane_ctrl15
''                                                             read_lane_ctrl15
''                                                             write_lane_ctrl15
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_lanectrl15
    Private write_lane_ctrl15_value
    Private read_lane_ctrl15_value
    Private flag_lane_ctrl15

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

    Property Get get_lane_ctrl15
        get_lane_ctrl15 = read_lane_ctrl15_value
    End Property

    Property Let set_lane_ctrl15(aData)
        write_lane_ctrl15_value = aData
        flag_lane_ctrl15        = &H1
    End Property

    Property Get read_lane_ctrl15
        read
        read_lane_ctrl15 = read_lane_ctrl15_value
    End Property

    Property Let write_lane_ctrl15(aData)
        set_lane_ctrl15 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_ctrl15_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_ctrl15_mask = mask then
                read_lane_ctrl15_value = data_low
            else
                read_lane_ctrl15_value = (data_low - H8000_0000) and lane_ctrl15_mask
            end If
        else
            read_lane_ctrl15_value = data_low and lane_ctrl15_mask
        end If

    End Sub

    Sub write
        If flag_lane_ctrl15 = &H0 Then read
        If flag_lane_ctrl15 = &H0 Then write_lane_ctrl15_value = get_lane_ctrl15

        regValue = leftShift((write_lane_ctrl15_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_ctrl15_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_ctrl15_mask = mask then
                read_lane_ctrl15_value = data_low
            else
                read_lane_ctrl15_value = (data_low - H8000_0000) and lane_ctrl15_mask
            end If
        else
            read_lane_ctrl15_value = data_low and lane_ctrl15_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lane_ctrl15_value = &H0
        flag_lane_ctrl15        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_laneprbs0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_en                                    [15:0]           get_prbs_en
''                                                             set_prbs_en
''                                                             read_prbs_en
''                                                             write_prbs_en
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs0
    Private write_prbs_en_value
    Private read_prbs_en_value
    Private flag_prbs_en

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

    Property Get get_prbs_en
        get_prbs_en = read_prbs_en_value
    End Property

    Property Let set_prbs_en(aData)
        write_prbs_en_value = aData
        flag_prbs_en        = &H1
    End Property

    Property Get read_prbs_en
        read
        read_prbs_en = read_prbs_en_value
    End Property

    Property Let write_prbs_en(aData)
        set_prbs_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        prbs_en_mask = &Hffff
        if data_low > LONG_MAX then
            if prbs_en_mask = mask then
                read_prbs_en_value = data_low
            else
                read_prbs_en_value = (data_low - H8000_0000) and prbs_en_mask
            end If
        else
            read_prbs_en_value = data_low and prbs_en_mask
        end If

    End Sub

    Sub write
        If flag_prbs_en = &H0 Then read
        If flag_prbs_en = &H0 Then write_prbs_en_value = get_prbs_en

        regValue = leftShift((write_prbs_en_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        prbs_en_mask = &Hffff
        if data_low > LONG_MAX then
            if prbs_en_mask = mask then
                read_prbs_en_value = data_low
            else
                read_prbs_en_value = (data_low - H8000_0000) and prbs_en_mask
            end If
        else
            read_prbs_en_value = data_low and prbs_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_en_value = &H0
        flag_prbs_en        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_laneprbs1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_inv                                   [15:0]           get_prbs_inv
''                                                             set_prbs_inv
''                                                             read_prbs_inv
''                                                             write_prbs_inv
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs1
    Private write_prbs_inv_value
    Private read_prbs_inv_value
    Private flag_prbs_inv

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

    Property Get get_prbs_inv
        get_prbs_inv = read_prbs_inv_value
    End Property

    Property Let set_prbs_inv(aData)
        write_prbs_inv_value = aData
        flag_prbs_inv        = &H1
    End Property

    Property Get read_prbs_inv
        read
        read_prbs_inv = read_prbs_inv_value
    End Property

    Property Let write_prbs_inv(aData)
        set_prbs_inv = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        prbs_inv_mask = &Hffff
        if data_low > LONG_MAX then
            if prbs_inv_mask = mask then
                read_prbs_inv_value = data_low
            else
                read_prbs_inv_value = (data_low - H8000_0000) and prbs_inv_mask
            end If
        else
            read_prbs_inv_value = data_low and prbs_inv_mask
        end If

    End Sub

    Sub write
        If flag_prbs_inv = &H0 Then read
        If flag_prbs_inv = &H0 Then write_prbs_inv_value = get_prbs_inv

        regValue = leftShift((write_prbs_inv_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        prbs_inv_mask = &Hffff
        if data_low > LONG_MAX then
            if prbs_inv_mask = mask then
                read_prbs_inv_value = data_low
            else
                read_prbs_inv_value = (data_low - H8000_0000) and prbs_inv_mask
            end If
        else
            read_prbs_inv_value = data_low and prbs_inv_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_inv_value = &H0
        flag_prbs_inv        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_laneprbs2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lane_prbs2                                 [15:0]           get_lane_prbs2
''                                                             set_lane_prbs2
''                                                             read_lane_prbs2
''                                                             write_lane_prbs2
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs2
    Private write_lane_prbs2_value
    Private read_lane_prbs2_value
    Private flag_lane_prbs2

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

    Property Get get_lane_prbs2
        get_lane_prbs2 = read_lane_prbs2_value
    End Property

    Property Let set_lane_prbs2(aData)
        write_lane_prbs2_value = aData
        flag_lane_prbs2        = &H1
    End Property

    Property Get read_lane_prbs2
        read
        read_lane_prbs2 = read_lane_prbs2_value
    End Property

    Property Let write_lane_prbs2(aData)
        set_lane_prbs2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_prbs2_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_prbs2_mask = mask then
                read_lane_prbs2_value = data_low
            else
                read_lane_prbs2_value = (data_low - H8000_0000) and lane_prbs2_mask
            end If
        else
            read_lane_prbs2_value = data_low and lane_prbs2_mask
        end If

    End Sub

    Sub write
        If flag_lane_prbs2 = &H0 Then read
        If flag_lane_prbs2 = &H0 Then write_lane_prbs2_value = get_lane_prbs2

        regValue = leftShift((write_lane_prbs2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_prbs2_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_prbs2_mask = mask then
                read_lane_prbs2_value = data_low
            else
                read_lane_prbs2_value = (data_low - H8000_0000) and lane_prbs2_mask
            end If
        else
            read_lane_prbs2_value = data_low and lane_prbs2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lane_prbs2_value = &H0
        flag_lane_prbs2        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_laneprbs3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_order7                                [15:14]          get_prbs_order7
''                                                             set_prbs_order7
''                                                             read_prbs_order7
''                                                             write_prbs_order7
''---------------------------------------------------------------------------------
'' prbs_order6                                [13:12]          get_prbs_order6
''                                                             set_prbs_order6
''                                                             read_prbs_order6
''                                                             write_prbs_order6
''---------------------------------------------------------------------------------
'' prbs_order5                                [11:10]          get_prbs_order5
''                                                             set_prbs_order5
''                                                             read_prbs_order5
''                                                             write_prbs_order5
''---------------------------------------------------------------------------------
'' prbs_order4                                [9:8]            get_prbs_order4
''                                                             set_prbs_order4
''                                                             read_prbs_order4
''                                                             write_prbs_order4
''---------------------------------------------------------------------------------
'' prbs_order3                                [7:6]            get_prbs_order3
''                                                             set_prbs_order3
''                                                             read_prbs_order3
''                                                             write_prbs_order3
''---------------------------------------------------------------------------------
'' prbs_order2                                [5:4]            get_prbs_order2
''                                                             set_prbs_order2
''                                                             read_prbs_order2
''                                                             write_prbs_order2
''---------------------------------------------------------------------------------
'' prbs_order1                                [3:2]            get_prbs_order1
''                                                             set_prbs_order1
''                                                             read_prbs_order1
''                                                             write_prbs_order1
''---------------------------------------------------------------------------------
'' prbs_order0                                [1:0]            get_prbs_order0
''                                                             set_prbs_order0
''                                                             read_prbs_order0
''                                                             write_prbs_order0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs3
    Private write_prbs_order7_value
    Private read_prbs_order7_value
    Private flag_prbs_order7
    Private write_prbs_order6_value
    Private read_prbs_order6_value
    Private flag_prbs_order6
    Private write_prbs_order5_value
    Private read_prbs_order5_value
    Private flag_prbs_order5
    Private write_prbs_order4_value
    Private read_prbs_order4_value
    Private flag_prbs_order4
    Private write_prbs_order3_value
    Private read_prbs_order3_value
    Private flag_prbs_order3
    Private write_prbs_order2_value
    Private read_prbs_order2_value
    Private flag_prbs_order2
    Private write_prbs_order1_value
    Private read_prbs_order1_value
    Private flag_prbs_order1
    Private write_prbs_order0_value
    Private read_prbs_order0_value
    Private flag_prbs_order0

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

    Property Get get_prbs_order7
        get_prbs_order7 = read_prbs_order7_value
    End Property

    Property Let set_prbs_order7(aData)
        write_prbs_order7_value = aData
        flag_prbs_order7        = &H1
    End Property

    Property Get read_prbs_order7
        read
        read_prbs_order7 = read_prbs_order7_value
    End Property

    Property Let write_prbs_order7(aData)
        set_prbs_order7 = aData
        write
    End Property

    Property Get get_prbs_order6
        get_prbs_order6 = read_prbs_order6_value
    End Property

    Property Let set_prbs_order6(aData)
        write_prbs_order6_value = aData
        flag_prbs_order6        = &H1
    End Property

    Property Get read_prbs_order6
        read
        read_prbs_order6 = read_prbs_order6_value
    End Property

    Property Let write_prbs_order6(aData)
        set_prbs_order6 = aData
        write
    End Property

    Property Get get_prbs_order5
        get_prbs_order5 = read_prbs_order5_value
    End Property

    Property Let set_prbs_order5(aData)
        write_prbs_order5_value = aData
        flag_prbs_order5        = &H1
    End Property

    Property Get read_prbs_order5
        read
        read_prbs_order5 = read_prbs_order5_value
    End Property

    Property Let write_prbs_order5(aData)
        set_prbs_order5 = aData
        write
    End Property

    Property Get get_prbs_order4
        get_prbs_order4 = read_prbs_order4_value
    End Property

    Property Let set_prbs_order4(aData)
        write_prbs_order4_value = aData
        flag_prbs_order4        = &H1
    End Property

    Property Get read_prbs_order4
        read
        read_prbs_order4 = read_prbs_order4_value
    End Property

    Property Let write_prbs_order4(aData)
        set_prbs_order4 = aData
        write
    End Property

    Property Get get_prbs_order3
        get_prbs_order3 = read_prbs_order3_value
    End Property

    Property Let set_prbs_order3(aData)
        write_prbs_order3_value = aData
        flag_prbs_order3        = &H1
    End Property

    Property Get read_prbs_order3
        read
        read_prbs_order3 = read_prbs_order3_value
    End Property

    Property Let write_prbs_order3(aData)
        set_prbs_order3 = aData
        write
    End Property

    Property Get get_prbs_order2
        get_prbs_order2 = read_prbs_order2_value
    End Property

    Property Let set_prbs_order2(aData)
        write_prbs_order2_value = aData
        flag_prbs_order2        = &H1
    End Property

    Property Get read_prbs_order2
        read
        read_prbs_order2 = read_prbs_order2_value
    End Property

    Property Let write_prbs_order2(aData)
        set_prbs_order2 = aData
        write
    End Property

    Property Get get_prbs_order1
        get_prbs_order1 = read_prbs_order1_value
    End Property

    Property Let set_prbs_order1(aData)
        write_prbs_order1_value = aData
        flag_prbs_order1        = &H1
    End Property

    Property Get read_prbs_order1
        read
        read_prbs_order1 = read_prbs_order1_value
    End Property

    Property Let write_prbs_order1(aData)
        set_prbs_order1 = aData
        write
    End Property

    Property Get get_prbs_order0
        get_prbs_order0 = read_prbs_order0_value
    End Property

    Property Let set_prbs_order0(aData)
        write_prbs_order0_value = aData
        flag_prbs_order0        = &H1
    End Property

    Property Get read_prbs_order0
        read
        read_prbs_order0 = read_prbs_order0_value
    End Property

    Property Let write_prbs_order0(aData)
        set_prbs_order0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_order7_value = rightShift(data_low, 14) and &H3
        read_prbs_order6_value = rightShift(data_low, 12) and &H3
        read_prbs_order5_value = rightShift(data_low, 10) and &H3
        read_prbs_order4_value = rightShift(data_low, 8) and &H3
        read_prbs_order3_value = rightShift(data_low, 6) and &H3
        read_prbs_order2_value = rightShift(data_low, 4) and &H3
        read_prbs_order1_value = rightShift(data_low, 2) and &H3
        prbs_order0_mask = &H3
        if data_low > LONG_MAX then
            if prbs_order0_mask = mask then
                read_prbs_order0_value = data_low
            else
                read_prbs_order0_value = (data_low - H8000_0000) and prbs_order0_mask
            end If
        else
            read_prbs_order0_value = data_low and prbs_order0_mask
        end If

    End Sub

    Sub write
        If flag_prbs_order7 = &H0 or flag_prbs_order6 = &H0 or flag_prbs_order5 = &H0 or flag_prbs_order4 = &H0 or flag_prbs_order3 = &H0 or flag_prbs_order2 = &H0 or flag_prbs_order1 = &H0 or flag_prbs_order0 = &H0 Then read
        If flag_prbs_order7 = &H0 Then write_prbs_order7_value = get_prbs_order7
        If flag_prbs_order6 = &H0 Then write_prbs_order6_value = get_prbs_order6
        If flag_prbs_order5 = &H0 Then write_prbs_order5_value = get_prbs_order5
        If flag_prbs_order4 = &H0 Then write_prbs_order4_value = get_prbs_order4
        If flag_prbs_order3 = &H0 Then write_prbs_order3_value = get_prbs_order3
        If flag_prbs_order2 = &H0 Then write_prbs_order2_value = get_prbs_order2
        If flag_prbs_order1 = &H0 Then write_prbs_order1_value = get_prbs_order1
        If flag_prbs_order0 = &H0 Then write_prbs_order0_value = get_prbs_order0

        regValue = leftShift((write_prbs_order7_value and &H3), 14) + leftShift((write_prbs_order6_value and &H3), 12) + leftShift((write_prbs_order5_value and &H3), 10) + leftShift((write_prbs_order4_value and &H3), 8) + leftShift((write_prbs_order3_value and &H3), 6) + leftShift((write_prbs_order2_value and &H3), 4) + leftShift((write_prbs_order1_value and &H3), 2) + leftShift((write_prbs_order0_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_order7_value = rightShift(data_low, 14) and &H3
        read_prbs_order6_value = rightShift(data_low, 12) and &H3
        read_prbs_order5_value = rightShift(data_low, 10) and &H3
        read_prbs_order4_value = rightShift(data_low, 8) and &H3
        read_prbs_order3_value = rightShift(data_low, 6) and &H3
        read_prbs_order2_value = rightShift(data_low, 4) and &H3
        read_prbs_order1_value = rightShift(data_low, 2) and &H3
        prbs_order0_mask = &H3
        if data_low > LONG_MAX then
            if prbs_order0_mask = mask then
                read_prbs_order0_value = data_low
            else
                read_prbs_order0_value = (data_low - H8000_0000) and prbs_order0_mask
            end If
        else
            read_prbs_order0_value = data_low and prbs_order0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_order7_value = &H0
        flag_prbs_order7        = &H0
        write_prbs_order6_value = &H0
        flag_prbs_order6        = &H0
        write_prbs_order5_value = &H0
        flag_prbs_order5        = &H0
        write_prbs_order4_value = &H0
        flag_prbs_order4        = &H0
        write_prbs_order3_value = &H0
        flag_prbs_order3        = &H0
        write_prbs_order2_value = &H0
        flag_prbs_order2        = &H0
        write_prbs_order1_value = &H0
        flag_prbs_order1        = &H0
        write_prbs_order0_value = &H0
        flag_prbs_order0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_laneprbs4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_order15                               [15:14]          get_prbs_order15
''                                                             set_prbs_order15
''                                                             read_prbs_order15
''                                                             write_prbs_order15
''---------------------------------------------------------------------------------
'' prbs_order14                               [13:12]          get_prbs_order14
''                                                             set_prbs_order14
''                                                             read_prbs_order14
''                                                             write_prbs_order14
''---------------------------------------------------------------------------------
'' prbs_order13                               [11:10]          get_prbs_order13
''                                                             set_prbs_order13
''                                                             read_prbs_order13
''                                                             write_prbs_order13
''---------------------------------------------------------------------------------
'' prbs_order12                               [9:8]            get_prbs_order12
''                                                             set_prbs_order12
''                                                             read_prbs_order12
''                                                             write_prbs_order12
''---------------------------------------------------------------------------------
'' prbs_order11                               [7:6]            get_prbs_order11
''                                                             set_prbs_order11
''                                                             read_prbs_order11
''                                                             write_prbs_order11
''---------------------------------------------------------------------------------
'' prbs_order10                               [5:4]            get_prbs_order10
''                                                             set_prbs_order10
''                                                             read_prbs_order10
''                                                             write_prbs_order10
''---------------------------------------------------------------------------------
'' prbs_order9                                [3:2]            get_prbs_order9
''                                                             set_prbs_order9
''                                                             read_prbs_order9
''                                                             write_prbs_order9
''---------------------------------------------------------------------------------
'' prbs_order8                                [1:0]            get_prbs_order8
''                                                             set_prbs_order8
''                                                             read_prbs_order8
''                                                             write_prbs_order8
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs4
    Private write_prbs_order15_value
    Private read_prbs_order15_value
    Private flag_prbs_order15
    Private write_prbs_order14_value
    Private read_prbs_order14_value
    Private flag_prbs_order14
    Private write_prbs_order13_value
    Private read_prbs_order13_value
    Private flag_prbs_order13
    Private write_prbs_order12_value
    Private read_prbs_order12_value
    Private flag_prbs_order12
    Private write_prbs_order11_value
    Private read_prbs_order11_value
    Private flag_prbs_order11
    Private write_prbs_order10_value
    Private read_prbs_order10_value
    Private flag_prbs_order10
    Private write_prbs_order9_value
    Private read_prbs_order9_value
    Private flag_prbs_order9
    Private write_prbs_order8_value
    Private read_prbs_order8_value
    Private flag_prbs_order8

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

    Property Get get_prbs_order15
        get_prbs_order15 = read_prbs_order15_value
    End Property

    Property Let set_prbs_order15(aData)
        write_prbs_order15_value = aData
        flag_prbs_order15        = &H1
    End Property

    Property Get read_prbs_order15
        read
        read_prbs_order15 = read_prbs_order15_value
    End Property

    Property Let write_prbs_order15(aData)
        set_prbs_order15 = aData
        write
    End Property

    Property Get get_prbs_order14
        get_prbs_order14 = read_prbs_order14_value
    End Property

    Property Let set_prbs_order14(aData)
        write_prbs_order14_value = aData
        flag_prbs_order14        = &H1
    End Property

    Property Get read_prbs_order14
        read
        read_prbs_order14 = read_prbs_order14_value
    End Property

    Property Let write_prbs_order14(aData)
        set_prbs_order14 = aData
        write
    End Property

    Property Get get_prbs_order13
        get_prbs_order13 = read_prbs_order13_value
    End Property

    Property Let set_prbs_order13(aData)
        write_prbs_order13_value = aData
        flag_prbs_order13        = &H1
    End Property

    Property Get read_prbs_order13
        read
        read_prbs_order13 = read_prbs_order13_value
    End Property

    Property Let write_prbs_order13(aData)
        set_prbs_order13 = aData
        write
    End Property

    Property Get get_prbs_order12
        get_prbs_order12 = read_prbs_order12_value
    End Property

    Property Let set_prbs_order12(aData)
        write_prbs_order12_value = aData
        flag_prbs_order12        = &H1
    End Property

    Property Get read_prbs_order12
        read
        read_prbs_order12 = read_prbs_order12_value
    End Property

    Property Let write_prbs_order12(aData)
        set_prbs_order12 = aData
        write
    End Property

    Property Get get_prbs_order11
        get_prbs_order11 = read_prbs_order11_value
    End Property

    Property Let set_prbs_order11(aData)
        write_prbs_order11_value = aData
        flag_prbs_order11        = &H1
    End Property

    Property Get read_prbs_order11
        read
        read_prbs_order11 = read_prbs_order11_value
    End Property

    Property Let write_prbs_order11(aData)
        set_prbs_order11 = aData
        write
    End Property

    Property Get get_prbs_order10
        get_prbs_order10 = read_prbs_order10_value
    End Property

    Property Let set_prbs_order10(aData)
        write_prbs_order10_value = aData
        flag_prbs_order10        = &H1
    End Property

    Property Get read_prbs_order10
        read
        read_prbs_order10 = read_prbs_order10_value
    End Property

    Property Let write_prbs_order10(aData)
        set_prbs_order10 = aData
        write
    End Property

    Property Get get_prbs_order9
        get_prbs_order9 = read_prbs_order9_value
    End Property

    Property Let set_prbs_order9(aData)
        write_prbs_order9_value = aData
        flag_prbs_order9        = &H1
    End Property

    Property Get read_prbs_order9
        read
        read_prbs_order9 = read_prbs_order9_value
    End Property

    Property Let write_prbs_order9(aData)
        set_prbs_order9 = aData
        write
    End Property

    Property Get get_prbs_order8
        get_prbs_order8 = read_prbs_order8_value
    End Property

    Property Let set_prbs_order8(aData)
        write_prbs_order8_value = aData
        flag_prbs_order8        = &H1
    End Property

    Property Get read_prbs_order8
        read
        read_prbs_order8 = read_prbs_order8_value
    End Property

    Property Let write_prbs_order8(aData)
        set_prbs_order8 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_order15_value = rightShift(data_low, 14) and &H3
        read_prbs_order14_value = rightShift(data_low, 12) and &H3
        read_prbs_order13_value = rightShift(data_low, 10) and &H3
        read_prbs_order12_value = rightShift(data_low, 8) and &H3
        read_prbs_order11_value = rightShift(data_low, 6) and &H3
        read_prbs_order10_value = rightShift(data_low, 4) and &H3
        read_prbs_order9_value = rightShift(data_low, 2) and &H3
        prbs_order8_mask = &H3
        if data_low > LONG_MAX then
            if prbs_order8_mask = mask then
                read_prbs_order8_value = data_low
            else
                read_prbs_order8_value = (data_low - H8000_0000) and prbs_order8_mask
            end If
        else
            read_prbs_order8_value = data_low and prbs_order8_mask
        end If

    End Sub

    Sub write
        If flag_prbs_order15 = &H0 or flag_prbs_order14 = &H0 or flag_prbs_order13 = &H0 or flag_prbs_order12 = &H0 or flag_prbs_order11 = &H0 or flag_prbs_order10 = &H0 or flag_prbs_order9 = &H0 or flag_prbs_order8 = &H0 Then read
        If flag_prbs_order15 = &H0 Then write_prbs_order15_value = get_prbs_order15
        If flag_prbs_order14 = &H0 Then write_prbs_order14_value = get_prbs_order14
        If flag_prbs_order13 = &H0 Then write_prbs_order13_value = get_prbs_order13
        If flag_prbs_order12 = &H0 Then write_prbs_order12_value = get_prbs_order12
        If flag_prbs_order11 = &H0 Then write_prbs_order11_value = get_prbs_order11
        If flag_prbs_order10 = &H0 Then write_prbs_order10_value = get_prbs_order10
        If flag_prbs_order9 = &H0 Then write_prbs_order9_value = get_prbs_order9
        If flag_prbs_order8 = &H0 Then write_prbs_order8_value = get_prbs_order8

        regValue = leftShift((write_prbs_order15_value and &H3), 14) + leftShift((write_prbs_order14_value and &H3), 12) + leftShift((write_prbs_order13_value and &H3), 10) + leftShift((write_prbs_order12_value and &H3), 8) + leftShift((write_prbs_order11_value and &H3), 6) + leftShift((write_prbs_order10_value and &H3), 4) + leftShift((write_prbs_order9_value and &H3), 2) + leftShift((write_prbs_order8_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_order15_value = rightShift(data_low, 14) and &H3
        read_prbs_order14_value = rightShift(data_low, 12) and &H3
        read_prbs_order13_value = rightShift(data_low, 10) and &H3
        read_prbs_order12_value = rightShift(data_low, 8) and &H3
        read_prbs_order11_value = rightShift(data_low, 6) and &H3
        read_prbs_order10_value = rightShift(data_low, 4) and &H3
        read_prbs_order9_value = rightShift(data_low, 2) and &H3
        prbs_order8_mask = &H3
        if data_low > LONG_MAX then
            if prbs_order8_mask = mask then
                read_prbs_order8_value = data_low
            else
                read_prbs_order8_value = (data_low - H8000_0000) and prbs_order8_mask
            end If
        else
            read_prbs_order8_value = data_low and prbs_order8_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_order15_value = &H0
        flag_prbs_order15        = &H0
        write_prbs_order14_value = &H0
        flag_prbs_order14        = &H0
        write_prbs_order13_value = &H0
        flag_prbs_order13        = &H0
        write_prbs_order12_value = &H0
        flag_prbs_order12        = &H0
        write_prbs_order11_value = &H0
        flag_prbs_order11        = &H0
        write_prbs_order10_value = &H0
        flag_prbs_order10        = &H0
        write_prbs_order9_value = &H0
        flag_prbs_order9        = &H0
        write_prbs_order8_value = &H0
        flag_prbs_order8        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_lanetest0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_order3a                               [15:15]          get_prbs_order3a
''                                                             set_prbs_order3a
''                                                             read_prbs_order3a
''                                                             write_prbs_order3a
''---------------------------------------------------------------------------------
'' prbs_order2a                               [14:14]          get_prbs_order2a
''                                                             set_prbs_order2a
''                                                             read_prbs_order2a
''                                                             write_prbs_order2a
''---------------------------------------------------------------------------------
'' prbs_order1a                               [13:13]          get_prbs_order1a
''                                                             set_prbs_order1a
''                                                             read_prbs_order1a
''                                                             write_prbs_order1a
''---------------------------------------------------------------------------------
'' prbs_order0a                               [12:12]          get_prbs_order0a
''                                                             set_prbs_order0a
''                                                             read_prbs_order0a
''                                                             write_prbs_order0a
''---------------------------------------------------------------------------------
'' ext_pwrdn_dis                              [10:10]          get_ext_pwrdn_dis
''                                                             set_ext_pwrdn_dis
''                                                             read_ext_pwrdn_dis
''                                                             write_ext_pwrdn_dis
''---------------------------------------------------------------------------------
'' pwrdn_safe_dis_tmp                         [9:9]            get_pwrdn_safe_dis_tmp
''                                                             set_pwrdn_safe_dis_tmp
''                                                             read_pwrdn_safe_dis_tmp
''                                                             write_pwrdn_safe_dis_tmp
''---------------------------------------------------------------------------------
'' pwrdn_clks_en                              [8:8]            get_pwrdn_clks_en
''                                                             set_pwrdn_clks_en
''                                                             read_pwrdn_clks_en
''                                                             write_pwrdn_clks_en
''---------------------------------------------------------------------------------
'' pll_lock_rstb_r                            [6:6]            get_pll_lock_rstb_r
''                                                             set_pll_lock_rstb_r
''                                                             read_pll_lock_rstb_r
''                                                             write_pll_lock_rstb_r
''---------------------------------------------------------------------------------
'' lfck_bypass                                [5:5]            get_lfck_bypass
''                                                             set_lfck_bypass
''                                                             read_lfck_bypass
''                                                             write_lfck_bypass
''---------------------------------------------------------------------------------
'' rx_snoop_en                                [4:4]            get_rx_snoop_en
''                                                             set_rx_snoop_en
''                                                             read_rx_snoop_en
''                                                             write_rx_snoop_en
''---------------------------------------------------------------------------------
'' mdio_StandAloneMode                        [3:3]            get_mdio_StandAloneMode
''                                                             set_mdio_StandAloneMode
''                                                             read_mdio_StandAloneMode
''                                                             write_mdio_StandAloneMode
''---------------------------------------------------------------------------------
'' mdio_PllTuningBypass                       [2:2]            get_mdio_PllTuningBypass
''                                                             set_mdio_PllTuningBypass
''                                                             read_mdio_PllTuningBypass
''                                                             write_mdio_PllTuningBypass
''---------------------------------------------------------------------------------
'' mdio_lfck_rx_sel_cnt0                      [1:1]            get_mdio_lfck_rx_sel_cnt0
''                                                             set_mdio_lfck_rx_sel_cnt0
''                                                             read_mdio_lfck_rx_sel_cnt0
''                                                             write_mdio_lfck_rx_sel_cnt0
''---------------------------------------------------------------------------------
'' mdio_lfck_rx_sel_refclk                    [0:0]            get_mdio_lfck_rx_sel_refclk
''                                                             set_mdio_lfck_rx_sel_refclk
''                                                             read_mdio_lfck_rx_sel_refclk
''                                                             write_mdio_lfck_rx_sel_refclk
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_lanetest0
    Private write_prbs_order3a_value
    Private read_prbs_order3a_value
    Private flag_prbs_order3a
    Private write_prbs_order2a_value
    Private read_prbs_order2a_value
    Private flag_prbs_order2a
    Private write_prbs_order1a_value
    Private read_prbs_order1a_value
    Private flag_prbs_order1a
    Private write_prbs_order0a_value
    Private read_prbs_order0a_value
    Private flag_prbs_order0a
    Private write_ext_pwrdn_dis_value
    Private read_ext_pwrdn_dis_value
    Private flag_ext_pwrdn_dis
    Private write_pwrdn_safe_dis_tmp_value
    Private read_pwrdn_safe_dis_tmp_value
    Private flag_pwrdn_safe_dis_tmp
    Private write_pwrdn_clks_en_value
    Private read_pwrdn_clks_en_value
    Private flag_pwrdn_clks_en
    Private write_pll_lock_rstb_r_value
    Private read_pll_lock_rstb_r_value
    Private flag_pll_lock_rstb_r
    Private write_lfck_bypass_value
    Private read_lfck_bypass_value
    Private flag_lfck_bypass
    Private write_rx_snoop_en_value
    Private read_rx_snoop_en_value
    Private flag_rx_snoop_en
    Private write_mdio_StandAloneMode_value
    Private read_mdio_StandAloneMode_value
    Private flag_mdio_StandAloneMode
    Private write_mdio_PllTuningBypass_value
    Private read_mdio_PllTuningBypass_value
    Private flag_mdio_PllTuningBypass
    Private write_mdio_lfck_rx_sel_cnt0_value
    Private read_mdio_lfck_rx_sel_cnt0_value
    Private flag_mdio_lfck_rx_sel_cnt0
    Private write_mdio_lfck_rx_sel_refclk_value
    Private read_mdio_lfck_rx_sel_refclk_value
    Private flag_mdio_lfck_rx_sel_refclk

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

    Property Get get_prbs_order3a
        get_prbs_order3a = read_prbs_order3a_value
    End Property

    Property Let set_prbs_order3a(aData)
        write_prbs_order3a_value = aData
        flag_prbs_order3a        = &H1
    End Property

    Property Get read_prbs_order3a
        read
        read_prbs_order3a = read_prbs_order3a_value
    End Property

    Property Let write_prbs_order3a(aData)
        set_prbs_order3a = aData
        write
    End Property

    Property Get get_prbs_order2a
        get_prbs_order2a = read_prbs_order2a_value
    End Property

    Property Let set_prbs_order2a(aData)
        write_prbs_order2a_value = aData
        flag_prbs_order2a        = &H1
    End Property

    Property Get read_prbs_order2a
        read
        read_prbs_order2a = read_prbs_order2a_value
    End Property

    Property Let write_prbs_order2a(aData)
        set_prbs_order2a = aData
        write
    End Property

    Property Get get_prbs_order1a
        get_prbs_order1a = read_prbs_order1a_value
    End Property

    Property Let set_prbs_order1a(aData)
        write_prbs_order1a_value = aData
        flag_prbs_order1a        = &H1
    End Property

    Property Get read_prbs_order1a
        read
        read_prbs_order1a = read_prbs_order1a_value
    End Property

    Property Let write_prbs_order1a(aData)
        set_prbs_order1a = aData
        write
    End Property

    Property Get get_prbs_order0a
        get_prbs_order0a = read_prbs_order0a_value
    End Property

    Property Let set_prbs_order0a(aData)
        write_prbs_order0a_value = aData
        flag_prbs_order0a        = &H1
    End Property

    Property Get read_prbs_order0a
        read
        read_prbs_order0a = read_prbs_order0a_value
    End Property

    Property Let write_prbs_order0a(aData)
        set_prbs_order0a = aData
        write
    End Property

    Property Get get_ext_pwrdn_dis
        get_ext_pwrdn_dis = read_ext_pwrdn_dis_value
    End Property

    Property Let set_ext_pwrdn_dis(aData)
        write_ext_pwrdn_dis_value = aData
        flag_ext_pwrdn_dis        = &H1
    End Property

    Property Get read_ext_pwrdn_dis
        read
        read_ext_pwrdn_dis = read_ext_pwrdn_dis_value
    End Property

    Property Let write_ext_pwrdn_dis(aData)
        set_ext_pwrdn_dis = aData
        write
    End Property

    Property Get get_pwrdn_safe_dis_tmp
        get_pwrdn_safe_dis_tmp = read_pwrdn_safe_dis_tmp_value
    End Property

    Property Let set_pwrdn_safe_dis_tmp(aData)
        write_pwrdn_safe_dis_tmp_value = aData
        flag_pwrdn_safe_dis_tmp        = &H1
    End Property

    Property Get read_pwrdn_safe_dis_tmp
        read
        read_pwrdn_safe_dis_tmp = read_pwrdn_safe_dis_tmp_value
    End Property

    Property Let write_pwrdn_safe_dis_tmp(aData)
        set_pwrdn_safe_dis_tmp = aData
        write
    End Property

    Property Get get_pwrdn_clks_en
        get_pwrdn_clks_en = read_pwrdn_clks_en_value
    End Property

    Property Let set_pwrdn_clks_en(aData)
        write_pwrdn_clks_en_value = aData
        flag_pwrdn_clks_en        = &H1
    End Property

    Property Get read_pwrdn_clks_en
        read
        read_pwrdn_clks_en = read_pwrdn_clks_en_value
    End Property

    Property Let write_pwrdn_clks_en(aData)
        set_pwrdn_clks_en = aData
        write
    End Property

    Property Get get_pll_lock_rstb_r
        get_pll_lock_rstb_r = read_pll_lock_rstb_r_value
    End Property

    Property Let set_pll_lock_rstb_r(aData)
        write_pll_lock_rstb_r_value = aData
        flag_pll_lock_rstb_r        = &H1
    End Property

    Property Get read_pll_lock_rstb_r
        read
        read_pll_lock_rstb_r = read_pll_lock_rstb_r_value
    End Property

    Property Let write_pll_lock_rstb_r(aData)
        set_pll_lock_rstb_r = aData
        write
    End Property

    Property Get get_lfck_bypass
        get_lfck_bypass = read_lfck_bypass_value
    End Property

    Property Let set_lfck_bypass(aData)
        write_lfck_bypass_value = aData
        flag_lfck_bypass        = &H1
    End Property

    Property Get read_lfck_bypass
        read
        read_lfck_bypass = read_lfck_bypass_value
    End Property

    Property Let write_lfck_bypass(aData)
        set_lfck_bypass = aData
        write
    End Property

    Property Get get_rx_snoop_en
        get_rx_snoop_en = read_rx_snoop_en_value
    End Property

    Property Let set_rx_snoop_en(aData)
        write_rx_snoop_en_value = aData
        flag_rx_snoop_en        = &H1
    End Property

    Property Get read_rx_snoop_en
        read
        read_rx_snoop_en = read_rx_snoop_en_value
    End Property

    Property Let write_rx_snoop_en(aData)
        set_rx_snoop_en = aData
        write
    End Property

    Property Get get_mdio_StandAloneMode
        get_mdio_StandAloneMode = read_mdio_StandAloneMode_value
    End Property

    Property Let set_mdio_StandAloneMode(aData)
        write_mdio_StandAloneMode_value = aData
        flag_mdio_StandAloneMode        = &H1
    End Property

    Property Get read_mdio_StandAloneMode
        read
        read_mdio_StandAloneMode = read_mdio_StandAloneMode_value
    End Property

    Property Let write_mdio_StandAloneMode(aData)
        set_mdio_StandAloneMode = aData
        write
    End Property

    Property Get get_mdio_PllTuningBypass
        get_mdio_PllTuningBypass = read_mdio_PllTuningBypass_value
    End Property

    Property Let set_mdio_PllTuningBypass(aData)
        write_mdio_PllTuningBypass_value = aData
        flag_mdio_PllTuningBypass        = &H1
    End Property

    Property Get read_mdio_PllTuningBypass
        read
        read_mdio_PllTuningBypass = read_mdio_PllTuningBypass_value
    End Property

    Property Let write_mdio_PllTuningBypass(aData)
        set_mdio_PllTuningBypass = aData
        write
    End Property

    Property Get get_mdio_lfck_rx_sel_cnt0
        get_mdio_lfck_rx_sel_cnt0 = read_mdio_lfck_rx_sel_cnt0_value
    End Property

    Property Let set_mdio_lfck_rx_sel_cnt0(aData)
        write_mdio_lfck_rx_sel_cnt0_value = aData
        flag_mdio_lfck_rx_sel_cnt0        = &H1
    End Property

    Property Get read_mdio_lfck_rx_sel_cnt0
        read
        read_mdio_lfck_rx_sel_cnt0 = read_mdio_lfck_rx_sel_cnt0_value
    End Property

    Property Let write_mdio_lfck_rx_sel_cnt0(aData)
        set_mdio_lfck_rx_sel_cnt0 = aData
        write
    End Property

    Property Get get_mdio_lfck_rx_sel_refclk
        get_mdio_lfck_rx_sel_refclk = read_mdio_lfck_rx_sel_refclk_value
    End Property

    Property Let set_mdio_lfck_rx_sel_refclk(aData)
        write_mdio_lfck_rx_sel_refclk_value = aData
        flag_mdio_lfck_rx_sel_refclk        = &H1
    End Property

    Property Get read_mdio_lfck_rx_sel_refclk
        read
        read_mdio_lfck_rx_sel_refclk = read_mdio_lfck_rx_sel_refclk_value
    End Property

    Property Let write_mdio_lfck_rx_sel_refclk(aData)
        set_mdio_lfck_rx_sel_refclk = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_order3a_value = rightShift(data_low, 15) and &H1
        read_prbs_order2a_value = rightShift(data_low, 14) and &H1
        read_prbs_order1a_value = rightShift(data_low, 13) and &H1
        read_prbs_order0a_value = rightShift(data_low, 12) and &H1
        read_ext_pwrdn_dis_value = rightShift(data_low, 10) and &H1
        read_pwrdn_safe_dis_tmp_value = rightShift(data_low, 9) and &H1
        read_pwrdn_clks_en_value = rightShift(data_low, 8) and &H1
        read_pll_lock_rstb_r_value = rightShift(data_low, 6) and &H1
        read_lfck_bypass_value = rightShift(data_low, 5) and &H1
        read_rx_snoop_en_value = rightShift(data_low, 4) and &H1
        read_mdio_StandAloneMode_value = rightShift(data_low, 3) and &H1
        read_mdio_PllTuningBypass_value = rightShift(data_low, 2) and &H1
        read_mdio_lfck_rx_sel_cnt0_value = rightShift(data_low, 1) and &H1
        mdio_lfck_rx_sel_refclk_mask = &H1
        if data_low > LONG_MAX then
            if mdio_lfck_rx_sel_refclk_mask = mask then
                read_mdio_lfck_rx_sel_refclk_value = data_low
            else
                read_mdio_lfck_rx_sel_refclk_value = (data_low - H8000_0000) and mdio_lfck_rx_sel_refclk_mask
            end If
        else
            read_mdio_lfck_rx_sel_refclk_value = data_low and mdio_lfck_rx_sel_refclk_mask
        end If

    End Sub

    Sub write
        If flag_prbs_order3a = &H0 or flag_prbs_order2a = &H0 or flag_prbs_order1a = &H0 or flag_prbs_order0a = &H0 or flag_ext_pwrdn_dis = &H0 or flag_pwrdn_safe_dis_tmp = &H0 or flag_pwrdn_clks_en = &H0 or flag_pll_lock_rstb_r = &H0 or flag_lfck_bypass = &H0 or flag_rx_snoop_en = &H0 or flag_mdio_StandAloneMode = &H0 or flag_mdio_PllTuningBypass = &H0 or flag_mdio_lfck_rx_sel_cnt0 = &H0 or flag_mdio_lfck_rx_sel_refclk = &H0 Then read
        If flag_prbs_order3a = &H0 Then write_prbs_order3a_value = get_prbs_order3a
        If flag_prbs_order2a = &H0 Then write_prbs_order2a_value = get_prbs_order2a
        If flag_prbs_order1a = &H0 Then write_prbs_order1a_value = get_prbs_order1a
        If flag_prbs_order0a = &H0 Then write_prbs_order0a_value = get_prbs_order0a
        If flag_ext_pwrdn_dis = &H0 Then write_ext_pwrdn_dis_value = get_ext_pwrdn_dis
        If flag_pwrdn_safe_dis_tmp = &H0 Then write_pwrdn_safe_dis_tmp_value = get_pwrdn_safe_dis_tmp
        If flag_pwrdn_clks_en = &H0 Then write_pwrdn_clks_en_value = get_pwrdn_clks_en
        If flag_pll_lock_rstb_r = &H0 Then write_pll_lock_rstb_r_value = get_pll_lock_rstb_r
        If flag_lfck_bypass = &H0 Then write_lfck_bypass_value = get_lfck_bypass
        If flag_rx_snoop_en = &H0 Then write_rx_snoop_en_value = get_rx_snoop_en
        If flag_mdio_StandAloneMode = &H0 Then write_mdio_StandAloneMode_value = get_mdio_StandAloneMode
        If flag_mdio_PllTuningBypass = &H0 Then write_mdio_PllTuningBypass_value = get_mdio_PllTuningBypass
        If flag_mdio_lfck_rx_sel_cnt0 = &H0 Then write_mdio_lfck_rx_sel_cnt0_value = get_mdio_lfck_rx_sel_cnt0
        If flag_mdio_lfck_rx_sel_refclk = &H0 Then write_mdio_lfck_rx_sel_refclk_value = get_mdio_lfck_rx_sel_refclk

        regValue = leftShift((write_prbs_order3a_value and &H1), 15) + leftShift((write_prbs_order2a_value and &H1), 14) + leftShift((write_prbs_order1a_value and &H1), 13) + leftShift((write_prbs_order0a_value and &H1), 12) + leftShift((write_ext_pwrdn_dis_value and &H1), 10) + leftShift((write_pwrdn_safe_dis_tmp_value and &H1), 9) + leftShift((write_pwrdn_clks_en_value and &H1), 8) + leftShift((write_pll_lock_rstb_r_value and &H1), 6) + leftShift((write_lfck_bypass_value and &H1), 5) + leftShift((write_rx_snoop_en_value and &H1), 4) + leftShift((write_mdio_StandAloneMode_value and &H1), 3) + leftShift((write_mdio_PllTuningBypass_value and &H1), 2) + leftShift((write_mdio_lfck_rx_sel_cnt0_value and &H1), 1) + leftShift((write_mdio_lfck_rx_sel_refclk_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_order3a_value = rightShift(data_low, 15) and &H1
        read_prbs_order2a_value = rightShift(data_low, 14) and &H1
        read_prbs_order1a_value = rightShift(data_low, 13) and &H1
        read_prbs_order0a_value = rightShift(data_low, 12) and &H1
        read_ext_pwrdn_dis_value = rightShift(data_low, 10) and &H1
        read_pwrdn_safe_dis_tmp_value = rightShift(data_low, 9) and &H1
        read_pwrdn_clks_en_value = rightShift(data_low, 8) and &H1
        read_pll_lock_rstb_r_value = rightShift(data_low, 6) and &H1
        read_lfck_bypass_value = rightShift(data_low, 5) and &H1
        read_rx_snoop_en_value = rightShift(data_low, 4) and &H1
        read_mdio_StandAloneMode_value = rightShift(data_low, 3) and &H1
        read_mdio_PllTuningBypass_value = rightShift(data_low, 2) and &H1
        read_mdio_lfck_rx_sel_cnt0_value = rightShift(data_low, 1) and &H1
        mdio_lfck_rx_sel_refclk_mask = &H1
        if data_low > LONG_MAX then
            if mdio_lfck_rx_sel_refclk_mask = mask then
                read_mdio_lfck_rx_sel_refclk_value = data_low
            else
                read_mdio_lfck_rx_sel_refclk_value = (data_low - H8000_0000) and mdio_lfck_rx_sel_refclk_mask
            end If
        else
            read_mdio_lfck_rx_sel_refclk_value = data_low and mdio_lfck_rx_sel_refclk_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_order3a_value = &H0
        flag_prbs_order3a        = &H0
        write_prbs_order2a_value = &H0
        flag_prbs_order2a        = &H0
        write_prbs_order1a_value = &H0
        flag_prbs_order1a        = &H0
        write_prbs_order0a_value = &H0
        flag_prbs_order0a        = &H0
        write_ext_pwrdn_dis_value = &H0
        flag_ext_pwrdn_dis        = &H0
        write_pwrdn_safe_dis_tmp_value = &H0
        flag_pwrdn_safe_dis_tmp        = &H0
        write_pwrdn_clks_en_value = &H0
        flag_pwrdn_clks_en        = &H0
        write_pll_lock_rstb_r_value = &H0
        flag_pll_lock_rstb_r        = &H0
        write_lfck_bypass_value = &H0
        flag_lfck_bypass        = &H0
        write_rx_snoop_en_value = &H0
        flag_rx_snoop_en        = &H0
        write_mdio_StandAloneMode_value = &H0
        flag_mdio_StandAloneMode        = &H0
        write_mdio_PllTuningBypass_value = &H0
        flag_mdio_PllTuningBypass        = &H0
        write_mdio_lfck_rx_sel_cnt0_value = &H0
        flag_mdio_lfck_rx_sel_cnt0        = &H0
        write_mdio_lfck_rx_sel_refclk_value = &H0
        flag_mdio_lfck_rx_sel_refclk        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_lanetest1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_start                                 [15:15]          get_comp_start
''                                                             set_comp_start
''                                                             read_comp_start
''                                                             write_comp_start
''---------------------------------------------------------------------------------
'' tmux_sel                                   [5:0]            get_tmux_sel
''                                                             set_tmux_sel
''                                                             read_tmux_sel
''                                                             write_tmux_sel
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_lanetest1
    Private write_comp_start_value
    Private read_comp_start_value
    Private flag_comp_start
    Private write_tmux_sel_value
    Private read_tmux_sel_value
    Private flag_tmux_sel

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

    Property Get get_comp_start
        get_comp_start = read_comp_start_value
    End Property

    Property Let set_comp_start(aData)
        write_comp_start_value = aData
        flag_comp_start        = &H1
    End Property

    Property Get read_comp_start
        read
        read_comp_start = read_comp_start_value
    End Property

    Property Let write_comp_start(aData)
        set_comp_start = aData
        write
    End Property

    Property Get get_tmux_sel
        get_tmux_sel = read_tmux_sel_value
    End Property

    Property Let set_tmux_sel(aData)
        write_tmux_sel_value = aData
        flag_tmux_sel        = &H1
    End Property

    Property Get read_tmux_sel
        read
        read_tmux_sel = read_tmux_sel_value
    End Property

    Property Let write_tmux_sel(aData)
        set_tmux_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_comp_start_value = rightShift(data_low, 15) and &H1
        tmux_sel_mask = &H3f
        if data_low > LONG_MAX then
            if tmux_sel_mask = mask then
                read_tmux_sel_value = data_low
            else
                read_tmux_sel_value = (data_low - H8000_0000) and tmux_sel_mask
            end If
        else
            read_tmux_sel_value = data_low and tmux_sel_mask
        end If

    End Sub

    Sub write
        If flag_comp_start = &H0 or flag_tmux_sel = &H0 Then read
        If flag_comp_start = &H0 Then write_comp_start_value = get_comp_start
        If flag_tmux_sel = &H0 Then write_tmux_sel_value = get_tmux_sel

        regValue = leftShift((write_comp_start_value and &H1), 15) + leftShift((write_tmux_sel_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_comp_start_value = rightShift(data_low, 15) and &H1
        tmux_sel_mask = &H3f
        if data_low > LONG_MAX then
            if tmux_sel_mask = mask then
                read_tmux_sel_value = data_low
            else
                read_tmux_sel_value = (data_low - H8000_0000) and tmux_sel_mask
            end If
        else
            read_tmux_sel_value = data_low and tmux_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_start_value = &H0
        flag_comp_start        = &H0
        write_tmux_sel_value = &H0
        flag_tmux_sel        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_comp_delay0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_delay3_11                             [15:12]          get_comp_delay3_11
''                                                             set_comp_delay3_11
''                                                             read_comp_delay3_11
''                                                             write_comp_delay3_11
''---------------------------------------------------------------------------------
'' comp_delay2_10                             [11:8]           get_comp_delay2_10
''                                                             set_comp_delay2_10
''                                                             read_comp_delay2_10
''                                                             write_comp_delay2_10
''---------------------------------------------------------------------------------
'' comp_delay1_9                              [7:4]            get_comp_delay1_9
''                                                             set_comp_delay1_9
''                                                             read_comp_delay1_9
''                                                             write_comp_delay1_9
''---------------------------------------------------------------------------------
'' comp_delay0_8                              [3:0]            get_comp_delay0_8
''                                                             set_comp_delay0_8
''                                                             read_comp_delay0_8
''                                                             write_comp_delay0_8
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_comp_delay0
    Private write_comp_delay3_11_value
    Private read_comp_delay3_11_value
    Private flag_comp_delay3_11
    Private write_comp_delay2_10_value
    Private read_comp_delay2_10_value
    Private flag_comp_delay2_10
    Private write_comp_delay1_9_value
    Private read_comp_delay1_9_value
    Private flag_comp_delay1_9
    Private write_comp_delay0_8_value
    Private read_comp_delay0_8_value
    Private flag_comp_delay0_8

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

    Property Get get_comp_delay3_11
        get_comp_delay3_11 = read_comp_delay3_11_value
    End Property

    Property Let set_comp_delay3_11(aData)
        write_comp_delay3_11_value = aData
        flag_comp_delay3_11        = &H1
    End Property

    Property Get read_comp_delay3_11
        read
        read_comp_delay3_11 = read_comp_delay3_11_value
    End Property

    Property Let write_comp_delay3_11(aData)
        set_comp_delay3_11 = aData
        write
    End Property

    Property Get get_comp_delay2_10
        get_comp_delay2_10 = read_comp_delay2_10_value
    End Property

    Property Let set_comp_delay2_10(aData)
        write_comp_delay2_10_value = aData
        flag_comp_delay2_10        = &H1
    End Property

    Property Get read_comp_delay2_10
        read
        read_comp_delay2_10 = read_comp_delay2_10_value
    End Property

    Property Let write_comp_delay2_10(aData)
        set_comp_delay2_10 = aData
        write
    End Property

    Property Get get_comp_delay1_9
        get_comp_delay1_9 = read_comp_delay1_9_value
    End Property

    Property Let set_comp_delay1_9(aData)
        write_comp_delay1_9_value = aData
        flag_comp_delay1_9        = &H1
    End Property

    Property Get read_comp_delay1_9
        read
        read_comp_delay1_9 = read_comp_delay1_9_value
    End Property

    Property Let write_comp_delay1_9(aData)
        set_comp_delay1_9 = aData
        write
    End Property

    Property Get get_comp_delay0_8
        get_comp_delay0_8 = read_comp_delay0_8_value
    End Property

    Property Let set_comp_delay0_8(aData)
        write_comp_delay0_8_value = aData
        flag_comp_delay0_8        = &H1
    End Property

    Property Get read_comp_delay0_8
        read
        read_comp_delay0_8 = read_comp_delay0_8_value
    End Property

    Property Let write_comp_delay0_8(aData)
        set_comp_delay0_8 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_comp_delay3_11_value = rightShift(data_low, 12) and &Hf
        read_comp_delay2_10_value = rightShift(data_low, 8) and &Hf
        read_comp_delay1_9_value = rightShift(data_low, 4) and &Hf
        comp_delay0_8_mask = &Hf
        if data_low > LONG_MAX then
            if comp_delay0_8_mask = mask then
                read_comp_delay0_8_value = data_low
            else
                read_comp_delay0_8_value = (data_low - H8000_0000) and comp_delay0_8_mask
            end If
        else
            read_comp_delay0_8_value = data_low and comp_delay0_8_mask
        end If

    End Sub

    Sub write
        If flag_comp_delay3_11 = &H0 or flag_comp_delay2_10 = &H0 or flag_comp_delay1_9 = &H0 or flag_comp_delay0_8 = &H0 Then read
        If flag_comp_delay3_11 = &H0 Then write_comp_delay3_11_value = get_comp_delay3_11
        If flag_comp_delay2_10 = &H0 Then write_comp_delay2_10_value = get_comp_delay2_10
        If flag_comp_delay1_9 = &H0 Then write_comp_delay1_9_value = get_comp_delay1_9
        If flag_comp_delay0_8 = &H0 Then write_comp_delay0_8_value = get_comp_delay0_8

        regValue = leftShift((write_comp_delay3_11_value and &Hf), 12) + leftShift((write_comp_delay2_10_value and &Hf), 8) + leftShift((write_comp_delay1_9_value and &Hf), 4) + leftShift((write_comp_delay0_8_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_comp_delay3_11_value = rightShift(data_low, 12) and &Hf
        read_comp_delay2_10_value = rightShift(data_low, 8) and &Hf
        read_comp_delay1_9_value = rightShift(data_low, 4) and &Hf
        comp_delay0_8_mask = &Hf
        if data_low > LONG_MAX then
            if comp_delay0_8_mask = mask then
                read_comp_delay0_8_value = data_low
            else
                read_comp_delay0_8_value = (data_low - H8000_0000) and comp_delay0_8_mask
            end If
        else
            read_comp_delay0_8_value = data_low and comp_delay0_8_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_delay3_11_value = &H0
        flag_comp_delay3_11        = &H0
        write_comp_delay2_10_value = &H0
        flag_comp_delay2_10        = &H0
        write_comp_delay1_9_value = &H0
        flag_comp_delay1_9        = &H0
        write_comp_delay0_8_value = &H0
        flag_comp_delay0_8        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_comp_delay1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_delay7_15                             [15:12]          get_comp_delay7_15
''                                                             set_comp_delay7_15
''                                                             read_comp_delay7_15
''                                                             write_comp_delay7_15
''---------------------------------------------------------------------------------
'' comp_delay6_14                             [11:8]           get_comp_delay6_14
''                                                             set_comp_delay6_14
''                                                             read_comp_delay6_14
''                                                             write_comp_delay6_14
''---------------------------------------------------------------------------------
'' comp_delay5_13                             [7:4]            get_comp_delay5_13
''                                                             set_comp_delay5_13
''                                                             read_comp_delay5_13
''                                                             write_comp_delay5_13
''---------------------------------------------------------------------------------
'' comp_delay4_12                             [3:0]            get_comp_delay4_12
''                                                             set_comp_delay4_12
''                                                             read_comp_delay4_12
''                                                             write_comp_delay4_12
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_comp_delay1
    Private write_comp_delay7_15_value
    Private read_comp_delay7_15_value
    Private flag_comp_delay7_15
    Private write_comp_delay6_14_value
    Private read_comp_delay6_14_value
    Private flag_comp_delay6_14
    Private write_comp_delay5_13_value
    Private read_comp_delay5_13_value
    Private flag_comp_delay5_13
    Private write_comp_delay4_12_value
    Private read_comp_delay4_12_value
    Private flag_comp_delay4_12

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

    Property Get get_comp_delay7_15
        get_comp_delay7_15 = read_comp_delay7_15_value
    End Property

    Property Let set_comp_delay7_15(aData)
        write_comp_delay7_15_value = aData
        flag_comp_delay7_15        = &H1
    End Property

    Property Get read_comp_delay7_15
        read
        read_comp_delay7_15 = read_comp_delay7_15_value
    End Property

    Property Let write_comp_delay7_15(aData)
        set_comp_delay7_15 = aData
        write
    End Property

    Property Get get_comp_delay6_14
        get_comp_delay6_14 = read_comp_delay6_14_value
    End Property

    Property Let set_comp_delay6_14(aData)
        write_comp_delay6_14_value = aData
        flag_comp_delay6_14        = &H1
    End Property

    Property Get read_comp_delay6_14
        read
        read_comp_delay6_14 = read_comp_delay6_14_value
    End Property

    Property Let write_comp_delay6_14(aData)
        set_comp_delay6_14 = aData
        write
    End Property

    Property Get get_comp_delay5_13
        get_comp_delay5_13 = read_comp_delay5_13_value
    End Property

    Property Let set_comp_delay5_13(aData)
        write_comp_delay5_13_value = aData
        flag_comp_delay5_13        = &H1
    End Property

    Property Get read_comp_delay5_13
        read
        read_comp_delay5_13 = read_comp_delay5_13_value
    End Property

    Property Let write_comp_delay5_13(aData)
        set_comp_delay5_13 = aData
        write
    End Property

    Property Get get_comp_delay4_12
        get_comp_delay4_12 = read_comp_delay4_12_value
    End Property

    Property Let set_comp_delay4_12(aData)
        write_comp_delay4_12_value = aData
        flag_comp_delay4_12        = &H1
    End Property

    Property Get read_comp_delay4_12
        read
        read_comp_delay4_12 = read_comp_delay4_12_value
    End Property

    Property Let write_comp_delay4_12(aData)
        set_comp_delay4_12 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_comp_delay7_15_value = rightShift(data_low, 12) and &Hf
        read_comp_delay6_14_value = rightShift(data_low, 8) and &Hf
        read_comp_delay5_13_value = rightShift(data_low, 4) and &Hf
        comp_delay4_12_mask = &Hf
        if data_low > LONG_MAX then
            if comp_delay4_12_mask = mask then
                read_comp_delay4_12_value = data_low
            else
                read_comp_delay4_12_value = (data_low - H8000_0000) and comp_delay4_12_mask
            end If
        else
            read_comp_delay4_12_value = data_low and comp_delay4_12_mask
        end If

    End Sub

    Sub write
        If flag_comp_delay7_15 = &H0 or flag_comp_delay6_14 = &H0 or flag_comp_delay5_13 = &H0 or flag_comp_delay4_12 = &H0 Then read
        If flag_comp_delay7_15 = &H0 Then write_comp_delay7_15_value = get_comp_delay7_15
        If flag_comp_delay6_14 = &H0 Then write_comp_delay6_14_value = get_comp_delay6_14
        If flag_comp_delay5_13 = &H0 Then write_comp_delay5_13_value = get_comp_delay5_13
        If flag_comp_delay4_12 = &H0 Then write_comp_delay4_12_value = get_comp_delay4_12

        regValue = leftShift((write_comp_delay7_15_value and &Hf), 12) + leftShift((write_comp_delay6_14_value and &Hf), 8) + leftShift((write_comp_delay5_13_value and &Hf), 4) + leftShift((write_comp_delay4_12_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_comp_delay7_15_value = rightShift(data_low, 12) and &Hf
        read_comp_delay6_14_value = rightShift(data_low, 8) and &Hf
        read_comp_delay5_13_value = rightShift(data_low, 4) and &Hf
        comp_delay4_12_mask = &Hf
        if data_low > LONG_MAX then
            if comp_delay4_12_mask = mask then
                read_comp_delay4_12_value = data_low
            else
                read_comp_delay4_12_value = (data_low - H8000_0000) and comp_delay4_12_mask
            end If
        else
            read_comp_delay4_12_value = data_low and comp_delay4_12_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_delay7_15_value = &H0
        flag_comp_delay7_15        = &H0
        write_comp_delay6_14_value = &H0
        flag_comp_delay6_14        = &H0
        write_comp_delay5_13_value = &H0
        flag_comp_delay5_13        = &H0
        write_comp_delay4_12_value = &H0
        flag_comp_delay4_12        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_comp_type
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_type                                  [15:0]           get_comp_type
''                                                             set_comp_type
''                                                             read_comp_type
''                                                             write_comp_type
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_comp_type
    Private write_comp_type_value
    Private read_comp_type_value
    Private flag_comp_type

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

    Property Get get_comp_type
        get_comp_type = read_comp_type_value
    End Property

    Property Let set_comp_type(aData)
        write_comp_type_value = aData
        flag_comp_type        = &H1
    End Property

    Property Get read_comp_type
        read
        read_comp_type = read_comp_type_value
    End Property

    Property Let write_comp_type(aData)
        set_comp_type = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_type_mask = &Hffff
        if data_low > LONG_MAX then
            if comp_type_mask = mask then
                read_comp_type_value = data_low
            else
                read_comp_type_value = (data_low - H8000_0000) and comp_type_mask
            end If
        else
            read_comp_type_value = data_low and comp_type_mask
        end If

    End Sub

    Sub write
        If flag_comp_type = &H0 Then read
        If flag_comp_type = &H0 Then write_comp_type_value = get_comp_type

        regValue = leftShift((write_comp_type_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_type_mask = &Hffff
        if data_low > LONG_MAX then
            if comp_type_mask = mask then
                read_comp_type_value = data_low
            else
                read_comp_type_value = (data_low - H8000_0000) and comp_type_mask
            end If
        else
            read_comp_type_value = data_low and comp_type_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_type_value = &H0
        flag_comp_type        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_comp_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_enable                                [15:0]           get_comp_enable
''                                                             set_comp_enable
''                                                             read_comp_enable
''                                                             write_comp_enable
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_comp_enable
    Private write_comp_enable_value
    Private read_comp_enable_value
    Private flag_comp_enable

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

    Property Get get_comp_enable
        get_comp_enable = read_comp_enable_value
    End Property

    Property Let set_comp_enable(aData)
        write_comp_enable_value = aData
        flag_comp_enable        = &H1
    End Property

    Property Get read_comp_enable
        read
        read_comp_enable = read_comp_enable_value
    End Property

    Property Let write_comp_enable(aData)
        set_comp_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_enable_mask = &Hffff
        if data_low > LONG_MAX then
            if comp_enable_mask = mask then
                read_comp_enable_value = data_low
            else
                read_comp_enable_value = (data_low - H8000_0000) and comp_enable_mask
            end If
        else
            read_comp_enable_value = data_low and comp_enable_mask
        end If

    End Sub

    Sub write
        If flag_comp_enable = &H0 Then read
        If flag_comp_enable = &H0 Then write_comp_enable_value = get_comp_enable

        regValue = leftShift((write_comp_enable_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_enable_mask = &Hffff
        if data_low > LONG_MAX then
            if comp_enable_mask = mask then
                read_comp_enable_value = data_low
            else
                read_comp_enable_value = (data_low - H8000_0000) and comp_enable_mask
            end If
        else
            read_comp_enable_value = data_low and comp_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_enable_value = &H0
        flag_comp_enable        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_refclksensetol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseTol                        [15:0]           get_mdio_RefclkSenseTol
''                                                             set_mdio_RefclkSenseTol
''                                                             read_mdio_RefclkSenseTol
''                                                             write_mdio_RefclkSenseTol
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_refclksensetol
    Private write_mdio_RefclkSenseTol_value
    Private read_mdio_RefclkSenseTol_value
    Private flag_mdio_RefclkSenseTol

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

    Property Get get_mdio_RefclkSenseTol
        get_mdio_RefclkSenseTol = read_mdio_RefclkSenseTol_value
    End Property

    Property Let set_mdio_RefclkSenseTol(aData)
        write_mdio_RefclkSenseTol_value = aData
        flag_mdio_RefclkSenseTol        = &H1
    End Property

    Property Get read_mdio_RefclkSenseTol
        read
        read_mdio_RefclkSenseTol = read_mdio_RefclkSenseTol_value
    End Property

    Property Let write_mdio_RefclkSenseTol(aData)
        set_mdio_RefclkSenseTol = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSenseTol_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSenseTol_mask = mask then
                read_mdio_RefclkSenseTol_value = data_low
            else
                read_mdio_RefclkSenseTol_value = (data_low - H8000_0000) and mdio_RefclkSenseTol_mask
            end If
        else
            read_mdio_RefclkSenseTol_value = data_low and mdio_RefclkSenseTol_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSenseTol = &H0 Then read
        If flag_mdio_RefclkSenseTol = &H0 Then write_mdio_RefclkSenseTol_value = get_mdio_RefclkSenseTol

        regValue = leftShift((write_mdio_RefclkSenseTol_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSenseTol_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSenseTol_mask = mask then
                read_mdio_RefclkSenseTol_value = data_low
            else
                read_mdio_RefclkSenseTol_value = (data_low - H8000_0000) and mdio_RefclkSenseTol_mask
            end If
        else
            read_mdio_RefclkSenseTol_value = data_low and mdio_RefclkSenseTol_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSenseTol_value = &H0
        flag_mdio_RefclkSenseTol        = &H0
    End Sub
End Class


'' @REGISTER : PCIE5__SGMIIPCIE_X1_xgxs_fe_tmux
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XGXS_fe_tmux                               [15:0]           get_XGXS_fe_tmux
''                                                             set_XGXS_fe_tmux
''                                                             read_XGXS_fe_tmux
''                                                             write_XGXS_fe_tmux
''---------------------------------------------------------------------------------
Class REGISTER_PCIE5__SGMIIPCIE_X1_xgxs_fe_tmux
    Private write_XGXS_fe_tmux_value
    Private read_XGXS_fe_tmux_value
    Private flag_XGXS_fe_tmux

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

    Property Get get_XGXS_fe_tmux
        get_XGXS_fe_tmux = read_XGXS_fe_tmux_value
    End Property

    Property Let set_XGXS_fe_tmux(aData)
        write_XGXS_fe_tmux_value = aData
        flag_XGXS_fe_tmux        = &H1
    End Property

    Property Get read_XGXS_fe_tmux
        read
        read_XGXS_fe_tmux = read_XGXS_fe_tmux_value
    End Property

    Property Let write_XGXS_fe_tmux(aData)
        set_XGXS_fe_tmux = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        XGXS_fe_tmux_mask = &Hffff
        if data_low > LONG_MAX then
            if XGXS_fe_tmux_mask = mask then
                read_XGXS_fe_tmux_value = data_low
            else
                read_XGXS_fe_tmux_value = (data_low - H8000_0000) and XGXS_fe_tmux_mask
            end If
        else
            read_XGXS_fe_tmux_value = data_low and XGXS_fe_tmux_mask
        end If

    End Sub

    Sub write
        If flag_XGXS_fe_tmux = &H0 Then read
        If flag_XGXS_fe_tmux = &H0 Then write_XGXS_fe_tmux_value = get_XGXS_fe_tmux

        regValue = leftShift((write_XGXS_fe_tmux_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        XGXS_fe_tmux_mask = &Hffff
        if data_low > LONG_MAX then
            if XGXS_fe_tmux_mask = mask then
                read_XGXS_fe_tmux_value = data_low
            else
                read_XGXS_fe_tmux_value = (data_low - H8000_0000) and XGXS_fe_tmux_mask
            end If
        else
            read_XGXS_fe_tmux_value = data_low and XGXS_fe_tmux_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XGXS_fe_tmux_value = &H0
        flag_XGXS_fe_tmux        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCIE5__SGMIIPCIE_X1_INSTANCE

    Public lanectrl15
    Public laneprbs0
    Public laneprbs1
    Public laneprbs2
    Public laneprbs3
    Public laneprbs4
    Public lanetest0
    Public lanetest1
    Public comp_delay0
    Public comp_delay1
    Public comp_type
    Public comp_enable
    Public refclksensetol
    Public xgxs_fe_tmux


    Public default function Init(aBaseAddr)
        Set lanectrl15 = (New REGISTER_PCIE5__SGMIIPCIE_X1_lanectrl15)(aBaseAddr, 16)
        Set laneprbs0 = (New REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs0)(aBaseAddr, 16)
        Set laneprbs1 = (New REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs1)(aBaseAddr, 16)
        Set laneprbs2 = (New REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs2)(aBaseAddr, 16)
        Set laneprbs3 = (New REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs3)(aBaseAddr, 16)
        Set laneprbs4 = (New REGISTER_PCIE5__SGMIIPCIE_X1_laneprbs4)(aBaseAddr, 16)
        Set lanetest0 = (New REGISTER_PCIE5__SGMIIPCIE_X1_lanetest0)(aBaseAddr, 16)
        Set lanetest1 = (New REGISTER_PCIE5__SGMIIPCIE_X1_lanetest1)(aBaseAddr, 16)
        Set comp_delay0 = (New REGISTER_PCIE5__SGMIIPCIE_X1_comp_delay0)(aBaseAddr, 16)
        Set comp_delay1 = (New REGISTER_PCIE5__SGMIIPCIE_X1_comp_delay1)(aBaseAddr, 16)
        Set comp_type = (New REGISTER_PCIE5__SGMIIPCIE_X1_comp_type)(aBaseAddr, 16)
        Set comp_enable = (New REGISTER_PCIE5__SGMIIPCIE_X1_comp_enable)(aBaseAddr, 16)
        Set refclksensetol = (New REGISTER_PCIE5__SGMIIPCIE_X1_refclksensetol)(aBaseAddr, 16)
        Set xgxs_fe_tmux = (New REGISTER_PCIE5__SGMIIPCIE_X1_xgxs_fe_tmux)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCIE5__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PCIE5__SGMIIPCIE_X1.Add ((New PCIE5__SGMIIPCIE_X1_INSTANCE)(&H4ade2a00))


