

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


'' @REGISTER : CL45DEV7_an_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AN_reset                                   [15:15]          get_AN_reset
''                                                             set_AN_reset
''                                                             read_AN_reset
''                                                             write_AN_reset
''---------------------------------------------------------------------------------
'' Extended_next_page_control                 [13:13]          get_Extended_next_page_control
''                                                             set_Extended_next_page_control
''                                                             read_Extended_next_page_control
''                                                             write_Extended_next_page_control
''---------------------------------------------------------------------------------
'' Auto_Negotiation_enable                    [12:12]          get_Auto_Negotiation_enable
''                                                             set_Auto_Negotiation_enable
''                                                             read_Auto_Negotiation_enable
''                                                             write_Auto_Negotiation_enable
''---------------------------------------------------------------------------------
'' Restart_Auto_Negotiation                   [9:9]            get_Restart_Auto_Negotiation
''                                                             set_Restart_Auto_Negotiation
''                                                             read_Restart_Auto_Negotiation
''                                                             write_Restart_Auto_Negotiation
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_ctrl
    Private write_AN_reset_value
    Private read_AN_reset_value
    Private flag_AN_reset
    Private write_Extended_next_page_control_value
    Private read_Extended_next_page_control_value
    Private flag_Extended_next_page_control
    Private write_Auto_Negotiation_enable_value
    Private read_Auto_Negotiation_enable_value
    Private flag_Auto_Negotiation_enable
    Private write_Restart_Auto_Negotiation_value
    Private read_Restart_Auto_Negotiation_value
    Private flag_Restart_Auto_Negotiation

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

    Property Get get_AN_reset
        get_AN_reset = read_AN_reset_value
    End Property

    Property Let set_AN_reset(aData)
        write_AN_reset_value = aData
        flag_AN_reset        = &H1
    End Property

    Property Get read_AN_reset
        read
        read_AN_reset = read_AN_reset_value
    End Property

    Property Let write_AN_reset(aData)
        set_AN_reset = aData
        write
    End Property

    Property Get get_Extended_next_page_control
        get_Extended_next_page_control = read_Extended_next_page_control_value
    End Property

    Property Let set_Extended_next_page_control(aData)
        write_Extended_next_page_control_value = aData
        flag_Extended_next_page_control        = &H1
    End Property

    Property Get read_Extended_next_page_control
        read
        read_Extended_next_page_control = read_Extended_next_page_control_value
    End Property

    Property Let write_Extended_next_page_control(aData)
        set_Extended_next_page_control = aData
        write
    End Property

    Property Get get_Auto_Negotiation_enable
        get_Auto_Negotiation_enable = read_Auto_Negotiation_enable_value
    End Property

    Property Let set_Auto_Negotiation_enable(aData)
        write_Auto_Negotiation_enable_value = aData
        flag_Auto_Negotiation_enable        = &H1
    End Property

    Property Get read_Auto_Negotiation_enable
        read
        read_Auto_Negotiation_enable = read_Auto_Negotiation_enable_value
    End Property

    Property Let write_Auto_Negotiation_enable(aData)
        set_Auto_Negotiation_enable = aData
        write
    End Property

    Property Get get_Restart_Auto_Negotiation
        get_Restart_Auto_Negotiation = read_Restart_Auto_Negotiation_value
    End Property

    Property Let set_Restart_Auto_Negotiation(aData)
        write_Restart_Auto_Negotiation_value = aData
        flag_Restart_Auto_Negotiation        = &H1
    End Property

    Property Get read_Restart_Auto_Negotiation
        read
        read_Restart_Auto_Negotiation = read_Restart_Auto_Negotiation_value
    End Property

    Property Let write_Restart_Auto_Negotiation(aData)
        set_Restart_Auto_Negotiation = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AN_reset_value = rightShift(data_low, 15) and &H1
        read_Extended_next_page_control_value = rightShift(data_low, 13) and &H1
        read_Auto_Negotiation_enable_value = rightShift(data_low, 12) and &H1
        read_Restart_Auto_Negotiation_value = rightShift(data_low, 9) and &H1

    End Sub

    Sub write
        If flag_AN_reset = &H0 or flag_Extended_next_page_control = &H0 or flag_Auto_Negotiation_enable = &H0 or flag_Restart_Auto_Negotiation = &H0 Then read
        If flag_AN_reset = &H0 Then write_AN_reset_value = get_AN_reset
        If flag_Extended_next_page_control = &H0 Then write_Extended_next_page_control_value = get_Extended_next_page_control
        If flag_Auto_Negotiation_enable = &H0 Then write_Auto_Negotiation_enable_value = get_Auto_Negotiation_enable
        If flag_Restart_Auto_Negotiation = &H0 Then write_Restart_Auto_Negotiation_value = get_Restart_Auto_Negotiation

        regValue = leftShift((write_AN_reset_value and &H1), 15) + leftShift((write_Extended_next_page_control_value and &H1), 13) + leftShift((write_Auto_Negotiation_enable_value and &H1), 12) + leftShift((write_Restart_Auto_Negotiation_value and &H1), 9)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AN_reset_value = rightShift(data_low, 15) and &H1
        read_Extended_next_page_control_value = rightShift(data_low, 13) and &H1
        read_Auto_Negotiation_enable_value = rightShift(data_low, 12) and &H1
        read_Restart_Auto_Negotiation_value = rightShift(data_low, 9) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AN_reset_value = &H0
        flag_AN_reset        = &H0
        write_Extended_next_page_control_value = &H0
        flag_Extended_next_page_control        = &H0
        write_Auto_Negotiation_enable_value = &H0
        flag_Auto_Negotiation_enable        = &H0
        write_Restart_Auto_Negotiation_value = &H0
        flag_Restart_Auto_Negotiation        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Extended_next_page_status                  [7:7]            get_Extended_next_page_status
''                                                             set_Extended_next_page_status
''                                                             read_Extended_next_page_status
''                                                             write_Extended_next_page_status
''---------------------------------------------------------------------------------
'' Page_received                              [6:6]            get_Page_received
''                                                             set_Page_received
''                                                             read_Page_received
''                                                             write_Page_received
''---------------------------------------------------------------------------------
'' AN_complete                                [5:5]            get_AN_complete
''                                                             set_AN_complete
''                                                             read_AN_complete
''                                                             write_AN_complete
''---------------------------------------------------------------------------------
'' Remodt_Fault                               [4:4]            get_Remodt_Fault
''                                                             set_Remodt_Fault
''                                                             read_Remodt_Fault
''                                                             write_Remodt_Fault
''---------------------------------------------------------------------------------
'' AN_ability                                 [3:3]            get_AN_ability
''                                                             set_AN_ability
''                                                             read_AN_ability
''                                                             write_AN_ability
''---------------------------------------------------------------------------------
'' Link_status                                [2:2]            get_Link_status
''                                                             set_Link_status
''                                                             read_Link_status
''                                                             write_Link_status
''---------------------------------------------------------------------------------
'' Link_partner_AN_ability                    [0:0]            get_Link_partner_AN_ability
''                                                             set_Link_partner_AN_ability
''                                                             read_Link_partner_AN_ability
''                                                             write_Link_partner_AN_ability
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_stat
    Private write_Extended_next_page_status_value
    Private read_Extended_next_page_status_value
    Private flag_Extended_next_page_status
    Private write_Page_received_value
    Private read_Page_received_value
    Private flag_Page_received
    Private write_AN_complete_value
    Private read_AN_complete_value
    Private flag_AN_complete
    Private write_Remodt_Fault_value
    Private read_Remodt_Fault_value
    Private flag_Remodt_Fault
    Private write_AN_ability_value
    Private read_AN_ability_value
    Private flag_AN_ability
    Private write_Link_status_value
    Private read_Link_status_value
    Private flag_Link_status
    Private write_Link_partner_AN_ability_value
    Private read_Link_partner_AN_ability_value
    Private flag_Link_partner_AN_ability

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

    Property Get get_Extended_next_page_status
        get_Extended_next_page_status = read_Extended_next_page_status_value
    End Property

    Property Let set_Extended_next_page_status(aData)
        write_Extended_next_page_status_value = aData
        flag_Extended_next_page_status        = &H1
    End Property

    Property Get read_Extended_next_page_status
        read
        read_Extended_next_page_status = read_Extended_next_page_status_value
    End Property

    Property Let write_Extended_next_page_status(aData)
        set_Extended_next_page_status = aData
        write
    End Property

    Property Get get_Page_received
        get_Page_received = read_Page_received_value
    End Property

    Property Let set_Page_received(aData)
        write_Page_received_value = aData
        flag_Page_received        = &H1
    End Property

    Property Get read_Page_received
        read
        read_Page_received = read_Page_received_value
    End Property

    Property Let write_Page_received(aData)
        set_Page_received = aData
        write
    End Property

    Property Get get_AN_complete
        get_AN_complete = read_AN_complete_value
    End Property

    Property Let set_AN_complete(aData)
        write_AN_complete_value = aData
        flag_AN_complete        = &H1
    End Property

    Property Get read_AN_complete
        read
        read_AN_complete = read_AN_complete_value
    End Property

    Property Let write_AN_complete(aData)
        set_AN_complete = aData
        write
    End Property

    Property Get get_Remodt_Fault
        get_Remodt_Fault = read_Remodt_Fault_value
    End Property

    Property Let set_Remodt_Fault(aData)
        write_Remodt_Fault_value = aData
        flag_Remodt_Fault        = &H1
    End Property

    Property Get read_Remodt_Fault
        read
        read_Remodt_Fault = read_Remodt_Fault_value
    End Property

    Property Let write_Remodt_Fault(aData)
        set_Remodt_Fault = aData
        write
    End Property

    Property Get get_AN_ability
        get_AN_ability = read_AN_ability_value
    End Property

    Property Let set_AN_ability(aData)
        write_AN_ability_value = aData
        flag_AN_ability        = &H1
    End Property

    Property Get read_AN_ability
        read
        read_AN_ability = read_AN_ability_value
    End Property

    Property Let write_AN_ability(aData)
        set_AN_ability = aData
        write
    End Property

    Property Get get_Link_status
        get_Link_status = read_Link_status_value
    End Property

    Property Let set_Link_status(aData)
        write_Link_status_value = aData
        flag_Link_status        = &H1
    End Property

    Property Get read_Link_status
        read
        read_Link_status = read_Link_status_value
    End Property

    Property Let write_Link_status(aData)
        set_Link_status = aData
        write
    End Property

    Property Get get_Link_partner_AN_ability
        get_Link_partner_AN_ability = read_Link_partner_AN_ability_value
    End Property

    Property Let set_Link_partner_AN_ability(aData)
        write_Link_partner_AN_ability_value = aData
        flag_Link_partner_AN_ability        = &H1
    End Property

    Property Get read_Link_partner_AN_ability
        read
        read_Link_partner_AN_ability = read_Link_partner_AN_ability_value
    End Property

    Property Let write_Link_partner_AN_ability(aData)
        set_Link_partner_AN_ability = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Extended_next_page_status_value = rightShift(data_low, 7) and &H1
        read_Page_received_value = rightShift(data_low, 6) and &H1
        read_AN_complete_value = rightShift(data_low, 5) and &H1
        read_Remodt_Fault_value = rightShift(data_low, 4) and &H1
        read_AN_ability_value = rightShift(data_low, 3) and &H1
        read_Link_status_value = rightShift(data_low, 2) and &H1
        Link_partner_AN_ability_mask = &H1
        if data_low > LONG_MAX then
            if Link_partner_AN_ability_mask = mask then
                read_Link_partner_AN_ability_value = data_low
            else
                read_Link_partner_AN_ability_value = (data_low - H8000_0000) and Link_partner_AN_ability_mask
            end If
        else
            read_Link_partner_AN_ability_value = data_low and Link_partner_AN_ability_mask
        end If

    End Sub

    Sub write
        If flag_Extended_next_page_status = &H0 or flag_Page_received = &H0 or flag_AN_complete = &H0 or flag_Remodt_Fault = &H0 or flag_AN_ability = &H0 or flag_Link_status = &H0 or flag_Link_partner_AN_ability = &H0 Then read
        If flag_Extended_next_page_status = &H0 Then write_Extended_next_page_status_value = get_Extended_next_page_status
        If flag_Page_received = &H0 Then write_Page_received_value = get_Page_received
        If flag_AN_complete = &H0 Then write_AN_complete_value = get_AN_complete
        If flag_Remodt_Fault = &H0 Then write_Remodt_Fault_value = get_Remodt_Fault
        If flag_AN_ability = &H0 Then write_AN_ability_value = get_AN_ability
        If flag_Link_status = &H0 Then write_Link_status_value = get_Link_status
        If flag_Link_partner_AN_ability = &H0 Then write_Link_partner_AN_ability_value = get_Link_partner_AN_ability

        regValue = leftShift((write_Extended_next_page_status_value and &H1), 7) + leftShift((write_Page_received_value and &H1), 6) + leftShift((write_AN_complete_value and &H1), 5) + leftShift((write_Remodt_Fault_value and &H1), 4) + leftShift((write_AN_ability_value and &H1), 3) + leftShift((write_Link_status_value and &H1), 2) + leftShift((write_Link_partner_AN_ability_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Extended_next_page_status_value = rightShift(data_low, 7) and &H1
        read_Page_received_value = rightShift(data_low, 6) and &H1
        read_AN_complete_value = rightShift(data_low, 5) and &H1
        read_Remodt_Fault_value = rightShift(data_low, 4) and &H1
        read_AN_ability_value = rightShift(data_low, 3) and &H1
        read_Link_status_value = rightShift(data_low, 2) and &H1
        Link_partner_AN_ability_mask = &H1
        if data_low > LONG_MAX then
            if Link_partner_AN_ability_mask = mask then
                read_Link_partner_AN_ability_value = data_low
            else
                read_Link_partner_AN_ability_value = (data_low - H8000_0000) and Link_partner_AN_ability_mask
            end If
        else
            read_Link_partner_AN_ability_value = data_low and Link_partner_AN_ability_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Extended_next_page_status_value = &H0
        flag_Extended_next_page_status        = &H0
        write_Page_received_value = &H0
        flag_Page_received        = &H0
        write_AN_complete_value = &H0
        flag_AN_complete        = &H0
        write_Remodt_Fault_value = &H0
        flag_Remodt_Fault        = &H0
        write_AN_ability_value = &H0
        flag_AN_ability        = &H0
        write_Link_status_value = &H0
        flag_Link_status        = &H0
        write_Link_partner_AN_ability_value = &H0
        flag_Link_partner_AN_ability        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_dev_id_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cu_an_device_identifier                    [15:0]           get_cu_an_device_identifier
''                                                             set_cu_an_device_identifier
''                                                             read_cu_an_device_identifier
''                                                             write_cu_an_device_identifier
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_dev_id_lsb
    Private write_cu_an_device_identifier_value
    Private read_cu_an_device_identifier_value
    Private flag_cu_an_device_identifier

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

    Property Get get_cu_an_device_identifier
        get_cu_an_device_identifier = read_cu_an_device_identifier_value
    End Property

    Property Let set_cu_an_device_identifier(aData)
        write_cu_an_device_identifier_value = aData
        flag_cu_an_device_identifier        = &H1
    End Property

    Property Get read_cu_an_device_identifier
        read
        read_cu_an_device_identifier = read_cu_an_device_identifier_value
    End Property

    Property Let write_cu_an_device_identifier(aData)
        set_cu_an_device_identifier = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_identifier_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_identifier_mask = mask then
                read_cu_an_device_identifier_value = data_low
            else
                read_cu_an_device_identifier_value = (data_low - H8000_0000) and cu_an_device_identifier_mask
            end If
        else
            read_cu_an_device_identifier_value = data_low and cu_an_device_identifier_mask
        end If

    End Sub

    Sub write
        If flag_cu_an_device_identifier = &H0 Then read
        If flag_cu_an_device_identifier = &H0 Then write_cu_an_device_identifier_value = get_cu_an_device_identifier

        regValue = leftShift((write_cu_an_device_identifier_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_identifier_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_identifier_mask = mask then
                read_cu_an_device_identifier_value = data_low
            else
                read_cu_an_device_identifier_value = (data_low - H8000_0000) and cu_an_device_identifier_mask
            end If
        else
            read_cu_an_device_identifier_value = data_low and cu_an_device_identifier_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cu_an_device_identifier_value = &H0
        flag_cu_an_device_identifier        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_dev_id_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cu_an_device_identifier                    [15:0]           get_cu_an_device_identifier
''                                                             set_cu_an_device_identifier
''                                                             read_cu_an_device_identifier
''                                                             write_cu_an_device_identifier
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_dev_id_msb
    Private write_cu_an_device_identifier_value
    Private read_cu_an_device_identifier_value
    Private flag_cu_an_device_identifier

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

    Property Get get_cu_an_device_identifier
        get_cu_an_device_identifier = read_cu_an_device_identifier_value
    End Property

    Property Let set_cu_an_device_identifier(aData)
        write_cu_an_device_identifier_value = aData
        flag_cu_an_device_identifier        = &H1
    End Property

    Property Get read_cu_an_device_identifier
        read
        read_cu_an_device_identifier = read_cu_an_device_identifier_value
    End Property

    Property Let write_cu_an_device_identifier(aData)
        set_cu_an_device_identifier = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_identifier_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_identifier_mask = mask then
                read_cu_an_device_identifier_value = data_low
            else
                read_cu_an_device_identifier_value = (data_low - H8000_0000) and cu_an_device_identifier_mask
            end If
        else
            read_cu_an_device_identifier_value = data_low and cu_an_device_identifier_mask
        end If

    End Sub

    Sub write
        If flag_cu_an_device_identifier = &H0 Then read
        If flag_cu_an_device_identifier = &H0 Then write_cu_an_device_identifier_value = get_cu_an_device_identifier

        regValue = leftShift((write_cu_an_device_identifier_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_identifier_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_identifier_mask = mask then
                read_cu_an_device_identifier_value = data_low
            else
                read_cu_an_device_identifier_value = (data_low - H8000_0000) and cu_an_device_identifier_mask
            end If
        else
            read_cu_an_device_identifier_value = data_low and cu_an_device_identifier_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cu_an_device_identifier_value = &H0
        flag_cu_an_device_identifier        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_dev_in_pkg_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_PRE                                [7:7]            get_AUTONEG_PRE
''                                                             set_AUTONEG_PRE
''                                                             read_AUTONEG_PRE
''                                                             write_AUTONEG_PRE
''---------------------------------------------------------------------------------
'' TC_PRE                                     [6:6]            get_TC_PRE
''                                                             set_TC_PRE
''                                                             read_TC_PRE
''                                                             write_TC_PRE
''---------------------------------------------------------------------------------
'' DTEXS_PRE                                  [5:5]            get_DTEXS_PRE
''                                                             set_DTEXS_PRE
''                                                             read_DTEXS_PRE
''                                                             write_DTEXS_PRE
''---------------------------------------------------------------------------------
'' PHYXS_PRE                                  [4:4]            get_PHYXS_PRE
''                                                             set_PHYXS_PRE
''                                                             read_PHYXS_PRE
''                                                             write_PHYXS_PRE
''---------------------------------------------------------------------------------
'' PCS_PRE                                    [3:3]            get_PCS_PRE
''                                                             set_PCS_PRE
''                                                             read_PCS_PRE
''                                                             write_PCS_PRE
''---------------------------------------------------------------------------------
'' WIS_PRE                                    [2:2]            get_WIS_PRE
''                                                             set_WIS_PRE
''                                                             read_WIS_PRE
''                                                             write_WIS_PRE
''---------------------------------------------------------------------------------
'' PMD_PRE                                    [1:1]            get_PMD_PRE
''                                                             set_PMD_PRE
''                                                             read_PMD_PRE
''                                                             write_PMD_PRE
''---------------------------------------------------------------------------------
'' CLA22_PRE                                  [0:0]            get_CLA22_PRE
''                                                             set_CLA22_PRE
''                                                             read_CLA22_PRE
''                                                             write_CLA22_PRE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_dev_in_pkg_lsb
    Private write_AUTONEG_PRE_value
    Private read_AUTONEG_PRE_value
    Private flag_AUTONEG_PRE
    Private write_TC_PRE_value
    Private read_TC_PRE_value
    Private flag_TC_PRE
    Private write_DTEXS_PRE_value
    Private read_DTEXS_PRE_value
    Private flag_DTEXS_PRE
    Private write_PHYXS_PRE_value
    Private read_PHYXS_PRE_value
    Private flag_PHYXS_PRE
    Private write_PCS_PRE_value
    Private read_PCS_PRE_value
    Private flag_PCS_PRE
    Private write_WIS_PRE_value
    Private read_WIS_PRE_value
    Private flag_WIS_PRE
    Private write_PMD_PRE_value
    Private read_PMD_PRE_value
    Private flag_PMD_PRE
    Private write_CLA22_PRE_value
    Private read_CLA22_PRE_value
    Private flag_CLA22_PRE

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

    Property Get get_AUTONEG_PRE
        get_AUTONEG_PRE = read_AUTONEG_PRE_value
    End Property

    Property Let set_AUTONEG_PRE(aData)
        write_AUTONEG_PRE_value = aData
        flag_AUTONEG_PRE        = &H1
    End Property

    Property Get read_AUTONEG_PRE
        read
        read_AUTONEG_PRE = read_AUTONEG_PRE_value
    End Property

    Property Let write_AUTONEG_PRE(aData)
        set_AUTONEG_PRE = aData
        write
    End Property

    Property Get get_TC_PRE
        get_TC_PRE = read_TC_PRE_value
    End Property

    Property Let set_TC_PRE(aData)
        write_TC_PRE_value = aData
        flag_TC_PRE        = &H1
    End Property

    Property Get read_TC_PRE
        read
        read_TC_PRE = read_TC_PRE_value
    End Property

    Property Let write_TC_PRE(aData)
        set_TC_PRE = aData
        write
    End Property

    Property Get get_DTEXS_PRE
        get_DTEXS_PRE = read_DTEXS_PRE_value
    End Property

    Property Let set_DTEXS_PRE(aData)
        write_DTEXS_PRE_value = aData
        flag_DTEXS_PRE        = &H1
    End Property

    Property Get read_DTEXS_PRE
        read
        read_DTEXS_PRE = read_DTEXS_PRE_value
    End Property

    Property Let write_DTEXS_PRE(aData)
        set_DTEXS_PRE = aData
        write
    End Property

    Property Get get_PHYXS_PRE
        get_PHYXS_PRE = read_PHYXS_PRE_value
    End Property

    Property Let set_PHYXS_PRE(aData)
        write_PHYXS_PRE_value = aData
        flag_PHYXS_PRE        = &H1
    End Property

    Property Get read_PHYXS_PRE
        read
        read_PHYXS_PRE = read_PHYXS_PRE_value
    End Property

    Property Let write_PHYXS_PRE(aData)
        set_PHYXS_PRE = aData
        write
    End Property

    Property Get get_PCS_PRE
        get_PCS_PRE = read_PCS_PRE_value
    End Property

    Property Let set_PCS_PRE(aData)
        write_PCS_PRE_value = aData
        flag_PCS_PRE        = &H1
    End Property

    Property Get read_PCS_PRE
        read
        read_PCS_PRE = read_PCS_PRE_value
    End Property

    Property Let write_PCS_PRE(aData)
        set_PCS_PRE = aData
        write
    End Property

    Property Get get_WIS_PRE
        get_WIS_PRE = read_WIS_PRE_value
    End Property

    Property Let set_WIS_PRE(aData)
        write_WIS_PRE_value = aData
        flag_WIS_PRE        = &H1
    End Property

    Property Get read_WIS_PRE
        read
        read_WIS_PRE = read_WIS_PRE_value
    End Property

    Property Let write_WIS_PRE(aData)
        set_WIS_PRE = aData
        write
    End Property

    Property Get get_PMD_PRE
        get_PMD_PRE = read_PMD_PRE_value
    End Property

    Property Let set_PMD_PRE(aData)
        write_PMD_PRE_value = aData
        flag_PMD_PRE        = &H1
    End Property

    Property Get read_PMD_PRE
        read
        read_PMD_PRE = read_PMD_PRE_value
    End Property

    Property Let write_PMD_PRE(aData)
        set_PMD_PRE = aData
        write
    End Property

    Property Get get_CLA22_PRE
        get_CLA22_PRE = read_CLA22_PRE_value
    End Property

    Property Let set_CLA22_PRE(aData)
        write_CLA22_PRE_value = aData
        flag_CLA22_PRE        = &H1
    End Property

    Property Get read_CLA22_PRE
        read
        read_CLA22_PRE = read_CLA22_PRE_value
    End Property

    Property Let write_CLA22_PRE(aData)
        set_CLA22_PRE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PRE_value = rightShift(data_low, 7) and &H1
        read_TC_PRE_value = rightShift(data_low, 6) and &H1
        read_DTEXS_PRE_value = rightShift(data_low, 5) and &H1
        read_PHYXS_PRE_value = rightShift(data_low, 4) and &H1
        read_PCS_PRE_value = rightShift(data_low, 3) and &H1
        read_WIS_PRE_value = rightShift(data_low, 2) and &H1
        read_PMD_PRE_value = rightShift(data_low, 1) and &H1
        CLA22_PRE_mask = &H1
        if data_low > LONG_MAX then
            if CLA22_PRE_mask = mask then
                read_CLA22_PRE_value = data_low
            else
                read_CLA22_PRE_value = (data_low - H8000_0000) and CLA22_PRE_mask
            end If
        else
            read_CLA22_PRE_value = data_low and CLA22_PRE_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_PRE = &H0 or flag_TC_PRE = &H0 or flag_DTEXS_PRE = &H0 or flag_PHYXS_PRE = &H0 or flag_PCS_PRE = &H0 or flag_WIS_PRE = &H0 or flag_PMD_PRE = &H0 or flag_CLA22_PRE = &H0 Then read
        If flag_AUTONEG_PRE = &H0 Then write_AUTONEG_PRE_value = get_AUTONEG_PRE
        If flag_TC_PRE = &H0 Then write_TC_PRE_value = get_TC_PRE
        If flag_DTEXS_PRE = &H0 Then write_DTEXS_PRE_value = get_DTEXS_PRE
        If flag_PHYXS_PRE = &H0 Then write_PHYXS_PRE_value = get_PHYXS_PRE
        If flag_PCS_PRE = &H0 Then write_PCS_PRE_value = get_PCS_PRE
        If flag_WIS_PRE = &H0 Then write_WIS_PRE_value = get_WIS_PRE
        If flag_PMD_PRE = &H0 Then write_PMD_PRE_value = get_PMD_PRE
        If flag_CLA22_PRE = &H0 Then write_CLA22_PRE_value = get_CLA22_PRE

        regValue = leftShift((write_AUTONEG_PRE_value and &H1), 7) + leftShift((write_TC_PRE_value and &H1), 6) + leftShift((write_DTEXS_PRE_value and &H1), 5) + leftShift((write_PHYXS_PRE_value and &H1), 4) + leftShift((write_PCS_PRE_value and &H1), 3) + leftShift((write_WIS_PRE_value and &H1), 2) + leftShift((write_PMD_PRE_value and &H1), 1) + leftShift((write_CLA22_PRE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PRE_value = rightShift(data_low, 7) and &H1
        read_TC_PRE_value = rightShift(data_low, 6) and &H1
        read_DTEXS_PRE_value = rightShift(data_low, 5) and &H1
        read_PHYXS_PRE_value = rightShift(data_low, 4) and &H1
        read_PCS_PRE_value = rightShift(data_low, 3) and &H1
        read_WIS_PRE_value = rightShift(data_low, 2) and &H1
        read_PMD_PRE_value = rightShift(data_low, 1) and &H1
        CLA22_PRE_mask = &H1
        if data_low > LONG_MAX then
            if CLA22_PRE_mask = mask then
                read_CLA22_PRE_value = data_low
            else
                read_CLA22_PRE_value = (data_low - H8000_0000) and CLA22_PRE_mask
            end If
        else
            read_CLA22_PRE_value = data_low and CLA22_PRE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_PRE_value = &H0
        flag_AUTONEG_PRE        = &H0
        write_TC_PRE_value = &H0
        flag_TC_PRE        = &H0
        write_DTEXS_PRE_value = &H0
        flag_DTEXS_PRE        = &H0
        write_PHYXS_PRE_value = &H0
        flag_PHYXS_PRE        = &H0
        write_PCS_PRE_value = &H0
        flag_PCS_PRE        = &H0
        write_WIS_PRE_value = &H0
        flag_WIS_PRE        = &H0
        write_PMD_PRE_value = &H0
        flag_PMD_PRE        = &H0
        write_CLA22_PRE_value = &H0
        flag_CLA22_PRE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_dev_in_pkg_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VENSP_DEV2_PRE                             [15:15]          get_VENSP_DEV2_PRE
''                                                             set_VENSP_DEV2_PRE
''                                                             read_VENSP_DEV2_PRE
''                                                             write_VENSP_DEV2_PRE
''---------------------------------------------------------------------------------
'' VENSP_DEV1_PRE                             [14:14]          get_VENSP_DEV1_PRE
''                                                             set_VENSP_DEV1_PRE
''                                                             read_VENSP_DEV1_PRE
''                                                             write_VENSP_DEV1_PRE
''---------------------------------------------------------------------------------
'' CLA22_EXT_PRE                              [13:13]          get_CLA22_EXT_PRE
''                                                             set_CLA22_EXT_PRE
''                                                             read_CLA22_EXT_PRE
''                                                             write_CLA22_EXT_PRE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_dev_in_pkg_msb
    Private write_VENSP_DEV2_PRE_value
    Private read_VENSP_DEV2_PRE_value
    Private flag_VENSP_DEV2_PRE
    Private write_VENSP_DEV1_PRE_value
    Private read_VENSP_DEV1_PRE_value
    Private flag_VENSP_DEV1_PRE
    Private write_CLA22_EXT_PRE_value
    Private read_CLA22_EXT_PRE_value
    Private flag_CLA22_EXT_PRE

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

    Property Get get_VENSP_DEV2_PRE
        get_VENSP_DEV2_PRE = read_VENSP_DEV2_PRE_value
    End Property

    Property Let set_VENSP_DEV2_PRE(aData)
        write_VENSP_DEV2_PRE_value = aData
        flag_VENSP_DEV2_PRE        = &H1
    End Property

    Property Get read_VENSP_DEV2_PRE
        read
        read_VENSP_DEV2_PRE = read_VENSP_DEV2_PRE_value
    End Property

    Property Let write_VENSP_DEV2_PRE(aData)
        set_VENSP_DEV2_PRE = aData
        write
    End Property

    Property Get get_VENSP_DEV1_PRE
        get_VENSP_DEV1_PRE = read_VENSP_DEV1_PRE_value
    End Property

    Property Let set_VENSP_DEV1_PRE(aData)
        write_VENSP_DEV1_PRE_value = aData
        flag_VENSP_DEV1_PRE        = &H1
    End Property

    Property Get read_VENSP_DEV1_PRE
        read
        read_VENSP_DEV1_PRE = read_VENSP_DEV1_PRE_value
    End Property

    Property Let write_VENSP_DEV1_PRE(aData)
        set_VENSP_DEV1_PRE = aData
        write
    End Property

    Property Get get_CLA22_EXT_PRE
        get_CLA22_EXT_PRE = read_CLA22_EXT_PRE_value
    End Property

    Property Let set_CLA22_EXT_PRE(aData)
        write_CLA22_EXT_PRE_value = aData
        flag_CLA22_EXT_PRE        = &H1
    End Property

    Property Get read_CLA22_EXT_PRE
        read
        read_CLA22_EXT_PRE = read_CLA22_EXT_PRE_value
    End Property

    Property Let write_CLA22_EXT_PRE(aData)
        set_CLA22_EXT_PRE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VENSP_DEV2_PRE_value = rightShift(data_low, 15) and &H1
        read_VENSP_DEV1_PRE_value = rightShift(data_low, 14) and &H1
        read_CLA22_EXT_PRE_value = rightShift(data_low, 13) and &H1

    End Sub

    Sub write
        If flag_VENSP_DEV2_PRE = &H0 or flag_VENSP_DEV1_PRE = &H0 or flag_CLA22_EXT_PRE = &H0 Then read
        If flag_VENSP_DEV2_PRE = &H0 Then write_VENSP_DEV2_PRE_value = get_VENSP_DEV2_PRE
        If flag_VENSP_DEV1_PRE = &H0 Then write_VENSP_DEV1_PRE_value = get_VENSP_DEV1_PRE
        If flag_CLA22_EXT_PRE = &H0 Then write_CLA22_EXT_PRE_value = get_CLA22_EXT_PRE

        regValue = leftShift((write_VENSP_DEV2_PRE_value and &H1), 15) + leftShift((write_VENSP_DEV1_PRE_value and &H1), 14) + leftShift((write_CLA22_EXT_PRE_value and &H1), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VENSP_DEV2_PRE_value = rightShift(data_low, 15) and &H1
        read_VENSP_DEV1_PRE_value = rightShift(data_low, 14) and &H1
        read_CLA22_EXT_PRE_value = rightShift(data_low, 13) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VENSP_DEV2_PRE_value = &H0
        flag_VENSP_DEV2_PRE        = &H0
        write_VENSP_DEV1_PRE_value = &H0
        flag_VENSP_DEV1_PRE        = &H0
        write_CLA22_EXT_PRE_value = &H0
        flag_CLA22_EXT_PRE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_dev_pkg_id_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cu_an_device_package_id                    [15:0]           get_cu_an_device_package_id
''                                                             set_cu_an_device_package_id
''                                                             read_cu_an_device_package_id
''                                                             write_cu_an_device_package_id
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_dev_pkg_id_lsb
    Private write_cu_an_device_package_id_value
    Private read_cu_an_device_package_id_value
    Private flag_cu_an_device_package_id

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

    Property Get get_cu_an_device_package_id
        get_cu_an_device_package_id = read_cu_an_device_package_id_value
    End Property

    Property Let set_cu_an_device_package_id(aData)
        write_cu_an_device_package_id_value = aData
        flag_cu_an_device_package_id        = &H1
    End Property

    Property Get read_cu_an_device_package_id
        read
        read_cu_an_device_package_id = read_cu_an_device_package_id_value
    End Property

    Property Let write_cu_an_device_package_id(aData)
        set_cu_an_device_package_id = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_package_id_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_package_id_mask = mask then
                read_cu_an_device_package_id_value = data_low
            else
                read_cu_an_device_package_id_value = (data_low - H8000_0000) and cu_an_device_package_id_mask
            end If
        else
            read_cu_an_device_package_id_value = data_low and cu_an_device_package_id_mask
        end If

    End Sub

    Sub write
        If flag_cu_an_device_package_id = &H0 Then read
        If flag_cu_an_device_package_id = &H0 Then write_cu_an_device_package_id_value = get_cu_an_device_package_id

        regValue = leftShift((write_cu_an_device_package_id_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_package_id_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_package_id_mask = mask then
                read_cu_an_device_package_id_value = data_low
            else
                read_cu_an_device_package_id_value = (data_low - H8000_0000) and cu_an_device_package_id_mask
            end If
        else
            read_cu_an_device_package_id_value = data_low and cu_an_device_package_id_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cu_an_device_package_id_value = &H0
        flag_cu_an_device_package_id        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_dev_pkg_id_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cu_an_device_package_id                    [15:0]           get_cu_an_device_package_id
''                                                             set_cu_an_device_package_id
''                                                             read_cu_an_device_package_id
''                                                             write_cu_an_device_package_id
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_dev_pkg_id_msb
    Private write_cu_an_device_package_id_value
    Private read_cu_an_device_package_id_value
    Private flag_cu_an_device_package_id

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

    Property Get get_cu_an_device_package_id
        get_cu_an_device_package_id = read_cu_an_device_package_id_value
    End Property

    Property Let set_cu_an_device_package_id(aData)
        write_cu_an_device_package_id_value = aData
        flag_cu_an_device_package_id        = &H1
    End Property

    Property Get read_cu_an_device_package_id
        read
        read_cu_an_device_package_id = read_cu_an_device_package_id_value
    End Property

    Property Let write_cu_an_device_package_id(aData)
        set_cu_an_device_package_id = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_package_id_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_package_id_mask = mask then
                read_cu_an_device_package_id_value = data_low
            else
                read_cu_an_device_package_id_value = (data_low - H8000_0000) and cu_an_device_package_id_mask
            end If
        else
            read_cu_an_device_package_id_value = data_low and cu_an_device_package_id_mask
        end If

    End Sub

    Sub write
        If flag_cu_an_device_package_id = &H0 Then read
        If flag_cu_an_device_package_id = &H0 Then write_cu_an_device_package_id_value = get_cu_an_device_package_id

        regValue = leftShift((write_cu_an_device_package_id_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cu_an_device_package_id_mask = &Hffff
        if data_low > LONG_MAX then
            if cu_an_device_package_id_mask = mask then
                read_cu_an_device_package_id_value = data_low
            else
                read_cu_an_device_package_id_value = (data_low - H8000_0000) and cu_an_device_package_id_mask
            end If
        else
            read_cu_an_device_package_id_value = data_low and cu_an_device_package_id_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cu_an_device_package_id_value = &H0
        flag_cu_an_device_package_id        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_ad
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LD_NEXT_PAGE                               [15:15]          get_LD_NEXT_PAGE
''                                                             set_LD_NEXT_PAGE
''                                                             read_LD_NEXT_PAGE
''                                                             write_LD_NEXT_PAGE
''---------------------------------------------------------------------------------
'' LD_ACKNOWLEDGE                             [14:14]          get_LD_ACKNOWLEDGE
''                                                             set_LD_ACKNOWLEDGE
''                                                             read_LD_ACKNOWLEDGE
''                                                             write_LD_ACKNOWLEDGE
''---------------------------------------------------------------------------------
'' LD_REMOTE_FAULT                            [13:13]          get_LD_REMOTE_FAULT
''                                                             set_LD_REMOTE_FAULT
''                                                             read_LD_REMOTE_FAULT
''                                                             write_LD_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' LD_EXTENDED_NEXT_PAGE_ABILITY              [12:12]          get_LD_EXTENDED_NEXT_PAGE_ABILITY
''                                                             set_LD_EXTENDED_NEXT_PAGE_ABILITY
''                                                             read_LD_EXTENDED_NEXT_PAGE_ABILITY
''                                                             write_LD_EXTENDED_NEXT_PAGE_ABILITY
''---------------------------------------------------------------------------------
'' LD_ASYMMETRIC_PAUSE                        [11:11]          get_LD_ASYMMETRIC_PAUSE
''                                                             set_LD_ASYMMETRIC_PAUSE
''                                                             read_LD_ASYMMETRIC_PAUSE
''                                                             write_LD_ASYMMETRIC_PAUSE
''---------------------------------------------------------------------------------
'' LD_PAUSE_CAPABLE                           [10:10]          get_LD_PAUSE_CAPABLE
''                                                             set_LD_PAUSE_CAPABLE
''                                                             read_LD_PAUSE_CAPABLE
''                                                             write_LD_PAUSE_CAPABLE
''---------------------------------------------------------------------------------
'' LD_100BASE_T4_CAPABLE                      [9:9]            get_LD_100BASE_T4_CAPABLE
''                                                             set_LD_100BASE_T4_CAPABLE
''                                                             read_LD_100BASE_T4_CAPABLE
''                                                             write_LD_100BASE_T4_CAPABLE
''---------------------------------------------------------------------------------
'' LD_100BASE_TX_FULL_DUPLEX_CAPABLE          [8:8]            get_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
''                                                             set_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
''                                                             read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
''                                                             write_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LD_100BASE_TX_HALF_DUPLEX_CAPABLE          [7:7]            get_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
''                                                             set_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
''                                                             read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
''                                                             write_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LD_10BASE_T_FULL_DUPLEX_CAPABLE            [6:6]            get_LD_10BASE_T_FULL_DUPLEX_CAPABLE
''                                                             set_LD_10BASE_T_FULL_DUPLEX_CAPABLE
''                                                             read_LD_10BASE_T_FULL_DUPLEX_CAPABLE
''                                                             write_LD_10BASE_T_FULL_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LD_10BASE_T_HALF_DUPLEX_CAPABLE            [5:5]            get_LD_10BASE_T_HALF_DUPLEX_CAPABLE
''                                                             set_LD_10BASE_T_HALF_DUPLEX_CAPABLE
''                                                             read_LD_10BASE_T_HALF_DUPLEX_CAPABLE
''                                                             write_LD_10BASE_T_HALF_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LD_PROTOCOL_SELECTOR                       [4:0]            get_LD_PROTOCOL_SELECTOR
''                                                             set_LD_PROTOCOL_SELECTOR
''                                                             read_LD_PROTOCOL_SELECTOR
''                                                             write_LD_PROTOCOL_SELECTOR
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_ad
    Private write_LD_NEXT_PAGE_value
    Private read_LD_NEXT_PAGE_value
    Private flag_LD_NEXT_PAGE
    Private write_LD_ACKNOWLEDGE_value
    Private read_LD_ACKNOWLEDGE_value
    Private flag_LD_ACKNOWLEDGE
    Private write_LD_REMOTE_FAULT_value
    Private read_LD_REMOTE_FAULT_value
    Private flag_LD_REMOTE_FAULT
    Private write_LD_EXTENDED_NEXT_PAGE_ABILITY_value
    Private read_LD_EXTENDED_NEXT_PAGE_ABILITY_value
    Private flag_LD_EXTENDED_NEXT_PAGE_ABILITY
    Private write_LD_ASYMMETRIC_PAUSE_value
    Private read_LD_ASYMMETRIC_PAUSE_value
    Private flag_LD_ASYMMETRIC_PAUSE
    Private write_LD_PAUSE_CAPABLE_value
    Private read_LD_PAUSE_CAPABLE_value
    Private flag_LD_PAUSE_CAPABLE
    Private write_LD_100BASE_T4_CAPABLE_value
    Private read_LD_100BASE_T4_CAPABLE_value
    Private flag_LD_100BASE_T4_CAPABLE
    Private write_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    Private read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    Private flag_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
    Private write_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    Private read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    Private flag_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
    Private write_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value
    Private read_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value
    Private flag_LD_10BASE_T_FULL_DUPLEX_CAPABLE
    Private write_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value
    Private read_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value
    Private flag_LD_10BASE_T_HALF_DUPLEX_CAPABLE
    Private write_LD_PROTOCOL_SELECTOR_value
    Private read_LD_PROTOCOL_SELECTOR_value
    Private flag_LD_PROTOCOL_SELECTOR

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

    Property Get get_LD_NEXT_PAGE
        get_LD_NEXT_PAGE = read_LD_NEXT_PAGE_value
    End Property

    Property Let set_LD_NEXT_PAGE(aData)
        write_LD_NEXT_PAGE_value = aData
        flag_LD_NEXT_PAGE        = &H1
    End Property

    Property Get read_LD_NEXT_PAGE
        read
        read_LD_NEXT_PAGE = read_LD_NEXT_PAGE_value
    End Property

    Property Let write_LD_NEXT_PAGE(aData)
        set_LD_NEXT_PAGE = aData
        write
    End Property

    Property Get get_LD_ACKNOWLEDGE
        get_LD_ACKNOWLEDGE = read_LD_ACKNOWLEDGE_value
    End Property

    Property Let set_LD_ACKNOWLEDGE(aData)
        write_LD_ACKNOWLEDGE_value = aData
        flag_LD_ACKNOWLEDGE        = &H1
    End Property

    Property Get read_LD_ACKNOWLEDGE
        read
        read_LD_ACKNOWLEDGE = read_LD_ACKNOWLEDGE_value
    End Property

    Property Let write_LD_ACKNOWLEDGE(aData)
        set_LD_ACKNOWLEDGE = aData
        write
    End Property

    Property Get get_LD_REMOTE_FAULT
        get_LD_REMOTE_FAULT = read_LD_REMOTE_FAULT_value
    End Property

    Property Let set_LD_REMOTE_FAULT(aData)
        write_LD_REMOTE_FAULT_value = aData
        flag_LD_REMOTE_FAULT        = &H1
    End Property

    Property Get read_LD_REMOTE_FAULT
        read
        read_LD_REMOTE_FAULT = read_LD_REMOTE_FAULT_value
    End Property

    Property Let write_LD_REMOTE_FAULT(aData)
        set_LD_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_LD_EXTENDED_NEXT_PAGE_ABILITY
        get_LD_EXTENDED_NEXT_PAGE_ABILITY = read_LD_EXTENDED_NEXT_PAGE_ABILITY_value
    End Property

    Property Let set_LD_EXTENDED_NEXT_PAGE_ABILITY(aData)
        write_LD_EXTENDED_NEXT_PAGE_ABILITY_value = aData
        flag_LD_EXTENDED_NEXT_PAGE_ABILITY        = &H1
    End Property

    Property Get read_LD_EXTENDED_NEXT_PAGE_ABILITY
        read
        read_LD_EXTENDED_NEXT_PAGE_ABILITY = read_LD_EXTENDED_NEXT_PAGE_ABILITY_value
    End Property

    Property Let write_LD_EXTENDED_NEXT_PAGE_ABILITY(aData)
        set_LD_EXTENDED_NEXT_PAGE_ABILITY = aData
        write
    End Property

    Property Get get_LD_ASYMMETRIC_PAUSE
        get_LD_ASYMMETRIC_PAUSE = read_LD_ASYMMETRIC_PAUSE_value
    End Property

    Property Let set_LD_ASYMMETRIC_PAUSE(aData)
        write_LD_ASYMMETRIC_PAUSE_value = aData
        flag_LD_ASYMMETRIC_PAUSE        = &H1
    End Property

    Property Get read_LD_ASYMMETRIC_PAUSE
        read
        read_LD_ASYMMETRIC_PAUSE = read_LD_ASYMMETRIC_PAUSE_value
    End Property

    Property Let write_LD_ASYMMETRIC_PAUSE(aData)
        set_LD_ASYMMETRIC_PAUSE = aData
        write
    End Property

    Property Get get_LD_PAUSE_CAPABLE
        get_LD_PAUSE_CAPABLE = read_LD_PAUSE_CAPABLE_value
    End Property

    Property Let set_LD_PAUSE_CAPABLE(aData)
        write_LD_PAUSE_CAPABLE_value = aData
        flag_LD_PAUSE_CAPABLE        = &H1
    End Property

    Property Get read_LD_PAUSE_CAPABLE
        read
        read_LD_PAUSE_CAPABLE = read_LD_PAUSE_CAPABLE_value
    End Property

    Property Let write_LD_PAUSE_CAPABLE(aData)
        set_LD_PAUSE_CAPABLE = aData
        write
    End Property

    Property Get get_LD_100BASE_T4_CAPABLE
        get_LD_100BASE_T4_CAPABLE = read_LD_100BASE_T4_CAPABLE_value
    End Property

    Property Let set_LD_100BASE_T4_CAPABLE(aData)
        write_LD_100BASE_T4_CAPABLE_value = aData
        flag_LD_100BASE_T4_CAPABLE        = &H1
    End Property

    Property Get read_LD_100BASE_T4_CAPABLE
        read
        read_LD_100BASE_T4_CAPABLE = read_LD_100BASE_T4_CAPABLE_value
    End Property

    Property Let write_LD_100BASE_T4_CAPABLE(aData)
        set_LD_100BASE_T4_CAPABLE = aData
        write
    End Property

    Property Get get_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
        get_LD_100BASE_TX_FULL_DUPLEX_CAPABLE = read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LD_100BASE_TX_FULL_DUPLEX_CAPABLE(aData)
        write_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value = aData
        flag_LD_100BASE_TX_FULL_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
        read
        read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE = read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LD_100BASE_TX_FULL_DUPLEX_CAPABLE(aData)
        set_LD_100BASE_TX_FULL_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
        get_LD_100BASE_TX_HALF_DUPLEX_CAPABLE = read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LD_100BASE_TX_HALF_DUPLEX_CAPABLE(aData)
        write_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value = aData
        flag_LD_100BASE_TX_HALF_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
        read
        read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE = read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LD_100BASE_TX_HALF_DUPLEX_CAPABLE(aData)
        set_LD_100BASE_TX_HALF_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LD_10BASE_T_FULL_DUPLEX_CAPABLE
        get_LD_10BASE_T_FULL_DUPLEX_CAPABLE = read_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LD_10BASE_T_FULL_DUPLEX_CAPABLE(aData)
        write_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value = aData
        flag_LD_10BASE_T_FULL_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LD_10BASE_T_FULL_DUPLEX_CAPABLE
        read
        read_LD_10BASE_T_FULL_DUPLEX_CAPABLE = read_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LD_10BASE_T_FULL_DUPLEX_CAPABLE(aData)
        set_LD_10BASE_T_FULL_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LD_10BASE_T_HALF_DUPLEX_CAPABLE
        get_LD_10BASE_T_HALF_DUPLEX_CAPABLE = read_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LD_10BASE_T_HALF_DUPLEX_CAPABLE(aData)
        write_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value = aData
        flag_LD_10BASE_T_HALF_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LD_10BASE_T_HALF_DUPLEX_CAPABLE
        read
        read_LD_10BASE_T_HALF_DUPLEX_CAPABLE = read_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LD_10BASE_T_HALF_DUPLEX_CAPABLE(aData)
        set_LD_10BASE_T_HALF_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LD_PROTOCOL_SELECTOR
        get_LD_PROTOCOL_SELECTOR = read_LD_PROTOCOL_SELECTOR_value
    End Property

    Property Let set_LD_PROTOCOL_SELECTOR(aData)
        write_LD_PROTOCOL_SELECTOR_value = aData
        flag_LD_PROTOCOL_SELECTOR        = &H1
    End Property

    Property Get read_LD_PROTOCOL_SELECTOR
        read
        read_LD_PROTOCOL_SELECTOR = read_LD_PROTOCOL_SELECTOR_value
    End Property

    Property Let write_LD_PROTOCOL_SELECTOR(aData)
        set_LD_PROTOCOL_SELECTOR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_LD_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_LD_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_LD_EXTENDED_NEXT_PAGE_ABILITY_value = rightShift(data_low, 12) and &H1
        read_LD_ASYMMETRIC_PAUSE_value = rightShift(data_low, 11) and &H1
        read_LD_PAUSE_CAPABLE_value = rightShift(data_low, 10) and &H1
        read_LD_100BASE_T4_CAPABLE_value = rightShift(data_low, 9) and &H1
        read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 8) and &H1
        read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 7) and &H1
        read_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 6) and &H1
        read_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 5) and &H1
        LD_PROTOCOL_SELECTOR_mask = &H1f
        if data_low > LONG_MAX then
            if LD_PROTOCOL_SELECTOR_mask = mask then
                read_LD_PROTOCOL_SELECTOR_value = data_low
            else
                read_LD_PROTOCOL_SELECTOR_value = (data_low - H8000_0000) and LD_PROTOCOL_SELECTOR_mask
            end If
        else
            read_LD_PROTOCOL_SELECTOR_value = data_low and LD_PROTOCOL_SELECTOR_mask
        end If

    End Sub

    Sub write
        If flag_LD_NEXT_PAGE = &H0 or flag_LD_ACKNOWLEDGE = &H0 or flag_LD_REMOTE_FAULT = &H0 or flag_LD_EXTENDED_NEXT_PAGE_ABILITY = &H0 or flag_LD_ASYMMETRIC_PAUSE = &H0 or flag_LD_PAUSE_CAPABLE = &H0 or flag_LD_100BASE_T4_CAPABLE = &H0 or flag_LD_100BASE_TX_FULL_DUPLEX_CAPABLE = &H0 or flag_LD_100BASE_TX_HALF_DUPLEX_CAPABLE = &H0 or flag_LD_10BASE_T_FULL_DUPLEX_CAPABLE = &H0 or flag_LD_10BASE_T_HALF_DUPLEX_CAPABLE = &H0 or flag_LD_PROTOCOL_SELECTOR = &H0 Then read
        If flag_LD_NEXT_PAGE = &H0 Then write_LD_NEXT_PAGE_value = get_LD_NEXT_PAGE
        If flag_LD_ACKNOWLEDGE = &H0 Then write_LD_ACKNOWLEDGE_value = get_LD_ACKNOWLEDGE
        If flag_LD_REMOTE_FAULT = &H0 Then write_LD_REMOTE_FAULT_value = get_LD_REMOTE_FAULT
        If flag_LD_EXTENDED_NEXT_PAGE_ABILITY = &H0 Then write_LD_EXTENDED_NEXT_PAGE_ABILITY_value = get_LD_EXTENDED_NEXT_PAGE_ABILITY
        If flag_LD_ASYMMETRIC_PAUSE = &H0 Then write_LD_ASYMMETRIC_PAUSE_value = get_LD_ASYMMETRIC_PAUSE
        If flag_LD_PAUSE_CAPABLE = &H0 Then write_LD_PAUSE_CAPABLE_value = get_LD_PAUSE_CAPABLE
        If flag_LD_100BASE_T4_CAPABLE = &H0 Then write_LD_100BASE_T4_CAPABLE_value = get_LD_100BASE_T4_CAPABLE
        If flag_LD_100BASE_TX_FULL_DUPLEX_CAPABLE = &H0 Then write_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value = get_LD_100BASE_TX_FULL_DUPLEX_CAPABLE
        If flag_LD_100BASE_TX_HALF_DUPLEX_CAPABLE = &H0 Then write_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value = get_LD_100BASE_TX_HALF_DUPLEX_CAPABLE
        If flag_LD_10BASE_T_FULL_DUPLEX_CAPABLE = &H0 Then write_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value = get_LD_10BASE_T_FULL_DUPLEX_CAPABLE
        If flag_LD_10BASE_T_HALF_DUPLEX_CAPABLE = &H0 Then write_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value = get_LD_10BASE_T_HALF_DUPLEX_CAPABLE
        If flag_LD_PROTOCOL_SELECTOR = &H0 Then write_LD_PROTOCOL_SELECTOR_value = get_LD_PROTOCOL_SELECTOR

        regValue = leftShift((write_LD_NEXT_PAGE_value and &H1), 15) + leftShift((write_LD_ACKNOWLEDGE_value and &H1), 14) + leftShift((write_LD_REMOTE_FAULT_value and &H1), 13) + leftShift((write_LD_EXTENDED_NEXT_PAGE_ABILITY_value and &H1), 12) + leftShift((write_LD_ASYMMETRIC_PAUSE_value and &H1), 11) + leftShift((write_LD_PAUSE_CAPABLE_value and &H1), 10) + leftShift((write_LD_100BASE_T4_CAPABLE_value and &H1), 9) + leftShift((write_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value and &H1), 8) + leftShift((write_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value and &H1), 7) + leftShift((write_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value and &H1), 6) + leftShift((write_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value and &H1), 5) + leftShift((write_LD_PROTOCOL_SELECTOR_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_LD_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_LD_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_LD_EXTENDED_NEXT_PAGE_ABILITY_value = rightShift(data_low, 12) and &H1
        read_LD_ASYMMETRIC_PAUSE_value = rightShift(data_low, 11) and &H1
        read_LD_PAUSE_CAPABLE_value = rightShift(data_low, 10) and &H1
        read_LD_100BASE_T4_CAPABLE_value = rightShift(data_low, 9) and &H1
        read_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 8) and &H1
        read_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 7) and &H1
        read_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 6) and &H1
        read_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 5) and &H1
        LD_PROTOCOL_SELECTOR_mask = &H1f
        if data_low > LONG_MAX then
            if LD_PROTOCOL_SELECTOR_mask = mask then
                read_LD_PROTOCOL_SELECTOR_value = data_low
            else
                read_LD_PROTOCOL_SELECTOR_value = (data_low - H8000_0000) and LD_PROTOCOL_SELECTOR_mask
            end If
        else
            read_LD_PROTOCOL_SELECTOR_value = data_low and LD_PROTOCOL_SELECTOR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LD_NEXT_PAGE_value = &H0
        flag_LD_NEXT_PAGE        = &H0
        write_LD_ACKNOWLEDGE_value = &H0
        flag_LD_ACKNOWLEDGE        = &H0
        write_LD_REMOTE_FAULT_value = &H0
        flag_LD_REMOTE_FAULT        = &H0
        write_LD_EXTENDED_NEXT_PAGE_ABILITY_value = &H0
        flag_LD_EXTENDED_NEXT_PAGE_ABILITY        = &H0
        write_LD_ASYMMETRIC_PAUSE_value = &H0
        flag_LD_ASYMMETRIC_PAUSE        = &H0
        write_LD_PAUSE_CAPABLE_value = &H0
        flag_LD_PAUSE_CAPABLE        = &H0
        write_LD_100BASE_T4_CAPABLE_value = &H0
        flag_LD_100BASE_T4_CAPABLE        = &H0
        write_LD_100BASE_TX_FULL_DUPLEX_CAPABLE_value = &H0
        flag_LD_100BASE_TX_FULL_DUPLEX_CAPABLE        = &H0
        write_LD_100BASE_TX_HALF_DUPLEX_CAPABLE_value = &H0
        flag_LD_100BASE_TX_HALF_DUPLEX_CAPABLE        = &H0
        write_LD_10BASE_T_FULL_DUPLEX_CAPABLE_value = &H0
        flag_LD_10BASE_T_FULL_DUPLEX_CAPABLE        = &H0
        write_LD_10BASE_T_HALF_DUPLEX_CAPABLE_value = &H0
        flag_LD_10BASE_T_HALF_DUPLEX_CAPABLE        = &H0
        write_LD_PROTOCOL_SELECTOR_value = &H0
        flag_LD_PROTOCOL_SELECTOR        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_lpa
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_NEXT_PAGE                               [15:15]          get_LP_NEXT_PAGE
''                                                             set_LP_NEXT_PAGE
''                                                             read_LP_NEXT_PAGE
''                                                             write_LP_NEXT_PAGE
''---------------------------------------------------------------------------------
'' LP_ACKNOWLEDGE                             [14:14]          get_LP_ACKNOWLEDGE
''                                                             set_LP_ACKNOWLEDGE
''                                                             read_LP_ACKNOWLEDGE
''                                                             write_LP_ACKNOWLEDGE
''---------------------------------------------------------------------------------
'' LP_REMOTE_FAULT                            [13:13]          get_LP_REMOTE_FAULT
''                                                             set_LP_REMOTE_FAULT
''                                                             read_LP_REMOTE_FAULT
''                                                             write_LP_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' LP_EXTENDED_NEXT_PAGE_ABILITY              [12:12]          get_LP_EXTENDED_NEXT_PAGE_ABILITY
''                                                             set_LP_EXTENDED_NEXT_PAGE_ABILITY
''                                                             read_LP_EXTENDED_NEXT_PAGE_ABILITY
''                                                             write_LP_EXTENDED_NEXT_PAGE_ABILITY
''---------------------------------------------------------------------------------
'' LP_ASYMMETRIC_PAUSE                        [11:11]          get_LP_ASYMMETRIC_PAUSE
''                                                             set_LP_ASYMMETRIC_PAUSE
''                                                             read_LP_ASYMMETRIC_PAUSE
''                                                             write_LP_ASYMMETRIC_PAUSE
''---------------------------------------------------------------------------------
'' LP_PAUSE_CAPABLE                           [10:10]          get_LP_PAUSE_CAPABLE
''                                                             set_LP_PAUSE_CAPABLE
''                                                             read_LP_PAUSE_CAPABLE
''                                                             write_LP_PAUSE_CAPABLE
''---------------------------------------------------------------------------------
'' LP_100BASE_T4_CAPABLE                      [9:9]            get_LP_100BASE_T4_CAPABLE
''                                                             set_LP_100BASE_T4_CAPABLE
''                                                             read_LP_100BASE_T4_CAPABLE
''                                                             write_LP_100BASE_T4_CAPABLE
''---------------------------------------------------------------------------------
'' LP_100BASE_TX_FULL_DUPLEX_CAPABLE          [8:8]            get_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
''                                                             set_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
''                                                             read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
''                                                             write_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LP_100BASE_TX_HALF_DUPLEX_CAPABLE          [7:7]            get_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
''                                                             set_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
''                                                             read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
''                                                             write_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LP_10BASE_T_FULL_DUPLEX_CAPABLE            [6:6]            get_LP_10BASE_T_FULL_DUPLEX_CAPABLE
''                                                             set_LP_10BASE_T_FULL_DUPLEX_CAPABLE
''                                                             read_LP_10BASE_T_FULL_DUPLEX_CAPABLE
''                                                             write_LP_10BASE_T_FULL_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LP_10BASE_T_HALF_DUPLEX_CAPABLE            [5:5]            get_LP_10BASE_T_HALF_DUPLEX_CAPABLE
''                                                             set_LP_10BASE_T_HALF_DUPLEX_CAPABLE
''                                                             read_LP_10BASE_T_HALF_DUPLEX_CAPABLE
''                                                             write_LP_10BASE_T_HALF_DUPLEX_CAPABLE
''---------------------------------------------------------------------------------
'' LP_PROTOCOL_SELECTOR                       [4:0]            get_LP_PROTOCOL_SELECTOR
''                                                             set_LP_PROTOCOL_SELECTOR
''                                                             read_LP_PROTOCOL_SELECTOR
''                                                             write_LP_PROTOCOL_SELECTOR
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_lpa
    Private write_LP_NEXT_PAGE_value
    Private read_LP_NEXT_PAGE_value
    Private flag_LP_NEXT_PAGE
    Private write_LP_ACKNOWLEDGE_value
    Private read_LP_ACKNOWLEDGE_value
    Private flag_LP_ACKNOWLEDGE
    Private write_LP_REMOTE_FAULT_value
    Private read_LP_REMOTE_FAULT_value
    Private flag_LP_REMOTE_FAULT
    Private write_LP_EXTENDED_NEXT_PAGE_ABILITY_value
    Private read_LP_EXTENDED_NEXT_PAGE_ABILITY_value
    Private flag_LP_EXTENDED_NEXT_PAGE_ABILITY
    Private write_LP_ASYMMETRIC_PAUSE_value
    Private read_LP_ASYMMETRIC_PAUSE_value
    Private flag_LP_ASYMMETRIC_PAUSE
    Private write_LP_PAUSE_CAPABLE_value
    Private read_LP_PAUSE_CAPABLE_value
    Private flag_LP_PAUSE_CAPABLE
    Private write_LP_100BASE_T4_CAPABLE_value
    Private read_LP_100BASE_T4_CAPABLE_value
    Private flag_LP_100BASE_T4_CAPABLE
    Private write_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    Private read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    Private flag_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
    Private write_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    Private read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    Private flag_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
    Private write_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value
    Private read_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value
    Private flag_LP_10BASE_T_FULL_DUPLEX_CAPABLE
    Private write_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value
    Private read_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value
    Private flag_LP_10BASE_T_HALF_DUPLEX_CAPABLE
    Private write_LP_PROTOCOL_SELECTOR_value
    Private read_LP_PROTOCOL_SELECTOR_value
    Private flag_LP_PROTOCOL_SELECTOR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP_NEXT_PAGE
        get_LP_NEXT_PAGE = read_LP_NEXT_PAGE_value
    End Property

    Property Let set_LP_NEXT_PAGE(aData)
        write_LP_NEXT_PAGE_value = aData
        flag_LP_NEXT_PAGE        = &H1
    End Property

    Property Get read_LP_NEXT_PAGE
        read
        read_LP_NEXT_PAGE = read_LP_NEXT_PAGE_value
    End Property

    Property Let write_LP_NEXT_PAGE(aData)
        set_LP_NEXT_PAGE = aData
        write
    End Property

    Property Get get_LP_ACKNOWLEDGE
        get_LP_ACKNOWLEDGE = read_LP_ACKNOWLEDGE_value
    End Property

    Property Let set_LP_ACKNOWLEDGE(aData)
        write_LP_ACKNOWLEDGE_value = aData
        flag_LP_ACKNOWLEDGE        = &H1
    End Property

    Property Get read_LP_ACKNOWLEDGE
        read
        read_LP_ACKNOWLEDGE = read_LP_ACKNOWLEDGE_value
    End Property

    Property Let write_LP_ACKNOWLEDGE(aData)
        set_LP_ACKNOWLEDGE = aData
        write
    End Property

    Property Get get_LP_REMOTE_FAULT
        get_LP_REMOTE_FAULT = read_LP_REMOTE_FAULT_value
    End Property

    Property Let set_LP_REMOTE_FAULT(aData)
        write_LP_REMOTE_FAULT_value = aData
        flag_LP_REMOTE_FAULT        = &H1
    End Property

    Property Get read_LP_REMOTE_FAULT
        read
        read_LP_REMOTE_FAULT = read_LP_REMOTE_FAULT_value
    End Property

    Property Let write_LP_REMOTE_FAULT(aData)
        set_LP_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_LP_EXTENDED_NEXT_PAGE_ABILITY
        get_LP_EXTENDED_NEXT_PAGE_ABILITY = read_LP_EXTENDED_NEXT_PAGE_ABILITY_value
    End Property

    Property Let set_LP_EXTENDED_NEXT_PAGE_ABILITY(aData)
        write_LP_EXTENDED_NEXT_PAGE_ABILITY_value = aData
        flag_LP_EXTENDED_NEXT_PAGE_ABILITY        = &H1
    End Property

    Property Get read_LP_EXTENDED_NEXT_PAGE_ABILITY
        read
        read_LP_EXTENDED_NEXT_PAGE_ABILITY = read_LP_EXTENDED_NEXT_PAGE_ABILITY_value
    End Property

    Property Let write_LP_EXTENDED_NEXT_PAGE_ABILITY(aData)
        set_LP_EXTENDED_NEXT_PAGE_ABILITY = aData
        write
    End Property

    Property Get get_LP_ASYMMETRIC_PAUSE
        get_LP_ASYMMETRIC_PAUSE = read_LP_ASYMMETRIC_PAUSE_value
    End Property

    Property Let set_LP_ASYMMETRIC_PAUSE(aData)
        write_LP_ASYMMETRIC_PAUSE_value = aData
        flag_LP_ASYMMETRIC_PAUSE        = &H1
    End Property

    Property Get read_LP_ASYMMETRIC_PAUSE
        read
        read_LP_ASYMMETRIC_PAUSE = read_LP_ASYMMETRIC_PAUSE_value
    End Property

    Property Let write_LP_ASYMMETRIC_PAUSE(aData)
        set_LP_ASYMMETRIC_PAUSE = aData
        write
    End Property

    Property Get get_LP_PAUSE_CAPABLE
        get_LP_PAUSE_CAPABLE = read_LP_PAUSE_CAPABLE_value
    End Property

    Property Let set_LP_PAUSE_CAPABLE(aData)
        write_LP_PAUSE_CAPABLE_value = aData
        flag_LP_PAUSE_CAPABLE        = &H1
    End Property

    Property Get read_LP_PAUSE_CAPABLE
        read
        read_LP_PAUSE_CAPABLE = read_LP_PAUSE_CAPABLE_value
    End Property

    Property Let write_LP_PAUSE_CAPABLE(aData)
        set_LP_PAUSE_CAPABLE = aData
        write
    End Property

    Property Get get_LP_100BASE_T4_CAPABLE
        get_LP_100BASE_T4_CAPABLE = read_LP_100BASE_T4_CAPABLE_value
    End Property

    Property Let set_LP_100BASE_T4_CAPABLE(aData)
        write_LP_100BASE_T4_CAPABLE_value = aData
        flag_LP_100BASE_T4_CAPABLE        = &H1
    End Property

    Property Get read_LP_100BASE_T4_CAPABLE
        read
        read_LP_100BASE_T4_CAPABLE = read_LP_100BASE_T4_CAPABLE_value
    End Property

    Property Let write_LP_100BASE_T4_CAPABLE(aData)
        set_LP_100BASE_T4_CAPABLE = aData
        write
    End Property

    Property Get get_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
        get_LP_100BASE_TX_FULL_DUPLEX_CAPABLE = read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LP_100BASE_TX_FULL_DUPLEX_CAPABLE(aData)
        write_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value = aData
        flag_LP_100BASE_TX_FULL_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
        read
        read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE = read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LP_100BASE_TX_FULL_DUPLEX_CAPABLE(aData)
        set_LP_100BASE_TX_FULL_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
        get_LP_100BASE_TX_HALF_DUPLEX_CAPABLE = read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LP_100BASE_TX_HALF_DUPLEX_CAPABLE(aData)
        write_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value = aData
        flag_LP_100BASE_TX_HALF_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
        read
        read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE = read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LP_100BASE_TX_HALF_DUPLEX_CAPABLE(aData)
        set_LP_100BASE_TX_HALF_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LP_10BASE_T_FULL_DUPLEX_CAPABLE
        get_LP_10BASE_T_FULL_DUPLEX_CAPABLE = read_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LP_10BASE_T_FULL_DUPLEX_CAPABLE(aData)
        write_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value = aData
        flag_LP_10BASE_T_FULL_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LP_10BASE_T_FULL_DUPLEX_CAPABLE
        read
        read_LP_10BASE_T_FULL_DUPLEX_CAPABLE = read_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LP_10BASE_T_FULL_DUPLEX_CAPABLE(aData)
        set_LP_10BASE_T_FULL_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LP_10BASE_T_HALF_DUPLEX_CAPABLE
        get_LP_10BASE_T_HALF_DUPLEX_CAPABLE = read_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let set_LP_10BASE_T_HALF_DUPLEX_CAPABLE(aData)
        write_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value = aData
        flag_LP_10BASE_T_HALF_DUPLEX_CAPABLE        = &H1
    End Property

    Property Get read_LP_10BASE_T_HALF_DUPLEX_CAPABLE
        read
        read_LP_10BASE_T_HALF_DUPLEX_CAPABLE = read_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value
    End Property

    Property Let write_LP_10BASE_T_HALF_DUPLEX_CAPABLE(aData)
        set_LP_10BASE_T_HALF_DUPLEX_CAPABLE = aData
        write
    End Property

    Property Get get_LP_PROTOCOL_SELECTOR
        get_LP_PROTOCOL_SELECTOR = read_LP_PROTOCOL_SELECTOR_value
    End Property

    Property Let set_LP_PROTOCOL_SELECTOR(aData)
        write_LP_PROTOCOL_SELECTOR_value = aData
        flag_LP_PROTOCOL_SELECTOR        = &H1
    End Property

    Property Get read_LP_PROTOCOL_SELECTOR
        read
        read_LP_PROTOCOL_SELECTOR = read_LP_PROTOCOL_SELECTOR_value
    End Property

    Property Let write_LP_PROTOCOL_SELECTOR(aData)
        set_LP_PROTOCOL_SELECTOR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_LP_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_LP_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_LP_EXTENDED_NEXT_PAGE_ABILITY_value = rightShift(data_low, 12) and &H1
        read_LP_ASYMMETRIC_PAUSE_value = rightShift(data_low, 11) and &H1
        read_LP_PAUSE_CAPABLE_value = rightShift(data_low, 10) and &H1
        read_LP_100BASE_T4_CAPABLE_value = rightShift(data_low, 9) and &H1
        read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 8) and &H1
        read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 7) and &H1
        read_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 6) and &H1
        read_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 5) and &H1
        LP_PROTOCOL_SELECTOR_mask = &H1f
        if data_low > LONG_MAX then
            if LP_PROTOCOL_SELECTOR_mask = mask then
                read_LP_PROTOCOL_SELECTOR_value = data_low
            else
                read_LP_PROTOCOL_SELECTOR_value = (data_low - H8000_0000) and LP_PROTOCOL_SELECTOR_mask
            end If
        else
            read_LP_PROTOCOL_SELECTOR_value = data_low and LP_PROTOCOL_SELECTOR_mask
        end If

    End Sub

    Sub write
        If flag_LP_NEXT_PAGE = &H0 or flag_LP_ACKNOWLEDGE = &H0 or flag_LP_REMOTE_FAULT = &H0 or flag_LP_EXTENDED_NEXT_PAGE_ABILITY = &H0 or flag_LP_ASYMMETRIC_PAUSE = &H0 or flag_LP_PAUSE_CAPABLE = &H0 or flag_LP_100BASE_T4_CAPABLE = &H0 or flag_LP_100BASE_TX_FULL_DUPLEX_CAPABLE = &H0 or flag_LP_100BASE_TX_HALF_DUPLEX_CAPABLE = &H0 or flag_LP_10BASE_T_FULL_DUPLEX_CAPABLE = &H0 or flag_LP_10BASE_T_HALF_DUPLEX_CAPABLE = &H0 or flag_LP_PROTOCOL_SELECTOR = &H0 Then read
        If flag_LP_NEXT_PAGE = &H0 Then write_LP_NEXT_PAGE_value = get_LP_NEXT_PAGE
        If flag_LP_ACKNOWLEDGE = &H0 Then write_LP_ACKNOWLEDGE_value = get_LP_ACKNOWLEDGE
        If flag_LP_REMOTE_FAULT = &H0 Then write_LP_REMOTE_FAULT_value = get_LP_REMOTE_FAULT
        If flag_LP_EXTENDED_NEXT_PAGE_ABILITY = &H0 Then write_LP_EXTENDED_NEXT_PAGE_ABILITY_value = get_LP_EXTENDED_NEXT_PAGE_ABILITY
        If flag_LP_ASYMMETRIC_PAUSE = &H0 Then write_LP_ASYMMETRIC_PAUSE_value = get_LP_ASYMMETRIC_PAUSE
        If flag_LP_PAUSE_CAPABLE = &H0 Then write_LP_PAUSE_CAPABLE_value = get_LP_PAUSE_CAPABLE
        If flag_LP_100BASE_T4_CAPABLE = &H0 Then write_LP_100BASE_T4_CAPABLE_value = get_LP_100BASE_T4_CAPABLE
        If flag_LP_100BASE_TX_FULL_DUPLEX_CAPABLE = &H0 Then write_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value = get_LP_100BASE_TX_FULL_DUPLEX_CAPABLE
        If flag_LP_100BASE_TX_HALF_DUPLEX_CAPABLE = &H0 Then write_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value = get_LP_100BASE_TX_HALF_DUPLEX_CAPABLE
        If flag_LP_10BASE_T_FULL_DUPLEX_CAPABLE = &H0 Then write_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value = get_LP_10BASE_T_FULL_DUPLEX_CAPABLE
        If flag_LP_10BASE_T_HALF_DUPLEX_CAPABLE = &H0 Then write_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value = get_LP_10BASE_T_HALF_DUPLEX_CAPABLE
        If flag_LP_PROTOCOL_SELECTOR = &H0 Then write_LP_PROTOCOL_SELECTOR_value = get_LP_PROTOCOL_SELECTOR

        regValue = leftShift((write_LP_NEXT_PAGE_value and &H1), 15) + leftShift((write_LP_ACKNOWLEDGE_value and &H1), 14) + leftShift((write_LP_REMOTE_FAULT_value and &H1), 13) + leftShift((write_LP_EXTENDED_NEXT_PAGE_ABILITY_value and &H1), 12) + leftShift((write_LP_ASYMMETRIC_PAUSE_value and &H1), 11) + leftShift((write_LP_PAUSE_CAPABLE_value and &H1), 10) + leftShift((write_LP_100BASE_T4_CAPABLE_value and &H1), 9) + leftShift((write_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value and &H1), 8) + leftShift((write_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value and &H1), 7) + leftShift((write_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value and &H1), 6) + leftShift((write_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value and &H1), 5) + leftShift((write_LP_PROTOCOL_SELECTOR_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_LP_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_LP_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_LP_EXTENDED_NEXT_PAGE_ABILITY_value = rightShift(data_low, 12) and &H1
        read_LP_ASYMMETRIC_PAUSE_value = rightShift(data_low, 11) and &H1
        read_LP_PAUSE_CAPABLE_value = rightShift(data_low, 10) and &H1
        read_LP_100BASE_T4_CAPABLE_value = rightShift(data_low, 9) and &H1
        read_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 8) and &H1
        read_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 7) and &H1
        read_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value = rightShift(data_low, 6) and &H1
        read_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value = rightShift(data_low, 5) and &H1
        LP_PROTOCOL_SELECTOR_mask = &H1f
        if data_low > LONG_MAX then
            if LP_PROTOCOL_SELECTOR_mask = mask then
                read_LP_PROTOCOL_SELECTOR_value = data_low
            else
                read_LP_PROTOCOL_SELECTOR_value = (data_low - H8000_0000) and LP_PROTOCOL_SELECTOR_mask
            end If
        else
            read_LP_PROTOCOL_SELECTOR_value = data_low and LP_PROTOCOL_SELECTOR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_NEXT_PAGE_value = &H0
        flag_LP_NEXT_PAGE        = &H0
        write_LP_ACKNOWLEDGE_value = &H0
        flag_LP_ACKNOWLEDGE        = &H0
        write_LP_REMOTE_FAULT_value = &H0
        flag_LP_REMOTE_FAULT        = &H0
        write_LP_EXTENDED_NEXT_PAGE_ABILITY_value = &H0
        flag_LP_EXTENDED_NEXT_PAGE_ABILITY        = &H0
        write_LP_ASYMMETRIC_PAUSE_value = &H0
        flag_LP_ASYMMETRIC_PAUSE        = &H0
        write_LP_PAUSE_CAPABLE_value = &H0
        flag_LP_PAUSE_CAPABLE        = &H0
        write_LP_100BASE_T4_CAPABLE_value = &H0
        flag_LP_100BASE_T4_CAPABLE        = &H0
        write_LP_100BASE_TX_FULL_DUPLEX_CAPABLE_value = &H0
        flag_LP_100BASE_TX_FULL_DUPLEX_CAPABLE        = &H0
        write_LP_100BASE_TX_HALF_DUPLEX_CAPABLE_value = &H0
        flag_LP_100BASE_TX_HALF_DUPLEX_CAPABLE        = &H0
        write_LP_10BASE_T_FULL_DUPLEX_CAPABLE_value = &H0
        flag_LP_10BASE_T_FULL_DUPLEX_CAPABLE        = &H0
        write_LP_10BASE_T_HALF_DUPLEX_CAPABLE_value = &H0
        flag_LP_10BASE_T_HALF_DUPLEX_CAPABLE        = &H0
        write_LP_PROTOCOL_SELECTOR_value = &H0
        flag_LP_PROTOCOL_SELECTOR        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_xnpa
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Next_page                                  [15:15]          get_Next_page
''                                                             set_Next_page
''                                                             read_Next_page
''                                                             write_Next_page
''---------------------------------------------------------------------------------
'' Message_page                               [13:13]          get_Message_page
''                                                             set_Message_page
''                                                             read_Message_page
''                                                             write_Message_page
''---------------------------------------------------------------------------------
'' Acknowledge_2                              [12:12]          get_Acknowledge_2
''                                                             set_Acknowledge_2
''                                                             read_Acknowledge_2
''                                                             write_Acknowledge_2
''---------------------------------------------------------------------------------
'' Toggle                                     [11:11]          get_Toggle
''                                                             set_Toggle
''                                                             read_Toggle
''                                                             write_Toggle
''---------------------------------------------------------------------------------
'' Unformatted_Code_Field                     [10:0]           get_Unformatted_Code_Field
''                                                             set_Unformatted_Code_Field
''                                                             read_Unformatted_Code_Field
''                                                             write_Unformatted_Code_Field
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_xnpa
    Private write_Next_page_value
    Private read_Next_page_value
    Private flag_Next_page
    Private write_Message_page_value
    Private read_Message_page_value
    Private flag_Message_page
    Private write_Acknowledge_2_value
    Private read_Acknowledge_2_value
    Private flag_Acknowledge_2
    Private write_Toggle_value
    Private read_Toggle_value
    Private flag_Toggle
    Private write_Unformatted_Code_Field_value
    Private read_Unformatted_Code_Field_value
    Private flag_Unformatted_Code_Field

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Next_page
        get_Next_page = read_Next_page_value
    End Property

    Property Let set_Next_page(aData)
        write_Next_page_value = aData
        flag_Next_page        = &H1
    End Property

    Property Get read_Next_page
        read
        read_Next_page = read_Next_page_value
    End Property

    Property Let write_Next_page(aData)
        set_Next_page = aData
        write
    End Property

    Property Get get_Message_page
        get_Message_page = read_Message_page_value
    End Property

    Property Let set_Message_page(aData)
        write_Message_page_value = aData
        flag_Message_page        = &H1
    End Property

    Property Get read_Message_page
        read
        read_Message_page = read_Message_page_value
    End Property

    Property Let write_Message_page(aData)
        set_Message_page = aData
        write
    End Property

    Property Get get_Acknowledge_2
        get_Acknowledge_2 = read_Acknowledge_2_value
    End Property

    Property Let set_Acknowledge_2(aData)
        write_Acknowledge_2_value = aData
        flag_Acknowledge_2        = &H1
    End Property

    Property Get read_Acknowledge_2
        read
        read_Acknowledge_2 = read_Acknowledge_2_value
    End Property

    Property Let write_Acknowledge_2(aData)
        set_Acknowledge_2 = aData
        write
    End Property

    Property Get get_Toggle
        get_Toggle = read_Toggle_value
    End Property

    Property Let set_Toggle(aData)
        write_Toggle_value = aData
        flag_Toggle        = &H1
    End Property

    Property Get read_Toggle
        read
        read_Toggle = read_Toggle_value
    End Property

    Property Let write_Toggle(aData)
        set_Toggle = aData
        write
    End Property

    Property Get get_Unformatted_Code_Field
        get_Unformatted_Code_Field = read_Unformatted_Code_Field_value
    End Property

    Property Let set_Unformatted_Code_Field(aData)
        write_Unformatted_Code_Field_value = aData
        flag_Unformatted_Code_Field        = &H1
    End Property

    Property Get read_Unformatted_Code_Field
        read
        read_Unformatted_Code_Field = read_Unformatted_Code_Field_value
    End Property

    Property Let write_Unformatted_Code_Field(aData)
        set_Unformatted_Code_Field = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Next_page_value = rightShift(data_low, 15) and &H1
        read_Message_page_value = rightShift(data_low, 13) and &H1
        read_Acknowledge_2_value = rightShift(data_low, 12) and &H1
        read_Toggle_value = rightShift(data_low, 11) and &H1
        Unformatted_Code_Field_mask = &H7ff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field_mask = mask then
                read_Unformatted_Code_Field_value = data_low
            else
                read_Unformatted_Code_Field_value = (data_low - H8000_0000) and Unformatted_Code_Field_mask
            end If
        else
            read_Unformatted_Code_Field_value = data_low and Unformatted_Code_Field_mask
        end If

    End Sub

    Sub write
        If flag_Next_page = &H0 or flag_Message_page = &H0 or flag_Acknowledge_2 = &H0 or flag_Toggle = &H0 or flag_Unformatted_Code_Field = &H0 Then read
        If flag_Next_page = &H0 Then write_Next_page_value = get_Next_page
        If flag_Message_page = &H0 Then write_Message_page_value = get_Message_page
        If flag_Acknowledge_2 = &H0 Then write_Acknowledge_2_value = get_Acknowledge_2
        If flag_Toggle = &H0 Then write_Toggle_value = get_Toggle
        If flag_Unformatted_Code_Field = &H0 Then write_Unformatted_Code_Field_value = get_Unformatted_Code_Field

        regValue = leftShift((write_Next_page_value and &H1), 15) + leftShift((write_Message_page_value and &H1), 13) + leftShift((write_Acknowledge_2_value and &H1), 12) + leftShift((write_Toggle_value and &H1), 11) + leftShift((write_Unformatted_Code_Field_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Next_page_value = rightShift(data_low, 15) and &H1
        read_Message_page_value = rightShift(data_low, 13) and &H1
        read_Acknowledge_2_value = rightShift(data_low, 12) and &H1
        read_Toggle_value = rightShift(data_low, 11) and &H1
        Unformatted_Code_Field_mask = &H7ff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field_mask = mask then
                read_Unformatted_Code_Field_value = data_low
            else
                read_Unformatted_Code_Field_value = (data_low - H8000_0000) and Unformatted_Code_Field_mask
            end If
        else
            read_Unformatted_Code_Field_value = data_low and Unformatted_Code_Field_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Next_page_value = &H0
        flag_Next_page        = &H0
        write_Message_page_value = &H0
        flag_Message_page        = &H0
        write_Acknowledge_2_value = &H0
        flag_Acknowledge_2        = &H0
        write_Toggle_value = &H0
        flag_Toggle        = &H0
        write_Unformatted_Code_Field_value = &H0
        flag_Unformatted_Code_Field        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_xnpb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Unformatted_Code_Field1                    [15:0]           get_Unformatted_Code_Field1
''                                                             set_Unformatted_Code_Field1
''                                                             read_Unformatted_Code_Field1
''                                                             write_Unformatted_Code_Field1
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_xnpb
    Private write_Unformatted_Code_Field1_value
    Private read_Unformatted_Code_Field1_value
    Private flag_Unformatted_Code_Field1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Unformatted_Code_Field1
        get_Unformatted_Code_Field1 = read_Unformatted_Code_Field1_value
    End Property

    Property Let set_Unformatted_Code_Field1(aData)
        write_Unformatted_Code_Field1_value = aData
        flag_Unformatted_Code_Field1        = &H1
    End Property

    Property Get read_Unformatted_Code_Field1
        read
        read_Unformatted_Code_Field1 = read_Unformatted_Code_Field1_value
    End Property

    Property Let write_Unformatted_Code_Field1(aData)
        set_Unformatted_Code_Field1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field1_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field1_mask = mask then
                read_Unformatted_Code_Field1_value = data_low
            else
                read_Unformatted_Code_Field1_value = (data_low - H8000_0000) and Unformatted_Code_Field1_mask
            end If
        else
            read_Unformatted_Code_Field1_value = data_low and Unformatted_Code_Field1_mask
        end If

    End Sub

    Sub write
        If flag_Unformatted_Code_Field1 = &H0 Then read
        If flag_Unformatted_Code_Field1 = &H0 Then write_Unformatted_Code_Field1_value = get_Unformatted_Code_Field1

        regValue = leftShift((write_Unformatted_Code_Field1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field1_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field1_mask = mask then
                read_Unformatted_Code_Field1_value = data_low
            else
                read_Unformatted_Code_Field1_value = (data_low - H8000_0000) and Unformatted_Code_Field1_mask
            end If
        else
            read_Unformatted_Code_Field1_value = data_low and Unformatted_Code_Field1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Unformatted_Code_Field1_value = &H0
        flag_Unformatted_Code_Field1        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_an_xnpc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Unformatted_Code_Field2                    [15:0]           get_Unformatted_Code_Field2
''                                                             set_Unformatted_Code_Field2
''                                                             read_Unformatted_Code_Field2
''                                                             write_Unformatted_Code_Field2
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_an_xnpc
    Private write_Unformatted_Code_Field2_value
    Private read_Unformatted_Code_Field2_value
    Private flag_Unformatted_Code_Field2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Unformatted_Code_Field2
        get_Unformatted_Code_Field2 = read_Unformatted_Code_Field2_value
    End Property

    Property Let set_Unformatted_Code_Field2(aData)
        write_Unformatted_Code_Field2_value = aData
        flag_Unformatted_Code_Field2        = &H1
    End Property

    Property Get read_Unformatted_Code_Field2
        read
        read_Unformatted_Code_Field2 = read_Unformatted_Code_Field2_value
    End Property

    Property Let write_Unformatted_Code_Field2(aData)
        set_Unformatted_Code_Field2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field2_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field2_mask = mask then
                read_Unformatted_Code_Field2_value = data_low
            else
                read_Unformatted_Code_Field2_value = (data_low - H8000_0000) and Unformatted_Code_Field2_mask
            end If
        else
            read_Unformatted_Code_Field2_value = data_low and Unformatted_Code_Field2_mask
        end If

    End Sub

    Sub write
        If flag_Unformatted_Code_Field2 = &H0 Then read
        If flag_Unformatted_Code_Field2 = &H0 Then write_Unformatted_Code_Field2_value = get_Unformatted_Code_Field2

        regValue = leftShift((write_Unformatted_Code_Field2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field2_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field2_mask = mask then
                read_Unformatted_Code_Field2_value = data_low
            else
                read_Unformatted_Code_Field2_value = (data_low - H8000_0000) and Unformatted_Code_Field2_mask
            end If
        else
            read_Unformatted_Code_Field2_value = data_low and Unformatted_Code_Field2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Unformatted_Code_Field2_value = &H0
        flag_Unformatted_Code_Field2        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_lp_xnpa
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Next_page                                  [15:15]          get_Next_page
''                                                             set_Next_page
''                                                             read_Next_page
''                                                             write_Next_page
''---------------------------------------------------------------------------------
'' Acknowledge                                [14:14]          get_Acknowledge
''                                                             set_Acknowledge
''                                                             read_Acknowledge
''                                                             write_Acknowledge
''---------------------------------------------------------------------------------
'' Message_page                               [13:13]          get_Message_page
''                                                             set_Message_page
''                                                             read_Message_page
''                                                             write_Message_page
''---------------------------------------------------------------------------------
'' Acknowledge_2                              [12:12]          get_Acknowledge_2
''                                                             set_Acknowledge_2
''                                                             read_Acknowledge_2
''                                                             write_Acknowledge_2
''---------------------------------------------------------------------------------
'' Toggle                                     [11:11]          get_Toggle
''                                                             set_Toggle
''                                                             read_Toggle
''                                                             write_Toggle
''---------------------------------------------------------------------------------
'' Unformatted_Code_Field                     [10:0]           get_Unformatted_Code_Field
''                                                             set_Unformatted_Code_Field
''                                                             read_Unformatted_Code_Field
''                                                             write_Unformatted_Code_Field
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_lp_xnpa
    Private write_Next_page_value
    Private read_Next_page_value
    Private flag_Next_page
    Private write_Acknowledge_value
    Private read_Acknowledge_value
    Private flag_Acknowledge
    Private write_Message_page_value
    Private read_Message_page_value
    Private flag_Message_page
    Private write_Acknowledge_2_value
    Private read_Acknowledge_2_value
    Private flag_Acknowledge_2
    Private write_Toggle_value
    Private read_Toggle_value
    Private flag_Toggle
    Private write_Unformatted_Code_Field_value
    Private read_Unformatted_Code_Field_value
    Private flag_Unformatted_Code_Field

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Next_page
        get_Next_page = read_Next_page_value
    End Property

    Property Let set_Next_page(aData)
        write_Next_page_value = aData
        flag_Next_page        = &H1
    End Property

    Property Get read_Next_page
        read
        read_Next_page = read_Next_page_value
    End Property

    Property Let write_Next_page(aData)
        set_Next_page = aData
        write
    End Property

    Property Get get_Acknowledge
        get_Acknowledge = read_Acknowledge_value
    End Property

    Property Let set_Acknowledge(aData)
        write_Acknowledge_value = aData
        flag_Acknowledge        = &H1
    End Property

    Property Get read_Acknowledge
        read
        read_Acknowledge = read_Acknowledge_value
    End Property

    Property Let write_Acknowledge(aData)
        set_Acknowledge = aData
        write
    End Property

    Property Get get_Message_page
        get_Message_page = read_Message_page_value
    End Property

    Property Let set_Message_page(aData)
        write_Message_page_value = aData
        flag_Message_page        = &H1
    End Property

    Property Get read_Message_page
        read
        read_Message_page = read_Message_page_value
    End Property

    Property Let write_Message_page(aData)
        set_Message_page = aData
        write
    End Property

    Property Get get_Acknowledge_2
        get_Acknowledge_2 = read_Acknowledge_2_value
    End Property

    Property Let set_Acknowledge_2(aData)
        write_Acknowledge_2_value = aData
        flag_Acknowledge_2        = &H1
    End Property

    Property Get read_Acknowledge_2
        read
        read_Acknowledge_2 = read_Acknowledge_2_value
    End Property

    Property Let write_Acknowledge_2(aData)
        set_Acknowledge_2 = aData
        write
    End Property

    Property Get get_Toggle
        get_Toggle = read_Toggle_value
    End Property

    Property Let set_Toggle(aData)
        write_Toggle_value = aData
        flag_Toggle        = &H1
    End Property

    Property Get read_Toggle
        read
        read_Toggle = read_Toggle_value
    End Property

    Property Let write_Toggle(aData)
        set_Toggle = aData
        write
    End Property

    Property Get get_Unformatted_Code_Field
        get_Unformatted_Code_Field = read_Unformatted_Code_Field_value
    End Property

    Property Let set_Unformatted_Code_Field(aData)
        write_Unformatted_Code_Field_value = aData
        flag_Unformatted_Code_Field        = &H1
    End Property

    Property Get read_Unformatted_Code_Field
        read
        read_Unformatted_Code_Field = read_Unformatted_Code_Field_value
    End Property

    Property Let write_Unformatted_Code_Field(aData)
        set_Unformatted_Code_Field = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Next_page_value = rightShift(data_low, 15) and &H1
        read_Acknowledge_value = rightShift(data_low, 14) and &H1
        read_Message_page_value = rightShift(data_low, 13) and &H1
        read_Acknowledge_2_value = rightShift(data_low, 12) and &H1
        read_Toggle_value = rightShift(data_low, 11) and &H1
        Unformatted_Code_Field_mask = &H7ff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field_mask = mask then
                read_Unformatted_Code_Field_value = data_low
            else
                read_Unformatted_Code_Field_value = (data_low - H8000_0000) and Unformatted_Code_Field_mask
            end If
        else
            read_Unformatted_Code_Field_value = data_low and Unformatted_Code_Field_mask
        end If

    End Sub

    Sub write
        If flag_Next_page = &H0 or flag_Acknowledge = &H0 or flag_Message_page = &H0 or flag_Acknowledge_2 = &H0 or flag_Toggle = &H0 or flag_Unformatted_Code_Field = &H0 Then read
        If flag_Next_page = &H0 Then write_Next_page_value = get_Next_page
        If flag_Acknowledge = &H0 Then write_Acknowledge_value = get_Acknowledge
        If flag_Message_page = &H0 Then write_Message_page_value = get_Message_page
        If flag_Acknowledge_2 = &H0 Then write_Acknowledge_2_value = get_Acknowledge_2
        If flag_Toggle = &H0 Then write_Toggle_value = get_Toggle
        If flag_Unformatted_Code_Field = &H0 Then write_Unformatted_Code_Field_value = get_Unformatted_Code_Field

        regValue = leftShift((write_Next_page_value and &H1), 15) + leftShift((write_Acknowledge_value and &H1), 14) + leftShift((write_Message_page_value and &H1), 13) + leftShift((write_Acknowledge_2_value and &H1), 12) + leftShift((write_Toggle_value and &H1), 11) + leftShift((write_Unformatted_Code_Field_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Next_page_value = rightShift(data_low, 15) and &H1
        read_Acknowledge_value = rightShift(data_low, 14) and &H1
        read_Message_page_value = rightShift(data_low, 13) and &H1
        read_Acknowledge_2_value = rightShift(data_low, 12) and &H1
        read_Toggle_value = rightShift(data_low, 11) and &H1
        Unformatted_Code_Field_mask = &H7ff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field_mask = mask then
                read_Unformatted_Code_Field_value = data_low
            else
                read_Unformatted_Code_Field_value = (data_low - H8000_0000) and Unformatted_Code_Field_mask
            end If
        else
            read_Unformatted_Code_Field_value = data_low and Unformatted_Code_Field_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Next_page_value = &H0
        flag_Next_page        = &H0
        write_Acknowledge_value = &H0
        flag_Acknowledge        = &H0
        write_Message_page_value = &H0
        flag_Message_page        = &H0
        write_Acknowledge_2_value = &H0
        flag_Acknowledge_2        = &H0
        write_Toggle_value = &H0
        flag_Toggle        = &H0
        write_Unformatted_Code_Field_value = &H0
        flag_Unformatted_Code_Field        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_lp_xnpb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Unformatted_Code_Field1                    [15:0]           get_Unformatted_Code_Field1
''                                                             set_Unformatted_Code_Field1
''                                                             read_Unformatted_Code_Field1
''                                                             write_Unformatted_Code_Field1
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_lp_xnpb
    Private write_Unformatted_Code_Field1_value
    Private read_Unformatted_Code_Field1_value
    Private flag_Unformatted_Code_Field1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Unformatted_Code_Field1
        get_Unformatted_Code_Field1 = read_Unformatted_Code_Field1_value
    End Property

    Property Let set_Unformatted_Code_Field1(aData)
        write_Unformatted_Code_Field1_value = aData
        flag_Unformatted_Code_Field1        = &H1
    End Property

    Property Get read_Unformatted_Code_Field1
        read
        read_Unformatted_Code_Field1 = read_Unformatted_Code_Field1_value
    End Property

    Property Let write_Unformatted_Code_Field1(aData)
        set_Unformatted_Code_Field1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field1_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field1_mask = mask then
                read_Unformatted_Code_Field1_value = data_low
            else
                read_Unformatted_Code_Field1_value = (data_low - H8000_0000) and Unformatted_Code_Field1_mask
            end If
        else
            read_Unformatted_Code_Field1_value = data_low and Unformatted_Code_Field1_mask
        end If

    End Sub

    Sub write
        If flag_Unformatted_Code_Field1 = &H0 Then read
        If flag_Unformatted_Code_Field1 = &H0 Then write_Unformatted_Code_Field1_value = get_Unformatted_Code_Field1

        regValue = leftShift((write_Unformatted_Code_Field1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field1_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field1_mask = mask then
                read_Unformatted_Code_Field1_value = data_low
            else
                read_Unformatted_Code_Field1_value = (data_low - H8000_0000) and Unformatted_Code_Field1_mask
            end If
        else
            read_Unformatted_Code_Field1_value = data_low and Unformatted_Code_Field1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Unformatted_Code_Field1_value = &H0
        flag_Unformatted_Code_Field1        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_lp_xnpc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Unformatted_Code_Field2                    [15:0]           get_Unformatted_Code_Field2
''                                                             set_Unformatted_Code_Field2
''                                                             read_Unformatted_Code_Field2
''                                                             write_Unformatted_Code_Field2
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_lp_xnpc
    Private write_Unformatted_Code_Field2_value
    Private read_Unformatted_Code_Field2_value
    Private flag_Unformatted_Code_Field2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Unformatted_Code_Field2
        get_Unformatted_Code_Field2 = read_Unformatted_Code_Field2_value
    End Property

    Property Let set_Unformatted_Code_Field2(aData)
        write_Unformatted_Code_Field2_value = aData
        flag_Unformatted_Code_Field2        = &H1
    End Property

    Property Get read_Unformatted_Code_Field2
        read
        read_Unformatted_Code_Field2 = read_Unformatted_Code_Field2_value
    End Property

    Property Let write_Unformatted_Code_Field2(aData)
        set_Unformatted_Code_Field2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field2_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field2_mask = mask then
                read_Unformatted_Code_Field2_value = data_low
            else
                read_Unformatted_Code_Field2_value = (data_low - H8000_0000) and Unformatted_Code_Field2_mask
            end If
        else
            read_Unformatted_Code_Field2_value = data_low and Unformatted_Code_Field2_mask
        end If

    End Sub

    Sub write
        If flag_Unformatted_Code_Field2 = &H0 Then read
        If flag_Unformatted_Code_Field2 = &H0 Then write_Unformatted_Code_Field2_value = get_Unformatted_Code_Field2

        regValue = leftShift((write_Unformatted_Code_Field2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Unformatted_Code_Field2_mask = &Hffff
        if data_low > LONG_MAX then
            if Unformatted_Code_Field2_mask = mask then
                read_Unformatted_Code_Field2_value = data_low
            else
                read_Unformatted_Code_Field2_value = (data_low - H8000_0000) and Unformatted_Code_Field2_mask
            end If
        else
            read_Unformatted_Code_Field2_value = data_low and Unformatted_Code_Field2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Unformatted_Code_Field2_value = &H0
        flag_Unformatted_Code_Field2        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_teng_an_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSTR_SLV_MAN_CONFIG_EN                     [15:15]          get_MSTR_SLV_MAN_CONFIG_EN
''                                                             set_MSTR_SLV_MAN_CONFIG_EN
''                                                             read_MSTR_SLV_MAN_CONFIG_EN
''                                                             write_MSTR_SLV_MAN_CONFIG_EN
''---------------------------------------------------------------------------------
'' MSTR_SLV_CONFIG_VAL                        [14:14]          get_MSTR_SLV_CONFIG_VAL
''                                                             set_MSTR_SLV_CONFIG_VAL
''                                                             read_MSTR_SLV_CONFIG_VAL
''                                                             write_MSTR_SLV_CONFIG_VAL
''---------------------------------------------------------------------------------
'' PORT_TYPE                                  [13:13]          get_PORT_TYPE
''                                                             set_PORT_TYPE
''                                                             read_PORT_TYPE
''                                                             write_PORT_TYPE
''---------------------------------------------------------------------------------
'' ld_PHY_10GBASE_T_ABLE                      [12:12]          get_ld_PHY_10GBASE_T_ABLE
''                                                             set_ld_PHY_10GBASE_T_ABLE
''                                                             read_ld_PHY_10GBASE_T_ABLE
''                                                             write_ld_PHY_10GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LD_PHY_5GBASE_T_ABLE                       [8:8]            get_LD_PHY_5GBASE_T_ABLE
''                                                             set_LD_PHY_5GBASE_T_ABLE
''                                                             read_LD_PHY_5GBASE_T_ABLE
''                                                             write_LD_PHY_5GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LD_PHY_2P5GBASE_T_ABLE                     [7:7]            get_LD_PHY_2P5GBASE_T_ABLE
''                                                             set_LD_PHY_2P5GBASE_T_ABLE
''                                                             read_LD_PHY_2P5GBASE_T_ABLE
''                                                             write_LD_PHY_2P5GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LD_FAST_RETRAIN_CAPABLE_5G                 [6:6]            get_LD_FAST_RETRAIN_CAPABLE_5G
''                                                             set_LD_FAST_RETRAIN_CAPABLE_5G
''                                                             read_LD_FAST_RETRAIN_CAPABLE_5G
''                                                             write_LD_FAST_RETRAIN_CAPABLE_5G
''---------------------------------------------------------------------------------
'' LD_FAST_RETRAIN_CAPABLE_2P5G               [5:5]            get_LD_FAST_RETRAIN_CAPABLE_2P5G
''                                                             set_LD_FAST_RETRAIN_CAPABLE_2P5G
''                                                             read_LD_FAST_RETRAIN_CAPABLE_2P5G
''                                                             write_LD_FAST_RETRAIN_CAPABLE_2P5G
''---------------------------------------------------------------------------------
'' LD_PMA_TRAIN_RST_SEQ                       [2:2]            get_LD_PMA_TRAIN_RST_SEQ
''                                                             set_LD_PMA_TRAIN_RST_SEQ
''                                                             read_LD_PMA_TRAIN_RST_SEQ
''                                                             write_LD_PMA_TRAIN_RST_SEQ
''---------------------------------------------------------------------------------
'' LD_FAST_RETRAIN_CAPABLE_10G                [1:1]            get_LD_FAST_RETRAIN_CAPABLE_10G
''                                                             set_LD_FAST_RETRAIN_CAPABLE_10G
''                                                             read_LD_FAST_RETRAIN_CAPABLE_10G
''                                                             write_LD_FAST_RETRAIN_CAPABLE_10G
''---------------------------------------------------------------------------------
'' LD_LOOP_TIMING_ABLE                        [0:0]            get_LD_LOOP_TIMING_ABLE
''                                                             set_LD_LOOP_TIMING_ABLE
''                                                             read_LD_LOOP_TIMING_ABLE
''                                                             write_LD_LOOP_TIMING_ABLE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_teng_an_ctrl
    Private write_MSTR_SLV_MAN_CONFIG_EN_value
    Private read_MSTR_SLV_MAN_CONFIG_EN_value
    Private flag_MSTR_SLV_MAN_CONFIG_EN
    Private write_MSTR_SLV_CONFIG_VAL_value
    Private read_MSTR_SLV_CONFIG_VAL_value
    Private flag_MSTR_SLV_CONFIG_VAL
    Private write_PORT_TYPE_value
    Private read_PORT_TYPE_value
    Private flag_PORT_TYPE
    Private write_ld_PHY_10GBASE_T_ABLE_value
    Private read_ld_PHY_10GBASE_T_ABLE_value
    Private flag_ld_PHY_10GBASE_T_ABLE
    Private write_LD_PHY_5GBASE_T_ABLE_value
    Private read_LD_PHY_5GBASE_T_ABLE_value
    Private flag_LD_PHY_5GBASE_T_ABLE
    Private write_LD_PHY_2P5GBASE_T_ABLE_value
    Private read_LD_PHY_2P5GBASE_T_ABLE_value
    Private flag_LD_PHY_2P5GBASE_T_ABLE
    Private write_LD_FAST_RETRAIN_CAPABLE_5G_value
    Private read_LD_FAST_RETRAIN_CAPABLE_5G_value
    Private flag_LD_FAST_RETRAIN_CAPABLE_5G
    Private write_LD_FAST_RETRAIN_CAPABLE_2P5G_value
    Private read_LD_FAST_RETRAIN_CAPABLE_2P5G_value
    Private flag_LD_FAST_RETRAIN_CAPABLE_2P5G
    Private write_LD_PMA_TRAIN_RST_SEQ_value
    Private read_LD_PMA_TRAIN_RST_SEQ_value
    Private flag_LD_PMA_TRAIN_RST_SEQ
    Private write_LD_FAST_RETRAIN_CAPABLE_10G_value
    Private read_LD_FAST_RETRAIN_CAPABLE_10G_value
    Private flag_LD_FAST_RETRAIN_CAPABLE_10G
    Private write_LD_LOOP_TIMING_ABLE_value
    Private read_LD_LOOP_TIMING_ABLE_value
    Private flag_LD_LOOP_TIMING_ABLE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSTR_SLV_MAN_CONFIG_EN
        get_MSTR_SLV_MAN_CONFIG_EN = read_MSTR_SLV_MAN_CONFIG_EN_value
    End Property

    Property Let set_MSTR_SLV_MAN_CONFIG_EN(aData)
        write_MSTR_SLV_MAN_CONFIG_EN_value = aData
        flag_MSTR_SLV_MAN_CONFIG_EN        = &H1
    End Property

    Property Get read_MSTR_SLV_MAN_CONFIG_EN
        read
        read_MSTR_SLV_MAN_CONFIG_EN = read_MSTR_SLV_MAN_CONFIG_EN_value
    End Property

    Property Let write_MSTR_SLV_MAN_CONFIG_EN(aData)
        set_MSTR_SLV_MAN_CONFIG_EN = aData
        write
    End Property

    Property Get get_MSTR_SLV_CONFIG_VAL
        get_MSTR_SLV_CONFIG_VAL = read_MSTR_SLV_CONFIG_VAL_value
    End Property

    Property Let set_MSTR_SLV_CONFIG_VAL(aData)
        write_MSTR_SLV_CONFIG_VAL_value = aData
        flag_MSTR_SLV_CONFIG_VAL        = &H1
    End Property

    Property Get read_MSTR_SLV_CONFIG_VAL
        read
        read_MSTR_SLV_CONFIG_VAL = read_MSTR_SLV_CONFIG_VAL_value
    End Property

    Property Let write_MSTR_SLV_CONFIG_VAL(aData)
        set_MSTR_SLV_CONFIG_VAL = aData
        write
    End Property

    Property Get get_PORT_TYPE
        get_PORT_TYPE = read_PORT_TYPE_value
    End Property

    Property Let set_PORT_TYPE(aData)
        write_PORT_TYPE_value = aData
        flag_PORT_TYPE        = &H1
    End Property

    Property Get read_PORT_TYPE
        read
        read_PORT_TYPE = read_PORT_TYPE_value
    End Property

    Property Let write_PORT_TYPE(aData)
        set_PORT_TYPE = aData
        write
    End Property

    Property Get get_ld_PHY_10GBASE_T_ABLE
        get_ld_PHY_10GBASE_T_ABLE = read_ld_PHY_10GBASE_T_ABLE_value
    End Property

    Property Let set_ld_PHY_10GBASE_T_ABLE(aData)
        write_ld_PHY_10GBASE_T_ABLE_value = aData
        flag_ld_PHY_10GBASE_T_ABLE        = &H1
    End Property

    Property Get read_ld_PHY_10GBASE_T_ABLE
        read
        read_ld_PHY_10GBASE_T_ABLE = read_ld_PHY_10GBASE_T_ABLE_value
    End Property

    Property Let write_ld_PHY_10GBASE_T_ABLE(aData)
        set_ld_PHY_10GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LD_PHY_5GBASE_T_ABLE
        get_LD_PHY_5GBASE_T_ABLE = read_LD_PHY_5GBASE_T_ABLE_value
    End Property

    Property Let set_LD_PHY_5GBASE_T_ABLE(aData)
        write_LD_PHY_5GBASE_T_ABLE_value = aData
        flag_LD_PHY_5GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LD_PHY_5GBASE_T_ABLE
        read
        read_LD_PHY_5GBASE_T_ABLE = read_LD_PHY_5GBASE_T_ABLE_value
    End Property

    Property Let write_LD_PHY_5GBASE_T_ABLE(aData)
        set_LD_PHY_5GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LD_PHY_2P5GBASE_T_ABLE
        get_LD_PHY_2P5GBASE_T_ABLE = read_LD_PHY_2P5GBASE_T_ABLE_value
    End Property

    Property Let set_LD_PHY_2P5GBASE_T_ABLE(aData)
        write_LD_PHY_2P5GBASE_T_ABLE_value = aData
        flag_LD_PHY_2P5GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LD_PHY_2P5GBASE_T_ABLE
        read
        read_LD_PHY_2P5GBASE_T_ABLE = read_LD_PHY_2P5GBASE_T_ABLE_value
    End Property

    Property Let write_LD_PHY_2P5GBASE_T_ABLE(aData)
        set_LD_PHY_2P5GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LD_FAST_RETRAIN_CAPABLE_5G
        get_LD_FAST_RETRAIN_CAPABLE_5G = read_LD_FAST_RETRAIN_CAPABLE_5G_value
    End Property

    Property Let set_LD_FAST_RETRAIN_CAPABLE_5G(aData)
        write_LD_FAST_RETRAIN_CAPABLE_5G_value = aData
        flag_LD_FAST_RETRAIN_CAPABLE_5G        = &H1
    End Property

    Property Get read_LD_FAST_RETRAIN_CAPABLE_5G
        read
        read_LD_FAST_RETRAIN_CAPABLE_5G = read_LD_FAST_RETRAIN_CAPABLE_5G_value
    End Property

    Property Let write_LD_FAST_RETRAIN_CAPABLE_5G(aData)
        set_LD_FAST_RETRAIN_CAPABLE_5G = aData
        write
    End Property

    Property Get get_LD_FAST_RETRAIN_CAPABLE_2P5G
        get_LD_FAST_RETRAIN_CAPABLE_2P5G = read_LD_FAST_RETRAIN_CAPABLE_2P5G_value
    End Property

    Property Let set_LD_FAST_RETRAIN_CAPABLE_2P5G(aData)
        write_LD_FAST_RETRAIN_CAPABLE_2P5G_value = aData
        flag_LD_FAST_RETRAIN_CAPABLE_2P5G        = &H1
    End Property

    Property Get read_LD_FAST_RETRAIN_CAPABLE_2P5G
        read
        read_LD_FAST_RETRAIN_CAPABLE_2P5G = read_LD_FAST_RETRAIN_CAPABLE_2P5G_value
    End Property

    Property Let write_LD_FAST_RETRAIN_CAPABLE_2P5G(aData)
        set_LD_FAST_RETRAIN_CAPABLE_2P5G = aData
        write
    End Property

    Property Get get_LD_PMA_TRAIN_RST_SEQ
        get_LD_PMA_TRAIN_RST_SEQ = read_LD_PMA_TRAIN_RST_SEQ_value
    End Property

    Property Let set_LD_PMA_TRAIN_RST_SEQ(aData)
        write_LD_PMA_TRAIN_RST_SEQ_value = aData
        flag_LD_PMA_TRAIN_RST_SEQ        = &H1
    End Property

    Property Get read_LD_PMA_TRAIN_RST_SEQ
        read
        read_LD_PMA_TRAIN_RST_SEQ = read_LD_PMA_TRAIN_RST_SEQ_value
    End Property

    Property Let write_LD_PMA_TRAIN_RST_SEQ(aData)
        set_LD_PMA_TRAIN_RST_SEQ = aData
        write
    End Property

    Property Get get_LD_FAST_RETRAIN_CAPABLE_10G
        get_LD_FAST_RETRAIN_CAPABLE_10G = read_LD_FAST_RETRAIN_CAPABLE_10G_value
    End Property

    Property Let set_LD_FAST_RETRAIN_CAPABLE_10G(aData)
        write_LD_FAST_RETRAIN_CAPABLE_10G_value = aData
        flag_LD_FAST_RETRAIN_CAPABLE_10G        = &H1
    End Property

    Property Get read_LD_FAST_RETRAIN_CAPABLE_10G
        read
        read_LD_FAST_RETRAIN_CAPABLE_10G = read_LD_FAST_RETRAIN_CAPABLE_10G_value
    End Property

    Property Let write_LD_FAST_RETRAIN_CAPABLE_10G(aData)
        set_LD_FAST_RETRAIN_CAPABLE_10G = aData
        write
    End Property

    Property Get get_LD_LOOP_TIMING_ABLE
        get_LD_LOOP_TIMING_ABLE = read_LD_LOOP_TIMING_ABLE_value
    End Property

    Property Let set_LD_LOOP_TIMING_ABLE(aData)
        write_LD_LOOP_TIMING_ABLE_value = aData
        flag_LD_LOOP_TIMING_ABLE        = &H1
    End Property

    Property Get read_LD_LOOP_TIMING_ABLE
        read
        read_LD_LOOP_TIMING_ABLE = read_LD_LOOP_TIMING_ABLE_value
    End Property

    Property Let write_LD_LOOP_TIMING_ABLE(aData)
        set_LD_LOOP_TIMING_ABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSTR_SLV_MAN_CONFIG_EN_value = rightShift(data_low, 15) and &H1
        read_MSTR_SLV_CONFIG_VAL_value = rightShift(data_low, 14) and &H1
        read_PORT_TYPE_value = rightShift(data_low, 13) and &H1
        read_ld_PHY_10GBASE_T_ABLE_value = rightShift(data_low, 12) and &H1
        read_LD_PHY_5GBASE_T_ABLE_value = rightShift(data_low, 8) and &H1
        read_LD_PHY_2P5GBASE_T_ABLE_value = rightShift(data_low, 7) and &H1
        read_LD_FAST_RETRAIN_CAPABLE_5G_value = rightShift(data_low, 6) and &H1
        read_LD_FAST_RETRAIN_CAPABLE_2P5G_value = rightShift(data_low, 5) and &H1
        read_LD_PMA_TRAIN_RST_SEQ_value = rightShift(data_low, 2) and &H1
        read_LD_FAST_RETRAIN_CAPABLE_10G_value = rightShift(data_low, 1) and &H1
        LD_LOOP_TIMING_ABLE_mask = &H1
        if data_low > LONG_MAX then
            if LD_LOOP_TIMING_ABLE_mask = mask then
                read_LD_LOOP_TIMING_ABLE_value = data_low
            else
                read_LD_LOOP_TIMING_ABLE_value = (data_low - H8000_0000) and LD_LOOP_TIMING_ABLE_mask
            end If
        else
            read_LD_LOOP_TIMING_ABLE_value = data_low and LD_LOOP_TIMING_ABLE_mask
        end If

    End Sub

    Sub write
        If flag_MSTR_SLV_MAN_CONFIG_EN = &H0 or flag_MSTR_SLV_CONFIG_VAL = &H0 or flag_PORT_TYPE = &H0 or flag_ld_PHY_10GBASE_T_ABLE = &H0 or flag_LD_PHY_5GBASE_T_ABLE = &H0 or flag_LD_PHY_2P5GBASE_T_ABLE = &H0 or flag_LD_FAST_RETRAIN_CAPABLE_5G = &H0 or flag_LD_FAST_RETRAIN_CAPABLE_2P5G = &H0 or flag_LD_PMA_TRAIN_RST_SEQ = &H0 or flag_LD_FAST_RETRAIN_CAPABLE_10G = &H0 or flag_LD_LOOP_TIMING_ABLE = &H0 Then read
        If flag_MSTR_SLV_MAN_CONFIG_EN = &H0 Then write_MSTR_SLV_MAN_CONFIG_EN_value = get_MSTR_SLV_MAN_CONFIG_EN
        If flag_MSTR_SLV_CONFIG_VAL = &H0 Then write_MSTR_SLV_CONFIG_VAL_value = get_MSTR_SLV_CONFIG_VAL
        If flag_PORT_TYPE = &H0 Then write_PORT_TYPE_value = get_PORT_TYPE
        If flag_ld_PHY_10GBASE_T_ABLE = &H0 Then write_ld_PHY_10GBASE_T_ABLE_value = get_ld_PHY_10GBASE_T_ABLE
        If flag_LD_PHY_5GBASE_T_ABLE = &H0 Then write_LD_PHY_5GBASE_T_ABLE_value = get_LD_PHY_5GBASE_T_ABLE
        If flag_LD_PHY_2P5GBASE_T_ABLE = &H0 Then write_LD_PHY_2P5GBASE_T_ABLE_value = get_LD_PHY_2P5GBASE_T_ABLE
        If flag_LD_FAST_RETRAIN_CAPABLE_5G = &H0 Then write_LD_FAST_RETRAIN_CAPABLE_5G_value = get_LD_FAST_RETRAIN_CAPABLE_5G
        If flag_LD_FAST_RETRAIN_CAPABLE_2P5G = &H0 Then write_LD_FAST_RETRAIN_CAPABLE_2P5G_value = get_LD_FAST_RETRAIN_CAPABLE_2P5G
        If flag_LD_PMA_TRAIN_RST_SEQ = &H0 Then write_LD_PMA_TRAIN_RST_SEQ_value = get_LD_PMA_TRAIN_RST_SEQ
        If flag_LD_FAST_RETRAIN_CAPABLE_10G = &H0 Then write_LD_FAST_RETRAIN_CAPABLE_10G_value = get_LD_FAST_RETRAIN_CAPABLE_10G
        If flag_LD_LOOP_TIMING_ABLE = &H0 Then write_LD_LOOP_TIMING_ABLE_value = get_LD_LOOP_TIMING_ABLE

        regValue = leftShift((write_MSTR_SLV_MAN_CONFIG_EN_value and &H1), 15) + leftShift((write_MSTR_SLV_CONFIG_VAL_value and &H1), 14) + leftShift((write_PORT_TYPE_value and &H1), 13) + leftShift((write_ld_PHY_10GBASE_T_ABLE_value and &H1), 12) + leftShift((write_LD_PHY_5GBASE_T_ABLE_value and &H1), 8) + leftShift((write_LD_PHY_2P5GBASE_T_ABLE_value and &H1), 7) + leftShift((write_LD_FAST_RETRAIN_CAPABLE_5G_value and &H1), 6) + leftShift((write_LD_FAST_RETRAIN_CAPABLE_2P5G_value and &H1), 5) + leftShift((write_LD_PMA_TRAIN_RST_SEQ_value and &H1), 2) + leftShift((write_LD_FAST_RETRAIN_CAPABLE_10G_value and &H1), 1) + leftShift((write_LD_LOOP_TIMING_ABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSTR_SLV_MAN_CONFIG_EN_value = rightShift(data_low, 15) and &H1
        read_MSTR_SLV_CONFIG_VAL_value = rightShift(data_low, 14) and &H1
        read_PORT_TYPE_value = rightShift(data_low, 13) and &H1
        read_ld_PHY_10GBASE_T_ABLE_value = rightShift(data_low, 12) and &H1
        read_LD_PHY_5GBASE_T_ABLE_value = rightShift(data_low, 8) and &H1
        read_LD_PHY_2P5GBASE_T_ABLE_value = rightShift(data_low, 7) and &H1
        read_LD_FAST_RETRAIN_CAPABLE_5G_value = rightShift(data_low, 6) and &H1
        read_LD_FAST_RETRAIN_CAPABLE_2P5G_value = rightShift(data_low, 5) and &H1
        read_LD_PMA_TRAIN_RST_SEQ_value = rightShift(data_low, 2) and &H1
        read_LD_FAST_RETRAIN_CAPABLE_10G_value = rightShift(data_low, 1) and &H1
        LD_LOOP_TIMING_ABLE_mask = &H1
        if data_low > LONG_MAX then
            if LD_LOOP_TIMING_ABLE_mask = mask then
                read_LD_LOOP_TIMING_ABLE_value = data_low
            else
                read_LD_LOOP_TIMING_ABLE_value = (data_low - H8000_0000) and LD_LOOP_TIMING_ABLE_mask
            end If
        else
            read_LD_LOOP_TIMING_ABLE_value = data_low and LD_LOOP_TIMING_ABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSTR_SLV_MAN_CONFIG_EN_value = &H0
        flag_MSTR_SLV_MAN_CONFIG_EN        = &H0
        write_MSTR_SLV_CONFIG_VAL_value = &H0
        flag_MSTR_SLV_CONFIG_VAL        = &H0
        write_PORT_TYPE_value = &H0
        flag_PORT_TYPE        = &H0
        write_ld_PHY_10GBASE_T_ABLE_value = &H0
        flag_ld_PHY_10GBASE_T_ABLE        = &H0
        write_LD_PHY_5GBASE_T_ABLE_value = &H0
        flag_LD_PHY_5GBASE_T_ABLE        = &H0
        write_LD_PHY_2P5GBASE_T_ABLE_value = &H0
        flag_LD_PHY_2P5GBASE_T_ABLE        = &H0
        write_LD_FAST_RETRAIN_CAPABLE_5G_value = &H0
        flag_LD_FAST_RETRAIN_CAPABLE_5G        = &H0
        write_LD_FAST_RETRAIN_CAPABLE_2P5G_value = &H0
        flag_LD_FAST_RETRAIN_CAPABLE_2P5G        = &H0
        write_LD_PMA_TRAIN_RST_SEQ_value = &H0
        flag_LD_PMA_TRAIN_RST_SEQ        = &H0
        write_LD_FAST_RETRAIN_CAPABLE_10G_value = &H0
        flag_LD_FAST_RETRAIN_CAPABLE_10G        = &H0
        write_LD_LOOP_TIMING_ABLE_value = &H0
        flag_LD_LOOP_TIMING_ABLE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_teng_an_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSTR_SLV_CONFIG_FAULT                      [15:15]          get_MSTR_SLV_CONFIG_FAULT
''                                                             set_MSTR_SLV_CONFIG_FAULT
''                                                             read_MSTR_SLV_CONFIG_FAULT
''                                                             write_MSTR_SLV_CONFIG_FAULT
''---------------------------------------------------------------------------------
'' MSTR_SLV_CONFIG_RES                        [14:14]          get_MSTR_SLV_CONFIG_RES
''                                                             set_MSTR_SLV_CONFIG_RES
''                                                             read_MSTR_SLV_CONFIG_RES
''                                                             write_MSTR_SLV_CONFIG_RES
''---------------------------------------------------------------------------------
'' LOCAL_RCVR_STAT                            [13:13]          get_LOCAL_RCVR_STAT
''                                                             set_LOCAL_RCVR_STAT
''                                                             read_LOCAL_RCVR_STAT
''                                                             write_LOCAL_RCVR_STAT
''---------------------------------------------------------------------------------
'' REMOTE_RCVR_STAT                           [12:12]          get_REMOTE_RCVR_STAT
''                                                             set_REMOTE_RCVR_STAT
''                                                             read_REMOTE_RCVR_STAT
''                                                             write_REMOTE_RCVR_STAT
''---------------------------------------------------------------------------------
'' LP_PHY_10GBASE_T_ABLE                      [11:11]          get_LP_PHY_10GBASE_T_ABLE
''                                                             set_LP_PHY_10GBASE_T_ABLE
''                                                             read_LP_PHY_10GBASE_T_ABLE
''                                                             write_LP_PHY_10GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LP_LOOP_TIMING_ABLE                        [10:10]          get_LP_LOOP_TIMING_ABLE
''                                                             set_LP_LOOP_TIMING_ABLE
''                                                             read_LP_LOOP_TIMING_ABLE
''                                                             write_LP_LOOP_TIMING_ABLE
''---------------------------------------------------------------------------------
'' LP_PMA_TRAIN_RST_REQ                       [9:9]            get_LP_PMA_TRAIN_RST_REQ
''                                                             set_LP_PMA_TRAIN_RST_REQ
''                                                             read_LP_PMA_TRAIN_RST_REQ
''                                                             write_LP_PMA_TRAIN_RST_REQ
''---------------------------------------------------------------------------------
'' LP_PHY_5GBASE_T_ABLE                       [6:6]            get_LP_PHY_5GBASE_T_ABLE
''                                                             set_LP_PHY_5GBASE_T_ABLE
''                                                             read_LP_PHY_5GBASE_T_ABLE
''                                                             write_LP_PHY_5GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LP_PHY_2P5GBASE_T_ABLE                     [5:5]            get_LP_PHY_2P5GBASE_T_ABLE
''                                                             set_LP_PHY_2P5GBASE_T_ABLE
''                                                             read_LP_PHY_2P5GBASE_T_ABLE
''                                                             write_LP_PHY_2P5GBASE_T_ABLE
''---------------------------------------------------------------------------------
'' LP_FAST_RETRAIN_CAPABLE_5G                 [4:4]            get_LP_FAST_RETRAIN_CAPABLE_5G
''                                                             set_LP_FAST_RETRAIN_CAPABLE_5G
''                                                             read_LP_FAST_RETRAIN_CAPABLE_5G
''                                                             write_LP_FAST_RETRAIN_CAPABLE_5G
''---------------------------------------------------------------------------------
'' LP_FAST_RETRAIN_CAPABLE_2P5G               [3:3]            get_LP_FAST_RETRAIN_CAPABLE_2P5G
''                                                             set_LP_FAST_RETRAIN_CAPABLE_2P5G
''                                                             read_LP_FAST_RETRAIN_CAPABLE_2P5G
''                                                             write_LP_FAST_RETRAIN_CAPABLE_2P5G
''---------------------------------------------------------------------------------
'' LP_FAST_RETRAIN_CAPABLE_10G                [1:1]            get_LP_FAST_RETRAIN_CAPABLE_10G
''                                                             set_LP_FAST_RETRAIN_CAPABLE_10G
''                                                             read_LP_FAST_RETRAIN_CAPABLE_10G
''                                                             write_LP_FAST_RETRAIN_CAPABLE_10G
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_teng_an_stat
    Private write_MSTR_SLV_CONFIG_FAULT_value
    Private read_MSTR_SLV_CONFIG_FAULT_value
    Private flag_MSTR_SLV_CONFIG_FAULT
    Private write_MSTR_SLV_CONFIG_RES_value
    Private read_MSTR_SLV_CONFIG_RES_value
    Private flag_MSTR_SLV_CONFIG_RES
    Private write_LOCAL_RCVR_STAT_value
    Private read_LOCAL_RCVR_STAT_value
    Private flag_LOCAL_RCVR_STAT
    Private write_REMOTE_RCVR_STAT_value
    Private read_REMOTE_RCVR_STAT_value
    Private flag_REMOTE_RCVR_STAT
    Private write_LP_PHY_10GBASE_T_ABLE_value
    Private read_LP_PHY_10GBASE_T_ABLE_value
    Private flag_LP_PHY_10GBASE_T_ABLE
    Private write_LP_LOOP_TIMING_ABLE_value
    Private read_LP_LOOP_TIMING_ABLE_value
    Private flag_LP_LOOP_TIMING_ABLE
    Private write_LP_PMA_TRAIN_RST_REQ_value
    Private read_LP_PMA_TRAIN_RST_REQ_value
    Private flag_LP_PMA_TRAIN_RST_REQ
    Private write_LP_PHY_5GBASE_T_ABLE_value
    Private read_LP_PHY_5GBASE_T_ABLE_value
    Private flag_LP_PHY_5GBASE_T_ABLE
    Private write_LP_PHY_2P5GBASE_T_ABLE_value
    Private read_LP_PHY_2P5GBASE_T_ABLE_value
    Private flag_LP_PHY_2P5GBASE_T_ABLE
    Private write_LP_FAST_RETRAIN_CAPABLE_5G_value
    Private read_LP_FAST_RETRAIN_CAPABLE_5G_value
    Private flag_LP_FAST_RETRAIN_CAPABLE_5G
    Private write_LP_FAST_RETRAIN_CAPABLE_2P5G_value
    Private read_LP_FAST_RETRAIN_CAPABLE_2P5G_value
    Private flag_LP_FAST_RETRAIN_CAPABLE_2P5G
    Private write_LP_FAST_RETRAIN_CAPABLE_10G_value
    Private read_LP_FAST_RETRAIN_CAPABLE_10G_value
    Private flag_LP_FAST_RETRAIN_CAPABLE_10G

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H42
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSTR_SLV_CONFIG_FAULT
        get_MSTR_SLV_CONFIG_FAULT = read_MSTR_SLV_CONFIG_FAULT_value
    End Property

    Property Let set_MSTR_SLV_CONFIG_FAULT(aData)
        write_MSTR_SLV_CONFIG_FAULT_value = aData
        flag_MSTR_SLV_CONFIG_FAULT        = &H1
    End Property

    Property Get read_MSTR_SLV_CONFIG_FAULT
        read
        read_MSTR_SLV_CONFIG_FAULT = read_MSTR_SLV_CONFIG_FAULT_value
    End Property

    Property Let write_MSTR_SLV_CONFIG_FAULT(aData)
        set_MSTR_SLV_CONFIG_FAULT = aData
        write
    End Property

    Property Get get_MSTR_SLV_CONFIG_RES
        get_MSTR_SLV_CONFIG_RES = read_MSTR_SLV_CONFIG_RES_value
    End Property

    Property Let set_MSTR_SLV_CONFIG_RES(aData)
        write_MSTR_SLV_CONFIG_RES_value = aData
        flag_MSTR_SLV_CONFIG_RES        = &H1
    End Property

    Property Get read_MSTR_SLV_CONFIG_RES
        read
        read_MSTR_SLV_CONFIG_RES = read_MSTR_SLV_CONFIG_RES_value
    End Property

    Property Let write_MSTR_SLV_CONFIG_RES(aData)
        set_MSTR_SLV_CONFIG_RES = aData
        write
    End Property

    Property Get get_LOCAL_RCVR_STAT
        get_LOCAL_RCVR_STAT = read_LOCAL_RCVR_STAT_value
    End Property

    Property Let set_LOCAL_RCVR_STAT(aData)
        write_LOCAL_RCVR_STAT_value = aData
        flag_LOCAL_RCVR_STAT        = &H1
    End Property

    Property Get read_LOCAL_RCVR_STAT
        read
        read_LOCAL_RCVR_STAT = read_LOCAL_RCVR_STAT_value
    End Property

    Property Let write_LOCAL_RCVR_STAT(aData)
        set_LOCAL_RCVR_STAT = aData
        write
    End Property

    Property Get get_REMOTE_RCVR_STAT
        get_REMOTE_RCVR_STAT = read_REMOTE_RCVR_STAT_value
    End Property

    Property Let set_REMOTE_RCVR_STAT(aData)
        write_REMOTE_RCVR_STAT_value = aData
        flag_REMOTE_RCVR_STAT        = &H1
    End Property

    Property Get read_REMOTE_RCVR_STAT
        read
        read_REMOTE_RCVR_STAT = read_REMOTE_RCVR_STAT_value
    End Property

    Property Let write_REMOTE_RCVR_STAT(aData)
        set_REMOTE_RCVR_STAT = aData
        write
    End Property

    Property Get get_LP_PHY_10GBASE_T_ABLE
        get_LP_PHY_10GBASE_T_ABLE = read_LP_PHY_10GBASE_T_ABLE_value
    End Property

    Property Let set_LP_PHY_10GBASE_T_ABLE(aData)
        write_LP_PHY_10GBASE_T_ABLE_value = aData
        flag_LP_PHY_10GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LP_PHY_10GBASE_T_ABLE
        read
        read_LP_PHY_10GBASE_T_ABLE = read_LP_PHY_10GBASE_T_ABLE_value
    End Property

    Property Let write_LP_PHY_10GBASE_T_ABLE(aData)
        set_LP_PHY_10GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LP_LOOP_TIMING_ABLE
        get_LP_LOOP_TIMING_ABLE = read_LP_LOOP_TIMING_ABLE_value
    End Property

    Property Let set_LP_LOOP_TIMING_ABLE(aData)
        write_LP_LOOP_TIMING_ABLE_value = aData
        flag_LP_LOOP_TIMING_ABLE        = &H1
    End Property

    Property Get read_LP_LOOP_TIMING_ABLE
        read
        read_LP_LOOP_TIMING_ABLE = read_LP_LOOP_TIMING_ABLE_value
    End Property

    Property Let write_LP_LOOP_TIMING_ABLE(aData)
        set_LP_LOOP_TIMING_ABLE = aData
        write
    End Property

    Property Get get_LP_PMA_TRAIN_RST_REQ
        get_LP_PMA_TRAIN_RST_REQ = read_LP_PMA_TRAIN_RST_REQ_value
    End Property

    Property Let set_LP_PMA_TRAIN_RST_REQ(aData)
        write_LP_PMA_TRAIN_RST_REQ_value = aData
        flag_LP_PMA_TRAIN_RST_REQ        = &H1
    End Property

    Property Get read_LP_PMA_TRAIN_RST_REQ
        read
        read_LP_PMA_TRAIN_RST_REQ = read_LP_PMA_TRAIN_RST_REQ_value
    End Property

    Property Let write_LP_PMA_TRAIN_RST_REQ(aData)
        set_LP_PMA_TRAIN_RST_REQ = aData
        write
    End Property

    Property Get get_LP_PHY_5GBASE_T_ABLE
        get_LP_PHY_5GBASE_T_ABLE = read_LP_PHY_5GBASE_T_ABLE_value
    End Property

    Property Let set_LP_PHY_5GBASE_T_ABLE(aData)
        write_LP_PHY_5GBASE_T_ABLE_value = aData
        flag_LP_PHY_5GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LP_PHY_5GBASE_T_ABLE
        read
        read_LP_PHY_5GBASE_T_ABLE = read_LP_PHY_5GBASE_T_ABLE_value
    End Property

    Property Let write_LP_PHY_5GBASE_T_ABLE(aData)
        set_LP_PHY_5GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LP_PHY_2P5GBASE_T_ABLE
        get_LP_PHY_2P5GBASE_T_ABLE = read_LP_PHY_2P5GBASE_T_ABLE_value
    End Property

    Property Let set_LP_PHY_2P5GBASE_T_ABLE(aData)
        write_LP_PHY_2P5GBASE_T_ABLE_value = aData
        flag_LP_PHY_2P5GBASE_T_ABLE        = &H1
    End Property

    Property Get read_LP_PHY_2P5GBASE_T_ABLE
        read
        read_LP_PHY_2P5GBASE_T_ABLE = read_LP_PHY_2P5GBASE_T_ABLE_value
    End Property

    Property Let write_LP_PHY_2P5GBASE_T_ABLE(aData)
        set_LP_PHY_2P5GBASE_T_ABLE = aData
        write
    End Property

    Property Get get_LP_FAST_RETRAIN_CAPABLE_5G
        get_LP_FAST_RETRAIN_CAPABLE_5G = read_LP_FAST_RETRAIN_CAPABLE_5G_value
    End Property

    Property Let set_LP_FAST_RETRAIN_CAPABLE_5G(aData)
        write_LP_FAST_RETRAIN_CAPABLE_5G_value = aData
        flag_LP_FAST_RETRAIN_CAPABLE_5G        = &H1
    End Property

    Property Get read_LP_FAST_RETRAIN_CAPABLE_5G
        read
        read_LP_FAST_RETRAIN_CAPABLE_5G = read_LP_FAST_RETRAIN_CAPABLE_5G_value
    End Property

    Property Let write_LP_FAST_RETRAIN_CAPABLE_5G(aData)
        set_LP_FAST_RETRAIN_CAPABLE_5G = aData
        write
    End Property

    Property Get get_LP_FAST_RETRAIN_CAPABLE_2P5G
        get_LP_FAST_RETRAIN_CAPABLE_2P5G = read_LP_FAST_RETRAIN_CAPABLE_2P5G_value
    End Property

    Property Let set_LP_FAST_RETRAIN_CAPABLE_2P5G(aData)
        write_LP_FAST_RETRAIN_CAPABLE_2P5G_value = aData
        flag_LP_FAST_RETRAIN_CAPABLE_2P5G        = &H1
    End Property

    Property Get read_LP_FAST_RETRAIN_CAPABLE_2P5G
        read
        read_LP_FAST_RETRAIN_CAPABLE_2P5G = read_LP_FAST_RETRAIN_CAPABLE_2P5G_value
    End Property

    Property Let write_LP_FAST_RETRAIN_CAPABLE_2P5G(aData)
        set_LP_FAST_RETRAIN_CAPABLE_2P5G = aData
        write
    End Property

    Property Get get_LP_FAST_RETRAIN_CAPABLE_10G
        get_LP_FAST_RETRAIN_CAPABLE_10G = read_LP_FAST_RETRAIN_CAPABLE_10G_value
    End Property

    Property Let set_LP_FAST_RETRAIN_CAPABLE_10G(aData)
        write_LP_FAST_RETRAIN_CAPABLE_10G_value = aData
        flag_LP_FAST_RETRAIN_CAPABLE_10G        = &H1
    End Property

    Property Get read_LP_FAST_RETRAIN_CAPABLE_10G
        read
        read_LP_FAST_RETRAIN_CAPABLE_10G = read_LP_FAST_RETRAIN_CAPABLE_10G_value
    End Property

    Property Let write_LP_FAST_RETRAIN_CAPABLE_10G(aData)
        set_LP_FAST_RETRAIN_CAPABLE_10G = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSTR_SLV_CONFIG_FAULT_value = rightShift(data_low, 15) and &H1
        read_MSTR_SLV_CONFIG_RES_value = rightShift(data_low, 14) and &H1
        read_LOCAL_RCVR_STAT_value = rightShift(data_low, 13) and &H1
        read_REMOTE_RCVR_STAT_value = rightShift(data_low, 12) and &H1
        read_LP_PHY_10GBASE_T_ABLE_value = rightShift(data_low, 11) and &H1
        read_LP_LOOP_TIMING_ABLE_value = rightShift(data_low, 10) and &H1
        read_LP_PMA_TRAIN_RST_REQ_value = rightShift(data_low, 9) and &H1
        read_LP_PHY_5GBASE_T_ABLE_value = rightShift(data_low, 6) and &H1
        read_LP_PHY_2P5GBASE_T_ABLE_value = rightShift(data_low, 5) and &H1
        read_LP_FAST_RETRAIN_CAPABLE_5G_value = rightShift(data_low, 4) and &H1
        read_LP_FAST_RETRAIN_CAPABLE_2P5G_value = rightShift(data_low, 3) and &H1
        read_LP_FAST_RETRAIN_CAPABLE_10G_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_MSTR_SLV_CONFIG_FAULT = &H0 or flag_MSTR_SLV_CONFIG_RES = &H0 or flag_LOCAL_RCVR_STAT = &H0 or flag_REMOTE_RCVR_STAT = &H0 or flag_LP_PHY_10GBASE_T_ABLE = &H0 or flag_LP_LOOP_TIMING_ABLE = &H0 or flag_LP_PMA_TRAIN_RST_REQ = &H0 or flag_LP_PHY_5GBASE_T_ABLE = &H0 or flag_LP_PHY_2P5GBASE_T_ABLE = &H0 or flag_LP_FAST_RETRAIN_CAPABLE_5G = &H0 or flag_LP_FAST_RETRAIN_CAPABLE_2P5G = &H0 or flag_LP_FAST_RETRAIN_CAPABLE_10G = &H0 Then read
        If flag_MSTR_SLV_CONFIG_FAULT = &H0 Then write_MSTR_SLV_CONFIG_FAULT_value = get_MSTR_SLV_CONFIG_FAULT
        If flag_MSTR_SLV_CONFIG_RES = &H0 Then write_MSTR_SLV_CONFIG_RES_value = get_MSTR_SLV_CONFIG_RES
        If flag_LOCAL_RCVR_STAT = &H0 Then write_LOCAL_RCVR_STAT_value = get_LOCAL_RCVR_STAT
        If flag_REMOTE_RCVR_STAT = &H0 Then write_REMOTE_RCVR_STAT_value = get_REMOTE_RCVR_STAT
        If flag_LP_PHY_10GBASE_T_ABLE = &H0 Then write_LP_PHY_10GBASE_T_ABLE_value = get_LP_PHY_10GBASE_T_ABLE
        If flag_LP_LOOP_TIMING_ABLE = &H0 Then write_LP_LOOP_TIMING_ABLE_value = get_LP_LOOP_TIMING_ABLE
        If flag_LP_PMA_TRAIN_RST_REQ = &H0 Then write_LP_PMA_TRAIN_RST_REQ_value = get_LP_PMA_TRAIN_RST_REQ
        If flag_LP_PHY_5GBASE_T_ABLE = &H0 Then write_LP_PHY_5GBASE_T_ABLE_value = get_LP_PHY_5GBASE_T_ABLE
        If flag_LP_PHY_2P5GBASE_T_ABLE = &H0 Then write_LP_PHY_2P5GBASE_T_ABLE_value = get_LP_PHY_2P5GBASE_T_ABLE
        If flag_LP_FAST_RETRAIN_CAPABLE_5G = &H0 Then write_LP_FAST_RETRAIN_CAPABLE_5G_value = get_LP_FAST_RETRAIN_CAPABLE_5G
        If flag_LP_FAST_RETRAIN_CAPABLE_2P5G = &H0 Then write_LP_FAST_RETRAIN_CAPABLE_2P5G_value = get_LP_FAST_RETRAIN_CAPABLE_2P5G
        If flag_LP_FAST_RETRAIN_CAPABLE_10G = &H0 Then write_LP_FAST_RETRAIN_CAPABLE_10G_value = get_LP_FAST_RETRAIN_CAPABLE_10G

        regValue = leftShift((write_MSTR_SLV_CONFIG_FAULT_value and &H1), 15) + leftShift((write_MSTR_SLV_CONFIG_RES_value and &H1), 14) + leftShift((write_LOCAL_RCVR_STAT_value and &H1), 13) + leftShift((write_REMOTE_RCVR_STAT_value and &H1), 12) + leftShift((write_LP_PHY_10GBASE_T_ABLE_value and &H1), 11) + leftShift((write_LP_LOOP_TIMING_ABLE_value and &H1), 10) + leftShift((write_LP_PMA_TRAIN_RST_REQ_value and &H1), 9) + leftShift((write_LP_PHY_5GBASE_T_ABLE_value and &H1), 6) + leftShift((write_LP_PHY_2P5GBASE_T_ABLE_value and &H1), 5) + leftShift((write_LP_FAST_RETRAIN_CAPABLE_5G_value and &H1), 4) + leftShift((write_LP_FAST_RETRAIN_CAPABLE_2P5G_value and &H1), 3) + leftShift((write_LP_FAST_RETRAIN_CAPABLE_10G_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSTR_SLV_CONFIG_FAULT_value = rightShift(data_low, 15) and &H1
        read_MSTR_SLV_CONFIG_RES_value = rightShift(data_low, 14) and &H1
        read_LOCAL_RCVR_STAT_value = rightShift(data_low, 13) and &H1
        read_REMOTE_RCVR_STAT_value = rightShift(data_low, 12) and &H1
        read_LP_PHY_10GBASE_T_ABLE_value = rightShift(data_low, 11) and &H1
        read_LP_LOOP_TIMING_ABLE_value = rightShift(data_low, 10) and &H1
        read_LP_PMA_TRAIN_RST_REQ_value = rightShift(data_low, 9) and &H1
        read_LP_PHY_5GBASE_T_ABLE_value = rightShift(data_low, 6) and &H1
        read_LP_PHY_2P5GBASE_T_ABLE_value = rightShift(data_low, 5) and &H1
        read_LP_FAST_RETRAIN_CAPABLE_5G_value = rightShift(data_low, 4) and &H1
        read_LP_FAST_RETRAIN_CAPABLE_2P5G_value = rightShift(data_low, 3) and &H1
        read_LP_FAST_RETRAIN_CAPABLE_10G_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSTR_SLV_CONFIG_FAULT_value = &H0
        flag_MSTR_SLV_CONFIG_FAULT        = &H0
        write_MSTR_SLV_CONFIG_RES_value = &H0
        flag_MSTR_SLV_CONFIG_RES        = &H0
        write_LOCAL_RCVR_STAT_value = &H0
        flag_LOCAL_RCVR_STAT        = &H0
        write_REMOTE_RCVR_STAT_value = &H0
        flag_REMOTE_RCVR_STAT        = &H0
        write_LP_PHY_10GBASE_T_ABLE_value = &H0
        flag_LP_PHY_10GBASE_T_ABLE        = &H0
        write_LP_LOOP_TIMING_ABLE_value = &H0
        flag_LP_LOOP_TIMING_ABLE        = &H0
        write_LP_PMA_TRAIN_RST_REQ_value = &H0
        flag_LP_PMA_TRAIN_RST_REQ        = &H0
        write_LP_PHY_5GBASE_T_ABLE_value = &H0
        flag_LP_PHY_5GBASE_T_ABLE        = &H0
        write_LP_PHY_2P5GBASE_T_ABLE_value = &H0
        flag_LP_PHY_2P5GBASE_T_ABLE        = &H0
        write_LP_FAST_RETRAIN_CAPABLE_5G_value = &H0
        flag_LP_FAST_RETRAIN_CAPABLE_5G        = &H0
        write_LP_FAST_RETRAIN_CAPABLE_2P5G_value = &H0
        flag_LP_FAST_RETRAIN_CAPABLE_2P5G        = &H0
        write_LP_FAST_RETRAIN_CAPABLE_10G_value = &H0
        flag_LP_FAST_RETRAIN_CAPABLE_10G        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_eee_adv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHY_10GBASE_KR_EEE                         [6:6]            get_PHY_10GBASE_KR_EEE
''                                                             set_PHY_10GBASE_KR_EEE
''                                                             read_PHY_10GBASE_KR_EEE
''                                                             write_PHY_10GBASE_KR_EEE
''---------------------------------------------------------------------------------
'' PHY_10GBASE_KX4_EEE                        [5:5]            get_PHY_10GBASE_KX4_EEE
''                                                             set_PHY_10GBASE_KX4_EEE
''                                                             read_PHY_10GBASE_KX4_EEE
''                                                             write_PHY_10GBASE_KX4_EEE
''---------------------------------------------------------------------------------
'' PHY_10GBASE_T_EEE                          [3:3]            get_PHY_10GBASE_T_EEE
''                                                             set_PHY_10GBASE_T_EEE
''                                                             read_PHY_10GBASE_T_EEE
''                                                             write_PHY_10GBASE_T_EEE
''---------------------------------------------------------------------------------
'' PHY_1000BASE_T_EEE                         [2:2]            get_PHY_1000BASE_T_EEE
''                                                             set_PHY_1000BASE_T_EEE
''                                                             read_PHY_1000BASE_T_EEE
''                                                             write_PHY_1000BASE_T_EEE
''---------------------------------------------------------------------------------
'' PHY_100BASE_T_EEE                          [1:1]            get_PHY_100BASE_T_EEE
''                                                             set_PHY_100BASE_T_EEE
''                                                             read_PHY_100BASE_T_EEE
''                                                             write_PHY_100BASE_T_EEE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_eee_adv
    Private write_PHY_10GBASE_KR_EEE_value
    Private read_PHY_10GBASE_KR_EEE_value
    Private flag_PHY_10GBASE_KR_EEE
    Private write_PHY_10GBASE_KX4_EEE_value
    Private read_PHY_10GBASE_KX4_EEE_value
    Private flag_PHY_10GBASE_KX4_EEE
    Private write_PHY_10GBASE_T_EEE_value
    Private read_PHY_10GBASE_T_EEE_value
    Private flag_PHY_10GBASE_T_EEE
    Private write_PHY_1000BASE_T_EEE_value
    Private read_PHY_1000BASE_T_EEE_value
    Private flag_PHY_1000BASE_T_EEE
    Private write_PHY_100BASE_T_EEE_value
    Private read_PHY_100BASE_T_EEE_value
    Private flag_PHY_100BASE_T_EEE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHY_10GBASE_KR_EEE
        get_PHY_10GBASE_KR_EEE = read_PHY_10GBASE_KR_EEE_value
    End Property

    Property Let set_PHY_10GBASE_KR_EEE(aData)
        write_PHY_10GBASE_KR_EEE_value = aData
        flag_PHY_10GBASE_KR_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASE_KR_EEE
        read
        read_PHY_10GBASE_KR_EEE = read_PHY_10GBASE_KR_EEE_value
    End Property

    Property Let write_PHY_10GBASE_KR_EEE(aData)
        set_PHY_10GBASE_KR_EEE = aData
        write
    End Property

    Property Get get_PHY_10GBASE_KX4_EEE
        get_PHY_10GBASE_KX4_EEE = read_PHY_10GBASE_KX4_EEE_value
    End Property

    Property Let set_PHY_10GBASE_KX4_EEE(aData)
        write_PHY_10GBASE_KX4_EEE_value = aData
        flag_PHY_10GBASE_KX4_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASE_KX4_EEE
        read
        read_PHY_10GBASE_KX4_EEE = read_PHY_10GBASE_KX4_EEE_value
    End Property

    Property Let write_PHY_10GBASE_KX4_EEE(aData)
        set_PHY_10GBASE_KX4_EEE = aData
        write
    End Property

    Property Get get_PHY_10GBASE_T_EEE
        get_PHY_10GBASE_T_EEE = read_PHY_10GBASE_T_EEE_value
    End Property

    Property Let set_PHY_10GBASE_T_EEE(aData)
        write_PHY_10GBASE_T_EEE_value = aData
        flag_PHY_10GBASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASE_T_EEE
        read
        read_PHY_10GBASE_T_EEE = read_PHY_10GBASE_T_EEE_value
    End Property

    Property Let write_PHY_10GBASE_T_EEE(aData)
        set_PHY_10GBASE_T_EEE = aData
        write
    End Property

    Property Get get_PHY_1000BASE_T_EEE
        get_PHY_1000BASE_T_EEE = read_PHY_1000BASE_T_EEE_value
    End Property

    Property Let set_PHY_1000BASE_T_EEE(aData)
        write_PHY_1000BASE_T_EEE_value = aData
        flag_PHY_1000BASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_1000BASE_T_EEE
        read
        read_PHY_1000BASE_T_EEE = read_PHY_1000BASE_T_EEE_value
    End Property

    Property Let write_PHY_1000BASE_T_EEE(aData)
        set_PHY_1000BASE_T_EEE = aData
        write
    End Property

    Property Get get_PHY_100BASE_T_EEE
        get_PHY_100BASE_T_EEE = read_PHY_100BASE_T_EEE_value
    End Property

    Property Let set_PHY_100BASE_T_EEE(aData)
        write_PHY_100BASE_T_EEE_value = aData
        flag_PHY_100BASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_100BASE_T_EEE
        read
        read_PHY_100BASE_T_EEE = read_PHY_100BASE_T_EEE_value
    End Property

    Property Let write_PHY_100BASE_T_EEE(aData)
        set_PHY_100BASE_T_EEE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_10GBASE_KR_EEE_value = rightShift(data_low, 6) and &H1
        read_PHY_10GBASE_KX4_EEE_value = rightShift(data_low, 5) and &H1
        read_PHY_10GBASE_T_EEE_value = rightShift(data_low, 3) and &H1
        read_PHY_1000BASE_T_EEE_value = rightShift(data_low, 2) and &H1
        read_PHY_100BASE_T_EEE_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_PHY_10GBASE_KR_EEE = &H0 or flag_PHY_10GBASE_KX4_EEE = &H0 or flag_PHY_10GBASE_T_EEE = &H0 or flag_PHY_1000BASE_T_EEE = &H0 or flag_PHY_100BASE_T_EEE = &H0 Then read
        If flag_PHY_10GBASE_KR_EEE = &H0 Then write_PHY_10GBASE_KR_EEE_value = get_PHY_10GBASE_KR_EEE
        If flag_PHY_10GBASE_KX4_EEE = &H0 Then write_PHY_10GBASE_KX4_EEE_value = get_PHY_10GBASE_KX4_EEE
        If flag_PHY_10GBASE_T_EEE = &H0 Then write_PHY_10GBASE_T_EEE_value = get_PHY_10GBASE_T_EEE
        If flag_PHY_1000BASE_T_EEE = &H0 Then write_PHY_1000BASE_T_EEE_value = get_PHY_1000BASE_T_EEE
        If flag_PHY_100BASE_T_EEE = &H0 Then write_PHY_100BASE_T_EEE_value = get_PHY_100BASE_T_EEE

        regValue = leftShift((write_PHY_10GBASE_KR_EEE_value and &H1), 6) + leftShift((write_PHY_10GBASE_KX4_EEE_value and &H1), 5) + leftShift((write_PHY_10GBASE_T_EEE_value and &H1), 3) + leftShift((write_PHY_1000BASE_T_EEE_value and &H1), 2) + leftShift((write_PHY_100BASE_T_EEE_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_10GBASE_KR_EEE_value = rightShift(data_low, 6) and &H1
        read_PHY_10GBASE_KX4_EEE_value = rightShift(data_low, 5) and &H1
        read_PHY_10GBASE_T_EEE_value = rightShift(data_low, 3) and &H1
        read_PHY_1000BASE_T_EEE_value = rightShift(data_low, 2) and &H1
        read_PHY_100BASE_T_EEE_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHY_10GBASE_KR_EEE_value = &H0
        flag_PHY_10GBASE_KR_EEE        = &H0
        write_PHY_10GBASE_KX4_EEE_value = &H0
        flag_PHY_10GBASE_KX4_EEE        = &H0
        write_PHY_10GBASE_T_EEE_value = &H0
        flag_PHY_10GBASE_T_EEE        = &H0
        write_PHY_1000BASE_T_EEE_value = &H0
        flag_PHY_1000BASE_T_EEE        = &H0
        write_PHY_100BASE_T_EEE_value = &H0
        flag_PHY_100BASE_T_EEE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_eee_lp_adv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHY_10GBASE_KR_EEE                         [6:6]            get_PHY_10GBASE_KR_EEE
''                                                             set_PHY_10GBASE_KR_EEE
''                                                             read_PHY_10GBASE_KR_EEE
''                                                             write_PHY_10GBASE_KR_EEE
''---------------------------------------------------------------------------------
'' PHY_10GBASE_KX4_EEE                        [5:5]            get_PHY_10GBASE_KX4_EEE
''                                                             set_PHY_10GBASE_KX4_EEE
''                                                             read_PHY_10GBASE_KX4_EEE
''                                                             write_PHY_10GBASE_KX4_EEE
''---------------------------------------------------------------------------------
'' PHY_10GBASE_T_EEE                          [3:3]            get_PHY_10GBASE_T_EEE
''                                                             set_PHY_10GBASE_T_EEE
''                                                             read_PHY_10GBASE_T_EEE
''                                                             write_PHY_10GBASE_T_EEE
''---------------------------------------------------------------------------------
'' PHY_1000BASE_T_EEE                         [2:2]            get_PHY_1000BASE_T_EEE
''                                                             set_PHY_1000BASE_T_EEE
''                                                             read_PHY_1000BASE_T_EEE
''                                                             write_PHY_1000BASE_T_EEE
''---------------------------------------------------------------------------------
'' PHY_100BASE_T_EEE                          [1:1]            get_PHY_100BASE_T_EEE
''                                                             set_PHY_100BASE_T_EEE
''                                                             read_PHY_100BASE_T_EEE
''                                                             write_PHY_100BASE_T_EEE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_eee_lp_adv
    Private write_PHY_10GBASE_KR_EEE_value
    Private read_PHY_10GBASE_KR_EEE_value
    Private flag_PHY_10GBASE_KR_EEE
    Private write_PHY_10GBASE_KX4_EEE_value
    Private read_PHY_10GBASE_KX4_EEE_value
    Private flag_PHY_10GBASE_KX4_EEE
    Private write_PHY_10GBASE_T_EEE_value
    Private read_PHY_10GBASE_T_EEE_value
    Private flag_PHY_10GBASE_T_EEE
    Private write_PHY_1000BASE_T_EEE_value
    Private read_PHY_1000BASE_T_EEE_value
    Private flag_PHY_1000BASE_T_EEE
    Private write_PHY_100BASE_T_EEE_value
    Private read_PHY_100BASE_T_EEE_value
    Private flag_PHY_100BASE_T_EEE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHY_10GBASE_KR_EEE
        get_PHY_10GBASE_KR_EEE = read_PHY_10GBASE_KR_EEE_value
    End Property

    Property Let set_PHY_10GBASE_KR_EEE(aData)
        write_PHY_10GBASE_KR_EEE_value = aData
        flag_PHY_10GBASE_KR_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASE_KR_EEE
        read
        read_PHY_10GBASE_KR_EEE = read_PHY_10GBASE_KR_EEE_value
    End Property

    Property Let write_PHY_10GBASE_KR_EEE(aData)
        set_PHY_10GBASE_KR_EEE = aData
        write
    End Property

    Property Get get_PHY_10GBASE_KX4_EEE
        get_PHY_10GBASE_KX4_EEE = read_PHY_10GBASE_KX4_EEE_value
    End Property

    Property Let set_PHY_10GBASE_KX4_EEE(aData)
        write_PHY_10GBASE_KX4_EEE_value = aData
        flag_PHY_10GBASE_KX4_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASE_KX4_EEE
        read
        read_PHY_10GBASE_KX4_EEE = read_PHY_10GBASE_KX4_EEE_value
    End Property

    Property Let write_PHY_10GBASE_KX4_EEE(aData)
        set_PHY_10GBASE_KX4_EEE = aData
        write
    End Property

    Property Get get_PHY_10GBASE_T_EEE
        get_PHY_10GBASE_T_EEE = read_PHY_10GBASE_T_EEE_value
    End Property

    Property Let set_PHY_10GBASE_T_EEE(aData)
        write_PHY_10GBASE_T_EEE_value = aData
        flag_PHY_10GBASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASE_T_EEE
        read
        read_PHY_10GBASE_T_EEE = read_PHY_10GBASE_T_EEE_value
    End Property

    Property Let write_PHY_10GBASE_T_EEE(aData)
        set_PHY_10GBASE_T_EEE = aData
        write
    End Property

    Property Get get_PHY_1000BASE_T_EEE
        get_PHY_1000BASE_T_EEE = read_PHY_1000BASE_T_EEE_value
    End Property

    Property Let set_PHY_1000BASE_T_EEE(aData)
        write_PHY_1000BASE_T_EEE_value = aData
        flag_PHY_1000BASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_1000BASE_T_EEE
        read
        read_PHY_1000BASE_T_EEE = read_PHY_1000BASE_T_EEE_value
    End Property

    Property Let write_PHY_1000BASE_T_EEE(aData)
        set_PHY_1000BASE_T_EEE = aData
        write
    End Property

    Property Get get_PHY_100BASE_T_EEE
        get_PHY_100BASE_T_EEE = read_PHY_100BASE_T_EEE_value
    End Property

    Property Let set_PHY_100BASE_T_EEE(aData)
        write_PHY_100BASE_T_EEE_value = aData
        flag_PHY_100BASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_100BASE_T_EEE
        read
        read_PHY_100BASE_T_EEE = read_PHY_100BASE_T_EEE_value
    End Property

    Property Let write_PHY_100BASE_T_EEE(aData)
        set_PHY_100BASE_T_EEE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_10GBASE_KR_EEE_value = rightShift(data_low, 6) and &H1
        read_PHY_10GBASE_KX4_EEE_value = rightShift(data_low, 5) and &H1
        read_PHY_10GBASE_T_EEE_value = rightShift(data_low, 3) and &H1
        read_PHY_1000BASE_T_EEE_value = rightShift(data_low, 2) and &H1
        read_PHY_100BASE_T_EEE_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_PHY_10GBASE_KR_EEE = &H0 or flag_PHY_10GBASE_KX4_EEE = &H0 or flag_PHY_10GBASE_T_EEE = &H0 or flag_PHY_1000BASE_T_EEE = &H0 or flag_PHY_100BASE_T_EEE = &H0 Then read
        If flag_PHY_10GBASE_KR_EEE = &H0 Then write_PHY_10GBASE_KR_EEE_value = get_PHY_10GBASE_KR_EEE
        If flag_PHY_10GBASE_KX4_EEE = &H0 Then write_PHY_10GBASE_KX4_EEE_value = get_PHY_10GBASE_KX4_EEE
        If flag_PHY_10GBASE_T_EEE = &H0 Then write_PHY_10GBASE_T_EEE_value = get_PHY_10GBASE_T_EEE
        If flag_PHY_1000BASE_T_EEE = &H0 Then write_PHY_1000BASE_T_EEE_value = get_PHY_1000BASE_T_EEE
        If flag_PHY_100BASE_T_EEE = &H0 Then write_PHY_100BASE_T_EEE_value = get_PHY_100BASE_T_EEE

        regValue = leftShift((write_PHY_10GBASE_KR_EEE_value and &H1), 6) + leftShift((write_PHY_10GBASE_KX4_EEE_value and &H1), 5) + leftShift((write_PHY_10GBASE_T_EEE_value and &H1), 3) + leftShift((write_PHY_1000BASE_T_EEE_value and &H1), 2) + leftShift((write_PHY_100BASE_T_EEE_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_10GBASE_KR_EEE_value = rightShift(data_low, 6) and &H1
        read_PHY_10GBASE_KX4_EEE_value = rightShift(data_low, 5) and &H1
        read_PHY_10GBASE_T_EEE_value = rightShift(data_low, 3) and &H1
        read_PHY_1000BASE_T_EEE_value = rightShift(data_low, 2) and &H1
        read_PHY_100BASE_T_EEE_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHY_10GBASE_KR_EEE_value = &H0
        flag_PHY_10GBASE_KR_EEE        = &H0
        write_PHY_10GBASE_KX4_EEE_value = &H0
        flag_PHY_10GBASE_KX4_EEE        = &H0
        write_PHY_10GBASE_T_EEE_value = &H0
        flag_PHY_10GBASE_T_EEE        = &H0
        write_PHY_1000BASE_T_EEE_value = &H0
        flag_PHY_1000BASE_T_EEE        = &H0
        write_PHY_100BASE_T_EEE_value = &H0
        flag_PHY_100BASE_T_EEE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_eee_adv_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHY_5GBASE_T_EEE                           [1:1]            get_PHY_5GBASE_T_EEE
''                                                             set_PHY_5GBASE_T_EEE
''                                                             read_PHY_5GBASE_T_EEE
''                                                             write_PHY_5GBASE_T_EEE
''---------------------------------------------------------------------------------
'' PHY_2P5GBASE_T_EEE                         [0:0]            get_PHY_2P5GBASE_T_EEE
''                                                             set_PHY_2P5GBASE_T_EEE
''                                                             read_PHY_2P5GBASE_T_EEE
''                                                             write_PHY_2P5GBASE_T_EEE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_eee_adv_2
    Private write_PHY_5GBASE_T_EEE_value
    Private read_PHY_5GBASE_T_EEE_value
    Private flag_PHY_5GBASE_T_EEE
    Private write_PHY_2P5GBASE_T_EEE_value
    Private read_PHY_2P5GBASE_T_EEE_value
    Private flag_PHY_2P5GBASE_T_EEE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHY_5GBASE_T_EEE
        get_PHY_5GBASE_T_EEE = read_PHY_5GBASE_T_EEE_value
    End Property

    Property Let set_PHY_5GBASE_T_EEE(aData)
        write_PHY_5GBASE_T_EEE_value = aData
        flag_PHY_5GBASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_5GBASE_T_EEE
        read
        read_PHY_5GBASE_T_EEE = read_PHY_5GBASE_T_EEE_value
    End Property

    Property Let write_PHY_5GBASE_T_EEE(aData)
        set_PHY_5GBASE_T_EEE = aData
        write
    End Property

    Property Get get_PHY_2P5GBASE_T_EEE
        get_PHY_2P5GBASE_T_EEE = read_PHY_2P5GBASE_T_EEE_value
    End Property

    Property Let set_PHY_2P5GBASE_T_EEE(aData)
        write_PHY_2P5GBASE_T_EEE_value = aData
        flag_PHY_2P5GBASE_T_EEE        = &H1
    End Property

    Property Get read_PHY_2P5GBASE_T_EEE
        read
        read_PHY_2P5GBASE_T_EEE = read_PHY_2P5GBASE_T_EEE_value
    End Property

    Property Let write_PHY_2P5GBASE_T_EEE(aData)
        set_PHY_2P5GBASE_T_EEE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_5GBASE_T_EEE_value = rightShift(data_low, 1) and &H1
        PHY_2P5GBASE_T_EEE_mask = &H1
        if data_low > LONG_MAX then
            if PHY_2P5GBASE_T_EEE_mask = mask then
                read_PHY_2P5GBASE_T_EEE_value = data_low
            else
                read_PHY_2P5GBASE_T_EEE_value = (data_low - H8000_0000) and PHY_2P5GBASE_T_EEE_mask
            end If
        else
            read_PHY_2P5GBASE_T_EEE_value = data_low and PHY_2P5GBASE_T_EEE_mask
        end If

    End Sub

    Sub write
        If flag_PHY_5GBASE_T_EEE = &H0 or flag_PHY_2P5GBASE_T_EEE = &H0 Then read
        If flag_PHY_5GBASE_T_EEE = &H0 Then write_PHY_5GBASE_T_EEE_value = get_PHY_5GBASE_T_EEE
        If flag_PHY_2P5GBASE_T_EEE = &H0 Then write_PHY_2P5GBASE_T_EEE_value = get_PHY_2P5GBASE_T_EEE

        regValue = leftShift((write_PHY_5GBASE_T_EEE_value and &H1), 1) + leftShift((write_PHY_2P5GBASE_T_EEE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_5GBASE_T_EEE_value = rightShift(data_low, 1) and &H1
        PHY_2P5GBASE_T_EEE_mask = &H1
        if data_low > LONG_MAX then
            if PHY_2P5GBASE_T_EEE_mask = mask then
                read_PHY_2P5GBASE_T_EEE_value = data_low
            else
                read_PHY_2P5GBASE_T_EEE_value = (data_low - H8000_0000) and PHY_2P5GBASE_T_EEE_mask
            end If
        else
            read_PHY_2P5GBASE_T_EEE_value = data_low and PHY_2P5GBASE_T_EEE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHY_5GBASE_T_EEE_value = &H0
        flag_PHY_5GBASE_T_EEE        = &H0
        write_PHY_2P5GBASE_T_EEE_value = &H0
        flag_PHY_2P5GBASE_T_EEE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_eee_lp_adv_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_PHY_5GBASE_T_EEE                        [1:1]            get_LP_PHY_5GBASE_T_EEE
''                                                             set_LP_PHY_5GBASE_T_EEE
''                                                             read_LP_PHY_5GBASE_T_EEE
''                                                             write_LP_PHY_5GBASE_T_EEE
''---------------------------------------------------------------------------------
'' LP_PHY_2P5GBASE_T_EEE                      [0:0]            get_LP_PHY_2P5GBASE_T_EEE
''                                                             set_LP_PHY_2P5GBASE_T_EEE
''                                                             read_LP_PHY_2P5GBASE_T_EEE
''                                                             write_LP_PHY_2P5GBASE_T_EEE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_eee_lp_adv_2
    Private write_LP_PHY_5GBASE_T_EEE_value
    Private read_LP_PHY_5GBASE_T_EEE_value
    Private flag_LP_PHY_5GBASE_T_EEE
    Private write_LP_PHY_2P5GBASE_T_EEE_value
    Private read_LP_PHY_2P5GBASE_T_EEE_value
    Private flag_LP_PHY_2P5GBASE_T_EEE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP_PHY_5GBASE_T_EEE
        get_LP_PHY_5GBASE_T_EEE = read_LP_PHY_5GBASE_T_EEE_value
    End Property

    Property Let set_LP_PHY_5GBASE_T_EEE(aData)
        write_LP_PHY_5GBASE_T_EEE_value = aData
        flag_LP_PHY_5GBASE_T_EEE        = &H1
    End Property

    Property Get read_LP_PHY_5GBASE_T_EEE
        read
        read_LP_PHY_5GBASE_T_EEE = read_LP_PHY_5GBASE_T_EEE_value
    End Property

    Property Let write_LP_PHY_5GBASE_T_EEE(aData)
        set_LP_PHY_5GBASE_T_EEE = aData
        write
    End Property

    Property Get get_LP_PHY_2P5GBASE_T_EEE
        get_LP_PHY_2P5GBASE_T_EEE = read_LP_PHY_2P5GBASE_T_EEE_value
    End Property

    Property Let set_LP_PHY_2P5GBASE_T_EEE(aData)
        write_LP_PHY_2P5GBASE_T_EEE_value = aData
        flag_LP_PHY_2P5GBASE_T_EEE        = &H1
    End Property

    Property Get read_LP_PHY_2P5GBASE_T_EEE
        read
        read_LP_PHY_2P5GBASE_T_EEE = read_LP_PHY_2P5GBASE_T_EEE_value
    End Property

    Property Let write_LP_PHY_2P5GBASE_T_EEE(aData)
        set_LP_PHY_2P5GBASE_T_EEE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_PHY_5GBASE_T_EEE_value = rightShift(data_low, 1) and &H1
        LP_PHY_2P5GBASE_T_EEE_mask = &H1
        if data_low > LONG_MAX then
            if LP_PHY_2P5GBASE_T_EEE_mask = mask then
                read_LP_PHY_2P5GBASE_T_EEE_value = data_low
            else
                read_LP_PHY_2P5GBASE_T_EEE_value = (data_low - H8000_0000) and LP_PHY_2P5GBASE_T_EEE_mask
            end If
        else
            read_LP_PHY_2P5GBASE_T_EEE_value = data_low and LP_PHY_2P5GBASE_T_EEE_mask
        end If

    End Sub

    Sub write
        If flag_LP_PHY_5GBASE_T_EEE = &H0 or flag_LP_PHY_2P5GBASE_T_EEE = &H0 Then read
        If flag_LP_PHY_5GBASE_T_EEE = &H0 Then write_LP_PHY_5GBASE_T_EEE_value = get_LP_PHY_5GBASE_T_EEE
        If flag_LP_PHY_2P5GBASE_T_EEE = &H0 Then write_LP_PHY_2P5GBASE_T_EEE_value = get_LP_PHY_2P5GBASE_T_EEE

        regValue = leftShift((write_LP_PHY_5GBASE_T_EEE_value and &H1), 1) + leftShift((write_LP_PHY_2P5GBASE_T_EEE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_PHY_5GBASE_T_EEE_value = rightShift(data_low, 1) and &H1
        LP_PHY_2P5GBASE_T_EEE_mask = &H1
        if data_low > LONG_MAX then
            if LP_PHY_2P5GBASE_T_EEE_mask = mask then
                read_LP_PHY_2P5GBASE_T_EEE_value = data_low
            else
                read_LP_PHY_2P5GBASE_T_EEE_value = (data_low - H8000_0000) and LP_PHY_2P5GBASE_T_EEE_mask
            end If
        else
            read_LP_PHY_2P5GBASE_T_EEE_value = data_low and LP_PHY_2P5GBASE_T_EEE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_PHY_5GBASE_T_EEE_value = &H0
        flag_LP_PHY_5GBASE_T_EEE        = &H0
        write_LP_PHY_2P5GBASE_T_EEE_value = &H0
        flag_LP_PHY_2P5GBASE_T_EEE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_multi_gbaset_an_ctrl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LD_2P5GBASE_T_THP_BYPASS_REQUEST           [3:3]            get_LD_2P5GBASE_T_THP_BYPASS_REQUEST
''                                                             set_LD_2P5GBASE_T_THP_BYPASS_REQUEST
''                                                             read_LD_2P5GBASE_T_THP_BYPASS_REQUEST
''                                                             write_LD_2P5GBASE_T_THP_BYPASS_REQUEST
''---------------------------------------------------------------------------------
'' LD_5GBASE_T_THP_BYPASS_REQUEST             [2:2]            get_LD_5GBASE_T_THP_BYPASS_REQUEST
''                                                             set_LD_5GBASE_T_THP_BYPASS_REQUEST
''                                                             read_LD_5GBASE_T_THP_BYPASS_REQUEST
''                                                             write_LD_5GBASE_T_THP_BYPASS_REQUEST
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_multi_gbaset_an_ctrl_2
    Private write_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value
    Private read_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value
    Private flag_LD_2P5GBASE_T_THP_BYPASS_REQUEST
    Private write_LD_5GBASE_T_THP_BYPASS_REQUEST_value
    Private read_LD_5GBASE_T_THP_BYPASS_REQUEST_value
    Private flag_LD_5GBASE_T_THP_BYPASS_REQUEST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LD_2P5GBASE_T_THP_BYPASS_REQUEST
        get_LD_2P5GBASE_T_THP_BYPASS_REQUEST = read_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let set_LD_2P5GBASE_T_THP_BYPASS_REQUEST(aData)
        write_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value = aData
        flag_LD_2P5GBASE_T_THP_BYPASS_REQUEST        = &H1
    End Property

    Property Get read_LD_2P5GBASE_T_THP_BYPASS_REQUEST
        read
        read_LD_2P5GBASE_T_THP_BYPASS_REQUEST = read_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let write_LD_2P5GBASE_T_THP_BYPASS_REQUEST(aData)
        set_LD_2P5GBASE_T_THP_BYPASS_REQUEST = aData
        write
    End Property

    Property Get get_LD_5GBASE_T_THP_BYPASS_REQUEST
        get_LD_5GBASE_T_THP_BYPASS_REQUEST = read_LD_5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let set_LD_5GBASE_T_THP_BYPASS_REQUEST(aData)
        write_LD_5GBASE_T_THP_BYPASS_REQUEST_value = aData
        flag_LD_5GBASE_T_THP_BYPASS_REQUEST        = &H1
    End Property

    Property Get read_LD_5GBASE_T_THP_BYPASS_REQUEST
        read
        read_LD_5GBASE_T_THP_BYPASS_REQUEST = read_LD_5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let write_LD_5GBASE_T_THP_BYPASS_REQUEST(aData)
        set_LD_5GBASE_T_THP_BYPASS_REQUEST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 3) and &H1
        read_LD_5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_LD_2P5GBASE_T_THP_BYPASS_REQUEST = &H0 or flag_LD_5GBASE_T_THP_BYPASS_REQUEST = &H0 Then read
        If flag_LD_2P5GBASE_T_THP_BYPASS_REQUEST = &H0 Then write_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value = get_LD_2P5GBASE_T_THP_BYPASS_REQUEST
        If flag_LD_5GBASE_T_THP_BYPASS_REQUEST = &H0 Then write_LD_5GBASE_T_THP_BYPASS_REQUEST_value = get_LD_5GBASE_T_THP_BYPASS_REQUEST

        regValue = leftShift((write_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value and &H1), 3) + leftShift((write_LD_5GBASE_T_THP_BYPASS_REQUEST_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 3) and &H1
        read_LD_5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LD_2P5GBASE_T_THP_BYPASS_REQUEST_value = &H0
        flag_LD_2P5GBASE_T_THP_BYPASS_REQUEST        = &H0
        write_LD_5GBASE_T_THP_BYPASS_REQUEST_value = &H0
        flag_LD_5GBASE_T_THP_BYPASS_REQUEST        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_multi_gbaset_an_status_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_2P5GBASE_T_THP_BYPASS_REQUEST           [3:3]            get_LP_2P5GBASE_T_THP_BYPASS_REQUEST
''                                                             set_LP_2P5GBASE_T_THP_BYPASS_REQUEST
''                                                             read_LP_2P5GBASE_T_THP_BYPASS_REQUEST
''                                                             write_LP_2P5GBASE_T_THP_BYPASS_REQUEST
''---------------------------------------------------------------------------------
'' LP_5GBASE_T_THP_BYPASS_REQUEST             [2:2]            get_LP_5GBASE_T_THP_BYPASS_REQUEST
''                                                             set_LP_5GBASE_T_THP_BYPASS_REQUEST
''                                                             read_LP_5GBASE_T_THP_BYPASS_REQUEST
''                                                             write_LP_5GBASE_T_THP_BYPASS_REQUEST
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_multi_gbaset_an_status_2
    Private write_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value
    Private read_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value
    Private flag_LP_2P5GBASE_T_THP_BYPASS_REQUEST
    Private write_LP_5GBASE_T_THP_BYPASS_REQUEST_value
    Private read_LP_5GBASE_T_THP_BYPASS_REQUEST_value
    Private flag_LP_5GBASE_T_THP_BYPASS_REQUEST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H82
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP_2P5GBASE_T_THP_BYPASS_REQUEST
        get_LP_2P5GBASE_T_THP_BYPASS_REQUEST = read_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let set_LP_2P5GBASE_T_THP_BYPASS_REQUEST(aData)
        write_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value = aData
        flag_LP_2P5GBASE_T_THP_BYPASS_REQUEST        = &H1
    End Property

    Property Get read_LP_2P5GBASE_T_THP_BYPASS_REQUEST
        read
        read_LP_2P5GBASE_T_THP_BYPASS_REQUEST = read_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let write_LP_2P5GBASE_T_THP_BYPASS_REQUEST(aData)
        set_LP_2P5GBASE_T_THP_BYPASS_REQUEST = aData
        write
    End Property

    Property Get get_LP_5GBASE_T_THP_BYPASS_REQUEST
        get_LP_5GBASE_T_THP_BYPASS_REQUEST = read_LP_5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let set_LP_5GBASE_T_THP_BYPASS_REQUEST(aData)
        write_LP_5GBASE_T_THP_BYPASS_REQUEST_value = aData
        flag_LP_5GBASE_T_THP_BYPASS_REQUEST        = &H1
    End Property

    Property Get read_LP_5GBASE_T_THP_BYPASS_REQUEST
        read
        read_LP_5GBASE_T_THP_BYPASS_REQUEST = read_LP_5GBASE_T_THP_BYPASS_REQUEST_value
    End Property

    Property Let write_LP_5GBASE_T_THP_BYPASS_REQUEST(aData)
        set_LP_5GBASE_T_THP_BYPASS_REQUEST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 3) and &H1
        read_LP_5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_LP_2P5GBASE_T_THP_BYPASS_REQUEST = &H0 or flag_LP_5GBASE_T_THP_BYPASS_REQUEST = &H0 Then read
        If flag_LP_2P5GBASE_T_THP_BYPASS_REQUEST = &H0 Then write_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value = get_LP_2P5GBASE_T_THP_BYPASS_REQUEST
        If flag_LP_5GBASE_T_THP_BYPASS_REQUEST = &H0 Then write_LP_5GBASE_T_THP_BYPASS_REQUEST_value = get_LP_5GBASE_T_THP_BYPASS_REQUEST

        regValue = leftShift((write_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value and &H1), 3) + leftShift((write_LP_5GBASE_T_THP_BYPASS_REQUEST_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 3) and &H1
        read_LP_5GBASE_T_THP_BYPASS_REQUEST_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_2P5GBASE_T_THP_BYPASS_REQUEST_value = &H0
        flag_LP_2P5GBASE_T_THP_BYPASS_REQUEST        = &H0
        write_LP_5GBASE_T_THP_BYPASS_REQUEST_value = &H0
        flag_LP_5GBASE_T_THP_BYPASS_REQUEST        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_autoneg_baset1_an_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_RESET                              [15:15]          get_AUTONEG_RESET
''                                                             set_AUTONEG_RESET
''                                                             read_AUTONEG_RESET
''                                                             write_AUTONEG_RESET
''---------------------------------------------------------------------------------
'' AUTONEG_ENABLE                             [12:12]          get_AUTONEG_ENABLE
''                                                             set_AUTONEG_ENABLE
''                                                             read_AUTONEG_ENABLE
''                                                             write_AUTONEG_ENABLE
''---------------------------------------------------------------------------------
'' RESTART_AUTO_NEGOTIATION                   [9:9]            get_RESTART_AUTO_NEGOTIATION
''                                                             set_RESTART_AUTO_NEGOTIATION
''                                                             read_RESTART_AUTO_NEGOTIATION
''                                                             write_RESTART_AUTO_NEGOTIATION
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_autoneg_baset1_an_control
    Private write_AUTONEG_RESET_value
    Private read_AUTONEG_RESET_value
    Private flag_AUTONEG_RESET
    Private write_AUTONEG_ENABLE_value
    Private read_AUTONEG_ENABLE_value
    Private flag_AUTONEG_ENABLE
    Private write_RESTART_AUTO_NEGOTIATION_value
    Private read_RESTART_AUTO_NEGOTIATION_value
    Private flag_RESTART_AUTO_NEGOTIATION

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AUTONEG_RESET
        get_AUTONEG_RESET = read_AUTONEG_RESET_value
    End Property

    Property Let set_AUTONEG_RESET(aData)
        write_AUTONEG_RESET_value = aData
        flag_AUTONEG_RESET        = &H1
    End Property

    Property Get read_AUTONEG_RESET
        read
        read_AUTONEG_RESET = read_AUTONEG_RESET_value
    End Property

    Property Let write_AUTONEG_RESET(aData)
        set_AUTONEG_RESET = aData
        write
    End Property

    Property Get get_AUTONEG_ENABLE
        get_AUTONEG_ENABLE = read_AUTONEG_ENABLE_value
    End Property

    Property Let set_AUTONEG_ENABLE(aData)
        write_AUTONEG_ENABLE_value = aData
        flag_AUTONEG_ENABLE        = &H1
    End Property

    Property Get read_AUTONEG_ENABLE
        read
        read_AUTONEG_ENABLE = read_AUTONEG_ENABLE_value
    End Property

    Property Let write_AUTONEG_ENABLE(aData)
        set_AUTONEG_ENABLE = aData
        write
    End Property

    Property Get get_RESTART_AUTO_NEGOTIATION
        get_RESTART_AUTO_NEGOTIATION = read_RESTART_AUTO_NEGOTIATION_value
    End Property

    Property Let set_RESTART_AUTO_NEGOTIATION(aData)
        write_RESTART_AUTO_NEGOTIATION_value = aData
        flag_RESTART_AUTO_NEGOTIATION        = &H1
    End Property

    Property Get read_RESTART_AUTO_NEGOTIATION
        read
        read_RESTART_AUTO_NEGOTIATION = read_RESTART_AUTO_NEGOTIATION_value
    End Property

    Property Let write_RESTART_AUTO_NEGOTIATION(aData)
        set_RESTART_AUTO_NEGOTIATION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_RESET_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_ENABLE_value = rightShift(data_low, 12) and &H1
        read_RESTART_AUTO_NEGOTIATION_value = rightShift(data_low, 9) and &H1

    End Sub

    Sub write
        If flag_AUTONEG_RESET = &H0 or flag_AUTONEG_ENABLE = &H0 or flag_RESTART_AUTO_NEGOTIATION = &H0 Then read
        If flag_AUTONEG_RESET = &H0 Then write_AUTONEG_RESET_value = get_AUTONEG_RESET
        If flag_AUTONEG_ENABLE = &H0 Then write_AUTONEG_ENABLE_value = get_AUTONEG_ENABLE
        If flag_RESTART_AUTO_NEGOTIATION = &H0 Then write_RESTART_AUTO_NEGOTIATION_value = get_RESTART_AUTO_NEGOTIATION

        regValue = leftShift((write_AUTONEG_RESET_value and &H1), 15) + leftShift((write_AUTONEG_ENABLE_value and &H1), 12) + leftShift((write_RESTART_AUTO_NEGOTIATION_value and &H1), 9)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_RESET_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_ENABLE_value = rightShift(data_low, 12) and &H1
        read_RESTART_AUTO_NEGOTIATION_value = rightShift(data_low, 9) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_RESET_value = &H0
        flag_AUTONEG_RESET        = &H0
        write_AUTONEG_ENABLE_value = &H0
        flag_AUTONEG_ENABLE        = &H0
        write_RESTART_AUTO_NEGOTIATION_value = &H0
        flag_RESTART_AUTO_NEGOTIATION        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_autoneg_baset1_an_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PAGE_RECEIVED                              [6:6]            get_PAGE_RECEIVED
''                                                             set_PAGE_RECEIVED
''                                                             read_PAGE_RECEIVED
''                                                             write_PAGE_RECEIVED
''---------------------------------------------------------------------------------
'' AUTONEG_COMPLETE                           [5:5]            get_AUTONEG_COMPLETE
''                                                             set_AUTONEG_COMPLETE
''                                                             read_AUTONEG_COMPLETE
''                                                             write_AUTONEG_COMPLETE
''---------------------------------------------------------------------------------
'' REMOTE_FAULT                               [4:4]            get_REMOTE_FAULT
''                                                             set_REMOTE_FAULT
''                                                             read_REMOTE_FAULT
''                                                             write_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' AUTONEG_ABILITY                            [3:3]            get_AUTONEG_ABILITY
''                                                             set_AUTONEG_ABILITY
''                                                             read_AUTONEG_ABILITY
''                                                             write_AUTONEG_ABILITY
''---------------------------------------------------------------------------------
'' LINK_STATUS                                [2:2]            get_LINK_STATUS
''                                                             set_LINK_STATUS
''                                                             read_LINK_STATUS
''                                                             write_LINK_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_autoneg_baset1_an_status
    Private write_PAGE_RECEIVED_value
    Private read_PAGE_RECEIVED_value
    Private flag_PAGE_RECEIVED
    Private write_AUTONEG_COMPLETE_value
    Private read_AUTONEG_COMPLETE_value
    Private flag_AUTONEG_COMPLETE
    Private write_REMOTE_FAULT_value
    Private read_REMOTE_FAULT_value
    Private flag_REMOTE_FAULT
    Private write_AUTONEG_ABILITY_value
    Private read_AUTONEG_ABILITY_value
    Private flag_AUTONEG_ABILITY
    Private write_LINK_STATUS_value
    Private read_LINK_STATUS_value
    Private flag_LINK_STATUS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H402
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PAGE_RECEIVED
        get_PAGE_RECEIVED = read_PAGE_RECEIVED_value
    End Property

    Property Let set_PAGE_RECEIVED(aData)
        write_PAGE_RECEIVED_value = aData
        flag_PAGE_RECEIVED        = &H1
    End Property

    Property Get read_PAGE_RECEIVED
        read
        read_PAGE_RECEIVED = read_PAGE_RECEIVED_value
    End Property

    Property Let write_PAGE_RECEIVED(aData)
        set_PAGE_RECEIVED = aData
        write
    End Property

    Property Get get_AUTONEG_COMPLETE
        get_AUTONEG_COMPLETE = read_AUTONEG_COMPLETE_value
    End Property

    Property Let set_AUTONEG_COMPLETE(aData)
        write_AUTONEG_COMPLETE_value = aData
        flag_AUTONEG_COMPLETE        = &H1
    End Property

    Property Get read_AUTONEG_COMPLETE
        read
        read_AUTONEG_COMPLETE = read_AUTONEG_COMPLETE_value
    End Property

    Property Let write_AUTONEG_COMPLETE(aData)
        set_AUTONEG_COMPLETE = aData
        write
    End Property

    Property Get get_REMOTE_FAULT
        get_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let set_REMOTE_FAULT(aData)
        write_REMOTE_FAULT_value = aData
        flag_REMOTE_FAULT        = &H1
    End Property

    Property Get read_REMOTE_FAULT
        read
        read_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let write_REMOTE_FAULT(aData)
        set_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_AUTONEG_ABILITY
        get_AUTONEG_ABILITY = read_AUTONEG_ABILITY_value
    End Property

    Property Let set_AUTONEG_ABILITY(aData)
        write_AUTONEG_ABILITY_value = aData
        flag_AUTONEG_ABILITY        = &H1
    End Property

    Property Get read_AUTONEG_ABILITY
        read
        read_AUTONEG_ABILITY = read_AUTONEG_ABILITY_value
    End Property

    Property Let write_AUTONEG_ABILITY(aData)
        set_AUTONEG_ABILITY = aData
        write
    End Property

    Property Get get_LINK_STATUS
        get_LINK_STATUS = read_LINK_STATUS_value
    End Property

    Property Let set_LINK_STATUS(aData)
        write_LINK_STATUS_value = aData
        flag_LINK_STATUS        = &H1
    End Property

    Property Get read_LINK_STATUS
        read
        read_LINK_STATUS = read_LINK_STATUS_value
    End Property

    Property Let write_LINK_STATUS(aData)
        set_LINK_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAGE_RECEIVED_value = rightShift(data_low, 6) and &H1
        read_AUTONEG_COMPLETE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 4) and &H1
        read_AUTONEG_ABILITY_value = rightShift(data_low, 3) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_PAGE_RECEIVED = &H0 or flag_AUTONEG_COMPLETE = &H0 or flag_REMOTE_FAULT = &H0 or flag_AUTONEG_ABILITY = &H0 or flag_LINK_STATUS = &H0 Then read
        If flag_PAGE_RECEIVED = &H0 Then write_PAGE_RECEIVED_value = get_PAGE_RECEIVED
        If flag_AUTONEG_COMPLETE = &H0 Then write_AUTONEG_COMPLETE_value = get_AUTONEG_COMPLETE
        If flag_REMOTE_FAULT = &H0 Then write_REMOTE_FAULT_value = get_REMOTE_FAULT
        If flag_AUTONEG_ABILITY = &H0 Then write_AUTONEG_ABILITY_value = get_AUTONEG_ABILITY
        If flag_LINK_STATUS = &H0 Then write_LINK_STATUS_value = get_LINK_STATUS

        regValue = leftShift((write_PAGE_RECEIVED_value and &H1), 6) + leftShift((write_AUTONEG_COMPLETE_value and &H1), 5) + leftShift((write_REMOTE_FAULT_value and &H1), 4) + leftShift((write_AUTONEG_ABILITY_value and &H1), 3) + leftShift((write_LINK_STATUS_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAGE_RECEIVED_value = rightShift(data_low, 6) and &H1
        read_AUTONEG_COMPLETE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 4) and &H1
        read_AUTONEG_ABILITY_value = rightShift(data_low, 3) and &H1
        read_LINK_STATUS_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PAGE_RECEIVED_value = &H0
        flag_PAGE_RECEIVED        = &H0
        write_AUTONEG_COMPLETE_value = &H0
        flag_AUTONEG_COMPLETE        = &H0
        write_REMOTE_FAULT_value = &H0
        flag_REMOTE_FAULT        = &H0
        write_AUTONEG_ABILITY_value = &H0
        flag_AUTONEG_ABILITY        = &H0
        write_LINK_STATUS_value = &H0
        flag_LINK_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_advertisement_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NEXT_PAGE                                  [15:15]          get_NEXT_PAGE
''                                                             set_NEXT_PAGE
''                                                             read_NEXT_PAGE
''                                                             write_NEXT_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE                                [14:14]          get_ACKNOWLEDGE
''                                                             set_ACKNOWLEDGE
''                                                             read_ACKNOWLEDGE
''                                                             write_ACKNOWLEDGE
''---------------------------------------------------------------------------------
'' REMOTE_FAULT                               [13:13]          get_REMOTE_FAULT
''                                                             set_REMOTE_FAULT
''                                                             read_REMOTE_FAULT
''                                                             write_REMOTE_FAULT
''---------------------------------------------------------------------------------
'' FORCE_MASTER_SLAVE                         [12:12]          get_FORCE_MASTER_SLAVE
''                                                             set_FORCE_MASTER_SLAVE
''                                                             read_FORCE_MASTER_SLAVE
''                                                             write_FORCE_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' PAUSE_CAPABILITIES                         [11:10]          get_PAUSE_CAPABILITIES
''                                                             set_PAUSE_CAPABILITIES
''                                                             read_PAUSE_CAPABILITIES
''                                                             write_PAUSE_CAPABILITIES
''---------------------------------------------------------------------------------
'' ECHOED_NONCE_FIELD                         [9:5]            get_ECHOED_NONCE_FIELD
''                                                             set_ECHOED_NONCE_FIELD
''                                                             read_ECHOED_NONCE_FIELD
''                                                             write_ECHOED_NONCE_FIELD
''---------------------------------------------------------------------------------
'' SELECTOR_FIELD                             [4:0]            get_SELECTOR_FIELD
''                                                             set_SELECTOR_FIELD
''                                                             read_SELECTOR_FIELD
''                                                             write_SELECTOR_FIELD
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_advertisement_reg0
    Private write_NEXT_PAGE_value
    Private read_NEXT_PAGE_value
    Private flag_NEXT_PAGE
    Private write_ACKNOWLEDGE_value
    Private read_ACKNOWLEDGE_value
    Private flag_ACKNOWLEDGE
    Private write_REMOTE_FAULT_value
    Private read_REMOTE_FAULT_value
    Private flag_REMOTE_FAULT
    Private write_FORCE_MASTER_SLAVE_value
    Private read_FORCE_MASTER_SLAVE_value
    Private flag_FORCE_MASTER_SLAVE
    Private write_PAUSE_CAPABILITIES_value
    Private read_PAUSE_CAPABILITIES_value
    Private flag_PAUSE_CAPABILITIES
    Private write_ECHOED_NONCE_FIELD_value
    Private read_ECHOED_NONCE_FIELD_value
    Private flag_ECHOED_NONCE_FIELD
    Private write_SELECTOR_FIELD_value
    Private read_SELECTOR_FIELD_value
    Private flag_SELECTOR_FIELD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H404
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NEXT_PAGE
        get_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let set_NEXT_PAGE(aData)
        write_NEXT_PAGE_value = aData
        flag_NEXT_PAGE        = &H1
    End Property

    Property Get read_NEXT_PAGE
        read
        read_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let write_NEXT_PAGE(aData)
        set_NEXT_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE
        get_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let set_ACKNOWLEDGE(aData)
        write_ACKNOWLEDGE_value = aData
        flag_ACKNOWLEDGE        = &H1
    End Property

    Property Get read_ACKNOWLEDGE
        read
        read_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let write_ACKNOWLEDGE(aData)
        set_ACKNOWLEDGE = aData
        write
    End Property

    Property Get get_REMOTE_FAULT
        get_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let set_REMOTE_FAULT(aData)
        write_REMOTE_FAULT_value = aData
        flag_REMOTE_FAULT        = &H1
    End Property

    Property Get read_REMOTE_FAULT
        read
        read_REMOTE_FAULT = read_REMOTE_FAULT_value
    End Property

    Property Let write_REMOTE_FAULT(aData)
        set_REMOTE_FAULT = aData
        write
    End Property

    Property Get get_FORCE_MASTER_SLAVE
        get_FORCE_MASTER_SLAVE = read_FORCE_MASTER_SLAVE_value
    End Property

    Property Let set_FORCE_MASTER_SLAVE(aData)
        write_FORCE_MASTER_SLAVE_value = aData
        flag_FORCE_MASTER_SLAVE        = &H1
    End Property

    Property Get read_FORCE_MASTER_SLAVE
        read
        read_FORCE_MASTER_SLAVE = read_FORCE_MASTER_SLAVE_value
    End Property

    Property Let write_FORCE_MASTER_SLAVE(aData)
        set_FORCE_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_PAUSE_CAPABILITIES
        get_PAUSE_CAPABILITIES = read_PAUSE_CAPABILITIES_value
    End Property

    Property Let set_PAUSE_CAPABILITIES(aData)
        write_PAUSE_CAPABILITIES_value = aData
        flag_PAUSE_CAPABILITIES        = &H1
    End Property

    Property Get read_PAUSE_CAPABILITIES
        read
        read_PAUSE_CAPABILITIES = read_PAUSE_CAPABILITIES_value
    End Property

    Property Let write_PAUSE_CAPABILITIES(aData)
        set_PAUSE_CAPABILITIES = aData
        write
    End Property

    Property Get get_ECHOED_NONCE_FIELD
        get_ECHOED_NONCE_FIELD = read_ECHOED_NONCE_FIELD_value
    End Property

    Property Let set_ECHOED_NONCE_FIELD(aData)
        write_ECHOED_NONCE_FIELD_value = aData
        flag_ECHOED_NONCE_FIELD        = &H1
    End Property

    Property Get read_ECHOED_NONCE_FIELD
        read
        read_ECHOED_NONCE_FIELD = read_ECHOED_NONCE_FIELD_value
    End Property

    Property Let write_ECHOED_NONCE_FIELD(aData)
        set_ECHOED_NONCE_FIELD = aData
        write
    End Property

    Property Get get_SELECTOR_FIELD
        get_SELECTOR_FIELD = read_SELECTOR_FIELD_value
    End Property

    Property Let set_SELECTOR_FIELD(aData)
        write_SELECTOR_FIELD_value = aData
        flag_SELECTOR_FIELD        = &H1
    End Property

    Property Get read_SELECTOR_FIELD
        read
        read_SELECTOR_FIELD = read_SELECTOR_FIELD_value
    End Property

    Property Let write_SELECTOR_FIELD(aData)
        set_SELECTOR_FIELD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_FORCE_MASTER_SLAVE_value = rightShift(data_low, 12) and &H1
        read_PAUSE_CAPABILITIES_value = rightShift(data_low, 10) and &H3
        read_ECHOED_NONCE_FIELD_value = rightShift(data_low, 5) and &H1f
        SELECTOR_FIELD_mask = &H1f
        if data_low > LONG_MAX then
            if SELECTOR_FIELD_mask = mask then
                read_SELECTOR_FIELD_value = data_low
            else
                read_SELECTOR_FIELD_value = (data_low - H8000_0000) and SELECTOR_FIELD_mask
            end If
        else
            read_SELECTOR_FIELD_value = data_low and SELECTOR_FIELD_mask
        end If

    End Sub

    Sub write
        If flag_NEXT_PAGE = &H0 or flag_ACKNOWLEDGE = &H0 or flag_REMOTE_FAULT = &H0 or flag_FORCE_MASTER_SLAVE = &H0 or flag_PAUSE_CAPABILITIES = &H0 or flag_ECHOED_NONCE_FIELD = &H0 or flag_SELECTOR_FIELD = &H0 Then read
        If flag_NEXT_PAGE = &H0 Then write_NEXT_PAGE_value = get_NEXT_PAGE
        If flag_ACKNOWLEDGE = &H0 Then write_ACKNOWLEDGE_value = get_ACKNOWLEDGE
        If flag_REMOTE_FAULT = &H0 Then write_REMOTE_FAULT_value = get_REMOTE_FAULT
        If flag_FORCE_MASTER_SLAVE = &H0 Then write_FORCE_MASTER_SLAVE_value = get_FORCE_MASTER_SLAVE
        If flag_PAUSE_CAPABILITIES = &H0 Then write_PAUSE_CAPABILITIES_value = get_PAUSE_CAPABILITIES
        If flag_ECHOED_NONCE_FIELD = &H0 Then write_ECHOED_NONCE_FIELD_value = get_ECHOED_NONCE_FIELD
        If flag_SELECTOR_FIELD = &H0 Then write_SELECTOR_FIELD_value = get_SELECTOR_FIELD

        regValue = leftShift((write_NEXT_PAGE_value and &H1), 15) + leftShift((write_ACKNOWLEDGE_value and &H1), 14) + leftShift((write_REMOTE_FAULT_value and &H1), 13) + leftShift((write_FORCE_MASTER_SLAVE_value and &H1), 12) + leftShift((write_PAUSE_CAPABILITIES_value and &H3), 10) + leftShift((write_ECHOED_NONCE_FIELD_value and &H1f), 5) + leftShift((write_SELECTOR_FIELD_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_REMOTE_FAULT_value = rightShift(data_low, 13) and &H1
        read_FORCE_MASTER_SLAVE_value = rightShift(data_low, 12) and &H1
        read_PAUSE_CAPABILITIES_value = rightShift(data_low, 10) and &H3
        read_ECHOED_NONCE_FIELD_value = rightShift(data_low, 5) and &H1f
        SELECTOR_FIELD_mask = &H1f
        if data_low > LONG_MAX then
            if SELECTOR_FIELD_mask = mask then
                read_SELECTOR_FIELD_value = data_low
            else
                read_SELECTOR_FIELD_value = (data_low - H8000_0000) and SELECTOR_FIELD_mask
            end If
        else
            read_SELECTOR_FIELD_value = data_low and SELECTOR_FIELD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NEXT_PAGE_value = &H0
        flag_NEXT_PAGE        = &H0
        write_ACKNOWLEDGE_value = &H0
        flag_ACKNOWLEDGE        = &H0
        write_REMOTE_FAULT_value = &H0
        flag_REMOTE_FAULT        = &H0
        write_FORCE_MASTER_SLAVE_value = &H0
        flag_FORCE_MASTER_SLAVE        = &H0
        write_PAUSE_CAPABILITIES_value = &H0
        flag_PAUSE_CAPABILITIES        = &H0
        write_ECHOED_NONCE_FIELD_value = &H0
        flag_ECHOED_NONCE_FIELD        = &H0
        write_SELECTOR_FIELD_value = &H0
        flag_SELECTOR_FIELD        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_advertisement_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D31_D24                                    [15:8]           get_D31_D24
''                                                             set_D31_D24
''                                                             read_D31_D24
''                                                             write_D31_D24
''---------------------------------------------------------------------------------
'' ADVERISE_1000BASE_T1                       [7:7]            get_ADVERISE_1000BASE_T1
''                                                             set_ADVERISE_1000BASE_T1
''                                                             read_ADVERISE_1000BASE_T1
''                                                             write_ADVERISE_1000BASE_T1
''---------------------------------------------------------------------------------
'' D22                                        [6:6]            get_D22
''                                                             set_D22
''                                                             read_D22
''                                                             write_D22
''---------------------------------------------------------------------------------
'' ADVERISE_100BASE_T1                        [5:5]            get_ADVERISE_100BASE_T1
''                                                             set_ADVERISE_100BASE_T1
''                                                             read_ADVERISE_100BASE_T1
''                                                             write_ADVERISE_100BASE_T1
''---------------------------------------------------------------------------------
'' MASTER_SLAVE                               [4:4]            get_MASTER_SLAVE
''                                                             set_MASTER_SLAVE
''                                                             read_MASTER_SLAVE
''                                                             write_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' TRANSMITTED_NONCE_FIELD                    [3:0]            get_TRANSMITTED_NONCE_FIELD
''                                                             set_TRANSMITTED_NONCE_FIELD
''                                                             read_TRANSMITTED_NONCE_FIELD
''                                                             write_TRANSMITTED_NONCE_FIELD
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_advertisement_reg1
    Private write_D31_D24_value
    Private read_D31_D24_value
    Private flag_D31_D24
    Private write_ADVERISE_1000BASE_T1_value
    Private read_ADVERISE_1000BASE_T1_value
    Private flag_ADVERISE_1000BASE_T1
    Private write_D22_value
    Private read_D22_value
    Private flag_D22
    Private write_ADVERISE_100BASE_T1_value
    Private read_ADVERISE_100BASE_T1_value
    Private flag_ADVERISE_100BASE_T1
    Private write_MASTER_SLAVE_value
    Private read_MASTER_SLAVE_value
    Private flag_MASTER_SLAVE
    Private write_TRANSMITTED_NONCE_FIELD_value
    Private read_TRANSMITTED_NONCE_FIELD_value
    Private flag_TRANSMITTED_NONCE_FIELD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H406
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D31_D24
        get_D31_D24 = read_D31_D24_value
    End Property

    Property Let set_D31_D24(aData)
        write_D31_D24_value = aData
        flag_D31_D24        = &H1
    End Property

    Property Get read_D31_D24
        read
        read_D31_D24 = read_D31_D24_value
    End Property

    Property Let write_D31_D24(aData)
        set_D31_D24 = aData
        write
    End Property

    Property Get get_ADVERISE_1000BASE_T1
        get_ADVERISE_1000BASE_T1 = read_ADVERISE_1000BASE_T1_value
    End Property

    Property Let set_ADVERISE_1000BASE_T1(aData)
        write_ADVERISE_1000BASE_T1_value = aData
        flag_ADVERISE_1000BASE_T1        = &H1
    End Property

    Property Get read_ADVERISE_1000BASE_T1
        read
        read_ADVERISE_1000BASE_T1 = read_ADVERISE_1000BASE_T1_value
    End Property

    Property Let write_ADVERISE_1000BASE_T1(aData)
        set_ADVERISE_1000BASE_T1 = aData
        write
    End Property

    Property Get get_D22
        get_D22 = read_D22_value
    End Property

    Property Let set_D22(aData)
        write_D22_value = aData
        flag_D22        = &H1
    End Property

    Property Get read_D22
        read
        read_D22 = read_D22_value
    End Property

    Property Let write_D22(aData)
        set_D22 = aData
        write
    End Property

    Property Get get_ADVERISE_100BASE_T1
        get_ADVERISE_100BASE_T1 = read_ADVERISE_100BASE_T1_value
    End Property

    Property Let set_ADVERISE_100BASE_T1(aData)
        write_ADVERISE_100BASE_T1_value = aData
        flag_ADVERISE_100BASE_T1        = &H1
    End Property

    Property Get read_ADVERISE_100BASE_T1
        read
        read_ADVERISE_100BASE_T1 = read_ADVERISE_100BASE_T1_value
    End Property

    Property Let write_ADVERISE_100BASE_T1(aData)
        set_ADVERISE_100BASE_T1 = aData
        write
    End Property

    Property Get get_MASTER_SLAVE
        get_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let set_MASTER_SLAVE(aData)
        write_MASTER_SLAVE_value = aData
        flag_MASTER_SLAVE        = &H1
    End Property

    Property Get read_MASTER_SLAVE
        read
        read_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let write_MASTER_SLAVE(aData)
        set_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_TRANSMITTED_NONCE_FIELD
        get_TRANSMITTED_NONCE_FIELD = read_TRANSMITTED_NONCE_FIELD_value
    End Property

    Property Let set_TRANSMITTED_NONCE_FIELD(aData)
        write_TRANSMITTED_NONCE_FIELD_value = aData
        flag_TRANSMITTED_NONCE_FIELD        = &H1
    End Property

    Property Get read_TRANSMITTED_NONCE_FIELD
        read
        read_TRANSMITTED_NONCE_FIELD = read_TRANSMITTED_NONCE_FIELD_value
    End Property

    Property Let write_TRANSMITTED_NONCE_FIELD(aData)
        set_TRANSMITTED_NONCE_FIELD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_D31_D24_value = rightShift(data_low, 8) and &Hff
        read_ADVERISE_1000BASE_T1_value = rightShift(data_low, 7) and &H1
        read_D22_value = rightShift(data_low, 6) and &H1
        read_ADVERISE_100BASE_T1_value = rightShift(data_low, 5) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 4) and &H1
        TRANSMITTED_NONCE_FIELD_mask = &Hf
        if data_low > LONG_MAX then
            if TRANSMITTED_NONCE_FIELD_mask = mask then
                read_TRANSMITTED_NONCE_FIELD_value = data_low
            else
                read_TRANSMITTED_NONCE_FIELD_value = (data_low - H8000_0000) and TRANSMITTED_NONCE_FIELD_mask
            end If
        else
            read_TRANSMITTED_NONCE_FIELD_value = data_low and TRANSMITTED_NONCE_FIELD_mask
        end If

    End Sub

    Sub write
        If flag_D31_D24 = &H0 or flag_ADVERISE_1000BASE_T1 = &H0 or flag_D22 = &H0 or flag_ADVERISE_100BASE_T1 = &H0 or flag_MASTER_SLAVE = &H0 or flag_TRANSMITTED_NONCE_FIELD = &H0 Then read
        If flag_D31_D24 = &H0 Then write_D31_D24_value = get_D31_D24
        If flag_ADVERISE_1000BASE_T1 = &H0 Then write_ADVERISE_1000BASE_T1_value = get_ADVERISE_1000BASE_T1
        If flag_D22 = &H0 Then write_D22_value = get_D22
        If flag_ADVERISE_100BASE_T1 = &H0 Then write_ADVERISE_100BASE_T1_value = get_ADVERISE_100BASE_T1
        If flag_MASTER_SLAVE = &H0 Then write_MASTER_SLAVE_value = get_MASTER_SLAVE
        If flag_TRANSMITTED_NONCE_FIELD = &H0 Then write_TRANSMITTED_NONCE_FIELD_value = get_TRANSMITTED_NONCE_FIELD

        regValue = leftShift((write_D31_D24_value and &Hff), 8) + leftShift((write_ADVERISE_1000BASE_T1_value and &H1), 7) + leftShift((write_D22_value and &H1), 6) + leftShift((write_ADVERISE_100BASE_T1_value and &H1), 5) + leftShift((write_MASTER_SLAVE_value and &H1), 4) + leftShift((write_TRANSMITTED_NONCE_FIELD_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_D31_D24_value = rightShift(data_low, 8) and &Hff
        read_ADVERISE_1000BASE_T1_value = rightShift(data_low, 7) and &H1
        read_D22_value = rightShift(data_low, 6) and &H1
        read_ADVERISE_100BASE_T1_value = rightShift(data_low, 5) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 4) and &H1
        TRANSMITTED_NONCE_FIELD_mask = &Hf
        if data_low > LONG_MAX then
            if TRANSMITTED_NONCE_FIELD_mask = mask then
                read_TRANSMITTED_NONCE_FIELD_value = data_low
            else
                read_TRANSMITTED_NONCE_FIELD_value = (data_low - H8000_0000) and TRANSMITTED_NONCE_FIELD_mask
            end If
        else
            read_TRANSMITTED_NONCE_FIELD_value = data_low and TRANSMITTED_NONCE_FIELD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D31_D24_value = &H0
        flag_D31_D24        = &H0
        write_ADVERISE_1000BASE_T1_value = &H0
        flag_ADVERISE_1000BASE_T1        = &H0
        write_D22_value = &H0
        flag_D22        = &H0
        write_ADVERISE_100BASE_T1_value = &H0
        flag_ADVERISE_100BASE_T1        = &H0
        write_MASTER_SLAVE_value = &H0
        flag_MASTER_SLAVE        = &H0
        write_TRANSMITTED_NONCE_FIELD_value = &H0
        flag_TRANSMITTED_NONCE_FIELD        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_advertisement_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D47_D32                                    [15:0]           get_D47_D32
''                                                             set_D47_D32
''                                                             read_D47_D32
''                                                             write_D47_D32
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_advertisement_reg2
    Private write_D47_D32_value
    Private read_D47_D32_value
    Private flag_D47_D32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D47_D32
        get_D47_D32 = read_D47_D32_value
    End Property

    Property Let set_D47_D32(aData)
        write_D47_D32_value = aData
        flag_D47_D32        = &H1
    End Property

    Property Get read_D47_D32
        read
        read_D47_D32 = read_D47_D32_value
    End Property

    Property Let write_D47_D32(aData)
        set_D47_D32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

    End Sub

    Sub write
        If flag_D47_D32 = &H0 Then read
        If flag_D47_D32 = &H0 Then write_D47_D32_value = get_D47_D32

        regValue = leftShift((write_D47_D32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D47_D32_value = &H0
        flag_D47_D32        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_lp_base_page_ability_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D15_D0                                     [15:0]           get_D15_D0
''                                                             set_D15_D0
''                                                             read_D15_D0
''                                                             write_D15_D0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_lp_base_page_ability_reg0
    Private write_D15_D0_value
    Private read_D15_D0_value
    Private flag_D15_D0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D15_D0
        get_D15_D0 = read_D15_D0_value
    End Property

    Property Let set_D15_D0(aData)
        write_D15_D0_value = aData
        flag_D15_D0        = &H1
    End Property

    Property Get read_D15_D0
        read
        read_D15_D0 = read_D15_D0_value
    End Property

    Property Let write_D15_D0(aData)
        set_D15_D0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D15_D0_mask = &Hffff
        if data_low > LONG_MAX then
            if D15_D0_mask = mask then
                read_D15_D0_value = data_low
            else
                read_D15_D0_value = (data_low - H8000_0000) and D15_D0_mask
            end If
        else
            read_D15_D0_value = data_low and D15_D0_mask
        end If

    End Sub

    Sub write
        If flag_D15_D0 = &H0 Then read
        If flag_D15_D0 = &H0 Then write_D15_D0_value = get_D15_D0

        regValue = leftShift((write_D15_D0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D15_D0_mask = &Hffff
        if data_low > LONG_MAX then
            if D15_D0_mask = mask then
                read_D15_D0_value = data_low
            else
                read_D15_D0_value = (data_low - H8000_0000) and D15_D0_mask
            end If
        else
            read_D15_D0_value = data_low and D15_D0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D15_D0_value = &H0
        flag_D15_D0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_lp_base_page_ability_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D31_D16                                    [15:0]           get_D31_D16
''                                                             set_D31_D16
''                                                             read_D31_D16
''                                                             write_D31_D16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_lp_base_page_ability_reg1
    Private write_D31_D16_value
    Private read_D31_D16_value
    Private flag_D31_D16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D31_D16
        get_D31_D16 = read_D31_D16_value
    End Property

    Property Let set_D31_D16(aData)
        write_D31_D16_value = aData
        flag_D31_D16        = &H1
    End Property

    Property Get read_D31_D16
        read
        read_D31_D16 = read_D31_D16_value
    End Property

    Property Let write_D31_D16(aData)
        set_D31_D16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D31_D16_mask = &Hffff
        if data_low > LONG_MAX then
            if D31_D16_mask = mask then
                read_D31_D16_value = data_low
            else
                read_D31_D16_value = (data_low - H8000_0000) and D31_D16_mask
            end If
        else
            read_D31_D16_value = data_low and D31_D16_mask
        end If

    End Sub

    Sub write
        If flag_D31_D16 = &H0 Then read
        If flag_D31_D16 = &H0 Then write_D31_D16_value = get_D31_D16

        regValue = leftShift((write_D31_D16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D31_D16_mask = &Hffff
        if data_low > LONG_MAX then
            if D31_D16_mask = mask then
                read_D31_D16_value = data_low
            else
                read_D31_D16_value = (data_low - H8000_0000) and D31_D16_mask
            end If
        else
            read_D31_D16_value = data_low and D31_D16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D31_D16_value = &H0
        flag_D31_D16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_lp_base_page_ability_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' D47_D32                                    [15:0]           get_D47_D32
''                                                             set_D47_D32
''                                                             read_D47_D32
''                                                             write_D47_D32
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_lp_base_page_ability_reg2
    Private write_D47_D32_value
    Private read_D47_D32_value
    Private flag_D47_D32

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_D47_D32
        get_D47_D32 = read_D47_D32_value
    End Property

    Property Let set_D47_D32(aData)
        write_D47_D32_value = aData
        flag_D47_D32        = &H1
    End Property

    Property Get read_D47_D32
        read
        read_D47_D32 = read_D47_D32_value
    End Property

    Property Let write_D47_D32(aData)
        set_D47_D32 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

    End Sub

    Sub write
        If flag_D47_D32 = &H0 Then read
        If flag_D47_D32 = &H0 Then write_D47_D32_value = get_D47_D32

        regValue = leftShift((write_D47_D32_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        D47_D32_mask = &Hffff
        if data_low > LONG_MAX then
            if D47_D32_mask = mask then
                read_D47_D32_value = data_low
            else
                read_D47_D32_value = (data_low - H8000_0000) and D47_D32_mask
            end If
        else
            read_D47_D32_value = data_low and D47_D32_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_D47_D32_value = &H0
        flag_D47_D32        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_next_page_transmit_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NEXT_PAGE                                  [15:15]          get_NEXT_PAGE
''                                                             set_NEXT_PAGE
''                                                             read_NEXT_PAGE
''                                                             write_NEXT_PAGE
''---------------------------------------------------------------------------------
'' MESSAGE_PAGE                               [13:13]          get_MESSAGE_PAGE
''                                                             set_MESSAGE_PAGE
''                                                             read_MESSAGE_PAGE
''                                                             write_MESSAGE_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE2                               [12:12]          get_ACKNOWLEDGE2
''                                                             set_ACKNOWLEDGE2
''                                                             read_ACKNOWLEDGE2
''                                                             write_ACKNOWLEDGE2
''---------------------------------------------------------------------------------
'' TOGGLE                                     [11:11]          get_TOGGLE
''                                                             set_TOGGLE
''                                                             read_TOGGLE
''                                                             write_TOGGLE
''---------------------------------------------------------------------------------
'' MESSAGE_UNFORMATTED_CODE_FIELD             [10:0]           get_MESSAGE_UNFORMATTED_CODE_FIELD
''                                                             set_MESSAGE_UNFORMATTED_CODE_FIELD
''                                                             read_MESSAGE_UNFORMATTED_CODE_FIELD
''                                                             write_MESSAGE_UNFORMATTED_CODE_FIELD
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_next_page_transmit_reg0
    Private write_NEXT_PAGE_value
    Private read_NEXT_PAGE_value
    Private flag_NEXT_PAGE
    Private write_MESSAGE_PAGE_value
    Private read_MESSAGE_PAGE_value
    Private flag_MESSAGE_PAGE
    Private write_ACKNOWLEDGE2_value
    Private read_ACKNOWLEDGE2_value
    Private flag_ACKNOWLEDGE2
    Private write_TOGGLE_value
    Private read_TOGGLE_value
    Private flag_TOGGLE
    Private write_MESSAGE_UNFORMATTED_CODE_FIELD_value
    Private read_MESSAGE_UNFORMATTED_CODE_FIELD_value
    Private flag_MESSAGE_UNFORMATTED_CODE_FIELD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H410
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NEXT_PAGE
        get_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let set_NEXT_PAGE(aData)
        write_NEXT_PAGE_value = aData
        flag_NEXT_PAGE        = &H1
    End Property

    Property Get read_NEXT_PAGE
        read
        read_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let write_NEXT_PAGE(aData)
        set_NEXT_PAGE = aData
        write
    End Property

    Property Get get_MESSAGE_PAGE
        get_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let set_MESSAGE_PAGE(aData)
        write_MESSAGE_PAGE_value = aData
        flag_MESSAGE_PAGE        = &H1
    End Property

    Property Get read_MESSAGE_PAGE
        read
        read_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let write_MESSAGE_PAGE(aData)
        set_MESSAGE_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE2
        get_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let set_ACKNOWLEDGE2(aData)
        write_ACKNOWLEDGE2_value = aData
        flag_ACKNOWLEDGE2        = &H1
    End Property

    Property Get read_ACKNOWLEDGE2
        read
        read_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let write_ACKNOWLEDGE2(aData)
        set_ACKNOWLEDGE2 = aData
        write
    End Property

    Property Get get_TOGGLE
        get_TOGGLE = read_TOGGLE_value
    End Property

    Property Let set_TOGGLE(aData)
        write_TOGGLE_value = aData
        flag_TOGGLE        = &H1
    End Property

    Property Get read_TOGGLE
        read
        read_TOGGLE = read_TOGGLE_value
    End Property

    Property Let write_TOGGLE(aData)
        set_TOGGLE = aData
        write
    End Property

    Property Get get_MESSAGE_UNFORMATTED_CODE_FIELD
        get_MESSAGE_UNFORMATTED_CODE_FIELD = read_MESSAGE_UNFORMATTED_CODE_FIELD_value
    End Property

    Property Let set_MESSAGE_UNFORMATTED_CODE_FIELD(aData)
        write_MESSAGE_UNFORMATTED_CODE_FIELD_value = aData
        flag_MESSAGE_UNFORMATTED_CODE_FIELD        = &H1
    End Property

    Property Get read_MESSAGE_UNFORMATTED_CODE_FIELD
        read
        read_MESSAGE_UNFORMATTED_CODE_FIELD = read_MESSAGE_UNFORMATTED_CODE_FIELD_value
    End Property

    Property Let write_MESSAGE_UNFORMATTED_CODE_FIELD(aData)
        set_MESSAGE_UNFORMATTED_CODE_FIELD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MESSAGE_UNFORMATTED_CODE_FIELD_mask = &H7ff
        if data_low > LONG_MAX then
            if MESSAGE_UNFORMATTED_CODE_FIELD_mask = mask then
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low
            else
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = (data_low - H8000_0000) and MESSAGE_UNFORMATTED_CODE_FIELD_mask
            end If
        else
            read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low and MESSAGE_UNFORMATTED_CODE_FIELD_mask
        end If

    End Sub

    Sub write
        If flag_NEXT_PAGE = &H0 or flag_MESSAGE_PAGE = &H0 or flag_ACKNOWLEDGE2 = &H0 or flag_TOGGLE = &H0 or flag_MESSAGE_UNFORMATTED_CODE_FIELD = &H0 Then read
        If flag_NEXT_PAGE = &H0 Then write_NEXT_PAGE_value = get_NEXT_PAGE
        If flag_MESSAGE_PAGE = &H0 Then write_MESSAGE_PAGE_value = get_MESSAGE_PAGE
        If flag_ACKNOWLEDGE2 = &H0 Then write_ACKNOWLEDGE2_value = get_ACKNOWLEDGE2
        If flag_TOGGLE = &H0 Then write_TOGGLE_value = get_TOGGLE
        If flag_MESSAGE_UNFORMATTED_CODE_FIELD = &H0 Then write_MESSAGE_UNFORMATTED_CODE_FIELD_value = get_MESSAGE_UNFORMATTED_CODE_FIELD

        regValue = leftShift((write_NEXT_PAGE_value and &H1), 15) + leftShift((write_MESSAGE_PAGE_value and &H1), 13) + leftShift((write_ACKNOWLEDGE2_value and &H1), 12) + leftShift((write_TOGGLE_value and &H1), 11) + leftShift((write_MESSAGE_UNFORMATTED_CODE_FIELD_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MESSAGE_UNFORMATTED_CODE_FIELD_mask = &H7ff
        if data_low > LONG_MAX then
            if MESSAGE_UNFORMATTED_CODE_FIELD_mask = mask then
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low
            else
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = (data_low - H8000_0000) and MESSAGE_UNFORMATTED_CODE_FIELD_mask
            end If
        else
            read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low and MESSAGE_UNFORMATTED_CODE_FIELD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NEXT_PAGE_value = &H0
        flag_NEXT_PAGE        = &H0
        write_MESSAGE_PAGE_value = &H0
        flag_MESSAGE_PAGE        = &H0
        write_ACKNOWLEDGE2_value = &H0
        flag_ACKNOWLEDGE2        = &H0
        write_TOGGLE_value = &H0
        flag_TOGGLE        = &H0
        write_MESSAGE_UNFORMATTED_CODE_FIELD_value = &H0
        flag_MESSAGE_UNFORMATTED_CODE_FIELD        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_next_page_transmit_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_1                   [15:0]           get_UNFORMATTED_CODE_FIELD_1
''                                                             set_UNFORMATTED_CODE_FIELD_1
''                                                             read_UNFORMATTED_CODE_FIELD_1
''                                                             write_UNFORMATTED_CODE_FIELD_1
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_next_page_transmit_reg1
    Private write_UNFORMATTED_CODE_FIELD_1_value
    Private read_UNFORMATTED_CODE_FIELD_1_value
    Private flag_UNFORMATTED_CODE_FIELD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H412
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_1
        get_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_1(aData)
        write_UNFORMATTED_CODE_FIELD_1_value = aData
        flag_UNFORMATTED_CODE_FIELD_1        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_1
        read
        read_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_1(aData)
        set_UNFORMATTED_CODE_FIELD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then write_UNFORMATTED_CODE_FIELD_1_value = get_UNFORMATTED_CODE_FIELD_1

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_1_value = &H0
        flag_UNFORMATTED_CODE_FIELD_1        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_next_page_transmit_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_2                   [15:0]           get_UNFORMATTED_CODE_FIELD_2
''                                                             set_UNFORMATTED_CODE_FIELD_2
''                                                             read_UNFORMATTED_CODE_FIELD_2
''                                                             write_UNFORMATTED_CODE_FIELD_2
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_next_page_transmit_reg2
    Private write_UNFORMATTED_CODE_FIELD_2_value
    Private read_UNFORMATTED_CODE_FIELD_2_value
    Private flag_UNFORMATTED_CODE_FIELD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_2
        get_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_2(aData)
        write_UNFORMATTED_CODE_FIELD_2_value = aData
        flag_UNFORMATTED_CODE_FIELD_2        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_2
        read
        read_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_2(aData)
        set_UNFORMATTED_CODE_FIELD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then write_UNFORMATTED_CODE_FIELD_2_value = get_UNFORMATTED_CODE_FIELD_2

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_2_value = &H0
        flag_UNFORMATTED_CODE_FIELD_2        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_lp_next_page_ability_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NEXT_PAGE                                  [15:15]          get_NEXT_PAGE
''                                                             set_NEXT_PAGE
''                                                             read_NEXT_PAGE
''                                                             write_NEXT_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE                                [14:14]          get_ACKNOWLEDGE
''                                                             set_ACKNOWLEDGE
''                                                             read_ACKNOWLEDGE
''                                                             write_ACKNOWLEDGE
''---------------------------------------------------------------------------------
'' MESSAGE_PAGE                               [13:13]          get_MESSAGE_PAGE
''                                                             set_MESSAGE_PAGE
''                                                             read_MESSAGE_PAGE
''                                                             write_MESSAGE_PAGE
''---------------------------------------------------------------------------------
'' ACKNOWLEDGE2                               [12:12]          get_ACKNOWLEDGE2
''                                                             set_ACKNOWLEDGE2
''                                                             read_ACKNOWLEDGE2
''                                                             write_ACKNOWLEDGE2
''---------------------------------------------------------------------------------
'' TOGGLE                                     [11:11]          get_TOGGLE
''                                                             set_TOGGLE
''                                                             read_TOGGLE
''                                                             write_TOGGLE
''---------------------------------------------------------------------------------
'' MESSAGE_UNFORMATTED_CODE_FIELD             [10:0]           get_MESSAGE_UNFORMATTED_CODE_FIELD
''                                                             set_MESSAGE_UNFORMATTED_CODE_FIELD
''                                                             read_MESSAGE_UNFORMATTED_CODE_FIELD
''                                                             write_MESSAGE_UNFORMATTED_CODE_FIELD
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_lp_next_page_ability_reg0
    Private write_NEXT_PAGE_value
    Private read_NEXT_PAGE_value
    Private flag_NEXT_PAGE
    Private write_ACKNOWLEDGE_value
    Private read_ACKNOWLEDGE_value
    Private flag_ACKNOWLEDGE
    Private write_MESSAGE_PAGE_value
    Private read_MESSAGE_PAGE_value
    Private flag_MESSAGE_PAGE
    Private write_ACKNOWLEDGE2_value
    Private read_ACKNOWLEDGE2_value
    Private flag_ACKNOWLEDGE2
    Private write_TOGGLE_value
    Private read_TOGGLE_value
    Private flag_TOGGLE
    Private write_MESSAGE_UNFORMATTED_CODE_FIELD_value
    Private read_MESSAGE_UNFORMATTED_CODE_FIELD_value
    Private flag_MESSAGE_UNFORMATTED_CODE_FIELD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H416
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NEXT_PAGE
        get_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let set_NEXT_PAGE(aData)
        write_NEXT_PAGE_value = aData
        flag_NEXT_PAGE        = &H1
    End Property

    Property Get read_NEXT_PAGE
        read
        read_NEXT_PAGE = read_NEXT_PAGE_value
    End Property

    Property Let write_NEXT_PAGE(aData)
        set_NEXT_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE
        get_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let set_ACKNOWLEDGE(aData)
        write_ACKNOWLEDGE_value = aData
        flag_ACKNOWLEDGE        = &H1
    End Property

    Property Get read_ACKNOWLEDGE
        read
        read_ACKNOWLEDGE = read_ACKNOWLEDGE_value
    End Property

    Property Let write_ACKNOWLEDGE(aData)
        set_ACKNOWLEDGE = aData
        write
    End Property

    Property Get get_MESSAGE_PAGE
        get_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let set_MESSAGE_PAGE(aData)
        write_MESSAGE_PAGE_value = aData
        flag_MESSAGE_PAGE        = &H1
    End Property

    Property Get read_MESSAGE_PAGE
        read
        read_MESSAGE_PAGE = read_MESSAGE_PAGE_value
    End Property

    Property Let write_MESSAGE_PAGE(aData)
        set_MESSAGE_PAGE = aData
        write
    End Property

    Property Get get_ACKNOWLEDGE2
        get_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let set_ACKNOWLEDGE2(aData)
        write_ACKNOWLEDGE2_value = aData
        flag_ACKNOWLEDGE2        = &H1
    End Property

    Property Get read_ACKNOWLEDGE2
        read
        read_ACKNOWLEDGE2 = read_ACKNOWLEDGE2_value
    End Property

    Property Let write_ACKNOWLEDGE2(aData)
        set_ACKNOWLEDGE2 = aData
        write
    End Property

    Property Get get_TOGGLE
        get_TOGGLE = read_TOGGLE_value
    End Property

    Property Let set_TOGGLE(aData)
        write_TOGGLE_value = aData
        flag_TOGGLE        = &H1
    End Property

    Property Get read_TOGGLE
        read
        read_TOGGLE = read_TOGGLE_value
    End Property

    Property Let write_TOGGLE(aData)
        set_TOGGLE = aData
        write
    End Property

    Property Get get_MESSAGE_UNFORMATTED_CODE_FIELD
        get_MESSAGE_UNFORMATTED_CODE_FIELD = read_MESSAGE_UNFORMATTED_CODE_FIELD_value
    End Property

    Property Let set_MESSAGE_UNFORMATTED_CODE_FIELD(aData)
        write_MESSAGE_UNFORMATTED_CODE_FIELD_value = aData
        flag_MESSAGE_UNFORMATTED_CODE_FIELD        = &H1
    End Property

    Property Get read_MESSAGE_UNFORMATTED_CODE_FIELD
        read
        read_MESSAGE_UNFORMATTED_CODE_FIELD = read_MESSAGE_UNFORMATTED_CODE_FIELD_value
    End Property

    Property Let write_MESSAGE_UNFORMATTED_CODE_FIELD(aData)
        set_MESSAGE_UNFORMATTED_CODE_FIELD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MESSAGE_UNFORMATTED_CODE_FIELD_mask = &H7ff
        if data_low > LONG_MAX then
            if MESSAGE_UNFORMATTED_CODE_FIELD_mask = mask then
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low
            else
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = (data_low - H8000_0000) and MESSAGE_UNFORMATTED_CODE_FIELD_mask
            end If
        else
            read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low and MESSAGE_UNFORMATTED_CODE_FIELD_mask
        end If

    End Sub

    Sub write
        If flag_NEXT_PAGE = &H0 or flag_ACKNOWLEDGE = &H0 or flag_MESSAGE_PAGE = &H0 or flag_ACKNOWLEDGE2 = &H0 or flag_TOGGLE = &H0 or flag_MESSAGE_UNFORMATTED_CODE_FIELD = &H0 Then read
        If flag_NEXT_PAGE = &H0 Then write_NEXT_PAGE_value = get_NEXT_PAGE
        If flag_ACKNOWLEDGE = &H0 Then write_ACKNOWLEDGE_value = get_ACKNOWLEDGE
        If flag_MESSAGE_PAGE = &H0 Then write_MESSAGE_PAGE_value = get_MESSAGE_PAGE
        If flag_ACKNOWLEDGE2 = &H0 Then write_ACKNOWLEDGE2_value = get_ACKNOWLEDGE2
        If flag_TOGGLE = &H0 Then write_TOGGLE_value = get_TOGGLE
        If flag_MESSAGE_UNFORMATTED_CODE_FIELD = &H0 Then write_MESSAGE_UNFORMATTED_CODE_FIELD_value = get_MESSAGE_UNFORMATTED_CODE_FIELD

        regValue = leftShift((write_NEXT_PAGE_value and &H1), 15) + leftShift((write_ACKNOWLEDGE_value and &H1), 14) + leftShift((write_MESSAGE_PAGE_value and &H1), 13) + leftShift((write_ACKNOWLEDGE2_value and &H1), 12) + leftShift((write_TOGGLE_value and &H1), 11) + leftShift((write_MESSAGE_UNFORMATTED_CODE_FIELD_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NEXT_PAGE_value = rightShift(data_low, 15) and &H1
        read_ACKNOWLEDGE_value = rightShift(data_low, 14) and &H1
        read_MESSAGE_PAGE_value = rightShift(data_low, 13) and &H1
        read_ACKNOWLEDGE2_value = rightShift(data_low, 12) and &H1
        read_TOGGLE_value = rightShift(data_low, 11) and &H1
        MESSAGE_UNFORMATTED_CODE_FIELD_mask = &H7ff
        if data_low > LONG_MAX then
            if MESSAGE_UNFORMATTED_CODE_FIELD_mask = mask then
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low
            else
                read_MESSAGE_UNFORMATTED_CODE_FIELD_value = (data_low - H8000_0000) and MESSAGE_UNFORMATTED_CODE_FIELD_mask
            end If
        else
            read_MESSAGE_UNFORMATTED_CODE_FIELD_value = data_low and MESSAGE_UNFORMATTED_CODE_FIELD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NEXT_PAGE_value = &H0
        flag_NEXT_PAGE        = &H0
        write_ACKNOWLEDGE_value = &H0
        flag_ACKNOWLEDGE        = &H0
        write_MESSAGE_PAGE_value = &H0
        flag_MESSAGE_PAGE        = &H0
        write_ACKNOWLEDGE2_value = &H0
        flag_ACKNOWLEDGE2        = &H0
        write_TOGGLE_value = &H0
        flag_TOGGLE        = &H0
        write_MESSAGE_UNFORMATTED_CODE_FIELD_value = &H0
        flag_MESSAGE_UNFORMATTED_CODE_FIELD        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_lp_next_page_ability_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_1                   [15:0]           get_UNFORMATTED_CODE_FIELD_1
''                                                             set_UNFORMATTED_CODE_FIELD_1
''                                                             read_UNFORMATTED_CODE_FIELD_1
''                                                             write_UNFORMATTED_CODE_FIELD_1
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_lp_next_page_ability_reg1
    Private write_UNFORMATTED_CODE_FIELD_1_value
    Private read_UNFORMATTED_CODE_FIELD_1_value
    Private flag_UNFORMATTED_CODE_FIELD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H418
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_1
        get_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_1(aData)
        write_UNFORMATTED_CODE_FIELD_1_value = aData
        flag_UNFORMATTED_CODE_FIELD_1        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_1
        read
        read_UNFORMATTED_CODE_FIELD_1 = read_UNFORMATTED_CODE_FIELD_1_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_1(aData)
        set_UNFORMATTED_CODE_FIELD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_1 = &H0 Then write_UNFORMATTED_CODE_FIELD_1_value = get_UNFORMATTED_CODE_FIELD_1

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_1_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_1_mask = mask then
                read_UNFORMATTED_CODE_FIELD_1_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_1_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_1_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_1_value = data_low and UNFORMATTED_CODE_FIELD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_1_value = &H0
        flag_UNFORMATTED_CODE_FIELD_1        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV7_baset1_an_lp_next_page_ability_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNFORMATTED_CODE_FIELD_2                   [15:0]           get_UNFORMATTED_CODE_FIELD_2
''                                                             set_UNFORMATTED_CODE_FIELD_2
''                                                             read_UNFORMATTED_CODE_FIELD_2
''                                                             write_UNFORMATTED_CODE_FIELD_2
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV7_baset1_an_lp_next_page_ability_reg2
    Private write_UNFORMATTED_CODE_FIELD_2_value
    Private read_UNFORMATTED_CODE_FIELD_2_value
    Private flag_UNFORMATTED_CODE_FIELD_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H41a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNFORMATTED_CODE_FIELD_2
        get_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let set_UNFORMATTED_CODE_FIELD_2(aData)
        write_UNFORMATTED_CODE_FIELD_2_value = aData
        flag_UNFORMATTED_CODE_FIELD_2        = &H1
    End Property

    Property Get read_UNFORMATTED_CODE_FIELD_2
        read
        read_UNFORMATTED_CODE_FIELD_2 = read_UNFORMATTED_CODE_FIELD_2_value
    End Property

    Property Let write_UNFORMATTED_CODE_FIELD_2(aData)
        set_UNFORMATTED_CODE_FIELD_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

    End Sub

    Sub write
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then read
        If flag_UNFORMATTED_CODE_FIELD_2 = &H0 Then write_UNFORMATTED_CODE_FIELD_2_value = get_UNFORMATTED_CODE_FIELD_2

        regValue = leftShift((write_UNFORMATTED_CODE_FIELD_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNFORMATTED_CODE_FIELD_2_mask = &Hffff
        if data_low > LONG_MAX then
            if UNFORMATTED_CODE_FIELD_2_mask = mask then
                read_UNFORMATTED_CODE_FIELD_2_value = data_low
            else
                read_UNFORMATTED_CODE_FIELD_2_value = (data_low - H8000_0000) and UNFORMATTED_CODE_FIELD_2_mask
            end If
        else
            read_UNFORMATTED_CODE_FIELD_2_value = data_low and UNFORMATTED_CODE_FIELD_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNFORMATTED_CODE_FIELD_2_value = &H0
        flag_UNFORMATTED_CODE_FIELD_2        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CL45DEV7_INSTANCE

    Public an_ctrl
    Public an_stat
    Public an_dev_id_lsb
    Public an_dev_id_msb
    Public an_dev_in_pkg_lsb
    Public an_dev_in_pkg_msb
    Public an_dev_pkg_id_lsb
    Public an_dev_pkg_id_msb
    Public an_ad
    Public an_lpa
    Public an_xnpa
    Public an_xnpb
    Public an_xnpc
    Public lp_xnpa
    Public lp_xnpb
    Public lp_xnpc
    Public teng_an_ctrl
    Public teng_an_stat
    Public eee_adv
    Public eee_lp_adv
    Public eee_adv_2
    Public eee_lp_adv_2
    Public multi_gbaset_an_ctrl_2
    Public multi_gbaset_an_status_2
    Public autoneg_baset1_an_control
    Public autoneg_baset1_an_status
    Public baset1_an_advertisement_reg0
    Public baset1_an_advertisement_reg1
    Public baset1_an_advertisement_reg2
    Public baset1_an_lp_base_page_ability_reg0
    Public baset1_an_lp_base_page_ability_reg1
    Public baset1_an_lp_base_page_ability_reg2
    Public baset1_an_next_page_transmit_reg0
    Public baset1_an_next_page_transmit_reg1
    Public baset1_an_next_page_transmit_reg2
    Public baset1_an_lp_next_page_ability_reg0
    Public baset1_an_lp_next_page_ability_reg1
    Public baset1_an_lp_next_page_ability_reg2


    Public default function Init(aBaseAddr)
        Set an_ctrl = (New REGISTER_CL45DEV7_an_ctrl)(aBaseAddr, 16)
        Set an_stat = (New REGISTER_CL45DEV7_an_stat)(aBaseAddr, 16)
        Set an_dev_id_lsb = (New REGISTER_CL45DEV7_an_dev_id_lsb)(aBaseAddr, 16)
        Set an_dev_id_msb = (New REGISTER_CL45DEV7_an_dev_id_msb)(aBaseAddr, 16)
        Set an_dev_in_pkg_lsb = (New REGISTER_CL45DEV7_an_dev_in_pkg_lsb)(aBaseAddr, 16)
        Set an_dev_in_pkg_msb = (New REGISTER_CL45DEV7_an_dev_in_pkg_msb)(aBaseAddr, 16)
        Set an_dev_pkg_id_lsb = (New REGISTER_CL45DEV7_an_dev_pkg_id_lsb)(aBaseAddr, 16)
        Set an_dev_pkg_id_msb = (New REGISTER_CL45DEV7_an_dev_pkg_id_msb)(aBaseAddr, 16)
        Set an_ad = (New REGISTER_CL45DEV7_an_ad)(aBaseAddr, 16)
        Set an_lpa = (New REGISTER_CL45DEV7_an_lpa)(aBaseAddr, 16)
        Set an_xnpa = (New REGISTER_CL45DEV7_an_xnpa)(aBaseAddr, 16)
        Set an_xnpb = (New REGISTER_CL45DEV7_an_xnpb)(aBaseAddr, 16)
        Set an_xnpc = (New REGISTER_CL45DEV7_an_xnpc)(aBaseAddr, 16)
        Set lp_xnpa = (New REGISTER_CL45DEV7_lp_xnpa)(aBaseAddr, 16)
        Set lp_xnpb = (New REGISTER_CL45DEV7_lp_xnpb)(aBaseAddr, 16)
        Set lp_xnpc = (New REGISTER_CL45DEV7_lp_xnpc)(aBaseAddr, 16)
        Set teng_an_ctrl = (New REGISTER_CL45DEV7_teng_an_ctrl)(aBaseAddr, 16)
        Set teng_an_stat = (New REGISTER_CL45DEV7_teng_an_stat)(aBaseAddr, 16)
        Set eee_adv = (New REGISTER_CL45DEV7_eee_adv)(aBaseAddr, 16)
        Set eee_lp_adv = (New REGISTER_CL45DEV7_eee_lp_adv)(aBaseAddr, 16)
        Set eee_adv_2 = (New REGISTER_CL45DEV7_eee_adv_2)(aBaseAddr, 16)
        Set eee_lp_adv_2 = (New REGISTER_CL45DEV7_eee_lp_adv_2)(aBaseAddr, 16)
        Set multi_gbaset_an_ctrl_2 = (New REGISTER_CL45DEV7_multi_gbaset_an_ctrl_2)(aBaseAddr, 16)
        Set multi_gbaset_an_status_2 = (New REGISTER_CL45DEV7_multi_gbaset_an_status_2)(aBaseAddr, 16)
        Set autoneg_baset1_an_control = (New REGISTER_CL45DEV7_autoneg_baset1_an_control)(aBaseAddr, 16)
        Set autoneg_baset1_an_status = (New REGISTER_CL45DEV7_autoneg_baset1_an_status)(aBaseAddr, 16)
        Set baset1_an_advertisement_reg0 = (New REGISTER_CL45DEV7_baset1_an_advertisement_reg0)(aBaseAddr, 16)
        Set baset1_an_advertisement_reg1 = (New REGISTER_CL45DEV7_baset1_an_advertisement_reg1)(aBaseAddr, 16)
        Set baset1_an_advertisement_reg2 = (New REGISTER_CL45DEV7_baset1_an_advertisement_reg2)(aBaseAddr, 16)
        Set baset1_an_lp_base_page_ability_reg0 = (New REGISTER_CL45DEV7_baset1_an_lp_base_page_ability_reg0)(aBaseAddr, 16)
        Set baset1_an_lp_base_page_ability_reg1 = (New REGISTER_CL45DEV7_baset1_an_lp_base_page_ability_reg1)(aBaseAddr, 16)
        Set baset1_an_lp_base_page_ability_reg2 = (New REGISTER_CL45DEV7_baset1_an_lp_base_page_ability_reg2)(aBaseAddr, 16)
        Set baset1_an_next_page_transmit_reg0 = (New REGISTER_CL45DEV7_baset1_an_next_page_transmit_reg0)(aBaseAddr, 16)
        Set baset1_an_next_page_transmit_reg1 = (New REGISTER_CL45DEV7_baset1_an_next_page_transmit_reg1)(aBaseAddr, 16)
        Set baset1_an_next_page_transmit_reg2 = (New REGISTER_CL45DEV7_baset1_an_next_page_transmit_reg2)(aBaseAddr, 16)
        Set baset1_an_lp_next_page_ability_reg0 = (New REGISTER_CL45DEV7_baset1_an_lp_next_page_ability_reg0)(aBaseAddr, 16)
        Set baset1_an_lp_next_page_ability_reg1 = (New REGISTER_CL45DEV7_baset1_an_lp_next_page_ability_reg1)(aBaseAddr, 16)
        Set baset1_an_lp_next_page_ability_reg2 = (New REGISTER_CL45DEV7_baset1_an_lp_next_page_ability_reg2)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CL45DEV7 = CreateObject("System.Collections.ArrayList")
CL45DEV7.Add ((New CL45DEV7_INSTANCE)(&H4a4e0000))
CL45DEV7.Add ((New CL45DEV7_INSTANCE)(&H494e0000))
CL45DEV7.Add ((New CL45DEV7_INSTANCE)(&H498e0000))
CL45DEV7.Add ((New CL45DEV7_INSTANCE)(&H49ce0000))
CL45DEV7.Add ((New CL45DEV7_INSTANCE)(&H4a0e0000))


