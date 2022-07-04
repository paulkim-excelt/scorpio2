

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


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ctrl_15_0                                  [15:0]           get_ctrl_15_0
''                                                             set_ctrl_15_0
''                                                             read_ctrl_15_0
''                                                             write_ctrl_15_0
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl0
    Private write_ctrl_15_0_value
    Private read_ctrl_15_0_value
    Private flag_ctrl_15_0

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

    Property Get get_ctrl_15_0
        get_ctrl_15_0 = read_ctrl_15_0_value
    End Property

    Property Let set_ctrl_15_0(aData)
        write_ctrl_15_0_value = aData
        flag_ctrl_15_0        = &H1
    End Property

    Property Get read_ctrl_15_0
        read
        read_ctrl_15_0 = read_ctrl_15_0_value
    End Property

    Property Let write_ctrl_15_0(aData)
        set_ctrl_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_15_0_mask = mask then
                read_ctrl_15_0_value = data_low
            else
                read_ctrl_15_0_value = (data_low - H8000_0000) and ctrl_15_0_mask
            end If
        else
            read_ctrl_15_0_value = data_low and ctrl_15_0_mask
        end If

    End Sub

    Sub write
        If flag_ctrl_15_0 = &H0 Then read
        If flag_ctrl_15_0 = &H0 Then write_ctrl_15_0_value = get_ctrl_15_0

        regValue = leftShift((write_ctrl_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_15_0_mask = mask then
                read_ctrl_15_0_value = data_low
            else
                read_ctrl_15_0_value = (data_low - H8000_0000) and ctrl_15_0_mask
            end If
        else
            read_ctrl_15_0_value = data_low and ctrl_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ctrl_15_0_value = &H0
        flag_ctrl_15_0        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ctrl_31_16                                 [15:0]           get_ctrl_31_16
''                                                             set_ctrl_31_16
''                                                             read_ctrl_31_16
''                                                             write_ctrl_31_16
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl1
    Private write_ctrl_31_16_value
    Private read_ctrl_31_16_value
    Private flag_ctrl_31_16

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

    Property Get get_ctrl_31_16
        get_ctrl_31_16 = read_ctrl_31_16_value
    End Property

    Property Let set_ctrl_31_16(aData)
        write_ctrl_31_16_value = aData
        flag_ctrl_31_16        = &H1
    End Property

    Property Get read_ctrl_31_16
        read
        read_ctrl_31_16 = read_ctrl_31_16_value
    End Property

    Property Let write_ctrl_31_16(aData)
        set_ctrl_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_31_16_mask = mask then
                read_ctrl_31_16_value = data_low
            else
                read_ctrl_31_16_value = (data_low - H8000_0000) and ctrl_31_16_mask
            end If
        else
            read_ctrl_31_16_value = data_low and ctrl_31_16_mask
        end If

    End Sub

    Sub write
        If flag_ctrl_31_16 = &H0 Then read
        If flag_ctrl_31_16 = &H0 Then write_ctrl_31_16_value = get_ctrl_31_16

        regValue = leftShift((write_ctrl_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_31_16_mask = mask then
                read_ctrl_31_16_value = data_low
            else
                read_ctrl_31_16_value = (data_low - H8000_0000) and ctrl_31_16_mask
            end If
        else
            read_ctrl_31_16_value = data_low and ctrl_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ctrl_31_16_value = &H0
        flag_ctrl_31_16        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ctrl_47_32                                 [15:0]           get_ctrl_47_32
''                                                             set_ctrl_47_32
''                                                             read_ctrl_47_32
''                                                             write_ctrl_47_32
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl2
    Private write_ctrl_47_32_value
    Private read_ctrl_47_32_value
    Private flag_ctrl_47_32

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

    Property Get get_ctrl_47_32
        get_ctrl_47_32 = read_ctrl_47_32_value
    End Property

    Property Let set_ctrl_47_32(aData)
        write_ctrl_47_32_value = aData
        flag_ctrl_47_32        = &H1
    End Property

    Property Get read_ctrl_47_32
        read
        read_ctrl_47_32 = read_ctrl_47_32_value
    End Property

    Property Let write_ctrl_47_32(aData)
        set_ctrl_47_32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_47_32_mask = mask then
                read_ctrl_47_32_value = data_low
            else
                read_ctrl_47_32_value = (data_low - H8000_0000) and ctrl_47_32_mask
            end If
        else
            read_ctrl_47_32_value = data_low and ctrl_47_32_mask
        end If

    End Sub

    Sub write
        If flag_ctrl_47_32 = &H0 Then read
        If flag_ctrl_47_32 = &H0 Then write_ctrl_47_32_value = get_ctrl_47_32

        regValue = leftShift((write_ctrl_47_32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_47_32_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_47_32_mask = mask then
                read_ctrl_47_32_value = data_low
            else
                read_ctrl_47_32_value = (data_low - H8000_0000) and ctrl_47_32_mask
            end If
        else
            read_ctrl_47_32_value = data_low and ctrl_47_32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ctrl_47_32_value = &H0
        flag_ctrl_47_32        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ctrl_63_48                                 [15:0]           get_ctrl_63_48
''                                                             set_ctrl_63_48
''                                                             read_ctrl_63_48
''                                                             write_ctrl_63_48
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl3
    Private write_ctrl_63_48_value
    Private read_ctrl_63_48_value
    Private flag_ctrl_63_48

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

    Property Get get_ctrl_63_48
        get_ctrl_63_48 = read_ctrl_63_48_value
    End Property

    Property Let set_ctrl_63_48(aData)
        write_ctrl_63_48_value = aData
        flag_ctrl_63_48        = &H1
    End Property

    Property Get read_ctrl_63_48
        read
        read_ctrl_63_48 = read_ctrl_63_48_value
    End Property

    Property Let write_ctrl_63_48(aData)
        set_ctrl_63_48 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_63_48_mask = mask then
                read_ctrl_63_48_value = data_low
            else
                read_ctrl_63_48_value = (data_low - H8000_0000) and ctrl_63_48_mask
            end If
        else
            read_ctrl_63_48_value = data_low and ctrl_63_48_mask
        end If

    End Sub

    Sub write
        If flag_ctrl_63_48 = &H0 Then read
        If flag_ctrl_63_48 = &H0 Then write_ctrl_63_48_value = get_ctrl_63_48

        regValue = leftShift((write_ctrl_63_48_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_63_48_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_63_48_mask = mask then
                read_ctrl_63_48_value = data_low
            else
                read_ctrl_63_48_value = (data_low - H8000_0000) and ctrl_63_48_mask
            end If
        else
            read_ctrl_63_48_value = data_low and ctrl_63_48_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ctrl_63_48_value = &H0
        flag_ctrl_63_48        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ctrl_79_64                                 [15:0]           get_ctrl_79_64
''                                                             set_ctrl_79_64
''                                                             read_ctrl_79_64
''                                                             write_ctrl_79_64
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl4
    Private write_ctrl_79_64_value
    Private read_ctrl_79_64_value
    Private flag_ctrl_79_64

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

    Property Get get_ctrl_79_64
        get_ctrl_79_64 = read_ctrl_79_64_value
    End Property

    Property Let set_ctrl_79_64(aData)
        write_ctrl_79_64_value = aData
        flag_ctrl_79_64        = &H1
    End Property

    Property Get read_ctrl_79_64
        read
        read_ctrl_79_64 = read_ctrl_79_64_value
    End Property

    Property Let write_ctrl_79_64(aData)
        set_ctrl_79_64 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_79_64_mask = mask then
                read_ctrl_79_64_value = data_low
            else
                read_ctrl_79_64_value = (data_low - H8000_0000) and ctrl_79_64_mask
            end If
        else
            read_ctrl_79_64_value = data_low and ctrl_79_64_mask
        end If

    End Sub

    Sub write
        If flag_ctrl_79_64 = &H0 Then read
        If flag_ctrl_79_64 = &H0 Then write_ctrl_79_64_value = get_ctrl_79_64

        regValue = leftShift((write_ctrl_79_64_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_79_64_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_79_64_mask = mask then
                read_ctrl_79_64_value = data_low
            else
                read_ctrl_79_64_value = (data_low - H8000_0000) and ctrl_79_64_mask
            end If
        else
            read_ctrl_79_64_value = data_low and ctrl_79_64_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ctrl_79_64_value = &H0
        flag_ctrl_79_64        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ctrl_95_80                                 [15:0]           get_ctrl_95_80
''                                                             set_ctrl_95_80
''                                                             read_ctrl_95_80
''                                                             write_ctrl_95_80
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl5
    Private write_ctrl_95_80_value
    Private read_ctrl_95_80_value
    Private flag_ctrl_95_80

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

    Property Get get_ctrl_95_80
        get_ctrl_95_80 = read_ctrl_95_80_value
    End Property

    Property Let set_ctrl_95_80(aData)
        write_ctrl_95_80_value = aData
        flag_ctrl_95_80        = &H1
    End Property

    Property Get read_ctrl_95_80
        read
        read_ctrl_95_80 = read_ctrl_95_80_value
    End Property

    Property Let write_ctrl_95_80(aData)
        set_ctrl_95_80 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_95_80_mask = mask then
                read_ctrl_95_80_value = data_low
            else
                read_ctrl_95_80_value = (data_low - H8000_0000) and ctrl_95_80_mask
            end If
        else
            read_ctrl_95_80_value = data_low and ctrl_95_80_mask
        end If

    End Sub

    Sub write
        If flag_ctrl_95_80 = &H0 Then read
        If flag_ctrl_95_80 = &H0 Then write_ctrl_95_80_value = get_ctrl_95_80

        regValue = leftShift((write_ctrl_95_80_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_95_80_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_95_80_mask = mask then
                read_ctrl_95_80_value = data_low
            else
                read_ctrl_95_80_value = (data_low - H8000_0000) and ctrl_95_80_mask
            end If
        else
            read_ctrl_95_80_value = data_low and ctrl_95_80_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ctrl_95_80_value = &H0
        flag_ctrl_95_80        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ctrl_111_96                                [15:0]           get_ctrl_111_96
''                                                             set_ctrl_111_96
''                                                             read_ctrl_111_96
''                                                             write_ctrl_111_96
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl6
    Private write_ctrl_111_96_value
    Private read_ctrl_111_96_value
    Private flag_ctrl_111_96

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

    Property Get get_ctrl_111_96
        get_ctrl_111_96 = read_ctrl_111_96_value
    End Property

    Property Let set_ctrl_111_96(aData)
        write_ctrl_111_96_value = aData
        flag_ctrl_111_96        = &H1
    End Property

    Property Get read_ctrl_111_96
        read
        read_ctrl_111_96 = read_ctrl_111_96_value
    End Property

    Property Let write_ctrl_111_96(aData)
        set_ctrl_111_96 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_111_96_mask = mask then
                read_ctrl_111_96_value = data_low
            else
                read_ctrl_111_96_value = (data_low - H8000_0000) and ctrl_111_96_mask
            end If
        else
            read_ctrl_111_96_value = data_low and ctrl_111_96_mask
        end If

    End Sub

    Sub write
        If flag_ctrl_111_96 = &H0 Then read
        If flag_ctrl_111_96 = &H0 Then write_ctrl_111_96_value = get_ctrl_111_96

        regValue = leftShift((write_ctrl_111_96_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ctrl_111_96_mask = &Hffff
        if data_low > LONG_MAX then
            if ctrl_111_96_mask = mask then
                read_ctrl_111_96_value = data_low
            else
                read_ctrl_111_96_value = (data_low - H8000_0000) and ctrl_111_96_mask
            end If
        else
            read_ctrl_111_96_value = data_low and ctrl_111_96_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ctrl_111_96_value = &H0
        flag_ctrl_111_96        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_ctrlg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_tcSelect                              [15:8]           get_mdio_tcSelect
''                                                             set_mdio_tcSelect
''                                                             read_mdio_tcSelect
''                                                             write_mdio_tcSelect
''---------------------------------------------------------------------------------
'' mdio_rx0_pf_ctrl                           [7:4]            get_mdio_rx0_pf_ctrl
''                                                             set_mdio_rx0_pf_ctrl
''                                                             read_mdio_rx0_pf_ctrl
''                                                             write_mdio_rx0_pf_ctrl
''---------------------------------------------------------------------------------
'' mdio_rx0_pf_ctrl_sel                       [3:3]            get_mdio_rx0_pf_ctrl_sel
''                                                             set_mdio_rx0_pf_ctrl_sel
''                                                             read_mdio_rx0_pf_ctrl_sel
''                                                             write_mdio_rx0_pf_ctrl_sel
''---------------------------------------------------------------------------------
'' mdio_sel_fts_L0S                           [2:2]            get_mdio_sel_fts_L0S
''                                                             set_mdio_sel_fts_L0S
''                                                             read_mdio_sel_fts_L0S
''                                                             write_mdio_sel_fts_L0S
''---------------------------------------------------------------------------------
'' mdio_sel_com_num                           [1:0]            get_mdio_sel_com_num
''                                                             set_mdio_sel_com_num
''                                                             read_mdio_sel_com_num
''                                                             write_mdio_sel_com_num
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrlg1
    Private write_mdio_tcSelect_value
    Private read_mdio_tcSelect_value
    Private flag_mdio_tcSelect
    Private write_mdio_rx0_pf_ctrl_value
    Private read_mdio_rx0_pf_ctrl_value
    Private flag_mdio_rx0_pf_ctrl
    Private write_mdio_rx0_pf_ctrl_sel_value
    Private read_mdio_rx0_pf_ctrl_sel_value
    Private flag_mdio_rx0_pf_ctrl_sel
    Private write_mdio_sel_fts_L0S_value
    Private read_mdio_sel_fts_L0S_value
    Private flag_mdio_sel_fts_L0S
    Private write_mdio_sel_com_num_value
    Private read_mdio_sel_com_num_value
    Private flag_mdio_sel_com_num

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

    Property Get get_mdio_tcSelect
        get_mdio_tcSelect = read_mdio_tcSelect_value
    End Property

    Property Let set_mdio_tcSelect(aData)
        write_mdio_tcSelect_value = aData
        flag_mdio_tcSelect        = &H1
    End Property

    Property Get read_mdio_tcSelect
        read
        read_mdio_tcSelect = read_mdio_tcSelect_value
    End Property

    Property Let write_mdio_tcSelect(aData)
        set_mdio_tcSelect = aData
        write
    End Property

    Property Get get_mdio_rx0_pf_ctrl
        get_mdio_rx0_pf_ctrl = read_mdio_rx0_pf_ctrl_value
    End Property

    Property Let set_mdio_rx0_pf_ctrl(aData)
        write_mdio_rx0_pf_ctrl_value = aData
        flag_mdio_rx0_pf_ctrl        = &H1
    End Property

    Property Get read_mdio_rx0_pf_ctrl
        read
        read_mdio_rx0_pf_ctrl = read_mdio_rx0_pf_ctrl_value
    End Property

    Property Let write_mdio_rx0_pf_ctrl(aData)
        set_mdio_rx0_pf_ctrl = aData
        write
    End Property

    Property Get get_mdio_rx0_pf_ctrl_sel
        get_mdio_rx0_pf_ctrl_sel = read_mdio_rx0_pf_ctrl_sel_value
    End Property

    Property Let set_mdio_rx0_pf_ctrl_sel(aData)
        write_mdio_rx0_pf_ctrl_sel_value = aData
        flag_mdio_rx0_pf_ctrl_sel        = &H1
    End Property

    Property Get read_mdio_rx0_pf_ctrl_sel
        read
        read_mdio_rx0_pf_ctrl_sel = read_mdio_rx0_pf_ctrl_sel_value
    End Property

    Property Let write_mdio_rx0_pf_ctrl_sel(aData)
        set_mdio_rx0_pf_ctrl_sel = aData
        write
    End Property

    Property Get get_mdio_sel_fts_L0S
        get_mdio_sel_fts_L0S = read_mdio_sel_fts_L0S_value
    End Property

    Property Let set_mdio_sel_fts_L0S(aData)
        write_mdio_sel_fts_L0S_value = aData
        flag_mdio_sel_fts_L0S        = &H1
    End Property

    Property Get read_mdio_sel_fts_L0S
        read
        read_mdio_sel_fts_L0S = read_mdio_sel_fts_L0S_value
    End Property

    Property Let write_mdio_sel_fts_L0S(aData)
        set_mdio_sel_fts_L0S = aData
        write
    End Property

    Property Get get_mdio_sel_com_num
        get_mdio_sel_com_num = read_mdio_sel_com_num_value
    End Property

    Property Let set_mdio_sel_com_num(aData)
        write_mdio_sel_com_num_value = aData
        flag_mdio_sel_com_num        = &H1
    End Property

    Property Get read_mdio_sel_com_num
        read
        read_mdio_sel_com_num = read_mdio_sel_com_num_value
    End Property

    Property Let write_mdio_sel_com_num(aData)
        set_mdio_sel_com_num = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_tcSelect_value = rightShift(data_low, 8) and &Hff
        read_mdio_rx0_pf_ctrl_value = rightShift(data_low, 4) and &Hf
        read_mdio_rx0_pf_ctrl_sel_value = rightShift(data_low, 3) and &H1
        read_mdio_sel_fts_L0S_value = rightShift(data_low, 2) and &H1
        mdio_sel_com_num_mask = &H3
        if data_low > LONG_MAX then
            if mdio_sel_com_num_mask = mask then
                read_mdio_sel_com_num_value = data_low
            else
                read_mdio_sel_com_num_value = (data_low - H8000_0000) and mdio_sel_com_num_mask
            end If
        else
            read_mdio_sel_com_num_value = data_low and mdio_sel_com_num_mask
        end If

    End Sub

    Sub write
        If flag_mdio_tcSelect = &H0 or flag_mdio_rx0_pf_ctrl = &H0 or flag_mdio_rx0_pf_ctrl_sel = &H0 or flag_mdio_sel_fts_L0S = &H0 or flag_mdio_sel_com_num = &H0 Then read
        If flag_mdio_tcSelect = &H0 Then write_mdio_tcSelect_value = get_mdio_tcSelect
        If flag_mdio_rx0_pf_ctrl = &H0 Then write_mdio_rx0_pf_ctrl_value = get_mdio_rx0_pf_ctrl
        If flag_mdio_rx0_pf_ctrl_sel = &H0 Then write_mdio_rx0_pf_ctrl_sel_value = get_mdio_rx0_pf_ctrl_sel
        If flag_mdio_sel_fts_L0S = &H0 Then write_mdio_sel_fts_L0S_value = get_mdio_sel_fts_L0S
        If flag_mdio_sel_com_num = &H0 Then write_mdio_sel_com_num_value = get_mdio_sel_com_num

        regValue = leftShift((write_mdio_tcSelect_value and &Hff), 8) + leftShift((write_mdio_rx0_pf_ctrl_value and &Hf), 4) + leftShift((write_mdio_rx0_pf_ctrl_sel_value and &H1), 3) + leftShift((write_mdio_sel_fts_L0S_value and &H1), 2) + leftShift((write_mdio_sel_com_num_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_tcSelect_value = rightShift(data_low, 8) and &Hff
        read_mdio_rx0_pf_ctrl_value = rightShift(data_low, 4) and &Hf
        read_mdio_rx0_pf_ctrl_sel_value = rightShift(data_low, 3) and &H1
        read_mdio_sel_fts_L0S_value = rightShift(data_low, 2) and &H1
        mdio_sel_com_num_mask = &H3
        if data_low > LONG_MAX then
            if mdio_sel_com_num_mask = mask then
                read_mdio_sel_com_num_value = data_low
            else
                read_mdio_sel_com_num_value = (data_low - H8000_0000) and mdio_sel_com_num_mask
            end If
        else
            read_mdio_sel_com_num_value = data_low and mdio_sel_com_num_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_tcSelect_value = &H0
        flag_mdio_tcSelect        = &H0
        write_mdio_rx0_pf_ctrl_value = &H0
        flag_mdio_rx0_pf_ctrl        = &H0
        write_mdio_rx0_pf_ctrl_sel_value = &H0
        flag_mdio_rx0_pf_ctrl_sel        = &H0
        write_mdio_sel_fts_L0S_value = &H0
        flag_mdio_sel_fts_L0S        = &H0
        write_mdio_sel_com_num_value = &H0
        flag_mdio_sel_com_num        = &H0
    End Sub
End Class


'' @REGISTER : RX_AFE0__SGMIIPCIE_X1_astatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' status                                     [15:0]           get_status
''                                                             set_status
''                                                             read_status
''                                                             write_status
''---------------------------------------------------------------------------------
Class REGISTER_RX_AFE0__SGMIIPCIE_X1_astatus
    Private write_status_value
    Private read_status_value
    Private flag_status

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

    Property Get get_status
        get_status = read_status_value
    End Property

    Property Let set_status(aData)
        write_status_value = aData
        flag_status        = &H1
    End Property

    Property Get read_status
        read
        read_status = read_status_value
    End Property

    Property Let write_status(aData)
        set_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status_mask = &Hffff
        if data_low > LONG_MAX then
            if status_mask = mask then
                read_status_value = data_low
            else
                read_status_value = (data_low - H8000_0000) and status_mask
            end If
        else
            read_status_value = data_low and status_mask
        end If

    End Sub

    Sub write
        If flag_status = &H0 Then read
        If flag_status = &H0 Then write_status_value = get_status

        regValue = leftShift((write_status_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status_mask = &Hffff
        if data_low > LONG_MAX then
            if status_mask = mask then
                read_status_value = data_low
            else
                read_status_value = (data_low - H8000_0000) and status_mask
            end If
        else
            read_status_value = data_low and status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_status_value = &H0
        flag_status        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RX_AFE0__SGMIIPCIE_X1_INSTANCE

    Public ctrl0
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public ctrl4
    Public ctrl5
    Public ctrl6
    Public ctrlg1
    Public astatus


    Public default function Init(aBaseAddr)
        Set ctrl0 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl0)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl3)(aBaseAddr, 16)
        Set ctrl4 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl4)(aBaseAddr, 16)
        Set ctrl5 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl5)(aBaseAddr, 16)
        Set ctrl6 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrl6)(aBaseAddr, 16)
        Set ctrlg1 = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_ctrlg1)(aBaseAddr, 16)
        Set astatus = (New REGISTER_RX_AFE0__SGMIIPCIE_X1_astatus)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_AFE0__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX_AFE0__SGMIIPCIE_X1.Add ((New RX_AFE0__SGMIIPCIE_X1_INSTANCE)(&H4adec000))


