

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


'' @REGISTER : PLL_DFE0__SGMIIPCIE_X1_timer1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' anaPll_cap_charge                          [15:0]           get_anaPll_cap_charge
''                                                             set_anaPll_cap_charge
''                                                             read_anaPll_cap_charge
''                                                             write_anaPll_cap_charge
''---------------------------------------------------------------------------------
Class REGISTER_PLL_DFE0__SGMIIPCIE_X1_timer1
    Private write_anaPll_cap_charge_value
    Private read_anaPll_cap_charge_value
    Private flag_anaPll_cap_charge

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

    Property Get get_anaPll_cap_charge
        get_anaPll_cap_charge = read_anaPll_cap_charge_value
    End Property

    Property Let set_anaPll_cap_charge(aData)
        write_anaPll_cap_charge_value = aData
        flag_anaPll_cap_charge        = &H1
    End Property

    Property Get read_anaPll_cap_charge
        read
        read_anaPll_cap_charge = read_anaPll_cap_charge_value
    End Property

    Property Let write_anaPll_cap_charge(aData)
        set_anaPll_cap_charge = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPll_cap_charge_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPll_cap_charge_mask = mask then
                read_anaPll_cap_charge_value = data_low
            else
                read_anaPll_cap_charge_value = (data_low - H8000_0000) and anaPll_cap_charge_mask
            end If
        else
            read_anaPll_cap_charge_value = data_low and anaPll_cap_charge_mask
        end If

    End Sub

    Sub write
        If flag_anaPll_cap_charge = &H0 Then read
        If flag_anaPll_cap_charge = &H0 Then write_anaPll_cap_charge_value = get_anaPll_cap_charge

        regValue = leftShift((write_anaPll_cap_charge_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPll_cap_charge_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPll_cap_charge_mask = mask then
                read_anaPll_cap_charge_value = data_low
            else
                read_anaPll_cap_charge_value = (data_low - H8000_0000) and anaPll_cap_charge_mask
            end If
        else
            read_anaPll_cap_charge_value = data_low and anaPll_cap_charge_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_anaPll_cap_charge_value = &H0
        flag_anaPll_cap_charge        = &H0
    End Sub
End Class


'' @REGISTER : PLL_DFE0__SGMIIPCIE_X1_timer2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' anaPll_step_time                           [15:0]           get_anaPll_step_time
''                                                             set_anaPll_step_time
''                                                             read_anaPll_step_time
''                                                             write_anaPll_step_time
''---------------------------------------------------------------------------------
Class REGISTER_PLL_DFE0__SGMIIPCIE_X1_timer2
    Private write_anaPll_step_time_value
    Private read_anaPll_step_time_value
    Private flag_anaPll_step_time

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

    Property Get get_anaPll_step_time
        get_anaPll_step_time = read_anaPll_step_time_value
    End Property

    Property Let set_anaPll_step_time(aData)
        write_anaPll_step_time_value = aData
        flag_anaPll_step_time        = &H1
    End Property

    Property Get read_anaPll_step_time
        read
        read_anaPll_step_time = read_anaPll_step_time_value
    End Property

    Property Let write_anaPll_step_time(aData)
        set_anaPll_step_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPll_step_time_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPll_step_time_mask = mask then
                read_anaPll_step_time_value = data_low
            else
                read_anaPll_step_time_value = (data_low - H8000_0000) and anaPll_step_time_mask
            end If
        else
            read_anaPll_step_time_value = data_low and anaPll_step_time_mask
        end If

    End Sub

    Sub write
        If flag_anaPll_step_time = &H0 Then read
        If flag_anaPll_step_time = &H0 Then write_anaPll_step_time_value = get_anaPll_step_time

        regValue = leftShift((write_anaPll_step_time_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPll_step_time_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPll_step_time_mask = mask then
                read_anaPll_step_time_value = data_low
            else
                read_anaPll_step_time_value = (data_low - H8000_0000) and anaPll_step_time_mask
            end If
        else
            read_anaPll_step_time_value = data_low and anaPll_step_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_anaPll_step_time_value = &H0
        flag_anaPll_step_time        = &H0
    End Sub
End Class


'' @REGISTER : PLL_DFE0__SGMIIPCIE_X1_timer3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' anaPll_delay_time                          [15:0]           get_anaPll_delay_time
''                                                             set_anaPll_delay_time
''                                                             read_anaPll_delay_time
''                                                             write_anaPll_delay_time
''---------------------------------------------------------------------------------
Class REGISTER_PLL_DFE0__SGMIIPCIE_X1_timer3
    Private write_anaPll_delay_time_value
    Private read_anaPll_delay_time_value
    Private flag_anaPll_delay_time

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

    Property Get get_anaPll_delay_time
        get_anaPll_delay_time = read_anaPll_delay_time_value
    End Property

    Property Let set_anaPll_delay_time(aData)
        write_anaPll_delay_time_value = aData
        flag_anaPll_delay_time        = &H1
    End Property

    Property Get read_anaPll_delay_time
        read
        read_anaPll_delay_time = read_anaPll_delay_time_value
    End Property

    Property Let write_anaPll_delay_time(aData)
        set_anaPll_delay_time = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPll_delay_time_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPll_delay_time_mask = mask then
                read_anaPll_delay_time_value = data_low
            else
                read_anaPll_delay_time_value = (data_low - H8000_0000) and anaPll_delay_time_mask
            end If
        else
            read_anaPll_delay_time_value = data_low and anaPll_delay_time_mask
        end If

    End Sub

    Sub write
        If flag_anaPll_delay_time = &H0 Then read
        If flag_anaPll_delay_time = &H0 Then write_anaPll_delay_time_value = get_anaPll_delay_time

        regValue = leftShift((write_anaPll_delay_time_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        anaPll_delay_time_mask = &Hffff
        if data_low > LONG_MAX then
            if anaPll_delay_time_mask = mask then
                read_anaPll_delay_time_value = data_low
            else
                read_anaPll_delay_time_value = (data_low - H8000_0000) and anaPll_delay_time_mask
            end If
        else
            read_anaPll_delay_time_value = data_low and anaPll_delay_time_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_anaPll_delay_time_value = &H0
        flag_anaPll_delay_time        = &H0
    End Sub
End Class


'' @REGISTER : PLL_DFE0__SGMIIPCIE_X1_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ext_range                                  [14:8]           get_ext_range
''                                                             set_ext_range
''                                                             read_ext_range
''                                                             write_ext_range
''---------------------------------------------------------------------------------
'' pll_range_dfs                              [6:0]            get_pll_range_dfs
''                                                             set_pll_range_dfs
''                                                             read_pll_range_dfs
''                                                             write_pll_range_dfs
''---------------------------------------------------------------------------------
Class REGISTER_PLL_DFE0__SGMIIPCIE_X1_ctrl1
    Private write_ext_range_value
    Private read_ext_range_value
    Private flag_ext_range
    Private write_pll_range_dfs_value
    Private read_pll_range_dfs_value
    Private flag_pll_range_dfs

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

    Property Get get_pll_range_dfs
        get_pll_range_dfs = read_pll_range_dfs_value
    End Property

    Property Let set_pll_range_dfs(aData)
        write_pll_range_dfs_value = aData
        flag_pll_range_dfs        = &H1
    End Property

    Property Get read_pll_range_dfs
        read
        read_pll_range_dfs = read_pll_range_dfs_value
    End Property

    Property Let write_pll_range_dfs(aData)
        set_pll_range_dfs = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ext_range_value = rightShift(data_low, 8) and &H7f
        pll_range_dfs_mask = &H7f
        if data_low > LONG_MAX then
            if pll_range_dfs_mask = mask then
                read_pll_range_dfs_value = data_low
            else
                read_pll_range_dfs_value = (data_low - H8000_0000) and pll_range_dfs_mask
            end If
        else
            read_pll_range_dfs_value = data_low and pll_range_dfs_mask
        end If

    End Sub

    Sub write
        If flag_ext_range = &H0 or flag_pll_range_dfs = &H0 Then read
        If flag_ext_range = &H0 Then write_ext_range_value = get_ext_range
        If flag_pll_range_dfs = &H0 Then write_pll_range_dfs_value = get_pll_range_dfs

        regValue = leftShift((write_ext_range_value and &H7f), 8) + leftShift((write_pll_range_dfs_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ext_range_value = rightShift(data_low, 8) and &H7f
        pll_range_dfs_mask = &H7f
        if data_low > LONG_MAX then
            if pll_range_dfs_mask = mask then
                read_pll_range_dfs_value = data_low
            else
                read_pll_range_dfs_value = (data_low - H8000_0000) and pll_range_dfs_mask
            end If
        else
            read_pll_range_dfs_value = data_low and pll_range_dfs_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ext_range_value = &H0
        flag_ext_range        = &H0
        write_pll_range_dfs_value = &H0
        flag_pll_range_dfs        = &H0
    End Sub
End Class


'' @REGISTER : PLL_DFE0__SGMIIPCIE_X1_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vcocal_done_ovrd_val                       [15:15]          get_vcocal_done_ovrd_val
''                                                             set_vcocal_done_ovrd_val
''                                                             read_vcocal_done_ovrd_val
''                                                             write_vcocal_done_ovrd_val
''---------------------------------------------------------------------------------
'' vcocal_done_ovrd                           [14:14]          get_vcocal_done_ovrd
''                                                             set_vcocal_done_ovrd
''                                                             read_vcocal_done_ovrd
''                                                             write_vcocal_done_ovrd
''---------------------------------------------------------------------------------
'' halfstep_en                                [13:13]          get_halfstep_en
''                                                             set_halfstep_en
''                                                             read_halfstep_en
''                                                             write_halfstep_en
''---------------------------------------------------------------------------------
'' en_calib_n                                 [12:12]          get_en_calib_n
''                                                             set_en_calib_n
''                                                             read_en_calib_n
''                                                             write_en_calib_n
''---------------------------------------------------------------------------------
'' cal_th                                     [11:8]           get_cal_th
''                                                             set_cal_th
''                                                             read_cal_th
''                                                             write_cal_th
''---------------------------------------------------------------------------------
'' pll_range_ovrd                             [7:7]            get_pll_range_ovrd
''                                                             set_pll_range_ovrd
''                                                             read_pll_range_ovrd
''                                                             write_pll_range_ovrd
''---------------------------------------------------------------------------------
'' pll_range_ovrd_val                         [6:0]            get_pll_range_ovrd_val
''                                                             set_pll_range_ovrd_val
''                                                             read_pll_range_ovrd_val
''                                                             write_pll_range_ovrd_val
''---------------------------------------------------------------------------------
Class REGISTER_PLL_DFE0__SGMIIPCIE_X1_ctrl2
    Private write_vcocal_done_ovrd_val_value
    Private read_vcocal_done_ovrd_val_value
    Private flag_vcocal_done_ovrd_val
    Private write_vcocal_done_ovrd_value
    Private read_vcocal_done_ovrd_value
    Private flag_vcocal_done_ovrd
    Private write_halfstep_en_value
    Private read_halfstep_en_value
    Private flag_halfstep_en
    Private write_en_calib_n_value
    Private read_en_calib_n_value
    Private flag_en_calib_n
    Private write_cal_th_value
    Private read_cal_th_value
    Private flag_cal_th
    Private write_pll_range_ovrd_value
    Private read_pll_range_ovrd_value
    Private flag_pll_range_ovrd
    Private write_pll_range_ovrd_val_value
    Private read_pll_range_ovrd_val_value
    Private flag_pll_range_ovrd_val

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

    Property Get get_vcocal_done_ovrd_val
        get_vcocal_done_ovrd_val = read_vcocal_done_ovrd_val_value
    End Property

    Property Let set_vcocal_done_ovrd_val(aData)
        write_vcocal_done_ovrd_val_value = aData
        flag_vcocal_done_ovrd_val        = &H1
    End Property

    Property Get read_vcocal_done_ovrd_val
        read
        read_vcocal_done_ovrd_val = read_vcocal_done_ovrd_val_value
    End Property

    Property Let write_vcocal_done_ovrd_val(aData)
        set_vcocal_done_ovrd_val = aData
        write
    End Property

    Property Get get_vcocal_done_ovrd
        get_vcocal_done_ovrd = read_vcocal_done_ovrd_value
    End Property

    Property Let set_vcocal_done_ovrd(aData)
        write_vcocal_done_ovrd_value = aData
        flag_vcocal_done_ovrd        = &H1
    End Property

    Property Get read_vcocal_done_ovrd
        read
        read_vcocal_done_ovrd = read_vcocal_done_ovrd_value
    End Property

    Property Let write_vcocal_done_ovrd(aData)
        set_vcocal_done_ovrd = aData
        write
    End Property

    Property Get get_halfstep_en
        get_halfstep_en = read_halfstep_en_value
    End Property

    Property Let set_halfstep_en(aData)
        write_halfstep_en_value = aData
        flag_halfstep_en        = &H1
    End Property

    Property Get read_halfstep_en
        read
        read_halfstep_en = read_halfstep_en_value
    End Property

    Property Let write_halfstep_en(aData)
        set_halfstep_en = aData
        write
    End Property

    Property Get get_en_calib_n
        get_en_calib_n = read_en_calib_n_value
    End Property

    Property Let set_en_calib_n(aData)
        write_en_calib_n_value = aData
        flag_en_calib_n        = &H1
    End Property

    Property Get read_en_calib_n
        read
        read_en_calib_n = read_en_calib_n_value
    End Property

    Property Let write_en_calib_n(aData)
        set_en_calib_n = aData
        write
    End Property

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

    Property Get get_pll_range_ovrd
        get_pll_range_ovrd = read_pll_range_ovrd_value
    End Property

    Property Let set_pll_range_ovrd(aData)
        write_pll_range_ovrd_value = aData
        flag_pll_range_ovrd        = &H1
    End Property

    Property Get read_pll_range_ovrd
        read
        read_pll_range_ovrd = read_pll_range_ovrd_value
    End Property

    Property Let write_pll_range_ovrd(aData)
        set_pll_range_ovrd = aData
        write
    End Property

    Property Get get_pll_range_ovrd_val
        get_pll_range_ovrd_val = read_pll_range_ovrd_val_value
    End Property

    Property Let set_pll_range_ovrd_val(aData)
        write_pll_range_ovrd_val_value = aData
        flag_pll_range_ovrd_val        = &H1
    End Property

    Property Get read_pll_range_ovrd_val
        read
        read_pll_range_ovrd_val = read_pll_range_ovrd_val_value
    End Property

    Property Let write_pll_range_ovrd_val(aData)
        set_pll_range_ovrd_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vcocal_done_ovrd_val_value = rightShift(data_low, 15) and &H1
        read_vcocal_done_ovrd_value = rightShift(data_low, 14) and &H1
        read_halfstep_en_value = rightShift(data_low, 13) and &H1
        read_en_calib_n_value = rightShift(data_low, 12) and &H1
        read_cal_th_value = rightShift(data_low, 8) and &Hf
        read_pll_range_ovrd_value = rightShift(data_low, 7) and &H1
        pll_range_ovrd_val_mask = &H7f
        if data_low > LONG_MAX then
            if pll_range_ovrd_val_mask = mask then
                read_pll_range_ovrd_val_value = data_low
            else
                read_pll_range_ovrd_val_value = (data_low - H8000_0000) and pll_range_ovrd_val_mask
            end If
        else
            read_pll_range_ovrd_val_value = data_low and pll_range_ovrd_val_mask
        end If

    End Sub

    Sub write
        If flag_vcocal_done_ovrd_val = &H0 or flag_vcocal_done_ovrd = &H0 or flag_halfstep_en = &H0 or flag_en_calib_n = &H0 or flag_cal_th = &H0 or flag_pll_range_ovrd = &H0 or flag_pll_range_ovrd_val = &H0 Then read
        If flag_vcocal_done_ovrd_val = &H0 Then write_vcocal_done_ovrd_val_value = get_vcocal_done_ovrd_val
        If flag_vcocal_done_ovrd = &H0 Then write_vcocal_done_ovrd_value = get_vcocal_done_ovrd
        If flag_halfstep_en = &H0 Then write_halfstep_en_value = get_halfstep_en
        If flag_en_calib_n = &H0 Then write_en_calib_n_value = get_en_calib_n
        If flag_cal_th = &H0 Then write_cal_th_value = get_cal_th
        If flag_pll_range_ovrd = &H0 Then write_pll_range_ovrd_value = get_pll_range_ovrd
        If flag_pll_range_ovrd_val = &H0 Then write_pll_range_ovrd_val_value = get_pll_range_ovrd_val

        regValue = leftShift((write_vcocal_done_ovrd_val_value and &H1), 15) + leftShift((write_vcocal_done_ovrd_value and &H1), 14) + leftShift((write_halfstep_en_value and &H1), 13) + leftShift((write_en_calib_n_value and &H1), 12) + leftShift((write_cal_th_value and &Hf), 8) + leftShift((write_pll_range_ovrd_value and &H1), 7) + leftShift((write_pll_range_ovrd_val_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_vcocal_done_ovrd_val_value = rightShift(data_low, 15) and &H1
        read_vcocal_done_ovrd_value = rightShift(data_low, 14) and &H1
        read_halfstep_en_value = rightShift(data_low, 13) and &H1
        read_en_calib_n_value = rightShift(data_low, 12) and &H1
        read_cal_th_value = rightShift(data_low, 8) and &Hf
        read_pll_range_ovrd_value = rightShift(data_low, 7) and &H1
        pll_range_ovrd_val_mask = &H7f
        if data_low > LONG_MAX then
            if pll_range_ovrd_val_mask = mask then
                read_pll_range_ovrd_val_value = data_low
            else
                read_pll_range_ovrd_val_value = (data_low - H8000_0000) and pll_range_ovrd_val_mask
            end If
        else
            read_pll_range_ovrd_val_value = data_low and pll_range_ovrd_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vcocal_done_ovrd_val_value = &H0
        flag_vcocal_done_ovrd_val        = &H0
        write_vcocal_done_ovrd_value = &H0
        flag_vcocal_done_ovrd        = &H0
        write_halfstep_en_value = &H0
        flag_halfstep_en        = &H0
        write_en_calib_n_value = &H0
        flag_en_calib_n        = &H0
        write_cal_th_value = &H0
        flag_cal_th        = &H0
        write_pll_range_ovrd_value = &H0
        flag_pll_range_ovrd        = &H0
        write_pll_range_ovrd_val_value = &H0
        flag_pll_range_ovrd_val        = &H0
    End Sub
End Class


'' @REGISTER : PLL_DFE0__SGMIIPCIE_X1_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_testsel_refclk_ovrd_sel               [6:6]            get_mdio_testsel_refclk_ovrd_sel
''                                                             set_mdio_testsel_refclk_ovrd_sel
''                                                             read_mdio_testsel_refclk_ovrd_sel
''                                                             write_mdio_testsel_refclk_ovrd_sel
''---------------------------------------------------------------------------------
'' mdio_testsel_refclk_ovrd_val               [5:5]            get_mdio_testsel_refclk_ovrd_val
''                                                             set_mdio_testsel_refclk_ovrd_val
''                                                             read_mdio_testsel_refclk_ovrd_val
''                                                             write_mdio_testsel_refclk_ovrd_val
''---------------------------------------------------------------------------------
'' stop_recal                                 [4:4]            get_stop_recal
''                                                             set_stop_recal
''                                                             read_stop_recal
''                                                             write_stop_recal
''---------------------------------------------------------------------------------
'' mdio_vco_cal_err_ena                       [3:3]            get_mdio_vco_cal_err_ena
''                                                             set_mdio_vco_cal_err_ena
''                                                             read_mdio_vco_cal_err_ena
''                                                             write_mdio_vco_cal_err_ena
''---------------------------------------------------------------------------------
'' calib_search_bit                           [2:0]            get_calib_search_bit
''                                                             set_calib_search_bit
''                                                             read_calib_search_bit
''                                                             write_calib_search_bit
''---------------------------------------------------------------------------------
Class REGISTER_PLL_DFE0__SGMIIPCIE_X1_ctrl3
    Private write_mdio_testsel_refclk_ovrd_sel_value
    Private read_mdio_testsel_refclk_ovrd_sel_value
    Private flag_mdio_testsel_refclk_ovrd_sel
    Private write_mdio_testsel_refclk_ovrd_val_value
    Private read_mdio_testsel_refclk_ovrd_val_value
    Private flag_mdio_testsel_refclk_ovrd_val
    Private write_stop_recal_value
    Private read_stop_recal_value
    Private flag_stop_recal
    Private write_mdio_vco_cal_err_ena_value
    Private read_mdio_vco_cal_err_ena_value
    Private flag_mdio_vco_cal_err_ena
    Private write_calib_search_bit_value
    Private read_calib_search_bit_value
    Private flag_calib_search_bit

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

    Property Get get_mdio_testsel_refclk_ovrd_sel
        get_mdio_testsel_refclk_ovrd_sel = read_mdio_testsel_refclk_ovrd_sel_value
    End Property

    Property Let set_mdio_testsel_refclk_ovrd_sel(aData)
        write_mdio_testsel_refclk_ovrd_sel_value = aData
        flag_mdio_testsel_refclk_ovrd_sel        = &H1
    End Property

    Property Get read_mdio_testsel_refclk_ovrd_sel
        read
        read_mdio_testsel_refclk_ovrd_sel = read_mdio_testsel_refclk_ovrd_sel_value
    End Property

    Property Let write_mdio_testsel_refclk_ovrd_sel(aData)
        set_mdio_testsel_refclk_ovrd_sel = aData
        write
    End Property

    Property Get get_mdio_testsel_refclk_ovrd_val
        get_mdio_testsel_refclk_ovrd_val = read_mdio_testsel_refclk_ovrd_val_value
    End Property

    Property Let set_mdio_testsel_refclk_ovrd_val(aData)
        write_mdio_testsel_refclk_ovrd_val_value = aData
        flag_mdio_testsel_refclk_ovrd_val        = &H1
    End Property

    Property Get read_mdio_testsel_refclk_ovrd_val
        read
        read_mdio_testsel_refclk_ovrd_val = read_mdio_testsel_refclk_ovrd_val_value
    End Property

    Property Let write_mdio_testsel_refclk_ovrd_val(aData)
        set_mdio_testsel_refclk_ovrd_val = aData
        write
    End Property

    Property Get get_stop_recal
        get_stop_recal = read_stop_recal_value
    End Property

    Property Let set_stop_recal(aData)
        write_stop_recal_value = aData
        flag_stop_recal        = &H1
    End Property

    Property Get read_stop_recal
        read
        read_stop_recal = read_stop_recal_value
    End Property

    Property Let write_stop_recal(aData)
        set_stop_recal = aData
        write
    End Property

    Property Get get_mdio_vco_cal_err_ena
        get_mdio_vco_cal_err_ena = read_mdio_vco_cal_err_ena_value
    End Property

    Property Let set_mdio_vco_cal_err_ena(aData)
        write_mdio_vco_cal_err_ena_value = aData
        flag_mdio_vco_cal_err_ena        = &H1
    End Property

    Property Get read_mdio_vco_cal_err_ena
        read
        read_mdio_vco_cal_err_ena = read_mdio_vco_cal_err_ena_value
    End Property

    Property Let write_mdio_vco_cal_err_ena(aData)
        set_mdio_vco_cal_err_ena = aData
        write
    End Property

    Property Get get_calib_search_bit
        get_calib_search_bit = read_calib_search_bit_value
    End Property

    Property Let set_calib_search_bit(aData)
        write_calib_search_bit_value = aData
        flag_calib_search_bit        = &H1
    End Property

    Property Get read_calib_search_bit
        read
        read_calib_search_bit = read_calib_search_bit_value
    End Property

    Property Let write_calib_search_bit(aData)
        set_calib_search_bit = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_testsel_refclk_ovrd_sel_value = rightShift(data_low, 6) and &H1
        read_mdio_testsel_refclk_ovrd_val_value = rightShift(data_low, 5) and &H1
        read_stop_recal_value = rightShift(data_low, 4) and &H1
        read_mdio_vco_cal_err_ena_value = rightShift(data_low, 3) and &H1
        calib_search_bit_mask = &H7
        if data_low > LONG_MAX then
            if calib_search_bit_mask = mask then
                read_calib_search_bit_value = data_low
            else
                read_calib_search_bit_value = (data_low - H8000_0000) and calib_search_bit_mask
            end If
        else
            read_calib_search_bit_value = data_low and calib_search_bit_mask
        end If

    End Sub

    Sub write
        If flag_mdio_testsel_refclk_ovrd_sel = &H0 or flag_mdio_testsel_refclk_ovrd_val = &H0 or flag_stop_recal = &H0 or flag_mdio_vco_cal_err_ena = &H0 or flag_calib_search_bit = &H0 Then read
        If flag_mdio_testsel_refclk_ovrd_sel = &H0 Then write_mdio_testsel_refclk_ovrd_sel_value = get_mdio_testsel_refclk_ovrd_sel
        If flag_mdio_testsel_refclk_ovrd_val = &H0 Then write_mdio_testsel_refclk_ovrd_val_value = get_mdio_testsel_refclk_ovrd_val
        If flag_stop_recal = &H0 Then write_stop_recal_value = get_stop_recal
        If flag_mdio_vco_cal_err_ena = &H0 Then write_mdio_vco_cal_err_ena_value = get_mdio_vco_cal_err_ena
        If flag_calib_search_bit = &H0 Then write_calib_search_bit_value = get_calib_search_bit

        regValue = leftShift((write_mdio_testsel_refclk_ovrd_sel_value and &H1), 6) + leftShift((write_mdio_testsel_refclk_ovrd_val_value and &H1), 5) + leftShift((write_stop_recal_value and &H1), 4) + leftShift((write_mdio_vco_cal_err_ena_value and &H1), 3) + leftShift((write_calib_search_bit_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_testsel_refclk_ovrd_sel_value = rightShift(data_low, 6) and &H1
        read_mdio_testsel_refclk_ovrd_val_value = rightShift(data_low, 5) and &H1
        read_stop_recal_value = rightShift(data_low, 4) and &H1
        read_mdio_vco_cal_err_ena_value = rightShift(data_low, 3) and &H1
        calib_search_bit_mask = &H7
        if data_low > LONG_MAX then
            if calib_search_bit_mask = mask then
                read_calib_search_bit_value = data_low
            else
                read_calib_search_bit_value = (data_low - H8000_0000) and calib_search_bit_mask
            end If
        else
            read_calib_search_bit_value = data_low and calib_search_bit_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_testsel_refclk_ovrd_sel_value = &H0
        flag_mdio_testsel_refclk_ovrd_sel        = &H0
        write_mdio_testsel_refclk_ovrd_val_value = &H0
        flag_mdio_testsel_refclk_ovrd_val        = &H0
        write_stop_recal_value = &H0
        flag_stop_recal        = &H0
        write_mdio_vco_cal_err_ena_value = &H0
        flag_mdio_vco_cal_err_ena        = &H0
        write_calib_search_bit_value = &H0
        flag_calib_search_bit        = &H0
    End Sub
End Class


'' @REGISTER : PLL_DFE0__SGMIIPCIE_X1_status1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cal_error                                  [12:12]          get_cal_error
''                                                             set_cal_error
''                                                             read_cal_error
''                                                             write_cal_error
''---------------------------------------------------------------------------------
'' cal_state                                  [11:8]           get_cal_state
''                                                             set_cal_state
''                                                             read_cal_state
''                                                             write_cal_state
''---------------------------------------------------------------------------------
'' cal_done                                   [7:7]            get_cal_done
''                                                             set_cal_done
''                                                             read_cal_done
''                                                             write_cal_done
''---------------------------------------------------------------------------------
'' vco_range                                  [6:0]            get_vco_range
''                                                             set_vco_range
''                                                             read_vco_range
''                                                             write_vco_range
''---------------------------------------------------------------------------------
Class REGISTER_PLL_DFE0__SGMIIPCIE_X1_status1
    Private write_cal_error_value
    Private read_cal_error_value
    Private flag_cal_error
    Private write_cal_state_value
    Private read_cal_state_value
    Private flag_cal_state
    Private write_cal_done_value
    Private read_cal_done_value
    Private flag_cal_done
    Private write_vco_range_value
    Private read_vco_range_value
    Private flag_vco_range

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

    Property Get get_cal_done
        get_cal_done = read_cal_done_value
    End Property

    Property Let set_cal_done(aData)
        write_cal_done_value = aData
        flag_cal_done        = &H1
    End Property

    Property Get read_cal_done
        read
        read_cal_done = read_cal_done_value
    End Property

    Property Let write_cal_done(aData)
        set_cal_done = aData
        write
    End Property

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_error_value = rightShift(data_low, 12) and &H1
        read_cal_state_value = rightShift(data_low, 8) and &Hf
        read_cal_done_value = rightShift(data_low, 7) and &H1
        vco_range_mask = &H7f
        if data_low > LONG_MAX then
            if vco_range_mask = mask then
                read_vco_range_value = data_low
            else
                read_vco_range_value = (data_low - H8000_0000) and vco_range_mask
            end If
        else
            read_vco_range_value = data_low and vco_range_mask
        end If

    End Sub

    Sub write
        If flag_cal_error = &H0 or flag_cal_state = &H0 or flag_cal_done = &H0 or flag_vco_range = &H0 Then read
        If flag_cal_error = &H0 Then write_cal_error_value = get_cal_error
        If flag_cal_state = &H0 Then write_cal_state_value = get_cal_state
        If flag_cal_done = &H0 Then write_cal_done_value = get_cal_done
        If flag_vco_range = &H0 Then write_vco_range_value = get_vco_range

        regValue = leftShift((write_cal_error_value and &H1), 12) + leftShift((write_cal_state_value and &Hf), 8) + leftShift((write_cal_done_value and &H1), 7) + leftShift((write_vco_range_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cal_error_value = rightShift(data_low, 12) and &H1
        read_cal_state_value = rightShift(data_low, 8) and &Hf
        read_cal_done_value = rightShift(data_low, 7) and &H1
        vco_range_mask = &H7f
        if data_low > LONG_MAX then
            if vco_range_mask = mask then
                read_vco_range_value = data_low
            else
                read_vco_range_value = (data_low - H8000_0000) and vco_range_mask
            end If
        else
            read_vco_range_value = data_low and vco_range_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cal_error_value = &H0
        flag_cal_error        = &H0
        write_cal_state_value = &H0
        flag_cal_state        = &H0
        write_cal_done_value = &H0
        flag_cal_done        = &H0
        write_vco_range_value = &H0
        flag_vco_range        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PLL_DFE0__SGMIIPCIE_X1_INSTANCE

    Public timer1
    Public timer2
    Public timer3
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public status1


    Public default function Init(aBaseAddr)
        Set timer1 = (New REGISTER_PLL_DFE0__SGMIIPCIE_X1_timer1)(aBaseAddr, 16)
        Set timer2 = (New REGISTER_PLL_DFE0__SGMIIPCIE_X1_timer2)(aBaseAddr, 16)
        Set timer3 = (New REGISTER_PLL_DFE0__SGMIIPCIE_X1_timer3)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_PLL_DFE0__SGMIIPCIE_X1_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_PLL_DFE0__SGMIIPCIE_X1_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_PLL_DFE0__SGMIIPCIE_X1_ctrl3)(aBaseAddr, 16)
        Set status1 = (New REGISTER_PLL_DFE0__SGMIIPCIE_X1_status1)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PLL_DFE0__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PLL_DFE0__SGMIIPCIE_X1.Add ((New PLL_DFE0__SGMIIPCIE_X1_INSTANCE)(&H4ade6000))


