

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


'' @REGISTER : RXLN__SGMIIPCIE_X1_rx_prbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbsmon_en                                 [12:12]          get_prbsmon_en
''                                                             set_prbsmon_en
''                                                             read_prbsmon_en
''                                                             write_prbsmon_en
''---------------------------------------------------------------------------------
'' prbsmon_inv                                [11:11]          get_prbsmon_inv
''                                                             set_prbsmon_inv
''                                                             read_prbsmon_inv
''                                                             write_prbsmon_inv
''---------------------------------------------------------------------------------
'' prbsmon_order                              [10:8]           get_prbsmon_order
''                                                             set_prbsmon_order
''                                                             read_prbsmon_order
''                                                             write_prbsmon_order
''---------------------------------------------------------------------------------
Class REGISTER_RXLN__SGMIIPCIE_X1_rx_prbs
    Private write_prbsmon_en_value
    Private read_prbsmon_en_value
    Private flag_prbsmon_en
    Private write_prbsmon_inv_value
    Private read_prbsmon_inv_value
    Private flag_prbsmon_inv
    Private write_prbsmon_order_value
    Private read_prbsmon_order_value
    Private flag_prbsmon_order

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

    Property Get get_prbsmon_en
        get_prbsmon_en = read_prbsmon_en_value
    End Property

    Property Let set_prbsmon_en(aData)
        write_prbsmon_en_value = aData
        flag_prbsmon_en        = &H1
    End Property

    Property Get read_prbsmon_en
        read
        read_prbsmon_en = read_prbsmon_en_value
    End Property

    Property Let write_prbsmon_en(aData)
        set_prbsmon_en = aData
        write
    End Property

    Property Get get_prbsmon_inv
        get_prbsmon_inv = read_prbsmon_inv_value
    End Property

    Property Let set_prbsmon_inv(aData)
        write_prbsmon_inv_value = aData
        flag_prbsmon_inv        = &H1
    End Property

    Property Get read_prbsmon_inv
        read
        read_prbsmon_inv = read_prbsmon_inv_value
    End Property

    Property Let write_prbsmon_inv(aData)
        set_prbsmon_inv = aData
        write
    End Property

    Property Get get_prbsmon_order
        get_prbsmon_order = read_prbsmon_order_value
    End Property

    Property Let set_prbsmon_order(aData)
        write_prbsmon_order_value = aData
        flag_prbsmon_order        = &H1
    End Property

    Property Get read_prbsmon_order
        read
        read_prbsmon_order = read_prbsmon_order_value
    End Property

    Property Let write_prbsmon_order(aData)
        set_prbsmon_order = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbsmon_en_value = rightShift(data_low, 12) and &H1
        read_prbsmon_inv_value = rightShift(data_low, 11) and &H1
        read_prbsmon_order_value = rightShift(data_low, 8) and &H7

    End Sub

    Sub write
        If flag_prbsmon_en = &H0 or flag_prbsmon_inv = &H0 or flag_prbsmon_order = &H0 Then read
        If flag_prbsmon_en = &H0 Then write_prbsmon_en_value = get_prbsmon_en
        If flag_prbsmon_inv = &H0 Then write_prbsmon_inv_value = get_prbsmon_inv
        If flag_prbsmon_order = &H0 Then write_prbsmon_order_value = get_prbsmon_order

        regValue = leftShift((write_prbsmon_en_value and &H1), 12) + leftShift((write_prbsmon_inv_value and &H1), 11) + leftShift((write_prbsmon_order_value and &H7), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbsmon_en_value = rightShift(data_low, 12) and &H1
        read_prbsmon_inv_value = rightShift(data_low, 11) and &H1
        read_prbsmon_order_value = rightShift(data_low, 8) and &H7

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbsmon_en_value = &H0
        flag_prbsmon_en        = &H0
        write_prbsmon_inv_value = &H0
        flag_prbsmon_inv        = &H0
        write_prbsmon_order_value = &H0
        flag_prbsmon_order        = &H0
    End Sub
End Class


'' @REGISTER : RXLN__SGMIIPCIE_X1_rx_control1000x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LPI_en_rx                                  [15:15]          get_LPI_en_rx
''                                                             set_LPI_en_rx
''                                                             read_LPI_en_rx
''                                                             write_LPI_en_rx
''---------------------------------------------------------------------------------
'' ECCFED                                     [6:6]            get_ECCFED
''                                                             set_ECCFED
''                                                             read_ECCFED
''                                                             write_ECCFED
''---------------------------------------------------------------------------------
'' crc_checker_disable                        [5:5]            get_crc_checker_disable
''                                                             set_crc_checker_disable
''                                                             read_crc_checker_disable
''                                                             write_crc_checker_disable
''---------------------------------------------------------------------------------
'' autodet_en                                 [4:4]            get_autodet_en
''                                                             set_autodet_en
''                                                             read_autodet_en
''                                                             write_autodet_en
''---------------------------------------------------------------------------------
'' invert_signal_detect                       [3:3]            get_invert_signal_detect
''                                                             set_invert_signal_detect
''                                                             read_invert_signal_detect
''                                                             write_invert_signal_detect
''---------------------------------------------------------------------------------
'' signal_detect_en                           [2:2]            get_signal_detect_en
''                                                             set_signal_detect_en
''                                                             read_signal_detect_en
''                                                             write_signal_detect_en
''---------------------------------------------------------------------------------
Class REGISTER_RXLN__SGMIIPCIE_X1_rx_control1000x1
    Private write_LPI_en_rx_value
    Private read_LPI_en_rx_value
    Private flag_LPI_en_rx
    Private write_ECCFED_value
    Private read_ECCFED_value
    Private flag_ECCFED
    Private write_crc_checker_disable_value
    Private read_crc_checker_disable_value
    Private flag_crc_checker_disable
    Private write_autodet_en_value
    Private read_autodet_en_value
    Private flag_autodet_en
    Private write_invert_signal_detect_value
    Private read_invert_signal_detect_value
    Private flag_invert_signal_detect
    Private write_signal_detect_en_value
    Private read_signal_detect_en_value
    Private flag_signal_detect_en

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

    Property Get get_LPI_en_rx
        get_LPI_en_rx = read_LPI_en_rx_value
    End Property

    Property Let set_LPI_en_rx(aData)
        write_LPI_en_rx_value = aData
        flag_LPI_en_rx        = &H1
    End Property

    Property Get read_LPI_en_rx
        read
        read_LPI_en_rx = read_LPI_en_rx_value
    End Property

    Property Let write_LPI_en_rx(aData)
        set_LPI_en_rx = aData
        write
    End Property

    Property Get get_ECCFED
        get_ECCFED = read_ECCFED_value
    End Property

    Property Let set_ECCFED(aData)
        write_ECCFED_value = aData
        flag_ECCFED        = &H1
    End Property

    Property Get read_ECCFED
        read
        read_ECCFED = read_ECCFED_value
    End Property

    Property Let write_ECCFED(aData)
        set_ECCFED = aData
        write
    End Property

    Property Get get_crc_checker_disable
        get_crc_checker_disable = read_crc_checker_disable_value
    End Property

    Property Let set_crc_checker_disable(aData)
        write_crc_checker_disable_value = aData
        flag_crc_checker_disable        = &H1
    End Property

    Property Get read_crc_checker_disable
        read
        read_crc_checker_disable = read_crc_checker_disable_value
    End Property

    Property Let write_crc_checker_disable(aData)
        set_crc_checker_disable = aData
        write
    End Property

    Property Get get_autodet_en
        get_autodet_en = read_autodet_en_value
    End Property

    Property Let set_autodet_en(aData)
        write_autodet_en_value = aData
        flag_autodet_en        = &H1
    End Property

    Property Get read_autodet_en
        read
        read_autodet_en = read_autodet_en_value
    End Property

    Property Let write_autodet_en(aData)
        set_autodet_en = aData
        write
    End Property

    Property Get get_invert_signal_detect
        get_invert_signal_detect = read_invert_signal_detect_value
    End Property

    Property Let set_invert_signal_detect(aData)
        write_invert_signal_detect_value = aData
        flag_invert_signal_detect        = &H1
    End Property

    Property Get read_invert_signal_detect
        read
        read_invert_signal_detect = read_invert_signal_detect_value
    End Property

    Property Let write_invert_signal_detect(aData)
        set_invert_signal_detect = aData
        write
    End Property

    Property Get get_signal_detect_en
        get_signal_detect_en = read_signal_detect_en_value
    End Property

    Property Let set_signal_detect_en(aData)
        write_signal_detect_en_value = aData
        flag_signal_detect_en        = &H1
    End Property

    Property Get read_signal_detect_en
        read
        read_signal_detect_en = read_signal_detect_en_value
    End Property

    Property Let write_signal_detect_en(aData)
        set_signal_detect_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_en_rx_value = rightShift(data_low, 15) and &H1
        read_ECCFED_value = rightShift(data_low, 6) and &H1
        read_crc_checker_disable_value = rightShift(data_low, 5) and &H1
        read_autodet_en_value = rightShift(data_low, 4) and &H1
        read_invert_signal_detect_value = rightShift(data_low, 3) and &H1
        read_signal_detect_en_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_LPI_en_rx = &H0 or flag_ECCFED = &H0 or flag_crc_checker_disable = &H0 or flag_autodet_en = &H0 or flag_invert_signal_detect = &H0 or flag_signal_detect_en = &H0 Then read
        If flag_LPI_en_rx = &H0 Then write_LPI_en_rx_value = get_LPI_en_rx
        If flag_ECCFED = &H0 Then write_ECCFED_value = get_ECCFED
        If flag_crc_checker_disable = &H0 Then write_crc_checker_disable_value = get_crc_checker_disable
        If flag_autodet_en = &H0 Then write_autodet_en_value = get_autodet_en
        If flag_invert_signal_detect = &H0 Then write_invert_signal_detect_value = get_invert_signal_detect
        If flag_signal_detect_en = &H0 Then write_signal_detect_en_value = get_signal_detect_en

        regValue = leftShift((write_LPI_en_rx_value and &H1), 15) + leftShift((write_ECCFED_value and &H1), 6) + leftShift((write_crc_checker_disable_value and &H1), 5) + leftShift((write_autodet_en_value and &H1), 4) + leftShift((write_invert_signal_detect_value and &H1), 3) + leftShift((write_signal_detect_en_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_en_rx_value = rightShift(data_low, 15) and &H1
        read_ECCFED_value = rightShift(data_low, 6) and &H1
        read_crc_checker_disable_value = rightShift(data_low, 5) and &H1
        read_autodet_en_value = rightShift(data_low, 4) and &H1
        read_invert_signal_detect_value = rightShift(data_low, 3) and &H1
        read_signal_detect_en_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LPI_en_rx_value = &H0
        flag_LPI_en_rx        = &H0
        write_ECCFED_value = &H0
        flag_ECCFED        = &H0
        write_crc_checker_disable_value = &H0
        flag_crc_checker_disable        = &H0
        write_autodet_en_value = &H0
        flag_autodet_en        = &H0
        write_invert_signal_detect_value = &H0
        flag_invert_signal_detect        = &H0
        write_signal_detect_en_value = &H0
        flag_signal_detect_en        = &H0
    End Sub
End Class


'' @REGISTER : RXLN__SGMIIPCIE_X1_blockaddress
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
Class REGISTER_RXLN__SGMIIPCIE_X1_blockaddress
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

Class RXLN__SGMIIPCIE_X1_INSTANCE

    Public rx_prbs
    Public rx_control1000x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set rx_prbs = (New REGISTER_RXLN__SGMIIPCIE_X1_rx_prbs)(aBaseAddr, 16)
        Set rx_control1000x1 = (New REGISTER_RXLN__SGMIIPCIE_X1_rx_control1000x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RXLN__SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RXLN__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RXLN__SGMIIPCIE_X1.Add ((New RXLN__SGMIIPCIE_X1_INSTANCE)(&H4add01a0))


