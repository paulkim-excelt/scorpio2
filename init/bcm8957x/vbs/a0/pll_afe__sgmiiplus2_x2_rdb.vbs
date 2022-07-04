

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


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' en_test_integer_clk                        [15:15]          get_en_test_integer_clk
''                                                             set_en_test_integer_clk
''                                                             read_en_test_integer_clk
''                                                             write_en_test_integer_clk
''---------------------------------------------------------------------------------
'' xtal_bias                                  [14:12]          get_xtal_bias
''                                                             set_xtal_bias
''                                                             read_xtal_bias
''                                                             write_xtal_bias
''---------------------------------------------------------------------------------
'' cpar                                       [11:10]          get_cpar
''                                                             set_cpar
''                                                             read_cpar
''                                                             write_cpar
''---------------------------------------------------------------------------------
'' rpar                                       [9:6]            get_rpar
''                                                             set_rpar
''                                                             read_rpar
''                                                             write_rpar
''---------------------------------------------------------------------------------
'' curr_sel                                   [5:2]            get_curr_sel
''                                                             set_curr_sel
''                                                             read_curr_sel
''                                                             write_curr_sel
''---------------------------------------------------------------------------------
'' hipass                                     [1:1]            get_hipass
''                                                             set_hipass
''                                                             read_hipass
''                                                             write_hipass
''---------------------------------------------------------------------------------
'' CM_sel                                     [0:0]            get_CM_sel
''                                                             set_CM_sel
''                                                             read_CM_sel
''                                                             write_CM_sel
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl0
    Private write_en_test_integer_clk_value
    Private read_en_test_integer_clk_value
    Private flag_en_test_integer_clk
    Private write_xtal_bias_value
    Private read_xtal_bias_value
    Private flag_xtal_bias
    Private write_cpar_value
    Private read_cpar_value
    Private flag_cpar
    Private write_rpar_value
    Private read_rpar_value
    Private flag_rpar
    Private write_curr_sel_value
    Private read_curr_sel_value
    Private flag_curr_sel
    Private write_hipass_value
    Private read_hipass_value
    Private flag_hipass
    Private write_CM_sel_value
    Private read_CM_sel_value
    Private flag_CM_sel

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

    Property Get get_en_test_integer_clk
        get_en_test_integer_clk = read_en_test_integer_clk_value
    End Property

    Property Let set_en_test_integer_clk(aData)
        write_en_test_integer_clk_value = aData
        flag_en_test_integer_clk        = &H1
    End Property

    Property Get read_en_test_integer_clk
        read
        read_en_test_integer_clk = read_en_test_integer_clk_value
    End Property

    Property Let write_en_test_integer_clk(aData)
        set_en_test_integer_clk = aData
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

    Property Get get_cpar
        get_cpar = read_cpar_value
    End Property

    Property Let set_cpar(aData)
        write_cpar_value = aData
        flag_cpar        = &H1
    End Property

    Property Get read_cpar
        read
        read_cpar = read_cpar_value
    End Property

    Property Let write_cpar(aData)
        set_cpar = aData
        write
    End Property

    Property Get get_rpar
        get_rpar = read_rpar_value
    End Property

    Property Let set_rpar(aData)
        write_rpar_value = aData
        flag_rpar        = &H1
    End Property

    Property Get read_rpar
        read
        read_rpar = read_rpar_value
    End Property

    Property Let write_rpar(aData)
        set_rpar = aData
        write
    End Property

    Property Get get_curr_sel
        get_curr_sel = read_curr_sel_value
    End Property

    Property Let set_curr_sel(aData)
        write_curr_sel_value = aData
        flag_curr_sel        = &H1
    End Property

    Property Get read_curr_sel
        read
        read_curr_sel = read_curr_sel_value
    End Property

    Property Let write_curr_sel(aData)
        set_curr_sel = aData
        write
    End Property

    Property Get get_hipass
        get_hipass = read_hipass_value
    End Property

    Property Let set_hipass(aData)
        write_hipass_value = aData
        flag_hipass        = &H1
    End Property

    Property Get read_hipass
        read
        read_hipass = read_hipass_value
    End Property

    Property Let write_hipass(aData)
        set_hipass = aData
        write
    End Property

    Property Get get_CM_sel
        get_CM_sel = read_CM_sel_value
    End Property

    Property Let set_CM_sel(aData)
        write_CM_sel_value = aData
        flag_CM_sel        = &H1
    End Property

    Property Get read_CM_sel
        read
        read_CM_sel = read_CM_sel_value
    End Property

    Property Let write_CM_sel(aData)
        set_CM_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_en_test_integer_clk_value = rightShift(data_low, 15) and &H1
        read_xtal_bias_value = rightShift(data_low, 12) and &H7
        read_cpar_value = rightShift(data_low, 10) and &H3
        read_rpar_value = rightShift(data_low, 6) and &Hf
        read_curr_sel_value = rightShift(data_low, 2) and &Hf
        read_hipass_value = rightShift(data_low, 1) and &H1
        CM_sel_mask = &H1
        if data_low > LONG_MAX then
            if CM_sel_mask = mask then
                read_CM_sel_value = data_low
            else
                read_CM_sel_value = (data_low - H8000_0000) and CM_sel_mask
            end If
        else
            read_CM_sel_value = data_low and CM_sel_mask
        end If

    End Sub

    Sub write
        If flag_en_test_integer_clk = &H0 or flag_xtal_bias = &H0 or flag_cpar = &H0 or flag_rpar = &H0 or flag_curr_sel = &H0 or flag_hipass = &H0 or flag_CM_sel = &H0 Then read
        If flag_en_test_integer_clk = &H0 Then write_en_test_integer_clk_value = get_en_test_integer_clk
        If flag_xtal_bias = &H0 Then write_xtal_bias_value = get_xtal_bias
        If flag_cpar = &H0 Then write_cpar_value = get_cpar
        If flag_rpar = &H0 Then write_rpar_value = get_rpar
        If flag_curr_sel = &H0 Then write_curr_sel_value = get_curr_sel
        If flag_hipass = &H0 Then write_hipass_value = get_hipass
        If flag_CM_sel = &H0 Then write_CM_sel_value = get_CM_sel

        regValue = leftShift((write_en_test_integer_clk_value and &H1), 15) + leftShift((write_xtal_bias_value and &H7), 12) + leftShift((write_cpar_value and &H3), 10) + leftShift((write_rpar_value and &Hf), 6) + leftShift((write_curr_sel_value and &Hf), 2) + leftShift((write_hipass_value and &H1), 1) + leftShift((write_CM_sel_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_en_test_integer_clk_value = rightShift(data_low, 15) and &H1
        read_xtal_bias_value = rightShift(data_low, 12) and &H7
        read_cpar_value = rightShift(data_low, 10) and &H3
        read_rpar_value = rightShift(data_low, 6) and &Hf
        read_curr_sel_value = rightShift(data_low, 2) and &Hf
        read_hipass_value = rightShift(data_low, 1) and &H1
        CM_sel_mask = &H1
        if data_low > LONG_MAX then
            if CM_sel_mask = mask then
                read_CM_sel_value = data_low
            else
                read_CM_sel_value = (data_low - H8000_0000) and CM_sel_mask
            end If
        else
            read_CM_sel_value = data_low and CM_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_en_test_integer_clk_value = &H0
        flag_en_test_integer_clk        = &H0
        write_xtal_bias_value = &H0
        flag_xtal_bias        = &H0
        write_cpar_value = &H0
        flag_cpar        = &H0
        write_rpar_value = &H0
        flag_rpar        = &H0
        write_curr_sel_value = &H0
        flag_curr_sel        = &H0
        write_hipass_value = &H0
        flag_hipass        = &H0
        write_CM_sel_value = &H0
        flag_CM_sel        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' leakage_test                               [11:10]          get_leakage_test
''                                                             set_leakage_test
''                                                             read_leakage_test
''                                                             write_leakage_test
''---------------------------------------------------------------------------------
'' PLL_pon                                    [9:6]            get_PLL_pon
''                                                             set_PLL_pon
''                                                             read_PLL_pon
''                                                             write_PLL_pon
''---------------------------------------------------------------------------------
'' xtal_core_bias                             [5:2]            get_xtal_core_bias
''                                                             set_xtal_core_bias
''                                                             read_xtal_core_bias
''                                                             write_xtal_core_bias
''---------------------------------------------------------------------------------
'' lv_en                                      [1:1]            get_lv_en
''                                                             set_lv_en
''                                                             read_lv_en
''                                                             write_lv_en
''---------------------------------------------------------------------------------
'' en_test_frac_clk                           [0:0]            get_en_test_frac_clk
''                                                             set_en_test_frac_clk
''                                                             read_en_test_frac_clk
''                                                             write_en_test_frac_clk
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl1
    Private write_leakage_test_value
    Private read_leakage_test_value
    Private flag_leakage_test
    Private write_PLL_pon_value
    Private read_PLL_pon_value
    Private flag_PLL_pon
    Private write_xtal_core_bias_value
    Private read_xtal_core_bias_value
    Private flag_xtal_core_bias
    Private write_lv_en_value
    Private read_lv_en_value
    Private flag_lv_en
    Private write_en_test_frac_clk_value
    Private read_en_test_frac_clk_value
    Private flag_en_test_frac_clk

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

    Property Get get_leakage_test
        get_leakage_test = read_leakage_test_value
    End Property

    Property Let set_leakage_test(aData)
        write_leakage_test_value = aData
        flag_leakage_test        = &H1
    End Property

    Property Get read_leakage_test
        read
        read_leakage_test = read_leakage_test_value
    End Property

    Property Let write_leakage_test(aData)
        set_leakage_test = aData
        write
    End Property

    Property Get get_PLL_pon
        get_PLL_pon = read_PLL_pon_value
    End Property

    Property Let set_PLL_pon(aData)
        write_PLL_pon_value = aData
        flag_PLL_pon        = &H1
    End Property

    Property Get read_PLL_pon
        read
        read_PLL_pon = read_PLL_pon_value
    End Property

    Property Let write_PLL_pon(aData)
        set_PLL_pon = aData
        write
    End Property

    Property Get get_xtal_core_bias
        get_xtal_core_bias = read_xtal_core_bias_value
    End Property

    Property Let set_xtal_core_bias(aData)
        write_xtal_core_bias_value = aData
        flag_xtal_core_bias        = &H1
    End Property

    Property Get read_xtal_core_bias
        read
        read_xtal_core_bias = read_xtal_core_bias_value
    End Property

    Property Let write_xtal_core_bias(aData)
        set_xtal_core_bias = aData
        write
    End Property

    Property Get get_lv_en
        get_lv_en = read_lv_en_value
    End Property

    Property Let set_lv_en(aData)
        write_lv_en_value = aData
        flag_lv_en        = &H1
    End Property

    Property Get read_lv_en
        read
        read_lv_en = read_lv_en_value
    End Property

    Property Let write_lv_en(aData)
        set_lv_en = aData
        write
    End Property

    Property Get get_en_test_frac_clk
        get_en_test_frac_clk = read_en_test_frac_clk_value
    End Property

    Property Let set_en_test_frac_clk(aData)
        write_en_test_frac_clk_value = aData
        flag_en_test_frac_clk        = &H1
    End Property

    Property Get read_en_test_frac_clk
        read
        read_en_test_frac_clk = read_en_test_frac_clk_value
    End Property

    Property Let write_en_test_frac_clk(aData)
        set_en_test_frac_clk = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_leakage_test_value = rightShift(data_low, 10) and &H3
        read_PLL_pon_value = rightShift(data_low, 6) and &Hf
        read_xtal_core_bias_value = rightShift(data_low, 2) and &Hf
        read_lv_en_value = rightShift(data_low, 1) and &H1
        en_test_frac_clk_mask = &H1
        if data_low > LONG_MAX then
            if en_test_frac_clk_mask = mask then
                read_en_test_frac_clk_value = data_low
            else
                read_en_test_frac_clk_value = (data_low - H8000_0000) and en_test_frac_clk_mask
            end If
        else
            read_en_test_frac_clk_value = data_low and en_test_frac_clk_mask
        end If

    End Sub

    Sub write
        If flag_leakage_test = &H0 or flag_PLL_pon = &H0 or flag_xtal_core_bias = &H0 or flag_lv_en = &H0 or flag_en_test_frac_clk = &H0 Then read
        If flag_leakage_test = &H0 Then write_leakage_test_value = get_leakage_test
        If flag_PLL_pon = &H0 Then write_PLL_pon_value = get_PLL_pon
        If flag_xtal_core_bias = &H0 Then write_xtal_core_bias_value = get_xtal_core_bias
        If flag_lv_en = &H0 Then write_lv_en_value = get_lv_en
        If flag_en_test_frac_clk = &H0 Then write_en_test_frac_clk_value = get_en_test_frac_clk

        regValue = leftShift((write_leakage_test_value and &H3), 10) + leftShift((write_PLL_pon_value and &Hf), 6) + leftShift((write_xtal_core_bias_value and &Hf), 2) + leftShift((write_lv_en_value and &H1), 1) + leftShift((write_en_test_frac_clk_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_leakage_test_value = rightShift(data_low, 10) and &H3
        read_PLL_pon_value = rightShift(data_low, 6) and &Hf
        read_xtal_core_bias_value = rightShift(data_low, 2) and &Hf
        read_lv_en_value = rightShift(data_low, 1) and &H1
        en_test_frac_clk_mask = &H1
        if data_low > LONG_MAX then
            if en_test_frac_clk_mask = mask then
                read_en_test_frac_clk_value = data_low
            else
                read_en_test_frac_clk_value = (data_low - H8000_0000) and en_test_frac_clk_mask
            end If
        else
            read_en_test_frac_clk_value = data_low and en_test_frac_clk_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_leakage_test_value = &H0
        flag_leakage_test        = &H0
        write_PLL_pon_value = &H0
        flag_PLL_pon        = &H0
        write_xtal_core_bias_value = &H0
        flag_xtal_core_bias        = &H0
        write_lv_en_value = &H0
        flag_lv_en        = &H0
        write_en_test_frac_clk_value = &H0
        flag_en_test_frac_clk        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' i_pll_frac_mode                            [15:14]          get_i_pll_frac_mode
''                                                             set_i_pll_frac_mode
''                                                             read_i_pll_frac_mode
''                                                             write_i_pll_frac_mode
''---------------------------------------------------------------------------------
'' vco_ictr                                   [13:11]          get_vco_ictr
''                                                             set_vco_ictr
''                                                             read_vco_ictr
''                                                             write_vco_ictr
''---------------------------------------------------------------------------------
'' test_pll_mode                              [10:10]          get_test_pll_mode
''                                                             set_test_pll_mode
''                                                             read_test_pll_mode
''                                                             write_test_pll_mode
''---------------------------------------------------------------------------------
'' test_amp                                   [8:5]            get_test_amp
''                                                             set_test_amp
''                                                             read_test_amp
''                                                             write_test_amp
''---------------------------------------------------------------------------------
'' intN_fb_en                                 [4:4]            get_intN_fb_en
''                                                             set_intN_fb_en
''                                                             read_intN_fb_en
''                                                             write_intN_fb_en
''---------------------------------------------------------------------------------
'' en10T                                      [3:3]            get_en10T
''                                                             set_en10T
''                                                             read_en10T
''                                                             write_en10T
''---------------------------------------------------------------------------------
'' test_vc                                    [2:2]            get_test_vc
''                                                             set_test_vc
''                                                             read_test_vc
''                                                             write_test_vc
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl2
    Private write_i_pll_frac_mode_value
    Private read_i_pll_frac_mode_value
    Private flag_i_pll_frac_mode
    Private write_vco_ictr_value
    Private read_vco_ictr_value
    Private flag_vco_ictr
    Private write_test_pll_mode_value
    Private read_test_pll_mode_value
    Private flag_test_pll_mode
    Private write_test_amp_value
    Private read_test_amp_value
    Private flag_test_amp
    Private write_intN_fb_en_value
    Private read_intN_fb_en_value
    Private flag_intN_fb_en
    Private write_en10T_value
    Private read_en10T_value
    Private flag_en10T
    Private write_test_vc_value
    Private read_test_vc_value
    Private flag_test_vc

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

    Property Get get_i_pll_frac_mode
        get_i_pll_frac_mode = read_i_pll_frac_mode_value
    End Property

    Property Let set_i_pll_frac_mode(aData)
        write_i_pll_frac_mode_value = aData
        flag_i_pll_frac_mode        = &H1
    End Property

    Property Get read_i_pll_frac_mode
        read
        read_i_pll_frac_mode = read_i_pll_frac_mode_value
    End Property

    Property Let write_i_pll_frac_mode(aData)
        set_i_pll_frac_mode = aData
        write
    End Property

    Property Get get_vco_ictr
        get_vco_ictr = read_vco_ictr_value
    End Property

    Property Let set_vco_ictr(aData)
        write_vco_ictr_value = aData
        flag_vco_ictr        = &H1
    End Property

    Property Get read_vco_ictr
        read
        read_vco_ictr = read_vco_ictr_value
    End Property

    Property Let write_vco_ictr(aData)
        set_vco_ictr = aData
        write
    End Property

    Property Get get_test_pll_mode
        get_test_pll_mode = read_test_pll_mode_value
    End Property

    Property Let set_test_pll_mode(aData)
        write_test_pll_mode_value = aData
        flag_test_pll_mode        = &H1
    End Property

    Property Get read_test_pll_mode
        read
        read_test_pll_mode = read_test_pll_mode_value
    End Property

    Property Let write_test_pll_mode(aData)
        set_test_pll_mode = aData
        write
    End Property

    Property Get get_test_amp
        get_test_amp = read_test_amp_value
    End Property

    Property Let set_test_amp(aData)
        write_test_amp_value = aData
        flag_test_amp        = &H1
    End Property

    Property Get read_test_amp
        read
        read_test_amp = read_test_amp_value
    End Property

    Property Let write_test_amp(aData)
        set_test_amp = aData
        write
    End Property

    Property Get get_intN_fb_en
        get_intN_fb_en = read_intN_fb_en_value
    End Property

    Property Let set_intN_fb_en(aData)
        write_intN_fb_en_value = aData
        flag_intN_fb_en        = &H1
    End Property

    Property Get read_intN_fb_en
        read
        read_intN_fb_en = read_intN_fb_en_value
    End Property

    Property Let write_intN_fb_en(aData)
        set_intN_fb_en = aData
        write
    End Property

    Property Get get_en10T
        get_en10T = read_en10T_value
    End Property

    Property Let set_en10T(aData)
        write_en10T_value = aData
        flag_en10T        = &H1
    End Property

    Property Get read_en10T
        read
        read_en10T = read_en10T_value
    End Property

    Property Let write_en10T(aData)
        set_en10T = aData
        write
    End Property

    Property Get get_test_vc
        get_test_vc = read_test_vc_value
    End Property

    Property Let set_test_vc(aData)
        write_test_vc_value = aData
        flag_test_vc        = &H1
    End Property

    Property Get read_test_vc
        read
        read_test_vc = read_test_vc_value
    End Property

    Property Let write_test_vc(aData)
        set_test_vc = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_pll_frac_mode_value = rightShift(data_low, 14) and &H3
        read_vco_ictr_value = rightShift(data_low, 11) and &H7
        read_test_pll_mode_value = rightShift(data_low, 10) and &H1
        read_test_amp_value = rightShift(data_low, 5) and &Hf
        read_intN_fb_en_value = rightShift(data_low, 4) and &H1
        read_en10T_value = rightShift(data_low, 3) and &H1
        read_test_vc_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_i_pll_frac_mode = &H0 or flag_vco_ictr = &H0 or flag_test_pll_mode = &H0 or flag_test_amp = &H0 or flag_intN_fb_en = &H0 or flag_en10T = &H0 or flag_test_vc = &H0 Then read
        If flag_i_pll_frac_mode = &H0 Then write_i_pll_frac_mode_value = get_i_pll_frac_mode
        If flag_vco_ictr = &H0 Then write_vco_ictr_value = get_vco_ictr
        If flag_test_pll_mode = &H0 Then write_test_pll_mode_value = get_test_pll_mode
        If flag_test_amp = &H0 Then write_test_amp_value = get_test_amp
        If flag_intN_fb_en = &H0 Then write_intN_fb_en_value = get_intN_fb_en
        If flag_en10T = &H0 Then write_en10T_value = get_en10T
        If flag_test_vc = &H0 Then write_test_vc_value = get_test_vc

        regValue = leftShift((write_i_pll_frac_mode_value and &H3), 14) + leftShift((write_vco_ictr_value and &H7), 11) + leftShift((write_test_pll_mode_value and &H1), 10) + leftShift((write_test_amp_value and &Hf), 5) + leftShift((write_intN_fb_en_value and &H1), 4) + leftShift((write_en10T_value and &H1), 3) + leftShift((write_test_vc_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_pll_frac_mode_value = rightShift(data_low, 14) and &H3
        read_vco_ictr_value = rightShift(data_low, 11) and &H7
        read_test_pll_mode_value = rightShift(data_low, 10) and &H1
        read_test_amp_value = rightShift(data_low, 5) and &Hf
        read_intN_fb_en_value = rightShift(data_low, 4) and &H1
        read_en10T_value = rightShift(data_low, 3) and &H1
        read_test_vc_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_i_pll_frac_mode_value = &H0
        flag_i_pll_frac_mode        = &H0
        write_vco_ictr_value = &H0
        flag_vco_ictr        = &H0
        write_test_pll_mode_value = &H0
        flag_test_pll_mode        = &H0
        write_test_amp_value = &H0
        flag_test_amp        = &H0
        write_intN_fb_en_value = &H0
        flag_intN_fb_en        = &H0
        write_en10T_value = &H0
        flag_en10T        = &H0
        write_test_vc_value = &H0
        flag_test_vc        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pll_mode                                   [15:15]          get_pll_mode
''                                                             set_pll_mode
''                                                             read_pll_mode
''                                                             write_pll_mode
''---------------------------------------------------------------------------------
'' refclk_in_bias                             [14:9]           get_refclk_in_bias
''                                                             set_refclk_in_bias
''                                                             read_refclk_in_bias
''                                                             write_refclk_in_bias
''---------------------------------------------------------------------------------
'' int_div_en                                 [8:8]            get_int_div_en
''                                                             set_int_div_en
''                                                             read_int_div_en
''                                                             write_int_div_en
''---------------------------------------------------------------------------------
'' mmd_en                                     [7:7]            get_mmd_en
''                                                             set_mmd_en
''                                                             read_mmd_en
''                                                             write_mmd_en
''---------------------------------------------------------------------------------
'' test_sel                                   [6:4]            get_test_sel
''                                                             set_test_sel
''                                                             read_test_sel
''                                                             write_test_sel
''---------------------------------------------------------------------------------
'' testclk_en                                 [3:3]            get_testclk_en
''                                                             set_testclk_en
''                                                             read_testclk_en
''                                                             write_testclk_en
''---------------------------------------------------------------------------------
'' tcest_neg                                  [2:0]            get_tcest_neg
''                                                             set_tcest_neg
''                                                             read_tcest_neg
''                                                             write_tcest_neg
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl3
    Private write_pll_mode_value
    Private read_pll_mode_value
    Private flag_pll_mode
    Private write_refclk_in_bias_value
    Private read_refclk_in_bias_value
    Private flag_refclk_in_bias
    Private write_int_div_en_value
    Private read_int_div_en_value
    Private flag_int_div_en
    Private write_mmd_en_value
    Private read_mmd_en_value
    Private flag_mmd_en
    Private write_test_sel_value
    Private read_test_sel_value
    Private flag_test_sel
    Private write_testclk_en_value
    Private read_testclk_en_value
    Private flag_testclk_en
    Private write_tcest_neg_value
    Private read_tcest_neg_value
    Private flag_tcest_neg

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

    Property Get get_pll_mode
        get_pll_mode = read_pll_mode_value
    End Property

    Property Let set_pll_mode(aData)
        write_pll_mode_value = aData
        flag_pll_mode        = &H1
    End Property

    Property Get read_pll_mode
        read
        read_pll_mode = read_pll_mode_value
    End Property

    Property Let write_pll_mode(aData)
        set_pll_mode = aData
        write
    End Property

    Property Get get_refclk_in_bias
        get_refclk_in_bias = read_refclk_in_bias_value
    End Property

    Property Let set_refclk_in_bias(aData)
        write_refclk_in_bias_value = aData
        flag_refclk_in_bias        = &H1
    End Property

    Property Get read_refclk_in_bias
        read
        read_refclk_in_bias = read_refclk_in_bias_value
    End Property

    Property Let write_refclk_in_bias(aData)
        set_refclk_in_bias = aData
        write
    End Property

    Property Get get_int_div_en
        get_int_div_en = read_int_div_en_value
    End Property

    Property Let set_int_div_en(aData)
        write_int_div_en_value = aData
        flag_int_div_en        = &H1
    End Property

    Property Get read_int_div_en
        read
        read_int_div_en = read_int_div_en_value
    End Property

    Property Let write_int_div_en(aData)
        set_int_div_en = aData
        write
    End Property

    Property Get get_mmd_en
        get_mmd_en = read_mmd_en_value
    End Property

    Property Let set_mmd_en(aData)
        write_mmd_en_value = aData
        flag_mmd_en        = &H1
    End Property

    Property Get read_mmd_en
        read
        read_mmd_en = read_mmd_en_value
    End Property

    Property Let write_mmd_en(aData)
        set_mmd_en = aData
        write
    End Property

    Property Get get_test_sel
        get_test_sel = read_test_sel_value
    End Property

    Property Let set_test_sel(aData)
        write_test_sel_value = aData
        flag_test_sel        = &H1
    End Property

    Property Get read_test_sel
        read
        read_test_sel = read_test_sel_value
    End Property

    Property Let write_test_sel(aData)
        set_test_sel = aData
        write
    End Property

    Property Get get_testclk_en
        get_testclk_en = read_testclk_en_value
    End Property

    Property Let set_testclk_en(aData)
        write_testclk_en_value = aData
        flag_testclk_en        = &H1
    End Property

    Property Get read_testclk_en
        read
        read_testclk_en = read_testclk_en_value
    End Property

    Property Let write_testclk_en(aData)
        set_testclk_en = aData
        write
    End Property

    Property Get get_tcest_neg
        get_tcest_neg = read_tcest_neg_value
    End Property

    Property Let set_tcest_neg(aData)
        write_tcest_neg_value = aData
        flag_tcest_neg        = &H1
    End Property

    Property Get read_tcest_neg
        read
        read_tcest_neg = read_tcest_neg_value
    End Property

    Property Let write_tcest_neg(aData)
        set_tcest_neg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll_mode_value = rightShift(data_low, 15) and &H1
        read_refclk_in_bias_value = rightShift(data_low, 9) and &H3f
        read_int_div_en_value = rightShift(data_low, 8) and &H1
        read_mmd_en_value = rightShift(data_low, 7) and &H1
        read_test_sel_value = rightShift(data_low, 4) and &H7
        read_testclk_en_value = rightShift(data_low, 3) and &H1
        tcest_neg_mask = &H7
        if data_low > LONG_MAX then
            if tcest_neg_mask = mask then
                read_tcest_neg_value = data_low
            else
                read_tcest_neg_value = (data_low - H8000_0000) and tcest_neg_mask
            end If
        else
            read_tcest_neg_value = data_low and tcest_neg_mask
        end If

    End Sub

    Sub write
        If flag_pll_mode = &H0 or flag_refclk_in_bias = &H0 or flag_int_div_en = &H0 or flag_mmd_en = &H0 or flag_test_sel = &H0 or flag_testclk_en = &H0 or flag_tcest_neg = &H0 Then read
        If flag_pll_mode = &H0 Then write_pll_mode_value = get_pll_mode
        If flag_refclk_in_bias = &H0 Then write_refclk_in_bias_value = get_refclk_in_bias
        If flag_int_div_en = &H0 Then write_int_div_en_value = get_int_div_en
        If flag_mmd_en = &H0 Then write_mmd_en_value = get_mmd_en
        If flag_test_sel = &H0 Then write_test_sel_value = get_test_sel
        If flag_testclk_en = &H0 Then write_testclk_en_value = get_testclk_en
        If flag_tcest_neg = &H0 Then write_tcest_neg_value = get_tcest_neg

        regValue = leftShift((write_pll_mode_value and &H1), 15) + leftShift((write_refclk_in_bias_value and &H3f), 9) + leftShift((write_int_div_en_value and &H1), 8) + leftShift((write_mmd_en_value and &H1), 7) + leftShift((write_test_sel_value and &H7), 4) + leftShift((write_testclk_en_value and &H1), 3) + leftShift((write_tcest_neg_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pll_mode_value = rightShift(data_low, 15) and &H1
        read_refclk_in_bias_value = rightShift(data_low, 9) and &H3f
        read_int_div_en_value = rightShift(data_low, 8) and &H1
        read_mmd_en_value = rightShift(data_low, 7) and &H1
        read_test_sel_value = rightShift(data_low, 4) and &H7
        read_testclk_en_value = rightShift(data_low, 3) and &H1
        tcest_neg_mask = &H7
        if data_low > LONG_MAX then
            if tcest_neg_mask = mask then
                read_tcest_neg_value = data_low
            else
                read_tcest_neg_value = (data_low - H8000_0000) and tcest_neg_mask
            end If
        else
            read_tcest_neg_value = data_low and tcest_neg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pll_mode_value = &H0
        flag_pll_mode        = &H0
        write_refclk_in_bias_value = &H0
        flag_refclk_in_bias        = &H0
        write_int_div_en_value = &H0
        flag_int_div_en        = &H0
        write_mmd_en_value = &H0
        flag_mmd_en        = &H0
        write_test_sel_value = &H0
        flag_test_sel        = &H0
        write_testclk_en_value = &H0
        flag_testclk_en        = &H0
        write_tcest_neg_value = &H0
        flag_tcest_neg        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mmd_prsc8or9pwdb                           [15:15]          get_mmd_prsc8or9pwdb
''                                                             set_mmd_prsc8or9pwdb
''                                                             read_mmd_prsc8or9pwdb
''                                                             write_mmd_prsc8or9pwdb
''---------------------------------------------------------------------------------
'' adj                                        [14:12]          get_adj
''                                                             set_adj
''                                                             read_adj
''                                                             write_adj
''---------------------------------------------------------------------------------
'' mmd_resetb                                 [11:11]          get_mmd_resetb
''                                                             set_mmd_resetb
''                                                             read_mmd_resetb
''                                                             write_mmd_resetb
''---------------------------------------------------------------------------------
'' en_cap                                     [6:4]            get_en_cap
''                                                             set_en_cap
''                                                             read_en_cap
''                                                             write_en_cap
''---------------------------------------------------------------------------------
'' div                                        [3:0]            get_div
''                                                             set_div
''                                                             read_div
''                                                             write_div
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl4
    Private write_mmd_prsc8or9pwdb_value
    Private read_mmd_prsc8or9pwdb_value
    Private flag_mmd_prsc8or9pwdb
    Private write_adj_value
    Private read_adj_value
    Private flag_adj
    Private write_mmd_resetb_value
    Private read_mmd_resetb_value
    Private flag_mmd_resetb
    Private write_en_cap_value
    Private read_en_cap_value
    Private flag_en_cap
    Private write_div_value
    Private read_div_value
    Private flag_div

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

    Property Get get_mmd_prsc8or9pwdb
        get_mmd_prsc8or9pwdb = read_mmd_prsc8or9pwdb_value
    End Property

    Property Let set_mmd_prsc8or9pwdb(aData)
        write_mmd_prsc8or9pwdb_value = aData
        flag_mmd_prsc8or9pwdb        = &H1
    End Property

    Property Get read_mmd_prsc8or9pwdb
        read
        read_mmd_prsc8or9pwdb = read_mmd_prsc8or9pwdb_value
    End Property

    Property Let write_mmd_prsc8or9pwdb(aData)
        set_mmd_prsc8or9pwdb = aData
        write
    End Property

    Property Get get_adj
        get_adj = read_adj_value
    End Property

    Property Let set_adj(aData)
        write_adj_value = aData
        flag_adj        = &H1
    End Property

    Property Get read_adj
        read
        read_adj = read_adj_value
    End Property

    Property Let write_adj(aData)
        set_adj = aData
        write
    End Property

    Property Get get_mmd_resetb
        get_mmd_resetb = read_mmd_resetb_value
    End Property

    Property Let set_mmd_resetb(aData)
        write_mmd_resetb_value = aData
        flag_mmd_resetb        = &H1
    End Property

    Property Get read_mmd_resetb
        read
        read_mmd_resetb = read_mmd_resetb_value
    End Property

    Property Let write_mmd_resetb(aData)
        set_mmd_resetb = aData
        write
    End Property

    Property Get get_en_cap
        get_en_cap = read_en_cap_value
    End Property

    Property Let set_en_cap(aData)
        write_en_cap_value = aData
        flag_en_cap        = &H1
    End Property

    Property Get read_en_cap
        read
        read_en_cap = read_en_cap_value
    End Property

    Property Let write_en_cap(aData)
        set_en_cap = aData
        write
    End Property

    Property Get get_div
        get_div = read_div_value
    End Property

    Property Let set_div(aData)
        write_div_value = aData
        flag_div        = &H1
    End Property

    Property Get read_div
        read
        read_div = read_div_value
    End Property

    Property Let write_div(aData)
        set_div = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mmd_prsc8or9pwdb_value = rightShift(data_low, 15) and &H1
        read_adj_value = rightShift(data_low, 12) and &H7
        read_mmd_resetb_value = rightShift(data_low, 11) and &H1
        read_en_cap_value = rightShift(data_low, 4) and &H7
        div_mask = &Hf
        if data_low > LONG_MAX then
            if div_mask = mask then
                read_div_value = data_low
            else
                read_div_value = (data_low - H8000_0000) and div_mask
            end If
        else
            read_div_value = data_low and div_mask
        end If

    End Sub

    Sub write
        If flag_mmd_prsc8or9pwdb = &H0 or flag_adj = &H0 or flag_mmd_resetb = &H0 or flag_en_cap = &H0 or flag_div = &H0 Then read
        If flag_mmd_prsc8or9pwdb = &H0 Then write_mmd_prsc8or9pwdb_value = get_mmd_prsc8or9pwdb
        If flag_adj = &H0 Then write_adj_value = get_adj
        If flag_mmd_resetb = &H0 Then write_mmd_resetb_value = get_mmd_resetb
        If flag_en_cap = &H0 Then write_en_cap_value = get_en_cap
        If flag_div = &H0 Then write_div_value = get_div

        regValue = leftShift((write_mmd_prsc8or9pwdb_value and &H1), 15) + leftShift((write_adj_value and &H7), 12) + leftShift((write_mmd_resetb_value and &H1), 11) + leftShift((write_en_cap_value and &H7), 4) + leftShift((write_div_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mmd_prsc8or9pwdb_value = rightShift(data_low, 15) and &H1
        read_adj_value = rightShift(data_low, 12) and &H7
        read_mmd_resetb_value = rightShift(data_low, 11) and &H1
        read_en_cap_value = rightShift(data_low, 4) and &H7
        div_mask = &Hf
        if data_low > LONG_MAX then
            if div_mask = mask then
                read_div_value = data_low
            else
                read_div_value = (data_low - H8000_0000) and div_mask
            end If
        else
            read_div_value = data_low and div_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mmd_prsc8or9pwdb_value = &H0
        flag_mmd_prsc8or9pwdb        = &H0
        write_adj_value = &H0
        flag_adj        = &H0
        write_mmd_resetb_value = &H0
        flag_mmd_resetb        = &H0
        write_en_cap_value = &H0
        flag_en_cap        = &H0
        write_div_value = &H0
        flag_div        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' i_ndiv_frac_3_0                            [15:12]          get_i_ndiv_frac_3_0
''                                                             set_i_ndiv_frac_3_0
''                                                             read_i_ndiv_frac_3_0
''                                                             write_i_ndiv_frac_3_0
''---------------------------------------------------------------------------------
'' i_pfd_offset                               [11:10]          get_i_pfd_offset
''                                                             set_i_pfd_offset
''                                                             read_i_pfd_offset
''                                                             write_i_pfd_offset
''---------------------------------------------------------------------------------
'' Ref_doubler_en                             [9:9]            get_Ref_doubler_en
''                                                             set_Ref_doubler_en
''                                                             read_Ref_doubler_en
''                                                             write_Ref_doubler_en
''---------------------------------------------------------------------------------
'' I_pfd_offset_enlarge                       [8:8]            get_I_pfd_offset_enlarge
''                                                             set_I_pfd_offset_enlarge
''                                                             read_I_pfd_offset_enlarge
''                                                             write_I_pfd_offset_enlarge
''---------------------------------------------------------------------------------
'' en_cur                                     [7:5]            get_en_cur
''                                                             set_en_cur
''                                                             read_en_cur
''                                                             write_en_cur
''---------------------------------------------------------------------------------
'' calib_adj                                  [3:1]            get_calib_adj
''                                                             set_calib_adj
''                                                             read_calib_adj
''                                                             write_calib_adj
''---------------------------------------------------------------------------------
'' mmd_prsc4or5pwdb                           [0:0]            get_mmd_prsc4or5pwdb
''                                                             set_mmd_prsc4or5pwdb
''                                                             read_mmd_prsc4or5pwdb
''                                                             write_mmd_prsc4or5pwdb
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl5
    Private write_i_ndiv_frac_3_0_value
    Private read_i_ndiv_frac_3_0_value
    Private flag_i_ndiv_frac_3_0
    Private write_i_pfd_offset_value
    Private read_i_pfd_offset_value
    Private flag_i_pfd_offset
    Private write_Ref_doubler_en_value
    Private read_Ref_doubler_en_value
    Private flag_Ref_doubler_en
    Private write_I_pfd_offset_enlarge_value
    Private read_I_pfd_offset_enlarge_value
    Private flag_I_pfd_offset_enlarge
    Private write_en_cur_value
    Private read_en_cur_value
    Private flag_en_cur
    Private write_calib_adj_value
    Private read_calib_adj_value
    Private flag_calib_adj
    Private write_mmd_prsc4or5pwdb_value
    Private read_mmd_prsc4or5pwdb_value
    Private flag_mmd_prsc4or5pwdb

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

    Property Get get_i_ndiv_frac_3_0
        get_i_ndiv_frac_3_0 = read_i_ndiv_frac_3_0_value
    End Property

    Property Let set_i_ndiv_frac_3_0(aData)
        write_i_ndiv_frac_3_0_value = aData
        flag_i_ndiv_frac_3_0        = &H1
    End Property

    Property Get read_i_ndiv_frac_3_0
        read
        read_i_ndiv_frac_3_0 = read_i_ndiv_frac_3_0_value
    End Property

    Property Let write_i_ndiv_frac_3_0(aData)
        set_i_ndiv_frac_3_0 = aData
        write
    End Property

    Property Get get_i_pfd_offset
        get_i_pfd_offset = read_i_pfd_offset_value
    End Property

    Property Let set_i_pfd_offset(aData)
        write_i_pfd_offset_value = aData
        flag_i_pfd_offset        = &H1
    End Property

    Property Get read_i_pfd_offset
        read
        read_i_pfd_offset = read_i_pfd_offset_value
    End Property

    Property Let write_i_pfd_offset(aData)
        set_i_pfd_offset = aData
        write
    End Property

    Property Get get_Ref_doubler_en
        get_Ref_doubler_en = read_Ref_doubler_en_value
    End Property

    Property Let set_Ref_doubler_en(aData)
        write_Ref_doubler_en_value = aData
        flag_Ref_doubler_en        = &H1
    End Property

    Property Get read_Ref_doubler_en
        read
        read_Ref_doubler_en = read_Ref_doubler_en_value
    End Property

    Property Let write_Ref_doubler_en(aData)
        set_Ref_doubler_en = aData
        write
    End Property

    Property Get get_I_pfd_offset_enlarge
        get_I_pfd_offset_enlarge = read_I_pfd_offset_enlarge_value
    End Property

    Property Let set_I_pfd_offset_enlarge(aData)
        write_I_pfd_offset_enlarge_value = aData
        flag_I_pfd_offset_enlarge        = &H1
    End Property

    Property Get read_I_pfd_offset_enlarge
        read
        read_I_pfd_offset_enlarge = read_I_pfd_offset_enlarge_value
    End Property

    Property Let write_I_pfd_offset_enlarge(aData)
        set_I_pfd_offset_enlarge = aData
        write
    End Property

    Property Get get_en_cur
        get_en_cur = read_en_cur_value
    End Property

    Property Let set_en_cur(aData)
        write_en_cur_value = aData
        flag_en_cur        = &H1
    End Property

    Property Get read_en_cur
        read
        read_en_cur = read_en_cur_value
    End Property

    Property Let write_en_cur(aData)
        set_en_cur = aData
        write
    End Property

    Property Get get_calib_adj
        get_calib_adj = read_calib_adj_value
    End Property

    Property Let set_calib_adj(aData)
        write_calib_adj_value = aData
        flag_calib_adj        = &H1
    End Property

    Property Get read_calib_adj
        read
        read_calib_adj = read_calib_adj_value
    End Property

    Property Let write_calib_adj(aData)
        set_calib_adj = aData
        write
    End Property

    Property Get get_mmd_prsc4or5pwdb
        get_mmd_prsc4or5pwdb = read_mmd_prsc4or5pwdb_value
    End Property

    Property Let set_mmd_prsc4or5pwdb(aData)
        write_mmd_prsc4or5pwdb_value = aData
        flag_mmd_prsc4or5pwdb        = &H1
    End Property

    Property Get read_mmd_prsc4or5pwdb
        read
        read_mmd_prsc4or5pwdb = read_mmd_prsc4or5pwdb_value
    End Property

    Property Let write_mmd_prsc4or5pwdb(aData)
        set_mmd_prsc4or5pwdb = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_ndiv_frac_3_0_value = rightShift(data_low, 12) and &Hf
        read_i_pfd_offset_value = rightShift(data_low, 10) and &H3
        read_Ref_doubler_en_value = rightShift(data_low, 9) and &H1
        read_I_pfd_offset_enlarge_value = rightShift(data_low, 8) and &H1
        read_en_cur_value = rightShift(data_low, 5) and &H7
        read_calib_adj_value = rightShift(data_low, 1) and &H7
        mmd_prsc4or5pwdb_mask = &H1
        if data_low > LONG_MAX then
            if mmd_prsc4or5pwdb_mask = mask then
                read_mmd_prsc4or5pwdb_value = data_low
            else
                read_mmd_prsc4or5pwdb_value = (data_low - H8000_0000) and mmd_prsc4or5pwdb_mask
            end If
        else
            read_mmd_prsc4or5pwdb_value = data_low and mmd_prsc4or5pwdb_mask
        end If

    End Sub

    Sub write
        If flag_i_ndiv_frac_3_0 = &H0 or flag_i_pfd_offset = &H0 or flag_Ref_doubler_en = &H0 or flag_I_pfd_offset_enlarge = &H0 or flag_en_cur = &H0 or flag_calib_adj = &H0 or flag_mmd_prsc4or5pwdb = &H0 Then read
        If flag_i_ndiv_frac_3_0 = &H0 Then write_i_ndiv_frac_3_0_value = get_i_ndiv_frac_3_0
        If flag_i_pfd_offset = &H0 Then write_i_pfd_offset_value = get_i_pfd_offset
        If flag_Ref_doubler_en = &H0 Then write_Ref_doubler_en_value = get_Ref_doubler_en
        If flag_I_pfd_offset_enlarge = &H0 Then write_I_pfd_offset_enlarge_value = get_I_pfd_offset_enlarge
        If flag_en_cur = &H0 Then write_en_cur_value = get_en_cur
        If flag_calib_adj = &H0 Then write_calib_adj_value = get_calib_adj
        If flag_mmd_prsc4or5pwdb = &H0 Then write_mmd_prsc4or5pwdb_value = get_mmd_prsc4or5pwdb

        regValue = leftShift((write_i_ndiv_frac_3_0_value and &Hf), 12) + leftShift((write_i_pfd_offset_value and &H3), 10) + leftShift((write_Ref_doubler_en_value and &H1), 9) + leftShift((write_I_pfd_offset_enlarge_value and &H1), 8) + leftShift((write_en_cur_value and &H7), 5) + leftShift((write_calib_adj_value and &H7), 1) + leftShift((write_mmd_prsc4or5pwdb_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_ndiv_frac_3_0_value = rightShift(data_low, 12) and &Hf
        read_i_pfd_offset_value = rightShift(data_low, 10) and &H3
        read_Ref_doubler_en_value = rightShift(data_low, 9) and &H1
        read_I_pfd_offset_enlarge_value = rightShift(data_low, 8) and &H1
        read_en_cur_value = rightShift(data_low, 5) and &H7
        read_calib_adj_value = rightShift(data_low, 1) and &H7
        mmd_prsc4or5pwdb_mask = &H1
        if data_low > LONG_MAX then
            if mmd_prsc4or5pwdb_mask = mask then
                read_mmd_prsc4or5pwdb_value = data_low
            else
                read_mmd_prsc4or5pwdb_value = (data_low - H8000_0000) and mmd_prsc4or5pwdb_mask
            end If
        else
            read_mmd_prsc4or5pwdb_value = data_low and mmd_prsc4or5pwdb_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_i_ndiv_frac_3_0_value = &H0
        flag_i_ndiv_frac_3_0        = &H0
        write_i_pfd_offset_value = &H0
        flag_i_pfd_offset        = &H0
        write_Ref_doubler_en_value = &H0
        flag_Ref_doubler_en        = &H0
        write_I_pfd_offset_enlarge_value = &H0
        flag_I_pfd_offset_enlarge        = &H0
        write_en_cur_value = &H0
        flag_en_cur        = &H0
        write_calib_adj_value = &H0
        flag_calib_adj        = &H0
        write_mmd_prsc4or5pwdb_value = &H0
        flag_mmd_prsc4or5pwdb        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' i_ndiv_int_1_0                             [15:14]          get_i_ndiv_int_1_0
''                                                             set_i_ndiv_int_1_0
''                                                             read_i_ndiv_int_1_0
''                                                             write_i_ndiv_int_1_0
''---------------------------------------------------------------------------------
'' i_ndiv_frac_17_4                           [13:0]           get_i_ndiv_frac_17_4
''                                                             set_i_ndiv_frac_17_4
''                                                             read_i_ndiv_frac_17_4
''                                                             write_i_ndiv_frac_17_4
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl6
    Private write_i_ndiv_int_1_0_value
    Private read_i_ndiv_int_1_0_value
    Private flag_i_ndiv_int_1_0
    Private write_i_ndiv_frac_17_4_value
    Private read_i_ndiv_frac_17_4_value
    Private flag_i_ndiv_frac_17_4

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

    Property Get get_i_ndiv_int_1_0
        get_i_ndiv_int_1_0 = read_i_ndiv_int_1_0_value
    End Property

    Property Let set_i_ndiv_int_1_0(aData)
        write_i_ndiv_int_1_0_value = aData
        flag_i_ndiv_int_1_0        = &H1
    End Property

    Property Get read_i_ndiv_int_1_0
        read
        read_i_ndiv_int_1_0 = read_i_ndiv_int_1_0_value
    End Property

    Property Let write_i_ndiv_int_1_0(aData)
        set_i_ndiv_int_1_0 = aData
        write
    End Property

    Property Get get_i_ndiv_frac_17_4
        get_i_ndiv_frac_17_4 = read_i_ndiv_frac_17_4_value
    End Property

    Property Let set_i_ndiv_frac_17_4(aData)
        write_i_ndiv_frac_17_4_value = aData
        flag_i_ndiv_frac_17_4        = &H1
    End Property

    Property Get read_i_ndiv_frac_17_4
        read
        read_i_ndiv_frac_17_4 = read_i_ndiv_frac_17_4_value
    End Property

    Property Let write_i_ndiv_frac_17_4(aData)
        set_i_ndiv_frac_17_4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_ndiv_int_1_0_value = rightShift(data_low, 14) and &H3
        i_ndiv_frac_17_4_mask = &H3fff
        if data_low > LONG_MAX then
            if i_ndiv_frac_17_4_mask = mask then
                read_i_ndiv_frac_17_4_value = data_low
            else
                read_i_ndiv_frac_17_4_value = (data_low - H8000_0000) and i_ndiv_frac_17_4_mask
            end If
        else
            read_i_ndiv_frac_17_4_value = data_low and i_ndiv_frac_17_4_mask
        end If

    End Sub

    Sub write
        If flag_i_ndiv_int_1_0 = &H0 or flag_i_ndiv_frac_17_4 = &H0 Then read
        If flag_i_ndiv_int_1_0 = &H0 Then write_i_ndiv_int_1_0_value = get_i_ndiv_int_1_0
        If flag_i_ndiv_frac_17_4 = &H0 Then write_i_ndiv_frac_17_4_value = get_i_ndiv_frac_17_4

        regValue = leftShift((write_i_ndiv_int_1_0_value and &H3), 14) + leftShift((write_i_ndiv_frac_17_4_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_i_ndiv_int_1_0_value = rightShift(data_low, 14) and &H3
        i_ndiv_frac_17_4_mask = &H3fff
        if data_low > LONG_MAX then
            if i_ndiv_frac_17_4_mask = mask then
                read_i_ndiv_frac_17_4_value = data_low
            else
                read_i_ndiv_frac_17_4_value = (data_low - H8000_0000) and i_ndiv_frac_17_4_mask
            end If
        else
            read_i_ndiv_frac_17_4_value = data_low and i_ndiv_frac_17_4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_i_ndiv_int_1_0_value = &H0
        flag_i_ndiv_int_1_0        = &H0
        write_i_ndiv_frac_17_4_value = &H0
        flag_i_ndiv_frac_17_4        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sel_fp3cap                                 [15:12]          get_sel_fp3cap
''                                                             set_sel_fp3cap
''                                                             read_sel_fp3cap
''                                                             write_sel_fp3cap
''---------------------------------------------------------------------------------
'' i_pll_sdm_pwrdnb                           [11:11]          get_i_pll_sdm_pwrdnb
''                                                             set_i_pll_sdm_pwrdnb
''                                                             read_i_pll_sdm_pwrdnb
''                                                             write_i_pll_sdm_pwrdnb
''---------------------------------------------------------------------------------
'' inv_vco_cal                                [10:10]          get_inv_vco_cal
''                                                             set_inv_vco_cal
''                                                             read_inv_vco_cal
''                                                             write_inv_vco_cal
''---------------------------------------------------------------------------------
'' i_ndiv_dither_en                           [9:9]            get_i_ndiv_dither_en
''                                                             set_i_ndiv_dither_en
''                                                             read_i_ndiv_dither_en
''                                                             write_i_ndiv_dither_en
''---------------------------------------------------------------------------------
'' mmd_div_range                              [8:8]            get_mmd_div_range
''                                                             set_mmd_div_range
''                                                             read_mmd_div_range
''                                                             write_mmd_div_range
''---------------------------------------------------------------------------------
'' i_ndiv_int_9_2                             [7:0]            get_i_ndiv_int_9_2
''                                                             set_i_ndiv_int_9_2
''                                                             read_i_ndiv_int_9_2
''                                                             write_i_ndiv_int_9_2
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl7
    Private write_sel_fp3cap_value
    Private read_sel_fp3cap_value
    Private flag_sel_fp3cap
    Private write_i_pll_sdm_pwrdnb_value
    Private read_i_pll_sdm_pwrdnb_value
    Private flag_i_pll_sdm_pwrdnb
    Private write_inv_vco_cal_value
    Private read_inv_vco_cal_value
    Private flag_inv_vco_cal
    Private write_i_ndiv_dither_en_value
    Private read_i_ndiv_dither_en_value
    Private flag_i_ndiv_dither_en
    Private write_mmd_div_range_value
    Private read_mmd_div_range_value
    Private flag_mmd_div_range
    Private write_i_ndiv_int_9_2_value
    Private read_i_ndiv_int_9_2_value
    Private flag_i_ndiv_int_9_2

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

    Property Get get_sel_fp3cap
        get_sel_fp3cap = read_sel_fp3cap_value
    End Property

    Property Let set_sel_fp3cap(aData)
        write_sel_fp3cap_value = aData
        flag_sel_fp3cap        = &H1
    End Property

    Property Get read_sel_fp3cap
        read
        read_sel_fp3cap = read_sel_fp3cap_value
    End Property

    Property Let write_sel_fp3cap(aData)
        set_sel_fp3cap = aData
        write
    End Property

    Property Get get_i_pll_sdm_pwrdnb
        get_i_pll_sdm_pwrdnb = read_i_pll_sdm_pwrdnb_value
    End Property

    Property Let set_i_pll_sdm_pwrdnb(aData)
        write_i_pll_sdm_pwrdnb_value = aData
        flag_i_pll_sdm_pwrdnb        = &H1
    End Property

    Property Get read_i_pll_sdm_pwrdnb
        read
        read_i_pll_sdm_pwrdnb = read_i_pll_sdm_pwrdnb_value
    End Property

    Property Let write_i_pll_sdm_pwrdnb(aData)
        set_i_pll_sdm_pwrdnb = aData
        write
    End Property

    Property Get get_inv_vco_cal
        get_inv_vco_cal = read_inv_vco_cal_value
    End Property

    Property Let set_inv_vco_cal(aData)
        write_inv_vco_cal_value = aData
        flag_inv_vco_cal        = &H1
    End Property

    Property Get read_inv_vco_cal
        read
        read_inv_vco_cal = read_inv_vco_cal_value
    End Property

    Property Let write_inv_vco_cal(aData)
        set_inv_vco_cal = aData
        write
    End Property

    Property Get get_i_ndiv_dither_en
        get_i_ndiv_dither_en = read_i_ndiv_dither_en_value
    End Property

    Property Let set_i_ndiv_dither_en(aData)
        write_i_ndiv_dither_en_value = aData
        flag_i_ndiv_dither_en        = &H1
    End Property

    Property Get read_i_ndiv_dither_en
        read
        read_i_ndiv_dither_en = read_i_ndiv_dither_en_value
    End Property

    Property Let write_i_ndiv_dither_en(aData)
        set_i_ndiv_dither_en = aData
        write
    End Property

    Property Get get_mmd_div_range
        get_mmd_div_range = read_mmd_div_range_value
    End Property

    Property Let set_mmd_div_range(aData)
        write_mmd_div_range_value = aData
        flag_mmd_div_range        = &H1
    End Property

    Property Get read_mmd_div_range
        read
        read_mmd_div_range = read_mmd_div_range_value
    End Property

    Property Let write_mmd_div_range(aData)
        set_mmd_div_range = aData
        write
    End Property

    Property Get get_i_ndiv_int_9_2
        get_i_ndiv_int_9_2 = read_i_ndiv_int_9_2_value
    End Property

    Property Let set_i_ndiv_int_9_2(aData)
        write_i_ndiv_int_9_2_value = aData
        flag_i_ndiv_int_9_2        = &H1
    End Property

    Property Get read_i_ndiv_int_9_2
        read
        read_i_ndiv_int_9_2 = read_i_ndiv_int_9_2_value
    End Property

    Property Let write_i_ndiv_int_9_2(aData)
        set_i_ndiv_int_9_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sel_fp3cap_value = rightShift(data_low, 12) and &Hf
        read_i_pll_sdm_pwrdnb_value = rightShift(data_low, 11) and &H1
        read_inv_vco_cal_value = rightShift(data_low, 10) and &H1
        read_i_ndiv_dither_en_value = rightShift(data_low, 9) and &H1
        read_mmd_div_range_value = rightShift(data_low, 8) and &H1
        i_ndiv_int_9_2_mask = &Hff
        if data_low > LONG_MAX then
            if i_ndiv_int_9_2_mask = mask then
                read_i_ndiv_int_9_2_value = data_low
            else
                read_i_ndiv_int_9_2_value = (data_low - H8000_0000) and i_ndiv_int_9_2_mask
            end If
        else
            read_i_ndiv_int_9_2_value = data_low and i_ndiv_int_9_2_mask
        end If

    End Sub

    Sub write
        If flag_sel_fp3cap = &H0 or flag_i_pll_sdm_pwrdnb = &H0 or flag_inv_vco_cal = &H0 or flag_i_ndiv_dither_en = &H0 or flag_mmd_div_range = &H0 or flag_i_ndiv_int_9_2 = &H0 Then read
        If flag_sel_fp3cap = &H0 Then write_sel_fp3cap_value = get_sel_fp3cap
        If flag_i_pll_sdm_pwrdnb = &H0 Then write_i_pll_sdm_pwrdnb_value = get_i_pll_sdm_pwrdnb
        If flag_inv_vco_cal = &H0 Then write_inv_vco_cal_value = get_inv_vco_cal
        If flag_i_ndiv_dither_en = &H0 Then write_i_ndiv_dither_en_value = get_i_ndiv_dither_en
        If flag_mmd_div_range = &H0 Then write_mmd_div_range_value = get_mmd_div_range
        If flag_i_ndiv_int_9_2 = &H0 Then write_i_ndiv_int_9_2_value = get_i_ndiv_int_9_2

        regValue = leftShift((write_sel_fp3cap_value and &Hf), 12) + leftShift((write_i_pll_sdm_pwrdnb_value and &H1), 11) + leftShift((write_inv_vco_cal_value and &H1), 10) + leftShift((write_i_ndiv_dither_en_value and &H1), 9) + leftShift((write_mmd_div_range_value and &H1), 8) + leftShift((write_i_ndiv_int_9_2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sel_fp3cap_value = rightShift(data_low, 12) and &Hf
        read_i_pll_sdm_pwrdnb_value = rightShift(data_low, 11) and &H1
        read_inv_vco_cal_value = rightShift(data_low, 10) and &H1
        read_i_ndiv_dither_en_value = rightShift(data_low, 9) and &H1
        read_mmd_div_range_value = rightShift(data_low, 8) and &H1
        i_ndiv_int_9_2_mask = &Hff
        if data_low > LONG_MAX then
            if i_ndiv_int_9_2_mask = mask then
                read_i_ndiv_int_9_2_value = data_low
            else
                read_i_ndiv_int_9_2_value = (data_low - H8000_0000) and i_ndiv_int_9_2_mask
            end If
        else
            read_i_ndiv_int_9_2_value = data_low and i_ndiv_int_9_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sel_fp3cap_value = &H0
        flag_sel_fp3cap        = &H0
        write_i_pll_sdm_pwrdnb_value = &H0
        flag_i_pll_sdm_pwrdnb        = &H0
        write_inv_vco_cal_value = &H0
        flag_inv_vco_cal        = &H0
        write_i_ndiv_dither_en_value = &H0
        flag_i_ndiv_dither_en        = &H0
        write_mmd_div_range_value = &H0
        flag_mmd_div_range        = &H0
        write_i_ndiv_int_9_2_value = &H0
        flag_i_ndiv_int_9_2        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_ctrl8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vdd1p0_pll_en                              [0:0]            get_vdd1p0_pll_en
''                                                             set_vdd1p0_pll_en
''                                                             read_vdd1p0_pll_en
''                                                             write_vdd1p0_pll_en
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl8
    Private write_vdd1p0_pll_en_value
    Private read_vdd1p0_pll_en_value
    Private flag_vdd1p0_pll_en

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

    Property Get get_vdd1p0_pll_en
        get_vdd1p0_pll_en = read_vdd1p0_pll_en_value
    End Property

    Property Let set_vdd1p0_pll_en(aData)
        write_vdd1p0_pll_en_value = aData
        flag_vdd1p0_pll_en        = &H1
    End Property

    Property Get read_vdd1p0_pll_en
        read
        read_vdd1p0_pll_en = read_vdd1p0_pll_en_value
    End Property

    Property Let write_vdd1p0_pll_en(aData)
        set_vdd1p0_pll_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vdd1p0_pll_en_mask = &H1
        if data_low > LONG_MAX then
            if vdd1p0_pll_en_mask = mask then
                read_vdd1p0_pll_en_value = data_low
            else
                read_vdd1p0_pll_en_value = (data_low - H8000_0000) and vdd1p0_pll_en_mask
            end If
        else
            read_vdd1p0_pll_en_value = data_low and vdd1p0_pll_en_mask
        end If

    End Sub

    Sub write
        If flag_vdd1p0_pll_en = &H0 Then read
        If flag_vdd1p0_pll_en = &H0 Then write_vdd1p0_pll_en_value = get_vdd1p0_pll_en

        regValue = leftShift((write_vdd1p0_pll_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vdd1p0_pll_en_mask = &H1
        if data_low > LONG_MAX then
            if vdd1p0_pll_en_mask = mask then
                read_vdd1p0_pll_en_value = data_low
            else
                read_vdd1p0_pll_en_value = (data_low - H8000_0000) and vdd1p0_pll_en_mask
            end If
        else
            read_vdd1p0_pll_en_value = data_low and vdd1p0_pll_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vdd1p0_pll_en_value = &H0
        flag_vdd1p0_pll_en        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_tcatimer0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tca_timer_sel                              [15:14]          get_tca_timer_sel
''                                                             set_tca_timer_sel
''                                                             read_tca_timer_sel
''                                                             write_tca_timer_sel
''---------------------------------------------------------------------------------
'' tca_coarse_timer                           [13:0]           get_tca_coarse_timer
''                                                             set_tca_coarse_timer
''                                                             read_tca_coarse_timer
''                                                             write_tca_coarse_timer
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_tcatimer0
    Private write_tca_timer_sel_value
    Private read_tca_timer_sel_value
    Private flag_tca_timer_sel
    Private write_tca_coarse_timer_value
    Private read_tca_coarse_timer_value
    Private flag_tca_coarse_timer

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

    Property Get get_tca_timer_sel
        get_tca_timer_sel = read_tca_timer_sel_value
    End Property

    Property Let set_tca_timer_sel(aData)
        write_tca_timer_sel_value = aData
        flag_tca_timer_sel        = &H1
    End Property

    Property Get read_tca_timer_sel
        read
        read_tca_timer_sel = read_tca_timer_sel_value
    End Property

    Property Let write_tca_timer_sel(aData)
        set_tca_timer_sel = aData
        write
    End Property

    Property Get get_tca_coarse_timer
        get_tca_coarse_timer = read_tca_coarse_timer_value
    End Property

    Property Let set_tca_coarse_timer(aData)
        write_tca_coarse_timer_value = aData
        flag_tca_coarse_timer        = &H1
    End Property

    Property Get read_tca_coarse_timer
        read
        read_tca_coarse_timer = read_tca_coarse_timer_value
    End Property

    Property Let write_tca_coarse_timer(aData)
        set_tca_coarse_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tca_timer_sel_value = rightShift(data_low, 14) and &H3
        tca_coarse_timer_mask = &H3fff
        if data_low > LONG_MAX then
            if tca_coarse_timer_mask = mask then
                read_tca_coarse_timer_value = data_low
            else
                read_tca_coarse_timer_value = (data_low - H8000_0000) and tca_coarse_timer_mask
            end If
        else
            read_tca_coarse_timer_value = data_low and tca_coarse_timer_mask
        end If

    End Sub

    Sub write
        If flag_tca_timer_sel = &H0 or flag_tca_coarse_timer = &H0 Then read
        If flag_tca_timer_sel = &H0 Then write_tca_timer_sel_value = get_tca_timer_sel
        If flag_tca_coarse_timer = &H0 Then write_tca_coarse_timer_value = get_tca_coarse_timer

        regValue = leftShift((write_tca_timer_sel_value and &H3), 14) + leftShift((write_tca_coarse_timer_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tca_timer_sel_value = rightShift(data_low, 14) and &H3
        tca_coarse_timer_mask = &H3fff
        if data_low > LONG_MAX then
            if tca_coarse_timer_mask = mask then
                read_tca_coarse_timer_value = data_low
            else
                read_tca_coarse_timer_value = (data_low - H8000_0000) and tca_coarse_timer_mask
            end If
        else
            read_tca_coarse_timer_value = data_low and tca_coarse_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tca_timer_sel_value = &H0
        flag_tca_timer_sel        = &H0
        write_tca_coarse_timer_value = &H0
        flag_tca_coarse_timer        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_tcatimer1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' xgxs_sel                                   [15:15]          get_xgxs_sel
''                                                             set_xgxs_sel
''                                                             read_xgxs_sel
''                                                             write_xgxs_sel
''---------------------------------------------------------------------------------
'' interp_override                            [14:14]          get_interp_override
''                                                             set_interp_override
''                                                             read_interp_override
''                                                             write_interp_override
''---------------------------------------------------------------------------------
'' tca_fine_timer                             [13:0]           get_tca_fine_timer
''                                                             set_tca_fine_timer
''                                                             read_tca_fine_timer
''                                                             write_tca_fine_timer
''---------------------------------------------------------------------------------
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_tcatimer1
    Private write_xgxs_sel_value
    Private read_xgxs_sel_value
    Private flag_xgxs_sel
    Private write_interp_override_value
    Private read_interp_override_value
    Private flag_interp_override
    Private write_tca_fine_timer_value
    Private read_tca_fine_timer_value
    Private flag_tca_fine_timer

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

    Property Get get_xgxs_sel
        get_xgxs_sel = read_xgxs_sel_value
    End Property

    Property Let set_xgxs_sel(aData)
        write_xgxs_sel_value = aData
        flag_xgxs_sel        = &H1
    End Property

    Property Get read_xgxs_sel
        read
        read_xgxs_sel = read_xgxs_sel_value
    End Property

    Property Let write_xgxs_sel(aData)
        set_xgxs_sel = aData
        write
    End Property

    Property Get get_interp_override
        get_interp_override = read_interp_override_value
    End Property

    Property Let set_interp_override(aData)
        write_interp_override_value = aData
        flag_interp_override        = &H1
    End Property

    Property Get read_interp_override
        read
        read_interp_override = read_interp_override_value
    End Property

    Property Let write_interp_override(aData)
        set_interp_override = aData
        write
    End Property

    Property Get get_tca_fine_timer
        get_tca_fine_timer = read_tca_fine_timer_value
    End Property

    Property Let set_tca_fine_timer(aData)
        write_tca_fine_timer_value = aData
        flag_tca_fine_timer        = &H1
    End Property

    Property Get read_tca_fine_timer
        read
        read_tca_fine_timer = read_tca_fine_timer_value
    End Property

    Property Let write_tca_fine_timer(aData)
        set_tca_fine_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_xgxs_sel_value = rightShift(data_low, 15) and &H1
        read_interp_override_value = rightShift(data_low, 14) and &H1
        tca_fine_timer_mask = &H3fff
        if data_low > LONG_MAX then
            if tca_fine_timer_mask = mask then
                read_tca_fine_timer_value = data_low
            else
                read_tca_fine_timer_value = (data_low - H8000_0000) and tca_fine_timer_mask
            end If
        else
            read_tca_fine_timer_value = data_low and tca_fine_timer_mask
        end If

    End Sub

    Sub write
        If flag_xgxs_sel = &H0 or flag_interp_override = &H0 or flag_tca_fine_timer = &H0 Then read
        If flag_xgxs_sel = &H0 Then write_xgxs_sel_value = get_xgxs_sel
        If flag_interp_override = &H0 Then write_interp_override_value = get_interp_override
        If flag_tca_fine_timer = &H0 Then write_tca_fine_timer_value = get_tca_fine_timer

        regValue = leftShift((write_xgxs_sel_value and &H1), 15) + leftShift((write_interp_override_value and &H1), 14) + leftShift((write_tca_fine_timer_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_xgxs_sel_value = rightShift(data_low, 15) and &H1
        read_interp_override_value = rightShift(data_low, 14) and &H1
        tca_fine_timer_mask = &H3fff
        if data_low > LONG_MAX then
            if tca_fine_timer_mask = mask then
                read_tca_fine_timer_value = data_low
            else
                read_tca_fine_timer_value = (data_low - H8000_0000) and tca_fine_timer_mask
            end If
        else
            read_tca_fine_timer_value = data_low and tca_fine_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_xgxs_sel_value = &H0
        flag_xgxs_sel        = &H0
        write_interp_override_value = &H0
        flag_interp_override        = &H0
        write_tca_fine_timer_value = &H0
        flag_tca_fine_timer        = &H0
    End Sub
End Class


'' @REGISTER : PLL_AFE__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_PLL_AFE__SGMIIPLUS2_X2_blockaddress
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

Class PLL_AFE__SGMIIPLUS2_X2_INSTANCE

    Public ctrl0
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public ctrl4
    Public ctrl5
    Public ctrl6
    Public ctrl7
    Public ctrl8
    Public tcatimer0
    Public tcatimer1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set ctrl0 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl0)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl3)(aBaseAddr, 16)
        Set ctrl4 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl4)(aBaseAddr, 16)
        Set ctrl5 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl5)(aBaseAddr, 16)
        Set ctrl6 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl6)(aBaseAddr, 16)
        Set ctrl7 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl7)(aBaseAddr, 16)
        Set ctrl8 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_ctrl8)(aBaseAddr, 16)
        Set tcatimer0 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_tcatimer0)(aBaseAddr, 16)
        Set tcatimer1 = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_tcatimer1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_PLL_AFE__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PLL_AFE__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
PLL_AFE__SGMIIPLUS2_X2.Add ((New PLL_AFE__SGMIIPLUS2_X2_INSTANCE)(&H4ac500a0))


