

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


'' @REGISTER : PMA_PMD_IEEE_control_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESET                                      [15:15]          get_RESET
''                                                             set_RESET
''                                                             read_RESET
''                                                             write_RESET
''---------------------------------------------------------------------------------
'' SPEED_SEL_0                                [13:13]          get_SPEED_SEL_0
''                                                             set_SPEED_SEL_0
''                                                             read_SPEED_SEL_0
''                                                             write_SPEED_SEL_0
''---------------------------------------------------------------------------------
'' LOW_POWER                                  [11:11]          get_LOW_POWER
''                                                             set_LOW_POWER
''                                                             read_LOW_POWER
''                                                             write_LOW_POWER
''---------------------------------------------------------------------------------
'' SPEED_SEL_1                                [6:6]            get_SPEED_SEL_1
''                                                             set_SPEED_SEL_1
''                                                             read_SPEED_SEL_1
''                                                             write_SPEED_SEL_1
''---------------------------------------------------------------------------------
'' SPEED_SELECT                               [5:2]            get_SPEED_SELECT
''                                                             set_SPEED_SELECT
''                                                             read_SPEED_SELECT
''                                                             write_SPEED_SELECT
''---------------------------------------------------------------------------------
'' REMOTE_LOOPBACK                            [1:1]            get_REMOTE_LOOPBACK
''                                                             set_REMOTE_LOOPBACK
''                                                             read_REMOTE_LOOPBACK
''                                                             write_REMOTE_LOOPBACK
''---------------------------------------------------------------------------------
'' LOCAL_LOOPBACK                             [0:0]            get_LOCAL_LOOPBACK
''                                                             set_LOCAL_LOOPBACK
''                                                             read_LOCAL_LOOPBACK
''                                                             write_LOCAL_LOOPBACK
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_control_reg1
    Private write_RESET_value
    Private read_RESET_value
    Private flag_RESET
    Private write_SPEED_SEL_0_value
    Private read_SPEED_SEL_0_value
    Private flag_SPEED_SEL_0
    Private write_LOW_POWER_value
    Private read_LOW_POWER_value
    Private flag_LOW_POWER
    Private write_SPEED_SEL_1_value
    Private read_SPEED_SEL_1_value
    Private flag_SPEED_SEL_1
    Private write_SPEED_SELECT_value
    Private read_SPEED_SELECT_value
    Private flag_SPEED_SELECT
    Private write_REMOTE_LOOPBACK_value
    Private read_REMOTE_LOOPBACK_value
    Private flag_REMOTE_LOOPBACK
    Private write_LOCAL_LOOPBACK_value
    Private read_LOCAL_LOOPBACK_value
    Private flag_LOCAL_LOOPBACK

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

    Property Get get_RESET
        get_RESET = read_RESET_value
    End Property

    Property Let set_RESET(aData)
        write_RESET_value = aData
        flag_RESET        = &H1
    End Property

    Property Get read_RESET
        read
        read_RESET = read_RESET_value
    End Property

    Property Let write_RESET(aData)
        set_RESET = aData
        write
    End Property

    Property Get get_SPEED_SEL_0
        get_SPEED_SEL_0 = read_SPEED_SEL_0_value
    End Property

    Property Let set_SPEED_SEL_0(aData)
        write_SPEED_SEL_0_value = aData
        flag_SPEED_SEL_0        = &H1
    End Property

    Property Get read_SPEED_SEL_0
        read
        read_SPEED_SEL_0 = read_SPEED_SEL_0_value
    End Property

    Property Let write_SPEED_SEL_0(aData)
        set_SPEED_SEL_0 = aData
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

    Property Get get_SPEED_SEL_1
        get_SPEED_SEL_1 = read_SPEED_SEL_1_value
    End Property

    Property Let set_SPEED_SEL_1(aData)
        write_SPEED_SEL_1_value = aData
        flag_SPEED_SEL_1        = &H1
    End Property

    Property Get read_SPEED_SEL_1
        read
        read_SPEED_SEL_1 = read_SPEED_SEL_1_value
    End Property

    Property Let write_SPEED_SEL_1(aData)
        set_SPEED_SEL_1 = aData
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

    Property Get get_REMOTE_LOOPBACK
        get_REMOTE_LOOPBACK = read_REMOTE_LOOPBACK_value
    End Property

    Property Let set_REMOTE_LOOPBACK(aData)
        write_REMOTE_LOOPBACK_value = aData
        flag_REMOTE_LOOPBACK        = &H1
    End Property

    Property Get read_REMOTE_LOOPBACK
        read
        read_REMOTE_LOOPBACK = read_REMOTE_LOOPBACK_value
    End Property

    Property Let write_REMOTE_LOOPBACK(aData)
        set_REMOTE_LOOPBACK = aData
        write
    End Property

    Property Get get_LOCAL_LOOPBACK
        get_LOCAL_LOOPBACK = read_LOCAL_LOOPBACK_value
    End Property

    Property Let set_LOCAL_LOOPBACK(aData)
        write_LOCAL_LOOPBACK_value = aData
        flag_LOCAL_LOOPBACK        = &H1
    End Property

    Property Get read_LOCAL_LOOPBACK
        read
        read_LOCAL_LOOPBACK = read_LOCAL_LOOPBACK_value
    End Property

    Property Let write_LOCAL_LOOPBACK(aData)
        set_LOCAL_LOOPBACK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESET_value = rightShift(data_low, 15) and &H1
        read_SPEED_SEL_0_value = rightShift(data_low, 13) and &H1
        read_LOW_POWER_value = rightShift(data_low, 11) and &H1
        read_SPEED_SEL_1_value = rightShift(data_low, 6) and &H1
        read_SPEED_SELECT_value = rightShift(data_low, 2) and &Hf
        read_REMOTE_LOOPBACK_value = rightShift(data_low, 1) and &H1
        LOCAL_LOOPBACK_mask = &H1
        if data_low > LONG_MAX then
            if LOCAL_LOOPBACK_mask = mask then
                read_LOCAL_LOOPBACK_value = data_low
            else
                read_LOCAL_LOOPBACK_value = (data_low - H8000_0000) and LOCAL_LOOPBACK_mask
            end If
        else
            read_LOCAL_LOOPBACK_value = data_low and LOCAL_LOOPBACK_mask
        end If

    End Sub

    Sub write
        If flag_RESET = &H0 or flag_SPEED_SEL_0 = &H0 or flag_LOW_POWER = &H0 or flag_SPEED_SEL_1 = &H0 or flag_SPEED_SELECT = &H0 or flag_REMOTE_LOOPBACK = &H0 or flag_LOCAL_LOOPBACK = &H0 Then read
        If flag_RESET = &H0 Then write_RESET_value = get_RESET
        If flag_SPEED_SEL_0 = &H0 Then write_SPEED_SEL_0_value = get_SPEED_SEL_0
        If flag_LOW_POWER = &H0 Then write_LOW_POWER_value = get_LOW_POWER
        If flag_SPEED_SEL_1 = &H0 Then write_SPEED_SEL_1_value = get_SPEED_SEL_1
        If flag_SPEED_SELECT = &H0 Then write_SPEED_SELECT_value = get_SPEED_SELECT
        If flag_REMOTE_LOOPBACK = &H0 Then write_REMOTE_LOOPBACK_value = get_REMOTE_LOOPBACK
        If flag_LOCAL_LOOPBACK = &H0 Then write_LOCAL_LOOPBACK_value = get_LOCAL_LOOPBACK

        regValue = leftShift((write_RESET_value and &H1), 15) + leftShift((write_SPEED_SEL_0_value and &H1), 13) + leftShift((write_LOW_POWER_value and &H1), 11) + leftShift((write_SPEED_SEL_1_value and &H1), 6) + leftShift((write_SPEED_SELECT_value and &Hf), 2) + leftShift((write_REMOTE_LOOPBACK_value and &H1), 1) + leftShift((write_LOCAL_LOOPBACK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESET_value = rightShift(data_low, 15) and &H1
        read_SPEED_SEL_0_value = rightShift(data_low, 13) and &H1
        read_LOW_POWER_value = rightShift(data_low, 11) and &H1
        read_SPEED_SEL_1_value = rightShift(data_low, 6) and &H1
        read_SPEED_SELECT_value = rightShift(data_low, 2) and &Hf
        read_REMOTE_LOOPBACK_value = rightShift(data_low, 1) and &H1
        LOCAL_LOOPBACK_mask = &H1
        if data_low > LONG_MAX then
            if LOCAL_LOOPBACK_mask = mask then
                read_LOCAL_LOOPBACK_value = data_low
            else
                read_LOCAL_LOOPBACK_value = (data_low - H8000_0000) and LOCAL_LOOPBACK_mask
            end If
        else
            read_LOCAL_LOOPBACK_value = data_low and LOCAL_LOOPBACK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESET_value = &H0
        flag_RESET        = &H0
        write_SPEED_SEL_0_value = &H0
        flag_SPEED_SEL_0        = &H0
        write_LOW_POWER_value = &H0
        flag_LOW_POWER        = &H0
        write_SPEED_SEL_1_value = &H0
        flag_SPEED_SEL_1        = &H0
        write_SPEED_SELECT_value = &H0
        flag_SPEED_SELECT        = &H0
        write_REMOTE_LOOPBACK_value = &H0
        flag_REMOTE_LOOPBACK        = &H0
        write_LOCAL_LOOPBACK_value = &H0
        flag_LOCAL_LOOPBACK        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_status_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PIASA                                      [9:9]            get_PIASA
''                                                             set_PIASA
''                                                             read_PIASA
''                                                             write_PIASA
''---------------------------------------------------------------------------------
'' PEASA                                      [8:8]            get_PEASA
''                                                             set_PEASA
''                                                             read_PEASA
''                                                             write_PEASA
''---------------------------------------------------------------------------------
'' Fault                                      [7:7]            get_Fault
''                                                             set_Fault
''                                                             read_Fault
''                                                             write_Fault
''---------------------------------------------------------------------------------
'' Receive_link_status                        [2:2]            get_Receive_link_status
''                                                             set_Receive_link_status
''                                                             read_Receive_link_status
''                                                             write_Receive_link_status
''---------------------------------------------------------------------------------
'' Low_power_ability                          [1:1]            get_Low_power_ability
''                                                             set_Low_power_ability
''                                                             read_Low_power_ability
''                                                             write_Low_power_ability
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_status_reg1
    Private write_PIASA_value
    Private read_PIASA_value
    Private flag_PIASA
    Private write_PEASA_value
    Private read_PEASA_value
    Private flag_PEASA
    Private write_Fault_value
    Private read_Fault_value
    Private flag_Fault
    Private write_Receive_link_status_value
    Private read_Receive_link_status_value
    Private flag_Receive_link_status
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

    Property Get get_PIASA
        get_PIASA = read_PIASA_value
    End Property

    Property Let set_PIASA(aData)
        write_PIASA_value = aData
        flag_PIASA        = &H1
    End Property

    Property Get read_PIASA
        read
        read_PIASA = read_PIASA_value
    End Property

    Property Let write_PIASA(aData)
        set_PIASA = aData
        write
    End Property

    Property Get get_PEASA
        get_PEASA = read_PEASA_value
    End Property

    Property Let set_PEASA(aData)
        write_PEASA_value = aData
        flag_PEASA        = &H1
    End Property

    Property Get read_PEASA
        read
        read_PEASA = read_PEASA_value
    End Property

    Property Let write_PEASA(aData)
        set_PEASA = aData
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
        read_PIASA_value = rightShift(data_low, 9) and &H1
        read_PEASA_value = rightShift(data_low, 8) and &H1
        read_Fault_value = rightShift(data_low, 7) and &H1
        read_Receive_link_status_value = rightShift(data_low, 2) and &H1
        read_Low_power_ability_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_PIASA = &H0 or flag_PEASA = &H0 or flag_Fault = &H0 or flag_Receive_link_status = &H0 or flag_Low_power_ability = &H0 Then read
        If flag_PIASA = &H0 Then write_PIASA_value = get_PIASA
        If flag_PEASA = &H0 Then write_PEASA_value = get_PEASA
        If flag_Fault = &H0 Then write_Fault_value = get_Fault
        If flag_Receive_link_status = &H0 Then write_Receive_link_status_value = get_Receive_link_status
        If flag_Low_power_ability = &H0 Then write_Low_power_ability_value = get_Low_power_ability

        regValue = leftShift((write_PIASA_value and &H1), 9) + leftShift((write_PEASA_value and &H1), 8) + leftShift((write_Fault_value and &H1), 7) + leftShift((write_Receive_link_status_value and &H1), 2) + leftShift((write_Low_power_ability_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PIASA_value = rightShift(data_low, 9) and &H1
        read_PEASA_value = rightShift(data_low, 8) and &H1
        read_Fault_value = rightShift(data_low, 7) and &H1
        read_Receive_link_status_value = rightShift(data_low, 2) and &H1
        read_Low_power_ability_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PIASA_value = &H0
        flag_PIASA        = &H0
        write_PEASA_value = &H0
        flag_PEASA        = &H0
        write_Fault_value = &H0
        flag_Fault        = &H0
        write_Receive_link_status_value = &H0
        flag_Receive_link_status        = &H0
        write_Low_power_ability_value = &H0
        flag_Low_power_ability        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_device_id_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Device_ID0                                 [15:0]           get_Device_ID0
''                                                             set_Device_ID0
''                                                             read_Device_ID0
''                                                             write_Device_ID0
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_device_id_reg0
    Private write_Device_ID0_value
    Private read_Device_ID0_value
    Private flag_Device_ID0

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

    Property Get get_Device_ID0
        get_Device_ID0 = read_Device_ID0_value
    End Property

    Property Let set_Device_ID0(aData)
        write_Device_ID0_value = aData
        flag_Device_ID0        = &H1
    End Property

    Property Get read_Device_ID0
        read
        read_Device_ID0 = read_Device_ID0_value
    End Property

    Property Let write_Device_ID0(aData)
        set_Device_ID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Device_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if Device_ID0_mask = mask then
                read_Device_ID0_value = data_low
            else
                read_Device_ID0_value = (data_low - H8000_0000) and Device_ID0_mask
            end If
        else
            read_Device_ID0_value = data_low and Device_ID0_mask
        end If

    End Sub

    Sub write
        If flag_Device_ID0 = &H0 Then read
        If flag_Device_ID0 = &H0 Then write_Device_ID0_value = get_Device_ID0

        regValue = leftShift((write_Device_ID0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Device_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if Device_ID0_mask = mask then
                read_Device_ID0_value = data_low
            else
                read_Device_ID0_value = (data_low - H8000_0000) and Device_ID0_mask
            end If
        else
            read_Device_ID0_value = data_low and Device_ID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Device_ID0_value = &H0
        flag_Device_ID0        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_device_id_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Device_ID1                                 [15:0]           get_Device_ID1
''                                                             set_Device_ID1
''                                                             read_Device_ID1
''                                                             write_Device_ID1
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_device_id_reg1
    Private write_Device_ID1_value
    Private read_Device_ID1_value
    Private flag_Device_ID1

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

    Property Get get_Device_ID1
        get_Device_ID1 = read_Device_ID1_value
    End Property

    Property Let set_Device_ID1(aData)
        write_Device_ID1_value = aData
        flag_Device_ID1        = &H1
    End Property

    Property Get read_Device_ID1
        read
        read_Device_ID1 = read_Device_ID1_value
    End Property

    Property Let write_Device_ID1(aData)
        set_Device_ID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Device_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if Device_ID1_mask = mask then
                read_Device_ID1_value = data_low
            else
                read_Device_ID1_value = (data_low - H8000_0000) and Device_ID1_mask
            end If
        else
            read_Device_ID1_value = data_low and Device_ID1_mask
        end If

    End Sub

    Sub write
        If flag_Device_ID1 = &H0 Then read
        If flag_Device_ID1 = &H0 Then write_Device_ID1_value = get_Device_ID1

        regValue = leftShift((write_Device_ID1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Device_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if Device_ID1_mask = mask then
                read_Device_ID1_value = data_low
            else
                read_Device_ID1_value = (data_low - H8000_0000) and Device_ID1_mask
            end If
        else
            read_Device_ID1_value = data_low and Device_ID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Device_ID1_value = &H0
        flag_Device_ID1        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_pma_pmd_speed_ability_register
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' capable_100G                               [9:9]            get_capable_100G
''                                                             set_capable_100G
''                                                             read_capable_100G
''                                                             write_capable_100G
''---------------------------------------------------------------------------------
'' capable_40G                                [8:8]            get_capable_40G
''                                                             set_capable_40G
''                                                             read_capable_40G
''                                                             write_capable_40G
''---------------------------------------------------------------------------------
'' capable_10_1G                              [7:7]            get_capable_10_1G
''                                                             set_capable_10_1G
''                                                             read_capable_10_1G
''                                                             write_capable_10_1G
''---------------------------------------------------------------------------------
'' capable_10M                                [6:6]            get_capable_10M
''                                                             set_capable_10M
''                                                             read_capable_10M
''                                                             write_capable_10M
''---------------------------------------------------------------------------------
'' capable_100M                               [5:5]            get_capable_100M
''                                                             set_capable_100M
''                                                             read_capable_100M
''                                                             write_capable_100M
''---------------------------------------------------------------------------------
'' capable_1000M                              [4:4]            get_capable_1000M
''                                                             set_capable_1000M
''                                                             read_capable_1000M
''                                                             write_capable_1000M
''---------------------------------------------------------------------------------
'' capable_10PASS_TS                          [2:2]            get_capable_10PASS_TS
''                                                             set_capable_10PASS_TS
''                                                             read_capable_10PASS_TS
''                                                             write_capable_10PASS_TS
''---------------------------------------------------------------------------------
'' capable_2BASE_TL                           [1:1]            get_capable_2BASE_TL
''                                                             set_capable_2BASE_TL
''                                                             read_capable_2BASE_TL
''                                                             write_capable_2BASE_TL
''---------------------------------------------------------------------------------
'' capable_10G                                [0:0]            get_capable_10G
''                                                             set_capable_10G
''                                                             read_capable_10G
''                                                             write_capable_10G
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_pma_pmd_speed_ability_register
    Private write_capable_100G_value
    Private read_capable_100G_value
    Private flag_capable_100G
    Private write_capable_40G_value
    Private read_capable_40G_value
    Private flag_capable_40G
    Private write_capable_10_1G_value
    Private read_capable_10_1G_value
    Private flag_capable_10_1G
    Private write_capable_10M_value
    Private read_capable_10M_value
    Private flag_capable_10M
    Private write_capable_100M_value
    Private read_capable_100M_value
    Private flag_capable_100M
    Private write_capable_1000M_value
    Private read_capable_1000M_value
    Private flag_capable_1000M
    Private write_capable_10PASS_TS_value
    Private read_capable_10PASS_TS_value
    Private flag_capable_10PASS_TS
    Private write_capable_2BASE_TL_value
    Private read_capable_2BASE_TL_value
    Private flag_capable_2BASE_TL
    Private write_capable_10G_value
    Private read_capable_10G_value
    Private flag_capable_10G

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

    Property Get get_capable_100G
        get_capable_100G = read_capable_100G_value
    End Property

    Property Let set_capable_100G(aData)
        write_capable_100G_value = aData
        flag_capable_100G        = &H1
    End Property

    Property Get read_capable_100G
        read
        read_capable_100G = read_capable_100G_value
    End Property

    Property Let write_capable_100G(aData)
        set_capable_100G = aData
        write
    End Property

    Property Get get_capable_40G
        get_capable_40G = read_capable_40G_value
    End Property

    Property Let set_capable_40G(aData)
        write_capable_40G_value = aData
        flag_capable_40G        = &H1
    End Property

    Property Get read_capable_40G
        read
        read_capable_40G = read_capable_40G_value
    End Property

    Property Let write_capable_40G(aData)
        set_capable_40G = aData
        write
    End Property

    Property Get get_capable_10_1G
        get_capable_10_1G = read_capable_10_1G_value
    End Property

    Property Let set_capable_10_1G(aData)
        write_capable_10_1G_value = aData
        flag_capable_10_1G        = &H1
    End Property

    Property Get read_capable_10_1G
        read
        read_capable_10_1G = read_capable_10_1G_value
    End Property

    Property Let write_capable_10_1G(aData)
        set_capable_10_1G = aData
        write
    End Property

    Property Get get_capable_10M
        get_capable_10M = read_capable_10M_value
    End Property

    Property Let set_capable_10M(aData)
        write_capable_10M_value = aData
        flag_capable_10M        = &H1
    End Property

    Property Get read_capable_10M
        read
        read_capable_10M = read_capable_10M_value
    End Property

    Property Let write_capable_10M(aData)
        set_capable_10M = aData
        write
    End Property

    Property Get get_capable_100M
        get_capable_100M = read_capable_100M_value
    End Property

    Property Let set_capable_100M(aData)
        write_capable_100M_value = aData
        flag_capable_100M        = &H1
    End Property

    Property Get read_capable_100M
        read
        read_capable_100M = read_capable_100M_value
    End Property

    Property Let write_capable_100M(aData)
        set_capable_100M = aData
        write
    End Property

    Property Get get_capable_1000M
        get_capable_1000M = read_capable_1000M_value
    End Property

    Property Let set_capable_1000M(aData)
        write_capable_1000M_value = aData
        flag_capable_1000M        = &H1
    End Property

    Property Get read_capable_1000M
        read
        read_capable_1000M = read_capable_1000M_value
    End Property

    Property Let write_capable_1000M(aData)
        set_capable_1000M = aData
        write
    End Property

    Property Get get_capable_10PASS_TS
        get_capable_10PASS_TS = read_capable_10PASS_TS_value
    End Property

    Property Let set_capable_10PASS_TS(aData)
        write_capable_10PASS_TS_value = aData
        flag_capable_10PASS_TS        = &H1
    End Property

    Property Get read_capable_10PASS_TS
        read
        read_capable_10PASS_TS = read_capable_10PASS_TS_value
    End Property

    Property Let write_capable_10PASS_TS(aData)
        set_capable_10PASS_TS = aData
        write
    End Property

    Property Get get_capable_2BASE_TL
        get_capable_2BASE_TL = read_capable_2BASE_TL_value
    End Property

    Property Let set_capable_2BASE_TL(aData)
        write_capable_2BASE_TL_value = aData
        flag_capable_2BASE_TL        = &H1
    End Property

    Property Get read_capable_2BASE_TL
        read
        read_capable_2BASE_TL = read_capable_2BASE_TL_value
    End Property

    Property Let write_capable_2BASE_TL(aData)
        set_capable_2BASE_TL = aData
        write
    End Property

    Property Get get_capable_10G
        get_capable_10G = read_capable_10G_value
    End Property

    Property Let set_capable_10G(aData)
        write_capable_10G_value = aData
        flag_capable_10G        = &H1
    End Property

    Property Get read_capable_10G
        read
        read_capable_10G = read_capable_10G_value
    End Property

    Property Let write_capable_10G(aData)
        set_capable_10G = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_capable_100G_value = rightShift(data_low, 9) and &H1
        read_capable_40G_value = rightShift(data_low, 8) and &H1
        read_capable_10_1G_value = rightShift(data_low, 7) and &H1
        read_capable_10M_value = rightShift(data_low, 6) and &H1
        read_capable_100M_value = rightShift(data_low, 5) and &H1
        read_capable_1000M_value = rightShift(data_low, 4) and &H1
        read_capable_10PASS_TS_value = rightShift(data_low, 2) and &H1
        read_capable_2BASE_TL_value = rightShift(data_low, 1) and &H1
        capable_10G_mask = &H1
        if data_low > LONG_MAX then
            if capable_10G_mask = mask then
                read_capable_10G_value = data_low
            else
                read_capable_10G_value = (data_low - H8000_0000) and capable_10G_mask
            end If
        else
            read_capable_10G_value = data_low and capable_10G_mask
        end If

    End Sub

    Sub write
        If flag_capable_100G = &H0 or flag_capable_40G = &H0 or flag_capable_10_1G = &H0 or flag_capable_10M = &H0 or flag_capable_100M = &H0 or flag_capable_1000M = &H0 or flag_capable_10PASS_TS = &H0 or flag_capable_2BASE_TL = &H0 or flag_capable_10G = &H0 Then read
        If flag_capable_100G = &H0 Then write_capable_100G_value = get_capable_100G
        If flag_capable_40G = &H0 Then write_capable_40G_value = get_capable_40G
        If flag_capable_10_1G = &H0 Then write_capable_10_1G_value = get_capable_10_1G
        If flag_capable_10M = &H0 Then write_capable_10M_value = get_capable_10M
        If flag_capable_100M = &H0 Then write_capable_100M_value = get_capable_100M
        If flag_capable_1000M = &H0 Then write_capable_1000M_value = get_capable_1000M
        If flag_capable_10PASS_TS = &H0 Then write_capable_10PASS_TS_value = get_capable_10PASS_TS
        If flag_capable_2BASE_TL = &H0 Then write_capable_2BASE_TL_value = get_capable_2BASE_TL
        If flag_capable_10G = &H0 Then write_capable_10G_value = get_capable_10G

        regValue = leftShift((write_capable_100G_value and &H1), 9) + leftShift((write_capable_40G_value and &H1), 8) + leftShift((write_capable_10_1G_value and &H1), 7) + leftShift((write_capable_10M_value and &H1), 6) + leftShift((write_capable_100M_value and &H1), 5) + leftShift((write_capable_1000M_value and &H1), 4) + leftShift((write_capable_10PASS_TS_value and &H1), 2) + leftShift((write_capable_2BASE_TL_value and &H1), 1) + leftShift((write_capable_10G_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_capable_100G_value = rightShift(data_low, 9) and &H1
        read_capable_40G_value = rightShift(data_low, 8) and &H1
        read_capable_10_1G_value = rightShift(data_low, 7) and &H1
        read_capable_10M_value = rightShift(data_low, 6) and &H1
        read_capable_100M_value = rightShift(data_low, 5) and &H1
        read_capable_1000M_value = rightShift(data_low, 4) and &H1
        read_capable_10PASS_TS_value = rightShift(data_low, 2) and &H1
        read_capable_2BASE_TL_value = rightShift(data_low, 1) and &H1
        capable_10G_mask = &H1
        if data_low > LONG_MAX then
            if capable_10G_mask = mask then
                read_capable_10G_value = data_low
            else
                read_capable_10G_value = (data_low - H8000_0000) and capable_10G_mask
            end If
        else
            read_capable_10G_value = data_low and capable_10G_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_capable_100G_value = &H0
        flag_capable_100G        = &H0
        write_capable_40G_value = &H0
        flag_capable_40G        = &H0
        write_capable_10_1G_value = &H0
        flag_capable_10_1G        = &H0
        write_capable_10M_value = &H0
        flag_capable_10M        = &H0
        write_capable_100M_value = &H0
        flag_capable_100M        = &H0
        write_capable_1000M_value = &H0
        flag_capable_1000M        = &H0
        write_capable_10PASS_TS_value = &H0
        flag_capable_10PASS_TS        = &H0
        write_capable_2BASE_TL_value = &H0
        flag_capable_2BASE_TL        = &H0
        write_capable_10G_value = &H0
        flag_capable_10G        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_device_in_package_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Separated_PMA_4_present                    [11:11]          get_Separated_PMA_4_present
''                                                             set_Separated_PMA_4_present
''                                                             read_Separated_PMA_4_present
''                                                             write_Separated_PMA_4_present
''---------------------------------------------------------------------------------
'' SPP3P                                      [10:10]          get_SPP3P
''                                                             set_SPP3P
''                                                             read_SPP3P
''                                                             write_SPP3P
''---------------------------------------------------------------------------------
'' Separated_PMA_2_present                    [9:9]            get_Separated_PMA_2_present
''                                                             set_Separated_PMA_2_present
''                                                             read_Separated_PMA_2_present
''                                                             write_Separated_PMA_2_present
''---------------------------------------------------------------------------------
'' Separated_PMA_1_present                    [8:8]            get_Separated_PMA_1_present
''                                                             set_Separated_PMA_1_present
''                                                             read_Separated_PMA_1_present
''                                                             write_Separated_PMA_1_present
''---------------------------------------------------------------------------------
'' Auto_Negotiation_present                   [7:7]            get_Auto_Negotiation_present
''                                                             set_Auto_Negotiation_present
''                                                             read_Auto_Negotiation_present
''                                                             write_Auto_Negotiation_present
''---------------------------------------------------------------------------------
'' TC_present                                 [6:6]            get_TC_present
''                                                             set_TC_present
''                                                             read_TC_present
''                                                             write_TC_present
''---------------------------------------------------------------------------------
'' DTE_XS_present                             [5:5]            get_DTE_XS_present
''                                                             set_DTE_XS_present
''                                                             read_DTE_XS_present
''                                                             write_DTE_XS_present
''---------------------------------------------------------------------------------
'' PHY_XS_present                             [4:4]            get_PHY_XS_present
''                                                             set_PHY_XS_present
''                                                             read_PHY_XS_present
''                                                             write_PHY_XS_present
''---------------------------------------------------------------------------------
'' PCS_present                                [3:3]            get_PCS_present
''                                                             set_PCS_present
''                                                             read_PCS_present
''                                                             write_PCS_present
''---------------------------------------------------------------------------------
'' WIS_present                                [2:2]            get_WIS_present
''                                                             set_WIS_present
''                                                             read_WIS_present
''                                                             write_WIS_present
''---------------------------------------------------------------------------------
'' PMD_PMA_present                            [1:1]            get_PMD_PMA_present
''                                                             set_PMD_PMA_present
''                                                             read_PMD_PMA_present
''                                                             write_PMD_PMA_present
''---------------------------------------------------------------------------------
'' Clause_22_registers_present                [0:0]            get_Clause_22_registers_present
''                                                             set_Clause_22_registers_present
''                                                             read_Clause_22_registers_present
''                                                             write_Clause_22_registers_present
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_device_in_package_reg0
    Private write_Separated_PMA_4_present_value
    Private read_Separated_PMA_4_present_value
    Private flag_Separated_PMA_4_present
    Private write_SPP3P_value
    Private read_SPP3P_value
    Private flag_SPP3P
    Private write_Separated_PMA_2_present_value
    Private read_Separated_PMA_2_present_value
    Private flag_Separated_PMA_2_present
    Private write_Separated_PMA_1_present_value
    Private read_Separated_PMA_1_present_value
    Private flag_Separated_PMA_1_present
    Private write_Auto_Negotiation_present_value
    Private read_Auto_Negotiation_present_value
    Private flag_Auto_Negotiation_present
    Private write_TC_present_value
    Private read_TC_present_value
    Private flag_TC_present
    Private write_DTE_XS_present_value
    Private read_DTE_XS_present_value
    Private flag_DTE_XS_present
    Private write_PHY_XS_present_value
    Private read_PHY_XS_present_value
    Private flag_PHY_XS_present
    Private write_PCS_present_value
    Private read_PCS_present_value
    Private flag_PCS_present
    Private write_WIS_present_value
    Private read_WIS_present_value
    Private flag_WIS_present
    Private write_PMD_PMA_present_value
    Private read_PMD_PMA_present_value
    Private flag_PMD_PMA_present
    Private write_Clause_22_registers_present_value
    Private read_Clause_22_registers_present_value
    Private flag_Clause_22_registers_present

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

    Property Get get_Separated_PMA_4_present
        get_Separated_PMA_4_present = read_Separated_PMA_4_present_value
    End Property

    Property Let set_Separated_PMA_4_present(aData)
        write_Separated_PMA_4_present_value = aData
        flag_Separated_PMA_4_present        = &H1
    End Property

    Property Get read_Separated_PMA_4_present
        read
        read_Separated_PMA_4_present = read_Separated_PMA_4_present_value
    End Property

    Property Let write_Separated_PMA_4_present(aData)
        set_Separated_PMA_4_present = aData
        write
    End Property

    Property Get get_SPP3P
        get_SPP3P = read_SPP3P_value
    End Property

    Property Let set_SPP3P(aData)
        write_SPP3P_value = aData
        flag_SPP3P        = &H1
    End Property

    Property Get read_SPP3P
        read
        read_SPP3P = read_SPP3P_value
    End Property

    Property Let write_SPP3P(aData)
        set_SPP3P = aData
        write
    End Property

    Property Get get_Separated_PMA_2_present
        get_Separated_PMA_2_present = read_Separated_PMA_2_present_value
    End Property

    Property Let set_Separated_PMA_2_present(aData)
        write_Separated_PMA_2_present_value = aData
        flag_Separated_PMA_2_present        = &H1
    End Property

    Property Get read_Separated_PMA_2_present
        read
        read_Separated_PMA_2_present = read_Separated_PMA_2_present_value
    End Property

    Property Let write_Separated_PMA_2_present(aData)
        set_Separated_PMA_2_present = aData
        write
    End Property

    Property Get get_Separated_PMA_1_present
        get_Separated_PMA_1_present = read_Separated_PMA_1_present_value
    End Property

    Property Let set_Separated_PMA_1_present(aData)
        write_Separated_PMA_1_present_value = aData
        flag_Separated_PMA_1_present        = &H1
    End Property

    Property Get read_Separated_PMA_1_present
        read
        read_Separated_PMA_1_present = read_Separated_PMA_1_present_value
    End Property

    Property Let write_Separated_PMA_1_present(aData)
        set_Separated_PMA_1_present = aData
        write
    End Property

    Property Get get_Auto_Negotiation_present
        get_Auto_Negotiation_present = read_Auto_Negotiation_present_value
    End Property

    Property Let set_Auto_Negotiation_present(aData)
        write_Auto_Negotiation_present_value = aData
        flag_Auto_Negotiation_present        = &H1
    End Property

    Property Get read_Auto_Negotiation_present
        read
        read_Auto_Negotiation_present = read_Auto_Negotiation_present_value
    End Property

    Property Let write_Auto_Negotiation_present(aData)
        set_Auto_Negotiation_present = aData
        write
    End Property

    Property Get get_TC_present
        get_TC_present = read_TC_present_value
    End Property

    Property Let set_TC_present(aData)
        write_TC_present_value = aData
        flag_TC_present        = &H1
    End Property

    Property Get read_TC_present
        read
        read_TC_present = read_TC_present_value
    End Property

    Property Let write_TC_present(aData)
        set_TC_present = aData
        write
    End Property

    Property Get get_DTE_XS_present
        get_DTE_XS_present = read_DTE_XS_present_value
    End Property

    Property Let set_DTE_XS_present(aData)
        write_DTE_XS_present_value = aData
        flag_DTE_XS_present        = &H1
    End Property

    Property Get read_DTE_XS_present
        read
        read_DTE_XS_present = read_DTE_XS_present_value
    End Property

    Property Let write_DTE_XS_present(aData)
        set_DTE_XS_present = aData
        write
    End Property

    Property Get get_PHY_XS_present
        get_PHY_XS_present = read_PHY_XS_present_value
    End Property

    Property Let set_PHY_XS_present(aData)
        write_PHY_XS_present_value = aData
        flag_PHY_XS_present        = &H1
    End Property

    Property Get read_PHY_XS_present
        read
        read_PHY_XS_present = read_PHY_XS_present_value
    End Property

    Property Let write_PHY_XS_present(aData)
        set_PHY_XS_present = aData
        write
    End Property

    Property Get get_PCS_present
        get_PCS_present = read_PCS_present_value
    End Property

    Property Let set_PCS_present(aData)
        write_PCS_present_value = aData
        flag_PCS_present        = &H1
    End Property

    Property Get read_PCS_present
        read
        read_PCS_present = read_PCS_present_value
    End Property

    Property Let write_PCS_present(aData)
        set_PCS_present = aData
        write
    End Property

    Property Get get_WIS_present
        get_WIS_present = read_WIS_present_value
    End Property

    Property Let set_WIS_present(aData)
        write_WIS_present_value = aData
        flag_WIS_present        = &H1
    End Property

    Property Get read_WIS_present
        read
        read_WIS_present = read_WIS_present_value
    End Property

    Property Let write_WIS_present(aData)
        set_WIS_present = aData
        write
    End Property

    Property Get get_PMD_PMA_present
        get_PMD_PMA_present = read_PMD_PMA_present_value
    End Property

    Property Let set_PMD_PMA_present(aData)
        write_PMD_PMA_present_value = aData
        flag_PMD_PMA_present        = &H1
    End Property

    Property Get read_PMD_PMA_present
        read
        read_PMD_PMA_present = read_PMD_PMA_present_value
    End Property

    Property Let write_PMD_PMA_present(aData)
        set_PMD_PMA_present = aData
        write
    End Property

    Property Get get_Clause_22_registers_present
        get_Clause_22_registers_present = read_Clause_22_registers_present_value
    End Property

    Property Let set_Clause_22_registers_present(aData)
        write_Clause_22_registers_present_value = aData
        flag_Clause_22_registers_present        = &H1
    End Property

    Property Get read_Clause_22_registers_present
        read
        read_Clause_22_registers_present = read_Clause_22_registers_present_value
    End Property

    Property Let write_Clause_22_registers_present(aData)
        set_Clause_22_registers_present = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Separated_PMA_4_present_value = rightShift(data_low, 11) and &H1
        read_SPP3P_value = rightShift(data_low, 10) and &H1
        read_Separated_PMA_2_present_value = rightShift(data_low, 9) and &H1
        read_Separated_PMA_1_present_value = rightShift(data_low, 8) and &H1
        read_Auto_Negotiation_present_value = rightShift(data_low, 7) and &H1
        read_TC_present_value = rightShift(data_low, 6) and &H1
        read_DTE_XS_present_value = rightShift(data_low, 5) and &H1
        read_PHY_XS_present_value = rightShift(data_low, 4) and &H1
        read_PCS_present_value = rightShift(data_low, 3) and &H1
        read_WIS_present_value = rightShift(data_low, 2) and &H1
        read_PMD_PMA_present_value = rightShift(data_low, 1) and &H1
        Clause_22_registers_present_mask = &H1
        if data_low > LONG_MAX then
            if Clause_22_registers_present_mask = mask then
                read_Clause_22_registers_present_value = data_low
            else
                read_Clause_22_registers_present_value = (data_low - H8000_0000) and Clause_22_registers_present_mask
            end If
        else
            read_Clause_22_registers_present_value = data_low and Clause_22_registers_present_mask
        end If

    End Sub

    Sub write
        If flag_Separated_PMA_4_present = &H0 or flag_SPP3P = &H0 or flag_Separated_PMA_2_present = &H0 or flag_Separated_PMA_1_present = &H0 or flag_Auto_Negotiation_present = &H0 or flag_TC_present = &H0 or flag_DTE_XS_present = &H0 or flag_PHY_XS_present = &H0 or flag_PCS_present = &H0 or flag_WIS_present = &H0 or flag_PMD_PMA_present = &H0 or flag_Clause_22_registers_present = &H0 Then read
        If flag_Separated_PMA_4_present = &H0 Then write_Separated_PMA_4_present_value = get_Separated_PMA_4_present
        If flag_SPP3P = &H0 Then write_SPP3P_value = get_SPP3P
        If flag_Separated_PMA_2_present = &H0 Then write_Separated_PMA_2_present_value = get_Separated_PMA_2_present
        If flag_Separated_PMA_1_present = &H0 Then write_Separated_PMA_1_present_value = get_Separated_PMA_1_present
        If flag_Auto_Negotiation_present = &H0 Then write_Auto_Negotiation_present_value = get_Auto_Negotiation_present
        If flag_TC_present = &H0 Then write_TC_present_value = get_TC_present
        If flag_DTE_XS_present = &H0 Then write_DTE_XS_present_value = get_DTE_XS_present
        If flag_PHY_XS_present = &H0 Then write_PHY_XS_present_value = get_PHY_XS_present
        If flag_PCS_present = &H0 Then write_PCS_present_value = get_PCS_present
        If flag_WIS_present = &H0 Then write_WIS_present_value = get_WIS_present
        If flag_PMD_PMA_present = &H0 Then write_PMD_PMA_present_value = get_PMD_PMA_present
        If flag_Clause_22_registers_present = &H0 Then write_Clause_22_registers_present_value = get_Clause_22_registers_present

        regValue = leftShift((write_Separated_PMA_4_present_value and &H1), 11) + leftShift((write_SPP3P_value and &H1), 10) + leftShift((write_Separated_PMA_2_present_value and &H1), 9) + leftShift((write_Separated_PMA_1_present_value and &H1), 8) + leftShift((write_Auto_Negotiation_present_value and &H1), 7) + leftShift((write_TC_present_value and &H1), 6) + leftShift((write_DTE_XS_present_value and &H1), 5) + leftShift((write_PHY_XS_present_value and &H1), 4) + leftShift((write_PCS_present_value and &H1), 3) + leftShift((write_WIS_present_value and &H1), 2) + leftShift((write_PMD_PMA_present_value and &H1), 1) + leftShift((write_Clause_22_registers_present_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Separated_PMA_4_present_value = rightShift(data_low, 11) and &H1
        read_SPP3P_value = rightShift(data_low, 10) and &H1
        read_Separated_PMA_2_present_value = rightShift(data_low, 9) and &H1
        read_Separated_PMA_1_present_value = rightShift(data_low, 8) and &H1
        read_Auto_Negotiation_present_value = rightShift(data_low, 7) and &H1
        read_TC_present_value = rightShift(data_low, 6) and &H1
        read_DTE_XS_present_value = rightShift(data_low, 5) and &H1
        read_PHY_XS_present_value = rightShift(data_low, 4) and &H1
        read_PCS_present_value = rightShift(data_low, 3) and &H1
        read_WIS_present_value = rightShift(data_low, 2) and &H1
        read_PMD_PMA_present_value = rightShift(data_low, 1) and &H1
        Clause_22_registers_present_mask = &H1
        if data_low > LONG_MAX then
            if Clause_22_registers_present_mask = mask then
                read_Clause_22_registers_present_value = data_low
            else
                read_Clause_22_registers_present_value = (data_low - H8000_0000) and Clause_22_registers_present_mask
            end If
        else
            read_Clause_22_registers_present_value = data_low and Clause_22_registers_present_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Separated_PMA_4_present_value = &H0
        flag_Separated_PMA_4_present        = &H0
        write_SPP3P_value = &H0
        flag_SPP3P        = &H0
        write_Separated_PMA_2_present_value = &H0
        flag_Separated_PMA_2_present        = &H0
        write_Separated_PMA_1_present_value = &H0
        flag_Separated_PMA_1_present        = &H0
        write_Auto_Negotiation_present_value = &H0
        flag_Auto_Negotiation_present        = &H0
        write_TC_present_value = &H0
        flag_TC_present        = &H0
        write_DTE_XS_present_value = &H0
        flag_DTE_XS_present        = &H0
        write_PHY_XS_present_value = &H0
        flag_PHY_XS_present        = &H0
        write_PCS_present_value = &H0
        flag_PCS_present        = &H0
        write_WIS_present_value = &H0
        flag_WIS_present        = &H0
        write_PMD_PMA_present_value = &H0
        flag_PMD_PMA_present        = &H0
        write_Clause_22_registers_present_value = &H0
        flag_Clause_22_registers_present        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_device_in_package_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VSD2P                                      [15:15]          get_VSD2P
''                                                             set_VSD2P
''                                                             read_VSD2P
''                                                             write_VSD2P
''---------------------------------------------------------------------------------
'' VSD1P                                      [14:14]          get_VSD1P
''                                                             set_VSD1P
''                                                             read_VSD1P
''                                                             write_VSD1P
''---------------------------------------------------------------------------------
'' Clause_22_extension_present                [13:13]          get_Clause_22_extension_present
''                                                             set_Clause_22_extension_present
''                                                             read_Clause_22_extension_present
''                                                             write_Clause_22_extension_present
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_device_in_package_reg1
    Private write_VSD2P_value
    Private read_VSD2P_value
    Private flag_VSD2P
    Private write_VSD1P_value
    Private read_VSD1P_value
    Private flag_VSD1P
    Private write_Clause_22_extension_present_value
    Private read_Clause_22_extension_present_value
    Private flag_Clause_22_extension_present

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

    Property Get get_VSD2P
        get_VSD2P = read_VSD2P_value
    End Property

    Property Let set_VSD2P(aData)
        write_VSD2P_value = aData
        flag_VSD2P        = &H1
    End Property

    Property Get read_VSD2P
        read
        read_VSD2P = read_VSD2P_value
    End Property

    Property Let write_VSD2P(aData)
        set_VSD2P = aData
        write
    End Property

    Property Get get_VSD1P
        get_VSD1P = read_VSD1P_value
    End Property

    Property Let set_VSD1P(aData)
        write_VSD1P_value = aData
        flag_VSD1P        = &H1
    End Property

    Property Get read_VSD1P
        read
        read_VSD1P = read_VSD1P_value
    End Property

    Property Let write_VSD1P(aData)
        set_VSD1P = aData
        write
    End Property

    Property Get get_Clause_22_extension_present
        get_Clause_22_extension_present = read_Clause_22_extension_present_value
    End Property

    Property Let set_Clause_22_extension_present(aData)
        write_Clause_22_extension_present_value = aData
        flag_Clause_22_extension_present        = &H1
    End Property

    Property Get read_Clause_22_extension_present
        read
        read_Clause_22_extension_present = read_Clause_22_extension_present_value
    End Property

    Property Let write_Clause_22_extension_present(aData)
        set_Clause_22_extension_present = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VSD2P_value = rightShift(data_low, 15) and &H1
        read_VSD1P_value = rightShift(data_low, 14) and &H1
        read_Clause_22_extension_present_value = rightShift(data_low, 13) and &H1

    End Sub

    Sub write
        If flag_VSD2P = &H0 or flag_VSD1P = &H0 or flag_Clause_22_extension_present = &H0 Then read
        If flag_VSD2P = &H0 Then write_VSD2P_value = get_VSD2P
        If flag_VSD1P = &H0 Then write_VSD1P_value = get_VSD1P
        If flag_Clause_22_extension_present = &H0 Then write_Clause_22_extension_present_value = get_Clause_22_extension_present

        regValue = leftShift((write_VSD2P_value and &H1), 15) + leftShift((write_VSD1P_value and &H1), 14) + leftShift((write_Clause_22_extension_present_value and &H1), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VSD2P_value = rightShift(data_low, 15) and &H1
        read_VSD1P_value = rightShift(data_low, 14) and &H1
        read_Clause_22_extension_present_value = rightShift(data_low, 13) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VSD2P_value = &H0
        flag_VSD2P        = &H0
        write_VSD1P_value = &H0
        flag_VSD1P        = &H0
        write_Clause_22_extension_present_value = &H0
        flag_Clause_22_extension_present        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_control_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PIASE                                      [9:9]            get_PIASE
''                                                             set_PIASE
''                                                             read_PIASE
''                                                             write_PIASE
''---------------------------------------------------------------------------------
'' PEASE                                      [8:8]            get_PEASE
''                                                             set_PEASE
''                                                             read_PEASE
''                                                             write_PEASE
''---------------------------------------------------------------------------------
'' PMA_PMD_type_selection                     [5:0]            get_PMA_PMD_type_selection
''                                                             set_PMA_PMD_type_selection
''                                                             read_PMA_PMD_type_selection
''                                                             write_PMA_PMD_type_selection
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_control_reg2
    Private write_PIASE_value
    Private read_PIASE_value
    Private flag_PIASE
    Private write_PEASE_value
    Private read_PEASE_value
    Private flag_PEASE
    Private write_PMA_PMD_type_selection_value
    Private read_PMA_PMD_type_selection_value
    Private flag_PMA_PMD_type_selection

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

    Property Get get_PIASE
        get_PIASE = read_PIASE_value
    End Property

    Property Let set_PIASE(aData)
        write_PIASE_value = aData
        flag_PIASE        = &H1
    End Property

    Property Get read_PIASE
        read
        read_PIASE = read_PIASE_value
    End Property

    Property Let write_PIASE(aData)
        set_PIASE = aData
        write
    End Property

    Property Get get_PEASE
        get_PEASE = read_PEASE_value
    End Property

    Property Let set_PEASE(aData)
        write_PEASE_value = aData
        flag_PEASE        = &H1
    End Property

    Property Get read_PEASE
        read
        read_PEASE = read_PEASE_value
    End Property

    Property Let write_PEASE(aData)
        set_PEASE = aData
        write
    End Property

    Property Get get_PMA_PMD_type_selection
        get_PMA_PMD_type_selection = read_PMA_PMD_type_selection_value
    End Property

    Property Let set_PMA_PMD_type_selection(aData)
        write_PMA_PMD_type_selection_value = aData
        flag_PMA_PMD_type_selection        = &H1
    End Property

    Property Get read_PMA_PMD_type_selection
        read
        read_PMA_PMD_type_selection = read_PMA_PMD_type_selection_value
    End Property

    Property Let write_PMA_PMD_type_selection(aData)
        set_PMA_PMD_type_selection = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PIASE_value = rightShift(data_low, 9) and &H1
        read_PEASE_value = rightShift(data_low, 8) and &H1
        PMA_PMD_type_selection_mask = &H3f
        if data_low > LONG_MAX then
            if PMA_PMD_type_selection_mask = mask then
                read_PMA_PMD_type_selection_value = data_low
            else
                read_PMA_PMD_type_selection_value = (data_low - H8000_0000) and PMA_PMD_type_selection_mask
            end If
        else
            read_PMA_PMD_type_selection_value = data_low and PMA_PMD_type_selection_mask
        end If

    End Sub

    Sub write
        If flag_PIASE = &H0 or flag_PEASE = &H0 or flag_PMA_PMD_type_selection = &H0 Then read
        If flag_PIASE = &H0 Then write_PIASE_value = get_PIASE
        If flag_PEASE = &H0 Then write_PEASE_value = get_PEASE
        If flag_PMA_PMD_type_selection = &H0 Then write_PMA_PMD_type_selection_value = get_PMA_PMD_type_selection

        regValue = leftShift((write_PIASE_value and &H1), 9) + leftShift((write_PEASE_value and &H1), 8) + leftShift((write_PMA_PMD_type_selection_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PIASE_value = rightShift(data_low, 9) and &H1
        read_PEASE_value = rightShift(data_low, 8) and &H1
        PMA_PMD_type_selection_mask = &H3f
        if data_low > LONG_MAX then
            if PMA_PMD_type_selection_mask = mask then
                read_PMA_PMD_type_selection_value = data_low
            else
                read_PMA_PMD_type_selection_value = (data_low - H8000_0000) and PMA_PMD_type_selection_mask
            end If
        else
            read_PMA_PMD_type_selection_value = data_low and PMA_PMD_type_selection_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PIASE_value = &H0
        flag_PIASE        = &H0
        write_PEASE_value = &H0
        flag_PEASE        = &H0
        write_PMA_PMD_type_selection_value = &H0
        flag_PMA_PMD_type_selection        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_status_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Device_present                             [15:14]          get_Device_present
''                                                             set_Device_present
''                                                             read_Device_present
''                                                             write_Device_present
''---------------------------------------------------------------------------------
'' Transmit_fault_ability                     [13:13]          get_Transmit_fault_ability
''                                                             set_Transmit_fault_ability
''                                                             read_Transmit_fault_ability
''                                                             write_Transmit_fault_ability
''---------------------------------------------------------------------------------
'' Receive_fault_ability                      [12:12]          get_Receive_fault_ability
''                                                             set_Receive_fault_ability
''                                                             read_Receive_fault_ability
''                                                             write_Receive_fault_ability
''---------------------------------------------------------------------------------
'' Transmi_fault                              [11:11]          get_Transmi_fault
''                                                             set_Transmi_fault
''                                                             read_Transmi_fault
''                                                             write_Transmi_fault
''---------------------------------------------------------------------------------
'' Receive_fault                              [10:10]          get_Receive_fault
''                                                             set_Receive_fault
''                                                             read_Receive_fault
''                                                             write_Receive_fault
''---------------------------------------------------------------------------------
'' Extended_abilities                         [9:9]            get_Extended_abilities
''                                                             set_Extended_abilities
''                                                             read_Extended_abilities
''                                                             write_Extended_abilities
''---------------------------------------------------------------------------------
'' PTDA                                       [8:8]            get_PTDA
''                                                             set_PTDA
''                                                             read_PTDA
''                                                             write_PTDA
''---------------------------------------------------------------------------------
'' ability_10GBASE_SR                         [7:7]            get_ability_10GBASE_SR
''                                                             set_ability_10GBASE_SR
''                                                             read_ability_10GBASE_SR
''                                                             write_ability_10GBASE_SR
''---------------------------------------------------------------------------------
'' ability_10GBASE_LR                         [6:6]            get_ability_10GBASE_LR
''                                                             set_ability_10GBASE_LR
''                                                             read_ability_10GBASE_LR
''                                                             write_ability_10GBASE_LR
''---------------------------------------------------------------------------------
'' ability_10GBASE_ER                         [5:5]            get_ability_10GBASE_ER
''                                                             set_ability_10GBASE_ER
''                                                             read_ability_10GBASE_ER
''                                                             write_ability_10GBASE_ER
''---------------------------------------------------------------------------------
'' ability_10GBASE_LX4                        [4:4]            get_ability_10GBASE_LX4
''                                                             set_ability_10GBASE_LX4
''                                                             read_ability_10GBASE_LX4
''                                                             write_ability_10GBASE_LX4
''---------------------------------------------------------------------------------
'' ability_10GBASE_SW                         [3:3]            get_ability_10GBASE_SW
''                                                             set_ability_10GBASE_SW
''                                                             read_ability_10GBASE_SW
''                                                             write_ability_10GBASE_SW
''---------------------------------------------------------------------------------
'' ability_10GBASE_LW                         [2:2]            get_ability_10GBASE_LW
''                                                             set_ability_10GBASE_LW
''                                                             read_ability_10GBASE_LW
''                                                             write_ability_10GBASE_LW
''---------------------------------------------------------------------------------
'' ability_10GBASE_EW                         [1:1]            get_ability_10GBASE_EW
''                                                             set_ability_10GBASE_EW
''                                                             read_ability_10GBASE_EW
''                                                             write_ability_10GBASE_EW
''---------------------------------------------------------------------------------
'' PLLA                                       [0:0]            get_PLLA
''                                                             set_PLLA
''                                                             read_PLLA
''                                                             write_PLLA
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_status_reg2
    Private write_Device_present_value
    Private read_Device_present_value
    Private flag_Device_present
    Private write_Transmit_fault_ability_value
    Private read_Transmit_fault_ability_value
    Private flag_Transmit_fault_ability
    Private write_Receive_fault_ability_value
    Private read_Receive_fault_ability_value
    Private flag_Receive_fault_ability
    Private write_Transmi_fault_value
    Private read_Transmi_fault_value
    Private flag_Transmi_fault
    Private write_Receive_fault_value
    Private read_Receive_fault_value
    Private flag_Receive_fault
    Private write_Extended_abilities_value
    Private read_Extended_abilities_value
    Private flag_Extended_abilities
    Private write_PTDA_value
    Private read_PTDA_value
    Private flag_PTDA
    Private write_ability_10GBASE_SR_value
    Private read_ability_10GBASE_SR_value
    Private flag_ability_10GBASE_SR
    Private write_ability_10GBASE_LR_value
    Private read_ability_10GBASE_LR_value
    Private flag_ability_10GBASE_LR
    Private write_ability_10GBASE_ER_value
    Private read_ability_10GBASE_ER_value
    Private flag_ability_10GBASE_ER
    Private write_ability_10GBASE_LX4_value
    Private read_ability_10GBASE_LX4_value
    Private flag_ability_10GBASE_LX4
    Private write_ability_10GBASE_SW_value
    Private read_ability_10GBASE_SW_value
    Private flag_ability_10GBASE_SW
    Private write_ability_10GBASE_LW_value
    Private read_ability_10GBASE_LW_value
    Private flag_ability_10GBASE_LW
    Private write_ability_10GBASE_EW_value
    Private read_ability_10GBASE_EW_value
    Private flag_ability_10GBASE_EW
    Private write_PLLA_value
    Private read_PLLA_value
    Private flag_PLLA

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

    Property Get get_Device_present
        get_Device_present = read_Device_present_value
    End Property

    Property Let set_Device_present(aData)
        write_Device_present_value = aData
        flag_Device_present        = &H1
    End Property

    Property Get read_Device_present
        read
        read_Device_present = read_Device_present_value
    End Property

    Property Let write_Device_present(aData)
        set_Device_present = aData
        write
    End Property

    Property Get get_Transmit_fault_ability
        get_Transmit_fault_ability = read_Transmit_fault_ability_value
    End Property

    Property Let set_Transmit_fault_ability(aData)
        write_Transmit_fault_ability_value = aData
        flag_Transmit_fault_ability        = &H1
    End Property

    Property Get read_Transmit_fault_ability
        read
        read_Transmit_fault_ability = read_Transmit_fault_ability_value
    End Property

    Property Let write_Transmit_fault_ability(aData)
        set_Transmit_fault_ability = aData
        write
    End Property

    Property Get get_Receive_fault_ability
        get_Receive_fault_ability = read_Receive_fault_ability_value
    End Property

    Property Let set_Receive_fault_ability(aData)
        write_Receive_fault_ability_value = aData
        flag_Receive_fault_ability        = &H1
    End Property

    Property Get read_Receive_fault_ability
        read
        read_Receive_fault_ability = read_Receive_fault_ability_value
    End Property

    Property Let write_Receive_fault_ability(aData)
        set_Receive_fault_ability = aData
        write
    End Property

    Property Get get_Transmi_fault
        get_Transmi_fault = read_Transmi_fault_value
    End Property

    Property Let set_Transmi_fault(aData)
        write_Transmi_fault_value = aData
        flag_Transmi_fault        = &H1
    End Property

    Property Get read_Transmi_fault
        read
        read_Transmi_fault = read_Transmi_fault_value
    End Property

    Property Let write_Transmi_fault(aData)
        set_Transmi_fault = aData
        write
    End Property

    Property Get get_Receive_fault
        get_Receive_fault = read_Receive_fault_value
    End Property

    Property Let set_Receive_fault(aData)
        write_Receive_fault_value = aData
        flag_Receive_fault        = &H1
    End Property

    Property Get read_Receive_fault
        read
        read_Receive_fault = read_Receive_fault_value
    End Property

    Property Let write_Receive_fault(aData)
        set_Receive_fault = aData
        write
    End Property

    Property Get get_Extended_abilities
        get_Extended_abilities = read_Extended_abilities_value
    End Property

    Property Let set_Extended_abilities(aData)
        write_Extended_abilities_value = aData
        flag_Extended_abilities        = &H1
    End Property

    Property Get read_Extended_abilities
        read
        read_Extended_abilities = read_Extended_abilities_value
    End Property

    Property Let write_Extended_abilities(aData)
        set_Extended_abilities = aData
        write
    End Property

    Property Get get_PTDA
        get_PTDA = read_PTDA_value
    End Property

    Property Let set_PTDA(aData)
        write_PTDA_value = aData
        flag_PTDA        = &H1
    End Property

    Property Get read_PTDA
        read
        read_PTDA = read_PTDA_value
    End Property

    Property Let write_PTDA(aData)
        set_PTDA = aData
        write
    End Property

    Property Get get_ability_10GBASE_SR
        get_ability_10GBASE_SR = read_ability_10GBASE_SR_value
    End Property

    Property Let set_ability_10GBASE_SR(aData)
        write_ability_10GBASE_SR_value = aData
        flag_ability_10GBASE_SR        = &H1
    End Property

    Property Get read_ability_10GBASE_SR
        read
        read_ability_10GBASE_SR = read_ability_10GBASE_SR_value
    End Property

    Property Let write_ability_10GBASE_SR(aData)
        set_ability_10GBASE_SR = aData
        write
    End Property

    Property Get get_ability_10GBASE_LR
        get_ability_10GBASE_LR = read_ability_10GBASE_LR_value
    End Property

    Property Let set_ability_10GBASE_LR(aData)
        write_ability_10GBASE_LR_value = aData
        flag_ability_10GBASE_LR        = &H1
    End Property

    Property Get read_ability_10GBASE_LR
        read
        read_ability_10GBASE_LR = read_ability_10GBASE_LR_value
    End Property

    Property Let write_ability_10GBASE_LR(aData)
        set_ability_10GBASE_LR = aData
        write
    End Property

    Property Get get_ability_10GBASE_ER
        get_ability_10GBASE_ER = read_ability_10GBASE_ER_value
    End Property

    Property Let set_ability_10GBASE_ER(aData)
        write_ability_10GBASE_ER_value = aData
        flag_ability_10GBASE_ER        = &H1
    End Property

    Property Get read_ability_10GBASE_ER
        read
        read_ability_10GBASE_ER = read_ability_10GBASE_ER_value
    End Property

    Property Let write_ability_10GBASE_ER(aData)
        set_ability_10GBASE_ER = aData
        write
    End Property

    Property Get get_ability_10GBASE_LX4
        get_ability_10GBASE_LX4 = read_ability_10GBASE_LX4_value
    End Property

    Property Let set_ability_10GBASE_LX4(aData)
        write_ability_10GBASE_LX4_value = aData
        flag_ability_10GBASE_LX4        = &H1
    End Property

    Property Get read_ability_10GBASE_LX4
        read
        read_ability_10GBASE_LX4 = read_ability_10GBASE_LX4_value
    End Property

    Property Let write_ability_10GBASE_LX4(aData)
        set_ability_10GBASE_LX4 = aData
        write
    End Property

    Property Get get_ability_10GBASE_SW
        get_ability_10GBASE_SW = read_ability_10GBASE_SW_value
    End Property

    Property Let set_ability_10GBASE_SW(aData)
        write_ability_10GBASE_SW_value = aData
        flag_ability_10GBASE_SW        = &H1
    End Property

    Property Get read_ability_10GBASE_SW
        read
        read_ability_10GBASE_SW = read_ability_10GBASE_SW_value
    End Property

    Property Let write_ability_10GBASE_SW(aData)
        set_ability_10GBASE_SW = aData
        write
    End Property

    Property Get get_ability_10GBASE_LW
        get_ability_10GBASE_LW = read_ability_10GBASE_LW_value
    End Property

    Property Let set_ability_10GBASE_LW(aData)
        write_ability_10GBASE_LW_value = aData
        flag_ability_10GBASE_LW        = &H1
    End Property

    Property Get read_ability_10GBASE_LW
        read
        read_ability_10GBASE_LW = read_ability_10GBASE_LW_value
    End Property

    Property Let write_ability_10GBASE_LW(aData)
        set_ability_10GBASE_LW = aData
        write
    End Property

    Property Get get_ability_10GBASE_EW
        get_ability_10GBASE_EW = read_ability_10GBASE_EW_value
    End Property

    Property Let set_ability_10GBASE_EW(aData)
        write_ability_10GBASE_EW_value = aData
        flag_ability_10GBASE_EW        = &H1
    End Property

    Property Get read_ability_10GBASE_EW
        read
        read_ability_10GBASE_EW = read_ability_10GBASE_EW_value
    End Property

    Property Let write_ability_10GBASE_EW(aData)
        set_ability_10GBASE_EW = aData
        write
    End Property

    Property Get get_PLLA
        get_PLLA = read_PLLA_value
    End Property

    Property Let set_PLLA(aData)
        write_PLLA_value = aData
        flag_PLLA        = &H1
    End Property

    Property Get read_PLLA
        read
        read_PLLA = read_PLLA_value
    End Property

    Property Let write_PLLA(aData)
        set_PLLA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Device_present_value = rightShift(data_low, 14) and &H3
        read_Transmit_fault_ability_value = rightShift(data_low, 13) and &H1
        read_Receive_fault_ability_value = rightShift(data_low, 12) and &H1
        read_Transmi_fault_value = rightShift(data_low, 11) and &H1
        read_Receive_fault_value = rightShift(data_low, 10) and &H1
        read_Extended_abilities_value = rightShift(data_low, 9) and &H1
        read_PTDA_value = rightShift(data_low, 8) and &H1
        read_ability_10GBASE_SR_value = rightShift(data_low, 7) and &H1
        read_ability_10GBASE_LR_value = rightShift(data_low, 6) and &H1
        read_ability_10GBASE_ER_value = rightShift(data_low, 5) and &H1
        read_ability_10GBASE_LX4_value = rightShift(data_low, 4) and &H1
        read_ability_10GBASE_SW_value = rightShift(data_low, 3) and &H1
        read_ability_10GBASE_LW_value = rightShift(data_low, 2) and &H1
        read_ability_10GBASE_EW_value = rightShift(data_low, 1) and &H1
        PLLA_mask = &H1
        if data_low > LONG_MAX then
            if PLLA_mask = mask then
                read_PLLA_value = data_low
            else
                read_PLLA_value = (data_low - H8000_0000) and PLLA_mask
            end If
        else
            read_PLLA_value = data_low and PLLA_mask
        end If

    End Sub

    Sub write
        If flag_Device_present = &H0 or flag_Transmit_fault_ability = &H0 or flag_Receive_fault_ability = &H0 or flag_Transmi_fault = &H0 or flag_Receive_fault = &H0 or flag_Extended_abilities = &H0 or flag_PTDA = &H0 or flag_ability_10GBASE_SR = &H0 or flag_ability_10GBASE_LR = &H0 or flag_ability_10GBASE_ER = &H0 or flag_ability_10GBASE_LX4 = &H0 or flag_ability_10GBASE_SW = &H0 or flag_ability_10GBASE_LW = &H0 or flag_ability_10GBASE_EW = &H0 or flag_PLLA = &H0 Then read
        If flag_Device_present = &H0 Then write_Device_present_value = get_Device_present
        If flag_Transmit_fault_ability = &H0 Then write_Transmit_fault_ability_value = get_Transmit_fault_ability
        If flag_Receive_fault_ability = &H0 Then write_Receive_fault_ability_value = get_Receive_fault_ability
        If flag_Transmi_fault = &H0 Then write_Transmi_fault_value = get_Transmi_fault
        If flag_Receive_fault = &H0 Then write_Receive_fault_value = get_Receive_fault
        If flag_Extended_abilities = &H0 Then write_Extended_abilities_value = get_Extended_abilities
        If flag_PTDA = &H0 Then write_PTDA_value = get_PTDA
        If flag_ability_10GBASE_SR = &H0 Then write_ability_10GBASE_SR_value = get_ability_10GBASE_SR
        If flag_ability_10GBASE_LR = &H0 Then write_ability_10GBASE_LR_value = get_ability_10GBASE_LR
        If flag_ability_10GBASE_ER = &H0 Then write_ability_10GBASE_ER_value = get_ability_10GBASE_ER
        If flag_ability_10GBASE_LX4 = &H0 Then write_ability_10GBASE_LX4_value = get_ability_10GBASE_LX4
        If flag_ability_10GBASE_SW = &H0 Then write_ability_10GBASE_SW_value = get_ability_10GBASE_SW
        If flag_ability_10GBASE_LW = &H0 Then write_ability_10GBASE_LW_value = get_ability_10GBASE_LW
        If flag_ability_10GBASE_EW = &H0 Then write_ability_10GBASE_EW_value = get_ability_10GBASE_EW
        If flag_PLLA = &H0 Then write_PLLA_value = get_PLLA

        regValue = leftShift((write_Device_present_value and &H3), 14) + leftShift((write_Transmit_fault_ability_value and &H1), 13) + leftShift((write_Receive_fault_ability_value and &H1), 12) + leftShift((write_Transmi_fault_value and &H1), 11) + leftShift((write_Receive_fault_value and &H1), 10) + leftShift((write_Extended_abilities_value and &H1), 9) + leftShift((write_PTDA_value and &H1), 8) + leftShift((write_ability_10GBASE_SR_value and &H1), 7) + leftShift((write_ability_10GBASE_LR_value and &H1), 6) + leftShift((write_ability_10GBASE_ER_value and &H1), 5) + leftShift((write_ability_10GBASE_LX4_value and &H1), 4) + leftShift((write_ability_10GBASE_SW_value and &H1), 3) + leftShift((write_ability_10GBASE_LW_value and &H1), 2) + leftShift((write_ability_10GBASE_EW_value and &H1), 1) + leftShift((write_PLLA_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Device_present_value = rightShift(data_low, 14) and &H3
        read_Transmit_fault_ability_value = rightShift(data_low, 13) and &H1
        read_Receive_fault_ability_value = rightShift(data_low, 12) and &H1
        read_Transmi_fault_value = rightShift(data_low, 11) and &H1
        read_Receive_fault_value = rightShift(data_low, 10) and &H1
        read_Extended_abilities_value = rightShift(data_low, 9) and &H1
        read_PTDA_value = rightShift(data_low, 8) and &H1
        read_ability_10GBASE_SR_value = rightShift(data_low, 7) and &H1
        read_ability_10GBASE_LR_value = rightShift(data_low, 6) and &H1
        read_ability_10GBASE_ER_value = rightShift(data_low, 5) and &H1
        read_ability_10GBASE_LX4_value = rightShift(data_low, 4) and &H1
        read_ability_10GBASE_SW_value = rightShift(data_low, 3) and &H1
        read_ability_10GBASE_LW_value = rightShift(data_low, 2) and &H1
        read_ability_10GBASE_EW_value = rightShift(data_low, 1) and &H1
        PLLA_mask = &H1
        if data_low > LONG_MAX then
            if PLLA_mask = mask then
                read_PLLA_value = data_low
            else
                read_PLLA_value = (data_low - H8000_0000) and PLLA_mask
            end If
        else
            read_PLLA_value = data_low and PLLA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Device_present_value = &H0
        flag_Device_present        = &H0
        write_Transmit_fault_ability_value = &H0
        flag_Transmit_fault_ability        = &H0
        write_Receive_fault_ability_value = &H0
        flag_Receive_fault_ability        = &H0
        write_Transmi_fault_value = &H0
        flag_Transmi_fault        = &H0
        write_Receive_fault_value = &H0
        flag_Receive_fault        = &H0
        write_Extended_abilities_value = &H0
        flag_Extended_abilities        = &H0
        write_PTDA_value = &H0
        flag_PTDA        = &H0
        write_ability_10GBASE_SR_value = &H0
        flag_ability_10GBASE_SR        = &H0
        write_ability_10GBASE_LR_value = &H0
        flag_ability_10GBASE_LR        = &H0
        write_ability_10GBASE_ER_value = &H0
        flag_ability_10GBASE_ER        = &H0
        write_ability_10GBASE_LX4_value = &H0
        flag_ability_10GBASE_LX4        = &H0
        write_ability_10GBASE_SW_value = &H0
        flag_ability_10GBASE_SW        = &H0
        write_ability_10GBASE_LW_value = &H0
        flag_ability_10GBASE_LW        = &H0
        write_ability_10GBASE_EW_value = &H0
        flag_ability_10GBASE_EW        = &H0
        write_PLLA_value = &H0
        flag_PLLA        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_transmit_disable_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_9                     [10:10]          get_PMD_transmit_disable_9
''                                                             set_PMD_transmit_disable_9
''                                                             read_PMD_transmit_disable_9
''                                                             write_PMD_transmit_disable_9
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_8                     [9:9]            get_PMD_transmit_disable_8
''                                                             set_PMD_transmit_disable_8
''                                                             read_PMD_transmit_disable_8
''                                                             write_PMD_transmit_disable_8
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_7                     [8:8]            get_PMD_transmit_disable_7
''                                                             set_PMD_transmit_disable_7
''                                                             read_PMD_transmit_disable_7
''                                                             write_PMD_transmit_disable_7
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_6                     [7:7]            get_PMD_transmit_disable_6
''                                                             set_PMD_transmit_disable_6
''                                                             read_PMD_transmit_disable_6
''                                                             write_PMD_transmit_disable_6
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_5                     [6:6]            get_PMD_transmit_disable_5
''                                                             set_PMD_transmit_disable_5
''                                                             read_PMD_transmit_disable_5
''                                                             write_PMD_transmit_disable_5
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_4                     [5:5]            get_PMD_transmit_disable_4
''                                                             set_PMD_transmit_disable_4
''                                                             read_PMD_transmit_disable_4
''                                                             write_PMD_transmit_disable_4
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_3                     [4:4]            get_PMD_transmit_disable_3
''                                                             set_PMD_transmit_disable_3
''                                                             read_PMD_transmit_disable_3
''                                                             write_PMD_transmit_disable_3
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_2                     [3:3]            get_PMD_transmit_disable_2
''                                                             set_PMD_transmit_disable_2
''                                                             read_PMD_transmit_disable_2
''                                                             write_PMD_transmit_disable_2
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_1                     [2:2]            get_PMD_transmit_disable_1
''                                                             set_PMD_transmit_disable_1
''                                                             read_PMD_transmit_disable_1
''                                                             write_PMD_transmit_disable_1
''---------------------------------------------------------------------------------
'' PMD_transmit_disable_0                     [1:1]            get_PMD_transmit_disable_0
''                                                             set_PMD_transmit_disable_0
''                                                             read_PMD_transmit_disable_0
''                                                             write_PMD_transmit_disable_0
''---------------------------------------------------------------------------------
'' Global_PMD_transmit_disable                [0:0]            get_Global_PMD_transmit_disable
''                                                             set_Global_PMD_transmit_disable
''                                                             read_Global_PMD_transmit_disable
''                                                             write_Global_PMD_transmit_disable
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_transmit_disable_reg
    Private write_PMD_transmit_disable_9_value
    Private read_PMD_transmit_disable_9_value
    Private flag_PMD_transmit_disable_9
    Private write_PMD_transmit_disable_8_value
    Private read_PMD_transmit_disable_8_value
    Private flag_PMD_transmit_disable_8
    Private write_PMD_transmit_disable_7_value
    Private read_PMD_transmit_disable_7_value
    Private flag_PMD_transmit_disable_7
    Private write_PMD_transmit_disable_6_value
    Private read_PMD_transmit_disable_6_value
    Private flag_PMD_transmit_disable_6
    Private write_PMD_transmit_disable_5_value
    Private read_PMD_transmit_disable_5_value
    Private flag_PMD_transmit_disable_5
    Private write_PMD_transmit_disable_4_value
    Private read_PMD_transmit_disable_4_value
    Private flag_PMD_transmit_disable_4
    Private write_PMD_transmit_disable_3_value
    Private read_PMD_transmit_disable_3_value
    Private flag_PMD_transmit_disable_3
    Private write_PMD_transmit_disable_2_value
    Private read_PMD_transmit_disable_2_value
    Private flag_PMD_transmit_disable_2
    Private write_PMD_transmit_disable_1_value
    Private read_PMD_transmit_disable_1_value
    Private flag_PMD_transmit_disable_1
    Private write_PMD_transmit_disable_0_value
    Private read_PMD_transmit_disable_0_value
    Private flag_PMD_transmit_disable_0
    Private write_Global_PMD_transmit_disable_value
    Private read_Global_PMD_transmit_disable_value
    Private flag_Global_PMD_transmit_disable

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

    Property Get get_PMD_transmit_disable_9
        get_PMD_transmit_disable_9 = read_PMD_transmit_disable_9_value
    End Property

    Property Let set_PMD_transmit_disable_9(aData)
        write_PMD_transmit_disable_9_value = aData
        flag_PMD_transmit_disable_9        = &H1
    End Property

    Property Get read_PMD_transmit_disable_9
        read
        read_PMD_transmit_disable_9 = read_PMD_transmit_disable_9_value
    End Property

    Property Let write_PMD_transmit_disable_9(aData)
        set_PMD_transmit_disable_9 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_8
        get_PMD_transmit_disable_8 = read_PMD_transmit_disable_8_value
    End Property

    Property Let set_PMD_transmit_disable_8(aData)
        write_PMD_transmit_disable_8_value = aData
        flag_PMD_transmit_disable_8        = &H1
    End Property

    Property Get read_PMD_transmit_disable_8
        read
        read_PMD_transmit_disable_8 = read_PMD_transmit_disable_8_value
    End Property

    Property Let write_PMD_transmit_disable_8(aData)
        set_PMD_transmit_disable_8 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_7
        get_PMD_transmit_disable_7 = read_PMD_transmit_disable_7_value
    End Property

    Property Let set_PMD_transmit_disable_7(aData)
        write_PMD_transmit_disable_7_value = aData
        flag_PMD_transmit_disable_7        = &H1
    End Property

    Property Get read_PMD_transmit_disable_7
        read
        read_PMD_transmit_disable_7 = read_PMD_transmit_disable_7_value
    End Property

    Property Let write_PMD_transmit_disable_7(aData)
        set_PMD_transmit_disable_7 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_6
        get_PMD_transmit_disable_6 = read_PMD_transmit_disable_6_value
    End Property

    Property Let set_PMD_transmit_disable_6(aData)
        write_PMD_transmit_disable_6_value = aData
        flag_PMD_transmit_disable_6        = &H1
    End Property

    Property Get read_PMD_transmit_disable_6
        read
        read_PMD_transmit_disable_6 = read_PMD_transmit_disable_6_value
    End Property

    Property Let write_PMD_transmit_disable_6(aData)
        set_PMD_transmit_disable_6 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_5
        get_PMD_transmit_disable_5 = read_PMD_transmit_disable_5_value
    End Property

    Property Let set_PMD_transmit_disable_5(aData)
        write_PMD_transmit_disable_5_value = aData
        flag_PMD_transmit_disable_5        = &H1
    End Property

    Property Get read_PMD_transmit_disable_5
        read
        read_PMD_transmit_disable_5 = read_PMD_transmit_disable_5_value
    End Property

    Property Let write_PMD_transmit_disable_5(aData)
        set_PMD_transmit_disable_5 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_4
        get_PMD_transmit_disable_4 = read_PMD_transmit_disable_4_value
    End Property

    Property Let set_PMD_transmit_disable_4(aData)
        write_PMD_transmit_disable_4_value = aData
        flag_PMD_transmit_disable_4        = &H1
    End Property

    Property Get read_PMD_transmit_disable_4
        read
        read_PMD_transmit_disable_4 = read_PMD_transmit_disable_4_value
    End Property

    Property Let write_PMD_transmit_disable_4(aData)
        set_PMD_transmit_disable_4 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_3
        get_PMD_transmit_disable_3 = read_PMD_transmit_disable_3_value
    End Property

    Property Let set_PMD_transmit_disable_3(aData)
        write_PMD_transmit_disable_3_value = aData
        flag_PMD_transmit_disable_3        = &H1
    End Property

    Property Get read_PMD_transmit_disable_3
        read
        read_PMD_transmit_disable_3 = read_PMD_transmit_disable_3_value
    End Property

    Property Let write_PMD_transmit_disable_3(aData)
        set_PMD_transmit_disable_3 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_2
        get_PMD_transmit_disable_2 = read_PMD_transmit_disable_2_value
    End Property

    Property Let set_PMD_transmit_disable_2(aData)
        write_PMD_transmit_disable_2_value = aData
        flag_PMD_transmit_disable_2        = &H1
    End Property

    Property Get read_PMD_transmit_disable_2
        read
        read_PMD_transmit_disable_2 = read_PMD_transmit_disable_2_value
    End Property

    Property Let write_PMD_transmit_disable_2(aData)
        set_PMD_transmit_disable_2 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_1
        get_PMD_transmit_disable_1 = read_PMD_transmit_disable_1_value
    End Property

    Property Let set_PMD_transmit_disable_1(aData)
        write_PMD_transmit_disable_1_value = aData
        flag_PMD_transmit_disable_1        = &H1
    End Property

    Property Get read_PMD_transmit_disable_1
        read
        read_PMD_transmit_disable_1 = read_PMD_transmit_disable_1_value
    End Property

    Property Let write_PMD_transmit_disable_1(aData)
        set_PMD_transmit_disable_1 = aData
        write
    End Property

    Property Get get_PMD_transmit_disable_0
        get_PMD_transmit_disable_0 = read_PMD_transmit_disable_0_value
    End Property

    Property Let set_PMD_transmit_disable_0(aData)
        write_PMD_transmit_disable_0_value = aData
        flag_PMD_transmit_disable_0        = &H1
    End Property

    Property Get read_PMD_transmit_disable_0
        read
        read_PMD_transmit_disable_0 = read_PMD_transmit_disable_0_value
    End Property

    Property Let write_PMD_transmit_disable_0(aData)
        set_PMD_transmit_disable_0 = aData
        write
    End Property

    Property Get get_Global_PMD_transmit_disable
        get_Global_PMD_transmit_disable = read_Global_PMD_transmit_disable_value
    End Property

    Property Let set_Global_PMD_transmit_disable(aData)
        write_Global_PMD_transmit_disable_value = aData
        flag_Global_PMD_transmit_disable        = &H1
    End Property

    Property Get read_Global_PMD_transmit_disable
        read
        read_Global_PMD_transmit_disable = read_Global_PMD_transmit_disable_value
    End Property

    Property Let write_Global_PMD_transmit_disable(aData)
        set_Global_PMD_transmit_disable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_transmit_disable_9_value = rightShift(data_low, 10) and &H1
        read_PMD_transmit_disable_8_value = rightShift(data_low, 9) and &H1
        read_PMD_transmit_disable_7_value = rightShift(data_low, 8) and &H1
        read_PMD_transmit_disable_6_value = rightShift(data_low, 7) and &H1
        read_PMD_transmit_disable_5_value = rightShift(data_low, 6) and &H1
        read_PMD_transmit_disable_4_value = rightShift(data_low, 5) and &H1
        read_PMD_transmit_disable_3_value = rightShift(data_low, 4) and &H1
        read_PMD_transmit_disable_2_value = rightShift(data_low, 3) and &H1
        read_PMD_transmit_disable_1_value = rightShift(data_low, 2) and &H1
        read_PMD_transmit_disable_0_value = rightShift(data_low, 1) and &H1
        Global_PMD_transmit_disable_mask = &H1
        if data_low > LONG_MAX then
            if Global_PMD_transmit_disable_mask = mask then
                read_Global_PMD_transmit_disable_value = data_low
            else
                read_Global_PMD_transmit_disable_value = (data_low - H8000_0000) and Global_PMD_transmit_disable_mask
            end If
        else
            read_Global_PMD_transmit_disable_value = data_low and Global_PMD_transmit_disable_mask
        end If

    End Sub

    Sub write
        If flag_PMD_transmit_disable_9 = &H0 or flag_PMD_transmit_disable_8 = &H0 or flag_PMD_transmit_disable_7 = &H0 or flag_PMD_transmit_disable_6 = &H0 or flag_PMD_transmit_disable_5 = &H0 or flag_PMD_transmit_disable_4 = &H0 or flag_PMD_transmit_disable_3 = &H0 or flag_PMD_transmit_disable_2 = &H0 or flag_PMD_transmit_disable_1 = &H0 or flag_PMD_transmit_disable_0 = &H0 or flag_Global_PMD_transmit_disable = &H0 Then read
        If flag_PMD_transmit_disable_9 = &H0 Then write_PMD_transmit_disable_9_value = get_PMD_transmit_disable_9
        If flag_PMD_transmit_disable_8 = &H0 Then write_PMD_transmit_disable_8_value = get_PMD_transmit_disable_8
        If flag_PMD_transmit_disable_7 = &H0 Then write_PMD_transmit_disable_7_value = get_PMD_transmit_disable_7
        If flag_PMD_transmit_disable_6 = &H0 Then write_PMD_transmit_disable_6_value = get_PMD_transmit_disable_6
        If flag_PMD_transmit_disable_5 = &H0 Then write_PMD_transmit_disable_5_value = get_PMD_transmit_disable_5
        If flag_PMD_transmit_disable_4 = &H0 Then write_PMD_transmit_disable_4_value = get_PMD_transmit_disable_4
        If flag_PMD_transmit_disable_3 = &H0 Then write_PMD_transmit_disable_3_value = get_PMD_transmit_disable_3
        If flag_PMD_transmit_disable_2 = &H0 Then write_PMD_transmit_disable_2_value = get_PMD_transmit_disable_2
        If flag_PMD_transmit_disable_1 = &H0 Then write_PMD_transmit_disable_1_value = get_PMD_transmit_disable_1
        If flag_PMD_transmit_disable_0 = &H0 Then write_PMD_transmit_disable_0_value = get_PMD_transmit_disable_0
        If flag_Global_PMD_transmit_disable = &H0 Then write_Global_PMD_transmit_disable_value = get_Global_PMD_transmit_disable

        regValue = leftShift((write_PMD_transmit_disable_9_value and &H1), 10) + leftShift((write_PMD_transmit_disable_8_value and &H1), 9) + leftShift((write_PMD_transmit_disable_7_value and &H1), 8) + leftShift((write_PMD_transmit_disable_6_value and &H1), 7) + leftShift((write_PMD_transmit_disable_5_value and &H1), 6) + leftShift((write_PMD_transmit_disable_4_value and &H1), 5) + leftShift((write_PMD_transmit_disable_3_value and &H1), 4) + leftShift((write_PMD_transmit_disable_2_value and &H1), 3) + leftShift((write_PMD_transmit_disable_1_value and &H1), 2) + leftShift((write_PMD_transmit_disable_0_value and &H1), 1) + leftShift((write_Global_PMD_transmit_disable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_transmit_disable_9_value = rightShift(data_low, 10) and &H1
        read_PMD_transmit_disable_8_value = rightShift(data_low, 9) and &H1
        read_PMD_transmit_disable_7_value = rightShift(data_low, 8) and &H1
        read_PMD_transmit_disable_6_value = rightShift(data_low, 7) and &H1
        read_PMD_transmit_disable_5_value = rightShift(data_low, 6) and &H1
        read_PMD_transmit_disable_4_value = rightShift(data_low, 5) and &H1
        read_PMD_transmit_disable_3_value = rightShift(data_low, 4) and &H1
        read_PMD_transmit_disable_2_value = rightShift(data_low, 3) and &H1
        read_PMD_transmit_disable_1_value = rightShift(data_low, 2) and &H1
        read_PMD_transmit_disable_0_value = rightShift(data_low, 1) and &H1
        Global_PMD_transmit_disable_mask = &H1
        if data_low > LONG_MAX then
            if Global_PMD_transmit_disable_mask = mask then
                read_Global_PMD_transmit_disable_value = data_low
            else
                read_Global_PMD_transmit_disable_value = (data_low - H8000_0000) and Global_PMD_transmit_disable_mask
            end If
        else
            read_Global_PMD_transmit_disable_value = data_low and Global_PMD_transmit_disable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMD_transmit_disable_9_value = &H0
        flag_PMD_transmit_disable_9        = &H0
        write_PMD_transmit_disable_8_value = &H0
        flag_PMD_transmit_disable_8        = &H0
        write_PMD_transmit_disable_7_value = &H0
        flag_PMD_transmit_disable_7        = &H0
        write_PMD_transmit_disable_6_value = &H0
        flag_PMD_transmit_disable_6        = &H0
        write_PMD_transmit_disable_5_value = &H0
        flag_PMD_transmit_disable_5        = &H0
        write_PMD_transmit_disable_4_value = &H0
        flag_PMD_transmit_disable_4        = &H0
        write_PMD_transmit_disable_3_value = &H0
        flag_PMD_transmit_disable_3        = &H0
        write_PMD_transmit_disable_2_value = &H0
        flag_PMD_transmit_disable_2        = &H0
        write_PMD_transmit_disable_1_value = &H0
        flag_PMD_transmit_disable_1        = &H0
        write_PMD_transmit_disable_0_value = &H0
        flag_PMD_transmit_disable_0        = &H0
        write_Global_PMD_transmit_disable_value = &H0
        flag_Global_PMD_transmit_disable        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_receive_signal_det_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_9                [10:10]          get_PMD_receive_signal_detect_9
''                                                             set_PMD_receive_signal_detect_9
''                                                             read_PMD_receive_signal_detect_9
''                                                             write_PMD_receive_signal_detect_9
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_8                [9:9]            get_PMD_receive_signal_detect_8
''                                                             set_PMD_receive_signal_detect_8
''                                                             read_PMD_receive_signal_detect_8
''                                                             write_PMD_receive_signal_detect_8
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_7                [8:8]            get_PMD_receive_signal_detect_7
''                                                             set_PMD_receive_signal_detect_7
''                                                             read_PMD_receive_signal_detect_7
''                                                             write_PMD_receive_signal_detect_7
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_6                [7:7]            get_PMD_receive_signal_detect_6
''                                                             set_PMD_receive_signal_detect_6
''                                                             read_PMD_receive_signal_detect_6
''                                                             write_PMD_receive_signal_detect_6
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_5                [6:6]            get_PMD_receive_signal_detect_5
''                                                             set_PMD_receive_signal_detect_5
''                                                             read_PMD_receive_signal_detect_5
''                                                             write_PMD_receive_signal_detect_5
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_4                [5:5]            get_PMD_receive_signal_detect_4
''                                                             set_PMD_receive_signal_detect_4
''                                                             read_PMD_receive_signal_detect_4
''                                                             write_PMD_receive_signal_detect_4
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_3                [4:4]            get_PMD_receive_signal_detect_3
''                                                             set_PMD_receive_signal_detect_3
''                                                             read_PMD_receive_signal_detect_3
''                                                             write_PMD_receive_signal_detect_3
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_2                [3:3]            get_PMD_receive_signal_detect_2
''                                                             set_PMD_receive_signal_detect_2
''                                                             read_PMD_receive_signal_detect_2
''                                                             write_PMD_receive_signal_detect_2
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_1                [2:2]            get_PMD_receive_signal_detect_1
''                                                             set_PMD_receive_signal_detect_1
''                                                             read_PMD_receive_signal_detect_1
''                                                             write_PMD_receive_signal_detect_1
''---------------------------------------------------------------------------------
'' PMD_receive_signal_detect_0                [1:1]            get_PMD_receive_signal_detect_0
''                                                             set_PMD_receive_signal_detect_0
''                                                             read_PMD_receive_signal_detect_0
''                                                             write_PMD_receive_signal_detect_0
''---------------------------------------------------------------------------------
'' GPRSD                                      [0:0]            get_GPRSD
''                                                             set_GPRSD
''                                                             read_GPRSD
''                                                             write_GPRSD
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_receive_signal_det_reg
    Private write_PMD_receive_signal_detect_9_value
    Private read_PMD_receive_signal_detect_9_value
    Private flag_PMD_receive_signal_detect_9
    Private write_PMD_receive_signal_detect_8_value
    Private read_PMD_receive_signal_detect_8_value
    Private flag_PMD_receive_signal_detect_8
    Private write_PMD_receive_signal_detect_7_value
    Private read_PMD_receive_signal_detect_7_value
    Private flag_PMD_receive_signal_detect_7
    Private write_PMD_receive_signal_detect_6_value
    Private read_PMD_receive_signal_detect_6_value
    Private flag_PMD_receive_signal_detect_6
    Private write_PMD_receive_signal_detect_5_value
    Private read_PMD_receive_signal_detect_5_value
    Private flag_PMD_receive_signal_detect_5
    Private write_PMD_receive_signal_detect_4_value
    Private read_PMD_receive_signal_detect_4_value
    Private flag_PMD_receive_signal_detect_4
    Private write_PMD_receive_signal_detect_3_value
    Private read_PMD_receive_signal_detect_3_value
    Private flag_PMD_receive_signal_detect_3
    Private write_PMD_receive_signal_detect_2_value
    Private read_PMD_receive_signal_detect_2_value
    Private flag_PMD_receive_signal_detect_2
    Private write_PMD_receive_signal_detect_1_value
    Private read_PMD_receive_signal_detect_1_value
    Private flag_PMD_receive_signal_detect_1
    Private write_PMD_receive_signal_detect_0_value
    Private read_PMD_receive_signal_detect_0_value
    Private flag_PMD_receive_signal_detect_0
    Private write_GPRSD_value
    Private read_GPRSD_value
    Private flag_GPRSD

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

    Property Get get_PMD_receive_signal_detect_9
        get_PMD_receive_signal_detect_9 = read_PMD_receive_signal_detect_9_value
    End Property

    Property Let set_PMD_receive_signal_detect_9(aData)
        write_PMD_receive_signal_detect_9_value = aData
        flag_PMD_receive_signal_detect_9        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_9
        read
        read_PMD_receive_signal_detect_9 = read_PMD_receive_signal_detect_9_value
    End Property

    Property Let write_PMD_receive_signal_detect_9(aData)
        set_PMD_receive_signal_detect_9 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_8
        get_PMD_receive_signal_detect_8 = read_PMD_receive_signal_detect_8_value
    End Property

    Property Let set_PMD_receive_signal_detect_8(aData)
        write_PMD_receive_signal_detect_8_value = aData
        flag_PMD_receive_signal_detect_8        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_8
        read
        read_PMD_receive_signal_detect_8 = read_PMD_receive_signal_detect_8_value
    End Property

    Property Let write_PMD_receive_signal_detect_8(aData)
        set_PMD_receive_signal_detect_8 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_7
        get_PMD_receive_signal_detect_7 = read_PMD_receive_signal_detect_7_value
    End Property

    Property Let set_PMD_receive_signal_detect_7(aData)
        write_PMD_receive_signal_detect_7_value = aData
        flag_PMD_receive_signal_detect_7        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_7
        read
        read_PMD_receive_signal_detect_7 = read_PMD_receive_signal_detect_7_value
    End Property

    Property Let write_PMD_receive_signal_detect_7(aData)
        set_PMD_receive_signal_detect_7 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_6
        get_PMD_receive_signal_detect_6 = read_PMD_receive_signal_detect_6_value
    End Property

    Property Let set_PMD_receive_signal_detect_6(aData)
        write_PMD_receive_signal_detect_6_value = aData
        flag_PMD_receive_signal_detect_6        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_6
        read
        read_PMD_receive_signal_detect_6 = read_PMD_receive_signal_detect_6_value
    End Property

    Property Let write_PMD_receive_signal_detect_6(aData)
        set_PMD_receive_signal_detect_6 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_5
        get_PMD_receive_signal_detect_5 = read_PMD_receive_signal_detect_5_value
    End Property

    Property Let set_PMD_receive_signal_detect_5(aData)
        write_PMD_receive_signal_detect_5_value = aData
        flag_PMD_receive_signal_detect_5        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_5
        read
        read_PMD_receive_signal_detect_5 = read_PMD_receive_signal_detect_5_value
    End Property

    Property Let write_PMD_receive_signal_detect_5(aData)
        set_PMD_receive_signal_detect_5 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_4
        get_PMD_receive_signal_detect_4 = read_PMD_receive_signal_detect_4_value
    End Property

    Property Let set_PMD_receive_signal_detect_4(aData)
        write_PMD_receive_signal_detect_4_value = aData
        flag_PMD_receive_signal_detect_4        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_4
        read
        read_PMD_receive_signal_detect_4 = read_PMD_receive_signal_detect_4_value
    End Property

    Property Let write_PMD_receive_signal_detect_4(aData)
        set_PMD_receive_signal_detect_4 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_3
        get_PMD_receive_signal_detect_3 = read_PMD_receive_signal_detect_3_value
    End Property

    Property Let set_PMD_receive_signal_detect_3(aData)
        write_PMD_receive_signal_detect_3_value = aData
        flag_PMD_receive_signal_detect_3        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_3
        read
        read_PMD_receive_signal_detect_3 = read_PMD_receive_signal_detect_3_value
    End Property

    Property Let write_PMD_receive_signal_detect_3(aData)
        set_PMD_receive_signal_detect_3 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_2
        get_PMD_receive_signal_detect_2 = read_PMD_receive_signal_detect_2_value
    End Property

    Property Let set_PMD_receive_signal_detect_2(aData)
        write_PMD_receive_signal_detect_2_value = aData
        flag_PMD_receive_signal_detect_2        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_2
        read
        read_PMD_receive_signal_detect_2 = read_PMD_receive_signal_detect_2_value
    End Property

    Property Let write_PMD_receive_signal_detect_2(aData)
        set_PMD_receive_signal_detect_2 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_1
        get_PMD_receive_signal_detect_1 = read_PMD_receive_signal_detect_1_value
    End Property

    Property Let set_PMD_receive_signal_detect_1(aData)
        write_PMD_receive_signal_detect_1_value = aData
        flag_PMD_receive_signal_detect_1        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_1
        read
        read_PMD_receive_signal_detect_1 = read_PMD_receive_signal_detect_1_value
    End Property

    Property Let write_PMD_receive_signal_detect_1(aData)
        set_PMD_receive_signal_detect_1 = aData
        write
    End Property

    Property Get get_PMD_receive_signal_detect_0
        get_PMD_receive_signal_detect_0 = read_PMD_receive_signal_detect_0_value
    End Property

    Property Let set_PMD_receive_signal_detect_0(aData)
        write_PMD_receive_signal_detect_0_value = aData
        flag_PMD_receive_signal_detect_0        = &H1
    End Property

    Property Get read_PMD_receive_signal_detect_0
        read
        read_PMD_receive_signal_detect_0 = read_PMD_receive_signal_detect_0_value
    End Property

    Property Let write_PMD_receive_signal_detect_0(aData)
        set_PMD_receive_signal_detect_0 = aData
        write
    End Property

    Property Get get_GPRSD
        get_GPRSD = read_GPRSD_value
    End Property

    Property Let set_GPRSD(aData)
        write_GPRSD_value = aData
        flag_GPRSD        = &H1
    End Property

    Property Get read_GPRSD
        read
        read_GPRSD = read_GPRSD_value
    End Property

    Property Let write_GPRSD(aData)
        set_GPRSD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_receive_signal_detect_9_value = rightShift(data_low, 10) and &H1
        read_PMD_receive_signal_detect_8_value = rightShift(data_low, 9) and &H1
        read_PMD_receive_signal_detect_7_value = rightShift(data_low, 8) and &H1
        read_PMD_receive_signal_detect_6_value = rightShift(data_low, 7) and &H1
        read_PMD_receive_signal_detect_5_value = rightShift(data_low, 6) and &H1
        read_PMD_receive_signal_detect_4_value = rightShift(data_low, 5) and &H1
        read_PMD_receive_signal_detect_3_value = rightShift(data_low, 4) and &H1
        read_PMD_receive_signal_detect_2_value = rightShift(data_low, 3) and &H1
        read_PMD_receive_signal_detect_1_value = rightShift(data_low, 2) and &H1
        read_PMD_receive_signal_detect_0_value = rightShift(data_low, 1) and &H1
        GPRSD_mask = &H1
        if data_low > LONG_MAX then
            if GPRSD_mask = mask then
                read_GPRSD_value = data_low
            else
                read_GPRSD_value = (data_low - H8000_0000) and GPRSD_mask
            end If
        else
            read_GPRSD_value = data_low and GPRSD_mask
        end If

    End Sub

    Sub write
        If flag_PMD_receive_signal_detect_9 = &H0 or flag_PMD_receive_signal_detect_8 = &H0 or flag_PMD_receive_signal_detect_7 = &H0 or flag_PMD_receive_signal_detect_6 = &H0 or flag_PMD_receive_signal_detect_5 = &H0 or flag_PMD_receive_signal_detect_4 = &H0 or flag_PMD_receive_signal_detect_3 = &H0 or flag_PMD_receive_signal_detect_2 = &H0 or flag_PMD_receive_signal_detect_1 = &H0 or flag_PMD_receive_signal_detect_0 = &H0 or flag_GPRSD = &H0 Then read
        If flag_PMD_receive_signal_detect_9 = &H0 Then write_PMD_receive_signal_detect_9_value = get_PMD_receive_signal_detect_9
        If flag_PMD_receive_signal_detect_8 = &H0 Then write_PMD_receive_signal_detect_8_value = get_PMD_receive_signal_detect_8
        If flag_PMD_receive_signal_detect_7 = &H0 Then write_PMD_receive_signal_detect_7_value = get_PMD_receive_signal_detect_7
        If flag_PMD_receive_signal_detect_6 = &H0 Then write_PMD_receive_signal_detect_6_value = get_PMD_receive_signal_detect_6
        If flag_PMD_receive_signal_detect_5 = &H0 Then write_PMD_receive_signal_detect_5_value = get_PMD_receive_signal_detect_5
        If flag_PMD_receive_signal_detect_4 = &H0 Then write_PMD_receive_signal_detect_4_value = get_PMD_receive_signal_detect_4
        If flag_PMD_receive_signal_detect_3 = &H0 Then write_PMD_receive_signal_detect_3_value = get_PMD_receive_signal_detect_3
        If flag_PMD_receive_signal_detect_2 = &H0 Then write_PMD_receive_signal_detect_2_value = get_PMD_receive_signal_detect_2
        If flag_PMD_receive_signal_detect_1 = &H0 Then write_PMD_receive_signal_detect_1_value = get_PMD_receive_signal_detect_1
        If flag_PMD_receive_signal_detect_0 = &H0 Then write_PMD_receive_signal_detect_0_value = get_PMD_receive_signal_detect_0
        If flag_GPRSD = &H0 Then write_GPRSD_value = get_GPRSD

        regValue = leftShift((write_PMD_receive_signal_detect_9_value and &H1), 10) + leftShift((write_PMD_receive_signal_detect_8_value and &H1), 9) + leftShift((write_PMD_receive_signal_detect_7_value and &H1), 8) + leftShift((write_PMD_receive_signal_detect_6_value and &H1), 7) + leftShift((write_PMD_receive_signal_detect_5_value and &H1), 6) + leftShift((write_PMD_receive_signal_detect_4_value and &H1), 5) + leftShift((write_PMD_receive_signal_detect_3_value and &H1), 4) + leftShift((write_PMD_receive_signal_detect_2_value and &H1), 3) + leftShift((write_PMD_receive_signal_detect_1_value and &H1), 2) + leftShift((write_PMD_receive_signal_detect_0_value and &H1), 1) + leftShift((write_GPRSD_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_receive_signal_detect_9_value = rightShift(data_low, 10) and &H1
        read_PMD_receive_signal_detect_8_value = rightShift(data_low, 9) and &H1
        read_PMD_receive_signal_detect_7_value = rightShift(data_low, 8) and &H1
        read_PMD_receive_signal_detect_6_value = rightShift(data_low, 7) and &H1
        read_PMD_receive_signal_detect_5_value = rightShift(data_low, 6) and &H1
        read_PMD_receive_signal_detect_4_value = rightShift(data_low, 5) and &H1
        read_PMD_receive_signal_detect_3_value = rightShift(data_low, 4) and &H1
        read_PMD_receive_signal_detect_2_value = rightShift(data_low, 3) and &H1
        read_PMD_receive_signal_detect_1_value = rightShift(data_low, 2) and &H1
        read_PMD_receive_signal_detect_0_value = rightShift(data_low, 1) and &H1
        GPRSD_mask = &H1
        if data_low > LONG_MAX then
            if GPRSD_mask = mask then
                read_GPRSD_value = data_low
            else
                read_GPRSD_value = (data_low - H8000_0000) and GPRSD_mask
            end If
        else
            read_GPRSD_value = data_low and GPRSD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMD_receive_signal_detect_9_value = &H0
        flag_PMD_receive_signal_detect_9        = &H0
        write_PMD_receive_signal_detect_8_value = &H0
        flag_PMD_receive_signal_detect_8        = &H0
        write_PMD_receive_signal_detect_7_value = &H0
        flag_PMD_receive_signal_detect_7        = &H0
        write_PMD_receive_signal_detect_6_value = &H0
        flag_PMD_receive_signal_detect_6        = &H0
        write_PMD_receive_signal_detect_5_value = &H0
        flag_PMD_receive_signal_detect_5        = &H0
        write_PMD_receive_signal_detect_4_value = &H0
        flag_PMD_receive_signal_detect_4        = &H0
        write_PMD_receive_signal_detect_3_value = &H0
        flag_PMD_receive_signal_detect_3        = &H0
        write_PMD_receive_signal_detect_2_value = &H0
        flag_PMD_receive_signal_detect_2        = &H0
        write_PMD_receive_signal_detect_1_value = &H0
        flag_PMD_receive_signal_detect_1        = &H0
        write_PMD_receive_signal_detect_0_value = &H0
        flag_PMD_receive_signal_detect_0        = &H0
        write_GPRSD_value = &H0
        flag_GPRSD        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_extended_ability_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BASET1_extended_abilities                  [11:11]          get_BASET1_extended_abilities
''                                                             set_BASET1_extended_abilities
''                                                             read_BASET1_extended_abilities
''                                                             write_BASET1_extended_abilities
''---------------------------------------------------------------------------------
'' abilities_40G_100G_extended                [10:10]          get_abilities_40G_100G_extended
''                                                             set_abilities_40G_100G_extended
''                                                             read_abilities_40G_100G_extended
''                                                             write_abilities_40G_100G_extended
''---------------------------------------------------------------------------------
'' P2MP_ability                               [9:9]            get_P2MP_ability
''                                                             set_P2MP_ability
''                                                             read_P2MP_ability
''                                                             write_P2MP_ability
''---------------------------------------------------------------------------------
'' ability_10BASET                            [8:8]            get_ability_10BASET
''                                                             set_ability_10BASET
''                                                             read_ability_10BASET
''                                                             write_ability_10BASET
''---------------------------------------------------------------------------------
'' ability_100BASETX                          [7:7]            get_ability_100BASETX
''                                                             set_ability_100BASETX
''                                                             read_ability_100BASETX
''                                                             write_ability_100BASETX
''---------------------------------------------------------------------------------
'' ability_1000BASEKX                         [6:6]            get_ability_1000BASEKX
''                                                             set_ability_1000BASEKX
''                                                             read_ability_1000BASEKX
''                                                             write_ability_1000BASEKX
''---------------------------------------------------------------------------------
'' ability_1000BASET                          [5:5]            get_ability_1000BASET
''                                                             set_ability_1000BASET
''                                                             read_ability_1000BASET
''                                                             write_ability_1000BASET
''---------------------------------------------------------------------------------
'' ability_10GBASEKR                          [4:4]            get_ability_10GBASEKR
''                                                             set_ability_10GBASEKR
''                                                             read_ability_10GBASEKR
''                                                             write_ability_10GBASEKR
''---------------------------------------------------------------------------------
'' ability_10GBASEKX4                         [3:3]            get_ability_10GBASEKX4
''                                                             set_ability_10GBASEKX4
''                                                             read_ability_10GBASEKX4
''                                                             write_ability_10GBASEKX4
''---------------------------------------------------------------------------------
'' ability_10GBASET                           [2:2]            get_ability_10GBASET
''                                                             set_ability_10GBASET
''                                                             read_ability_10GBASET
''                                                             write_ability_10GBASET
''---------------------------------------------------------------------------------
'' ability_10GBASELRM                         [1:1]            get_ability_10GBASELRM
''                                                             set_ability_10GBASELRM
''                                                             read_ability_10GBASELRM
''                                                             write_ability_10GBASELRM
''---------------------------------------------------------------------------------
'' ability_10GBASECX4                         [0:0]            get_ability_10GBASECX4
''                                                             set_ability_10GBASECX4
''                                                             read_ability_10GBASECX4
''                                                             write_ability_10GBASECX4
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_extended_ability_reg
    Private write_BASET1_extended_abilities_value
    Private read_BASET1_extended_abilities_value
    Private flag_BASET1_extended_abilities
    Private write_abilities_40G_100G_extended_value
    Private read_abilities_40G_100G_extended_value
    Private flag_abilities_40G_100G_extended
    Private write_P2MP_ability_value
    Private read_P2MP_ability_value
    Private flag_P2MP_ability
    Private write_ability_10BASET_value
    Private read_ability_10BASET_value
    Private flag_ability_10BASET
    Private write_ability_100BASETX_value
    Private read_ability_100BASETX_value
    Private flag_ability_100BASETX
    Private write_ability_1000BASEKX_value
    Private read_ability_1000BASEKX_value
    Private flag_ability_1000BASEKX
    Private write_ability_1000BASET_value
    Private read_ability_1000BASET_value
    Private flag_ability_1000BASET
    Private write_ability_10GBASEKR_value
    Private read_ability_10GBASEKR_value
    Private flag_ability_10GBASEKR
    Private write_ability_10GBASEKX4_value
    Private read_ability_10GBASEKX4_value
    Private flag_ability_10GBASEKX4
    Private write_ability_10GBASET_value
    Private read_ability_10GBASET_value
    Private flag_ability_10GBASET
    Private write_ability_10GBASELRM_value
    Private read_ability_10GBASELRM_value
    Private flag_ability_10GBASELRM
    Private write_ability_10GBASECX4_value
    Private read_ability_10GBASECX4_value
    Private flag_ability_10GBASECX4

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

    Property Get get_BASET1_extended_abilities
        get_BASET1_extended_abilities = read_BASET1_extended_abilities_value
    End Property

    Property Let set_BASET1_extended_abilities(aData)
        write_BASET1_extended_abilities_value = aData
        flag_BASET1_extended_abilities        = &H1
    End Property

    Property Get read_BASET1_extended_abilities
        read
        read_BASET1_extended_abilities = read_BASET1_extended_abilities_value
    End Property

    Property Let write_BASET1_extended_abilities(aData)
        set_BASET1_extended_abilities = aData
        write
    End Property

    Property Get get_abilities_40G_100G_extended
        get_abilities_40G_100G_extended = read_abilities_40G_100G_extended_value
    End Property

    Property Let set_abilities_40G_100G_extended(aData)
        write_abilities_40G_100G_extended_value = aData
        flag_abilities_40G_100G_extended        = &H1
    End Property

    Property Get read_abilities_40G_100G_extended
        read
        read_abilities_40G_100G_extended = read_abilities_40G_100G_extended_value
    End Property

    Property Let write_abilities_40G_100G_extended(aData)
        set_abilities_40G_100G_extended = aData
        write
    End Property

    Property Get get_P2MP_ability
        get_P2MP_ability = read_P2MP_ability_value
    End Property

    Property Let set_P2MP_ability(aData)
        write_P2MP_ability_value = aData
        flag_P2MP_ability        = &H1
    End Property

    Property Get read_P2MP_ability
        read
        read_P2MP_ability = read_P2MP_ability_value
    End Property

    Property Let write_P2MP_ability(aData)
        set_P2MP_ability = aData
        write
    End Property

    Property Get get_ability_10BASET
        get_ability_10BASET = read_ability_10BASET_value
    End Property

    Property Let set_ability_10BASET(aData)
        write_ability_10BASET_value = aData
        flag_ability_10BASET        = &H1
    End Property

    Property Get read_ability_10BASET
        read
        read_ability_10BASET = read_ability_10BASET_value
    End Property

    Property Let write_ability_10BASET(aData)
        set_ability_10BASET = aData
        write
    End Property

    Property Get get_ability_100BASETX
        get_ability_100BASETX = read_ability_100BASETX_value
    End Property

    Property Let set_ability_100BASETX(aData)
        write_ability_100BASETX_value = aData
        flag_ability_100BASETX        = &H1
    End Property

    Property Get read_ability_100BASETX
        read
        read_ability_100BASETX = read_ability_100BASETX_value
    End Property

    Property Let write_ability_100BASETX(aData)
        set_ability_100BASETX = aData
        write
    End Property

    Property Get get_ability_1000BASEKX
        get_ability_1000BASEKX = read_ability_1000BASEKX_value
    End Property

    Property Let set_ability_1000BASEKX(aData)
        write_ability_1000BASEKX_value = aData
        flag_ability_1000BASEKX        = &H1
    End Property

    Property Get read_ability_1000BASEKX
        read
        read_ability_1000BASEKX = read_ability_1000BASEKX_value
    End Property

    Property Let write_ability_1000BASEKX(aData)
        set_ability_1000BASEKX = aData
        write
    End Property

    Property Get get_ability_1000BASET
        get_ability_1000BASET = read_ability_1000BASET_value
    End Property

    Property Let set_ability_1000BASET(aData)
        write_ability_1000BASET_value = aData
        flag_ability_1000BASET        = &H1
    End Property

    Property Get read_ability_1000BASET
        read
        read_ability_1000BASET = read_ability_1000BASET_value
    End Property

    Property Let write_ability_1000BASET(aData)
        set_ability_1000BASET = aData
        write
    End Property

    Property Get get_ability_10GBASEKR
        get_ability_10GBASEKR = read_ability_10GBASEKR_value
    End Property

    Property Let set_ability_10GBASEKR(aData)
        write_ability_10GBASEKR_value = aData
        flag_ability_10GBASEKR        = &H1
    End Property

    Property Get read_ability_10GBASEKR
        read
        read_ability_10GBASEKR = read_ability_10GBASEKR_value
    End Property

    Property Let write_ability_10GBASEKR(aData)
        set_ability_10GBASEKR = aData
        write
    End Property

    Property Get get_ability_10GBASEKX4
        get_ability_10GBASEKX4 = read_ability_10GBASEKX4_value
    End Property

    Property Let set_ability_10GBASEKX4(aData)
        write_ability_10GBASEKX4_value = aData
        flag_ability_10GBASEKX4        = &H1
    End Property

    Property Get read_ability_10GBASEKX4
        read
        read_ability_10GBASEKX4 = read_ability_10GBASEKX4_value
    End Property

    Property Let write_ability_10GBASEKX4(aData)
        set_ability_10GBASEKX4 = aData
        write
    End Property

    Property Get get_ability_10GBASET
        get_ability_10GBASET = read_ability_10GBASET_value
    End Property

    Property Let set_ability_10GBASET(aData)
        write_ability_10GBASET_value = aData
        flag_ability_10GBASET        = &H1
    End Property

    Property Get read_ability_10GBASET
        read
        read_ability_10GBASET = read_ability_10GBASET_value
    End Property

    Property Let write_ability_10GBASET(aData)
        set_ability_10GBASET = aData
        write
    End Property

    Property Get get_ability_10GBASELRM
        get_ability_10GBASELRM = read_ability_10GBASELRM_value
    End Property

    Property Let set_ability_10GBASELRM(aData)
        write_ability_10GBASELRM_value = aData
        flag_ability_10GBASELRM        = &H1
    End Property

    Property Get read_ability_10GBASELRM
        read
        read_ability_10GBASELRM = read_ability_10GBASELRM_value
    End Property

    Property Let write_ability_10GBASELRM(aData)
        set_ability_10GBASELRM = aData
        write
    End Property

    Property Get get_ability_10GBASECX4
        get_ability_10GBASECX4 = read_ability_10GBASECX4_value
    End Property

    Property Let set_ability_10GBASECX4(aData)
        write_ability_10GBASECX4_value = aData
        flag_ability_10GBASECX4        = &H1
    End Property

    Property Get read_ability_10GBASECX4
        read
        read_ability_10GBASECX4 = read_ability_10GBASECX4_value
    End Property

    Property Let write_ability_10GBASECX4(aData)
        set_ability_10GBASECX4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASET1_extended_abilities_value = rightShift(data_low, 11) and &H1
        read_abilities_40G_100G_extended_value = rightShift(data_low, 10) and &H1
        read_P2MP_ability_value = rightShift(data_low, 9) and &H1
        read_ability_10BASET_value = rightShift(data_low, 8) and &H1
        read_ability_100BASETX_value = rightShift(data_low, 7) and &H1
        read_ability_1000BASEKX_value = rightShift(data_low, 6) and &H1
        read_ability_1000BASET_value = rightShift(data_low, 5) and &H1
        read_ability_10GBASEKR_value = rightShift(data_low, 4) and &H1
        read_ability_10GBASEKX4_value = rightShift(data_low, 3) and &H1
        read_ability_10GBASET_value = rightShift(data_low, 2) and &H1
        read_ability_10GBASELRM_value = rightShift(data_low, 1) and &H1
        ability_10GBASECX4_mask = &H1
        if data_low > LONG_MAX then
            if ability_10GBASECX4_mask = mask then
                read_ability_10GBASECX4_value = data_low
            else
                read_ability_10GBASECX4_value = (data_low - H8000_0000) and ability_10GBASECX4_mask
            end If
        else
            read_ability_10GBASECX4_value = data_low and ability_10GBASECX4_mask
        end If

    End Sub

    Sub write
        If flag_BASET1_extended_abilities = &H0 or flag_abilities_40G_100G_extended = &H0 or flag_P2MP_ability = &H0 or flag_ability_10BASET = &H0 or flag_ability_100BASETX = &H0 or flag_ability_1000BASEKX = &H0 or flag_ability_1000BASET = &H0 or flag_ability_10GBASEKR = &H0 or flag_ability_10GBASEKX4 = &H0 or flag_ability_10GBASET = &H0 or flag_ability_10GBASELRM = &H0 or flag_ability_10GBASECX4 = &H0 Then read
        If flag_BASET1_extended_abilities = &H0 Then write_BASET1_extended_abilities_value = get_BASET1_extended_abilities
        If flag_abilities_40G_100G_extended = &H0 Then write_abilities_40G_100G_extended_value = get_abilities_40G_100G_extended
        If flag_P2MP_ability = &H0 Then write_P2MP_ability_value = get_P2MP_ability
        If flag_ability_10BASET = &H0 Then write_ability_10BASET_value = get_ability_10BASET
        If flag_ability_100BASETX = &H0 Then write_ability_100BASETX_value = get_ability_100BASETX
        If flag_ability_1000BASEKX = &H0 Then write_ability_1000BASEKX_value = get_ability_1000BASEKX
        If flag_ability_1000BASET = &H0 Then write_ability_1000BASET_value = get_ability_1000BASET
        If flag_ability_10GBASEKR = &H0 Then write_ability_10GBASEKR_value = get_ability_10GBASEKR
        If flag_ability_10GBASEKX4 = &H0 Then write_ability_10GBASEKX4_value = get_ability_10GBASEKX4
        If flag_ability_10GBASET = &H0 Then write_ability_10GBASET_value = get_ability_10GBASET
        If flag_ability_10GBASELRM = &H0 Then write_ability_10GBASELRM_value = get_ability_10GBASELRM
        If flag_ability_10GBASECX4 = &H0 Then write_ability_10GBASECX4_value = get_ability_10GBASECX4

        regValue = leftShift((write_BASET1_extended_abilities_value and &H1), 11) + leftShift((write_abilities_40G_100G_extended_value and &H1), 10) + leftShift((write_P2MP_ability_value and &H1), 9) + leftShift((write_ability_10BASET_value and &H1), 8) + leftShift((write_ability_100BASETX_value and &H1), 7) + leftShift((write_ability_1000BASEKX_value and &H1), 6) + leftShift((write_ability_1000BASET_value and &H1), 5) + leftShift((write_ability_10GBASEKR_value and &H1), 4) + leftShift((write_ability_10GBASEKX4_value and &H1), 3) + leftShift((write_ability_10GBASET_value and &H1), 2) + leftShift((write_ability_10GBASELRM_value and &H1), 1) + leftShift((write_ability_10GBASECX4_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BASET1_extended_abilities_value = rightShift(data_low, 11) and &H1
        read_abilities_40G_100G_extended_value = rightShift(data_low, 10) and &H1
        read_P2MP_ability_value = rightShift(data_low, 9) and &H1
        read_ability_10BASET_value = rightShift(data_low, 8) and &H1
        read_ability_100BASETX_value = rightShift(data_low, 7) and &H1
        read_ability_1000BASEKX_value = rightShift(data_low, 6) and &H1
        read_ability_1000BASET_value = rightShift(data_low, 5) and &H1
        read_ability_10GBASEKR_value = rightShift(data_low, 4) and &H1
        read_ability_10GBASEKX4_value = rightShift(data_low, 3) and &H1
        read_ability_10GBASET_value = rightShift(data_low, 2) and &H1
        read_ability_10GBASELRM_value = rightShift(data_low, 1) and &H1
        ability_10GBASECX4_mask = &H1
        if data_low > LONG_MAX then
            if ability_10GBASECX4_mask = mask then
                read_ability_10GBASECX4_value = data_low
            else
                read_ability_10GBASECX4_value = (data_low - H8000_0000) and ability_10GBASECX4_mask
            end If
        else
            read_ability_10GBASECX4_value = data_low and ability_10GBASECX4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BASET1_extended_abilities_value = &H0
        flag_BASET1_extended_abilities        = &H0
        write_abilities_40G_100G_extended_value = &H0
        flag_abilities_40G_100G_extended        = &H0
        write_P2MP_ability_value = &H0
        flag_P2MP_ability        = &H0
        write_ability_10BASET_value = &H0
        flag_ability_10BASET        = &H0
        write_ability_100BASETX_value = &H0
        flag_ability_100BASETX        = &H0
        write_ability_1000BASEKX_value = &H0
        flag_ability_1000BASEKX        = &H0
        write_ability_1000BASET_value = &H0
        flag_ability_1000BASET        = &H0
        write_ability_10GBASEKR_value = &H0
        flag_ability_10GBASEKR        = &H0
        write_ability_10GBASEKX4_value = &H0
        flag_ability_10GBASEKX4        = &H0
        write_ability_10GBASET_value = &H0
        flag_ability_10GBASET        = &H0
        write_ability_10GBASELRM_value = &H0
        flag_ability_10GBASELRM        = &H0
        write_ability_10GBASECX4_value = &H0
        flag_ability_10GBASECX4        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_package_id_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PACKAGE_ID                                 [15:0]           get_PACKAGE_ID
''                                                             set_PACKAGE_ID
''                                                             read_PACKAGE_ID
''                                                             write_PACKAGE_ID
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_package_id_reg0
    Private write_PACKAGE_ID_value
    Private read_PACKAGE_ID_value
    Private flag_PACKAGE_ID

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

    Property Get get_PACKAGE_ID
        get_PACKAGE_ID = read_PACKAGE_ID_value
    End Property

    Property Let set_PACKAGE_ID(aData)
        write_PACKAGE_ID_value = aData
        flag_PACKAGE_ID        = &H1
    End Property

    Property Get read_PACKAGE_ID
        read
        read_PACKAGE_ID = read_PACKAGE_ID_value
    End Property

    Property Let write_PACKAGE_ID(aData)
        set_PACKAGE_ID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PACKAGE_ID_mask = &Hffff
        if data_low > LONG_MAX then
            if PACKAGE_ID_mask = mask then
                read_PACKAGE_ID_value = data_low
            else
                read_PACKAGE_ID_value = (data_low - H8000_0000) and PACKAGE_ID_mask
            end If
        else
            read_PACKAGE_ID_value = data_low and PACKAGE_ID_mask
        end If

    End Sub

    Sub write
        If flag_PACKAGE_ID = &H0 Then read
        If flag_PACKAGE_ID = &H0 Then write_PACKAGE_ID_value = get_PACKAGE_ID

        regValue = leftShift((write_PACKAGE_ID_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PACKAGE_ID_mask = &Hffff
        if data_low > LONG_MAX then
            if PACKAGE_ID_mask = mask then
                read_PACKAGE_ID_value = data_low
            else
                read_PACKAGE_ID_value = (data_low - H8000_0000) and PACKAGE_ID_mask
            end If
        else
            read_PACKAGE_ID_value = data_low and PACKAGE_ID_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PACKAGE_ID_value = &H0
        flag_PACKAGE_ID        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_package_id_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PACKAGE_ID                                 [15:0]           get_PACKAGE_ID
''                                                             set_PACKAGE_ID
''                                                             read_PACKAGE_ID
''                                                             write_PACKAGE_ID
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_package_id_reg1
    Private write_PACKAGE_ID_value
    Private read_PACKAGE_ID_value
    Private flag_PACKAGE_ID

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

    Property Get get_PACKAGE_ID
        get_PACKAGE_ID = read_PACKAGE_ID_value
    End Property

    Property Let set_PACKAGE_ID(aData)
        write_PACKAGE_ID_value = aData
        flag_PACKAGE_ID        = &H1
    End Property

    Property Get read_PACKAGE_ID
        read
        read_PACKAGE_ID = read_PACKAGE_ID_value
    End Property

    Property Let write_PACKAGE_ID(aData)
        set_PACKAGE_ID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PACKAGE_ID_mask = &Hffff
        if data_low > LONG_MAX then
            if PACKAGE_ID_mask = mask then
                read_PACKAGE_ID_value = data_low
            else
                read_PACKAGE_ID_value = (data_low - H8000_0000) and PACKAGE_ID_mask
            end If
        else
            read_PACKAGE_ID_value = data_low and PACKAGE_ID_mask
        end If

    End Sub

    Sub write
        If flag_PACKAGE_ID = &H0 Then read
        If flag_PACKAGE_ID = &H0 Then write_PACKAGE_ID_value = get_PACKAGE_ID

        regValue = leftShift((write_PACKAGE_ID_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PACKAGE_ID_mask = &Hffff
        if data_low > LONG_MAX then
            if PACKAGE_ID_mask = mask then
                read_PACKAGE_ID_value = data_low
            else
                read_PACKAGE_ID_value = (data_low - H8000_0000) and PACKAGE_ID_mask
            end If
        else
            read_PACKAGE_ID_value = data_low and PACKAGE_ID_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PACKAGE_ID_value = &H0
        flag_PACKAGE_ID        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_baset1_pma_pmd_extended_ability
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ability_1000T1                             [1:1]            get_ability_1000T1
''                                                             set_ability_1000T1
''                                                             read_ability_1000T1
''                                                             write_ability_1000T1
''---------------------------------------------------------------------------------
'' ability_100T1                              [0:0]            get_ability_100T1
''                                                             set_ability_100T1
''                                                             read_ability_100T1
''                                                             write_ability_100T1
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_baset1_pma_pmd_extended_ability
    Private write_ability_1000T1_value
    Private read_ability_1000T1_value
    Private flag_ability_1000T1
    Private write_ability_100T1_value
    Private read_ability_100T1_value
    Private flag_ability_100T1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ability_1000T1
        get_ability_1000T1 = read_ability_1000T1_value
    End Property

    Property Let set_ability_1000T1(aData)
        write_ability_1000T1_value = aData
        flag_ability_1000T1        = &H1
    End Property

    Property Get read_ability_1000T1
        read
        read_ability_1000T1 = read_ability_1000T1_value
    End Property

    Property Let write_ability_1000T1(aData)
        set_ability_1000T1 = aData
        write
    End Property

    Property Get get_ability_100T1
        get_ability_100T1 = read_ability_100T1_value
    End Property

    Property Let set_ability_100T1(aData)
        write_ability_100T1_value = aData
        flag_ability_100T1        = &H1
    End Property

    Property Get read_ability_100T1
        read
        read_ability_100T1 = read_ability_100T1_value
    End Property

    Property Let write_ability_100T1(aData)
        set_ability_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ability_1000T1_value = rightShift(data_low, 1) and &H1
        ability_100T1_mask = &H1
        if data_low > LONG_MAX then
            if ability_100T1_mask = mask then
                read_ability_100T1_value = data_low
            else
                read_ability_100T1_value = (data_low - H8000_0000) and ability_100T1_mask
            end If
        else
            read_ability_100T1_value = data_low and ability_100T1_mask
        end If

    End Sub

    Sub write
        If flag_ability_1000T1 = &H0 or flag_ability_100T1 = &H0 Then read
        If flag_ability_1000T1 = &H0 Then write_ability_1000T1_value = get_ability_1000T1
        If flag_ability_100T1 = &H0 Then write_ability_100T1_value = get_ability_100T1

        regValue = leftShift((write_ability_1000T1_value and &H1), 1) + leftShift((write_ability_100T1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ability_1000T1_value = rightShift(data_low, 1) and &H1
        ability_100T1_mask = &H1
        if data_low > LONG_MAX then
            if ability_100T1_mask = mask then
                read_ability_100T1_value = data_low
            else
                read_ability_100T1_value = (data_low - H8000_0000) and ability_100T1_mask
            end If
        else
            read_ability_100T1_value = data_low and ability_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ability_1000T1_value = &H0
        flag_ability_1000T1        = &H0
        write_ability_100T1_value = &H0
        flag_ability_100T1        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_timesync_capability
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ability_1000T1                             [1:1]            get_ability_1000T1
''                                                             set_ability_1000T1
''                                                             read_ability_1000T1
''                                                             write_ability_1000T1
''---------------------------------------------------------------------------------
'' ability_100T1                              [0:0]            get_ability_100T1
''                                                             set_ability_100T1
''                                                             read_ability_100T1
''                                                             write_ability_100T1
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_timesync_capability
    Private write_ability_1000T1_value
    Private read_ability_1000T1_value
    Private flag_ability_1000T1
    Private write_ability_100T1_value
    Private read_ability_100T1_value
    Private flag_ability_100T1

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

    Property Get get_ability_1000T1
        get_ability_1000T1 = read_ability_1000T1_value
    End Property

    Property Let set_ability_1000T1(aData)
        write_ability_1000T1_value = aData
        flag_ability_1000T1        = &H1
    End Property

    Property Get read_ability_1000T1
        read
        read_ability_1000T1 = read_ability_1000T1_value
    End Property

    Property Let write_ability_1000T1(aData)
        set_ability_1000T1 = aData
        write
    End Property

    Property Get get_ability_100T1
        get_ability_100T1 = read_ability_100T1_value
    End Property

    Property Let set_ability_100T1(aData)
        write_ability_100T1_value = aData
        flag_ability_100T1        = &H1
    End Property

    Property Get read_ability_100T1
        read
        read_ability_100T1 = read_ability_100T1_value
    End Property

    Property Let write_ability_100T1(aData)
        set_ability_100T1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ability_1000T1_value = rightShift(data_low, 1) and &H1
        ability_100T1_mask = &H1
        if data_low > LONG_MAX then
            if ability_100T1_mask = mask then
                read_ability_100T1_value = data_low
            else
                read_ability_100T1_value = (data_low - H8000_0000) and ability_100T1_mask
            end If
        else
            read_ability_100T1_value = data_low and ability_100T1_mask
        end If

    End Sub

    Sub write
        If flag_ability_1000T1 = &H0 or flag_ability_100T1 = &H0 Then read
        If flag_ability_1000T1 = &H0 Then write_ability_1000T1_value = get_ability_1000T1
        If flag_ability_100T1 = &H0 Then write_ability_100T1_value = get_ability_100T1

        regValue = leftShift((write_ability_1000T1_value and &H1), 1) + leftShift((write_ability_100T1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ability_1000T1_value = rightShift(data_low, 1) and &H1
        ability_100T1_mask = &H1
        if data_low > LONG_MAX then
            if ability_100T1_mask = mask then
                read_ability_100T1_value = data_low
            else
                read_ability_100T1_value = (data_low - H8000_0000) and ability_100T1_mask
            end If
        else
            read_ability_100T1_value = data_low and ability_100T1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ability_1000T1_value = &H0
        flag_ability_1000T1        = &H0
        write_ability_100T1_value = &H0
        flag_ability_100T1        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_tx_path_data_delay_max_l
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
Class REGISTER_PMA_PMD_IEEE_tx_path_data_delay_max_l
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


'' @REGISTER : PMA_PMD_IEEE_tx_path_data_delay_max_u
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
Class REGISTER_PMA_PMD_IEEE_tx_path_data_delay_max_u
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


'' @REGISTER : PMA_PMD_IEEE_tx_path_data_delay_min_l
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
Class REGISTER_PMA_PMD_IEEE_tx_path_data_delay_min_l
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


'' @REGISTER : PMA_PMD_IEEE_tx_path_data_delay_min_u
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
Class REGISTER_PMA_PMD_IEEE_tx_path_data_delay_min_u
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


'' @REGISTER : PMA_PMD_IEEE_rx_path_data_delay_max_l
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
Class REGISTER_PMA_PMD_IEEE_rx_path_data_delay_max_l
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


'' @REGISTER : PMA_PMD_IEEE_rx_path_data_delay_max_u
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TTPDM                                      [15:0]           get_TTPDM
''                                                             set_TTPDM
''                                                             read_TTPDM
''                                                             write_TTPDM
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_rx_path_data_delay_max_u
    Private write_TTPDM_value
    Private read_TTPDM_value
    Private flag_TTPDM

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

    Property Get get_TTPDM
        get_TTPDM = read_TTPDM_value
    End Property

    Property Let set_TTPDM(aData)
        write_TTPDM_value = aData
        flag_TTPDM        = &H1
    End Property

    Property Get read_TTPDM
        read
        read_TTPDM = read_TTPDM_value
    End Property

    Property Let write_TTPDM(aData)
        set_TTPDM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPDM_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPDM_mask = mask then
                read_TTPDM_value = data_low
            else
                read_TTPDM_value = (data_low - H8000_0000) and TTPDM_mask
            end If
        else
            read_TTPDM_value = data_low and TTPDM_mask
        end If

    End Sub

    Sub write
        If flag_TTPDM = &H0 Then read
        If flag_TTPDM = &H0 Then write_TTPDM_value = get_TTPDM

        regValue = leftShift((write_TTPDM_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TTPDM_mask = &Hffff
        if data_low > LONG_MAX then
            if TTPDM_mask = mask then
                read_TTPDM_value = data_low
            else
                read_TTPDM_value = (data_low - H8000_0000) and TTPDM_mask
            end If
        else
            read_TTPDM_value = data_low and TTPDM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TTPDM_value = &H0
        flag_TTPDM        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_rx_path_data_delay_min_l
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
Class REGISTER_PMA_PMD_IEEE_rx_path_data_delay_min_l
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


'' @REGISTER : PMA_PMD_IEEE_rx_path_data_delay_min_u
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
Class REGISTER_PMA_PMD_IEEE_rx_path_data_delay_min_u
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


'' @REGISTER : PMA_PMD_IEEE_baset1_pma_pmd_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BaseT1_PMA_PMD_Control_bit_15              [15:15]          get_BaseT1_PMA_PMD_Control_bit_15
''                                                             set_BaseT1_PMA_PMD_Control_bit_15
''                                                             read_BaseT1_PMA_PMD_Control_bit_15
''                                                             write_BaseT1_PMA_PMD_Control_bit_15
''---------------------------------------------------------------------------------
'' master_slave                               [14:14]          get_master_slave
''                                                             set_master_slave
''                                                             read_master_slave
''                                                             write_master_slave
''---------------------------------------------------------------------------------
'' T1_BASE_SEL                                [3:0]            get_T1_BASE_SEL
''                                                             set_T1_BASE_SEL
''                                                             read_T1_BASE_SEL
''                                                             write_T1_BASE_SEL
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_baset1_pma_pmd_control
    Private write_BaseT1_PMA_PMD_Control_bit_15_value
    Private read_BaseT1_PMA_PMD_Control_bit_15_value
    Private flag_BaseT1_PMA_PMD_Control_bit_15
    Private write_master_slave_value
    Private read_master_slave_value
    Private flag_master_slave
    Private write_T1_BASE_SEL_value
    Private read_T1_BASE_SEL_value
    Private flag_T1_BASE_SEL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1068
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BaseT1_PMA_PMD_Control_bit_15
        get_BaseT1_PMA_PMD_Control_bit_15 = read_BaseT1_PMA_PMD_Control_bit_15_value
    End Property

    Property Let set_BaseT1_PMA_PMD_Control_bit_15(aData)
        write_BaseT1_PMA_PMD_Control_bit_15_value = aData
        flag_BaseT1_PMA_PMD_Control_bit_15        = &H1
    End Property

    Property Get read_BaseT1_PMA_PMD_Control_bit_15
        read
        read_BaseT1_PMA_PMD_Control_bit_15 = read_BaseT1_PMA_PMD_Control_bit_15_value
    End Property

    Property Let write_BaseT1_PMA_PMD_Control_bit_15(aData)
        set_BaseT1_PMA_PMD_Control_bit_15 = aData
        write
    End Property

    Property Get get_master_slave
        get_master_slave = read_master_slave_value
    End Property

    Property Let set_master_slave(aData)
        write_master_slave_value = aData
        flag_master_slave        = &H1
    End Property

    Property Get read_master_slave
        read
        read_master_slave = read_master_slave_value
    End Property

    Property Let write_master_slave(aData)
        set_master_slave = aData
        write
    End Property

    Property Get get_T1_BASE_SEL
        get_T1_BASE_SEL = read_T1_BASE_SEL_value
    End Property

    Property Let set_T1_BASE_SEL(aData)
        write_T1_BASE_SEL_value = aData
        flag_T1_BASE_SEL        = &H1
    End Property

    Property Get read_T1_BASE_SEL
        read
        read_T1_BASE_SEL = read_T1_BASE_SEL_value
    End Property

    Property Let write_T1_BASE_SEL(aData)
        set_T1_BASE_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BaseT1_PMA_PMD_Control_bit_15_value = rightShift(data_low, 15) and &H1
        read_master_slave_value = rightShift(data_low, 14) and &H1
        T1_BASE_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if T1_BASE_SEL_mask = mask then
                read_T1_BASE_SEL_value = data_low
            else
                read_T1_BASE_SEL_value = (data_low - H8000_0000) and T1_BASE_SEL_mask
            end If
        else
            read_T1_BASE_SEL_value = data_low and T1_BASE_SEL_mask
        end If

    End Sub

    Sub write
        If flag_BaseT1_PMA_PMD_Control_bit_15 = &H0 or flag_master_slave = &H0 or flag_T1_BASE_SEL = &H0 Then read
        If flag_BaseT1_PMA_PMD_Control_bit_15 = &H0 Then write_BaseT1_PMA_PMD_Control_bit_15_value = get_BaseT1_PMA_PMD_Control_bit_15
        If flag_master_slave = &H0 Then write_master_slave_value = get_master_slave
        If flag_T1_BASE_SEL = &H0 Then write_T1_BASE_SEL_value = get_T1_BASE_SEL

        regValue = leftShift((write_BaseT1_PMA_PMD_Control_bit_15_value and &H1), 15) + leftShift((write_master_slave_value and &H1), 14) + leftShift((write_T1_BASE_SEL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BaseT1_PMA_PMD_Control_bit_15_value = rightShift(data_low, 15) and &H1
        read_master_slave_value = rightShift(data_low, 14) and &H1
        T1_BASE_SEL_mask = &Hf
        if data_low > LONG_MAX then
            if T1_BASE_SEL_mask = mask then
                read_T1_BASE_SEL_value = data_low
            else
                read_T1_BASE_SEL_value = (data_low - H8000_0000) and T1_BASE_SEL_mask
            end If
        else
            read_T1_BASE_SEL_value = data_low and T1_BASE_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BaseT1_PMA_PMD_Control_bit_15_value = &H0
        flag_BaseT1_PMA_PMD_Control_bit_15        = &H0
        write_master_slave_value = &H0
        flag_master_slave        = &H0
        write_T1_BASE_SEL_value = &H0
        flag_T1_BASE_SEL        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_base100t1_pma_pmd_test_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' test_control                               [15:13]          get_test_control
''                                                             set_test_control
''                                                             read_test_control
''                                                             write_test_control
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_base100t1_pma_pmd_test_control
    Private write_test_control_value
    Private read_test_control_value
    Private flag_test_control

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H106c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_test_control
        get_test_control = read_test_control_value
    End Property

    Property Let set_test_control(aData)
        write_test_control_value = aData
        flag_test_control        = &H1
    End Property

    Property Get read_test_control
        read
        read_test_control = read_test_control_value
    End Property

    Property Let write_test_control(aData)
        set_test_control = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_test_control_value = rightShift(data_low, 13) and &H7

    End Sub

    Sub write
        If flag_test_control = &H0 Then read
        If flag_test_control = &H0 Then write_test_control_value = get_test_control

        regValue = leftShift((write_test_control_value and &H7), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_test_control_value = rightShift(data_low, 13) and &H7

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_test_control_value = &H0
        flag_test_control        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_base1000t1_pma_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA_PMD_reset                              [15:15]          get_PMA_PMD_reset
''                                                             set_PMA_PMD_reset
''                                                             read_PMA_PMD_reset
''                                                             write_PMA_PMD_reset
''---------------------------------------------------------------------------------
'' Transmit_disable                           [14:14]          get_Transmit_disable
''                                                             set_Transmit_disable
''                                                             read_Transmit_disable
''                                                             write_Transmit_disable
''---------------------------------------------------------------------------------
'' Low_power                                  [11:11]          get_Low_power
''                                                             set_Low_power
''                                                             read_Low_power
''                                                             write_Low_power
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_base1000t1_pma_control
    Private write_PMA_PMD_reset_value
    Private read_PMA_PMD_reset_value
    Private flag_PMA_PMD_reset
    Private write_Transmit_disable_value
    Private read_Transmit_disable_value
    Private flag_Transmit_disable
    Private write_Low_power_value
    Private read_Low_power_value
    Private flag_Low_power

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

    Property Get get_PMA_PMD_reset
        get_PMA_PMD_reset = read_PMA_PMD_reset_value
    End Property

    Property Let set_PMA_PMD_reset(aData)
        write_PMA_PMD_reset_value = aData
        flag_PMA_PMD_reset        = &H1
    End Property

    Property Get read_PMA_PMD_reset
        read
        read_PMA_PMD_reset = read_PMA_PMD_reset_value
    End Property

    Property Let write_PMA_PMD_reset(aData)
        set_PMA_PMD_reset = aData
        write
    End Property

    Property Get get_Transmit_disable
        get_Transmit_disable = read_Transmit_disable_value
    End Property

    Property Let set_Transmit_disable(aData)
        write_Transmit_disable_value = aData
        flag_Transmit_disable        = &H1
    End Property

    Property Get read_Transmit_disable
        read
        read_Transmit_disable = read_Transmit_disable_value
    End Property

    Property Let write_Transmit_disable(aData)
        set_Transmit_disable = aData
        write
    End Property

    Property Get get_Low_power
        get_Low_power = read_Low_power_value
    End Property

    Property Let set_Low_power(aData)
        write_Low_power_value = aData
        flag_Low_power        = &H1
    End Property

    Property Get read_Low_power
        read
        read_Low_power = read_Low_power_value
    End Property

    Property Let write_Low_power(aData)
        set_Low_power = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMA_PMD_reset_value = rightShift(data_low, 15) and &H1
        read_Transmit_disable_value = rightShift(data_low, 14) and &H1
        read_Low_power_value = rightShift(data_low, 11) and &H1

    End Sub

    Sub write
        If flag_PMA_PMD_reset = &H0 or flag_Transmit_disable = &H0 or flag_Low_power = &H0 Then read
        If flag_PMA_PMD_reset = &H0 Then write_PMA_PMD_reset_value = get_PMA_PMD_reset
        If flag_Transmit_disable = &H0 Then write_Transmit_disable_value = get_Transmit_disable
        If flag_Low_power = &H0 Then write_Low_power_value = get_Low_power

        regValue = leftShift((write_PMA_PMD_reset_value and &H1), 15) + leftShift((write_Transmit_disable_value and &H1), 14) + leftShift((write_Low_power_value and &H1), 11)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMA_PMD_reset_value = rightShift(data_low, 15) and &H1
        read_Transmit_disable_value = rightShift(data_low, 14) and &H1
        read_Low_power_value = rightShift(data_low, 11) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA_PMD_reset_value = &H0
        flag_PMA_PMD_reset        = &H0
        write_Transmit_disable_value = &H0
        flag_Transmit_disable        = &H0
        write_Low_power_value = &H0
        flag_Low_power        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_base1000t1_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' A10001O                                    [11:11]          get_A10001O
''                                                             set_A10001O
''                                                             read_A10001O
''                                                             write_A10001O
''---------------------------------------------------------------------------------
'' EEE_Ability                                [10:10]          get_EEE_Ability
''                                                             set_EEE_Ability
''                                                             read_EEE_Ability
''                                                             write_EEE_Ability
''---------------------------------------------------------------------------------
'' Receive_fault_ability                      [9:9]            get_Receive_fault_ability
''                                                             set_Receive_fault_ability
''                                                             read_Receive_fault_ability
''                                                             write_Receive_fault_ability
''---------------------------------------------------------------------------------
'' Low_power_ability                          [8:8]            get_Low_power_ability
''                                                             set_Low_power_ability
''                                                             read_Low_power_ability
''                                                             write_Low_power_ability
''---------------------------------------------------------------------------------
'' Receive_polarity                           [2:2]            get_Receive_polarity
''                                                             set_Receive_polarity
''                                                             read_Receive_polarity
''                                                             write_Receive_polarity
''---------------------------------------------------------------------------------
'' Receive_fault                              [1:1]            get_Receive_fault
''                                                             set_Receive_fault
''                                                             read_Receive_fault
''                                                             write_Receive_fault
''---------------------------------------------------------------------------------
'' Receive_link_status                        [0:0]            get_Receive_link_status
''                                                             set_Receive_link_status
''                                                             read_Receive_link_status
''                                                             write_Receive_link_status
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_base1000t1_status
    Private write_A10001O_value
    Private read_A10001O_value
    Private flag_A10001O
    Private write_EEE_Ability_value
    Private read_EEE_Ability_value
    Private flag_EEE_Ability
    Private write_Receive_fault_ability_value
    Private read_Receive_fault_ability_value
    Private flag_Receive_fault_ability
    Private write_Low_power_ability_value
    Private read_Low_power_ability_value
    Private flag_Low_power_ability
    Private write_Receive_polarity_value
    Private read_Receive_polarity_value
    Private flag_Receive_polarity
    Private write_Receive_fault_value
    Private read_Receive_fault_value
    Private flag_Receive_fault
    Private write_Receive_link_status_value
    Private read_Receive_link_status_value
    Private flag_Receive_link_status

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

    Property Get get_A10001O
        get_A10001O = read_A10001O_value
    End Property

    Property Let set_A10001O(aData)
        write_A10001O_value = aData
        flag_A10001O        = &H1
    End Property

    Property Get read_A10001O
        read
        read_A10001O = read_A10001O_value
    End Property

    Property Let write_A10001O(aData)
        set_A10001O = aData
        write
    End Property

    Property Get get_EEE_Ability
        get_EEE_Ability = read_EEE_Ability_value
    End Property

    Property Let set_EEE_Ability(aData)
        write_EEE_Ability_value = aData
        flag_EEE_Ability        = &H1
    End Property

    Property Get read_EEE_Ability
        read
        read_EEE_Ability = read_EEE_Ability_value
    End Property

    Property Let write_EEE_Ability(aData)
        set_EEE_Ability = aData
        write
    End Property

    Property Get get_Receive_fault_ability
        get_Receive_fault_ability = read_Receive_fault_ability_value
    End Property

    Property Let set_Receive_fault_ability(aData)
        write_Receive_fault_ability_value = aData
        flag_Receive_fault_ability        = &H1
    End Property

    Property Get read_Receive_fault_ability
        read
        read_Receive_fault_ability = read_Receive_fault_ability_value
    End Property

    Property Let write_Receive_fault_ability(aData)
        set_Receive_fault_ability = aData
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

    Property Get get_Receive_polarity
        get_Receive_polarity = read_Receive_polarity_value
    End Property

    Property Let set_Receive_polarity(aData)
        write_Receive_polarity_value = aData
        flag_Receive_polarity        = &H1
    End Property

    Property Get read_Receive_polarity
        read
        read_Receive_polarity = read_Receive_polarity_value
    End Property

    Property Let write_Receive_polarity(aData)
        set_Receive_polarity = aData
        write
    End Property

    Property Get get_Receive_fault
        get_Receive_fault = read_Receive_fault_value
    End Property

    Property Let set_Receive_fault(aData)
        write_Receive_fault_value = aData
        flag_Receive_fault        = &H1
    End Property

    Property Get read_Receive_fault
        read
        read_Receive_fault = read_Receive_fault_value
    End Property

    Property Let write_Receive_fault(aData)
        set_Receive_fault = aData
        write
    End Property

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_A10001O_value = rightShift(data_low, 11) and &H1
        read_EEE_Ability_value = rightShift(data_low, 10) and &H1
        read_Receive_fault_ability_value = rightShift(data_low, 9) and &H1
        read_Low_power_ability_value = rightShift(data_low, 8) and &H1
        read_Receive_polarity_value = rightShift(data_low, 2) and &H1
        read_Receive_fault_value = rightShift(data_low, 1) and &H1
        Receive_link_status_mask = &H1
        if data_low > LONG_MAX then
            if Receive_link_status_mask = mask then
                read_Receive_link_status_value = data_low
            else
                read_Receive_link_status_value = (data_low - H8000_0000) and Receive_link_status_mask
            end If
        else
            read_Receive_link_status_value = data_low and Receive_link_status_mask
        end If

    End Sub

    Sub write
        If flag_A10001O = &H0 or flag_EEE_Ability = &H0 or flag_Receive_fault_ability = &H0 or flag_Low_power_ability = &H0 or flag_Receive_polarity = &H0 or flag_Receive_fault = &H0 or flag_Receive_link_status = &H0 Then read
        If flag_A10001O = &H0 Then write_A10001O_value = get_A10001O
        If flag_EEE_Ability = &H0 Then write_EEE_Ability_value = get_EEE_Ability
        If flag_Receive_fault_ability = &H0 Then write_Receive_fault_ability_value = get_Receive_fault_ability
        If flag_Low_power_ability = &H0 Then write_Low_power_ability_value = get_Low_power_ability
        If flag_Receive_polarity = &H0 Then write_Receive_polarity_value = get_Receive_polarity
        If flag_Receive_fault = &H0 Then write_Receive_fault_value = get_Receive_fault
        If flag_Receive_link_status = &H0 Then write_Receive_link_status_value = get_Receive_link_status

        regValue = leftShift((write_A10001O_value and &H1), 11) + leftShift((write_EEE_Ability_value and &H1), 10) + leftShift((write_Receive_fault_ability_value and &H1), 9) + leftShift((write_Low_power_ability_value and &H1), 8) + leftShift((write_Receive_polarity_value and &H1), 2) + leftShift((write_Receive_fault_value and &H1), 1) + leftShift((write_Receive_link_status_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_A10001O_value = rightShift(data_low, 11) and &H1
        read_EEE_Ability_value = rightShift(data_low, 10) and &H1
        read_Receive_fault_ability_value = rightShift(data_low, 9) and &H1
        read_Low_power_ability_value = rightShift(data_low, 8) and &H1
        read_Receive_polarity_value = rightShift(data_low, 2) and &H1
        read_Receive_fault_value = rightShift(data_low, 1) and &H1
        Receive_link_status_mask = &H1
        if data_low > LONG_MAX then
            if Receive_link_status_mask = mask then
                read_Receive_link_status_value = data_low
            else
                read_Receive_link_status_value = (data_low - H8000_0000) and Receive_link_status_mask
            end If
        else
            read_Receive_link_status_value = data_low and Receive_link_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_A10001O_value = &H0
        flag_A10001O        = &H0
        write_EEE_Ability_value = &H0
        flag_EEE_Ability        = &H0
        write_Receive_fault_ability_value = &H0
        flag_Receive_fault_ability        = &H0
        write_Low_power_ability_value = &H0
        flag_Low_power_ability        = &H0
        write_Receive_polarity_value = &H0
        flag_Receive_polarity        = &H0
        write_Receive_fault_value = &H0
        flag_Receive_fault        = &H0
        write_Receive_link_status_value = &H0
        flag_Receive_link_status        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_base1000t1_training
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' User_field_7                               [10:4]           get_User_field_7
''                                                             set_User_field_7
''                                                             read_User_field_7
''                                                             write_User_field_7
''---------------------------------------------------------------------------------
'' A10001O                                    [1:1]            get_A10001O
''                                                             set_A10001O
''                                                             read_A10001O
''                                                             write_A10001O
''---------------------------------------------------------------------------------
'' EEE_advertisement                          [0:0]            get_EEE_advertisement
''                                                             set_EEE_advertisement
''                                                             read_EEE_advertisement
''                                                             write_EEE_advertisement
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_base1000t1_training
    Private write_User_field_7_value
    Private read_User_field_7_value
    Private flag_User_field_7
    Private write_A10001O_value
    Private read_A10001O_value
    Private flag_A10001O
    Private write_EEE_advertisement_value
    Private read_EEE_advertisement_value
    Private flag_EEE_advertisement

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

    Property Get get_User_field_7
        get_User_field_7 = read_User_field_7_value
    End Property

    Property Let set_User_field_7(aData)
        write_User_field_7_value = aData
        flag_User_field_7        = &H1
    End Property

    Property Get read_User_field_7
        read
        read_User_field_7 = read_User_field_7_value
    End Property

    Property Let write_User_field_7(aData)
        set_User_field_7 = aData
        write
    End Property

    Property Get get_A10001O
        get_A10001O = read_A10001O_value
    End Property

    Property Let set_A10001O(aData)
        write_A10001O_value = aData
        flag_A10001O        = &H1
    End Property

    Property Get read_A10001O
        read
        read_A10001O = read_A10001O_value
    End Property

    Property Let write_A10001O(aData)
        set_A10001O = aData
        write
    End Property

    Property Get get_EEE_advertisement
        get_EEE_advertisement = read_EEE_advertisement_value
    End Property

    Property Let set_EEE_advertisement(aData)
        write_EEE_advertisement_value = aData
        flag_EEE_advertisement        = &H1
    End Property

    Property Get read_EEE_advertisement
        read
        read_EEE_advertisement = read_EEE_advertisement_value
    End Property

    Property Let write_EEE_advertisement(aData)
        set_EEE_advertisement = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_User_field_7_value = rightShift(data_low, 4) and &H7f
        read_A10001O_value = rightShift(data_low, 1) and &H1
        EEE_advertisement_mask = &H1
        if data_low > LONG_MAX then
            if EEE_advertisement_mask = mask then
                read_EEE_advertisement_value = data_low
            else
                read_EEE_advertisement_value = (data_low - H8000_0000) and EEE_advertisement_mask
            end If
        else
            read_EEE_advertisement_value = data_low and EEE_advertisement_mask
        end If

    End Sub

    Sub write
        If flag_User_field_7 = &H0 or flag_A10001O = &H0 or flag_EEE_advertisement = &H0 Then read
        If flag_User_field_7 = &H0 Then write_User_field_7_value = get_User_field_7
        If flag_A10001O = &H0 Then write_A10001O_value = get_A10001O
        If flag_EEE_advertisement = &H0 Then write_EEE_advertisement_value = get_EEE_advertisement

        regValue = leftShift((write_User_field_7_value and &H7f), 4) + leftShift((write_A10001O_value and &H1), 1) + leftShift((write_EEE_advertisement_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_User_field_7_value = rightShift(data_low, 4) and &H7f
        read_A10001O_value = rightShift(data_low, 1) and &H1
        EEE_advertisement_mask = &H1
        if data_low > LONG_MAX then
            if EEE_advertisement_mask = mask then
                read_EEE_advertisement_value = data_low
            else
                read_EEE_advertisement_value = (data_low - H8000_0000) and EEE_advertisement_mask
            end If
        else
            read_EEE_advertisement_value = data_low and EEE_advertisement_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_User_field_7_value = &H0
        flag_User_field_7        = &H0
        write_A10001O_value = &H0
        flag_A10001O        = &H0
        write_EEE_advertisement_value = &H0
        flag_EEE_advertisement        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_base1000t1_link_partner_training
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Link_partner_user_field                    [10:4]           get_Link_partner_user_field
''                                                             set_Link_partner_user_field
''                                                             read_Link_partner_user_field
''                                                             write_Link_partner_user_field
''---------------------------------------------------------------------------------
'' LP10001O                                   [1:1]            get_LP10001O
''                                                             set_LP10001O
''                                                             read_LP10001O
''                                                             write_LP10001O
''---------------------------------------------------------------------------------
'' LPEA                                       [0:0]            get_LPEA
''                                                             set_LPEA
''                                                             read_LPEA
''                                                             write_LPEA
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_base1000t1_link_partner_training
    Private write_Link_partner_user_field_value
    Private read_Link_partner_user_field_value
    Private flag_Link_partner_user_field
    Private write_LP10001O_value
    Private read_LP10001O_value
    Private flag_LP10001O
    Private write_LPEA_value
    Private read_LPEA_value
    Private flag_LPEA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1206
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Link_partner_user_field
        get_Link_partner_user_field = read_Link_partner_user_field_value
    End Property

    Property Let set_Link_partner_user_field(aData)
        write_Link_partner_user_field_value = aData
        flag_Link_partner_user_field        = &H1
    End Property

    Property Get read_Link_partner_user_field
        read
        read_Link_partner_user_field = read_Link_partner_user_field_value
    End Property

    Property Let write_Link_partner_user_field(aData)
        set_Link_partner_user_field = aData
        write
    End Property

    Property Get get_LP10001O
        get_LP10001O = read_LP10001O_value
    End Property

    Property Let set_LP10001O(aData)
        write_LP10001O_value = aData
        flag_LP10001O        = &H1
    End Property

    Property Get read_LP10001O
        read
        read_LP10001O = read_LP10001O_value
    End Property

    Property Let write_LP10001O(aData)
        set_LP10001O = aData
        write
    End Property

    Property Get get_LPEA
        get_LPEA = read_LPEA_value
    End Property

    Property Let set_LPEA(aData)
        write_LPEA_value = aData
        flag_LPEA        = &H1
    End Property

    Property Get read_LPEA
        read
        read_LPEA = read_LPEA_value
    End Property

    Property Let write_LPEA(aData)
        set_LPEA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Link_partner_user_field_value = rightShift(data_low, 4) and &H7f
        read_LP10001O_value = rightShift(data_low, 1) and &H1
        LPEA_mask = &H1
        if data_low > LONG_MAX then
            if LPEA_mask = mask then
                read_LPEA_value = data_low
            else
                read_LPEA_value = (data_low - H8000_0000) and LPEA_mask
            end If
        else
            read_LPEA_value = data_low and LPEA_mask
        end If

    End Sub

    Sub write
        If flag_Link_partner_user_field = &H0 or flag_LP10001O = &H0 or flag_LPEA = &H0 Then read
        If flag_Link_partner_user_field = &H0 Then write_Link_partner_user_field_value = get_Link_partner_user_field
        If flag_LP10001O = &H0 Then write_LP10001O_value = get_LP10001O
        If flag_LPEA = &H0 Then write_LPEA_value = get_LPEA

        regValue = leftShift((write_Link_partner_user_field_value and &H7f), 4) + leftShift((write_LP10001O_value and &H1), 1) + leftShift((write_LPEA_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Link_partner_user_field_value = rightShift(data_low, 4) and &H7f
        read_LP10001O_value = rightShift(data_low, 1) and &H1
        LPEA_mask = &H1
        if data_low > LONG_MAX then
            if LPEA_mask = mask then
                read_LPEA_value = data_low
            else
                read_LPEA_value = (data_low - H8000_0000) and LPEA_mask
            end If
        else
            read_LPEA_value = data_low and LPEA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Link_partner_user_field_value = &H0
        flag_Link_partner_user_field        = &H0
        write_LP10001O_value = &H0
        flag_LP10001O        = &H0
        write_LPEA_value = &H0
        flag_LPEA        = &H0
    End Sub
End Class


'' @REGISTER : PMA_PMD_IEEE_base1000t1_test_mode_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Test_mode_control                          [15:13]          get_Test_mode_control
''                                                             set_Test_mode_control
''                                                             read_Test_mode_control
''                                                             write_Test_mode_control
''---------------------------------------------------------------------------------
Class REGISTER_PMA_PMD_IEEE_base1000t1_test_mode_control
    Private write_Test_mode_control_value
    Private read_Test_mode_control_value
    Private flag_Test_mode_control

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

    Property Get get_Test_mode_control
        get_Test_mode_control = read_Test_mode_control_value
    End Property

    Property Let set_Test_mode_control(aData)
        write_Test_mode_control_value = aData
        flag_Test_mode_control        = &H1
    End Property

    Property Get read_Test_mode_control
        read
        read_Test_mode_control = read_Test_mode_control_value
    End Property

    Property Let write_Test_mode_control(aData)
        set_Test_mode_control = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Test_mode_control_value = rightShift(data_low, 13) and &H7

    End Sub

    Sub write
        If flag_Test_mode_control = &H0 Then read
        If flag_Test_mode_control = &H0 Then write_Test_mode_control_value = get_Test_mode_control

        regValue = leftShift((write_Test_mode_control_value and &H7), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Test_mode_control_value = rightShift(data_low, 13) and &H7

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Test_mode_control_value = &H0
        flag_Test_mode_control        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PMA_PMD_IEEE_INSTANCE

    Public control_reg1
    Public status_reg1
    Public device_id_reg0
    Public device_id_reg1
    Public pma_pmd_speed_ability_register
    Public device_in_package_reg0
    Public device_in_package_reg1
    Public control_reg2
    Public status_reg2
    Public transmit_disable_reg
    Public receive_signal_det_reg
    Public extended_ability_reg
    Public package_id_reg0
    Public package_id_reg1
    Public baset1_pma_pmd_extended_ability
    Public timesync_capability
    Public tx_path_data_delay_max_l
    Public tx_path_data_delay_max_u
    Public tx_path_data_delay_min_l
    Public tx_path_data_delay_min_u
    Public rx_path_data_delay_max_l
    Public rx_path_data_delay_max_u
    Public rx_path_data_delay_min_l
    Public rx_path_data_delay_min_u
    Public baset1_pma_pmd_control
    Public base100t1_pma_pmd_test_control
    Public base1000t1_pma_control
    Public base1000t1_status
    Public base1000t1_training
    Public base1000t1_link_partner_training
    Public base1000t1_test_mode_control


    Public default function Init(aBaseAddr)
        Set control_reg1 = (New REGISTER_PMA_PMD_IEEE_control_reg1)(aBaseAddr, 16)
        Set status_reg1 = (New REGISTER_PMA_PMD_IEEE_status_reg1)(aBaseAddr, 16)
        Set device_id_reg0 = (New REGISTER_PMA_PMD_IEEE_device_id_reg0)(aBaseAddr, 16)
        Set device_id_reg1 = (New REGISTER_PMA_PMD_IEEE_device_id_reg1)(aBaseAddr, 16)
        Set pma_pmd_speed_ability_register = (New REGISTER_PMA_PMD_IEEE_pma_pmd_speed_ability_register)(aBaseAddr, 16)
        Set device_in_package_reg0 = (New REGISTER_PMA_PMD_IEEE_device_in_package_reg0)(aBaseAddr, 16)
        Set device_in_package_reg1 = (New REGISTER_PMA_PMD_IEEE_device_in_package_reg1)(aBaseAddr, 16)
        Set control_reg2 = (New REGISTER_PMA_PMD_IEEE_control_reg2)(aBaseAddr, 16)
        Set status_reg2 = (New REGISTER_PMA_PMD_IEEE_status_reg2)(aBaseAddr, 16)
        Set transmit_disable_reg = (New REGISTER_PMA_PMD_IEEE_transmit_disable_reg)(aBaseAddr, 16)
        Set receive_signal_det_reg = (New REGISTER_PMA_PMD_IEEE_receive_signal_det_reg)(aBaseAddr, 16)
        Set extended_ability_reg = (New REGISTER_PMA_PMD_IEEE_extended_ability_reg)(aBaseAddr, 16)
        Set package_id_reg0 = (New REGISTER_PMA_PMD_IEEE_package_id_reg0)(aBaseAddr, 16)
        Set package_id_reg1 = (New REGISTER_PMA_PMD_IEEE_package_id_reg1)(aBaseAddr, 16)
        Set baset1_pma_pmd_extended_ability = (New REGISTER_PMA_PMD_IEEE_baset1_pma_pmd_extended_ability)(aBaseAddr, 16)
        Set timesync_capability = (New REGISTER_PMA_PMD_IEEE_timesync_capability)(aBaseAddr, 16)
        Set tx_path_data_delay_max_l = (New REGISTER_PMA_PMD_IEEE_tx_path_data_delay_max_l)(aBaseAddr, 16)
        Set tx_path_data_delay_max_u = (New REGISTER_PMA_PMD_IEEE_tx_path_data_delay_max_u)(aBaseAddr, 16)
        Set tx_path_data_delay_min_l = (New REGISTER_PMA_PMD_IEEE_tx_path_data_delay_min_l)(aBaseAddr, 16)
        Set tx_path_data_delay_min_u = (New REGISTER_PMA_PMD_IEEE_tx_path_data_delay_min_u)(aBaseAddr, 16)
        Set rx_path_data_delay_max_l = (New REGISTER_PMA_PMD_IEEE_rx_path_data_delay_max_l)(aBaseAddr, 16)
        Set rx_path_data_delay_max_u = (New REGISTER_PMA_PMD_IEEE_rx_path_data_delay_max_u)(aBaseAddr, 16)
        Set rx_path_data_delay_min_l = (New REGISTER_PMA_PMD_IEEE_rx_path_data_delay_min_l)(aBaseAddr, 16)
        Set rx_path_data_delay_min_u = (New REGISTER_PMA_PMD_IEEE_rx_path_data_delay_min_u)(aBaseAddr, 16)
        Set baset1_pma_pmd_control = (New REGISTER_PMA_PMD_IEEE_baset1_pma_pmd_control)(aBaseAddr, 16)
        Set base100t1_pma_pmd_test_control = (New REGISTER_PMA_PMD_IEEE_base100t1_pma_pmd_test_control)(aBaseAddr, 16)
        Set base1000t1_pma_control = (New REGISTER_PMA_PMD_IEEE_base1000t1_pma_control)(aBaseAddr, 16)
        Set base1000t1_status = (New REGISTER_PMA_PMD_IEEE_base1000t1_status)(aBaseAddr, 16)
        Set base1000t1_training = (New REGISTER_PMA_PMD_IEEE_base1000t1_training)(aBaseAddr, 16)
        Set base1000t1_link_partner_training = (New REGISTER_PMA_PMD_IEEE_base1000t1_link_partner_training)(aBaseAddr, 16)
        Set base1000t1_test_mode_control = (New REGISTER_PMA_PMD_IEEE_base1000t1_test_mode_control)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PMA_PMD_IEEE = CreateObject("System.Collections.ArrayList")
PMA_PMD_IEEE.Add ((New PMA_PMD_IEEE_INSTANCE)(&H49020000))


