

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


'' @REGISTER : PCS_IEEE_pcs_control_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_Reset                                  [15:15]          get_PCS_Reset
''                                                             set_PCS_Reset
''                                                             read_PCS_Reset
''                                                             write_PCS_Reset
''---------------------------------------------------------------------------------
'' Loopback                                   [14:14]          get_Loopback
''                                                             set_Loopback
''                                                             read_Loopback
''                                                             write_Loopback
''---------------------------------------------------------------------------------
'' SPEED_SELECT_13                            [13:13]          get_SPEED_SELECT_13
''                                                             set_SPEED_SELECT_13
''                                                             read_SPEED_SELECT_13
''                                                             write_SPEED_SELECT_13
''---------------------------------------------------------------------------------
'' LOW_POWER                                  [11:11]          get_LOW_POWER
''                                                             set_LOW_POWER
''                                                             read_LOW_POWER
''                                                             write_LOW_POWER
''---------------------------------------------------------------------------------
'' Clock_Stop_Enable                          [10:10]          get_Clock_Stop_Enable
''                                                             set_Clock_Stop_Enable
''                                                             read_Clock_Stop_Enable
''                                                             write_Clock_Stop_Enable
''---------------------------------------------------------------------------------
'' SPEED_SELECT_6                             [6:6]            get_SPEED_SELECT_6
''                                                             set_SPEED_SELECT_6
''                                                             read_SPEED_SELECT_6
''                                                             write_SPEED_SELECT_6
''---------------------------------------------------------------------------------
'' SPEED_SELECT                               [5:2]            get_SPEED_SELECT
''                                                             set_SPEED_SELECT
''                                                             read_SPEED_SELECT
''                                                             write_SPEED_SELECT
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_pcs_control_reg1
    Private write_PCS_Reset_value
    Private read_PCS_Reset_value
    Private flag_PCS_Reset
    Private write_Loopback_value
    Private read_Loopback_value
    Private flag_Loopback
    Private write_SPEED_SELECT_13_value
    Private read_SPEED_SELECT_13_value
    Private flag_SPEED_SELECT_13
    Private write_LOW_POWER_value
    Private read_LOW_POWER_value
    Private flag_LOW_POWER
    Private write_Clock_Stop_Enable_value
    Private read_Clock_Stop_Enable_value
    Private flag_Clock_Stop_Enable
    Private write_SPEED_SELECT_6_value
    Private read_SPEED_SELECT_6_value
    Private flag_SPEED_SELECT_6
    Private write_SPEED_SELECT_value
    Private read_SPEED_SELECT_value
    Private flag_SPEED_SELECT

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

    Property Get get_PCS_Reset
        get_PCS_Reset = read_PCS_Reset_value
    End Property

    Property Let set_PCS_Reset(aData)
        write_PCS_Reset_value = aData
        flag_PCS_Reset        = &H1
    End Property

    Property Get read_PCS_Reset
        read
        read_PCS_Reset = read_PCS_Reset_value
    End Property

    Property Let write_PCS_Reset(aData)
        set_PCS_Reset = aData
        write
    End Property

    Property Get get_Loopback
        get_Loopback = read_Loopback_value
    End Property

    Property Let set_Loopback(aData)
        write_Loopback_value = aData
        flag_Loopback        = &H1
    End Property

    Property Get read_Loopback
        read
        read_Loopback = read_Loopback_value
    End Property

    Property Let write_Loopback(aData)
        set_Loopback = aData
        write
    End Property

    Property Get get_SPEED_SELECT_13
        get_SPEED_SELECT_13 = read_SPEED_SELECT_13_value
    End Property

    Property Let set_SPEED_SELECT_13(aData)
        write_SPEED_SELECT_13_value = aData
        flag_SPEED_SELECT_13        = &H1
    End Property

    Property Get read_SPEED_SELECT_13
        read
        read_SPEED_SELECT_13 = read_SPEED_SELECT_13_value
    End Property

    Property Let write_SPEED_SELECT_13(aData)
        set_SPEED_SELECT_13 = aData
        write
    End Property

    Property Get get_LOW_POWER
        get_LOW_POWER = read_LOW_POWER_value
    End Property

    Property Let set_LOW_POWER(aData)
        write_LOW_POWER_value = aData
        flag_LOW_POWER        = &H1
    End Property

    Property Get read_LOW_POWER
        read
        read_LOW_POWER = read_LOW_POWER_value
    End Property

    Property Let write_LOW_POWER(aData)
        set_LOW_POWER = aData
        write
    End Property

    Property Get get_Clock_Stop_Enable
        get_Clock_Stop_Enable = read_Clock_Stop_Enable_value
    End Property

    Property Let set_Clock_Stop_Enable(aData)
        write_Clock_Stop_Enable_value = aData
        flag_Clock_Stop_Enable        = &H1
    End Property

    Property Get read_Clock_Stop_Enable
        read
        read_Clock_Stop_Enable = read_Clock_Stop_Enable_value
    End Property

    Property Let write_Clock_Stop_Enable(aData)
        set_Clock_Stop_Enable = aData
        write
    End Property

    Property Get get_SPEED_SELECT_6
        get_SPEED_SELECT_6 = read_SPEED_SELECT_6_value
    End Property

    Property Let set_SPEED_SELECT_6(aData)
        write_SPEED_SELECT_6_value = aData
        flag_SPEED_SELECT_6        = &H1
    End Property

    Property Get read_SPEED_SELECT_6
        read
        read_SPEED_SELECT_6 = read_SPEED_SELECT_6_value
    End Property

    Property Let write_SPEED_SELECT_6(aData)
        set_SPEED_SELECT_6 = aData
        write
    End Property

    Property Get get_SPEED_SELECT
        get_SPEED_SELECT = read_SPEED_SELECT_value
    End Property

    Property Let set_SPEED_SELECT(aData)
        write_SPEED_SELECT_value = aData
        flag_SPEED_SELECT        = &H1
    End Property

    Property Get read_SPEED_SELECT
        read
        read_SPEED_SELECT = read_SPEED_SELECT_value
    End Property

    Property Let write_SPEED_SELECT(aData)
        set_SPEED_SELECT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PCS_Reset_value = rightShift(data_low, 15) and &H1
        read_Loopback_value = rightShift(data_low, 14) and &H1
        read_SPEED_SELECT_13_value = rightShift(data_low, 13) and &H1
        read_LOW_POWER_value = rightShift(data_low, 11) and &H1
        read_Clock_Stop_Enable_value = rightShift(data_low, 10) and &H1
        read_SPEED_SELECT_6_value = rightShift(data_low, 6) and &H1
        read_SPEED_SELECT_value = rightShift(data_low, 2) and &Hf

    End Sub

    Sub write
        If flag_PCS_Reset = &H0 or flag_Loopback = &H0 or flag_SPEED_SELECT_13 = &H0 or flag_LOW_POWER = &H0 or flag_Clock_Stop_Enable = &H0 or flag_SPEED_SELECT_6 = &H0 or flag_SPEED_SELECT = &H0 Then read
        If flag_PCS_Reset = &H0 Then write_PCS_Reset_value = get_PCS_Reset
        If flag_Loopback = &H0 Then write_Loopback_value = get_Loopback
        If flag_SPEED_SELECT_13 = &H0 Then write_SPEED_SELECT_13_value = get_SPEED_SELECT_13
        If flag_LOW_POWER = &H0 Then write_LOW_POWER_value = get_LOW_POWER
        If flag_Clock_Stop_Enable = &H0 Then write_Clock_Stop_Enable_value = get_Clock_Stop_Enable
        If flag_SPEED_SELECT_6 = &H0 Then write_SPEED_SELECT_6_value = get_SPEED_SELECT_6
        If flag_SPEED_SELECT = &H0 Then write_SPEED_SELECT_value = get_SPEED_SELECT

        regValue = leftShift((write_PCS_Reset_value and &H1), 15) + leftShift((write_Loopback_value and &H1), 14) + leftShift((write_SPEED_SELECT_13_value and &H1), 13) + leftShift((write_LOW_POWER_value and &H1), 11) + leftShift((write_Clock_Stop_Enable_value and &H1), 10) + leftShift((write_SPEED_SELECT_6_value and &H1), 6) + leftShift((write_SPEED_SELECT_value and &Hf), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PCS_Reset_value = rightShift(data_low, 15) and &H1
        read_Loopback_value = rightShift(data_low, 14) and &H1
        read_SPEED_SELECT_13_value = rightShift(data_low, 13) and &H1
        read_LOW_POWER_value = rightShift(data_low, 11) and &H1
        read_Clock_Stop_Enable_value = rightShift(data_low, 10) and &H1
        read_SPEED_SELECT_6_value = rightShift(data_low, 6) and &H1
        read_SPEED_SELECT_value = rightShift(data_low, 2) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_Reset_value = &H0
        flag_PCS_Reset        = &H0
        write_Loopback_value = &H0
        flag_Loopback        = &H0
        write_SPEED_SELECT_13_value = &H0
        flag_SPEED_SELECT_13        = &H0
        write_LOW_POWER_value = &H0
        flag_LOW_POWER        = &H0
        write_Clock_Stop_Enable_value = &H0
        flag_Clock_Stop_Enable        = &H0
        write_SPEED_SELECT_6_value = &H0
        flag_SPEED_SELECT_6        = &H0
        write_SPEED_SELECT_value = &H0
        flag_SPEED_SELECT        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_status_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_LPI_received                            [11:11]          get_TX_LPI_received
''                                                             set_TX_LPI_received
''                                                             read_TX_LPI_received
''                                                             write_TX_LPI_received
''---------------------------------------------------------------------------------
'' RX_LPI_received                            [10:10]          get_RX_LPI_received
''                                                             set_RX_LPI_received
''                                                             read_RX_LPI_received
''                                                             write_RX_LPI_received
''---------------------------------------------------------------------------------
'' Tx_LPI_indication                          [9:9]            get_Tx_LPI_indication
''                                                             set_Tx_LPI_indication
''                                                             read_Tx_LPI_indication
''                                                             write_Tx_LPI_indication
''---------------------------------------------------------------------------------
'' Rx_LPI_indication                          [8:8]            get_Rx_LPI_indication
''                                                             set_Rx_LPI_indication
''                                                             read_Rx_LPI_indication
''                                                             write_Rx_LPI_indication
''---------------------------------------------------------------------------------
'' Fault                                      [7:7]            get_Fault
''                                                             set_Fault
''                                                             read_Fault
''                                                             write_Fault
''---------------------------------------------------------------------------------
'' Clock_stop_capable                         [6:6]            get_Clock_stop_capable
''                                                             set_Clock_stop_capable
''                                                             read_Clock_stop_capable
''                                                             write_Clock_stop_capable
''---------------------------------------------------------------------------------
'' PCS_receive_link_status                    [2:2]            get_PCS_receive_link_status
''                                                             set_PCS_receive_link_status
''                                                             read_PCS_receive_link_status
''                                                             write_PCS_receive_link_status
''---------------------------------------------------------------------------------
'' Low_power_ability                          [1:1]            get_Low_power_ability
''                                                             set_Low_power_ability
''                                                             read_Low_power_ability
''                                                             write_Low_power_ability
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_status_reg1
    Private write_TX_LPI_received_value
    Private read_TX_LPI_received_value
    Private flag_TX_LPI_received
    Private write_RX_LPI_received_value
    Private read_RX_LPI_received_value
    Private flag_RX_LPI_received
    Private write_Tx_LPI_indication_value
    Private read_Tx_LPI_indication_value
    Private flag_Tx_LPI_indication
    Private write_Rx_LPI_indication_value
    Private read_Rx_LPI_indication_value
    Private flag_Rx_LPI_indication
    Private write_Fault_value
    Private read_Fault_value
    Private flag_Fault
    Private write_Clock_stop_capable_value
    Private read_Clock_stop_capable_value
    Private flag_Clock_stop_capable
    Private write_PCS_receive_link_status_value
    Private read_PCS_receive_link_status_value
    Private flag_PCS_receive_link_status
    Private write_Low_power_ability_value
    Private read_Low_power_ability_value
    Private flag_Low_power_ability

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

    Property Get get_TX_LPI_received
        get_TX_LPI_received = read_TX_LPI_received_value
    End Property

    Property Let set_TX_LPI_received(aData)
        write_TX_LPI_received_value = aData
        flag_TX_LPI_received        = &H1
    End Property

    Property Get read_TX_LPI_received
        read
        read_TX_LPI_received = read_TX_LPI_received_value
    End Property

    Property Let write_TX_LPI_received(aData)
        set_TX_LPI_received = aData
        write
    End Property

    Property Get get_RX_LPI_received
        get_RX_LPI_received = read_RX_LPI_received_value
    End Property

    Property Let set_RX_LPI_received(aData)
        write_RX_LPI_received_value = aData
        flag_RX_LPI_received        = &H1
    End Property

    Property Get read_RX_LPI_received
        read
        read_RX_LPI_received = read_RX_LPI_received_value
    End Property

    Property Let write_RX_LPI_received(aData)
        set_RX_LPI_received = aData
        write
    End Property

    Property Get get_Tx_LPI_indication
        get_Tx_LPI_indication = read_Tx_LPI_indication_value
    End Property

    Property Let set_Tx_LPI_indication(aData)
        write_Tx_LPI_indication_value = aData
        flag_Tx_LPI_indication        = &H1
    End Property

    Property Get read_Tx_LPI_indication
        read
        read_Tx_LPI_indication = read_Tx_LPI_indication_value
    End Property

    Property Let write_Tx_LPI_indication(aData)
        set_Tx_LPI_indication = aData
        write
    End Property

    Property Get get_Rx_LPI_indication
        get_Rx_LPI_indication = read_Rx_LPI_indication_value
    End Property

    Property Let set_Rx_LPI_indication(aData)
        write_Rx_LPI_indication_value = aData
        flag_Rx_LPI_indication        = &H1
    End Property

    Property Get read_Rx_LPI_indication
        read
        read_Rx_LPI_indication = read_Rx_LPI_indication_value
    End Property

    Property Let write_Rx_LPI_indication(aData)
        set_Rx_LPI_indication = aData
        write
    End Property

    Property Get get_Fault
        get_Fault = read_Fault_value
    End Property

    Property Let set_Fault(aData)
        write_Fault_value = aData
        flag_Fault        = &H1
    End Property

    Property Get read_Fault
        read
        read_Fault = read_Fault_value
    End Property

    Property Let write_Fault(aData)
        set_Fault = aData
        write
    End Property

    Property Get get_Clock_stop_capable
        get_Clock_stop_capable = read_Clock_stop_capable_value
    End Property

    Property Let set_Clock_stop_capable(aData)
        write_Clock_stop_capable_value = aData
        flag_Clock_stop_capable        = &H1
    End Property

    Property Get read_Clock_stop_capable
        read
        read_Clock_stop_capable = read_Clock_stop_capable_value
    End Property

    Property Let write_Clock_stop_capable(aData)
        set_Clock_stop_capable = aData
        write
    End Property

    Property Get get_PCS_receive_link_status
        get_PCS_receive_link_status = read_PCS_receive_link_status_value
    End Property

    Property Let set_PCS_receive_link_status(aData)
        write_PCS_receive_link_status_value = aData
        flag_PCS_receive_link_status        = &H1
    End Property

    Property Get read_PCS_receive_link_status
        read
        read_PCS_receive_link_status = read_PCS_receive_link_status_value
    End Property

    Property Let write_PCS_receive_link_status(aData)
        set_PCS_receive_link_status = aData
        write
    End Property

    Property Get get_Low_power_ability
        get_Low_power_ability = read_Low_power_ability_value
    End Property

    Property Let set_Low_power_ability(aData)
        write_Low_power_ability_value = aData
        flag_Low_power_ability        = &H1
    End Property

    Property Get read_Low_power_ability
        read
        read_Low_power_ability = read_Low_power_ability_value
    End Property

    Property Let write_Low_power_ability(aData)
        set_Low_power_ability = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_LPI_received_value = rightShift(data_low, 11) and &H1
        read_RX_LPI_received_value = rightShift(data_low, 10) and &H1
        read_Tx_LPI_indication_value = rightShift(data_low, 9) and &H1
        read_Rx_LPI_indication_value = rightShift(data_low, 8) and &H1
        read_Fault_value = rightShift(data_low, 7) and &H1
        read_Clock_stop_capable_value = rightShift(data_low, 6) and &H1
        read_PCS_receive_link_status_value = rightShift(data_low, 2) and &H1
        read_Low_power_ability_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_TX_LPI_received = &H0 or flag_RX_LPI_received = &H0 or flag_Tx_LPI_indication = &H0 or flag_Rx_LPI_indication = &H0 or flag_Fault = &H0 or flag_Clock_stop_capable = &H0 or flag_PCS_receive_link_status = &H0 or flag_Low_power_ability = &H0 Then read
        If flag_TX_LPI_received = &H0 Then write_TX_LPI_received_value = get_TX_LPI_received
        If flag_RX_LPI_received = &H0 Then write_RX_LPI_received_value = get_RX_LPI_received
        If flag_Tx_LPI_indication = &H0 Then write_Tx_LPI_indication_value = get_Tx_LPI_indication
        If flag_Rx_LPI_indication = &H0 Then write_Rx_LPI_indication_value = get_Rx_LPI_indication
        If flag_Fault = &H0 Then write_Fault_value = get_Fault
        If flag_Clock_stop_capable = &H0 Then write_Clock_stop_capable_value = get_Clock_stop_capable
        If flag_PCS_receive_link_status = &H0 Then write_PCS_receive_link_status_value = get_PCS_receive_link_status
        If flag_Low_power_ability = &H0 Then write_Low_power_ability_value = get_Low_power_ability

        regValue = leftShift((write_TX_LPI_received_value and &H1), 11) + leftShift((write_RX_LPI_received_value and &H1), 10) + leftShift((write_Tx_LPI_indication_value and &H1), 9) + leftShift((write_Rx_LPI_indication_value and &H1), 8) + leftShift((write_Fault_value and &H1), 7) + leftShift((write_Clock_stop_capable_value and &H1), 6) + leftShift((write_PCS_receive_link_status_value and &H1), 2) + leftShift((write_Low_power_ability_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_LPI_received_value = rightShift(data_low, 11) and &H1
        read_RX_LPI_received_value = rightShift(data_low, 10) and &H1
        read_Tx_LPI_indication_value = rightShift(data_low, 9) and &H1
        read_Rx_LPI_indication_value = rightShift(data_low, 8) and &H1
        read_Fault_value = rightShift(data_low, 7) and &H1
        read_Clock_stop_capable_value = rightShift(data_low, 6) and &H1
        read_PCS_receive_link_status_value = rightShift(data_low, 2) and &H1
        read_Low_power_ability_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_LPI_received_value = &H0
        flag_TX_LPI_received        = &H0
        write_RX_LPI_received_value = &H0
        flag_RX_LPI_received        = &H0
        write_Tx_LPI_indication_value = &H0
        flag_Tx_LPI_indication        = &H0
        write_Rx_LPI_indication_value = &H0
        flag_Rx_LPI_indication        = &H0
        write_Fault_value = &H0
        flag_Fault        = &H0
        write_Clock_stop_capable_value = &H0
        flag_Clock_stop_capable        = &H0
        write_PCS_receive_link_status_value = &H0
        flag_PCS_receive_link_status        = &H0
        write_Low_power_ability_value = &H0
        flag_Low_power_ability        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_pcs_device_id_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DEVICE_ID0                             [15:0]           get_PCS_DEVICE_ID0
''                                                             set_PCS_DEVICE_ID0
''                                                             read_PCS_DEVICE_ID0
''                                                             write_PCS_DEVICE_ID0
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_pcs_device_id_reg0
    Private write_PCS_DEVICE_ID0_value
    Private read_PCS_DEVICE_ID0_value
    Private flag_PCS_DEVICE_ID0

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

    Property Get get_PCS_DEVICE_ID0
        get_PCS_DEVICE_ID0 = read_PCS_DEVICE_ID0_value
    End Property

    Property Let set_PCS_DEVICE_ID0(aData)
        write_PCS_DEVICE_ID0_value = aData
        flag_PCS_DEVICE_ID0        = &H1
    End Property

    Property Get read_PCS_DEVICE_ID0
        read
        read_PCS_DEVICE_ID0 = read_PCS_DEVICE_ID0_value
    End Property

    Property Let write_PCS_DEVICE_ID0(aData)
        set_PCS_DEVICE_ID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_ID0_mask = mask then
                read_PCS_DEVICE_ID0_value = data_low
            else
                read_PCS_DEVICE_ID0_value = (data_low - H8000_0000) and PCS_DEVICE_ID0_mask
            end If
        else
            read_PCS_DEVICE_ID0_value = data_low and PCS_DEVICE_ID0_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DEVICE_ID0 = &H0 Then read
        If flag_PCS_DEVICE_ID0 = &H0 Then write_PCS_DEVICE_ID0_value = get_PCS_DEVICE_ID0

        regValue = leftShift((write_PCS_DEVICE_ID0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_ID0_mask = mask then
                read_PCS_DEVICE_ID0_value = data_low
            else
                read_PCS_DEVICE_ID0_value = (data_low - H8000_0000) and PCS_DEVICE_ID0_mask
            end If
        else
            read_PCS_DEVICE_ID0_value = data_low and PCS_DEVICE_ID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DEVICE_ID0_value = &H0
        flag_PCS_DEVICE_ID0        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_pcs_device_id_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DEVICE_ID1                             [15:0]           get_PCS_DEVICE_ID1
''                                                             set_PCS_DEVICE_ID1
''                                                             read_PCS_DEVICE_ID1
''                                                             write_PCS_DEVICE_ID1
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_pcs_device_id_reg1
    Private write_PCS_DEVICE_ID1_value
    Private read_PCS_DEVICE_ID1_value
    Private flag_PCS_DEVICE_ID1

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

    Property Get get_PCS_DEVICE_ID1
        get_PCS_DEVICE_ID1 = read_PCS_DEVICE_ID1_value
    End Property

    Property Let set_PCS_DEVICE_ID1(aData)
        write_PCS_DEVICE_ID1_value = aData
        flag_PCS_DEVICE_ID1        = &H1
    End Property

    Property Get read_PCS_DEVICE_ID1
        read
        read_PCS_DEVICE_ID1 = read_PCS_DEVICE_ID1_value
    End Property

    Property Let write_PCS_DEVICE_ID1(aData)
        set_PCS_DEVICE_ID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_ID1_mask = mask then
                read_PCS_DEVICE_ID1_value = data_low
            else
                read_PCS_DEVICE_ID1_value = (data_low - H8000_0000) and PCS_DEVICE_ID1_mask
            end If
        else
            read_PCS_DEVICE_ID1_value = data_low and PCS_DEVICE_ID1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DEVICE_ID1 = &H0 Then read
        If flag_PCS_DEVICE_ID1 = &H0 Then write_PCS_DEVICE_ID1_value = get_PCS_DEVICE_ID1

        regValue = leftShift((write_PCS_DEVICE_ID1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_ID1_mask = mask then
                read_PCS_DEVICE_ID1_value = data_low
            else
                read_PCS_DEVICE_ID1_value = (data_low - H8000_0000) and PCS_DEVICE_ID1_mask
            end If
        else
            read_PCS_DEVICE_ID1_value = data_low and PCS_DEVICE_ID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DEVICE_ID1_value = &H0
        flag_PCS_DEVICE_ID1        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_pcs_device_in_pkg_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DEVICE_IN_PKG0                         [15:0]           get_PCS_DEVICE_IN_PKG0
''                                                             set_PCS_DEVICE_IN_PKG0
''                                                             read_PCS_DEVICE_IN_PKG0
''                                                             write_PCS_DEVICE_IN_PKG0
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_pcs_device_in_pkg_reg0
    Private write_PCS_DEVICE_IN_PKG0_value
    Private read_PCS_DEVICE_IN_PKG0_value
    Private flag_PCS_DEVICE_IN_PKG0

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

    Property Get get_PCS_DEVICE_IN_PKG0
        get_PCS_DEVICE_IN_PKG0 = read_PCS_DEVICE_IN_PKG0_value
    End Property

    Property Let set_PCS_DEVICE_IN_PKG0(aData)
        write_PCS_DEVICE_IN_PKG0_value = aData
        flag_PCS_DEVICE_IN_PKG0        = &H1
    End Property

    Property Get read_PCS_DEVICE_IN_PKG0
        read
        read_PCS_DEVICE_IN_PKG0 = read_PCS_DEVICE_IN_PKG0_value
    End Property

    Property Let write_PCS_DEVICE_IN_PKG0(aData)
        set_PCS_DEVICE_IN_PKG0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_IN_PKG0_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_IN_PKG0_mask = mask then
                read_PCS_DEVICE_IN_PKG0_value = data_low
            else
                read_PCS_DEVICE_IN_PKG0_value = (data_low - H8000_0000) and PCS_DEVICE_IN_PKG0_mask
            end If
        else
            read_PCS_DEVICE_IN_PKG0_value = data_low and PCS_DEVICE_IN_PKG0_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DEVICE_IN_PKG0 = &H0 Then read
        If flag_PCS_DEVICE_IN_PKG0 = &H0 Then write_PCS_DEVICE_IN_PKG0_value = get_PCS_DEVICE_IN_PKG0

        regValue = leftShift((write_PCS_DEVICE_IN_PKG0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_IN_PKG0_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_IN_PKG0_mask = mask then
                read_PCS_DEVICE_IN_PKG0_value = data_low
            else
                read_PCS_DEVICE_IN_PKG0_value = (data_low - H8000_0000) and PCS_DEVICE_IN_PKG0_mask
            end If
        else
            read_PCS_DEVICE_IN_PKG0_value = data_low and PCS_DEVICE_IN_PKG0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DEVICE_IN_PKG0_value = &H0
        flag_PCS_DEVICE_IN_PKG0        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_pcs_device_in_pkg_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_DEVICE_IN_PKG1                         [15:0]           get_PCS_DEVICE_IN_PKG1
''                                                             set_PCS_DEVICE_IN_PKG1
''                                                             read_PCS_DEVICE_IN_PKG1
''                                                             write_PCS_DEVICE_IN_PKG1
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_pcs_device_in_pkg_reg1
    Private write_PCS_DEVICE_IN_PKG1_value
    Private read_PCS_DEVICE_IN_PKG1_value
    Private flag_PCS_DEVICE_IN_PKG1

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

    Property Get get_PCS_DEVICE_IN_PKG1
        get_PCS_DEVICE_IN_PKG1 = read_PCS_DEVICE_IN_PKG1_value
    End Property

    Property Let set_PCS_DEVICE_IN_PKG1(aData)
        write_PCS_DEVICE_IN_PKG1_value = aData
        flag_PCS_DEVICE_IN_PKG1        = &H1
    End Property

    Property Get read_PCS_DEVICE_IN_PKG1
        read
        read_PCS_DEVICE_IN_PKG1 = read_PCS_DEVICE_IN_PKG1_value
    End Property

    Property Let write_PCS_DEVICE_IN_PKG1(aData)
        set_PCS_DEVICE_IN_PKG1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_IN_PKG1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_IN_PKG1_mask = mask then
                read_PCS_DEVICE_IN_PKG1_value = data_low
            else
                read_PCS_DEVICE_IN_PKG1_value = (data_low - H8000_0000) and PCS_DEVICE_IN_PKG1_mask
            end If
        else
            read_PCS_DEVICE_IN_PKG1_value = data_low and PCS_DEVICE_IN_PKG1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_DEVICE_IN_PKG1 = &H0 Then read
        If flag_PCS_DEVICE_IN_PKG1 = &H0 Then write_PCS_DEVICE_IN_PKG1_value = get_PCS_DEVICE_IN_PKG1

        regValue = leftShift((write_PCS_DEVICE_IN_PKG1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_DEVICE_IN_PKG1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_DEVICE_IN_PKG1_mask = mask then
                read_PCS_DEVICE_IN_PKG1_value = data_low
            else
                read_PCS_DEVICE_IN_PKG1_value = (data_low - H8000_0000) and PCS_DEVICE_IN_PKG1_mask
            end If
        else
            read_PCS_DEVICE_IN_PKG1_value = data_low and PCS_DEVICE_IN_PKG1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_DEVICE_IN_PKG1_value = &H0
        flag_PCS_DEVICE_IN_PKG1        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_pcs_pkg_id_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_PKG_ID0                                [15:0]           get_PCS_PKG_ID0
''                                                             set_PCS_PKG_ID0
''                                                             read_PCS_PKG_ID0
''                                                             write_PCS_PKG_ID0
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_pcs_pkg_id_reg0
    Private write_PCS_PKG_ID0_value
    Private read_PCS_PKG_ID0_value
    Private flag_PCS_PKG_ID0

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

    Property Get get_PCS_PKG_ID0
        get_PCS_PKG_ID0 = read_PCS_PKG_ID0_value
    End Property

    Property Let set_PCS_PKG_ID0(aData)
        write_PCS_PKG_ID0_value = aData
        flag_PCS_PKG_ID0        = &H1
    End Property

    Property Get read_PCS_PKG_ID0
        read
        read_PCS_PKG_ID0 = read_PCS_PKG_ID0_value
    End Property

    Property Let write_PCS_PKG_ID0(aData)
        set_PCS_PKG_ID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_PKG_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_PKG_ID0_mask = mask then
                read_PCS_PKG_ID0_value = data_low
            else
                read_PCS_PKG_ID0_value = (data_low - H8000_0000) and PCS_PKG_ID0_mask
            end If
        else
            read_PCS_PKG_ID0_value = data_low and PCS_PKG_ID0_mask
        end If

    End Sub

    Sub write
        If flag_PCS_PKG_ID0 = &H0 Then read
        If flag_PCS_PKG_ID0 = &H0 Then write_PCS_PKG_ID0_value = get_PCS_PKG_ID0

        regValue = leftShift((write_PCS_PKG_ID0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_PKG_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_PKG_ID0_mask = mask then
                read_PCS_PKG_ID0_value = data_low
            else
                read_PCS_PKG_ID0_value = (data_low - H8000_0000) and PCS_PKG_ID0_mask
            end If
        else
            read_PCS_PKG_ID0_value = data_low and PCS_PKG_ID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_PKG_ID0_value = &H0
        flag_PCS_PKG_ID0        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_pcs_pkg_id_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_PKG_ID1                                [15:0]           get_PCS_PKG_ID1
''                                                             set_PCS_PKG_ID1
''                                                             read_PCS_PKG_ID1
''                                                             write_PCS_PKG_ID1
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_pcs_pkg_id_reg1
    Private write_PCS_PKG_ID1_value
    Private read_PCS_PKG_ID1_value
    Private flag_PCS_PKG_ID1

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

    Property Get get_PCS_PKG_ID1
        get_PCS_PKG_ID1 = read_PCS_PKG_ID1_value
    End Property

    Property Let set_PCS_PKG_ID1(aData)
        write_PCS_PKG_ID1_value = aData
        flag_PCS_PKG_ID1        = &H1
    End Property

    Property Get read_PCS_PKG_ID1
        read
        read_PCS_PKG_ID1 = read_PCS_PKG_ID1_value
    End Property

    Property Let write_PCS_PKG_ID1(aData)
        set_PCS_PKG_ID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_PKG_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_PKG_ID1_mask = mask then
                read_PCS_PKG_ID1_value = data_low
            else
                read_PCS_PKG_ID1_value = (data_low - H8000_0000) and PCS_PKG_ID1_mask
            end If
        else
            read_PCS_PKG_ID1_value = data_low and PCS_PKG_ID1_mask
        end If

    End Sub

    Sub write
        If flag_PCS_PKG_ID1 = &H0 Then read
        If flag_PCS_PKG_ID1 = &H0 Then write_PCS_PKG_ID1_value = get_PCS_PKG_ID1

        regValue = leftShift((write_PCS_PKG_ID1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PCS_PKG_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if PCS_PKG_ID1_mask = mask then
                read_PCS_PKG_ID1_value = data_low
            else
                read_PCS_PKG_ID1_value = (data_low - H8000_0000) and PCS_PKG_ID1_mask
            end If
        else
            read_PCS_PKG_ID1_value = data_low and PCS_PKG_ID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_PKG_ID1_value = &H0
        flag_PCS_PKG_ID1        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_timesync_pcs_capability
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TimeSync_transmit_path_data_delay          [1:1]            get_TimeSync_transmit_path_data_delay
''                                                             set_TimeSync_transmit_path_data_delay
''                                                             read_TimeSync_transmit_path_data_delay
''                                                             write_TimeSync_transmit_path_data_delay
''---------------------------------------------------------------------------------
'' TimeSync_receive_path_data_delay           [0:0]            get_TimeSync_receive_path_data_delay
''                                                             set_TimeSync_receive_path_data_delay
''                                                             read_TimeSync_receive_path_data_delay
''                                                             write_TimeSync_receive_path_data_delay
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_timesync_pcs_capability
    Private write_TimeSync_transmit_path_data_delay_value
    Private read_TimeSync_transmit_path_data_delay_value
    Private flag_TimeSync_transmit_path_data_delay
    Private write_TimeSync_receive_path_data_delay_value
    Private read_TimeSync_receive_path_data_delay_value
    Private flag_TimeSync_receive_path_data_delay

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TimeSync_transmit_path_data_delay
        get_TimeSync_transmit_path_data_delay = read_TimeSync_transmit_path_data_delay_value
    End Property

    Property Let set_TimeSync_transmit_path_data_delay(aData)
        write_TimeSync_transmit_path_data_delay_value = aData
        flag_TimeSync_transmit_path_data_delay        = &H1
    End Property

    Property Get read_TimeSync_transmit_path_data_delay
        read
        read_TimeSync_transmit_path_data_delay = read_TimeSync_transmit_path_data_delay_value
    End Property

    Property Let write_TimeSync_transmit_path_data_delay(aData)
        set_TimeSync_transmit_path_data_delay = aData
        write
    End Property

    Property Get get_TimeSync_receive_path_data_delay
        get_TimeSync_receive_path_data_delay = read_TimeSync_receive_path_data_delay_value
    End Property

    Property Let set_TimeSync_receive_path_data_delay(aData)
        write_TimeSync_receive_path_data_delay_value = aData
        flag_TimeSync_receive_path_data_delay        = &H1
    End Property

    Property Get read_TimeSync_receive_path_data_delay
        read
        read_TimeSync_receive_path_data_delay = read_TimeSync_receive_path_data_delay_value
    End Property

    Property Let write_TimeSync_receive_path_data_delay(aData)
        set_TimeSync_receive_path_data_delay = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TimeSync_transmit_path_data_delay_value = rightShift(data_low, 1) and &H1
        TimeSync_receive_path_data_delay_mask = &H1
        if data_low > LONG_MAX then
            if TimeSync_receive_path_data_delay_mask = mask then
                read_TimeSync_receive_path_data_delay_value = data_low
            else
                read_TimeSync_receive_path_data_delay_value = (data_low - H8000_0000) and TimeSync_receive_path_data_delay_mask
            end If
        else
            read_TimeSync_receive_path_data_delay_value = data_low and TimeSync_receive_path_data_delay_mask
        end If

    End Sub

    Sub write
        If flag_TimeSync_transmit_path_data_delay = &H0 or flag_TimeSync_receive_path_data_delay = &H0 Then read
        If flag_TimeSync_transmit_path_data_delay = &H0 Then write_TimeSync_transmit_path_data_delay_value = get_TimeSync_transmit_path_data_delay
        If flag_TimeSync_receive_path_data_delay = &H0 Then write_TimeSync_receive_path_data_delay_value = get_TimeSync_receive_path_data_delay

        regValue = leftShift((write_TimeSync_transmit_path_data_delay_value and &H1), 1) + leftShift((write_TimeSync_receive_path_data_delay_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TimeSync_transmit_path_data_delay_value = rightShift(data_low, 1) and &H1
        TimeSync_receive_path_data_delay_mask = &H1
        if data_low > LONG_MAX then
            if TimeSync_receive_path_data_delay_mask = mask then
                read_TimeSync_receive_path_data_delay_value = data_low
            else
                read_TimeSync_receive_path_data_delay_value = (data_low - H8000_0000) and TimeSync_receive_path_data_delay_mask
            end If
        else
            read_TimeSync_receive_path_data_delay_value = data_low and TimeSync_receive_path_data_delay_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TimeSync_transmit_path_data_delay_value = &H0
        flag_TimeSync_transmit_path_data_delay        = &H0
        write_TimeSync_receive_path_data_delay_value = &H0
        flag_TimeSync_receive_path_data_delay        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_maximum_pcs_tx_path_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TMPTPD                                     [15:0]           get_TMPTPD
''                                                             set_TMPTPD
''                                                             read_TMPTPD
''                                                             write_TMPTPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_maximum_pcs_tx_path_delay_lower
    Private write_TMPTPD_value
    Private read_TMPTPD_value
    Private flag_TMPTPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He12
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TMPTPD
        get_TMPTPD = read_TMPTPD_value
    End Property

    Property Let set_TMPTPD(aData)
        write_TMPTPD_value = aData
        flag_TMPTPD        = &H1
    End Property

    Property Get read_TMPTPD
        read
        read_TMPTPD = read_TMPTPD_value
    End Property

    Property Let write_TMPTPD(aData)
        set_TMPTPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPTPD_mask = mask then
                read_TMPTPD_value = data_low
            else
                read_TMPTPD_value = (data_low - H8000_0000) and TMPTPD_mask
            end If
        else
            read_TMPTPD_value = data_low and TMPTPD_mask
        end If

    End Sub

    Sub write
        If flag_TMPTPD = &H0 Then read
        If flag_TMPTPD = &H0 Then write_TMPTPD_value = get_TMPTPD

        regValue = leftShift((write_TMPTPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPTPD_mask = mask then
                read_TMPTPD_value = data_low
            else
                read_TMPTPD_value = (data_low - H8000_0000) and TMPTPD_mask
            end If
        else
            read_TMPTPD_value = data_low and TMPTPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TMPTPD_value = &H0
        flag_TMPTPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_maximum_pcs_tx_path_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TMPTPD                                     [15:0]           get_TMPTPD
''                                                             set_TMPTPD
''                                                             read_TMPTPD
''                                                             write_TMPTPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_maximum_pcs_tx_path_delay_upper
    Private write_TMPTPD_value
    Private read_TMPTPD_value
    Private flag_TMPTPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TMPTPD
        get_TMPTPD = read_TMPTPD_value
    End Property

    Property Let set_TMPTPD(aData)
        write_TMPTPD_value = aData
        flag_TMPTPD        = &H1
    End Property

    Property Get read_TMPTPD
        read
        read_TMPTPD = read_TMPTPD_value
    End Property

    Property Let write_TMPTPD(aData)
        set_TMPTPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPTPD_mask = mask then
                read_TMPTPD_value = data_low
            else
                read_TMPTPD_value = (data_low - H8000_0000) and TMPTPD_mask
            end If
        else
            read_TMPTPD_value = data_low and TMPTPD_mask
        end If

    End Sub

    Sub write
        If flag_TMPTPD = &H0 Then read
        If flag_TMPTPD = &H0 Then write_TMPTPD_value = get_TMPTPD

        regValue = leftShift((write_TMPTPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPTPD_mask = mask then
                read_TMPTPD_value = data_low
            else
                read_TMPTPD_value = (data_low - H8000_0000) and TMPTPD_mask
            end If
        else
            read_TMPTPD_value = data_low and TMPTPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TMPTPD_value = &H0
        flag_TMPTPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_minimum_pcs_tx_path_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TTPD                                       [15:0]           get_TTPD
''                                                             set_TTPD
''                                                             read_TTPD
''                                                             write_TTPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_minimum_pcs_tx_path_delay_lower
    Private write_TTPD_value
    Private read_TTPD_value
    Private flag_TTPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He16
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TTPD
        get_TTPD = read_TTPD_value
    End Property

    Property Let set_TTPD(aData)
        write_TTPD_value = aData
        flag_TTPD        = &H1
    End Property

    Property Get read_TTPD
        read
        read_TTPD = read_TTPD_value
    End Property

    Property Let write_TTPD(aData)
        set_TTPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

    End Sub

    Sub write
        If flag_TTPD = &H0 Then read
        If flag_TTPD = &H0 Then write_TTPD_value = get_TTPD

        regValue = leftShift((write_TTPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TTPD_value = &H0
        flag_TTPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_minimum_pcs_tx_path_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TTPD                                       [15:0]           get_TTPD
''                                                             set_TTPD
''                                                             read_TTPD
''                                                             write_TTPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_minimum_pcs_tx_path_delay_upper
    Private write_TTPD_value
    Private read_TTPD_value
    Private flag_TTPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TTPD
        get_TTPD = read_TTPD_value
    End Property

    Property Let set_TTPD(aData)
        write_TTPD_value = aData
        flag_TTPD        = &H1
    End Property

    Property Get read_TTPD
        read
        read_TTPD = read_TTPD_value
    End Property

    Property Let write_TTPD(aData)
        set_TTPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

    End Sub

    Sub write
        If flag_TTPD = &H0 Then read
        If flag_TTPD = &H0 Then write_TTPD_value = get_TTPD

        regValue = leftShift((write_TTPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TTPD_value = &H0
        flag_TTPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_maximum_pcs_rx_path_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TMPRPD                                     [15:0]           get_TMPRPD
''                                                             set_TMPRPD
''                                                             read_TMPRPD
''                                                             write_TMPRPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_maximum_pcs_rx_path_delay_lower
    Private write_TMPRPD_value
    Private read_TMPRPD_value
    Private flag_TMPRPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He1a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TMPRPD
        get_TMPRPD = read_TMPRPD_value
    End Property

    Property Let set_TMPRPD(aData)
        write_TMPRPD_value = aData
        flag_TMPRPD        = &H1
    End Property

    Property Get read_TMPRPD
        read
        read_TMPRPD = read_TMPRPD_value
    End Property

    Property Let write_TMPRPD(aData)
        set_TMPRPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPRPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPRPD_mask = mask then
                read_TMPRPD_value = data_low
            else
                read_TMPRPD_value = (data_low - H8000_0000) and TMPRPD_mask
            end If
        else
            read_TMPRPD_value = data_low and TMPRPD_mask
        end If

    End Sub

    Sub write
        If flag_TMPRPD = &H0 Then read
        If flag_TMPRPD = &H0 Then write_TMPRPD_value = get_TMPRPD

        regValue = leftShift((write_TMPRPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPRPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPRPD_mask = mask then
                read_TMPRPD_value = data_low
            else
                read_TMPRPD_value = (data_low - H8000_0000) and TMPRPD_mask
            end If
        else
            read_TMPRPD_value = data_low and TMPRPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TMPRPD_value = &H0
        flag_TMPRPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_maximum_pcs_rx_path_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TMPRPD                                     [15:0]           get_TMPRPD
''                                                             set_TMPRPD
''                                                             read_TMPRPD
''                                                             write_TMPRPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_maximum_pcs_rx_path_delay_upper
    Private write_TMPRPD_value
    Private read_TMPRPD_value
    Private flag_TMPRPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TMPRPD
        get_TMPRPD = read_TMPRPD_value
    End Property

    Property Let set_TMPRPD(aData)
        write_TMPRPD_value = aData
        flag_TMPRPD        = &H1
    End Property

    Property Get read_TMPRPD
        read
        read_TMPRPD = read_TMPRPD_value
    End Property

    Property Let write_TMPRPD(aData)
        set_TMPRPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPRPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPRPD_mask = mask then
                read_TMPRPD_value = data_low
            else
                read_TMPRPD_value = (data_low - H8000_0000) and TMPRPD_mask
            end If
        else
            read_TMPRPD_value = data_low and TMPRPD_mask
        end If

    End Sub

    Sub write
        If flag_TMPRPD = &H0 Then read
        If flag_TMPRPD = &H0 Then write_TMPRPD_value = get_TMPRPD

        regValue = leftShift((write_TMPRPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TMPRPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TMPRPD_mask = mask then
                read_TMPRPD_value = data_low
            else
                read_TMPRPD_value = (data_low - H8000_0000) and TMPRPD_mask
            end If
        else
            read_TMPRPD_value = data_low and TMPRPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TMPRPD_value = &H0
        flag_TMPRPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_minimum_pcs_rx_path_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TTPD                                       [15:0]           get_TTPD
''                                                             set_TTPD
''                                                             read_TTPD
''                                                             write_TTPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_minimum_pcs_rx_path_delay_lower
    Private write_TTPD_value
    Private read_TTPD_value
    Private flag_TTPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He1e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TTPD
        get_TTPD = read_TTPD_value
    End Property

    Property Let set_TTPD(aData)
        write_TTPD_value = aData
        flag_TTPD        = &H1
    End Property

    Property Get read_TTPD
        read
        read_TTPD = read_TTPD_value
    End Property

    Property Let write_TTPD(aData)
        set_TTPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

    End Sub

    Sub write
        If flag_TTPD = &H0 Then read
        If flag_TTPD = &H0 Then write_TTPD_value = get_TTPD

        regValue = leftShift((write_TTPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TTPD_value = &H0
        flag_TTPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_minimum_pcs_rx_path_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TTPD                                       [15:0]           get_TTPD
''                                                             set_TTPD
''                                                             read_TTPD
''                                                             write_TTPD
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_minimum_pcs_rx_path_delay_upper
    Private write_TTPD_value
    Private read_TTPD_value
    Private flag_TTPD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TTPD
        get_TTPD = read_TTPD_value
    End Property

    Property Let set_TTPD(aData)
        write_TTPD_value = aData
        flag_TTPD        = &H1
    End Property

    Property Get read_TTPD
        read
        read_TTPD = read_TTPD_value
    End Property

    Property Let write_TTPD(aData)
        set_TTPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

    End Sub

    Sub write
        If flag_TTPD = &H0 Then read
        If flag_TTPD = &H0 Then write_TTPD_value = get_TTPD

        regValue = leftShift((write_TTPD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPD_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPD_mask = mask then
                read_TTPD_value = data_low
            else
                read_TTPD_value = (data_low - H8000_0000) and TTPD_mask
            end If
        else
            read_TTPD_value = data_low and TTPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TTPD_value = &H0
        flag_TTPD        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_pcs_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PCS_reset                                  [15:15]          get_PCS_reset
''                                                             set_PCS_reset
''                                                             read_PCS_reset
''                                                             write_PCS_reset
''---------------------------------------------------------------------------------
'' PCS_Loopback                               [14:14]          get_PCS_Loopback
''                                                             set_PCS_Loopback
''                                                             read_PCS_Loopback
''                                                             write_PCS_Loopback
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_pcs_control
    Private write_PCS_reset_value
    Private read_PCS_reset_value
    Private flag_PCS_reset
    Private write_PCS_Loopback_value
    Private read_PCS_Loopback_value
    Private flag_PCS_Loopback

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PCS_reset
        get_PCS_reset = read_PCS_reset_value
    End Property

    Property Let set_PCS_reset(aData)
        write_PCS_reset_value = aData
        flag_PCS_reset        = &H1
    End Property

    Property Get read_PCS_reset
        read
        read_PCS_reset = read_PCS_reset_value
    End Property

    Property Let write_PCS_reset(aData)
        set_PCS_reset = aData
        write
    End Property

    Property Get get_PCS_Loopback
        get_PCS_Loopback = read_PCS_Loopback_value
    End Property

    Property Let set_PCS_Loopback(aData)
        write_PCS_Loopback_value = aData
        flag_PCS_Loopback        = &H1
    End Property

    Property Get read_PCS_Loopback
        read
        read_PCS_Loopback = read_PCS_Loopback_value
    End Property

    Property Let write_PCS_Loopback(aData)
        set_PCS_Loopback = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PCS_reset_value = rightShift(data_low, 15) and &H1
        read_PCS_Loopback_value = rightShift(data_low, 14) and &H1

    End Sub

    Sub write
        If flag_PCS_reset = &H0 or flag_PCS_Loopback = &H0 Then read
        If flag_PCS_reset = &H0 Then write_PCS_reset_value = get_PCS_reset
        If flag_PCS_Loopback = &H0 Then write_PCS_Loopback_value = get_PCS_Loopback

        regValue = leftShift((write_PCS_reset_value and &H1), 15) + leftShift((write_PCS_Loopback_value and &H1), 14)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PCS_reset_value = rightShift(data_low, 15) and &H1
        read_PCS_Loopback_value = rightShift(data_low, 14) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PCS_reset_value = &H0
        flag_PCS_reset        = &H0
        write_PCS_Loopback_value = &H0
        flag_PCS_Loopback        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_pcs_status1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Tx_LPI_received                            [11:11]          get_Tx_LPI_received
''                                                             set_Tx_LPI_received
''                                                             read_Tx_LPI_received
''                                                             write_Tx_LPI_received
''---------------------------------------------------------------------------------
'' Rx_LPI_received                            [10:10]          get_Rx_LPI_received
''                                                             set_Rx_LPI_received
''                                                             read_Rx_LPI_received
''                                                             write_Rx_LPI_received
''---------------------------------------------------------------------------------
'' Tx_LPI_indication                          [9:9]            get_Tx_LPI_indication
''                                                             set_Tx_LPI_indication
''                                                             read_Tx_LPI_indication
''                                                             write_Tx_LPI_indication
''---------------------------------------------------------------------------------
'' Rx_LPI_indication                          [8:8]            get_Rx_LPI_indication
''                                                             set_Rx_LPI_indication
''                                                             read_Rx_LPI_indication
''                                                             write_Rx_LPI_indication
''---------------------------------------------------------------------------------
'' Fault                                      [7:7]            get_Fault
''                                                             set_Fault
''                                                             read_Fault
''                                                             write_Fault
''---------------------------------------------------------------------------------
'' PCS_receive_link_status                    [2:2]            get_PCS_receive_link_status
''                                                             set_PCS_receive_link_status
''                                                             read_PCS_receive_link_status
''                                                             write_PCS_receive_link_status
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_pcs_status1
    Private write_Tx_LPI_received_value
    Private read_Tx_LPI_received_value
    Private flag_Tx_LPI_received
    Private write_Rx_LPI_received_value
    Private read_Rx_LPI_received_value
    Private flag_Rx_LPI_received
    Private write_Tx_LPI_indication_value
    Private read_Tx_LPI_indication_value
    Private flag_Tx_LPI_indication
    Private write_Rx_LPI_indication_value
    Private read_Rx_LPI_indication_value
    Private flag_Rx_LPI_indication
    Private write_Fault_value
    Private read_Fault_value
    Private flag_Fault
    Private write_PCS_receive_link_status_value
    Private read_PCS_receive_link_status_value
    Private flag_PCS_receive_link_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1202
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Tx_LPI_received
        get_Tx_LPI_received = read_Tx_LPI_received_value
    End Property

    Property Let set_Tx_LPI_received(aData)
        write_Tx_LPI_received_value = aData
        flag_Tx_LPI_received        = &H1
    End Property

    Property Get read_Tx_LPI_received
        read
        read_Tx_LPI_received = read_Tx_LPI_received_value
    End Property

    Property Let write_Tx_LPI_received(aData)
        set_Tx_LPI_received = aData
        write
    End Property

    Property Get get_Rx_LPI_received
        get_Rx_LPI_received = read_Rx_LPI_received_value
    End Property

    Property Let set_Rx_LPI_received(aData)
        write_Rx_LPI_received_value = aData
        flag_Rx_LPI_received        = &H1
    End Property

    Property Get read_Rx_LPI_received
        read
        read_Rx_LPI_received = read_Rx_LPI_received_value
    End Property

    Property Let write_Rx_LPI_received(aData)
        set_Rx_LPI_received = aData
        write
    End Property

    Property Get get_Tx_LPI_indication
        get_Tx_LPI_indication = read_Tx_LPI_indication_value
    End Property

    Property Let set_Tx_LPI_indication(aData)
        write_Tx_LPI_indication_value = aData
        flag_Tx_LPI_indication        = &H1
    End Property

    Property Get read_Tx_LPI_indication
        read
        read_Tx_LPI_indication = read_Tx_LPI_indication_value
    End Property

    Property Let write_Tx_LPI_indication(aData)
        set_Tx_LPI_indication = aData
        write
    End Property

    Property Get get_Rx_LPI_indication
        get_Rx_LPI_indication = read_Rx_LPI_indication_value
    End Property

    Property Let set_Rx_LPI_indication(aData)
        write_Rx_LPI_indication_value = aData
        flag_Rx_LPI_indication        = &H1
    End Property

    Property Get read_Rx_LPI_indication
        read
        read_Rx_LPI_indication = read_Rx_LPI_indication_value
    End Property

    Property Let write_Rx_LPI_indication(aData)
        set_Rx_LPI_indication = aData
        write
    End Property

    Property Get get_Fault
        get_Fault = read_Fault_value
    End Property

    Property Let set_Fault(aData)
        write_Fault_value = aData
        flag_Fault        = &H1
    End Property

    Property Get read_Fault
        read
        read_Fault = read_Fault_value
    End Property

    Property Let write_Fault(aData)
        set_Fault = aData
        write
    End Property

    Property Get get_PCS_receive_link_status
        get_PCS_receive_link_status = read_PCS_receive_link_status_value
    End Property

    Property Let set_PCS_receive_link_status(aData)
        write_PCS_receive_link_status_value = aData
        flag_PCS_receive_link_status        = &H1
    End Property

    Property Get read_PCS_receive_link_status
        read
        read_PCS_receive_link_status = read_PCS_receive_link_status_value
    End Property

    Property Let write_PCS_receive_link_status(aData)
        set_PCS_receive_link_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Tx_LPI_received_value = rightShift(data_low, 11) and &H1
        read_Rx_LPI_received_value = rightShift(data_low, 10) and &H1
        read_Tx_LPI_indication_value = rightShift(data_low, 9) and &H1
        read_Rx_LPI_indication_value = rightShift(data_low, 8) and &H1
        read_Fault_value = rightShift(data_low, 7) and &H1
        read_PCS_receive_link_status_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_Tx_LPI_received = &H0 or flag_Rx_LPI_received = &H0 or flag_Tx_LPI_indication = &H0 or flag_Rx_LPI_indication = &H0 or flag_Fault = &H0 or flag_PCS_receive_link_status = &H0 Then read
        If flag_Tx_LPI_received = &H0 Then write_Tx_LPI_received_value = get_Tx_LPI_received
        If flag_Rx_LPI_received = &H0 Then write_Rx_LPI_received_value = get_Rx_LPI_received
        If flag_Tx_LPI_indication = &H0 Then write_Tx_LPI_indication_value = get_Tx_LPI_indication
        If flag_Rx_LPI_indication = &H0 Then write_Rx_LPI_indication_value = get_Rx_LPI_indication
        If flag_Fault = &H0 Then write_Fault_value = get_Fault
        If flag_PCS_receive_link_status = &H0 Then write_PCS_receive_link_status_value = get_PCS_receive_link_status

        regValue = leftShift((write_Tx_LPI_received_value and &H1), 11) + leftShift((write_Rx_LPI_received_value and &H1), 10) + leftShift((write_Tx_LPI_indication_value and &H1), 9) + leftShift((write_Rx_LPI_indication_value and &H1), 8) + leftShift((write_Fault_value and &H1), 7) + leftShift((write_PCS_receive_link_status_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Tx_LPI_received_value = rightShift(data_low, 11) and &H1
        read_Rx_LPI_received_value = rightShift(data_low, 10) and &H1
        read_Tx_LPI_indication_value = rightShift(data_low, 9) and &H1
        read_Rx_LPI_indication_value = rightShift(data_low, 8) and &H1
        read_Fault_value = rightShift(data_low, 7) and &H1
        read_PCS_receive_link_status_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Tx_LPI_received_value = &H0
        flag_Tx_LPI_received        = &H0
        write_Rx_LPI_received_value = &H0
        flag_Rx_LPI_received        = &H0
        write_Tx_LPI_indication_value = &H0
        flag_Tx_LPI_indication        = &H0
        write_Rx_LPI_indication_value = &H0
        flag_Rx_LPI_indication        = &H0
        write_Fault_value = &H0
        flag_Fault        = &H0
        write_PCS_receive_link_status_value = &H0
        flag_PCS_receive_link_status        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_pcs_status2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Receive_link_status                        [10:10]          get_Receive_link_status
''                                                             set_Receive_link_status
''                                                             read_Receive_link_status
''                                                             write_Receive_link_status
''---------------------------------------------------------------------------------
'' PCS_high_BER                               [9:9]            get_PCS_high_BER
''                                                             set_PCS_high_BER
''                                                             read_PCS_high_BER
''                                                             write_PCS_high_BER
''---------------------------------------------------------------------------------
'' PCS_block_lock                             [8:8]            get_PCS_block_lock
''                                                             set_PCS_block_lock
''                                                             read_PCS_block_lock
''                                                             write_PCS_block_lock
''---------------------------------------------------------------------------------
'' Latched_high_BER                           [7:7]            get_Latched_high_BER
''                                                             set_Latched_high_BER
''                                                             read_Latched_high_BER
''                                                             write_Latched_high_BER
''---------------------------------------------------------------------------------
'' Latched_block_lock                         [6:6]            get_Latched_block_lock
''                                                             set_Latched_block_lock
''                                                             read_Latched_block_lock
''                                                             write_Latched_block_lock
''---------------------------------------------------------------------------------
'' BER_count                                  [5:0]            get_BER_count
''                                                             set_BER_count
''                                                             read_BER_count
''                                                             write_BER_count
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_pcs_status2
    Private write_Receive_link_status_value
    Private read_Receive_link_status_value
    Private flag_Receive_link_status
    Private write_PCS_high_BER_value
    Private read_PCS_high_BER_value
    Private flag_PCS_high_BER
    Private write_PCS_block_lock_value
    Private read_PCS_block_lock_value
    Private flag_PCS_block_lock
    Private write_Latched_high_BER_value
    Private read_Latched_high_BER_value
    Private flag_Latched_high_BER
    Private write_Latched_block_lock_value
    Private read_Latched_block_lock_value
    Private flag_Latched_block_lock
    Private write_BER_count_value
    Private read_BER_count_value
    Private flag_BER_count

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Receive_link_status
        get_Receive_link_status = read_Receive_link_status_value
    End Property

    Property Let set_Receive_link_status(aData)
        write_Receive_link_status_value = aData
        flag_Receive_link_status        = &H1
    End Property

    Property Get read_Receive_link_status
        read
        read_Receive_link_status = read_Receive_link_status_value
    End Property

    Property Let write_Receive_link_status(aData)
        set_Receive_link_status = aData
        write
    End Property

    Property Get get_PCS_high_BER
        get_PCS_high_BER = read_PCS_high_BER_value
    End Property

    Property Let set_PCS_high_BER(aData)
        write_PCS_high_BER_value = aData
        flag_PCS_high_BER        = &H1
    End Property

    Property Get read_PCS_high_BER
        read
        read_PCS_high_BER = read_PCS_high_BER_value
    End Property

    Property Let write_PCS_high_BER(aData)
        set_PCS_high_BER = aData
        write
    End Property

    Property Get get_PCS_block_lock
        get_PCS_block_lock = read_PCS_block_lock_value
    End Property

    Property Let set_PCS_block_lock(aData)
        write_PCS_block_lock_value = aData
        flag_PCS_block_lock        = &H1
    End Property

    Property Get read_PCS_block_lock
        read
        read_PCS_block_lock = read_PCS_block_lock_value
    End Property

    Property Let write_PCS_block_lock(aData)
        set_PCS_block_lock = aData
        write
    End Property

    Property Get get_Latched_high_BER
        get_Latched_high_BER = read_Latched_high_BER_value
    End Property

    Property Let set_Latched_high_BER(aData)
        write_Latched_high_BER_value = aData
        flag_Latched_high_BER        = &H1
    End Property

    Property Get read_Latched_high_BER
        read
        read_Latched_high_BER = read_Latched_high_BER_value
    End Property

    Property Let write_Latched_high_BER(aData)
        set_Latched_high_BER = aData
        write
    End Property

    Property Get get_Latched_block_lock
        get_Latched_block_lock = read_Latched_block_lock_value
    End Property

    Property Let set_Latched_block_lock(aData)
        write_Latched_block_lock_value = aData
        flag_Latched_block_lock        = &H1
    End Property

    Property Get read_Latched_block_lock
        read
        read_Latched_block_lock = read_Latched_block_lock_value
    End Property

    Property Let write_Latched_block_lock(aData)
        set_Latched_block_lock = aData
        write
    End Property

    Property Get get_BER_count
        get_BER_count = read_BER_count_value
    End Property

    Property Let set_BER_count(aData)
        write_BER_count_value = aData
        flag_BER_count        = &H1
    End Property

    Property Get read_BER_count
        read
        read_BER_count = read_BER_count_value
    End Property

    Property Let write_BER_count(aData)
        set_BER_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Receive_link_status_value = rightShift(data_low, 10) and &H1
        read_PCS_high_BER_value = rightShift(data_low, 9) and &H1
        read_PCS_block_lock_value = rightShift(data_low, 8) and &H1
        read_Latched_high_BER_value = rightShift(data_low, 7) and &H1
        read_Latched_block_lock_value = rightShift(data_low, 6) and &H1
        BER_count_mask = &H3f
        if data_low > LONG_MAX then
            if BER_count_mask = mask then
                read_BER_count_value = data_low
            else
                read_BER_count_value = (data_low - H8000_0000) and BER_count_mask
            end If
        else
            read_BER_count_value = data_low and BER_count_mask
        end If

    End Sub

    Sub write
        If flag_Receive_link_status = &H0 or flag_PCS_high_BER = &H0 or flag_PCS_block_lock = &H0 or flag_Latched_high_BER = &H0 or flag_Latched_block_lock = &H0 or flag_BER_count = &H0 Then read
        If flag_Receive_link_status = &H0 Then write_Receive_link_status_value = get_Receive_link_status
        If flag_PCS_high_BER = &H0 Then write_PCS_high_BER_value = get_PCS_high_BER
        If flag_PCS_block_lock = &H0 Then write_PCS_block_lock_value = get_PCS_block_lock
        If flag_Latched_high_BER = &H0 Then write_Latched_high_BER_value = get_Latched_high_BER
        If flag_Latched_block_lock = &H0 Then write_Latched_block_lock_value = get_Latched_block_lock
        If flag_BER_count = &H0 Then write_BER_count_value = get_BER_count

        regValue = leftShift((write_Receive_link_status_value and &H1), 10) + leftShift((write_PCS_high_BER_value and &H1), 9) + leftShift((write_PCS_block_lock_value and &H1), 8) + leftShift((write_Latched_high_BER_value and &H1), 7) + leftShift((write_Latched_block_lock_value and &H1), 6) + leftShift((write_BER_count_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Receive_link_status_value = rightShift(data_low, 10) and &H1
        read_PCS_high_BER_value = rightShift(data_low, 9) and &H1
        read_PCS_block_lock_value = rightShift(data_low, 8) and &H1
        read_Latched_high_BER_value = rightShift(data_low, 7) and &H1
        read_Latched_block_lock_value = rightShift(data_low, 6) and &H1
        BER_count_mask = &H3f
        if data_low > LONG_MAX then
            if BER_count_mask = mask then
                read_BER_count_value = data_low
            else
                read_BER_count_value = (data_low - H8000_0000) and BER_count_mask
            end If
        else
            read_BER_count_value = data_low and BER_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Receive_link_status_value = &H0
        flag_Receive_link_status        = &H0
        write_PCS_high_BER_value = &H0
        flag_PCS_high_BER        = &H0
        write_PCS_block_lock_value = &H0
        flag_PCS_block_lock        = &H0
        write_Latched_high_BER_value = &H0
        flag_Latched_high_BER        = &H0
        write_Latched_block_lock_value = &H0
        flag_Latched_block_lock        = &H0
        write_BER_count_value = &H0
        flag_BER_count        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_oam_xmit
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_valid               [15:15]          get_BASE1000T1_OAM_message_valid
''                                                             set_BASE1000T1_OAM_message_valid
''                                                             read_BASE1000T1_OAM_message_valid
''                                                             write_BASE1000T1_OAM_message_valid
''---------------------------------------------------------------------------------
'' Toggle_value                               [14:14]          get_Toggle_value
''                                                             set_Toggle_value
''                                                             read_Toggle_value
''                                                             write_Toggle_value
''---------------------------------------------------------------------------------
'' B10001OMR                                  [13:13]          get_B10001OMR
''                                                             set_B10001OMR
''                                                             read_B10001OMR
''                                                             write_B10001OMR
''---------------------------------------------------------------------------------
'' Received_message_toggle_value              [12:12]          get_Received_message_toggle_value
''                                                             set_Received_message_toggle_value
''                                                             read_Received_message_toggle_value
''                                                             write_Received_message_toggle_value
''---------------------------------------------------------------------------------
'' Message_number                             [11:8]           get_Message_number
''                                                             set_Message_number
''                                                             read_Message_number
''                                                             write_Message_number
''---------------------------------------------------------------------------------
'' Ping_received                              [3:3]            get_Ping_received
''                                                             set_Ping_received
''                                                             read_Ping_received
''                                                             write_Ping_received
''---------------------------------------------------------------------------------
'' Ping_transmit                              [2:2]            get_Ping_transmit
''                                                             set_Ping_transmit
''                                                             read_Ping_transmit
''                                                             write_Ping_transmit
''---------------------------------------------------------------------------------
'' Local_SNR                                  [1:0]            get_Local_SNR
''                                                             set_Local_SNR
''                                                             read_Local_SNR
''                                                             write_Local_SNR
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_oam_xmit
    Private write_BASE1000T1_OAM_message_valid_value
    Private read_BASE1000T1_OAM_message_valid_value
    Private flag_BASE1000T1_OAM_message_valid
    Private write_Toggle_value_value
    Private read_Toggle_value_value
    Private flag_Toggle_value
    Private write_B10001OMR_value
    Private read_B10001OMR_value
    Private flag_B10001OMR
    Private write_Received_message_toggle_value_value
    Private read_Received_message_toggle_value_value
    Private flag_Received_message_toggle_value
    Private write_Message_number_value
    Private read_Message_number_value
    Private flag_Message_number
    Private write_Ping_received_value
    Private read_Ping_received_value
    Private flag_Ping_received
    Private write_Ping_transmit_value
    Private read_Ping_transmit_value
    Private flag_Ping_transmit
    Private write_Local_SNR_value
    Private read_Local_SNR_value
    Private flag_Local_SNR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BASE1000T1_OAM_message_valid
        get_BASE1000T1_OAM_message_valid = read_BASE1000T1_OAM_message_valid_value
    End Property

    Property Let set_BASE1000T1_OAM_message_valid(aData)
        write_BASE1000T1_OAM_message_valid_value = aData
        flag_BASE1000T1_OAM_message_valid        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_valid
        read
        read_BASE1000T1_OAM_message_valid = read_BASE1000T1_OAM_message_valid_value
    End Property

    Property Let write_BASE1000T1_OAM_message_valid(aData)
        set_BASE1000T1_OAM_message_valid = aData
        write
    End Property

    Property Get get_Toggle_value
        get_Toggle_value = read_Toggle_value_value
    End Property

    Property Let set_Toggle_value(aData)
        write_Toggle_value_value = aData
        flag_Toggle_value        = &H1
    End Property

    Property Get read_Toggle_value
        read
        read_Toggle_value = read_Toggle_value_value
    End Property

    Property Let write_Toggle_value(aData)
        set_Toggle_value = aData
        write
    End Property

    Property Get get_B10001OMR
        get_B10001OMR = read_B10001OMR_value
    End Property

    Property Let set_B10001OMR(aData)
        write_B10001OMR_value = aData
        flag_B10001OMR        = &H1
    End Property

    Property Get read_B10001OMR
        read
        read_B10001OMR = read_B10001OMR_value
    End Property

    Property Let write_B10001OMR(aData)
        set_B10001OMR = aData
        write
    End Property

    Property Get get_Received_message_toggle_value
        get_Received_message_toggle_value = read_Received_message_toggle_value_value
    End Property

    Property Let set_Received_message_toggle_value(aData)
        write_Received_message_toggle_value_value = aData
        flag_Received_message_toggle_value        = &H1
    End Property

    Property Get read_Received_message_toggle_value
        read
        read_Received_message_toggle_value = read_Received_message_toggle_value_value
    End Property

    Property Let write_Received_message_toggle_value(aData)
        set_Received_message_toggle_value = aData
        write
    End Property

    Property Get get_Message_number
        get_Message_number = read_Message_number_value
    End Property

    Property Let set_Message_number(aData)
        write_Message_number_value = aData
        flag_Message_number        = &H1
    End Property

    Property Get read_Message_number
        read
        read_Message_number = read_Message_number_value
    End Property

    Property Let write_Message_number(aData)
        set_Message_number = aData
        write
    End Property

    Property Get get_Ping_received
        get_Ping_received = read_Ping_received_value
    End Property

    Property Let set_Ping_received(aData)
        write_Ping_received_value = aData
        flag_Ping_received        = &H1
    End Property

    Property Get read_Ping_received
        read
        read_Ping_received = read_Ping_received_value
    End Property

    Property Let write_Ping_received(aData)
        set_Ping_received = aData
        write
    End Property

    Property Get get_Ping_transmit
        get_Ping_transmit = read_Ping_transmit_value
    End Property

    Property Let set_Ping_transmit(aData)
        write_Ping_transmit_value = aData
        flag_Ping_transmit        = &H1
    End Property

    Property Get read_Ping_transmit
        read
        read_Ping_transmit = read_Ping_transmit_value
    End Property

    Property Let write_Ping_transmit(aData)
        set_Ping_transmit = aData
        write
    End Property

    Property Get get_Local_SNR
        get_Local_SNR = read_Local_SNR_value
    End Property

    Property Let set_Local_SNR(aData)
        write_Local_SNR_value = aData
        flag_Local_SNR        = &H1
    End Property

    Property Get read_Local_SNR
        read
        read_Local_SNR = read_Local_SNR_value
    End Property

    Property Let write_Local_SNR(aData)
        set_Local_SNR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_valid_value = rightShift(data_low, 15) and &H1
        read_Toggle_value_value = rightShift(data_low, 14) and &H1
        read_B10001OMR_value = rightShift(data_low, 13) and &H1
        read_Received_message_toggle_value_value = rightShift(data_low, 12) and &H1
        read_Message_number_value = rightShift(data_low, 8) and &Hf
        read_Ping_received_value = rightShift(data_low, 3) and &H1
        read_Ping_transmit_value = rightShift(data_low, 2) and &H1
        Local_SNR_mask = &H3
        if data_low > LONG_MAX then
            if Local_SNR_mask = mask then
                read_Local_SNR_value = data_low
            else
                read_Local_SNR_value = (data_low - H8000_0000) and Local_SNR_mask
            end If
        else
            read_Local_SNR_value = data_low and Local_SNR_mask
        end If

    End Sub

    Sub write
        If flag_BASE1000T1_OAM_message_valid = &H0 or flag_Toggle_value = &H0 or flag_B10001OMR = &H0 or flag_Received_message_toggle_value = &H0 or flag_Message_number = &H0 or flag_Ping_received = &H0 or flag_Ping_transmit = &H0 or flag_Local_SNR = &H0 Then read
        If flag_BASE1000T1_OAM_message_valid = &H0 Then write_BASE1000T1_OAM_message_valid_value = get_BASE1000T1_OAM_message_valid
        If flag_Toggle_value = &H0 Then write_Toggle_value_value = get_Toggle_value
        If flag_B10001OMR = &H0 Then write_B10001OMR_value = get_B10001OMR
        If flag_Received_message_toggle_value = &H0 Then write_Received_message_toggle_value_value = get_Received_message_toggle_value
        If flag_Message_number = &H0 Then write_Message_number_value = get_Message_number
        If flag_Ping_received = &H0 Then write_Ping_received_value = get_Ping_received
        If flag_Ping_transmit = &H0 Then write_Ping_transmit_value = get_Ping_transmit
        If flag_Local_SNR = &H0 Then write_Local_SNR_value = get_Local_SNR

        regValue = leftShift((write_BASE1000T1_OAM_message_valid_value and &H1), 15) + leftShift((write_Toggle_value_value and &H1), 14) + leftShift((write_B10001OMR_value and &H1), 13) + leftShift((write_Received_message_toggle_value_value and &H1), 12) + leftShift((write_Message_number_value and &Hf), 8) + leftShift((write_Ping_received_value and &H1), 3) + leftShift((write_Ping_transmit_value and &H1), 2) + leftShift((write_Local_SNR_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_valid_value = rightShift(data_low, 15) and &H1
        read_Toggle_value_value = rightShift(data_low, 14) and &H1
        read_B10001OMR_value = rightShift(data_low, 13) and &H1
        read_Received_message_toggle_value_value = rightShift(data_low, 12) and &H1
        read_Message_number_value = rightShift(data_low, 8) and &Hf
        read_Ping_received_value = rightShift(data_low, 3) and &H1
        read_Ping_transmit_value = rightShift(data_low, 2) and &H1
        Local_SNR_mask = &H3
        if data_low > LONG_MAX then
            if Local_SNR_mask = mask then
                read_Local_SNR_value = data_low
            else
                read_Local_SNR_value = (data_low - H8000_0000) and Local_SNR_mask
            end If
        else
            read_Local_SNR_value = data_low and Local_SNR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BASE1000T1_OAM_message_valid_value = &H0
        flag_BASE1000T1_OAM_message_valid        = &H0
        write_Toggle_value_value = &H0
        flag_Toggle_value        = &H0
        write_B10001OMR_value = &H0
        flag_B10001OMR        = &H0
        write_Received_message_toggle_value_value = &H0
        flag_Received_message_toggle_value        = &H0
        write_Message_number_value = &H0
        flag_Message_number        = &H0
        write_Ping_received_value = &H0
        flag_Ping_received        = &H0
        write_Ping_transmit_value = &H0
        flag_Ping_transmit        = &H0
        write_Local_SNR_value = &H0
        flag_Local_SNR        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_oam_message_1_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_1                   [15:8]           get_BASE1000T1_OAM_message_1
''                                                             set_BASE1000T1_OAM_message_1
''                                                             read_BASE1000T1_OAM_message_1
''                                                             write_BASE1000T1_OAM_message_1
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_0                   [7:0]            get_BASE1000T1_OAM_message_0
''                                                             set_BASE1000T1_OAM_message_0
''                                                             read_BASE1000T1_OAM_message_0
''                                                             write_BASE1000T1_OAM_message_0
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_oam_message_1_0
    Private write_BASE1000T1_OAM_message_1_value
    Private read_BASE1000T1_OAM_message_1_value
    Private flag_BASE1000T1_OAM_message_1
    Private write_BASE1000T1_OAM_message_0_value
    Private read_BASE1000T1_OAM_message_0_value
    Private flag_BASE1000T1_OAM_message_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BASE1000T1_OAM_message_1
        get_BASE1000T1_OAM_message_1 = read_BASE1000T1_OAM_message_1_value
    End Property

    Property Let set_BASE1000T1_OAM_message_1(aData)
        write_BASE1000T1_OAM_message_1_value = aData
        flag_BASE1000T1_OAM_message_1        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_1
        read
        read_BASE1000T1_OAM_message_1 = read_BASE1000T1_OAM_message_1_value
    End Property

    Property Let write_BASE1000T1_OAM_message_1(aData)
        set_BASE1000T1_OAM_message_1 = aData
        write
    End Property

    Property Get get_BASE1000T1_OAM_message_0
        get_BASE1000T1_OAM_message_0 = read_BASE1000T1_OAM_message_0_value
    End Property

    Property Let set_BASE1000T1_OAM_message_0(aData)
        write_BASE1000T1_OAM_message_0_value = aData
        flag_BASE1000T1_OAM_message_0        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_0
        read
        read_BASE1000T1_OAM_message_0 = read_BASE1000T1_OAM_message_0_value
    End Property

    Property Let write_BASE1000T1_OAM_message_0(aData)
        set_BASE1000T1_OAM_message_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_1_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_0_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_0_mask = mask then
                read_BASE1000T1_OAM_message_0_value = data_low
            else
                read_BASE1000T1_OAM_message_0_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_0_mask
            end If
        else
            read_BASE1000T1_OAM_message_0_value = data_low and BASE1000T1_OAM_message_0_mask
        end If

    End Sub

    Sub write
        If flag_BASE1000T1_OAM_message_1 = &H0 or flag_BASE1000T1_OAM_message_0 = &H0 Then read
        If flag_BASE1000T1_OAM_message_1 = &H0 Then write_BASE1000T1_OAM_message_1_value = get_BASE1000T1_OAM_message_1
        If flag_BASE1000T1_OAM_message_0 = &H0 Then write_BASE1000T1_OAM_message_0_value = get_BASE1000T1_OAM_message_0

        regValue = leftShift((write_BASE1000T1_OAM_message_1_value and &Hff), 8) + leftShift((write_BASE1000T1_OAM_message_0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_1_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_0_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_0_mask = mask then
                read_BASE1000T1_OAM_message_0_value = data_low
            else
                read_BASE1000T1_OAM_message_0_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_0_mask
            end If
        else
            read_BASE1000T1_OAM_message_0_value = data_low and BASE1000T1_OAM_message_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BASE1000T1_OAM_message_1_value = &H0
        flag_BASE1000T1_OAM_message_1        = &H0
        write_BASE1000T1_OAM_message_0_value = &H0
        flag_BASE1000T1_OAM_message_0        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_oam_message_3_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_3                   [15:8]           get_BASE1000T1_OAM_message_3
''                                                             set_BASE1000T1_OAM_message_3
''                                                             read_BASE1000T1_OAM_message_3
''                                                             write_BASE1000T1_OAM_message_3
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_2                   [7:0]            get_BASE1000T1_OAM_message_2
''                                                             set_BASE1000T1_OAM_message_2
''                                                             read_BASE1000T1_OAM_message_2
''                                                             write_BASE1000T1_OAM_message_2
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_oam_message_3_2
    Private write_BASE1000T1_OAM_message_3_value
    Private read_BASE1000T1_OAM_message_3_value
    Private flag_BASE1000T1_OAM_message_3
    Private write_BASE1000T1_OAM_message_2_value
    Private read_BASE1000T1_OAM_message_2_value
    Private flag_BASE1000T1_OAM_message_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BASE1000T1_OAM_message_3
        get_BASE1000T1_OAM_message_3 = read_BASE1000T1_OAM_message_3_value
    End Property

    Property Let set_BASE1000T1_OAM_message_3(aData)
        write_BASE1000T1_OAM_message_3_value = aData
        flag_BASE1000T1_OAM_message_3        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_3
        read
        read_BASE1000T1_OAM_message_3 = read_BASE1000T1_OAM_message_3_value
    End Property

    Property Let write_BASE1000T1_OAM_message_3(aData)
        set_BASE1000T1_OAM_message_3 = aData
        write
    End Property

    Property Get get_BASE1000T1_OAM_message_2
        get_BASE1000T1_OAM_message_2 = read_BASE1000T1_OAM_message_2_value
    End Property

    Property Let set_BASE1000T1_OAM_message_2(aData)
        write_BASE1000T1_OAM_message_2_value = aData
        flag_BASE1000T1_OAM_message_2        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_2
        read
        read_BASE1000T1_OAM_message_2 = read_BASE1000T1_OAM_message_2_value
    End Property

    Property Let write_BASE1000T1_OAM_message_2(aData)
        set_BASE1000T1_OAM_message_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_3_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_2_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_2_mask = mask then
                read_BASE1000T1_OAM_message_2_value = data_low
            else
                read_BASE1000T1_OAM_message_2_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_2_mask
            end If
        else
            read_BASE1000T1_OAM_message_2_value = data_low and BASE1000T1_OAM_message_2_mask
        end If

    End Sub

    Sub write
        If flag_BASE1000T1_OAM_message_3 = &H0 or flag_BASE1000T1_OAM_message_2 = &H0 Then read
        If flag_BASE1000T1_OAM_message_3 = &H0 Then write_BASE1000T1_OAM_message_3_value = get_BASE1000T1_OAM_message_3
        If flag_BASE1000T1_OAM_message_2 = &H0 Then write_BASE1000T1_OAM_message_2_value = get_BASE1000T1_OAM_message_2

        regValue = leftShift((write_BASE1000T1_OAM_message_3_value and &Hff), 8) + leftShift((write_BASE1000T1_OAM_message_2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_3_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_2_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_2_mask = mask then
                read_BASE1000T1_OAM_message_2_value = data_low
            else
                read_BASE1000T1_OAM_message_2_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_2_mask
            end If
        else
            read_BASE1000T1_OAM_message_2_value = data_low and BASE1000T1_OAM_message_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BASE1000T1_OAM_message_3_value = &H0
        flag_BASE1000T1_OAM_message_3        = &H0
        write_BASE1000T1_OAM_message_2_value = &H0
        flag_BASE1000T1_OAM_message_2        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_oam_message_5_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_5                   [15:8]           get_BASE1000T1_OAM_message_5
''                                                             set_BASE1000T1_OAM_message_5
''                                                             read_BASE1000T1_OAM_message_5
''                                                             write_BASE1000T1_OAM_message_5
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_4                   [7:0]            get_BASE1000T1_OAM_message_4
''                                                             set_BASE1000T1_OAM_message_4
''                                                             read_BASE1000T1_OAM_message_4
''                                                             write_BASE1000T1_OAM_message_4
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_oam_message_5_4
    Private write_BASE1000T1_OAM_message_5_value
    Private read_BASE1000T1_OAM_message_5_value
    Private flag_BASE1000T1_OAM_message_5
    Private write_BASE1000T1_OAM_message_4_value
    Private read_BASE1000T1_OAM_message_4_value
    Private flag_BASE1000T1_OAM_message_4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BASE1000T1_OAM_message_5
        get_BASE1000T1_OAM_message_5 = read_BASE1000T1_OAM_message_5_value
    End Property

    Property Let set_BASE1000T1_OAM_message_5(aData)
        write_BASE1000T1_OAM_message_5_value = aData
        flag_BASE1000T1_OAM_message_5        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_5
        read
        read_BASE1000T1_OAM_message_5 = read_BASE1000T1_OAM_message_5_value
    End Property

    Property Let write_BASE1000T1_OAM_message_5(aData)
        set_BASE1000T1_OAM_message_5 = aData
        write
    End Property

    Property Get get_BASE1000T1_OAM_message_4
        get_BASE1000T1_OAM_message_4 = read_BASE1000T1_OAM_message_4_value
    End Property

    Property Let set_BASE1000T1_OAM_message_4(aData)
        write_BASE1000T1_OAM_message_4_value = aData
        flag_BASE1000T1_OAM_message_4        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_4
        read
        read_BASE1000T1_OAM_message_4 = read_BASE1000T1_OAM_message_4_value
    End Property

    Property Let write_BASE1000T1_OAM_message_4(aData)
        set_BASE1000T1_OAM_message_4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_5_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_4_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_4_mask = mask then
                read_BASE1000T1_OAM_message_4_value = data_low
            else
                read_BASE1000T1_OAM_message_4_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_4_mask
            end If
        else
            read_BASE1000T1_OAM_message_4_value = data_low and BASE1000T1_OAM_message_4_mask
        end If

    End Sub

    Sub write
        If flag_BASE1000T1_OAM_message_5 = &H0 or flag_BASE1000T1_OAM_message_4 = &H0 Then read
        If flag_BASE1000T1_OAM_message_5 = &H0 Then write_BASE1000T1_OAM_message_5_value = get_BASE1000T1_OAM_message_5
        If flag_BASE1000T1_OAM_message_4 = &H0 Then write_BASE1000T1_OAM_message_4_value = get_BASE1000T1_OAM_message_4

        regValue = leftShift((write_BASE1000T1_OAM_message_5_value and &Hff), 8) + leftShift((write_BASE1000T1_OAM_message_4_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_5_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_4_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_4_mask = mask then
                read_BASE1000T1_OAM_message_4_value = data_low
            else
                read_BASE1000T1_OAM_message_4_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_4_mask
            end If
        else
            read_BASE1000T1_OAM_message_4_value = data_low and BASE1000T1_OAM_message_4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BASE1000T1_OAM_message_5_value = &H0
        flag_BASE1000T1_OAM_message_5        = &H0
        write_BASE1000T1_OAM_message_4_value = &H0
        flag_BASE1000T1_OAM_message_4        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_oam_message_7_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_7                   [15:8]           get_BASE1000T1_OAM_message_7
''                                                             set_BASE1000T1_OAM_message_7
''                                                             read_BASE1000T1_OAM_message_7
''                                                             write_BASE1000T1_OAM_message_7
''---------------------------------------------------------------------------------
'' BASE1000T1_OAM_message_6                   [7:0]            get_BASE1000T1_OAM_message_6
''                                                             set_BASE1000T1_OAM_message_6
''                                                             read_BASE1000T1_OAM_message_6
''                                                             write_BASE1000T1_OAM_message_6
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_oam_message_7_6
    Private write_BASE1000T1_OAM_message_7_value
    Private read_BASE1000T1_OAM_message_7_value
    Private flag_BASE1000T1_OAM_message_7
    Private write_BASE1000T1_OAM_message_6_value
    Private read_BASE1000T1_OAM_message_6_value
    Private flag_BASE1000T1_OAM_message_6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BASE1000T1_OAM_message_7
        get_BASE1000T1_OAM_message_7 = read_BASE1000T1_OAM_message_7_value
    End Property

    Property Let set_BASE1000T1_OAM_message_7(aData)
        write_BASE1000T1_OAM_message_7_value = aData
        flag_BASE1000T1_OAM_message_7        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_7
        read
        read_BASE1000T1_OAM_message_7 = read_BASE1000T1_OAM_message_7_value
    End Property

    Property Let write_BASE1000T1_OAM_message_7(aData)
        set_BASE1000T1_OAM_message_7 = aData
        write
    End Property

    Property Get get_BASE1000T1_OAM_message_6
        get_BASE1000T1_OAM_message_6 = read_BASE1000T1_OAM_message_6_value
    End Property

    Property Let set_BASE1000T1_OAM_message_6(aData)
        write_BASE1000T1_OAM_message_6_value = aData
        flag_BASE1000T1_OAM_message_6        = &H1
    End Property

    Property Get read_BASE1000T1_OAM_message_6
        read
        read_BASE1000T1_OAM_message_6 = read_BASE1000T1_OAM_message_6_value
    End Property

    Property Let write_BASE1000T1_OAM_message_6(aData)
        set_BASE1000T1_OAM_message_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_7_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_6_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_6_mask = mask then
                read_BASE1000T1_OAM_message_6_value = data_low
            else
                read_BASE1000T1_OAM_message_6_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_6_mask
            end If
        else
            read_BASE1000T1_OAM_message_6_value = data_low and BASE1000T1_OAM_message_6_mask
        end If

    End Sub

    Sub write
        If flag_BASE1000T1_OAM_message_7 = &H0 or flag_BASE1000T1_OAM_message_6 = &H0 Then read
        If flag_BASE1000T1_OAM_message_7 = &H0 Then write_BASE1000T1_OAM_message_7_value = get_BASE1000T1_OAM_message_7
        If flag_BASE1000T1_OAM_message_6 = &H0 Then write_BASE1000T1_OAM_message_6_value = get_BASE1000T1_OAM_message_6

        regValue = leftShift((write_BASE1000T1_OAM_message_7_value and &Hff), 8) + leftShift((write_BASE1000T1_OAM_message_6_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASE1000T1_OAM_message_7_value = rightShift(data_low, 8) and &Hff
        BASE1000T1_OAM_message_6_mask = &Hff
        if data_low > LONG_MAX then
            if BASE1000T1_OAM_message_6_mask = mask then
                read_BASE1000T1_OAM_message_6_value = data_low
            else
                read_BASE1000T1_OAM_message_6_value = (data_low - H8000_0000) and BASE1000T1_OAM_message_6_mask
            end If
        else
            read_BASE1000T1_OAM_message_6_value = data_low and BASE1000T1_OAM_message_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BASE1000T1_OAM_message_7_value = &H0
        flag_BASE1000T1_OAM_message_7        = &H0
        write_BASE1000T1_OAM_message_6_value = &H0
        flag_BASE1000T1_OAM_message_6        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_base1000t1_oam_receive
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP10001OMV                                 [15:15]          get_LP10001OMV
''                                                             set_LP10001OMV
''                                                             read_LP10001OMV
''                                                             write_LP10001OMV
''---------------------------------------------------------------------------------
'' Link_partner_toggle_value                  [14:14]          get_Link_partner_toggle_value
''                                                             set_Link_partner_toggle_value
''                                                             read_Link_partner_toggle_value
''                                                             write_Link_partner_toggle_value
''---------------------------------------------------------------------------------
'' Link_partner_message_number                [11:8]           get_Link_partner_message_number
''                                                             set_Link_partner_message_number
''                                                             read_Link_partner_message_number
''                                                             write_Link_partner_message_number
''---------------------------------------------------------------------------------
'' Link_partner_SNR                           [1:0]            get_Link_partner_SNR
''                                                             set_Link_partner_SNR
''                                                             read_Link_partner_SNR
''                                                             write_Link_partner_SNR
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_base1000t1_oam_receive
    Private write_LP10001OMV_value
    Private read_LP10001OMV_value
    Private flag_LP10001OMV
    Private write_Link_partner_toggle_value_value
    Private read_Link_partner_toggle_value_value
    Private flag_Link_partner_toggle_value
    Private write_Link_partner_message_number_value
    Private read_Link_partner_message_number_value
    Private flag_Link_partner_message_number
    Private write_Link_partner_SNR_value
    Private read_Link_partner_SNR_value
    Private flag_Link_partner_SNR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1212
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP10001OMV
        get_LP10001OMV = read_LP10001OMV_value
    End Property

    Property Let set_LP10001OMV(aData)
        write_LP10001OMV_value = aData
        flag_LP10001OMV        = &H1
    End Property

    Property Get read_LP10001OMV
        read
        read_LP10001OMV = read_LP10001OMV_value
    End Property

    Property Let write_LP10001OMV(aData)
        set_LP10001OMV = aData
        write
    End Property

    Property Get get_Link_partner_toggle_value
        get_Link_partner_toggle_value = read_Link_partner_toggle_value_value
    End Property

    Property Let set_Link_partner_toggle_value(aData)
        write_Link_partner_toggle_value_value = aData
        flag_Link_partner_toggle_value        = &H1
    End Property

    Property Get read_Link_partner_toggle_value
        read
        read_Link_partner_toggle_value = read_Link_partner_toggle_value_value
    End Property

    Property Let write_Link_partner_toggle_value(aData)
        set_Link_partner_toggle_value = aData
        write
    End Property

    Property Get get_Link_partner_message_number
        get_Link_partner_message_number = read_Link_partner_message_number_value
    End Property

    Property Let set_Link_partner_message_number(aData)
        write_Link_partner_message_number_value = aData
        flag_Link_partner_message_number        = &H1
    End Property

    Property Get read_Link_partner_message_number
        read
        read_Link_partner_message_number = read_Link_partner_message_number_value
    End Property

    Property Let write_Link_partner_message_number(aData)
        set_Link_partner_message_number = aData
        write
    End Property

    Property Get get_Link_partner_SNR
        get_Link_partner_SNR = read_Link_partner_SNR_value
    End Property

    Property Let set_Link_partner_SNR(aData)
        write_Link_partner_SNR_value = aData
        flag_Link_partner_SNR        = &H1
    End Property

    Property Get read_Link_partner_SNR
        read
        read_Link_partner_SNR = read_Link_partner_SNR_value
    End Property

    Property Let write_Link_partner_SNR(aData)
        set_Link_partner_SNR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP10001OMV_value = rightShift(data_low, 15) and &H1
        read_Link_partner_toggle_value_value = rightShift(data_low, 14) and &H1
        read_Link_partner_message_number_value = rightShift(data_low, 8) and &Hf
        Link_partner_SNR_mask = &H3
        if data_low > LONG_MAX then
            if Link_partner_SNR_mask = mask then
                read_Link_partner_SNR_value = data_low
            else
                read_Link_partner_SNR_value = (data_low - H8000_0000) and Link_partner_SNR_mask
            end If
        else
            read_Link_partner_SNR_value = data_low and Link_partner_SNR_mask
        end If

    End Sub

    Sub write
        If flag_LP10001OMV = &H0 or flag_Link_partner_toggle_value = &H0 or flag_Link_partner_message_number = &H0 or flag_Link_partner_SNR = &H0 Then read
        If flag_LP10001OMV = &H0 Then write_LP10001OMV_value = get_LP10001OMV
        If flag_Link_partner_toggle_value = &H0 Then write_Link_partner_toggle_value_value = get_Link_partner_toggle_value
        If flag_Link_partner_message_number = &H0 Then write_Link_partner_message_number_value = get_Link_partner_message_number
        If flag_Link_partner_SNR = &H0 Then write_Link_partner_SNR_value = get_Link_partner_SNR

        regValue = leftShift((write_LP10001OMV_value and &H1), 15) + leftShift((write_Link_partner_toggle_value_value and &H1), 14) + leftShift((write_Link_partner_message_number_value and &Hf), 8) + leftShift((write_Link_partner_SNR_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP10001OMV_value = rightShift(data_low, 15) and &H1
        read_Link_partner_toggle_value_value = rightShift(data_low, 14) and &H1
        read_Link_partner_message_number_value = rightShift(data_low, 8) and &Hf
        Link_partner_SNR_mask = &H3
        if data_low > LONG_MAX then
            if Link_partner_SNR_mask = mask then
                read_Link_partner_SNR_value = data_low
            else
                read_Link_partner_SNR_value = (data_low - H8000_0000) and Link_partner_SNR_mask
            end If
        else
            read_Link_partner_SNR_value = data_low and Link_partner_SNR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP10001OMV_value = &H0
        flag_LP10001OMV        = &H0
        write_Link_partner_toggle_value_value = &H0
        flag_Link_partner_toggle_value        = &H0
        write_Link_partner_message_number_value = &H0
        flag_Link_partner_message_number        = &H0
        write_Link_partner_SNR_value = &H0
        flag_Link_partner_SNR        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_lp_base1000t1_oam_message_1_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LB10001OM1                                 [15:8]           get_LB10001OM1
''                                                             set_LB10001OM1
''                                                             read_LB10001OM1
''                                                             write_LB10001OM1
''---------------------------------------------------------------------------------
'' LB10001OM0                                 [7:0]            get_LB10001OM0
''                                                             set_LB10001OM0
''                                                             read_LB10001OM0
''                                                             write_LB10001OM0
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_lp_base1000t1_oam_message_1_0
    Private write_LB10001OM1_value
    Private read_LB10001OM1_value
    Private flag_LB10001OM1
    Private write_LB10001OM0_value
    Private read_LB10001OM0_value
    Private flag_LB10001OM0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LB10001OM1
        get_LB10001OM1 = read_LB10001OM1_value
    End Property

    Property Let set_LB10001OM1(aData)
        write_LB10001OM1_value = aData
        flag_LB10001OM1        = &H1
    End Property

    Property Get read_LB10001OM1
        read
        read_LB10001OM1 = read_LB10001OM1_value
    End Property

    Property Let write_LB10001OM1(aData)
        set_LB10001OM1 = aData
        write
    End Property

    Property Get get_LB10001OM0
        get_LB10001OM0 = read_LB10001OM0_value
    End Property

    Property Let set_LB10001OM0(aData)
        write_LB10001OM0_value = aData
        flag_LB10001OM0        = &H1
    End Property

    Property Get read_LB10001OM0
        read
        read_LB10001OM0 = read_LB10001OM0_value
    End Property

    Property Let write_LB10001OM0(aData)
        set_LB10001OM0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM1_value = rightShift(data_low, 8) and &Hff
        LB10001OM0_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM0_mask = mask then
                read_LB10001OM0_value = data_low
            else
                read_LB10001OM0_value = (data_low - H8000_0000) and LB10001OM0_mask
            end If
        else
            read_LB10001OM0_value = data_low and LB10001OM0_mask
        end If

    End Sub

    Sub write
        If flag_LB10001OM1 = &H0 or flag_LB10001OM0 = &H0 Then read
        If flag_LB10001OM1 = &H0 Then write_LB10001OM1_value = get_LB10001OM1
        If flag_LB10001OM0 = &H0 Then write_LB10001OM0_value = get_LB10001OM0

        regValue = leftShift((write_LB10001OM1_value and &Hff), 8) + leftShift((write_LB10001OM0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM1_value = rightShift(data_low, 8) and &Hff
        LB10001OM0_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM0_mask = mask then
                read_LB10001OM0_value = data_low
            else
                read_LB10001OM0_value = (data_low - H8000_0000) and LB10001OM0_mask
            end If
        else
            read_LB10001OM0_value = data_low and LB10001OM0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LB10001OM1_value = &H0
        flag_LB10001OM1        = &H0
        write_LB10001OM0_value = &H0
        flag_LB10001OM0        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_lp_base1000t1_oam_message_3_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LB10001OM3                                 [15:8]           get_LB10001OM3
''                                                             set_LB10001OM3
''                                                             read_LB10001OM3
''                                                             write_LB10001OM3
''---------------------------------------------------------------------------------
'' LB10001OM2                                 [7:0]            get_LB10001OM2
''                                                             set_LB10001OM2
''                                                             read_LB10001OM2
''                                                             write_LB10001OM2
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_lp_base1000t1_oam_message_3_2
    Private write_LB10001OM3_value
    Private read_LB10001OM3_value
    Private flag_LB10001OM3
    Private write_LB10001OM2_value
    Private read_LB10001OM2_value
    Private flag_LB10001OM2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1216
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LB10001OM3
        get_LB10001OM3 = read_LB10001OM3_value
    End Property

    Property Let set_LB10001OM3(aData)
        write_LB10001OM3_value = aData
        flag_LB10001OM3        = &H1
    End Property

    Property Get read_LB10001OM3
        read
        read_LB10001OM3 = read_LB10001OM3_value
    End Property

    Property Let write_LB10001OM3(aData)
        set_LB10001OM3 = aData
        write
    End Property

    Property Get get_LB10001OM2
        get_LB10001OM2 = read_LB10001OM2_value
    End Property

    Property Let set_LB10001OM2(aData)
        write_LB10001OM2_value = aData
        flag_LB10001OM2        = &H1
    End Property

    Property Get read_LB10001OM2
        read
        read_LB10001OM2 = read_LB10001OM2_value
    End Property

    Property Let write_LB10001OM2(aData)
        set_LB10001OM2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM3_value = rightShift(data_low, 8) and &Hff
        LB10001OM2_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM2_mask = mask then
                read_LB10001OM2_value = data_low
            else
                read_LB10001OM2_value = (data_low - H8000_0000) and LB10001OM2_mask
            end If
        else
            read_LB10001OM2_value = data_low and LB10001OM2_mask
        end If

    End Sub

    Sub write
        If flag_LB10001OM3 = &H0 or flag_LB10001OM2 = &H0 Then read
        If flag_LB10001OM3 = &H0 Then write_LB10001OM3_value = get_LB10001OM3
        If flag_LB10001OM2 = &H0 Then write_LB10001OM2_value = get_LB10001OM2

        regValue = leftShift((write_LB10001OM3_value and &Hff), 8) + leftShift((write_LB10001OM2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM3_value = rightShift(data_low, 8) and &Hff
        LB10001OM2_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM2_mask = mask then
                read_LB10001OM2_value = data_low
            else
                read_LB10001OM2_value = (data_low - H8000_0000) and LB10001OM2_mask
            end If
        else
            read_LB10001OM2_value = data_low and LB10001OM2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LB10001OM3_value = &H0
        flag_LB10001OM3        = &H0
        write_LB10001OM2_value = &H0
        flag_LB10001OM2        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_lp_base1000t1_oam_message_5_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LB10001OM5                                 [15:8]           get_LB10001OM5
''                                                             set_LB10001OM5
''                                                             read_LB10001OM5
''                                                             write_LB10001OM5
''---------------------------------------------------------------------------------
'' LB10001OM4                                 [7:0]            get_LB10001OM4
''                                                             set_LB10001OM4
''                                                             read_LB10001OM4
''                                                             write_LB10001OM4
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_lp_base1000t1_oam_message_5_4
    Private write_LB10001OM5_value
    Private read_LB10001OM5_value
    Private flag_LB10001OM5
    Private write_LB10001OM4_value
    Private read_LB10001OM4_value
    Private flag_LB10001OM4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1218
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LB10001OM5
        get_LB10001OM5 = read_LB10001OM5_value
    End Property

    Property Let set_LB10001OM5(aData)
        write_LB10001OM5_value = aData
        flag_LB10001OM5        = &H1
    End Property

    Property Get read_LB10001OM5
        read
        read_LB10001OM5 = read_LB10001OM5_value
    End Property

    Property Let write_LB10001OM5(aData)
        set_LB10001OM5 = aData
        write
    End Property

    Property Get get_LB10001OM4
        get_LB10001OM4 = read_LB10001OM4_value
    End Property

    Property Let set_LB10001OM4(aData)
        write_LB10001OM4_value = aData
        flag_LB10001OM4        = &H1
    End Property

    Property Get read_LB10001OM4
        read
        read_LB10001OM4 = read_LB10001OM4_value
    End Property

    Property Let write_LB10001OM4(aData)
        set_LB10001OM4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM5_value = rightShift(data_low, 8) and &Hff
        LB10001OM4_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM4_mask = mask then
                read_LB10001OM4_value = data_low
            else
                read_LB10001OM4_value = (data_low - H8000_0000) and LB10001OM4_mask
            end If
        else
            read_LB10001OM4_value = data_low and LB10001OM4_mask
        end If

    End Sub

    Sub write
        If flag_LB10001OM5 = &H0 or flag_LB10001OM4 = &H0 Then read
        If flag_LB10001OM5 = &H0 Then write_LB10001OM5_value = get_LB10001OM5
        If flag_LB10001OM4 = &H0 Then write_LB10001OM4_value = get_LB10001OM4

        regValue = leftShift((write_LB10001OM5_value and &Hff), 8) + leftShift((write_LB10001OM4_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM5_value = rightShift(data_low, 8) and &Hff
        LB10001OM4_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM4_mask = mask then
                read_LB10001OM4_value = data_low
            else
                read_LB10001OM4_value = (data_low - H8000_0000) and LB10001OM4_mask
            end If
        else
            read_LB10001OM4_value = data_low and LB10001OM4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LB10001OM5_value = &H0
        flag_LB10001OM5        = &H0
        write_LB10001OM4_value = &H0
        flag_LB10001OM4        = &H0
    End Sub
End Class


'' @REGISTER : PCS_IEEE_lp_base1000t1_oam_message_7_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LB10001OM7                                 [15:8]           get_LB10001OM7
''                                                             set_LB10001OM7
''                                                             read_LB10001OM7
''                                                             write_LB10001OM7
''---------------------------------------------------------------------------------
'' LB10001OM6                                 [7:0]            get_LB10001OM6
''                                                             set_LB10001OM6
''                                                             read_LB10001OM6
''                                                             write_LB10001OM6
''---------------------------------------------------------------------------------
Class REGISTER_PCS_IEEE_lp_base1000t1_oam_message_7_6
    Private write_LB10001OM7_value
    Private read_LB10001OM7_value
    Private flag_LB10001OM7
    Private write_LB10001OM6_value
    Private read_LB10001OM6_value
    Private flag_LB10001OM6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H121a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LB10001OM7
        get_LB10001OM7 = read_LB10001OM7_value
    End Property

    Property Let set_LB10001OM7(aData)
        write_LB10001OM7_value = aData
        flag_LB10001OM7        = &H1
    End Property

    Property Get read_LB10001OM7
        read
        read_LB10001OM7 = read_LB10001OM7_value
    End Property

    Property Let write_LB10001OM7(aData)
        set_LB10001OM7 = aData
        write
    End Property

    Property Get get_LB10001OM6
        get_LB10001OM6 = read_LB10001OM6_value
    End Property

    Property Let set_LB10001OM6(aData)
        write_LB10001OM6_value = aData
        flag_LB10001OM6        = &H1
    End Property

    Property Get read_LB10001OM6
        read
        read_LB10001OM6 = read_LB10001OM6_value
    End Property

    Property Let write_LB10001OM6(aData)
        set_LB10001OM6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM7_value = rightShift(data_low, 8) and &Hff
        LB10001OM6_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM6_mask = mask then
                read_LB10001OM6_value = data_low
            else
                read_LB10001OM6_value = (data_low - H8000_0000) and LB10001OM6_mask
            end If
        else
            read_LB10001OM6_value = data_low and LB10001OM6_mask
        end If

    End Sub

    Sub write
        If flag_LB10001OM7 = &H0 or flag_LB10001OM6 = &H0 Then read
        If flag_LB10001OM7 = &H0 Then write_LB10001OM7_value = get_LB10001OM7
        If flag_LB10001OM6 = &H0 Then write_LB10001OM6_value = get_LB10001OM6

        regValue = leftShift((write_LB10001OM7_value and &Hff), 8) + leftShift((write_LB10001OM6_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LB10001OM7_value = rightShift(data_low, 8) and &Hff
        LB10001OM6_mask = &Hff
        if data_low > LONG_MAX then
            if LB10001OM6_mask = mask then
                read_LB10001OM6_value = data_low
            else
                read_LB10001OM6_value = (data_low - H8000_0000) and LB10001OM6_mask
            end If
        else
            read_LB10001OM6_value = data_low and LB10001OM6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LB10001OM7_value = &H0
        flag_LB10001OM7        = &H0
        write_LB10001OM6_value = &H0
        flag_LB10001OM6        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCS_IEEE_INSTANCE

    Public pcs_control_reg1
    Public status_reg1
    Public pcs_device_id_reg0
    Public pcs_device_id_reg1
    Public pcs_device_in_pkg_reg0
    Public pcs_device_in_pkg_reg1
    Public pcs_pkg_id_reg0
    Public pcs_pkg_id_reg1
    Public timesync_pcs_capability
    Public maximum_pcs_tx_path_delay_lower
    Public maximum_pcs_tx_path_delay_upper
    Public minimum_pcs_tx_path_delay_lower
    Public minimum_pcs_tx_path_delay_upper
    Public maximum_pcs_rx_path_delay_lower
    Public maximum_pcs_rx_path_delay_upper
    Public minimum_pcs_rx_path_delay_lower
    Public minimum_pcs_rx_path_delay_upper
    Public base1000t1_pcs_control
    Public base1000t1_pcs_status1
    Public base1000t1_pcs_status2
    Public base1000t1_oam_xmit
    Public base1000t1_oam_message_1_0
    Public base1000t1_oam_message_3_2
    Public base1000t1_oam_message_5_4
    Public base1000t1_oam_message_7_6
    Public base1000t1_oam_receive
    Public lp_base1000t1_oam_message_1_0
    Public lp_base1000t1_oam_message_3_2
    Public lp_base1000t1_oam_message_5_4
    Public lp_base1000t1_oam_message_7_6


    Public default function Init(aBaseAddr)
        Set pcs_control_reg1 = (New REGISTER_PCS_IEEE_pcs_control_reg1)(aBaseAddr, 16)
        Set status_reg1 = (New REGISTER_PCS_IEEE_status_reg1)(aBaseAddr, 16)
        Set pcs_device_id_reg0 = (New REGISTER_PCS_IEEE_pcs_device_id_reg0)(aBaseAddr, 16)
        Set pcs_device_id_reg1 = (New REGISTER_PCS_IEEE_pcs_device_id_reg1)(aBaseAddr, 16)
        Set pcs_device_in_pkg_reg0 = (New REGISTER_PCS_IEEE_pcs_device_in_pkg_reg0)(aBaseAddr, 16)
        Set pcs_device_in_pkg_reg1 = (New REGISTER_PCS_IEEE_pcs_device_in_pkg_reg1)(aBaseAddr, 16)
        Set pcs_pkg_id_reg0 = (New REGISTER_PCS_IEEE_pcs_pkg_id_reg0)(aBaseAddr, 16)
        Set pcs_pkg_id_reg1 = (New REGISTER_PCS_IEEE_pcs_pkg_id_reg1)(aBaseAddr, 16)
        Set timesync_pcs_capability = (New REGISTER_PCS_IEEE_timesync_pcs_capability)(aBaseAddr, 16)
        Set maximum_pcs_tx_path_delay_lower = (New REGISTER_PCS_IEEE_maximum_pcs_tx_path_delay_lower)(aBaseAddr, 16)
        Set maximum_pcs_tx_path_delay_upper = (New REGISTER_PCS_IEEE_maximum_pcs_tx_path_delay_upper)(aBaseAddr, 16)
        Set minimum_pcs_tx_path_delay_lower = (New REGISTER_PCS_IEEE_minimum_pcs_tx_path_delay_lower)(aBaseAddr, 16)
        Set minimum_pcs_tx_path_delay_upper = (New REGISTER_PCS_IEEE_minimum_pcs_tx_path_delay_upper)(aBaseAddr, 16)
        Set maximum_pcs_rx_path_delay_lower = (New REGISTER_PCS_IEEE_maximum_pcs_rx_path_delay_lower)(aBaseAddr, 16)
        Set maximum_pcs_rx_path_delay_upper = (New REGISTER_PCS_IEEE_maximum_pcs_rx_path_delay_upper)(aBaseAddr, 16)
        Set minimum_pcs_rx_path_delay_lower = (New REGISTER_PCS_IEEE_minimum_pcs_rx_path_delay_lower)(aBaseAddr, 16)
        Set minimum_pcs_rx_path_delay_upper = (New REGISTER_PCS_IEEE_minimum_pcs_rx_path_delay_upper)(aBaseAddr, 16)
        Set base1000t1_pcs_control = (New REGISTER_PCS_IEEE_base1000t1_pcs_control)(aBaseAddr, 16)
        Set base1000t1_pcs_status1 = (New REGISTER_PCS_IEEE_base1000t1_pcs_status1)(aBaseAddr, 16)
        Set base1000t1_pcs_status2 = (New REGISTER_PCS_IEEE_base1000t1_pcs_status2)(aBaseAddr, 16)
        Set base1000t1_oam_xmit = (New REGISTER_PCS_IEEE_base1000t1_oam_xmit)(aBaseAddr, 16)
        Set base1000t1_oam_message_1_0 = (New REGISTER_PCS_IEEE_base1000t1_oam_message_1_0)(aBaseAddr, 16)
        Set base1000t1_oam_message_3_2 = (New REGISTER_PCS_IEEE_base1000t1_oam_message_3_2)(aBaseAddr, 16)
        Set base1000t1_oam_message_5_4 = (New REGISTER_PCS_IEEE_base1000t1_oam_message_5_4)(aBaseAddr, 16)
        Set base1000t1_oam_message_7_6 = (New REGISTER_PCS_IEEE_base1000t1_oam_message_7_6)(aBaseAddr, 16)
        Set base1000t1_oam_receive = (New REGISTER_PCS_IEEE_base1000t1_oam_receive)(aBaseAddr, 16)
        Set lp_base1000t1_oam_message_1_0 = (New REGISTER_PCS_IEEE_lp_base1000t1_oam_message_1_0)(aBaseAddr, 16)
        Set lp_base1000t1_oam_message_3_2 = (New REGISTER_PCS_IEEE_lp_base1000t1_oam_message_3_2)(aBaseAddr, 16)
        Set lp_base1000t1_oam_message_5_4 = (New REGISTER_PCS_IEEE_lp_base1000t1_oam_message_5_4)(aBaseAddr, 16)
        Set lp_base1000t1_oam_message_7_6 = (New REGISTER_PCS_IEEE_lp_base1000t1_oam_message_7_6)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCS_IEEE = CreateObject("System.Collections.ArrayList")
PCS_IEEE.Add ((New PCS_IEEE_INSTANCE)(&H49060000))


