

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


'' @REGISTER : PLL2__SGMIIPLUS2_X2_stat0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vco_range                                  [12:6]           get_vco_range
''                                                             set_vco_range
''                                                             read_vco_range
''                                                             write_vco_range
''---------------------------------------------------------------------------------
'' cal_state                                  [5:2]            get_cal_state
''                                                             set_cal_state
''                                                             read_cal_state
''                                                             write_cal_state
''---------------------------------------------------------------------------------
'' cal_valid                                  [1:1]            get_cal_valid
''                                                             set_cal_valid
''                                                             read_cal_valid
''                                                             write_cal_valid
''---------------------------------------------------------------------------------
'' cal_error                                  [0:0]            get_cal_error
''                                                             set_cal_error
''                                                             read_cal_error
''                                                             write_cal_error
''---------------------------------------------------------------------------------
Class REGISTER_PLL2__SGMIIPLUS2_X2_stat0
    Private write_vco_range_value
    Private read_vco_range_value
    Private flag_vco_range
    Private write_cal_state_value
    Private read_cal_state_value
    Private flag_cal_state
    Private write_cal_valid_value
    Private read_cal_valid_value
    Private flag_cal_valid
    Private write_cal_error_value
    Private read_cal_error_value
    Private flag_cal_error

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

    Property Get get_vco_range
        get_vco_range = read_vco_range_value
    End Property

    Property Let set_vco_range(aData)
        write_vco_range_value = aData
        flag_vco_range        = &H1
    End Property

    Property Get read_vco_range
        read
        read_vco_range = read_vco_range_value
    End Property

    Property Let write_vco_range(aData)
        set_vco_range = aData
        write
    End Property

    Property Get get_cal_state
        get_cal_state = read_cal_state_value
    End Property

    Property Let set_cal_state(aData)
        write_cal_state_value = aData
        flag_cal_state        = &H1
    End Property

    Property Get read_cal_state
        read
        read_cal_state = read_cal_state_value
    End Property

    Property Let write_cal_state(aData)
        set_cal_state = aData
        write
    End Property

    Property Get get_cal_valid
        get_cal_valid = read_cal_valid_value
    End Property

    Property Let set_cal_valid(aData)
        write_cal_valid_value = aData
        flag_cal_valid        = &H1
    End Property

    Property Get read_cal_valid
        read
        read_cal_valid = read_cal_valid_value
    End Property

    Property Let write_cal_valid(aData)
        set_cal_valid = aData
        write
    End Property

    Property Get get_cal_error
        get_cal_error = read_cal_error_value
    End Property

    Property Let set_cal_error(aData)
        write_cal_error_value = aData
        flag_cal_error        = &H1
    End Property

    Property Get read_cal_error
        read
        read_cal_error = read_cal_error_value
    End Property

    Property Let write_cal_error(aData)
        set_cal_error = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vco_range_value = rightShift(data_low, 6) and &H7f
        read_cal_state_value = rightShift(data_low, 2) and &Hf
        read_cal_valid_value = rightShift(data_low, 1) and &H1
        cal_error_mask = &H1
        if data_low > LONG_MAX then
            if cal_error_mask = mask then
                read_cal_error_value = data_low
            else
                read_cal_error_value = (data_low - H8000_0000) and cal_error_mask
            end If
        else
            read_cal_error_value = data_low and cal_error_mask
        end If

    End Sub

    Sub write
        If flag_vco_range = &H0 or flag_cal_state = &H0 or flag_cal_valid = &H0 or flag_cal_error = &H0 Then read
        If flag_vco_range = &H0 Then write_vco_range_value = get_vco_range
        If flag_cal_state = &H0 Then write_cal_state_value = get_cal_state
        If flag_cal_valid = &H0 Then write_cal_valid_value = get_cal_valid
        If flag_cal_error = &H0 Then write_cal_error_value = get_cal_error

        regValue = leftShift((write_vco_range_value and &H7f), 6) + leftShift((write_cal_state_value and &Hf), 2) + leftShift((write_cal_valid_value and &H1), 1) + leftShift((write_cal_error_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vco_range_value = rightShift(data_low, 6) and &H7f
        read_cal_state_value = rightShift(data_low, 2) and &Hf
        read_cal_valid_value = rightShift(data_low, 1) and &H1
        cal_error_mask = &H1
        if data_low > LONG_MAX then
            if cal_error_mask = mask then
                read_cal_error_value = data_low
            else
                read_cal_error_value = (data_low - H8000_0000) and cal_error_mask
            end If
        else
            read_cal_error_value = data_low and cal_error_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vco_range_value = &H0
        flag_vco_range        = &H0
        write_cal_state_value = &H0
        flag_cal_state        = &H0
        write_cal_valid_value = &H0
        flag_cal_valid        = &H0
        write_cal_error_value = &H0
        flag_cal_error        = &H0
    End Sub
End Class


'' @REGISTER : PLL2__SGMIIPLUS2_X2_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cal_th                                     [10:7]           get_cal_th
''                                                             set_cal_th
''                                                             read_cal_th
''                                                             write_cal_th
''---------------------------------------------------------------------------------
'' ext_range                                  [6:0]            get_ext_range
''                                                             set_ext_range
''                                                             read_ext_range
''                                                             write_ext_range
''---------------------------------------------------------------------------------
Class REGISTER_PLL2__SGMIIPLUS2_X2_ctrl1
    Private write_cal_th_value
    Private read_cal_th_value
    Private flag_cal_th
    Private write_ext_range_value
    Private read_ext_range_value
    Private flag_ext_range

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

    Property Get get_cal_th
        get_cal_th = read_cal_th_value
    End Property

    Property Let set_cal_th(aData)
        write_cal_th_value = aData
        flag_cal_th        = &H1
    End Property

    Property Get read_cal_th
        read
        read_cal_th = read_cal_th_value
    End Property

    Property Let write_cal_th(aData)
        set_cal_th = aData
        write
    End Property

    Property Get get_ext_range
        get_ext_range = read_ext_range_value
    End Property

    Property Let set_ext_range(aData)
        write_ext_range_value = aData
        flag_ext_range        = &H1
    End Property

    Property Get read_ext_range
        read
        read_ext_range = read_ext_range_value
    End Property

    Property Let write_ext_range(aData)
        set_ext_range = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_th_value = rightShift(data_low, 7) and &Hf
        ext_range_mask = &H7f
        if data_low > LONG_MAX then
            if ext_range_mask = mask then
                read_ext_range_value = data_low
            else
                read_ext_range_value = (data_low - H8000_0000) and ext_range_mask
            end If
        else
            read_ext_range_value = data_low and ext_range_mask
        end If

    End Sub

    Sub write
        If flag_cal_th = &H0 or flag_ext_range = &H0 Then read
        If flag_cal_th = &H0 Then write_cal_th_value = get_cal_th
        If flag_ext_range = &H0 Then write_ext_range_value = get_ext_range

        regValue = leftShift((write_cal_th_value and &Hf), 7) + leftShift((write_ext_range_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_th_value = rightShift(data_low, 7) and &Hf
        ext_range_mask = &H7f
        if data_low > LONG_MAX then
            if ext_range_mask = mask then
                read_ext_range_value = data_low
            else
                read_ext_range_value = (data_low - H8000_0000) and ext_range_mask
            end If
        else
            read_ext_range_value = data_low and ext_range_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cal_th_value = &H0
        flag_cal_th        = &H0
        write_ext_range_value = &H0
        flag_ext_range        = &H0
    End Sub
End Class


'' @REGISTER : PLL2__SGMIIPLUS2_X2_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' range_dfs                                  [14:8]           get_range_dfs
''                                                             set_range_dfs
''                                                             read_range_dfs
''                                                             write_range_dfs
''---------------------------------------------------------------------------------
'' range_ovrd                                 [7:7]            get_range_ovrd
''                                                             set_range_ovrd
''                                                             read_range_ovrd
''                                                             write_range_ovrd
''---------------------------------------------------------------------------------
'' range_ovrd_val                             [6:0]            get_range_ovrd_val
''                                                             set_range_ovrd_val
''                                                             read_range_ovrd_val
''                                                             write_range_ovrd_val
''---------------------------------------------------------------------------------
Class REGISTER_PLL2__SGMIIPLUS2_X2_ctrl2
    Private write_range_dfs_value
    Private read_range_dfs_value
    Private flag_range_dfs
    Private write_range_ovrd_value
    Private read_range_ovrd_value
    Private flag_range_ovrd
    Private write_range_ovrd_val_value
    Private read_range_ovrd_val_value
    Private flag_range_ovrd_val

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

    Property Get get_range_dfs
        get_range_dfs = read_range_dfs_value
    End Property

    Property Let set_range_dfs(aData)
        write_range_dfs_value = aData
        flag_range_dfs        = &H1
    End Property

    Property Get read_range_dfs
        read
        read_range_dfs = read_range_dfs_value
    End Property

    Property Let write_range_dfs(aData)
        set_range_dfs = aData
        write
    End Property

    Property Get get_range_ovrd
        get_range_ovrd = read_range_ovrd_value
    End Property

    Property Let set_range_ovrd(aData)
        write_range_ovrd_value = aData
        flag_range_ovrd        = &H1
    End Property

    Property Get read_range_ovrd
        read
        read_range_ovrd = read_range_ovrd_value
    End Property

    Property Let write_range_ovrd(aData)
        set_range_ovrd = aData
        write
    End Property

    Property Get get_range_ovrd_val
        get_range_ovrd_val = read_range_ovrd_val_value
    End Property

    Property Let set_range_ovrd_val(aData)
        write_range_ovrd_val_value = aData
        flag_range_ovrd_val        = &H1
    End Property

    Property Get read_range_ovrd_val
        read
        read_range_ovrd_val = read_range_ovrd_val_value
    End Property

    Property Let write_range_ovrd_val(aData)
        set_range_ovrd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_range_dfs_value = rightShift(data_low, 8) and &H7f
        read_range_ovrd_value = rightShift(data_low, 7) and &H1
        range_ovrd_val_mask = &H7f
        if data_low > LONG_MAX then
            if range_ovrd_val_mask = mask then
                read_range_ovrd_val_value = data_low
            else
                read_range_ovrd_val_value = (data_low - H8000_0000) and range_ovrd_val_mask
            end If
        else
            read_range_ovrd_val_value = data_low and range_ovrd_val_mask
        end If

    End Sub

    Sub write
        If flag_range_dfs = &H0 or flag_range_ovrd = &H0 or flag_range_ovrd_val = &H0 Then read
        If flag_range_dfs = &H0 Then write_range_dfs_value = get_range_dfs
        If flag_range_ovrd = &H0 Then write_range_ovrd_value = get_range_ovrd
        If flag_range_ovrd_val = &H0 Then write_range_ovrd_val_value = get_range_ovrd_val

        regValue = leftShift((write_range_dfs_value and &H7f), 8) + leftShift((write_range_ovrd_value and &H1), 7) + leftShift((write_range_ovrd_val_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_range_dfs_value = rightShift(data_low, 8) and &H7f
        read_range_ovrd_value = rightShift(data_low, 7) and &H1
        range_ovrd_val_mask = &H7f
        if data_low > LONG_MAX then
            if range_ovrd_val_mask = mask then
                read_range_ovrd_val_value = data_low
            else
                read_range_ovrd_val_value = (data_low - H8000_0000) and range_ovrd_val_mask
            end If
        else
            read_range_ovrd_val_value = data_low and range_ovrd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_range_dfs_value = &H0
        flag_range_dfs        = &H0
        write_range_ovrd_value = &H0
        flag_range_ovrd        = &H0
        write_range_ovrd_val_value = &H0
        flag_range_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : PLL2__SGMIIPLUS2_X2_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' calib_cap_charge_time                      [15:0]           get_calib_cap_charge_time
''                                                             set_calib_cap_charge_time
''                                                             read_calib_cap_charge_time
''                                                             write_calib_cap_charge_time
''---------------------------------------------------------------------------------
Class REGISTER_PLL2__SGMIIPLUS2_X2_ctrl3
    Private write_calib_cap_charge_time_value
    Private read_calib_cap_charge_time_value
    Private flag_calib_cap_charge_time

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

    Property Get get_calib_cap_charge_time
        get_calib_cap_charge_time = read_calib_cap_charge_time_value
    End Property

    Property Let set_calib_cap_charge_time(aData)
        write_calib_cap_charge_time_value = aData
        flag_calib_cap_charge_time        = &H1
    End Property

    Property Get read_calib_cap_charge_time
        read
        read_calib_cap_charge_time = read_calib_cap_charge_time_value
    End Property

    Property Let write_calib_cap_charge_time(aData)
        set_calib_cap_charge_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        calib_cap_charge_time_mask = &Hffff
        if data_low > LONG_MAX then
            if calib_cap_charge_time_mask = mask then
                read_calib_cap_charge_time_value = data_low
            else
                read_calib_cap_charge_time_value = (data_low - H8000_0000) and calib_cap_charge_time_mask
            end If
        else
            read_calib_cap_charge_time_value = data_low and calib_cap_charge_time_mask
        end If

    End Sub

    Sub write
        If flag_calib_cap_charge_time = &H0 Then read
        If flag_calib_cap_charge_time = &H0 Then write_calib_cap_charge_time_value = get_calib_cap_charge_time

        regValue = leftShift((write_calib_cap_charge_time_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        calib_cap_charge_time_mask = &Hffff
        if data_low > LONG_MAX then
            if calib_cap_charge_time_mask = mask then
                read_calib_cap_charge_time_value = data_low
            else
                read_calib_cap_charge_time_value = (data_low - H8000_0000) and calib_cap_charge_time_mask
            end If
        else
            read_calib_cap_charge_time_value = data_low and calib_cap_charge_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_calib_cap_charge_time_value = &H0
        flag_calib_cap_charge_time        = &H0
    End Sub
End Class


'' @REGISTER : PLL2__SGMIIPLUS2_X2_ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' calib_delay_time                           [15:0]           get_calib_delay_time
''                                                             set_calib_delay_time
''                                                             read_calib_delay_time
''                                                             write_calib_delay_time
''---------------------------------------------------------------------------------
Class REGISTER_PLL2__SGMIIPLUS2_X2_ctrl4
    Private write_calib_delay_time_value
    Private read_calib_delay_time_value
    Private flag_calib_delay_time

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

    Property Get get_calib_delay_time
        get_calib_delay_time = read_calib_delay_time_value
    End Property

    Property Let set_calib_delay_time(aData)
        write_calib_delay_time_value = aData
        flag_calib_delay_time        = &H1
    End Property

    Property Get read_calib_delay_time
        read
        read_calib_delay_time = read_calib_delay_time_value
    End Property

    Property Let write_calib_delay_time(aData)
        set_calib_delay_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        calib_delay_time_mask = &Hffff
        if data_low > LONG_MAX then
            if calib_delay_time_mask = mask then
                read_calib_delay_time_value = data_low
            else
                read_calib_delay_time_value = (data_low - H8000_0000) and calib_delay_time_mask
            end If
        else
            read_calib_delay_time_value = data_low and calib_delay_time_mask
        end If

    End Sub

    Sub write
        If flag_calib_delay_time = &H0 Then read
        If flag_calib_delay_time = &H0 Then write_calib_delay_time_value = get_calib_delay_time

        regValue = leftShift((write_calib_delay_time_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        calib_delay_time_mask = &Hffff
        if data_low > LONG_MAX then
            if calib_delay_time_mask = mask then
                read_calib_delay_time_value = data_low
            else
                read_calib_delay_time_value = (data_low - H8000_0000) and calib_delay_time_mask
            end If
        else
            read_calib_delay_time_value = data_low and calib_delay_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_calib_delay_time_value = &H0
        flag_calib_delay_time        = &H0
    End Sub
End Class


'' @REGISTER : PLL2__SGMIIPLUS2_X2_ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' calib_step_time                            [15:0]           get_calib_step_time
''                                                             set_calib_step_time
''                                                             read_calib_step_time
''                                                             write_calib_step_time
''---------------------------------------------------------------------------------
Class REGISTER_PLL2__SGMIIPLUS2_X2_ctrl5
    Private write_calib_step_time_value
    Private read_calib_step_time_value
    Private flag_calib_step_time

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

    Property Get get_calib_step_time
        get_calib_step_time = read_calib_step_time_value
    End Property

    Property Let set_calib_step_time(aData)
        write_calib_step_time_value = aData
        flag_calib_step_time        = &H1
    End Property

    Property Get read_calib_step_time
        read
        read_calib_step_time = read_calib_step_time_value
    End Property

    Property Let write_calib_step_time(aData)
        set_calib_step_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        calib_step_time_mask = &Hffff
        if data_low > LONG_MAX then
            if calib_step_time_mask = mask then
                read_calib_step_time_value = data_low
            else
                read_calib_step_time_value = (data_low - H8000_0000) and calib_step_time_mask
            end If
        else
            read_calib_step_time_value = data_low and calib_step_time_mask
        end If

    End Sub

    Sub write
        If flag_calib_step_time = &H0 Then read
        If flag_calib_step_time = &H0 Then write_calib_step_time_value = get_calib_step_time

        regValue = leftShift((write_calib_step_time_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        calib_step_time_mask = &Hffff
        if data_low > LONG_MAX then
            if calib_step_time_mask = mask then
                read_calib_step_time_value = data_low
            else
                read_calib_step_time_value = (data_low - H8000_0000) and calib_step_time_mask
            end If
        else
            read_calib_step_time_value = data_low and calib_step_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_calib_step_time_value = &H0
        flag_calib_step_time        = &H0
    End Sub
End Class


'' @REGISTER : PLL2__SGMIIPLUS2_X2_ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dfe0_en_calib_n                            [6:6]            get_dfe0_en_calib_n
''                                                             set_dfe0_en_calib_n
''                                                             read_dfe0_en_calib_n
''                                                             write_dfe0_en_calib_n
''---------------------------------------------------------------------------------
'' dfe0_halfstep_en                           [5:5]            get_dfe0_halfstep_en
''                                                             set_dfe0_halfstep_en
''                                                             read_dfe0_halfstep_en
''                                                             write_dfe0_halfstep_en
''---------------------------------------------------------------------------------
'' dfe0_calib_search_bit                      [4:2]            get_dfe0_calib_search_bit
''                                                             set_dfe0_calib_search_bit
''                                                             read_dfe0_calib_search_bit
''                                                             write_dfe0_calib_search_bit
''---------------------------------------------------------------------------------
'' dfe0_vcocal_valid_ovrd                     [1:1]            get_dfe0_vcocal_valid_ovrd
''                                                             set_dfe0_vcocal_valid_ovrd
''                                                             read_dfe0_vcocal_valid_ovrd
''                                                             write_dfe0_vcocal_valid_ovrd
''---------------------------------------------------------------------------------
'' dfe0_vcocal_valid_ovrd_val                 [0:0]            get_dfe0_vcocal_valid_ovrd_val
''                                                             set_dfe0_vcocal_valid_ovrd_val
''                                                             read_dfe0_vcocal_valid_ovrd_val
''                                                             write_dfe0_vcocal_valid_ovrd_val
''---------------------------------------------------------------------------------
Class REGISTER_PLL2__SGMIIPLUS2_X2_ctrl6
    Private write_dfe0_en_calib_n_value
    Private read_dfe0_en_calib_n_value
    Private flag_dfe0_en_calib_n
    Private write_dfe0_halfstep_en_value
    Private read_dfe0_halfstep_en_value
    Private flag_dfe0_halfstep_en
    Private write_dfe0_calib_search_bit_value
    Private read_dfe0_calib_search_bit_value
    Private flag_dfe0_calib_search_bit
    Private write_dfe0_vcocal_valid_ovrd_value
    Private read_dfe0_vcocal_valid_ovrd_value
    Private flag_dfe0_vcocal_valid_ovrd
    Private write_dfe0_vcocal_valid_ovrd_val_value
    Private read_dfe0_vcocal_valid_ovrd_val_value
    Private flag_dfe0_vcocal_valid_ovrd_val

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

    Property Get get_dfe0_en_calib_n
        get_dfe0_en_calib_n = read_dfe0_en_calib_n_value
    End Property

    Property Let set_dfe0_en_calib_n(aData)
        write_dfe0_en_calib_n_value = aData
        flag_dfe0_en_calib_n        = &H1
    End Property

    Property Get read_dfe0_en_calib_n
        read
        read_dfe0_en_calib_n = read_dfe0_en_calib_n_value
    End Property

    Property Let write_dfe0_en_calib_n(aData)
        set_dfe0_en_calib_n = aData
        write
    End Property

    Property Get get_dfe0_halfstep_en
        get_dfe0_halfstep_en = read_dfe0_halfstep_en_value
    End Property

    Property Let set_dfe0_halfstep_en(aData)
        write_dfe0_halfstep_en_value = aData
        flag_dfe0_halfstep_en        = &H1
    End Property

    Property Get read_dfe0_halfstep_en
        read
        read_dfe0_halfstep_en = read_dfe0_halfstep_en_value
    End Property

    Property Let write_dfe0_halfstep_en(aData)
        set_dfe0_halfstep_en = aData
        write
    End Property

    Property Get get_dfe0_calib_search_bit
        get_dfe0_calib_search_bit = read_dfe0_calib_search_bit_value
    End Property

    Property Let set_dfe0_calib_search_bit(aData)
        write_dfe0_calib_search_bit_value = aData
        flag_dfe0_calib_search_bit        = &H1
    End Property

    Property Get read_dfe0_calib_search_bit
        read
        read_dfe0_calib_search_bit = read_dfe0_calib_search_bit_value
    End Property

    Property Let write_dfe0_calib_search_bit(aData)
        set_dfe0_calib_search_bit = aData
        write
    End Property

    Property Get get_dfe0_vcocal_valid_ovrd
        get_dfe0_vcocal_valid_ovrd = read_dfe0_vcocal_valid_ovrd_value
    End Property

    Property Let set_dfe0_vcocal_valid_ovrd(aData)
        write_dfe0_vcocal_valid_ovrd_value = aData
        flag_dfe0_vcocal_valid_ovrd        = &H1
    End Property

    Property Get read_dfe0_vcocal_valid_ovrd
        read
        read_dfe0_vcocal_valid_ovrd = read_dfe0_vcocal_valid_ovrd_value
    End Property

    Property Let write_dfe0_vcocal_valid_ovrd(aData)
        set_dfe0_vcocal_valid_ovrd = aData
        write
    End Property

    Property Get get_dfe0_vcocal_valid_ovrd_val
        get_dfe0_vcocal_valid_ovrd_val = read_dfe0_vcocal_valid_ovrd_val_value
    End Property

    Property Let set_dfe0_vcocal_valid_ovrd_val(aData)
        write_dfe0_vcocal_valid_ovrd_val_value = aData
        flag_dfe0_vcocal_valid_ovrd_val        = &H1
    End Property

    Property Get read_dfe0_vcocal_valid_ovrd_val
        read
        read_dfe0_vcocal_valid_ovrd_val = read_dfe0_vcocal_valid_ovrd_val_value
    End Property

    Property Let write_dfe0_vcocal_valid_ovrd_val(aData)
        set_dfe0_vcocal_valid_ovrd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dfe0_en_calib_n_value = rightShift(data_low, 6) and &H1
        read_dfe0_halfstep_en_value = rightShift(data_low, 5) and &H1
        read_dfe0_calib_search_bit_value = rightShift(data_low, 2) and &H7
        read_dfe0_vcocal_valid_ovrd_value = rightShift(data_low, 1) and &H1
        dfe0_vcocal_valid_ovrd_val_mask = &H1
        if data_low > LONG_MAX then
            if dfe0_vcocal_valid_ovrd_val_mask = mask then
                read_dfe0_vcocal_valid_ovrd_val_value = data_low
            else
                read_dfe0_vcocal_valid_ovrd_val_value = (data_low - H8000_0000) and dfe0_vcocal_valid_ovrd_val_mask
            end If
        else
            read_dfe0_vcocal_valid_ovrd_val_value = data_low and dfe0_vcocal_valid_ovrd_val_mask
        end If

    End Sub

    Sub write
        If flag_dfe0_en_calib_n = &H0 or flag_dfe0_halfstep_en = &H0 or flag_dfe0_calib_search_bit = &H0 or flag_dfe0_vcocal_valid_ovrd = &H0 or flag_dfe0_vcocal_valid_ovrd_val = &H0 Then read
        If flag_dfe0_en_calib_n = &H0 Then write_dfe0_en_calib_n_value = get_dfe0_en_calib_n
        If flag_dfe0_halfstep_en = &H0 Then write_dfe0_halfstep_en_value = get_dfe0_halfstep_en
        If flag_dfe0_calib_search_bit = &H0 Then write_dfe0_calib_search_bit_value = get_dfe0_calib_search_bit
        If flag_dfe0_vcocal_valid_ovrd = &H0 Then write_dfe0_vcocal_valid_ovrd_value = get_dfe0_vcocal_valid_ovrd
        If flag_dfe0_vcocal_valid_ovrd_val = &H0 Then write_dfe0_vcocal_valid_ovrd_val_value = get_dfe0_vcocal_valid_ovrd_val

        regValue = leftShift((write_dfe0_en_calib_n_value and &H1), 6) + leftShift((write_dfe0_halfstep_en_value and &H1), 5) + leftShift((write_dfe0_calib_search_bit_value and &H7), 2) + leftShift((write_dfe0_vcocal_valid_ovrd_value and &H1), 1) + leftShift((write_dfe0_vcocal_valid_ovrd_val_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dfe0_en_calib_n_value = rightShift(data_low, 6) and &H1
        read_dfe0_halfstep_en_value = rightShift(data_low, 5) and &H1
        read_dfe0_calib_search_bit_value = rightShift(data_low, 2) and &H7
        read_dfe0_vcocal_valid_ovrd_value = rightShift(data_low, 1) and &H1
        dfe0_vcocal_valid_ovrd_val_mask = &H1
        if data_low > LONG_MAX then
            if dfe0_vcocal_valid_ovrd_val_mask = mask then
                read_dfe0_vcocal_valid_ovrd_val_value = data_low
            else
                read_dfe0_vcocal_valid_ovrd_val_value = (data_low - H8000_0000) and dfe0_vcocal_valid_ovrd_val_mask
            end If
        else
            read_dfe0_vcocal_valid_ovrd_val_value = data_low and dfe0_vcocal_valid_ovrd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dfe0_en_calib_n_value = &H0
        flag_dfe0_en_calib_n        = &H0
        write_dfe0_halfstep_en_value = &H0
        flag_dfe0_halfstep_en        = &H0
        write_dfe0_calib_search_bit_value = &H0
        flag_dfe0_calib_search_bit        = &H0
        write_dfe0_vcocal_valid_ovrd_value = &H0
        flag_dfe0_vcocal_valid_ovrd        = &H0
        write_dfe0_vcocal_valid_ovrd_val_value = &H0
        flag_dfe0_vcocal_valid_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : PLL2__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_PLL2__SGMIIPLUS2_X2_blockaddress
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

Class PLL2__SGMIIPLUS2_X2_INSTANCE

    Public stat0
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public ctrl4
    Public ctrl5
    Public ctrl6
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set stat0 = (New REGISTER_PLL2__SGMIIPLUS2_X2_stat0)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_PLL2__SGMIIPLUS2_X2_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_PLL2__SGMIIPLUS2_X2_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_PLL2__SGMIIPLUS2_X2_ctrl3)(aBaseAddr, 16)
        Set ctrl4 = (New REGISTER_PLL2__SGMIIPLUS2_X2_ctrl4)(aBaseAddr, 16)
        Set ctrl5 = (New REGISTER_PLL2__SGMIIPLUS2_X2_ctrl5)(aBaseAddr, 16)
        Set ctrl6 = (New REGISTER_PLL2__SGMIIPLUS2_X2_ctrl6)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_PLL2__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PLL2__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
PLL2__SGMIIPLUS2_X2.Add ((New PLL2__SGMIIPLUS2_X2_INSTANCE)(&H4ac50300))


