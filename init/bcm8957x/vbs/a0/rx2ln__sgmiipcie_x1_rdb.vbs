

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


'' @REGISTER : RX2LN__SGMIIPCIE_X1_fx100_rxcontrol1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxdata_sel                                 [9:6]            get_rxdata_sel
''                                                             set_rxdata_sel
''                                                             read_rxdata_sel
''                                                             write_rxdata_sel
''---------------------------------------------------------------------------------
'' full_duplex                                [1:1]            get_full_duplex
''                                                             set_full_duplex
''                                                             read_full_duplex
''                                                             write_full_duplex
''---------------------------------------------------------------------------------
Class REGISTER_RX2LN__SGMIIPCIE_X1_fx100_rxcontrol1
    Private write_rxdata_sel_value
    Private read_rxdata_sel_value
    Private flag_rxdata_sel
    Private write_full_duplex_value
    Private read_full_duplex_value
    Private flag_full_duplex

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

    Property Get get_rxdata_sel
        get_rxdata_sel = read_rxdata_sel_value
    End Property

    Property Let set_rxdata_sel(aData)
        write_rxdata_sel_value = aData
        flag_rxdata_sel        = &H1
    End Property

    Property Get read_rxdata_sel
        read
        read_rxdata_sel = read_rxdata_sel_value
    End Property

    Property Let write_rxdata_sel(aData)
        set_rxdata_sel = aData
        write
    End Property

    Property Get get_full_duplex
        get_full_duplex = read_full_duplex_value
    End Property

    Property Let set_full_duplex(aData)
        write_full_duplex_value = aData
        flag_full_duplex        = &H1
    End Property

    Property Get read_full_duplex
        read
        read_full_duplex = read_full_duplex_value
    End Property

    Property Let write_full_duplex(aData)
        set_full_duplex = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxdata_sel_value = rightShift(data_low, 6) and &Hf
        read_full_duplex_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_rxdata_sel = &H0 or flag_full_duplex = &H0 Then read
        If flag_rxdata_sel = &H0 Then write_rxdata_sel_value = get_rxdata_sel
        If flag_full_duplex = &H0 Then write_full_duplex_value = get_full_duplex

        regValue = leftShift((write_rxdata_sel_value and &Hf), 6) + leftShift((write_full_duplex_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxdata_sel_value = rightShift(data_low, 6) and &Hf
        read_full_duplex_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxdata_sel_value = &H0
        flag_rxdata_sel        = &H0
        write_full_duplex_value = &H0
        flag_full_duplex        = &H0
    End Sub
End Class


'' @REGISTER : RX2LN__SGMIIPCIE_X1_fx100_rxcontrol3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' number_of_idle                             [15:8]           get_number_of_idle
''                                                             set_number_of_idle
''                                                             read_number_of_idle
''                                                             write_number_of_idle
''---------------------------------------------------------------------------------
'' correlator_disable                         [7:7]            get_correlator_disable
''                                                             set_correlator_disable
''                                                             read_correlator_disable
''                                                             write_correlator_disable
''---------------------------------------------------------------------------------
Class REGISTER_RX2LN__SGMIIPCIE_X1_fx100_rxcontrol3
    Private write_number_of_idle_value
    Private read_number_of_idle_value
    Private flag_number_of_idle
    Private write_correlator_disable_value
    Private read_correlator_disable_value
    Private flag_correlator_disable

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

    Property Get get_number_of_idle
        get_number_of_idle = read_number_of_idle_value
    End Property

    Property Let set_number_of_idle(aData)
        write_number_of_idle_value = aData
        flag_number_of_idle        = &H1
    End Property

    Property Get read_number_of_idle
        read
        read_number_of_idle = read_number_of_idle_value
    End Property

    Property Let write_number_of_idle(aData)
        set_number_of_idle = aData
        write
    End Property

    Property Get get_correlator_disable
        get_correlator_disable = read_correlator_disable_value
    End Property

    Property Let set_correlator_disable(aData)
        write_correlator_disable_value = aData
        flag_correlator_disable        = &H1
    End Property

    Property Get read_correlator_disable
        read
        read_correlator_disable = read_correlator_disable_value
    End Property

    Property Let write_correlator_disable(aData)
        set_correlator_disable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_number_of_idle_value = rightShift(data_low, 8) and &Hff
        read_correlator_disable_value = rightShift(data_low, 7) and &H1

    End Sub

    Sub write
        If flag_number_of_idle = &H0 or flag_correlator_disable = &H0 Then read
        If flag_number_of_idle = &H0 Then write_number_of_idle_value = get_number_of_idle
        If flag_correlator_disable = &H0 Then write_correlator_disable_value = get_correlator_disable

        regValue = leftShift((write_number_of_idle_value and &Hff), 8) + leftShift((write_correlator_disable_value and &H1), 7)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_number_of_idle_value = rightShift(data_low, 8) and &Hff
        read_correlator_disable_value = rightShift(data_low, 7) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_number_of_idle_value = &H0
        flag_number_of_idle        = &H0
        write_correlator_disable_value = &H0
        flag_correlator_disable        = &H0
    End Sub
End Class


'' @REGISTER : RX2LN__SGMIIPCIE_X1_blockaddress
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
Class REGISTER_RX2LN__SGMIIPCIE_X1_blockaddress
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

Class RX2LN__SGMIIPCIE_X1_INSTANCE

    Public fx100_rxcontrol1
    Public fx100_rxcontrol3
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set fx100_rxcontrol1 = (New REGISTER_RX2LN__SGMIIPCIE_X1_fx100_rxcontrol1)(aBaseAddr, 16)
        Set fx100_rxcontrol3 = (New REGISTER_RX2LN__SGMIIPCIE_X1_fx100_rxcontrol3)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX2LN__SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX2LN__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX2LN__SGMIIPCIE_X1.Add ((New RX2LN__SGMIIPCIE_X1_INSTANCE)(&H4add01c0))


