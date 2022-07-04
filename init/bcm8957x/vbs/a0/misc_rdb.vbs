

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


'' @REGISTER : MISC_model_rev_num
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' model_num                                  [9:4]            get_model_num
''                                                             set_model_num
''                                                             read_model_num
''                                                             write_model_num
''---------------------------------------------------------------------------------
'' rev_num                                    [3:0]            get_rev_num
''                                                             set_rev_num
''                                                             read_rev_num
''                                                             write_rev_num
''---------------------------------------------------------------------------------
Class REGISTER_MISC_model_rev_num
    Private write_model_num_value
    Private read_model_num_value
    Private flag_model_num
    Private write_rev_num_value
    Private read_rev_num_value
    Private flag_rev_num

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

    Property Get get_model_num
        get_model_num = read_model_num_value
    End Property

    Property Let set_model_num(aData)
        write_model_num_value = aData
        flag_model_num        = &H1
    End Property

    Property Get read_model_num
        read
        read_model_num = read_model_num_value
    End Property

    Property Let write_model_num(aData)
        set_model_num = aData
        write
    End Property

    Property Get get_rev_num
        get_rev_num = read_rev_num_value
    End Property

    Property Let set_rev_num(aData)
        write_rev_num_value = aData
        flag_rev_num        = &H1
    End Property

    Property Get read_rev_num
        read
        read_rev_num = read_rev_num_value
    End Property

    Property Let write_rev_num(aData)
        set_rev_num = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_model_num_value = rightShift(data_low, 4) and &H3f
        rev_num_mask = &Hf
        if data_low > LONG_MAX then
            if rev_num_mask = mask then
                read_rev_num_value = data_low
            else
                read_rev_num_value = (data_low - H8000_0000) and rev_num_mask
            end If
        else
            read_rev_num_value = data_low and rev_num_mask
        end If

    End Sub

    Sub write
        If flag_model_num = &H0 or flag_rev_num = &H0 Then read
        If flag_model_num = &H0 Then write_model_num_value = get_model_num
        If flag_rev_num = &H0 Then write_rev_num_value = get_rev_num

        regValue = leftShift((write_model_num_value and &H3f), 4) + leftShift((write_rev_num_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_model_num_value = rightShift(data_low, 4) and &H3f
        rev_num_mask = &Hf
        if data_low > LONG_MAX then
            if rev_num_mask = mask then
                read_rev_num_value = data_low
            else
                read_rev_num_value = (data_low - H8000_0000) and rev_num_mask
            end If
        else
            read_rev_num_value = data_low and rev_num_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_model_num_value = &H0
        flag_model_num        = &H0
        write_rev_num_value = &H0
        flag_rev_num        = &H0
    End Sub
End Class


'' @REGISTER : MISC_deviceid_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' device_id_lo                               [11:0]           get_device_id_lo
''                                                             set_device_id_lo
''                                                             read_device_id_lo
''                                                             write_device_id_lo
''---------------------------------------------------------------------------------
Class REGISTER_MISC_deviceid_lo
    Private write_device_id_lo_value
    Private read_device_id_lo_value
    Private flag_device_id_lo

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

    Property Get get_device_id_lo
        get_device_id_lo = read_device_id_lo_value
    End Property

    Property Let set_device_id_lo(aData)
        write_device_id_lo_value = aData
        flag_device_id_lo        = &H1
    End Property

    Property Get read_device_id_lo
        read
        read_device_id_lo = read_device_id_lo_value
    End Property

    Property Let write_device_id_lo(aData)
        set_device_id_lo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        device_id_lo_mask = &Hfff
        if data_low > LONG_MAX then
            if device_id_lo_mask = mask then
                read_device_id_lo_value = data_low
            else
                read_device_id_lo_value = (data_low - H8000_0000) and device_id_lo_mask
            end If
        else
            read_device_id_lo_value = data_low and device_id_lo_mask
        end If

    End Sub

    Sub write
        If flag_device_id_lo = &H0 Then read
        If flag_device_id_lo = &H0 Then write_device_id_lo_value = get_device_id_lo

        regValue = leftShift((write_device_id_lo_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        device_id_lo_mask = &Hfff
        if data_low > LONG_MAX then
            if device_id_lo_mask = mask then
                read_device_id_lo_value = data_low
            else
                read_device_id_lo_value = (data_low - H8000_0000) and device_id_lo_mask
            end If
        else
            read_device_id_lo_value = data_low and device_id_lo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_device_id_lo_value = &H0
        flag_device_id_lo        = &H0
    End Sub
End Class


'' @REGISTER : MISC_deviceid_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' device_id_hi                               [7:0]            get_device_id_hi
''                                                             set_device_id_hi
''                                                             read_device_id_hi
''                                                             write_device_id_hi
''---------------------------------------------------------------------------------
Class REGISTER_MISC_deviceid_hi
    Private write_device_id_hi_value
    Private read_device_id_hi_value
    Private flag_device_id_hi

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

    Property Get get_device_id_hi
        get_device_id_hi = read_device_id_hi_value
    End Property

    Property Let set_device_id_hi(aData)
        write_device_id_hi_value = aData
        flag_device_id_hi        = &H1
    End Property

    Property Get read_device_id_hi
        read
        read_device_id_hi = read_device_id_hi_value
    End Property

    Property Let write_device_id_hi(aData)
        set_device_id_hi = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        device_id_hi_mask = &Hff
        if data_low > LONG_MAX then
            if device_id_hi_mask = mask then
                read_device_id_hi_value = data_low
            else
                read_device_id_hi_value = (data_low - H8000_0000) and device_id_hi_mask
            end If
        else
            read_device_id_hi_value = data_low and device_id_hi_mask
        end If

    End Sub

    Sub write
        If flag_device_id_hi = &H0 Then read
        If flag_device_id_hi = &H0 Then write_device_id_hi_value = get_device_id_hi

        regValue = leftShift((write_device_id_hi_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        device_id_hi_mask = &Hff
        if data_low > LONG_MAX then
            if device_id_hi_mask = mask then
                read_device_id_hi_value = data_low
            else
                read_device_id_hi_value = (data_low - H8000_0000) and device_id_hi_mask
            end If
        else
            read_device_id_hi_value = data_low and device_id_hi_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_device_id_hi_value = &H0
        flag_device_id_hi        = &H0
    End Sub
End Class


'' @REGISTER : MISC_switch_misc_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pda_all_mem_for_switch                     [15:15]          get_pda_all_mem_for_switch
''                                                             set_pda_all_mem_for_switch
''                                                             read_pda_all_mem_for_switch
''                                                             write_pda_all_mem_for_switch
''---------------------------------------------------------------------------------
'' direct_gate_port                           [8:0]            get_direct_gate_port
''                                                             set_direct_gate_port
''                                                             read_direct_gate_port
''                                                             write_direct_gate_port
''---------------------------------------------------------------------------------
Class REGISTER_MISC_switch_misc_ctrl
    Private write_pda_all_mem_for_switch_value
    Private read_pda_all_mem_for_switch_value
    Private flag_pda_all_mem_for_switch
    Private write_direct_gate_port_value
    Private read_direct_gate_port_value
    Private flag_direct_gate_port

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

    Property Get get_pda_all_mem_for_switch
        get_pda_all_mem_for_switch = read_pda_all_mem_for_switch_value
    End Property

    Property Let set_pda_all_mem_for_switch(aData)
        write_pda_all_mem_for_switch_value = aData
        flag_pda_all_mem_for_switch        = &H1
    End Property

    Property Get read_pda_all_mem_for_switch
        read
        read_pda_all_mem_for_switch = read_pda_all_mem_for_switch_value
    End Property

    Property Let write_pda_all_mem_for_switch(aData)
        set_pda_all_mem_for_switch = aData
        write
    End Property

    Property Get get_direct_gate_port
        get_direct_gate_port = read_direct_gate_port_value
    End Property

    Property Let set_direct_gate_port(aData)
        write_direct_gate_port_value = aData
        flag_direct_gate_port        = &H1
    End Property

    Property Get read_direct_gate_port
        read
        read_direct_gate_port = read_direct_gate_port_value
    End Property

    Property Let write_direct_gate_port(aData)
        set_direct_gate_port = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pda_all_mem_for_switch_value = rightShift(data_low, 15) and &H1
        direct_gate_port_mask = &H1ff
        if data_low > LONG_MAX then
            if direct_gate_port_mask = mask then
                read_direct_gate_port_value = data_low
            else
                read_direct_gate_port_value = (data_low - H8000_0000) and direct_gate_port_mask
            end If
        else
            read_direct_gate_port_value = data_low and direct_gate_port_mask
        end If

    End Sub

    Sub write
        If flag_pda_all_mem_for_switch = &H0 or flag_direct_gate_port = &H0 Then read
        If flag_pda_all_mem_for_switch = &H0 Then write_pda_all_mem_for_switch_value = get_pda_all_mem_for_switch
        If flag_direct_gate_port = &H0 Then write_direct_gate_port_value = get_direct_gate_port

        regValue = leftShift((write_pda_all_mem_for_switch_value and &H1), 15) + leftShift((write_direct_gate_port_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pda_all_mem_for_switch_value = rightShift(data_low, 15) and &H1
        direct_gate_port_mask = &H1ff
        if data_low > LONG_MAX then
            if direct_gate_port_mask = mask then
                read_direct_gate_port_value = data_low
            else
                read_direct_gate_port_value = (data_low - H8000_0000) and direct_gate_port_mask
            end If
        else
            read_direct_gate_port_value = data_low and direct_gate_port_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pda_all_mem_for_switch_value = &H0
        flag_pda_all_mem_for_switch        = &H0
        write_direct_gate_port_value = &H0
        flag_direct_gate_port        = &H0
    End Sub
End Class


'' @REGISTER : MISC_ldo_pwrdn
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdn                                      [0:0]            get_pwrdn
''                                                             set_pwrdn
''                                                             read_pwrdn
''                                                             write_pwrdn
''---------------------------------------------------------------------------------
Class REGISTER_MISC_ldo_pwrdn
    Private write_pwrdn_value
    Private read_pwrdn_value
    Private flag_pwrdn

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pwrdn
        get_pwrdn = read_pwrdn_value
    End Property

    Property Let set_pwrdn(aData)
        write_pwrdn_value = aData
        flag_pwrdn        = &H1
    End Property

    Property Get read_pwrdn
        read
        read_pwrdn = read_pwrdn_value
    End Property

    Property Let write_pwrdn(aData)
        set_pwrdn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdn_mask = mask then
                read_pwrdn_value = data_low
            else
                read_pwrdn_value = (data_low - H8000_0000) and pwrdn_mask
            end If
        else
            read_pwrdn_value = data_low and pwrdn_mask
        end If

    End Sub

    Sub write
        If flag_pwrdn = &H0 Then read
        If flag_pwrdn = &H0 Then write_pwrdn_value = get_pwrdn

        regValue = leftShift((write_pwrdn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdn_mask = mask then
                read_pwrdn_value = data_low
            else
                read_pwrdn_value = (data_low - H8000_0000) and pwrdn_mask
            end If
        else
            read_pwrdn_value = data_low and pwrdn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdn_value = &H0
        flag_pwrdn        = &H0
    End Sub
End Class


'' @REGISTER : MISC_ldo_vregcntl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BG_ref_voltage_trimming                    [14:11]          get_BG_ref_voltage_trimming
''                                                             set_BG_ref_voltage_trimming
''                                                             read_BG_ref_voltage_trimming
''                                                             write_BG_ref_voltage_trimming
''---------------------------------------------------------------------------------
'' Inrush_current_adjustment                  [10:10]          get_Inrush_current_adjustment
''                                                             set_Inrush_current_adjustment
''                                                             read_Inrush_current_adjustment
''                                                             write_Inrush_current_adjustment
''---------------------------------------------------------------------------------
'' Current_limit_adjustment                   [9:9]            get_Current_limit_adjustment
''                                                             set_Current_limit_adjustment
''                                                             read_Current_limit_adjustment
''                                                             write_Current_limit_adjustment
''---------------------------------------------------------------------------------
'' Leakage_sensing_control                    [8:8]            get_Leakage_sensing_control
''                                                             set_Leakage_sensing_control
''                                                             read_Leakage_sensing_control
''                                                             write_Leakage_sensing_control
''---------------------------------------------------------------------------------
'' Output_voltage_tuning                      [7:4]            get_Output_voltage_tuning
''                                                             set_Output_voltage_tuning
''                                                             read_Output_voltage_tuning
''                                                             write_Output_voltage_tuning
''---------------------------------------------------------------------------------
'' BTCT                                       [3:0]            get_BTCT
''                                                             set_BTCT
''                                                             read_BTCT
''                                                             write_BTCT
''---------------------------------------------------------------------------------
Class REGISTER_MISC_ldo_vregcntl_1
    Private write_BG_ref_voltage_trimming_value
    Private read_BG_ref_voltage_trimming_value
    Private flag_BG_ref_voltage_trimming
    Private write_Inrush_current_adjustment_value
    Private read_Inrush_current_adjustment_value
    Private flag_Inrush_current_adjustment
    Private write_Current_limit_adjustment_value
    Private read_Current_limit_adjustment_value
    Private flag_Current_limit_adjustment
    Private write_Leakage_sensing_control_value
    Private read_Leakage_sensing_control_value
    Private flag_Leakage_sensing_control
    Private write_Output_voltage_tuning_value
    Private read_Output_voltage_tuning_value
    Private flag_Output_voltage_tuning
    Private write_BTCT_value
    Private read_BTCT_value
    Private flag_BTCT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H102
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BG_ref_voltage_trimming
        get_BG_ref_voltage_trimming = read_BG_ref_voltage_trimming_value
    End Property

    Property Let set_BG_ref_voltage_trimming(aData)
        write_BG_ref_voltage_trimming_value = aData
        flag_BG_ref_voltage_trimming        = &H1
    End Property

    Property Get read_BG_ref_voltage_trimming
        read
        read_BG_ref_voltage_trimming = read_BG_ref_voltage_trimming_value
    End Property

    Property Let write_BG_ref_voltage_trimming(aData)
        set_BG_ref_voltage_trimming = aData
        write
    End Property

    Property Get get_Inrush_current_adjustment
        get_Inrush_current_adjustment = read_Inrush_current_adjustment_value
    End Property

    Property Let set_Inrush_current_adjustment(aData)
        write_Inrush_current_adjustment_value = aData
        flag_Inrush_current_adjustment        = &H1
    End Property

    Property Get read_Inrush_current_adjustment
        read
        read_Inrush_current_adjustment = read_Inrush_current_adjustment_value
    End Property

    Property Let write_Inrush_current_adjustment(aData)
        set_Inrush_current_adjustment = aData
        write
    End Property

    Property Get get_Current_limit_adjustment
        get_Current_limit_adjustment = read_Current_limit_adjustment_value
    End Property

    Property Let set_Current_limit_adjustment(aData)
        write_Current_limit_adjustment_value = aData
        flag_Current_limit_adjustment        = &H1
    End Property

    Property Get read_Current_limit_adjustment
        read
        read_Current_limit_adjustment = read_Current_limit_adjustment_value
    End Property

    Property Let write_Current_limit_adjustment(aData)
        set_Current_limit_adjustment = aData
        write
    End Property

    Property Get get_Leakage_sensing_control
        get_Leakage_sensing_control = read_Leakage_sensing_control_value
    End Property

    Property Let set_Leakage_sensing_control(aData)
        write_Leakage_sensing_control_value = aData
        flag_Leakage_sensing_control        = &H1
    End Property

    Property Get read_Leakage_sensing_control
        read
        read_Leakage_sensing_control = read_Leakage_sensing_control_value
    End Property

    Property Let write_Leakage_sensing_control(aData)
        set_Leakage_sensing_control = aData
        write
    End Property

    Property Get get_Output_voltage_tuning
        get_Output_voltage_tuning = read_Output_voltage_tuning_value
    End Property

    Property Let set_Output_voltage_tuning(aData)
        write_Output_voltage_tuning_value = aData
        flag_Output_voltage_tuning        = &H1
    End Property

    Property Get read_Output_voltage_tuning
        read
        read_Output_voltage_tuning = read_Output_voltage_tuning_value
    End Property

    Property Let write_Output_voltage_tuning(aData)
        set_Output_voltage_tuning = aData
        write
    End Property

    Property Get get_BTCT
        get_BTCT = read_BTCT_value
    End Property

    Property Let set_BTCT(aData)
        write_BTCT_value = aData
        flag_BTCT        = &H1
    End Property

    Property Get read_BTCT
        read
        read_BTCT = read_BTCT_value
    End Property

    Property Let write_BTCT(aData)
        set_BTCT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BG_ref_voltage_trimming_value = rightShift(data_low, 11) and &Hf
        read_Inrush_current_adjustment_value = rightShift(data_low, 10) and &H1
        read_Current_limit_adjustment_value = rightShift(data_low, 9) and &H1
        read_Leakage_sensing_control_value = rightShift(data_low, 8) and &H1
        read_Output_voltage_tuning_value = rightShift(data_low, 4) and &Hf
        BTCT_mask = &Hf
        if data_low > LONG_MAX then
            if BTCT_mask = mask then
                read_BTCT_value = data_low
            else
                read_BTCT_value = (data_low - H8000_0000) and BTCT_mask
            end If
        else
            read_BTCT_value = data_low and BTCT_mask
        end If

    End Sub

    Sub write
        If flag_BG_ref_voltage_trimming = &H0 or flag_Inrush_current_adjustment = &H0 or flag_Current_limit_adjustment = &H0 or flag_Leakage_sensing_control = &H0 or flag_Output_voltage_tuning = &H0 or flag_BTCT = &H0 Then read
        If flag_BG_ref_voltage_trimming = &H0 Then write_BG_ref_voltage_trimming_value = get_BG_ref_voltage_trimming
        If flag_Inrush_current_adjustment = &H0 Then write_Inrush_current_adjustment_value = get_Inrush_current_adjustment
        If flag_Current_limit_adjustment = &H0 Then write_Current_limit_adjustment_value = get_Current_limit_adjustment
        If flag_Leakage_sensing_control = &H0 Then write_Leakage_sensing_control_value = get_Leakage_sensing_control
        If flag_Output_voltage_tuning = &H0 Then write_Output_voltage_tuning_value = get_Output_voltage_tuning
        If flag_BTCT = &H0 Then write_BTCT_value = get_BTCT

        regValue = leftShift((write_BG_ref_voltage_trimming_value and &Hf), 11) + leftShift((write_Inrush_current_adjustment_value and &H1), 10) + leftShift((write_Current_limit_adjustment_value and &H1), 9) + leftShift((write_Leakage_sensing_control_value and &H1), 8) + leftShift((write_Output_voltage_tuning_value and &Hf), 4) + leftShift((write_BTCT_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BG_ref_voltage_trimming_value = rightShift(data_low, 11) and &Hf
        read_Inrush_current_adjustment_value = rightShift(data_low, 10) and &H1
        read_Current_limit_adjustment_value = rightShift(data_low, 9) and &H1
        read_Leakage_sensing_control_value = rightShift(data_low, 8) and &H1
        read_Output_voltage_tuning_value = rightShift(data_low, 4) and &Hf
        BTCT_mask = &Hf
        if data_low > LONG_MAX then
            if BTCT_mask = mask then
                read_BTCT_value = data_low
            else
                read_BTCT_value = (data_low - H8000_0000) and BTCT_mask
            end If
        else
            read_BTCT_value = data_low and BTCT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BG_ref_voltage_trimming_value = &H0
        flag_BG_ref_voltage_trimming        = &H0
        write_Inrush_current_adjustment_value = &H0
        flag_Inrush_current_adjustment        = &H0
        write_Current_limit_adjustment_value = &H0
        flag_Current_limit_adjustment        = &H0
        write_Leakage_sensing_control_value = &H0
        flag_Leakage_sensing_control        = &H0
        write_Output_voltage_tuning_value = &H0
        flag_Output_voltage_tuning        = &H0
        write_BTCT_value = &H0
        flag_BTCT        = &H0
    End Sub
End Class


'' @REGISTER : MISC_ldo_vregcntl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Zero_position_adjustment                   [3:2]            get_Zero_position_adjustment
''                                                             set_Zero_position_adjustment
''                                                             read_Zero_position_adjustment
''                                                             write_Zero_position_adjustment
''---------------------------------------------------------------------------------
'' Leakage_sensing_adjustment                 [1:0]            get_Leakage_sensing_adjustment
''                                                             set_Leakage_sensing_adjustment
''                                                             read_Leakage_sensing_adjustment
''                                                             write_Leakage_sensing_adjustment
''---------------------------------------------------------------------------------
Class REGISTER_MISC_ldo_vregcntl_2
    Private write_Zero_position_adjustment_value
    Private read_Zero_position_adjustment_value
    Private flag_Zero_position_adjustment
    Private write_Leakage_sensing_adjustment_value
    Private read_Leakage_sensing_adjustment_value
    Private flag_Leakage_sensing_adjustment

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Zero_position_adjustment
        get_Zero_position_adjustment = read_Zero_position_adjustment_value
    End Property

    Property Let set_Zero_position_adjustment(aData)
        write_Zero_position_adjustment_value = aData
        flag_Zero_position_adjustment        = &H1
    End Property

    Property Get read_Zero_position_adjustment
        read
        read_Zero_position_adjustment = read_Zero_position_adjustment_value
    End Property

    Property Let write_Zero_position_adjustment(aData)
        set_Zero_position_adjustment = aData
        write
    End Property

    Property Get get_Leakage_sensing_adjustment
        get_Leakage_sensing_adjustment = read_Leakage_sensing_adjustment_value
    End Property

    Property Let set_Leakage_sensing_adjustment(aData)
        write_Leakage_sensing_adjustment_value = aData
        flag_Leakage_sensing_adjustment        = &H1
    End Property

    Property Get read_Leakage_sensing_adjustment
        read
        read_Leakage_sensing_adjustment = read_Leakage_sensing_adjustment_value
    End Property

    Property Let write_Leakage_sensing_adjustment(aData)
        set_Leakage_sensing_adjustment = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Zero_position_adjustment_value = rightShift(data_low, 2) and &H3
        Leakage_sensing_adjustment_mask = &H3
        if data_low > LONG_MAX then
            if Leakage_sensing_adjustment_mask = mask then
                read_Leakage_sensing_adjustment_value = data_low
            else
                read_Leakage_sensing_adjustment_value = (data_low - H8000_0000) and Leakage_sensing_adjustment_mask
            end If
        else
            read_Leakage_sensing_adjustment_value = data_low and Leakage_sensing_adjustment_mask
        end If

    End Sub

    Sub write
        If flag_Zero_position_adjustment = &H0 or flag_Leakage_sensing_adjustment = &H0 Then read
        If flag_Zero_position_adjustment = &H0 Then write_Zero_position_adjustment_value = get_Zero_position_adjustment
        If flag_Leakage_sensing_adjustment = &H0 Then write_Leakage_sensing_adjustment_value = get_Leakage_sensing_adjustment

        regValue = leftShift((write_Zero_position_adjustment_value and &H3), 2) + leftShift((write_Leakage_sensing_adjustment_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Zero_position_adjustment_value = rightShift(data_low, 2) and &H3
        Leakage_sensing_adjustment_mask = &H3
        if data_low > LONG_MAX then
            if Leakage_sensing_adjustment_mask = mask then
                read_Leakage_sensing_adjustment_value = data_low
            else
                read_Leakage_sensing_adjustment_value = (data_low - H8000_0000) and Leakage_sensing_adjustment_mask
            end If
        else
            read_Leakage_sensing_adjustment_value = data_low and Leakage_sensing_adjustment_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Zero_position_adjustment_value = &H0
        flag_Zero_position_adjustment        = &H0
        write_Leakage_sensing_adjustment_value = &H0
        flag_Leakage_sensing_adjustment        = &H0
    End Sub
End Class


'' @REGISTER : MISC_ldo_vregcntlen
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vregcntlen                                 [0:0]            get_vregcntlen
''                                                             set_vregcntlen
''                                                             read_vregcntlen
''                                                             write_vregcntlen
''---------------------------------------------------------------------------------
Class REGISTER_MISC_ldo_vregcntlen
    Private write_vregcntlen_value
    Private read_vregcntlen_value
    Private flag_vregcntlen

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H106
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vregcntlen
        get_vregcntlen = read_vregcntlen_value
    End Property

    Property Let set_vregcntlen(aData)
        write_vregcntlen_value = aData
        flag_vregcntlen        = &H1
    End Property

    Property Get read_vregcntlen
        read
        read_vregcntlen = read_vregcntlen_value
    End Property

    Property Let write_vregcntlen(aData)
        set_vregcntlen = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vregcntlen_mask = &H1
        if data_low > LONG_MAX then
            if vregcntlen_mask = mask then
                read_vregcntlen_value = data_low
            else
                read_vregcntlen_value = (data_low - H8000_0000) and vregcntlen_mask
            end If
        else
            read_vregcntlen_value = data_low and vregcntlen_mask
        end If

    End Sub

    Sub write
        If flag_vregcntlen = &H0 Then read
        If flag_vregcntlen = &H0 Then write_vregcntlen_value = get_vregcntlen

        regValue = leftShift((write_vregcntlen_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vregcntlen_mask = &H1
        if data_low > LONG_MAX then
            if vregcntlen_mask = mask then
                read_vregcntlen_value = data_low
            else
                read_vregcntlen_value = (data_low - H8000_0000) and vregcntlen_mask
            end If
        else
            read_vregcntlen_value = data_low and vregcntlen_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vregcntlen_value = &H0
        flag_vregcntlen        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' swreg_softreset                            [0:0]            get_swreg_softreset
''                                                             set_swreg_softreset
''                                                             read_swreg_softreset
''                                                             write_swreg_softreset
''---------------------------------------------------------------------------------
'' update_ctrl_reg_posedge                    [1:1]            get_update_ctrl_reg_posedge
''                                                             set_update_ctrl_reg_posedge
''                                                             read_update_ctrl_reg_posedge
''                                                             write_update_ctrl_reg_posedge
''---------------------------------------------------------------------------------
'' comp_lp_ctrl                               [2:2]            get_comp_lp_ctrl
''                                                             set_comp_lp_ctrl
''                                                             read_comp_lp_ctrl
''                                                             write_comp_lp_ctrl
''---------------------------------------------------------------------------------
'' comp_loop_gain1_ctrl                       [3:3]            get_comp_loop_gain1_ctrl
''                                                             set_comp_loop_gain1_ctrl
''                                                             read_comp_loop_gain1_ctrl
''                                                             write_comp_loop_gain1_ctrl
''---------------------------------------------------------------------------------
'' comp_loop_gain2_ctrl                       [6:4]            get_comp_loop_gain2_ctrl
''                                                             set_comp_loop_gain2_ctrl
''                                                             read_comp_loop_gain2_ctrl
''                                                             write_comp_loop_gain2_ctrl
''---------------------------------------------------------------------------------
'' burst_r_ctrl                               [10:9]           get_burst_r_ctrl
''                                                             set_burst_r_ctrl
''                                                             read_burst_r_ctrl
''                                                             write_burst_r_ctrl
''---------------------------------------------------------------------------------
'' sd_dither_dis                              [11:11]          get_sd_dither_dis
''                                                             set_sd_dither_dis
''                                                             read_sd_dither_dis
''                                                             write_sd_dither_dis
''---------------------------------------------------------------------------------
'' fault_0_ilim_dutycycle_en                  [12:12]          get_fault_0_ilim_dutycycle_en
''                                                             set_fault_0_ilim_dutycycle_en
''                                                             read_fault_0_ilim_dutycycle_en
''                                                             write_fault_0_ilim_dutycycle_en
''---------------------------------------------------------------------------------
'' fault_1_ilim_adcout_en                     [13:13]          get_fault_1_ilim_adcout_en
''                                                             set_fault_1_ilim_adcout_en
''                                                             read_fault_1_ilim_adcout_en
''                                                             write_fault_1_ilim_adcout_en
''---------------------------------------------------------------------------------
'' fault_ov_en                                [14:14]          get_fault_ov_en
''                                                             set_fault_ov_en
''                                                             read_fault_ov_en
''                                                             write_fault_ov_en
''---------------------------------------------------------------------------------
'' jitterfilter_dis                           [15:15]          get_jitterfilter_dis
''                                                             set_jitterfilter_dis
''                                                             read_jitterfilter_dis
''                                                             write_jitterfilter_dis
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg0
    Private write_swreg_softreset_value
    Private read_swreg_softreset_value
    Private flag_swreg_softreset
    Private write_update_ctrl_reg_posedge_value
    Private read_update_ctrl_reg_posedge_value
    Private flag_update_ctrl_reg_posedge
    Private write_comp_lp_ctrl_value
    Private read_comp_lp_ctrl_value
    Private flag_comp_lp_ctrl
    Private write_comp_loop_gain1_ctrl_value
    Private read_comp_loop_gain1_ctrl_value
    Private flag_comp_loop_gain1_ctrl
    Private write_comp_loop_gain2_ctrl_value
    Private read_comp_loop_gain2_ctrl_value
    Private flag_comp_loop_gain2_ctrl
    Private write_burst_r_ctrl_value
    Private read_burst_r_ctrl_value
    Private flag_burst_r_ctrl
    Private write_sd_dither_dis_value
    Private read_sd_dither_dis_value
    Private flag_sd_dither_dis
    Private write_fault_0_ilim_dutycycle_en_value
    Private read_fault_0_ilim_dutycycle_en_value
    Private flag_fault_0_ilim_dutycycle_en
    Private write_fault_1_ilim_adcout_en_value
    Private read_fault_1_ilim_adcout_en_value
    Private flag_fault_1_ilim_adcout_en
    Private write_fault_ov_en_value
    Private read_fault_ov_en_value
    Private flag_fault_ov_en
    Private write_jitterfilter_dis_value
    Private read_jitterfilter_dis_value
    Private flag_jitterfilter_dis

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_swreg_softreset
        get_swreg_softreset = read_swreg_softreset_value
    End Property

    Property Let set_swreg_softreset(aData)
        write_swreg_softreset_value = aData
        flag_swreg_softreset        = &H1
    End Property

    Property Get read_swreg_softreset
        read
        read_swreg_softreset = read_swreg_softreset_value
    End Property

    Property Let write_swreg_softreset(aData)
        set_swreg_softreset = aData
        write
    End Property

    Property Get get_update_ctrl_reg_posedge
        get_update_ctrl_reg_posedge = read_update_ctrl_reg_posedge_value
    End Property

    Property Let set_update_ctrl_reg_posedge(aData)
        write_update_ctrl_reg_posedge_value = aData
        flag_update_ctrl_reg_posedge        = &H1
    End Property

    Property Get read_update_ctrl_reg_posedge
        read
        read_update_ctrl_reg_posedge = read_update_ctrl_reg_posedge_value
    End Property

    Property Let write_update_ctrl_reg_posedge(aData)
        set_update_ctrl_reg_posedge = aData
        write
    End Property

    Property Get get_comp_lp_ctrl
        get_comp_lp_ctrl = read_comp_lp_ctrl_value
    End Property

    Property Let set_comp_lp_ctrl(aData)
        write_comp_lp_ctrl_value = aData
        flag_comp_lp_ctrl        = &H1
    End Property

    Property Get read_comp_lp_ctrl
        read
        read_comp_lp_ctrl = read_comp_lp_ctrl_value
    End Property

    Property Let write_comp_lp_ctrl(aData)
        set_comp_lp_ctrl = aData
        write
    End Property

    Property Get get_comp_loop_gain1_ctrl
        get_comp_loop_gain1_ctrl = read_comp_loop_gain1_ctrl_value
    End Property

    Property Let set_comp_loop_gain1_ctrl(aData)
        write_comp_loop_gain1_ctrl_value = aData
        flag_comp_loop_gain1_ctrl        = &H1
    End Property

    Property Get read_comp_loop_gain1_ctrl
        read
        read_comp_loop_gain1_ctrl = read_comp_loop_gain1_ctrl_value
    End Property

    Property Let write_comp_loop_gain1_ctrl(aData)
        set_comp_loop_gain1_ctrl = aData
        write
    End Property

    Property Get get_comp_loop_gain2_ctrl
        get_comp_loop_gain2_ctrl = read_comp_loop_gain2_ctrl_value
    End Property

    Property Let set_comp_loop_gain2_ctrl(aData)
        write_comp_loop_gain2_ctrl_value = aData
        flag_comp_loop_gain2_ctrl        = &H1
    End Property

    Property Get read_comp_loop_gain2_ctrl
        read
        read_comp_loop_gain2_ctrl = read_comp_loop_gain2_ctrl_value
    End Property

    Property Let write_comp_loop_gain2_ctrl(aData)
        set_comp_loop_gain2_ctrl = aData
        write
    End Property

    Property Get get_burst_r_ctrl
        get_burst_r_ctrl = read_burst_r_ctrl_value
    End Property

    Property Let set_burst_r_ctrl(aData)
        write_burst_r_ctrl_value = aData
        flag_burst_r_ctrl        = &H1
    End Property

    Property Get read_burst_r_ctrl
        read
        read_burst_r_ctrl = read_burst_r_ctrl_value
    End Property

    Property Let write_burst_r_ctrl(aData)
        set_burst_r_ctrl = aData
        write
    End Property

    Property Get get_sd_dither_dis
        get_sd_dither_dis = read_sd_dither_dis_value
    End Property

    Property Let set_sd_dither_dis(aData)
        write_sd_dither_dis_value = aData
        flag_sd_dither_dis        = &H1
    End Property

    Property Get read_sd_dither_dis
        read
        read_sd_dither_dis = read_sd_dither_dis_value
    End Property

    Property Let write_sd_dither_dis(aData)
        set_sd_dither_dis = aData
        write
    End Property

    Property Get get_fault_0_ilim_dutycycle_en
        get_fault_0_ilim_dutycycle_en = read_fault_0_ilim_dutycycle_en_value
    End Property

    Property Let set_fault_0_ilim_dutycycle_en(aData)
        write_fault_0_ilim_dutycycle_en_value = aData
        flag_fault_0_ilim_dutycycle_en        = &H1
    End Property

    Property Get read_fault_0_ilim_dutycycle_en
        read
        read_fault_0_ilim_dutycycle_en = read_fault_0_ilim_dutycycle_en_value
    End Property

    Property Let write_fault_0_ilim_dutycycle_en(aData)
        set_fault_0_ilim_dutycycle_en = aData
        write
    End Property

    Property Get get_fault_1_ilim_adcout_en
        get_fault_1_ilim_adcout_en = read_fault_1_ilim_adcout_en_value
    End Property

    Property Let set_fault_1_ilim_adcout_en(aData)
        write_fault_1_ilim_adcout_en_value = aData
        flag_fault_1_ilim_adcout_en        = &H1
    End Property

    Property Get read_fault_1_ilim_adcout_en
        read
        read_fault_1_ilim_adcout_en = read_fault_1_ilim_adcout_en_value
    End Property

    Property Let write_fault_1_ilim_adcout_en(aData)
        set_fault_1_ilim_adcout_en = aData
        write
    End Property

    Property Get get_fault_ov_en
        get_fault_ov_en = read_fault_ov_en_value
    End Property

    Property Let set_fault_ov_en(aData)
        write_fault_ov_en_value = aData
        flag_fault_ov_en        = &H1
    End Property

    Property Get read_fault_ov_en
        read
        read_fault_ov_en = read_fault_ov_en_value
    End Property

    Property Let write_fault_ov_en(aData)
        set_fault_ov_en = aData
        write
    End Property

    Property Get get_jitterfilter_dis
        get_jitterfilter_dis = read_jitterfilter_dis_value
    End Property

    Property Let set_jitterfilter_dis(aData)
        write_jitterfilter_dis_value = aData
        flag_jitterfilter_dis        = &H1
    End Property

    Property Get read_jitterfilter_dis
        read
        read_jitterfilter_dis = read_jitterfilter_dis_value
    End Property

    Property Let write_jitterfilter_dis(aData)
        set_jitterfilter_dis = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        swreg_softreset_mask = &H1
        if data_low > LONG_MAX then
            if swreg_softreset_mask = mask then
                read_swreg_softreset_value = data_low
            else
                read_swreg_softreset_value = (data_low - H8000_0000) and swreg_softreset_mask
            end If
        else
            read_swreg_softreset_value = data_low and swreg_softreset_mask
        end If
        read_update_ctrl_reg_posedge_value = rightShift(data_low, 1) and &H1
        read_comp_lp_ctrl_value = rightShift(data_low, 2) and &H1
        read_comp_loop_gain1_ctrl_value = rightShift(data_low, 3) and &H1
        read_comp_loop_gain2_ctrl_value = rightShift(data_low, 4) and &H7
        read_burst_r_ctrl_value = rightShift(data_low, 9) and &H3
        read_sd_dither_dis_value = rightShift(data_low, 11) and &H1
        read_fault_0_ilim_dutycycle_en_value = rightShift(data_low, 12) and &H1
        read_fault_1_ilim_adcout_en_value = rightShift(data_low, 13) and &H1
        read_fault_ov_en_value = rightShift(data_low, 14) and &H1
        read_jitterfilter_dis_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_swreg_softreset = &H0 or flag_update_ctrl_reg_posedge = &H0 or flag_comp_lp_ctrl = &H0 or flag_comp_loop_gain1_ctrl = &H0 or flag_comp_loop_gain2_ctrl = &H0 or flag_burst_r_ctrl = &H0 or flag_sd_dither_dis = &H0 or flag_fault_0_ilim_dutycycle_en = &H0 or flag_fault_1_ilim_adcout_en = &H0 or flag_fault_ov_en = &H0 or flag_jitterfilter_dis = &H0 Then read
        If flag_swreg_softreset = &H0 Then write_swreg_softreset_value = get_swreg_softreset
        If flag_update_ctrl_reg_posedge = &H0 Then write_update_ctrl_reg_posedge_value = get_update_ctrl_reg_posedge
        If flag_comp_lp_ctrl = &H0 Then write_comp_lp_ctrl_value = get_comp_lp_ctrl
        If flag_comp_loop_gain1_ctrl = &H0 Then write_comp_loop_gain1_ctrl_value = get_comp_loop_gain1_ctrl
        If flag_comp_loop_gain2_ctrl = &H0 Then write_comp_loop_gain2_ctrl_value = get_comp_loop_gain2_ctrl
        If flag_burst_r_ctrl = &H0 Then write_burst_r_ctrl_value = get_burst_r_ctrl
        If flag_sd_dither_dis = &H0 Then write_sd_dither_dis_value = get_sd_dither_dis
        If flag_fault_0_ilim_dutycycle_en = &H0 Then write_fault_0_ilim_dutycycle_en_value = get_fault_0_ilim_dutycycle_en
        If flag_fault_1_ilim_adcout_en = &H0 Then write_fault_1_ilim_adcout_en_value = get_fault_1_ilim_adcout_en
        If flag_fault_ov_en = &H0 Then write_fault_ov_en_value = get_fault_ov_en
        If flag_jitterfilter_dis = &H0 Then write_jitterfilter_dis_value = get_jitterfilter_dis

        regValue = leftShift((write_swreg_softreset_value and &H1), 0) + leftShift((write_update_ctrl_reg_posedge_value and &H1), 1) + leftShift((write_comp_lp_ctrl_value and &H1), 2) + leftShift((write_comp_loop_gain1_ctrl_value and &H1), 3) + leftShift((write_comp_loop_gain2_ctrl_value and &H7), 4) + leftShift((write_burst_r_ctrl_value and &H3), 9) + leftShift((write_sd_dither_dis_value and &H1), 11) + leftShift((write_fault_0_ilim_dutycycle_en_value and &H1), 12) + leftShift((write_fault_1_ilim_adcout_en_value and &H1), 13) + leftShift((write_fault_ov_en_value and &H1), 14) + leftShift((write_jitterfilter_dis_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        swreg_softreset_mask = &H1
        if data_low > LONG_MAX then
            if swreg_softreset_mask = mask then
                read_swreg_softreset_value = data_low
            else
                read_swreg_softreset_value = (data_low - H8000_0000) and swreg_softreset_mask
            end If
        else
            read_swreg_softreset_value = data_low and swreg_softreset_mask
        end If
        read_update_ctrl_reg_posedge_value = rightShift(data_low, 1) and &H1
        read_comp_lp_ctrl_value = rightShift(data_low, 2) and &H1
        read_comp_loop_gain1_ctrl_value = rightShift(data_low, 3) and &H1
        read_comp_loop_gain2_ctrl_value = rightShift(data_low, 4) and &H7
        read_burst_r_ctrl_value = rightShift(data_low, 9) and &H3
        read_sd_dither_dis_value = rightShift(data_low, 11) and &H1
        read_fault_0_ilim_dutycycle_en_value = rightShift(data_low, 12) and &H1
        read_fault_1_ilim_adcout_en_value = rightShift(data_low, 13) and &H1
        read_fault_ov_en_value = rightShift(data_low, 14) and &H1
        read_jitterfilter_dis_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_swreg_softreset_value = &H0
        flag_swreg_softreset        = &H0
        write_update_ctrl_reg_posedge_value = &H0
        flag_update_ctrl_reg_posedge        = &H0
        write_comp_lp_ctrl_value = &H0
        flag_comp_lp_ctrl        = &H0
        write_comp_loop_gain1_ctrl_value = &H0
        flag_comp_loop_gain1_ctrl        = &H0
        write_comp_loop_gain2_ctrl_value = &H0
        flag_comp_loop_gain2_ctrl        = &H0
        write_burst_r_ctrl_value = &H0
        flag_burst_r_ctrl        = &H0
        write_sd_dither_dis_value = &H0
        flag_sd_dither_dis        = &H0
        write_fault_0_ilim_dutycycle_en_value = &H0
        flag_fault_0_ilim_dutycycle_en        = &H0
        write_fault_1_ilim_adcout_en_value = &H0
        flag_fault_1_ilim_adcout_en        = &H0
        write_fault_ov_en_value = &H0
        flag_fault_ov_en        = &H0
        write_jitterfilter_dis_value = &H0
        flag_jitterfilter_dis        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_ss_ctrl                               [1:0]            get_comp_ss_ctrl
''                                                             set_comp_ss_ctrl
''                                                             read_comp_ss_ctrl
''                                                             write_comp_ss_ctrl
''---------------------------------------------------------------------------------
'' sd_freq_ctrl                               [3:2]            get_sd_freq_ctrl
''                                                             set_sd_freq_ctrl
''                                                             read_sd_freq_ctrl
''                                                             write_sd_freq_ctrl
''---------------------------------------------------------------------------------
'' fault_dutycycle                            [5:4]            get_fault_dutycycle
''                                                             set_fault_dutycycle
''                                                             read_fault_dutycycle
''                                                             write_fault_dutycycle
''---------------------------------------------------------------------------------
'' fault_adcout_ctrl                          [7:6]            get_fault_adcout_ctrl
''                                                             set_fault_adcout_ctrl
''                                                             read_fault_adcout_ctrl
''                                                             write_fault_adcout_ctrl
''---------------------------------------------------------------------------------
'' comp_coef1_sel                             [15:8]           get_comp_coef1_sel
''                                                             set_comp_coef1_sel
''                                                             read_comp_coef1_sel
''                                                             write_comp_coef1_sel
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg1
    Private write_comp_ss_ctrl_value
    Private read_comp_ss_ctrl_value
    Private flag_comp_ss_ctrl
    Private write_sd_freq_ctrl_value
    Private read_sd_freq_ctrl_value
    Private flag_sd_freq_ctrl
    Private write_fault_dutycycle_value
    Private read_fault_dutycycle_value
    Private flag_fault_dutycycle
    Private write_fault_adcout_ctrl_value
    Private read_fault_adcout_ctrl_value
    Private flag_fault_adcout_ctrl
    Private write_comp_coef1_sel_value
    Private read_comp_coef1_sel_value
    Private flag_comp_coef1_sel

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H112
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_comp_ss_ctrl
        get_comp_ss_ctrl = read_comp_ss_ctrl_value
    End Property

    Property Let set_comp_ss_ctrl(aData)
        write_comp_ss_ctrl_value = aData
        flag_comp_ss_ctrl        = &H1
    End Property

    Property Get read_comp_ss_ctrl
        read
        read_comp_ss_ctrl = read_comp_ss_ctrl_value
    End Property

    Property Let write_comp_ss_ctrl(aData)
        set_comp_ss_ctrl = aData
        write
    End Property

    Property Get get_sd_freq_ctrl
        get_sd_freq_ctrl = read_sd_freq_ctrl_value
    End Property

    Property Let set_sd_freq_ctrl(aData)
        write_sd_freq_ctrl_value = aData
        flag_sd_freq_ctrl        = &H1
    End Property

    Property Get read_sd_freq_ctrl
        read
        read_sd_freq_ctrl = read_sd_freq_ctrl_value
    End Property

    Property Let write_sd_freq_ctrl(aData)
        set_sd_freq_ctrl = aData
        write
    End Property

    Property Get get_fault_dutycycle
        get_fault_dutycycle = read_fault_dutycycle_value
    End Property

    Property Let set_fault_dutycycle(aData)
        write_fault_dutycycle_value = aData
        flag_fault_dutycycle        = &H1
    End Property

    Property Get read_fault_dutycycle
        read
        read_fault_dutycycle = read_fault_dutycycle_value
    End Property

    Property Let write_fault_dutycycle(aData)
        set_fault_dutycycle = aData
        write
    End Property

    Property Get get_fault_adcout_ctrl
        get_fault_adcout_ctrl = read_fault_adcout_ctrl_value
    End Property

    Property Let set_fault_adcout_ctrl(aData)
        write_fault_adcout_ctrl_value = aData
        flag_fault_adcout_ctrl        = &H1
    End Property

    Property Get read_fault_adcout_ctrl
        read
        read_fault_adcout_ctrl = read_fault_adcout_ctrl_value
    End Property

    Property Let write_fault_adcout_ctrl(aData)
        set_fault_adcout_ctrl = aData
        write
    End Property

    Property Get get_comp_coef1_sel
        get_comp_coef1_sel = read_comp_coef1_sel_value
    End Property

    Property Let set_comp_coef1_sel(aData)
        write_comp_coef1_sel_value = aData
        flag_comp_coef1_sel        = &H1
    End Property

    Property Get read_comp_coef1_sel
        read
        read_comp_coef1_sel = read_comp_coef1_sel_value
    End Property

    Property Let write_comp_coef1_sel(aData)
        set_comp_coef1_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_ss_ctrl_mask = &H3
        if data_low > LONG_MAX then
            if comp_ss_ctrl_mask = mask then
                read_comp_ss_ctrl_value = data_low
            else
                read_comp_ss_ctrl_value = (data_low - H8000_0000) and comp_ss_ctrl_mask
            end If
        else
            read_comp_ss_ctrl_value = data_low and comp_ss_ctrl_mask
        end If
        read_sd_freq_ctrl_value = rightShift(data_low, 2) and &H3
        read_fault_dutycycle_value = rightShift(data_low, 4) and &H3
        read_fault_adcout_ctrl_value = rightShift(data_low, 6) and &H3
        read_comp_coef1_sel_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_comp_ss_ctrl = &H0 or flag_sd_freq_ctrl = &H0 or flag_fault_dutycycle = &H0 or flag_fault_adcout_ctrl = &H0 or flag_comp_coef1_sel = &H0 Then read
        If flag_comp_ss_ctrl = &H0 Then write_comp_ss_ctrl_value = get_comp_ss_ctrl
        If flag_sd_freq_ctrl = &H0 Then write_sd_freq_ctrl_value = get_sd_freq_ctrl
        If flag_fault_dutycycle = &H0 Then write_fault_dutycycle_value = get_fault_dutycycle
        If flag_fault_adcout_ctrl = &H0 Then write_fault_adcout_ctrl_value = get_fault_adcout_ctrl
        If flag_comp_coef1_sel = &H0 Then write_comp_coef1_sel_value = get_comp_coef1_sel

        regValue = leftShift((write_comp_ss_ctrl_value and &H3), 0) + leftShift((write_sd_freq_ctrl_value and &H3), 2) + leftShift((write_fault_dutycycle_value and &H3), 4) + leftShift((write_fault_adcout_ctrl_value and &H3), 6) + leftShift((write_comp_coef1_sel_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_ss_ctrl_mask = &H3
        if data_low > LONG_MAX then
            if comp_ss_ctrl_mask = mask then
                read_comp_ss_ctrl_value = data_low
            else
                read_comp_ss_ctrl_value = (data_low - H8000_0000) and comp_ss_ctrl_mask
            end If
        else
            read_comp_ss_ctrl_value = data_low and comp_ss_ctrl_mask
        end If
        read_sd_freq_ctrl_value = rightShift(data_low, 2) and &H3
        read_fault_dutycycle_value = rightShift(data_low, 4) and &H3
        read_fault_adcout_ctrl_value = rightShift(data_low, 6) and &H3
        read_comp_coef1_sel_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_ss_ctrl_value = &H0
        flag_comp_ss_ctrl        = &H0
        write_sd_freq_ctrl_value = &H0
        flag_sd_freq_ctrl        = &H0
        write_fault_dutycycle_value = &H0
        flag_fault_dutycycle        = &H0
        write_fault_adcout_ctrl_value = &H0
        flag_fault_adcout_ctrl        = &H0
        write_comp_coef1_sel_value = &H0
        flag_comp_coef1_sel        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' comp_coef1_sel                             [1:0]            get_comp_coef1_sel
''                                                             set_comp_coef1_sel
''                                                             read_comp_coef1_sel
''                                                             write_comp_coef1_sel
''---------------------------------------------------------------------------------
'' comp_coef2_sel                             [11:2]           get_comp_coef2_sel
''                                                             set_comp_coef2_sel
''                                                             read_comp_coef2_sel
''                                                             write_comp_coef2_sel
''---------------------------------------------------------------------------------
'' sd_dutymin_3_0                             [15:12]          get_sd_dutymin_3_0
''                                                             set_sd_dutymin_3_0
''                                                             read_sd_dutymin_3_0
''                                                             write_sd_dutymin_3_0
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg2
    Private write_comp_coef1_sel_value
    Private read_comp_coef1_sel_value
    Private flag_comp_coef1_sel
    Private write_comp_coef2_sel_value
    Private read_comp_coef2_sel_value
    Private flag_comp_coef2_sel
    Private write_sd_dutymin_3_0_value
    Private read_sd_dutymin_3_0_value
    Private flag_sd_dutymin_3_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_comp_coef1_sel
        get_comp_coef1_sel = read_comp_coef1_sel_value
    End Property

    Property Let set_comp_coef1_sel(aData)
        write_comp_coef1_sel_value = aData
        flag_comp_coef1_sel        = &H1
    End Property

    Property Get read_comp_coef1_sel
        read
        read_comp_coef1_sel = read_comp_coef1_sel_value
    End Property

    Property Let write_comp_coef1_sel(aData)
        set_comp_coef1_sel = aData
        write
    End Property

    Property Get get_comp_coef2_sel
        get_comp_coef2_sel = read_comp_coef2_sel_value
    End Property

    Property Let set_comp_coef2_sel(aData)
        write_comp_coef2_sel_value = aData
        flag_comp_coef2_sel        = &H1
    End Property

    Property Get read_comp_coef2_sel
        read
        read_comp_coef2_sel = read_comp_coef2_sel_value
    End Property

    Property Let write_comp_coef2_sel(aData)
        set_comp_coef2_sel = aData
        write
    End Property

    Property Get get_sd_dutymin_3_0
        get_sd_dutymin_3_0 = read_sd_dutymin_3_0_value
    End Property

    Property Let set_sd_dutymin_3_0(aData)
        write_sd_dutymin_3_0_value = aData
        flag_sd_dutymin_3_0        = &H1
    End Property

    Property Get read_sd_dutymin_3_0
        read
        read_sd_dutymin_3_0 = read_sd_dutymin_3_0_value
    End Property

    Property Let write_sd_dutymin_3_0(aData)
        set_sd_dutymin_3_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_coef1_sel_mask = &H3
        if data_low > LONG_MAX then
            if comp_coef1_sel_mask = mask then
                read_comp_coef1_sel_value = data_low
            else
                read_comp_coef1_sel_value = (data_low - H8000_0000) and comp_coef1_sel_mask
            end If
        else
            read_comp_coef1_sel_value = data_low and comp_coef1_sel_mask
        end If
        read_comp_coef2_sel_value = rightShift(data_low, 2) and &H3ff
        read_sd_dutymin_3_0_value = rightShift(data_low, 12) and &Hf

    End Sub

    Sub write
        If flag_comp_coef1_sel = &H0 or flag_comp_coef2_sel = &H0 or flag_sd_dutymin_3_0 = &H0 Then read
        If flag_comp_coef1_sel = &H0 Then write_comp_coef1_sel_value = get_comp_coef1_sel
        If flag_comp_coef2_sel = &H0 Then write_comp_coef2_sel_value = get_comp_coef2_sel
        If flag_sd_dutymin_3_0 = &H0 Then write_sd_dutymin_3_0_value = get_sd_dutymin_3_0

        regValue = leftShift((write_comp_coef1_sel_value and &H3), 0) + leftShift((write_comp_coef2_sel_value and &H3ff), 2) + leftShift((write_sd_dutymin_3_0_value and &Hf), 12)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        comp_coef1_sel_mask = &H3
        if data_low > LONG_MAX then
            if comp_coef1_sel_mask = mask then
                read_comp_coef1_sel_value = data_low
            else
                read_comp_coef1_sel_value = (data_low - H8000_0000) and comp_coef1_sel_mask
            end If
        else
            read_comp_coef1_sel_value = data_low and comp_coef1_sel_mask
        end If
        read_comp_coef2_sel_value = rightShift(data_low, 2) and &H3ff
        read_sd_dutymin_3_0_value = rightShift(data_low, 12) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_comp_coef1_sel_value = &H0
        flag_comp_coef1_sel        = &H0
        write_comp_coef2_sel_value = &H0
        flag_comp_coef2_sel        = &H0
        write_sd_dutymin_3_0_value = &H0
        flag_sd_dutymin_3_0        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sd_dutymin_6_4                             [2:0]            get_sd_dutymin_6_4
''                                                             set_sd_dutymin_6_4
''                                                             read_sd_dutymin_6_4
''                                                             write_sd_dutymin_6_4
''---------------------------------------------------------------------------------
'' sd_dutymax                                 [11:3]           get_sd_dutymax
''                                                             set_sd_dutymax
''                                                             read_sd_dutymax
''                                                             write_sd_dutymax
''---------------------------------------------------------------------------------
'' fault_adcout_ref_3_0                       [15:12]          get_fault_adcout_ref_3_0
''                                                             set_fault_adcout_ref_3_0
''                                                             read_fault_adcout_ref_3_0
''                                                             write_fault_adcout_ref_3_0
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg3
    Private write_sd_dutymin_6_4_value
    Private read_sd_dutymin_6_4_value
    Private flag_sd_dutymin_6_4
    Private write_sd_dutymax_value
    Private read_sd_dutymax_value
    Private flag_sd_dutymax
    Private write_fault_adcout_ref_3_0_value
    Private read_fault_adcout_ref_3_0_value
    Private flag_fault_adcout_ref_3_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H116
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sd_dutymin_6_4
        get_sd_dutymin_6_4 = read_sd_dutymin_6_4_value
    End Property

    Property Let set_sd_dutymin_6_4(aData)
        write_sd_dutymin_6_4_value = aData
        flag_sd_dutymin_6_4        = &H1
    End Property

    Property Get read_sd_dutymin_6_4
        read
        read_sd_dutymin_6_4 = read_sd_dutymin_6_4_value
    End Property

    Property Let write_sd_dutymin_6_4(aData)
        set_sd_dutymin_6_4 = aData
        write
    End Property

    Property Get get_sd_dutymax
        get_sd_dutymax = read_sd_dutymax_value
    End Property

    Property Let set_sd_dutymax(aData)
        write_sd_dutymax_value = aData
        flag_sd_dutymax        = &H1
    End Property

    Property Get read_sd_dutymax
        read
        read_sd_dutymax = read_sd_dutymax_value
    End Property

    Property Let write_sd_dutymax(aData)
        set_sd_dutymax = aData
        write
    End Property

    Property Get get_fault_adcout_ref_3_0
        get_fault_adcout_ref_3_0 = read_fault_adcout_ref_3_0_value
    End Property

    Property Let set_fault_adcout_ref_3_0(aData)
        write_fault_adcout_ref_3_0_value = aData
        flag_fault_adcout_ref_3_0        = &H1
    End Property

    Property Get read_fault_adcout_ref_3_0
        read
        read_fault_adcout_ref_3_0 = read_fault_adcout_ref_3_0_value
    End Property

    Property Let write_fault_adcout_ref_3_0(aData)
        set_fault_adcout_ref_3_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sd_dutymin_6_4_mask = &H7
        if data_low > LONG_MAX then
            if sd_dutymin_6_4_mask = mask then
                read_sd_dutymin_6_4_value = data_low
            else
                read_sd_dutymin_6_4_value = (data_low - H8000_0000) and sd_dutymin_6_4_mask
            end If
        else
            read_sd_dutymin_6_4_value = data_low and sd_dutymin_6_4_mask
        end If
        read_sd_dutymax_value = rightShift(data_low, 3) and &H1ff
        read_fault_adcout_ref_3_0_value = rightShift(data_low, 12) and &Hf

    End Sub

    Sub write
        If flag_sd_dutymin_6_4 = &H0 or flag_sd_dutymax = &H0 or flag_fault_adcout_ref_3_0 = &H0 Then read
        If flag_sd_dutymin_6_4 = &H0 Then write_sd_dutymin_6_4_value = get_sd_dutymin_6_4
        If flag_sd_dutymax = &H0 Then write_sd_dutymax_value = get_sd_dutymax
        If flag_fault_adcout_ref_3_0 = &H0 Then write_fault_adcout_ref_3_0_value = get_fault_adcout_ref_3_0

        regValue = leftShift((write_sd_dutymin_6_4_value and &H7), 0) + leftShift((write_sd_dutymax_value and &H1ff), 3) + leftShift((write_fault_adcout_ref_3_0_value and &Hf), 12)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sd_dutymin_6_4_mask = &H7
        if data_low > LONG_MAX then
            if sd_dutymin_6_4_mask = mask then
                read_sd_dutymin_6_4_value = data_low
            else
                read_sd_dutymin_6_4_value = (data_low - H8000_0000) and sd_dutymin_6_4_mask
            end If
        else
            read_sd_dutymin_6_4_value = data_low and sd_dutymin_6_4_mask
        end If
        read_sd_dutymax_value = rightShift(data_low, 3) and &H1ff
        read_fault_adcout_ref_3_0_value = rightShift(data_low, 12) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sd_dutymin_6_4_value = &H0
        flag_sd_dutymin_6_4        = &H0
        write_sd_dutymax_value = &H0
        flag_sd_dutymax        = &H0
        write_fault_adcout_ref_3_0_value = &H0
        flag_fault_adcout_ref_3_0        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fault_adcout_ref_9_4                       [5:0]            get_fault_adcout_ref_9_4
''                                                             set_fault_adcout_ref_9_4
''                                                             read_fault_adcout_ref_9_4
''                                                             write_fault_adcout_ref_9_4
''---------------------------------------------------------------------------------
'' ilim_dutycycle_ref                         [15:6]           get_ilim_dutycycle_ref
''                                                             set_ilim_dutycycle_ref
''                                                             read_ilim_dutycycle_ref
''                                                             write_ilim_dutycycle_ref
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg4
    Private write_fault_adcout_ref_9_4_value
    Private read_fault_adcout_ref_9_4_value
    Private flag_fault_adcout_ref_9_4
    Private write_ilim_dutycycle_ref_value
    Private read_ilim_dutycycle_ref_value
    Private flag_ilim_dutycycle_ref

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fault_adcout_ref_9_4
        get_fault_adcout_ref_9_4 = read_fault_adcout_ref_9_4_value
    End Property

    Property Let set_fault_adcout_ref_9_4(aData)
        write_fault_adcout_ref_9_4_value = aData
        flag_fault_adcout_ref_9_4        = &H1
    End Property

    Property Get read_fault_adcout_ref_9_4
        read
        read_fault_adcout_ref_9_4 = read_fault_adcout_ref_9_4_value
    End Property

    Property Let write_fault_adcout_ref_9_4(aData)
        set_fault_adcout_ref_9_4 = aData
        write
    End Property

    Property Get get_ilim_dutycycle_ref
        get_ilim_dutycycle_ref = read_ilim_dutycycle_ref_value
    End Property

    Property Let set_ilim_dutycycle_ref(aData)
        write_ilim_dutycycle_ref_value = aData
        flag_ilim_dutycycle_ref        = &H1
    End Property

    Property Get read_ilim_dutycycle_ref
        read
        read_ilim_dutycycle_ref = read_ilim_dutycycle_ref_value
    End Property

    Property Let write_ilim_dutycycle_ref(aData)
        set_ilim_dutycycle_ref = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fault_adcout_ref_9_4_mask = &H3f
        if data_low > LONG_MAX then
            if fault_adcout_ref_9_4_mask = mask then
                read_fault_adcout_ref_9_4_value = data_low
            else
                read_fault_adcout_ref_9_4_value = (data_low - H8000_0000) and fault_adcout_ref_9_4_mask
            end If
        else
            read_fault_adcout_ref_9_4_value = data_low and fault_adcout_ref_9_4_mask
        end If
        read_ilim_dutycycle_ref_value = rightShift(data_low, 6) and &H3ff

    End Sub

    Sub write
        If flag_fault_adcout_ref_9_4 = &H0 or flag_ilim_dutycycle_ref = &H0 Then read
        If flag_fault_adcout_ref_9_4 = &H0 Then write_fault_adcout_ref_9_4_value = get_fault_adcout_ref_9_4
        If flag_ilim_dutycycle_ref = &H0 Then write_ilim_dutycycle_ref_value = get_ilim_dutycycle_ref

        regValue = leftShift((write_fault_adcout_ref_9_4_value and &H3f), 0) + leftShift((write_ilim_dutycycle_ref_value and &H3ff), 6)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fault_adcout_ref_9_4_mask = &H3f
        if data_low > LONG_MAX then
            if fault_adcout_ref_9_4_mask = mask then
                read_fault_adcout_ref_9_4_value = data_low
            else
                read_fault_adcout_ref_9_4_value = (data_low - H8000_0000) and fault_adcout_ref_9_4_mask
            end If
        else
            read_fault_adcout_ref_9_4_value = data_low and fault_adcout_ref_9_4_mask
        end If
        read_ilim_dutycycle_ref_value = rightShift(data_low, 6) and &H3ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fault_adcout_ref_9_4_value = &H0
        flag_fault_adcout_ref_9_4        = &H0
        write_ilim_dutycycle_ref_value = &H0
        flag_ilim_dutycycle_ref        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pmu_stable_override_bsti                   [0:0]            get_pmu_stable_override_bsti
''                                                             set_pmu_stable_override_bsti
''                                                             read_pmu_stable_override_bsti
''                                                             write_pmu_stable_override_bsti
''---------------------------------------------------------------------------------
'' FETS_ENB_DELAY_CTRL                        [3:2]            get_FETS_ENB_DELAY_CTRL
''                                                             set_FETS_ENB_DELAY_CTRL
''                                                             read_FETS_ENB_DELAY_CTRL
''                                                             write_FETS_ENB_DELAY_CTRL
''---------------------------------------------------------------------------------
'' NOVL_CTRL                                  [6:4]            get_NOVL_CTRL
''                                                             set_NOVL_CTRL
''                                                             read_NOVL_CTRL
''                                                             write_NOVL_CTRL
''---------------------------------------------------------------------------------
'' dutycycle_ilim_fault_0_mask                [7:7]            get_dutycycle_ilim_fault_0_mask
''                                                             set_dutycycle_ilim_fault_0_mask
''                                                             read_dutycycle_ilim_fault_0_mask
''                                                             write_dutycycle_ilim_fault_0_mask
''---------------------------------------------------------------------------------
'' adcout_ilim_fault_1_mask                   [8:8]            get_adcout_ilim_fault_1_mask
''                                                             set_adcout_ilim_fault_1_mask
''                                                             read_adcout_ilim_fault_1_mask
''                                                             write_adcout_ilim_fault_1_mask
''---------------------------------------------------------------------------------
'' analog_comp_ilim_fault2_mask               [9:9]            get_analog_comp_ilim_fault2_mask
''                                                             set_analog_comp_ilim_fault2_mask
''                                                             read_analog_comp_ilim_fault2_mask
''                                                             write_analog_comp_ilim_fault2_mask
''---------------------------------------------------------------------------------
'' OV_fault_mask                              [10:10]          get_OV_fault_mask
''                                                             set_OV_fault_mask
''                                                             read_OV_fault_mask
''                                                             write_OV_fault_mask
''---------------------------------------------------------------------------------
'' PLL_EN                                     [11:11]          get_PLL_EN
''                                                             set_PLL_EN
''                                                             read_PLL_EN
''                                                             write_PLL_EN
''---------------------------------------------------------------------------------
'' BURST_MODE_EN                              [12:12]          get_BURST_MODE_EN
''                                                             set_BURST_MODE_EN
''                                                             read_BURST_MODE_EN
''                                                             write_BURST_MODE_EN
''---------------------------------------------------------------------------------
'' burst_d_ctrl_2_0                           [15:13]          get_burst_d_ctrl_2_0
''                                                             set_burst_d_ctrl_2_0
''                                                             read_burst_d_ctrl_2_0
''                                                             write_burst_d_ctrl_2_0
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg5
    Private write_pmu_stable_override_bsti_value
    Private read_pmu_stable_override_bsti_value
    Private flag_pmu_stable_override_bsti
    Private write_FETS_ENB_DELAY_CTRL_value
    Private read_FETS_ENB_DELAY_CTRL_value
    Private flag_FETS_ENB_DELAY_CTRL
    Private write_NOVL_CTRL_value
    Private read_NOVL_CTRL_value
    Private flag_NOVL_CTRL
    Private write_dutycycle_ilim_fault_0_mask_value
    Private read_dutycycle_ilim_fault_0_mask_value
    Private flag_dutycycle_ilim_fault_0_mask
    Private write_adcout_ilim_fault_1_mask_value
    Private read_adcout_ilim_fault_1_mask_value
    Private flag_adcout_ilim_fault_1_mask
    Private write_analog_comp_ilim_fault2_mask_value
    Private read_analog_comp_ilim_fault2_mask_value
    Private flag_analog_comp_ilim_fault2_mask
    Private write_OV_fault_mask_value
    Private read_OV_fault_mask_value
    Private flag_OV_fault_mask
    Private write_PLL_EN_value
    Private read_PLL_EN_value
    Private flag_PLL_EN
    Private write_BURST_MODE_EN_value
    Private read_BURST_MODE_EN_value
    Private flag_BURST_MODE_EN
    Private write_burst_d_ctrl_2_0_value
    Private read_burst_d_ctrl_2_0_value
    Private flag_burst_d_ctrl_2_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pmu_stable_override_bsti
        get_pmu_stable_override_bsti = read_pmu_stable_override_bsti_value
    End Property

    Property Let set_pmu_stable_override_bsti(aData)
        write_pmu_stable_override_bsti_value = aData
        flag_pmu_stable_override_bsti        = &H1
    End Property

    Property Get read_pmu_stable_override_bsti
        read
        read_pmu_stable_override_bsti = read_pmu_stable_override_bsti_value
    End Property

    Property Let write_pmu_stable_override_bsti(aData)
        set_pmu_stable_override_bsti = aData
        write
    End Property

    Property Get get_FETS_ENB_DELAY_CTRL
        get_FETS_ENB_DELAY_CTRL = read_FETS_ENB_DELAY_CTRL_value
    End Property

    Property Let set_FETS_ENB_DELAY_CTRL(aData)
        write_FETS_ENB_DELAY_CTRL_value = aData
        flag_FETS_ENB_DELAY_CTRL        = &H1
    End Property

    Property Get read_FETS_ENB_DELAY_CTRL
        read
        read_FETS_ENB_DELAY_CTRL = read_FETS_ENB_DELAY_CTRL_value
    End Property

    Property Let write_FETS_ENB_DELAY_CTRL(aData)
        set_FETS_ENB_DELAY_CTRL = aData
        write
    End Property

    Property Get get_NOVL_CTRL
        get_NOVL_CTRL = read_NOVL_CTRL_value
    End Property

    Property Let set_NOVL_CTRL(aData)
        write_NOVL_CTRL_value = aData
        flag_NOVL_CTRL        = &H1
    End Property

    Property Get read_NOVL_CTRL
        read
        read_NOVL_CTRL = read_NOVL_CTRL_value
    End Property

    Property Let write_NOVL_CTRL(aData)
        set_NOVL_CTRL = aData
        write
    End Property

    Property Get get_dutycycle_ilim_fault_0_mask
        get_dutycycle_ilim_fault_0_mask = read_dutycycle_ilim_fault_0_mask_value
    End Property

    Property Let set_dutycycle_ilim_fault_0_mask(aData)
        write_dutycycle_ilim_fault_0_mask_value = aData
        flag_dutycycle_ilim_fault_0_mask        = &H1
    End Property

    Property Get read_dutycycle_ilim_fault_0_mask
        read
        read_dutycycle_ilim_fault_0_mask = read_dutycycle_ilim_fault_0_mask_value
    End Property

    Property Let write_dutycycle_ilim_fault_0_mask(aData)
        set_dutycycle_ilim_fault_0_mask = aData
        write
    End Property

    Property Get get_adcout_ilim_fault_1_mask
        get_adcout_ilim_fault_1_mask = read_adcout_ilim_fault_1_mask_value
    End Property

    Property Let set_adcout_ilim_fault_1_mask(aData)
        write_adcout_ilim_fault_1_mask_value = aData
        flag_adcout_ilim_fault_1_mask        = &H1
    End Property

    Property Get read_adcout_ilim_fault_1_mask
        read
        read_adcout_ilim_fault_1_mask = read_adcout_ilim_fault_1_mask_value
    End Property

    Property Let write_adcout_ilim_fault_1_mask(aData)
        set_adcout_ilim_fault_1_mask = aData
        write
    End Property

    Property Get get_analog_comp_ilim_fault2_mask
        get_analog_comp_ilim_fault2_mask = read_analog_comp_ilim_fault2_mask_value
    End Property

    Property Let set_analog_comp_ilim_fault2_mask(aData)
        write_analog_comp_ilim_fault2_mask_value = aData
        flag_analog_comp_ilim_fault2_mask        = &H1
    End Property

    Property Get read_analog_comp_ilim_fault2_mask
        read
        read_analog_comp_ilim_fault2_mask = read_analog_comp_ilim_fault2_mask_value
    End Property

    Property Let write_analog_comp_ilim_fault2_mask(aData)
        set_analog_comp_ilim_fault2_mask = aData
        write
    End Property

    Property Get get_OV_fault_mask
        get_OV_fault_mask = read_OV_fault_mask_value
    End Property

    Property Let set_OV_fault_mask(aData)
        write_OV_fault_mask_value = aData
        flag_OV_fault_mask        = &H1
    End Property

    Property Get read_OV_fault_mask
        read
        read_OV_fault_mask = read_OV_fault_mask_value
    End Property

    Property Let write_OV_fault_mask(aData)
        set_OV_fault_mask = aData
        write
    End Property

    Property Get get_PLL_EN
        get_PLL_EN = read_PLL_EN_value
    End Property

    Property Let set_PLL_EN(aData)
        write_PLL_EN_value = aData
        flag_PLL_EN        = &H1
    End Property

    Property Get read_PLL_EN
        read
        read_PLL_EN = read_PLL_EN_value
    End Property

    Property Let write_PLL_EN(aData)
        set_PLL_EN = aData
        write
    End Property

    Property Get get_BURST_MODE_EN
        get_BURST_MODE_EN = read_BURST_MODE_EN_value
    End Property

    Property Let set_BURST_MODE_EN(aData)
        write_BURST_MODE_EN_value = aData
        flag_BURST_MODE_EN        = &H1
    End Property

    Property Get read_BURST_MODE_EN
        read
        read_BURST_MODE_EN = read_BURST_MODE_EN_value
    End Property

    Property Let write_BURST_MODE_EN(aData)
        set_BURST_MODE_EN = aData
        write
    End Property

    Property Get get_burst_d_ctrl_2_0
        get_burst_d_ctrl_2_0 = read_burst_d_ctrl_2_0_value
    End Property

    Property Let set_burst_d_ctrl_2_0(aData)
        write_burst_d_ctrl_2_0_value = aData
        flag_burst_d_ctrl_2_0        = &H1
    End Property

    Property Get read_burst_d_ctrl_2_0
        read
        read_burst_d_ctrl_2_0 = read_burst_d_ctrl_2_0_value
    End Property

    Property Let write_burst_d_ctrl_2_0(aData)
        set_burst_d_ctrl_2_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pmu_stable_override_bsti_mask = &H1
        if data_low > LONG_MAX then
            if pmu_stable_override_bsti_mask = mask then
                read_pmu_stable_override_bsti_value = data_low
            else
                read_pmu_stable_override_bsti_value = (data_low - H8000_0000) and pmu_stable_override_bsti_mask
            end If
        else
            read_pmu_stable_override_bsti_value = data_low and pmu_stable_override_bsti_mask
        end If
        read_FETS_ENB_DELAY_CTRL_value = rightShift(data_low, 2) and &H3
        read_NOVL_CTRL_value = rightShift(data_low, 4) and &H7
        read_dutycycle_ilim_fault_0_mask_value = rightShift(data_low, 7) and &H1
        read_adcout_ilim_fault_1_mask_value = rightShift(data_low, 8) and &H1
        read_analog_comp_ilim_fault2_mask_value = rightShift(data_low, 9) and &H1
        read_OV_fault_mask_value = rightShift(data_low, 10) and &H1
        read_PLL_EN_value = rightShift(data_low, 11) and &H1
        read_BURST_MODE_EN_value = rightShift(data_low, 12) and &H1
        read_burst_d_ctrl_2_0_value = rightShift(data_low, 13) and &H7

    End Sub

    Sub write
        If flag_pmu_stable_override_bsti = &H0 or flag_FETS_ENB_DELAY_CTRL = &H0 or flag_NOVL_CTRL = &H0 or flag_dutycycle_ilim_fault_0_mask = &H0 or flag_adcout_ilim_fault_1_mask = &H0 or flag_analog_comp_ilim_fault2_mask = &H0 or flag_OV_fault_mask = &H0 or flag_PLL_EN = &H0 or flag_BURST_MODE_EN = &H0 or flag_burst_d_ctrl_2_0 = &H0 Then read
        If flag_pmu_stable_override_bsti = &H0 Then write_pmu_stable_override_bsti_value = get_pmu_stable_override_bsti
        If flag_FETS_ENB_DELAY_CTRL = &H0 Then write_FETS_ENB_DELAY_CTRL_value = get_FETS_ENB_DELAY_CTRL
        If flag_NOVL_CTRL = &H0 Then write_NOVL_CTRL_value = get_NOVL_CTRL
        If flag_dutycycle_ilim_fault_0_mask = &H0 Then write_dutycycle_ilim_fault_0_mask_value = get_dutycycle_ilim_fault_0_mask
        If flag_adcout_ilim_fault_1_mask = &H0 Then write_adcout_ilim_fault_1_mask_value = get_adcout_ilim_fault_1_mask
        If flag_analog_comp_ilim_fault2_mask = &H0 Then write_analog_comp_ilim_fault2_mask_value = get_analog_comp_ilim_fault2_mask
        If flag_OV_fault_mask = &H0 Then write_OV_fault_mask_value = get_OV_fault_mask
        If flag_PLL_EN = &H0 Then write_PLL_EN_value = get_PLL_EN
        If flag_BURST_MODE_EN = &H0 Then write_BURST_MODE_EN_value = get_BURST_MODE_EN
        If flag_burst_d_ctrl_2_0 = &H0 Then write_burst_d_ctrl_2_0_value = get_burst_d_ctrl_2_0

        regValue = leftShift((write_pmu_stable_override_bsti_value and &H1), 0) + leftShift((write_FETS_ENB_DELAY_CTRL_value and &H3), 2) + leftShift((write_NOVL_CTRL_value and &H7), 4) + leftShift((write_dutycycle_ilim_fault_0_mask_value and &H1), 7) + leftShift((write_adcout_ilim_fault_1_mask_value and &H1), 8) + leftShift((write_analog_comp_ilim_fault2_mask_value and &H1), 9) + leftShift((write_OV_fault_mask_value and &H1), 10) + leftShift((write_PLL_EN_value and &H1), 11) + leftShift((write_BURST_MODE_EN_value and &H1), 12) + leftShift((write_burst_d_ctrl_2_0_value and &H7), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pmu_stable_override_bsti_mask = &H1
        if data_low > LONG_MAX then
            if pmu_stable_override_bsti_mask = mask then
                read_pmu_stable_override_bsti_value = data_low
            else
                read_pmu_stable_override_bsti_value = (data_low - H8000_0000) and pmu_stable_override_bsti_mask
            end If
        else
            read_pmu_stable_override_bsti_value = data_low and pmu_stable_override_bsti_mask
        end If
        read_FETS_ENB_DELAY_CTRL_value = rightShift(data_low, 2) and &H3
        read_NOVL_CTRL_value = rightShift(data_low, 4) and &H7
        read_dutycycle_ilim_fault_0_mask_value = rightShift(data_low, 7) and &H1
        read_adcout_ilim_fault_1_mask_value = rightShift(data_low, 8) and &H1
        read_analog_comp_ilim_fault2_mask_value = rightShift(data_low, 9) and &H1
        read_OV_fault_mask_value = rightShift(data_low, 10) and &H1
        read_PLL_EN_value = rightShift(data_low, 11) and &H1
        read_BURST_MODE_EN_value = rightShift(data_low, 12) and &H1
        read_burst_d_ctrl_2_0_value = rightShift(data_low, 13) and &H7

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pmu_stable_override_bsti_value = &H0
        flag_pmu_stable_override_bsti        = &H0
        write_FETS_ENB_DELAY_CTRL_value = &H0
        flag_FETS_ENB_DELAY_CTRL        = &H0
        write_NOVL_CTRL_value = &H0
        flag_NOVL_CTRL        = &H0
        write_dutycycle_ilim_fault_0_mask_value = &H0
        flag_dutycycle_ilim_fault_0_mask        = &H0
        write_adcout_ilim_fault_1_mask_value = &H0
        flag_adcout_ilim_fault_1_mask        = &H0
        write_analog_comp_ilim_fault2_mask_value = &H0
        flag_analog_comp_ilim_fault2_mask        = &H0
        write_OV_fault_mask_value = &H0
        flag_OV_fault_mask        = &H0
        write_PLL_EN_value = &H0
        flag_PLL_EN        = &H0
        write_BURST_MODE_EN_value = &H0
        flag_BURST_MODE_EN        = &H0
        write_burst_d_ctrl_2_0_value = &H0
        flag_burst_d_ctrl_2_0        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DVDD_CTRL                                  [1:0]            get_DVDD_CTRL
''                                                             set_DVDD_CTRL
''                                                             read_DVDD_CTRL
''                                                             write_DVDD_CTRL
''---------------------------------------------------------------------------------
'' BG_TRIM_CTRL                               [7:2]            get_BG_TRIM_CTRL
''                                                             set_BG_TRIM_CTRL
''                                                             read_BG_TRIM_CTRL
''                                                             write_BG_TRIM_CTRL
''---------------------------------------------------------------------------------
'' REF_CTRL                                   [15:8]           get_REF_CTRL
''                                                             set_REF_CTRL
''                                                             read_REF_CTRL
''                                                             write_REF_CTRL
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg6
    Private write_DVDD_CTRL_value
    Private read_DVDD_CTRL_value
    Private flag_DVDD_CTRL
    Private write_BG_TRIM_CTRL_value
    Private read_BG_TRIM_CTRL_value
    Private flag_BG_TRIM_CTRL
    Private write_REF_CTRL_value
    Private read_REF_CTRL_value
    Private flag_REF_CTRL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DVDD_CTRL
        get_DVDD_CTRL = read_DVDD_CTRL_value
    End Property

    Property Let set_DVDD_CTRL(aData)
        write_DVDD_CTRL_value = aData
        flag_DVDD_CTRL        = &H1
    End Property

    Property Get read_DVDD_CTRL
        read
        read_DVDD_CTRL = read_DVDD_CTRL_value
    End Property

    Property Let write_DVDD_CTRL(aData)
        set_DVDD_CTRL = aData
        write
    End Property

    Property Get get_BG_TRIM_CTRL
        get_BG_TRIM_CTRL = read_BG_TRIM_CTRL_value
    End Property

    Property Let set_BG_TRIM_CTRL(aData)
        write_BG_TRIM_CTRL_value = aData
        flag_BG_TRIM_CTRL        = &H1
    End Property

    Property Get read_BG_TRIM_CTRL
        read
        read_BG_TRIM_CTRL = read_BG_TRIM_CTRL_value
    End Property

    Property Let write_BG_TRIM_CTRL(aData)
        set_BG_TRIM_CTRL = aData
        write
    End Property

    Property Get get_REF_CTRL
        get_REF_CTRL = read_REF_CTRL_value
    End Property

    Property Let set_REF_CTRL(aData)
        write_REF_CTRL_value = aData
        flag_REF_CTRL        = &H1
    End Property

    Property Get read_REF_CTRL
        read
        read_REF_CTRL = read_REF_CTRL_value
    End Property

    Property Let write_REF_CTRL(aData)
        set_REF_CTRL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DVDD_CTRL_mask = &H3
        if data_low > LONG_MAX then
            if DVDD_CTRL_mask = mask then
                read_DVDD_CTRL_value = data_low
            else
                read_DVDD_CTRL_value = (data_low - H8000_0000) and DVDD_CTRL_mask
            end If
        else
            read_DVDD_CTRL_value = data_low and DVDD_CTRL_mask
        end If
        read_BG_TRIM_CTRL_value = rightShift(data_low, 2) and &H3f
        read_REF_CTRL_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_DVDD_CTRL = &H0 or flag_BG_TRIM_CTRL = &H0 or flag_REF_CTRL = &H0 Then read
        If flag_DVDD_CTRL = &H0 Then write_DVDD_CTRL_value = get_DVDD_CTRL
        If flag_BG_TRIM_CTRL = &H0 Then write_BG_TRIM_CTRL_value = get_BG_TRIM_CTRL
        If flag_REF_CTRL = &H0 Then write_REF_CTRL_value = get_REF_CTRL

        regValue = leftShift((write_DVDD_CTRL_value and &H3), 0) + leftShift((write_BG_TRIM_CTRL_value and &H3f), 2) + leftShift((write_REF_CTRL_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DVDD_CTRL_mask = &H3
        if data_low > LONG_MAX then
            if DVDD_CTRL_mask = mask then
                read_DVDD_CTRL_value = data_low
            else
                read_DVDD_CTRL_value = (data_low - H8000_0000) and DVDD_CTRL_mask
            end If
        else
            read_DVDD_CTRL_value = data_low and DVDD_CTRL_mask
        end If
        read_BG_TRIM_CTRL_value = rightShift(data_low, 2) and &H3f
        read_REF_CTRL_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DVDD_CTRL_value = &H0
        flag_DVDD_CTRL        = &H0
        write_BG_TRIM_CTRL_value = &H0
        flag_BG_TRIM_CTRL        = &H0
        write_REF_CTRL_value = &H0
        flag_REF_CTRL        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NDRIVE_Pfet                                [2:0]            get_NDRIVE_Pfet
''                                                             set_NDRIVE_Pfet
''                                                             read_NDRIVE_Pfet
''                                                             write_NDRIVE_Pfet
''---------------------------------------------------------------------------------
'' NDRIVE_Nfet                                [5:3]            get_NDRIVE_Nfet
''                                                             set_NDRIVE_Nfet
''                                                             read_NDRIVE_Nfet
''                                                             write_NDRIVE_Nfet
''---------------------------------------------------------------------------------
'' PDRIVE_Pfet                                [8:6]            get_PDRIVE_Pfet
''                                                             set_PDRIVE_Pfet
''                                                             read_PDRIVE_Pfet
''                                                             write_PDRIVE_Pfet
''---------------------------------------------------------------------------------
'' PDRIVE_Nfet                                [11:9]           get_PDRIVE_Nfet
''                                                             set_PDRIVE_Nfet
''                                                             read_PDRIVE_Nfet
''                                                             write_PDRIVE_Nfet
''---------------------------------------------------------------------------------
'' adapt_novl                                 [13:12]          get_adapt_novl
''                                                             set_adapt_novl
''                                                             read_adapt_novl
''                                                             write_adapt_novl
''---------------------------------------------------------------------------------
'' pulse_width_limit                          [15:14]          get_pulse_width_limit
''                                                             set_pulse_width_limit
''                                                             read_pulse_width_limit
''                                                             write_pulse_width_limit
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg7
    Private write_NDRIVE_Pfet_value
    Private read_NDRIVE_Pfet_value
    Private flag_NDRIVE_Pfet
    Private write_NDRIVE_Nfet_value
    Private read_NDRIVE_Nfet_value
    Private flag_NDRIVE_Nfet
    Private write_PDRIVE_Pfet_value
    Private read_PDRIVE_Pfet_value
    Private flag_PDRIVE_Pfet
    Private write_PDRIVE_Nfet_value
    Private read_PDRIVE_Nfet_value
    Private flag_PDRIVE_Nfet
    Private write_adapt_novl_value
    Private read_adapt_novl_value
    Private flag_adapt_novl
    Private write_pulse_width_limit_value
    Private read_pulse_width_limit_value
    Private flag_pulse_width_limit

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NDRIVE_Pfet
        get_NDRIVE_Pfet = read_NDRIVE_Pfet_value
    End Property

    Property Let set_NDRIVE_Pfet(aData)
        write_NDRIVE_Pfet_value = aData
        flag_NDRIVE_Pfet        = &H1
    End Property

    Property Get read_NDRIVE_Pfet
        read
        read_NDRIVE_Pfet = read_NDRIVE_Pfet_value
    End Property

    Property Let write_NDRIVE_Pfet(aData)
        set_NDRIVE_Pfet = aData
        write
    End Property

    Property Get get_NDRIVE_Nfet
        get_NDRIVE_Nfet = read_NDRIVE_Nfet_value
    End Property

    Property Let set_NDRIVE_Nfet(aData)
        write_NDRIVE_Nfet_value = aData
        flag_NDRIVE_Nfet        = &H1
    End Property

    Property Get read_NDRIVE_Nfet
        read
        read_NDRIVE_Nfet = read_NDRIVE_Nfet_value
    End Property

    Property Let write_NDRIVE_Nfet(aData)
        set_NDRIVE_Nfet = aData
        write
    End Property

    Property Get get_PDRIVE_Pfet
        get_PDRIVE_Pfet = read_PDRIVE_Pfet_value
    End Property

    Property Let set_PDRIVE_Pfet(aData)
        write_PDRIVE_Pfet_value = aData
        flag_PDRIVE_Pfet        = &H1
    End Property

    Property Get read_PDRIVE_Pfet
        read
        read_PDRIVE_Pfet = read_PDRIVE_Pfet_value
    End Property

    Property Let write_PDRIVE_Pfet(aData)
        set_PDRIVE_Pfet = aData
        write
    End Property

    Property Get get_PDRIVE_Nfet
        get_PDRIVE_Nfet = read_PDRIVE_Nfet_value
    End Property

    Property Let set_PDRIVE_Nfet(aData)
        write_PDRIVE_Nfet_value = aData
        flag_PDRIVE_Nfet        = &H1
    End Property

    Property Get read_PDRIVE_Nfet
        read
        read_PDRIVE_Nfet = read_PDRIVE_Nfet_value
    End Property

    Property Let write_PDRIVE_Nfet(aData)
        set_PDRIVE_Nfet = aData
        write
    End Property

    Property Get get_adapt_novl
        get_adapt_novl = read_adapt_novl_value
    End Property

    Property Let set_adapt_novl(aData)
        write_adapt_novl_value = aData
        flag_adapt_novl        = &H1
    End Property

    Property Get read_adapt_novl
        read
        read_adapt_novl = read_adapt_novl_value
    End Property

    Property Let write_adapt_novl(aData)
        set_adapt_novl = aData
        write
    End Property

    Property Get get_pulse_width_limit
        get_pulse_width_limit = read_pulse_width_limit_value
    End Property

    Property Let set_pulse_width_limit(aData)
        write_pulse_width_limit_value = aData
        flag_pulse_width_limit        = &H1
    End Property

    Property Get read_pulse_width_limit
        read
        read_pulse_width_limit = read_pulse_width_limit_value
    End Property

    Property Let write_pulse_width_limit(aData)
        set_pulse_width_limit = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NDRIVE_Pfet_mask = &H7
        if data_low > LONG_MAX then
            if NDRIVE_Pfet_mask = mask then
                read_NDRIVE_Pfet_value = data_low
            else
                read_NDRIVE_Pfet_value = (data_low - H8000_0000) and NDRIVE_Pfet_mask
            end If
        else
            read_NDRIVE_Pfet_value = data_low and NDRIVE_Pfet_mask
        end If
        read_NDRIVE_Nfet_value = rightShift(data_low, 3) and &H7
        read_PDRIVE_Pfet_value = rightShift(data_low, 6) and &H7
        read_PDRIVE_Nfet_value = rightShift(data_low, 9) and &H7
        read_adapt_novl_value = rightShift(data_low, 12) and &H3
        read_pulse_width_limit_value = rightShift(data_low, 14) and &H3

    End Sub

    Sub write
        If flag_NDRIVE_Pfet = &H0 or flag_NDRIVE_Nfet = &H0 or flag_PDRIVE_Pfet = &H0 or flag_PDRIVE_Nfet = &H0 or flag_adapt_novl = &H0 or flag_pulse_width_limit = &H0 Then read
        If flag_NDRIVE_Pfet = &H0 Then write_NDRIVE_Pfet_value = get_NDRIVE_Pfet
        If flag_NDRIVE_Nfet = &H0 Then write_NDRIVE_Nfet_value = get_NDRIVE_Nfet
        If flag_PDRIVE_Pfet = &H0 Then write_PDRIVE_Pfet_value = get_PDRIVE_Pfet
        If flag_PDRIVE_Nfet = &H0 Then write_PDRIVE_Nfet_value = get_PDRIVE_Nfet
        If flag_adapt_novl = &H0 Then write_adapt_novl_value = get_adapt_novl
        If flag_pulse_width_limit = &H0 Then write_pulse_width_limit_value = get_pulse_width_limit

        regValue = leftShift((write_NDRIVE_Pfet_value and &H7), 0) + leftShift((write_NDRIVE_Nfet_value and &H7), 3) + leftShift((write_PDRIVE_Pfet_value and &H7), 6) + leftShift((write_PDRIVE_Nfet_value and &H7), 9) + leftShift((write_adapt_novl_value and &H3), 12) + leftShift((write_pulse_width_limit_value and &H3), 14)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NDRIVE_Pfet_mask = &H7
        if data_low > LONG_MAX then
            if NDRIVE_Pfet_mask = mask then
                read_NDRIVE_Pfet_value = data_low
            else
                read_NDRIVE_Pfet_value = (data_low - H8000_0000) and NDRIVE_Pfet_mask
            end If
        else
            read_NDRIVE_Pfet_value = data_low and NDRIVE_Pfet_mask
        end If
        read_NDRIVE_Nfet_value = rightShift(data_low, 3) and &H7
        read_PDRIVE_Pfet_value = rightShift(data_low, 6) and &H7
        read_PDRIVE_Nfet_value = rightShift(data_low, 9) and &H7
        read_adapt_novl_value = rightShift(data_low, 12) and &H3
        read_pulse_width_limit_value = rightShift(data_low, 14) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NDRIVE_Pfet_value = &H0
        flag_NDRIVE_Pfet        = &H0
        write_NDRIVE_Nfet_value = &H0
        flag_NDRIVE_Nfet        = &H0
        write_PDRIVE_Pfet_value = &H0
        flag_PDRIVE_Pfet        = &H0
        write_PDRIVE_Nfet_value = &H0
        flag_PDRIVE_Nfet        = &H0
        write_adapt_novl_value = &H0
        flag_adapt_novl        = &H0
        write_pulse_width_limit_value = &H0
        flag_pulse_width_limit        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RGM_CTRL                                   [2:0]            get_RGM_CTRL
''                                                             set_RGM_CTRL
''                                                             read_RGM_CTRL
''                                                             write_RGM_CTRL
''---------------------------------------------------------------------------------
'' OSC_ADJ                                    [5:3]            get_OSC_ADJ
''                                                             set_OSC_ADJ
''                                                             read_OSC_ADJ
''                                                             write_OSC_ADJ
''---------------------------------------------------------------------------------
'' phase_cntrl_en                             [6:6]            get_phase_cntrl_en
''                                                             set_phase_cntrl_en
''                                                             read_phase_cntrl_en
''                                                             write_phase_cntrl_en
''---------------------------------------------------------------------------------
'' GMBIAS_CTRL                                [7:7]            get_GMBIAS_CTRL
''                                                             set_GMBIAS_CTRL
''                                                             read_GMBIAS_CTRL
''                                                             write_GMBIAS_CTRL
''---------------------------------------------------------------------------------
'' phase_cntrl_comp_width                     [8:8]            get_phase_cntrl_comp_width
''                                                             set_phase_cntrl_comp_width
''                                                             read_phase_cntrl_comp_width
''                                                             write_phase_cntrl_comp_width
''---------------------------------------------------------------------------------
'' IVCO_CTRL                                  [11:9]           get_IVCO_CTRL
''                                                             set_IVCO_CTRL
''                                                             read_IVCO_CTRL
''                                                             write_IVCO_CTRL
''---------------------------------------------------------------------------------
'' burst_d_ctrl_6_3                           [15:12]          get_burst_d_ctrl_6_3
''                                                             set_burst_d_ctrl_6_3
''                                                             read_burst_d_ctrl_6_3
''                                                             write_burst_d_ctrl_6_3
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg8
    Private write_RGM_CTRL_value
    Private read_RGM_CTRL_value
    Private flag_RGM_CTRL
    Private write_OSC_ADJ_value
    Private read_OSC_ADJ_value
    Private flag_OSC_ADJ
    Private write_phase_cntrl_en_value
    Private read_phase_cntrl_en_value
    Private flag_phase_cntrl_en
    Private write_GMBIAS_CTRL_value
    Private read_GMBIAS_CTRL_value
    Private flag_GMBIAS_CTRL
    Private write_phase_cntrl_comp_width_value
    Private read_phase_cntrl_comp_width_value
    Private flag_phase_cntrl_comp_width
    Private write_IVCO_CTRL_value
    Private read_IVCO_CTRL_value
    Private flag_IVCO_CTRL
    Private write_burst_d_ctrl_6_3_value
    Private read_burst_d_ctrl_6_3_value
    Private flag_burst_d_ctrl_6_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RGM_CTRL
        get_RGM_CTRL = read_RGM_CTRL_value
    End Property

    Property Let set_RGM_CTRL(aData)
        write_RGM_CTRL_value = aData
        flag_RGM_CTRL        = &H1
    End Property

    Property Get read_RGM_CTRL
        read
        read_RGM_CTRL = read_RGM_CTRL_value
    End Property

    Property Let write_RGM_CTRL(aData)
        set_RGM_CTRL = aData
        write
    End Property

    Property Get get_OSC_ADJ
        get_OSC_ADJ = read_OSC_ADJ_value
    End Property

    Property Let set_OSC_ADJ(aData)
        write_OSC_ADJ_value = aData
        flag_OSC_ADJ        = &H1
    End Property

    Property Get read_OSC_ADJ
        read
        read_OSC_ADJ = read_OSC_ADJ_value
    End Property

    Property Let write_OSC_ADJ(aData)
        set_OSC_ADJ = aData
        write
    End Property

    Property Get get_phase_cntrl_en
        get_phase_cntrl_en = read_phase_cntrl_en_value
    End Property

    Property Let set_phase_cntrl_en(aData)
        write_phase_cntrl_en_value = aData
        flag_phase_cntrl_en        = &H1
    End Property

    Property Get read_phase_cntrl_en
        read
        read_phase_cntrl_en = read_phase_cntrl_en_value
    End Property

    Property Let write_phase_cntrl_en(aData)
        set_phase_cntrl_en = aData
        write
    End Property

    Property Get get_GMBIAS_CTRL
        get_GMBIAS_CTRL = read_GMBIAS_CTRL_value
    End Property

    Property Let set_GMBIAS_CTRL(aData)
        write_GMBIAS_CTRL_value = aData
        flag_GMBIAS_CTRL        = &H1
    End Property

    Property Get read_GMBIAS_CTRL
        read
        read_GMBIAS_CTRL = read_GMBIAS_CTRL_value
    End Property

    Property Let write_GMBIAS_CTRL(aData)
        set_GMBIAS_CTRL = aData
        write
    End Property

    Property Get get_phase_cntrl_comp_width
        get_phase_cntrl_comp_width = read_phase_cntrl_comp_width_value
    End Property

    Property Let set_phase_cntrl_comp_width(aData)
        write_phase_cntrl_comp_width_value = aData
        flag_phase_cntrl_comp_width        = &H1
    End Property

    Property Get read_phase_cntrl_comp_width
        read
        read_phase_cntrl_comp_width = read_phase_cntrl_comp_width_value
    End Property

    Property Let write_phase_cntrl_comp_width(aData)
        set_phase_cntrl_comp_width = aData
        write
    End Property

    Property Get get_IVCO_CTRL
        get_IVCO_CTRL = read_IVCO_CTRL_value
    End Property

    Property Let set_IVCO_CTRL(aData)
        write_IVCO_CTRL_value = aData
        flag_IVCO_CTRL        = &H1
    End Property

    Property Get read_IVCO_CTRL
        read
        read_IVCO_CTRL = read_IVCO_CTRL_value
    End Property

    Property Let write_IVCO_CTRL(aData)
        set_IVCO_CTRL = aData
        write
    End Property

    Property Get get_burst_d_ctrl_6_3
        get_burst_d_ctrl_6_3 = read_burst_d_ctrl_6_3_value
    End Property

    Property Let set_burst_d_ctrl_6_3(aData)
        write_burst_d_ctrl_6_3_value = aData
        flag_burst_d_ctrl_6_3        = &H1
    End Property

    Property Get read_burst_d_ctrl_6_3
        read
        read_burst_d_ctrl_6_3 = read_burst_d_ctrl_6_3_value
    End Property

    Property Let write_burst_d_ctrl_6_3(aData)
        set_burst_d_ctrl_6_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGM_CTRL_mask = &H7
        if data_low > LONG_MAX then
            if RGM_CTRL_mask = mask then
                read_RGM_CTRL_value = data_low
            else
                read_RGM_CTRL_value = (data_low - H8000_0000) and RGM_CTRL_mask
            end If
        else
            read_RGM_CTRL_value = data_low and RGM_CTRL_mask
        end If
        read_OSC_ADJ_value = rightShift(data_low, 3) and &H7
        read_phase_cntrl_en_value = rightShift(data_low, 6) and &H1
        read_GMBIAS_CTRL_value = rightShift(data_low, 7) and &H1
        read_phase_cntrl_comp_width_value = rightShift(data_low, 8) and &H1
        read_IVCO_CTRL_value = rightShift(data_low, 9) and &H7
        read_burst_d_ctrl_6_3_value = rightShift(data_low, 12) and &Hf

    End Sub

    Sub write
        If flag_RGM_CTRL = &H0 or flag_OSC_ADJ = &H0 or flag_phase_cntrl_en = &H0 or flag_GMBIAS_CTRL = &H0 or flag_phase_cntrl_comp_width = &H0 or flag_IVCO_CTRL = &H0 or flag_burst_d_ctrl_6_3 = &H0 Then read
        If flag_RGM_CTRL = &H0 Then write_RGM_CTRL_value = get_RGM_CTRL
        If flag_OSC_ADJ = &H0 Then write_OSC_ADJ_value = get_OSC_ADJ
        If flag_phase_cntrl_en = &H0 Then write_phase_cntrl_en_value = get_phase_cntrl_en
        If flag_GMBIAS_CTRL = &H0 Then write_GMBIAS_CTRL_value = get_GMBIAS_CTRL
        If flag_phase_cntrl_comp_width = &H0 Then write_phase_cntrl_comp_width_value = get_phase_cntrl_comp_width
        If flag_IVCO_CTRL = &H0 Then write_IVCO_CTRL_value = get_IVCO_CTRL
        If flag_burst_d_ctrl_6_3 = &H0 Then write_burst_d_ctrl_6_3_value = get_burst_d_ctrl_6_3

        regValue = leftShift((write_RGM_CTRL_value and &H7), 0) + leftShift((write_OSC_ADJ_value and &H7), 3) + leftShift((write_phase_cntrl_en_value and &H1), 6) + leftShift((write_GMBIAS_CTRL_value and &H1), 7) + leftShift((write_phase_cntrl_comp_width_value and &H1), 8) + leftShift((write_IVCO_CTRL_value and &H7), 9) + leftShift((write_burst_d_ctrl_6_3_value and &Hf), 12)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RGM_CTRL_mask = &H7
        if data_low > LONG_MAX then
            if RGM_CTRL_mask = mask then
                read_RGM_CTRL_value = data_low
            else
                read_RGM_CTRL_value = (data_low - H8000_0000) and RGM_CTRL_mask
            end If
        else
            read_RGM_CTRL_value = data_low and RGM_CTRL_mask
        end If
        read_OSC_ADJ_value = rightShift(data_low, 3) and &H7
        read_phase_cntrl_en_value = rightShift(data_low, 6) and &H1
        read_GMBIAS_CTRL_value = rightShift(data_low, 7) and &H1
        read_phase_cntrl_comp_width_value = rightShift(data_low, 8) and &H1
        read_IVCO_CTRL_value = rightShift(data_low, 9) and &H7
        read_burst_d_ctrl_6_3_value = rightShift(data_low, 12) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RGM_CTRL_value = &H0
        flag_RGM_CTRL        = &H0
        write_OSC_ADJ_value = &H0
        flag_OSC_ADJ        = &H0
        write_phase_cntrl_en_value = &H0
        flag_phase_cntrl_en        = &H0
        write_GMBIAS_CTRL_value = &H0
        flag_GMBIAS_CTRL        = &H0
        write_phase_cntrl_comp_width_value = &H0
        flag_phase_cntrl_comp_width        = &H0
        write_IVCO_CTRL_value = &H0
        flag_IVCO_CTRL        = &H0
        write_burst_d_ctrl_6_3_value = &H0
        flag_burst_d_ctrl_6_3        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_ctrl_reg9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Test_mode_ADC                              [0:0]            get_Test_mode_ADC
''                                                             set_Test_mode_ADC
''                                                             read_Test_mode_ADC
''                                                             write_Test_mode_ADC
''---------------------------------------------------------------------------------
'' Test_mode_Vbg                              [1:1]            get_Test_mode_Vbg
''                                                             set_Test_mode_Vbg
''                                                             read_Test_mode_Vbg
''                                                             write_Test_mode_Vbg
''---------------------------------------------------------------------------------
'' OVERCUR_REF_CTRL                           [3:2]            get_OVERCUR_REF_CTRL
''                                                             set_OVERCUR_REF_CTRL
''                                                             read_OVERCUR_REF_CTRL
''                                                             write_OVERCUR_REF_CTRL
''---------------------------------------------------------------------------------
'' adaptive_deadtime_dis                      [4:4]            get_adaptive_deadtime_dis
''                                                             set_adaptive_deadtime_dis
''                                                             read_adaptive_deadtime_dis
''                                                             write_adaptive_deadtime_dis
''---------------------------------------------------------------------------------
'' adaptive_deadtime_CTRL                     [6:5]            get_adaptive_deadtime_CTRL
''                                                             set_adaptive_deadtime_CTRL
''                                                             read_adaptive_deadtime_CTRL
''                                                             write_adaptive_deadtime_CTRL
''---------------------------------------------------------------------------------
'' non_linear_gain                            [8:8]            get_non_linear_gain
''                                                             set_non_linear_gain
''                                                             read_non_linear_gain
''                                                             write_non_linear_gain
''---------------------------------------------------------------------------------
'' non_linear_gain_en                         [9:9]            get_non_linear_gain_en
''                                                             set_non_linear_gain_en
''                                                             read_non_linear_gain_en
''                                                             write_non_linear_gain_en
''---------------------------------------------------------------------------------
'' adc_gain                                   [11:10]          get_adc_gain
''                                                             set_adc_gain
''                                                             read_adc_gain
''                                                             write_adc_gain
''---------------------------------------------------------------------------------
'' sys_clk_freq                               [13:12]          get_sys_clk_freq
''                                                             set_sys_clk_freq
''                                                             read_sys_clk_freq
''                                                             write_sys_clk_freq
''---------------------------------------------------------------------------------
'' adc_freq                                   [15:14]          get_adc_freq
''                                                             set_adc_freq
''                                                             read_adc_freq
''                                                             write_adc_freq
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_ctrl_reg9
    Private write_Test_mode_ADC_value
    Private read_Test_mode_ADC_value
    Private flag_Test_mode_ADC
    Private write_Test_mode_Vbg_value
    Private read_Test_mode_Vbg_value
    Private flag_Test_mode_Vbg
    Private write_OVERCUR_REF_CTRL_value
    Private read_OVERCUR_REF_CTRL_value
    Private flag_OVERCUR_REF_CTRL
    Private write_adaptive_deadtime_dis_value
    Private read_adaptive_deadtime_dis_value
    Private flag_adaptive_deadtime_dis
    Private write_adaptive_deadtime_CTRL_value
    Private read_adaptive_deadtime_CTRL_value
    Private flag_adaptive_deadtime_CTRL
    Private write_non_linear_gain_value
    Private read_non_linear_gain_value
    Private flag_non_linear_gain
    Private write_non_linear_gain_en_value
    Private read_non_linear_gain_en_value
    Private flag_non_linear_gain_en
    Private write_adc_gain_value
    Private read_adc_gain_value
    Private flag_adc_gain
    Private write_sys_clk_freq_value
    Private read_sys_clk_freq_value
    Private flag_sys_clk_freq
    Private write_adc_freq_value
    Private read_adc_freq_value
    Private flag_adc_freq

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H122
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Test_mode_ADC
        get_Test_mode_ADC = read_Test_mode_ADC_value
    End Property

    Property Let set_Test_mode_ADC(aData)
        write_Test_mode_ADC_value = aData
        flag_Test_mode_ADC        = &H1
    End Property

    Property Get read_Test_mode_ADC
        read
        read_Test_mode_ADC = read_Test_mode_ADC_value
    End Property

    Property Let write_Test_mode_ADC(aData)
        set_Test_mode_ADC = aData
        write
    End Property

    Property Get get_Test_mode_Vbg
        get_Test_mode_Vbg = read_Test_mode_Vbg_value
    End Property

    Property Let set_Test_mode_Vbg(aData)
        write_Test_mode_Vbg_value = aData
        flag_Test_mode_Vbg        = &H1
    End Property

    Property Get read_Test_mode_Vbg
        read
        read_Test_mode_Vbg = read_Test_mode_Vbg_value
    End Property

    Property Let write_Test_mode_Vbg(aData)
        set_Test_mode_Vbg = aData
        write
    End Property

    Property Get get_OVERCUR_REF_CTRL
        get_OVERCUR_REF_CTRL = read_OVERCUR_REF_CTRL_value
    End Property

    Property Let set_OVERCUR_REF_CTRL(aData)
        write_OVERCUR_REF_CTRL_value = aData
        flag_OVERCUR_REF_CTRL        = &H1
    End Property

    Property Get read_OVERCUR_REF_CTRL
        read
        read_OVERCUR_REF_CTRL = read_OVERCUR_REF_CTRL_value
    End Property

    Property Let write_OVERCUR_REF_CTRL(aData)
        set_OVERCUR_REF_CTRL = aData
        write
    End Property

    Property Get get_adaptive_deadtime_dis
        get_adaptive_deadtime_dis = read_adaptive_deadtime_dis_value
    End Property

    Property Let set_adaptive_deadtime_dis(aData)
        write_adaptive_deadtime_dis_value = aData
        flag_adaptive_deadtime_dis        = &H1
    End Property

    Property Get read_adaptive_deadtime_dis
        read
        read_adaptive_deadtime_dis = read_adaptive_deadtime_dis_value
    End Property

    Property Let write_adaptive_deadtime_dis(aData)
        set_adaptive_deadtime_dis = aData
        write
    End Property

    Property Get get_adaptive_deadtime_CTRL
        get_adaptive_deadtime_CTRL = read_adaptive_deadtime_CTRL_value
    End Property

    Property Let set_adaptive_deadtime_CTRL(aData)
        write_adaptive_deadtime_CTRL_value = aData
        flag_adaptive_deadtime_CTRL        = &H1
    End Property

    Property Get read_adaptive_deadtime_CTRL
        read
        read_adaptive_deadtime_CTRL = read_adaptive_deadtime_CTRL_value
    End Property

    Property Let write_adaptive_deadtime_CTRL(aData)
        set_adaptive_deadtime_CTRL = aData
        write
    End Property

    Property Get get_non_linear_gain
        get_non_linear_gain = read_non_linear_gain_value
    End Property

    Property Let set_non_linear_gain(aData)
        write_non_linear_gain_value = aData
        flag_non_linear_gain        = &H1
    End Property

    Property Get read_non_linear_gain
        read
        read_non_linear_gain = read_non_linear_gain_value
    End Property

    Property Let write_non_linear_gain(aData)
        set_non_linear_gain = aData
        write
    End Property

    Property Get get_non_linear_gain_en
        get_non_linear_gain_en = read_non_linear_gain_en_value
    End Property

    Property Let set_non_linear_gain_en(aData)
        write_non_linear_gain_en_value = aData
        flag_non_linear_gain_en        = &H1
    End Property

    Property Get read_non_linear_gain_en
        read
        read_non_linear_gain_en = read_non_linear_gain_en_value
    End Property

    Property Let write_non_linear_gain_en(aData)
        set_non_linear_gain_en = aData
        write
    End Property

    Property Get get_adc_gain
        get_adc_gain = read_adc_gain_value
    End Property

    Property Let set_adc_gain(aData)
        write_adc_gain_value = aData
        flag_adc_gain        = &H1
    End Property

    Property Get read_adc_gain
        read
        read_adc_gain = read_adc_gain_value
    End Property

    Property Let write_adc_gain(aData)
        set_adc_gain = aData
        write
    End Property

    Property Get get_sys_clk_freq
        get_sys_clk_freq = read_sys_clk_freq_value
    End Property

    Property Let set_sys_clk_freq(aData)
        write_sys_clk_freq_value = aData
        flag_sys_clk_freq        = &H1
    End Property

    Property Get read_sys_clk_freq
        read
        read_sys_clk_freq = read_sys_clk_freq_value
    End Property

    Property Let write_sys_clk_freq(aData)
        set_sys_clk_freq = aData
        write
    End Property

    Property Get get_adc_freq
        get_adc_freq = read_adc_freq_value
    End Property

    Property Let set_adc_freq(aData)
        write_adc_freq_value = aData
        flag_adc_freq        = &H1
    End Property

    Property Get read_adc_freq
        read
        read_adc_freq = read_adc_freq_value
    End Property

    Property Let write_adc_freq(aData)
        set_adc_freq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Test_mode_ADC_mask = &H1
        if data_low > LONG_MAX then
            if Test_mode_ADC_mask = mask then
                read_Test_mode_ADC_value = data_low
            else
                read_Test_mode_ADC_value = (data_low - H8000_0000) and Test_mode_ADC_mask
            end If
        else
            read_Test_mode_ADC_value = data_low and Test_mode_ADC_mask
        end If
        read_Test_mode_Vbg_value = rightShift(data_low, 1) and &H1
        read_OVERCUR_REF_CTRL_value = rightShift(data_low, 2) and &H3
        read_adaptive_deadtime_dis_value = rightShift(data_low, 4) and &H1
        read_adaptive_deadtime_CTRL_value = rightShift(data_low, 5) and &H3
        read_non_linear_gain_value = rightShift(data_low, 8) and &H1
        read_non_linear_gain_en_value = rightShift(data_low, 9) and &H1
        read_adc_gain_value = rightShift(data_low, 10) and &H3
        read_sys_clk_freq_value = rightShift(data_low, 12) and &H3
        read_adc_freq_value = rightShift(data_low, 14) and &H3

    End Sub

    Sub write
        If flag_Test_mode_ADC = &H0 or flag_Test_mode_Vbg = &H0 or flag_OVERCUR_REF_CTRL = &H0 or flag_adaptive_deadtime_dis = &H0 or flag_adaptive_deadtime_CTRL = &H0 or flag_non_linear_gain = &H0 or flag_non_linear_gain_en = &H0 or flag_adc_gain = &H0 or flag_sys_clk_freq = &H0 or flag_adc_freq = &H0 Then read
        If flag_Test_mode_ADC = &H0 Then write_Test_mode_ADC_value = get_Test_mode_ADC
        If flag_Test_mode_Vbg = &H0 Then write_Test_mode_Vbg_value = get_Test_mode_Vbg
        If flag_OVERCUR_REF_CTRL = &H0 Then write_OVERCUR_REF_CTRL_value = get_OVERCUR_REF_CTRL
        If flag_adaptive_deadtime_dis = &H0 Then write_adaptive_deadtime_dis_value = get_adaptive_deadtime_dis
        If flag_adaptive_deadtime_CTRL = &H0 Then write_adaptive_deadtime_CTRL_value = get_adaptive_deadtime_CTRL
        If flag_non_linear_gain = &H0 Then write_non_linear_gain_value = get_non_linear_gain
        If flag_non_linear_gain_en = &H0 Then write_non_linear_gain_en_value = get_non_linear_gain_en
        If flag_adc_gain = &H0 Then write_adc_gain_value = get_adc_gain
        If flag_sys_clk_freq = &H0 Then write_sys_clk_freq_value = get_sys_clk_freq
        If flag_adc_freq = &H0 Then write_adc_freq_value = get_adc_freq

        regValue = leftShift((write_Test_mode_ADC_value and &H1), 0) + leftShift((write_Test_mode_Vbg_value and &H1), 1) + leftShift((write_OVERCUR_REF_CTRL_value and &H3), 2) + leftShift((write_adaptive_deadtime_dis_value and &H1), 4) + leftShift((write_adaptive_deadtime_CTRL_value and &H3), 5) + leftShift((write_non_linear_gain_value and &H1), 8) + leftShift((write_non_linear_gain_en_value and &H1), 9) + leftShift((write_adc_gain_value and &H3), 10) + leftShift((write_sys_clk_freq_value and &H3), 12) + leftShift((write_adc_freq_value and &H3), 14)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Test_mode_ADC_mask = &H1
        if data_low > LONG_MAX then
            if Test_mode_ADC_mask = mask then
                read_Test_mode_ADC_value = data_low
            else
                read_Test_mode_ADC_value = (data_low - H8000_0000) and Test_mode_ADC_mask
            end If
        else
            read_Test_mode_ADC_value = data_low and Test_mode_ADC_mask
        end If
        read_Test_mode_Vbg_value = rightShift(data_low, 1) and &H1
        read_OVERCUR_REF_CTRL_value = rightShift(data_low, 2) and &H3
        read_adaptive_deadtime_dis_value = rightShift(data_low, 4) and &H1
        read_adaptive_deadtime_CTRL_value = rightShift(data_low, 5) and &H3
        read_non_linear_gain_value = rightShift(data_low, 8) and &H1
        read_non_linear_gain_en_value = rightShift(data_low, 9) and &H1
        read_adc_gain_value = rightShift(data_low, 10) and &H3
        read_sys_clk_freq_value = rightShift(data_low, 12) and &H3
        read_adc_freq_value = rightShift(data_low, 14) and &H3

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Test_mode_ADC_value = &H0
        flag_Test_mode_ADC        = &H0
        write_Test_mode_Vbg_value = &H0
        flag_Test_mode_Vbg        = &H0
        write_OVERCUR_REF_CTRL_value = &H0
        flag_OVERCUR_REF_CTRL        = &H0
        write_adaptive_deadtime_dis_value = &H0
        flag_adaptive_deadtime_dis        = &H0
        write_adaptive_deadtime_CTRL_value = &H0
        flag_adaptive_deadtime_CTRL        = &H0
        write_non_linear_gain_value = &H0
        flag_non_linear_gain        = &H0
        write_non_linear_gain_en_value = &H0
        flag_non_linear_gain_en        = &H0
        write_adc_gain_value = &H0
        flag_adc_gain        = &H0
        write_sys_clk_freq_value = &H0
        flag_sys_clk_freq        = &H0
        write_adc_freq_value = &H0
        flag_adc_freq        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_stat_reg12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' adc_comp_in                                [7:0]            get_adc_comp_in
''                                                             set_adc_comp_in
''                                                             read_adc_comp_in
''                                                             write_adc_comp_in
''---------------------------------------------------------------------------------
'' duty_cycle                                 [8:8]            get_duty_cycle
''                                                             set_duty_cycle
''                                                             read_duty_cycle
''                                                             write_duty_cycle
''---------------------------------------------------------------------------------
'' undervoltage_fault                         [9:9]            get_undervoltage_fault
''                                                             set_undervoltage_fault
''                                                             read_undervoltage_fault
''                                                             write_undervoltage_fault
''---------------------------------------------------------------------------------
'' overvoltage_fault                          [11:11]          get_overvoltage_fault
''                                                             set_overvoltage_fault
''                                                             read_overvoltage_fault
''                                                             write_overvoltage_fault
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_stat_reg12
    Private write_adc_comp_in_value
    Private read_adc_comp_in_value
    Private flag_adc_comp_in
    Private write_duty_cycle_value
    Private read_duty_cycle_value
    Private flag_duty_cycle
    Private write_undervoltage_fault_value
    Private read_undervoltage_fault_value
    Private flag_undervoltage_fault
    Private write_overvoltage_fault_value
    Private read_overvoltage_fault_value
    Private flag_overvoltage_fault

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H124
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_adc_comp_in
        get_adc_comp_in = read_adc_comp_in_value
    End Property

    Property Let set_adc_comp_in(aData)
        write_adc_comp_in_value = aData
        flag_adc_comp_in        = &H1
    End Property

    Property Get read_adc_comp_in
        read
        read_adc_comp_in = read_adc_comp_in_value
    End Property

    Property Let write_adc_comp_in(aData)
        set_adc_comp_in = aData
        write
    End Property

    Property Get get_duty_cycle
        get_duty_cycle = read_duty_cycle_value
    End Property

    Property Let set_duty_cycle(aData)
        write_duty_cycle_value = aData
        flag_duty_cycle        = &H1
    End Property

    Property Get read_duty_cycle
        read
        read_duty_cycle = read_duty_cycle_value
    End Property

    Property Let write_duty_cycle(aData)
        set_duty_cycle = aData
        write
    End Property

    Property Get get_undervoltage_fault
        get_undervoltage_fault = read_undervoltage_fault_value
    End Property

    Property Let set_undervoltage_fault(aData)
        write_undervoltage_fault_value = aData
        flag_undervoltage_fault        = &H1
    End Property

    Property Get read_undervoltage_fault
        read
        read_undervoltage_fault = read_undervoltage_fault_value
    End Property

    Property Let write_undervoltage_fault(aData)
        set_undervoltage_fault = aData
        write
    End Property

    Property Get get_overvoltage_fault
        get_overvoltage_fault = read_overvoltage_fault_value
    End Property

    Property Let set_overvoltage_fault(aData)
        write_overvoltage_fault_value = aData
        flag_overvoltage_fault        = &H1
    End Property

    Property Get read_overvoltage_fault
        read
        read_overvoltage_fault = read_overvoltage_fault_value
    End Property

    Property Let write_overvoltage_fault(aData)
        set_overvoltage_fault = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        adc_comp_in_mask = &Hff
        if data_low > LONG_MAX then
            if adc_comp_in_mask = mask then
                read_adc_comp_in_value = data_low
            else
                read_adc_comp_in_value = (data_low - H8000_0000) and adc_comp_in_mask
            end If
        else
            read_adc_comp_in_value = data_low and adc_comp_in_mask
        end If
        read_duty_cycle_value = rightShift(data_low, 8) and &H1
        read_undervoltage_fault_value = rightShift(data_low, 9) and &H1
        read_overvoltage_fault_value = rightShift(data_low, 11) and &H1

    End Sub

    Sub write
        If flag_adc_comp_in = &H0 or flag_duty_cycle = &H0 or flag_undervoltage_fault = &H0 or flag_overvoltage_fault = &H0 Then read
        If flag_adc_comp_in = &H0 Then write_adc_comp_in_value = get_adc_comp_in
        If flag_duty_cycle = &H0 Then write_duty_cycle_value = get_duty_cycle
        If flag_undervoltage_fault = &H0 Then write_undervoltage_fault_value = get_undervoltage_fault
        If flag_overvoltage_fault = &H0 Then write_overvoltage_fault_value = get_overvoltage_fault

        regValue = leftShift((write_adc_comp_in_value and &Hff), 0) + leftShift((write_duty_cycle_value and &H1), 8) + leftShift((write_undervoltage_fault_value and &H1), 9) + leftShift((write_overvoltage_fault_value and &H1), 11)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        adc_comp_in_mask = &Hff
        if data_low > LONG_MAX then
            if adc_comp_in_mask = mask then
                read_adc_comp_in_value = data_low
            else
                read_adc_comp_in_value = (data_low - H8000_0000) and adc_comp_in_mask
            end If
        else
            read_adc_comp_in_value = data_low and adc_comp_in_mask
        end If
        read_duty_cycle_value = rightShift(data_low, 8) and &H1
        read_undervoltage_fault_value = rightShift(data_low, 9) and &H1
        read_overvoltage_fault_value = rightShift(data_low, 11) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_adc_comp_in_value = &H0
        flag_adc_comp_in        = &H0
        write_duty_cycle_value = &H0
        flag_duty_cycle        = &H0
        write_undervoltage_fault_value = &H0
        flag_undervoltage_fault        = &H0
        write_overvoltage_fault_value = &H0
        flag_overvoltage_fault        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_stat_reg13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ilim_dutycycle                             [9:0]            get_ilim_dutycycle
''                                                             set_ilim_dutycycle
''                                                             read_ilim_dutycycle
''                                                             write_ilim_dutycycle
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_stat_reg13
    Private write_ilim_dutycycle_value
    Private read_ilim_dutycycle_value
    Private flag_ilim_dutycycle

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H126
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ilim_dutycycle
        get_ilim_dutycycle = read_ilim_dutycycle_value
    End Property

    Property Let set_ilim_dutycycle(aData)
        write_ilim_dutycycle_value = aData
        flag_ilim_dutycycle        = &H1
    End Property

    Property Get read_ilim_dutycycle
        read
        read_ilim_dutycycle = read_ilim_dutycycle_value
    End Property

    Property Let write_ilim_dutycycle(aData)
        set_ilim_dutycycle = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ilim_dutycycle_mask = &H3ff
        if data_low > LONG_MAX then
            if ilim_dutycycle_mask = mask then
                read_ilim_dutycycle_value = data_low
            else
                read_ilim_dutycycle_value = (data_low - H8000_0000) and ilim_dutycycle_mask
            end If
        else
            read_ilim_dutycycle_value = data_low and ilim_dutycycle_mask
        end If

    End Sub

    Sub write
        If flag_ilim_dutycycle = &H0 Then read
        If flag_ilim_dutycycle = &H0 Then write_ilim_dutycycle_value = get_ilim_dutycycle

        regValue = leftShift((write_ilim_dutycycle_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ilim_dutycycle_mask = &H3ff
        if data_low > LONG_MAX then
            if ilim_dutycycle_mask = mask then
                read_ilim_dutycycle_value = data_low
            else
                read_ilim_dutycycle_value = (data_low - H8000_0000) and ilim_dutycycle_mask
            end If
        else
            read_ilim_dutycycle_value = data_low and ilim_dutycycle_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ilim_dutycycle_value = &H0
        flag_ilim_dutycycle        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_stat_reg14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ilim_adcout                                [10:0]           get_ilim_adcout
''                                                             set_ilim_adcout
''                                                             read_ilim_adcout
''                                                             write_ilim_adcout
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_stat_reg14
    Private write_ilim_adcout_value
    Private read_ilim_adcout_value
    Private flag_ilim_adcout

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H128
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ilim_adcout
        get_ilim_adcout = read_ilim_adcout_value
    End Property

    Property Let set_ilim_adcout(aData)
        write_ilim_adcout_value = aData
        flag_ilim_adcout        = &H1
    End Property

    Property Get read_ilim_adcout
        read
        read_ilim_adcout = read_ilim_adcout_value
    End Property

    Property Let write_ilim_adcout(aData)
        set_ilim_adcout = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ilim_adcout_mask = &H7ff
        if data_low > LONG_MAX then
            if ilim_adcout_mask = mask then
                read_ilim_adcout_value = data_low
            else
                read_ilim_adcout_value = (data_low - H8000_0000) and ilim_adcout_mask
            end If
        else
            read_ilim_adcout_value = data_low and ilim_adcout_mask
        end If

    End Sub

    Sub write
        If flag_ilim_adcout = &H0 Then read
        If flag_ilim_adcout = &H0 Then write_ilim_adcout_value = get_ilim_adcout

        regValue = leftShift((write_ilim_adcout_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ilim_adcout_mask = &H7ff
        if data_low > LONG_MAX then
            if ilim_adcout_mask = mask then
                read_ilim_adcout_value = data_low
            else
                read_ilim_adcout_value = (data_low - H8000_0000) and ilim_adcout_mask
            end If
        else
            read_ilim_adcout_value = data_low and ilim_adcout_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ilim_adcout_value = &H0
        flag_ilim_adcout        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_stat_reg15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ana_curr_limit                             [0:0]            get_ana_curr_limit
''                                                             set_ana_curr_limit
''                                                             read_ana_curr_limit
''                                                             write_ana_curr_limit
''---------------------------------------------------------------------------------
'' pvin_select_1P5                            [2:1]            get_pvin_select_1P5
''                                                             set_pvin_select_1P5
''                                                             read_pvin_select_1P5
''                                                             write_pvin_select_1P5
''---------------------------------------------------------------------------------
'' vin_select_1P5                             [4:3]            get_vin_select_1P5
''                                                             set_vin_select_1P5
''                                                             read_vin_select_1P5
''                                                             write_vin_select_1P5
''---------------------------------------------------------------------------------
'' dig_duty_cycle_curr_limit_fault            [13:13]          get_dig_duty_cycle_curr_limit_fault
''                                                             set_dig_duty_cycle_curr_limit_fault
''                                                             read_dig_duty_cycle_curr_limit_fault
''                                                             write_dig_duty_cycle_curr_limit_fault
''---------------------------------------------------------------------------------
'' dig_uv_fault                               [14:14]          get_dig_uv_fault
''                                                             set_dig_uv_fault
''                                                             read_dig_uv_fault
''                                                             write_dig_uv_fault
''---------------------------------------------------------------------------------
'' dig_ov_fault                               [15:15]          get_dig_ov_fault
''                                                             set_dig_ov_fault
''                                                             read_dig_ov_fault
''                                                             write_dig_ov_fault
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_stat_reg15
    Private write_ana_curr_limit_value
    Private read_ana_curr_limit_value
    Private flag_ana_curr_limit
    Private write_pvin_select_1P5_value
    Private read_pvin_select_1P5_value
    Private flag_pvin_select_1P5
    Private write_vin_select_1P5_value
    Private read_vin_select_1P5_value
    Private flag_vin_select_1P5
    Private write_dig_duty_cycle_curr_limit_fault_value
    Private read_dig_duty_cycle_curr_limit_fault_value
    Private flag_dig_duty_cycle_curr_limit_fault
    Private write_dig_uv_fault_value
    Private read_dig_uv_fault_value
    Private flag_dig_uv_fault
    Private write_dig_ov_fault_value
    Private read_dig_ov_fault_value
    Private flag_dig_ov_fault

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ana_curr_limit
        get_ana_curr_limit = read_ana_curr_limit_value
    End Property

    Property Let set_ana_curr_limit(aData)
        write_ana_curr_limit_value = aData
        flag_ana_curr_limit        = &H1
    End Property

    Property Get read_ana_curr_limit
        read
        read_ana_curr_limit = read_ana_curr_limit_value
    End Property

    Property Let write_ana_curr_limit(aData)
        set_ana_curr_limit = aData
        write
    End Property

    Property Get get_pvin_select_1P5
        get_pvin_select_1P5 = read_pvin_select_1P5_value
    End Property

    Property Let set_pvin_select_1P5(aData)
        write_pvin_select_1P5_value = aData
        flag_pvin_select_1P5        = &H1
    End Property

    Property Get read_pvin_select_1P5
        read
        read_pvin_select_1P5 = read_pvin_select_1P5_value
    End Property

    Property Let write_pvin_select_1P5(aData)
        set_pvin_select_1P5 = aData
        write
    End Property

    Property Get get_vin_select_1P5
        get_vin_select_1P5 = read_vin_select_1P5_value
    End Property

    Property Let set_vin_select_1P5(aData)
        write_vin_select_1P5_value = aData
        flag_vin_select_1P5        = &H1
    End Property

    Property Get read_vin_select_1P5
        read
        read_vin_select_1P5 = read_vin_select_1P5_value
    End Property

    Property Let write_vin_select_1P5(aData)
        set_vin_select_1P5 = aData
        write
    End Property

    Property Get get_dig_duty_cycle_curr_limit_fault
        get_dig_duty_cycle_curr_limit_fault = read_dig_duty_cycle_curr_limit_fault_value
    End Property

    Property Let set_dig_duty_cycle_curr_limit_fault(aData)
        write_dig_duty_cycle_curr_limit_fault_value = aData
        flag_dig_duty_cycle_curr_limit_fault        = &H1
    End Property

    Property Get read_dig_duty_cycle_curr_limit_fault
        read
        read_dig_duty_cycle_curr_limit_fault = read_dig_duty_cycle_curr_limit_fault_value
    End Property

    Property Let write_dig_duty_cycle_curr_limit_fault(aData)
        set_dig_duty_cycle_curr_limit_fault = aData
        write
    End Property

    Property Get get_dig_uv_fault
        get_dig_uv_fault = read_dig_uv_fault_value
    End Property

    Property Let set_dig_uv_fault(aData)
        write_dig_uv_fault_value = aData
        flag_dig_uv_fault        = &H1
    End Property

    Property Get read_dig_uv_fault
        read
        read_dig_uv_fault = read_dig_uv_fault_value
    End Property

    Property Let write_dig_uv_fault(aData)
        set_dig_uv_fault = aData
        write
    End Property

    Property Get get_dig_ov_fault
        get_dig_ov_fault = read_dig_ov_fault_value
    End Property

    Property Let set_dig_ov_fault(aData)
        write_dig_ov_fault_value = aData
        flag_dig_ov_fault        = &H1
    End Property

    Property Get read_dig_ov_fault
        read
        read_dig_ov_fault = read_dig_ov_fault_value
    End Property

    Property Let write_dig_ov_fault(aData)
        set_dig_ov_fault = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_curr_limit_mask = &H1
        if data_low > LONG_MAX then
            if ana_curr_limit_mask = mask then
                read_ana_curr_limit_value = data_low
            else
                read_ana_curr_limit_value = (data_low - H8000_0000) and ana_curr_limit_mask
            end If
        else
            read_ana_curr_limit_value = data_low and ana_curr_limit_mask
        end If
        read_pvin_select_1P5_value = rightShift(data_low, 1) and &H3
        read_vin_select_1P5_value = rightShift(data_low, 3) and &H3
        read_dig_duty_cycle_curr_limit_fault_value = rightShift(data_low, 13) and &H1
        read_dig_uv_fault_value = rightShift(data_low, 14) and &H1
        read_dig_ov_fault_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_ana_curr_limit = &H0 or flag_pvin_select_1P5 = &H0 or flag_vin_select_1P5 = &H0 or flag_dig_duty_cycle_curr_limit_fault = &H0 or flag_dig_uv_fault = &H0 or flag_dig_ov_fault = &H0 Then read
        If flag_ana_curr_limit = &H0 Then write_ana_curr_limit_value = get_ana_curr_limit
        If flag_pvin_select_1P5 = &H0 Then write_pvin_select_1P5_value = get_pvin_select_1P5
        If flag_vin_select_1P5 = &H0 Then write_vin_select_1P5_value = get_vin_select_1P5
        If flag_dig_duty_cycle_curr_limit_fault = &H0 Then write_dig_duty_cycle_curr_limit_fault_value = get_dig_duty_cycle_curr_limit_fault
        If flag_dig_uv_fault = &H0 Then write_dig_uv_fault_value = get_dig_uv_fault
        If flag_dig_ov_fault = &H0 Then write_dig_ov_fault_value = get_dig_ov_fault

        regValue = leftShift((write_ana_curr_limit_value and &H1), 0) + leftShift((write_pvin_select_1P5_value and &H3), 1) + leftShift((write_vin_select_1P5_value and &H3), 3) + leftShift((write_dig_duty_cycle_curr_limit_fault_value and &H1), 13) + leftShift((write_dig_uv_fault_value and &H1), 14) + leftShift((write_dig_ov_fault_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ana_curr_limit_mask = &H1
        if data_low > LONG_MAX then
            if ana_curr_limit_mask = mask then
                read_ana_curr_limit_value = data_low
            else
                read_ana_curr_limit_value = (data_low - H8000_0000) and ana_curr_limit_mask
            end If
        else
            read_ana_curr_limit_value = data_low and ana_curr_limit_mask
        end If
        read_pvin_select_1P5_value = rightShift(data_low, 1) and &H3
        read_vin_select_1P5_value = rightShift(data_low, 3) and &H3
        read_dig_duty_cycle_curr_limit_fault_value = rightShift(data_low, 13) and &H1
        read_dig_uv_fault_value = rightShift(data_low, 14) and &H1
        read_dig_ov_fault_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ana_curr_limit_value = &H0
        flag_ana_curr_limit        = &H0
        write_pvin_select_1P5_value = &H0
        flag_pvin_select_1P5        = &H0
        write_vin_select_1P5_value = &H0
        flag_vin_select_1P5        = &H0
        write_dig_duty_cycle_curr_limit_fault_value = &H0
        flag_dig_duty_cycle_curr_limit_fault        = &H0
        write_dig_uv_fault_value = &H0
        flag_dig_uv_fault        = &H0
        write_dig_ov_fault_value = &H0
        flag_dig_ov_fault        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_access_ctrl_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_9                         [9:9]            get_swreg_write_ctrl_9
''                                                             set_swreg_write_ctrl_9
''                                                             read_swreg_write_ctrl_9
''                                                             write_swreg_write_ctrl_9
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_8                         [8:8]            get_swreg_write_ctrl_8
''                                                             set_swreg_write_ctrl_8
''                                                             read_swreg_write_ctrl_8
''                                                             write_swreg_write_ctrl_8
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_7                         [7:7]            get_swreg_write_ctrl_7
''                                                             set_swreg_write_ctrl_7
''                                                             read_swreg_write_ctrl_7
''                                                             write_swreg_write_ctrl_7
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_6                         [6:6]            get_swreg_write_ctrl_6
''                                                             set_swreg_write_ctrl_6
''                                                             read_swreg_write_ctrl_6
''                                                             write_swreg_write_ctrl_6
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_5                         [5:5]            get_swreg_write_ctrl_5
''                                                             set_swreg_write_ctrl_5
''                                                             read_swreg_write_ctrl_5
''                                                             write_swreg_write_ctrl_5
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_4                         [4:4]            get_swreg_write_ctrl_4
''                                                             set_swreg_write_ctrl_4
''                                                             read_swreg_write_ctrl_4
''                                                             write_swreg_write_ctrl_4
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_3                         [3:3]            get_swreg_write_ctrl_3
''                                                             set_swreg_write_ctrl_3
''                                                             read_swreg_write_ctrl_3
''                                                             write_swreg_write_ctrl_3
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_2                         [2:2]            get_swreg_write_ctrl_2
''                                                             set_swreg_write_ctrl_2
''                                                             read_swreg_write_ctrl_2
''                                                             write_swreg_write_ctrl_2
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_1                         [1:1]            get_swreg_write_ctrl_1
''                                                             set_swreg_write_ctrl_1
''                                                             read_swreg_write_ctrl_1
''                                                             write_swreg_write_ctrl_1
''---------------------------------------------------------------------------------
'' swreg_write_ctrl_0                         [0:0]            get_swreg_write_ctrl_0
''                                                             set_swreg_write_ctrl_0
''                                                             read_swreg_write_ctrl_0
''                                                             write_swreg_write_ctrl_0
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_access_ctrl_1
    Private write_swreg_write_ctrl_9_value
    Private read_swreg_write_ctrl_9_value
    Private flag_swreg_write_ctrl_9
    Private write_swreg_write_ctrl_8_value
    Private read_swreg_write_ctrl_8_value
    Private flag_swreg_write_ctrl_8
    Private write_swreg_write_ctrl_7_value
    Private read_swreg_write_ctrl_7_value
    Private flag_swreg_write_ctrl_7
    Private write_swreg_write_ctrl_6_value
    Private read_swreg_write_ctrl_6_value
    Private flag_swreg_write_ctrl_6
    Private write_swreg_write_ctrl_5_value
    Private read_swreg_write_ctrl_5_value
    Private flag_swreg_write_ctrl_5
    Private write_swreg_write_ctrl_4_value
    Private read_swreg_write_ctrl_4_value
    Private flag_swreg_write_ctrl_4
    Private write_swreg_write_ctrl_3_value
    Private read_swreg_write_ctrl_3_value
    Private flag_swreg_write_ctrl_3
    Private write_swreg_write_ctrl_2_value
    Private read_swreg_write_ctrl_2_value
    Private flag_swreg_write_ctrl_2
    Private write_swreg_write_ctrl_1_value
    Private read_swreg_write_ctrl_1_value
    Private flag_swreg_write_ctrl_1
    Private write_swreg_write_ctrl_0_value
    Private read_swreg_write_ctrl_0_value
    Private flag_swreg_write_ctrl_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_swreg_write_ctrl_9
        get_swreg_write_ctrl_9 = read_swreg_write_ctrl_9_value
    End Property

    Property Let set_swreg_write_ctrl_9(aData)
        write_swreg_write_ctrl_9_value = aData
        flag_swreg_write_ctrl_9        = &H1
    End Property

    Property Get read_swreg_write_ctrl_9
        read
        read_swreg_write_ctrl_9 = read_swreg_write_ctrl_9_value
    End Property

    Property Let write_swreg_write_ctrl_9(aData)
        set_swreg_write_ctrl_9 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_8
        get_swreg_write_ctrl_8 = read_swreg_write_ctrl_8_value
    End Property

    Property Let set_swreg_write_ctrl_8(aData)
        write_swreg_write_ctrl_8_value = aData
        flag_swreg_write_ctrl_8        = &H1
    End Property

    Property Get read_swreg_write_ctrl_8
        read
        read_swreg_write_ctrl_8 = read_swreg_write_ctrl_8_value
    End Property

    Property Let write_swreg_write_ctrl_8(aData)
        set_swreg_write_ctrl_8 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_7
        get_swreg_write_ctrl_7 = read_swreg_write_ctrl_7_value
    End Property

    Property Let set_swreg_write_ctrl_7(aData)
        write_swreg_write_ctrl_7_value = aData
        flag_swreg_write_ctrl_7        = &H1
    End Property

    Property Get read_swreg_write_ctrl_7
        read
        read_swreg_write_ctrl_7 = read_swreg_write_ctrl_7_value
    End Property

    Property Let write_swreg_write_ctrl_7(aData)
        set_swreg_write_ctrl_7 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_6
        get_swreg_write_ctrl_6 = read_swreg_write_ctrl_6_value
    End Property

    Property Let set_swreg_write_ctrl_6(aData)
        write_swreg_write_ctrl_6_value = aData
        flag_swreg_write_ctrl_6        = &H1
    End Property

    Property Get read_swreg_write_ctrl_6
        read
        read_swreg_write_ctrl_6 = read_swreg_write_ctrl_6_value
    End Property

    Property Let write_swreg_write_ctrl_6(aData)
        set_swreg_write_ctrl_6 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_5
        get_swreg_write_ctrl_5 = read_swreg_write_ctrl_5_value
    End Property

    Property Let set_swreg_write_ctrl_5(aData)
        write_swreg_write_ctrl_5_value = aData
        flag_swreg_write_ctrl_5        = &H1
    End Property

    Property Get read_swreg_write_ctrl_5
        read
        read_swreg_write_ctrl_5 = read_swreg_write_ctrl_5_value
    End Property

    Property Let write_swreg_write_ctrl_5(aData)
        set_swreg_write_ctrl_5 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_4
        get_swreg_write_ctrl_4 = read_swreg_write_ctrl_4_value
    End Property

    Property Let set_swreg_write_ctrl_4(aData)
        write_swreg_write_ctrl_4_value = aData
        flag_swreg_write_ctrl_4        = &H1
    End Property

    Property Get read_swreg_write_ctrl_4
        read
        read_swreg_write_ctrl_4 = read_swreg_write_ctrl_4_value
    End Property

    Property Let write_swreg_write_ctrl_4(aData)
        set_swreg_write_ctrl_4 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_3
        get_swreg_write_ctrl_3 = read_swreg_write_ctrl_3_value
    End Property

    Property Let set_swreg_write_ctrl_3(aData)
        write_swreg_write_ctrl_3_value = aData
        flag_swreg_write_ctrl_3        = &H1
    End Property

    Property Get read_swreg_write_ctrl_3
        read
        read_swreg_write_ctrl_3 = read_swreg_write_ctrl_3_value
    End Property

    Property Let write_swreg_write_ctrl_3(aData)
        set_swreg_write_ctrl_3 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_2
        get_swreg_write_ctrl_2 = read_swreg_write_ctrl_2_value
    End Property

    Property Let set_swreg_write_ctrl_2(aData)
        write_swreg_write_ctrl_2_value = aData
        flag_swreg_write_ctrl_2        = &H1
    End Property

    Property Get read_swreg_write_ctrl_2
        read
        read_swreg_write_ctrl_2 = read_swreg_write_ctrl_2_value
    End Property

    Property Let write_swreg_write_ctrl_2(aData)
        set_swreg_write_ctrl_2 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_1
        get_swreg_write_ctrl_1 = read_swreg_write_ctrl_1_value
    End Property

    Property Let set_swreg_write_ctrl_1(aData)
        write_swreg_write_ctrl_1_value = aData
        flag_swreg_write_ctrl_1        = &H1
    End Property

    Property Get read_swreg_write_ctrl_1
        read
        read_swreg_write_ctrl_1 = read_swreg_write_ctrl_1_value
    End Property

    Property Let write_swreg_write_ctrl_1(aData)
        set_swreg_write_ctrl_1 = aData
        write
    End Property

    Property Get get_swreg_write_ctrl_0
        get_swreg_write_ctrl_0 = read_swreg_write_ctrl_0_value
    End Property

    Property Let set_swreg_write_ctrl_0(aData)
        write_swreg_write_ctrl_0_value = aData
        flag_swreg_write_ctrl_0        = &H1
    End Property

    Property Get read_swreg_write_ctrl_0
        read
        read_swreg_write_ctrl_0 = read_swreg_write_ctrl_0_value
    End Property

    Property Let write_swreg_write_ctrl_0(aData)
        set_swreg_write_ctrl_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_swreg_write_ctrl_9_value = rightShift(data_low, 9) and &H1
        read_swreg_write_ctrl_8_value = rightShift(data_low, 8) and &H1
        read_swreg_write_ctrl_7_value = rightShift(data_low, 7) and &H1
        read_swreg_write_ctrl_6_value = rightShift(data_low, 6) and &H1
        read_swreg_write_ctrl_5_value = rightShift(data_low, 5) and &H1
        read_swreg_write_ctrl_4_value = rightShift(data_low, 4) and &H1
        read_swreg_write_ctrl_3_value = rightShift(data_low, 3) and &H1
        read_swreg_write_ctrl_2_value = rightShift(data_low, 2) and &H1
        read_swreg_write_ctrl_1_value = rightShift(data_low, 1) and &H1
        swreg_write_ctrl_0_mask = &H1
        if data_low > LONG_MAX then
            if swreg_write_ctrl_0_mask = mask then
                read_swreg_write_ctrl_0_value = data_low
            else
                read_swreg_write_ctrl_0_value = (data_low - H8000_0000) and swreg_write_ctrl_0_mask
            end If
        else
            read_swreg_write_ctrl_0_value = data_low and swreg_write_ctrl_0_mask
        end If

    End Sub

    Sub write
        If flag_swreg_write_ctrl_9 = &H0 or flag_swreg_write_ctrl_8 = &H0 or flag_swreg_write_ctrl_7 = &H0 or flag_swreg_write_ctrl_6 = &H0 or flag_swreg_write_ctrl_5 = &H0 or flag_swreg_write_ctrl_4 = &H0 or flag_swreg_write_ctrl_3 = &H0 or flag_swreg_write_ctrl_2 = &H0 or flag_swreg_write_ctrl_1 = &H0 or flag_swreg_write_ctrl_0 = &H0 Then read
        If flag_swreg_write_ctrl_9 = &H0 Then write_swreg_write_ctrl_9_value = get_swreg_write_ctrl_9
        If flag_swreg_write_ctrl_8 = &H0 Then write_swreg_write_ctrl_8_value = get_swreg_write_ctrl_8
        If flag_swreg_write_ctrl_7 = &H0 Then write_swreg_write_ctrl_7_value = get_swreg_write_ctrl_7
        If flag_swreg_write_ctrl_6 = &H0 Then write_swreg_write_ctrl_6_value = get_swreg_write_ctrl_6
        If flag_swreg_write_ctrl_5 = &H0 Then write_swreg_write_ctrl_5_value = get_swreg_write_ctrl_5
        If flag_swreg_write_ctrl_4 = &H0 Then write_swreg_write_ctrl_4_value = get_swreg_write_ctrl_4
        If flag_swreg_write_ctrl_3 = &H0 Then write_swreg_write_ctrl_3_value = get_swreg_write_ctrl_3
        If flag_swreg_write_ctrl_2 = &H0 Then write_swreg_write_ctrl_2_value = get_swreg_write_ctrl_2
        If flag_swreg_write_ctrl_1 = &H0 Then write_swreg_write_ctrl_1_value = get_swreg_write_ctrl_1
        If flag_swreg_write_ctrl_0 = &H0 Then write_swreg_write_ctrl_0_value = get_swreg_write_ctrl_0

        regValue = leftShift((write_swreg_write_ctrl_9_value and &H1), 9) + leftShift((write_swreg_write_ctrl_8_value and &H1), 8) + leftShift((write_swreg_write_ctrl_7_value and &H1), 7) + leftShift((write_swreg_write_ctrl_6_value and &H1), 6) + leftShift((write_swreg_write_ctrl_5_value and &H1), 5) + leftShift((write_swreg_write_ctrl_4_value and &H1), 4) + leftShift((write_swreg_write_ctrl_3_value and &H1), 3) + leftShift((write_swreg_write_ctrl_2_value and &H1), 2) + leftShift((write_swreg_write_ctrl_1_value and &H1), 1) + leftShift((write_swreg_write_ctrl_0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_swreg_write_ctrl_9_value = rightShift(data_low, 9) and &H1
        read_swreg_write_ctrl_8_value = rightShift(data_low, 8) and &H1
        read_swreg_write_ctrl_7_value = rightShift(data_low, 7) and &H1
        read_swreg_write_ctrl_6_value = rightShift(data_low, 6) and &H1
        read_swreg_write_ctrl_5_value = rightShift(data_low, 5) and &H1
        read_swreg_write_ctrl_4_value = rightShift(data_low, 4) and &H1
        read_swreg_write_ctrl_3_value = rightShift(data_low, 3) and &H1
        read_swreg_write_ctrl_2_value = rightShift(data_low, 2) and &H1
        read_swreg_write_ctrl_1_value = rightShift(data_low, 1) and &H1
        swreg_write_ctrl_0_mask = &H1
        if data_low > LONG_MAX then
            if swreg_write_ctrl_0_mask = mask then
                read_swreg_write_ctrl_0_value = data_low
            else
                read_swreg_write_ctrl_0_value = (data_low - H8000_0000) and swreg_write_ctrl_0_mask
            end If
        else
            read_swreg_write_ctrl_0_value = data_low and swreg_write_ctrl_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_swreg_write_ctrl_9_value = &H0
        flag_swreg_write_ctrl_9        = &H0
        write_swreg_write_ctrl_8_value = &H0
        flag_swreg_write_ctrl_8        = &H0
        write_swreg_write_ctrl_7_value = &H0
        flag_swreg_write_ctrl_7        = &H0
        write_swreg_write_ctrl_6_value = &H0
        flag_swreg_write_ctrl_6        = &H0
        write_swreg_write_ctrl_5_value = &H0
        flag_swreg_write_ctrl_5        = &H0
        write_swreg_write_ctrl_4_value = &H0
        flag_swreg_write_ctrl_4        = &H0
        write_swreg_write_ctrl_3_value = &H0
        flag_swreg_write_ctrl_3        = &H0
        write_swreg_write_ctrl_2_value = &H0
        flag_swreg_write_ctrl_2        = &H0
        write_swreg_write_ctrl_1_value = &H0
        flag_swreg_write_ctrl_1        = &H0
        write_swreg_write_ctrl_0_value = &H0
        flag_swreg_write_ctrl_0        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_access_ctrl_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' swreg_read_stat_15                         [15:15]          get_swreg_read_stat_15
''                                                             set_swreg_read_stat_15
''                                                             read_swreg_read_stat_15
''                                                             write_swreg_read_stat_15
''---------------------------------------------------------------------------------
'' swreg_read_stat_14                         [14:14]          get_swreg_read_stat_14
''                                                             set_swreg_read_stat_14
''                                                             read_swreg_read_stat_14
''                                                             write_swreg_read_stat_14
''---------------------------------------------------------------------------------
'' swreg_read_stat_13                         [13:13]          get_swreg_read_stat_13
''                                                             set_swreg_read_stat_13
''                                                             read_swreg_read_stat_13
''                                                             write_swreg_read_stat_13
''---------------------------------------------------------------------------------
'' swreg_read_stat_12                         [12:12]          get_swreg_read_stat_12
''                                                             set_swreg_read_stat_12
''                                                             read_swreg_read_stat_12
''                                                             write_swreg_read_stat_12
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_9                          [9:9]            get_swreg_read_ctrl_9
''                                                             set_swreg_read_ctrl_9
''                                                             read_swreg_read_ctrl_9
''                                                             write_swreg_read_ctrl_9
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_8                          [8:8]            get_swreg_read_ctrl_8
''                                                             set_swreg_read_ctrl_8
''                                                             read_swreg_read_ctrl_8
''                                                             write_swreg_read_ctrl_8
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_7                          [7:7]            get_swreg_read_ctrl_7
''                                                             set_swreg_read_ctrl_7
''                                                             read_swreg_read_ctrl_7
''                                                             write_swreg_read_ctrl_7
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_6                          [6:6]            get_swreg_read_ctrl_6
''                                                             set_swreg_read_ctrl_6
''                                                             read_swreg_read_ctrl_6
''                                                             write_swreg_read_ctrl_6
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_5                          [5:5]            get_swreg_read_ctrl_5
''                                                             set_swreg_read_ctrl_5
''                                                             read_swreg_read_ctrl_5
''                                                             write_swreg_read_ctrl_5
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_4                          [4:4]            get_swreg_read_ctrl_4
''                                                             set_swreg_read_ctrl_4
''                                                             read_swreg_read_ctrl_4
''                                                             write_swreg_read_ctrl_4
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_3                          [3:3]            get_swreg_read_ctrl_3
''                                                             set_swreg_read_ctrl_3
''                                                             read_swreg_read_ctrl_3
''                                                             write_swreg_read_ctrl_3
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_2                          [2:2]            get_swreg_read_ctrl_2
''                                                             set_swreg_read_ctrl_2
''                                                             read_swreg_read_ctrl_2
''                                                             write_swreg_read_ctrl_2
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_1                          [1:1]            get_swreg_read_ctrl_1
''                                                             set_swreg_read_ctrl_1
''                                                             read_swreg_read_ctrl_1
''                                                             write_swreg_read_ctrl_1
''---------------------------------------------------------------------------------
'' swreg_read_ctrl_0                          [0:0]            get_swreg_read_ctrl_0
''                                                             set_swreg_read_ctrl_0
''                                                             read_swreg_read_ctrl_0
''                                                             write_swreg_read_ctrl_0
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_access_ctrl_2
    Private write_swreg_read_stat_15_value
    Private read_swreg_read_stat_15_value
    Private flag_swreg_read_stat_15
    Private write_swreg_read_stat_14_value
    Private read_swreg_read_stat_14_value
    Private flag_swreg_read_stat_14
    Private write_swreg_read_stat_13_value
    Private read_swreg_read_stat_13_value
    Private flag_swreg_read_stat_13
    Private write_swreg_read_stat_12_value
    Private read_swreg_read_stat_12_value
    Private flag_swreg_read_stat_12
    Private write_swreg_read_ctrl_9_value
    Private read_swreg_read_ctrl_9_value
    Private flag_swreg_read_ctrl_9
    Private write_swreg_read_ctrl_8_value
    Private read_swreg_read_ctrl_8_value
    Private flag_swreg_read_ctrl_8
    Private write_swreg_read_ctrl_7_value
    Private read_swreg_read_ctrl_7_value
    Private flag_swreg_read_ctrl_7
    Private write_swreg_read_ctrl_6_value
    Private read_swreg_read_ctrl_6_value
    Private flag_swreg_read_ctrl_6
    Private write_swreg_read_ctrl_5_value
    Private read_swreg_read_ctrl_5_value
    Private flag_swreg_read_ctrl_5
    Private write_swreg_read_ctrl_4_value
    Private read_swreg_read_ctrl_4_value
    Private flag_swreg_read_ctrl_4
    Private write_swreg_read_ctrl_3_value
    Private read_swreg_read_ctrl_3_value
    Private flag_swreg_read_ctrl_3
    Private write_swreg_read_ctrl_2_value
    Private read_swreg_read_ctrl_2_value
    Private flag_swreg_read_ctrl_2
    Private write_swreg_read_ctrl_1_value
    Private read_swreg_read_ctrl_1_value
    Private flag_swreg_read_ctrl_1
    Private write_swreg_read_ctrl_0_value
    Private read_swreg_read_ctrl_0_value
    Private flag_swreg_read_ctrl_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_swreg_read_stat_15
        get_swreg_read_stat_15 = read_swreg_read_stat_15_value
    End Property

    Property Let set_swreg_read_stat_15(aData)
        write_swreg_read_stat_15_value = aData
        flag_swreg_read_stat_15        = &H1
    End Property

    Property Get read_swreg_read_stat_15
        read
        read_swreg_read_stat_15 = read_swreg_read_stat_15_value
    End Property

    Property Let write_swreg_read_stat_15(aData)
        set_swreg_read_stat_15 = aData
        write
    End Property

    Property Get get_swreg_read_stat_14
        get_swreg_read_stat_14 = read_swreg_read_stat_14_value
    End Property

    Property Let set_swreg_read_stat_14(aData)
        write_swreg_read_stat_14_value = aData
        flag_swreg_read_stat_14        = &H1
    End Property

    Property Get read_swreg_read_stat_14
        read
        read_swreg_read_stat_14 = read_swreg_read_stat_14_value
    End Property

    Property Let write_swreg_read_stat_14(aData)
        set_swreg_read_stat_14 = aData
        write
    End Property

    Property Get get_swreg_read_stat_13
        get_swreg_read_stat_13 = read_swreg_read_stat_13_value
    End Property

    Property Let set_swreg_read_stat_13(aData)
        write_swreg_read_stat_13_value = aData
        flag_swreg_read_stat_13        = &H1
    End Property

    Property Get read_swreg_read_stat_13
        read
        read_swreg_read_stat_13 = read_swreg_read_stat_13_value
    End Property

    Property Let write_swreg_read_stat_13(aData)
        set_swreg_read_stat_13 = aData
        write
    End Property

    Property Get get_swreg_read_stat_12
        get_swreg_read_stat_12 = read_swreg_read_stat_12_value
    End Property

    Property Let set_swreg_read_stat_12(aData)
        write_swreg_read_stat_12_value = aData
        flag_swreg_read_stat_12        = &H1
    End Property

    Property Get read_swreg_read_stat_12
        read
        read_swreg_read_stat_12 = read_swreg_read_stat_12_value
    End Property

    Property Let write_swreg_read_stat_12(aData)
        set_swreg_read_stat_12 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_9
        get_swreg_read_ctrl_9 = read_swreg_read_ctrl_9_value
    End Property

    Property Let set_swreg_read_ctrl_9(aData)
        write_swreg_read_ctrl_9_value = aData
        flag_swreg_read_ctrl_9        = &H1
    End Property

    Property Get read_swreg_read_ctrl_9
        read
        read_swreg_read_ctrl_9 = read_swreg_read_ctrl_9_value
    End Property

    Property Let write_swreg_read_ctrl_9(aData)
        set_swreg_read_ctrl_9 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_8
        get_swreg_read_ctrl_8 = read_swreg_read_ctrl_8_value
    End Property

    Property Let set_swreg_read_ctrl_8(aData)
        write_swreg_read_ctrl_8_value = aData
        flag_swreg_read_ctrl_8        = &H1
    End Property

    Property Get read_swreg_read_ctrl_8
        read
        read_swreg_read_ctrl_8 = read_swreg_read_ctrl_8_value
    End Property

    Property Let write_swreg_read_ctrl_8(aData)
        set_swreg_read_ctrl_8 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_7
        get_swreg_read_ctrl_7 = read_swreg_read_ctrl_7_value
    End Property

    Property Let set_swreg_read_ctrl_7(aData)
        write_swreg_read_ctrl_7_value = aData
        flag_swreg_read_ctrl_7        = &H1
    End Property

    Property Get read_swreg_read_ctrl_7
        read
        read_swreg_read_ctrl_7 = read_swreg_read_ctrl_7_value
    End Property

    Property Let write_swreg_read_ctrl_7(aData)
        set_swreg_read_ctrl_7 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_6
        get_swreg_read_ctrl_6 = read_swreg_read_ctrl_6_value
    End Property

    Property Let set_swreg_read_ctrl_6(aData)
        write_swreg_read_ctrl_6_value = aData
        flag_swreg_read_ctrl_6        = &H1
    End Property

    Property Get read_swreg_read_ctrl_6
        read
        read_swreg_read_ctrl_6 = read_swreg_read_ctrl_6_value
    End Property

    Property Let write_swreg_read_ctrl_6(aData)
        set_swreg_read_ctrl_6 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_5
        get_swreg_read_ctrl_5 = read_swreg_read_ctrl_5_value
    End Property

    Property Let set_swreg_read_ctrl_5(aData)
        write_swreg_read_ctrl_5_value = aData
        flag_swreg_read_ctrl_5        = &H1
    End Property

    Property Get read_swreg_read_ctrl_5
        read
        read_swreg_read_ctrl_5 = read_swreg_read_ctrl_5_value
    End Property

    Property Let write_swreg_read_ctrl_5(aData)
        set_swreg_read_ctrl_5 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_4
        get_swreg_read_ctrl_4 = read_swreg_read_ctrl_4_value
    End Property

    Property Let set_swreg_read_ctrl_4(aData)
        write_swreg_read_ctrl_4_value = aData
        flag_swreg_read_ctrl_4        = &H1
    End Property

    Property Get read_swreg_read_ctrl_4
        read
        read_swreg_read_ctrl_4 = read_swreg_read_ctrl_4_value
    End Property

    Property Let write_swreg_read_ctrl_4(aData)
        set_swreg_read_ctrl_4 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_3
        get_swreg_read_ctrl_3 = read_swreg_read_ctrl_3_value
    End Property

    Property Let set_swreg_read_ctrl_3(aData)
        write_swreg_read_ctrl_3_value = aData
        flag_swreg_read_ctrl_3        = &H1
    End Property

    Property Get read_swreg_read_ctrl_3
        read
        read_swreg_read_ctrl_3 = read_swreg_read_ctrl_3_value
    End Property

    Property Let write_swreg_read_ctrl_3(aData)
        set_swreg_read_ctrl_3 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_2
        get_swreg_read_ctrl_2 = read_swreg_read_ctrl_2_value
    End Property

    Property Let set_swreg_read_ctrl_2(aData)
        write_swreg_read_ctrl_2_value = aData
        flag_swreg_read_ctrl_2        = &H1
    End Property

    Property Get read_swreg_read_ctrl_2
        read
        read_swreg_read_ctrl_2 = read_swreg_read_ctrl_2_value
    End Property

    Property Let write_swreg_read_ctrl_2(aData)
        set_swreg_read_ctrl_2 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_1
        get_swreg_read_ctrl_1 = read_swreg_read_ctrl_1_value
    End Property

    Property Let set_swreg_read_ctrl_1(aData)
        write_swreg_read_ctrl_1_value = aData
        flag_swreg_read_ctrl_1        = &H1
    End Property

    Property Get read_swreg_read_ctrl_1
        read
        read_swreg_read_ctrl_1 = read_swreg_read_ctrl_1_value
    End Property

    Property Let write_swreg_read_ctrl_1(aData)
        set_swreg_read_ctrl_1 = aData
        write
    End Property

    Property Get get_swreg_read_ctrl_0
        get_swreg_read_ctrl_0 = read_swreg_read_ctrl_0_value
    End Property

    Property Let set_swreg_read_ctrl_0(aData)
        write_swreg_read_ctrl_0_value = aData
        flag_swreg_read_ctrl_0        = &H1
    End Property

    Property Get read_swreg_read_ctrl_0
        read
        read_swreg_read_ctrl_0 = read_swreg_read_ctrl_0_value
    End Property

    Property Let write_swreg_read_ctrl_0(aData)
        set_swreg_read_ctrl_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_swreg_read_stat_15_value = rightShift(data_low, 15) and &H1
        read_swreg_read_stat_14_value = rightShift(data_low, 14) and &H1
        read_swreg_read_stat_13_value = rightShift(data_low, 13) and &H1
        read_swreg_read_stat_12_value = rightShift(data_low, 12) and &H1
        read_swreg_read_ctrl_9_value = rightShift(data_low, 9) and &H1
        read_swreg_read_ctrl_8_value = rightShift(data_low, 8) and &H1
        read_swreg_read_ctrl_7_value = rightShift(data_low, 7) and &H1
        read_swreg_read_ctrl_6_value = rightShift(data_low, 6) and &H1
        read_swreg_read_ctrl_5_value = rightShift(data_low, 5) and &H1
        read_swreg_read_ctrl_4_value = rightShift(data_low, 4) and &H1
        read_swreg_read_ctrl_3_value = rightShift(data_low, 3) and &H1
        read_swreg_read_ctrl_2_value = rightShift(data_low, 2) and &H1
        read_swreg_read_ctrl_1_value = rightShift(data_low, 1) and &H1
        swreg_read_ctrl_0_mask = &H1
        if data_low > LONG_MAX then
            if swreg_read_ctrl_0_mask = mask then
                read_swreg_read_ctrl_0_value = data_low
            else
                read_swreg_read_ctrl_0_value = (data_low - H8000_0000) and swreg_read_ctrl_0_mask
            end If
        else
            read_swreg_read_ctrl_0_value = data_low and swreg_read_ctrl_0_mask
        end If

    End Sub

    Sub write
        If flag_swreg_read_stat_15 = &H0 or flag_swreg_read_stat_14 = &H0 or flag_swreg_read_stat_13 = &H0 or flag_swreg_read_stat_12 = &H0 or flag_swreg_read_ctrl_9 = &H0 or flag_swreg_read_ctrl_8 = &H0 or flag_swreg_read_ctrl_7 = &H0 or flag_swreg_read_ctrl_6 = &H0 or flag_swreg_read_ctrl_5 = &H0 or flag_swreg_read_ctrl_4 = &H0 or flag_swreg_read_ctrl_3 = &H0 or flag_swreg_read_ctrl_2 = &H0 or flag_swreg_read_ctrl_1 = &H0 or flag_swreg_read_ctrl_0 = &H0 Then read
        If flag_swreg_read_stat_15 = &H0 Then write_swreg_read_stat_15_value = get_swreg_read_stat_15
        If flag_swreg_read_stat_14 = &H0 Then write_swreg_read_stat_14_value = get_swreg_read_stat_14
        If flag_swreg_read_stat_13 = &H0 Then write_swreg_read_stat_13_value = get_swreg_read_stat_13
        If flag_swreg_read_stat_12 = &H0 Then write_swreg_read_stat_12_value = get_swreg_read_stat_12
        If flag_swreg_read_ctrl_9 = &H0 Then write_swreg_read_ctrl_9_value = get_swreg_read_ctrl_9
        If flag_swreg_read_ctrl_8 = &H0 Then write_swreg_read_ctrl_8_value = get_swreg_read_ctrl_8
        If flag_swreg_read_ctrl_7 = &H0 Then write_swreg_read_ctrl_7_value = get_swreg_read_ctrl_7
        If flag_swreg_read_ctrl_6 = &H0 Then write_swreg_read_ctrl_6_value = get_swreg_read_ctrl_6
        If flag_swreg_read_ctrl_5 = &H0 Then write_swreg_read_ctrl_5_value = get_swreg_read_ctrl_5
        If flag_swreg_read_ctrl_4 = &H0 Then write_swreg_read_ctrl_4_value = get_swreg_read_ctrl_4
        If flag_swreg_read_ctrl_3 = &H0 Then write_swreg_read_ctrl_3_value = get_swreg_read_ctrl_3
        If flag_swreg_read_ctrl_2 = &H0 Then write_swreg_read_ctrl_2_value = get_swreg_read_ctrl_2
        If flag_swreg_read_ctrl_1 = &H0 Then write_swreg_read_ctrl_1_value = get_swreg_read_ctrl_1
        If flag_swreg_read_ctrl_0 = &H0 Then write_swreg_read_ctrl_0_value = get_swreg_read_ctrl_0

        regValue = leftShift((write_swreg_read_stat_15_value and &H1), 15) + leftShift((write_swreg_read_stat_14_value and &H1), 14) + leftShift((write_swreg_read_stat_13_value and &H1), 13) + leftShift((write_swreg_read_stat_12_value and &H1), 12) + leftShift((write_swreg_read_ctrl_9_value and &H1), 9) + leftShift((write_swreg_read_ctrl_8_value and &H1), 8) + leftShift((write_swreg_read_ctrl_7_value and &H1), 7) + leftShift((write_swreg_read_ctrl_6_value and &H1), 6) + leftShift((write_swreg_read_ctrl_5_value and &H1), 5) + leftShift((write_swreg_read_ctrl_4_value and &H1), 4) + leftShift((write_swreg_read_ctrl_3_value and &H1), 3) + leftShift((write_swreg_read_ctrl_2_value and &H1), 2) + leftShift((write_swreg_read_ctrl_1_value and &H1), 1) + leftShift((write_swreg_read_ctrl_0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_swreg_read_stat_15_value = rightShift(data_low, 15) and &H1
        read_swreg_read_stat_14_value = rightShift(data_low, 14) and &H1
        read_swreg_read_stat_13_value = rightShift(data_low, 13) and &H1
        read_swreg_read_stat_12_value = rightShift(data_low, 12) and &H1
        read_swreg_read_ctrl_9_value = rightShift(data_low, 9) and &H1
        read_swreg_read_ctrl_8_value = rightShift(data_low, 8) and &H1
        read_swreg_read_ctrl_7_value = rightShift(data_low, 7) and &H1
        read_swreg_read_ctrl_6_value = rightShift(data_low, 6) and &H1
        read_swreg_read_ctrl_5_value = rightShift(data_low, 5) and &H1
        read_swreg_read_ctrl_4_value = rightShift(data_low, 4) and &H1
        read_swreg_read_ctrl_3_value = rightShift(data_low, 3) and &H1
        read_swreg_read_ctrl_2_value = rightShift(data_low, 2) and &H1
        read_swreg_read_ctrl_1_value = rightShift(data_low, 1) and &H1
        swreg_read_ctrl_0_mask = &H1
        if data_low > LONG_MAX then
            if swreg_read_ctrl_0_mask = mask then
                read_swreg_read_ctrl_0_value = data_low
            else
                read_swreg_read_ctrl_0_value = (data_low - H8000_0000) and swreg_read_ctrl_0_mask
            end If
        else
            read_swreg_read_ctrl_0_value = data_low and swreg_read_ctrl_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_swreg_read_stat_15_value = &H0
        flag_swreg_read_stat_15        = &H0
        write_swreg_read_stat_14_value = &H0
        flag_swreg_read_stat_14        = &H0
        write_swreg_read_stat_13_value = &H0
        flag_swreg_read_stat_13        = &H0
        write_swreg_read_stat_12_value = &H0
        flag_swreg_read_stat_12        = &H0
        write_swreg_read_ctrl_9_value = &H0
        flag_swreg_read_ctrl_9        = &H0
        write_swreg_read_ctrl_8_value = &H0
        flag_swreg_read_ctrl_8        = &H0
        write_swreg_read_ctrl_7_value = &H0
        flag_swreg_read_ctrl_7        = &H0
        write_swreg_read_ctrl_6_value = &H0
        flag_swreg_read_ctrl_6        = &H0
        write_swreg_read_ctrl_5_value = &H0
        flag_swreg_read_ctrl_5        = &H0
        write_swreg_read_ctrl_4_value = &H0
        flag_swreg_read_ctrl_4        = &H0
        write_swreg_read_ctrl_3_value = &H0
        flag_swreg_read_ctrl_3        = &H0
        write_swreg_read_ctrl_2_value = &H0
        flag_swreg_read_ctrl_2        = &H0
        write_swreg_read_ctrl_1_value = &H0
        flag_swreg_read_ctrl_1        = &H0
        write_swreg_read_ctrl_0_value = &H0
        flag_swreg_read_ctrl_0        = &H0
    End Sub
End Class


'' @REGISTER : MISC_swreg_control_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' swreg_pmu_stable_status                    [0:0]            get_swreg_pmu_stable_status
''                                                             set_swreg_pmu_stable_status
''                                                             read_swreg_pmu_stable_status
''                                                             write_swreg_pmu_stable_status
''---------------------------------------------------------------------------------
'' swreg_ext_pllclk_en                        [1:1]            get_swreg_ext_pllclk_en
''                                                             set_swreg_ext_pllclk_en
''                                                             read_swreg_ext_pllclk_en
''                                                             write_swreg_ext_pllclk_en
''---------------------------------------------------------------------------------
Class REGISTER_MISC_swreg_control_status
    Private write_swreg_pmu_stable_status_value
    Private read_swreg_pmu_stable_status_value
    Private flag_swreg_pmu_stable_status
    Private write_swreg_ext_pllclk_en_value
    Private read_swreg_ext_pllclk_en_value
    Private flag_swreg_ext_pllclk_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H130
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_swreg_pmu_stable_status
        get_swreg_pmu_stable_status = read_swreg_pmu_stable_status_value
    End Property

    Property Let set_swreg_pmu_stable_status(aData)
        write_swreg_pmu_stable_status_value = aData
        flag_swreg_pmu_stable_status        = &H1
    End Property

    Property Get read_swreg_pmu_stable_status
        read
        read_swreg_pmu_stable_status = read_swreg_pmu_stable_status_value
    End Property

    Property Let write_swreg_pmu_stable_status(aData)
        set_swreg_pmu_stable_status = aData
        write
    End Property

    Property Get get_swreg_ext_pllclk_en
        get_swreg_ext_pllclk_en = read_swreg_ext_pllclk_en_value
    End Property

    Property Let set_swreg_ext_pllclk_en(aData)
        write_swreg_ext_pllclk_en_value = aData
        flag_swreg_ext_pllclk_en        = &H1
    End Property

    Property Get read_swreg_ext_pllclk_en
        read
        read_swreg_ext_pllclk_en = read_swreg_ext_pllclk_en_value
    End Property

    Property Let write_swreg_ext_pllclk_en(aData)
        set_swreg_ext_pllclk_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        swreg_pmu_stable_status_mask = &H1
        if data_low > LONG_MAX then
            if swreg_pmu_stable_status_mask = mask then
                read_swreg_pmu_stable_status_value = data_low
            else
                read_swreg_pmu_stable_status_value = (data_low - H8000_0000) and swreg_pmu_stable_status_mask
            end If
        else
            read_swreg_pmu_stable_status_value = data_low and swreg_pmu_stable_status_mask
        end If
        read_swreg_ext_pllclk_en_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_swreg_pmu_stable_status = &H0 or flag_swreg_ext_pllclk_en = &H0 Then read
        If flag_swreg_pmu_stable_status = &H0 Then write_swreg_pmu_stable_status_value = get_swreg_pmu_stable_status
        If flag_swreg_ext_pllclk_en = &H0 Then write_swreg_ext_pllclk_en_value = get_swreg_ext_pllclk_en

        regValue = leftShift((write_swreg_pmu_stable_status_value and &H1), 0) + leftShift((write_swreg_ext_pllclk_en_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        swreg_pmu_stable_status_mask = &H1
        if data_low > LONG_MAX then
            if swreg_pmu_stable_status_mask = mask then
                read_swreg_pmu_stable_status_value = data_low
            else
                read_swreg_pmu_stable_status_value = (data_low - H8000_0000) and swreg_pmu_stable_status_mask
            end If
        else
            read_swreg_pmu_stable_status_value = data_low and swreg_pmu_stable_status_mask
        end If
        read_swreg_ext_pllclk_en_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_swreg_pmu_stable_status_value = &H0
        flag_swreg_pmu_stable_status        = &H0
        write_swreg_ext_pllclk_en_value = &H0
        flag_swreg_ext_pllclk_en        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plus2_pwrdwn
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdwn                                     [0:0]            get_pwrdwn
''                                                             set_pwrdwn
''                                                             read_pwrdwn
''                                                             write_pwrdwn
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plus2_pwrdwn
    Private write_pwrdwn_value
    Private read_pwrdwn_value
    Private flag_pwrdwn

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H140
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pwrdwn
        get_pwrdwn = read_pwrdwn_value
    End Property

    Property Let set_pwrdwn(aData)
        write_pwrdwn_value = aData
        flag_pwrdwn        = &H1
    End Property

    Property Get read_pwrdwn
        read
        read_pwrdwn = read_pwrdwn_value
    End Property

    Property Let write_pwrdwn(aData)
        set_pwrdwn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_mask = mask then
                read_pwrdwn_value = data_low
            else
                read_pwrdwn_value = (data_low - H8000_0000) and pwrdwn_mask
            end If
        else
            read_pwrdwn_value = data_low and pwrdwn_mask
        end If

    End Sub

    Sub write
        If flag_pwrdwn = &H0 Then read
        If flag_pwrdwn = &H0 Then write_pwrdwn_value = get_pwrdwn

        regValue = leftShift((write_pwrdwn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_mask = mask then
                read_pwrdwn_value = data_low
            else
                read_pwrdwn_value = (data_low - H8000_0000) and pwrdwn_mask
            end If
        else
            read_pwrdwn_value = data_low and pwrdwn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdwn_value = &H0
        flag_pwrdwn        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plus2_hw_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' hw_rst_dly_val                             [14:0]           get_hw_rst_dly_val
''                                                             set_hw_rst_dly_val
''                                                             read_hw_rst_dly_val
''                                                             write_hw_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plus2_hw_rst_dly_val
    Private write_hw_rst_dly_val_value
    Private read_hw_rst_dly_val_value
    Private flag_hw_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H142
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_hw_rst_dly_val
        get_hw_rst_dly_val = read_hw_rst_dly_val_value
    End Property

    Property Let set_hw_rst_dly_val(aData)
        write_hw_rst_dly_val_value = aData
        flag_hw_rst_dly_val        = &H1
    End Property

    Property Get read_hw_rst_dly_val
        read
        read_hw_rst_dly_val = read_hw_rst_dly_val_value
    End Property

    Property Let write_hw_rst_dly_val(aData)
        set_hw_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_rst_dly_val_mask = &H7fff
        if data_low > LONG_MAX then
            if hw_rst_dly_val_mask = mask then
                read_hw_rst_dly_val_value = data_low
            else
                read_hw_rst_dly_val_value = (data_low - H8000_0000) and hw_rst_dly_val_mask
            end If
        else
            read_hw_rst_dly_val_value = data_low and hw_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_hw_rst_dly_val = &H0 Then read
        If flag_hw_rst_dly_val = &H0 Then write_hw_rst_dly_val_value = get_hw_rst_dly_val

        regValue = leftShift((write_hw_rst_dly_val_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_rst_dly_val_mask = &H7fff
        if data_low > LONG_MAX then
            if hw_rst_dly_val_mask = mask then
                read_hw_rst_dly_val_value = data_low
            else
                read_hw_rst_dly_val_value = (data_low - H8000_0000) and hw_rst_dly_val_mask
            end If
        else
            read_hw_rst_dly_val_value = data_low and hw_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_hw_rst_dly_val_value = &H0
        flag_hw_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plus2_mdio_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_rst_dly_val                           [12:0]           get_mdio_rst_dly_val
''                                                             set_mdio_rst_dly_val
''                                                             read_mdio_rst_dly_val
''                                                             write_mdio_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plus2_mdio_rst_dly_val
    Private write_mdio_rst_dly_val_value
    Private read_mdio_rst_dly_val_value
    Private flag_mdio_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H144
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mdio_rst_dly_val
        get_mdio_rst_dly_val = read_mdio_rst_dly_val_value
    End Property

    Property Let set_mdio_rst_dly_val(aData)
        write_mdio_rst_dly_val_value = aData
        flag_mdio_rst_dly_val        = &H1
    End Property

    Property Get read_mdio_rst_dly_val
        read
        read_mdio_rst_dly_val = read_mdio_rst_dly_val_value
    End Property

    Property Let write_mdio_rst_dly_val(aData)
        set_mdio_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_rst_dly_val_mask = &H1fff
        if data_low > LONG_MAX then
            if mdio_rst_dly_val_mask = mask then
                read_mdio_rst_dly_val_value = data_low
            else
                read_mdio_rst_dly_val_value = (data_low - H8000_0000) and mdio_rst_dly_val_mask
            end If
        else
            read_mdio_rst_dly_val_value = data_low and mdio_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_mdio_rst_dly_val = &H0 Then read
        If flag_mdio_rst_dly_val = &H0 Then write_mdio_rst_dly_val_value = get_mdio_rst_dly_val

        regValue = leftShift((write_mdio_rst_dly_val_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_rst_dly_val_mask = &H1fff
        if data_low > LONG_MAX then
            if mdio_rst_dly_val_mask = mask then
                read_mdio_rst_dly_val_value = data_low
            else
                read_mdio_rst_dly_val_value = (data_low - H8000_0000) and mdio_rst_dly_val_mask
            end If
        else
            read_mdio_rst_dly_val_value = data_low and mdio_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_rst_dly_val_value = &H0
        flag_mdio_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plus2_pll_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_rst_dly_val                            [11:0]           get_pll_rst_dly_val
''                                                             set_pll_rst_dly_val
''                                                             read_pll_rst_dly_val
''                                                             write_pll_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plus2_pll_rst_dly_val
    Private write_pll_rst_dly_val_value
    Private read_pll_rst_dly_val_value
    Private flag_pll_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H146
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll_rst_dly_val
        get_pll_rst_dly_val = read_pll_rst_dly_val_value
    End Property

    Property Let set_pll_rst_dly_val(aData)
        write_pll_rst_dly_val_value = aData
        flag_pll_rst_dly_val        = &H1
    End Property

    Property Get read_pll_rst_dly_val
        read
        read_pll_rst_dly_val = read_pll_rst_dly_val_value
    End Property

    Property Let write_pll_rst_dly_val(aData)
        set_pll_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_rst_dly_val_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_rst_dly_val_mask = mask then
                read_pll_rst_dly_val_value = data_low
            else
                read_pll_rst_dly_val_value = (data_low - H8000_0000) and pll_rst_dly_val_mask
            end If
        else
            read_pll_rst_dly_val_value = data_low and pll_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_pll_rst_dly_val = &H0 Then read
        If flag_pll_rst_dly_val = &H0 Then write_pll_rst_dly_val_value = get_pll_rst_dly_val

        regValue = leftShift((write_pll_rst_dly_val_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_rst_dly_val_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_rst_dly_val_mask = mask then
                read_pll_rst_dly_val_value = data_low
            else
                read_pll_rst_dly_val_value = (data_low - H8000_0000) and pll_rst_dly_val_mask
            end If
        else
            read_pll_rst_dly_val_value = data_low and pll_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_rst_dly_val_value = &H0
        flag_pll_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plus2_ext_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rescal_autoload_en                         [11:11]          get_rescal_autoload_en
''                                                             set_rescal_autoload_en
''                                                             read_rescal_autoload_en
''                                                             write_rescal_autoload_en
''---------------------------------------------------------------------------------
'' refsel                                     [9:8]            get_refsel
''                                                             set_refsel
''                                                             read_refsel
''                                                             write_refsel
''---------------------------------------------------------------------------------
'' rescal                                     [7:4]            get_rescal
''                                                             set_rescal
''                                                             read_rescal
''                                                             write_rescal
''---------------------------------------------------------------------------------
'' spare                                      [3:0]            get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plus2_ext_ctl
    Private write_rescal_autoload_en_value
    Private read_rescal_autoload_en_value
    Private flag_rescal_autoload_en
    Private write_refsel_value
    Private read_refsel_value
    Private flag_refsel
    Private write_rescal_value
    Private read_rescal_value
    Private flag_rescal
    Private write_spare_value
    Private read_spare_value
    Private flag_spare

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H148
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rescal_autoload_en
        get_rescal_autoload_en = read_rescal_autoload_en_value
    End Property

    Property Let set_rescal_autoload_en(aData)
        write_rescal_autoload_en_value = aData
        flag_rescal_autoload_en        = &H1
    End Property

    Property Get read_rescal_autoload_en
        read
        read_rescal_autoload_en = read_rescal_autoload_en_value
    End Property

    Property Let write_rescal_autoload_en(aData)
        set_rescal_autoload_en = aData
        write
    End Property

    Property Get get_refsel
        get_refsel = read_refsel_value
    End Property

    Property Let set_refsel(aData)
        write_refsel_value = aData
        flag_refsel        = &H1
    End Property

    Property Get read_refsel
        read
        read_refsel = read_refsel_value
    End Property

    Property Let write_refsel(aData)
        set_refsel = aData
        write
    End Property

    Property Get get_rescal
        get_rescal = read_rescal_value
    End Property

    Property Let set_rescal(aData)
        write_rescal_value = aData
        flag_rescal        = &H1
    End Property

    Property Get read_rescal
        read
        read_rescal = read_rescal_value
    End Property

    Property Let write_rescal(aData)
        set_rescal = aData
        write
    End Property

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rescal_autoload_en_value = rightShift(data_low, 11) and &H1
        read_refsel_value = rightShift(data_low, 8) and &H3
        read_rescal_value = rightShift(data_low, 4) and &Hf
        spare_mask = &Hf
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

    End Sub

    Sub write
        If flag_rescal_autoload_en = &H0 or flag_refsel = &H0 or flag_rescal = &H0 or flag_spare = &H0 Then read
        If flag_rescal_autoload_en = &H0 Then write_rescal_autoload_en_value = get_rescal_autoload_en
        If flag_refsel = &H0 Then write_refsel_value = get_refsel
        If flag_rescal = &H0 Then write_rescal_value = get_rescal
        If flag_spare = &H0 Then write_spare_value = get_spare

        regValue = leftShift((write_rescal_autoload_en_value and &H1), 11) + leftShift((write_refsel_value and &H3), 8) + leftShift((write_rescal_value and &Hf), 4) + leftShift((write_spare_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rescal_autoload_en_value = rightShift(data_low, 11) and &H1
        read_refsel_value = rightShift(data_low, 8) and &H3
        read_rescal_value = rightShift(data_low, 4) and &Hf
        spare_mask = &Hf
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rescal_autoload_en_value = &H0
        flag_rescal_autoload_en        = &H0
        write_refsel_value = &H0
        flag_refsel        = &H0
        write_rescal_value = &H0
        flag_rescal        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plus2_mdio_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_broadcast_en                         [9:9]            get_sgmii_broadcast_en
''                                                             set_sgmii_broadcast_en
''                                                             read_sgmii_broadcast_en
''                                                             write_sgmii_broadcast_en
''---------------------------------------------------------------------------------
'' md_devad                                   [4:0]            get_md_devad
''                                                             set_md_devad
''                                                             read_md_devad
''                                                             write_md_devad
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plus2_mdio_ctl
    Private write_sgmii_broadcast_en_value
    Private read_sgmii_broadcast_en_value
    Private flag_sgmii_broadcast_en
    Private write_md_devad_value
    Private read_md_devad_value
    Private flag_md_devad

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H156
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sgmii_broadcast_en
        get_sgmii_broadcast_en = read_sgmii_broadcast_en_value
    End Property

    Property Let set_sgmii_broadcast_en(aData)
        write_sgmii_broadcast_en_value = aData
        flag_sgmii_broadcast_en        = &H1
    End Property

    Property Get read_sgmii_broadcast_en
        read
        read_sgmii_broadcast_en = read_sgmii_broadcast_en_value
    End Property

    Property Let write_sgmii_broadcast_en(aData)
        set_sgmii_broadcast_en = aData
        write
    End Property

    Property Get get_md_devad
        get_md_devad = read_md_devad_value
    End Property

    Property Let set_md_devad(aData)
        write_md_devad_value = aData
        flag_md_devad        = &H1
    End Property

    Property Get read_md_devad
        read
        read_md_devad = read_md_devad_value
    End Property

    Property Let write_md_devad(aData)
        set_md_devad = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_broadcast_en_value = rightShift(data_low, 9) and &H1
        md_devad_mask = &H1f
        if data_low > LONG_MAX then
            if md_devad_mask = mask then
                read_md_devad_value = data_low
            else
                read_md_devad_value = (data_low - H8000_0000) and md_devad_mask
            end If
        else
            read_md_devad_value = data_low and md_devad_mask
        end If

    End Sub

    Sub write
        If flag_sgmii_broadcast_en = &H0 or flag_md_devad = &H0 Then read
        If flag_sgmii_broadcast_en = &H0 Then write_sgmii_broadcast_en_value = get_sgmii_broadcast_en
        If flag_md_devad = &H0 Then write_md_devad_value = get_md_devad

        regValue = leftShift((write_sgmii_broadcast_en_value and &H1), 9) + leftShift((write_md_devad_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_broadcast_en_value = rightShift(data_low, 9) and &H1
        md_devad_mask = &H1f
        if data_low > LONG_MAX then
            if md_devad_mask = mask then
                read_md_devad_value = data_low
            else
                read_md_devad_value = (data_low - H8000_0000) and md_devad_mask
            end If
        else
            read_md_devad_value = data_low and md_devad_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_broadcast_en_value = &H0
        flag_sgmii_broadcast_en        = &H0
        write_md_devad_value = &H0
        flag_md_devad        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plus2_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_status                               [15:0]           get_sgmii_status
''                                                             set_sgmii_status
''                                                             read_sgmii_status
''                                                             write_sgmii_status
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plus2_status
    Private write_sgmii_status_value
    Private read_sgmii_status_value
    Private flag_sgmii_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H158
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sgmii_status
        get_sgmii_status = read_sgmii_status_value
    End Property

    Property Let set_sgmii_status(aData)
        write_sgmii_status_value = aData
        flag_sgmii_status        = &H1
    End Property

    Property Get read_sgmii_status
        read
        read_sgmii_status = read_sgmii_status_value
    End Property

    Property Let write_sgmii_status(aData)
        set_sgmii_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_status_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_status_mask = mask then
                read_sgmii_status_value = data_low
            else
                read_sgmii_status_value = (data_low - H8000_0000) and sgmii_status_mask
            end If
        else
            read_sgmii_status_value = data_low and sgmii_status_mask
        end If

    End Sub

    Sub write
        If flag_sgmii_status = &H0 Then read
        If flag_sgmii_status = &H0 Then write_sgmii_status_value = get_sgmii_status

        regValue = leftShift((write_sgmii_status_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_status_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_status_mask = mask then
                read_sgmii_status_value = data_low
            else
                read_sgmii_status_value = (data_low - H8000_0000) and sgmii_status_mask
            end If
        else
            read_sgmii_status_value = data_low and sgmii_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_status_value = &H0
        flag_sgmii_status        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_pcie_pwrdwn
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdwn                                     [0:0]            get_pwrdwn
''                                                             set_pwrdwn
''                                                             read_pwrdwn
''                                                             write_pwrdwn
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_pcie_pwrdwn
    Private write_pwrdwn_value
    Private read_pwrdwn_value
    Private flag_pwrdwn

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H160
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pwrdwn
        get_pwrdwn = read_pwrdwn_value
    End Property

    Property Let set_pwrdwn(aData)
        write_pwrdwn_value = aData
        flag_pwrdwn        = &H1
    End Property

    Property Get read_pwrdwn
        read
        read_pwrdwn = read_pwrdwn_value
    End Property

    Property Let write_pwrdwn(aData)
        set_pwrdwn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_mask = mask then
                read_pwrdwn_value = data_low
            else
                read_pwrdwn_value = (data_low - H8000_0000) and pwrdwn_mask
            end If
        else
            read_pwrdwn_value = data_low and pwrdwn_mask
        end If

    End Sub

    Sub write
        If flag_pwrdwn = &H0 Then read
        If flag_pwrdwn = &H0 Then write_pwrdwn_value = get_pwrdwn

        regValue = leftShift((write_pwrdwn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_mask = mask then
                read_pwrdwn_value = data_low
            else
                read_pwrdwn_value = (data_low - H8000_0000) and pwrdwn_mask
            end If
        else
            read_pwrdwn_value = data_low and pwrdwn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdwn_value = &H0
        flag_pwrdwn        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_pcie_hw_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' hw_rst_dly_val                             [14:0]           get_hw_rst_dly_val
''                                                             set_hw_rst_dly_val
''                                                             read_hw_rst_dly_val
''                                                             write_hw_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_pcie_hw_rst_dly_val
    Private write_hw_rst_dly_val_value
    Private read_hw_rst_dly_val_value
    Private flag_hw_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H162
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_hw_rst_dly_val
        get_hw_rst_dly_val = read_hw_rst_dly_val_value
    End Property

    Property Let set_hw_rst_dly_val(aData)
        write_hw_rst_dly_val_value = aData
        flag_hw_rst_dly_val        = &H1
    End Property

    Property Get read_hw_rst_dly_val
        read
        read_hw_rst_dly_val = read_hw_rst_dly_val_value
    End Property

    Property Let write_hw_rst_dly_val(aData)
        set_hw_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_rst_dly_val_mask = &H7fff
        if data_low > LONG_MAX then
            if hw_rst_dly_val_mask = mask then
                read_hw_rst_dly_val_value = data_low
            else
                read_hw_rst_dly_val_value = (data_low - H8000_0000) and hw_rst_dly_val_mask
            end If
        else
            read_hw_rst_dly_val_value = data_low and hw_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_hw_rst_dly_val = &H0 Then read
        If flag_hw_rst_dly_val = &H0 Then write_hw_rst_dly_val_value = get_hw_rst_dly_val

        regValue = leftShift((write_hw_rst_dly_val_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_rst_dly_val_mask = &H7fff
        if data_low > LONG_MAX then
            if hw_rst_dly_val_mask = mask then
                read_hw_rst_dly_val_value = data_low
            else
                read_hw_rst_dly_val_value = (data_low - H8000_0000) and hw_rst_dly_val_mask
            end If
        else
            read_hw_rst_dly_val_value = data_low and hw_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_hw_rst_dly_val_value = &H0
        flag_hw_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_pcie_mdio_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pcb_rd_ack_pos_sel                         [14:14]          get_pcb_rd_ack_pos_sel
''                                                             set_pcb_rd_ack_pos_sel
''                                                             read_pcb_rd_ack_pos_sel
''                                                             write_pcb_rd_ack_pos_sel
''---------------------------------------------------------------------------------
'' pcb_rd_cycle_len_sel                       [13:13]          get_pcb_rd_cycle_len_sel
''                                                             set_pcb_rd_cycle_len_sel
''                                                             read_pcb_rd_cycle_len_sel
''                                                             write_pcb_rd_cycle_len_sel
''---------------------------------------------------------------------------------
'' mdio_rst_dly_val                           [12:0]           get_mdio_rst_dly_val
''                                                             set_mdio_rst_dly_val
''                                                             read_mdio_rst_dly_val
''                                                             write_mdio_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_pcie_mdio_rst_dly_val
    Private write_pcb_rd_ack_pos_sel_value
    Private read_pcb_rd_ack_pos_sel_value
    Private flag_pcb_rd_ack_pos_sel
    Private write_pcb_rd_cycle_len_sel_value
    Private read_pcb_rd_cycle_len_sel_value
    Private flag_pcb_rd_cycle_len_sel
    Private write_mdio_rst_dly_val_value
    Private read_mdio_rst_dly_val_value
    Private flag_mdio_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H164
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pcb_rd_ack_pos_sel
        get_pcb_rd_ack_pos_sel = read_pcb_rd_ack_pos_sel_value
    End Property

    Property Let set_pcb_rd_ack_pos_sel(aData)
        write_pcb_rd_ack_pos_sel_value = aData
        flag_pcb_rd_ack_pos_sel        = &H1
    End Property

    Property Get read_pcb_rd_ack_pos_sel
        read
        read_pcb_rd_ack_pos_sel = read_pcb_rd_ack_pos_sel_value
    End Property

    Property Let write_pcb_rd_ack_pos_sel(aData)
        set_pcb_rd_ack_pos_sel = aData
        write
    End Property

    Property Get get_pcb_rd_cycle_len_sel
        get_pcb_rd_cycle_len_sel = read_pcb_rd_cycle_len_sel_value
    End Property

    Property Let set_pcb_rd_cycle_len_sel(aData)
        write_pcb_rd_cycle_len_sel_value = aData
        flag_pcb_rd_cycle_len_sel        = &H1
    End Property

    Property Get read_pcb_rd_cycle_len_sel
        read
        read_pcb_rd_cycle_len_sel = read_pcb_rd_cycle_len_sel_value
    End Property

    Property Let write_pcb_rd_cycle_len_sel(aData)
        set_pcb_rd_cycle_len_sel = aData
        write
    End Property

    Property Get get_mdio_rst_dly_val
        get_mdio_rst_dly_val = read_mdio_rst_dly_val_value
    End Property

    Property Let set_mdio_rst_dly_val(aData)
        write_mdio_rst_dly_val_value = aData
        flag_mdio_rst_dly_val        = &H1
    End Property

    Property Get read_mdio_rst_dly_val
        read
        read_mdio_rst_dly_val = read_mdio_rst_dly_val_value
    End Property

    Property Let write_mdio_rst_dly_val(aData)
        set_mdio_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pcb_rd_ack_pos_sel_value = rightShift(data_low, 14) and &H1
        read_pcb_rd_cycle_len_sel_value = rightShift(data_low, 13) and &H1
        mdio_rst_dly_val_mask = &H1fff
        if data_low > LONG_MAX then
            if mdio_rst_dly_val_mask = mask then
                read_mdio_rst_dly_val_value = data_low
            else
                read_mdio_rst_dly_val_value = (data_low - H8000_0000) and mdio_rst_dly_val_mask
            end If
        else
            read_mdio_rst_dly_val_value = data_low and mdio_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_pcb_rd_ack_pos_sel = &H0 or flag_pcb_rd_cycle_len_sel = &H0 or flag_mdio_rst_dly_val = &H0 Then read
        If flag_pcb_rd_ack_pos_sel = &H0 Then write_pcb_rd_ack_pos_sel_value = get_pcb_rd_ack_pos_sel
        If flag_pcb_rd_cycle_len_sel = &H0 Then write_pcb_rd_cycle_len_sel_value = get_pcb_rd_cycle_len_sel
        If flag_mdio_rst_dly_val = &H0 Then write_mdio_rst_dly_val_value = get_mdio_rst_dly_val

        regValue = leftShift((write_pcb_rd_ack_pos_sel_value and &H1), 14) + leftShift((write_pcb_rd_cycle_len_sel_value and &H1), 13) + leftShift((write_mdio_rst_dly_val_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pcb_rd_ack_pos_sel_value = rightShift(data_low, 14) and &H1
        read_pcb_rd_cycle_len_sel_value = rightShift(data_low, 13) and &H1
        mdio_rst_dly_val_mask = &H1fff
        if data_low > LONG_MAX then
            if mdio_rst_dly_val_mask = mask then
                read_mdio_rst_dly_val_value = data_low
            else
                read_mdio_rst_dly_val_value = (data_low - H8000_0000) and mdio_rst_dly_val_mask
            end If
        else
            read_mdio_rst_dly_val_value = data_low and mdio_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pcb_rd_ack_pos_sel_value = &H0
        flag_pcb_rd_ack_pos_sel        = &H0
        write_pcb_rd_cycle_len_sel_value = &H0
        flag_pcb_rd_cycle_len_sel        = &H0
        write_mdio_rst_dly_val_value = &H0
        flag_mdio_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_pcie_pll_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pcb_wr_ack_pos_sel                         [14:14]          get_pcb_wr_ack_pos_sel
''                                                             set_pcb_wr_ack_pos_sel
''                                                             read_pcb_wr_ack_pos_sel
''                                                             write_pcb_wr_ack_pos_sel
''---------------------------------------------------------------------------------
'' pcb_wr_cycle_len_sel                       [13:12]          get_pcb_wr_cycle_len_sel
''                                                             set_pcb_wr_cycle_len_sel
''                                                             read_pcb_wr_cycle_len_sel
''                                                             write_pcb_wr_cycle_len_sel
''---------------------------------------------------------------------------------
'' pll_rst_dly_val                            [11:0]           get_pll_rst_dly_val
''                                                             set_pll_rst_dly_val
''                                                             read_pll_rst_dly_val
''                                                             write_pll_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_pcie_pll_rst_dly_val
    Private write_pcb_wr_ack_pos_sel_value
    Private read_pcb_wr_ack_pos_sel_value
    Private flag_pcb_wr_ack_pos_sel
    Private write_pcb_wr_cycle_len_sel_value
    Private read_pcb_wr_cycle_len_sel_value
    Private flag_pcb_wr_cycle_len_sel
    Private write_pll_rst_dly_val_value
    Private read_pll_rst_dly_val_value
    Private flag_pll_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H166
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pcb_wr_ack_pos_sel
        get_pcb_wr_ack_pos_sel = read_pcb_wr_ack_pos_sel_value
    End Property

    Property Let set_pcb_wr_ack_pos_sel(aData)
        write_pcb_wr_ack_pos_sel_value = aData
        flag_pcb_wr_ack_pos_sel        = &H1
    End Property

    Property Get read_pcb_wr_ack_pos_sel
        read
        read_pcb_wr_ack_pos_sel = read_pcb_wr_ack_pos_sel_value
    End Property

    Property Let write_pcb_wr_ack_pos_sel(aData)
        set_pcb_wr_ack_pos_sel = aData
        write
    End Property

    Property Get get_pcb_wr_cycle_len_sel
        get_pcb_wr_cycle_len_sel = read_pcb_wr_cycle_len_sel_value
    End Property

    Property Let set_pcb_wr_cycle_len_sel(aData)
        write_pcb_wr_cycle_len_sel_value = aData
        flag_pcb_wr_cycle_len_sel        = &H1
    End Property

    Property Get read_pcb_wr_cycle_len_sel
        read
        read_pcb_wr_cycle_len_sel = read_pcb_wr_cycle_len_sel_value
    End Property

    Property Let write_pcb_wr_cycle_len_sel(aData)
        set_pcb_wr_cycle_len_sel = aData
        write
    End Property

    Property Get get_pll_rst_dly_val
        get_pll_rst_dly_val = read_pll_rst_dly_val_value
    End Property

    Property Let set_pll_rst_dly_val(aData)
        write_pll_rst_dly_val_value = aData
        flag_pll_rst_dly_val        = &H1
    End Property

    Property Get read_pll_rst_dly_val
        read
        read_pll_rst_dly_val = read_pll_rst_dly_val_value
    End Property

    Property Let write_pll_rst_dly_val(aData)
        set_pll_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pcb_wr_ack_pos_sel_value = rightShift(data_low, 14) and &H1
        read_pcb_wr_cycle_len_sel_value = rightShift(data_low, 12) and &H3
        pll_rst_dly_val_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_rst_dly_val_mask = mask then
                read_pll_rst_dly_val_value = data_low
            else
                read_pll_rst_dly_val_value = (data_low - H8000_0000) and pll_rst_dly_val_mask
            end If
        else
            read_pll_rst_dly_val_value = data_low and pll_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_pcb_wr_ack_pos_sel = &H0 or flag_pcb_wr_cycle_len_sel = &H0 or flag_pll_rst_dly_val = &H0 Then read
        If flag_pcb_wr_ack_pos_sel = &H0 Then write_pcb_wr_ack_pos_sel_value = get_pcb_wr_ack_pos_sel
        If flag_pcb_wr_cycle_len_sel = &H0 Then write_pcb_wr_cycle_len_sel_value = get_pcb_wr_cycle_len_sel
        If flag_pll_rst_dly_val = &H0 Then write_pll_rst_dly_val_value = get_pll_rst_dly_val

        regValue = leftShift((write_pcb_wr_ack_pos_sel_value and &H1), 14) + leftShift((write_pcb_wr_cycle_len_sel_value and &H3), 12) + leftShift((write_pll_rst_dly_val_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pcb_wr_ack_pos_sel_value = rightShift(data_low, 14) and &H1
        read_pcb_wr_cycle_len_sel_value = rightShift(data_low, 12) and &H3
        pll_rst_dly_val_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_rst_dly_val_mask = mask then
                read_pll_rst_dly_val_value = data_low
            else
                read_pll_rst_dly_val_value = (data_low - H8000_0000) and pll_rst_dly_val_mask
            end If
        else
            read_pll_rst_dly_val_value = data_low and pll_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pcb_wr_ack_pos_sel_value = &H0
        flag_pcb_wr_ack_pos_sel        = &H0
        write_pcb_wr_cycle_len_sel_value = &H0
        flag_pcb_wr_cycle_len_sel        = &H0
        write_pll_rst_dly_val_value = &H0
        flag_pll_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_pcie_ext_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rescal_autoload_en                         [11:11]          get_rescal_autoload_en
''                                                             set_rescal_autoload_en
''                                                             read_rescal_autoload_en
''                                                             write_rescal_autoload_en
''---------------------------------------------------------------------------------
'' refsel                                     [9:8]            get_refsel
''                                                             set_refsel
''                                                             read_refsel
''                                                             write_refsel
''---------------------------------------------------------------------------------
'' spare2                                     [7:5]            get_spare2
''                                                             set_spare2
''                                                             read_spare2
''                                                             write_spare2
''---------------------------------------------------------------------------------
'' rescal                                     [4:1]            get_rescal
''                                                             set_rescal
''                                                             read_rescal
''                                                             write_rescal
''---------------------------------------------------------------------------------
'' spare                                      [0:0]            get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_pcie_ext_ctl
    Private write_rescal_autoload_en_value
    Private read_rescal_autoload_en_value
    Private flag_rescal_autoload_en
    Private write_refsel_value
    Private read_refsel_value
    Private flag_refsel
    Private write_spare2_value
    Private read_spare2_value
    Private flag_spare2
    Private write_rescal_value
    Private read_rescal_value
    Private flag_rescal
    Private write_spare_value
    Private read_spare_value
    Private flag_spare

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H168
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rescal_autoload_en
        get_rescal_autoload_en = read_rescal_autoload_en_value
    End Property

    Property Let set_rescal_autoload_en(aData)
        write_rescal_autoload_en_value = aData
        flag_rescal_autoload_en        = &H1
    End Property

    Property Get read_rescal_autoload_en
        read
        read_rescal_autoload_en = read_rescal_autoload_en_value
    End Property

    Property Let write_rescal_autoload_en(aData)
        set_rescal_autoload_en = aData
        write
    End Property

    Property Get get_refsel
        get_refsel = read_refsel_value
    End Property

    Property Let set_refsel(aData)
        write_refsel_value = aData
        flag_refsel        = &H1
    End Property

    Property Get read_refsel
        read
        read_refsel = read_refsel_value
    End Property

    Property Let write_refsel(aData)
        set_refsel = aData
        write
    End Property

    Property Get get_spare2
        get_spare2 = read_spare2_value
    End Property

    Property Let set_spare2(aData)
        write_spare2_value = aData
        flag_spare2        = &H1
    End Property

    Property Get read_spare2
        read
        read_spare2 = read_spare2_value
    End Property

    Property Let write_spare2(aData)
        set_spare2 = aData
        write
    End Property

    Property Get get_rescal
        get_rescal = read_rescal_value
    End Property

    Property Let set_rescal(aData)
        write_rescal_value = aData
        flag_rescal        = &H1
    End Property

    Property Get read_rescal
        read
        read_rescal = read_rescal_value
    End Property

    Property Let write_rescal(aData)
        set_rescal = aData
        write
    End Property

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rescal_autoload_en_value = rightShift(data_low, 11) and &H1
        read_refsel_value = rightShift(data_low, 8) and &H3
        read_spare2_value = rightShift(data_low, 5) and &H7
        read_rescal_value = rightShift(data_low, 1) and &Hf
        spare_mask = &H1
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

    End Sub

    Sub write
        If flag_rescal_autoload_en = &H0 or flag_refsel = &H0 or flag_spare2 = &H0 or flag_rescal = &H0 or flag_spare = &H0 Then read
        If flag_rescal_autoload_en = &H0 Then write_rescal_autoload_en_value = get_rescal_autoload_en
        If flag_refsel = &H0 Then write_refsel_value = get_refsel
        If flag_spare2 = &H0 Then write_spare2_value = get_spare2
        If flag_rescal = &H0 Then write_rescal_value = get_rescal
        If flag_spare = &H0 Then write_spare_value = get_spare

        regValue = leftShift((write_rescal_autoload_en_value and &H1), 11) + leftShift((write_refsel_value and &H3), 8) + leftShift((write_spare2_value and &H7), 5) + leftShift((write_rescal_value and &Hf), 1) + leftShift((write_spare_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rescal_autoload_en_value = rightShift(data_low, 11) and &H1
        read_refsel_value = rightShift(data_low, 8) and &H3
        read_spare2_value = rightShift(data_low, 5) and &H7
        read_rescal_value = rightShift(data_low, 1) and &Hf
        spare_mask = &H1
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rescal_autoload_en_value = &H0
        flag_rescal_autoload_en        = &H0
        write_refsel_value = &H0
        flag_refsel        = &H0
        write_spare2_value = &H0
        flag_spare2        = &H0
        write_rescal_value = &H0
        flag_rescal        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_pcie_mdio_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' md_devad                                   [4:0]            get_md_devad
''                                                             set_md_devad
''                                                             read_md_devad
''                                                             write_md_devad
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_pcie_mdio_ctl
    Private write_md_devad_value
    Private read_md_devad_value
    Private flag_md_devad

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_md_devad
        get_md_devad = read_md_devad_value
    End Property

    Property Let set_md_devad(aData)
        write_md_devad_value = aData
        flag_md_devad        = &H1
    End Property

    Property Get read_md_devad
        read
        read_md_devad = read_md_devad_value
    End Property

    Property Let write_md_devad(aData)
        set_md_devad = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        md_devad_mask = &H1f
        if data_low > LONG_MAX then
            if md_devad_mask = mask then
                read_md_devad_value = data_low
            else
                read_md_devad_value = (data_low - H8000_0000) and md_devad_mask
            end If
        else
            read_md_devad_value = data_low and md_devad_mask
        end If

    End Sub

    Sub write
        If flag_md_devad = &H0 Then read
        If flag_md_devad = &H0 Then write_md_devad_value = get_md_devad

        regValue = leftShift((write_md_devad_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        md_devad_mask = &H1f
        if data_low > LONG_MAX then
            if md_devad_mask = mask then
                read_md_devad_value = data_low
            else
                read_md_devad_value = (data_low - H8000_0000) and md_devad_mask
            end If
        else
            read_md_devad_value = data_low and md_devad_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_md_devad_value = &H0
        flag_md_devad        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_pcie_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_pcie_status                          [15:0]           get_sgmii_pcie_status
''                                                             set_sgmii_pcie_status
''                                                             read_sgmii_pcie_status
''                                                             write_sgmii_pcie_status
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_pcie_status
    Private write_sgmii_pcie_status_value
    Private read_sgmii_pcie_status_value
    Private flag_sgmii_pcie_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sgmii_pcie_status
        get_sgmii_pcie_status = read_sgmii_pcie_status_value
    End Property

    Property Let set_sgmii_pcie_status(aData)
        write_sgmii_pcie_status_value = aData
        flag_sgmii_pcie_status        = &H1
    End Property

    Property Get read_sgmii_pcie_status
        read
        read_sgmii_pcie_status = read_sgmii_pcie_status_value
    End Property

    Property Let write_sgmii_pcie_status(aData)
        set_sgmii_pcie_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_pcie_status_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_pcie_status_mask = mask then
                read_sgmii_pcie_status_value = data_low
            else
                read_sgmii_pcie_status_value = (data_low - H8000_0000) and sgmii_pcie_status_mask
            end If
        else
            read_sgmii_pcie_status_value = data_low and sgmii_pcie_status_mask
        end If

    End Sub

    Sub write
        If flag_sgmii_pcie_status = &H0 Then read
        If flag_sgmii_pcie_status = &H0 Then write_sgmii_pcie_status_value = get_sgmii_pcie_status

        regValue = leftShift((write_sgmii_pcie_status_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_pcie_status_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_pcie_status_mask = mask then
                read_sgmii_pcie_status_value = data_low
            else
                read_sgmii_pcie_status_value = (data_low - H8000_0000) and sgmii_pcie_status_mask
            end If
        else
            read_sgmii_pcie_status_value = data_low and sgmii_pcie_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_pcie_status_value = &H0
        flag_sgmii_pcie_status        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_afe_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare15to5                                 [15:5]           get_spare15to5
''                                                             set_spare15to5
''                                                             read_spare15to5
''                                                             write_spare15to5
''---------------------------------------------------------------------------------
'' afe_cal_done                               [4:4]            get_afe_cal_done
''                                                             set_afe_cal_done
''                                                             read_afe_cal_done
''                                                             write_afe_cal_done
''---------------------------------------------------------------------------------
'' spare3                                     [3:3]            get_spare3
''                                                             set_spare3
''                                                             read_spare3
''                                                             write_spare3
''---------------------------------------------------------------------------------
'' sgmii_txpll_lock1                          [2:2]            get_sgmii_txpll_lock1
''                                                             set_sgmii_txpll_lock1
''                                                             read_sgmii_txpll_lock1
''                                                             write_sgmii_txpll_lock1
''---------------------------------------------------------------------------------
'' sgmii_pcie_txpll_lock                      [1:1]            get_sgmii_pcie_txpll_lock
''                                                             set_sgmii_pcie_txpll_lock
''                                                             read_sgmii_pcie_txpll_lock
''                                                             write_sgmii_pcie_txpll_lock
''---------------------------------------------------------------------------------
'' sgmii_txpll_lock0                          [0:0]            get_sgmii_txpll_lock0
''                                                             set_sgmii_txpll_lock0
''                                                             read_sgmii_txpll_lock0
''                                                             write_sgmii_txpll_lock0
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_afe_status
    Private write_spare15to5_value
    Private read_spare15to5_value
    Private flag_spare15to5
    Private write_afe_cal_done_value
    Private read_afe_cal_done_value
    Private flag_afe_cal_done
    Private write_spare3_value
    Private read_spare3_value
    Private flag_spare3
    Private write_sgmii_txpll_lock1_value
    Private read_sgmii_txpll_lock1_value
    Private flag_sgmii_txpll_lock1
    Private write_sgmii_pcie_txpll_lock_value
    Private read_sgmii_pcie_txpll_lock_value
    Private flag_sgmii_pcie_txpll_lock
    Private write_sgmii_txpll_lock0_value
    Private read_sgmii_txpll_lock0_value
    Private flag_sgmii_txpll_lock0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare15to5
        get_spare15to5 = read_spare15to5_value
    End Property

    Property Let set_spare15to5(aData)
        write_spare15to5_value = aData
        flag_spare15to5        = &H1
    End Property

    Property Get read_spare15to5
        read
        read_spare15to5 = read_spare15to5_value
    End Property

    Property Let write_spare15to5(aData)
        set_spare15to5 = aData
        write
    End Property

    Property Get get_afe_cal_done
        get_afe_cal_done = read_afe_cal_done_value
    End Property

    Property Let set_afe_cal_done(aData)
        write_afe_cal_done_value = aData
        flag_afe_cal_done        = &H1
    End Property

    Property Get read_afe_cal_done
        read
        read_afe_cal_done = read_afe_cal_done_value
    End Property

    Property Let write_afe_cal_done(aData)
        set_afe_cal_done = aData
        write
    End Property

    Property Get get_spare3
        get_spare3 = read_spare3_value
    End Property

    Property Let set_spare3(aData)
        write_spare3_value = aData
        flag_spare3        = &H1
    End Property

    Property Get read_spare3
        read
        read_spare3 = read_spare3_value
    End Property

    Property Let write_spare3(aData)
        set_spare3 = aData
        write
    End Property

    Property Get get_sgmii_txpll_lock1
        get_sgmii_txpll_lock1 = read_sgmii_txpll_lock1_value
    End Property

    Property Let set_sgmii_txpll_lock1(aData)
        write_sgmii_txpll_lock1_value = aData
        flag_sgmii_txpll_lock1        = &H1
    End Property

    Property Get read_sgmii_txpll_lock1
        read
        read_sgmii_txpll_lock1 = read_sgmii_txpll_lock1_value
    End Property

    Property Let write_sgmii_txpll_lock1(aData)
        set_sgmii_txpll_lock1 = aData
        write
    End Property

    Property Get get_sgmii_pcie_txpll_lock
        get_sgmii_pcie_txpll_lock = read_sgmii_pcie_txpll_lock_value
    End Property

    Property Let set_sgmii_pcie_txpll_lock(aData)
        write_sgmii_pcie_txpll_lock_value = aData
        flag_sgmii_pcie_txpll_lock        = &H1
    End Property

    Property Get read_sgmii_pcie_txpll_lock
        read
        read_sgmii_pcie_txpll_lock = read_sgmii_pcie_txpll_lock_value
    End Property

    Property Let write_sgmii_pcie_txpll_lock(aData)
        set_sgmii_pcie_txpll_lock = aData
        write
    End Property

    Property Get get_sgmii_txpll_lock0
        get_sgmii_txpll_lock0 = read_sgmii_txpll_lock0_value
    End Property

    Property Let set_sgmii_txpll_lock0(aData)
        write_sgmii_txpll_lock0_value = aData
        flag_sgmii_txpll_lock0        = &H1
    End Property

    Property Get read_sgmii_txpll_lock0
        read
        read_sgmii_txpll_lock0 = read_sgmii_txpll_lock0_value
    End Property

    Property Let write_sgmii_txpll_lock0(aData)
        set_sgmii_txpll_lock0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare15to5_value = rightShift(data_low, 5) and &H7ff
        read_afe_cal_done_value = rightShift(data_low, 4) and &H1
        read_spare3_value = rightShift(data_low, 3) and &H1
        read_sgmii_txpll_lock1_value = rightShift(data_low, 2) and &H1
        read_sgmii_pcie_txpll_lock_value = rightShift(data_low, 1) and &H1
        sgmii_txpll_lock0_mask = &H1
        if data_low > LONG_MAX then
            if sgmii_txpll_lock0_mask = mask then
                read_sgmii_txpll_lock0_value = data_low
            else
                read_sgmii_txpll_lock0_value = (data_low - H8000_0000) and sgmii_txpll_lock0_mask
            end If
        else
            read_sgmii_txpll_lock0_value = data_low and sgmii_txpll_lock0_mask
        end If

    End Sub

    Sub write
        If flag_spare15to5 = &H0 or flag_afe_cal_done = &H0 or flag_spare3 = &H0 or flag_sgmii_txpll_lock1 = &H0 or flag_sgmii_pcie_txpll_lock = &H0 or flag_sgmii_txpll_lock0 = &H0 Then read
        If flag_spare15to5 = &H0 Then write_spare15to5_value = get_spare15to5
        If flag_afe_cal_done = &H0 Then write_afe_cal_done_value = get_afe_cal_done
        If flag_spare3 = &H0 Then write_spare3_value = get_spare3
        If flag_sgmii_txpll_lock1 = &H0 Then write_sgmii_txpll_lock1_value = get_sgmii_txpll_lock1
        If flag_sgmii_pcie_txpll_lock = &H0 Then write_sgmii_pcie_txpll_lock_value = get_sgmii_pcie_txpll_lock
        If flag_sgmii_txpll_lock0 = &H0 Then write_sgmii_txpll_lock0_value = get_sgmii_txpll_lock0

        regValue = leftShift((write_spare15to5_value and &H7ff), 5) + leftShift((write_afe_cal_done_value and &H1), 4) + leftShift((write_spare3_value and &H1), 3) + leftShift((write_sgmii_txpll_lock1_value and &H1), 2) + leftShift((write_sgmii_pcie_txpll_lock_value and &H1), 1) + leftShift((write_sgmii_txpll_lock0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare15to5_value = rightShift(data_low, 5) and &H7ff
        read_afe_cal_done_value = rightShift(data_low, 4) and &H1
        read_spare3_value = rightShift(data_low, 3) and &H1
        read_sgmii_txpll_lock1_value = rightShift(data_low, 2) and &H1
        read_sgmii_pcie_txpll_lock_value = rightShift(data_low, 1) and &H1
        sgmii_txpll_lock0_mask = &H1
        if data_low > LONG_MAX then
            if sgmii_txpll_lock0_mask = mask then
                read_sgmii_txpll_lock0_value = data_low
            else
                read_sgmii_txpll_lock0_value = (data_low - H8000_0000) and sgmii_txpll_lock0_mask
            end If
        else
            read_sgmii_txpll_lock0_value = data_low and sgmii_txpll_lock0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare15to5_value = &H0
        flag_spare15to5        = &H0
        write_afe_cal_done_value = &H0
        flag_afe_cal_done        = &H0
        write_spare3_value = &H0
        flag_spare3        = &H0
        write_sgmii_txpll_lock1_value = &H0
        flag_sgmii_txpll_lock1        = &H0
        write_sgmii_pcie_txpll_lock_value = &H0
        flag_sgmii_pcie_txpll_lock        = &H0
        write_sgmii_txpll_lock0_value = &H0
        flag_sgmii_txpll_lock0        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plusr_pwrdwn
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pwrdwn                                     [0:0]            get_pwrdwn
''                                                             set_pwrdwn
''                                                             read_pwrdwn
''                                                             write_pwrdwn
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plusr_pwrdwn
    Private write_pwrdwn_value
    Private read_pwrdwn_value
    Private flag_pwrdwn

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H170
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pwrdwn
        get_pwrdwn = read_pwrdwn_value
    End Property

    Property Let set_pwrdwn(aData)
        write_pwrdwn_value = aData
        flag_pwrdwn        = &H1
    End Property

    Property Get read_pwrdwn
        read
        read_pwrdwn = read_pwrdwn_value
    End Property

    Property Let write_pwrdwn(aData)
        set_pwrdwn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_mask = mask then
                read_pwrdwn_value = data_low
            else
                read_pwrdwn_value = (data_low - H8000_0000) and pwrdwn_mask
            end If
        else
            read_pwrdwn_value = data_low and pwrdwn_mask
        end If

    End Sub

    Sub write
        If flag_pwrdwn = &H0 Then read
        If flag_pwrdwn = &H0 Then write_pwrdwn_value = get_pwrdwn

        regValue = leftShift((write_pwrdwn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pwrdwn_mask = &H1
        if data_low > LONG_MAX then
            if pwrdwn_mask = mask then
                read_pwrdwn_value = data_low
            else
                read_pwrdwn_value = (data_low - H8000_0000) and pwrdwn_mask
            end If
        else
            read_pwrdwn_value = data_low and pwrdwn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pwrdwn_value = &H0
        flag_pwrdwn        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plusr_hw_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' hw_rst_dly_val                             [14:0]           get_hw_rst_dly_val
''                                                             set_hw_rst_dly_val
''                                                             read_hw_rst_dly_val
''                                                             write_hw_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plusr_hw_rst_dly_val
    Private write_hw_rst_dly_val_value
    Private read_hw_rst_dly_val_value
    Private flag_hw_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H172
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_hw_rst_dly_val
        get_hw_rst_dly_val = read_hw_rst_dly_val_value
    End Property

    Property Let set_hw_rst_dly_val(aData)
        write_hw_rst_dly_val_value = aData
        flag_hw_rst_dly_val        = &H1
    End Property

    Property Get read_hw_rst_dly_val
        read
        read_hw_rst_dly_val = read_hw_rst_dly_val_value
    End Property

    Property Let write_hw_rst_dly_val(aData)
        set_hw_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_rst_dly_val_mask = &H7fff
        if data_low > LONG_MAX then
            if hw_rst_dly_val_mask = mask then
                read_hw_rst_dly_val_value = data_low
            else
                read_hw_rst_dly_val_value = (data_low - H8000_0000) and hw_rst_dly_val_mask
            end If
        else
            read_hw_rst_dly_val_value = data_low and hw_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_hw_rst_dly_val = &H0 Then read
        If flag_hw_rst_dly_val = &H0 Then write_hw_rst_dly_val_value = get_hw_rst_dly_val

        regValue = leftShift((write_hw_rst_dly_val_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        hw_rst_dly_val_mask = &H7fff
        if data_low > LONG_MAX then
            if hw_rst_dly_val_mask = mask then
                read_hw_rst_dly_val_value = data_low
            else
                read_hw_rst_dly_val_value = (data_low - H8000_0000) and hw_rst_dly_val_mask
            end If
        else
            read_hw_rst_dly_val_value = data_low and hw_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_hw_rst_dly_val_value = &H0
        flag_hw_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plusr_pll_rst_dly_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_rst_dly_val                            [11:0]           get_pll_rst_dly_val
''                                                             set_pll_rst_dly_val
''                                                             read_pll_rst_dly_val
''                                                             write_pll_rst_dly_val
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plusr_pll_rst_dly_val
    Private write_pll_rst_dly_val_value
    Private read_pll_rst_dly_val_value
    Private flag_pll_rst_dly_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H176
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll_rst_dly_val
        get_pll_rst_dly_val = read_pll_rst_dly_val_value
    End Property

    Property Let set_pll_rst_dly_val(aData)
        write_pll_rst_dly_val_value = aData
        flag_pll_rst_dly_val        = &H1
    End Property

    Property Get read_pll_rst_dly_val
        read
        read_pll_rst_dly_val = read_pll_rst_dly_val_value
    End Property

    Property Let write_pll_rst_dly_val(aData)
        set_pll_rst_dly_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_rst_dly_val_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_rst_dly_val_mask = mask then
                read_pll_rst_dly_val_value = data_low
            else
                read_pll_rst_dly_val_value = (data_low - H8000_0000) and pll_rst_dly_val_mask
            end If
        else
            read_pll_rst_dly_val_value = data_low and pll_rst_dly_val_mask
        end If

    End Sub

    Sub write
        If flag_pll_rst_dly_val = &H0 Then read
        If flag_pll_rst_dly_val = &H0 Then write_pll_rst_dly_val_value = get_pll_rst_dly_val

        regValue = leftShift((write_pll_rst_dly_val_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_rst_dly_val_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_rst_dly_val_mask = mask then
                read_pll_rst_dly_val_value = data_low
            else
                read_pll_rst_dly_val_value = (data_low - H8000_0000) and pll_rst_dly_val_mask
            end If
        else
            read_pll_rst_dly_val_value = data_low and pll_rst_dly_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_rst_dly_val_value = &H0
        flag_pll_rst_dly_val        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plusr_ext_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rescal_autoload_en                         [11:11]          get_rescal_autoload_en
''                                                             set_rescal_autoload_en
''                                                             read_rescal_autoload_en
''                                                             write_rescal_autoload_en
''---------------------------------------------------------------------------------
'' refsel                                     [9:8]            get_refsel
''                                                             set_refsel
''                                                             read_refsel
''                                                             write_refsel
''---------------------------------------------------------------------------------
'' rescal                                     [7:4]            get_rescal
''                                                             set_rescal
''                                                             read_rescal
''                                                             write_rescal
''---------------------------------------------------------------------------------
'' spare                                      [3:0]            get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plusr_ext_ctl
    Private write_rescal_autoload_en_value
    Private read_rescal_autoload_en_value
    Private flag_rescal_autoload_en
    Private write_refsel_value
    Private read_refsel_value
    Private flag_refsel
    Private write_rescal_value
    Private read_rescal_value
    Private flag_rescal
    Private write_spare_value
    Private read_spare_value
    Private flag_spare

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H178
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rescal_autoload_en
        get_rescal_autoload_en = read_rescal_autoload_en_value
    End Property

    Property Let set_rescal_autoload_en(aData)
        write_rescal_autoload_en_value = aData
        flag_rescal_autoload_en        = &H1
    End Property

    Property Get read_rescal_autoload_en
        read
        read_rescal_autoload_en = read_rescal_autoload_en_value
    End Property

    Property Let write_rescal_autoload_en(aData)
        set_rescal_autoload_en = aData
        write
    End Property

    Property Get get_refsel
        get_refsel = read_refsel_value
    End Property

    Property Let set_refsel(aData)
        write_refsel_value = aData
        flag_refsel        = &H1
    End Property

    Property Get read_refsel
        read
        read_refsel = read_refsel_value
    End Property

    Property Let write_refsel(aData)
        set_refsel = aData
        write
    End Property

    Property Get get_rescal
        get_rescal = read_rescal_value
    End Property

    Property Let set_rescal(aData)
        write_rescal_value = aData
        flag_rescal        = &H1
    End Property

    Property Get read_rescal
        read
        read_rescal = read_rescal_value
    End Property

    Property Let write_rescal(aData)
        set_rescal = aData
        write
    End Property

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rescal_autoload_en_value = rightShift(data_low, 11) and &H1
        read_refsel_value = rightShift(data_low, 8) and &H3
        read_rescal_value = rightShift(data_low, 4) and &Hf
        spare_mask = &Hf
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

    End Sub

    Sub write
        If flag_rescal_autoload_en = &H0 or flag_refsel = &H0 or flag_rescal = &H0 or flag_spare = &H0 Then read
        If flag_rescal_autoload_en = &H0 Then write_rescal_autoload_en_value = get_rescal_autoload_en
        If flag_refsel = &H0 Then write_refsel_value = get_refsel
        If flag_rescal = &H0 Then write_rescal_value = get_rescal
        If flag_spare = &H0 Then write_spare_value = get_spare

        regValue = leftShift((write_rescal_autoload_en_value and &H1), 11) + leftShift((write_refsel_value and &H3), 8) + leftShift((write_rescal_value and &Hf), 4) + leftShift((write_spare_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rescal_autoload_en_value = rightShift(data_low, 11) and &H1
        read_refsel_value = rightShift(data_low, 8) and &H3
        read_rescal_value = rightShift(data_low, 4) and &Hf
        spare_mask = &Hf
        if data_low > LONG_MAX then
            if spare_mask = mask then
                read_spare_value = data_low
            else
                read_spare_value = (data_low - H8000_0000) and spare_mask
            end If
        else
            read_spare_value = data_low and spare_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rescal_autoload_en_value = &H0
        flag_rescal_autoload_en        = &H0
        write_refsel_value = &H0
        flag_refsel        = &H0
        write_rescal_value = &H0
        flag_rescal        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plusr_mdio_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_mdio_fast_mode                       [10:10]          get_sgmii_mdio_fast_mode
''                                                             set_sgmii_mdio_fast_mode
''                                                             read_sgmii_mdio_fast_mode
''                                                             write_sgmii_mdio_fast_mode
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plusr_mdio_ctl
    Private write_sgmii_mdio_fast_mode_value
    Private read_sgmii_mdio_fast_mode_value
    Private flag_sgmii_mdio_fast_mode

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sgmii_mdio_fast_mode
        get_sgmii_mdio_fast_mode = read_sgmii_mdio_fast_mode_value
    End Property

    Property Let set_sgmii_mdio_fast_mode(aData)
        write_sgmii_mdio_fast_mode_value = aData
        flag_sgmii_mdio_fast_mode        = &H1
    End Property

    Property Get read_sgmii_mdio_fast_mode
        read
        read_sgmii_mdio_fast_mode = read_sgmii_mdio_fast_mode_value
    End Property

    Property Let write_sgmii_mdio_fast_mode(aData)
        set_sgmii_mdio_fast_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_mdio_fast_mode_value = rightShift(data_low, 10) and &H1

    End Sub

    Sub write
        If flag_sgmii_mdio_fast_mode = &H0 Then read
        If flag_sgmii_mdio_fast_mode = &H0 Then write_sgmii_mdio_fast_mode_value = get_sgmii_mdio_fast_mode

        regValue = leftShift((write_sgmii_mdio_fast_mode_value and &H1), 10)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_mdio_fast_mode_value = rightShift(data_low, 10) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_mdio_fast_mode_value = &H0
        flag_sgmii_mdio_fast_mode        = &H0
    End Sub
End Class


'' @REGISTER : MISC_sgmii_plusr_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_status                               [15:0]           get_sgmii_status
''                                                             set_sgmii_status
''                                                             read_sgmii_status
''                                                             write_sgmii_status
''---------------------------------------------------------------------------------
Class REGISTER_MISC_sgmii_plusr_status
    Private write_sgmii_status_value
    Private read_sgmii_status_value
    Private flag_sgmii_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sgmii_status
        get_sgmii_status = read_sgmii_status_value
    End Property

    Property Let set_sgmii_status(aData)
        write_sgmii_status_value = aData
        flag_sgmii_status        = &H1
    End Property

    Property Get read_sgmii_status
        read
        read_sgmii_status = read_sgmii_status_value
    End Property

    Property Let write_sgmii_status(aData)
        set_sgmii_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_status_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_status_mask = mask then
                read_sgmii_status_value = data_low
            else
                read_sgmii_status_value = (data_low - H8000_0000) and sgmii_status_mask
            end If
        else
            read_sgmii_status_value = data_low and sgmii_status_mask
        end If

    End Sub

    Sub write
        If flag_sgmii_status = &H0 Then read
        If flag_sgmii_status = &H0 Then write_sgmii_status_value = get_sgmii_status

        regValue = leftShift((write_sgmii_status_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sgmii_status_mask = &Hffff
        if data_low > LONG_MAX then
            if sgmii_status_mask = mask then
                read_sgmii_status_value = data_low
            else
                read_sgmii_status_value = (data_low - H8000_0000) and sgmii_status_mask
            end If
        else
            read_sgmii_status_value = data_low and sgmii_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_status_value = &H0
        flag_sgmii_status        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_3p3_en                                [15:15]          get_vmon_3p3_en
''                                                             set_vmon_3p3_en
''                                                             read_vmon_3p3_en
''                                                             write_vmon_3p3_en
''---------------------------------------------------------------------------------
'' vmon_1p8_en                                [14:14]          get_vmon_1p8_en
''                                                             set_vmon_1p8_en
''                                                             read_vmon_1p8_en
''                                                             write_vmon_1p8_en
''---------------------------------------------------------------------------------
'' vmon_1v_en                                 [13:13]          get_vmon_1v_en
''                                                             set_vmon_1v_en
''                                                             read_vmon_1v_en
''                                                             write_vmon_1v_en
''---------------------------------------------------------------------------------
'' tmon_en                                    [12:12]          get_tmon_en
''                                                             set_tmon_en
''                                                             read_tmon_en
''                                                             write_tmon_en
''---------------------------------------------------------------------------------
'' pvtmon_ext_intr_en                         [11:11]          get_pvtmon_ext_intr_en
''                                                             set_pvtmon_ext_intr_en
''                                                             read_pvtmon_ext_intr_en
''                                                             write_pvtmon_ext_intr_en
''---------------------------------------------------------------------------------
'' pvtmon_intr_en                             [10:10]          get_pvtmon_intr_en
''                                                             set_pvtmon_intr_en
''                                                             read_pvtmon_intr_en
''                                                             write_pvtmon_intr_en
''---------------------------------------------------------------------------------
'' clksel                                     [9:8]            get_clksel
''                                                             set_clksel
''                                                             read_clksel
''                                                             write_clksel
''---------------------------------------------------------------------------------
'' i_PVTMON_sel                               [6:4]            get_i_PVTMON_sel
''                                                             set_i_PVTMON_sel
''                                                             read_i_PVTMON_sel
''                                                             write_i_PVTMON_sel
''---------------------------------------------------------------------------------
'' auto_mode                                  [1:1]            get_auto_mode
''                                                             set_auto_mode
''                                                             read_auto_mode
''                                                             write_auto_mode
''---------------------------------------------------------------------------------
'' i_pwrdn                                    [0:0]            get_i_pwrdn
''                                                             set_i_pwrdn
''                                                             read_i_pwrdn
''                                                             write_i_pwrdn
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_ctrl
    Private write_vmon_3p3_en_value
    Private read_vmon_3p3_en_value
    Private flag_vmon_3p3_en
    Private write_vmon_1p8_en_value
    Private read_vmon_1p8_en_value
    Private flag_vmon_1p8_en
    Private write_vmon_1v_en_value
    Private read_vmon_1v_en_value
    Private flag_vmon_1v_en
    Private write_tmon_en_value
    Private read_tmon_en_value
    Private flag_tmon_en
    Private write_pvtmon_ext_intr_en_value
    Private read_pvtmon_ext_intr_en_value
    Private flag_pvtmon_ext_intr_en
    Private write_pvtmon_intr_en_value
    Private read_pvtmon_intr_en_value
    Private flag_pvtmon_intr_en
    Private write_clksel_value
    Private read_clksel_value
    Private flag_clksel
    Private write_i_PVTMON_sel_value
    Private read_i_PVTMON_sel_value
    Private flag_i_PVTMON_sel
    Private write_auto_mode_value
    Private read_auto_mode_value
    Private flag_auto_mode
    Private write_i_pwrdn_value
    Private read_i_pwrdn_value
    Private flag_i_pwrdn

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_3p3_en
        get_vmon_3p3_en = read_vmon_3p3_en_value
    End Property

    Property Let set_vmon_3p3_en(aData)
        write_vmon_3p3_en_value = aData
        flag_vmon_3p3_en        = &H1
    End Property

    Property Get read_vmon_3p3_en
        read
        read_vmon_3p3_en = read_vmon_3p3_en_value
    End Property

    Property Let write_vmon_3p3_en(aData)
        set_vmon_3p3_en = aData
        write
    End Property

    Property Get get_vmon_1p8_en
        get_vmon_1p8_en = read_vmon_1p8_en_value
    End Property

    Property Let set_vmon_1p8_en(aData)
        write_vmon_1p8_en_value = aData
        flag_vmon_1p8_en        = &H1
    End Property

    Property Get read_vmon_1p8_en
        read
        read_vmon_1p8_en = read_vmon_1p8_en_value
    End Property

    Property Let write_vmon_1p8_en(aData)
        set_vmon_1p8_en = aData
        write
    End Property

    Property Get get_vmon_1v_en
        get_vmon_1v_en = read_vmon_1v_en_value
    End Property

    Property Let set_vmon_1v_en(aData)
        write_vmon_1v_en_value = aData
        flag_vmon_1v_en        = &H1
    End Property

    Property Get read_vmon_1v_en
        read
        read_vmon_1v_en = read_vmon_1v_en_value
    End Property

    Property Let write_vmon_1v_en(aData)
        set_vmon_1v_en = aData
        write
    End Property

    Property Get get_tmon_en
        get_tmon_en = read_tmon_en_value
    End Property

    Property Let set_tmon_en(aData)
        write_tmon_en_value = aData
        flag_tmon_en        = &H1
    End Property

    Property Get read_tmon_en
        read
        read_tmon_en = read_tmon_en_value
    End Property

    Property Let write_tmon_en(aData)
        set_tmon_en = aData
        write
    End Property

    Property Get get_pvtmon_ext_intr_en
        get_pvtmon_ext_intr_en = read_pvtmon_ext_intr_en_value
    End Property

    Property Let set_pvtmon_ext_intr_en(aData)
        write_pvtmon_ext_intr_en_value = aData
        flag_pvtmon_ext_intr_en        = &H1
    End Property

    Property Get read_pvtmon_ext_intr_en
        read
        read_pvtmon_ext_intr_en = read_pvtmon_ext_intr_en_value
    End Property

    Property Let write_pvtmon_ext_intr_en(aData)
        set_pvtmon_ext_intr_en = aData
        write
    End Property

    Property Get get_pvtmon_intr_en
        get_pvtmon_intr_en = read_pvtmon_intr_en_value
    End Property

    Property Let set_pvtmon_intr_en(aData)
        write_pvtmon_intr_en_value = aData
        flag_pvtmon_intr_en        = &H1
    End Property

    Property Get read_pvtmon_intr_en
        read
        read_pvtmon_intr_en = read_pvtmon_intr_en_value
    End Property

    Property Let write_pvtmon_intr_en(aData)
        set_pvtmon_intr_en = aData
        write
    End Property

    Property Get get_clksel
        get_clksel = read_clksel_value
    End Property

    Property Let set_clksel(aData)
        write_clksel_value = aData
        flag_clksel        = &H1
    End Property

    Property Get read_clksel
        read
        read_clksel = read_clksel_value
    End Property

    Property Let write_clksel(aData)
        set_clksel = aData
        write
    End Property

    Property Get get_i_PVTMON_sel
        get_i_PVTMON_sel = read_i_PVTMON_sel_value
    End Property

    Property Let set_i_PVTMON_sel(aData)
        write_i_PVTMON_sel_value = aData
        flag_i_PVTMON_sel        = &H1
    End Property

    Property Get read_i_PVTMON_sel
        read
        read_i_PVTMON_sel = read_i_PVTMON_sel_value
    End Property

    Property Let write_i_PVTMON_sel(aData)
        set_i_PVTMON_sel = aData
        write
    End Property

    Property Get get_auto_mode
        get_auto_mode = read_auto_mode_value
    End Property

    Property Let set_auto_mode(aData)
        write_auto_mode_value = aData
        flag_auto_mode        = &H1
    End Property

    Property Get read_auto_mode
        read
        read_auto_mode = read_auto_mode_value
    End Property

    Property Let write_auto_mode(aData)
        set_auto_mode = aData
        write
    End Property

    Property Get get_i_pwrdn
        get_i_pwrdn = read_i_pwrdn_value
    End Property

    Property Let set_i_pwrdn(aData)
        write_i_pwrdn_value = aData
        flag_i_pwrdn        = &H1
    End Property

    Property Get read_i_pwrdn
        read
        read_i_pwrdn = read_i_pwrdn_value
    End Property

    Property Let write_i_pwrdn(aData)
        set_i_pwrdn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3_en_value = rightShift(data_low, 15) and &H1
        read_vmon_1p8_en_value = rightShift(data_low, 14) and &H1
        read_vmon_1v_en_value = rightShift(data_low, 13) and &H1
        read_tmon_en_value = rightShift(data_low, 12) and &H1
        read_pvtmon_ext_intr_en_value = rightShift(data_low, 11) and &H1
        read_pvtmon_intr_en_value = rightShift(data_low, 10) and &H1
        read_clksel_value = rightShift(data_low, 8) and &H3
        read_i_PVTMON_sel_value = rightShift(data_low, 4) and &H7
        read_auto_mode_value = rightShift(data_low, 1) and &H1
        i_pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if i_pwrdn_mask = mask then
                read_i_pwrdn_value = data_low
            else
                read_i_pwrdn_value = (data_low - H8000_0000) and i_pwrdn_mask
            end If
        else
            read_i_pwrdn_value = data_low and i_pwrdn_mask
        end If

    End Sub

    Sub write
        If flag_vmon_3p3_en = &H0 or flag_vmon_1p8_en = &H0 or flag_vmon_1v_en = &H0 or flag_tmon_en = &H0 or flag_pvtmon_ext_intr_en = &H0 or flag_pvtmon_intr_en = &H0 or flag_clksel = &H0 or flag_i_PVTMON_sel = &H0 or flag_auto_mode = &H0 or flag_i_pwrdn = &H0 Then read
        If flag_vmon_3p3_en = &H0 Then write_vmon_3p3_en_value = get_vmon_3p3_en
        If flag_vmon_1p8_en = &H0 Then write_vmon_1p8_en_value = get_vmon_1p8_en
        If flag_vmon_1v_en = &H0 Then write_vmon_1v_en_value = get_vmon_1v_en
        If flag_tmon_en = &H0 Then write_tmon_en_value = get_tmon_en
        If flag_pvtmon_ext_intr_en = &H0 Then write_pvtmon_ext_intr_en_value = get_pvtmon_ext_intr_en
        If flag_pvtmon_intr_en = &H0 Then write_pvtmon_intr_en_value = get_pvtmon_intr_en
        If flag_clksel = &H0 Then write_clksel_value = get_clksel
        If flag_i_PVTMON_sel = &H0 Then write_i_PVTMON_sel_value = get_i_PVTMON_sel
        If flag_auto_mode = &H0 Then write_auto_mode_value = get_auto_mode
        If flag_i_pwrdn = &H0 Then write_i_pwrdn_value = get_i_pwrdn

        regValue = leftShift((write_vmon_3p3_en_value and &H1), 15) + leftShift((write_vmon_1p8_en_value and &H1), 14) + leftShift((write_vmon_1v_en_value and &H1), 13) + leftShift((write_tmon_en_value and &H1), 12) + leftShift((write_pvtmon_ext_intr_en_value and &H1), 11) + leftShift((write_pvtmon_intr_en_value and &H1), 10) + leftShift((write_clksel_value and &H3), 8) + leftShift((write_i_PVTMON_sel_value and &H7), 4) + leftShift((write_auto_mode_value and &H1), 1) + leftShift((write_i_pwrdn_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3_en_value = rightShift(data_low, 15) and &H1
        read_vmon_1p8_en_value = rightShift(data_low, 14) and &H1
        read_vmon_1v_en_value = rightShift(data_low, 13) and &H1
        read_tmon_en_value = rightShift(data_low, 12) and &H1
        read_pvtmon_ext_intr_en_value = rightShift(data_low, 11) and &H1
        read_pvtmon_intr_en_value = rightShift(data_low, 10) and &H1
        read_clksel_value = rightShift(data_low, 8) and &H3
        read_i_PVTMON_sel_value = rightShift(data_low, 4) and &H7
        read_auto_mode_value = rightShift(data_low, 1) and &H1
        i_pwrdn_mask = &H1
        if data_low > LONG_MAX then
            if i_pwrdn_mask = mask then
                read_i_pwrdn_value = data_low
            else
                read_i_pwrdn_value = (data_low - H8000_0000) and i_pwrdn_mask
            end If
        else
            read_i_pwrdn_value = data_low and i_pwrdn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_3p3_en_value = &H0
        flag_vmon_3p3_en        = &H0
        write_vmon_1p8_en_value = &H0
        flag_vmon_1p8_en        = &H0
        write_vmon_1v_en_value = &H0
        flag_vmon_1v_en        = &H0
        write_tmon_en_value = &H0
        flag_tmon_en        = &H0
        write_pvtmon_ext_intr_en_value = &H0
        flag_pvtmon_ext_intr_en        = &H0
        write_pvtmon_intr_en_value = &H0
        flag_pvtmon_intr_en        = &H0
        write_clksel_value = &H0
        flag_clksel        = &H0
        write_i_PVTMON_sel_value = &H0
        flag_i_PVTMON_sel        = &H0
        write_auto_mode_value = &H0
        flag_auto_mode        = &H0
        write_i_pwrdn_value = &H0
        flag_i_pwrdn        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_sample_num
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_sample_num                            [7:4]            get_vmon_sample_num
''                                                             set_vmon_sample_num
''                                                             read_vmon_sample_num
''                                                             write_vmon_sample_num
''---------------------------------------------------------------------------------
'' tmon_sample_num                            [3:0]            get_tmon_sample_num
''                                                             set_tmon_sample_num
''                                                             read_tmon_sample_num
''                                                             write_tmon_sample_num
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_sample_num
    Private write_vmon_sample_num_value
    Private read_vmon_sample_num_value
    Private flag_vmon_sample_num
    Private write_tmon_sample_num_value
    Private read_tmon_sample_num_value
    Private flag_tmon_sample_num

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H202
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_sample_num
        get_vmon_sample_num = read_vmon_sample_num_value
    End Property

    Property Let set_vmon_sample_num(aData)
        write_vmon_sample_num_value = aData
        flag_vmon_sample_num        = &H1
    End Property

    Property Get read_vmon_sample_num
        read
        read_vmon_sample_num = read_vmon_sample_num_value
    End Property

    Property Let write_vmon_sample_num(aData)
        set_vmon_sample_num = aData
        write
    End Property

    Property Get get_tmon_sample_num
        get_tmon_sample_num = read_tmon_sample_num_value
    End Property

    Property Let set_tmon_sample_num(aData)
        write_tmon_sample_num_value = aData
        flag_tmon_sample_num        = &H1
    End Property

    Property Get read_tmon_sample_num
        read
        read_tmon_sample_num = read_tmon_sample_num_value
    End Property

    Property Let write_tmon_sample_num(aData)
        set_tmon_sample_num = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_sample_num_value = rightShift(data_low, 4) and &Hf
        tmon_sample_num_mask = &Hf
        if data_low > LONG_MAX then
            if tmon_sample_num_mask = mask then
                read_tmon_sample_num_value = data_low
            else
                read_tmon_sample_num_value = (data_low - H8000_0000) and tmon_sample_num_mask
            end If
        else
            read_tmon_sample_num_value = data_low and tmon_sample_num_mask
        end If

    End Sub

    Sub write
        If flag_vmon_sample_num = &H0 or flag_tmon_sample_num = &H0 Then read
        If flag_vmon_sample_num = &H0 Then write_vmon_sample_num_value = get_vmon_sample_num
        If flag_tmon_sample_num = &H0 Then write_tmon_sample_num_value = get_tmon_sample_num

        regValue = leftShift((write_vmon_sample_num_value and &Hf), 4) + leftShift((write_tmon_sample_num_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_sample_num_value = rightShift(data_low, 4) and &Hf
        tmon_sample_num_mask = &Hf
        if data_low > LONG_MAX then
            if tmon_sample_num_mask = mask then
                read_tmon_sample_num_value = data_low
            else
                read_tmon_sample_num_value = (data_low - H8000_0000) and tmon_sample_num_mask
            end If
        else
            read_tmon_sample_num_value = data_low and tmon_sample_num_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_sample_num_value = &H0
        flag_vmon_sample_num        = &H0
        write_tmon_sample_num_value = &H0
        flag_tmon_sample_num        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_tmon_period
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tmon_period                                [3:0]            get_tmon_period
''                                                             set_tmon_period
''                                                             read_tmon_period
''                                                             write_tmon_period
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_tmon_period
    Private write_tmon_period_value
    Private read_tmon_period_value
    Private flag_tmon_period

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tmon_period
        get_tmon_period = read_tmon_period_value
    End Property

    Property Let set_tmon_period(aData)
        write_tmon_period_value = aData
        flag_tmon_period        = &H1
    End Property

    Property Get read_tmon_period
        read
        read_tmon_period = read_tmon_period_value
    End Property

    Property Let write_tmon_period(aData)
        set_tmon_period = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_period_mask = &Hf
        if data_low > LONG_MAX then
            if tmon_period_mask = mask then
                read_tmon_period_value = data_low
            else
                read_tmon_period_value = (data_low - H8000_0000) and tmon_period_mask
            end If
        else
            read_tmon_period_value = data_low and tmon_period_mask
        end If

    End Sub

    Sub write
        If flag_tmon_period = &H0 Then read
        If flag_tmon_period = &H0 Then write_tmon_period_value = get_tmon_period

        regValue = leftShift((write_tmon_period_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_period_mask = &Hf
        if data_low > LONG_MAX then
            if tmon_period_mask = mask then
                read_tmon_period_value = data_low
            else
                read_tmon_period_value = (data_low - H8000_0000) and tmon_period_mask
            end If
        else
            read_tmon_period_value = data_low and tmon_period_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tmon_period_value = &H0
        flag_tmon_period        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_i_ctrl_31_16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' i_ctrl_31_16                               [15:0]           get_i_ctrl_31_16
''                                                             set_i_ctrl_31_16
''                                                             read_i_ctrl_31_16
''                                                             write_i_ctrl_31_16
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_i_ctrl_31_16
    Private write_i_ctrl_31_16_value
    Private read_i_ctrl_31_16_value
    Private flag_i_ctrl_31_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H206
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_i_ctrl_31_16
        get_i_ctrl_31_16 = read_i_ctrl_31_16_value
    End Property

    Property Let set_i_ctrl_31_16(aData)
        write_i_ctrl_31_16_value = aData
        flag_i_ctrl_31_16        = &H1
    End Property

    Property Get read_i_ctrl_31_16
        read
        read_i_ctrl_31_16 = read_i_ctrl_31_16_value
    End Property

    Property Let write_i_ctrl_31_16(aData)
        set_i_ctrl_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        i_ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if i_ctrl_31_16_mask = mask then
                read_i_ctrl_31_16_value = data_low
            else
                read_i_ctrl_31_16_value = (data_low - H8000_0000) and i_ctrl_31_16_mask
            end If
        else
            read_i_ctrl_31_16_value = data_low and i_ctrl_31_16_mask
        end If

    End Sub

    Sub write
        If flag_i_ctrl_31_16 = &H0 Then read
        If flag_i_ctrl_31_16 = &H0 Then write_i_ctrl_31_16_value = get_i_ctrl_31_16

        regValue = leftShift((write_i_ctrl_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        i_ctrl_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if i_ctrl_31_16_mask = mask then
                read_i_ctrl_31_16_value = data_low
            else
                read_i_ctrl_31_16_value = (data_low - H8000_0000) and i_ctrl_31_16_mask
            end If
        else
            read_i_ctrl_31_16_value = data_low and i_ctrl_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_i_ctrl_31_16_value = &H0
        flag_i_ctrl_31_16        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_i_ctrl_15_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' i_ctrl_15_0                                [15:0]           get_i_ctrl_15_0
''                                                             set_i_ctrl_15_0
''                                                             read_i_ctrl_15_0
''                                                             write_i_ctrl_15_0
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_i_ctrl_15_0
    Private write_i_ctrl_15_0_value
    Private read_i_ctrl_15_0_value
    Private flag_i_ctrl_15_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_i_ctrl_15_0
        get_i_ctrl_15_0 = read_i_ctrl_15_0_value
    End Property

    Property Let set_i_ctrl_15_0(aData)
        write_i_ctrl_15_0_value = aData
        flag_i_ctrl_15_0        = &H1
    End Property

    Property Get read_i_ctrl_15_0
        read
        read_i_ctrl_15_0 = read_i_ctrl_15_0_value
    End Property

    Property Let write_i_ctrl_15_0(aData)
        set_i_ctrl_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        i_ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if i_ctrl_15_0_mask = mask then
                read_i_ctrl_15_0_value = data_low
            else
                read_i_ctrl_15_0_value = (data_low - H8000_0000) and i_ctrl_15_0_mask
            end If
        else
            read_i_ctrl_15_0_value = data_low and i_ctrl_15_0_mask
        end If

    End Sub

    Sub write
        If flag_i_ctrl_15_0 = &H0 Then read
        If flag_i_ctrl_15_0 = &H0 Then write_i_ctrl_15_0_value = get_i_ctrl_15_0

        regValue = leftShift((write_i_ctrl_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        i_ctrl_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if i_ctrl_15_0_mask = mask then
                read_i_ctrl_15_0_value = data_low
            else
                read_i_ctrl_15_0_value = (data_low - H8000_0000) and i_ctrl_15_0_mask
            end If
        else
            read_i_ctrl_15_0_value = data_low and i_ctrl_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_i_ctrl_15_0_value = &H0
        flag_i_ctrl_15_0        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_adc_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADC_data                                   [9:0]            get_ADC_data
''                                                             set_ADC_data
''                                                             read_ADC_data
''                                                             write_ADC_data
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_adc_data
    Private write_ADC_data_value
    Private read_ADC_data_value
    Private flag_ADC_data

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ADC_data
        get_ADC_data = read_ADC_data_value
    End Property

    Property Let set_ADC_data(aData)
        write_ADC_data_value = aData
        flag_ADC_data        = &H1
    End Property

    Property Get read_ADC_data
        read
        read_ADC_data = read_ADC_data_value
    End Property

    Property Let write_ADC_data(aData)
        set_ADC_data = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADC_data_mask = &H3ff
        if data_low > LONG_MAX then
            if ADC_data_mask = mask then
                read_ADC_data_value = data_low
            else
                read_ADC_data_value = (data_low - H8000_0000) and ADC_data_mask
            end If
        else
            read_ADC_data_value = data_low and ADC_data_mask
        end If

    End Sub

    Sub write
        If flag_ADC_data = &H0 Then read
        If flag_ADC_data = &H0 Then write_ADC_data_value = get_ADC_data

        regValue = leftShift((write_ADC_data_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADC_data_mask = &H3ff
        if data_low > LONG_MAX then
            if ADC_data_mask = mask then
                read_ADC_data_value = data_low
            else
                read_ADC_data_value = (data_low - H8000_0000) and ADC_data_mask
            end If
        else
            read_ADC_data_value = data_low and ADC_data_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADC_data_value = &H0
        flag_ADC_data        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_dac_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAC_data                                   [9:0]            get_DAC_data
''                                                             set_DAC_data
''                                                             read_DAC_data
''                                                             write_DAC_data
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_dac_data
    Private write_DAC_data_value
    Private read_DAC_data_value
    Private flag_DAC_data

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DAC_data
        get_DAC_data = read_DAC_data_value
    End Property

    Property Let set_DAC_data(aData)
        write_DAC_data_value = aData
        flag_DAC_data        = &H1
    End Property

    Property Get read_DAC_data
        read
        read_DAC_data = read_DAC_data_value
    End Property

    Property Let write_DAC_data(aData)
        set_DAC_data = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAC_data_mask = &H3ff
        if data_low > LONG_MAX then
            if DAC_data_mask = mask then
                read_DAC_data_value = data_low
            else
                read_DAC_data_value = (data_low - H8000_0000) and DAC_data_mask
            end If
        else
            read_DAC_data_value = data_low and DAC_data_mask
        end If

    End Sub

    Sub write
        If flag_DAC_data = &H0 Then read
        If flag_DAC_data = &H0 Then write_DAC_data_value = get_DAC_data

        regValue = leftShift((write_DAC_data_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAC_data_mask = &H3ff
        if data_low > LONG_MAX then
            if DAC_data_mask = mask then
                read_DAC_data_value = data_low
            else
                read_DAC_data_value = (data_low - H8000_0000) and DAC_data_mask
            end If
        else
            read_DAC_data_value = data_low and DAC_data_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAC_data_value = &H0
        flag_DAC_data        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_tmon_thresh1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tmon_thresh1_reset_en                      [11:11]          get_tmon_thresh1_reset_en
''                                                             set_tmon_thresh1_reset_en
''                                                             read_tmon_thresh1_reset_en
''                                                             write_tmon_thresh1_reset_en
''---------------------------------------------------------------------------------
'' tmon_thresh1_intr_en                       [10:10]          get_tmon_thresh1_intr_en
''                                                             set_tmon_thresh1_intr_en
''                                                             read_tmon_thresh1_intr_en
''                                                             write_tmon_thresh1_intr_en
''---------------------------------------------------------------------------------
'' tmon_thresh1                               [9:0]            get_tmon_thresh1
''                                                             set_tmon_thresh1
''                                                             read_tmon_thresh1
''                                                             write_tmon_thresh1
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_tmon_thresh1_ctrl
    Private write_tmon_thresh1_reset_en_value
    Private read_tmon_thresh1_reset_en_value
    Private flag_tmon_thresh1_reset_en
    Private write_tmon_thresh1_intr_en_value
    Private read_tmon_thresh1_intr_en_value
    Private flag_tmon_thresh1_intr_en
    Private write_tmon_thresh1_value
    Private read_tmon_thresh1_value
    Private flag_tmon_thresh1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tmon_thresh1_reset_en
        get_tmon_thresh1_reset_en = read_tmon_thresh1_reset_en_value
    End Property

    Property Let set_tmon_thresh1_reset_en(aData)
        write_tmon_thresh1_reset_en_value = aData
        flag_tmon_thresh1_reset_en        = &H1
    End Property

    Property Get read_tmon_thresh1_reset_en
        read
        read_tmon_thresh1_reset_en = read_tmon_thresh1_reset_en_value
    End Property

    Property Let write_tmon_thresh1_reset_en(aData)
        set_tmon_thresh1_reset_en = aData
        write
    End Property

    Property Get get_tmon_thresh1_intr_en
        get_tmon_thresh1_intr_en = read_tmon_thresh1_intr_en_value
    End Property

    Property Let set_tmon_thresh1_intr_en(aData)
        write_tmon_thresh1_intr_en_value = aData
        flag_tmon_thresh1_intr_en        = &H1
    End Property

    Property Get read_tmon_thresh1_intr_en
        read
        read_tmon_thresh1_intr_en = read_tmon_thresh1_intr_en_value
    End Property

    Property Let write_tmon_thresh1_intr_en(aData)
        set_tmon_thresh1_intr_en = aData
        write
    End Property

    Property Get get_tmon_thresh1
        get_tmon_thresh1 = read_tmon_thresh1_value
    End Property

    Property Let set_tmon_thresh1(aData)
        write_tmon_thresh1_value = aData
        flag_tmon_thresh1        = &H1
    End Property

    Property Get read_tmon_thresh1
        read
        read_tmon_thresh1 = read_tmon_thresh1_value
    End Property

    Property Let write_tmon_thresh1(aData)
        set_tmon_thresh1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tmon_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_tmon_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        tmon_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if tmon_thresh1_mask = mask then
                read_tmon_thresh1_value = data_low
            else
                read_tmon_thresh1_value = (data_low - H8000_0000) and tmon_thresh1_mask
            end If
        else
            read_tmon_thresh1_value = data_low and tmon_thresh1_mask
        end If

    End Sub

    Sub write
        If flag_tmon_thresh1_reset_en = &H0 or flag_tmon_thresh1_intr_en = &H0 or flag_tmon_thresh1 = &H0 Then read
        If flag_tmon_thresh1_reset_en = &H0 Then write_tmon_thresh1_reset_en_value = get_tmon_thresh1_reset_en
        If flag_tmon_thresh1_intr_en = &H0 Then write_tmon_thresh1_intr_en_value = get_tmon_thresh1_intr_en
        If flag_tmon_thresh1 = &H0 Then write_tmon_thresh1_value = get_tmon_thresh1

        regValue = leftShift((write_tmon_thresh1_reset_en_value and &H1), 11) + leftShift((write_tmon_thresh1_intr_en_value and &H1), 10) + leftShift((write_tmon_thresh1_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tmon_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_tmon_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        tmon_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if tmon_thresh1_mask = mask then
                read_tmon_thresh1_value = data_low
            else
                read_tmon_thresh1_value = (data_low - H8000_0000) and tmon_thresh1_mask
            end If
        else
            read_tmon_thresh1_value = data_low and tmon_thresh1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tmon_thresh1_reset_en_value = &H0
        flag_tmon_thresh1_reset_en        = &H0
        write_tmon_thresh1_intr_en_value = &H0
        flag_tmon_thresh1_intr_en        = &H0
        write_tmon_thresh1_value = &H0
        flag_tmon_thresh1        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_tmon_thresh2_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tmon_thresh2_reset_en                      [11:11]          get_tmon_thresh2_reset_en
''                                                             set_tmon_thresh2_reset_en
''                                                             read_tmon_thresh2_reset_en
''                                                             write_tmon_thresh2_reset_en
''---------------------------------------------------------------------------------
'' tmon_thresh2_intr_en                       [10:10]          get_tmon_thresh2_intr_en
''                                                             set_tmon_thresh2_intr_en
''                                                             read_tmon_thresh2_intr_en
''                                                             write_tmon_thresh2_intr_en
''---------------------------------------------------------------------------------
'' tmon_thresh2                               [9:0]            get_tmon_thresh2
''                                                             set_tmon_thresh2
''                                                             read_tmon_thresh2
''                                                             write_tmon_thresh2
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_tmon_thresh2_ctrl
    Private write_tmon_thresh2_reset_en_value
    Private read_tmon_thresh2_reset_en_value
    Private flag_tmon_thresh2_reset_en
    Private write_tmon_thresh2_intr_en_value
    Private read_tmon_thresh2_intr_en_value
    Private flag_tmon_thresh2_intr_en
    Private write_tmon_thresh2_value
    Private read_tmon_thresh2_value
    Private flag_tmon_thresh2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tmon_thresh2_reset_en
        get_tmon_thresh2_reset_en = read_tmon_thresh2_reset_en_value
    End Property

    Property Let set_tmon_thresh2_reset_en(aData)
        write_tmon_thresh2_reset_en_value = aData
        flag_tmon_thresh2_reset_en        = &H1
    End Property

    Property Get read_tmon_thresh2_reset_en
        read
        read_tmon_thresh2_reset_en = read_tmon_thresh2_reset_en_value
    End Property

    Property Let write_tmon_thresh2_reset_en(aData)
        set_tmon_thresh2_reset_en = aData
        write
    End Property

    Property Get get_tmon_thresh2_intr_en
        get_tmon_thresh2_intr_en = read_tmon_thresh2_intr_en_value
    End Property

    Property Let set_tmon_thresh2_intr_en(aData)
        write_tmon_thresh2_intr_en_value = aData
        flag_tmon_thresh2_intr_en        = &H1
    End Property

    Property Get read_tmon_thresh2_intr_en
        read
        read_tmon_thresh2_intr_en = read_tmon_thresh2_intr_en_value
    End Property

    Property Let write_tmon_thresh2_intr_en(aData)
        set_tmon_thresh2_intr_en = aData
        write
    End Property

    Property Get get_tmon_thresh2
        get_tmon_thresh2 = read_tmon_thresh2_value
    End Property

    Property Let set_tmon_thresh2(aData)
        write_tmon_thresh2_value = aData
        flag_tmon_thresh2        = &H1
    End Property

    Property Get read_tmon_thresh2
        read
        read_tmon_thresh2 = read_tmon_thresh2_value
    End Property

    Property Let write_tmon_thresh2(aData)
        set_tmon_thresh2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tmon_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_tmon_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        tmon_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if tmon_thresh2_mask = mask then
                read_tmon_thresh2_value = data_low
            else
                read_tmon_thresh2_value = (data_low - H8000_0000) and tmon_thresh2_mask
            end If
        else
            read_tmon_thresh2_value = data_low and tmon_thresh2_mask
        end If

    End Sub

    Sub write
        If flag_tmon_thresh2_reset_en = &H0 or flag_tmon_thresh2_intr_en = &H0 or flag_tmon_thresh2 = &H0 Then read
        If flag_tmon_thresh2_reset_en = &H0 Then write_tmon_thresh2_reset_en_value = get_tmon_thresh2_reset_en
        If flag_tmon_thresh2_intr_en = &H0 Then write_tmon_thresh2_intr_en_value = get_tmon_thresh2_intr_en
        If flag_tmon_thresh2 = &H0 Then write_tmon_thresh2_value = get_tmon_thresh2

        regValue = leftShift((write_tmon_thresh2_reset_en_value and &H1), 11) + leftShift((write_tmon_thresh2_intr_en_value and &H1), 10) + leftShift((write_tmon_thresh2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tmon_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_tmon_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        tmon_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if tmon_thresh2_mask = mask then
                read_tmon_thresh2_value = data_low
            else
                read_tmon_thresh2_value = (data_low - H8000_0000) and tmon_thresh2_mask
            end If
        else
            read_tmon_thresh2_value = data_low and tmon_thresh2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tmon_thresh2_reset_en_value = &H0
        flag_tmon_thresh2_reset_en        = &H0
        write_tmon_thresh2_intr_en_value = &H0
        flag_tmon_thresh2_intr_en        = &H0
        write_tmon_thresh2_value = &H0
        flag_tmon_thresh2        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1v_h_thresh1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh1_reset_en                 [11:11]          get_vmon_1v_h_thresh1_reset_en
''                                                             set_vmon_1v_h_thresh1_reset_en
''                                                             read_vmon_1v_h_thresh1_reset_en
''                                                             write_vmon_1v_h_thresh1_reset_en
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh1_intr_en                  [10:10]          get_vmon_1v_h_thresh1_intr_en
''                                                             set_vmon_1v_h_thresh1_intr_en
''                                                             read_vmon_1v_h_thresh1_intr_en
''                                                             write_vmon_1v_h_thresh1_intr_en
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh1                          [9:0]            get_vmon_1v_h_thresh1
''                                                             set_vmon_1v_h_thresh1
''                                                             read_vmon_1v_h_thresh1
''                                                             write_vmon_1v_h_thresh1
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1v_h_thresh1_ctrl
    Private write_vmon_1v_h_thresh1_reset_en_value
    Private read_vmon_1v_h_thresh1_reset_en_value
    Private flag_vmon_1v_h_thresh1_reset_en
    Private write_vmon_1v_h_thresh1_intr_en_value
    Private read_vmon_1v_h_thresh1_intr_en_value
    Private flag_vmon_1v_h_thresh1_intr_en
    Private write_vmon_1v_h_thresh1_value
    Private read_vmon_1v_h_thresh1_value
    Private flag_vmon_1v_h_thresh1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H212
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1v_h_thresh1_reset_en
        get_vmon_1v_h_thresh1_reset_en = read_vmon_1v_h_thresh1_reset_en_value
    End Property

    Property Let set_vmon_1v_h_thresh1_reset_en(aData)
        write_vmon_1v_h_thresh1_reset_en_value = aData
        flag_vmon_1v_h_thresh1_reset_en        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh1_reset_en
        read
        read_vmon_1v_h_thresh1_reset_en = read_vmon_1v_h_thresh1_reset_en_value
    End Property

    Property Let write_vmon_1v_h_thresh1_reset_en(aData)
        set_vmon_1v_h_thresh1_reset_en = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh1_intr_en
        get_vmon_1v_h_thresh1_intr_en = read_vmon_1v_h_thresh1_intr_en_value
    End Property

    Property Let set_vmon_1v_h_thresh1_intr_en(aData)
        write_vmon_1v_h_thresh1_intr_en_value = aData
        flag_vmon_1v_h_thresh1_intr_en        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh1_intr_en
        read
        read_vmon_1v_h_thresh1_intr_en = read_vmon_1v_h_thresh1_intr_en_value
    End Property

    Property Let write_vmon_1v_h_thresh1_intr_en(aData)
        set_vmon_1v_h_thresh1_intr_en = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh1
        get_vmon_1v_h_thresh1 = read_vmon_1v_h_thresh1_value
    End Property

    Property Let set_vmon_1v_h_thresh1(aData)
        write_vmon_1v_h_thresh1_value = aData
        flag_vmon_1v_h_thresh1        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh1
        read
        read_vmon_1v_h_thresh1 = read_vmon_1v_h_thresh1_value
    End Property

    Property Let write_vmon_1v_h_thresh1(aData)
        set_vmon_1v_h_thresh1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_h_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_h_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_h_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_h_thresh1_mask = mask then
                read_vmon_1v_h_thresh1_value = data_low
            else
                read_vmon_1v_h_thresh1_value = (data_low - H8000_0000) and vmon_1v_h_thresh1_mask
            end If
        else
            read_vmon_1v_h_thresh1_value = data_low and vmon_1v_h_thresh1_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1v_h_thresh1_reset_en = &H0 or flag_vmon_1v_h_thresh1_intr_en = &H0 or flag_vmon_1v_h_thresh1 = &H0 Then read
        If flag_vmon_1v_h_thresh1_reset_en = &H0 Then write_vmon_1v_h_thresh1_reset_en_value = get_vmon_1v_h_thresh1_reset_en
        If flag_vmon_1v_h_thresh1_intr_en = &H0 Then write_vmon_1v_h_thresh1_intr_en_value = get_vmon_1v_h_thresh1_intr_en
        If flag_vmon_1v_h_thresh1 = &H0 Then write_vmon_1v_h_thresh1_value = get_vmon_1v_h_thresh1

        regValue = leftShift((write_vmon_1v_h_thresh1_reset_en_value and &H1), 11) + leftShift((write_vmon_1v_h_thresh1_intr_en_value and &H1), 10) + leftShift((write_vmon_1v_h_thresh1_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_h_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_h_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_h_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_h_thresh1_mask = mask then
                read_vmon_1v_h_thresh1_value = data_low
            else
                read_vmon_1v_h_thresh1_value = (data_low - H8000_0000) and vmon_1v_h_thresh1_mask
            end If
        else
            read_vmon_1v_h_thresh1_value = data_low and vmon_1v_h_thresh1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1v_h_thresh1_reset_en_value = &H0
        flag_vmon_1v_h_thresh1_reset_en        = &H0
        write_vmon_1v_h_thresh1_intr_en_value = &H0
        flag_vmon_1v_h_thresh1_intr_en        = &H0
        write_vmon_1v_h_thresh1_value = &H0
        flag_vmon_1v_h_thresh1        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1v_h_thresh2_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh2_reset_en                 [11:11]          get_vmon_1v_h_thresh2_reset_en
''                                                             set_vmon_1v_h_thresh2_reset_en
''                                                             read_vmon_1v_h_thresh2_reset_en
''                                                             write_vmon_1v_h_thresh2_reset_en
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh2_intr_en                  [10:10]          get_vmon_1v_h_thresh2_intr_en
''                                                             set_vmon_1v_h_thresh2_intr_en
''                                                             read_vmon_1v_h_thresh2_intr_en
''                                                             write_vmon_1v_h_thresh2_intr_en
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh2                          [9:0]            get_vmon_1v_h_thresh2
''                                                             set_vmon_1v_h_thresh2
''                                                             read_vmon_1v_h_thresh2
''                                                             write_vmon_1v_h_thresh2
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1v_h_thresh2_ctrl
    Private write_vmon_1v_h_thresh2_reset_en_value
    Private read_vmon_1v_h_thresh2_reset_en_value
    Private flag_vmon_1v_h_thresh2_reset_en
    Private write_vmon_1v_h_thresh2_intr_en_value
    Private read_vmon_1v_h_thresh2_intr_en_value
    Private flag_vmon_1v_h_thresh2_intr_en
    Private write_vmon_1v_h_thresh2_value
    Private read_vmon_1v_h_thresh2_value
    Private flag_vmon_1v_h_thresh2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1v_h_thresh2_reset_en
        get_vmon_1v_h_thresh2_reset_en = read_vmon_1v_h_thresh2_reset_en_value
    End Property

    Property Let set_vmon_1v_h_thresh2_reset_en(aData)
        write_vmon_1v_h_thresh2_reset_en_value = aData
        flag_vmon_1v_h_thresh2_reset_en        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh2_reset_en
        read
        read_vmon_1v_h_thresh2_reset_en = read_vmon_1v_h_thresh2_reset_en_value
    End Property

    Property Let write_vmon_1v_h_thresh2_reset_en(aData)
        set_vmon_1v_h_thresh2_reset_en = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh2_intr_en
        get_vmon_1v_h_thresh2_intr_en = read_vmon_1v_h_thresh2_intr_en_value
    End Property

    Property Let set_vmon_1v_h_thresh2_intr_en(aData)
        write_vmon_1v_h_thresh2_intr_en_value = aData
        flag_vmon_1v_h_thresh2_intr_en        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh2_intr_en
        read
        read_vmon_1v_h_thresh2_intr_en = read_vmon_1v_h_thresh2_intr_en_value
    End Property

    Property Let write_vmon_1v_h_thresh2_intr_en(aData)
        set_vmon_1v_h_thresh2_intr_en = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh2
        get_vmon_1v_h_thresh2 = read_vmon_1v_h_thresh2_value
    End Property

    Property Let set_vmon_1v_h_thresh2(aData)
        write_vmon_1v_h_thresh2_value = aData
        flag_vmon_1v_h_thresh2        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh2
        read
        read_vmon_1v_h_thresh2 = read_vmon_1v_h_thresh2_value
    End Property

    Property Let write_vmon_1v_h_thresh2(aData)
        set_vmon_1v_h_thresh2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_h_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_h_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_h_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_h_thresh2_mask = mask then
                read_vmon_1v_h_thresh2_value = data_low
            else
                read_vmon_1v_h_thresh2_value = (data_low - H8000_0000) and vmon_1v_h_thresh2_mask
            end If
        else
            read_vmon_1v_h_thresh2_value = data_low and vmon_1v_h_thresh2_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1v_h_thresh2_reset_en = &H0 or flag_vmon_1v_h_thresh2_intr_en = &H0 or flag_vmon_1v_h_thresh2 = &H0 Then read
        If flag_vmon_1v_h_thresh2_reset_en = &H0 Then write_vmon_1v_h_thresh2_reset_en_value = get_vmon_1v_h_thresh2_reset_en
        If flag_vmon_1v_h_thresh2_intr_en = &H0 Then write_vmon_1v_h_thresh2_intr_en_value = get_vmon_1v_h_thresh2_intr_en
        If flag_vmon_1v_h_thresh2 = &H0 Then write_vmon_1v_h_thresh2_value = get_vmon_1v_h_thresh2

        regValue = leftShift((write_vmon_1v_h_thresh2_reset_en_value and &H1), 11) + leftShift((write_vmon_1v_h_thresh2_intr_en_value and &H1), 10) + leftShift((write_vmon_1v_h_thresh2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_h_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_h_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_h_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_h_thresh2_mask = mask then
                read_vmon_1v_h_thresh2_value = data_low
            else
                read_vmon_1v_h_thresh2_value = (data_low - H8000_0000) and vmon_1v_h_thresh2_mask
            end If
        else
            read_vmon_1v_h_thresh2_value = data_low and vmon_1v_h_thresh2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1v_h_thresh2_reset_en_value = &H0
        flag_vmon_1v_h_thresh2_reset_en        = &H0
        write_vmon_1v_h_thresh2_intr_en_value = &H0
        flag_vmon_1v_h_thresh2_intr_en        = &H0
        write_vmon_1v_h_thresh2_value = &H0
        flag_vmon_1v_h_thresh2        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1v_l_thresh1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh1_reset_en                 [11:11]          get_vmon_1v_l_thresh1_reset_en
''                                                             set_vmon_1v_l_thresh1_reset_en
''                                                             read_vmon_1v_l_thresh1_reset_en
''                                                             write_vmon_1v_l_thresh1_reset_en
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh1_intr_en                  [10:10]          get_vmon_1v_l_thresh1_intr_en
''                                                             set_vmon_1v_l_thresh1_intr_en
''                                                             read_vmon_1v_l_thresh1_intr_en
''                                                             write_vmon_1v_l_thresh1_intr_en
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh1                          [9:0]            get_vmon_1v_l_thresh1
''                                                             set_vmon_1v_l_thresh1
''                                                             read_vmon_1v_l_thresh1
''                                                             write_vmon_1v_l_thresh1
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1v_l_thresh1_ctrl
    Private write_vmon_1v_l_thresh1_reset_en_value
    Private read_vmon_1v_l_thresh1_reset_en_value
    Private flag_vmon_1v_l_thresh1_reset_en
    Private write_vmon_1v_l_thresh1_intr_en_value
    Private read_vmon_1v_l_thresh1_intr_en_value
    Private flag_vmon_1v_l_thresh1_intr_en
    Private write_vmon_1v_l_thresh1_value
    Private read_vmon_1v_l_thresh1_value
    Private flag_vmon_1v_l_thresh1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H216
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1v_l_thresh1_reset_en
        get_vmon_1v_l_thresh1_reset_en = read_vmon_1v_l_thresh1_reset_en_value
    End Property

    Property Let set_vmon_1v_l_thresh1_reset_en(aData)
        write_vmon_1v_l_thresh1_reset_en_value = aData
        flag_vmon_1v_l_thresh1_reset_en        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh1_reset_en
        read
        read_vmon_1v_l_thresh1_reset_en = read_vmon_1v_l_thresh1_reset_en_value
    End Property

    Property Let write_vmon_1v_l_thresh1_reset_en(aData)
        set_vmon_1v_l_thresh1_reset_en = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh1_intr_en
        get_vmon_1v_l_thresh1_intr_en = read_vmon_1v_l_thresh1_intr_en_value
    End Property

    Property Let set_vmon_1v_l_thresh1_intr_en(aData)
        write_vmon_1v_l_thresh1_intr_en_value = aData
        flag_vmon_1v_l_thresh1_intr_en        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh1_intr_en
        read
        read_vmon_1v_l_thresh1_intr_en = read_vmon_1v_l_thresh1_intr_en_value
    End Property

    Property Let write_vmon_1v_l_thresh1_intr_en(aData)
        set_vmon_1v_l_thresh1_intr_en = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh1
        get_vmon_1v_l_thresh1 = read_vmon_1v_l_thresh1_value
    End Property

    Property Let set_vmon_1v_l_thresh1(aData)
        write_vmon_1v_l_thresh1_value = aData
        flag_vmon_1v_l_thresh1        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh1
        read
        read_vmon_1v_l_thresh1 = read_vmon_1v_l_thresh1_value
    End Property

    Property Let write_vmon_1v_l_thresh1(aData)
        set_vmon_1v_l_thresh1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_l_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_l_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_l_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_l_thresh1_mask = mask then
                read_vmon_1v_l_thresh1_value = data_low
            else
                read_vmon_1v_l_thresh1_value = (data_low - H8000_0000) and vmon_1v_l_thresh1_mask
            end If
        else
            read_vmon_1v_l_thresh1_value = data_low and vmon_1v_l_thresh1_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1v_l_thresh1_reset_en = &H0 or flag_vmon_1v_l_thresh1_intr_en = &H0 or flag_vmon_1v_l_thresh1 = &H0 Then read
        If flag_vmon_1v_l_thresh1_reset_en = &H0 Then write_vmon_1v_l_thresh1_reset_en_value = get_vmon_1v_l_thresh1_reset_en
        If flag_vmon_1v_l_thresh1_intr_en = &H0 Then write_vmon_1v_l_thresh1_intr_en_value = get_vmon_1v_l_thresh1_intr_en
        If flag_vmon_1v_l_thresh1 = &H0 Then write_vmon_1v_l_thresh1_value = get_vmon_1v_l_thresh1

        regValue = leftShift((write_vmon_1v_l_thresh1_reset_en_value and &H1), 11) + leftShift((write_vmon_1v_l_thresh1_intr_en_value and &H1), 10) + leftShift((write_vmon_1v_l_thresh1_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_l_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_l_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_l_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_l_thresh1_mask = mask then
                read_vmon_1v_l_thresh1_value = data_low
            else
                read_vmon_1v_l_thresh1_value = (data_low - H8000_0000) and vmon_1v_l_thresh1_mask
            end If
        else
            read_vmon_1v_l_thresh1_value = data_low and vmon_1v_l_thresh1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1v_l_thresh1_reset_en_value = &H0
        flag_vmon_1v_l_thresh1_reset_en        = &H0
        write_vmon_1v_l_thresh1_intr_en_value = &H0
        flag_vmon_1v_l_thresh1_intr_en        = &H0
        write_vmon_1v_l_thresh1_value = &H0
        flag_vmon_1v_l_thresh1        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1v_l_thresh2_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh2_reset_en                 [11:11]          get_vmon_1v_l_thresh2_reset_en
''                                                             set_vmon_1v_l_thresh2_reset_en
''                                                             read_vmon_1v_l_thresh2_reset_en
''                                                             write_vmon_1v_l_thresh2_reset_en
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh2_intr_en                  [10:10]          get_vmon_1v_l_thresh2_intr_en
''                                                             set_vmon_1v_l_thresh2_intr_en
''                                                             read_vmon_1v_l_thresh2_intr_en
''                                                             write_vmon_1v_l_thresh2_intr_en
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh2                          [9:0]            get_vmon_1v_l_thresh2
''                                                             set_vmon_1v_l_thresh2
''                                                             read_vmon_1v_l_thresh2
''                                                             write_vmon_1v_l_thresh2
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1v_l_thresh2_ctrl
    Private write_vmon_1v_l_thresh2_reset_en_value
    Private read_vmon_1v_l_thresh2_reset_en_value
    Private flag_vmon_1v_l_thresh2_reset_en
    Private write_vmon_1v_l_thresh2_intr_en_value
    Private read_vmon_1v_l_thresh2_intr_en_value
    Private flag_vmon_1v_l_thresh2_intr_en
    Private write_vmon_1v_l_thresh2_value
    Private read_vmon_1v_l_thresh2_value
    Private flag_vmon_1v_l_thresh2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H218
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1v_l_thresh2_reset_en
        get_vmon_1v_l_thresh2_reset_en = read_vmon_1v_l_thresh2_reset_en_value
    End Property

    Property Let set_vmon_1v_l_thresh2_reset_en(aData)
        write_vmon_1v_l_thresh2_reset_en_value = aData
        flag_vmon_1v_l_thresh2_reset_en        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh2_reset_en
        read
        read_vmon_1v_l_thresh2_reset_en = read_vmon_1v_l_thresh2_reset_en_value
    End Property

    Property Let write_vmon_1v_l_thresh2_reset_en(aData)
        set_vmon_1v_l_thresh2_reset_en = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh2_intr_en
        get_vmon_1v_l_thresh2_intr_en = read_vmon_1v_l_thresh2_intr_en_value
    End Property

    Property Let set_vmon_1v_l_thresh2_intr_en(aData)
        write_vmon_1v_l_thresh2_intr_en_value = aData
        flag_vmon_1v_l_thresh2_intr_en        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh2_intr_en
        read
        read_vmon_1v_l_thresh2_intr_en = read_vmon_1v_l_thresh2_intr_en_value
    End Property

    Property Let write_vmon_1v_l_thresh2_intr_en(aData)
        set_vmon_1v_l_thresh2_intr_en = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh2
        get_vmon_1v_l_thresh2 = read_vmon_1v_l_thresh2_value
    End Property

    Property Let set_vmon_1v_l_thresh2(aData)
        write_vmon_1v_l_thresh2_value = aData
        flag_vmon_1v_l_thresh2        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh2
        read
        read_vmon_1v_l_thresh2 = read_vmon_1v_l_thresh2_value
    End Property

    Property Let write_vmon_1v_l_thresh2(aData)
        set_vmon_1v_l_thresh2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_l_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_l_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_l_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_l_thresh2_mask = mask then
                read_vmon_1v_l_thresh2_value = data_low
            else
                read_vmon_1v_l_thresh2_value = (data_low - H8000_0000) and vmon_1v_l_thresh2_mask
            end If
        else
            read_vmon_1v_l_thresh2_value = data_low and vmon_1v_l_thresh2_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1v_l_thresh2_reset_en = &H0 or flag_vmon_1v_l_thresh2_intr_en = &H0 or flag_vmon_1v_l_thresh2 = &H0 Then read
        If flag_vmon_1v_l_thresh2_reset_en = &H0 Then write_vmon_1v_l_thresh2_reset_en_value = get_vmon_1v_l_thresh2_reset_en
        If flag_vmon_1v_l_thresh2_intr_en = &H0 Then write_vmon_1v_l_thresh2_intr_en_value = get_vmon_1v_l_thresh2_intr_en
        If flag_vmon_1v_l_thresh2 = &H0 Then write_vmon_1v_l_thresh2_value = get_vmon_1v_l_thresh2

        regValue = leftShift((write_vmon_1v_l_thresh2_reset_en_value and &H1), 11) + leftShift((write_vmon_1v_l_thresh2_intr_en_value and &H1), 10) + leftShift((write_vmon_1v_l_thresh2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1v_l_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1v_l_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1v_l_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_l_thresh2_mask = mask then
                read_vmon_1v_l_thresh2_value = data_low
            else
                read_vmon_1v_l_thresh2_value = (data_low - H8000_0000) and vmon_1v_l_thresh2_mask
            end If
        else
            read_vmon_1v_l_thresh2_value = data_low and vmon_1v_l_thresh2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1v_l_thresh2_reset_en_value = &H0
        flag_vmon_1v_l_thresh2_reset_en        = &H0
        write_vmon_1v_l_thresh2_intr_en_value = &H0
        flag_vmon_1v_l_thresh2_intr_en        = &H0
        write_vmon_1v_l_thresh2_value = &H0
        flag_vmon_1v_l_thresh2        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1p8v_h_thresh1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh1_reset_en               [11:11]          get_vmon_1p8v_h_thresh1_reset_en
''                                                             set_vmon_1p8v_h_thresh1_reset_en
''                                                             read_vmon_1p8v_h_thresh1_reset_en
''                                                             write_vmon_1p8v_h_thresh1_reset_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh1_intr_en                [10:10]          get_vmon_1p8v_h_thresh1_intr_en
''                                                             set_vmon_1p8v_h_thresh1_intr_en
''                                                             read_vmon_1p8v_h_thresh1_intr_en
''                                                             write_vmon_1p8v_h_thresh1_intr_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh1                        [9:0]            get_vmon_1p8v_h_thresh1
''                                                             set_vmon_1p8v_h_thresh1
''                                                             read_vmon_1p8v_h_thresh1
''                                                             write_vmon_1p8v_h_thresh1
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1p8v_h_thresh1_ctrl
    Private write_vmon_1p8v_h_thresh1_reset_en_value
    Private read_vmon_1p8v_h_thresh1_reset_en_value
    Private flag_vmon_1p8v_h_thresh1_reset_en
    Private write_vmon_1p8v_h_thresh1_intr_en_value
    Private read_vmon_1p8v_h_thresh1_intr_en_value
    Private flag_vmon_1p8v_h_thresh1_intr_en
    Private write_vmon_1p8v_h_thresh1_value
    Private read_vmon_1p8v_h_thresh1_value
    Private flag_vmon_1p8v_h_thresh1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H21a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1p8v_h_thresh1_reset_en
        get_vmon_1p8v_h_thresh1_reset_en = read_vmon_1p8v_h_thresh1_reset_en_value
    End Property

    Property Let set_vmon_1p8v_h_thresh1_reset_en(aData)
        write_vmon_1p8v_h_thresh1_reset_en_value = aData
        flag_vmon_1p8v_h_thresh1_reset_en        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh1_reset_en
        read
        read_vmon_1p8v_h_thresh1_reset_en = read_vmon_1p8v_h_thresh1_reset_en_value
    End Property

    Property Let write_vmon_1p8v_h_thresh1_reset_en(aData)
        set_vmon_1p8v_h_thresh1_reset_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh1_intr_en
        get_vmon_1p8v_h_thresh1_intr_en = read_vmon_1p8v_h_thresh1_intr_en_value
    End Property

    Property Let set_vmon_1p8v_h_thresh1_intr_en(aData)
        write_vmon_1p8v_h_thresh1_intr_en_value = aData
        flag_vmon_1p8v_h_thresh1_intr_en        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh1_intr_en
        read
        read_vmon_1p8v_h_thresh1_intr_en = read_vmon_1p8v_h_thresh1_intr_en_value
    End Property

    Property Let write_vmon_1p8v_h_thresh1_intr_en(aData)
        set_vmon_1p8v_h_thresh1_intr_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh1
        get_vmon_1p8v_h_thresh1 = read_vmon_1p8v_h_thresh1_value
    End Property

    Property Let set_vmon_1p8v_h_thresh1(aData)
        write_vmon_1p8v_h_thresh1_value = aData
        flag_vmon_1p8v_h_thresh1        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh1
        read
        read_vmon_1p8v_h_thresh1 = read_vmon_1p8v_h_thresh1_value
    End Property

    Property Let write_vmon_1p8v_h_thresh1(aData)
        set_vmon_1p8v_h_thresh1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_h_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_h_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_h_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_h_thresh1_mask = mask then
                read_vmon_1p8v_h_thresh1_value = data_low
            else
                read_vmon_1p8v_h_thresh1_value = (data_low - H8000_0000) and vmon_1p8v_h_thresh1_mask
            end If
        else
            read_vmon_1p8v_h_thresh1_value = data_low and vmon_1p8v_h_thresh1_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1p8v_h_thresh1_reset_en = &H0 or flag_vmon_1p8v_h_thresh1_intr_en = &H0 or flag_vmon_1p8v_h_thresh1 = &H0 Then read
        If flag_vmon_1p8v_h_thresh1_reset_en = &H0 Then write_vmon_1p8v_h_thresh1_reset_en_value = get_vmon_1p8v_h_thresh1_reset_en
        If flag_vmon_1p8v_h_thresh1_intr_en = &H0 Then write_vmon_1p8v_h_thresh1_intr_en_value = get_vmon_1p8v_h_thresh1_intr_en
        If flag_vmon_1p8v_h_thresh1 = &H0 Then write_vmon_1p8v_h_thresh1_value = get_vmon_1p8v_h_thresh1

        regValue = leftShift((write_vmon_1p8v_h_thresh1_reset_en_value and &H1), 11) + leftShift((write_vmon_1p8v_h_thresh1_intr_en_value and &H1), 10) + leftShift((write_vmon_1p8v_h_thresh1_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_h_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_h_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_h_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_h_thresh1_mask = mask then
                read_vmon_1p8v_h_thresh1_value = data_low
            else
                read_vmon_1p8v_h_thresh1_value = (data_low - H8000_0000) and vmon_1p8v_h_thresh1_mask
            end If
        else
            read_vmon_1p8v_h_thresh1_value = data_low and vmon_1p8v_h_thresh1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1p8v_h_thresh1_reset_en_value = &H0
        flag_vmon_1p8v_h_thresh1_reset_en        = &H0
        write_vmon_1p8v_h_thresh1_intr_en_value = &H0
        flag_vmon_1p8v_h_thresh1_intr_en        = &H0
        write_vmon_1p8v_h_thresh1_value = &H0
        flag_vmon_1p8v_h_thresh1        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1p8v_h_thresh2_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh2_reset_en               [11:11]          get_vmon_1p8v_h_thresh2_reset_en
''                                                             set_vmon_1p8v_h_thresh2_reset_en
''                                                             read_vmon_1p8v_h_thresh2_reset_en
''                                                             write_vmon_1p8v_h_thresh2_reset_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh2_intr_en                [10:10]          get_vmon_1p8v_h_thresh2_intr_en
''                                                             set_vmon_1p8v_h_thresh2_intr_en
''                                                             read_vmon_1p8v_h_thresh2_intr_en
''                                                             write_vmon_1p8v_h_thresh2_intr_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh2                        [9:0]            get_vmon_1p8v_h_thresh2
''                                                             set_vmon_1p8v_h_thresh2
''                                                             read_vmon_1p8v_h_thresh2
''                                                             write_vmon_1p8v_h_thresh2
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1p8v_h_thresh2_ctrl
    Private write_vmon_1p8v_h_thresh2_reset_en_value
    Private read_vmon_1p8v_h_thresh2_reset_en_value
    Private flag_vmon_1p8v_h_thresh2_reset_en
    Private write_vmon_1p8v_h_thresh2_intr_en_value
    Private read_vmon_1p8v_h_thresh2_intr_en_value
    Private flag_vmon_1p8v_h_thresh2_intr_en
    Private write_vmon_1p8v_h_thresh2_value
    Private read_vmon_1p8v_h_thresh2_value
    Private flag_vmon_1p8v_h_thresh2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H21c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1p8v_h_thresh2_reset_en
        get_vmon_1p8v_h_thresh2_reset_en = read_vmon_1p8v_h_thresh2_reset_en_value
    End Property

    Property Let set_vmon_1p8v_h_thresh2_reset_en(aData)
        write_vmon_1p8v_h_thresh2_reset_en_value = aData
        flag_vmon_1p8v_h_thresh2_reset_en        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh2_reset_en
        read
        read_vmon_1p8v_h_thresh2_reset_en = read_vmon_1p8v_h_thresh2_reset_en_value
    End Property

    Property Let write_vmon_1p8v_h_thresh2_reset_en(aData)
        set_vmon_1p8v_h_thresh2_reset_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh2_intr_en
        get_vmon_1p8v_h_thresh2_intr_en = read_vmon_1p8v_h_thresh2_intr_en_value
    End Property

    Property Let set_vmon_1p8v_h_thresh2_intr_en(aData)
        write_vmon_1p8v_h_thresh2_intr_en_value = aData
        flag_vmon_1p8v_h_thresh2_intr_en        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh2_intr_en
        read
        read_vmon_1p8v_h_thresh2_intr_en = read_vmon_1p8v_h_thresh2_intr_en_value
    End Property

    Property Let write_vmon_1p8v_h_thresh2_intr_en(aData)
        set_vmon_1p8v_h_thresh2_intr_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh2
        get_vmon_1p8v_h_thresh2 = read_vmon_1p8v_h_thresh2_value
    End Property

    Property Let set_vmon_1p8v_h_thresh2(aData)
        write_vmon_1p8v_h_thresh2_value = aData
        flag_vmon_1p8v_h_thresh2        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh2
        read
        read_vmon_1p8v_h_thresh2 = read_vmon_1p8v_h_thresh2_value
    End Property

    Property Let write_vmon_1p8v_h_thresh2(aData)
        set_vmon_1p8v_h_thresh2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_h_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_h_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_h_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_h_thresh2_mask = mask then
                read_vmon_1p8v_h_thresh2_value = data_low
            else
                read_vmon_1p8v_h_thresh2_value = (data_low - H8000_0000) and vmon_1p8v_h_thresh2_mask
            end If
        else
            read_vmon_1p8v_h_thresh2_value = data_low and vmon_1p8v_h_thresh2_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1p8v_h_thresh2_reset_en = &H0 or flag_vmon_1p8v_h_thresh2_intr_en = &H0 or flag_vmon_1p8v_h_thresh2 = &H0 Then read
        If flag_vmon_1p8v_h_thresh2_reset_en = &H0 Then write_vmon_1p8v_h_thresh2_reset_en_value = get_vmon_1p8v_h_thresh2_reset_en
        If flag_vmon_1p8v_h_thresh2_intr_en = &H0 Then write_vmon_1p8v_h_thresh2_intr_en_value = get_vmon_1p8v_h_thresh2_intr_en
        If flag_vmon_1p8v_h_thresh2 = &H0 Then write_vmon_1p8v_h_thresh2_value = get_vmon_1p8v_h_thresh2

        regValue = leftShift((write_vmon_1p8v_h_thresh2_reset_en_value and &H1), 11) + leftShift((write_vmon_1p8v_h_thresh2_intr_en_value and &H1), 10) + leftShift((write_vmon_1p8v_h_thresh2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_h_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_h_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_h_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_h_thresh2_mask = mask then
                read_vmon_1p8v_h_thresh2_value = data_low
            else
                read_vmon_1p8v_h_thresh2_value = (data_low - H8000_0000) and vmon_1p8v_h_thresh2_mask
            end If
        else
            read_vmon_1p8v_h_thresh2_value = data_low and vmon_1p8v_h_thresh2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1p8v_h_thresh2_reset_en_value = &H0
        flag_vmon_1p8v_h_thresh2_reset_en        = &H0
        write_vmon_1p8v_h_thresh2_intr_en_value = &H0
        flag_vmon_1p8v_h_thresh2_intr_en        = &H0
        write_vmon_1p8v_h_thresh2_value = &H0
        flag_vmon_1p8v_h_thresh2        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1p8v_l_thresh1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh1_reset_en               [11:11]          get_vmon_1p8v_l_thresh1_reset_en
''                                                             set_vmon_1p8v_l_thresh1_reset_en
''                                                             read_vmon_1p8v_l_thresh1_reset_en
''                                                             write_vmon_1p8v_l_thresh1_reset_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh1_intr_en                [10:10]          get_vmon_1p8v_l_thresh1_intr_en
''                                                             set_vmon_1p8v_l_thresh1_intr_en
''                                                             read_vmon_1p8v_l_thresh1_intr_en
''                                                             write_vmon_1p8v_l_thresh1_intr_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh1                        [9:0]            get_vmon_1p8v_l_thresh1
''                                                             set_vmon_1p8v_l_thresh1
''                                                             read_vmon_1p8v_l_thresh1
''                                                             write_vmon_1p8v_l_thresh1
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1p8v_l_thresh1_ctrl
    Private write_vmon_1p8v_l_thresh1_reset_en_value
    Private read_vmon_1p8v_l_thresh1_reset_en_value
    Private flag_vmon_1p8v_l_thresh1_reset_en
    Private write_vmon_1p8v_l_thresh1_intr_en_value
    Private read_vmon_1p8v_l_thresh1_intr_en_value
    Private flag_vmon_1p8v_l_thresh1_intr_en
    Private write_vmon_1p8v_l_thresh1_value
    Private read_vmon_1p8v_l_thresh1_value
    Private flag_vmon_1p8v_l_thresh1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H21e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1p8v_l_thresh1_reset_en
        get_vmon_1p8v_l_thresh1_reset_en = read_vmon_1p8v_l_thresh1_reset_en_value
    End Property

    Property Let set_vmon_1p8v_l_thresh1_reset_en(aData)
        write_vmon_1p8v_l_thresh1_reset_en_value = aData
        flag_vmon_1p8v_l_thresh1_reset_en        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh1_reset_en
        read
        read_vmon_1p8v_l_thresh1_reset_en = read_vmon_1p8v_l_thresh1_reset_en_value
    End Property

    Property Let write_vmon_1p8v_l_thresh1_reset_en(aData)
        set_vmon_1p8v_l_thresh1_reset_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh1_intr_en
        get_vmon_1p8v_l_thresh1_intr_en = read_vmon_1p8v_l_thresh1_intr_en_value
    End Property

    Property Let set_vmon_1p8v_l_thresh1_intr_en(aData)
        write_vmon_1p8v_l_thresh1_intr_en_value = aData
        flag_vmon_1p8v_l_thresh1_intr_en        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh1_intr_en
        read
        read_vmon_1p8v_l_thresh1_intr_en = read_vmon_1p8v_l_thresh1_intr_en_value
    End Property

    Property Let write_vmon_1p8v_l_thresh1_intr_en(aData)
        set_vmon_1p8v_l_thresh1_intr_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh1
        get_vmon_1p8v_l_thresh1 = read_vmon_1p8v_l_thresh1_value
    End Property

    Property Let set_vmon_1p8v_l_thresh1(aData)
        write_vmon_1p8v_l_thresh1_value = aData
        flag_vmon_1p8v_l_thresh1        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh1
        read
        read_vmon_1p8v_l_thresh1 = read_vmon_1p8v_l_thresh1_value
    End Property

    Property Let write_vmon_1p8v_l_thresh1(aData)
        set_vmon_1p8v_l_thresh1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_l_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_l_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_l_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_l_thresh1_mask = mask then
                read_vmon_1p8v_l_thresh1_value = data_low
            else
                read_vmon_1p8v_l_thresh1_value = (data_low - H8000_0000) and vmon_1p8v_l_thresh1_mask
            end If
        else
            read_vmon_1p8v_l_thresh1_value = data_low and vmon_1p8v_l_thresh1_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1p8v_l_thresh1_reset_en = &H0 or flag_vmon_1p8v_l_thresh1_intr_en = &H0 or flag_vmon_1p8v_l_thresh1 = &H0 Then read
        If flag_vmon_1p8v_l_thresh1_reset_en = &H0 Then write_vmon_1p8v_l_thresh1_reset_en_value = get_vmon_1p8v_l_thresh1_reset_en
        If flag_vmon_1p8v_l_thresh1_intr_en = &H0 Then write_vmon_1p8v_l_thresh1_intr_en_value = get_vmon_1p8v_l_thresh1_intr_en
        If flag_vmon_1p8v_l_thresh1 = &H0 Then write_vmon_1p8v_l_thresh1_value = get_vmon_1p8v_l_thresh1

        regValue = leftShift((write_vmon_1p8v_l_thresh1_reset_en_value and &H1), 11) + leftShift((write_vmon_1p8v_l_thresh1_intr_en_value and &H1), 10) + leftShift((write_vmon_1p8v_l_thresh1_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_l_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_l_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_l_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_l_thresh1_mask = mask then
                read_vmon_1p8v_l_thresh1_value = data_low
            else
                read_vmon_1p8v_l_thresh1_value = (data_low - H8000_0000) and vmon_1p8v_l_thresh1_mask
            end If
        else
            read_vmon_1p8v_l_thresh1_value = data_low and vmon_1p8v_l_thresh1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1p8v_l_thresh1_reset_en_value = &H0
        flag_vmon_1p8v_l_thresh1_reset_en        = &H0
        write_vmon_1p8v_l_thresh1_intr_en_value = &H0
        flag_vmon_1p8v_l_thresh1_intr_en        = &H0
        write_vmon_1p8v_l_thresh1_value = &H0
        flag_vmon_1p8v_l_thresh1        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1p8v_l_thresh2_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh2_reset_en               [11:11]          get_vmon_1p8v_l_thresh2_reset_en
''                                                             set_vmon_1p8v_l_thresh2_reset_en
''                                                             read_vmon_1p8v_l_thresh2_reset_en
''                                                             write_vmon_1p8v_l_thresh2_reset_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh2_intr_en                [10:10]          get_vmon_1p8v_l_thresh2_intr_en
''                                                             set_vmon_1p8v_l_thresh2_intr_en
''                                                             read_vmon_1p8v_l_thresh2_intr_en
''                                                             write_vmon_1p8v_l_thresh2_intr_en
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh2                        [9:0]            get_vmon_1p8v_l_thresh2
''                                                             set_vmon_1p8v_l_thresh2
''                                                             read_vmon_1p8v_l_thresh2
''                                                             write_vmon_1p8v_l_thresh2
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1p8v_l_thresh2_ctrl
    Private write_vmon_1p8v_l_thresh2_reset_en_value
    Private read_vmon_1p8v_l_thresh2_reset_en_value
    Private flag_vmon_1p8v_l_thresh2_reset_en
    Private write_vmon_1p8v_l_thresh2_intr_en_value
    Private read_vmon_1p8v_l_thresh2_intr_en_value
    Private flag_vmon_1p8v_l_thresh2_intr_en
    Private write_vmon_1p8v_l_thresh2_value
    Private read_vmon_1p8v_l_thresh2_value
    Private flag_vmon_1p8v_l_thresh2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H220
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1p8v_l_thresh2_reset_en
        get_vmon_1p8v_l_thresh2_reset_en = read_vmon_1p8v_l_thresh2_reset_en_value
    End Property

    Property Let set_vmon_1p8v_l_thresh2_reset_en(aData)
        write_vmon_1p8v_l_thresh2_reset_en_value = aData
        flag_vmon_1p8v_l_thresh2_reset_en        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh2_reset_en
        read
        read_vmon_1p8v_l_thresh2_reset_en = read_vmon_1p8v_l_thresh2_reset_en_value
    End Property

    Property Let write_vmon_1p8v_l_thresh2_reset_en(aData)
        set_vmon_1p8v_l_thresh2_reset_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh2_intr_en
        get_vmon_1p8v_l_thresh2_intr_en = read_vmon_1p8v_l_thresh2_intr_en_value
    End Property

    Property Let set_vmon_1p8v_l_thresh2_intr_en(aData)
        write_vmon_1p8v_l_thresh2_intr_en_value = aData
        flag_vmon_1p8v_l_thresh2_intr_en        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh2_intr_en
        read
        read_vmon_1p8v_l_thresh2_intr_en = read_vmon_1p8v_l_thresh2_intr_en_value
    End Property

    Property Let write_vmon_1p8v_l_thresh2_intr_en(aData)
        set_vmon_1p8v_l_thresh2_intr_en = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh2
        get_vmon_1p8v_l_thresh2 = read_vmon_1p8v_l_thresh2_value
    End Property

    Property Let set_vmon_1p8v_l_thresh2(aData)
        write_vmon_1p8v_l_thresh2_value = aData
        flag_vmon_1p8v_l_thresh2        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh2
        read
        read_vmon_1p8v_l_thresh2 = read_vmon_1p8v_l_thresh2_value
    End Property

    Property Let write_vmon_1p8v_l_thresh2(aData)
        set_vmon_1p8v_l_thresh2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_l_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_l_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_l_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_l_thresh2_mask = mask then
                read_vmon_1p8v_l_thresh2_value = data_low
            else
                read_vmon_1p8v_l_thresh2_value = (data_low - H8000_0000) and vmon_1p8v_l_thresh2_mask
            end If
        else
            read_vmon_1p8v_l_thresh2_value = data_low and vmon_1p8v_l_thresh2_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1p8v_l_thresh2_reset_en = &H0 or flag_vmon_1p8v_l_thresh2_intr_en = &H0 or flag_vmon_1p8v_l_thresh2 = &H0 Then read
        If flag_vmon_1p8v_l_thresh2_reset_en = &H0 Then write_vmon_1p8v_l_thresh2_reset_en_value = get_vmon_1p8v_l_thresh2_reset_en
        If flag_vmon_1p8v_l_thresh2_intr_en = &H0 Then write_vmon_1p8v_l_thresh2_intr_en_value = get_vmon_1p8v_l_thresh2_intr_en
        If flag_vmon_1p8v_l_thresh2 = &H0 Then write_vmon_1p8v_l_thresh2_value = get_vmon_1p8v_l_thresh2

        regValue = leftShift((write_vmon_1p8v_l_thresh2_reset_en_value and &H1), 11) + leftShift((write_vmon_1p8v_l_thresh2_intr_en_value and &H1), 10) + leftShift((write_vmon_1p8v_l_thresh2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_1p8v_l_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_1p8v_l_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_1p8v_l_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_l_thresh2_mask = mask then
                read_vmon_1p8v_l_thresh2_value = data_low
            else
                read_vmon_1p8v_l_thresh2_value = (data_low - H8000_0000) and vmon_1p8v_l_thresh2_mask
            end If
        else
            read_vmon_1p8v_l_thresh2_value = data_low and vmon_1p8v_l_thresh2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1p8v_l_thresh2_reset_en_value = &H0
        flag_vmon_1p8v_l_thresh2_reset_en        = &H0
        write_vmon_1p8v_l_thresh2_intr_en_value = &H0
        flag_vmon_1p8v_l_thresh2_intr_en        = &H0
        write_vmon_1p8v_l_thresh2_value = &H0
        flag_vmon_1p8v_l_thresh2        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_3p3v_h_thresh1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh1_reset_en               [11:11]          get_vmon_3p3v_h_thresh1_reset_en
''                                                             set_vmon_3p3v_h_thresh1_reset_en
''                                                             read_vmon_3p3v_h_thresh1_reset_en
''                                                             write_vmon_3p3v_h_thresh1_reset_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh1_intr_en                [10:10]          get_vmon_3p3v_h_thresh1_intr_en
''                                                             set_vmon_3p3v_h_thresh1_intr_en
''                                                             read_vmon_3p3v_h_thresh1_intr_en
''                                                             write_vmon_3p3v_h_thresh1_intr_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh1                        [9:0]            get_vmon_3p3v_h_thresh1
''                                                             set_vmon_3p3v_h_thresh1
''                                                             read_vmon_3p3v_h_thresh1
''                                                             write_vmon_3p3v_h_thresh1
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_3p3v_h_thresh1_ctrl
    Private write_vmon_3p3v_h_thresh1_reset_en_value
    Private read_vmon_3p3v_h_thresh1_reset_en_value
    Private flag_vmon_3p3v_h_thresh1_reset_en
    Private write_vmon_3p3v_h_thresh1_intr_en_value
    Private read_vmon_3p3v_h_thresh1_intr_en_value
    Private flag_vmon_3p3v_h_thresh1_intr_en
    Private write_vmon_3p3v_h_thresh1_value
    Private read_vmon_3p3v_h_thresh1_value
    Private flag_vmon_3p3v_h_thresh1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H222
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_3p3v_h_thresh1_reset_en
        get_vmon_3p3v_h_thresh1_reset_en = read_vmon_3p3v_h_thresh1_reset_en_value
    End Property

    Property Let set_vmon_3p3v_h_thresh1_reset_en(aData)
        write_vmon_3p3v_h_thresh1_reset_en_value = aData
        flag_vmon_3p3v_h_thresh1_reset_en        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh1_reset_en
        read
        read_vmon_3p3v_h_thresh1_reset_en = read_vmon_3p3v_h_thresh1_reset_en_value
    End Property

    Property Let write_vmon_3p3v_h_thresh1_reset_en(aData)
        set_vmon_3p3v_h_thresh1_reset_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh1_intr_en
        get_vmon_3p3v_h_thresh1_intr_en = read_vmon_3p3v_h_thresh1_intr_en_value
    End Property

    Property Let set_vmon_3p3v_h_thresh1_intr_en(aData)
        write_vmon_3p3v_h_thresh1_intr_en_value = aData
        flag_vmon_3p3v_h_thresh1_intr_en        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh1_intr_en
        read
        read_vmon_3p3v_h_thresh1_intr_en = read_vmon_3p3v_h_thresh1_intr_en_value
    End Property

    Property Let write_vmon_3p3v_h_thresh1_intr_en(aData)
        set_vmon_3p3v_h_thresh1_intr_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh1
        get_vmon_3p3v_h_thresh1 = read_vmon_3p3v_h_thresh1_value
    End Property

    Property Let set_vmon_3p3v_h_thresh1(aData)
        write_vmon_3p3v_h_thresh1_value = aData
        flag_vmon_3p3v_h_thresh1        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh1
        read
        read_vmon_3p3v_h_thresh1 = read_vmon_3p3v_h_thresh1_value
    End Property

    Property Let write_vmon_3p3v_h_thresh1(aData)
        set_vmon_3p3v_h_thresh1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_h_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_h_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_h_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_h_thresh1_mask = mask then
                read_vmon_3p3v_h_thresh1_value = data_low
            else
                read_vmon_3p3v_h_thresh1_value = (data_low - H8000_0000) and vmon_3p3v_h_thresh1_mask
            end If
        else
            read_vmon_3p3v_h_thresh1_value = data_low and vmon_3p3v_h_thresh1_mask
        end If

    End Sub

    Sub write
        If flag_vmon_3p3v_h_thresh1_reset_en = &H0 or flag_vmon_3p3v_h_thresh1_intr_en = &H0 or flag_vmon_3p3v_h_thresh1 = &H0 Then read
        If flag_vmon_3p3v_h_thresh1_reset_en = &H0 Then write_vmon_3p3v_h_thresh1_reset_en_value = get_vmon_3p3v_h_thresh1_reset_en
        If flag_vmon_3p3v_h_thresh1_intr_en = &H0 Then write_vmon_3p3v_h_thresh1_intr_en_value = get_vmon_3p3v_h_thresh1_intr_en
        If flag_vmon_3p3v_h_thresh1 = &H0 Then write_vmon_3p3v_h_thresh1_value = get_vmon_3p3v_h_thresh1

        regValue = leftShift((write_vmon_3p3v_h_thresh1_reset_en_value and &H1), 11) + leftShift((write_vmon_3p3v_h_thresh1_intr_en_value and &H1), 10) + leftShift((write_vmon_3p3v_h_thresh1_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_h_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_h_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_h_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_h_thresh1_mask = mask then
                read_vmon_3p3v_h_thresh1_value = data_low
            else
                read_vmon_3p3v_h_thresh1_value = (data_low - H8000_0000) and vmon_3p3v_h_thresh1_mask
            end If
        else
            read_vmon_3p3v_h_thresh1_value = data_low and vmon_3p3v_h_thresh1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_3p3v_h_thresh1_reset_en_value = &H0
        flag_vmon_3p3v_h_thresh1_reset_en        = &H0
        write_vmon_3p3v_h_thresh1_intr_en_value = &H0
        flag_vmon_3p3v_h_thresh1_intr_en        = &H0
        write_vmon_3p3v_h_thresh1_value = &H0
        flag_vmon_3p3v_h_thresh1        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_3p3v_h_thresh2_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh2_reset_en               [11:11]          get_vmon_3p3v_h_thresh2_reset_en
''                                                             set_vmon_3p3v_h_thresh2_reset_en
''                                                             read_vmon_3p3v_h_thresh2_reset_en
''                                                             write_vmon_3p3v_h_thresh2_reset_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh2_intr_en                [10:10]          get_vmon_3p3v_h_thresh2_intr_en
''                                                             set_vmon_3p3v_h_thresh2_intr_en
''                                                             read_vmon_3p3v_h_thresh2_intr_en
''                                                             write_vmon_3p3v_h_thresh2_intr_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh2                        [9:0]            get_vmon_3p3v_h_thresh2
''                                                             set_vmon_3p3v_h_thresh2
''                                                             read_vmon_3p3v_h_thresh2
''                                                             write_vmon_3p3v_h_thresh2
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_3p3v_h_thresh2_ctrl
    Private write_vmon_3p3v_h_thresh2_reset_en_value
    Private read_vmon_3p3v_h_thresh2_reset_en_value
    Private flag_vmon_3p3v_h_thresh2_reset_en
    Private write_vmon_3p3v_h_thresh2_intr_en_value
    Private read_vmon_3p3v_h_thresh2_intr_en_value
    Private flag_vmon_3p3v_h_thresh2_intr_en
    Private write_vmon_3p3v_h_thresh2_value
    Private read_vmon_3p3v_h_thresh2_value
    Private flag_vmon_3p3v_h_thresh2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H224
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_3p3v_h_thresh2_reset_en
        get_vmon_3p3v_h_thresh2_reset_en = read_vmon_3p3v_h_thresh2_reset_en_value
    End Property

    Property Let set_vmon_3p3v_h_thresh2_reset_en(aData)
        write_vmon_3p3v_h_thresh2_reset_en_value = aData
        flag_vmon_3p3v_h_thresh2_reset_en        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh2_reset_en
        read
        read_vmon_3p3v_h_thresh2_reset_en = read_vmon_3p3v_h_thresh2_reset_en_value
    End Property

    Property Let write_vmon_3p3v_h_thresh2_reset_en(aData)
        set_vmon_3p3v_h_thresh2_reset_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh2_intr_en
        get_vmon_3p3v_h_thresh2_intr_en = read_vmon_3p3v_h_thresh2_intr_en_value
    End Property

    Property Let set_vmon_3p3v_h_thresh2_intr_en(aData)
        write_vmon_3p3v_h_thresh2_intr_en_value = aData
        flag_vmon_3p3v_h_thresh2_intr_en        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh2_intr_en
        read
        read_vmon_3p3v_h_thresh2_intr_en = read_vmon_3p3v_h_thresh2_intr_en_value
    End Property

    Property Let write_vmon_3p3v_h_thresh2_intr_en(aData)
        set_vmon_3p3v_h_thresh2_intr_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh2
        get_vmon_3p3v_h_thresh2 = read_vmon_3p3v_h_thresh2_value
    End Property

    Property Let set_vmon_3p3v_h_thresh2(aData)
        write_vmon_3p3v_h_thresh2_value = aData
        flag_vmon_3p3v_h_thresh2        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh2
        read
        read_vmon_3p3v_h_thresh2 = read_vmon_3p3v_h_thresh2_value
    End Property

    Property Let write_vmon_3p3v_h_thresh2(aData)
        set_vmon_3p3v_h_thresh2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_h_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_h_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_h_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_h_thresh2_mask = mask then
                read_vmon_3p3v_h_thresh2_value = data_low
            else
                read_vmon_3p3v_h_thresh2_value = (data_low - H8000_0000) and vmon_3p3v_h_thresh2_mask
            end If
        else
            read_vmon_3p3v_h_thresh2_value = data_low and vmon_3p3v_h_thresh2_mask
        end If

    End Sub

    Sub write
        If flag_vmon_3p3v_h_thresh2_reset_en = &H0 or flag_vmon_3p3v_h_thresh2_intr_en = &H0 or flag_vmon_3p3v_h_thresh2 = &H0 Then read
        If flag_vmon_3p3v_h_thresh2_reset_en = &H0 Then write_vmon_3p3v_h_thresh2_reset_en_value = get_vmon_3p3v_h_thresh2_reset_en
        If flag_vmon_3p3v_h_thresh2_intr_en = &H0 Then write_vmon_3p3v_h_thresh2_intr_en_value = get_vmon_3p3v_h_thresh2_intr_en
        If flag_vmon_3p3v_h_thresh2 = &H0 Then write_vmon_3p3v_h_thresh2_value = get_vmon_3p3v_h_thresh2

        regValue = leftShift((write_vmon_3p3v_h_thresh2_reset_en_value and &H1), 11) + leftShift((write_vmon_3p3v_h_thresh2_intr_en_value and &H1), 10) + leftShift((write_vmon_3p3v_h_thresh2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_h_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_h_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_h_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_h_thresh2_mask = mask then
                read_vmon_3p3v_h_thresh2_value = data_low
            else
                read_vmon_3p3v_h_thresh2_value = (data_low - H8000_0000) and vmon_3p3v_h_thresh2_mask
            end If
        else
            read_vmon_3p3v_h_thresh2_value = data_low and vmon_3p3v_h_thresh2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_3p3v_h_thresh2_reset_en_value = &H0
        flag_vmon_3p3v_h_thresh2_reset_en        = &H0
        write_vmon_3p3v_h_thresh2_intr_en_value = &H0
        flag_vmon_3p3v_h_thresh2_intr_en        = &H0
        write_vmon_3p3v_h_thresh2_value = &H0
        flag_vmon_3p3v_h_thresh2        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_3p3v_l_thresh1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh1_reset_en               [11:11]          get_vmon_3p3v_l_thresh1_reset_en
''                                                             set_vmon_3p3v_l_thresh1_reset_en
''                                                             read_vmon_3p3v_l_thresh1_reset_en
''                                                             write_vmon_3p3v_l_thresh1_reset_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh1_intr_en                [10:10]          get_vmon_3p3v_l_thresh1_intr_en
''                                                             set_vmon_3p3v_l_thresh1_intr_en
''                                                             read_vmon_3p3v_l_thresh1_intr_en
''                                                             write_vmon_3p3v_l_thresh1_intr_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh1                        [9:0]            get_vmon_3p3v_l_thresh1
''                                                             set_vmon_3p3v_l_thresh1
''                                                             read_vmon_3p3v_l_thresh1
''                                                             write_vmon_3p3v_l_thresh1
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_3p3v_l_thresh1_ctrl
    Private write_vmon_3p3v_l_thresh1_reset_en_value
    Private read_vmon_3p3v_l_thresh1_reset_en_value
    Private flag_vmon_3p3v_l_thresh1_reset_en
    Private write_vmon_3p3v_l_thresh1_intr_en_value
    Private read_vmon_3p3v_l_thresh1_intr_en_value
    Private flag_vmon_3p3v_l_thresh1_intr_en
    Private write_vmon_3p3v_l_thresh1_value
    Private read_vmon_3p3v_l_thresh1_value
    Private flag_vmon_3p3v_l_thresh1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H226
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_3p3v_l_thresh1_reset_en
        get_vmon_3p3v_l_thresh1_reset_en = read_vmon_3p3v_l_thresh1_reset_en_value
    End Property

    Property Let set_vmon_3p3v_l_thresh1_reset_en(aData)
        write_vmon_3p3v_l_thresh1_reset_en_value = aData
        flag_vmon_3p3v_l_thresh1_reset_en        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh1_reset_en
        read
        read_vmon_3p3v_l_thresh1_reset_en = read_vmon_3p3v_l_thresh1_reset_en_value
    End Property

    Property Let write_vmon_3p3v_l_thresh1_reset_en(aData)
        set_vmon_3p3v_l_thresh1_reset_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh1_intr_en
        get_vmon_3p3v_l_thresh1_intr_en = read_vmon_3p3v_l_thresh1_intr_en_value
    End Property

    Property Let set_vmon_3p3v_l_thresh1_intr_en(aData)
        write_vmon_3p3v_l_thresh1_intr_en_value = aData
        flag_vmon_3p3v_l_thresh1_intr_en        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh1_intr_en
        read
        read_vmon_3p3v_l_thresh1_intr_en = read_vmon_3p3v_l_thresh1_intr_en_value
    End Property

    Property Let write_vmon_3p3v_l_thresh1_intr_en(aData)
        set_vmon_3p3v_l_thresh1_intr_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh1
        get_vmon_3p3v_l_thresh1 = read_vmon_3p3v_l_thresh1_value
    End Property

    Property Let set_vmon_3p3v_l_thresh1(aData)
        write_vmon_3p3v_l_thresh1_value = aData
        flag_vmon_3p3v_l_thresh1        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh1
        read
        read_vmon_3p3v_l_thresh1 = read_vmon_3p3v_l_thresh1_value
    End Property

    Property Let write_vmon_3p3v_l_thresh1(aData)
        set_vmon_3p3v_l_thresh1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_l_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_l_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_l_thresh1_mask = mask then
                read_vmon_3p3v_l_thresh1_value = data_low
            else
                read_vmon_3p3v_l_thresh1_value = (data_low - H8000_0000) and vmon_3p3v_l_thresh1_mask
            end If
        else
            read_vmon_3p3v_l_thresh1_value = data_low and vmon_3p3v_l_thresh1_mask
        end If

    End Sub

    Sub write
        If flag_vmon_3p3v_l_thresh1_reset_en = &H0 or flag_vmon_3p3v_l_thresh1_intr_en = &H0 or flag_vmon_3p3v_l_thresh1 = &H0 Then read
        If flag_vmon_3p3v_l_thresh1_reset_en = &H0 Then write_vmon_3p3v_l_thresh1_reset_en_value = get_vmon_3p3v_l_thresh1_reset_en
        If flag_vmon_3p3v_l_thresh1_intr_en = &H0 Then write_vmon_3p3v_l_thresh1_intr_en_value = get_vmon_3p3v_l_thresh1_intr_en
        If flag_vmon_3p3v_l_thresh1 = &H0 Then write_vmon_3p3v_l_thresh1_value = get_vmon_3p3v_l_thresh1

        regValue = leftShift((write_vmon_3p3v_l_thresh1_reset_en_value and &H1), 11) + leftShift((write_vmon_3p3v_l_thresh1_intr_en_value and &H1), 10) + leftShift((write_vmon_3p3v_l_thresh1_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_l_thresh1_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_l_thresh1_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_l_thresh1_mask = mask then
                read_vmon_3p3v_l_thresh1_value = data_low
            else
                read_vmon_3p3v_l_thresh1_value = (data_low - H8000_0000) and vmon_3p3v_l_thresh1_mask
            end If
        else
            read_vmon_3p3v_l_thresh1_value = data_low and vmon_3p3v_l_thresh1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_3p3v_l_thresh1_reset_en_value = &H0
        flag_vmon_3p3v_l_thresh1_reset_en        = &H0
        write_vmon_3p3v_l_thresh1_intr_en_value = &H0
        flag_vmon_3p3v_l_thresh1_intr_en        = &H0
        write_vmon_3p3v_l_thresh1_value = &H0
        flag_vmon_3p3v_l_thresh1        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_3p3v_l_thresh2_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh2_reset_en               [11:11]          get_vmon_3p3v_l_thresh2_reset_en
''                                                             set_vmon_3p3v_l_thresh2_reset_en
''                                                             read_vmon_3p3v_l_thresh2_reset_en
''                                                             write_vmon_3p3v_l_thresh2_reset_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh2_intr_en                [10:10]          get_vmon_3p3v_l_thresh2_intr_en
''                                                             set_vmon_3p3v_l_thresh2_intr_en
''                                                             read_vmon_3p3v_l_thresh2_intr_en
''                                                             write_vmon_3p3v_l_thresh2_intr_en
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh2                        [9:0]            get_vmon_3p3v_l_thresh2
''                                                             set_vmon_3p3v_l_thresh2
''                                                             read_vmon_3p3v_l_thresh2
''                                                             write_vmon_3p3v_l_thresh2
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_3p3v_l_thresh2_ctrl
    Private write_vmon_3p3v_l_thresh2_reset_en_value
    Private read_vmon_3p3v_l_thresh2_reset_en_value
    Private flag_vmon_3p3v_l_thresh2_reset_en
    Private write_vmon_3p3v_l_thresh2_intr_en_value
    Private read_vmon_3p3v_l_thresh2_intr_en_value
    Private flag_vmon_3p3v_l_thresh2_intr_en
    Private write_vmon_3p3v_l_thresh2_value
    Private read_vmon_3p3v_l_thresh2_value
    Private flag_vmon_3p3v_l_thresh2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H228
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_3p3v_l_thresh2_reset_en
        get_vmon_3p3v_l_thresh2_reset_en = read_vmon_3p3v_l_thresh2_reset_en_value
    End Property

    Property Let set_vmon_3p3v_l_thresh2_reset_en(aData)
        write_vmon_3p3v_l_thresh2_reset_en_value = aData
        flag_vmon_3p3v_l_thresh2_reset_en        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh2_reset_en
        read
        read_vmon_3p3v_l_thresh2_reset_en = read_vmon_3p3v_l_thresh2_reset_en_value
    End Property

    Property Let write_vmon_3p3v_l_thresh2_reset_en(aData)
        set_vmon_3p3v_l_thresh2_reset_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh2_intr_en
        get_vmon_3p3v_l_thresh2_intr_en = read_vmon_3p3v_l_thresh2_intr_en_value
    End Property

    Property Let set_vmon_3p3v_l_thresh2_intr_en(aData)
        write_vmon_3p3v_l_thresh2_intr_en_value = aData
        flag_vmon_3p3v_l_thresh2_intr_en        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh2_intr_en
        read
        read_vmon_3p3v_l_thresh2_intr_en = read_vmon_3p3v_l_thresh2_intr_en_value
    End Property

    Property Let write_vmon_3p3v_l_thresh2_intr_en(aData)
        set_vmon_3p3v_l_thresh2_intr_en = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh2
        get_vmon_3p3v_l_thresh2 = read_vmon_3p3v_l_thresh2_value
    End Property

    Property Let set_vmon_3p3v_l_thresh2(aData)
        write_vmon_3p3v_l_thresh2_value = aData
        flag_vmon_3p3v_l_thresh2        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh2
        read
        read_vmon_3p3v_l_thresh2 = read_vmon_3p3v_l_thresh2_value
    End Property

    Property Let write_vmon_3p3v_l_thresh2(aData)
        set_vmon_3p3v_l_thresh2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_l_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_l_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_l_thresh2_mask = mask then
                read_vmon_3p3v_l_thresh2_value = data_low
            else
                read_vmon_3p3v_l_thresh2_value = (data_low - H8000_0000) and vmon_3p3v_l_thresh2_mask
            end If
        else
            read_vmon_3p3v_l_thresh2_value = data_low and vmon_3p3v_l_thresh2_mask
        end If

    End Sub

    Sub write
        If flag_vmon_3p3v_l_thresh2_reset_en = &H0 or flag_vmon_3p3v_l_thresh2_intr_en = &H0 or flag_vmon_3p3v_l_thresh2 = &H0 Then read
        If flag_vmon_3p3v_l_thresh2_reset_en = &H0 Then write_vmon_3p3v_l_thresh2_reset_en_value = get_vmon_3p3v_l_thresh2_reset_en
        If flag_vmon_3p3v_l_thresh2_intr_en = &H0 Then write_vmon_3p3v_l_thresh2_intr_en_value = get_vmon_3p3v_l_thresh2_intr_en
        If flag_vmon_3p3v_l_thresh2 = &H0 Then write_vmon_3p3v_l_thresh2_value = get_vmon_3p3v_l_thresh2

        regValue = leftShift((write_vmon_3p3v_l_thresh2_reset_en_value and &H1), 11) + leftShift((write_vmon_3p3v_l_thresh2_intr_en_value and &H1), 10) + leftShift((write_vmon_3p3v_l_thresh2_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vmon_3p3v_l_thresh2_reset_en_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh2_intr_en_value = rightShift(data_low, 10) and &H1
        vmon_3p3v_l_thresh2_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_l_thresh2_mask = mask then
                read_vmon_3p3v_l_thresh2_value = data_low
            else
                read_vmon_3p3v_l_thresh2_value = (data_low - H8000_0000) and vmon_3p3v_l_thresh2_mask
            end If
        else
            read_vmon_3p3v_l_thresh2_value = data_low and vmon_3p3v_l_thresh2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_3p3v_l_thresh2_reset_en_value = &H0
        flag_vmon_3p3v_l_thresh2_reset_en        = &H0
        write_vmon_3p3v_l_thresh2_intr_en_value = &H0
        flag_vmon_3p3v_l_thresh2_intr_en        = &H0
        write_vmon_3p3v_l_thresh2_value = &H0
        flag_vmon_3p3v_l_thresh2        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_threshold_filter
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' threshold_filter                           [7:0]            get_threshold_filter
''                                                             set_threshold_filter
''                                                             read_threshold_filter
''                                                             write_threshold_filter
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_threshold_filter
    Private write_threshold_filter_value
    Private read_threshold_filter_value
    Private flag_threshold_filter

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_threshold_filter
        get_threshold_filter = read_threshold_filter_value
    End Property

    Property Let set_threshold_filter(aData)
        write_threshold_filter_value = aData
        flag_threshold_filter        = &H1
    End Property

    Property Get read_threshold_filter
        read
        read_threshold_filter = read_threshold_filter_value
    End Property

    Property Let write_threshold_filter(aData)
        set_threshold_filter = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        threshold_filter_mask = &Hff
        if data_low > LONG_MAX then
            if threshold_filter_mask = mask then
                read_threshold_filter_value = data_low
            else
                read_threshold_filter_value = (data_low - H8000_0000) and threshold_filter_mask
            end If
        else
            read_threshold_filter_value = data_low and threshold_filter_mask
        end If

    End Sub

    Sub write
        If flag_threshold_filter = &H0 Then read
        If flag_threshold_filter = &H0 Then write_threshold_filter_value = get_threshold_filter

        regValue = leftShift((write_threshold_filter_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        threshold_filter_mask = &Hff
        if data_low > LONG_MAX then
            if threshold_filter_mask = mask then
                read_threshold_filter_value = data_low
            else
                read_threshold_filter_value = (data_low - H8000_0000) and threshold_filter_mask
            end If
        else
            read_threshold_filter_value = data_low and threshold_filter_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_threshold_filter_value = &H0
        flag_threshold_filter        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_viol_rawsts
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tmon_thresh1_viol                          [0:0]            get_tmon_thresh1_viol
''                                                             set_tmon_thresh1_viol
''                                                             read_tmon_thresh1_viol
''                                                             write_tmon_thresh1_viol
''---------------------------------------------------------------------------------
'' tmon_thresh2_viol                          [1:1]            get_tmon_thresh2_viol
''                                                             set_tmon_thresh2_viol
''                                                             read_tmon_thresh2_viol
''                                                             write_tmon_thresh2_viol
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh1_viol                     [2:2]            get_vmon_1v_h_thresh1_viol
''                                                             set_vmon_1v_h_thresh1_viol
''                                                             read_vmon_1v_h_thresh1_viol
''                                                             write_vmon_1v_h_thresh1_viol
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh2_viol                     [3:3]            get_vmon_1v_h_thresh2_viol
''                                                             set_vmon_1v_h_thresh2_viol
''                                                             read_vmon_1v_h_thresh2_viol
''                                                             write_vmon_1v_h_thresh2_viol
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh1_viol                     [4:4]            get_vmon_1v_l_thresh1_viol
''                                                             set_vmon_1v_l_thresh1_viol
''                                                             read_vmon_1v_l_thresh1_viol
''                                                             write_vmon_1v_l_thresh1_viol
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh2_viol                     [5:5]            get_vmon_1v_l_thresh2_viol
''                                                             set_vmon_1v_l_thresh2_viol
''                                                             read_vmon_1v_l_thresh2_viol
''                                                             write_vmon_1v_l_thresh2_viol
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh1_viol                   [6:6]            get_vmon_1p8v_h_thresh1_viol
''                                                             set_vmon_1p8v_h_thresh1_viol
''                                                             read_vmon_1p8v_h_thresh1_viol
''                                                             write_vmon_1p8v_h_thresh1_viol
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh2_viol                   [7:7]            get_vmon_1p8v_h_thresh2_viol
''                                                             set_vmon_1p8v_h_thresh2_viol
''                                                             read_vmon_1p8v_h_thresh2_viol
''                                                             write_vmon_1p8v_h_thresh2_viol
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh1_viol                   [8:8]            get_vmon_1p8v_l_thresh1_viol
''                                                             set_vmon_1p8v_l_thresh1_viol
''                                                             read_vmon_1p8v_l_thresh1_viol
''                                                             write_vmon_1p8v_l_thresh1_viol
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh2_viol                   [9:9]            get_vmon_1p8v_l_thresh2_viol
''                                                             set_vmon_1p8v_l_thresh2_viol
''                                                             read_vmon_1p8v_l_thresh2_viol
''                                                             write_vmon_1p8v_l_thresh2_viol
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh1_viol                   [10:10]          get_vmon_3p3v_h_thresh1_viol
''                                                             set_vmon_3p3v_h_thresh1_viol
''                                                             read_vmon_3p3v_h_thresh1_viol
''                                                             write_vmon_3p3v_h_thresh1_viol
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh2_viol                   [11:11]          get_vmon_3p3v_h_thresh2_viol
''                                                             set_vmon_3p3v_h_thresh2_viol
''                                                             read_vmon_3p3v_h_thresh2_viol
''                                                             write_vmon_3p3v_h_thresh2_viol
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh1_viol                   [12:12]          get_vmon_3p3v_l_thresh1_viol
''                                                             set_vmon_3p3v_l_thresh1_viol
''                                                             read_vmon_3p3v_l_thresh1_viol
''                                                             write_vmon_3p3v_l_thresh1_viol
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh2_viol                   [13:13]          get_vmon_3p3v_l_thresh2_viol
''                                                             set_vmon_3p3v_l_thresh2_viol
''                                                             read_vmon_3p3v_l_thresh2_viol
''                                                             write_vmon_3p3v_l_thresh2_viol
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_viol_rawsts
    Private write_tmon_thresh1_viol_value
    Private read_tmon_thresh1_viol_value
    Private flag_tmon_thresh1_viol
    Private write_tmon_thresh2_viol_value
    Private read_tmon_thresh2_viol_value
    Private flag_tmon_thresh2_viol
    Private write_vmon_1v_h_thresh1_viol_value
    Private read_vmon_1v_h_thresh1_viol_value
    Private flag_vmon_1v_h_thresh1_viol
    Private write_vmon_1v_h_thresh2_viol_value
    Private read_vmon_1v_h_thresh2_viol_value
    Private flag_vmon_1v_h_thresh2_viol
    Private write_vmon_1v_l_thresh1_viol_value
    Private read_vmon_1v_l_thresh1_viol_value
    Private flag_vmon_1v_l_thresh1_viol
    Private write_vmon_1v_l_thresh2_viol_value
    Private read_vmon_1v_l_thresh2_viol_value
    Private flag_vmon_1v_l_thresh2_viol
    Private write_vmon_1p8v_h_thresh1_viol_value
    Private read_vmon_1p8v_h_thresh1_viol_value
    Private flag_vmon_1p8v_h_thresh1_viol
    Private write_vmon_1p8v_h_thresh2_viol_value
    Private read_vmon_1p8v_h_thresh2_viol_value
    Private flag_vmon_1p8v_h_thresh2_viol
    Private write_vmon_1p8v_l_thresh1_viol_value
    Private read_vmon_1p8v_l_thresh1_viol_value
    Private flag_vmon_1p8v_l_thresh1_viol
    Private write_vmon_1p8v_l_thresh2_viol_value
    Private read_vmon_1p8v_l_thresh2_viol_value
    Private flag_vmon_1p8v_l_thresh2_viol
    Private write_vmon_3p3v_h_thresh1_viol_value
    Private read_vmon_3p3v_h_thresh1_viol_value
    Private flag_vmon_3p3v_h_thresh1_viol
    Private write_vmon_3p3v_h_thresh2_viol_value
    Private read_vmon_3p3v_h_thresh2_viol_value
    Private flag_vmon_3p3v_h_thresh2_viol
    Private write_vmon_3p3v_l_thresh1_viol_value
    Private read_vmon_3p3v_l_thresh1_viol_value
    Private flag_vmon_3p3v_l_thresh1_viol
    Private write_vmon_3p3v_l_thresh2_viol_value
    Private read_vmon_3p3v_l_thresh2_viol_value
    Private flag_vmon_3p3v_l_thresh2_viol

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tmon_thresh1_viol
        get_tmon_thresh1_viol = read_tmon_thresh1_viol_value
    End Property

    Property Let set_tmon_thresh1_viol(aData)
        write_tmon_thresh1_viol_value = aData
        flag_tmon_thresh1_viol        = &H1
    End Property

    Property Get read_tmon_thresh1_viol
        read
        read_tmon_thresh1_viol = read_tmon_thresh1_viol_value
    End Property

    Property Let write_tmon_thresh1_viol(aData)
        set_tmon_thresh1_viol = aData
        write
    End Property

    Property Get get_tmon_thresh2_viol
        get_tmon_thresh2_viol = read_tmon_thresh2_viol_value
    End Property

    Property Let set_tmon_thresh2_viol(aData)
        write_tmon_thresh2_viol_value = aData
        flag_tmon_thresh2_viol        = &H1
    End Property

    Property Get read_tmon_thresh2_viol
        read
        read_tmon_thresh2_viol = read_tmon_thresh2_viol_value
    End Property

    Property Let write_tmon_thresh2_viol(aData)
        set_tmon_thresh2_viol = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh1_viol
        get_vmon_1v_h_thresh1_viol = read_vmon_1v_h_thresh1_viol_value
    End Property

    Property Let set_vmon_1v_h_thresh1_viol(aData)
        write_vmon_1v_h_thresh1_viol_value = aData
        flag_vmon_1v_h_thresh1_viol        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh1_viol
        read
        read_vmon_1v_h_thresh1_viol = read_vmon_1v_h_thresh1_viol_value
    End Property

    Property Let write_vmon_1v_h_thresh1_viol(aData)
        set_vmon_1v_h_thresh1_viol = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh2_viol
        get_vmon_1v_h_thresh2_viol = read_vmon_1v_h_thresh2_viol_value
    End Property

    Property Let set_vmon_1v_h_thresh2_viol(aData)
        write_vmon_1v_h_thresh2_viol_value = aData
        flag_vmon_1v_h_thresh2_viol        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh2_viol
        read
        read_vmon_1v_h_thresh2_viol = read_vmon_1v_h_thresh2_viol_value
    End Property

    Property Let write_vmon_1v_h_thresh2_viol(aData)
        set_vmon_1v_h_thresh2_viol = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh1_viol
        get_vmon_1v_l_thresh1_viol = read_vmon_1v_l_thresh1_viol_value
    End Property

    Property Let set_vmon_1v_l_thresh1_viol(aData)
        write_vmon_1v_l_thresh1_viol_value = aData
        flag_vmon_1v_l_thresh1_viol        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh1_viol
        read
        read_vmon_1v_l_thresh1_viol = read_vmon_1v_l_thresh1_viol_value
    End Property

    Property Let write_vmon_1v_l_thresh1_viol(aData)
        set_vmon_1v_l_thresh1_viol = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh2_viol
        get_vmon_1v_l_thresh2_viol = read_vmon_1v_l_thresh2_viol_value
    End Property

    Property Let set_vmon_1v_l_thresh2_viol(aData)
        write_vmon_1v_l_thresh2_viol_value = aData
        flag_vmon_1v_l_thresh2_viol        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh2_viol
        read
        read_vmon_1v_l_thresh2_viol = read_vmon_1v_l_thresh2_viol_value
    End Property

    Property Let write_vmon_1v_l_thresh2_viol(aData)
        set_vmon_1v_l_thresh2_viol = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh1_viol
        get_vmon_1p8v_h_thresh1_viol = read_vmon_1p8v_h_thresh1_viol_value
    End Property

    Property Let set_vmon_1p8v_h_thresh1_viol(aData)
        write_vmon_1p8v_h_thresh1_viol_value = aData
        flag_vmon_1p8v_h_thresh1_viol        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh1_viol
        read
        read_vmon_1p8v_h_thresh1_viol = read_vmon_1p8v_h_thresh1_viol_value
    End Property

    Property Let write_vmon_1p8v_h_thresh1_viol(aData)
        set_vmon_1p8v_h_thresh1_viol = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh2_viol
        get_vmon_1p8v_h_thresh2_viol = read_vmon_1p8v_h_thresh2_viol_value
    End Property

    Property Let set_vmon_1p8v_h_thresh2_viol(aData)
        write_vmon_1p8v_h_thresh2_viol_value = aData
        flag_vmon_1p8v_h_thresh2_viol        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh2_viol
        read
        read_vmon_1p8v_h_thresh2_viol = read_vmon_1p8v_h_thresh2_viol_value
    End Property

    Property Let write_vmon_1p8v_h_thresh2_viol(aData)
        set_vmon_1p8v_h_thresh2_viol = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh1_viol
        get_vmon_1p8v_l_thresh1_viol = read_vmon_1p8v_l_thresh1_viol_value
    End Property

    Property Let set_vmon_1p8v_l_thresh1_viol(aData)
        write_vmon_1p8v_l_thresh1_viol_value = aData
        flag_vmon_1p8v_l_thresh1_viol        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh1_viol
        read
        read_vmon_1p8v_l_thresh1_viol = read_vmon_1p8v_l_thresh1_viol_value
    End Property

    Property Let write_vmon_1p8v_l_thresh1_viol(aData)
        set_vmon_1p8v_l_thresh1_viol = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh2_viol
        get_vmon_1p8v_l_thresh2_viol = read_vmon_1p8v_l_thresh2_viol_value
    End Property

    Property Let set_vmon_1p8v_l_thresh2_viol(aData)
        write_vmon_1p8v_l_thresh2_viol_value = aData
        flag_vmon_1p8v_l_thresh2_viol        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh2_viol
        read
        read_vmon_1p8v_l_thresh2_viol = read_vmon_1p8v_l_thresh2_viol_value
    End Property

    Property Let write_vmon_1p8v_l_thresh2_viol(aData)
        set_vmon_1p8v_l_thresh2_viol = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh1_viol
        get_vmon_3p3v_h_thresh1_viol = read_vmon_3p3v_h_thresh1_viol_value
    End Property

    Property Let set_vmon_3p3v_h_thresh1_viol(aData)
        write_vmon_3p3v_h_thresh1_viol_value = aData
        flag_vmon_3p3v_h_thresh1_viol        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh1_viol
        read
        read_vmon_3p3v_h_thresh1_viol = read_vmon_3p3v_h_thresh1_viol_value
    End Property

    Property Let write_vmon_3p3v_h_thresh1_viol(aData)
        set_vmon_3p3v_h_thresh1_viol = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh2_viol
        get_vmon_3p3v_h_thresh2_viol = read_vmon_3p3v_h_thresh2_viol_value
    End Property

    Property Let set_vmon_3p3v_h_thresh2_viol(aData)
        write_vmon_3p3v_h_thresh2_viol_value = aData
        flag_vmon_3p3v_h_thresh2_viol        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh2_viol
        read
        read_vmon_3p3v_h_thresh2_viol = read_vmon_3p3v_h_thresh2_viol_value
    End Property

    Property Let write_vmon_3p3v_h_thresh2_viol(aData)
        set_vmon_3p3v_h_thresh2_viol = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh1_viol
        get_vmon_3p3v_l_thresh1_viol = read_vmon_3p3v_l_thresh1_viol_value
    End Property

    Property Let set_vmon_3p3v_l_thresh1_viol(aData)
        write_vmon_3p3v_l_thresh1_viol_value = aData
        flag_vmon_3p3v_l_thresh1_viol        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh1_viol
        read
        read_vmon_3p3v_l_thresh1_viol = read_vmon_3p3v_l_thresh1_viol_value
    End Property

    Property Let write_vmon_3p3v_l_thresh1_viol(aData)
        set_vmon_3p3v_l_thresh1_viol = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh2_viol
        get_vmon_3p3v_l_thresh2_viol = read_vmon_3p3v_l_thresh2_viol_value
    End Property

    Property Let set_vmon_3p3v_l_thresh2_viol(aData)
        write_vmon_3p3v_l_thresh2_viol_value = aData
        flag_vmon_3p3v_l_thresh2_viol        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh2_viol
        read
        read_vmon_3p3v_l_thresh2_viol = read_vmon_3p3v_l_thresh2_viol_value
    End Property

    Property Let write_vmon_3p3v_l_thresh2_viol(aData)
        set_vmon_3p3v_l_thresh2_viol = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_thresh1_viol_mask = &H1
        if data_low > LONG_MAX then
            if tmon_thresh1_viol_mask = mask then
                read_tmon_thresh1_viol_value = data_low
            else
                read_tmon_thresh1_viol_value = (data_low - H8000_0000) and tmon_thresh1_viol_mask
            end If
        else
            read_tmon_thresh1_viol_value = data_low and tmon_thresh1_viol_mask
        end If
        read_tmon_thresh2_viol_value = rightShift(data_low, 1) and &H1
        read_vmon_1v_h_thresh1_viol_value = rightShift(data_low, 2) and &H1
        read_vmon_1v_h_thresh2_viol_value = rightShift(data_low, 3) and &H1
        read_vmon_1v_l_thresh1_viol_value = rightShift(data_low, 4) and &H1
        read_vmon_1v_l_thresh2_viol_value = rightShift(data_low, 5) and &H1
        read_vmon_1p8v_h_thresh1_viol_value = rightShift(data_low, 6) and &H1
        read_vmon_1p8v_h_thresh2_viol_value = rightShift(data_low, 7) and &H1
        read_vmon_1p8v_l_thresh1_viol_value = rightShift(data_low, 8) and &H1
        read_vmon_1p8v_l_thresh2_viol_value = rightShift(data_low, 9) and &H1
        read_vmon_3p3v_h_thresh1_viol_value = rightShift(data_low, 10) and &H1
        read_vmon_3p3v_h_thresh2_viol_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_viol_value = rightShift(data_low, 12) and &H1
        read_vmon_3p3v_l_thresh2_viol_value = rightShift(data_low, 13) and &H1

    End Sub

    Sub write
        If flag_tmon_thresh1_viol = &H0 or flag_tmon_thresh2_viol = &H0 or flag_vmon_1v_h_thresh1_viol = &H0 or flag_vmon_1v_h_thresh2_viol = &H0 or flag_vmon_1v_l_thresh1_viol = &H0 or flag_vmon_1v_l_thresh2_viol = &H0 or flag_vmon_1p8v_h_thresh1_viol = &H0 or flag_vmon_1p8v_h_thresh2_viol = &H0 or flag_vmon_1p8v_l_thresh1_viol = &H0 or flag_vmon_1p8v_l_thresh2_viol = &H0 or flag_vmon_3p3v_h_thresh1_viol = &H0 or flag_vmon_3p3v_h_thresh2_viol = &H0 or flag_vmon_3p3v_l_thresh1_viol = &H0 or flag_vmon_3p3v_l_thresh2_viol = &H0 Then read
        If flag_tmon_thresh1_viol = &H0 Then write_tmon_thresh1_viol_value = get_tmon_thresh1_viol
        If flag_tmon_thresh2_viol = &H0 Then write_tmon_thresh2_viol_value = get_tmon_thresh2_viol
        If flag_vmon_1v_h_thresh1_viol = &H0 Then write_vmon_1v_h_thresh1_viol_value = get_vmon_1v_h_thresh1_viol
        If flag_vmon_1v_h_thresh2_viol = &H0 Then write_vmon_1v_h_thresh2_viol_value = get_vmon_1v_h_thresh2_viol
        If flag_vmon_1v_l_thresh1_viol = &H0 Then write_vmon_1v_l_thresh1_viol_value = get_vmon_1v_l_thresh1_viol
        If flag_vmon_1v_l_thresh2_viol = &H0 Then write_vmon_1v_l_thresh2_viol_value = get_vmon_1v_l_thresh2_viol
        If flag_vmon_1p8v_h_thresh1_viol = &H0 Then write_vmon_1p8v_h_thresh1_viol_value = get_vmon_1p8v_h_thresh1_viol
        If flag_vmon_1p8v_h_thresh2_viol = &H0 Then write_vmon_1p8v_h_thresh2_viol_value = get_vmon_1p8v_h_thresh2_viol
        If flag_vmon_1p8v_l_thresh1_viol = &H0 Then write_vmon_1p8v_l_thresh1_viol_value = get_vmon_1p8v_l_thresh1_viol
        If flag_vmon_1p8v_l_thresh2_viol = &H0 Then write_vmon_1p8v_l_thresh2_viol_value = get_vmon_1p8v_l_thresh2_viol
        If flag_vmon_3p3v_h_thresh1_viol = &H0 Then write_vmon_3p3v_h_thresh1_viol_value = get_vmon_3p3v_h_thresh1_viol
        If flag_vmon_3p3v_h_thresh2_viol = &H0 Then write_vmon_3p3v_h_thresh2_viol_value = get_vmon_3p3v_h_thresh2_viol
        If flag_vmon_3p3v_l_thresh1_viol = &H0 Then write_vmon_3p3v_l_thresh1_viol_value = get_vmon_3p3v_l_thresh1_viol
        If flag_vmon_3p3v_l_thresh2_viol = &H0 Then write_vmon_3p3v_l_thresh2_viol_value = get_vmon_3p3v_l_thresh2_viol

        regValue = leftShift((write_tmon_thresh1_viol_value and &H1), 0) + leftShift((write_tmon_thresh2_viol_value and &H1), 1) + leftShift((write_vmon_1v_h_thresh1_viol_value and &H1), 2) + leftShift((write_vmon_1v_h_thresh2_viol_value and &H1), 3) + leftShift((write_vmon_1v_l_thresh1_viol_value and &H1), 4) + leftShift((write_vmon_1v_l_thresh2_viol_value and &H1), 5) + leftShift((write_vmon_1p8v_h_thresh1_viol_value and &H1), 6) + leftShift((write_vmon_1p8v_h_thresh2_viol_value and &H1), 7) + leftShift((write_vmon_1p8v_l_thresh1_viol_value and &H1), 8) + leftShift((write_vmon_1p8v_l_thresh2_viol_value and &H1), 9) + leftShift((write_vmon_3p3v_h_thresh1_viol_value and &H1), 10) + leftShift((write_vmon_3p3v_h_thresh2_viol_value and &H1), 11) + leftShift((write_vmon_3p3v_l_thresh1_viol_value and &H1), 12) + leftShift((write_vmon_3p3v_l_thresh2_viol_value and &H1), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_thresh1_viol_mask = &H1
        if data_low > LONG_MAX then
            if tmon_thresh1_viol_mask = mask then
                read_tmon_thresh1_viol_value = data_low
            else
                read_tmon_thresh1_viol_value = (data_low - H8000_0000) and tmon_thresh1_viol_mask
            end If
        else
            read_tmon_thresh1_viol_value = data_low and tmon_thresh1_viol_mask
        end If
        read_tmon_thresh2_viol_value = rightShift(data_low, 1) and &H1
        read_vmon_1v_h_thresh1_viol_value = rightShift(data_low, 2) and &H1
        read_vmon_1v_h_thresh2_viol_value = rightShift(data_low, 3) and &H1
        read_vmon_1v_l_thresh1_viol_value = rightShift(data_low, 4) and &H1
        read_vmon_1v_l_thresh2_viol_value = rightShift(data_low, 5) and &H1
        read_vmon_1p8v_h_thresh1_viol_value = rightShift(data_low, 6) and &H1
        read_vmon_1p8v_h_thresh2_viol_value = rightShift(data_low, 7) and &H1
        read_vmon_1p8v_l_thresh1_viol_value = rightShift(data_low, 8) and &H1
        read_vmon_1p8v_l_thresh2_viol_value = rightShift(data_low, 9) and &H1
        read_vmon_3p3v_h_thresh1_viol_value = rightShift(data_low, 10) and &H1
        read_vmon_3p3v_h_thresh2_viol_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_viol_value = rightShift(data_low, 12) and &H1
        read_vmon_3p3v_l_thresh2_viol_value = rightShift(data_low, 13) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tmon_thresh1_viol_value = &H0
        flag_tmon_thresh1_viol        = &H0
        write_tmon_thresh2_viol_value = &H0
        flag_tmon_thresh2_viol        = &H0
        write_vmon_1v_h_thresh1_viol_value = &H0
        flag_vmon_1v_h_thresh1_viol        = &H0
        write_vmon_1v_h_thresh2_viol_value = &H0
        flag_vmon_1v_h_thresh2_viol        = &H0
        write_vmon_1v_l_thresh1_viol_value = &H0
        flag_vmon_1v_l_thresh1_viol        = &H0
        write_vmon_1v_l_thresh2_viol_value = &H0
        flag_vmon_1v_l_thresh2_viol        = &H0
        write_vmon_1p8v_h_thresh1_viol_value = &H0
        flag_vmon_1p8v_h_thresh1_viol        = &H0
        write_vmon_1p8v_h_thresh2_viol_value = &H0
        flag_vmon_1p8v_h_thresh2_viol        = &H0
        write_vmon_1p8v_l_thresh1_viol_value = &H0
        flag_vmon_1p8v_l_thresh1_viol        = &H0
        write_vmon_1p8v_l_thresh2_viol_value = &H0
        flag_vmon_1p8v_l_thresh2_viol        = &H0
        write_vmon_3p3v_h_thresh1_viol_value = &H0
        flag_vmon_3p3v_h_thresh1_viol        = &H0
        write_vmon_3p3v_h_thresh2_viol_value = &H0
        flag_vmon_3p3v_h_thresh2_viol        = &H0
        write_vmon_3p3v_l_thresh1_viol_value = &H0
        flag_vmon_3p3v_l_thresh1_viol        = &H0
        write_vmon_3p3v_l_thresh2_viol_value = &H0
        flag_vmon_3p3v_l_thresh2_viol        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_intr_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tmon_thresh1_intr                          [0:0]            get_tmon_thresh1_intr
''                                                             set_tmon_thresh1_intr
''                                                             read_tmon_thresh1_intr
''                                                             write_tmon_thresh1_intr
''---------------------------------------------------------------------------------
'' tmon_thresh2_intr                          [1:1]            get_tmon_thresh2_intr
''                                                             set_tmon_thresh2_intr
''                                                             read_tmon_thresh2_intr
''                                                             write_tmon_thresh2_intr
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh1_intr                     [2:2]            get_vmon_1v_h_thresh1_intr
''                                                             set_vmon_1v_h_thresh1_intr
''                                                             read_vmon_1v_h_thresh1_intr
''                                                             write_vmon_1v_h_thresh1_intr
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh2_intr                     [3:3]            get_vmon_1v_h_thresh2_intr
''                                                             set_vmon_1v_h_thresh2_intr
''                                                             read_vmon_1v_h_thresh2_intr
''                                                             write_vmon_1v_h_thresh2_intr
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh1_intr                     [4:4]            get_vmon_1v_l_thresh1_intr
''                                                             set_vmon_1v_l_thresh1_intr
''                                                             read_vmon_1v_l_thresh1_intr
''                                                             write_vmon_1v_l_thresh1_intr
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh2_intr                     [5:5]            get_vmon_1v_l_thresh2_intr
''                                                             set_vmon_1v_l_thresh2_intr
''                                                             read_vmon_1v_l_thresh2_intr
''                                                             write_vmon_1v_l_thresh2_intr
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh1_intr                   [6:6]            get_vmon_1p8v_h_thresh1_intr
''                                                             set_vmon_1p8v_h_thresh1_intr
''                                                             read_vmon_1p8v_h_thresh1_intr
''                                                             write_vmon_1p8v_h_thresh1_intr
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh2_intr                   [7:7]            get_vmon_1p8v_h_thresh2_intr
''                                                             set_vmon_1p8v_h_thresh2_intr
''                                                             read_vmon_1p8v_h_thresh2_intr
''                                                             write_vmon_1p8v_h_thresh2_intr
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh1_intr                   [8:8]            get_vmon_1p8v_l_thresh1_intr
''                                                             set_vmon_1p8v_l_thresh1_intr
''                                                             read_vmon_1p8v_l_thresh1_intr
''                                                             write_vmon_1p8v_l_thresh1_intr
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh2_intr                   [9:9]            get_vmon_1p8v_l_thresh2_intr
''                                                             set_vmon_1p8v_l_thresh2_intr
''                                                             read_vmon_1p8v_l_thresh2_intr
''                                                             write_vmon_1p8v_l_thresh2_intr
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh1_intr                   [10:10]          get_vmon_3p3v_h_thresh1_intr
''                                                             set_vmon_3p3v_h_thresh1_intr
''                                                             read_vmon_3p3v_h_thresh1_intr
''                                                             write_vmon_3p3v_h_thresh1_intr
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh2_intr                   [11:11]          get_vmon_3p3v_h_thresh2_intr
''                                                             set_vmon_3p3v_h_thresh2_intr
''                                                             read_vmon_3p3v_h_thresh2_intr
''                                                             write_vmon_3p3v_h_thresh2_intr
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh1_intr                   [12:12]          get_vmon_3p3v_l_thresh1_intr
''                                                             set_vmon_3p3v_l_thresh1_intr
''                                                             read_vmon_3p3v_l_thresh1_intr
''                                                             write_vmon_3p3v_l_thresh1_intr
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh2_intr                   [13:13]          get_vmon_3p3v_l_thresh2_intr
''                                                             set_vmon_3p3v_l_thresh2_intr
''                                                             read_vmon_3p3v_l_thresh2_intr
''                                                             write_vmon_3p3v_l_thresh2_intr
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_intr_status
    Private write_tmon_thresh1_intr_value
    Private read_tmon_thresh1_intr_value
    Private flag_tmon_thresh1_intr
    Private write_tmon_thresh2_intr_value
    Private read_tmon_thresh2_intr_value
    Private flag_tmon_thresh2_intr
    Private write_vmon_1v_h_thresh1_intr_value
    Private read_vmon_1v_h_thresh1_intr_value
    Private flag_vmon_1v_h_thresh1_intr
    Private write_vmon_1v_h_thresh2_intr_value
    Private read_vmon_1v_h_thresh2_intr_value
    Private flag_vmon_1v_h_thresh2_intr
    Private write_vmon_1v_l_thresh1_intr_value
    Private read_vmon_1v_l_thresh1_intr_value
    Private flag_vmon_1v_l_thresh1_intr
    Private write_vmon_1v_l_thresh2_intr_value
    Private read_vmon_1v_l_thresh2_intr_value
    Private flag_vmon_1v_l_thresh2_intr
    Private write_vmon_1p8v_h_thresh1_intr_value
    Private read_vmon_1p8v_h_thresh1_intr_value
    Private flag_vmon_1p8v_h_thresh1_intr
    Private write_vmon_1p8v_h_thresh2_intr_value
    Private read_vmon_1p8v_h_thresh2_intr_value
    Private flag_vmon_1p8v_h_thresh2_intr
    Private write_vmon_1p8v_l_thresh1_intr_value
    Private read_vmon_1p8v_l_thresh1_intr_value
    Private flag_vmon_1p8v_l_thresh1_intr
    Private write_vmon_1p8v_l_thresh2_intr_value
    Private read_vmon_1p8v_l_thresh2_intr_value
    Private flag_vmon_1p8v_l_thresh2_intr
    Private write_vmon_3p3v_h_thresh1_intr_value
    Private read_vmon_3p3v_h_thresh1_intr_value
    Private flag_vmon_3p3v_h_thresh1_intr
    Private write_vmon_3p3v_h_thresh2_intr_value
    Private read_vmon_3p3v_h_thresh2_intr_value
    Private flag_vmon_3p3v_h_thresh2_intr
    Private write_vmon_3p3v_l_thresh1_intr_value
    Private read_vmon_3p3v_l_thresh1_intr_value
    Private flag_vmon_3p3v_l_thresh1_intr
    Private write_vmon_3p3v_l_thresh2_intr_value
    Private read_vmon_3p3v_l_thresh2_intr_value
    Private flag_vmon_3p3v_l_thresh2_intr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tmon_thresh1_intr
        get_tmon_thresh1_intr = read_tmon_thresh1_intr_value
    End Property

    Property Let set_tmon_thresh1_intr(aData)
        write_tmon_thresh1_intr_value = aData
        flag_tmon_thresh1_intr        = &H1
    End Property

    Property Get read_tmon_thresh1_intr
        read
        read_tmon_thresh1_intr = read_tmon_thresh1_intr_value
    End Property

    Property Let write_tmon_thresh1_intr(aData)
        set_tmon_thresh1_intr = aData
        write
    End Property

    Property Get get_tmon_thresh2_intr
        get_tmon_thresh2_intr = read_tmon_thresh2_intr_value
    End Property

    Property Let set_tmon_thresh2_intr(aData)
        write_tmon_thresh2_intr_value = aData
        flag_tmon_thresh2_intr        = &H1
    End Property

    Property Get read_tmon_thresh2_intr
        read
        read_tmon_thresh2_intr = read_tmon_thresh2_intr_value
    End Property

    Property Let write_tmon_thresh2_intr(aData)
        set_tmon_thresh2_intr = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh1_intr
        get_vmon_1v_h_thresh1_intr = read_vmon_1v_h_thresh1_intr_value
    End Property

    Property Let set_vmon_1v_h_thresh1_intr(aData)
        write_vmon_1v_h_thresh1_intr_value = aData
        flag_vmon_1v_h_thresh1_intr        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh1_intr
        read
        read_vmon_1v_h_thresh1_intr = read_vmon_1v_h_thresh1_intr_value
    End Property

    Property Let write_vmon_1v_h_thresh1_intr(aData)
        set_vmon_1v_h_thresh1_intr = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh2_intr
        get_vmon_1v_h_thresh2_intr = read_vmon_1v_h_thresh2_intr_value
    End Property

    Property Let set_vmon_1v_h_thresh2_intr(aData)
        write_vmon_1v_h_thresh2_intr_value = aData
        flag_vmon_1v_h_thresh2_intr        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh2_intr
        read
        read_vmon_1v_h_thresh2_intr = read_vmon_1v_h_thresh2_intr_value
    End Property

    Property Let write_vmon_1v_h_thresh2_intr(aData)
        set_vmon_1v_h_thresh2_intr = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh1_intr
        get_vmon_1v_l_thresh1_intr = read_vmon_1v_l_thresh1_intr_value
    End Property

    Property Let set_vmon_1v_l_thresh1_intr(aData)
        write_vmon_1v_l_thresh1_intr_value = aData
        flag_vmon_1v_l_thresh1_intr        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh1_intr
        read
        read_vmon_1v_l_thresh1_intr = read_vmon_1v_l_thresh1_intr_value
    End Property

    Property Let write_vmon_1v_l_thresh1_intr(aData)
        set_vmon_1v_l_thresh1_intr = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh2_intr
        get_vmon_1v_l_thresh2_intr = read_vmon_1v_l_thresh2_intr_value
    End Property

    Property Let set_vmon_1v_l_thresh2_intr(aData)
        write_vmon_1v_l_thresh2_intr_value = aData
        flag_vmon_1v_l_thresh2_intr        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh2_intr
        read
        read_vmon_1v_l_thresh2_intr = read_vmon_1v_l_thresh2_intr_value
    End Property

    Property Let write_vmon_1v_l_thresh2_intr(aData)
        set_vmon_1v_l_thresh2_intr = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh1_intr
        get_vmon_1p8v_h_thresh1_intr = read_vmon_1p8v_h_thresh1_intr_value
    End Property

    Property Let set_vmon_1p8v_h_thresh1_intr(aData)
        write_vmon_1p8v_h_thresh1_intr_value = aData
        flag_vmon_1p8v_h_thresh1_intr        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh1_intr
        read
        read_vmon_1p8v_h_thresh1_intr = read_vmon_1p8v_h_thresh1_intr_value
    End Property

    Property Let write_vmon_1p8v_h_thresh1_intr(aData)
        set_vmon_1p8v_h_thresh1_intr = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh2_intr
        get_vmon_1p8v_h_thresh2_intr = read_vmon_1p8v_h_thresh2_intr_value
    End Property

    Property Let set_vmon_1p8v_h_thresh2_intr(aData)
        write_vmon_1p8v_h_thresh2_intr_value = aData
        flag_vmon_1p8v_h_thresh2_intr        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh2_intr
        read
        read_vmon_1p8v_h_thresh2_intr = read_vmon_1p8v_h_thresh2_intr_value
    End Property

    Property Let write_vmon_1p8v_h_thresh2_intr(aData)
        set_vmon_1p8v_h_thresh2_intr = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh1_intr
        get_vmon_1p8v_l_thresh1_intr = read_vmon_1p8v_l_thresh1_intr_value
    End Property

    Property Let set_vmon_1p8v_l_thresh1_intr(aData)
        write_vmon_1p8v_l_thresh1_intr_value = aData
        flag_vmon_1p8v_l_thresh1_intr        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh1_intr
        read
        read_vmon_1p8v_l_thresh1_intr = read_vmon_1p8v_l_thresh1_intr_value
    End Property

    Property Let write_vmon_1p8v_l_thresh1_intr(aData)
        set_vmon_1p8v_l_thresh1_intr = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh2_intr
        get_vmon_1p8v_l_thresh2_intr = read_vmon_1p8v_l_thresh2_intr_value
    End Property

    Property Let set_vmon_1p8v_l_thresh2_intr(aData)
        write_vmon_1p8v_l_thresh2_intr_value = aData
        flag_vmon_1p8v_l_thresh2_intr        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh2_intr
        read
        read_vmon_1p8v_l_thresh2_intr = read_vmon_1p8v_l_thresh2_intr_value
    End Property

    Property Let write_vmon_1p8v_l_thresh2_intr(aData)
        set_vmon_1p8v_l_thresh2_intr = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh1_intr
        get_vmon_3p3v_h_thresh1_intr = read_vmon_3p3v_h_thresh1_intr_value
    End Property

    Property Let set_vmon_3p3v_h_thresh1_intr(aData)
        write_vmon_3p3v_h_thresh1_intr_value = aData
        flag_vmon_3p3v_h_thresh1_intr        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh1_intr
        read
        read_vmon_3p3v_h_thresh1_intr = read_vmon_3p3v_h_thresh1_intr_value
    End Property

    Property Let write_vmon_3p3v_h_thresh1_intr(aData)
        set_vmon_3p3v_h_thresh1_intr = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh2_intr
        get_vmon_3p3v_h_thresh2_intr = read_vmon_3p3v_h_thresh2_intr_value
    End Property

    Property Let set_vmon_3p3v_h_thresh2_intr(aData)
        write_vmon_3p3v_h_thresh2_intr_value = aData
        flag_vmon_3p3v_h_thresh2_intr        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh2_intr
        read
        read_vmon_3p3v_h_thresh2_intr = read_vmon_3p3v_h_thresh2_intr_value
    End Property

    Property Let write_vmon_3p3v_h_thresh2_intr(aData)
        set_vmon_3p3v_h_thresh2_intr = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh1_intr
        get_vmon_3p3v_l_thresh1_intr = read_vmon_3p3v_l_thresh1_intr_value
    End Property

    Property Let set_vmon_3p3v_l_thresh1_intr(aData)
        write_vmon_3p3v_l_thresh1_intr_value = aData
        flag_vmon_3p3v_l_thresh1_intr        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh1_intr
        read
        read_vmon_3p3v_l_thresh1_intr = read_vmon_3p3v_l_thresh1_intr_value
    End Property

    Property Let write_vmon_3p3v_l_thresh1_intr(aData)
        set_vmon_3p3v_l_thresh1_intr = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh2_intr
        get_vmon_3p3v_l_thresh2_intr = read_vmon_3p3v_l_thresh2_intr_value
    End Property

    Property Let set_vmon_3p3v_l_thresh2_intr(aData)
        write_vmon_3p3v_l_thresh2_intr_value = aData
        flag_vmon_3p3v_l_thresh2_intr        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh2_intr
        read
        read_vmon_3p3v_l_thresh2_intr = read_vmon_3p3v_l_thresh2_intr_value
    End Property

    Property Let write_vmon_3p3v_l_thresh2_intr(aData)
        set_vmon_3p3v_l_thresh2_intr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_thresh1_intr_mask = &H1
        if data_low > LONG_MAX then
            if tmon_thresh1_intr_mask = mask then
                read_tmon_thresh1_intr_value = data_low
            else
                read_tmon_thresh1_intr_value = (data_low - H8000_0000) and tmon_thresh1_intr_mask
            end If
        else
            read_tmon_thresh1_intr_value = data_low and tmon_thresh1_intr_mask
        end If
        read_tmon_thresh2_intr_value = rightShift(data_low, 1) and &H1
        read_vmon_1v_h_thresh1_intr_value = rightShift(data_low, 2) and &H1
        read_vmon_1v_h_thresh2_intr_value = rightShift(data_low, 3) and &H1
        read_vmon_1v_l_thresh1_intr_value = rightShift(data_low, 4) and &H1
        read_vmon_1v_l_thresh2_intr_value = rightShift(data_low, 5) and &H1
        read_vmon_1p8v_h_thresh1_intr_value = rightShift(data_low, 6) and &H1
        read_vmon_1p8v_h_thresh2_intr_value = rightShift(data_low, 7) and &H1
        read_vmon_1p8v_l_thresh1_intr_value = rightShift(data_low, 8) and &H1
        read_vmon_1p8v_l_thresh2_intr_value = rightShift(data_low, 9) and &H1
        read_vmon_3p3v_h_thresh1_intr_value = rightShift(data_low, 10) and &H1
        read_vmon_3p3v_h_thresh2_intr_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_intr_value = rightShift(data_low, 12) and &H1
        read_vmon_3p3v_l_thresh2_intr_value = rightShift(data_low, 13) and &H1

    End Sub

    Sub write
        If flag_tmon_thresh1_intr = &H0 or flag_tmon_thresh2_intr = &H0 or flag_vmon_1v_h_thresh1_intr = &H0 or flag_vmon_1v_h_thresh2_intr = &H0 or flag_vmon_1v_l_thresh1_intr = &H0 or flag_vmon_1v_l_thresh2_intr = &H0 or flag_vmon_1p8v_h_thresh1_intr = &H0 or flag_vmon_1p8v_h_thresh2_intr = &H0 or flag_vmon_1p8v_l_thresh1_intr = &H0 or flag_vmon_1p8v_l_thresh2_intr = &H0 or flag_vmon_3p3v_h_thresh1_intr = &H0 or flag_vmon_3p3v_h_thresh2_intr = &H0 or flag_vmon_3p3v_l_thresh1_intr = &H0 or flag_vmon_3p3v_l_thresh2_intr = &H0 Then read
        If flag_tmon_thresh1_intr = &H0 Then write_tmon_thresh1_intr_value = get_tmon_thresh1_intr
        If flag_tmon_thresh2_intr = &H0 Then write_tmon_thresh2_intr_value = get_tmon_thresh2_intr
        If flag_vmon_1v_h_thresh1_intr = &H0 Then write_vmon_1v_h_thresh1_intr_value = get_vmon_1v_h_thresh1_intr
        If flag_vmon_1v_h_thresh2_intr = &H0 Then write_vmon_1v_h_thresh2_intr_value = get_vmon_1v_h_thresh2_intr
        If flag_vmon_1v_l_thresh1_intr = &H0 Then write_vmon_1v_l_thresh1_intr_value = get_vmon_1v_l_thresh1_intr
        If flag_vmon_1v_l_thresh2_intr = &H0 Then write_vmon_1v_l_thresh2_intr_value = get_vmon_1v_l_thresh2_intr
        If flag_vmon_1p8v_h_thresh1_intr = &H0 Then write_vmon_1p8v_h_thresh1_intr_value = get_vmon_1p8v_h_thresh1_intr
        If flag_vmon_1p8v_h_thresh2_intr = &H0 Then write_vmon_1p8v_h_thresh2_intr_value = get_vmon_1p8v_h_thresh2_intr
        If flag_vmon_1p8v_l_thresh1_intr = &H0 Then write_vmon_1p8v_l_thresh1_intr_value = get_vmon_1p8v_l_thresh1_intr
        If flag_vmon_1p8v_l_thresh2_intr = &H0 Then write_vmon_1p8v_l_thresh2_intr_value = get_vmon_1p8v_l_thresh2_intr
        If flag_vmon_3p3v_h_thresh1_intr = &H0 Then write_vmon_3p3v_h_thresh1_intr_value = get_vmon_3p3v_h_thresh1_intr
        If flag_vmon_3p3v_h_thresh2_intr = &H0 Then write_vmon_3p3v_h_thresh2_intr_value = get_vmon_3p3v_h_thresh2_intr
        If flag_vmon_3p3v_l_thresh1_intr = &H0 Then write_vmon_3p3v_l_thresh1_intr_value = get_vmon_3p3v_l_thresh1_intr
        If flag_vmon_3p3v_l_thresh2_intr = &H0 Then write_vmon_3p3v_l_thresh2_intr_value = get_vmon_3p3v_l_thresh2_intr

        regValue = leftShift((write_tmon_thresh1_intr_value and &H1), 0) + leftShift((write_tmon_thresh2_intr_value and &H1), 1) + leftShift((write_vmon_1v_h_thresh1_intr_value and &H1), 2) + leftShift((write_vmon_1v_h_thresh2_intr_value and &H1), 3) + leftShift((write_vmon_1v_l_thresh1_intr_value and &H1), 4) + leftShift((write_vmon_1v_l_thresh2_intr_value and &H1), 5) + leftShift((write_vmon_1p8v_h_thresh1_intr_value and &H1), 6) + leftShift((write_vmon_1p8v_h_thresh2_intr_value and &H1), 7) + leftShift((write_vmon_1p8v_l_thresh1_intr_value and &H1), 8) + leftShift((write_vmon_1p8v_l_thresh2_intr_value and &H1), 9) + leftShift((write_vmon_3p3v_h_thresh1_intr_value and &H1), 10) + leftShift((write_vmon_3p3v_h_thresh2_intr_value and &H1), 11) + leftShift((write_vmon_3p3v_l_thresh1_intr_value and &H1), 12) + leftShift((write_vmon_3p3v_l_thresh2_intr_value and &H1), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_thresh1_intr_mask = &H1
        if data_low > LONG_MAX then
            if tmon_thresh1_intr_mask = mask then
                read_tmon_thresh1_intr_value = data_low
            else
                read_tmon_thresh1_intr_value = (data_low - H8000_0000) and tmon_thresh1_intr_mask
            end If
        else
            read_tmon_thresh1_intr_value = data_low and tmon_thresh1_intr_mask
        end If
        read_tmon_thresh2_intr_value = rightShift(data_low, 1) and &H1
        read_vmon_1v_h_thresh1_intr_value = rightShift(data_low, 2) and &H1
        read_vmon_1v_h_thresh2_intr_value = rightShift(data_low, 3) and &H1
        read_vmon_1v_l_thresh1_intr_value = rightShift(data_low, 4) and &H1
        read_vmon_1v_l_thresh2_intr_value = rightShift(data_low, 5) and &H1
        read_vmon_1p8v_h_thresh1_intr_value = rightShift(data_low, 6) and &H1
        read_vmon_1p8v_h_thresh2_intr_value = rightShift(data_low, 7) and &H1
        read_vmon_1p8v_l_thresh1_intr_value = rightShift(data_low, 8) and &H1
        read_vmon_1p8v_l_thresh2_intr_value = rightShift(data_low, 9) and &H1
        read_vmon_3p3v_h_thresh1_intr_value = rightShift(data_low, 10) and &H1
        read_vmon_3p3v_h_thresh2_intr_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_intr_value = rightShift(data_low, 12) and &H1
        read_vmon_3p3v_l_thresh2_intr_value = rightShift(data_low, 13) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tmon_thresh1_intr_value = &H0
        flag_tmon_thresh1_intr        = &H0
        write_tmon_thresh2_intr_value = &H0
        flag_tmon_thresh2_intr        = &H0
        write_vmon_1v_h_thresh1_intr_value = &H0
        flag_vmon_1v_h_thresh1_intr        = &H0
        write_vmon_1v_h_thresh2_intr_value = &H0
        flag_vmon_1v_h_thresh2_intr        = &H0
        write_vmon_1v_l_thresh1_intr_value = &H0
        flag_vmon_1v_l_thresh1_intr        = &H0
        write_vmon_1v_l_thresh2_intr_value = &H0
        flag_vmon_1v_l_thresh2_intr        = &H0
        write_vmon_1p8v_h_thresh1_intr_value = &H0
        flag_vmon_1p8v_h_thresh1_intr        = &H0
        write_vmon_1p8v_h_thresh2_intr_value = &H0
        flag_vmon_1p8v_h_thresh2_intr        = &H0
        write_vmon_1p8v_l_thresh1_intr_value = &H0
        flag_vmon_1p8v_l_thresh1_intr        = &H0
        write_vmon_1p8v_l_thresh2_intr_value = &H0
        flag_vmon_1p8v_l_thresh2_intr        = &H0
        write_vmon_3p3v_h_thresh1_intr_value = &H0
        flag_vmon_3p3v_h_thresh1_intr        = &H0
        write_vmon_3p3v_h_thresh2_intr_value = &H0
        flag_vmon_3p3v_h_thresh2_intr        = &H0
        write_vmon_3p3v_l_thresh1_intr_value = &H0
        flag_vmon_3p3v_l_thresh1_intr        = &H0
        write_vmon_3p3v_l_thresh2_intr_value = &H0
        flag_vmon_3p3v_l_thresh2_intr        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_intsts_clear
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tmon_thresh1_intsts_clear                  [0:0]            get_tmon_thresh1_intsts_clear
''                                                             set_tmon_thresh1_intsts_clear
''                                                             read_tmon_thresh1_intsts_clear
''                                                             write_tmon_thresh1_intsts_clear
''---------------------------------------------------------------------------------
'' tmon_thresh2_intsts_clear                  [1:1]            get_tmon_thresh2_intsts_clear
''                                                             set_tmon_thresh2_intsts_clear
''                                                             read_tmon_thresh2_intsts_clear
''                                                             write_tmon_thresh2_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh1_intsts_clear             [2:2]            get_vmon_1v_h_thresh1_intsts_clear
''                                                             set_vmon_1v_h_thresh1_intsts_clear
''                                                             read_vmon_1v_h_thresh1_intsts_clear
''                                                             write_vmon_1v_h_thresh1_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1v_h_thresh2_intsts_clear             [3:3]            get_vmon_1v_h_thresh2_intsts_clear
''                                                             set_vmon_1v_h_thresh2_intsts_clear
''                                                             read_vmon_1v_h_thresh2_intsts_clear
''                                                             write_vmon_1v_h_thresh2_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh1_intsts_clear             [4:4]            get_vmon_1v_l_thresh1_intsts_clear
''                                                             set_vmon_1v_l_thresh1_intsts_clear
''                                                             read_vmon_1v_l_thresh1_intsts_clear
''                                                             write_vmon_1v_l_thresh1_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1v_l_thresh2_intsts_clear             [5:5]            get_vmon_1v_l_thresh2_intsts_clear
''                                                             set_vmon_1v_l_thresh2_intsts_clear
''                                                             read_vmon_1v_l_thresh2_intsts_clear
''                                                             write_vmon_1v_l_thresh2_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh1_intsts_clear           [6:6]            get_vmon_1p8v_h_thresh1_intsts_clear
''                                                             set_vmon_1p8v_h_thresh1_intsts_clear
''                                                             read_vmon_1p8v_h_thresh1_intsts_clear
''                                                             write_vmon_1p8v_h_thresh1_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1p8v_h_thresh2_intsts_clear           [7:7]            get_vmon_1p8v_h_thresh2_intsts_clear
''                                                             set_vmon_1p8v_h_thresh2_intsts_clear
''                                                             read_vmon_1p8v_h_thresh2_intsts_clear
''                                                             write_vmon_1p8v_h_thresh2_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh1_intsts_clear           [8:8]            get_vmon_1p8v_l_thresh1_intsts_clear
''                                                             set_vmon_1p8v_l_thresh1_intsts_clear
''                                                             read_vmon_1p8v_l_thresh1_intsts_clear
''                                                             write_vmon_1p8v_l_thresh1_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_1p8v_l_thresh2_intsts_clear           [9:9]            get_vmon_1p8v_l_thresh2_intsts_clear
''                                                             set_vmon_1p8v_l_thresh2_intsts_clear
''                                                             read_vmon_1p8v_l_thresh2_intsts_clear
''                                                             write_vmon_1p8v_l_thresh2_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh1_intsts_clear           [10:10]          get_vmon_3p3v_h_thresh1_intsts_clear
''                                                             set_vmon_3p3v_h_thresh1_intsts_clear
''                                                             read_vmon_3p3v_h_thresh1_intsts_clear
''                                                             write_vmon_3p3v_h_thresh1_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_3p3v_h_thresh2_intsts_clear           [11:11]          get_vmon_3p3v_h_thresh2_intsts_clear
''                                                             set_vmon_3p3v_h_thresh2_intsts_clear
''                                                             read_vmon_3p3v_h_thresh2_intsts_clear
''                                                             write_vmon_3p3v_h_thresh2_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh1_intsts_clear           [12:12]          get_vmon_3p3v_l_thresh1_intsts_clear
''                                                             set_vmon_3p3v_l_thresh1_intsts_clear
''                                                             read_vmon_3p3v_l_thresh1_intsts_clear
''                                                             write_vmon_3p3v_l_thresh1_intsts_clear
''---------------------------------------------------------------------------------
'' vmon_3p3v_l_thresh2_intsts_clear           [13:13]          get_vmon_3p3v_l_thresh2_intsts_clear
''                                                             set_vmon_3p3v_l_thresh2_intsts_clear
''                                                             read_vmon_3p3v_l_thresh2_intsts_clear
''                                                             write_vmon_3p3v_l_thresh2_intsts_clear
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_intsts_clear
    Private write_tmon_thresh1_intsts_clear_value
    Private read_tmon_thresh1_intsts_clear_value
    Private flag_tmon_thresh1_intsts_clear
    Private write_tmon_thresh2_intsts_clear_value
    Private read_tmon_thresh2_intsts_clear_value
    Private flag_tmon_thresh2_intsts_clear
    Private write_vmon_1v_h_thresh1_intsts_clear_value
    Private read_vmon_1v_h_thresh1_intsts_clear_value
    Private flag_vmon_1v_h_thresh1_intsts_clear
    Private write_vmon_1v_h_thresh2_intsts_clear_value
    Private read_vmon_1v_h_thresh2_intsts_clear_value
    Private flag_vmon_1v_h_thresh2_intsts_clear
    Private write_vmon_1v_l_thresh1_intsts_clear_value
    Private read_vmon_1v_l_thresh1_intsts_clear_value
    Private flag_vmon_1v_l_thresh1_intsts_clear
    Private write_vmon_1v_l_thresh2_intsts_clear_value
    Private read_vmon_1v_l_thresh2_intsts_clear_value
    Private flag_vmon_1v_l_thresh2_intsts_clear
    Private write_vmon_1p8v_h_thresh1_intsts_clear_value
    Private read_vmon_1p8v_h_thresh1_intsts_clear_value
    Private flag_vmon_1p8v_h_thresh1_intsts_clear
    Private write_vmon_1p8v_h_thresh2_intsts_clear_value
    Private read_vmon_1p8v_h_thresh2_intsts_clear_value
    Private flag_vmon_1p8v_h_thresh2_intsts_clear
    Private write_vmon_1p8v_l_thresh1_intsts_clear_value
    Private read_vmon_1p8v_l_thresh1_intsts_clear_value
    Private flag_vmon_1p8v_l_thresh1_intsts_clear
    Private write_vmon_1p8v_l_thresh2_intsts_clear_value
    Private read_vmon_1p8v_l_thresh2_intsts_clear_value
    Private flag_vmon_1p8v_l_thresh2_intsts_clear
    Private write_vmon_3p3v_h_thresh1_intsts_clear_value
    Private read_vmon_3p3v_h_thresh1_intsts_clear_value
    Private flag_vmon_3p3v_h_thresh1_intsts_clear
    Private write_vmon_3p3v_h_thresh2_intsts_clear_value
    Private read_vmon_3p3v_h_thresh2_intsts_clear_value
    Private flag_vmon_3p3v_h_thresh2_intsts_clear
    Private write_vmon_3p3v_l_thresh1_intsts_clear_value
    Private read_vmon_3p3v_l_thresh1_intsts_clear_value
    Private flag_vmon_3p3v_l_thresh1_intsts_clear
    Private write_vmon_3p3v_l_thresh2_intsts_clear_value
    Private read_vmon_3p3v_l_thresh2_intsts_clear_value
    Private flag_vmon_3p3v_l_thresh2_intsts_clear

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H230
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tmon_thresh1_intsts_clear
        get_tmon_thresh1_intsts_clear = read_tmon_thresh1_intsts_clear_value
    End Property

    Property Let set_tmon_thresh1_intsts_clear(aData)
        write_tmon_thresh1_intsts_clear_value = aData
        flag_tmon_thresh1_intsts_clear        = &H1
    End Property

    Property Get read_tmon_thresh1_intsts_clear
        read
        read_tmon_thresh1_intsts_clear = read_tmon_thresh1_intsts_clear_value
    End Property

    Property Let write_tmon_thresh1_intsts_clear(aData)
        set_tmon_thresh1_intsts_clear = aData
        write
    End Property

    Property Get get_tmon_thresh2_intsts_clear
        get_tmon_thresh2_intsts_clear = read_tmon_thresh2_intsts_clear_value
    End Property

    Property Let set_tmon_thresh2_intsts_clear(aData)
        write_tmon_thresh2_intsts_clear_value = aData
        flag_tmon_thresh2_intsts_clear        = &H1
    End Property

    Property Get read_tmon_thresh2_intsts_clear
        read
        read_tmon_thresh2_intsts_clear = read_tmon_thresh2_intsts_clear_value
    End Property

    Property Let write_tmon_thresh2_intsts_clear(aData)
        set_tmon_thresh2_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh1_intsts_clear
        get_vmon_1v_h_thresh1_intsts_clear = read_vmon_1v_h_thresh1_intsts_clear_value
    End Property

    Property Let set_vmon_1v_h_thresh1_intsts_clear(aData)
        write_vmon_1v_h_thresh1_intsts_clear_value = aData
        flag_vmon_1v_h_thresh1_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh1_intsts_clear
        read
        read_vmon_1v_h_thresh1_intsts_clear = read_vmon_1v_h_thresh1_intsts_clear_value
    End Property

    Property Let write_vmon_1v_h_thresh1_intsts_clear(aData)
        set_vmon_1v_h_thresh1_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1v_h_thresh2_intsts_clear
        get_vmon_1v_h_thresh2_intsts_clear = read_vmon_1v_h_thresh2_intsts_clear_value
    End Property

    Property Let set_vmon_1v_h_thresh2_intsts_clear(aData)
        write_vmon_1v_h_thresh2_intsts_clear_value = aData
        flag_vmon_1v_h_thresh2_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1v_h_thresh2_intsts_clear
        read
        read_vmon_1v_h_thresh2_intsts_clear = read_vmon_1v_h_thresh2_intsts_clear_value
    End Property

    Property Let write_vmon_1v_h_thresh2_intsts_clear(aData)
        set_vmon_1v_h_thresh2_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh1_intsts_clear
        get_vmon_1v_l_thresh1_intsts_clear = read_vmon_1v_l_thresh1_intsts_clear_value
    End Property

    Property Let set_vmon_1v_l_thresh1_intsts_clear(aData)
        write_vmon_1v_l_thresh1_intsts_clear_value = aData
        flag_vmon_1v_l_thresh1_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh1_intsts_clear
        read
        read_vmon_1v_l_thresh1_intsts_clear = read_vmon_1v_l_thresh1_intsts_clear_value
    End Property

    Property Let write_vmon_1v_l_thresh1_intsts_clear(aData)
        set_vmon_1v_l_thresh1_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1v_l_thresh2_intsts_clear
        get_vmon_1v_l_thresh2_intsts_clear = read_vmon_1v_l_thresh2_intsts_clear_value
    End Property

    Property Let set_vmon_1v_l_thresh2_intsts_clear(aData)
        write_vmon_1v_l_thresh2_intsts_clear_value = aData
        flag_vmon_1v_l_thresh2_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1v_l_thresh2_intsts_clear
        read
        read_vmon_1v_l_thresh2_intsts_clear = read_vmon_1v_l_thresh2_intsts_clear_value
    End Property

    Property Let write_vmon_1v_l_thresh2_intsts_clear(aData)
        set_vmon_1v_l_thresh2_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh1_intsts_clear
        get_vmon_1p8v_h_thresh1_intsts_clear = read_vmon_1p8v_h_thresh1_intsts_clear_value
    End Property

    Property Let set_vmon_1p8v_h_thresh1_intsts_clear(aData)
        write_vmon_1p8v_h_thresh1_intsts_clear_value = aData
        flag_vmon_1p8v_h_thresh1_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh1_intsts_clear
        read
        read_vmon_1p8v_h_thresh1_intsts_clear = read_vmon_1p8v_h_thresh1_intsts_clear_value
    End Property

    Property Let write_vmon_1p8v_h_thresh1_intsts_clear(aData)
        set_vmon_1p8v_h_thresh1_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1p8v_h_thresh2_intsts_clear
        get_vmon_1p8v_h_thresh2_intsts_clear = read_vmon_1p8v_h_thresh2_intsts_clear_value
    End Property

    Property Let set_vmon_1p8v_h_thresh2_intsts_clear(aData)
        write_vmon_1p8v_h_thresh2_intsts_clear_value = aData
        flag_vmon_1p8v_h_thresh2_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1p8v_h_thresh2_intsts_clear
        read
        read_vmon_1p8v_h_thresh2_intsts_clear = read_vmon_1p8v_h_thresh2_intsts_clear_value
    End Property

    Property Let write_vmon_1p8v_h_thresh2_intsts_clear(aData)
        set_vmon_1p8v_h_thresh2_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh1_intsts_clear
        get_vmon_1p8v_l_thresh1_intsts_clear = read_vmon_1p8v_l_thresh1_intsts_clear_value
    End Property

    Property Let set_vmon_1p8v_l_thresh1_intsts_clear(aData)
        write_vmon_1p8v_l_thresh1_intsts_clear_value = aData
        flag_vmon_1p8v_l_thresh1_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh1_intsts_clear
        read
        read_vmon_1p8v_l_thresh1_intsts_clear = read_vmon_1p8v_l_thresh1_intsts_clear_value
    End Property

    Property Let write_vmon_1p8v_l_thresh1_intsts_clear(aData)
        set_vmon_1p8v_l_thresh1_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_1p8v_l_thresh2_intsts_clear
        get_vmon_1p8v_l_thresh2_intsts_clear = read_vmon_1p8v_l_thresh2_intsts_clear_value
    End Property

    Property Let set_vmon_1p8v_l_thresh2_intsts_clear(aData)
        write_vmon_1p8v_l_thresh2_intsts_clear_value = aData
        flag_vmon_1p8v_l_thresh2_intsts_clear        = &H1
    End Property

    Property Get read_vmon_1p8v_l_thresh2_intsts_clear
        read
        read_vmon_1p8v_l_thresh2_intsts_clear = read_vmon_1p8v_l_thresh2_intsts_clear_value
    End Property

    Property Let write_vmon_1p8v_l_thresh2_intsts_clear(aData)
        set_vmon_1p8v_l_thresh2_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh1_intsts_clear
        get_vmon_3p3v_h_thresh1_intsts_clear = read_vmon_3p3v_h_thresh1_intsts_clear_value
    End Property

    Property Let set_vmon_3p3v_h_thresh1_intsts_clear(aData)
        write_vmon_3p3v_h_thresh1_intsts_clear_value = aData
        flag_vmon_3p3v_h_thresh1_intsts_clear        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh1_intsts_clear
        read
        read_vmon_3p3v_h_thresh1_intsts_clear = read_vmon_3p3v_h_thresh1_intsts_clear_value
    End Property

    Property Let write_vmon_3p3v_h_thresh1_intsts_clear(aData)
        set_vmon_3p3v_h_thresh1_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_3p3v_h_thresh2_intsts_clear
        get_vmon_3p3v_h_thresh2_intsts_clear = read_vmon_3p3v_h_thresh2_intsts_clear_value
    End Property

    Property Let set_vmon_3p3v_h_thresh2_intsts_clear(aData)
        write_vmon_3p3v_h_thresh2_intsts_clear_value = aData
        flag_vmon_3p3v_h_thresh2_intsts_clear        = &H1
    End Property

    Property Get read_vmon_3p3v_h_thresh2_intsts_clear
        read
        read_vmon_3p3v_h_thresh2_intsts_clear = read_vmon_3p3v_h_thresh2_intsts_clear_value
    End Property

    Property Let write_vmon_3p3v_h_thresh2_intsts_clear(aData)
        set_vmon_3p3v_h_thresh2_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh1_intsts_clear
        get_vmon_3p3v_l_thresh1_intsts_clear = read_vmon_3p3v_l_thresh1_intsts_clear_value
    End Property

    Property Let set_vmon_3p3v_l_thresh1_intsts_clear(aData)
        write_vmon_3p3v_l_thresh1_intsts_clear_value = aData
        flag_vmon_3p3v_l_thresh1_intsts_clear        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh1_intsts_clear
        read
        read_vmon_3p3v_l_thresh1_intsts_clear = read_vmon_3p3v_l_thresh1_intsts_clear_value
    End Property

    Property Let write_vmon_3p3v_l_thresh1_intsts_clear(aData)
        set_vmon_3p3v_l_thresh1_intsts_clear = aData
        write
    End Property

    Property Get get_vmon_3p3v_l_thresh2_intsts_clear
        get_vmon_3p3v_l_thresh2_intsts_clear = read_vmon_3p3v_l_thresh2_intsts_clear_value
    End Property

    Property Let set_vmon_3p3v_l_thresh2_intsts_clear(aData)
        write_vmon_3p3v_l_thresh2_intsts_clear_value = aData
        flag_vmon_3p3v_l_thresh2_intsts_clear        = &H1
    End Property

    Property Get read_vmon_3p3v_l_thresh2_intsts_clear
        read
        read_vmon_3p3v_l_thresh2_intsts_clear = read_vmon_3p3v_l_thresh2_intsts_clear_value
    End Property

    Property Let write_vmon_3p3v_l_thresh2_intsts_clear(aData)
        set_vmon_3p3v_l_thresh2_intsts_clear = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_thresh1_intsts_clear_mask = &H1
        if data_low > LONG_MAX then
            if tmon_thresh1_intsts_clear_mask = mask then
                read_tmon_thresh1_intsts_clear_value = data_low
            else
                read_tmon_thresh1_intsts_clear_value = (data_low - H8000_0000) and tmon_thresh1_intsts_clear_mask
            end If
        else
            read_tmon_thresh1_intsts_clear_value = data_low and tmon_thresh1_intsts_clear_mask
        end If
        read_tmon_thresh2_intsts_clear_value = rightShift(data_low, 1) and &H1
        read_vmon_1v_h_thresh1_intsts_clear_value = rightShift(data_low, 2) and &H1
        read_vmon_1v_h_thresh2_intsts_clear_value = rightShift(data_low, 3) and &H1
        read_vmon_1v_l_thresh1_intsts_clear_value = rightShift(data_low, 4) and &H1
        read_vmon_1v_l_thresh2_intsts_clear_value = rightShift(data_low, 5) and &H1
        read_vmon_1p8v_h_thresh1_intsts_clear_value = rightShift(data_low, 6) and &H1
        read_vmon_1p8v_h_thresh2_intsts_clear_value = rightShift(data_low, 7) and &H1
        read_vmon_1p8v_l_thresh1_intsts_clear_value = rightShift(data_low, 8) and &H1
        read_vmon_1p8v_l_thresh2_intsts_clear_value = rightShift(data_low, 9) and &H1
        read_vmon_3p3v_h_thresh1_intsts_clear_value = rightShift(data_low, 10) and &H1
        read_vmon_3p3v_h_thresh2_intsts_clear_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_intsts_clear_value = rightShift(data_low, 12) and &H1
        read_vmon_3p3v_l_thresh2_intsts_clear_value = rightShift(data_low, 13) and &H1

    End Sub

    Sub write
        If flag_tmon_thresh1_intsts_clear = &H0 or flag_tmon_thresh2_intsts_clear = &H0 or flag_vmon_1v_h_thresh1_intsts_clear = &H0 or flag_vmon_1v_h_thresh2_intsts_clear = &H0 or flag_vmon_1v_l_thresh1_intsts_clear = &H0 or flag_vmon_1v_l_thresh2_intsts_clear = &H0 or flag_vmon_1p8v_h_thresh1_intsts_clear = &H0 or flag_vmon_1p8v_h_thresh2_intsts_clear = &H0 or flag_vmon_1p8v_l_thresh1_intsts_clear = &H0 or flag_vmon_1p8v_l_thresh2_intsts_clear = &H0 or flag_vmon_3p3v_h_thresh1_intsts_clear = &H0 or flag_vmon_3p3v_h_thresh2_intsts_clear = &H0 or flag_vmon_3p3v_l_thresh1_intsts_clear = &H0 or flag_vmon_3p3v_l_thresh2_intsts_clear = &H0 Then read
        If flag_tmon_thresh1_intsts_clear = &H0 Then write_tmon_thresh1_intsts_clear_value = get_tmon_thresh1_intsts_clear
        If flag_tmon_thresh2_intsts_clear = &H0 Then write_tmon_thresh2_intsts_clear_value = get_tmon_thresh2_intsts_clear
        If flag_vmon_1v_h_thresh1_intsts_clear = &H0 Then write_vmon_1v_h_thresh1_intsts_clear_value = get_vmon_1v_h_thresh1_intsts_clear
        If flag_vmon_1v_h_thresh2_intsts_clear = &H0 Then write_vmon_1v_h_thresh2_intsts_clear_value = get_vmon_1v_h_thresh2_intsts_clear
        If flag_vmon_1v_l_thresh1_intsts_clear = &H0 Then write_vmon_1v_l_thresh1_intsts_clear_value = get_vmon_1v_l_thresh1_intsts_clear
        If flag_vmon_1v_l_thresh2_intsts_clear = &H0 Then write_vmon_1v_l_thresh2_intsts_clear_value = get_vmon_1v_l_thresh2_intsts_clear
        If flag_vmon_1p8v_h_thresh1_intsts_clear = &H0 Then write_vmon_1p8v_h_thresh1_intsts_clear_value = get_vmon_1p8v_h_thresh1_intsts_clear
        If flag_vmon_1p8v_h_thresh2_intsts_clear = &H0 Then write_vmon_1p8v_h_thresh2_intsts_clear_value = get_vmon_1p8v_h_thresh2_intsts_clear
        If flag_vmon_1p8v_l_thresh1_intsts_clear = &H0 Then write_vmon_1p8v_l_thresh1_intsts_clear_value = get_vmon_1p8v_l_thresh1_intsts_clear
        If flag_vmon_1p8v_l_thresh2_intsts_clear = &H0 Then write_vmon_1p8v_l_thresh2_intsts_clear_value = get_vmon_1p8v_l_thresh2_intsts_clear
        If flag_vmon_3p3v_h_thresh1_intsts_clear = &H0 Then write_vmon_3p3v_h_thresh1_intsts_clear_value = get_vmon_3p3v_h_thresh1_intsts_clear
        If flag_vmon_3p3v_h_thresh2_intsts_clear = &H0 Then write_vmon_3p3v_h_thresh2_intsts_clear_value = get_vmon_3p3v_h_thresh2_intsts_clear
        If flag_vmon_3p3v_l_thresh1_intsts_clear = &H0 Then write_vmon_3p3v_l_thresh1_intsts_clear_value = get_vmon_3p3v_l_thresh1_intsts_clear
        If flag_vmon_3p3v_l_thresh2_intsts_clear = &H0 Then write_vmon_3p3v_l_thresh2_intsts_clear_value = get_vmon_3p3v_l_thresh2_intsts_clear

        regValue = leftShift((write_tmon_thresh1_intsts_clear_value and &H1), 0) + leftShift((write_tmon_thresh2_intsts_clear_value and &H1), 1) + leftShift((write_vmon_1v_h_thresh1_intsts_clear_value and &H1), 2) + leftShift((write_vmon_1v_h_thresh2_intsts_clear_value and &H1), 3) + leftShift((write_vmon_1v_l_thresh1_intsts_clear_value and &H1), 4) + leftShift((write_vmon_1v_l_thresh2_intsts_clear_value and &H1), 5) + leftShift((write_vmon_1p8v_h_thresh1_intsts_clear_value and &H1), 6) + leftShift((write_vmon_1p8v_h_thresh2_intsts_clear_value and &H1), 7) + leftShift((write_vmon_1p8v_l_thresh1_intsts_clear_value and &H1), 8) + leftShift((write_vmon_1p8v_l_thresh2_intsts_clear_value and &H1), 9) + leftShift((write_vmon_3p3v_h_thresh1_intsts_clear_value and &H1), 10) + leftShift((write_vmon_3p3v_h_thresh2_intsts_clear_value and &H1), 11) + leftShift((write_vmon_3p3v_l_thresh1_intsts_clear_value and &H1), 12) + leftShift((write_vmon_3p3v_l_thresh2_intsts_clear_value and &H1), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_thresh1_intsts_clear_mask = &H1
        if data_low > LONG_MAX then
            if tmon_thresh1_intsts_clear_mask = mask then
                read_tmon_thresh1_intsts_clear_value = data_low
            else
                read_tmon_thresh1_intsts_clear_value = (data_low - H8000_0000) and tmon_thresh1_intsts_clear_mask
            end If
        else
            read_tmon_thresh1_intsts_clear_value = data_low and tmon_thresh1_intsts_clear_mask
        end If
        read_tmon_thresh2_intsts_clear_value = rightShift(data_low, 1) and &H1
        read_vmon_1v_h_thresh1_intsts_clear_value = rightShift(data_low, 2) and &H1
        read_vmon_1v_h_thresh2_intsts_clear_value = rightShift(data_low, 3) and &H1
        read_vmon_1v_l_thresh1_intsts_clear_value = rightShift(data_low, 4) and &H1
        read_vmon_1v_l_thresh2_intsts_clear_value = rightShift(data_low, 5) and &H1
        read_vmon_1p8v_h_thresh1_intsts_clear_value = rightShift(data_low, 6) and &H1
        read_vmon_1p8v_h_thresh2_intsts_clear_value = rightShift(data_low, 7) and &H1
        read_vmon_1p8v_l_thresh1_intsts_clear_value = rightShift(data_low, 8) and &H1
        read_vmon_1p8v_l_thresh2_intsts_clear_value = rightShift(data_low, 9) and &H1
        read_vmon_3p3v_h_thresh1_intsts_clear_value = rightShift(data_low, 10) and &H1
        read_vmon_3p3v_h_thresh2_intsts_clear_value = rightShift(data_low, 11) and &H1
        read_vmon_3p3v_l_thresh1_intsts_clear_value = rightShift(data_low, 12) and &H1
        read_vmon_3p3v_l_thresh2_intsts_clear_value = rightShift(data_low, 13) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tmon_thresh1_intsts_clear_value = &H0
        flag_tmon_thresh1_intsts_clear        = &H0
        write_tmon_thresh2_intsts_clear_value = &H0
        flag_tmon_thresh2_intsts_clear        = &H0
        write_vmon_1v_h_thresh1_intsts_clear_value = &H0
        flag_vmon_1v_h_thresh1_intsts_clear        = &H0
        write_vmon_1v_h_thresh2_intsts_clear_value = &H0
        flag_vmon_1v_h_thresh2_intsts_clear        = &H0
        write_vmon_1v_l_thresh1_intsts_clear_value = &H0
        flag_vmon_1v_l_thresh1_intsts_clear        = &H0
        write_vmon_1v_l_thresh2_intsts_clear_value = &H0
        flag_vmon_1v_l_thresh2_intsts_clear        = &H0
        write_vmon_1p8v_h_thresh1_intsts_clear_value = &H0
        flag_vmon_1p8v_h_thresh1_intsts_clear        = &H0
        write_vmon_1p8v_h_thresh2_intsts_clear_value = &H0
        flag_vmon_1p8v_h_thresh2_intsts_clear        = &H0
        write_vmon_1p8v_l_thresh1_intsts_clear_value = &H0
        flag_vmon_1p8v_l_thresh1_intsts_clear        = &H0
        write_vmon_1p8v_l_thresh2_intsts_clear_value = &H0
        flag_vmon_1p8v_l_thresh2_intsts_clear        = &H0
        write_vmon_3p3v_h_thresh1_intsts_clear_value = &H0
        flag_vmon_3p3v_h_thresh1_intsts_clear        = &H0
        write_vmon_3p3v_h_thresh2_intsts_clear_value = &H0
        flag_vmon_3p3v_h_thresh2_intsts_clear        = &H0
        write_vmon_3p3v_l_thresh1_intsts_clear_value = &H0
        flag_vmon_3p3v_l_thresh1_intsts_clear        = &H0
        write_vmon_3p3v_l_thresh2_intsts_clear_value = &H0
        flag_vmon_3p3v_l_thresh2_intsts_clear        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_interrupt_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' interrupt_count                            [15:0]           get_interrupt_count
''                                                             set_interrupt_count
''                                                             read_interrupt_count
''                                                             write_interrupt_count
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_interrupt_count
    Private write_interrupt_count_value
    Private read_interrupt_count_value
    Private flag_interrupt_count

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H232
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_interrupt_count
        get_interrupt_count = read_interrupt_count_value
    End Property

    Property Let set_interrupt_count(aData)
        write_interrupt_count_value = aData
        flag_interrupt_count        = &H1
    End Property

    Property Get read_interrupt_count
        read
        read_interrupt_count = read_interrupt_count_value
    End Property

    Property Let write_interrupt_count(aData)
        set_interrupt_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        interrupt_count_mask = &Hffff
        if data_low > LONG_MAX then
            if interrupt_count_mask = mask then
                read_interrupt_count_value = data_low
            else
                read_interrupt_count_value = (data_low - H8000_0000) and interrupt_count_mask
            end If
        else
            read_interrupt_count_value = data_low and interrupt_count_mask
        end If

    End Sub

    Sub write
        If flag_interrupt_count = &H0 Then read
        If flag_interrupt_count = &H0 Then write_interrupt_count_value = get_interrupt_count

        regValue = leftShift((write_interrupt_count_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        interrupt_count_mask = &Hffff
        if data_low > LONG_MAX then
            if interrupt_count_mask = mask then
                read_interrupt_count_value = data_low
            else
                read_interrupt_count_value = (data_low - H8000_0000) and interrupt_count_mask
            end If
        else
            read_interrupt_count_value = data_low and interrupt_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_interrupt_count_value = &H0
        flag_interrupt_count        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_tmon_sample
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tmon_sample                                [9:0]            get_tmon_sample
''                                                             set_tmon_sample
''                                                             read_tmon_sample
''                                                             write_tmon_sample
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_tmon_sample
    Private write_tmon_sample_value
    Private read_tmon_sample_value
    Private flag_tmon_sample

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H234
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tmon_sample
        get_tmon_sample = read_tmon_sample_value
    End Property

    Property Let set_tmon_sample(aData)
        write_tmon_sample_value = aData
        flag_tmon_sample        = &H1
    End Property

    Property Get read_tmon_sample
        read
        read_tmon_sample = read_tmon_sample_value
    End Property

    Property Let write_tmon_sample(aData)
        set_tmon_sample = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if tmon_sample_mask = mask then
                read_tmon_sample_value = data_low
            else
                read_tmon_sample_value = (data_low - H8000_0000) and tmon_sample_mask
            end If
        else
            read_tmon_sample_value = data_low and tmon_sample_mask
        end If

    End Sub

    Sub write
        If flag_tmon_sample = &H0 Then read
        If flag_tmon_sample = &H0 Then write_tmon_sample_value = get_tmon_sample

        regValue = leftShift((write_tmon_sample_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tmon_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if tmon_sample_mask = mask then
                read_tmon_sample_value = data_low
            else
                read_tmon_sample_value = (data_low - H8000_0000) and tmon_sample_mask
            end If
        else
            read_tmon_sample_value = data_low and tmon_sample_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tmon_sample_value = &H0
        flag_tmon_sample        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1v_sample
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1v_sample                             [9:0]            get_vmon_1v_sample
''                                                             set_vmon_1v_sample
''                                                             read_vmon_1v_sample
''                                                             write_vmon_1v_sample
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1v_sample
    Private write_vmon_1v_sample_value
    Private read_vmon_1v_sample_value
    Private flag_vmon_1v_sample

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H236
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1v_sample
        get_vmon_1v_sample = read_vmon_1v_sample_value
    End Property

    Property Let set_vmon_1v_sample(aData)
        write_vmon_1v_sample_value = aData
        flag_vmon_1v_sample        = &H1
    End Property

    Property Get read_vmon_1v_sample
        read
        read_vmon_1v_sample = read_vmon_1v_sample_value
    End Property

    Property Let write_vmon_1v_sample(aData)
        set_vmon_1v_sample = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vmon_1v_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_sample_mask = mask then
                read_vmon_1v_sample_value = data_low
            else
                read_vmon_1v_sample_value = (data_low - H8000_0000) and vmon_1v_sample_mask
            end If
        else
            read_vmon_1v_sample_value = data_low and vmon_1v_sample_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1v_sample = &H0 Then read
        If flag_vmon_1v_sample = &H0 Then write_vmon_1v_sample_value = get_vmon_1v_sample

        regValue = leftShift((write_vmon_1v_sample_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vmon_1v_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1v_sample_mask = mask then
                read_vmon_1v_sample_value = data_low
            else
                read_vmon_1v_sample_value = (data_low - H8000_0000) and vmon_1v_sample_mask
            end If
        else
            read_vmon_1v_sample_value = data_low and vmon_1v_sample_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1v_sample_value = &H0
        flag_vmon_1v_sample        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_1p8v_sample
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_1p8v_sample                           [9:0]            get_vmon_1p8v_sample
''                                                             set_vmon_1p8v_sample
''                                                             read_vmon_1p8v_sample
''                                                             write_vmon_1p8v_sample
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_1p8v_sample
    Private write_vmon_1p8v_sample_value
    Private read_vmon_1p8v_sample_value
    Private flag_vmon_1p8v_sample

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H238
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_1p8v_sample
        get_vmon_1p8v_sample = read_vmon_1p8v_sample_value
    End Property

    Property Let set_vmon_1p8v_sample(aData)
        write_vmon_1p8v_sample_value = aData
        flag_vmon_1p8v_sample        = &H1
    End Property

    Property Get read_vmon_1p8v_sample
        read
        read_vmon_1p8v_sample = read_vmon_1p8v_sample_value
    End Property

    Property Let write_vmon_1p8v_sample(aData)
        set_vmon_1p8v_sample = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vmon_1p8v_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_sample_mask = mask then
                read_vmon_1p8v_sample_value = data_low
            else
                read_vmon_1p8v_sample_value = (data_low - H8000_0000) and vmon_1p8v_sample_mask
            end If
        else
            read_vmon_1p8v_sample_value = data_low and vmon_1p8v_sample_mask
        end If

    End Sub

    Sub write
        If flag_vmon_1p8v_sample = &H0 Then read
        If flag_vmon_1p8v_sample = &H0 Then write_vmon_1p8v_sample_value = get_vmon_1p8v_sample

        regValue = leftShift((write_vmon_1p8v_sample_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vmon_1p8v_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_1p8v_sample_mask = mask then
                read_vmon_1p8v_sample_value = data_low
            else
                read_vmon_1p8v_sample_value = (data_low - H8000_0000) and vmon_1p8v_sample_mask
            end If
        else
            read_vmon_1p8v_sample_value = data_low and vmon_1p8v_sample_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_1p8v_sample_value = &H0
        flag_vmon_1p8v_sample        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pvtmon_vmon_3p3v_sample
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vmon_3p3v_sample                           [9:0]            get_vmon_3p3v_sample
''                                                             set_vmon_3p3v_sample
''                                                             read_vmon_3p3v_sample
''                                                             write_vmon_3p3v_sample
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pvtmon_vmon_3p3v_sample
    Private write_vmon_3p3v_sample_value
    Private read_vmon_3p3v_sample_value
    Private flag_vmon_3p3v_sample

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H23a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_vmon_3p3v_sample
        get_vmon_3p3v_sample = read_vmon_3p3v_sample_value
    End Property

    Property Let set_vmon_3p3v_sample(aData)
        write_vmon_3p3v_sample_value = aData
        flag_vmon_3p3v_sample        = &H1
    End Property

    Property Get read_vmon_3p3v_sample
        read
        read_vmon_3p3v_sample = read_vmon_3p3v_sample_value
    End Property

    Property Let write_vmon_3p3v_sample(aData)
        set_vmon_3p3v_sample = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vmon_3p3v_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_sample_mask = mask then
                read_vmon_3p3v_sample_value = data_low
            else
                read_vmon_3p3v_sample_value = (data_low - H8000_0000) and vmon_3p3v_sample_mask
            end If
        else
            read_vmon_3p3v_sample_value = data_low and vmon_3p3v_sample_mask
        end If

    End Sub

    Sub write
        If flag_vmon_3p3v_sample = &H0 Then read
        If flag_vmon_3p3v_sample = &H0 Then write_vmon_3p3v_sample_value = get_vmon_3p3v_sample

        regValue = leftShift((write_vmon_3p3v_sample_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vmon_3p3v_sample_mask = &H3ff
        if data_low > LONG_MAX then
            if vmon_3p3v_sample_mask = mask then
                read_vmon_3p3v_sample_value = data_low
            else
                read_vmon_3p3v_sample_value = (data_low - H8000_0000) and vmon_3p3v_sample_mask
            end If
        else
            read_vmon_3p3v_sample_value = data_low and vmon_3p3v_sample_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vmon_3p3v_sample_value = &H0
        flag_vmon_3p3v_sample        = &H0
    End Sub
End Class


'' @REGISTER : MISC_f1_image_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' firmware_executed                          [15:15]          get_firmware_executed
''                                                             set_firmware_executed
''                                                             read_firmware_executed
''                                                             write_firmware_executed
''---------------------------------------------------------------------------------
'' bootrom_loaded                             [14:14]          get_bootrom_loaded
''                                                             set_bootrom_loaded
''                                                             read_bootrom_loaded
''                                                             write_bootrom_loaded
''---------------------------------------------------------------------------------
'' spare                                      [13:10]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' CRC_status                                 [9:9]            get_CRC_status
''                                                             set_CRC_status
''                                                             read_CRC_status
''                                                             write_CRC_status
''---------------------------------------------------------------------------------
'' Image_Key                                  [8:8]            get_Image_Key
''                                                             set_Image_Key
''                                                             read_Image_Key
''                                                             write_Image_Key
''---------------------------------------------------------------------------------
'' Image_Type                                 [7:6]            get_Image_Type
''                                                             set_Image_Type
''                                                             read_Image_Type
''                                                             write_Image_Type
''---------------------------------------------------------------------------------
'' Image_Count                                [5:2]            get_Image_Count
''                                                             set_Image_Count
''                                                             read_Image_Count
''                                                             write_Image_Count
''---------------------------------------------------------------------------------
'' Final_Image                                [1:1]            get_Final_Image
''                                                             set_Final_Image
''                                                             read_Final_Image
''                                                             write_Final_Image
''---------------------------------------------------------------------------------
'' CRC_Check_Enable                           [0:0]            get_CRC_Check_Enable
''                                                             set_CRC_Check_Enable
''                                                             read_CRC_Check_Enable
''                                                             write_CRC_Check_Enable
''---------------------------------------------------------------------------------
Class REGISTER_MISC_f1_image_status
    Private write_firmware_executed_value
    Private read_firmware_executed_value
    Private flag_firmware_executed
    Private write_bootrom_loaded_value
    Private read_bootrom_loaded_value
    Private flag_bootrom_loaded
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_CRC_status_value
    Private read_CRC_status_value
    Private flag_CRC_status
    Private write_Image_Key_value
    Private read_Image_Key_value
    Private flag_Image_Key
    Private write_Image_Type_value
    Private read_Image_Type_value
    Private flag_Image_Type
    Private write_Image_Count_value
    Private read_Image_Count_value
    Private flag_Image_Count
    Private write_Final_Image_value
    Private read_Final_Image_value
    Private flag_Final_Image
    Private write_CRC_Check_Enable_value
    Private read_CRC_Check_Enable_value
    Private flag_CRC_Check_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H300
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_firmware_executed
        get_firmware_executed = read_firmware_executed_value
    End Property

    Property Let set_firmware_executed(aData)
        write_firmware_executed_value = aData
        flag_firmware_executed        = &H1
    End Property

    Property Get read_firmware_executed
        read
        read_firmware_executed = read_firmware_executed_value
    End Property

    Property Let write_firmware_executed(aData)
        set_firmware_executed = aData
        write
    End Property

    Property Get get_bootrom_loaded
        get_bootrom_loaded = read_bootrom_loaded_value
    End Property

    Property Let set_bootrom_loaded(aData)
        write_bootrom_loaded_value = aData
        flag_bootrom_loaded        = &H1
    End Property

    Property Get read_bootrom_loaded
        read
        read_bootrom_loaded = read_bootrom_loaded_value
    End Property

    Property Let write_bootrom_loaded(aData)
        set_bootrom_loaded = aData
        write
    End Property

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_CRC_status
        get_CRC_status = read_CRC_status_value
    End Property

    Property Let set_CRC_status(aData)
        write_CRC_status_value = aData
        flag_CRC_status        = &H1
    End Property

    Property Get read_CRC_status
        read
        read_CRC_status = read_CRC_status_value
    End Property

    Property Let write_CRC_status(aData)
        set_CRC_status = aData
        write
    End Property

    Property Get get_Image_Key
        get_Image_Key = read_Image_Key_value
    End Property

    Property Let set_Image_Key(aData)
        write_Image_Key_value = aData
        flag_Image_Key        = &H1
    End Property

    Property Get read_Image_Key
        read
        read_Image_Key = read_Image_Key_value
    End Property

    Property Let write_Image_Key(aData)
        set_Image_Key = aData
        write
    End Property

    Property Get get_Image_Type
        get_Image_Type = read_Image_Type_value
    End Property

    Property Let set_Image_Type(aData)
        write_Image_Type_value = aData
        flag_Image_Type        = &H1
    End Property

    Property Get read_Image_Type
        read
        read_Image_Type = read_Image_Type_value
    End Property

    Property Let write_Image_Type(aData)
        set_Image_Type = aData
        write
    End Property

    Property Get get_Image_Count
        get_Image_Count = read_Image_Count_value
    End Property

    Property Let set_Image_Count(aData)
        write_Image_Count_value = aData
        flag_Image_Count        = &H1
    End Property

    Property Get read_Image_Count
        read
        read_Image_Count = read_Image_Count_value
    End Property

    Property Let write_Image_Count(aData)
        set_Image_Count = aData
        write
    End Property

    Property Get get_Final_Image
        get_Final_Image = read_Final_Image_value
    End Property

    Property Let set_Final_Image(aData)
        write_Final_Image_value = aData
        flag_Final_Image        = &H1
    End Property

    Property Get read_Final_Image
        read
        read_Final_Image = read_Final_Image_value
    End Property

    Property Let write_Final_Image(aData)
        set_Final_Image = aData
        write
    End Property

    Property Get get_CRC_Check_Enable
        get_CRC_Check_Enable = read_CRC_Check_Enable_value
    End Property

    Property Let set_CRC_Check_Enable(aData)
        write_CRC_Check_Enable_value = aData
        flag_CRC_Check_Enable        = &H1
    End Property

    Property Get read_CRC_Check_Enable
        read
        read_CRC_Check_Enable = read_CRC_Check_Enable_value
    End Property

    Property Let write_CRC_Check_Enable(aData)
        set_CRC_Check_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_executed_value = rightShift(data_low, 15) and &H1
        read_bootrom_loaded_value = rightShift(data_low, 14) and &H1
        read_spare_value = rightShift(data_low, 10) and &Hf
        read_CRC_status_value = rightShift(data_low, 9) and &H1
        read_Image_Key_value = rightShift(data_low, 8) and &H1
        read_Image_Type_value = rightShift(data_low, 6) and &H3
        read_Image_Count_value = rightShift(data_low, 2) and &Hf
        read_Final_Image_value = rightShift(data_low, 1) and &H1
        CRC_Check_Enable_mask = &H1
        if data_low > LONG_MAX then
            if CRC_Check_Enable_mask = mask then
                read_CRC_Check_Enable_value = data_low
            else
                read_CRC_Check_Enable_value = (data_low - H8000_0000) and CRC_Check_Enable_mask
            end If
        else
            read_CRC_Check_Enable_value = data_low and CRC_Check_Enable_mask
        end If

    End Sub

    Sub write
        If flag_firmware_executed = &H0 or flag_bootrom_loaded = &H0 or flag_spare = &H0 or flag_CRC_status = &H0 or flag_Image_Key = &H0 or flag_Image_Type = &H0 or flag_Image_Count = &H0 or flag_Final_Image = &H0 or flag_CRC_Check_Enable = &H0 Then read
        If flag_firmware_executed = &H0 Then write_firmware_executed_value = get_firmware_executed
        If flag_bootrom_loaded = &H0 Then write_bootrom_loaded_value = get_bootrom_loaded
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_CRC_status = &H0 Then write_CRC_status_value = get_CRC_status
        If flag_Image_Key = &H0 Then write_Image_Key_value = get_Image_Key
        If flag_Image_Type = &H0 Then write_Image_Type_value = get_Image_Type
        If flag_Image_Count = &H0 Then write_Image_Count_value = get_Image_Count
        If flag_Final_Image = &H0 Then write_Final_Image_value = get_Final_Image
        If flag_CRC_Check_Enable = &H0 Then write_CRC_Check_Enable_value = get_CRC_Check_Enable

        regValue = leftShift((write_firmware_executed_value and &H1), 15) + leftShift((write_bootrom_loaded_value and &H1), 14) + leftShift((write_spare_value and &Hf), 10) + leftShift((write_CRC_status_value and &H1), 9) + leftShift((write_Image_Key_value and &H1), 8) + leftShift((write_Image_Type_value and &H3), 6) + leftShift((write_Image_Count_value and &Hf), 2) + leftShift((write_Final_Image_value and &H1), 1) + leftShift((write_CRC_Check_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_executed_value = rightShift(data_low, 15) and &H1
        read_bootrom_loaded_value = rightShift(data_low, 14) and &H1
        read_spare_value = rightShift(data_low, 10) and &Hf
        read_CRC_status_value = rightShift(data_low, 9) and &H1
        read_Image_Key_value = rightShift(data_low, 8) and &H1
        read_Image_Type_value = rightShift(data_low, 6) and &H3
        read_Image_Count_value = rightShift(data_low, 2) and &Hf
        read_Final_Image_value = rightShift(data_low, 1) and &H1
        CRC_Check_Enable_mask = &H1
        if data_low > LONG_MAX then
            if CRC_Check_Enable_mask = mask then
                read_CRC_Check_Enable_value = data_low
            else
                read_CRC_Check_Enable_value = (data_low - H8000_0000) and CRC_Check_Enable_mask
            end If
        else
            read_CRC_Check_Enable_value = data_low and CRC_Check_Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_firmware_executed_value = &H0
        flag_firmware_executed        = &H0
        write_bootrom_loaded_value = &H0
        flag_bootrom_loaded        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
        write_CRC_status_value = &H0
        flag_CRC_status        = &H0
        write_Image_Key_value = &H0
        flag_Image_Key        = &H0
        write_Image_Type_value = &H0
        flag_Image_Type        = &H0
        write_Image_Count_value = &H0
        flag_Image_Count        = &H0
        write_Final_Image_value = &H0
        flag_Final_Image        = &H0
        write_CRC_Check_Enable_value = &H0
        flag_CRC_Check_Enable        = &H0
    End Sub
End Class


'' @REGISTER : MISC_f1_image_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' firmware_version                           [15:13]          get_firmware_version
''                                                             set_firmware_version
''                                                             read_firmware_version
''                                                             write_firmware_version
''---------------------------------------------------------------------------------
'' Month                                      [12:9]           get_Month
''                                                             set_Month
''                                                             read_Month
''                                                             write_Month
''---------------------------------------------------------------------------------
'' day                                        [8:4]            get_day
''                                                             set_day
''                                                             read_day
''                                                             write_day
''---------------------------------------------------------------------------------
'' year                                       [3:0]            get_year
''                                                             set_year
''                                                             read_year
''                                                             write_year
''---------------------------------------------------------------------------------
Class REGISTER_MISC_f1_image_version
    Private write_firmware_version_value
    Private read_firmware_version_value
    Private flag_firmware_version
    Private write_Month_value
    Private read_Month_value
    Private flag_Month
    Private write_day_value
    Private read_day_value
    Private flag_day
    Private write_year_value
    Private read_year_value
    Private flag_year

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H302
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_firmware_version
        get_firmware_version = read_firmware_version_value
    End Property

    Property Let set_firmware_version(aData)
        write_firmware_version_value = aData
        flag_firmware_version        = &H1
    End Property

    Property Get read_firmware_version
        read
        read_firmware_version = read_firmware_version_value
    End Property

    Property Let write_firmware_version(aData)
        set_firmware_version = aData
        write
    End Property

    Property Get get_Month
        get_Month = read_Month_value
    End Property

    Property Let set_Month(aData)
        write_Month_value = aData
        flag_Month        = &H1
    End Property

    Property Get read_Month
        read
        read_Month = read_Month_value
    End Property

    Property Let write_Month(aData)
        set_Month = aData
        write
    End Property

    Property Get get_day
        get_day = read_day_value
    End Property

    Property Let set_day(aData)
        write_day_value = aData
        flag_day        = &H1
    End Property

    Property Get read_day
        read
        read_day = read_day_value
    End Property

    Property Let write_day(aData)
        set_day = aData
        write
    End Property

    Property Get get_year
        get_year = read_year_value
    End Property

    Property Let set_year(aData)
        write_year_value = aData
        flag_year        = &H1
    End Property

    Property Get read_year
        read
        read_year = read_year_value
    End Property

    Property Let write_year(aData)
        set_year = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_version_value = rightShift(data_low, 13) and &H7
        read_Month_value = rightShift(data_low, 9) and &Hf
        read_day_value = rightShift(data_low, 4) and &H1f
        year_mask = &Hf
        if data_low > LONG_MAX then
            if year_mask = mask then
                read_year_value = data_low
            else
                read_year_value = (data_low - H8000_0000) and year_mask
            end If
        else
            read_year_value = data_low and year_mask
        end If

    End Sub

    Sub write
        If flag_firmware_version = &H0 or flag_Month = &H0 or flag_day = &H0 or flag_year = &H0 Then read
        If flag_firmware_version = &H0 Then write_firmware_version_value = get_firmware_version
        If flag_Month = &H0 Then write_Month_value = get_Month
        If flag_day = &H0 Then write_day_value = get_day
        If flag_year = &H0 Then write_year_value = get_year

        regValue = leftShift((write_firmware_version_value and &H7), 13) + leftShift((write_Month_value and &Hf), 9) + leftShift((write_day_value and &H1f), 4) + leftShift((write_year_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_version_value = rightShift(data_low, 13) and &H7
        read_Month_value = rightShift(data_low, 9) and &Hf
        read_day_value = rightShift(data_low, 4) and &H1f
        year_mask = &Hf
        if data_low > LONG_MAX then
            if year_mask = mask then
                read_year_value = data_low
            else
                read_year_value = (data_low - H8000_0000) and year_mask
            end If
        else
            read_year_value = data_low and year_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_firmware_version_value = &H0
        flag_firmware_version        = &H0
        write_Month_value = &H0
        flag_Month        = &H0
        write_day_value = &H0
        flag_day        = &H0
        write_year_value = &H0
        flag_year        = &H0
    End Sub
End Class


'' @REGISTER : MISC_f2_image_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' firmware_executed                          [15:15]          get_firmware_executed
''                                                             set_firmware_executed
''                                                             read_firmware_executed
''                                                             write_firmware_executed
''---------------------------------------------------------------------------------
'' bootrom_loaded                             [14:14]          get_bootrom_loaded
''                                                             set_bootrom_loaded
''                                                             read_bootrom_loaded
''                                                             write_bootrom_loaded
''---------------------------------------------------------------------------------
'' spare                                      [13:10]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' CRC_status                                 [9:9]            get_CRC_status
''                                                             set_CRC_status
''                                                             read_CRC_status
''                                                             write_CRC_status
''---------------------------------------------------------------------------------
'' Image_Key                                  [8:8]            get_Image_Key
''                                                             set_Image_Key
''                                                             read_Image_Key
''                                                             write_Image_Key
''---------------------------------------------------------------------------------
'' Image_Type                                 [7:6]            get_Image_Type
''                                                             set_Image_Type
''                                                             read_Image_Type
''                                                             write_Image_Type
''---------------------------------------------------------------------------------
'' Image_Count                                [5:2]            get_Image_Count
''                                                             set_Image_Count
''                                                             read_Image_Count
''                                                             write_Image_Count
''---------------------------------------------------------------------------------
'' Final_Image                                [1:1]            get_Final_Image
''                                                             set_Final_Image
''                                                             read_Final_Image
''                                                             write_Final_Image
''---------------------------------------------------------------------------------
'' CRC_Check_Enable                           [0:0]            get_CRC_Check_Enable
''                                                             set_CRC_Check_Enable
''                                                             read_CRC_Check_Enable
''                                                             write_CRC_Check_Enable
''---------------------------------------------------------------------------------
Class REGISTER_MISC_f2_image_status
    Private write_firmware_executed_value
    Private read_firmware_executed_value
    Private flag_firmware_executed
    Private write_bootrom_loaded_value
    Private read_bootrom_loaded_value
    Private flag_bootrom_loaded
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_CRC_status_value
    Private read_CRC_status_value
    Private flag_CRC_status
    Private write_Image_Key_value
    Private read_Image_Key_value
    Private flag_Image_Key
    Private write_Image_Type_value
    Private read_Image_Type_value
    Private flag_Image_Type
    Private write_Image_Count_value
    Private read_Image_Count_value
    Private flag_Image_Count
    Private write_Final_Image_value
    Private read_Final_Image_value
    Private flag_Final_Image
    Private write_CRC_Check_Enable_value
    Private read_CRC_Check_Enable_value
    Private flag_CRC_Check_Enable

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H304
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_firmware_executed
        get_firmware_executed = read_firmware_executed_value
    End Property

    Property Let set_firmware_executed(aData)
        write_firmware_executed_value = aData
        flag_firmware_executed        = &H1
    End Property

    Property Get read_firmware_executed
        read
        read_firmware_executed = read_firmware_executed_value
    End Property

    Property Let write_firmware_executed(aData)
        set_firmware_executed = aData
        write
    End Property

    Property Get get_bootrom_loaded
        get_bootrom_loaded = read_bootrom_loaded_value
    End Property

    Property Let set_bootrom_loaded(aData)
        write_bootrom_loaded_value = aData
        flag_bootrom_loaded        = &H1
    End Property

    Property Get read_bootrom_loaded
        read
        read_bootrom_loaded = read_bootrom_loaded_value
    End Property

    Property Let write_bootrom_loaded(aData)
        set_bootrom_loaded = aData
        write
    End Property

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_CRC_status
        get_CRC_status = read_CRC_status_value
    End Property

    Property Let set_CRC_status(aData)
        write_CRC_status_value = aData
        flag_CRC_status        = &H1
    End Property

    Property Get read_CRC_status
        read
        read_CRC_status = read_CRC_status_value
    End Property

    Property Let write_CRC_status(aData)
        set_CRC_status = aData
        write
    End Property

    Property Get get_Image_Key
        get_Image_Key = read_Image_Key_value
    End Property

    Property Let set_Image_Key(aData)
        write_Image_Key_value = aData
        flag_Image_Key        = &H1
    End Property

    Property Get read_Image_Key
        read
        read_Image_Key = read_Image_Key_value
    End Property

    Property Let write_Image_Key(aData)
        set_Image_Key = aData
        write
    End Property

    Property Get get_Image_Type
        get_Image_Type = read_Image_Type_value
    End Property

    Property Let set_Image_Type(aData)
        write_Image_Type_value = aData
        flag_Image_Type        = &H1
    End Property

    Property Get read_Image_Type
        read
        read_Image_Type = read_Image_Type_value
    End Property

    Property Let write_Image_Type(aData)
        set_Image_Type = aData
        write
    End Property

    Property Get get_Image_Count
        get_Image_Count = read_Image_Count_value
    End Property

    Property Let set_Image_Count(aData)
        write_Image_Count_value = aData
        flag_Image_Count        = &H1
    End Property

    Property Get read_Image_Count
        read
        read_Image_Count = read_Image_Count_value
    End Property

    Property Let write_Image_Count(aData)
        set_Image_Count = aData
        write
    End Property

    Property Get get_Final_Image
        get_Final_Image = read_Final_Image_value
    End Property

    Property Let set_Final_Image(aData)
        write_Final_Image_value = aData
        flag_Final_Image        = &H1
    End Property

    Property Get read_Final_Image
        read
        read_Final_Image = read_Final_Image_value
    End Property

    Property Let write_Final_Image(aData)
        set_Final_Image = aData
        write
    End Property

    Property Get get_CRC_Check_Enable
        get_CRC_Check_Enable = read_CRC_Check_Enable_value
    End Property

    Property Let set_CRC_Check_Enable(aData)
        write_CRC_Check_Enable_value = aData
        flag_CRC_Check_Enable        = &H1
    End Property

    Property Get read_CRC_Check_Enable
        read
        read_CRC_Check_Enable = read_CRC_Check_Enable_value
    End Property

    Property Let write_CRC_Check_Enable(aData)
        set_CRC_Check_Enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_executed_value = rightShift(data_low, 15) and &H1
        read_bootrom_loaded_value = rightShift(data_low, 14) and &H1
        read_spare_value = rightShift(data_low, 10) and &Hf
        read_CRC_status_value = rightShift(data_low, 9) and &H1
        read_Image_Key_value = rightShift(data_low, 8) and &H1
        read_Image_Type_value = rightShift(data_low, 6) and &H3
        read_Image_Count_value = rightShift(data_low, 2) and &Hf
        read_Final_Image_value = rightShift(data_low, 1) and &H1
        CRC_Check_Enable_mask = &H1
        if data_low > LONG_MAX then
            if CRC_Check_Enable_mask = mask then
                read_CRC_Check_Enable_value = data_low
            else
                read_CRC_Check_Enable_value = (data_low - H8000_0000) and CRC_Check_Enable_mask
            end If
        else
            read_CRC_Check_Enable_value = data_low and CRC_Check_Enable_mask
        end If

    End Sub

    Sub write
        If flag_firmware_executed = &H0 or flag_bootrom_loaded = &H0 or flag_spare = &H0 or flag_CRC_status = &H0 or flag_Image_Key = &H0 or flag_Image_Type = &H0 or flag_Image_Count = &H0 or flag_Final_Image = &H0 or flag_CRC_Check_Enable = &H0 Then read
        If flag_firmware_executed = &H0 Then write_firmware_executed_value = get_firmware_executed
        If flag_bootrom_loaded = &H0 Then write_bootrom_loaded_value = get_bootrom_loaded
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_CRC_status = &H0 Then write_CRC_status_value = get_CRC_status
        If flag_Image_Key = &H0 Then write_Image_Key_value = get_Image_Key
        If flag_Image_Type = &H0 Then write_Image_Type_value = get_Image_Type
        If flag_Image_Count = &H0 Then write_Image_Count_value = get_Image_Count
        If flag_Final_Image = &H0 Then write_Final_Image_value = get_Final_Image
        If flag_CRC_Check_Enable = &H0 Then write_CRC_Check_Enable_value = get_CRC_Check_Enable

        regValue = leftShift((write_firmware_executed_value and &H1), 15) + leftShift((write_bootrom_loaded_value and &H1), 14) + leftShift((write_spare_value and &Hf), 10) + leftShift((write_CRC_status_value and &H1), 9) + leftShift((write_Image_Key_value and &H1), 8) + leftShift((write_Image_Type_value and &H3), 6) + leftShift((write_Image_Count_value and &Hf), 2) + leftShift((write_Final_Image_value and &H1), 1) + leftShift((write_CRC_Check_Enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_executed_value = rightShift(data_low, 15) and &H1
        read_bootrom_loaded_value = rightShift(data_low, 14) and &H1
        read_spare_value = rightShift(data_low, 10) and &Hf
        read_CRC_status_value = rightShift(data_low, 9) and &H1
        read_Image_Key_value = rightShift(data_low, 8) and &H1
        read_Image_Type_value = rightShift(data_low, 6) and &H3
        read_Image_Count_value = rightShift(data_low, 2) and &Hf
        read_Final_Image_value = rightShift(data_low, 1) and &H1
        CRC_Check_Enable_mask = &H1
        if data_low > LONG_MAX then
            if CRC_Check_Enable_mask = mask then
                read_CRC_Check_Enable_value = data_low
            else
                read_CRC_Check_Enable_value = (data_low - H8000_0000) and CRC_Check_Enable_mask
            end If
        else
            read_CRC_Check_Enable_value = data_low and CRC_Check_Enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_firmware_executed_value = &H0
        flag_firmware_executed        = &H0
        write_bootrom_loaded_value = &H0
        flag_bootrom_loaded        = &H0
        write_spare_value = &H0
        flag_spare        = &H0
        write_CRC_status_value = &H0
        flag_CRC_status        = &H0
        write_Image_Key_value = &H0
        flag_Image_Key        = &H0
        write_Image_Type_value = &H0
        flag_Image_Type        = &H0
        write_Image_Count_value = &H0
        flag_Image_Count        = &H0
        write_Final_Image_value = &H0
        flag_Final_Image        = &H0
        write_CRC_Check_Enable_value = &H0
        flag_CRC_Check_Enable        = &H0
    End Sub
End Class


'' @REGISTER : MISC_f2_image_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' firmware_version                           [15:13]          get_firmware_version
''                                                             set_firmware_version
''                                                             read_firmware_version
''                                                             write_firmware_version
''---------------------------------------------------------------------------------
'' Month                                      [12:9]           get_Month
''                                                             set_Month
''                                                             read_Month
''                                                             write_Month
''---------------------------------------------------------------------------------
'' day                                        [8:4]            get_day
''                                                             set_day
''                                                             read_day
''                                                             write_day
''---------------------------------------------------------------------------------
'' year                                       [3:0]            get_year
''                                                             set_year
''                                                             read_year
''                                                             write_year
''---------------------------------------------------------------------------------
Class REGISTER_MISC_f2_image_version
    Private write_firmware_version_value
    Private read_firmware_version_value
    Private flag_firmware_version
    Private write_Month_value
    Private read_Month_value
    Private flag_Month
    Private write_day_value
    Private read_day_value
    Private flag_day
    Private write_year_value
    Private read_year_value
    Private flag_year

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H306
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_firmware_version
        get_firmware_version = read_firmware_version_value
    End Property

    Property Let set_firmware_version(aData)
        write_firmware_version_value = aData
        flag_firmware_version        = &H1
    End Property

    Property Get read_firmware_version
        read
        read_firmware_version = read_firmware_version_value
    End Property

    Property Let write_firmware_version(aData)
        set_firmware_version = aData
        write
    End Property

    Property Get get_Month
        get_Month = read_Month_value
    End Property

    Property Let set_Month(aData)
        write_Month_value = aData
        flag_Month        = &H1
    End Property

    Property Get read_Month
        read
        read_Month = read_Month_value
    End Property

    Property Let write_Month(aData)
        set_Month = aData
        write
    End Property

    Property Get get_day
        get_day = read_day_value
    End Property

    Property Let set_day(aData)
        write_day_value = aData
        flag_day        = &H1
    End Property

    Property Get read_day
        read
        read_day = read_day_value
    End Property

    Property Let write_day(aData)
        set_day = aData
        write
    End Property

    Property Get get_year
        get_year = read_year_value
    End Property

    Property Let set_year(aData)
        write_year_value = aData
        flag_year        = &H1
    End Property

    Property Get read_year
        read
        read_year = read_year_value
    End Property

    Property Let write_year(aData)
        set_year = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_version_value = rightShift(data_low, 13) and &H7
        read_Month_value = rightShift(data_low, 9) and &Hf
        read_day_value = rightShift(data_low, 4) and &H1f
        year_mask = &Hf
        if data_low > LONG_MAX then
            if year_mask = mask then
                read_year_value = data_low
            else
                read_year_value = (data_low - H8000_0000) and year_mask
            end If
        else
            read_year_value = data_low and year_mask
        end If

    End Sub

    Sub write
        If flag_firmware_version = &H0 or flag_Month = &H0 or flag_day = &H0 or flag_year = &H0 Then read
        If flag_firmware_version = &H0 Then write_firmware_version_value = get_firmware_version
        If flag_Month = &H0 Then write_Month_value = get_Month
        If flag_day = &H0 Then write_day_value = get_day
        If flag_year = &H0 Then write_year_value = get_year

        regValue = leftShift((write_firmware_version_value and &H7), 13) + leftShift((write_Month_value and &Hf), 9) + leftShift((write_day_value and &H1f), 4) + leftShift((write_year_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_firmware_version_value = rightShift(data_low, 13) and &H7
        read_Month_value = rightShift(data_low, 9) and &Hf
        read_day_value = rightShift(data_low, 4) and &H1f
        year_mask = &Hf
        if data_low > LONG_MAX then
            if year_mask = mask then
                read_year_value = data_low
            else
                read_year_value = (data_low - H8000_0000) and year_mask
            end If
        else
            read_year_value = data_low and year_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_firmware_version_value = &H0
        flag_firmware_version        = &H0
        write_Month_value = &H0
        flag_Month        = &H0
        write_day_value = &H0
        flag_day        = &H0
        write_year_value = &H0
        flag_year        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg4
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H308
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg5
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg6
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg7
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg8
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H310
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg9
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H312
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_f1_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' F1_Version                                 [15:0]           get_F1_Version
''                                                             set_F1_Version
''                                                             read_F1_Version
''                                                             write_F1_Version
''---------------------------------------------------------------------------------
Class REGISTER_MISC_f1_version
    Private write_F1_Version_value
    Private read_F1_Version_value
    Private flag_F1_Version

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H314
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_F1_Version
        get_F1_Version = read_F1_Version_value
    End Property

    Property Let set_F1_Version(aData)
        write_F1_Version_value = aData
        flag_F1_Version        = &H1
    End Property

    Property Get read_F1_Version
        read
        read_F1_Version = read_F1_Version_value
    End Property

    Property Let write_F1_Version(aData)
        set_F1_Version = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        F1_Version_mask = &Hffff
        if data_low > LONG_MAX then
            if F1_Version_mask = mask then
                read_F1_Version_value = data_low
            else
                read_F1_Version_value = (data_low - H8000_0000) and F1_Version_mask
            end If
        else
            read_F1_Version_value = data_low and F1_Version_mask
        end If

    End Sub

    Sub write
        If flag_F1_Version = &H0 Then read
        If flag_F1_Version = &H0 Then write_F1_Version_value = get_F1_Version

        regValue = leftShift((write_F1_Version_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        F1_Version_mask = &Hffff
        if data_low > LONG_MAX then
            if F1_Version_mask = mask then
                read_F1_Version_value = data_low
            else
                read_F1_Version_value = (data_low - H8000_0000) and F1_Version_mask
            end If
        else
            read_F1_Version_value = data_low and F1_Version_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_F1_Version_value = &H0
        flag_F1_Version        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg11
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H316
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_pkg_model
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [15:6]           get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' pkg_model                                  [5:0]            get_pkg_model
''                                                             set_pkg_model
''                                                             read_pkg_model
''                                                             write_pkg_model
''---------------------------------------------------------------------------------
Class REGISTER_MISC_pkg_model
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_pkg_model_value
    Private read_pkg_model_value
    Private flag_pkg_model

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H318
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_pkg_model
        get_pkg_model = read_pkg_model_value
    End Property

    Property Let set_pkg_model(aData)
        write_pkg_model_value = aData
        flag_pkg_model        = &H1
    End Property

    Property Get read_pkg_model
        read
        read_pkg_model = read_pkg_model_value
    End Property

    Property Let write_pkg_model(aData)
        set_pkg_model = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 6) and &H3ff
        pkg_model_mask = &H3f
        if data_low > LONG_MAX then
            if pkg_model_mask = mask then
                read_pkg_model_value = data_low
            else
                read_pkg_model_value = (data_low - H8000_0000) and pkg_model_mask
            end If
        else
            read_pkg_model_value = data_low and pkg_model_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_pkg_model = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_pkg_model = &H0 Then write_pkg_model_value = get_pkg_model

        regValue = leftShift((write_spare_value and &H3ff), 6) + leftShift((write_pkg_model_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 6) and &H3ff
        pkg_model_mask = &H3f
        if data_low > LONG_MAX then
            if pkg_model_mask = mask then
                read_pkg_model_value = data_low
            else
                read_pkg_model_value = (data_low - H8000_0000) and pkg_model_mask
            end If
        else
            read_pkg_model_value = data_low and pkg_model_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
        write_pkg_model_value = &H0
        flag_pkg_model        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg13
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H31a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg14
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H31c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_hw_reg15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_hw_reg                               [15:0]           get_spare_hw_reg
''                                                             set_spare_hw_reg
''                                                             read_spare_hw_reg
''                                                             write_spare_hw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_hw_reg15
    Private write_spare_hw_reg_value
    Private read_spare_hw_reg_value
    Private flag_spare_hw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H31e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_hw_reg
        get_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let set_spare_hw_reg(aData)
        write_spare_hw_reg_value = aData
        flag_spare_hw_reg        = &H1
    End Property

    Property Get read_spare_hw_reg
        read
        read_spare_hw_reg = read_spare_hw_reg_value
    End Property

    Property Let write_spare_hw_reg(aData)
        set_spare_hw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_hw_reg = &H0 Then read
        If flag_spare_hw_reg = &H0 Then write_spare_hw_reg_value = get_spare_hw_reg

        regValue = leftShift((write_spare_hw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_hw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_hw_reg_mask = mask then
                read_spare_hw_reg_value = data_low
            else
                read_spare_hw_reg_value = (data_low - H8000_0000) and spare_hw_reg_mask
            end If
        else
            read_spare_hw_reg_value = data_low and spare_hw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_hw_reg_value = &H0
        flag_spare_hw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg0
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H320
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg1
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H322
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg2
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H324
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg3
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H326
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg4
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H328
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg5
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg6
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg7
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg8
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H330
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg9
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H332
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg10
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H334
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg11
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H336
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg12
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H338
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg13
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H33a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg14
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H33c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_spare_sw_reg15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_sw_reg                               [15:0]           get_spare_sw_reg
''                                                             set_spare_sw_reg
''                                                             read_spare_sw_reg
''                                                             write_spare_sw_reg
''---------------------------------------------------------------------------------
Class REGISTER_MISC_spare_sw_reg15
    Private write_spare_sw_reg_value
    Private read_spare_sw_reg_value
    Private flag_spare_sw_reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H33e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_sw_reg
        get_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let set_spare_sw_reg(aData)
        write_spare_sw_reg_value = aData
        flag_spare_sw_reg        = &H1
    End Property

    Property Get read_spare_sw_reg
        read
        read_spare_sw_reg = read_spare_sw_reg_value
    End Property

    Property Let write_spare_sw_reg(aData)
        set_spare_sw_reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

    End Sub

    Sub write
        If flag_spare_sw_reg = &H0 Then read
        If flag_spare_sw_reg = &H0 Then write_spare_sw_reg_value = get_spare_sw_reg

        regValue = leftShift((write_spare_sw_reg_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spare_sw_reg_mask = &Hffff
        if data_low > LONG_MAX then
            if spare_sw_reg_mask = mask then
                read_spare_sw_reg_value = data_low
            else
                read_spare_sw_reg_value = (data_low - H8000_0000) and spare_sw_reg_mask
            end If
        else
            read_spare_sw_reg_value = data_low and spare_sw_reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_sw_reg_value = &H0
        flag_spare_sw_reg        = &H0
    End Sub
End Class


'' @REGISTER : MISC_cpusys_misc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [15:4]           get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' access_int_slv_thro_mdio_mst               [3:3]            get_access_int_slv_thro_mdio_mst
''                                                             set_access_int_slv_thro_mdio_mst
''                                                             read_access_int_slv_thro_mdio_mst
''                                                             write_access_int_slv_thro_mdio_mst
''---------------------------------------------------------------------------------
'' intr_out_en_pcie                           [2:2]            get_intr_out_en_pcie
''                                                             set_intr_out_en_pcie
''                                                             read_intr_out_en_pcie
''                                                             write_intr_out_en_pcie
''---------------------------------------------------------------------------------
'' intr_out_en_pad                            [1:1]            get_intr_out_en_pad
''                                                             set_intr_out_en_pad
''                                                             read_intr_out_en_pad
''                                                             write_intr_out_en_pad
''---------------------------------------------------------------------------------
'' soft_intr                                  [0:0]            get_soft_intr
''                                                             set_soft_intr
''                                                             read_soft_intr
''                                                             write_soft_intr
''---------------------------------------------------------------------------------
Class REGISTER_MISC_cpusys_misc
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_access_int_slv_thro_mdio_mst_value
    Private read_access_int_slv_thro_mdio_mst_value
    Private flag_access_int_slv_thro_mdio_mst
    Private write_intr_out_en_pcie_value
    Private read_intr_out_en_pcie_value
    Private flag_intr_out_en_pcie
    Private write_intr_out_en_pad_value
    Private read_intr_out_en_pad_value
    Private flag_intr_out_en_pad
    Private write_soft_intr_value
    Private read_soft_intr_value
    Private flag_soft_intr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H340
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_access_int_slv_thro_mdio_mst
        get_access_int_slv_thro_mdio_mst = read_access_int_slv_thro_mdio_mst_value
    End Property

    Property Let set_access_int_slv_thro_mdio_mst(aData)
        write_access_int_slv_thro_mdio_mst_value = aData
        flag_access_int_slv_thro_mdio_mst        = &H1
    End Property

    Property Get read_access_int_slv_thro_mdio_mst
        read
        read_access_int_slv_thro_mdio_mst = read_access_int_slv_thro_mdio_mst_value
    End Property

    Property Let write_access_int_slv_thro_mdio_mst(aData)
        set_access_int_slv_thro_mdio_mst = aData
        write
    End Property

    Property Get get_intr_out_en_pcie
        get_intr_out_en_pcie = read_intr_out_en_pcie_value
    End Property

    Property Let set_intr_out_en_pcie(aData)
        write_intr_out_en_pcie_value = aData
        flag_intr_out_en_pcie        = &H1
    End Property

    Property Get read_intr_out_en_pcie
        read
        read_intr_out_en_pcie = read_intr_out_en_pcie_value
    End Property

    Property Let write_intr_out_en_pcie(aData)
        set_intr_out_en_pcie = aData
        write
    End Property

    Property Get get_intr_out_en_pad
        get_intr_out_en_pad = read_intr_out_en_pad_value
    End Property

    Property Let set_intr_out_en_pad(aData)
        write_intr_out_en_pad_value = aData
        flag_intr_out_en_pad        = &H1
    End Property

    Property Get read_intr_out_en_pad
        read
        read_intr_out_en_pad = read_intr_out_en_pad_value
    End Property

    Property Let write_intr_out_en_pad(aData)
        set_intr_out_en_pad = aData
        write
    End Property

    Property Get get_soft_intr
        get_soft_intr = read_soft_intr_value
    End Property

    Property Let set_soft_intr(aData)
        write_soft_intr_value = aData
        flag_soft_intr        = &H1
    End Property

    Property Get read_soft_intr
        read
        read_soft_intr = read_soft_intr_value
    End Property

    Property Let write_soft_intr(aData)
        set_soft_intr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 4) and &Hfff
        read_access_int_slv_thro_mdio_mst_value = rightShift(data_low, 3) and &H1
        read_intr_out_en_pcie_value = rightShift(data_low, 2) and &H1
        read_intr_out_en_pad_value = rightShift(data_low, 1) and &H1
        soft_intr_mask = &H1
        if data_low > LONG_MAX then
            if soft_intr_mask = mask then
                read_soft_intr_value = data_low
            else
                read_soft_intr_value = (data_low - H8000_0000) and soft_intr_mask
            end If
        else
            read_soft_intr_value = data_low and soft_intr_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_access_int_slv_thro_mdio_mst = &H0 or flag_intr_out_en_pcie = &H0 or flag_intr_out_en_pad = &H0 or flag_soft_intr = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_access_int_slv_thro_mdio_mst = &H0 Then write_access_int_slv_thro_mdio_mst_value = get_access_int_slv_thro_mdio_mst
        If flag_intr_out_en_pcie = &H0 Then write_intr_out_en_pcie_value = get_intr_out_en_pcie
        If flag_intr_out_en_pad = &H0 Then write_intr_out_en_pad_value = get_intr_out_en_pad
        If flag_soft_intr = &H0 Then write_soft_intr_value = get_soft_intr

        regValue = leftShift((write_spare_value and &Hfff), 4) + leftShift((write_access_int_slv_thro_mdio_mst_value and &H1), 3) + leftShift((write_intr_out_en_pcie_value and &H1), 2) + leftShift((write_intr_out_en_pad_value and &H1), 1) + leftShift((write_soft_intr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 4) and &Hfff
        read_access_int_slv_thro_mdio_mst_value = rightShift(data_low, 3) and &H1
        read_intr_out_en_pcie_value = rightShift(data_low, 2) and &H1
        read_intr_out_en_pad_value = rightShift(data_low, 1) and &H1
        soft_intr_mask = &H1
        if data_low > LONG_MAX then
            if soft_intr_mask = mask then
                read_soft_intr_value = data_low
            else
                read_soft_intr_value = (data_low - H8000_0000) and soft_intr_mask
            end If
        else
            read_soft_intr_value = data_low and soft_intr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
        write_access_int_slv_thro_mdio_mst_value = &H0
        flag_access_int_slv_thro_mdio_mst        = &H0
        write_intr_out_en_pcie_value = &H0
        flag_intr_out_en_pcie        = &H0
        write_intr_out_en_pad_value = &H0
        flag_intr_out_en_pad        = &H0
        write_soft_intr_value = &H0
        flag_soft_intr        = &H0
    End Sub
End Class


'' @REGISTER : MISC_brphys_misc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [15:6]           get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' brphy_1g_1p_source_sync_mii                [5:5]            get_brphy_1g_1p_source_sync_mii
''                                                             set_brphy_1g_1p_source_sync_mii
''                                                             read_brphy_1g_1p_source_sync_mii
''                                                             write_brphy_1g_1p_source_sync_mii
''---------------------------------------------------------------------------------
'' br5p_tc10_rdb_mdio_sel                     [4:4]            get_br5p_tc10_rdb_mdio_sel
''                                                             set_br5p_tc10_rdb_mdio_sel
''                                                             read_br5p_tc10_rdb_mdio_sel
''                                                             write_br5p_tc10_rdb_mdio_sel
''---------------------------------------------------------------------------------
'' brphy_1g_1port_clear_on_read               [3:3]            get_brphy_1g_1port_clear_on_read
''                                                             set_brphy_1g_1port_clear_on_read
''                                                             read_brphy_1g_1port_clear_on_read
''                                                             write_brphy_1g_1port_clear_on_read
''---------------------------------------------------------------------------------
'' cfg_tc10_sl_m7_intr_en                     [2:2]            get_cfg_tc10_sl_m7_intr_en
''                                                             set_cfg_tc10_sl_m7_intr_en
''                                                             read_cfg_tc10_sl_m7_intr_en
''                                                             write_cfg_tc10_sl_m7_intr_en
''---------------------------------------------------------------------------------
'' br_auto_neg_en_strap_def                   [1:1]            get_br_auto_neg_en_strap_def
''                                                             set_br_auto_neg_en_strap_def
''                                                             read_br_auto_neg_en_strap_def
''                                                             write_br_auto_neg_en_strap_def
''---------------------------------------------------------------------------------
'' clear_on_read_en                           [0:0]            get_clear_on_read_en
''                                                             set_clear_on_read_en
''                                                             read_clear_on_read_en
''                                                             write_clear_on_read_en
''---------------------------------------------------------------------------------
Class REGISTER_MISC_brphys_misc
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_brphy_1g_1p_source_sync_mii_value
    Private read_brphy_1g_1p_source_sync_mii_value
    Private flag_brphy_1g_1p_source_sync_mii
    Private write_br5p_tc10_rdb_mdio_sel_value
    Private read_br5p_tc10_rdb_mdio_sel_value
    Private flag_br5p_tc10_rdb_mdio_sel
    Private write_brphy_1g_1port_clear_on_read_value
    Private read_brphy_1g_1port_clear_on_read_value
    Private flag_brphy_1g_1port_clear_on_read
    Private write_cfg_tc10_sl_m7_intr_en_value
    Private read_cfg_tc10_sl_m7_intr_en_value
    Private flag_cfg_tc10_sl_m7_intr_en
    Private write_br_auto_neg_en_strap_def_value
    Private read_br_auto_neg_en_strap_def_value
    Private flag_br_auto_neg_en_strap_def
    Private write_clear_on_read_en_value
    Private read_clear_on_read_en_value
    Private flag_clear_on_read_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H342
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_brphy_1g_1p_source_sync_mii
        get_brphy_1g_1p_source_sync_mii = read_brphy_1g_1p_source_sync_mii_value
    End Property

    Property Let set_brphy_1g_1p_source_sync_mii(aData)
        write_brphy_1g_1p_source_sync_mii_value = aData
        flag_brphy_1g_1p_source_sync_mii        = &H1
    End Property

    Property Get read_brphy_1g_1p_source_sync_mii
        read
        read_brphy_1g_1p_source_sync_mii = read_brphy_1g_1p_source_sync_mii_value
    End Property

    Property Let write_brphy_1g_1p_source_sync_mii(aData)
        set_brphy_1g_1p_source_sync_mii = aData
        write
    End Property

    Property Get get_br5p_tc10_rdb_mdio_sel
        get_br5p_tc10_rdb_mdio_sel = read_br5p_tc10_rdb_mdio_sel_value
    End Property

    Property Let set_br5p_tc10_rdb_mdio_sel(aData)
        write_br5p_tc10_rdb_mdio_sel_value = aData
        flag_br5p_tc10_rdb_mdio_sel        = &H1
    End Property

    Property Get read_br5p_tc10_rdb_mdio_sel
        read
        read_br5p_tc10_rdb_mdio_sel = read_br5p_tc10_rdb_mdio_sel_value
    End Property

    Property Let write_br5p_tc10_rdb_mdio_sel(aData)
        set_br5p_tc10_rdb_mdio_sel = aData
        write
    End Property

    Property Get get_brphy_1g_1port_clear_on_read
        get_brphy_1g_1port_clear_on_read = read_brphy_1g_1port_clear_on_read_value
    End Property

    Property Let set_brphy_1g_1port_clear_on_read(aData)
        write_brphy_1g_1port_clear_on_read_value = aData
        flag_brphy_1g_1port_clear_on_read        = &H1
    End Property

    Property Get read_brphy_1g_1port_clear_on_read
        read
        read_brphy_1g_1port_clear_on_read = read_brphy_1g_1port_clear_on_read_value
    End Property

    Property Let write_brphy_1g_1port_clear_on_read(aData)
        set_brphy_1g_1port_clear_on_read = aData
        write
    End Property

    Property Get get_cfg_tc10_sl_m7_intr_en
        get_cfg_tc10_sl_m7_intr_en = read_cfg_tc10_sl_m7_intr_en_value
    End Property

    Property Let set_cfg_tc10_sl_m7_intr_en(aData)
        write_cfg_tc10_sl_m7_intr_en_value = aData
        flag_cfg_tc10_sl_m7_intr_en        = &H1
    End Property

    Property Get read_cfg_tc10_sl_m7_intr_en
        read
        read_cfg_tc10_sl_m7_intr_en = read_cfg_tc10_sl_m7_intr_en_value
    End Property

    Property Let write_cfg_tc10_sl_m7_intr_en(aData)
        set_cfg_tc10_sl_m7_intr_en = aData
        write
    End Property

    Property Get get_br_auto_neg_en_strap_def
        get_br_auto_neg_en_strap_def = read_br_auto_neg_en_strap_def_value
    End Property

    Property Let set_br_auto_neg_en_strap_def(aData)
        write_br_auto_neg_en_strap_def_value = aData
        flag_br_auto_neg_en_strap_def        = &H1
    End Property

    Property Get read_br_auto_neg_en_strap_def
        read
        read_br_auto_neg_en_strap_def = read_br_auto_neg_en_strap_def_value
    End Property

    Property Let write_br_auto_neg_en_strap_def(aData)
        set_br_auto_neg_en_strap_def = aData
        write
    End Property

    Property Get get_clear_on_read_en
        get_clear_on_read_en = read_clear_on_read_en_value
    End Property

    Property Let set_clear_on_read_en(aData)
        write_clear_on_read_en_value = aData
        flag_clear_on_read_en        = &H1
    End Property

    Property Get read_clear_on_read_en
        read
        read_clear_on_read_en = read_clear_on_read_en_value
    End Property

    Property Let write_clear_on_read_en(aData)
        set_clear_on_read_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 6) and &H3ff
        read_brphy_1g_1p_source_sync_mii_value = rightShift(data_low, 5) and &H1
        read_br5p_tc10_rdb_mdio_sel_value = rightShift(data_low, 4) and &H1
        read_brphy_1g_1port_clear_on_read_value = rightShift(data_low, 3) and &H1
        read_cfg_tc10_sl_m7_intr_en_value = rightShift(data_low, 2) and &H1
        read_br_auto_neg_en_strap_def_value = rightShift(data_low, 1) and &H1
        clear_on_read_en_mask = &H1
        if data_low > LONG_MAX then
            if clear_on_read_en_mask = mask then
                read_clear_on_read_en_value = data_low
            else
                read_clear_on_read_en_value = (data_low - H8000_0000) and clear_on_read_en_mask
            end If
        else
            read_clear_on_read_en_value = data_low and clear_on_read_en_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_brphy_1g_1p_source_sync_mii = &H0 or flag_br5p_tc10_rdb_mdio_sel = &H0 or flag_brphy_1g_1port_clear_on_read = &H0 or flag_cfg_tc10_sl_m7_intr_en = &H0 or flag_br_auto_neg_en_strap_def = &H0 or flag_clear_on_read_en = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_brphy_1g_1p_source_sync_mii = &H0 Then write_brphy_1g_1p_source_sync_mii_value = get_brphy_1g_1p_source_sync_mii
        If flag_br5p_tc10_rdb_mdio_sel = &H0 Then write_br5p_tc10_rdb_mdio_sel_value = get_br5p_tc10_rdb_mdio_sel
        If flag_brphy_1g_1port_clear_on_read = &H0 Then write_brphy_1g_1port_clear_on_read_value = get_brphy_1g_1port_clear_on_read
        If flag_cfg_tc10_sl_m7_intr_en = &H0 Then write_cfg_tc10_sl_m7_intr_en_value = get_cfg_tc10_sl_m7_intr_en
        If flag_br_auto_neg_en_strap_def = &H0 Then write_br_auto_neg_en_strap_def_value = get_br_auto_neg_en_strap_def
        If flag_clear_on_read_en = &H0 Then write_clear_on_read_en_value = get_clear_on_read_en

        regValue = leftShift((write_spare_value and &H3ff), 6) + leftShift((write_brphy_1g_1p_source_sync_mii_value and &H1), 5) + leftShift((write_br5p_tc10_rdb_mdio_sel_value and &H1), 4) + leftShift((write_brphy_1g_1port_clear_on_read_value and &H1), 3) + leftShift((write_cfg_tc10_sl_m7_intr_en_value and &H1), 2) + leftShift((write_br_auto_neg_en_strap_def_value and &H1), 1) + leftShift((write_clear_on_read_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 6) and &H3ff
        read_brphy_1g_1p_source_sync_mii_value = rightShift(data_low, 5) and &H1
        read_br5p_tc10_rdb_mdio_sel_value = rightShift(data_low, 4) and &H1
        read_brphy_1g_1port_clear_on_read_value = rightShift(data_low, 3) and &H1
        read_cfg_tc10_sl_m7_intr_en_value = rightShift(data_low, 2) and &H1
        read_br_auto_neg_en_strap_def_value = rightShift(data_low, 1) and &H1
        clear_on_read_en_mask = &H1
        if data_low > LONG_MAX then
            if clear_on_read_en_mask = mask then
                read_clear_on_read_en_value = data_low
            else
                read_clear_on_read_en_value = (data_low - H8000_0000) and clear_on_read_en_mask
            end If
        else
            read_clear_on_read_en_value = data_low and clear_on_read_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
        write_brphy_1g_1p_source_sync_mii_value = &H0
        flag_brphy_1g_1p_source_sync_mii        = &H0
        write_br5p_tc10_rdb_mdio_sel_value = &H0
        flag_br5p_tc10_rdb_mdio_sel        = &H0
        write_brphy_1g_1port_clear_on_read_value = &H0
        flag_brphy_1g_1port_clear_on_read        = &H0
        write_cfg_tc10_sl_m7_intr_en_value = &H0
        flag_cfg_tc10_sl_m7_intr_en        = &H0
        write_br_auto_neg_en_strap_def_value = &H0
        flag_br_auto_neg_en_strap_def        = &H0
        write_clear_on_read_en_value = &H0
        flag_clear_on_read_en        = &H0
    End Sub
End Class


'' @REGISTER : MISC_brphys_tc10_ctrl_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' wake_via_wake_br1g                         [5:5]            get_wake_via_wake_br1g
''                                                             set_wake_via_wake_br1g
''                                                             read_wake_via_wake_br1g
''                                                             write_wake_via_wake_br1g
''---------------------------------------------------------------------------------
'' wake_via_wake_br5                          [4:4]            get_wake_via_wake_br5
''                                                             set_wake_via_wake_br5
''                                                             read_wake_via_wake_br5
''                                                             write_wake_via_wake_br5
''---------------------------------------------------------------------------------
'' wake_via_wake                              [3:0]            get_wake_via_wake
''                                                             set_wake_via_wake
''                                                             read_wake_via_wake
''                                                             write_wake_via_wake
''---------------------------------------------------------------------------------
Class REGISTER_MISC_brphys_tc10_ctrl_reg
    Private write_wake_via_wake_br1g_value
    Private read_wake_via_wake_br1g_value
    Private flag_wake_via_wake_br1g
    Private write_wake_via_wake_br5_value
    Private read_wake_via_wake_br5_value
    Private flag_wake_via_wake_br5
    Private write_wake_via_wake_value
    Private read_wake_via_wake_value
    Private flag_wake_via_wake

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H344
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_wake_via_wake_br1g
        get_wake_via_wake_br1g = read_wake_via_wake_br1g_value
    End Property

    Property Let set_wake_via_wake_br1g(aData)
        write_wake_via_wake_br1g_value = aData
        flag_wake_via_wake_br1g        = &H1
    End Property

    Property Get read_wake_via_wake_br1g
        read
        read_wake_via_wake_br1g = read_wake_via_wake_br1g_value
    End Property

    Property Let write_wake_via_wake_br1g(aData)
        set_wake_via_wake_br1g = aData
        write
    End Property

    Property Get get_wake_via_wake_br5
        get_wake_via_wake_br5 = read_wake_via_wake_br5_value
    End Property

    Property Let set_wake_via_wake_br5(aData)
        write_wake_via_wake_br5_value = aData
        flag_wake_via_wake_br5        = &H1
    End Property

    Property Get read_wake_via_wake_br5
        read
        read_wake_via_wake_br5 = read_wake_via_wake_br5_value
    End Property

    Property Let write_wake_via_wake_br5(aData)
        set_wake_via_wake_br5 = aData
        write
    End Property

    Property Get get_wake_via_wake
        get_wake_via_wake = read_wake_via_wake_value
    End Property

    Property Let set_wake_via_wake(aData)
        write_wake_via_wake_value = aData
        flag_wake_via_wake        = &H1
    End Property

    Property Get read_wake_via_wake
        read
        read_wake_via_wake = read_wake_via_wake_value
    End Property

    Property Let write_wake_via_wake(aData)
        set_wake_via_wake = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_wake_via_wake_br1g_value = rightShift(data_low, 5) and &H1
        read_wake_via_wake_br5_value = rightShift(data_low, 4) and &H1
        wake_via_wake_mask = &Hf
        if data_low > LONG_MAX then
            if wake_via_wake_mask = mask then
                read_wake_via_wake_value = data_low
            else
                read_wake_via_wake_value = (data_low - H8000_0000) and wake_via_wake_mask
            end If
        else
            read_wake_via_wake_value = data_low and wake_via_wake_mask
        end If

    End Sub

    Sub write
        If flag_wake_via_wake_br1g = &H0 or flag_wake_via_wake_br5 = &H0 or flag_wake_via_wake = &H0 Then read
        If flag_wake_via_wake_br1g = &H0 Then write_wake_via_wake_br1g_value = get_wake_via_wake_br1g
        If flag_wake_via_wake_br5 = &H0 Then write_wake_via_wake_br5_value = get_wake_via_wake_br5
        If flag_wake_via_wake = &H0 Then write_wake_via_wake_value = get_wake_via_wake

        regValue = leftShift((write_wake_via_wake_br1g_value and &H1), 5) + leftShift((write_wake_via_wake_br5_value and &H1), 4) + leftShift((write_wake_via_wake_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_wake_via_wake_br1g_value = rightShift(data_low, 5) and &H1
        read_wake_via_wake_br5_value = rightShift(data_low, 4) and &H1
        wake_via_wake_mask = &Hf
        if data_low > LONG_MAX then
            if wake_via_wake_mask = mask then
                read_wake_via_wake_value = data_low
            else
                read_wake_via_wake_value = (data_low - H8000_0000) and wake_via_wake_mask
            end If
        else
            read_wake_via_wake_value = data_low and wake_via_wake_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_wake_via_wake_br1g_value = &H0
        flag_wake_via_wake_br1g        = &H0
        write_wake_via_wake_br5_value = &H0
        flag_wake_via_wake_br5        = &H0
        write_wake_via_wake_value = &H0
        flag_wake_via_wake        = &H0
    End Sub
End Class


'' @REGISTER : MISC_brphys_tc10_status_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [15:13]          get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' tc10_sleep_mode_br1g                       [12:12]          get_tc10_sleep_mode_br1g
''                                                             set_tc10_sleep_mode_br1g
''                                                             read_tc10_sleep_mode_br1g
''                                                             write_tc10_sleep_mode_br1g
''---------------------------------------------------------------------------------
'' tc10_intr_status_br1g                      [11:11]          get_tc10_intr_status_br1g
''                                                             set_tc10_intr_status_br1g
''                                                             read_tc10_intr_status_br1g
''                                                             write_tc10_intr_status_br1g
''---------------------------------------------------------------------------------
'' tc10_sleep_mode_br5                        [10:10]          get_tc10_sleep_mode_br5
''                                                             set_tc10_sleep_mode_br5
''                                                             read_tc10_sleep_mode_br5
''                                                             write_tc10_sleep_mode_br5
''---------------------------------------------------------------------------------
'' tc10_intr_status_br5                       [9:9]            get_tc10_intr_status_br5
''                                                             set_tc10_intr_status_br5
''                                                             read_tc10_intr_status_br5
''                                                             write_tc10_intr_status_br5
''---------------------------------------------------------------------------------
'' afe_wake_via_wake                          [8:8]            get_afe_wake_via_wake
''                                                             set_afe_wake_via_wake
''                                                             read_afe_wake_via_wake
''                                                             write_afe_wake_via_wake
''---------------------------------------------------------------------------------
'' tc10_sleep_mode                            [7:4]            get_tc10_sleep_mode
''                                                             set_tc10_sleep_mode
''                                                             read_tc10_sleep_mode
''                                                             write_tc10_sleep_mode
''---------------------------------------------------------------------------------
'' tc10_intr_status                           [3:0]            get_tc10_intr_status
''                                                             set_tc10_intr_status
''                                                             read_tc10_intr_status
''                                                             write_tc10_intr_status
''---------------------------------------------------------------------------------
Class REGISTER_MISC_brphys_tc10_status_reg
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_tc10_sleep_mode_br1g_value
    Private read_tc10_sleep_mode_br1g_value
    Private flag_tc10_sleep_mode_br1g
    Private write_tc10_intr_status_br1g_value
    Private read_tc10_intr_status_br1g_value
    Private flag_tc10_intr_status_br1g
    Private write_tc10_sleep_mode_br5_value
    Private read_tc10_sleep_mode_br5_value
    Private flag_tc10_sleep_mode_br5
    Private write_tc10_intr_status_br5_value
    Private read_tc10_intr_status_br5_value
    Private flag_tc10_intr_status_br5
    Private write_afe_wake_via_wake_value
    Private read_afe_wake_via_wake_value
    Private flag_afe_wake_via_wake
    Private write_tc10_sleep_mode_value
    Private read_tc10_sleep_mode_value
    Private flag_tc10_sleep_mode
    Private write_tc10_intr_status_value
    Private read_tc10_intr_status_value
    Private flag_tc10_intr_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H346
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare
        get_spare = read_spare_value
    End Property

    Property Let set_spare(aData)
        write_spare_value = aData
        flag_spare        = &H1
    End Property

    Property Get read_spare
        read
        read_spare = read_spare_value
    End Property

    Property Let write_spare(aData)
        set_spare = aData
        write
    End Property

    Property Get get_tc10_sleep_mode_br1g
        get_tc10_sleep_mode_br1g = read_tc10_sleep_mode_br1g_value
    End Property

    Property Let set_tc10_sleep_mode_br1g(aData)
        write_tc10_sleep_mode_br1g_value = aData
        flag_tc10_sleep_mode_br1g        = &H1
    End Property

    Property Get read_tc10_sleep_mode_br1g
        read
        read_tc10_sleep_mode_br1g = read_tc10_sleep_mode_br1g_value
    End Property

    Property Let write_tc10_sleep_mode_br1g(aData)
        set_tc10_sleep_mode_br1g = aData
        write
    End Property

    Property Get get_tc10_intr_status_br1g
        get_tc10_intr_status_br1g = read_tc10_intr_status_br1g_value
    End Property

    Property Let set_tc10_intr_status_br1g(aData)
        write_tc10_intr_status_br1g_value = aData
        flag_tc10_intr_status_br1g        = &H1
    End Property

    Property Get read_tc10_intr_status_br1g
        read
        read_tc10_intr_status_br1g = read_tc10_intr_status_br1g_value
    End Property

    Property Let write_tc10_intr_status_br1g(aData)
        set_tc10_intr_status_br1g = aData
        write
    End Property

    Property Get get_tc10_sleep_mode_br5
        get_tc10_sleep_mode_br5 = read_tc10_sleep_mode_br5_value
    End Property

    Property Let set_tc10_sleep_mode_br5(aData)
        write_tc10_sleep_mode_br5_value = aData
        flag_tc10_sleep_mode_br5        = &H1
    End Property

    Property Get read_tc10_sleep_mode_br5
        read
        read_tc10_sleep_mode_br5 = read_tc10_sleep_mode_br5_value
    End Property

    Property Let write_tc10_sleep_mode_br5(aData)
        set_tc10_sleep_mode_br5 = aData
        write
    End Property

    Property Get get_tc10_intr_status_br5
        get_tc10_intr_status_br5 = read_tc10_intr_status_br5_value
    End Property

    Property Let set_tc10_intr_status_br5(aData)
        write_tc10_intr_status_br5_value = aData
        flag_tc10_intr_status_br5        = &H1
    End Property

    Property Get read_tc10_intr_status_br5
        read
        read_tc10_intr_status_br5 = read_tc10_intr_status_br5_value
    End Property

    Property Let write_tc10_intr_status_br5(aData)
        set_tc10_intr_status_br5 = aData
        write
    End Property

    Property Get get_afe_wake_via_wake
        get_afe_wake_via_wake = read_afe_wake_via_wake_value
    End Property

    Property Let set_afe_wake_via_wake(aData)
        write_afe_wake_via_wake_value = aData
        flag_afe_wake_via_wake        = &H1
    End Property

    Property Get read_afe_wake_via_wake
        read
        read_afe_wake_via_wake = read_afe_wake_via_wake_value
    End Property

    Property Let write_afe_wake_via_wake(aData)
        set_afe_wake_via_wake = aData
        write
    End Property

    Property Get get_tc10_sleep_mode
        get_tc10_sleep_mode = read_tc10_sleep_mode_value
    End Property

    Property Let set_tc10_sleep_mode(aData)
        write_tc10_sleep_mode_value = aData
        flag_tc10_sleep_mode        = &H1
    End Property

    Property Get read_tc10_sleep_mode
        read
        read_tc10_sleep_mode = read_tc10_sleep_mode_value
    End Property

    Property Let write_tc10_sleep_mode(aData)
        set_tc10_sleep_mode = aData
        write
    End Property

    Property Get get_tc10_intr_status
        get_tc10_intr_status = read_tc10_intr_status_value
    End Property

    Property Let set_tc10_intr_status(aData)
        write_tc10_intr_status_value = aData
        flag_tc10_intr_status        = &H1
    End Property

    Property Get read_tc10_intr_status
        read
        read_tc10_intr_status = read_tc10_intr_status_value
    End Property

    Property Let write_tc10_intr_status(aData)
        set_tc10_intr_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 13) and &H7
        read_tc10_sleep_mode_br1g_value = rightShift(data_low, 12) and &H1
        read_tc10_intr_status_br1g_value = rightShift(data_low, 11) and &H1
        read_tc10_sleep_mode_br5_value = rightShift(data_low, 10) and &H1
        read_tc10_intr_status_br5_value = rightShift(data_low, 9) and &H1
        read_afe_wake_via_wake_value = rightShift(data_low, 8) and &H1
        read_tc10_sleep_mode_value = rightShift(data_low, 4) and &Hf
        tc10_intr_status_mask = &Hf
        if data_low > LONG_MAX then
            if tc10_intr_status_mask = mask then
                read_tc10_intr_status_value = data_low
            else
                read_tc10_intr_status_value = (data_low - H8000_0000) and tc10_intr_status_mask
            end If
        else
            read_tc10_intr_status_value = data_low and tc10_intr_status_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_tc10_sleep_mode_br1g = &H0 or flag_tc10_intr_status_br1g = &H0 or flag_tc10_sleep_mode_br5 = &H0 or flag_tc10_intr_status_br5 = &H0 or flag_afe_wake_via_wake = &H0 or flag_tc10_sleep_mode = &H0 or flag_tc10_intr_status = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_tc10_sleep_mode_br1g = &H0 Then write_tc10_sleep_mode_br1g_value = get_tc10_sleep_mode_br1g
        If flag_tc10_intr_status_br1g = &H0 Then write_tc10_intr_status_br1g_value = get_tc10_intr_status_br1g
        If flag_tc10_sleep_mode_br5 = &H0 Then write_tc10_sleep_mode_br5_value = get_tc10_sleep_mode_br5
        If flag_tc10_intr_status_br5 = &H0 Then write_tc10_intr_status_br5_value = get_tc10_intr_status_br5
        If flag_afe_wake_via_wake = &H0 Then write_afe_wake_via_wake_value = get_afe_wake_via_wake
        If flag_tc10_sleep_mode = &H0 Then write_tc10_sleep_mode_value = get_tc10_sleep_mode
        If flag_tc10_intr_status = &H0 Then write_tc10_intr_status_value = get_tc10_intr_status

        regValue = leftShift((write_spare_value and &H7), 13) + leftShift((write_tc10_sleep_mode_br1g_value and &H1), 12) + leftShift((write_tc10_intr_status_br1g_value and &H1), 11) + leftShift((write_tc10_sleep_mode_br5_value and &H1), 10) + leftShift((write_tc10_intr_status_br5_value and &H1), 9) + leftShift((write_afe_wake_via_wake_value and &H1), 8) + leftShift((write_tc10_sleep_mode_value and &Hf), 4) + leftShift((write_tc10_intr_status_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 13) and &H7
        read_tc10_sleep_mode_br1g_value = rightShift(data_low, 12) and &H1
        read_tc10_intr_status_br1g_value = rightShift(data_low, 11) and &H1
        read_tc10_sleep_mode_br5_value = rightShift(data_low, 10) and &H1
        read_tc10_intr_status_br5_value = rightShift(data_low, 9) and &H1
        read_afe_wake_via_wake_value = rightShift(data_low, 8) and &H1
        read_tc10_sleep_mode_value = rightShift(data_low, 4) and &Hf
        tc10_intr_status_mask = &Hf
        if data_low > LONG_MAX then
            if tc10_intr_status_mask = mask then
                read_tc10_intr_status_value = data_low
            else
                read_tc10_intr_status_value = (data_low - H8000_0000) and tc10_intr_status_mask
            end If
        else
            read_tc10_intr_status_value = data_low and tc10_intr_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_value = &H0
        flag_spare        = &H0
        write_tc10_sleep_mode_br1g_value = &H0
        flag_tc10_sleep_mode_br1g        = &H0
        write_tc10_intr_status_br1g_value = &H0
        flag_tc10_intr_status_br1g        = &H0
        write_tc10_sleep_mode_br5_value = &H0
        flag_tc10_sleep_mode_br5        = &H0
        write_tc10_intr_status_br5_value = &H0
        flag_tc10_intr_status_br5        = &H0
        write_afe_wake_via_wake_value = &H0
        flag_afe_wake_via_wake        = &H0
        write_tc10_sleep_mode_value = &H0
        flag_tc10_sleep_mode        = &H0
        write_tc10_intr_status_value = &H0
        flag_tc10_intr_status        = &H0
    End Sub
End Class


'' @REGISTER : MISC_ring_osc_sel_ctrl_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ring_osc_sel_ctrl                          [3:0]            get_ring_osc_sel_ctrl
''                                                             set_ring_osc_sel_ctrl
''                                                             read_ring_osc_sel_ctrl
''                                                             write_ring_osc_sel_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_MISC_ring_osc_sel_ctrl_reg
    Private write_ring_osc_sel_ctrl_value
    Private read_ring_osc_sel_ctrl_value
    Private flag_ring_osc_sel_ctrl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H348
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ring_osc_sel_ctrl
        get_ring_osc_sel_ctrl = read_ring_osc_sel_ctrl_value
    End Property

    Property Let set_ring_osc_sel_ctrl(aData)
        write_ring_osc_sel_ctrl_value = aData
        flag_ring_osc_sel_ctrl        = &H1
    End Property

    Property Get read_ring_osc_sel_ctrl
        read
        read_ring_osc_sel_ctrl = read_ring_osc_sel_ctrl_value
    End Property

    Property Let write_ring_osc_sel_ctrl(aData)
        set_ring_osc_sel_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ring_osc_sel_ctrl_mask = &Hf
        if data_low > LONG_MAX then
            if ring_osc_sel_ctrl_mask = mask then
                read_ring_osc_sel_ctrl_value = data_low
            else
                read_ring_osc_sel_ctrl_value = (data_low - H8000_0000) and ring_osc_sel_ctrl_mask
            end If
        else
            read_ring_osc_sel_ctrl_value = data_low and ring_osc_sel_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_ring_osc_sel_ctrl = &H0 Then read
        If flag_ring_osc_sel_ctrl = &H0 Then write_ring_osc_sel_ctrl_value = get_ring_osc_sel_ctrl

        regValue = leftShift((write_ring_osc_sel_ctrl_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ring_osc_sel_ctrl_mask = &Hf
        if data_low > LONG_MAX then
            if ring_osc_sel_ctrl_mask = mask then
                read_ring_osc_sel_ctrl_value = data_low
            else
                read_ring_osc_sel_ctrl_value = (data_low - H8000_0000) and ring_osc_sel_ctrl_mask
            end If
        else
            read_ring_osc_sel_ctrl_value = data_low and ring_osc_sel_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ring_osc_sel_ctrl_value = &H0
        flag_ring_osc_sel_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : MISC_ring_osc_en_ctrl_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ring_osc_output_en                         [12:12]          get_ring_osc_output_en
''                                                             set_ring_osc_output_en
''                                                             read_ring_osc_output_en
''                                                             write_ring_osc_output_en
''---------------------------------------------------------------------------------
'' ring_osc_en_ctrl                           [11:0]           get_ring_osc_en_ctrl
''                                                             set_ring_osc_en_ctrl
''                                                             read_ring_osc_en_ctrl
''                                                             write_ring_osc_en_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_MISC_ring_osc_en_ctrl_reg
    Private write_ring_osc_output_en_value
    Private read_ring_osc_output_en_value
    Private flag_ring_osc_output_en
    Private write_ring_osc_en_ctrl_value
    Private read_ring_osc_en_ctrl_value
    Private flag_ring_osc_en_ctrl

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ring_osc_output_en
        get_ring_osc_output_en = read_ring_osc_output_en_value
    End Property

    Property Let set_ring_osc_output_en(aData)
        write_ring_osc_output_en_value = aData
        flag_ring_osc_output_en        = &H1
    End Property

    Property Get read_ring_osc_output_en
        read
        read_ring_osc_output_en = read_ring_osc_output_en_value
    End Property

    Property Let write_ring_osc_output_en(aData)
        set_ring_osc_output_en = aData
        write
    End Property

    Property Get get_ring_osc_en_ctrl
        get_ring_osc_en_ctrl = read_ring_osc_en_ctrl_value
    End Property

    Property Let set_ring_osc_en_ctrl(aData)
        write_ring_osc_en_ctrl_value = aData
        flag_ring_osc_en_ctrl        = &H1
    End Property

    Property Get read_ring_osc_en_ctrl
        read
        read_ring_osc_en_ctrl = read_ring_osc_en_ctrl_value
    End Property

    Property Let write_ring_osc_en_ctrl(aData)
        set_ring_osc_en_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ring_osc_output_en_value = rightShift(data_low, 12) and &H1
        ring_osc_en_ctrl_mask = &Hfff
        if data_low > LONG_MAX then
            if ring_osc_en_ctrl_mask = mask then
                read_ring_osc_en_ctrl_value = data_low
            else
                read_ring_osc_en_ctrl_value = (data_low - H8000_0000) and ring_osc_en_ctrl_mask
            end If
        else
            read_ring_osc_en_ctrl_value = data_low and ring_osc_en_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_ring_osc_output_en = &H0 or flag_ring_osc_en_ctrl = &H0 Then read
        If flag_ring_osc_output_en = &H0 Then write_ring_osc_output_en_value = get_ring_osc_output_en
        If flag_ring_osc_en_ctrl = &H0 Then write_ring_osc_en_ctrl_value = get_ring_osc_en_ctrl

        regValue = leftShift((write_ring_osc_output_en_value and &H1), 12) + leftShift((write_ring_osc_en_ctrl_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ring_osc_output_en_value = rightShift(data_low, 12) and &H1
        ring_osc_en_ctrl_mask = &Hfff
        if data_low > LONG_MAX then
            if ring_osc_en_ctrl_mask = mask then
                read_ring_osc_en_ctrl_value = data_low
            else
                read_ring_osc_en_ctrl_value = (data_low - H8000_0000) and ring_osc_en_ctrl_mask
            end If
        else
            read_ring_osc_en_ctrl_value = data_low and ring_osc_en_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ring_osc_output_en_value = &H0
        flag_ring_osc_output_en        = &H0
        write_ring_osc_en_ctrl_value = &H0
        flag_ring_osc_en_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : MISC_scratch_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch                                    [15:0]           get_scratch
''                                                             set_scratch
''                                                             read_scratch
''                                                             write_scratch
''---------------------------------------------------------------------------------
Class REGISTER_MISC_scratch_reg
    Private write_scratch_value
    Private read_scratch_value
    Private flag_scratch

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_scratch
        get_scratch = read_scratch_value
    End Property

    Property Let set_scratch(aData)
        write_scratch_value = aData
        flag_scratch        = &H1
    End Property

    Property Get read_scratch
        read
        read_scratch = read_scratch_value
    End Property

    Property Let write_scratch(aData)
        set_scratch = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_mask = &Hffff
        if data_low > LONG_MAX then
            if scratch_mask = mask then
                read_scratch_value = data_low
            else
                read_scratch_value = (data_low - H8000_0000) and scratch_mask
            end If
        else
            read_scratch_value = data_low and scratch_mask
        end If

    End Sub

    Sub write
        If flag_scratch = &H0 Then read
        If flag_scratch = &H0 Then write_scratch_value = get_scratch

        regValue = leftShift((write_scratch_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_mask = &Hffff
        if data_low > LONG_MAX then
            if scratch_mask = mask then
                read_scratch_value = data_low
            else
                read_scratch_value = (data_low - H8000_0000) and scratch_mask
            end If
        else
            read_scratch_value = data_low and scratch_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_value = &H0
        flag_scratch        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class MISC_INSTANCE

    Public model_rev_num
    Public deviceid_lo
    Public deviceid_hi
    Public switch_misc_ctrl
    Public ldo_pwrdn
    Public ldo_vregcntl_1
    Public ldo_vregcntl_2
    Public ldo_vregcntlen
    Public swreg_ctrl_reg0
    Public swreg_ctrl_reg1
    Public swreg_ctrl_reg2
    Public swreg_ctrl_reg3
    Public swreg_ctrl_reg4
    Public swreg_ctrl_reg5
    Public swreg_ctrl_reg6
    Public swreg_ctrl_reg7
    Public swreg_ctrl_reg8
    Public swreg_ctrl_reg9
    Public swreg_stat_reg12
    Public swreg_stat_reg13
    Public swreg_stat_reg14
    Public swreg_stat_reg15
    Public swreg_access_ctrl_1
    Public swreg_access_ctrl_2
    Public swreg_control_status
    Public sgmii_plus2_pwrdwn
    Public sgmii_plus2_hw_rst_dly_val
    Public sgmii_plus2_mdio_rst_dly_val
    Public sgmii_plus2_pll_rst_dly_val
    Public sgmii_plus2_ext_ctl
    Public sgmii_plus2_mdio_ctl
    Public sgmii_plus2_status
    Public sgmii_pcie_pwrdwn
    Public sgmii_pcie_hw_rst_dly_val
    Public sgmii_pcie_mdio_rst_dly_val
    Public sgmii_pcie_pll_rst_dly_val
    Public sgmii_pcie_ext_ctl
    Public sgmii_pcie_mdio_ctl
    Public sgmii_pcie_status
    Public sgmii_afe_status
    Public sgmii_plusr_pwrdwn
    Public sgmii_plusr_hw_rst_dly_val
    Public sgmii_plusr_pll_rst_dly_val
    Public sgmii_plusr_ext_ctl
    Public sgmii_plusr_mdio_ctl
    Public sgmii_plusr_status
    Public pvtmon_ctrl
    Public pvtmon_sample_num
    Public pvtmon_tmon_period
    Public pvtmon_i_ctrl_31_16
    Public pvtmon_i_ctrl_15_0
    Public pvtmon_adc_data
    Public pvtmon_dac_data
    Public pvtmon_tmon_thresh1_ctrl
    Public pvtmon_tmon_thresh2_ctrl
    Public pvtmon_vmon_1v_h_thresh1_ctrl
    Public pvtmon_vmon_1v_h_thresh2_ctrl
    Public pvtmon_vmon_1v_l_thresh1_ctrl
    Public pvtmon_vmon_1v_l_thresh2_ctrl
    Public pvtmon_vmon_1p8v_h_thresh1_ctrl
    Public pvtmon_vmon_1p8v_h_thresh2_ctrl
    Public pvtmon_vmon_1p8v_l_thresh1_ctrl
    Public pvtmon_vmon_1p8v_l_thresh2_ctrl
    Public pvtmon_vmon_3p3v_h_thresh1_ctrl
    Public pvtmon_vmon_3p3v_h_thresh2_ctrl
    Public pvtmon_vmon_3p3v_l_thresh1_ctrl
    Public pvtmon_vmon_3p3v_l_thresh2_ctrl
    Public pvtmon_threshold_filter
    Public pvtmon_viol_rawsts
    Public pvtmon_intr_status
    Public pvtmon_intsts_clear
    Public pvtmon_interrupt_count
    Public pvtmon_tmon_sample
    Public pvtmon_vmon_1v_sample
    Public pvtmon_vmon_1p8v_sample
    Public pvtmon_vmon_3p3v_sample
    Public f1_image_status
    Public f1_image_version
    Public f2_image_status
    Public f2_image_version
    Public spare_hw_reg4
    Public spare_hw_reg5
    Public spare_hw_reg6
    Public spare_hw_reg7
    Public spare_hw_reg8
    Public spare_hw_reg9
    Public f1_version
    Public spare_hw_reg11
    Public pkg_model
    Public spare_hw_reg13
    Public spare_hw_reg14
    Public spare_hw_reg15
    Public spare_sw_reg0
    Public spare_sw_reg1
    Public spare_sw_reg2
    Public spare_sw_reg3
    Public spare_sw_reg4
    Public spare_sw_reg5
    Public spare_sw_reg6
    Public spare_sw_reg7
    Public spare_sw_reg8
    Public spare_sw_reg9
    Public spare_sw_reg10
    Public spare_sw_reg11
    Public spare_sw_reg12
    Public spare_sw_reg13
    Public spare_sw_reg14
    Public spare_sw_reg15
    Public cpusys_misc
    Public brphys_misc
    Public brphys_tc10_ctrl_reg
    Public brphys_tc10_status_reg
    Public ring_osc_sel_ctrl_reg
    Public ring_osc_en_ctrl_reg
    Public scratch_reg


    Public default function Init(aBaseAddr)
        Set model_rev_num = (New REGISTER_MISC_model_rev_num)(aBaseAddr, 16)
        Set deviceid_lo = (New REGISTER_MISC_deviceid_lo)(aBaseAddr, 16)
        Set deviceid_hi = (New REGISTER_MISC_deviceid_hi)(aBaseAddr, 16)
        Set switch_misc_ctrl = (New REGISTER_MISC_switch_misc_ctrl)(aBaseAddr, 16)
        Set ldo_pwrdn = (New REGISTER_MISC_ldo_pwrdn)(aBaseAddr, 16)
        Set ldo_vregcntl_1 = (New REGISTER_MISC_ldo_vregcntl_1)(aBaseAddr, 16)
        Set ldo_vregcntl_2 = (New REGISTER_MISC_ldo_vregcntl_2)(aBaseAddr, 16)
        Set ldo_vregcntlen = (New REGISTER_MISC_ldo_vregcntlen)(aBaseAddr, 16)
        Set swreg_ctrl_reg0 = (New REGISTER_MISC_swreg_ctrl_reg0)(aBaseAddr, 16)
        Set swreg_ctrl_reg1 = (New REGISTER_MISC_swreg_ctrl_reg1)(aBaseAddr, 16)
        Set swreg_ctrl_reg2 = (New REGISTER_MISC_swreg_ctrl_reg2)(aBaseAddr, 16)
        Set swreg_ctrl_reg3 = (New REGISTER_MISC_swreg_ctrl_reg3)(aBaseAddr, 16)
        Set swreg_ctrl_reg4 = (New REGISTER_MISC_swreg_ctrl_reg4)(aBaseAddr, 16)
        Set swreg_ctrl_reg5 = (New REGISTER_MISC_swreg_ctrl_reg5)(aBaseAddr, 16)
        Set swreg_ctrl_reg6 = (New REGISTER_MISC_swreg_ctrl_reg6)(aBaseAddr, 16)
        Set swreg_ctrl_reg7 = (New REGISTER_MISC_swreg_ctrl_reg7)(aBaseAddr, 16)
        Set swreg_ctrl_reg8 = (New REGISTER_MISC_swreg_ctrl_reg8)(aBaseAddr, 16)
        Set swreg_ctrl_reg9 = (New REGISTER_MISC_swreg_ctrl_reg9)(aBaseAddr, 16)
        Set swreg_stat_reg12 = (New REGISTER_MISC_swreg_stat_reg12)(aBaseAddr, 16)
        Set swreg_stat_reg13 = (New REGISTER_MISC_swreg_stat_reg13)(aBaseAddr, 16)
        Set swreg_stat_reg14 = (New REGISTER_MISC_swreg_stat_reg14)(aBaseAddr, 16)
        Set swreg_stat_reg15 = (New REGISTER_MISC_swreg_stat_reg15)(aBaseAddr, 16)
        Set swreg_access_ctrl_1 = (New REGISTER_MISC_swreg_access_ctrl_1)(aBaseAddr, 16)
        Set swreg_access_ctrl_2 = (New REGISTER_MISC_swreg_access_ctrl_2)(aBaseAddr, 16)
        Set swreg_control_status = (New REGISTER_MISC_swreg_control_status)(aBaseAddr, 16)
        Set sgmii_plus2_pwrdwn = (New REGISTER_MISC_sgmii_plus2_pwrdwn)(aBaseAddr, 16)
        Set sgmii_plus2_hw_rst_dly_val = (New REGISTER_MISC_sgmii_plus2_hw_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_plus2_mdio_rst_dly_val = (New REGISTER_MISC_sgmii_plus2_mdio_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_plus2_pll_rst_dly_val = (New REGISTER_MISC_sgmii_plus2_pll_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_plus2_ext_ctl = (New REGISTER_MISC_sgmii_plus2_ext_ctl)(aBaseAddr, 16)
        Set sgmii_plus2_mdio_ctl = (New REGISTER_MISC_sgmii_plus2_mdio_ctl)(aBaseAddr, 16)
        Set sgmii_plus2_status = (New REGISTER_MISC_sgmii_plus2_status)(aBaseAddr, 16)
        Set sgmii_pcie_pwrdwn = (New REGISTER_MISC_sgmii_pcie_pwrdwn)(aBaseAddr, 16)
        Set sgmii_pcie_hw_rst_dly_val = (New REGISTER_MISC_sgmii_pcie_hw_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_pcie_mdio_rst_dly_val = (New REGISTER_MISC_sgmii_pcie_mdio_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_pcie_pll_rst_dly_val = (New REGISTER_MISC_sgmii_pcie_pll_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_pcie_ext_ctl = (New REGISTER_MISC_sgmii_pcie_ext_ctl)(aBaseAddr, 16)
        Set sgmii_pcie_mdio_ctl = (New REGISTER_MISC_sgmii_pcie_mdio_ctl)(aBaseAddr, 16)
        Set sgmii_pcie_status = (New REGISTER_MISC_sgmii_pcie_status)(aBaseAddr, 16)
        Set sgmii_afe_status = (New REGISTER_MISC_sgmii_afe_status)(aBaseAddr, 16)
        Set sgmii_plusr_pwrdwn = (New REGISTER_MISC_sgmii_plusr_pwrdwn)(aBaseAddr, 16)
        Set sgmii_plusr_hw_rst_dly_val = (New REGISTER_MISC_sgmii_plusr_hw_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_plusr_pll_rst_dly_val = (New REGISTER_MISC_sgmii_plusr_pll_rst_dly_val)(aBaseAddr, 16)
        Set sgmii_plusr_ext_ctl = (New REGISTER_MISC_sgmii_plusr_ext_ctl)(aBaseAddr, 16)
        Set sgmii_plusr_mdio_ctl = (New REGISTER_MISC_sgmii_plusr_mdio_ctl)(aBaseAddr, 16)
        Set sgmii_plusr_status = (New REGISTER_MISC_sgmii_plusr_status)(aBaseAddr, 16)
        Set pvtmon_ctrl = (New REGISTER_MISC_pvtmon_ctrl)(aBaseAddr, 16)
        Set pvtmon_sample_num = (New REGISTER_MISC_pvtmon_sample_num)(aBaseAddr, 16)
        Set pvtmon_tmon_period = (New REGISTER_MISC_pvtmon_tmon_period)(aBaseAddr, 16)
        Set pvtmon_i_ctrl_31_16 = (New REGISTER_MISC_pvtmon_i_ctrl_31_16)(aBaseAddr, 16)
        Set pvtmon_i_ctrl_15_0 = (New REGISTER_MISC_pvtmon_i_ctrl_15_0)(aBaseAddr, 16)
        Set pvtmon_adc_data = (New REGISTER_MISC_pvtmon_adc_data)(aBaseAddr, 16)
        Set pvtmon_dac_data = (New REGISTER_MISC_pvtmon_dac_data)(aBaseAddr, 16)
        Set pvtmon_tmon_thresh1_ctrl = (New REGISTER_MISC_pvtmon_tmon_thresh1_ctrl)(aBaseAddr, 16)
        Set pvtmon_tmon_thresh2_ctrl = (New REGISTER_MISC_pvtmon_tmon_thresh2_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1v_h_thresh1_ctrl = (New REGISTER_MISC_pvtmon_vmon_1v_h_thresh1_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1v_h_thresh2_ctrl = (New REGISTER_MISC_pvtmon_vmon_1v_h_thresh2_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1v_l_thresh1_ctrl = (New REGISTER_MISC_pvtmon_vmon_1v_l_thresh1_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1v_l_thresh2_ctrl = (New REGISTER_MISC_pvtmon_vmon_1v_l_thresh2_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1p8v_h_thresh1_ctrl = (New REGISTER_MISC_pvtmon_vmon_1p8v_h_thresh1_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1p8v_h_thresh2_ctrl = (New REGISTER_MISC_pvtmon_vmon_1p8v_h_thresh2_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1p8v_l_thresh1_ctrl = (New REGISTER_MISC_pvtmon_vmon_1p8v_l_thresh1_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_1p8v_l_thresh2_ctrl = (New REGISTER_MISC_pvtmon_vmon_1p8v_l_thresh2_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_3p3v_h_thresh1_ctrl = (New REGISTER_MISC_pvtmon_vmon_3p3v_h_thresh1_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_3p3v_h_thresh2_ctrl = (New REGISTER_MISC_pvtmon_vmon_3p3v_h_thresh2_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_3p3v_l_thresh1_ctrl = (New REGISTER_MISC_pvtmon_vmon_3p3v_l_thresh1_ctrl)(aBaseAddr, 16)
        Set pvtmon_vmon_3p3v_l_thresh2_ctrl = (New REGISTER_MISC_pvtmon_vmon_3p3v_l_thresh2_ctrl)(aBaseAddr, 16)
        Set pvtmon_threshold_filter = (New REGISTER_MISC_pvtmon_threshold_filter)(aBaseAddr, 16)
        Set pvtmon_viol_rawsts = (New REGISTER_MISC_pvtmon_viol_rawsts)(aBaseAddr, 16)
        Set pvtmon_intr_status = (New REGISTER_MISC_pvtmon_intr_status)(aBaseAddr, 16)
        Set pvtmon_intsts_clear = (New REGISTER_MISC_pvtmon_intsts_clear)(aBaseAddr, 16)
        Set pvtmon_interrupt_count = (New REGISTER_MISC_pvtmon_interrupt_count)(aBaseAddr, 16)
        Set pvtmon_tmon_sample = (New REGISTER_MISC_pvtmon_tmon_sample)(aBaseAddr, 16)
        Set pvtmon_vmon_1v_sample = (New REGISTER_MISC_pvtmon_vmon_1v_sample)(aBaseAddr, 16)
        Set pvtmon_vmon_1p8v_sample = (New REGISTER_MISC_pvtmon_vmon_1p8v_sample)(aBaseAddr, 16)
        Set pvtmon_vmon_3p3v_sample = (New REGISTER_MISC_pvtmon_vmon_3p3v_sample)(aBaseAddr, 16)
        Set f1_image_status = (New REGISTER_MISC_f1_image_status)(aBaseAddr, 16)
        Set f1_image_version = (New REGISTER_MISC_f1_image_version)(aBaseAddr, 16)
        Set f2_image_status = (New REGISTER_MISC_f2_image_status)(aBaseAddr, 16)
        Set f2_image_version = (New REGISTER_MISC_f2_image_version)(aBaseAddr, 16)
        Set spare_hw_reg4 = (New REGISTER_MISC_spare_hw_reg4)(aBaseAddr, 16)
        Set spare_hw_reg5 = (New REGISTER_MISC_spare_hw_reg5)(aBaseAddr, 16)
        Set spare_hw_reg6 = (New REGISTER_MISC_spare_hw_reg6)(aBaseAddr, 16)
        Set spare_hw_reg7 = (New REGISTER_MISC_spare_hw_reg7)(aBaseAddr, 16)
        Set spare_hw_reg8 = (New REGISTER_MISC_spare_hw_reg8)(aBaseAddr, 16)
        Set spare_hw_reg9 = (New REGISTER_MISC_spare_hw_reg9)(aBaseAddr, 16)
        Set f1_version = (New REGISTER_MISC_f1_version)(aBaseAddr, 16)
        Set spare_hw_reg11 = (New REGISTER_MISC_spare_hw_reg11)(aBaseAddr, 16)
        Set pkg_model = (New REGISTER_MISC_pkg_model)(aBaseAddr, 16)
        Set spare_hw_reg13 = (New REGISTER_MISC_spare_hw_reg13)(aBaseAddr, 16)
        Set spare_hw_reg14 = (New REGISTER_MISC_spare_hw_reg14)(aBaseAddr, 16)
        Set spare_hw_reg15 = (New REGISTER_MISC_spare_hw_reg15)(aBaseAddr, 16)
        Set spare_sw_reg0 = (New REGISTER_MISC_spare_sw_reg0)(aBaseAddr, 16)
        Set spare_sw_reg1 = (New REGISTER_MISC_spare_sw_reg1)(aBaseAddr, 16)
        Set spare_sw_reg2 = (New REGISTER_MISC_spare_sw_reg2)(aBaseAddr, 16)
        Set spare_sw_reg3 = (New REGISTER_MISC_spare_sw_reg3)(aBaseAddr, 16)
        Set spare_sw_reg4 = (New REGISTER_MISC_spare_sw_reg4)(aBaseAddr, 16)
        Set spare_sw_reg5 = (New REGISTER_MISC_spare_sw_reg5)(aBaseAddr, 16)
        Set spare_sw_reg6 = (New REGISTER_MISC_spare_sw_reg6)(aBaseAddr, 16)
        Set spare_sw_reg7 = (New REGISTER_MISC_spare_sw_reg7)(aBaseAddr, 16)
        Set spare_sw_reg8 = (New REGISTER_MISC_spare_sw_reg8)(aBaseAddr, 16)
        Set spare_sw_reg9 = (New REGISTER_MISC_spare_sw_reg9)(aBaseAddr, 16)
        Set spare_sw_reg10 = (New REGISTER_MISC_spare_sw_reg10)(aBaseAddr, 16)
        Set spare_sw_reg11 = (New REGISTER_MISC_spare_sw_reg11)(aBaseAddr, 16)
        Set spare_sw_reg12 = (New REGISTER_MISC_spare_sw_reg12)(aBaseAddr, 16)
        Set spare_sw_reg13 = (New REGISTER_MISC_spare_sw_reg13)(aBaseAddr, 16)
        Set spare_sw_reg14 = (New REGISTER_MISC_spare_sw_reg14)(aBaseAddr, 16)
        Set spare_sw_reg15 = (New REGISTER_MISC_spare_sw_reg15)(aBaseAddr, 16)
        Set cpusys_misc = (New REGISTER_MISC_cpusys_misc)(aBaseAddr, 16)
        Set brphys_misc = (New REGISTER_MISC_brphys_misc)(aBaseAddr, 16)
        Set brphys_tc10_ctrl_reg = (New REGISTER_MISC_brphys_tc10_ctrl_reg)(aBaseAddr, 16)
        Set brphys_tc10_status_reg = (New REGISTER_MISC_brphys_tc10_status_reg)(aBaseAddr, 16)
        Set ring_osc_sel_ctrl_reg = (New REGISTER_MISC_ring_osc_sel_ctrl_reg)(aBaseAddr, 16)
        Set ring_osc_en_ctrl_reg = (New REGISTER_MISC_ring_osc_en_ctrl_reg)(aBaseAddr, 16)
        Set scratch_reg = (New REGISTER_MISC_scratch_reg)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set MISC = CreateObject("System.Collections.ArrayList")
MISC.Add ((New MISC_INSTANCE)(&H4a800000))


