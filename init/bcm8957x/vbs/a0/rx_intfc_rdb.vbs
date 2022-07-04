

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


'' @REGISTER : RX_INTFC_rx_intfc_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AFE_RX_1000M_DELAY_SELECT                  [10:8]           get_AFE_RX_1000M_DELAY_SELECT
''                                                             set_AFE_RX_1000M_DELAY_SELECT
''                                                             read_AFE_RX_1000M_DELAY_SELECT
''                                                             write_AFE_RX_1000M_DELAY_SELECT
''---------------------------------------------------------------------------------
'' AFE_RX_100M_DELAY_SELECT                   [7:5]            get_AFE_RX_100M_DELAY_SELECT
''                                                             set_AFE_RX_100M_DELAY_SELECT
''                                                             read_AFE_RX_100M_DELAY_SELECT
''                                                             write_AFE_RX_100M_DELAY_SELECT
''---------------------------------------------------------------------------------
'' AFE_RX_T0_T1_SYM_INVERT                    [4:4]            get_AFE_RX_T0_T1_SYM_INVERT
''                                                             set_AFE_RX_T0_T1_SYM_INVERT
''                                                             read_AFE_RX_T0_T1_SYM_INVERT
''                                                             write_AFE_RX_T0_T1_SYM_INVERT
''---------------------------------------------------------------------------------
'' AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER         [3:3]            get_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
''                                                             set_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
''                                                             read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
''                                                             write_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
''---------------------------------------------------------------------------------
'' AFE_RX_T0_T1_SYM_SWAP                      [2:2]            get_AFE_RX_T0_T1_SYM_SWAP
''                                                             set_AFE_RX_T0_T1_SYM_SWAP
''                                                             read_AFE_RX_T0_T1_SYM_SWAP
''                                                             write_AFE_RX_T0_T1_SYM_SWAP
''---------------------------------------------------------------------------------
'' LINK_SYNC_T0_T1_SYM_SWAP                   [1:1]            get_LINK_SYNC_T0_T1_SYM_SWAP
''                                                             set_LINK_SYNC_T0_T1_SYM_SWAP
''                                                             read_LINK_SYNC_T0_T1_SYM_SWAP
''                                                             write_LINK_SYNC_T0_T1_SYM_SWAP
''---------------------------------------------------------------------------------
'' DSP_T0_T1_SYM_SWAP                         [0:0]            get_DSP_T0_T1_SYM_SWAP
''                                                             set_DSP_T0_T1_SYM_SWAP
''                                                             read_DSP_T0_T1_SYM_SWAP
''                                                             write_DSP_T0_T1_SYM_SWAP
''---------------------------------------------------------------------------------
Class REGISTER_RX_INTFC_rx_intfc_ctl
    Private write_AFE_RX_1000M_DELAY_SELECT_value
    Private read_AFE_RX_1000M_DELAY_SELECT_value
    Private flag_AFE_RX_1000M_DELAY_SELECT
    Private write_AFE_RX_100M_DELAY_SELECT_value
    Private read_AFE_RX_100M_DELAY_SELECT_value
    Private flag_AFE_RX_100M_DELAY_SELECT
    Private write_AFE_RX_T0_T1_SYM_INVERT_value
    Private read_AFE_RX_T0_T1_SYM_INVERT_value
    Private flag_AFE_RX_T0_T1_SYM_INVERT
    Private write_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    Private read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    Private flag_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
    Private write_AFE_RX_T0_T1_SYM_SWAP_value
    Private read_AFE_RX_T0_T1_SYM_SWAP_value
    Private flag_AFE_RX_T0_T1_SYM_SWAP
    Private write_LINK_SYNC_T0_T1_SYM_SWAP_value
    Private read_LINK_SYNC_T0_T1_SYM_SWAP_value
    Private flag_LINK_SYNC_T0_T1_SYM_SWAP
    Private write_DSP_T0_T1_SYM_SWAP_value
    Private read_DSP_T0_T1_SYM_SWAP_value
    Private flag_DSP_T0_T1_SYM_SWAP

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

    Property Get get_AFE_RX_1000M_DELAY_SELECT
        get_AFE_RX_1000M_DELAY_SELECT = read_AFE_RX_1000M_DELAY_SELECT_value
    End Property

    Property Let set_AFE_RX_1000M_DELAY_SELECT(aData)
        write_AFE_RX_1000M_DELAY_SELECT_value = aData
        flag_AFE_RX_1000M_DELAY_SELECT        = &H1
    End Property

    Property Get read_AFE_RX_1000M_DELAY_SELECT
        read
        read_AFE_RX_1000M_DELAY_SELECT = read_AFE_RX_1000M_DELAY_SELECT_value
    End Property

    Property Let write_AFE_RX_1000M_DELAY_SELECT(aData)
        set_AFE_RX_1000M_DELAY_SELECT = aData
        write
    End Property

    Property Get get_AFE_RX_100M_DELAY_SELECT
        get_AFE_RX_100M_DELAY_SELECT = read_AFE_RX_100M_DELAY_SELECT_value
    End Property

    Property Let set_AFE_RX_100M_DELAY_SELECT(aData)
        write_AFE_RX_100M_DELAY_SELECT_value = aData
        flag_AFE_RX_100M_DELAY_SELECT        = &H1
    End Property

    Property Get read_AFE_RX_100M_DELAY_SELECT
        read
        read_AFE_RX_100M_DELAY_SELECT = read_AFE_RX_100M_DELAY_SELECT_value
    End Property

    Property Let write_AFE_RX_100M_DELAY_SELECT(aData)
        set_AFE_RX_100M_DELAY_SELECT = aData
        write
    End Property

    Property Get get_AFE_RX_T0_T1_SYM_INVERT
        get_AFE_RX_T0_T1_SYM_INVERT = read_AFE_RX_T0_T1_SYM_INVERT_value
    End Property

    Property Let set_AFE_RX_T0_T1_SYM_INVERT(aData)
        write_AFE_RX_T0_T1_SYM_INVERT_value = aData
        flag_AFE_RX_T0_T1_SYM_INVERT        = &H1
    End Property

    Property Get read_AFE_RX_T0_T1_SYM_INVERT
        read
        read_AFE_RX_T0_T1_SYM_INVERT = read_AFE_RX_T0_T1_SYM_INVERT_value
    End Property

    Property Let write_AFE_RX_T0_T1_SYM_INVERT(aData)
        set_AFE_RX_T0_T1_SYM_INVERT = aData
        write
    End Property

    Property Get get_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
        get_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER = read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    End Property

    Property Let set_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER(aData)
        write_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value = aData
        flag_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER        = &H1
    End Property

    Property Get read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
        read
        read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER = read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    End Property

    Property Let write_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER(aData)
        set_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER = aData
        write
    End Property

    Property Get get_AFE_RX_T0_T1_SYM_SWAP
        get_AFE_RX_T0_T1_SYM_SWAP = read_AFE_RX_T0_T1_SYM_SWAP_value
    End Property

    Property Let set_AFE_RX_T0_T1_SYM_SWAP(aData)
        write_AFE_RX_T0_T1_SYM_SWAP_value = aData
        flag_AFE_RX_T0_T1_SYM_SWAP        = &H1
    End Property

    Property Get read_AFE_RX_T0_T1_SYM_SWAP
        read
        read_AFE_RX_T0_T1_SYM_SWAP = read_AFE_RX_T0_T1_SYM_SWAP_value
    End Property

    Property Let write_AFE_RX_T0_T1_SYM_SWAP(aData)
        set_AFE_RX_T0_T1_SYM_SWAP = aData
        write
    End Property

    Property Get get_LINK_SYNC_T0_T1_SYM_SWAP
        get_LINK_SYNC_T0_T1_SYM_SWAP = read_LINK_SYNC_T0_T1_SYM_SWAP_value
    End Property

    Property Let set_LINK_SYNC_T0_T1_SYM_SWAP(aData)
        write_LINK_SYNC_T0_T1_SYM_SWAP_value = aData
        flag_LINK_SYNC_T0_T1_SYM_SWAP        = &H1
    End Property

    Property Get read_LINK_SYNC_T0_T1_SYM_SWAP
        read
        read_LINK_SYNC_T0_T1_SYM_SWAP = read_LINK_SYNC_T0_T1_SYM_SWAP_value
    End Property

    Property Let write_LINK_SYNC_T0_T1_SYM_SWAP(aData)
        set_LINK_SYNC_T0_T1_SYM_SWAP = aData
        write
    End Property

    Property Get get_DSP_T0_T1_SYM_SWAP
        get_DSP_T0_T1_SYM_SWAP = read_DSP_T0_T1_SYM_SWAP_value
    End Property

    Property Let set_DSP_T0_T1_SYM_SWAP(aData)
        write_DSP_T0_T1_SYM_SWAP_value = aData
        flag_DSP_T0_T1_SYM_SWAP        = &H1
    End Property

    Property Get read_DSP_T0_T1_SYM_SWAP
        read
        read_DSP_T0_T1_SYM_SWAP = read_DSP_T0_T1_SYM_SWAP_value
    End Property

    Property Let write_DSP_T0_T1_SYM_SWAP(aData)
        set_DSP_T0_T1_SYM_SWAP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AFE_RX_1000M_DELAY_SELECT_value = rightShift(data_low, 8) and &H7
        read_AFE_RX_100M_DELAY_SELECT_value = rightShift(data_low, 5) and &H7
        read_AFE_RX_T0_T1_SYM_INVERT_value = rightShift(data_low, 4) and &H1
        read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value = rightShift(data_low, 3) and &H1
        read_AFE_RX_T0_T1_SYM_SWAP_value = rightShift(data_low, 2) and &H1
        read_LINK_SYNC_T0_T1_SYM_SWAP_value = rightShift(data_low, 1) and &H1
        DSP_T0_T1_SYM_SWAP_mask = &H1
        if data_low > LONG_MAX then
            if DSP_T0_T1_SYM_SWAP_mask = mask then
                read_DSP_T0_T1_SYM_SWAP_value = data_low
            else
                read_DSP_T0_T1_SYM_SWAP_value = (data_low - H8000_0000) and DSP_T0_T1_SYM_SWAP_mask
            end If
        else
            read_DSP_T0_T1_SYM_SWAP_value = data_low and DSP_T0_T1_SYM_SWAP_mask
        end If

    End Sub

    Sub write
        If flag_AFE_RX_1000M_DELAY_SELECT = &H0 or flag_AFE_RX_100M_DELAY_SELECT = &H0 or flag_AFE_RX_T0_T1_SYM_INVERT = &H0 or flag_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER = &H0 or flag_AFE_RX_T0_T1_SYM_SWAP = &H0 or flag_LINK_SYNC_T0_T1_SYM_SWAP = &H0 or flag_DSP_T0_T1_SYM_SWAP = &H0 Then read
        If flag_AFE_RX_1000M_DELAY_SELECT = &H0 Then write_AFE_RX_1000M_DELAY_SELECT_value = get_AFE_RX_1000M_DELAY_SELECT
        If flag_AFE_RX_100M_DELAY_SELECT = &H0 Then write_AFE_RX_100M_DELAY_SELECT_value = get_AFE_RX_100M_DELAY_SELECT
        If flag_AFE_RX_T0_T1_SYM_INVERT = &H0 Then write_AFE_RX_T0_T1_SYM_INVERT_value = get_AFE_RX_T0_T1_SYM_INVERT
        If flag_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER = &H0 Then write_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value = get_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER
        If flag_AFE_RX_T0_T1_SYM_SWAP = &H0 Then write_AFE_RX_T0_T1_SYM_SWAP_value = get_AFE_RX_T0_T1_SYM_SWAP
        If flag_LINK_SYNC_T0_T1_SYM_SWAP = &H0 Then write_LINK_SYNC_T0_T1_SYM_SWAP_value = get_LINK_SYNC_T0_T1_SYM_SWAP
        If flag_DSP_T0_T1_SYM_SWAP = &H0 Then write_DSP_T0_T1_SYM_SWAP_value = get_DSP_T0_T1_SYM_SWAP

        regValue = leftShift((write_AFE_RX_1000M_DELAY_SELECT_value and &H7), 8) + leftShift((write_AFE_RX_100M_DELAY_SELECT_value and &H7), 5) + leftShift((write_AFE_RX_T0_T1_SYM_INVERT_value and &H1), 4) + leftShift((write_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value and &H1), 3) + leftShift((write_AFE_RX_T0_T1_SYM_SWAP_value and &H1), 2) + leftShift((write_LINK_SYNC_T0_T1_SYM_SWAP_value and &H1), 1) + leftShift((write_DSP_T0_T1_SYM_SWAP_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AFE_RX_1000M_DELAY_SELECT_value = rightShift(data_low, 8) and &H7
        read_AFE_RX_100M_DELAY_SELECT_value = rightShift(data_low, 5) and &H7
        read_AFE_RX_T0_T1_SYM_INVERT_value = rightShift(data_low, 4) and &H1
        read_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value = rightShift(data_low, 3) and &H1
        read_AFE_RX_T0_T1_SYM_SWAP_value = rightShift(data_low, 2) and &H1
        read_LINK_SYNC_T0_T1_SYM_SWAP_value = rightShift(data_low, 1) and &H1
        DSP_T0_T1_SYM_SWAP_mask = &H1
        if data_low > LONG_MAX then
            if DSP_T0_T1_SYM_SWAP_mask = mask then
                read_DSP_T0_T1_SYM_SWAP_value = data_low
            else
                read_DSP_T0_T1_SYM_SWAP_value = (data_low - H8000_0000) and DSP_T0_T1_SYM_SWAP_mask
            end If
        else
            read_DSP_T0_T1_SYM_SWAP_value = data_low and DSP_T0_T1_SYM_SWAP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AFE_RX_1000M_DELAY_SELECT_value = &H0
        flag_AFE_RX_1000M_DELAY_SELECT        = &H0
        write_AFE_RX_100M_DELAY_SELECT_value = &H0
        flag_AFE_RX_100M_DELAY_SELECT        = &H0
        write_AFE_RX_T0_T1_SYM_INVERT_value = &H0
        flag_AFE_RX_T0_T1_SYM_INVERT        = &H0
        write_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER_value = &H0
        flag_AFE_RX_T0_T1_SYM_BIT_REVERSE_ORDER        = &H0
        write_AFE_RX_T0_T1_SYM_SWAP_value = &H0
        flag_AFE_RX_T0_T1_SYM_SWAP        = &H0
        write_LINK_SYNC_T0_T1_SYM_SWAP_value = &H0
        flag_LINK_SYNC_T0_T1_SYM_SWAP        = &H0
        write_DSP_T0_T1_SYM_SWAP_value = &H0
        flag_DSP_T0_T1_SYM_SWAP        = &H0
    End Sub
End Class


'' @REGISTER : RX_INTFC_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_END_ADDR                             [15:0]           get_SPARE_END_ADDR
''                                                             set_SPARE_END_ADDR
''                                                             read_SPARE_END_ADDR
''                                                             write_SPARE_END_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_RX_INTFC_spare_end_addr
    Private write_SPARE_END_ADDR_value
    Private read_SPARE_END_ADDR_value
    Private flag_SPARE_END_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_END_ADDR
        get_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let set_SPARE_END_ADDR(aData)
        write_SPARE_END_ADDR_value = aData
        flag_SPARE_END_ADDR        = &H1
    End Property

    Property Get read_SPARE_END_ADDR
        read
        read_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let write_SPARE_END_ADDR(aData)
        set_SPARE_END_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_END_ADDR = &H0 Then read
        If flag_SPARE_END_ADDR = &H0 Then write_SPARE_END_ADDR_value = get_SPARE_END_ADDR

        regValue = leftShift((write_SPARE_END_ADDR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_END_ADDR_value = &H0
        flag_SPARE_END_ADDR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RX_INTFC_INSTANCE

    Public rx_intfc_ctl
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set rx_intfc_ctl = (New REGISTER_RX_INTFC_rx_intfc_ctl)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_RX_INTFC_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_INTFC = CreateObject("System.Collections.ArrayList")
RX_INTFC.Add ((New RX_INTFC_INSTANCE)(&H49032800))


