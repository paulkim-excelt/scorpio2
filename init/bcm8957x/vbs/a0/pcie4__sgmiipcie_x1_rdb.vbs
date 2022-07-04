

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


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lane_ctrl0                                 [15:0]           get_lane_ctrl0
''                                                             set_lane_ctrl0
''                                                             read_lane_ctrl0
''                                                             write_lane_ctrl0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl0
    Private write_lane_ctrl0_value
    Private read_lane_ctrl0_value
    Private flag_lane_ctrl0

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

    Property Get get_lane_ctrl0
        get_lane_ctrl0 = read_lane_ctrl0_value
    End Property

    Property Let set_lane_ctrl0(aData)
        write_lane_ctrl0_value = aData
        flag_lane_ctrl0        = &H1
    End Property

    Property Get read_lane_ctrl0
        read
        read_lane_ctrl0 = read_lane_ctrl0_value
    End Property

    Property Let write_lane_ctrl0(aData)
        set_lane_ctrl0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_ctrl0_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_ctrl0_mask = mask then
                read_lane_ctrl0_value = data_low
            else
                read_lane_ctrl0_value = (data_low - H8000_0000) and lane_ctrl0_mask
            end If
        else
            read_lane_ctrl0_value = data_low and lane_ctrl0_mask
        end If

    End Sub

    Sub write
        If flag_lane_ctrl0 = &H0 Then read
        If flag_lane_ctrl0 = &H0 Then write_lane_ctrl0_value = get_lane_ctrl0

        regValue = leftShift((write_lane_ctrl0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_ctrl0_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_ctrl0_mask = mask then
                read_lane_ctrl0_value = data_low
            else
                read_lane_ctrl0_value = (data_low - H8000_0000) and lane_ctrl0_mask
            end If
        else
            read_lane_ctrl0_value = data_low and lane_ctrl0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lane_ctrl0_value = &H0
        flag_lane_ctrl0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lane_ctrl1                                 [15:0]           get_lane_ctrl1
''                                                             set_lane_ctrl1
''                                                             read_lane_ctrl1
''                                                             write_lane_ctrl1
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl1
    Private write_lane_ctrl1_value
    Private read_lane_ctrl1_value
    Private flag_lane_ctrl1

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

    Property Get get_lane_ctrl1
        get_lane_ctrl1 = read_lane_ctrl1_value
    End Property

    Property Let set_lane_ctrl1(aData)
        write_lane_ctrl1_value = aData
        flag_lane_ctrl1        = &H1
    End Property

    Property Get read_lane_ctrl1
        read
        read_lane_ctrl1 = read_lane_ctrl1_value
    End Property

    Property Let write_lane_ctrl1(aData)
        set_lane_ctrl1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_ctrl1_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_ctrl1_mask = mask then
                read_lane_ctrl1_value = data_low
            else
                read_lane_ctrl1_value = (data_low - H8000_0000) and lane_ctrl1_mask
            end If
        else
            read_lane_ctrl1_value = data_low and lane_ctrl1_mask
        end If

    End Sub

    Sub write
        If flag_lane_ctrl1 = &H0 Then read
        If flag_lane_ctrl1 = &H0 Then write_lane_ctrl1_value = get_lane_ctrl1

        regValue = leftShift((write_lane_ctrl1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lane_ctrl1_mask = &Hffff
        if data_low > LONG_MAX then
            if lane_ctrl1_mask = mask then
                read_lane_ctrl1_value = data_low
            else
                read_lane_ctrl1_value = (data_low - H8000_0000) and lane_ctrl1_mask
            end If
        else
            read_lane_ctrl1_value = data_low and lane_ctrl1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lane_ctrl1_value = &H0
        flag_lane_ctrl1        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' eden1g                                     [15:0]           get_eden1g
''                                                             set_eden1g
''                                                             read_eden1g
''                                                             write_eden1g
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl2
    Private write_eden1g_value
    Private read_eden1g_value
    Private flag_eden1g

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

    Property Get get_eden1g
        get_eden1g = read_eden1g_value
    End Property

    Property Let set_eden1g(aData)
        write_eden1g_value = aData
        flag_eden1g        = &H1
    End Property

    Property Get read_eden1g
        read
        read_eden1g = read_eden1g_value
    End Property

    Property Let write_eden1g(aData)
        set_eden1g = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        eden1g_mask = &Hffff
        if data_low > LONG_MAX then
            if eden1g_mask = mask then
                read_eden1g_value = data_low
            else
                read_eden1g_value = (data_low - H8000_0000) and eden1g_mask
            end If
        else
            read_eden1g_value = data_low and eden1g_mask
        end If

    End Sub

    Sub write
        If flag_eden1g = &H0 Then read
        If flag_eden1g = &H0 Then write_eden1g_value = get_eden1g

        regValue = leftShift((write_eden1g_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        eden1g_mask = &Hffff
        if data_low > LONG_MAX then
            if eden1g_mask = mask then
                read_eden1g_value = data_low
            else
                read_eden1g_value = (data_low - H8000_0000) and eden1g_mask
            end If
        else
            read_eden1g_value = data_low and eden1g_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_eden1g_value = &H0
        flag_eden1g        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdet_en1g                                  [15:0]           get_cdet_en1g
''                                                             set_cdet_en1g
''                                                             read_cdet_en1g
''                                                             write_cdet_en1g
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl3
    Private write_cdet_en1g_value
    Private read_cdet_en1g_value
    Private flag_cdet_en1g

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

    Property Get get_cdet_en1g
        get_cdet_en1g = read_cdet_en1g_value
    End Property

    Property Let set_cdet_en1g(aData)
        write_cdet_en1g_value = aData
        flag_cdet_en1g        = &H1
    End Property

    Property Get read_cdet_en1g
        read
        read_cdet_en1g = read_cdet_en1g_value
    End Property

    Property Let write_cdet_en1g(aData)
        set_cdet_en1g = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cdet_en1g_mask = &Hffff
        if data_low > LONG_MAX then
            if cdet_en1g_mask = mask then
                read_cdet_en1g_value = data_low
            else
                read_cdet_en1g_value = (data_low - H8000_0000) and cdet_en1g_mask
            end If
        else
            read_cdet_en1g_value = data_low and cdet_en1g_mask
        end If

    End Sub

    Sub write
        If flag_cdet_en1g = &H0 Then read
        If flag_cdet_en1g = &H0 Then write_cdet_en1g_value = get_cdet_en1g

        regValue = leftShift((write_cdet_en1g_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cdet_en1g_mask = &Hffff
        if data_low > LONG_MAX then
            if cdet_en1g_mask = mask then
                read_cdet_en1g_value = data_low
            else
                read_cdet_en1g_value = (data_low - H8000_0000) and cdet_en1g_mask
            end If
        else
            read_cdet_en1g_value = data_low and cdet_en1g_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdet_en1g_value = &H0
        flag_cdet_en1g        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdwn_rx_r                                [15:0]           get_pwrdwn_rx_r
''                                                             set_pwrdwn_rx_r
''                                                             read_pwrdwn_rx_r
''                                                             write_pwrdwn_rx_r
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl4
    Private write_pwrdwn_rx_r_value
    Private read_pwrdwn_rx_r_value
    Private flag_pwrdwn_rx_r

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

    Property Get get_pwrdwn_rx_r
        get_pwrdwn_rx_r = read_pwrdwn_rx_r_value
    End Property

    Property Let set_pwrdwn_rx_r(aData)
        write_pwrdwn_rx_r_value = aData
        flag_pwrdwn_rx_r        = &H1
    End Property

    Property Get read_pwrdwn_rx_r
        read
        read_pwrdwn_rx_r = read_pwrdwn_rx_r_value
    End Property

    Property Let write_pwrdwn_rx_r(aData)
        set_pwrdwn_rx_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_rx_r_mask = &Hffff
        if data_low > LONG_MAX then
            if pwrdwn_rx_r_mask = mask then
                read_pwrdwn_rx_r_value = data_low
            else
                read_pwrdwn_rx_r_value = (data_low - H8000_0000) and pwrdwn_rx_r_mask
            end If
        else
            read_pwrdwn_rx_r_value = data_low and pwrdwn_rx_r_mask
        end If

    End Sub

    Sub write
        If flag_pwrdwn_rx_r = &H0 Then read
        If flag_pwrdwn_rx_r = &H0 Then write_pwrdwn_rx_r_value = get_pwrdwn_rx_r

        regValue = leftShift((write_pwrdwn_rx_r_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_rx_r_mask = &Hffff
        if data_low > LONG_MAX then
            if pwrdwn_rx_r_mask = mask then
                read_pwrdwn_rx_r_value = data_low
            else
                read_pwrdwn_rx_r_value = (data_low - H8000_0000) and pwrdwn_rx_r_mask
            end If
        else
            read_pwrdwn_rx_r_value = data_low and pwrdwn_rx_r_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdwn_rx_r_value = &H0
        flag_pwrdwn_rx_r        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdwn_tx_r                                [15:0]           get_pwrdwn_tx_r
''                                                             set_pwrdwn_tx_r
''                                                             read_pwrdwn_tx_r
''                                                             write_pwrdwn_tx_r
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl5
    Private write_pwrdwn_tx_r_value
    Private read_pwrdwn_tx_r_value
    Private flag_pwrdwn_tx_r

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

    Property Get get_pwrdwn_tx_r
        get_pwrdwn_tx_r = read_pwrdwn_tx_r_value
    End Property

    Property Let set_pwrdwn_tx_r(aData)
        write_pwrdwn_tx_r_value = aData
        flag_pwrdwn_tx_r        = &H1
    End Property

    Property Get read_pwrdwn_tx_r
        read
        read_pwrdwn_tx_r = read_pwrdwn_tx_r_value
    End Property

    Property Let write_pwrdwn_tx_r(aData)
        set_pwrdwn_tx_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_tx_r_mask = &Hffff
        if data_low > LONG_MAX then
            if pwrdwn_tx_r_mask = mask then
                read_pwrdwn_tx_r_value = data_low
            else
                read_pwrdwn_tx_r_value = (data_low - H8000_0000) and pwrdwn_tx_r_mask
            end If
        else
            read_pwrdwn_tx_r_value = data_low and pwrdwn_tx_r_mask
        end If

    End Sub

    Sub write
        If flag_pwrdwn_tx_r = &H0 Then read
        If flag_pwrdwn_tx_r = &H0 Then write_pwrdwn_tx_r_value = get_pwrdwn_tx_r

        regValue = leftShift((write_pwrdwn_tx_r_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_tx_r_mask = &Hffff
        if data_low > LONG_MAX then
            if pwrdwn_tx_r_mask = mask then
                read_pwrdwn_tx_r_value = data_low
            else
                read_pwrdwn_tx_r_value = (data_low - H8000_0000) and pwrdwn_tx_r_mask
            end If
        else
            read_pwrdwn_tx_r_value = data_low and pwrdwn_tx_r_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdwn_tx_r_value = &H0
        flag_pwrdwn_tx_r        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdwn_10g_pll_dis                         [1:1]            get_pwrdwn_10g_pll_dis
''                                                             set_pwrdwn_10g_pll_dis
''                                                             read_pwrdwn_10g_pll_dis
''                                                             write_pwrdwn_10g_pll_dis
''---------------------------------------------------------------------------------
'' pwrdwn_pll_r                               [0:0]            get_pwrdwn_pll_r
''                                                             set_pwrdwn_pll_r
''                                                             read_pwrdwn_pll_r
''                                                             write_pwrdwn_pll_r
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl6
    Private write_pwrdwn_10g_pll_dis_value
    Private read_pwrdwn_10g_pll_dis_value
    Private flag_pwrdwn_10g_pll_dis
    Private write_pwrdwn_pll_r_value
    Private read_pwrdwn_pll_r_value
    Private flag_pwrdwn_pll_r

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

    Property Get get_pwrdwn_10g_pll_dis
        get_pwrdwn_10g_pll_dis = read_pwrdwn_10g_pll_dis_value
    End Property

    Property Let set_pwrdwn_10g_pll_dis(aData)
        write_pwrdwn_10g_pll_dis_value = aData
        flag_pwrdwn_10g_pll_dis        = &H1
    End Property

    Property Get read_pwrdwn_10g_pll_dis
        read
        read_pwrdwn_10g_pll_dis = read_pwrdwn_10g_pll_dis_value
    End Property

    Property Let write_pwrdwn_10g_pll_dis(aData)
        set_pwrdwn_10g_pll_dis = aData
        write
    End Property

    Property Get get_pwrdwn_pll_r
        get_pwrdwn_pll_r = read_pwrdwn_pll_r_value
    End Property

    Property Let set_pwrdwn_pll_r(aData)
        write_pwrdwn_pll_r_value = aData
        flag_pwrdwn_pll_r        = &H1
    End Property

    Property Get read_pwrdwn_pll_r
        read
        read_pwrdwn_pll_r = read_pwrdwn_pll_r_value
    End Property

    Property Let write_pwrdwn_pll_r(aData)
        set_pwrdwn_pll_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwrdwn_10g_pll_dis_value = rightShift(data_low, 1) and &H1
        pwrdwn_pll_r_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_pll_r_mask = mask then
                read_pwrdwn_pll_r_value = data_low
            else
                read_pwrdwn_pll_r_value = (data_low - H8000_0000) and pwrdwn_pll_r_mask
            end If
        else
            read_pwrdwn_pll_r_value = data_low and pwrdwn_pll_r_mask
        end If

    End Sub

    Sub write
        If flag_pwrdwn_10g_pll_dis = &H0 or flag_pwrdwn_pll_r = &H0 Then read
        If flag_pwrdwn_10g_pll_dis = &H0 Then write_pwrdwn_10g_pll_dis_value = get_pwrdwn_10g_pll_dis
        If flag_pwrdwn_pll_r = &H0 Then write_pwrdwn_pll_r_value = get_pwrdwn_pll_r

        regValue = leftShift((write_pwrdwn_10g_pll_dis_value and &H1), 1) + leftShift((write_pwrdwn_pll_r_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pwrdwn_10g_pll_dis_value = rightShift(data_low, 1) and &H1
        pwrdwn_pll_r_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_pll_r_mask = mask then
                read_pwrdwn_pll_r_value = data_low
            else
                read_pwrdwn_pll_r_value = (data_low - H8000_0000) and pwrdwn_pll_r_mask
            end If
        else
            read_pwrdwn_pll_r_value = data_low and pwrdwn_pll_r_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdwn_10g_pll_dis_value = &H0
        flag_pwrdwn_10g_pll_dis        = &H0
        write_pwrdwn_pll_r_value = &H0
        flag_pwrdwn_pll_r        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rst_sw_ln                                  [15:0]           get_rst_sw_ln
''                                                             set_rst_sw_ln
''                                                             read_rst_sw_ln
''                                                             write_rst_sw_ln
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl7
    Private write_rst_sw_ln_value
    Private read_rst_sw_ln_value
    Private flag_rst_sw_ln

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

    Property Get get_rst_sw_ln
        get_rst_sw_ln = read_rst_sw_ln_value
    End Property

    Property Let set_rst_sw_ln(aData)
        write_rst_sw_ln_value = aData
        flag_rst_sw_ln        = &H1
    End Property

    Property Get read_rst_sw_ln
        read
        read_rst_sw_ln = read_rst_sw_ln_value
    End Property

    Property Let write_rst_sw_ln(aData)
        set_rst_sw_ln = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rst_sw_ln_mask = &Hffff
        if data_low > LONG_MAX then
            if rst_sw_ln_mask = mask then
                read_rst_sw_ln_value = data_low
            else
                read_rst_sw_ln_value = (data_low - H8000_0000) and rst_sw_ln_mask
            end If
        else
            read_rst_sw_ln_value = data_low and rst_sw_ln_mask
        end If

    End Sub

    Sub write
        If flag_rst_sw_ln = &H0 Then read
        If flag_rst_sw_ln = &H0 Then write_rst_sw_ln_value = get_rst_sw_ln

        regValue = leftShift((write_rst_sw_ln_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rst_sw_ln_mask = &Hffff
        if data_low > LONG_MAX then
            if rst_sw_ln_mask = mask then
                read_rst_sw_ln_value = data_low
            else
                read_rst_sw_ln_value = (data_low - H8000_0000) and rst_sw_ln_mask
            end If
        else
            read_rst_sw_ln_value = data_low and rst_sw_ln_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rst_sw_ln_value = &H0
        flag_rst_sw_ln        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reset_anlg_r_ln                            [15:0]           get_reset_anlg_r_ln
''                                                             set_reset_anlg_r_ln
''                                                             read_reset_anlg_r_ln
''                                                             write_reset_anlg_r_ln
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl8
    Private write_reset_anlg_r_ln_value
    Private read_reset_anlg_r_ln_value
    Private flag_reset_anlg_r_ln

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

    Property Get get_reset_anlg_r_ln
        get_reset_anlg_r_ln = read_reset_anlg_r_ln_value
    End Property

    Property Let set_reset_anlg_r_ln(aData)
        write_reset_anlg_r_ln_value = aData
        flag_reset_anlg_r_ln        = &H1
    End Property

    Property Get read_reset_anlg_r_ln
        read
        read_reset_anlg_r_ln = read_reset_anlg_r_ln_value
    End Property

    Property Let write_reset_anlg_r_ln(aData)
        set_reset_anlg_r_ln = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reset_anlg_r_ln_mask = &Hffff
        if data_low > LONG_MAX then
            if reset_anlg_r_ln_mask = mask then
                read_reset_anlg_r_ln_value = data_low
            else
                read_reset_anlg_r_ln_value = (data_low - H8000_0000) and reset_anlg_r_ln_mask
            end If
        else
            read_reset_anlg_r_ln_value = data_low and reset_anlg_r_ln_mask
        end If

    End Sub

    Sub write
        If flag_reset_anlg_r_ln = &H0 Then read
        If flag_reset_anlg_r_ln = &H0 Then write_reset_anlg_r_ln_value = get_reset_anlg_r_ln

        regValue = leftShift((write_reset_anlg_r_ln_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reset_anlg_r_ln_mask = &Hffff
        if data_low > LONG_MAX then
            if reset_anlg_r_ln_mask = mask then
                read_reset_anlg_r_ln_value = data_low
            else
                read_reset_anlg_r_ln_value = (data_low - H8000_0000) and reset_anlg_r_ln_mask
            end If
        else
            read_reset_anlg_r_ln_value = data_low and reset_anlg_r_ln_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reset_anlg_r_ln_value = &H0
        flag_reset_anlg_r_ln        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_cont_en3                              [11:11]          get_mdio_cont_en3
''                                                             set_mdio_cont_en3
''                                                             read_mdio_cont_en3
''                                                             write_mdio_cont_en3
''---------------------------------------------------------------------------------
'' TxBeaconData                               [9:0]            get_TxBeaconData
''                                                             set_TxBeaconData
''                                                             read_TxBeaconData
''                                                             write_TxBeaconData
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl9
    Private write_mdio_cont_en3_value
    Private read_mdio_cont_en3_value
    Private flag_mdio_cont_en3
    Private write_TxBeaconData_value
    Private read_TxBeaconData_value
    Private flag_TxBeaconData

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

    Property Get get_mdio_cont_en3
        get_mdio_cont_en3 = read_mdio_cont_en3_value
    End Property

    Property Let set_mdio_cont_en3(aData)
        write_mdio_cont_en3_value = aData
        flag_mdio_cont_en3        = &H1
    End Property

    Property Get read_mdio_cont_en3
        read
        read_mdio_cont_en3 = read_mdio_cont_en3_value
    End Property

    Property Let write_mdio_cont_en3(aData)
        set_mdio_cont_en3 = aData
        write
    End Property

    Property Get get_TxBeaconData
        get_TxBeaconData = read_TxBeaconData_value
    End Property

    Property Let set_TxBeaconData(aData)
        write_TxBeaconData_value = aData
        flag_TxBeaconData        = &H1
    End Property

    Property Get read_TxBeaconData
        read
        read_TxBeaconData = read_TxBeaconData_value
    End Property

    Property Let write_TxBeaconData(aData)
        set_TxBeaconData = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_cont_en3_value = rightShift(data_low, 11) and &H1
        TxBeaconData_mask = &H3ff
        if data_low > LONG_MAX then
            if TxBeaconData_mask = mask then
                read_TxBeaconData_value = data_low
            else
                read_TxBeaconData_value = (data_low - H8000_0000) and TxBeaconData_mask
            end If
        else
            read_TxBeaconData_value = data_low and TxBeaconData_mask
        end If

    End Sub

    Sub write
        If flag_mdio_cont_en3 = &H0 or flag_TxBeaconData = &H0 Then read
        If flag_mdio_cont_en3 = &H0 Then write_mdio_cont_en3_value = get_mdio_cont_en3
        If flag_TxBeaconData = &H0 Then write_TxBeaconData_value = get_TxBeaconData

        regValue = leftShift((write_mdio_cont_en3_value and &H1), 11) + leftShift((write_TxBeaconData_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_cont_en3_value = rightShift(data_low, 11) and &H1
        TxBeaconData_mask = &H3ff
        if data_low > LONG_MAX then
            if TxBeaconData_mask = mask then
                read_TxBeaconData_value = data_low
            else
                read_TxBeaconData_value = (data_low - H8000_0000) and TxBeaconData_mask
            end If
        else
            read_TxBeaconData_value = data_low and TxBeaconData_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_cont_en3_value = &H0
        flag_mdio_cont_en3        = &H0
        write_TxBeaconData_value = &H0
        flag_TxBeaconData        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable_mdwr4rst                            [0:0]            get_enable_mdwr4rst
''                                                             set_enable_mdwr4rst
''                                                             read_enable_mdwr4rst
''                                                             write_enable_mdwr4rst
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl10
    Private write_enable_mdwr4rst_value
    Private read_enable_mdwr4rst_value
    Private flag_enable_mdwr4rst

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

    Property Get get_enable_mdwr4rst
        get_enable_mdwr4rst = read_enable_mdwr4rst_value
    End Property

    Property Let set_enable_mdwr4rst(aData)
        write_enable_mdwr4rst_value = aData
        flag_enable_mdwr4rst        = &H1
    End Property

    Property Get read_enable_mdwr4rst
        read
        read_enable_mdwr4rst = read_enable_mdwr4rst_value
    End Property

    Property Let write_enable_mdwr4rst(aData)
        set_enable_mdwr4rst = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_mdwr4rst_mask = &H1
        if data_low > LONG_MAX then
            if enable_mdwr4rst_mask = mask then
                read_enable_mdwr4rst_value = data_low
            else
                read_enable_mdwr4rst_value = (data_low - H8000_0000) and enable_mdwr4rst_mask
            end If
        else
            read_enable_mdwr4rst_value = data_low and enable_mdwr4rst_mask
        end If

    End Sub

    Sub write
        If flag_enable_mdwr4rst = &H0 Then read
        If flag_enable_mdwr4rst = &H0 Then write_enable_mdwr4rst_value = get_enable_mdwr4rst

        regValue = leftShift((write_enable_mdwr4rst_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_mdwr4rst_mask = &H1
        if data_low > LONG_MAX then
            if enable_mdwr4rst_mask = mask then
                read_enable_mdwr4rst_value = data_low
            else
                read_enable_mdwr4rst_value = (data_low - H8000_0000) and enable_mdwr4rst_mask
            end If
        else
            read_enable_mdwr4rst_value = data_low and enable_mdwr4rst_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_mdwr4rst_value = &H0
        flag_enable_mdwr4rst        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' elastic_autorst_en                         [15:0]           get_elastic_autorst_en
''                                                             set_elastic_autorst_en
''                                                             read_elastic_autorst_en
''                                                             write_elastic_autorst_en
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl11
    Private write_elastic_autorst_en_value
    Private read_elastic_autorst_en_value
    Private flag_elastic_autorst_en

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

    Property Get get_elastic_autorst_en
        get_elastic_autorst_en = read_elastic_autorst_en_value
    End Property

    Property Let set_elastic_autorst_en(aData)
        write_elastic_autorst_en_value = aData
        flag_elastic_autorst_en        = &H1
    End Property

    Property Get read_elastic_autorst_en
        read
        read_elastic_autorst_en = read_elastic_autorst_en_value
    End Property

    Property Let write_elastic_autorst_en(aData)
        set_elastic_autorst_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        elastic_autorst_en_mask = &Hffff
        if data_low > LONG_MAX then
            if elastic_autorst_en_mask = mask then
                read_elastic_autorst_en_value = data_low
            else
                read_elastic_autorst_en_value = (data_low - H8000_0000) and elastic_autorst_en_mask
            end If
        else
            read_elastic_autorst_en_value = data_low and elastic_autorst_en_mask
        end If

    End Sub

    Sub write
        If flag_elastic_autorst_en = &H0 Then read
        If flag_elastic_autorst_en = &H0 Then write_elastic_autorst_en_value = get_elastic_autorst_en

        regValue = leftShift((write_elastic_autorst_en_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        elastic_autorst_en_mask = &Hffff
        if data_low > LONG_MAX then
            if elastic_autorst_en_mask = mask then
                read_elastic_autorst_en_value = data_low
            else
                read_elastic_autorst_en_value = (data_low - H8000_0000) and elastic_autorst_en_mask
            end If
        else
            read_elastic_autorst_en_value = data_low and elastic_autorst_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_elastic_autorst_en_value = &H0
        flag_elastic_autorst_en        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comma_adj_fsm_sel                          [15:0]           get_comma_adj_fsm_sel
''                                                             set_comma_adj_fsm_sel
''                                                             read_comma_adj_fsm_sel
''                                                             write_comma_adj_fsm_sel
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl12
    Private write_comma_adj_fsm_sel_value
    Private read_comma_adj_fsm_sel_value
    Private flag_comma_adj_fsm_sel

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

    Property Get get_comma_adj_fsm_sel
        get_comma_adj_fsm_sel = read_comma_adj_fsm_sel_value
    End Property

    Property Let set_comma_adj_fsm_sel(aData)
        write_comma_adj_fsm_sel_value = aData
        flag_comma_adj_fsm_sel        = &H1
    End Property

    Property Get read_comma_adj_fsm_sel
        read
        read_comma_adj_fsm_sel = read_comma_adj_fsm_sel_value
    End Property

    Property Let write_comma_adj_fsm_sel(aData)
        set_comma_adj_fsm_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comma_adj_fsm_sel_mask = &Hffff
        if data_low > LONG_MAX then
            if comma_adj_fsm_sel_mask = mask then
                read_comma_adj_fsm_sel_value = data_low
            else
                read_comma_adj_fsm_sel_value = (data_low - H8000_0000) and comma_adj_fsm_sel_mask
            end If
        else
            read_comma_adj_fsm_sel_value = data_low and comma_adj_fsm_sel_mask
        end If

    End Sub

    Sub write
        If flag_comma_adj_fsm_sel = &H0 Then read
        If flag_comma_adj_fsm_sel = &H0 Then write_comma_adj_fsm_sel_value = get_comma_adj_fsm_sel

        regValue = leftShift((write_comma_adj_fsm_sel_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comma_adj_fsm_sel_mask = &Hffff
        if data_low > LONG_MAX then
            if comma_adj_fsm_sel_mask = mask then
                read_comma_adj_fsm_sel_value = data_low
            else
                read_comma_adj_fsm_sel_value = (data_low - H8000_0000) and comma_adj_fsm_sel_mask
            end If
        else
            read_comma_adj_fsm_sel_value = data_low and comma_adj_fsm_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comma_adj_fsm_sel_value = &H0
        flag_comma_adj_fsm_sel        = &H0
    End Sub
End Class


'' @REGISTER : PCIE4__SGMIIPCIE_X1_lanectrl13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RcvrDetectTimeout                          [15:0]           get_RcvrDetectTimeout
''                                                             set_RcvrDetectTimeout
''                                                             read_RcvrDetectTimeout
''                                                             write_RcvrDetectTimeout
''---------------------------------------------------------------------------------
Class REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl13
    Private write_RcvrDetectTimeout_value
    Private read_RcvrDetectTimeout_value
    Private flag_RcvrDetectTimeout

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

    Property Get get_RcvrDetectTimeout
        get_RcvrDetectTimeout = read_RcvrDetectTimeout_value
    End Property

    Property Let set_RcvrDetectTimeout(aData)
        write_RcvrDetectTimeout_value = aData
        flag_RcvrDetectTimeout        = &H1
    End Property

    Property Get read_RcvrDetectTimeout
        read
        read_RcvrDetectTimeout = read_RcvrDetectTimeout_value
    End Property

    Property Let write_RcvrDetectTimeout(aData)
        set_RcvrDetectTimeout = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RcvrDetectTimeout_mask = &Hffff
        if data_low > LONG_MAX then
            if RcvrDetectTimeout_mask = mask then
                read_RcvrDetectTimeout_value = data_low
            else
                read_RcvrDetectTimeout_value = (data_low - H8000_0000) and RcvrDetectTimeout_mask
            end If
        else
            read_RcvrDetectTimeout_value = data_low and RcvrDetectTimeout_mask
        end If

    End Sub

    Sub write
        If flag_RcvrDetectTimeout = &H0 Then read
        If flag_RcvrDetectTimeout = &H0 Then write_RcvrDetectTimeout_value = get_RcvrDetectTimeout

        regValue = leftShift((write_RcvrDetectTimeout_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RcvrDetectTimeout_mask = &Hffff
        if data_low > LONG_MAX then
            if RcvrDetectTimeout_mask = mask then
                read_RcvrDetectTimeout_value = data_low
            else
                read_RcvrDetectTimeout_value = (data_low - H8000_0000) and RcvrDetectTimeout_mask
            end If
        else
            read_RcvrDetectTimeout_value = data_low and RcvrDetectTimeout_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RcvrDetectTimeout_value = &H0
        flag_RcvrDetectTimeout        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCIE4__SGMIIPCIE_X1_INSTANCE

    Public lanectrl0
    Public lanectrl1
    Public lanectrl2
    Public lanectrl3
    Public lanectrl4
    Public lanectrl5
    Public lanectrl6
    Public lanectrl7
    Public lanectrl8
    Public lanectrl9
    Public lanectrl10
    Public lanectrl11
    Public lanectrl12
    Public lanectrl13


    Public default function Init(aBaseAddr)
        Set lanectrl0 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl0)(aBaseAddr, 16)
        Set lanectrl1 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl1)(aBaseAddr, 16)
        Set lanectrl2 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl2)(aBaseAddr, 16)
        Set lanectrl3 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl3)(aBaseAddr, 16)
        Set lanectrl4 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl4)(aBaseAddr, 16)
        Set lanectrl5 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl5)(aBaseAddr, 16)
        Set lanectrl6 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl6)(aBaseAddr, 16)
        Set lanectrl7 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl7)(aBaseAddr, 16)
        Set lanectrl8 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl8)(aBaseAddr, 16)
        Set lanectrl9 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl9)(aBaseAddr, 16)
        Set lanectrl10 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl10)(aBaseAddr, 16)
        Set lanectrl11 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl11)(aBaseAddr, 16)
        Set lanectrl12 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl12)(aBaseAddr, 16)
        Set lanectrl13 = (New REGISTER_PCIE4__SGMIIPCIE_X1_lanectrl13)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCIE4__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PCIE4__SGMIIPCIE_X1.Add ((New PCIE4__SGMIIPCIE_X1_INSTANCE)(&H4ade2800))


