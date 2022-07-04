

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


'' @REGISTER : CRG_xtal_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cmos_en_all                                [15:15]          get_cmos_en_all
''                                                             set_cmos_en_all
''                                                             read_cmos_en_all
''                                                             write_cmos_en_all
''---------------------------------------------------------------------------------
'' cmos_en_ch                                 [14:10]          get_cmos_en_ch
''                                                             set_cmos_en_ch
''                                                             read_cmos_en_ch
''                                                             write_cmos_en_ch
''---------------------------------------------------------------------------------
'' cml_pd_ch2                                 [9:9]            get_cml_pd_ch2
''                                                             set_cml_pd_ch2
''                                                             read_cml_pd_ch2
''                                                             write_cml_pd_ch2
''---------------------------------------------------------------------------------
'' cml_pd_ch0                                 [8:8]            get_cml_pd_ch0
''                                                             set_cml_pd_ch0
''                                                             read_cml_pd_ch0
''                                                             write_cml_pd_ch0
''---------------------------------------------------------------------------------
'' xcore_CM_sel                               [7:7]            get_xcore_CM_sel
''                                                             set_xcore_CM_sel
''                                                             read_xcore_CM_sel
''                                                             write_xcore_CM_sel
''---------------------------------------------------------------------------------
'' xtal_bias                                  [6:4]            get_xtal_bias
''                                                             set_xtal_bias
''                                                             read_xtal_bias
''                                                             write_xtal_bias
''---------------------------------------------------------------------------------
'' cml_cur                                    [3:3]            get_cml_cur
''                                                             set_cml_cur
''                                                             read_cml_cur
''                                                             write_cml_cur
''---------------------------------------------------------------------------------
'' d2c_bias                                   [2:0]            get_d2c_bias
''                                                             set_d2c_bias
''                                                             read_d2c_bias
''                                                             write_d2c_bias
''---------------------------------------------------------------------------------
Class REGISTER_CRG_xtal_config
    Private write_cmos_en_all_value
    Private read_cmos_en_all_value
    Private flag_cmos_en_all
    Private write_cmos_en_ch_value
    Private read_cmos_en_ch_value
    Private flag_cmos_en_ch
    Private write_cml_pd_ch2_value
    Private read_cml_pd_ch2_value
    Private flag_cml_pd_ch2
    Private write_cml_pd_ch0_value
    Private read_cml_pd_ch0_value
    Private flag_cml_pd_ch0
    Private write_xcore_CM_sel_value
    Private read_xcore_CM_sel_value
    Private flag_xcore_CM_sel
    Private write_xtal_bias_value
    Private read_xtal_bias_value
    Private flag_xtal_bias
    Private write_cml_cur_value
    Private read_cml_cur_value
    Private flag_cml_cur
    Private write_d2c_bias_value
    Private read_d2c_bias_value
    Private flag_d2c_bias

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

    Property Get get_cmos_en_all
        get_cmos_en_all = read_cmos_en_all_value
    End Property

    Property Let set_cmos_en_all(aData)
        write_cmos_en_all_value = aData
        flag_cmos_en_all        = &H1
    End Property

    Property Get read_cmos_en_all
        read
        read_cmos_en_all = read_cmos_en_all_value
    End Property

    Property Let write_cmos_en_all(aData)
        set_cmos_en_all = aData
        write
    End Property

    Property Get get_cmos_en_ch
        get_cmos_en_ch = read_cmos_en_ch_value
    End Property

    Property Let set_cmos_en_ch(aData)
        write_cmos_en_ch_value = aData
        flag_cmos_en_ch        = &H1
    End Property

    Property Get read_cmos_en_ch
        read
        read_cmos_en_ch = read_cmos_en_ch_value
    End Property

    Property Let write_cmos_en_ch(aData)
        set_cmos_en_ch = aData
        write
    End Property

    Property Get get_cml_pd_ch2
        get_cml_pd_ch2 = read_cml_pd_ch2_value
    End Property

    Property Let set_cml_pd_ch2(aData)
        write_cml_pd_ch2_value = aData
        flag_cml_pd_ch2        = &H1
    End Property

    Property Get read_cml_pd_ch2
        read
        read_cml_pd_ch2 = read_cml_pd_ch2_value
    End Property

    Property Let write_cml_pd_ch2(aData)
        set_cml_pd_ch2 = aData
        write
    End Property

    Property Get get_cml_pd_ch0
        get_cml_pd_ch0 = read_cml_pd_ch0_value
    End Property

    Property Let set_cml_pd_ch0(aData)
        write_cml_pd_ch0_value = aData
        flag_cml_pd_ch0        = &H1
    End Property

    Property Get read_cml_pd_ch0
        read
        read_cml_pd_ch0 = read_cml_pd_ch0_value
    End Property

    Property Let write_cml_pd_ch0(aData)
        set_cml_pd_ch0 = aData
        write
    End Property

    Property Get get_xcore_CM_sel
        get_xcore_CM_sel = read_xcore_CM_sel_value
    End Property

    Property Let set_xcore_CM_sel(aData)
        write_xcore_CM_sel_value = aData
        flag_xcore_CM_sel        = &H1
    End Property

    Property Get read_xcore_CM_sel
        read
        read_xcore_CM_sel = read_xcore_CM_sel_value
    End Property

    Property Let write_xcore_CM_sel(aData)
        set_xcore_CM_sel = aData
        write
    End Property

    Property Get get_xtal_bias
        get_xtal_bias = read_xtal_bias_value
    End Property

    Property Let set_xtal_bias(aData)
        write_xtal_bias_value = aData
        flag_xtal_bias        = &H1
    End Property

    Property Get read_xtal_bias
        read
        read_xtal_bias = read_xtal_bias_value
    End Property

    Property Let write_xtal_bias(aData)
        set_xtal_bias = aData
        write
    End Property

    Property Get get_cml_cur
        get_cml_cur = read_cml_cur_value
    End Property

    Property Let set_cml_cur(aData)
        write_cml_cur_value = aData
        flag_cml_cur        = &H1
    End Property

    Property Get read_cml_cur
        read
        read_cml_cur = read_cml_cur_value
    End Property

    Property Let write_cml_cur(aData)
        set_cml_cur = aData
        write
    End Property

    Property Get get_d2c_bias
        get_d2c_bias = read_d2c_bias_value
    End Property

    Property Let set_d2c_bias(aData)
        write_d2c_bias_value = aData
        flag_d2c_bias        = &H1
    End Property

    Property Get read_d2c_bias
        read
        read_d2c_bias = read_d2c_bias_value
    End Property

    Property Let write_d2c_bias(aData)
        set_d2c_bias = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cmos_en_all_value = rightShift(data_low, 15) and &H1
        read_cmos_en_ch_value = rightShift(data_low, 10) and &H1f
        read_cml_pd_ch2_value = rightShift(data_low, 9) and &H1
        read_cml_pd_ch0_value = rightShift(data_low, 8) and &H1
        read_xcore_CM_sel_value = rightShift(data_low, 7) and &H1
        read_xtal_bias_value = rightShift(data_low, 4) and &H7
        read_cml_cur_value = rightShift(data_low, 3) and &H1
        d2c_bias_mask = &H7
        if data_low > LONG_MAX then
            if d2c_bias_mask = mask then
                read_d2c_bias_value = data_low
            else
                read_d2c_bias_value = (data_low - H8000_0000) and d2c_bias_mask
            end If
        else
            read_d2c_bias_value = data_low and d2c_bias_mask
        end If

    End Sub

    Sub write
        If flag_cmos_en_all = &H0 or flag_cmos_en_ch = &H0 or flag_cml_pd_ch2 = &H0 or flag_cml_pd_ch0 = &H0 or flag_xcore_CM_sel = &H0 or flag_xtal_bias = &H0 or flag_cml_cur = &H0 or flag_d2c_bias = &H0 Then read
        If flag_cmos_en_all = &H0 Then write_cmos_en_all_value = get_cmos_en_all
        If flag_cmos_en_ch = &H0 Then write_cmos_en_ch_value = get_cmos_en_ch
        If flag_cml_pd_ch2 = &H0 Then write_cml_pd_ch2_value = get_cml_pd_ch2
        If flag_cml_pd_ch0 = &H0 Then write_cml_pd_ch0_value = get_cml_pd_ch0
        If flag_xcore_CM_sel = &H0 Then write_xcore_CM_sel_value = get_xcore_CM_sel
        If flag_xtal_bias = &H0 Then write_xtal_bias_value = get_xtal_bias
        If flag_cml_cur = &H0 Then write_cml_cur_value = get_cml_cur
        If flag_d2c_bias = &H0 Then write_d2c_bias_value = get_d2c_bias

        regValue = leftShift((write_cmos_en_all_value and &H1), 15) + leftShift((write_cmos_en_ch_value and &H1f), 10) + leftShift((write_cml_pd_ch2_value and &H1), 9) + leftShift((write_cml_pd_ch0_value and &H1), 8) + leftShift((write_xcore_CM_sel_value and &H1), 7) + leftShift((write_xtal_bias_value and &H7), 4) + leftShift((write_cml_cur_value and &H1), 3) + leftShift((write_d2c_bias_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cmos_en_all_value = rightShift(data_low, 15) and &H1
        read_cmos_en_ch_value = rightShift(data_low, 10) and &H1f
        read_cml_pd_ch2_value = rightShift(data_low, 9) and &H1
        read_cml_pd_ch0_value = rightShift(data_low, 8) and &H1
        read_xcore_CM_sel_value = rightShift(data_low, 7) and &H1
        read_xtal_bias_value = rightShift(data_low, 4) and &H7
        read_cml_cur_value = rightShift(data_low, 3) and &H1
        d2c_bias_mask = &H7
        if data_low > LONG_MAX then
            if d2c_bias_mask = mask then
                read_d2c_bias_value = data_low
            else
                read_d2c_bias_value = (data_low - H8000_0000) and d2c_bias_mask
            end If
        else
            read_d2c_bias_value = data_low and d2c_bias_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cmos_en_all_value = &H0
        flag_cmos_en_all        = &H0
        write_cmos_en_ch_value = &H0
        flag_cmos_en_ch        = &H0
        write_cml_pd_ch2_value = &H0
        flag_cml_pd_ch2        = &H0
        write_cml_pd_ch0_value = &H0
        flag_cml_pd_ch0        = &H0
        write_xcore_CM_sel_value = &H0
        flag_xcore_CM_sel        = &H0
        write_xtal_bias_value = &H0
        flag_xtal_bias        = &H0
        write_cml_cur_value = &H0
        flag_cml_cur        = &H0
        write_d2c_bias_value = &H0
        flag_d2c_bias        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_config1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pdiv                                       [15:12]          get_pdiv
''                                                             set_pdiv
''                                                             read_pdiv
''                                                             write_pdiv
''---------------------------------------------------------------------------------
'' ka                                         [9:7]            get_ka
''                                                             set_ka
''                                                             read_ka
''                                                             write_ka
''---------------------------------------------------------------------------------
'' ki                                         [6:4]            get_ki
''                                                             set_ki
''                                                             read_ki
''                                                             write_ki
''---------------------------------------------------------------------------------
'' kp                                         [3:0]            get_kp
''                                                             set_kp
''                                                             read_kp
''                                                             write_kp
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_config1
    Private write_pdiv_value
    Private read_pdiv_value
    Private flag_pdiv
    Private write_ka_value
    Private read_ka_value
    Private flag_ka
    Private write_ki_value
    Private read_ki_value
    Private flag_ki
    Private write_kp_value
    Private read_kp_value
    Private flag_kp

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

    Property Get get_pdiv
        get_pdiv = read_pdiv_value
    End Property

    Property Let set_pdiv(aData)
        write_pdiv_value = aData
        flag_pdiv        = &H1
    End Property

    Property Get read_pdiv
        read
        read_pdiv = read_pdiv_value
    End Property

    Property Let write_pdiv(aData)
        set_pdiv = aData
        write
    End Property

    Property Get get_ka
        get_ka = read_ka_value
    End Property

    Property Let set_ka(aData)
        write_ka_value = aData
        flag_ka        = &H1
    End Property

    Property Get read_ka
        read
        read_ka = read_ka_value
    End Property

    Property Let write_ka(aData)
        set_ka = aData
        write
    End Property

    Property Get get_ki
        get_ki = read_ki_value
    End Property

    Property Let set_ki(aData)
        write_ki_value = aData
        flag_ki        = &H1
    End Property

    Property Get read_ki
        read
        read_ki = read_ki_value
    End Property

    Property Let write_ki(aData)
        set_ki = aData
        write
    End Property

    Property Get get_kp
        get_kp = read_kp_value
    End Property

    Property Let set_kp(aData)
        write_kp_value = aData
        flag_kp        = &H1
    End Property

    Property Get read_kp
        read
        read_kp = read_kp_value
    End Property

    Property Let write_kp(aData)
        set_kp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pdiv_value = rightShift(data_low, 12) and &Hf
        read_ka_value = rightShift(data_low, 7) and &H7
        read_ki_value = rightShift(data_low, 4) and &H7
        kp_mask = &Hf
        if data_low > LONG_MAX then
            if kp_mask = mask then
                read_kp_value = data_low
            else
                read_kp_value = (data_low - H8000_0000) and kp_mask
            end If
        else
            read_kp_value = data_low and kp_mask
        end If

    End Sub

    Sub write
        If flag_pdiv = &H0 or flag_ka = &H0 or flag_ki = &H0 or flag_kp = &H0 Then read
        If flag_pdiv = &H0 Then write_pdiv_value = get_pdiv
        If flag_ka = &H0 Then write_ka_value = get_ka
        If flag_ki = &H0 Then write_ki_value = get_ki
        If flag_kp = &H0 Then write_kp_value = get_kp

        regValue = leftShift((write_pdiv_value and &Hf), 12) + leftShift((write_ka_value and &H7), 7) + leftShift((write_ki_value and &H7), 4) + leftShift((write_kp_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pdiv_value = rightShift(data_low, 12) and &Hf
        read_ka_value = rightShift(data_low, 7) and &H7
        read_ki_value = rightShift(data_low, 4) and &H7
        kp_mask = &Hf
        if data_low > LONG_MAX then
            if kp_mask = mask then
                read_kp_value = data_low
            else
                read_kp_value = (data_low - H8000_0000) and kp_mask
            end If
        else
            read_kp_value = data_low and kp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pdiv_value = &H0
        flag_pdiv        = &H0
        write_ka_value = &H0
        flag_ka        = &H0
        write_ki_value = &H0
        flag_ki        = &H0
        write_kp_value = &H0
        flag_kp        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_config2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bypass_en                                  [15:12]          get_bypass_en
''                                                             set_bypass_en
''                                                             read_bypass_en
''                                                             write_bypass_en
''---------------------------------------------------------------------------------
'' pll_ch_delay                               [11:8]           get_pll_ch_delay
''                                                             set_pll_ch_delay
''                                                             read_pll_ch_delay
''                                                             write_pll_ch_delay
''---------------------------------------------------------------------------------
'' pll_ch_hold                                [7:4]            get_pll_ch_hold
''                                                             set_pll_ch_hold
''                                                             read_pll_ch_hold
''                                                             write_pll_ch_hold
''---------------------------------------------------------------------------------
'' pll_ch_en_n                                [3:0]            get_pll_ch_en_n
''                                                             set_pll_ch_en_n
''                                                             read_pll_ch_en_n
''                                                             write_pll_ch_en_n
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_config2
    Private write_bypass_en_value
    Private read_bypass_en_value
    Private flag_bypass_en
    Private write_pll_ch_delay_value
    Private read_pll_ch_delay_value
    Private flag_pll_ch_delay
    Private write_pll_ch_hold_value
    Private read_pll_ch_hold_value
    Private flag_pll_ch_hold
    Private write_pll_ch_en_n_value
    Private read_pll_ch_en_n_value
    Private flag_pll_ch_en_n

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

    Property Get get_bypass_en
        get_bypass_en = read_bypass_en_value
    End Property

    Property Let set_bypass_en(aData)
        write_bypass_en_value = aData
        flag_bypass_en        = &H1
    End Property

    Property Get read_bypass_en
        read
        read_bypass_en = read_bypass_en_value
    End Property

    Property Let write_bypass_en(aData)
        set_bypass_en = aData
        write
    End Property

    Property Get get_pll_ch_delay
        get_pll_ch_delay = read_pll_ch_delay_value
    End Property

    Property Let set_pll_ch_delay(aData)
        write_pll_ch_delay_value = aData
        flag_pll_ch_delay        = &H1
    End Property

    Property Get read_pll_ch_delay
        read
        read_pll_ch_delay = read_pll_ch_delay_value
    End Property

    Property Let write_pll_ch_delay(aData)
        set_pll_ch_delay = aData
        write
    End Property

    Property Get get_pll_ch_hold
        get_pll_ch_hold = read_pll_ch_hold_value
    End Property

    Property Let set_pll_ch_hold(aData)
        write_pll_ch_hold_value = aData
        flag_pll_ch_hold        = &H1
    End Property

    Property Get read_pll_ch_hold
        read
        read_pll_ch_hold = read_pll_ch_hold_value
    End Property

    Property Let write_pll_ch_hold(aData)
        set_pll_ch_hold = aData
        write
    End Property

    Property Get get_pll_ch_en_n
        get_pll_ch_en_n = read_pll_ch_en_n_value
    End Property

    Property Let set_pll_ch_en_n(aData)
        write_pll_ch_en_n_value = aData
        flag_pll_ch_en_n        = &H1
    End Property

    Property Get read_pll_ch_en_n
        read
        read_pll_ch_en_n = read_pll_ch_en_n_value
    End Property

    Property Let write_pll_ch_en_n(aData)
        set_pll_ch_en_n = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_en_value = rightShift(data_low, 12) and &Hf
        read_pll_ch_delay_value = rightShift(data_low, 8) and &Hf
        read_pll_ch_hold_value = rightShift(data_low, 4) and &Hf
        pll_ch_en_n_mask = &Hf
        if data_low > LONG_MAX then
            if pll_ch_en_n_mask = mask then
                read_pll_ch_en_n_value = data_low
            else
                read_pll_ch_en_n_value = (data_low - H8000_0000) and pll_ch_en_n_mask
            end If
        else
            read_pll_ch_en_n_value = data_low and pll_ch_en_n_mask
        end If

    End Sub

    Sub write
        If flag_bypass_en = &H0 or flag_pll_ch_delay = &H0 or flag_pll_ch_hold = &H0 or flag_pll_ch_en_n = &H0 Then read
        If flag_bypass_en = &H0 Then write_bypass_en_value = get_bypass_en
        If flag_pll_ch_delay = &H0 Then write_pll_ch_delay_value = get_pll_ch_delay
        If flag_pll_ch_hold = &H0 Then write_pll_ch_hold_value = get_pll_ch_hold
        If flag_pll_ch_en_n = &H0 Then write_pll_ch_en_n_value = get_pll_ch_en_n

        regValue = leftShift((write_bypass_en_value and &Hf), 12) + leftShift((write_pll_ch_delay_value and &Hf), 8) + leftShift((write_pll_ch_hold_value and &Hf), 4) + leftShift((write_pll_ch_en_n_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_en_value = rightShift(data_low, 12) and &Hf
        read_pll_ch_delay_value = rightShift(data_low, 8) and &Hf
        read_pll_ch_hold_value = rightShift(data_low, 4) and &Hf
        pll_ch_en_n_mask = &Hf
        if data_low > LONG_MAX then
            if pll_ch_en_n_mask = mask then
                read_pll_ch_en_n_value = data_low
            else
                read_pll_ch_en_n_value = (data_low - H8000_0000) and pll_ch_en_n_mask
            end If
        else
            read_pll_ch_en_n_value = data_low and pll_ch_en_n_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bypass_en_value = &H0
        flag_bypass_en        = &H0
        write_pll_ch_delay_value = &H0
        flag_pll_ch_delay        = &H0
        write_pll_ch_hold_value = &H0
        flag_pll_ch_hold        = &H0
        write_pll_ch_en_n_value = &H0
        flag_pll_ch_en_n        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ndiv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NDIV_INT                                   [9:0]            get_NDIV_INT
''                                                             set_NDIV_INT
''                                                             read_NDIV_INT
''                                                             write_NDIV_INT
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ndiv
    Private write_NDIV_INT_value
    Private read_NDIV_INT_value
    Private flag_NDIV_INT

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

    Property Get get_NDIV_INT
        get_NDIV_INT = read_NDIV_INT_value
    End Property

    Property Let set_NDIV_INT(aData)
        write_NDIV_INT_value = aData
        flag_NDIV_INT        = &H1
    End Property

    Property Get read_NDIV_INT
        read
        read_NDIV_INT = read_NDIV_INT_value
    End Property

    Property Let write_NDIV_INT(aData)
        set_NDIV_INT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NDIV_INT_mask = &H3ff
        if data_low > LONG_MAX then
            if NDIV_INT_mask = mask then
                read_NDIV_INT_value = data_low
            else
                read_NDIV_INT_value = (data_low - H8000_0000) and NDIV_INT_mask
            end If
        else
            read_NDIV_INT_value = data_low and NDIV_INT_mask
        end If

    End Sub

    Sub write
        If flag_NDIV_INT = &H0 Then read
        If flag_NDIV_INT = &H0 Then write_NDIV_INT_value = get_NDIV_INT

        regValue = leftShift((write_NDIV_INT_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NDIV_INT_mask = &H3ff
        if data_low > LONG_MAX then
            if NDIV_INT_mask = mask then
                read_NDIV_INT_value = data_low
            else
                read_NDIV_INT_value = (data_low - H8000_0000) and NDIV_INT_mask
            end If
        else
            read_NDIV_INT_value = data_low and NDIV_INT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NDIV_INT_value = &H0
        flag_NDIV_INT        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl0                                  [15:0]           get_pll_ctrl0
''                                                             set_pll_ctrl0
''                                                             read_pll_ctrl0
''                                                             write_pll_ctrl0
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ctrl0
    Private write_pll_ctrl0_value
    Private read_pll_ctrl0_value
    Private flag_pll_ctrl0

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

    Property Get get_pll_ctrl0
        get_pll_ctrl0 = read_pll_ctrl0_value
    End Property

    Property Let set_pll_ctrl0(aData)
        write_pll_ctrl0_value = aData
        flag_pll_ctrl0        = &H1
    End Property

    Property Get read_pll_ctrl0
        read
        read_pll_ctrl0 = read_pll_ctrl0_value
    End Property

    Property Let write_pll_ctrl0(aData)
        set_pll_ctrl0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl0_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl0_mask = mask then
                read_pll_ctrl0_value = data_low
            else
                read_pll_ctrl0_value = (data_low - H8000_0000) and pll_ctrl0_mask
            end If
        else
            read_pll_ctrl0_value = data_low and pll_ctrl0_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl0 = &H0 Then read
        If flag_pll_ctrl0 = &H0 Then write_pll_ctrl0_value = get_pll_ctrl0

        regValue = leftShift((write_pll_ctrl0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl0_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl0_mask = mask then
                read_pll_ctrl0_value = data_low
            else
                read_pll_ctrl0_value = (data_low - H8000_0000) and pll_ctrl0_mask
            end If
        else
            read_pll_ctrl0_value = data_low and pll_ctrl0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl0_value = &H0
        flag_pll_ctrl0        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl1                                  [15:0]           get_pll_ctrl1
''                                                             set_pll_ctrl1
''                                                             read_pll_ctrl1
''                                                             write_pll_ctrl1
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ctrl1
    Private write_pll_ctrl1_value
    Private read_pll_ctrl1_value
    Private flag_pll_ctrl1

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

    Property Get get_pll_ctrl1
        get_pll_ctrl1 = read_pll_ctrl1_value
    End Property

    Property Let set_pll_ctrl1(aData)
        write_pll_ctrl1_value = aData
        flag_pll_ctrl1        = &H1
    End Property

    Property Get read_pll_ctrl1
        read
        read_pll_ctrl1 = read_pll_ctrl1_value
    End Property

    Property Let write_pll_ctrl1(aData)
        set_pll_ctrl1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl1_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl1_mask = mask then
                read_pll_ctrl1_value = data_low
            else
                read_pll_ctrl1_value = (data_low - H8000_0000) and pll_ctrl1_mask
            end If
        else
            read_pll_ctrl1_value = data_low and pll_ctrl1_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl1 = &H0 Then read
        If flag_pll_ctrl1 = &H0 Then write_pll_ctrl1_value = get_pll_ctrl1

        regValue = leftShift((write_pll_ctrl1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl1_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl1_mask = mask then
                read_pll_ctrl1_value = data_low
            else
                read_pll_ctrl1_value = (data_low - H8000_0000) and pll_ctrl1_mask
            end If
        else
            read_pll_ctrl1_value = data_low and pll_ctrl1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl1_value = &H0
        flag_pll_ctrl1        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl2                                  [15:0]           get_pll_ctrl2
''                                                             set_pll_ctrl2
''                                                             read_pll_ctrl2
''                                                             write_pll_ctrl2
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ctrl2
    Private write_pll_ctrl2_value
    Private read_pll_ctrl2_value
    Private flag_pll_ctrl2

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

    Property Get get_pll_ctrl2
        get_pll_ctrl2 = read_pll_ctrl2_value
    End Property

    Property Let set_pll_ctrl2(aData)
        write_pll_ctrl2_value = aData
        flag_pll_ctrl2        = &H1
    End Property

    Property Get read_pll_ctrl2
        read
        read_pll_ctrl2 = read_pll_ctrl2_value
    End Property

    Property Let write_pll_ctrl2(aData)
        set_pll_ctrl2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl2_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl2_mask = mask then
                read_pll_ctrl2_value = data_low
            else
                read_pll_ctrl2_value = (data_low - H8000_0000) and pll_ctrl2_mask
            end If
        else
            read_pll_ctrl2_value = data_low and pll_ctrl2_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl2 = &H0 Then read
        If flag_pll_ctrl2 = &H0 Then write_pll_ctrl2_value = get_pll_ctrl2

        regValue = leftShift((write_pll_ctrl2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl2_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl2_mask = mask then
                read_pll_ctrl2_value = data_low
            else
                read_pll_ctrl2_value = (data_low - H8000_0000) and pll_ctrl2_mask
            end If
        else
            read_pll_ctrl2_value = data_low and pll_ctrl2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl2_value = &H0
        flag_pll_ctrl2        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_ctrl3                                  [15:0]           get_pll_ctrl3
''                                                             set_pll_ctrl3
''                                                             read_pll_ctrl3
''                                                             write_pll_ctrl3
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ctrl3
    Private write_pll_ctrl3_value
    Private read_pll_ctrl3_value
    Private flag_pll_ctrl3

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

    Property Get get_pll_ctrl3
        get_pll_ctrl3 = read_pll_ctrl3_value
    End Property

    Property Let set_pll_ctrl3(aData)
        write_pll_ctrl3_value = aData
        flag_pll_ctrl3        = &H1
    End Property

    Property Get read_pll_ctrl3
        read
        read_pll_ctrl3 = read_pll_ctrl3_value
    End Property

    Property Let write_pll_ctrl3(aData)
        set_pll_ctrl3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl3_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl3_mask = mask then
                read_pll_ctrl3_value = data_low
            else
                read_pll_ctrl3_value = (data_low - H8000_0000) and pll_ctrl3_mask
            end If
        else
            read_pll_ctrl3_value = data_low and pll_ctrl3_mask
        end If

    End Sub

    Sub write
        If flag_pll_ctrl3 = &H0 Then read
        If flag_pll_ctrl3 = &H0 Then write_pll_ctrl3_value = get_pll_ctrl3

        regValue = leftShift((write_pll_ctrl3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll_ctrl3_mask = &Hffff
        if data_low > LONG_MAX then
            if pll_ctrl3_mask = mask then
                read_pll_ctrl3_value = data_low
            else
                read_pll_ctrl3_value = (data_low - H8000_0000) and pll_ctrl3_mask
            end If
        else
            read_pll_ctrl3_value = data_low and pll_ctrl3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_ctrl3_value = &H0
        flag_pll_ctrl3        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_mdiv_ch01
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdiv_ch1                                   [15:8]           get_mdiv_ch1
''                                                             set_mdiv_ch1
''                                                             read_mdiv_ch1
''                                                             write_mdiv_ch1
''---------------------------------------------------------------------------------
'' mdiv_ch0                                   [7:0]            get_mdiv_ch0
''                                                             set_mdiv_ch0
''                                                             read_mdiv_ch0
''                                                             write_mdiv_ch0
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_mdiv_ch01
    Private write_mdiv_ch1_value
    Private read_mdiv_ch1_value
    Private flag_mdiv_ch1
    Private write_mdiv_ch0_value
    Private read_mdiv_ch0_value
    Private flag_mdiv_ch0

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

    Property Get get_mdiv_ch1
        get_mdiv_ch1 = read_mdiv_ch1_value
    End Property

    Property Let set_mdiv_ch1(aData)
        write_mdiv_ch1_value = aData
        flag_mdiv_ch1        = &H1
    End Property

    Property Get read_mdiv_ch1
        read
        read_mdiv_ch1 = read_mdiv_ch1_value
    End Property

    Property Let write_mdiv_ch1(aData)
        set_mdiv_ch1 = aData
        write
    End Property

    Property Get get_mdiv_ch0
        get_mdiv_ch0 = read_mdiv_ch0_value
    End Property

    Property Let set_mdiv_ch0(aData)
        write_mdiv_ch0_value = aData
        flag_mdiv_ch0        = &H1
    End Property

    Property Get read_mdiv_ch0
        read
        read_mdiv_ch0 = read_mdiv_ch0_value
    End Property

    Property Let write_mdiv_ch0(aData)
        set_mdiv_ch0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch1_value = rightShift(data_low, 8) and &Hff
        mdiv_ch0_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch0_mask = mask then
                read_mdiv_ch0_value = data_low
            else
                read_mdiv_ch0_value = (data_low - H8000_0000) and mdiv_ch0_mask
            end If
        else
            read_mdiv_ch0_value = data_low and mdiv_ch0_mask
        end If

    End Sub

    Sub write
        If flag_mdiv_ch1 = &H0 or flag_mdiv_ch0 = &H0 Then read
        If flag_mdiv_ch1 = &H0 Then write_mdiv_ch1_value = get_mdiv_ch1
        If flag_mdiv_ch0 = &H0 Then write_mdiv_ch0_value = get_mdiv_ch0

        regValue = leftShift((write_mdiv_ch1_value and &Hff), 8) + leftShift((write_mdiv_ch0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch1_value = rightShift(data_low, 8) and &Hff
        mdiv_ch0_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch0_mask = mask then
                read_mdiv_ch0_value = data_low
            else
                read_mdiv_ch0_value = (data_low - H8000_0000) and mdiv_ch0_mask
            end If
        else
            read_mdiv_ch0_value = data_low and mdiv_ch0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdiv_ch1_value = &H0
        flag_mdiv_ch1        = &H0
        write_mdiv_ch0_value = &H0
        flag_mdiv_ch0        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_mdiv_ch23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdiv_ch3                                   [15:8]           get_mdiv_ch3
''                                                             set_mdiv_ch3
''                                                             read_mdiv_ch3
''                                                             write_mdiv_ch3
''---------------------------------------------------------------------------------
'' mdiv_ch2                                   [7:0]            get_mdiv_ch2
''                                                             set_mdiv_ch2
''                                                             read_mdiv_ch2
''                                                             write_mdiv_ch2
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_mdiv_ch23
    Private write_mdiv_ch3_value
    Private read_mdiv_ch3_value
    Private flag_mdiv_ch3
    Private write_mdiv_ch2_value
    Private read_mdiv_ch2_value
    Private flag_mdiv_ch2

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

    Property Get get_mdiv_ch3
        get_mdiv_ch3 = read_mdiv_ch3_value
    End Property

    Property Let set_mdiv_ch3(aData)
        write_mdiv_ch3_value = aData
        flag_mdiv_ch3        = &H1
    End Property

    Property Get read_mdiv_ch3
        read
        read_mdiv_ch3 = read_mdiv_ch3_value
    End Property

    Property Let write_mdiv_ch3(aData)
        set_mdiv_ch3 = aData
        write
    End Property

    Property Get get_mdiv_ch2
        get_mdiv_ch2 = read_mdiv_ch2_value
    End Property

    Property Let set_mdiv_ch2(aData)
        write_mdiv_ch2_value = aData
        flag_mdiv_ch2        = &H1
    End Property

    Property Get read_mdiv_ch2
        read
        read_mdiv_ch2 = read_mdiv_ch2_value
    End Property

    Property Let write_mdiv_ch2(aData)
        set_mdiv_ch2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch3_value = rightShift(data_low, 8) and &Hff
        mdiv_ch2_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch2_mask = mask then
                read_mdiv_ch2_value = data_low
            else
                read_mdiv_ch2_value = (data_low - H8000_0000) and mdiv_ch2_mask
            end If
        else
            read_mdiv_ch2_value = data_low and mdiv_ch2_mask
        end If

    End Sub

    Sub write
        If flag_mdiv_ch3 = &H0 or flag_mdiv_ch2 = &H0 Then read
        If flag_mdiv_ch3 = &H0 Then write_mdiv_ch3_value = get_mdiv_ch3
        If flag_mdiv_ch2 = &H0 Then write_mdiv_ch2_value = get_mdiv_ch2

        regValue = leftShift((write_mdiv_ch3_value and &Hff), 8) + leftShift((write_mdiv_ch2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch3_value = rightShift(data_low, 8) and &Hff
        mdiv_ch2_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch2_mask = mask then
                read_mdiv_ch2_value = data_low
            else
                read_mdiv_ch2_value = (data_low - H8000_0000) and mdiv_ch2_mask
            end If
        else
            read_mdiv_ch2_value = data_low and mdiv_ch2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdiv_ch3_value = &H0
        flag_mdiv_ch3        = &H0
        write_mdiv_ch2_value = &H0
        flag_mdiv_ch2        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ssc_config1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scc_limit_hi                               [13:8]           get_scc_limit_hi
''                                                             set_scc_limit_hi
''                                                             read_scc_limit_hi
''                                                             write_scc_limit_hi
''---------------------------------------------------------------------------------
'' SSC_mode                                   [0:0]            get_SSC_mode
''                                                             set_SSC_mode
''                                                             read_SSC_mode
''                                                             write_SSC_mode
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ssc_config1
    Private write_scc_limit_hi_value
    Private read_scc_limit_hi_value
    Private flag_scc_limit_hi
    Private write_SSC_mode_value
    Private read_SSC_mode_value
    Private flag_SSC_mode

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

    Property Get get_scc_limit_hi
        get_scc_limit_hi = read_scc_limit_hi_value
    End Property

    Property Let set_scc_limit_hi(aData)
        write_scc_limit_hi_value = aData
        flag_scc_limit_hi        = &H1
    End Property

    Property Get read_scc_limit_hi
        read
        read_scc_limit_hi = read_scc_limit_hi_value
    End Property

    Property Let write_scc_limit_hi(aData)
        set_scc_limit_hi = aData
        write
    End Property

    Property Get get_SSC_mode
        get_SSC_mode = read_SSC_mode_value
    End Property

    Property Let set_SSC_mode(aData)
        write_SSC_mode_value = aData
        flag_SSC_mode        = &H1
    End Property

    Property Get read_SSC_mode
        read
        read_SSC_mode = read_SSC_mode_value
    End Property

    Property Let write_SSC_mode(aData)
        set_SSC_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_scc_limit_hi_value = rightShift(data_low, 8) and &H3f
        SSC_mode_mask = &H1
        if data_low > LONG_MAX then
            if SSC_mode_mask = mask then
                read_SSC_mode_value = data_low
            else
                read_SSC_mode_value = (data_low - H8000_0000) and SSC_mode_mask
            end If
        else
            read_SSC_mode_value = data_low and SSC_mode_mask
        end If

    End Sub

    Sub write
        If flag_scc_limit_hi = &H0 or flag_SSC_mode = &H0 Then read
        If flag_scc_limit_hi = &H0 Then write_scc_limit_hi_value = get_scc_limit_hi
        If flag_SSC_mode = &H0 Then write_SSC_mode_value = get_SSC_mode

        regValue = leftShift((write_scc_limit_hi_value and &H3f), 8) + leftShift((write_SSC_mode_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_scc_limit_hi_value = rightShift(data_low, 8) and &H3f
        SSC_mode_mask = &H1
        if data_low > LONG_MAX then
            if SSC_mode_mask = mask then
                read_SSC_mode_value = data_low
            else
                read_SSC_mode_value = (data_low - H8000_0000) and SSC_mode_mask
            end If
        else
            read_SSC_mode_value = data_low and SSC_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scc_limit_hi_value = &H0
        flag_scc_limit_hi        = &H0
        write_SSC_mode_value = &H0
        flag_SSC_mode        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ssc_config2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scc_limit_low                              [15:0]           get_scc_limit_low
''                                                             set_scc_limit_low
''                                                             read_scc_limit_low
''                                                             write_scc_limit_low
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ssc_config2
    Private write_scc_limit_low_value
    Private read_scc_limit_low_value
    Private flag_scc_limit_low

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

    Property Get get_scc_limit_low
        get_scc_limit_low = read_scc_limit_low_value
    End Property

    Property Let set_scc_limit_low(aData)
        write_scc_limit_low_value = aData
        flag_scc_limit_low        = &H1
    End Property

    Property Get read_scc_limit_low
        read
        read_scc_limit_low = read_scc_limit_low_value
    End Property

    Property Let write_scc_limit_low(aData)
        set_scc_limit_low = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scc_limit_low_mask = &Hffff
        if data_low > LONG_MAX then
            if scc_limit_low_mask = mask then
                read_scc_limit_low_value = data_low
            else
                read_scc_limit_low_value = (data_low - H8000_0000) and scc_limit_low_mask
            end If
        else
            read_scc_limit_low_value = data_low and scc_limit_low_mask
        end If

    End Sub

    Sub write
        If flag_scc_limit_low = &H0 Then read
        If flag_scc_limit_low = &H0 Then write_scc_limit_low_value = get_scc_limit_low

        regValue = leftShift((write_scc_limit_low_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scc_limit_low_mask = &Hffff
        if data_low > LONG_MAX then
            if scc_limit_low_mask = mask then
                read_scc_limit_low_value = data_low
            else
                read_scc_limit_low_value = (data_low - H8000_0000) and scc_limit_low_mask
            end If
        else
            read_scc_limit_low_value = data_low and scc_limit_low_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scc_limit_low_value = &H0
        flag_scc_limit_low        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_ssc_step
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SCC_step                                   [15:0]           get_SCC_step
''                                                             set_SCC_step
''                                                             read_SCC_step
''                                                             write_SCC_step
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_ssc_step
    Private write_SCC_step_value
    Private read_SCC_step_value
    Private flag_SCC_step

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

    Property Get get_SCC_step
        get_SCC_step = read_SCC_step_value
    End Property

    Property Let set_SCC_step(aData)
        write_SCC_step_value = aData
        flag_SCC_step        = &H1
    End Property

    Property Get read_SCC_step
        read
        read_SCC_step = read_SCC_step_value
    End Property

    Property Let write_SCC_step(aData)
        set_SCC_step = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SCC_step_mask = &Hffff
        if data_low > LONG_MAX then
            if SCC_step_mask = mask then
                read_SCC_step_value = data_low
            else
                read_SCC_step_value = (data_low - H8000_0000) and SCC_step_mask
            end If
        else
            read_SCC_step_value = data_low and SCC_step_mask
        end If

    End Sub

    Sub write
        If flag_SCC_step = &H0 Then read
        If flag_SCC_step = &H0 Then write_SCC_step_value = get_SCC_step

        regValue = leftShift((write_SCC_step_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SCC_step_mask = &Hffff
        if data_low > LONG_MAX then
            if SCC_step_mask = mask then
                read_SCC_step_value = data_low
            else
                read_SCC_step_value = (data_low - H8000_0000) and SCC_step_mask
            end If
        else
            read_SCC_step_value = data_low and SCC_step_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SCC_step_value = &H0
        flag_SCC_step        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_lock                                   [13:13]          get_pll_lock
''                                                             set_pll_lock
''                                                             read_pll_lock
''                                                             write_pll_lock
''---------------------------------------------------------------------------------
'' pll_lock_lost                              [12:12]          get_pll_lock_lost
''                                                             set_pll_lock_lost
''                                                             read_pll_lock_lost
''                                                             write_pll_lock_lost
''---------------------------------------------------------------------------------
'' pll_status                                 [11:0]           get_pll_status
''                                                             set_pll_status
''                                                             read_pll_status
''                                                             write_pll_status
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll_status
    Private write_pll_lock_value
    Private read_pll_lock_value
    Private flag_pll_lock
    Private write_pll_lock_lost_value
    Private read_pll_lock_lost_value
    Private flag_pll_lock_lost
    Private write_pll_status_value
    Private read_pll_status_value
    Private flag_pll_status

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

    Property Get get_pll_lock
        get_pll_lock = read_pll_lock_value
    End Property

    Property Let set_pll_lock(aData)
        write_pll_lock_value = aData
        flag_pll_lock        = &H1
    End Property

    Property Get read_pll_lock
        read
        read_pll_lock = read_pll_lock_value
    End Property

    Property Let write_pll_lock(aData)
        set_pll_lock = aData
        write
    End Property

    Property Get get_pll_lock_lost
        get_pll_lock_lost = read_pll_lock_lost_value
    End Property

    Property Let set_pll_lock_lost(aData)
        write_pll_lock_lost_value = aData
        flag_pll_lock_lost        = &H1
    End Property

    Property Get read_pll_lock_lost
        read
        read_pll_lock_lost = read_pll_lock_lost_value
    End Property

    Property Let write_pll_lock_lost(aData)
        set_pll_lock_lost = aData
        write
    End Property

    Property Get get_pll_status
        get_pll_status = read_pll_status_value
    End Property

    Property Let set_pll_status(aData)
        write_pll_status_value = aData
        flag_pll_status        = &H1
    End Property

    Property Get read_pll_status
        read
        read_pll_status = read_pll_status_value
    End Property

    Property Let write_pll_status(aData)
        set_pll_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll_lock_value = rightShift(data_low, 13) and &H1
        read_pll_lock_lost_value = rightShift(data_low, 12) and &H1
        pll_status_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_status_mask = mask then
                read_pll_status_value = data_low
            else
                read_pll_status_value = (data_low - H8000_0000) and pll_status_mask
            end If
        else
            read_pll_status_value = data_low and pll_status_mask
        end If

    End Sub

    Sub write
        If flag_pll_lock = &H0 or flag_pll_lock_lost = &H0 or flag_pll_status = &H0 Then read
        If flag_pll_lock = &H0 Then write_pll_lock_value = get_pll_lock
        If flag_pll_lock_lost = &H0 Then write_pll_lock_lost_value = get_pll_lock_lost
        If flag_pll_status = &H0 Then write_pll_status_value = get_pll_status

        regValue = leftShift((write_pll_lock_value and &H1), 13) + leftShift((write_pll_lock_lost_value and &H1), 12) + leftShift((write_pll_status_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll_lock_value = rightShift(data_low, 13) and &H1
        read_pll_lock_lost_value = rightShift(data_low, 12) and &H1
        pll_status_mask = &Hfff
        if data_low > LONG_MAX then
            if pll_status_mask = mask then
                read_pll_status_value = data_low
            else
                read_pll_status_value = (data_low - H8000_0000) and pll_status_mask
            end If
        else
            read_pll_status_value = data_low and pll_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_lock_value = &H0
        flag_pll_lock        = &H0
        write_pll_lock_lost_value = &H0
        flag_pll_lock_lost        = &H0
        write_pll_status_value = &H0
        flag_pll_status        = &H0
    End Sub
End Class


'' @REGISTER : CRG_clock_config1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' clk625_dis                                 [7:7]            get_clk625_dis
''                                                             set_clk625_dis
''                                                             read_clk625_dis
''                                                             write_clk625_dis
''---------------------------------------------------------------------------------
'' mii3_gmiiclk_dis                           [6:6]            get_mii3_gmiiclk_dis
''                                                             set_mii3_gmiiclk_dis
''                                                             read_mii3_gmiiclk_dis
''                                                             write_mii3_gmiiclk_dis
''---------------------------------------------------------------------------------
'' pcie_axi_clk_dis                           [5:5]            get_pcie_axi_clk_dis
''                                                             set_pcie_axi_clk_dis
''                                                             read_pcie_axi_clk_dis
''                                                             write_pcie_axi_clk_dis
''---------------------------------------------------------------------------------
'' macpcieclk_dis                             [4:4]            get_macpcieclk_dis
''                                                             set_macpcieclk_dis
''                                                             read_macpcieclk_dis
''                                                             write_macpcieclk_dis
''---------------------------------------------------------------------------------
'' sysclk_dis                                 [3:3]            get_sysclk_dis
''                                                             set_sysclk_dis
''                                                             read_sysclk_dis
''                                                             write_sysclk_dis
''---------------------------------------------------------------------------------
'' mii2_gmiiclk_dis                           [2:2]            get_mii2_gmiiclk_dis
''                                                             set_mii2_gmiiclk_dis
''                                                             read_mii2_gmiiclk_dis
''                                                             write_mii2_gmiiclk_dis
''---------------------------------------------------------------------------------
'' mii1_gmiiclk_dis                           [1:1]            get_mii1_gmiiclk_dis
''                                                             set_mii1_gmiiclk_dis
''                                                             read_mii1_gmiiclk_dis
''                                                             write_mii1_gmiiclk_dis
''---------------------------------------------------------------------------------
'' p7_gmiiclk_dis                             [0:0]            get_p7_gmiiclk_dis
''                                                             set_p7_gmiiclk_dis
''                                                             read_p7_gmiiclk_dis
''                                                             write_p7_gmiiclk_dis
''---------------------------------------------------------------------------------
Class REGISTER_CRG_clock_config1
    Private write_clk625_dis_value
    Private read_clk625_dis_value
    Private flag_clk625_dis
    Private write_mii3_gmiiclk_dis_value
    Private read_mii3_gmiiclk_dis_value
    Private flag_mii3_gmiiclk_dis
    Private write_pcie_axi_clk_dis_value
    Private read_pcie_axi_clk_dis_value
    Private flag_pcie_axi_clk_dis
    Private write_macpcieclk_dis_value
    Private read_macpcieclk_dis_value
    Private flag_macpcieclk_dis
    Private write_sysclk_dis_value
    Private read_sysclk_dis_value
    Private flag_sysclk_dis
    Private write_mii2_gmiiclk_dis_value
    Private read_mii2_gmiiclk_dis_value
    Private flag_mii2_gmiiclk_dis
    Private write_mii1_gmiiclk_dis_value
    Private read_mii1_gmiiclk_dis_value
    Private flag_mii1_gmiiclk_dis
    Private write_p7_gmiiclk_dis_value
    Private read_p7_gmiiclk_dis_value
    Private flag_p7_gmiiclk_dis

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

    Property Get get_clk625_dis
        get_clk625_dis = read_clk625_dis_value
    End Property

    Property Let set_clk625_dis(aData)
        write_clk625_dis_value = aData
        flag_clk625_dis        = &H1
    End Property

    Property Get read_clk625_dis
        read
        read_clk625_dis = read_clk625_dis_value
    End Property

    Property Let write_clk625_dis(aData)
        set_clk625_dis = aData
        write
    End Property

    Property Get get_mii3_gmiiclk_dis
        get_mii3_gmiiclk_dis = read_mii3_gmiiclk_dis_value
    End Property

    Property Let set_mii3_gmiiclk_dis(aData)
        write_mii3_gmiiclk_dis_value = aData
        flag_mii3_gmiiclk_dis        = &H1
    End Property

    Property Get read_mii3_gmiiclk_dis
        read
        read_mii3_gmiiclk_dis = read_mii3_gmiiclk_dis_value
    End Property

    Property Let write_mii3_gmiiclk_dis(aData)
        set_mii3_gmiiclk_dis = aData
        write
    End Property

    Property Get get_pcie_axi_clk_dis
        get_pcie_axi_clk_dis = read_pcie_axi_clk_dis_value
    End Property

    Property Let set_pcie_axi_clk_dis(aData)
        write_pcie_axi_clk_dis_value = aData
        flag_pcie_axi_clk_dis        = &H1
    End Property

    Property Get read_pcie_axi_clk_dis
        read
        read_pcie_axi_clk_dis = read_pcie_axi_clk_dis_value
    End Property

    Property Let write_pcie_axi_clk_dis(aData)
        set_pcie_axi_clk_dis = aData
        write
    End Property

    Property Get get_macpcieclk_dis
        get_macpcieclk_dis = read_macpcieclk_dis_value
    End Property

    Property Let set_macpcieclk_dis(aData)
        write_macpcieclk_dis_value = aData
        flag_macpcieclk_dis        = &H1
    End Property

    Property Get read_macpcieclk_dis
        read
        read_macpcieclk_dis = read_macpcieclk_dis_value
    End Property

    Property Let write_macpcieclk_dis(aData)
        set_macpcieclk_dis = aData
        write
    End Property

    Property Get get_sysclk_dis
        get_sysclk_dis = read_sysclk_dis_value
    End Property

    Property Let set_sysclk_dis(aData)
        write_sysclk_dis_value = aData
        flag_sysclk_dis        = &H1
    End Property

    Property Get read_sysclk_dis
        read
        read_sysclk_dis = read_sysclk_dis_value
    End Property

    Property Let write_sysclk_dis(aData)
        set_sysclk_dis = aData
        write
    End Property

    Property Get get_mii2_gmiiclk_dis
        get_mii2_gmiiclk_dis = read_mii2_gmiiclk_dis_value
    End Property

    Property Let set_mii2_gmiiclk_dis(aData)
        write_mii2_gmiiclk_dis_value = aData
        flag_mii2_gmiiclk_dis        = &H1
    End Property

    Property Get read_mii2_gmiiclk_dis
        read
        read_mii2_gmiiclk_dis = read_mii2_gmiiclk_dis_value
    End Property

    Property Let write_mii2_gmiiclk_dis(aData)
        set_mii2_gmiiclk_dis = aData
        write
    End Property

    Property Get get_mii1_gmiiclk_dis
        get_mii1_gmiiclk_dis = read_mii1_gmiiclk_dis_value
    End Property

    Property Let set_mii1_gmiiclk_dis(aData)
        write_mii1_gmiiclk_dis_value = aData
        flag_mii1_gmiiclk_dis        = &H1
    End Property

    Property Get read_mii1_gmiiclk_dis
        read
        read_mii1_gmiiclk_dis = read_mii1_gmiiclk_dis_value
    End Property

    Property Let write_mii1_gmiiclk_dis(aData)
        set_mii1_gmiiclk_dis = aData
        write
    End Property

    Property Get get_p7_gmiiclk_dis
        get_p7_gmiiclk_dis = read_p7_gmiiclk_dis_value
    End Property

    Property Let set_p7_gmiiclk_dis(aData)
        write_p7_gmiiclk_dis_value = aData
        flag_p7_gmiiclk_dis        = &H1
    End Property

    Property Get read_p7_gmiiclk_dis
        read
        read_p7_gmiiclk_dis = read_p7_gmiiclk_dis_value
    End Property

    Property Let write_p7_gmiiclk_dis(aData)
        set_p7_gmiiclk_dis = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clk625_dis_value = rightShift(data_low, 7) and &H1
        read_mii3_gmiiclk_dis_value = rightShift(data_low, 6) and &H1
        read_pcie_axi_clk_dis_value = rightShift(data_low, 5) and &H1
        read_macpcieclk_dis_value = rightShift(data_low, 4) and &H1
        read_sysclk_dis_value = rightShift(data_low, 3) and &H1
        read_mii2_gmiiclk_dis_value = rightShift(data_low, 2) and &H1
        read_mii1_gmiiclk_dis_value = rightShift(data_low, 1) and &H1
        p7_gmiiclk_dis_mask = &H1
        if data_low > LONG_MAX then
            if p7_gmiiclk_dis_mask = mask then
                read_p7_gmiiclk_dis_value = data_low
            else
                read_p7_gmiiclk_dis_value = (data_low - H8000_0000) and p7_gmiiclk_dis_mask
            end If
        else
            read_p7_gmiiclk_dis_value = data_low and p7_gmiiclk_dis_mask
        end If

    End Sub

    Sub write
        If flag_clk625_dis = &H0 or flag_mii3_gmiiclk_dis = &H0 or flag_pcie_axi_clk_dis = &H0 or flag_macpcieclk_dis = &H0 or flag_sysclk_dis = &H0 or flag_mii2_gmiiclk_dis = &H0 or flag_mii1_gmiiclk_dis = &H0 or flag_p7_gmiiclk_dis = &H0 Then read
        If flag_clk625_dis = &H0 Then write_clk625_dis_value = get_clk625_dis
        If flag_mii3_gmiiclk_dis = &H0 Then write_mii3_gmiiclk_dis_value = get_mii3_gmiiclk_dis
        If flag_pcie_axi_clk_dis = &H0 Then write_pcie_axi_clk_dis_value = get_pcie_axi_clk_dis
        If flag_macpcieclk_dis = &H0 Then write_macpcieclk_dis_value = get_macpcieclk_dis
        If flag_sysclk_dis = &H0 Then write_sysclk_dis_value = get_sysclk_dis
        If flag_mii2_gmiiclk_dis = &H0 Then write_mii2_gmiiclk_dis_value = get_mii2_gmiiclk_dis
        If flag_mii1_gmiiclk_dis = &H0 Then write_mii1_gmiiclk_dis_value = get_mii1_gmiiclk_dis
        If flag_p7_gmiiclk_dis = &H0 Then write_p7_gmiiclk_dis_value = get_p7_gmiiclk_dis

        regValue = leftShift((write_clk625_dis_value and &H1), 7) + leftShift((write_mii3_gmiiclk_dis_value and &H1), 6) + leftShift((write_pcie_axi_clk_dis_value and &H1), 5) + leftShift((write_macpcieclk_dis_value and &H1), 4) + leftShift((write_sysclk_dis_value and &H1), 3) + leftShift((write_mii2_gmiiclk_dis_value and &H1), 2) + leftShift((write_mii1_gmiiclk_dis_value and &H1), 1) + leftShift((write_p7_gmiiclk_dis_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_clk625_dis_value = rightShift(data_low, 7) and &H1
        read_mii3_gmiiclk_dis_value = rightShift(data_low, 6) and &H1
        read_pcie_axi_clk_dis_value = rightShift(data_low, 5) and &H1
        read_macpcieclk_dis_value = rightShift(data_low, 4) and &H1
        read_sysclk_dis_value = rightShift(data_low, 3) and &H1
        read_mii2_gmiiclk_dis_value = rightShift(data_low, 2) and &H1
        read_mii1_gmiiclk_dis_value = rightShift(data_low, 1) and &H1
        p7_gmiiclk_dis_mask = &H1
        if data_low > LONG_MAX then
            if p7_gmiiclk_dis_mask = mask then
                read_p7_gmiiclk_dis_value = data_low
            else
                read_p7_gmiiclk_dis_value = (data_low - H8000_0000) and p7_gmiiclk_dis_mask
            end If
        else
            read_p7_gmiiclk_dis_value = data_low and p7_gmiiclk_dis_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_clk625_dis_value = &H0
        flag_clk625_dis        = &H0
        write_mii3_gmiiclk_dis_value = &H0
        flag_mii3_gmiiclk_dis        = &H0
        write_pcie_axi_clk_dis_value = &H0
        flag_pcie_axi_clk_dis        = &H0
        write_macpcieclk_dis_value = &H0
        flag_macpcieclk_dis        = &H0
        write_sysclk_dis_value = &H0
        flag_sysclk_dis        = &H0
        write_mii2_gmiiclk_dis_value = &H0
        flag_mii2_gmiiclk_dis        = &H0
        write_mii1_gmiiclk_dis_value = &H0
        flag_mii1_gmiiclk_dis        = &H0
        write_p7_gmiiclk_dis_value = &H0
        flag_p7_gmiiclk_dis        = &H0
    End Sub
End Class


'' @REGISTER : CRG_clock_config2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dis_pll1_ch2_div2_byp                      [4:4]            get_dis_pll1_ch2_div2_byp
''                                                             set_dis_pll1_ch2_div2_byp
''                                                             read_dis_pll1_ch2_div2_byp
''                                                             write_dis_pll1_ch2_div2_byp
''---------------------------------------------------------------------------------
'' pcie_gen1_sel_ovr                          [3:2]            get_pcie_gen1_sel_ovr
''                                                             set_pcie_gen1_sel_ovr
''                                                             read_pcie_gen1_sel_ovr
''                                                             write_pcie_gen1_sel_ovr
''---------------------------------------------------------------------------------
'' pciemac_ptp_sel                            [1:1]            get_pciemac_ptp_sel
''                                                             set_pciemac_ptp_sel
''                                                             read_pciemac_ptp_sel
''                                                             write_pciemac_ptp_sel
''---------------------------------------------------------------------------------
'' qspiclk_sel                                [0:0]            get_qspiclk_sel
''                                                             set_qspiclk_sel
''                                                             read_qspiclk_sel
''                                                             write_qspiclk_sel
''---------------------------------------------------------------------------------
Class REGISTER_CRG_clock_config2
    Private write_dis_pll1_ch2_div2_byp_value
    Private read_dis_pll1_ch2_div2_byp_value
    Private flag_dis_pll1_ch2_div2_byp
    Private write_pcie_gen1_sel_ovr_value
    Private read_pcie_gen1_sel_ovr_value
    Private flag_pcie_gen1_sel_ovr
    Private write_pciemac_ptp_sel_value
    Private read_pciemac_ptp_sel_value
    Private flag_pciemac_ptp_sel
    Private write_qspiclk_sel_value
    Private read_qspiclk_sel_value
    Private flag_qspiclk_sel

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

    Property Get get_dis_pll1_ch2_div2_byp
        get_dis_pll1_ch2_div2_byp = read_dis_pll1_ch2_div2_byp_value
    End Property

    Property Let set_dis_pll1_ch2_div2_byp(aData)
        write_dis_pll1_ch2_div2_byp_value = aData
        flag_dis_pll1_ch2_div2_byp        = &H1
    End Property

    Property Get read_dis_pll1_ch2_div2_byp
        read
        read_dis_pll1_ch2_div2_byp = read_dis_pll1_ch2_div2_byp_value
    End Property

    Property Let write_dis_pll1_ch2_div2_byp(aData)
        set_dis_pll1_ch2_div2_byp = aData
        write
    End Property

    Property Get get_pcie_gen1_sel_ovr
        get_pcie_gen1_sel_ovr = read_pcie_gen1_sel_ovr_value
    End Property

    Property Let set_pcie_gen1_sel_ovr(aData)
        write_pcie_gen1_sel_ovr_value = aData
        flag_pcie_gen1_sel_ovr        = &H1
    End Property

    Property Get read_pcie_gen1_sel_ovr
        read
        read_pcie_gen1_sel_ovr = read_pcie_gen1_sel_ovr_value
    End Property

    Property Let write_pcie_gen1_sel_ovr(aData)
        set_pcie_gen1_sel_ovr = aData
        write
    End Property

    Property Get get_pciemac_ptp_sel
        get_pciemac_ptp_sel = read_pciemac_ptp_sel_value
    End Property

    Property Let set_pciemac_ptp_sel(aData)
        write_pciemac_ptp_sel_value = aData
        flag_pciemac_ptp_sel        = &H1
    End Property

    Property Get read_pciemac_ptp_sel
        read
        read_pciemac_ptp_sel = read_pciemac_ptp_sel_value
    End Property

    Property Let write_pciemac_ptp_sel(aData)
        set_pciemac_ptp_sel = aData
        write
    End Property

    Property Get get_qspiclk_sel
        get_qspiclk_sel = read_qspiclk_sel_value
    End Property

    Property Let set_qspiclk_sel(aData)
        write_qspiclk_sel_value = aData
        flag_qspiclk_sel        = &H1
    End Property

    Property Get read_qspiclk_sel
        read
        read_qspiclk_sel = read_qspiclk_sel_value
    End Property

    Property Let write_qspiclk_sel(aData)
        set_qspiclk_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_pll1_ch2_div2_byp_value = rightShift(data_low, 4) and &H1
        read_pcie_gen1_sel_ovr_value = rightShift(data_low, 2) and &H3
        read_pciemac_ptp_sel_value = rightShift(data_low, 1) and &H1
        qspiclk_sel_mask = &H1
        if data_low > LONG_MAX then
            if qspiclk_sel_mask = mask then
                read_qspiclk_sel_value = data_low
            else
                read_qspiclk_sel_value = (data_low - H8000_0000) and qspiclk_sel_mask
            end If
        else
            read_qspiclk_sel_value = data_low and qspiclk_sel_mask
        end If

    End Sub

    Sub write
        If flag_dis_pll1_ch2_div2_byp = &H0 or flag_pcie_gen1_sel_ovr = &H0 or flag_pciemac_ptp_sel = &H0 or flag_qspiclk_sel = &H0 Then read
        If flag_dis_pll1_ch2_div2_byp = &H0 Then write_dis_pll1_ch2_div2_byp_value = get_dis_pll1_ch2_div2_byp
        If flag_pcie_gen1_sel_ovr = &H0 Then write_pcie_gen1_sel_ovr_value = get_pcie_gen1_sel_ovr
        If flag_pciemac_ptp_sel = &H0 Then write_pciemac_ptp_sel_value = get_pciemac_ptp_sel
        If flag_qspiclk_sel = &H0 Then write_qspiclk_sel_value = get_qspiclk_sel

        regValue = leftShift((write_dis_pll1_ch2_div2_byp_value and &H1), 4) + leftShift((write_pcie_gen1_sel_ovr_value and &H3), 2) + leftShift((write_pciemac_ptp_sel_value and &H1), 1) + leftShift((write_qspiclk_sel_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dis_pll1_ch2_div2_byp_value = rightShift(data_low, 4) and &H1
        read_pcie_gen1_sel_ovr_value = rightShift(data_low, 2) and &H3
        read_pciemac_ptp_sel_value = rightShift(data_low, 1) and &H1
        qspiclk_sel_mask = &H1
        if data_low > LONG_MAX then
            if qspiclk_sel_mask = mask then
                read_qspiclk_sel_value = data_low
            else
                read_qspiclk_sel_value = (data_low - H8000_0000) and qspiclk_sel_mask
            end If
        else
            read_qspiclk_sel_value = data_low and qspiclk_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dis_pll1_ch2_div2_byp_value = &H0
        flag_dis_pll1_ch2_div2_byp        = &H0
        write_pcie_gen1_sel_ovr_value = &H0
        flag_pcie_gen1_sel_ovr        = &H0
        write_pciemac_ptp_sel_value = &H0
        flag_pciemac_ptp_sel        = &H0
        write_qspiclk_sel_value = &H0
        flag_qspiclk_sel        = &H0
    End Sub
End Class


'' @REGISTER : CRG_iddq_chip
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' iddq_chip                                  [15:0]           get_iddq_chip
''                                                             set_iddq_chip
''                                                             read_iddq_chip
''                                                             write_iddq_chip
''---------------------------------------------------------------------------------
Class REGISTER_CRG_iddq_chip
    Private write_iddq_chip_value
    Private read_iddq_chip_value
    Private flag_iddq_chip

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

    Property Get get_iddq_chip
        get_iddq_chip = read_iddq_chip_value
    End Property

    Property Let set_iddq_chip(aData)
        write_iddq_chip_value = aData
        flag_iddq_chip        = &H1
    End Property

    Property Get read_iddq_chip
        read
        read_iddq_chip = read_iddq_chip_value
    End Property

    Property Let write_iddq_chip(aData)
        set_iddq_chip = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        iddq_chip_mask = &Hffff
        if data_low > LONG_MAX then
            if iddq_chip_mask = mask then
                read_iddq_chip_value = data_low
            else
                read_iddq_chip_value = (data_low - H8000_0000) and iddq_chip_mask
            end If
        else
            read_iddq_chip_value = data_low and iddq_chip_mask
        end If

    End Sub

    Sub write
        If flag_iddq_chip = &H0 Then read
        If flag_iddq_chip = &H0 Then write_iddq_chip_value = get_iddq_chip

        regValue = leftShift((write_iddq_chip_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        iddq_chip_mask = &Hffff
        if data_low > LONG_MAX then
            if iddq_chip_mask = mask then
                read_iddq_chip_value = data_low
            else
                read_iddq_chip_value = (data_low - H8000_0000) and iddq_chip_mask
            end If
        else
            read_iddq_chip_value = data_low and iddq_chip_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_iddq_chip_value = &H0
        flag_iddq_chip        = &H0
    End Sub
End Class


'' @REGISTER : CRG_iddq_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' iddq_brphy0                                [11:11]          get_iddq_brphy0
''                                                             set_iddq_brphy0
''                                                             read_iddq_brphy0
''                                                             write_iddq_brphy0
''---------------------------------------------------------------------------------
'' iddq_brphy_1g_1port                        [10:10]          get_iddq_brphy_1g_1port
''                                                             set_iddq_brphy_1g_1port
''                                                             read_iddq_brphy_1g_1port
''                                                             write_iddq_brphy_1g_1port
''---------------------------------------------------------------------------------
'' iddq_sgmii_plus2                           [9:9]            get_iddq_sgmii_plus2
''                                                             set_iddq_sgmii_plus2
''                                                             read_iddq_sgmii_plus2
''                                                             write_iddq_sgmii_plus2
''---------------------------------------------------------------------------------
'' iddq_rgmii3                                [8:8]            get_iddq_rgmii3
''                                                             set_iddq_rgmii3
''                                                             read_iddq_rgmii3
''                                                             write_iddq_rgmii3
''---------------------------------------------------------------------------------
'' iddq_rgmii2                                [7:7]            get_iddq_rgmii2
''                                                             set_iddq_rgmii2
''                                                             read_iddq_rgmii2
''                                                             write_iddq_rgmii2
''---------------------------------------------------------------------------------
'' iddq_rgmii1                                [6:6]            get_iddq_rgmii1
''                                                             set_iddq_rgmii1
''                                                             read_iddq_rgmii1
''                                                             write_iddq_rgmii1
''---------------------------------------------------------------------------------
'' iddq_sgmii_plusr                           [5:5]            get_iddq_sgmii_plusr
''                                                             set_iddq_sgmii_plusr
''                                                             read_iddq_sgmii_plusr
''                                                             write_iddq_sgmii_plusr
''---------------------------------------------------------------------------------
'' iddq_brphy4                                [4:4]            get_iddq_brphy4
''                                                             set_iddq_brphy4
''                                                             read_iddq_brphy4
''                                                             write_iddq_brphy4
''---------------------------------------------------------------------------------
'' iddq_brphy3                                [3:3]            get_iddq_brphy3
''                                                             set_iddq_brphy3
''                                                             read_iddq_brphy3
''                                                             write_iddq_brphy3
''---------------------------------------------------------------------------------
'' iddq_brphy2                                [2:2]            get_iddq_brphy2
''                                                             set_iddq_brphy2
''                                                             read_iddq_brphy2
''                                                             write_iddq_brphy2
''---------------------------------------------------------------------------------
'' iddq_brphy1                                [1:1]            get_iddq_brphy1
''                                                             set_iddq_brphy1
''                                                             read_iddq_brphy1
''                                                             write_iddq_brphy1
''---------------------------------------------------------------------------------
'' iddq_sgmii_pcie                            [0:0]            get_iddq_sgmii_pcie
''                                                             set_iddq_sgmii_pcie
''                                                             read_iddq_sgmii_pcie
''                                                             write_iddq_sgmii_pcie
''---------------------------------------------------------------------------------
Class REGISTER_CRG_iddq_config
    Private write_iddq_brphy0_value
    Private read_iddq_brphy0_value
    Private flag_iddq_brphy0
    Private write_iddq_brphy_1g_1port_value
    Private read_iddq_brphy_1g_1port_value
    Private flag_iddq_brphy_1g_1port
    Private write_iddq_sgmii_plus2_value
    Private read_iddq_sgmii_plus2_value
    Private flag_iddq_sgmii_plus2
    Private write_iddq_rgmii3_value
    Private read_iddq_rgmii3_value
    Private flag_iddq_rgmii3
    Private write_iddq_rgmii2_value
    Private read_iddq_rgmii2_value
    Private flag_iddq_rgmii2
    Private write_iddq_rgmii1_value
    Private read_iddq_rgmii1_value
    Private flag_iddq_rgmii1
    Private write_iddq_sgmii_plusr_value
    Private read_iddq_sgmii_plusr_value
    Private flag_iddq_sgmii_plusr
    Private write_iddq_brphy4_value
    Private read_iddq_brphy4_value
    Private flag_iddq_brphy4
    Private write_iddq_brphy3_value
    Private read_iddq_brphy3_value
    Private flag_iddq_brphy3
    Private write_iddq_brphy2_value
    Private read_iddq_brphy2_value
    Private flag_iddq_brphy2
    Private write_iddq_brphy1_value
    Private read_iddq_brphy1_value
    Private flag_iddq_brphy1
    Private write_iddq_sgmii_pcie_value
    Private read_iddq_sgmii_pcie_value
    Private flag_iddq_sgmii_pcie

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_iddq_brphy0
        get_iddq_brphy0 = read_iddq_brphy0_value
    End Property

    Property Let set_iddq_brphy0(aData)
        write_iddq_brphy0_value = aData
        flag_iddq_brphy0        = &H1
    End Property

    Property Get read_iddq_brphy0
        read
        read_iddq_brphy0 = read_iddq_brphy0_value
    End Property

    Property Let write_iddq_brphy0(aData)
        set_iddq_brphy0 = aData
        write
    End Property

    Property Get get_iddq_brphy_1g_1port
        get_iddq_brphy_1g_1port = read_iddq_brphy_1g_1port_value
    End Property

    Property Let set_iddq_brphy_1g_1port(aData)
        write_iddq_brphy_1g_1port_value = aData
        flag_iddq_brphy_1g_1port        = &H1
    End Property

    Property Get read_iddq_brphy_1g_1port
        read
        read_iddq_brphy_1g_1port = read_iddq_brphy_1g_1port_value
    End Property

    Property Let write_iddq_brphy_1g_1port(aData)
        set_iddq_brphy_1g_1port = aData
        write
    End Property

    Property Get get_iddq_sgmii_plus2
        get_iddq_sgmii_plus2 = read_iddq_sgmii_plus2_value
    End Property

    Property Let set_iddq_sgmii_plus2(aData)
        write_iddq_sgmii_plus2_value = aData
        flag_iddq_sgmii_plus2        = &H1
    End Property

    Property Get read_iddq_sgmii_plus2
        read
        read_iddq_sgmii_plus2 = read_iddq_sgmii_plus2_value
    End Property

    Property Let write_iddq_sgmii_plus2(aData)
        set_iddq_sgmii_plus2 = aData
        write
    End Property

    Property Get get_iddq_rgmii3
        get_iddq_rgmii3 = read_iddq_rgmii3_value
    End Property

    Property Let set_iddq_rgmii3(aData)
        write_iddq_rgmii3_value = aData
        flag_iddq_rgmii3        = &H1
    End Property

    Property Get read_iddq_rgmii3
        read
        read_iddq_rgmii3 = read_iddq_rgmii3_value
    End Property

    Property Let write_iddq_rgmii3(aData)
        set_iddq_rgmii3 = aData
        write
    End Property

    Property Get get_iddq_rgmii2
        get_iddq_rgmii2 = read_iddq_rgmii2_value
    End Property

    Property Let set_iddq_rgmii2(aData)
        write_iddq_rgmii2_value = aData
        flag_iddq_rgmii2        = &H1
    End Property

    Property Get read_iddq_rgmii2
        read
        read_iddq_rgmii2 = read_iddq_rgmii2_value
    End Property

    Property Let write_iddq_rgmii2(aData)
        set_iddq_rgmii2 = aData
        write
    End Property

    Property Get get_iddq_rgmii1
        get_iddq_rgmii1 = read_iddq_rgmii1_value
    End Property

    Property Let set_iddq_rgmii1(aData)
        write_iddq_rgmii1_value = aData
        flag_iddq_rgmii1        = &H1
    End Property

    Property Get read_iddq_rgmii1
        read
        read_iddq_rgmii1 = read_iddq_rgmii1_value
    End Property

    Property Let write_iddq_rgmii1(aData)
        set_iddq_rgmii1 = aData
        write
    End Property

    Property Get get_iddq_sgmii_plusr
        get_iddq_sgmii_plusr = read_iddq_sgmii_plusr_value
    End Property

    Property Let set_iddq_sgmii_plusr(aData)
        write_iddq_sgmii_plusr_value = aData
        flag_iddq_sgmii_plusr        = &H1
    End Property

    Property Get read_iddq_sgmii_plusr
        read
        read_iddq_sgmii_plusr = read_iddq_sgmii_plusr_value
    End Property

    Property Let write_iddq_sgmii_plusr(aData)
        set_iddq_sgmii_plusr = aData
        write
    End Property

    Property Get get_iddq_brphy4
        get_iddq_brphy4 = read_iddq_brphy4_value
    End Property

    Property Let set_iddq_brphy4(aData)
        write_iddq_brphy4_value = aData
        flag_iddq_brphy4        = &H1
    End Property

    Property Get read_iddq_brphy4
        read
        read_iddq_brphy4 = read_iddq_brphy4_value
    End Property

    Property Let write_iddq_brphy4(aData)
        set_iddq_brphy4 = aData
        write
    End Property

    Property Get get_iddq_brphy3
        get_iddq_brphy3 = read_iddq_brphy3_value
    End Property

    Property Let set_iddq_brphy3(aData)
        write_iddq_brphy3_value = aData
        flag_iddq_brphy3        = &H1
    End Property

    Property Get read_iddq_brphy3
        read
        read_iddq_brphy3 = read_iddq_brphy3_value
    End Property

    Property Let write_iddq_brphy3(aData)
        set_iddq_brphy3 = aData
        write
    End Property

    Property Get get_iddq_brphy2
        get_iddq_brphy2 = read_iddq_brphy2_value
    End Property

    Property Let set_iddq_brphy2(aData)
        write_iddq_brphy2_value = aData
        flag_iddq_brphy2        = &H1
    End Property

    Property Get read_iddq_brphy2
        read
        read_iddq_brphy2 = read_iddq_brphy2_value
    End Property

    Property Let write_iddq_brphy2(aData)
        set_iddq_brphy2 = aData
        write
    End Property

    Property Get get_iddq_brphy1
        get_iddq_brphy1 = read_iddq_brphy1_value
    End Property

    Property Let set_iddq_brphy1(aData)
        write_iddq_brphy1_value = aData
        flag_iddq_brphy1        = &H1
    End Property

    Property Get read_iddq_brphy1
        read
        read_iddq_brphy1 = read_iddq_brphy1_value
    End Property

    Property Let write_iddq_brphy1(aData)
        set_iddq_brphy1 = aData
        write
    End Property

    Property Get get_iddq_sgmii_pcie
        get_iddq_sgmii_pcie = read_iddq_sgmii_pcie_value
    End Property

    Property Let set_iddq_sgmii_pcie(aData)
        write_iddq_sgmii_pcie_value = aData
        flag_iddq_sgmii_pcie        = &H1
    End Property

    Property Get read_iddq_sgmii_pcie
        read
        read_iddq_sgmii_pcie = read_iddq_sgmii_pcie_value
    End Property

    Property Let write_iddq_sgmii_pcie(aData)
        set_iddq_sgmii_pcie = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_iddq_brphy0_value = rightShift(data_low, 11) and &H1
        read_iddq_brphy_1g_1port_value = rightShift(data_low, 10) and &H1
        read_iddq_sgmii_plus2_value = rightShift(data_low, 9) and &H1
        read_iddq_rgmii3_value = rightShift(data_low, 8) and &H1
        read_iddq_rgmii2_value = rightShift(data_low, 7) and &H1
        read_iddq_rgmii1_value = rightShift(data_low, 6) and &H1
        read_iddq_sgmii_plusr_value = rightShift(data_low, 5) and &H1
        read_iddq_brphy4_value = rightShift(data_low, 4) and &H1
        read_iddq_brphy3_value = rightShift(data_low, 3) and &H1
        read_iddq_brphy2_value = rightShift(data_low, 2) and &H1
        read_iddq_brphy1_value = rightShift(data_low, 1) and &H1
        iddq_sgmii_pcie_mask = &H1
        if data_low > LONG_MAX then
            if iddq_sgmii_pcie_mask = mask then
                read_iddq_sgmii_pcie_value = data_low
            else
                read_iddq_sgmii_pcie_value = (data_low - H8000_0000) and iddq_sgmii_pcie_mask
            end If
        else
            read_iddq_sgmii_pcie_value = data_low and iddq_sgmii_pcie_mask
        end If

    End Sub

    Sub write
        If flag_iddq_brphy0 = &H0 or flag_iddq_brphy_1g_1port = &H0 or flag_iddq_sgmii_plus2 = &H0 or flag_iddq_rgmii3 = &H0 or flag_iddq_rgmii2 = &H0 or flag_iddq_rgmii1 = &H0 or flag_iddq_sgmii_plusr = &H0 or flag_iddq_brphy4 = &H0 or flag_iddq_brphy3 = &H0 or flag_iddq_brphy2 = &H0 or flag_iddq_brphy1 = &H0 or flag_iddq_sgmii_pcie = &H0 Then read
        If flag_iddq_brphy0 = &H0 Then write_iddq_brphy0_value = get_iddq_brphy0
        If flag_iddq_brphy_1g_1port = &H0 Then write_iddq_brphy_1g_1port_value = get_iddq_brphy_1g_1port
        If flag_iddq_sgmii_plus2 = &H0 Then write_iddq_sgmii_plus2_value = get_iddq_sgmii_plus2
        If flag_iddq_rgmii3 = &H0 Then write_iddq_rgmii3_value = get_iddq_rgmii3
        If flag_iddq_rgmii2 = &H0 Then write_iddq_rgmii2_value = get_iddq_rgmii2
        If flag_iddq_rgmii1 = &H0 Then write_iddq_rgmii1_value = get_iddq_rgmii1
        If flag_iddq_sgmii_plusr = &H0 Then write_iddq_sgmii_plusr_value = get_iddq_sgmii_plusr
        If flag_iddq_brphy4 = &H0 Then write_iddq_brphy4_value = get_iddq_brphy4
        If flag_iddq_brphy3 = &H0 Then write_iddq_brphy3_value = get_iddq_brphy3
        If flag_iddq_brphy2 = &H0 Then write_iddq_brphy2_value = get_iddq_brphy2
        If flag_iddq_brphy1 = &H0 Then write_iddq_brphy1_value = get_iddq_brphy1
        If flag_iddq_sgmii_pcie = &H0 Then write_iddq_sgmii_pcie_value = get_iddq_sgmii_pcie

        regValue = leftShift((write_iddq_brphy0_value and &H1), 11) + leftShift((write_iddq_brphy_1g_1port_value and &H1), 10) + leftShift((write_iddq_sgmii_plus2_value and &H1), 9) + leftShift((write_iddq_rgmii3_value and &H1), 8) + leftShift((write_iddq_rgmii2_value and &H1), 7) + leftShift((write_iddq_rgmii1_value and &H1), 6) + leftShift((write_iddq_sgmii_plusr_value and &H1), 5) + leftShift((write_iddq_brphy4_value and &H1), 4) + leftShift((write_iddq_brphy3_value and &H1), 3) + leftShift((write_iddq_brphy2_value and &H1), 2) + leftShift((write_iddq_brphy1_value and &H1), 1) + leftShift((write_iddq_sgmii_pcie_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_iddq_brphy0_value = rightShift(data_low, 11) and &H1
        read_iddq_brphy_1g_1port_value = rightShift(data_low, 10) and &H1
        read_iddq_sgmii_plus2_value = rightShift(data_low, 9) and &H1
        read_iddq_rgmii3_value = rightShift(data_low, 8) and &H1
        read_iddq_rgmii2_value = rightShift(data_low, 7) and &H1
        read_iddq_rgmii1_value = rightShift(data_low, 6) and &H1
        read_iddq_sgmii_plusr_value = rightShift(data_low, 5) and &H1
        read_iddq_brphy4_value = rightShift(data_low, 4) and &H1
        read_iddq_brphy3_value = rightShift(data_low, 3) and &H1
        read_iddq_brphy2_value = rightShift(data_low, 2) and &H1
        read_iddq_brphy1_value = rightShift(data_low, 1) and &H1
        iddq_sgmii_pcie_mask = &H1
        if data_low > LONG_MAX then
            if iddq_sgmii_pcie_mask = mask then
                read_iddq_sgmii_pcie_value = data_low
            else
                read_iddq_sgmii_pcie_value = (data_low - H8000_0000) and iddq_sgmii_pcie_mask
            end If
        else
            read_iddq_sgmii_pcie_value = data_low and iddq_sgmii_pcie_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_iddq_brphy0_value = &H0
        flag_iddq_brphy0        = &H0
        write_iddq_brphy_1g_1port_value = &H0
        flag_iddq_brphy_1g_1port        = &H0
        write_iddq_sgmii_plus2_value = &H0
        flag_iddq_sgmii_plus2        = &H0
        write_iddq_rgmii3_value = &H0
        flag_iddq_rgmii3        = &H0
        write_iddq_rgmii2_value = &H0
        flag_iddq_rgmii2        = &H0
        write_iddq_rgmii1_value = &H0
        flag_iddq_rgmii1        = &H0
        write_iddq_sgmii_plusr_value = &H0
        flag_iddq_sgmii_plusr        = &H0
        write_iddq_brphy4_value = &H0
        flag_iddq_brphy4        = &H0
        write_iddq_brphy3_value = &H0
        flag_iddq_brphy3        = &H0
        write_iddq_brphy2_value = &H0
        flag_iddq_brphy2        = &H0
        write_iddq_brphy1_value = &H0
        flag_iddq_brphy1        = &H0
        write_iddq_sgmii_pcie_value = &H0
        flag_iddq_sgmii_pcie        = &H0
    End Sub
End Class


'' @REGISTER : CRG_reset_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' global_srst_en                             [15:15]          get_global_srst_en
''                                                             set_global_srst_en
''                                                             read_global_srst_en
''                                                             write_global_srst_en
''---------------------------------------------------------------------------------
'' srst_pciess                                [13:13]          get_srst_pciess
''                                                             set_srst_pciess
''                                                             read_srst_pciess
''                                                             write_srst_pciess
''---------------------------------------------------------------------------------
'' srst_sgmiipcie                             [12:12]          get_srst_sgmiipcie
''                                                             set_srst_sgmiipcie
''                                                             read_srst_sgmiipcie
''                                                             write_srst_sgmiipcie
''---------------------------------------------------------------------------------
'' wdg_clr                                    [11:11]          get_wdg_clr
''                                                             set_wdg_clr
''                                                             read_wdg_clr
''                                                             write_wdg_clr
''---------------------------------------------------------------------------------
'' wdg_status                                 [10:10]          get_wdg_status
''                                                             set_wdg_status
''                                                             read_wdg_status
''                                                             write_wdg_status
''---------------------------------------------------------------------------------
'' wdg_en                                     [9:9]            get_wdg_en
''                                                             set_wdg_en
''                                                             read_wdg_en
''                                                             write_wdg_en
''---------------------------------------------------------------------------------
'' pvtmon_rst_en                              [8:8]            get_pvtmon_rst_en
''                                                             set_pvtmon_rst_en
''                                                             read_pvtmon_rst_en
''                                                             write_pvtmon_rst_en
''---------------------------------------------------------------------------------
'' srst_macsec                                [7:7]            get_srst_macsec
''                                                             set_srst_macsec
''                                                             read_srst_macsec
''                                                             write_srst_macsec
''---------------------------------------------------------------------------------
'' srst_gmii2                                 [6:6]            get_srst_gmii2
''                                                             set_srst_gmii2
''                                                             read_srst_gmii2
''                                                             write_srst_gmii2
''---------------------------------------------------------------------------------
'' srst_gmii1                                 [5:5]            get_srst_gmii1
''                                                             set_srst_gmii1
''                                                             read_srst_gmii1
''                                                             write_srst_gmii1
''---------------------------------------------------------------------------------
'' srst_sgmii_plus2                           [4:4]            get_srst_sgmii_plus2
''                                                             set_srst_sgmii_plus2
''                                                             read_srst_sgmii_plus2
''                                                             write_srst_sgmii_plus2
''---------------------------------------------------------------------------------
'' srst_soc                                   [3:3]            get_srst_soc
''                                                             set_srst_soc
''                                                             read_srst_soc
''                                                             write_srst_soc
''---------------------------------------------------------------------------------
'' srst_switch                                [2:2]            get_srst_switch
''                                                             set_srst_switch
''                                                             read_srst_switch
''                                                             write_srst_switch
''---------------------------------------------------------------------------------
'' srst_brphys                                [1:1]            get_srst_brphys
''                                                             set_srst_brphys
''                                                             read_srst_brphys
''                                                             write_srst_brphys
''---------------------------------------------------------------------------------
'' srst_chip                                  [0:0]            get_srst_chip
''                                                             set_srst_chip
''                                                             read_srst_chip
''                                                             write_srst_chip
''---------------------------------------------------------------------------------
Class REGISTER_CRG_reset_config
    Private write_global_srst_en_value
    Private read_global_srst_en_value
    Private flag_global_srst_en
    Private write_srst_pciess_value
    Private read_srst_pciess_value
    Private flag_srst_pciess
    Private write_srst_sgmiipcie_value
    Private read_srst_sgmiipcie_value
    Private flag_srst_sgmiipcie
    Private write_wdg_clr_value
    Private read_wdg_clr_value
    Private flag_wdg_clr
    Private write_wdg_status_value
    Private read_wdg_status_value
    Private flag_wdg_status
    Private write_wdg_en_value
    Private read_wdg_en_value
    Private flag_wdg_en
    Private write_pvtmon_rst_en_value
    Private read_pvtmon_rst_en_value
    Private flag_pvtmon_rst_en
    Private write_srst_macsec_value
    Private read_srst_macsec_value
    Private flag_srst_macsec
    Private write_srst_gmii2_value
    Private read_srst_gmii2_value
    Private flag_srst_gmii2
    Private write_srst_gmii1_value
    Private read_srst_gmii1_value
    Private flag_srst_gmii1
    Private write_srst_sgmii_plus2_value
    Private read_srst_sgmii_plus2_value
    Private flag_srst_sgmii_plus2
    Private write_srst_soc_value
    Private read_srst_soc_value
    Private flag_srst_soc
    Private write_srst_switch_value
    Private read_srst_switch_value
    Private flag_srst_switch
    Private write_srst_brphys_value
    Private read_srst_brphys_value
    Private flag_srst_brphys
    Private write_srst_chip_value
    Private read_srst_chip_value
    Private flag_srst_chip

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

    Property Get get_global_srst_en
        get_global_srst_en = read_global_srst_en_value
    End Property

    Property Let set_global_srst_en(aData)
        write_global_srst_en_value = aData
        flag_global_srst_en        = &H1
    End Property

    Property Get read_global_srst_en
        read
        read_global_srst_en = read_global_srst_en_value
    End Property

    Property Let write_global_srst_en(aData)
        set_global_srst_en = aData
        write
    End Property

    Property Get get_srst_pciess
        get_srst_pciess = read_srst_pciess_value
    End Property

    Property Let set_srst_pciess(aData)
        write_srst_pciess_value = aData
        flag_srst_pciess        = &H1
    End Property

    Property Get read_srst_pciess
        read
        read_srst_pciess = read_srst_pciess_value
    End Property

    Property Let write_srst_pciess(aData)
        set_srst_pciess = aData
        write
    End Property

    Property Get get_srst_sgmiipcie
        get_srst_sgmiipcie = read_srst_sgmiipcie_value
    End Property

    Property Let set_srst_sgmiipcie(aData)
        write_srst_sgmiipcie_value = aData
        flag_srst_sgmiipcie        = &H1
    End Property

    Property Get read_srst_sgmiipcie
        read
        read_srst_sgmiipcie = read_srst_sgmiipcie_value
    End Property

    Property Let write_srst_sgmiipcie(aData)
        set_srst_sgmiipcie = aData
        write
    End Property

    Property Get get_wdg_clr
        get_wdg_clr = read_wdg_clr_value
    End Property

    Property Let set_wdg_clr(aData)
        write_wdg_clr_value = aData
        flag_wdg_clr        = &H1
    End Property

    Property Get read_wdg_clr
        read
        read_wdg_clr = read_wdg_clr_value
    End Property

    Property Let write_wdg_clr(aData)
        set_wdg_clr = aData
        write
    End Property

    Property Get get_wdg_status
        get_wdg_status = read_wdg_status_value
    End Property

    Property Let set_wdg_status(aData)
        write_wdg_status_value = aData
        flag_wdg_status        = &H1
    End Property

    Property Get read_wdg_status
        read
        read_wdg_status = read_wdg_status_value
    End Property

    Property Let write_wdg_status(aData)
        set_wdg_status = aData
        write
    End Property

    Property Get get_wdg_en
        get_wdg_en = read_wdg_en_value
    End Property

    Property Let set_wdg_en(aData)
        write_wdg_en_value = aData
        flag_wdg_en        = &H1
    End Property

    Property Get read_wdg_en
        read
        read_wdg_en = read_wdg_en_value
    End Property

    Property Let write_wdg_en(aData)
        set_wdg_en = aData
        write
    End Property

    Property Get get_pvtmon_rst_en
        get_pvtmon_rst_en = read_pvtmon_rst_en_value
    End Property

    Property Let set_pvtmon_rst_en(aData)
        write_pvtmon_rst_en_value = aData
        flag_pvtmon_rst_en        = &H1
    End Property

    Property Get read_pvtmon_rst_en
        read
        read_pvtmon_rst_en = read_pvtmon_rst_en_value
    End Property

    Property Let write_pvtmon_rst_en(aData)
        set_pvtmon_rst_en = aData
        write
    End Property

    Property Get get_srst_macsec
        get_srst_macsec = read_srst_macsec_value
    End Property

    Property Let set_srst_macsec(aData)
        write_srst_macsec_value = aData
        flag_srst_macsec        = &H1
    End Property

    Property Get read_srst_macsec
        read
        read_srst_macsec = read_srst_macsec_value
    End Property

    Property Let write_srst_macsec(aData)
        set_srst_macsec = aData
        write
    End Property

    Property Get get_srst_gmii2
        get_srst_gmii2 = read_srst_gmii2_value
    End Property

    Property Let set_srst_gmii2(aData)
        write_srst_gmii2_value = aData
        flag_srst_gmii2        = &H1
    End Property

    Property Get read_srst_gmii2
        read
        read_srst_gmii2 = read_srst_gmii2_value
    End Property

    Property Let write_srst_gmii2(aData)
        set_srst_gmii2 = aData
        write
    End Property

    Property Get get_srst_gmii1
        get_srst_gmii1 = read_srst_gmii1_value
    End Property

    Property Let set_srst_gmii1(aData)
        write_srst_gmii1_value = aData
        flag_srst_gmii1        = &H1
    End Property

    Property Get read_srst_gmii1
        read
        read_srst_gmii1 = read_srst_gmii1_value
    End Property

    Property Let write_srst_gmii1(aData)
        set_srst_gmii1 = aData
        write
    End Property

    Property Get get_srst_sgmii_plus2
        get_srst_sgmii_plus2 = read_srst_sgmii_plus2_value
    End Property

    Property Let set_srst_sgmii_plus2(aData)
        write_srst_sgmii_plus2_value = aData
        flag_srst_sgmii_plus2        = &H1
    End Property

    Property Get read_srst_sgmii_plus2
        read
        read_srst_sgmii_plus2 = read_srst_sgmii_plus2_value
    End Property

    Property Let write_srst_sgmii_plus2(aData)
        set_srst_sgmii_plus2 = aData
        write
    End Property

    Property Get get_srst_soc
        get_srst_soc = read_srst_soc_value
    End Property

    Property Let set_srst_soc(aData)
        write_srst_soc_value = aData
        flag_srst_soc        = &H1
    End Property

    Property Get read_srst_soc
        read
        read_srst_soc = read_srst_soc_value
    End Property

    Property Let write_srst_soc(aData)
        set_srst_soc = aData
        write
    End Property

    Property Get get_srst_switch
        get_srst_switch = read_srst_switch_value
    End Property

    Property Let set_srst_switch(aData)
        write_srst_switch_value = aData
        flag_srst_switch        = &H1
    End Property

    Property Get read_srst_switch
        read
        read_srst_switch = read_srst_switch_value
    End Property

    Property Let write_srst_switch(aData)
        set_srst_switch = aData
        write
    End Property

    Property Get get_srst_brphys
        get_srst_brphys = read_srst_brphys_value
    End Property

    Property Let set_srst_brphys(aData)
        write_srst_brphys_value = aData
        flag_srst_brphys        = &H1
    End Property

    Property Get read_srst_brphys
        read
        read_srst_brphys = read_srst_brphys_value
    End Property

    Property Let write_srst_brphys(aData)
        set_srst_brphys = aData
        write
    End Property

    Property Get get_srst_chip
        get_srst_chip = read_srst_chip_value
    End Property

    Property Let set_srst_chip(aData)
        write_srst_chip_value = aData
        flag_srst_chip        = &H1
    End Property

    Property Get read_srst_chip
        read
        read_srst_chip = read_srst_chip_value
    End Property

    Property Let write_srst_chip(aData)
        set_srst_chip = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_global_srst_en_value = rightShift(data_low, 15) and &H1
        read_srst_pciess_value = rightShift(data_low, 13) and &H1
        read_srst_sgmiipcie_value = rightShift(data_low, 12) and &H1
        read_wdg_clr_value = rightShift(data_low, 11) and &H1
        read_wdg_status_value = rightShift(data_low, 10) and &H1
        read_wdg_en_value = rightShift(data_low, 9) and &H1
        read_pvtmon_rst_en_value = rightShift(data_low, 8) and &H1
        read_srst_macsec_value = rightShift(data_low, 7) and &H1
        read_srst_gmii2_value = rightShift(data_low, 6) and &H1
        read_srst_gmii1_value = rightShift(data_low, 5) and &H1
        read_srst_sgmii_plus2_value = rightShift(data_low, 4) and &H1
        read_srst_soc_value = rightShift(data_low, 3) and &H1
        read_srst_switch_value = rightShift(data_low, 2) and &H1
        read_srst_brphys_value = rightShift(data_low, 1) and &H1
        srst_chip_mask = &H1
        if data_low > LONG_MAX then
            if srst_chip_mask = mask then
                read_srst_chip_value = data_low
            else
                read_srst_chip_value = (data_low - H8000_0000) and srst_chip_mask
            end If
        else
            read_srst_chip_value = data_low and srst_chip_mask
        end If

    End Sub

    Sub write
        If flag_global_srst_en = &H0 or flag_srst_pciess = &H0 or flag_srst_sgmiipcie = &H0 or flag_wdg_clr = &H0 or flag_wdg_status = &H0 or flag_wdg_en = &H0 or flag_pvtmon_rst_en = &H0 or flag_srst_macsec = &H0 or flag_srst_gmii2 = &H0 or flag_srst_gmii1 = &H0 or flag_srst_sgmii_plus2 = &H0 or flag_srst_soc = &H0 or flag_srst_switch = &H0 or flag_srst_brphys = &H0 or flag_srst_chip = &H0 Then read
        If flag_global_srst_en = &H0 Then write_global_srst_en_value = get_global_srst_en
        If flag_srst_pciess = &H0 Then write_srst_pciess_value = get_srst_pciess
        If flag_srst_sgmiipcie = &H0 Then write_srst_sgmiipcie_value = get_srst_sgmiipcie
        If flag_wdg_clr = &H0 Then write_wdg_clr_value = get_wdg_clr
        If flag_wdg_status = &H0 Then write_wdg_status_value = get_wdg_status
        If flag_wdg_en = &H0 Then write_wdg_en_value = get_wdg_en
        If flag_pvtmon_rst_en = &H0 Then write_pvtmon_rst_en_value = get_pvtmon_rst_en
        If flag_srst_macsec = &H0 Then write_srst_macsec_value = get_srst_macsec
        If flag_srst_gmii2 = &H0 Then write_srst_gmii2_value = get_srst_gmii2
        If flag_srst_gmii1 = &H0 Then write_srst_gmii1_value = get_srst_gmii1
        If flag_srst_sgmii_plus2 = &H0 Then write_srst_sgmii_plus2_value = get_srst_sgmii_plus2
        If flag_srst_soc = &H0 Then write_srst_soc_value = get_srst_soc
        If flag_srst_switch = &H0 Then write_srst_switch_value = get_srst_switch
        If flag_srst_brphys = &H0 Then write_srst_brphys_value = get_srst_brphys
        If flag_srst_chip = &H0 Then write_srst_chip_value = get_srst_chip

        regValue = leftShift((write_global_srst_en_value and &H1), 15) + leftShift((write_srst_pciess_value and &H1), 13) + leftShift((write_srst_sgmiipcie_value and &H1), 12) + leftShift((write_wdg_clr_value and &H1), 11) + leftShift((write_wdg_status_value and &H1), 10) + leftShift((write_wdg_en_value and &H1), 9) + leftShift((write_pvtmon_rst_en_value and &H1), 8) + leftShift((write_srst_macsec_value and &H1), 7) + leftShift((write_srst_gmii2_value and &H1), 6) + leftShift((write_srst_gmii1_value and &H1), 5) + leftShift((write_srst_sgmii_plus2_value and &H1), 4) + leftShift((write_srst_soc_value and &H1), 3) + leftShift((write_srst_switch_value and &H1), 2) + leftShift((write_srst_brphys_value and &H1), 1) + leftShift((write_srst_chip_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_global_srst_en_value = rightShift(data_low, 15) and &H1
        read_srst_pciess_value = rightShift(data_low, 13) and &H1
        read_srst_sgmiipcie_value = rightShift(data_low, 12) and &H1
        read_wdg_clr_value = rightShift(data_low, 11) and &H1
        read_wdg_status_value = rightShift(data_low, 10) and &H1
        read_wdg_en_value = rightShift(data_low, 9) and &H1
        read_pvtmon_rst_en_value = rightShift(data_low, 8) and &H1
        read_srst_macsec_value = rightShift(data_low, 7) and &H1
        read_srst_gmii2_value = rightShift(data_low, 6) and &H1
        read_srst_gmii1_value = rightShift(data_low, 5) and &H1
        read_srst_sgmii_plus2_value = rightShift(data_low, 4) and &H1
        read_srst_soc_value = rightShift(data_low, 3) and &H1
        read_srst_switch_value = rightShift(data_low, 2) and &H1
        read_srst_brphys_value = rightShift(data_low, 1) and &H1
        srst_chip_mask = &H1
        if data_low > LONG_MAX then
            if srst_chip_mask = mask then
                read_srst_chip_value = data_low
            else
                read_srst_chip_value = (data_low - H8000_0000) and srst_chip_mask
            end If
        else
            read_srst_chip_value = data_low and srst_chip_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_global_srst_en_value = &H0
        flag_global_srst_en        = &H0
        write_srst_pciess_value = &H0
        flag_srst_pciess        = &H0
        write_srst_sgmiipcie_value = &H0
        flag_srst_sgmiipcie        = &H0
        write_wdg_clr_value = &H0
        flag_wdg_clr        = &H0
        write_wdg_status_value = &H0
        flag_wdg_status        = &H0
        write_wdg_en_value = &H0
        flag_wdg_en        = &H0
        write_pvtmon_rst_en_value = &H0
        flag_pvtmon_rst_en        = &H0
        write_srst_macsec_value = &H0
        flag_srst_macsec        = &H0
        write_srst_gmii2_value = &H0
        flag_srst_gmii2        = &H0
        write_srst_gmii1_value = &H0
        flag_srst_gmii1        = &H0
        write_srst_sgmii_plus2_value = &H0
        flag_srst_sgmii_plus2        = &H0
        write_srst_soc_value = &H0
        flag_srst_soc        = &H0
        write_srst_switch_value = &H0
        flag_srst_switch        = &H0
        write_srst_brphys_value = &H0
        flag_srst_brphys        = &H0
        write_srst_chip_value = &H0
        flag_srst_chip        = &H0
    End Sub
End Class


'' @REGISTER : CRG_reset_config2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' otp_fdone_timeout                          [15:15]          get_otp_fdone_timeout
''                                                             set_otp_fdone_timeout
''                                                             read_otp_fdone_timeout
''                                                             write_otp_fdone_timeout
''---------------------------------------------------------------------------------
'' srst_sgmii_plusr                           [7:7]            get_srst_sgmii_plusr
''                                                             set_srst_sgmii_plusr
''                                                             read_srst_sgmii_plusr
''                                                             write_srst_sgmii_plusr
''---------------------------------------------------------------------------------
'' srst_gmii3                                 [6:6]            get_srst_gmii3
''                                                             set_srst_gmii3
''                                                             read_srst_gmii3
''                                                             write_srst_gmii3
''---------------------------------------------------------------------------------
'' srst_brphy_1g_1port                        [5:5]            get_srst_brphy_1g_1port
''                                                             set_srst_brphy_1g_1port
''                                                             read_srst_brphy_1g_1port
''                                                             write_srst_brphy_1g_1port
''---------------------------------------------------------------------------------
'' srst_pcie_perst                            [4:4]            get_srst_pcie_perst
''                                                             set_srst_pcie_perst
''                                                             read_srst_pcie_perst
''                                                             write_srst_pcie_perst
''---------------------------------------------------------------------------------
'' srst_p1588_mii                             [1:1]            get_srst_p1588_mii
''                                                             set_srst_p1588_mii
''                                                             read_srst_p1588_mii
''                                                             write_srst_p1588_mii
''---------------------------------------------------------------------------------
'' srst_p1588                                 [0:0]            get_srst_p1588
''                                                             set_srst_p1588
''                                                             read_srst_p1588
''                                                             write_srst_p1588
''---------------------------------------------------------------------------------
Class REGISTER_CRG_reset_config2
    Private write_otp_fdone_timeout_value
    Private read_otp_fdone_timeout_value
    Private flag_otp_fdone_timeout
    Private write_srst_sgmii_plusr_value
    Private read_srst_sgmii_plusr_value
    Private flag_srst_sgmii_plusr
    Private write_srst_gmii3_value
    Private read_srst_gmii3_value
    Private flag_srst_gmii3
    Private write_srst_brphy_1g_1port_value
    Private read_srst_brphy_1g_1port_value
    Private flag_srst_brphy_1g_1port
    Private write_srst_pcie_perst_value
    Private read_srst_pcie_perst_value
    Private flag_srst_pcie_perst
    Private write_srst_p1588_mii_value
    Private read_srst_p1588_mii_value
    Private flag_srst_p1588_mii
    Private write_srst_p1588_value
    Private read_srst_p1588_value
    Private flag_srst_p1588

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

    Property Get get_otp_fdone_timeout
        get_otp_fdone_timeout = read_otp_fdone_timeout_value
    End Property

    Property Let set_otp_fdone_timeout(aData)
        write_otp_fdone_timeout_value = aData
        flag_otp_fdone_timeout        = &H1
    End Property

    Property Get read_otp_fdone_timeout
        read
        read_otp_fdone_timeout = read_otp_fdone_timeout_value
    End Property

    Property Let write_otp_fdone_timeout(aData)
        set_otp_fdone_timeout = aData
        write
    End Property

    Property Get get_srst_sgmii_plusr
        get_srst_sgmii_plusr = read_srst_sgmii_plusr_value
    End Property

    Property Let set_srst_sgmii_plusr(aData)
        write_srst_sgmii_plusr_value = aData
        flag_srst_sgmii_plusr        = &H1
    End Property

    Property Get read_srst_sgmii_plusr
        read
        read_srst_sgmii_plusr = read_srst_sgmii_plusr_value
    End Property

    Property Let write_srst_sgmii_plusr(aData)
        set_srst_sgmii_plusr = aData
        write
    End Property

    Property Get get_srst_gmii3
        get_srst_gmii3 = read_srst_gmii3_value
    End Property

    Property Let set_srst_gmii3(aData)
        write_srst_gmii3_value = aData
        flag_srst_gmii3        = &H1
    End Property

    Property Get read_srst_gmii3
        read
        read_srst_gmii3 = read_srst_gmii3_value
    End Property

    Property Let write_srst_gmii3(aData)
        set_srst_gmii3 = aData
        write
    End Property

    Property Get get_srst_brphy_1g_1port
        get_srst_brphy_1g_1port = read_srst_brphy_1g_1port_value
    End Property

    Property Let set_srst_brphy_1g_1port(aData)
        write_srst_brphy_1g_1port_value = aData
        flag_srst_brphy_1g_1port        = &H1
    End Property

    Property Get read_srst_brphy_1g_1port
        read
        read_srst_brphy_1g_1port = read_srst_brphy_1g_1port_value
    End Property

    Property Let write_srst_brphy_1g_1port(aData)
        set_srst_brphy_1g_1port = aData
        write
    End Property

    Property Get get_srst_pcie_perst
        get_srst_pcie_perst = read_srst_pcie_perst_value
    End Property

    Property Let set_srst_pcie_perst(aData)
        write_srst_pcie_perst_value = aData
        flag_srst_pcie_perst        = &H1
    End Property

    Property Get read_srst_pcie_perst
        read
        read_srst_pcie_perst = read_srst_pcie_perst_value
    End Property

    Property Let write_srst_pcie_perst(aData)
        set_srst_pcie_perst = aData
        write
    End Property

    Property Get get_srst_p1588_mii
        get_srst_p1588_mii = read_srst_p1588_mii_value
    End Property

    Property Let set_srst_p1588_mii(aData)
        write_srst_p1588_mii_value = aData
        flag_srst_p1588_mii        = &H1
    End Property

    Property Get read_srst_p1588_mii
        read
        read_srst_p1588_mii = read_srst_p1588_mii_value
    End Property

    Property Let write_srst_p1588_mii(aData)
        set_srst_p1588_mii = aData
        write
    End Property

    Property Get get_srst_p1588
        get_srst_p1588 = read_srst_p1588_value
    End Property

    Property Let set_srst_p1588(aData)
        write_srst_p1588_value = aData
        flag_srst_p1588        = &H1
    End Property

    Property Get read_srst_p1588
        read
        read_srst_p1588 = read_srst_p1588_value
    End Property

    Property Let write_srst_p1588(aData)
        set_srst_p1588 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_otp_fdone_timeout_value = rightShift(data_low, 15) and &H1
        read_srst_sgmii_plusr_value = rightShift(data_low, 7) and &H1
        read_srst_gmii3_value = rightShift(data_low, 6) and &H1
        read_srst_brphy_1g_1port_value = rightShift(data_low, 5) and &H1
        read_srst_pcie_perst_value = rightShift(data_low, 4) and &H1
        read_srst_p1588_mii_value = rightShift(data_low, 1) and &H1
        srst_p1588_mask = &H1
        if data_low > LONG_MAX then
            if srst_p1588_mask = mask then
                read_srst_p1588_value = data_low
            else
                read_srst_p1588_value = (data_low - H8000_0000) and srst_p1588_mask
            end If
        else
            read_srst_p1588_value = data_low and srst_p1588_mask
        end If

    End Sub

    Sub write
        If flag_otp_fdone_timeout = &H0 or flag_srst_sgmii_plusr = &H0 or flag_srst_gmii3 = &H0 or flag_srst_brphy_1g_1port = &H0 or flag_srst_pcie_perst = &H0 or flag_srst_p1588_mii = &H0 or flag_srst_p1588 = &H0 Then read
        If flag_otp_fdone_timeout = &H0 Then write_otp_fdone_timeout_value = get_otp_fdone_timeout
        If flag_srst_sgmii_plusr = &H0 Then write_srst_sgmii_plusr_value = get_srst_sgmii_plusr
        If flag_srst_gmii3 = &H0 Then write_srst_gmii3_value = get_srst_gmii3
        If flag_srst_brphy_1g_1port = &H0 Then write_srst_brphy_1g_1port_value = get_srst_brphy_1g_1port
        If flag_srst_pcie_perst = &H0 Then write_srst_pcie_perst_value = get_srst_pcie_perst
        If flag_srst_p1588_mii = &H0 Then write_srst_p1588_mii_value = get_srst_p1588_mii
        If flag_srst_p1588 = &H0 Then write_srst_p1588_value = get_srst_p1588

        regValue = leftShift((write_otp_fdone_timeout_value and &H1), 15) + leftShift((write_srst_sgmii_plusr_value and &H1), 7) + leftShift((write_srst_gmii3_value and &H1), 6) + leftShift((write_srst_brphy_1g_1port_value and &H1), 5) + leftShift((write_srst_pcie_perst_value and &H1), 4) + leftShift((write_srst_p1588_mii_value and &H1), 1) + leftShift((write_srst_p1588_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_otp_fdone_timeout_value = rightShift(data_low, 15) and &H1
        read_srst_sgmii_plusr_value = rightShift(data_low, 7) and &H1
        read_srst_gmii3_value = rightShift(data_low, 6) and &H1
        read_srst_brphy_1g_1port_value = rightShift(data_low, 5) and &H1
        read_srst_pcie_perst_value = rightShift(data_low, 4) and &H1
        read_srst_p1588_mii_value = rightShift(data_low, 1) and &H1
        srst_p1588_mask = &H1
        if data_low > LONG_MAX then
            if srst_p1588_mask = mask then
                read_srst_p1588_value = data_low
            else
                read_srst_p1588_value = (data_low - H8000_0000) and srst_p1588_mask
            end If
        else
            read_srst_p1588_value = data_low and srst_p1588_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_otp_fdone_timeout_value = &H0
        flag_otp_fdone_timeout        = &H0
        write_srst_sgmii_plusr_value = &H0
        flag_srst_sgmii_plusr        = &H0
        write_srst_gmii3_value = &H0
        flag_srst_gmii3        = &H0
        write_srst_brphy_1g_1port_value = &H0
        flag_srst_brphy_1g_1port        = &H0
        write_srst_pcie_perst_value = &H0
        flag_srst_pcie_perst        = &H0
        write_srst_p1588_mii_value = &H0
        flag_srst_p1588_mii        = &H0
        write_srst_p1588_value = &H0
        flag_srst_p1588        = &H0
    End Sub
End Class


'' @REGISTER : CRG_xtal_config_cml50
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pd_drv_cml50_2                             [7:7]            get_pd_drv_cml50_2
''                                                             set_pd_drv_cml50_2
''                                                             read_pd_drv_cml50_2
''                                                             write_pd_drv_cml50_2
''---------------------------------------------------------------------------------
'' pd_drv_cml50_1                             [6:6]            get_pd_drv_cml50_1
''                                                             set_pd_drv_cml50_1
''                                                             read_pd_drv_cml50_1
''                                                             write_pd_drv_cml50_1
''---------------------------------------------------------------------------------
'' div2_sel_drv_cml50_2                       [5:5]            get_div2_sel_drv_cml50_2
''                                                             set_div2_sel_drv_cml50_2
''                                                             read_div2_sel_drv_cml50_2
''                                                             write_div2_sel_drv_cml50_2
''---------------------------------------------------------------------------------
'' div2_sel_drv_cml50_1                       [4:4]            get_div2_sel_drv_cml50_1
''                                                             set_div2_sel_drv_cml50_1
''                                                             read_div2_sel_drv_cml50_1
''                                                             write_div2_sel_drv_cml50_1
''---------------------------------------------------------------------------------
'' cur_drv_cml50_2                            [3:2]            get_cur_drv_cml50_2
''                                                             set_cur_drv_cml50_2
''                                                             read_cur_drv_cml50_2
''                                                             write_cur_drv_cml50_2
''---------------------------------------------------------------------------------
'' cur_drv_cml50_1                            [1:0]            get_cur_drv_cml50_1
''                                                             set_cur_drv_cml50_1
''                                                             read_cur_drv_cml50_1
''                                                             write_cur_drv_cml50_1
''---------------------------------------------------------------------------------
Class REGISTER_CRG_xtal_config_cml50
    Private write_pd_drv_cml50_2_value
    Private read_pd_drv_cml50_2_value
    Private flag_pd_drv_cml50_2
    Private write_pd_drv_cml50_1_value
    Private read_pd_drv_cml50_1_value
    Private flag_pd_drv_cml50_1
    Private write_div2_sel_drv_cml50_2_value
    Private read_div2_sel_drv_cml50_2_value
    Private flag_div2_sel_drv_cml50_2
    Private write_div2_sel_drv_cml50_1_value
    Private read_div2_sel_drv_cml50_1_value
    Private flag_div2_sel_drv_cml50_1
    Private write_cur_drv_cml50_2_value
    Private read_cur_drv_cml50_2_value
    Private flag_cur_drv_cml50_2
    Private write_cur_drv_cml50_1_value
    Private read_cur_drv_cml50_1_value
    Private flag_cur_drv_cml50_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pd_drv_cml50_2
        get_pd_drv_cml50_2 = read_pd_drv_cml50_2_value
    End Property

    Property Let set_pd_drv_cml50_2(aData)
        write_pd_drv_cml50_2_value = aData
        flag_pd_drv_cml50_2        = &H1
    End Property

    Property Get read_pd_drv_cml50_2
        read
        read_pd_drv_cml50_2 = read_pd_drv_cml50_2_value
    End Property

    Property Let write_pd_drv_cml50_2(aData)
        set_pd_drv_cml50_2 = aData
        write
    End Property

    Property Get get_pd_drv_cml50_1
        get_pd_drv_cml50_1 = read_pd_drv_cml50_1_value
    End Property

    Property Let set_pd_drv_cml50_1(aData)
        write_pd_drv_cml50_1_value = aData
        flag_pd_drv_cml50_1        = &H1
    End Property

    Property Get read_pd_drv_cml50_1
        read
        read_pd_drv_cml50_1 = read_pd_drv_cml50_1_value
    End Property

    Property Let write_pd_drv_cml50_1(aData)
        set_pd_drv_cml50_1 = aData
        write
    End Property

    Property Get get_div2_sel_drv_cml50_2
        get_div2_sel_drv_cml50_2 = read_div2_sel_drv_cml50_2_value
    End Property

    Property Let set_div2_sel_drv_cml50_2(aData)
        write_div2_sel_drv_cml50_2_value = aData
        flag_div2_sel_drv_cml50_2        = &H1
    End Property

    Property Get read_div2_sel_drv_cml50_2
        read
        read_div2_sel_drv_cml50_2 = read_div2_sel_drv_cml50_2_value
    End Property

    Property Let write_div2_sel_drv_cml50_2(aData)
        set_div2_sel_drv_cml50_2 = aData
        write
    End Property

    Property Get get_div2_sel_drv_cml50_1
        get_div2_sel_drv_cml50_1 = read_div2_sel_drv_cml50_1_value
    End Property

    Property Let set_div2_sel_drv_cml50_1(aData)
        write_div2_sel_drv_cml50_1_value = aData
        flag_div2_sel_drv_cml50_1        = &H1
    End Property

    Property Get read_div2_sel_drv_cml50_1
        read
        read_div2_sel_drv_cml50_1 = read_div2_sel_drv_cml50_1_value
    End Property

    Property Let write_div2_sel_drv_cml50_1(aData)
        set_div2_sel_drv_cml50_1 = aData
        write
    End Property

    Property Get get_cur_drv_cml50_2
        get_cur_drv_cml50_2 = read_cur_drv_cml50_2_value
    End Property

    Property Let set_cur_drv_cml50_2(aData)
        write_cur_drv_cml50_2_value = aData
        flag_cur_drv_cml50_2        = &H1
    End Property

    Property Get read_cur_drv_cml50_2
        read
        read_cur_drv_cml50_2 = read_cur_drv_cml50_2_value
    End Property

    Property Let write_cur_drv_cml50_2(aData)
        set_cur_drv_cml50_2 = aData
        write
    End Property

    Property Get get_cur_drv_cml50_1
        get_cur_drv_cml50_1 = read_cur_drv_cml50_1_value
    End Property

    Property Let set_cur_drv_cml50_1(aData)
        write_cur_drv_cml50_1_value = aData
        flag_cur_drv_cml50_1        = &H1
    End Property

    Property Get read_cur_drv_cml50_1
        read
        read_cur_drv_cml50_1 = read_cur_drv_cml50_1_value
    End Property

    Property Let write_cur_drv_cml50_1(aData)
        set_cur_drv_cml50_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pd_drv_cml50_2_value = rightShift(data_low, 7) and &H1
        read_pd_drv_cml50_1_value = rightShift(data_low, 6) and &H1
        read_div2_sel_drv_cml50_2_value = rightShift(data_low, 5) and &H1
        read_div2_sel_drv_cml50_1_value = rightShift(data_low, 4) and &H1
        read_cur_drv_cml50_2_value = rightShift(data_low, 2) and &H3
        cur_drv_cml50_1_mask = &H3
        if data_low > LONG_MAX then
            if cur_drv_cml50_1_mask = mask then
                read_cur_drv_cml50_1_value = data_low
            else
                read_cur_drv_cml50_1_value = (data_low - H8000_0000) and cur_drv_cml50_1_mask
            end If
        else
            read_cur_drv_cml50_1_value = data_low and cur_drv_cml50_1_mask
        end If

    End Sub

    Sub write
        If flag_pd_drv_cml50_2 = &H0 or flag_pd_drv_cml50_1 = &H0 or flag_div2_sel_drv_cml50_2 = &H0 or flag_div2_sel_drv_cml50_1 = &H0 or flag_cur_drv_cml50_2 = &H0 or flag_cur_drv_cml50_1 = &H0 Then read
        If flag_pd_drv_cml50_2 = &H0 Then write_pd_drv_cml50_2_value = get_pd_drv_cml50_2
        If flag_pd_drv_cml50_1 = &H0 Then write_pd_drv_cml50_1_value = get_pd_drv_cml50_1
        If flag_div2_sel_drv_cml50_2 = &H0 Then write_div2_sel_drv_cml50_2_value = get_div2_sel_drv_cml50_2
        If flag_div2_sel_drv_cml50_1 = &H0 Then write_div2_sel_drv_cml50_1_value = get_div2_sel_drv_cml50_1
        If flag_cur_drv_cml50_2 = &H0 Then write_cur_drv_cml50_2_value = get_cur_drv_cml50_2
        If flag_cur_drv_cml50_1 = &H0 Then write_cur_drv_cml50_1_value = get_cur_drv_cml50_1

        regValue = leftShift((write_pd_drv_cml50_2_value and &H1), 7) + leftShift((write_pd_drv_cml50_1_value and &H1), 6) + leftShift((write_div2_sel_drv_cml50_2_value and &H1), 5) + leftShift((write_div2_sel_drv_cml50_1_value and &H1), 4) + leftShift((write_cur_drv_cml50_2_value and &H3), 2) + leftShift((write_cur_drv_cml50_1_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pd_drv_cml50_2_value = rightShift(data_low, 7) and &H1
        read_pd_drv_cml50_1_value = rightShift(data_low, 6) and &H1
        read_div2_sel_drv_cml50_2_value = rightShift(data_low, 5) and &H1
        read_div2_sel_drv_cml50_1_value = rightShift(data_low, 4) and &H1
        read_cur_drv_cml50_2_value = rightShift(data_low, 2) and &H3
        cur_drv_cml50_1_mask = &H3
        if data_low > LONG_MAX then
            if cur_drv_cml50_1_mask = mask then
                read_cur_drv_cml50_1_value = data_low
            else
                read_cur_drv_cml50_1_value = (data_low - H8000_0000) and cur_drv_cml50_1_mask
            end If
        else
            read_cur_drv_cml50_1_value = data_low and cur_drv_cml50_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pd_drv_cml50_2_value = &H0
        flag_pd_drv_cml50_2        = &H0
        write_pd_drv_cml50_1_value = &H0
        flag_pd_drv_cml50_1        = &H0
        write_div2_sel_drv_cml50_2_value = &H0
        flag_div2_sel_drv_cml50_2        = &H0
        write_div2_sel_drv_cml50_1_value = &H0
        flag_div2_sel_drv_cml50_1        = &H0
        write_cur_drv_cml50_2_value = &H0
        flag_cur_drv_cml50_2        = &H0
        write_cur_drv_cml50_1_value = &H0
        flag_cur_drv_cml50_1        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [7:2]            get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' en_pll_rst                                 [1:1]            get_en_pll_rst
''                                                             set_en_pll_rst
''                                                             read_en_pll_rst
''                                                             write_en_pll_rst
''---------------------------------------------------------------------------------
'' sm_en                                      [0:0]            get_sm_en
''                                                             set_sm_en
''                                                             read_sm_en
''                                                             write_sm_en
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_ctrl
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_en_pll_rst_value
    Private read_en_pll_rst_value
    Private flag_en_pll_rst
    Private write_sm_en_value
    Private read_sm_en_value
    Private flag_sm_en

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

    Property Get get_en_pll_rst
        get_en_pll_rst = read_en_pll_rst_value
    End Property

    Property Let set_en_pll_rst(aData)
        write_en_pll_rst_value = aData
        flag_en_pll_rst        = &H1
    End Property

    Property Get read_en_pll_rst
        read
        read_en_pll_rst = read_en_pll_rst_value
    End Property

    Property Let write_en_pll_rst(aData)
        set_en_pll_rst = aData
        write
    End Property

    Property Get get_sm_en
        get_sm_en = read_sm_en_value
    End Property

    Property Let set_sm_en(aData)
        write_sm_en_value = aData
        flag_sm_en        = &H1
    End Property

    Property Get read_sm_en
        read
        read_sm_en = read_sm_en_value
    End Property

    Property Let write_sm_en(aData)
        set_sm_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 2) and &H3f
        read_en_pll_rst_value = rightShift(data_low, 1) and &H1
        sm_en_mask = &H1
        if data_low > LONG_MAX then
            if sm_en_mask = mask then
                read_sm_en_value = data_low
            else
                read_sm_en_value = (data_low - H8000_0000) and sm_en_mask
            end If
        else
            read_sm_en_value = data_low and sm_en_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_en_pll_rst = &H0 or flag_sm_en = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_en_pll_rst = &H0 Then write_en_pll_rst_value = get_en_pll_rst
        If flag_sm_en = &H0 Then write_sm_en_value = get_sm_en

        regValue = leftShift((write_spare_value and &H3f), 2) + leftShift((write_en_pll_rst_value and &H1), 1) + leftShift((write_sm_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 2) and &H3f
        read_en_pll_rst_value = rightShift(data_low, 1) and &H1
        sm_en_mask = &H1
        if data_low > LONG_MAX then
            if sm_en_mask = mask then
                read_sm_en_value = data_low
            else
                read_sm_en_value = (data_low - H8000_0000) and sm_en_mask
            end If
        else
            read_sm_en_value = data_low and sm_en_mask
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
        write_en_pll_rst_value = &H0
        flag_en_pll_rst        = &H0
        write_sm_en_value = &H0
        flag_sm_en        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_fault_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fault_en                                   [8:0]            get_fault_en
''                                                             set_fault_en
''                                                             read_fault_en
''                                                             write_fault_en
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_fault_ctrl
    Private write_fault_en_value
    Private read_fault_en_value
    Private flag_fault_en

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

    Property Get get_fault_en
        get_fault_en = read_fault_en_value
    End Property

    Property Let set_fault_en(aData)
        write_fault_en_value = aData
        flag_fault_en        = &H1
    End Property

    Property Get read_fault_en
        read
        read_fault_en = read_fault_en_value
    End Property

    Property Let write_fault_en(aData)
        set_fault_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fault_en_mask = &H1ff
        if data_low > LONG_MAX then
            if fault_en_mask = mask then
                read_fault_en_value = data_low
            else
                read_fault_en_value = (data_low - H8000_0000) and fault_en_mask
            end If
        else
            read_fault_en_value = data_low and fault_en_mask
        end If

    End Sub

    Sub write
        If flag_fault_en = &H0 Then read
        If flag_fault_en = &H0 Then write_fault_en_value = get_fault_en

        regValue = leftShift((write_fault_en_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fault_en_mask = &H1ff
        if data_low > LONG_MAX then
            if fault_en_mask = mask then
                read_fault_en_value = data_low
            else
                read_fault_en_value = (data_low - H8000_0000) and fault_en_mask
            end If
        else
            read_fault_en_value = data_low and fault_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fault_en_value = &H0
        flag_fault_en        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_clr_log
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' clr_log                                    [0:0]            get_clr_log
''                                                             set_clr_log
''                                                             read_clr_log
''                                                             write_clr_log
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_clr_log
    Private write_clr_log_value
    Private read_clr_log_value
    Private flag_clr_log

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_clr_log
        get_clr_log = read_clr_log_value
    End Property

    Property Let set_clr_log(aData)
        write_clr_log_value = aData
        flag_clr_log        = &H1
    End Property

    Property Get read_clr_log
        read
        read_clr_log = read_clr_log_value
    End Property

    Property Let write_clr_log(aData)
        set_clr_log = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        clr_log_mask = &H1
        if data_low > LONG_MAX then
            if clr_log_mask = mask then
                read_clr_log_value = data_low
            else
                read_clr_log_value = (data_low - H8000_0000) and clr_log_mask
            end If
        else
            read_clr_log_value = data_low and clr_log_mask
        end If

    End Sub

    Sub write
        If flag_clr_log = &H0 Then read
        If flag_clr_log = &H0 Then write_clr_log_value = get_clr_log

        regValue = leftShift((write_clr_log_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        clr_log_mask = &H1
        if data_low > LONG_MAX then
            if clr_log_mask = mask then
                read_clr_log_value = data_low
            else
                read_clr_log_value = (data_low - H8000_0000) and clr_log_mask
            end If
        else
            read_clr_log_value = data_low and clr_log_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_clr_log_value = &H0
        flag_clr_log        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_tim_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare                                      [7:2]            get_spare
''                                                             set_spare
''                                                             read_spare
''                                                             write_spare
''---------------------------------------------------------------------------------
'' sm_tim_load                                [1:1]            get_sm_tim_load
''                                                             set_sm_tim_load
''                                                             read_sm_tim_load
''                                                             write_sm_tim_load
''---------------------------------------------------------------------------------
'' sm_tim_en                                  [0:0]            get_sm_tim_en
''                                                             set_sm_tim_en
''                                                             read_sm_tim_en
''                                                             write_sm_tim_en
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_tim_ctrl
    Private write_spare_value
    Private read_spare_value
    Private flag_spare
    Private write_sm_tim_load_value
    Private read_sm_tim_load_value
    Private flag_sm_tim_load
    Private write_sm_tim_en_value
    Private read_sm_tim_en_value
    Private flag_sm_tim_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H46
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

    Property Get get_sm_tim_load
        get_sm_tim_load = read_sm_tim_load_value
    End Property

    Property Let set_sm_tim_load(aData)
        write_sm_tim_load_value = aData
        flag_sm_tim_load        = &H1
    End Property

    Property Get read_sm_tim_load
        read
        read_sm_tim_load = read_sm_tim_load_value
    End Property

    Property Let write_sm_tim_load(aData)
        set_sm_tim_load = aData
        write
    End Property

    Property Get get_sm_tim_en
        get_sm_tim_en = read_sm_tim_en_value
    End Property

    Property Let set_sm_tim_en(aData)
        write_sm_tim_en_value = aData
        flag_sm_tim_en        = &H1
    End Property

    Property Get read_sm_tim_en
        read
        read_sm_tim_en = read_sm_tim_en_value
    End Property

    Property Let write_sm_tim_en(aData)
        set_sm_tim_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 2) and &H3f
        read_sm_tim_load_value = rightShift(data_low, 1) and &H1
        sm_tim_en_mask = &H1
        if data_low > LONG_MAX then
            if sm_tim_en_mask = mask then
                read_sm_tim_en_value = data_low
            else
                read_sm_tim_en_value = (data_low - H8000_0000) and sm_tim_en_mask
            end If
        else
            read_sm_tim_en_value = data_low and sm_tim_en_mask
        end If

    End Sub

    Sub write
        If flag_spare = &H0 or flag_sm_tim_load = &H0 or flag_sm_tim_en = &H0 Then read
        If flag_spare = &H0 Then write_spare_value = get_spare
        If flag_sm_tim_load = &H0 Then write_sm_tim_load_value = get_sm_tim_load
        If flag_sm_tim_en = &H0 Then write_sm_tim_en_value = get_sm_tim_en

        regValue = leftShift((write_spare_value and &H3f), 2) + leftShift((write_sm_tim_load_value and &H1), 1) + leftShift((write_sm_tim_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_value = rightShift(data_low, 2) and &H3f
        read_sm_tim_load_value = rightShift(data_low, 1) and &H1
        sm_tim_en_mask = &H1
        if data_low > LONG_MAX then
            if sm_tim_en_mask = mask then
                read_sm_tim_en_value = data_low
            else
                read_sm_tim_en_value = (data_low - H8000_0000) and sm_tim_en_mask
            end If
        else
            read_sm_tim_en_value = data_low and sm_tim_en_mask
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
        write_sm_tim_load_value = &H0
        flag_sm_tim_load        = &H0
        write_sm_tim_en_value = &H0
        flag_sm_tim_en        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_tim_val
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tim_val                                    [15:0]           get_tim_val
''                                                             set_tim_val
''                                                             read_tim_val
''                                                             write_tim_val
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_tim_val
    Private write_tim_val_value
    Private read_tim_val_value
    Private flag_tim_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tim_val
        get_tim_val = read_tim_val_value
    End Property

    Property Let set_tim_val(aData)
        write_tim_val_value = aData
        flag_tim_val        = &H1
    End Property

    Property Get read_tim_val
        read
        read_tim_val = read_tim_val_value
    End Property

    Property Let write_tim_val(aData)
        set_tim_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tim_val_mask = &Hffff
        if data_low > LONG_MAX then
            if tim_val_mask = mask then
                read_tim_val_value = data_low
            else
                read_tim_val_value = (data_low - H8000_0000) and tim_val_mask
            end If
        else
            read_tim_val_value = data_low and tim_val_mask
        end If

    End Sub

    Sub write
        If flag_tim_val = &H0 Then read
        If flag_tim_val = &H0 Then write_tim_val_value = get_tim_val

        regValue = leftShift((write_tim_val_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tim_val_mask = &Hffff
        if data_low > LONG_MAX then
            if tim_val_mask = mask then
                read_tim_val_value = data_low
            else
                read_tim_val_value = (data_low - H8000_0000) and tim_val_mask
            end If
        else
            read_tim_val_value = data_low and tim_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tim_val_value = &H0
        flag_tim_val        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_tim_evt_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sm_tim_evt_clr                             [0:0]            get_sm_tim_evt_clr
''                                                             set_sm_tim_evt_clr
''                                                             read_sm_tim_evt_clr
''                                                             write_sm_tim_evt_clr
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_tim_evt_clr
    Private write_sm_tim_evt_clr_value
    Private read_sm_tim_evt_clr_value
    Private flag_sm_tim_evt_clr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sm_tim_evt_clr
        get_sm_tim_evt_clr = read_sm_tim_evt_clr_value
    End Property

    Property Let set_sm_tim_evt_clr(aData)
        write_sm_tim_evt_clr_value = aData
        flag_sm_tim_evt_clr        = &H1
    End Property

    Property Get read_sm_tim_evt_clr
        read
        read_sm_tim_evt_clr = read_sm_tim_evt_clr_value
    End Property

    Property Let write_sm_tim_evt_clr(aData)
        set_sm_tim_evt_clr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sm_tim_evt_clr_mask = &H1
        if data_low > LONG_MAX then
            if sm_tim_evt_clr_mask = mask then
                read_sm_tim_evt_clr_value = data_low
            else
                read_sm_tim_evt_clr_value = (data_low - H8000_0000) and sm_tim_evt_clr_mask
            end If
        else
            read_sm_tim_evt_clr_value = data_low and sm_tim_evt_clr_mask
        end If

    End Sub

    Sub write
        If flag_sm_tim_evt_clr = &H0 Then read
        If flag_sm_tim_evt_clr = &H0 Then write_sm_tim_evt_clr_value = get_sm_tim_evt_clr

        regValue = leftShift((write_sm_tim_evt_clr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sm_tim_evt_clr_mask = &H1
        if data_low > LONG_MAX then
            if sm_tim_evt_clr_mask = mask then
                read_sm_tim_evt_clr_value = data_low
            else
                read_sm_tim_evt_clr_value = (data_low - H8000_0000) and sm_tim_evt_clr_mask
            end If
        else
            read_sm_tim_evt_clr_value = data_low and sm_tim_evt_clr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sm_tim_evt_clr_value = &H0
        flag_sm_tim_evt_clr        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_sw_trigger
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_trig                                    [15:0]           get_sw_trig
''                                                             set_sw_trig
''                                                             read_sw_trig
''                                                             write_sw_trig
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_sw_trigger
    Private write_sw_trig_value
    Private read_sw_trig_value
    Private flag_sw_trig

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_trig
        get_sw_trig = read_sw_trig_value
    End Property

    Property Let set_sw_trig(aData)
        write_sw_trig_value = aData
        flag_sw_trig        = &H1
    End Property

    Property Get read_sw_trig
        read
        read_sw_trig = read_sw_trig_value
    End Property

    Property Let write_sw_trig(aData)
        set_sw_trig = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_trig_mask = &Hffff
        if data_low > LONG_MAX then
            if sw_trig_mask = mask then
                read_sw_trig_value = data_low
            else
                read_sw_trig_value = (data_low - H8000_0000) and sw_trig_mask
            end If
        else
            read_sw_trig_value = data_low and sw_trig_mask
        end If

    End Sub

    Sub write
        If flag_sw_trig = &H0 Then read
        If flag_sw_trig = &H0 Then write_sw_trig_value = get_sw_trig

        regValue = leftShift((write_sw_trig_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_trig_mask = &Hffff
        if data_low > LONG_MAX then
            if sw_trig_mask = mask then
                read_sw_trig_value = data_low
            else
                read_sw_trig_value = (data_low - H8000_0000) and sw_trig_mask
            end If
        else
            read_sw_trig_value = data_low and sw_trig_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_trig_value = &H0
        flag_sw_trig        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_sw_reason
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sw_reason                                  [7:0]            get_sw_reason
''                                                             set_sw_reason
''                                                             read_sw_reason
''                                                             write_sw_reason
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_sw_reason
    Private write_sw_reason_value
    Private read_sw_reason_value
    Private flag_sw_reason

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sw_reason
        get_sw_reason = read_sw_reason_value
    End Property

    Property Let set_sw_reason(aData)
        write_sw_reason_value = aData
        flag_sw_reason        = &H1
    End Property

    Property Get read_sw_reason
        read
        read_sw_reason = read_sw_reason_value
    End Property

    Property Let write_sw_reason(aData)
        set_sw_reason = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_reason_mask = &Hff
        if data_low > LONG_MAX then
            if sw_reason_mask = mask then
                read_sw_reason_value = data_low
            else
                read_sw_reason_value = (data_low - H8000_0000) and sw_reason_mask
            end If
        else
            read_sw_reason_value = data_low and sw_reason_mask
        end If

    End Sub

    Sub write
        If flag_sw_reason = &H0 Then read
        If flag_sw_reason = &H0 Then write_sw_reason_value = get_sw_reason

        regValue = leftShift((write_sw_reason_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sw_reason_mask = &Hff
        if data_low > LONG_MAX then
            if sw_reason_mask = mask then
                read_sw_reason_value = data_low
            else
                read_sw_reason_value = (data_low - H8000_0000) and sw_reason_mask
            end If
        else
            read_sw_reason_value = data_low and sw_reason_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sw_reason_value = &H0
        flag_sw_reason        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_cnt_64us_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cnt_64us_lo                                [15:0]           get_cnt_64us_lo
''                                                             set_cnt_64us_lo
''                                                             read_cnt_64us_lo
''                                                             write_cnt_64us_lo
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_cnt_64us_lo
    Private write_cnt_64us_lo_value
    Private read_cnt_64us_lo_value
    Private flag_cnt_64us_lo

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cnt_64us_lo
        get_cnt_64us_lo = read_cnt_64us_lo_value
    End Property

    Property Let set_cnt_64us_lo(aData)
        write_cnt_64us_lo_value = aData
        flag_cnt_64us_lo        = &H1
    End Property

    Property Get read_cnt_64us_lo
        read
        read_cnt_64us_lo = read_cnt_64us_lo_value
    End Property

    Property Let write_cnt_64us_lo(aData)
        set_cnt_64us_lo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cnt_64us_lo_mask = &Hffff
        if data_low > LONG_MAX then
            if cnt_64us_lo_mask = mask then
                read_cnt_64us_lo_value = data_low
            else
                read_cnt_64us_lo_value = (data_low - H8000_0000) and cnt_64us_lo_mask
            end If
        else
            read_cnt_64us_lo_value = data_low and cnt_64us_lo_mask
        end If

    End Sub

    Sub write
        If flag_cnt_64us_lo = &H0 Then read
        If flag_cnt_64us_lo = &H0 Then write_cnt_64us_lo_value = get_cnt_64us_lo

        regValue = leftShift((write_cnt_64us_lo_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cnt_64us_lo_mask = &Hffff
        if data_low > LONG_MAX then
            if cnt_64us_lo_mask = mask then
                read_cnt_64us_lo_value = data_low
            else
                read_cnt_64us_lo_value = (data_low - H8000_0000) and cnt_64us_lo_mask
            end If
        else
            read_cnt_64us_lo_value = data_low and cnt_64us_lo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cnt_64us_lo_value = &H0
        flag_cnt_64us_lo        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_cnt_64us_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cnt_64us_hi                                [3:0]            get_cnt_64us_hi
''                                                             set_cnt_64us_hi
''                                                             read_cnt_64us_hi
''                                                             write_cnt_64us_hi
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_cnt_64us_hi
    Private write_cnt_64us_hi_value
    Private read_cnt_64us_hi_value
    Private flag_cnt_64us_hi

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H52
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_cnt_64us_hi
        get_cnt_64us_hi = read_cnt_64us_hi_value
    End Property

    Property Let set_cnt_64us_hi(aData)
        write_cnt_64us_hi_value = aData
        flag_cnt_64us_hi        = &H1
    End Property

    Property Get read_cnt_64us_hi
        read
        read_cnt_64us_hi = read_cnt_64us_hi_value
    End Property

    Property Let write_cnt_64us_hi(aData)
        set_cnt_64us_hi = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cnt_64us_hi_mask = &Hf
        if data_low > LONG_MAX then
            if cnt_64us_hi_mask = mask then
                read_cnt_64us_hi_value = data_low
            else
                read_cnt_64us_hi_value = (data_low - H8000_0000) and cnt_64us_hi_mask
            end If
        else
            read_cnt_64us_hi_value = data_low and cnt_64us_hi_mask
        end If

    End Sub

    Sub write
        If flag_cnt_64us_hi = &H0 Then read
        If flag_cnt_64us_hi = &H0 Then write_cnt_64us_hi_value = get_cnt_64us_hi

        regValue = leftShift((write_cnt_64us_hi_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cnt_64us_hi_mask = &Hf
        if data_low > LONG_MAX then
            if cnt_64us_hi_mask = mask then
                read_cnt_64us_hi_value = data_low
            else
                read_cnt_64us_hi_value = (data_low - H8000_0000) and cnt_64us_hi_mask
            end If
        else
            read_cnt_64us_hi_value = data_low and cnt_64us_hi_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cnt_64us_hi_value = &H0
        flag_cnt_64us_hi        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sm_state                                   [5:0]            get_sm_state
''                                                             set_sm_state
''                                                             read_sm_state
''                                                             write_sm_state
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_status
    Private write_sm_state_value
    Private read_sm_state_value
    Private flag_sm_state

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H54
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sm_state
        get_sm_state = read_sm_state_value
    End Property

    Property Let set_sm_state(aData)
        write_sm_state_value = aData
        flag_sm_state        = &H1
    End Property

    Property Get read_sm_state
        read
        read_sm_state = read_sm_state_value
    End Property

    Property Let write_sm_state(aData)
        set_sm_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sm_state_mask = &H3f
        if data_low > LONG_MAX then
            if sm_state_mask = mask then
                read_sm_state_value = data_low
            else
                read_sm_state_value = (data_low - H8000_0000) and sm_state_mask
            end If
        else
            read_sm_state_value = data_low and sm_state_mask
        end If

    End Sub

    Sub write
        If flag_sm_state = &H0 Then read
        If flag_sm_state = &H0 Then write_sm_state_value = get_sm_state

        regValue = leftShift((write_sm_state_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sm_state_mask = &H3f
        if data_low > LONG_MAX then
            if sm_state_mask = mask then
                read_sm_state_value = data_low
            else
                read_sm_state_value = (data_low - H8000_0000) and sm_state_mask
            end If
        else
            read_sm_state_value = data_low and sm_state_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sm_state_value = &H0
        flag_sm_state        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_raw_log_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raw_log_lo                                 [15:0]           get_raw_log_lo
''                                                             set_raw_log_lo
''                                                             read_raw_log_lo
''                                                             write_raw_log_lo
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_raw_log_lo
    Private write_raw_log_lo_value
    Private read_raw_log_lo_value
    Private flag_raw_log_lo

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H56
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raw_log_lo
        get_raw_log_lo = read_raw_log_lo_value
    End Property

    Property Let set_raw_log_lo(aData)
        write_raw_log_lo_value = aData
        flag_raw_log_lo        = &H1
    End Property

    Property Get read_raw_log_lo
        read
        read_raw_log_lo = read_raw_log_lo_value
    End Property

    Property Let write_raw_log_lo(aData)
        set_raw_log_lo = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raw_log_lo_mask = &Hffff
        if data_low > LONG_MAX then
            if raw_log_lo_mask = mask then
                read_raw_log_lo_value = data_low
            else
                read_raw_log_lo_value = (data_low - H8000_0000) and raw_log_lo_mask
            end If
        else
            read_raw_log_lo_value = data_low and raw_log_lo_mask
        end If

    End Sub

    Sub write
        If flag_raw_log_lo = &H0 Then read
        If flag_raw_log_lo = &H0 Then write_raw_log_lo_value = get_raw_log_lo

        regValue = leftShift((write_raw_log_lo_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raw_log_lo_mask = &Hffff
        if data_low > LONG_MAX then
            if raw_log_lo_mask = mask then
                read_raw_log_lo_value = data_low
            else
                read_raw_log_lo_value = (data_low - H8000_0000) and raw_log_lo_mask
            end If
        else
            read_raw_log_lo_value = data_low and raw_log_lo_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raw_log_lo_value = &H0
        flag_raw_log_lo        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_raw_log_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raw_log_hi                                 [15:0]           get_raw_log_hi
''                                                             set_raw_log_hi
''                                                             read_raw_log_hi
''                                                             write_raw_log_hi
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_raw_log_hi
    Private write_raw_log_hi_value
    Private read_raw_log_hi_value
    Private flag_raw_log_hi

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H58
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raw_log_hi
        get_raw_log_hi = read_raw_log_hi_value
    End Property

    Property Let set_raw_log_hi(aData)
        write_raw_log_hi_value = aData
        flag_raw_log_hi        = &H1
    End Property

    Property Get read_raw_log_hi
        read
        read_raw_log_hi = read_raw_log_hi_value
    End Property

    Property Let write_raw_log_hi(aData)
        set_raw_log_hi = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raw_log_hi_mask = &Hffff
        if data_low > LONG_MAX then
            if raw_log_hi_mask = mask then
                read_raw_log_hi_value = data_low
            else
                read_raw_log_hi_value = (data_low - H8000_0000) and raw_log_hi_mask
            end If
        else
            read_raw_log_hi_value = data_low and raw_log_hi_mask
        end If

    End Sub

    Sub write
        If flag_raw_log_hi = &H0 Then read
        If flag_raw_log_hi = &H0 Then write_raw_log_hi_value = get_raw_log_hi

        regValue = leftShift((write_raw_log_hi_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raw_log_hi_mask = &Hffff
        if data_low > LONG_MAX then
            if raw_log_hi_mask = mask then
                read_raw_log_hi_value = data_low
            else
                read_raw_log_hi_value = (data_low - H8000_0000) and raw_log_hi_mask
            end If
        else
            read_raw_log_hi_value = data_low and raw_log_hi_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raw_log_hi_value = &H0
        flag_raw_log_hi        = &H0
    End Sub
End Class


'' @REGISTER : CRG_sm_fault_log
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fault_log                                  [8:0]            get_fault_log
''                                                             set_fault_log
''                                                             read_fault_log
''                                                             write_fault_log
''---------------------------------------------------------------------------------
Class REGISTER_CRG_sm_fault_log
    Private write_fault_log_value
    Private read_fault_log_value
    Private flag_fault_log

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fault_log
        get_fault_log = read_fault_log_value
    End Property

    Property Let set_fault_log(aData)
        write_fault_log_value = aData
        flag_fault_log        = &H1
    End Property

    Property Get read_fault_log
        read
        read_fault_log = read_fault_log_value
    End Property

    Property Let write_fault_log(aData)
        set_fault_log = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fault_log_mask = &H1ff
        if data_low > LONG_MAX then
            if fault_log_mask = mask then
                read_fault_log_value = data_low
            else
                read_fault_log_value = (data_low - H8000_0000) and fault_log_mask
            end If
        else
            read_fault_log_value = data_low and fault_log_mask
        end If

    End Sub

    Sub write
        If flag_fault_log = &H0 Then read
        If flag_fault_log = &H0 Then write_fault_log_value = get_fault_log

        regValue = leftShift((write_fault_log_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        fault_log_mask = &H1ff
        if data_low > LONG_MAX then
            if fault_log_mask = mask then
                read_fault_log_value = data_low
            else
                read_fault_log_value = (data_low - H8000_0000) and fault_log_mask
            end If
        else
            read_fault_log_value = data_low and fault_log_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fault_log_value = &H0
        flag_fault_log        = &H0
    End Sub
End Class


'' @REGISTER : CRG_rcosc_lfo_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rcosc_lfo_ctrl                             [15:0]           get_rcosc_lfo_ctrl
''                                                             set_rcosc_lfo_ctrl
''                                                             read_rcosc_lfo_ctrl
''                                                             write_rcosc_lfo_ctrl
''---------------------------------------------------------------------------------
Class REGISTER_CRG_rcosc_lfo_ctrl
    Private write_rcosc_lfo_ctrl_value
    Private read_rcosc_lfo_ctrl_value
    Private flag_rcosc_lfo_ctrl

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

    Property Get get_rcosc_lfo_ctrl
        get_rcosc_lfo_ctrl = read_rcosc_lfo_ctrl_value
    End Property

    Property Let set_rcosc_lfo_ctrl(aData)
        write_rcosc_lfo_ctrl_value = aData
        flag_rcosc_lfo_ctrl        = &H1
    End Property

    Property Get read_rcosc_lfo_ctrl
        read
        read_rcosc_lfo_ctrl = read_rcosc_lfo_ctrl_value
    End Property

    Property Let write_rcosc_lfo_ctrl(aData)
        set_rcosc_lfo_ctrl = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if rcosc_lfo_ctrl_mask = mask then
                read_rcosc_lfo_ctrl_value = data_low
            else
                read_rcosc_lfo_ctrl_value = (data_low - H8000_0000) and rcosc_lfo_ctrl_mask
            end If
        else
            read_rcosc_lfo_ctrl_value = data_low and rcosc_lfo_ctrl_mask
        end If

    End Sub

    Sub write
        If flag_rcosc_lfo_ctrl = &H0 Then read
        If flag_rcosc_lfo_ctrl = &H0 Then write_rcosc_lfo_ctrl_value = get_rcosc_lfo_ctrl

        regValue = leftShift((write_rcosc_lfo_ctrl_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_ctrl_mask = &Hffff
        if data_low > LONG_MAX then
            if rcosc_lfo_ctrl_mask = mask then
                read_rcosc_lfo_ctrl_value = data_low
            else
                read_rcosc_lfo_ctrl_value = (data_low - H8000_0000) and rcosc_lfo_ctrl_mask
            end If
        else
            read_rcosc_lfo_ctrl_value = data_low and rcosc_lfo_ctrl_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rcosc_lfo_ctrl_value = &H0
        flag_rcosc_lfo_ctrl        = &H0
    End Sub
End Class


'' @REGISTER : CRG_rcosc_lfo_cal
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rcosc_lfo_cal                              [7:0]            get_rcosc_lfo_cal
''                                                             set_rcosc_lfo_cal
''                                                             read_rcosc_lfo_cal
''                                                             write_rcosc_lfo_cal
''---------------------------------------------------------------------------------
Class REGISTER_CRG_rcosc_lfo_cal
    Private write_rcosc_lfo_cal_value
    Private read_rcosc_lfo_cal_value
    Private flag_rcosc_lfo_cal

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

    Property Get get_rcosc_lfo_cal
        get_rcosc_lfo_cal = read_rcosc_lfo_cal_value
    End Property

    Property Let set_rcosc_lfo_cal(aData)
        write_rcosc_lfo_cal_value = aData
        flag_rcosc_lfo_cal        = &H1
    End Property

    Property Get read_rcosc_lfo_cal
        read
        read_rcosc_lfo_cal = read_rcosc_lfo_cal_value
    End Property

    Property Let write_rcosc_lfo_cal(aData)
        set_rcosc_lfo_cal = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_cal_mask = &Hff
        if data_low > LONG_MAX then
            if rcosc_lfo_cal_mask = mask then
                read_rcosc_lfo_cal_value = data_low
            else
                read_rcosc_lfo_cal_value = (data_low - H8000_0000) and rcosc_lfo_cal_mask
            end If
        else
            read_rcosc_lfo_cal_value = data_low and rcosc_lfo_cal_mask
        end If

    End Sub

    Sub write
        If flag_rcosc_lfo_cal = &H0 Then read
        If flag_rcosc_lfo_cal = &H0 Then write_rcosc_lfo_cal_value = get_rcosc_lfo_cal

        regValue = leftShift((write_rcosc_lfo_cal_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_cal_mask = &Hff
        if data_low > LONG_MAX then
            if rcosc_lfo_cal_mask = mask then
                read_rcosc_lfo_cal_value = data_low
            else
                read_rcosc_lfo_cal_value = (data_low - H8000_0000) and rcosc_lfo_cal_mask
            end If
        else
            read_rcosc_lfo_cal_value = data_low and rcosc_lfo_cal_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rcosc_lfo_cal_value = &H0
        flag_rcosc_lfo_cal        = &H0
    End Sub
End Class


'' @REGISTER : CRG_rcosc_lfo_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rcosc_lfo_ctrl2                            [7:0]            get_rcosc_lfo_ctrl2
''                                                             set_rcosc_lfo_ctrl2
''                                                             read_rcosc_lfo_ctrl2
''                                                             write_rcosc_lfo_ctrl2
''---------------------------------------------------------------------------------
Class REGISTER_CRG_rcosc_lfo_ctrl2
    Private write_rcosc_lfo_ctrl2_value
    Private read_rcosc_lfo_ctrl2_value
    Private flag_rcosc_lfo_ctrl2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rcosc_lfo_ctrl2
        get_rcosc_lfo_ctrl2 = read_rcosc_lfo_ctrl2_value
    End Property

    Property Let set_rcosc_lfo_ctrl2(aData)
        write_rcosc_lfo_ctrl2_value = aData
        flag_rcosc_lfo_ctrl2        = &H1
    End Property

    Property Get read_rcosc_lfo_ctrl2
        read
        read_rcosc_lfo_ctrl2 = read_rcosc_lfo_ctrl2_value
    End Property

    Property Let write_rcosc_lfo_ctrl2(aData)
        set_rcosc_lfo_ctrl2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_ctrl2_mask = &Hff
        if data_low > LONG_MAX then
            if rcosc_lfo_ctrl2_mask = mask then
                read_rcosc_lfo_ctrl2_value = data_low
            else
                read_rcosc_lfo_ctrl2_value = (data_low - H8000_0000) and rcosc_lfo_ctrl2_mask
            end If
        else
            read_rcosc_lfo_ctrl2_value = data_low and rcosc_lfo_ctrl2_mask
        end If

    End Sub

    Sub write
        If flag_rcosc_lfo_ctrl2 = &H0 Then read
        If flag_rcosc_lfo_ctrl2 = &H0 Then write_rcosc_lfo_ctrl2_value = get_rcosc_lfo_ctrl2

        regValue = leftShift((write_rcosc_lfo_ctrl2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_ctrl2_mask = &Hff
        if data_low > LONG_MAX then
            if rcosc_lfo_ctrl2_mask = mask then
                read_rcosc_lfo_ctrl2_value = data_low
            else
                read_rcosc_lfo_ctrl2_value = (data_low - H8000_0000) and rcosc_lfo_ctrl2_mask
            end If
        else
            read_rcosc_lfo_ctrl2_value = data_low and rcosc_lfo_ctrl2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rcosc_lfo_ctrl2_value = &H0
        flag_rcosc_lfo_ctrl2        = &H0
    End Sub
End Class


'' @REGISTER : CRG_rcosc_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rcosc_lfo_stat                             [7:0]            get_rcosc_lfo_stat
''                                                             set_rcosc_lfo_stat
''                                                             read_rcosc_lfo_stat
''                                                             write_rcosc_lfo_stat
''---------------------------------------------------------------------------------
Class REGISTER_CRG_rcosc_status
    Private write_rcosc_lfo_stat_value
    Private read_rcosc_lfo_stat_value
    Private flag_rcosc_lfo_stat

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H86
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rcosc_lfo_stat
        get_rcosc_lfo_stat = read_rcosc_lfo_stat_value
    End Property

    Property Let set_rcosc_lfo_stat(aData)
        write_rcosc_lfo_stat_value = aData
        flag_rcosc_lfo_stat        = &H1
    End Property

    Property Get read_rcosc_lfo_stat
        read
        read_rcosc_lfo_stat = read_rcosc_lfo_stat_value
    End Property

    Property Let write_rcosc_lfo_stat(aData)
        set_rcosc_lfo_stat = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_stat_mask = &Hff
        if data_low > LONG_MAX then
            if rcosc_lfo_stat_mask = mask then
                read_rcosc_lfo_stat_value = data_low
            else
                read_rcosc_lfo_stat_value = (data_low - H8000_0000) and rcosc_lfo_stat_mask
            end If
        else
            read_rcosc_lfo_stat_value = data_low and rcosc_lfo_stat_mask
        end If

    End Sub

    Sub write
        If flag_rcosc_lfo_stat = &H0 Then read
        If flag_rcosc_lfo_stat = &H0 Then write_rcosc_lfo_stat_value = get_rcosc_lfo_stat

        regValue = leftShift((write_rcosc_lfo_stat_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcosc_lfo_stat_mask = &Hff
        if data_low > LONG_MAX then
            if rcosc_lfo_stat_mask = mask then
                read_rcosc_lfo_stat_value = data_low
            else
                read_rcosc_lfo_stat_value = (data_low - H8000_0000) and rcosc_lfo_stat_mask
            end If
        else
            read_rcosc_lfo_stat_value = data_low and rcosc_lfo_stat_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rcosc_lfo_stat_value = &H0
        flag_rcosc_lfo_stat        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_config1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pdiv                                       [15:12]          get_pdiv
''                                                             set_pdiv
''                                                             read_pdiv
''                                                             write_pdiv
''---------------------------------------------------------------------------------
'' ka                                         [9:7]            get_ka
''                                                             set_ka
''                                                             read_ka
''                                                             write_ka
''---------------------------------------------------------------------------------
'' ki                                         [6:4]            get_ki
''                                                             set_ki
''                                                             read_ki
''                                                             write_ki
''---------------------------------------------------------------------------------
'' kp                                         [3:0]            get_kp
''                                                             set_kp
''                                                             read_kp
''                                                             write_kp
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_config1
    Private write_pdiv_value
    Private read_pdiv_value
    Private flag_pdiv
    Private write_ka_value
    Private read_ka_value
    Private flag_ka
    Private write_ki_value
    Private read_ki_value
    Private flag_ki
    Private write_kp_value
    Private read_kp_value
    Private flag_kp

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pdiv
        get_pdiv = read_pdiv_value
    End Property

    Property Let set_pdiv(aData)
        write_pdiv_value = aData
        flag_pdiv        = &H1
    End Property

    Property Get read_pdiv
        read
        read_pdiv = read_pdiv_value
    End Property

    Property Let write_pdiv(aData)
        set_pdiv = aData
        write
    End Property

    Property Get get_ka
        get_ka = read_ka_value
    End Property

    Property Let set_ka(aData)
        write_ka_value = aData
        flag_ka        = &H1
    End Property

    Property Get read_ka
        read
        read_ka = read_ka_value
    End Property

    Property Let write_ka(aData)
        set_ka = aData
        write
    End Property

    Property Get get_ki
        get_ki = read_ki_value
    End Property

    Property Let set_ki(aData)
        write_ki_value = aData
        flag_ki        = &H1
    End Property

    Property Get read_ki
        read
        read_ki = read_ki_value
    End Property

    Property Let write_ki(aData)
        set_ki = aData
        write
    End Property

    Property Get get_kp
        get_kp = read_kp_value
    End Property

    Property Let set_kp(aData)
        write_kp_value = aData
        flag_kp        = &H1
    End Property

    Property Get read_kp
        read
        read_kp = read_kp_value
    End Property

    Property Let write_kp(aData)
        set_kp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pdiv_value = rightShift(data_low, 12) and &Hf
        read_ka_value = rightShift(data_low, 7) and &H7
        read_ki_value = rightShift(data_low, 4) and &H7
        kp_mask = &Hf
        if data_low > LONG_MAX then
            if kp_mask = mask then
                read_kp_value = data_low
            else
                read_kp_value = (data_low - H8000_0000) and kp_mask
            end If
        else
            read_kp_value = data_low and kp_mask
        end If

    End Sub

    Sub write
        If flag_pdiv = &H0 or flag_ka = &H0 or flag_ki = &H0 or flag_kp = &H0 Then read
        If flag_pdiv = &H0 Then write_pdiv_value = get_pdiv
        If flag_ka = &H0 Then write_ka_value = get_ka
        If flag_ki = &H0 Then write_ki_value = get_ki
        If flag_kp = &H0 Then write_kp_value = get_kp

        regValue = leftShift((write_pdiv_value and &Hf), 12) + leftShift((write_ka_value and &H7), 7) + leftShift((write_ki_value and &H7), 4) + leftShift((write_kp_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pdiv_value = rightShift(data_low, 12) and &Hf
        read_ka_value = rightShift(data_low, 7) and &H7
        read_ki_value = rightShift(data_low, 4) and &H7
        kp_mask = &Hf
        if data_low > LONG_MAX then
            if kp_mask = mask then
                read_kp_value = data_low
            else
                read_kp_value = (data_low - H8000_0000) and kp_mask
            end If
        else
            read_kp_value = data_low and kp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pdiv_value = &H0
        flag_pdiv        = &H0
        write_ka_value = &H0
        flag_ka        = &H0
        write_ki_value = &H0
        flag_ki        = &H0
        write_kp_value = &H0
        flag_kp        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_config2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll2_bypass_en                             [15:12]          get_pll2_bypass_en
''                                                             set_pll2_bypass_en
''                                                             read_pll2_bypass_en
''                                                             write_pll2_bypass_en
''---------------------------------------------------------------------------------
'' pll2_ch_delay                              [11:8]           get_pll2_ch_delay
''                                                             set_pll2_ch_delay
''                                                             read_pll2_ch_delay
''                                                             write_pll2_ch_delay
''---------------------------------------------------------------------------------
'' pll2_ch_hold                               [7:4]            get_pll2_ch_hold
''                                                             set_pll2_ch_hold
''                                                             read_pll2_ch_hold
''                                                             write_pll2_ch_hold
''---------------------------------------------------------------------------------
'' pll2_ch_en_n                               [3:0]            get_pll2_ch_en_n
''                                                             set_pll2_ch_en_n
''                                                             read_pll2_ch_en_n
''                                                             write_pll2_ch_en_n
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_config2
    Private write_pll2_bypass_en_value
    Private read_pll2_bypass_en_value
    Private flag_pll2_bypass_en
    Private write_pll2_ch_delay_value
    Private read_pll2_ch_delay_value
    Private flag_pll2_ch_delay
    Private write_pll2_ch_hold_value
    Private read_pll2_ch_hold_value
    Private flag_pll2_ch_hold
    Private write_pll2_ch_en_n_value
    Private read_pll2_ch_en_n_value
    Private flag_pll2_ch_en_n

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H92
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll2_bypass_en
        get_pll2_bypass_en = read_pll2_bypass_en_value
    End Property

    Property Let set_pll2_bypass_en(aData)
        write_pll2_bypass_en_value = aData
        flag_pll2_bypass_en        = &H1
    End Property

    Property Get read_pll2_bypass_en
        read
        read_pll2_bypass_en = read_pll2_bypass_en_value
    End Property

    Property Let write_pll2_bypass_en(aData)
        set_pll2_bypass_en = aData
        write
    End Property

    Property Get get_pll2_ch_delay
        get_pll2_ch_delay = read_pll2_ch_delay_value
    End Property

    Property Let set_pll2_ch_delay(aData)
        write_pll2_ch_delay_value = aData
        flag_pll2_ch_delay        = &H1
    End Property

    Property Get read_pll2_ch_delay
        read
        read_pll2_ch_delay = read_pll2_ch_delay_value
    End Property

    Property Let write_pll2_ch_delay(aData)
        set_pll2_ch_delay = aData
        write
    End Property

    Property Get get_pll2_ch_hold
        get_pll2_ch_hold = read_pll2_ch_hold_value
    End Property

    Property Let set_pll2_ch_hold(aData)
        write_pll2_ch_hold_value = aData
        flag_pll2_ch_hold        = &H1
    End Property

    Property Get read_pll2_ch_hold
        read
        read_pll2_ch_hold = read_pll2_ch_hold_value
    End Property

    Property Let write_pll2_ch_hold(aData)
        set_pll2_ch_hold = aData
        write
    End Property

    Property Get get_pll2_ch_en_n
        get_pll2_ch_en_n = read_pll2_ch_en_n_value
    End Property

    Property Let set_pll2_ch_en_n(aData)
        write_pll2_ch_en_n_value = aData
        flag_pll2_ch_en_n        = &H1
    End Property

    Property Get read_pll2_ch_en_n
        read
        read_pll2_ch_en_n = read_pll2_ch_en_n_value
    End Property

    Property Let write_pll2_ch_en_n(aData)
        set_pll2_ch_en_n = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll2_bypass_en_value = rightShift(data_low, 12) and &Hf
        read_pll2_ch_delay_value = rightShift(data_low, 8) and &Hf
        read_pll2_ch_hold_value = rightShift(data_low, 4) and &Hf
        pll2_ch_en_n_mask = &Hf
        if data_low > LONG_MAX then
            if pll2_ch_en_n_mask = mask then
                read_pll2_ch_en_n_value = data_low
            else
                read_pll2_ch_en_n_value = (data_low - H8000_0000) and pll2_ch_en_n_mask
            end If
        else
            read_pll2_ch_en_n_value = data_low and pll2_ch_en_n_mask
        end If

    End Sub

    Sub write
        If flag_pll2_bypass_en = &H0 or flag_pll2_ch_delay = &H0 or flag_pll2_ch_hold = &H0 or flag_pll2_ch_en_n = &H0 Then read
        If flag_pll2_bypass_en = &H0 Then write_pll2_bypass_en_value = get_pll2_bypass_en
        If flag_pll2_ch_delay = &H0 Then write_pll2_ch_delay_value = get_pll2_ch_delay
        If flag_pll2_ch_hold = &H0 Then write_pll2_ch_hold_value = get_pll2_ch_hold
        If flag_pll2_ch_en_n = &H0 Then write_pll2_ch_en_n_value = get_pll2_ch_en_n

        regValue = leftShift((write_pll2_bypass_en_value and &Hf), 12) + leftShift((write_pll2_ch_delay_value and &Hf), 8) + leftShift((write_pll2_ch_hold_value and &Hf), 4) + leftShift((write_pll2_ch_en_n_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll2_bypass_en_value = rightShift(data_low, 12) and &Hf
        read_pll2_ch_delay_value = rightShift(data_low, 8) and &Hf
        read_pll2_ch_hold_value = rightShift(data_low, 4) and &Hf
        pll2_ch_en_n_mask = &Hf
        if data_low > LONG_MAX then
            if pll2_ch_en_n_mask = mask then
                read_pll2_ch_en_n_value = data_low
            else
                read_pll2_ch_en_n_value = (data_low - H8000_0000) and pll2_ch_en_n_mask
            end If
        else
            read_pll2_ch_en_n_value = data_low and pll2_ch_en_n_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll2_bypass_en_value = &H0
        flag_pll2_bypass_en        = &H0
        write_pll2_ch_delay_value = &H0
        flag_pll2_ch_delay        = &H0
        write_pll2_ch_hold_value = &H0
        flag_pll2_ch_hold        = &H0
        write_pll2_ch_en_n_value = &H0
        flag_pll2_ch_en_n        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ndiv
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NDIV_INT                                   [9:0]            get_NDIV_INT
''                                                             set_NDIV_INT
''                                                             read_NDIV_INT
''                                                             write_NDIV_INT
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ndiv
    Private write_NDIV_INT_value
    Private read_NDIV_INT_value
    Private flag_NDIV_INT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NDIV_INT
        get_NDIV_INT = read_NDIV_INT_value
    End Property

    Property Let set_NDIV_INT(aData)
        write_NDIV_INT_value = aData
        flag_NDIV_INT        = &H1
    End Property

    Property Get read_NDIV_INT
        read
        read_NDIV_INT = read_NDIV_INT_value
    End Property

    Property Let write_NDIV_INT(aData)
        set_NDIV_INT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NDIV_INT_mask = &H3ff
        if data_low > LONG_MAX then
            if NDIV_INT_mask = mask then
                read_NDIV_INT_value = data_low
            else
                read_NDIV_INT_value = (data_low - H8000_0000) and NDIV_INT_mask
            end If
        else
            read_NDIV_INT_value = data_low and NDIV_INT_mask
        end If

    End Sub

    Sub write
        If flag_NDIV_INT = &H0 Then read
        If flag_NDIV_INT = &H0 Then write_NDIV_INT_value = get_NDIV_INT

        regValue = leftShift((write_NDIV_INT_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NDIV_INT_mask = &H3ff
        if data_low > LONG_MAX then
            if NDIV_INT_mask = mask then
                read_NDIV_INT_value = data_low
            else
                read_NDIV_INT_value = (data_low - H8000_0000) and NDIV_INT_mask
            end If
        else
            read_NDIV_INT_value = data_low and NDIV_INT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NDIV_INT_value = &H0
        flag_NDIV_INT        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll2_ctrl0                                 [15:0]           get_pll2_ctrl0
''                                                             set_pll2_ctrl0
''                                                             read_pll2_ctrl0
''                                                             write_pll2_ctrl0
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ctrl0
    Private write_pll2_ctrl0_value
    Private read_pll2_ctrl0_value
    Private flag_pll2_ctrl0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H96
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll2_ctrl0
        get_pll2_ctrl0 = read_pll2_ctrl0_value
    End Property

    Property Let set_pll2_ctrl0(aData)
        write_pll2_ctrl0_value = aData
        flag_pll2_ctrl0        = &H1
    End Property

    Property Get read_pll2_ctrl0
        read
        read_pll2_ctrl0 = read_pll2_ctrl0_value
    End Property

    Property Let write_pll2_ctrl0(aData)
        set_pll2_ctrl0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl0_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl0_mask = mask then
                read_pll2_ctrl0_value = data_low
            else
                read_pll2_ctrl0_value = (data_low - H8000_0000) and pll2_ctrl0_mask
            end If
        else
            read_pll2_ctrl0_value = data_low and pll2_ctrl0_mask
        end If

    End Sub

    Sub write
        If flag_pll2_ctrl0 = &H0 Then read
        If flag_pll2_ctrl0 = &H0 Then write_pll2_ctrl0_value = get_pll2_ctrl0

        regValue = leftShift((write_pll2_ctrl0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl0_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl0_mask = mask then
                read_pll2_ctrl0_value = data_low
            else
                read_pll2_ctrl0_value = (data_low - H8000_0000) and pll2_ctrl0_mask
            end If
        else
            read_pll2_ctrl0_value = data_low and pll2_ctrl0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll2_ctrl0_value = &H0
        flag_pll2_ctrl0        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll2_ctrl1                                 [15:0]           get_pll2_ctrl1
''                                                             set_pll2_ctrl1
''                                                             read_pll2_ctrl1
''                                                             write_pll2_ctrl1
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ctrl1
    Private write_pll2_ctrl1_value
    Private read_pll2_ctrl1_value
    Private flag_pll2_ctrl1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll2_ctrl1
        get_pll2_ctrl1 = read_pll2_ctrl1_value
    End Property

    Property Let set_pll2_ctrl1(aData)
        write_pll2_ctrl1_value = aData
        flag_pll2_ctrl1        = &H1
    End Property

    Property Get read_pll2_ctrl1
        read
        read_pll2_ctrl1 = read_pll2_ctrl1_value
    End Property

    Property Let write_pll2_ctrl1(aData)
        set_pll2_ctrl1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl1_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl1_mask = mask then
                read_pll2_ctrl1_value = data_low
            else
                read_pll2_ctrl1_value = (data_low - H8000_0000) and pll2_ctrl1_mask
            end If
        else
            read_pll2_ctrl1_value = data_low and pll2_ctrl1_mask
        end If

    End Sub

    Sub write
        If flag_pll2_ctrl1 = &H0 Then read
        If flag_pll2_ctrl1 = &H0 Then write_pll2_ctrl1_value = get_pll2_ctrl1

        regValue = leftShift((write_pll2_ctrl1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl1_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl1_mask = mask then
                read_pll2_ctrl1_value = data_low
            else
                read_pll2_ctrl1_value = (data_low - H8000_0000) and pll2_ctrl1_mask
            end If
        else
            read_pll2_ctrl1_value = data_low and pll2_ctrl1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll2_ctrl1_value = &H0
        flag_pll2_ctrl1        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll2_ctrl2                                 [15:0]           get_pll2_ctrl2
''                                                             set_pll2_ctrl2
''                                                             read_pll2_ctrl2
''                                                             write_pll2_ctrl2
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ctrl2
    Private write_pll2_ctrl2_value
    Private read_pll2_ctrl2_value
    Private flag_pll2_ctrl2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll2_ctrl2
        get_pll2_ctrl2 = read_pll2_ctrl2_value
    End Property

    Property Let set_pll2_ctrl2(aData)
        write_pll2_ctrl2_value = aData
        flag_pll2_ctrl2        = &H1
    End Property

    Property Get read_pll2_ctrl2
        read
        read_pll2_ctrl2 = read_pll2_ctrl2_value
    End Property

    Property Let write_pll2_ctrl2(aData)
        set_pll2_ctrl2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl2_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl2_mask = mask then
                read_pll2_ctrl2_value = data_low
            else
                read_pll2_ctrl2_value = (data_low - H8000_0000) and pll2_ctrl2_mask
            end If
        else
            read_pll2_ctrl2_value = data_low and pll2_ctrl2_mask
        end If

    End Sub

    Sub write
        If flag_pll2_ctrl2 = &H0 Then read
        If flag_pll2_ctrl2 = &H0 Then write_pll2_ctrl2_value = get_pll2_ctrl2

        regValue = leftShift((write_pll2_ctrl2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl2_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl2_mask = mask then
                read_pll2_ctrl2_value = data_low
            else
                read_pll2_ctrl2_value = (data_low - H8000_0000) and pll2_ctrl2_mask
            end If
        else
            read_pll2_ctrl2_value = data_low and pll2_ctrl2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll2_ctrl2_value = &H0
        flag_pll2_ctrl2        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll2_ctrl3                                 [15:0]           get_pll2_ctrl3
''                                                             set_pll2_ctrl3
''                                                             read_pll2_ctrl3
''                                                             write_pll2_ctrl3
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ctrl3
    Private write_pll2_ctrl3_value
    Private read_pll2_ctrl3_value
    Private flag_pll2_ctrl3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll2_ctrl3
        get_pll2_ctrl3 = read_pll2_ctrl3_value
    End Property

    Property Let set_pll2_ctrl3(aData)
        write_pll2_ctrl3_value = aData
        flag_pll2_ctrl3        = &H1
    End Property

    Property Get read_pll2_ctrl3
        read
        read_pll2_ctrl3 = read_pll2_ctrl3_value
    End Property

    Property Let write_pll2_ctrl3(aData)
        set_pll2_ctrl3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl3_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl3_mask = mask then
                read_pll2_ctrl3_value = data_low
            else
                read_pll2_ctrl3_value = (data_low - H8000_0000) and pll2_ctrl3_mask
            end If
        else
            read_pll2_ctrl3_value = data_low and pll2_ctrl3_mask
        end If

    End Sub

    Sub write
        If flag_pll2_ctrl3 = &H0 Then read
        If flag_pll2_ctrl3 = &H0 Then write_pll2_ctrl3_value = get_pll2_ctrl3

        regValue = leftShift((write_pll2_ctrl3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pll2_ctrl3_mask = &Hffff
        if data_low > LONG_MAX then
            if pll2_ctrl3_mask = mask then
                read_pll2_ctrl3_value = data_low
            else
                read_pll2_ctrl3_value = (data_low - H8000_0000) and pll2_ctrl3_mask
            end If
        else
            read_pll2_ctrl3_value = data_low and pll2_ctrl3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll2_ctrl3_value = &H0
        flag_pll2_ctrl3        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_mdiv_ch01
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdiv_ch1                                   [15:8]           get_mdiv_ch1
''                                                             set_mdiv_ch1
''                                                             read_mdiv_ch1
''                                                             write_mdiv_ch1
''---------------------------------------------------------------------------------
'' mdiv_ch0                                   [7:0]            get_mdiv_ch0
''                                                             set_mdiv_ch0
''                                                             read_mdiv_ch0
''                                                             write_mdiv_ch0
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_mdiv_ch01
    Private write_mdiv_ch1_value
    Private read_mdiv_ch1_value
    Private flag_mdiv_ch1
    Private write_mdiv_ch0_value
    Private read_mdiv_ch0_value
    Private flag_mdiv_ch0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mdiv_ch1
        get_mdiv_ch1 = read_mdiv_ch1_value
    End Property

    Property Let set_mdiv_ch1(aData)
        write_mdiv_ch1_value = aData
        flag_mdiv_ch1        = &H1
    End Property

    Property Get read_mdiv_ch1
        read
        read_mdiv_ch1 = read_mdiv_ch1_value
    End Property

    Property Let write_mdiv_ch1(aData)
        set_mdiv_ch1 = aData
        write
    End Property

    Property Get get_mdiv_ch0
        get_mdiv_ch0 = read_mdiv_ch0_value
    End Property

    Property Let set_mdiv_ch0(aData)
        write_mdiv_ch0_value = aData
        flag_mdiv_ch0        = &H1
    End Property

    Property Get read_mdiv_ch0
        read
        read_mdiv_ch0 = read_mdiv_ch0_value
    End Property

    Property Let write_mdiv_ch0(aData)
        set_mdiv_ch0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch1_value = rightShift(data_low, 8) and &Hff
        mdiv_ch0_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch0_mask = mask then
                read_mdiv_ch0_value = data_low
            else
                read_mdiv_ch0_value = (data_low - H8000_0000) and mdiv_ch0_mask
            end If
        else
            read_mdiv_ch0_value = data_low and mdiv_ch0_mask
        end If

    End Sub

    Sub write
        If flag_mdiv_ch1 = &H0 or flag_mdiv_ch0 = &H0 Then read
        If flag_mdiv_ch1 = &H0 Then write_mdiv_ch1_value = get_mdiv_ch1
        If flag_mdiv_ch0 = &H0 Then write_mdiv_ch0_value = get_mdiv_ch0

        regValue = leftShift((write_mdiv_ch1_value and &Hff), 8) + leftShift((write_mdiv_ch0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch1_value = rightShift(data_low, 8) and &Hff
        mdiv_ch0_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch0_mask = mask then
                read_mdiv_ch0_value = data_low
            else
                read_mdiv_ch0_value = (data_low - H8000_0000) and mdiv_ch0_mask
            end If
        else
            read_mdiv_ch0_value = data_low and mdiv_ch0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdiv_ch1_value = &H0
        flag_mdiv_ch1        = &H0
        write_mdiv_ch0_value = &H0
        flag_mdiv_ch0        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_mdiv_ch23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdiv_ch3                                   [15:8]           get_mdiv_ch3
''                                                             set_mdiv_ch3
''                                                             read_mdiv_ch3
''                                                             write_mdiv_ch3
''---------------------------------------------------------------------------------
'' mdiv_ch2                                   [7:0]            get_mdiv_ch2
''                                                             set_mdiv_ch2
''                                                             read_mdiv_ch2
''                                                             write_mdiv_ch2
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_mdiv_ch23
    Private write_mdiv_ch3_value
    Private read_mdiv_ch3_value
    Private flag_mdiv_ch3
    Private write_mdiv_ch2_value
    Private read_mdiv_ch2_value
    Private flag_mdiv_ch2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mdiv_ch3
        get_mdiv_ch3 = read_mdiv_ch3_value
    End Property

    Property Let set_mdiv_ch3(aData)
        write_mdiv_ch3_value = aData
        flag_mdiv_ch3        = &H1
    End Property

    Property Get read_mdiv_ch3
        read
        read_mdiv_ch3 = read_mdiv_ch3_value
    End Property

    Property Let write_mdiv_ch3(aData)
        set_mdiv_ch3 = aData
        write
    End Property

    Property Get get_mdiv_ch2
        get_mdiv_ch2 = read_mdiv_ch2_value
    End Property

    Property Let set_mdiv_ch2(aData)
        write_mdiv_ch2_value = aData
        flag_mdiv_ch2        = &H1
    End Property

    Property Get read_mdiv_ch2
        read
        read_mdiv_ch2 = read_mdiv_ch2_value
    End Property

    Property Let write_mdiv_ch2(aData)
        set_mdiv_ch2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch3_value = rightShift(data_low, 8) and &Hff
        mdiv_ch2_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch2_mask = mask then
                read_mdiv_ch2_value = data_low
            else
                read_mdiv_ch2_value = (data_low - H8000_0000) and mdiv_ch2_mask
            end If
        else
            read_mdiv_ch2_value = data_low and mdiv_ch2_mask
        end If

    End Sub

    Sub write
        If flag_mdiv_ch3 = &H0 or flag_mdiv_ch2 = &H0 Then read
        If flag_mdiv_ch3 = &H0 Then write_mdiv_ch3_value = get_mdiv_ch3
        If flag_mdiv_ch2 = &H0 Then write_mdiv_ch2_value = get_mdiv_ch2

        regValue = leftShift((write_mdiv_ch3_value and &Hff), 8) + leftShift((write_mdiv_ch2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdiv_ch3_value = rightShift(data_low, 8) and &Hff
        mdiv_ch2_mask = &Hff
        if data_low > LONG_MAX then
            if mdiv_ch2_mask = mask then
                read_mdiv_ch2_value = data_low
            else
                read_mdiv_ch2_value = (data_low - H8000_0000) and mdiv_ch2_mask
            end If
        else
            read_mdiv_ch2_value = data_low and mdiv_ch2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdiv_ch3_value = &H0
        flag_mdiv_ch3        = &H0
        write_mdiv_ch2_value = &H0
        flag_mdiv_ch2        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ssc_config1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scc_limit_hi                               [13:8]           get_scc_limit_hi
''                                                             set_scc_limit_hi
''                                                             read_scc_limit_hi
''                                                             write_scc_limit_hi
''---------------------------------------------------------------------------------
'' SSC_mode                                   [0:0]            get_SSC_mode
''                                                             set_SSC_mode
''                                                             read_SSC_mode
''                                                             write_SSC_mode
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ssc_config1
    Private write_scc_limit_hi_value
    Private read_scc_limit_hi_value
    Private flag_scc_limit_hi
    Private write_SSC_mode_value
    Private read_SSC_mode_value
    Private flag_SSC_mode

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_scc_limit_hi
        get_scc_limit_hi = read_scc_limit_hi_value
    End Property

    Property Let set_scc_limit_hi(aData)
        write_scc_limit_hi_value = aData
        flag_scc_limit_hi        = &H1
    End Property

    Property Get read_scc_limit_hi
        read
        read_scc_limit_hi = read_scc_limit_hi_value
    End Property

    Property Let write_scc_limit_hi(aData)
        set_scc_limit_hi = aData
        write
    End Property

    Property Get get_SSC_mode
        get_SSC_mode = read_SSC_mode_value
    End Property

    Property Let set_SSC_mode(aData)
        write_SSC_mode_value = aData
        flag_SSC_mode        = &H1
    End Property

    Property Get read_SSC_mode
        read
        read_SSC_mode = read_SSC_mode_value
    End Property

    Property Let write_SSC_mode(aData)
        set_SSC_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_scc_limit_hi_value = rightShift(data_low, 8) and &H3f
        SSC_mode_mask = &H1
        if data_low > LONG_MAX then
            if SSC_mode_mask = mask then
                read_SSC_mode_value = data_low
            else
                read_SSC_mode_value = (data_low - H8000_0000) and SSC_mode_mask
            end If
        else
            read_SSC_mode_value = data_low and SSC_mode_mask
        end If

    End Sub

    Sub write
        If flag_scc_limit_hi = &H0 or flag_SSC_mode = &H0 Then read
        If flag_scc_limit_hi = &H0 Then write_scc_limit_hi_value = get_scc_limit_hi
        If flag_SSC_mode = &H0 Then write_SSC_mode_value = get_SSC_mode

        regValue = leftShift((write_scc_limit_hi_value and &H3f), 8) + leftShift((write_SSC_mode_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_scc_limit_hi_value = rightShift(data_low, 8) and &H3f
        SSC_mode_mask = &H1
        if data_low > LONG_MAX then
            if SSC_mode_mask = mask then
                read_SSC_mode_value = data_low
            else
                read_SSC_mode_value = (data_low - H8000_0000) and SSC_mode_mask
            end If
        else
            read_SSC_mode_value = data_low and SSC_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scc_limit_hi_value = &H0
        flag_scc_limit_hi        = &H0
        write_SSC_mode_value = &H0
        flag_SSC_mode        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ssc_config2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scc_limit_low                              [15:0]           get_scc_limit_low
''                                                             set_scc_limit_low
''                                                             read_scc_limit_low
''                                                             write_scc_limit_low
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ssc_config2
    Private write_scc_limit_low_value
    Private read_scc_limit_low_value
    Private flag_scc_limit_low

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_scc_limit_low
        get_scc_limit_low = read_scc_limit_low_value
    End Property

    Property Let set_scc_limit_low(aData)
        write_scc_limit_low_value = aData
        flag_scc_limit_low        = &H1
    End Property

    Property Get read_scc_limit_low
        read
        read_scc_limit_low = read_scc_limit_low_value
    End Property

    Property Let write_scc_limit_low(aData)
        set_scc_limit_low = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scc_limit_low_mask = &Hffff
        if data_low > LONG_MAX then
            if scc_limit_low_mask = mask then
                read_scc_limit_low_value = data_low
            else
                read_scc_limit_low_value = (data_low - H8000_0000) and scc_limit_low_mask
            end If
        else
            read_scc_limit_low_value = data_low and scc_limit_low_mask
        end If

    End Sub

    Sub write
        If flag_scc_limit_low = &H0 Then read
        If flag_scc_limit_low = &H0 Then write_scc_limit_low_value = get_scc_limit_low

        regValue = leftShift((write_scc_limit_low_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scc_limit_low_mask = &Hffff
        if data_low > LONG_MAX then
            if scc_limit_low_mask = mask then
                read_scc_limit_low_value = data_low
            else
                read_scc_limit_low_value = (data_low - H8000_0000) and scc_limit_low_mask
            end If
        else
            read_scc_limit_low_value = data_low and scc_limit_low_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scc_limit_low_value = &H0
        flag_scc_limit_low        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_ssc_step
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SCC_step                                   [15:0]           get_SCC_step
''                                                             set_SCC_step
''                                                             read_SCC_step
''                                                             write_SCC_step
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_ssc_step
    Private write_SCC_step_value
    Private read_SCC_step_value
    Private flag_SCC_step

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SCC_step
        get_SCC_step = read_SCC_step_value
    End Property

    Property Let set_SCC_step(aData)
        write_SCC_step_value = aData
        flag_SCC_step        = &H1
    End Property

    Property Get read_SCC_step
        read
        read_SCC_step = read_SCC_step_value
    End Property

    Property Let write_SCC_step(aData)
        set_SCC_step = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SCC_step_mask = &Hffff
        if data_low > LONG_MAX then
            if SCC_step_mask = mask then
                read_SCC_step_value = data_low
            else
                read_SCC_step_value = (data_low - H8000_0000) and SCC_step_mask
            end If
        else
            read_SCC_step_value = data_low and SCC_step_mask
        end If

    End Sub

    Sub write
        If flag_SCC_step = &H0 Then read
        If flag_SCC_step = &H0 Then write_SCC_step_value = get_SCC_step

        regValue = leftShift((write_SCC_step_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SCC_step_mask = &Hffff
        if data_low > LONG_MAX then
            if SCC_step_mask = mask then
                read_SCC_step_value = data_low
            else
                read_SCC_step_value = (data_low - H8000_0000) and SCC_step_mask
            end If
        else
            read_SCC_step_value = data_low and SCC_step_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SCC_step_value = &H0
        flag_SCC_step        = &H0
    End Sub
End Class


'' @REGISTER : CRG_pll2_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll2_lock                                  [13:13]          get_pll2_lock
''                                                             set_pll2_lock
''                                                             read_pll2_lock
''                                                             write_pll2_lock
''---------------------------------------------------------------------------------
'' pll2_lock_lost                             [12:12]          get_pll2_lock_lost
''                                                             set_pll2_lock_lost
''                                                             read_pll2_lock_lost
''                                                             write_pll2_lock_lost
''---------------------------------------------------------------------------------
'' pll2_status                                [11:0]           get_pll2_status
''                                                             set_pll2_status
''                                                             read_pll2_status
''                                                             write_pll2_status
''---------------------------------------------------------------------------------
Class REGISTER_CRG_pll2_status
    Private write_pll2_lock_value
    Private read_pll2_lock_value
    Private flag_pll2_lock
    Private write_pll2_lock_lost_value
    Private read_pll2_lock_lost_value
    Private flag_pll2_lock_lost
    Private write_pll2_status_value
    Private read_pll2_status_value
    Private flag_pll2_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pll2_lock
        get_pll2_lock = read_pll2_lock_value
    End Property

    Property Let set_pll2_lock(aData)
        write_pll2_lock_value = aData
        flag_pll2_lock        = &H1
    End Property

    Property Get read_pll2_lock
        read
        read_pll2_lock = read_pll2_lock_value
    End Property

    Property Let write_pll2_lock(aData)
        set_pll2_lock = aData
        write
    End Property

    Property Get get_pll2_lock_lost
        get_pll2_lock_lost = read_pll2_lock_lost_value
    End Property

    Property Let set_pll2_lock_lost(aData)
        write_pll2_lock_lost_value = aData
        flag_pll2_lock_lost        = &H1
    End Property

    Property Get read_pll2_lock_lost
        read
        read_pll2_lock_lost = read_pll2_lock_lost_value
    End Property

    Property Let write_pll2_lock_lost(aData)
        set_pll2_lock_lost = aData
        write
    End Property

    Property Get get_pll2_status
        get_pll2_status = read_pll2_status_value
    End Property

    Property Let set_pll2_status(aData)
        write_pll2_status_value = aData
        flag_pll2_status        = &H1
    End Property

    Property Get read_pll2_status
        read
        read_pll2_status = read_pll2_status_value
    End Property

    Property Let write_pll2_status(aData)
        set_pll2_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll2_lock_value = rightShift(data_low, 13) and &H1
        read_pll2_lock_lost_value = rightShift(data_low, 12) and &H1
        pll2_status_mask = &Hfff
        if data_low > LONG_MAX then
            if pll2_status_mask = mask then
                read_pll2_status_value = data_low
            else
                read_pll2_status_value = (data_low - H8000_0000) and pll2_status_mask
            end If
        else
            read_pll2_status_value = data_low and pll2_status_mask
        end If

    End Sub

    Sub write
        If flag_pll2_lock = &H0 or flag_pll2_lock_lost = &H0 or flag_pll2_status = &H0 Then read
        If flag_pll2_lock = &H0 Then write_pll2_lock_value = get_pll2_lock
        If flag_pll2_lock_lost = &H0 Then write_pll2_lock_lost_value = get_pll2_lock_lost
        If flag_pll2_status = &H0 Then write_pll2_status_value = get_pll2_status

        regValue = leftShift((write_pll2_lock_value and &H1), 13) + leftShift((write_pll2_lock_lost_value and &H1), 12) + leftShift((write_pll2_status_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll2_lock_value = rightShift(data_low, 13) and &H1
        read_pll2_lock_lost_value = rightShift(data_low, 12) and &H1
        pll2_status_mask = &Hfff
        if data_low > LONG_MAX then
            if pll2_status_mask = mask then
                read_pll2_status_value = data_low
            else
                read_pll2_status_value = (data_low - H8000_0000) and pll2_status_mask
            end If
        else
            read_pll2_status_value = data_low and pll2_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll2_lock_value = &H0
        flag_pll2_lock        = &H0
        write_pll2_lock_lost_value = &H0
        flag_pll2_lock_lost        = &H0
        write_pll2_status_value = &H0
        flag_pll2_status        = &H0
    End Sub
End Class


'' @REGISTER : CRG_scratch_reg
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
Class REGISTER_CRG_scratch_reg
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

Class CRG_INSTANCE

    Public xtal_config
    Public pll_config1
    Public pll_config2
    Public pll_ndiv
    Public pll_ctrl0
    Public pll_ctrl1
    Public pll_ctrl2
    Public pll_ctrl3
    Public pll_mdiv_ch01
    Public pll_mdiv_ch23
    Public pll_ssc_config1
    Public pll_ssc_config2
    Public pll_ssc_step
    Public pll_status
    Public clock_config1
    Public clock_config2
    Public iddq_chip
    Public iddq_config
    Public reset_config
    Public reset_config2
    Public xtal_config_cml50
    Public sm_ctrl
    Public sm_fault_ctrl
    Public sm_clr_log
    Public sm_tim_ctrl
    Public sm_tim_val
    Public sm_tim_evt_clr
    Public sm_sw_trigger
    Public sm_sw_reason
    Public sm_cnt_64us_lo
    Public sm_cnt_64us_hi
    Public sm_status
    Public sm_raw_log_lo
    Public sm_raw_log_hi
    Public sm_fault_log
    Public rcosc_lfo_ctrl
    Public rcosc_lfo_cal
    Public rcosc_lfo_ctrl2
    Public rcosc_status
    Public pll2_config1
    Public pll2_config2
    Public pll2_ndiv
    Public pll2_ctrl0
    Public pll2_ctrl1
    Public pll2_ctrl2
    Public pll2_ctrl3
    Public pll2_mdiv_ch01
    Public pll2_mdiv_ch23
    Public pll2_ssc_config1
    Public pll2_ssc_config2
    Public pll2_ssc_step
    Public pll2_status
    Public scratch_reg


    Public default function Init(aBaseAddr)
        Set xtal_config = (New REGISTER_CRG_xtal_config)(aBaseAddr, 16)
        Set pll_config1 = (New REGISTER_CRG_pll_config1)(aBaseAddr, 16)
        Set pll_config2 = (New REGISTER_CRG_pll_config2)(aBaseAddr, 16)
        Set pll_ndiv = (New REGISTER_CRG_pll_ndiv)(aBaseAddr, 16)
        Set pll_ctrl0 = (New REGISTER_CRG_pll_ctrl0)(aBaseAddr, 16)
        Set pll_ctrl1 = (New REGISTER_CRG_pll_ctrl1)(aBaseAddr, 16)
        Set pll_ctrl2 = (New REGISTER_CRG_pll_ctrl2)(aBaseAddr, 16)
        Set pll_ctrl3 = (New REGISTER_CRG_pll_ctrl3)(aBaseAddr, 16)
        Set pll_mdiv_ch01 = (New REGISTER_CRG_pll_mdiv_ch01)(aBaseAddr, 16)
        Set pll_mdiv_ch23 = (New REGISTER_CRG_pll_mdiv_ch23)(aBaseAddr, 16)
        Set pll_ssc_config1 = (New REGISTER_CRG_pll_ssc_config1)(aBaseAddr, 16)
        Set pll_ssc_config2 = (New REGISTER_CRG_pll_ssc_config2)(aBaseAddr, 16)
        Set pll_ssc_step = (New REGISTER_CRG_pll_ssc_step)(aBaseAddr, 16)
        Set pll_status = (New REGISTER_CRG_pll_status)(aBaseAddr, 16)
        Set clock_config1 = (New REGISTER_CRG_clock_config1)(aBaseAddr, 16)
        Set clock_config2 = (New REGISTER_CRG_clock_config2)(aBaseAddr, 16)
        Set iddq_chip = (New REGISTER_CRG_iddq_chip)(aBaseAddr, 16)
        Set iddq_config = (New REGISTER_CRG_iddq_config)(aBaseAddr, 16)
        Set reset_config = (New REGISTER_CRG_reset_config)(aBaseAddr, 16)
        Set reset_config2 = (New REGISTER_CRG_reset_config2)(aBaseAddr, 16)
        Set xtal_config_cml50 = (New REGISTER_CRG_xtal_config_cml50)(aBaseAddr, 16)
        Set sm_ctrl = (New REGISTER_CRG_sm_ctrl)(aBaseAddr, 16)
        Set sm_fault_ctrl = (New REGISTER_CRG_sm_fault_ctrl)(aBaseAddr, 16)
        Set sm_clr_log = (New REGISTER_CRG_sm_clr_log)(aBaseAddr, 16)
        Set sm_tim_ctrl = (New REGISTER_CRG_sm_tim_ctrl)(aBaseAddr, 16)
        Set sm_tim_val = (New REGISTER_CRG_sm_tim_val)(aBaseAddr, 16)
        Set sm_tim_evt_clr = (New REGISTER_CRG_sm_tim_evt_clr)(aBaseAddr, 16)
        Set sm_sw_trigger = (New REGISTER_CRG_sm_sw_trigger)(aBaseAddr, 16)
        Set sm_sw_reason = (New REGISTER_CRG_sm_sw_reason)(aBaseAddr, 16)
        Set sm_cnt_64us_lo = (New REGISTER_CRG_sm_cnt_64us_lo)(aBaseAddr, 16)
        Set sm_cnt_64us_hi = (New REGISTER_CRG_sm_cnt_64us_hi)(aBaseAddr, 16)
        Set sm_status = (New REGISTER_CRG_sm_status)(aBaseAddr, 16)
        Set sm_raw_log_lo = (New REGISTER_CRG_sm_raw_log_lo)(aBaseAddr, 16)
        Set sm_raw_log_hi = (New REGISTER_CRG_sm_raw_log_hi)(aBaseAddr, 16)
        Set sm_fault_log = (New REGISTER_CRG_sm_fault_log)(aBaseAddr, 16)
        Set rcosc_lfo_ctrl = (New REGISTER_CRG_rcosc_lfo_ctrl)(aBaseAddr, 16)
        Set rcosc_lfo_cal = (New REGISTER_CRG_rcosc_lfo_cal)(aBaseAddr, 16)
        Set rcosc_lfo_ctrl2 = (New REGISTER_CRG_rcosc_lfo_ctrl2)(aBaseAddr, 16)
        Set rcosc_status = (New REGISTER_CRG_rcosc_status)(aBaseAddr, 16)
        Set pll2_config1 = (New REGISTER_CRG_pll2_config1)(aBaseAddr, 16)
        Set pll2_config2 = (New REGISTER_CRG_pll2_config2)(aBaseAddr, 16)
        Set pll2_ndiv = (New REGISTER_CRG_pll2_ndiv)(aBaseAddr, 16)
        Set pll2_ctrl0 = (New REGISTER_CRG_pll2_ctrl0)(aBaseAddr, 16)
        Set pll2_ctrl1 = (New REGISTER_CRG_pll2_ctrl1)(aBaseAddr, 16)
        Set pll2_ctrl2 = (New REGISTER_CRG_pll2_ctrl2)(aBaseAddr, 16)
        Set pll2_ctrl3 = (New REGISTER_CRG_pll2_ctrl3)(aBaseAddr, 16)
        Set pll2_mdiv_ch01 = (New REGISTER_CRG_pll2_mdiv_ch01)(aBaseAddr, 16)
        Set pll2_mdiv_ch23 = (New REGISTER_CRG_pll2_mdiv_ch23)(aBaseAddr, 16)
        Set pll2_ssc_config1 = (New REGISTER_CRG_pll2_ssc_config1)(aBaseAddr, 16)
        Set pll2_ssc_config2 = (New REGISTER_CRG_pll2_ssc_config2)(aBaseAddr, 16)
        Set pll2_ssc_step = (New REGISTER_CRG_pll2_ssc_step)(aBaseAddr, 16)
        Set pll2_status = (New REGISTER_CRG_pll2_status)(aBaseAddr, 16)
        Set scratch_reg = (New REGISTER_CRG_scratch_reg)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CRG = CreateObject("System.Collections.ArrayList")
CRG.Add ((New CRG_INSTANCE)(&H4a820000))


