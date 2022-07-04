

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


'' @REGISTER : PCIE1__SGMIIPCIE_X1_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pgen_en                                    [15:15]          get_pgen_en
''                                                             set_pgen_en
''                                                             read_pgen_en
''                                                             write_pgen_en
''---------------------------------------------------------------------------------
'' pcmp_en                                    [14:14]          get_pcmp_en
''                                                             set_pcmp_en
''                                                             read_pcmp_en
''                                                             write_pcmp_en
''---------------------------------------------------------------------------------
'' start_sequencer                            [13:13]          get_start_sequencer
''                                                             set_start_sequencer
''                                                             read_start_sequencer
''                                                             write_start_sequencer
''---------------------------------------------------------------------------------
'' reset_anlg_r                               [12:12]          get_reset_anlg_r
''                                                             set_reset_anlg_r
''                                                             read_reset_anlg_r
''                                                             write_reset_anlg_r
''---------------------------------------------------------------------------------
'' pll_bypass_r                               [7:7]            get_pll_bypass_r
''                                                             set_pll_bypass_r
''                                                             read_pll_bypass_r
''                                                             write_pll_bypass_r
''---------------------------------------------------------------------------------
'' mdio_cont_en                               [4:4]            get_mdio_cont_en
''                                                             set_mdio_cont_en
''                                                             read_mdio_cont_en
''                                                             write_mdio_cont_en
''---------------------------------------------------------------------------------
'' cdet_en10g                                 [3:3]            get_cdet_en10g
''                                                             set_cdet_en10g
''                                                             read_cdet_en10g
''                                                             write_cdet_en10g
''---------------------------------------------------------------------------------
'' eden10g                                    [2:2]            get_eden10g
''                                                             set_eden10g
''                                                             read_eden10g
''                                                             write_eden10g
''---------------------------------------------------------------------------------
'' txcko_div                                  [0:0]            get_txcko_div
''                                                             set_txcko_div
''                                                             read_txcko_div
''                                                             write_txcko_div
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_control
    Private write_pgen_en_value
    Private read_pgen_en_value
    Private flag_pgen_en
    Private write_pcmp_en_value
    Private read_pcmp_en_value
    Private flag_pcmp_en
    Private write_start_sequencer_value
    Private read_start_sequencer_value
    Private flag_start_sequencer
    Private write_reset_anlg_r_value
    Private read_reset_anlg_r_value
    Private flag_reset_anlg_r
    Private write_pll_bypass_r_value
    Private read_pll_bypass_r_value
    Private flag_pll_bypass_r
    Private write_mdio_cont_en_value
    Private read_mdio_cont_en_value
    Private flag_mdio_cont_en
    Private write_cdet_en10g_value
    Private read_cdet_en10g_value
    Private flag_cdet_en10g
    Private write_eden10g_value
    Private read_eden10g_value
    Private flag_eden10g
    Private write_txcko_div_value
    Private read_txcko_div_value
    Private flag_txcko_div

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

    Property Get get_pgen_en
        get_pgen_en = read_pgen_en_value
    End Property

    Property Let set_pgen_en(aData)
        write_pgen_en_value = aData
        flag_pgen_en        = &H1
    End Property

    Property Get read_pgen_en
        read
        read_pgen_en = read_pgen_en_value
    End Property

    Property Let write_pgen_en(aData)
        set_pgen_en = aData
        write
    End Property

    Property Get get_pcmp_en
        get_pcmp_en = read_pcmp_en_value
    End Property

    Property Let set_pcmp_en(aData)
        write_pcmp_en_value = aData
        flag_pcmp_en        = &H1
    End Property

    Property Get read_pcmp_en
        read
        read_pcmp_en = read_pcmp_en_value
    End Property

    Property Let write_pcmp_en(aData)
        set_pcmp_en = aData
        write
    End Property

    Property Get get_start_sequencer
        get_start_sequencer = read_start_sequencer_value
    End Property

    Property Let set_start_sequencer(aData)
        write_start_sequencer_value = aData
        flag_start_sequencer        = &H1
    End Property

    Property Get read_start_sequencer
        read
        read_start_sequencer = read_start_sequencer_value
    End Property

    Property Let write_start_sequencer(aData)
        set_start_sequencer = aData
        write
    End Property

    Property Get get_reset_anlg_r
        get_reset_anlg_r = read_reset_anlg_r_value
    End Property

    Property Let set_reset_anlg_r(aData)
        write_reset_anlg_r_value = aData
        flag_reset_anlg_r        = &H1
    End Property

    Property Get read_reset_anlg_r
        read
        read_reset_anlg_r = read_reset_anlg_r_value
    End Property

    Property Let write_reset_anlg_r(aData)
        set_reset_anlg_r = aData
        write
    End Property

    Property Get get_pll_bypass_r
        get_pll_bypass_r = read_pll_bypass_r_value
    End Property

    Property Let set_pll_bypass_r(aData)
        write_pll_bypass_r_value = aData
        flag_pll_bypass_r        = &H1
    End Property

    Property Get read_pll_bypass_r
        read
        read_pll_bypass_r = read_pll_bypass_r_value
    End Property

    Property Let write_pll_bypass_r(aData)
        set_pll_bypass_r = aData
        write
    End Property

    Property Get get_mdio_cont_en
        get_mdio_cont_en = read_mdio_cont_en_value
    End Property

    Property Let set_mdio_cont_en(aData)
        write_mdio_cont_en_value = aData
        flag_mdio_cont_en        = &H1
    End Property

    Property Get read_mdio_cont_en
        read
        read_mdio_cont_en = read_mdio_cont_en_value
    End Property

    Property Let write_mdio_cont_en(aData)
        set_mdio_cont_en = aData
        write
    End Property

    Property Get get_cdet_en10g
        get_cdet_en10g = read_cdet_en10g_value
    End Property

    Property Let set_cdet_en10g(aData)
        write_cdet_en10g_value = aData
        flag_cdet_en10g        = &H1
    End Property

    Property Get read_cdet_en10g
        read
        read_cdet_en10g = read_cdet_en10g_value
    End Property

    Property Let write_cdet_en10g(aData)
        set_cdet_en10g = aData
        write
    End Property

    Property Get get_eden10g
        get_eden10g = read_eden10g_value
    End Property

    Property Let set_eden10g(aData)
        write_eden10g_value = aData
        flag_eden10g        = &H1
    End Property

    Property Get read_eden10g
        read
        read_eden10g = read_eden10g_value
    End Property

    Property Let write_eden10g(aData)
        set_eden10g = aData
        write
    End Property

    Property Get get_txcko_div
        get_txcko_div = read_txcko_div_value
    End Property

    Property Let set_txcko_div(aData)
        write_txcko_div_value = aData
        flag_txcko_div        = &H1
    End Property

    Property Get read_txcko_div
        read
        read_txcko_div = read_txcko_div_value
    End Property

    Property Let write_txcko_div(aData)
        set_txcko_div = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pgen_en_value = rightShift(data_low, 15) and &H1
        read_pcmp_en_value = rightShift(data_low, 14) and &H1
        read_start_sequencer_value = rightShift(data_low, 13) and &H1
        read_reset_anlg_r_value = rightShift(data_low, 12) and &H1
        read_pll_bypass_r_value = rightShift(data_low, 7) and &H1
        read_mdio_cont_en_value = rightShift(data_low, 4) and &H1
        read_cdet_en10g_value = rightShift(data_low, 3) and &H1
        read_eden10g_value = rightShift(data_low, 2) and &H1
        txcko_div_mask = &H1
        if data_low > LONG_MAX then
            if txcko_div_mask = mask then
                read_txcko_div_value = data_low
            else
                read_txcko_div_value = (data_low - H8000_0000) and txcko_div_mask
            end If
        else
            read_txcko_div_value = data_low and txcko_div_mask
        end If

    End Sub

    Sub write
        If flag_pgen_en = &H0 or flag_pcmp_en = &H0 or flag_start_sequencer = &H0 or flag_reset_anlg_r = &H0 or flag_pll_bypass_r = &H0 or flag_mdio_cont_en = &H0 or flag_cdet_en10g = &H0 or flag_eden10g = &H0 or flag_txcko_div = &H0 Then read
        If flag_pgen_en = &H0 Then write_pgen_en_value = get_pgen_en
        If flag_pcmp_en = &H0 Then write_pcmp_en_value = get_pcmp_en
        If flag_start_sequencer = &H0 Then write_start_sequencer_value = get_start_sequencer
        If flag_reset_anlg_r = &H0 Then write_reset_anlg_r_value = get_reset_anlg_r
        If flag_pll_bypass_r = &H0 Then write_pll_bypass_r_value = get_pll_bypass_r
        If flag_mdio_cont_en = &H0 Then write_mdio_cont_en_value = get_mdio_cont_en
        If flag_cdet_en10g = &H0 Then write_cdet_en10g_value = get_cdet_en10g
        If flag_eden10g = &H0 Then write_eden10g_value = get_eden10g
        If flag_txcko_div = &H0 Then write_txcko_div_value = get_txcko_div

        regValue = leftShift((write_pgen_en_value and &H1), 15) + leftShift((write_pcmp_en_value and &H1), 14) + leftShift((write_start_sequencer_value and &H1), 13) + leftShift((write_reset_anlg_r_value and &H1), 12) + leftShift((write_pll_bypass_r_value and &H1), 7) + leftShift((write_mdio_cont_en_value and &H1), 4) + leftShift((write_cdet_en10g_value and &H1), 3) + leftShift((write_eden10g_value and &H1), 2) + leftShift((write_txcko_div_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pgen_en_value = rightShift(data_low, 15) and &H1
        read_pcmp_en_value = rightShift(data_low, 14) and &H1
        read_start_sequencer_value = rightShift(data_low, 13) and &H1
        read_reset_anlg_r_value = rightShift(data_low, 12) and &H1
        read_pll_bypass_r_value = rightShift(data_low, 7) and &H1
        read_mdio_cont_en_value = rightShift(data_low, 4) and &H1
        read_cdet_en10g_value = rightShift(data_low, 3) and &H1
        read_eden10g_value = rightShift(data_low, 2) and &H1
        txcko_div_mask = &H1
        if data_low > LONG_MAX then
            if txcko_div_mask = mask then
                read_txcko_div_value = data_low
            else
                read_txcko_div_value = (data_low - H8000_0000) and txcko_div_mask
            end If
        else
            read_txcko_div_value = data_low and txcko_div_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pgen_en_value = &H0
        flag_pgen_en        = &H0
        write_pcmp_en_value = &H0
        flag_pcmp_en        = &H0
        write_start_sequencer_value = &H0
        flag_start_sequencer        = &H0
        write_reset_anlg_r_value = &H0
        flag_reset_anlg_r        = &H0
        write_pll_bypass_r_value = &H0
        flag_pll_bypass_r        = &H0
        write_mdio_cont_en_value = &H0
        flag_mdio_cont_en        = &H0
        write_cdet_en10g_value = &H0
        flag_cdet_en10g        = &H0
        write_eden10g_value = &H0
        flag_eden10g        = &H0
        write_txcko_div_value = &H0
        flag_txcko_div        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' refselo                                    [15:13]          get_refselo
''                                                             set_refselo
''                                                             read_refselo
''                                                             write_refselo
''---------------------------------------------------------------------------------
'' clock_gen_pll_lock                         [12:12]          get_clock_gen_pll_lock
''                                                             set_clock_gen_pll_lock
''                                                             read_clock_gen_pll_lock
''                                                             write_clock_gen_pll_lock
''---------------------------------------------------------------------------------
'' pll_lock                                   [11:11]          get_pll_lock
''                                                             set_pll_lock
''                                                             read_pll_lock
''                                                             write_pll_lock
''---------------------------------------------------------------------------------
'' ssc_status                                 [10:10]          get_ssc_status
''                                                             set_ssc_status
''                                                             read_ssc_status
''                                                             write_ssc_status
''---------------------------------------------------------------------------------
'' pll_force_pll_lock                         [9:9]            get_pll_force_pll_lock
''                                                             set_pll_force_pll_lock
''                                                             read_pll_force_pll_lock
''                                                             write_pll_force_pll_lock
''---------------------------------------------------------------------------------
'' mdio_res_cal_done                          [4:4]            get_mdio_res_cal_done
''                                                             set_mdio_res_cal_done
''                                                             read_mdio_res_cal_done
''                                                             write_mdio_res_cal_done
''---------------------------------------------------------------------------------
'' dig2ana_rcal                               [3:0]            get_dig2ana_rcal
''                                                             set_dig2ana_rcal
''                                                             read_dig2ana_rcal
''                                                             write_dig2ana_rcal
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_status
    Private write_refselo_value
    Private read_refselo_value
    Private flag_refselo
    Private write_clock_gen_pll_lock_value
    Private read_clock_gen_pll_lock_value
    Private flag_clock_gen_pll_lock
    Private write_pll_lock_value
    Private read_pll_lock_value
    Private flag_pll_lock
    Private write_ssc_status_value
    Private read_ssc_status_value
    Private flag_ssc_status
    Private write_pll_force_pll_lock_value
    Private read_pll_force_pll_lock_value
    Private flag_pll_force_pll_lock
    Private write_mdio_res_cal_done_value
    Private read_mdio_res_cal_done_value
    Private flag_mdio_res_cal_done
    Private write_dig2ana_rcal_value
    Private read_dig2ana_rcal_value
    Private flag_dig2ana_rcal

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

    Property Get get_refselo
        get_refselo = read_refselo_value
    End Property

    Property Let set_refselo(aData)
        write_refselo_value = aData
        flag_refselo        = &H1
    End Property

    Property Get read_refselo
        read
        read_refselo = read_refselo_value
    End Property

    Property Let write_refselo(aData)
        set_refselo = aData
        write
    End Property

    Property Get get_clock_gen_pll_lock
        get_clock_gen_pll_lock = read_clock_gen_pll_lock_value
    End Property

    Property Let set_clock_gen_pll_lock(aData)
        write_clock_gen_pll_lock_value = aData
        flag_clock_gen_pll_lock        = &H1
    End Property

    Property Get read_clock_gen_pll_lock
        read
        read_clock_gen_pll_lock = read_clock_gen_pll_lock_value
    End Property

    Property Let write_clock_gen_pll_lock(aData)
        set_clock_gen_pll_lock = aData
        write
    End Property

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

    Property Get get_ssc_status
        get_ssc_status = read_ssc_status_value
    End Property

    Property Let set_ssc_status(aData)
        write_ssc_status_value = aData
        flag_ssc_status        = &H1
    End Property

    Property Get read_ssc_status
        read
        read_ssc_status = read_ssc_status_value
    End Property

    Property Let write_ssc_status(aData)
        set_ssc_status = aData
        write
    End Property

    Property Get get_pll_force_pll_lock
        get_pll_force_pll_lock = read_pll_force_pll_lock_value
    End Property

    Property Let set_pll_force_pll_lock(aData)
        write_pll_force_pll_lock_value = aData
        flag_pll_force_pll_lock        = &H1
    End Property

    Property Get read_pll_force_pll_lock
        read
        read_pll_force_pll_lock = read_pll_force_pll_lock_value
    End Property

    Property Let write_pll_force_pll_lock(aData)
        set_pll_force_pll_lock = aData
        write
    End Property

    Property Get get_mdio_res_cal_done
        get_mdio_res_cal_done = read_mdio_res_cal_done_value
    End Property

    Property Let set_mdio_res_cal_done(aData)
        write_mdio_res_cal_done_value = aData
        flag_mdio_res_cal_done        = &H1
    End Property

    Property Get read_mdio_res_cal_done
        read
        read_mdio_res_cal_done = read_mdio_res_cal_done_value
    End Property

    Property Let write_mdio_res_cal_done(aData)
        set_mdio_res_cal_done = aData
        write
    End Property

    Property Get get_dig2ana_rcal
        get_dig2ana_rcal = read_dig2ana_rcal_value
    End Property

    Property Let set_dig2ana_rcal(aData)
        write_dig2ana_rcal_value = aData
        flag_dig2ana_rcal        = &H1
    End Property

    Property Get read_dig2ana_rcal
        read
        read_dig2ana_rcal = read_dig2ana_rcal_value
    End Property

    Property Let write_dig2ana_rcal(aData)
        set_dig2ana_rcal = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_refselo_value = rightShift(data_low, 13) and &H7
        read_clock_gen_pll_lock_value = rightShift(data_low, 12) and &H1
        read_pll_lock_value = rightShift(data_low, 11) and &H1
        read_ssc_status_value = rightShift(data_low, 10) and &H1
        read_pll_force_pll_lock_value = rightShift(data_low, 9) and &H1
        read_mdio_res_cal_done_value = rightShift(data_low, 4) and &H1
        dig2ana_rcal_mask = &Hf
        if data_low > LONG_MAX then
            if dig2ana_rcal_mask = mask then
                read_dig2ana_rcal_value = data_low
            else
                read_dig2ana_rcal_value = (data_low - H8000_0000) and dig2ana_rcal_mask
            end If
        else
            read_dig2ana_rcal_value = data_low and dig2ana_rcal_mask
        end If

    End Sub

    Sub write
        If flag_refselo = &H0 or flag_clock_gen_pll_lock = &H0 or flag_pll_lock = &H0 or flag_ssc_status = &H0 or flag_pll_force_pll_lock = &H0 or flag_mdio_res_cal_done = &H0 or flag_dig2ana_rcal = &H0 Then read
        If flag_refselo = &H0 Then write_refselo_value = get_refselo
        If flag_clock_gen_pll_lock = &H0 Then write_clock_gen_pll_lock_value = get_clock_gen_pll_lock
        If flag_pll_lock = &H0 Then write_pll_lock_value = get_pll_lock
        If flag_ssc_status = &H0 Then write_ssc_status_value = get_ssc_status
        If flag_pll_force_pll_lock = &H0 Then write_pll_force_pll_lock_value = get_pll_force_pll_lock
        If flag_mdio_res_cal_done = &H0 Then write_mdio_res_cal_done_value = get_mdio_res_cal_done
        If flag_dig2ana_rcal = &H0 Then write_dig2ana_rcal_value = get_dig2ana_rcal

        regValue = leftShift((write_refselo_value and &H7), 13) + leftShift((write_clock_gen_pll_lock_value and &H1), 12) + leftShift((write_pll_lock_value and &H1), 11) + leftShift((write_ssc_status_value and &H1), 10) + leftShift((write_pll_force_pll_lock_value and &H1), 9) + leftShift((write_mdio_res_cal_done_value and &H1), 4) + leftShift((write_dig2ana_rcal_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_refselo_value = rightShift(data_low, 13) and &H7
        read_clock_gen_pll_lock_value = rightShift(data_low, 12) and &H1
        read_pll_lock_value = rightShift(data_low, 11) and &H1
        read_ssc_status_value = rightShift(data_low, 10) and &H1
        read_pll_force_pll_lock_value = rightShift(data_low, 9) and &H1
        read_mdio_res_cal_done_value = rightShift(data_low, 4) and &H1
        dig2ana_rcal_mask = &Hf
        if data_low > LONG_MAX then
            if dig2ana_rcal_mask = mask then
                read_dig2ana_rcal_value = data_low
            else
                read_dig2ana_rcal_value = (data_low - H8000_0000) and dig2ana_rcal_mask
            end If
        else
            read_dig2ana_rcal_value = data_low and dig2ana_rcal_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_refselo_value = &H0
        flag_refselo        = &H0
        write_clock_gen_pll_lock_value = &H0
        flag_clock_gen_pll_lock        = &H0
        write_pll_lock_value = &H0
        flag_pll_lock        = &H0
        write_ssc_status_value = &H0
        flag_ssc_status        = &H0
        write_pll_force_pll_lock_value = &H0
        flag_pll_force_pll_lock        = &H0
        write_mdio_res_cal_done_value = &H0
        flag_mdio_res_cal_done        = &H0
        write_dig2ana_rcal_value = &H0
        flag_dig2ana_rcal        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_mode_enable_ovrd                       [15:15]          get_ssc_mode_enable_ovrd
''                                                             set_ssc_mode_enable_ovrd
''                                                             read_ssc_mode_enable_ovrd
''                                                             write_ssc_mode_enable_ovrd
''---------------------------------------------------------------------------------
'' ssc_mode_enable_ovrd_val                   [14:14]          get_ssc_mode_enable_ovrd_val
''                                                             set_ssc_mode_enable_ovrd_val
''                                                             read_ssc_mode_enable_ovrd_val
''                                                             write_ssc_mode_enable_ovrd_val
''---------------------------------------------------------------------------------
'' ssc_force_reset                            [13:13]          get_ssc_force_reset
''                                                             set_ssc_force_reset
''                                                             read_ssc_force_reset
''                                                             write_ssc_force_reset
''---------------------------------------------------------------------------------
'' refclk_freq_ovrd                           [12:12]          get_refclk_freq_ovrd
''                                                             set_refclk_freq_ovrd
''                                                             read_refclk_freq_ovrd
''                                                             write_refclk_freq_ovrd
''---------------------------------------------------------------------------------
'' refclk_freq_ovrd_val                       [11:9]           get_refclk_freq_ovrd_val
''                                                             set_refclk_freq_ovrd_val
''                                                             read_refclk_freq_ovrd_val
''                                                             write_refclk_freq_ovrd_val
''---------------------------------------------------------------------------------
'' ssc_clock_divider_100MHz                   [6:3]            get_ssc_clock_divider_100MHz
''                                                             set_ssc_clock_divider_100MHz
''                                                             read_ssc_clock_divider_100MHz
''                                                             write_ssc_clock_divider_100MHz
''---------------------------------------------------------------------------------
'' ssc_limit_100MHz_1                         [2:0]            get_ssc_limit_100MHz_1
''                                                             set_ssc_limit_100MHz_1
''                                                             read_ssc_limit_100MHz_1
''                                                             write_ssc_limit_100MHz_1
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol0
    Private write_ssc_mode_enable_ovrd_value
    Private read_ssc_mode_enable_ovrd_value
    Private flag_ssc_mode_enable_ovrd
    Private write_ssc_mode_enable_ovrd_val_value
    Private read_ssc_mode_enable_ovrd_val_value
    Private flag_ssc_mode_enable_ovrd_val
    Private write_ssc_force_reset_value
    Private read_ssc_force_reset_value
    Private flag_ssc_force_reset
    Private write_refclk_freq_ovrd_value
    Private read_refclk_freq_ovrd_value
    Private flag_refclk_freq_ovrd
    Private write_refclk_freq_ovrd_val_value
    Private read_refclk_freq_ovrd_val_value
    Private flag_refclk_freq_ovrd_val
    Private write_ssc_clock_divider_100MHz_value
    Private read_ssc_clock_divider_100MHz_value
    Private flag_ssc_clock_divider_100MHz
    Private write_ssc_limit_100MHz_1_value
    Private read_ssc_limit_100MHz_1_value
    Private flag_ssc_limit_100MHz_1

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

    Property Get get_ssc_mode_enable_ovrd
        get_ssc_mode_enable_ovrd = read_ssc_mode_enable_ovrd_value
    End Property

    Property Let set_ssc_mode_enable_ovrd(aData)
        write_ssc_mode_enable_ovrd_value = aData
        flag_ssc_mode_enable_ovrd        = &H1
    End Property

    Property Get read_ssc_mode_enable_ovrd
        read
        read_ssc_mode_enable_ovrd = read_ssc_mode_enable_ovrd_value
    End Property

    Property Let write_ssc_mode_enable_ovrd(aData)
        set_ssc_mode_enable_ovrd = aData
        write
    End Property

    Property Get get_ssc_mode_enable_ovrd_val
        get_ssc_mode_enable_ovrd_val = read_ssc_mode_enable_ovrd_val_value
    End Property

    Property Let set_ssc_mode_enable_ovrd_val(aData)
        write_ssc_mode_enable_ovrd_val_value = aData
        flag_ssc_mode_enable_ovrd_val        = &H1
    End Property

    Property Get read_ssc_mode_enable_ovrd_val
        read
        read_ssc_mode_enable_ovrd_val = read_ssc_mode_enable_ovrd_val_value
    End Property

    Property Let write_ssc_mode_enable_ovrd_val(aData)
        set_ssc_mode_enable_ovrd_val = aData
        write
    End Property

    Property Get get_ssc_force_reset
        get_ssc_force_reset = read_ssc_force_reset_value
    End Property

    Property Let set_ssc_force_reset(aData)
        write_ssc_force_reset_value = aData
        flag_ssc_force_reset        = &H1
    End Property

    Property Get read_ssc_force_reset
        read
        read_ssc_force_reset = read_ssc_force_reset_value
    End Property

    Property Let write_ssc_force_reset(aData)
        set_ssc_force_reset = aData
        write
    End Property

    Property Get get_refclk_freq_ovrd
        get_refclk_freq_ovrd = read_refclk_freq_ovrd_value
    End Property

    Property Let set_refclk_freq_ovrd(aData)
        write_refclk_freq_ovrd_value = aData
        flag_refclk_freq_ovrd        = &H1
    End Property

    Property Get read_refclk_freq_ovrd
        read
        read_refclk_freq_ovrd = read_refclk_freq_ovrd_value
    End Property

    Property Let write_refclk_freq_ovrd(aData)
        set_refclk_freq_ovrd = aData
        write
    End Property

    Property Get get_refclk_freq_ovrd_val
        get_refclk_freq_ovrd_val = read_refclk_freq_ovrd_val_value
    End Property

    Property Let set_refclk_freq_ovrd_val(aData)
        write_refclk_freq_ovrd_val_value = aData
        flag_refclk_freq_ovrd_val        = &H1
    End Property

    Property Get read_refclk_freq_ovrd_val
        read
        read_refclk_freq_ovrd_val = read_refclk_freq_ovrd_val_value
    End Property

    Property Let write_refclk_freq_ovrd_val(aData)
        set_refclk_freq_ovrd_val = aData
        write
    End Property

    Property Get get_ssc_clock_divider_100MHz
        get_ssc_clock_divider_100MHz = read_ssc_clock_divider_100MHz_value
    End Property

    Property Let set_ssc_clock_divider_100MHz(aData)
        write_ssc_clock_divider_100MHz_value = aData
        flag_ssc_clock_divider_100MHz        = &H1
    End Property

    Property Get read_ssc_clock_divider_100MHz
        read
        read_ssc_clock_divider_100MHz = read_ssc_clock_divider_100MHz_value
    End Property

    Property Let write_ssc_clock_divider_100MHz(aData)
        set_ssc_clock_divider_100MHz = aData
        write
    End Property

    Property Get get_ssc_limit_100MHz_1
        get_ssc_limit_100MHz_1 = read_ssc_limit_100MHz_1_value
    End Property

    Property Let set_ssc_limit_100MHz_1(aData)
        write_ssc_limit_100MHz_1_value = aData
        flag_ssc_limit_100MHz_1        = &H1
    End Property

    Property Get read_ssc_limit_100MHz_1
        read
        read_ssc_limit_100MHz_1 = read_ssc_limit_100MHz_1_value
    End Property

    Property Let write_ssc_limit_100MHz_1(aData)
        set_ssc_limit_100MHz_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ssc_mode_enable_ovrd_value = rightShift(data_low, 15) and &H1
        read_ssc_mode_enable_ovrd_val_value = rightShift(data_low, 14) and &H1
        read_ssc_force_reset_value = rightShift(data_low, 13) and &H1
        read_refclk_freq_ovrd_value = rightShift(data_low, 12) and &H1
        read_refclk_freq_ovrd_val_value = rightShift(data_low, 9) and &H7
        read_ssc_clock_divider_100MHz_value = rightShift(data_low, 3) and &Hf
        ssc_limit_100MHz_1_mask = &H7
        if data_low > LONG_MAX then
            if ssc_limit_100MHz_1_mask = mask then
                read_ssc_limit_100MHz_1_value = data_low
            else
                read_ssc_limit_100MHz_1_value = (data_low - H8000_0000) and ssc_limit_100MHz_1_mask
            end If
        else
            read_ssc_limit_100MHz_1_value = data_low and ssc_limit_100MHz_1_mask
        end If

    End Sub

    Sub write
        If flag_ssc_mode_enable_ovrd = &H0 or flag_ssc_mode_enable_ovrd_val = &H0 or flag_ssc_force_reset = &H0 or flag_refclk_freq_ovrd = &H0 or flag_refclk_freq_ovrd_val = &H0 or flag_ssc_clock_divider_100MHz = &H0 or flag_ssc_limit_100MHz_1 = &H0 Then read
        If flag_ssc_mode_enable_ovrd = &H0 Then write_ssc_mode_enable_ovrd_value = get_ssc_mode_enable_ovrd
        If flag_ssc_mode_enable_ovrd_val = &H0 Then write_ssc_mode_enable_ovrd_val_value = get_ssc_mode_enable_ovrd_val
        If flag_ssc_force_reset = &H0 Then write_ssc_force_reset_value = get_ssc_force_reset
        If flag_refclk_freq_ovrd = &H0 Then write_refclk_freq_ovrd_value = get_refclk_freq_ovrd
        If flag_refclk_freq_ovrd_val = &H0 Then write_refclk_freq_ovrd_val_value = get_refclk_freq_ovrd_val
        If flag_ssc_clock_divider_100MHz = &H0 Then write_ssc_clock_divider_100MHz_value = get_ssc_clock_divider_100MHz
        If flag_ssc_limit_100MHz_1 = &H0 Then write_ssc_limit_100MHz_1_value = get_ssc_limit_100MHz_1

        regValue = leftShift((write_ssc_mode_enable_ovrd_value and &H1), 15) + leftShift((write_ssc_mode_enable_ovrd_val_value and &H1), 14) + leftShift((write_ssc_force_reset_value and &H1), 13) + leftShift((write_refclk_freq_ovrd_value and &H1), 12) + leftShift((write_refclk_freq_ovrd_val_value and &H7), 9) + leftShift((write_ssc_clock_divider_100MHz_value and &Hf), 3) + leftShift((write_ssc_limit_100MHz_1_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ssc_mode_enable_ovrd_value = rightShift(data_low, 15) and &H1
        read_ssc_mode_enable_ovrd_val_value = rightShift(data_low, 14) and &H1
        read_ssc_force_reset_value = rightShift(data_low, 13) and &H1
        read_refclk_freq_ovrd_value = rightShift(data_low, 12) and &H1
        read_refclk_freq_ovrd_val_value = rightShift(data_low, 9) and &H7
        read_ssc_clock_divider_100MHz_value = rightShift(data_low, 3) and &Hf
        ssc_limit_100MHz_1_mask = &H7
        if data_low > LONG_MAX then
            if ssc_limit_100MHz_1_mask = mask then
                read_ssc_limit_100MHz_1_value = data_low
            else
                read_ssc_limit_100MHz_1_value = (data_low - H8000_0000) and ssc_limit_100MHz_1_mask
            end If
        else
            read_ssc_limit_100MHz_1_value = data_low and ssc_limit_100MHz_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_mode_enable_ovrd_value = &H0
        flag_ssc_mode_enable_ovrd        = &H0
        write_ssc_mode_enable_ovrd_val_value = &H0
        flag_ssc_mode_enable_ovrd_val        = &H0
        write_ssc_force_reset_value = &H0
        flag_ssc_force_reset        = &H0
        write_refclk_freq_ovrd_value = &H0
        flag_refclk_freq_ovrd        = &H0
        write_refclk_freq_ovrd_val_value = &H0
        flag_refclk_freq_ovrd_val        = &H0
        write_ssc_clock_divider_100MHz_value = &H0
        flag_ssc_clock_divider_100MHz        = &H0
        write_ssc_limit_100MHz_1_value = &H0
        flag_ssc_limit_100MHz_1        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_limit_100MHz_0                         [15:0]           get_ssc_limit_100MHz_0
''                                                             set_ssc_limit_100MHz_0
''                                                             read_ssc_limit_100MHz_0
''                                                             write_ssc_limit_100MHz_0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol1
    Private write_ssc_limit_100MHz_0_value
    Private read_ssc_limit_100MHz_0_value
    Private flag_ssc_limit_100MHz_0

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

    Property Get get_ssc_limit_100MHz_0
        get_ssc_limit_100MHz_0 = read_ssc_limit_100MHz_0_value
    End Property

    Property Let set_ssc_limit_100MHz_0(aData)
        write_ssc_limit_100MHz_0_value = aData
        flag_ssc_limit_100MHz_0        = &H1
    End Property

    Property Get read_ssc_limit_100MHz_0
        read
        read_ssc_limit_100MHz_0 = read_ssc_limit_100MHz_0_value
    End Property

    Property Let write_ssc_limit_100MHz_0(aData)
        set_ssc_limit_100MHz_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_100MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_100MHz_0_mask = mask then
                read_ssc_limit_100MHz_0_value = data_low
            else
                read_ssc_limit_100MHz_0_value = (data_low - H8000_0000) and ssc_limit_100MHz_0_mask
            end If
        else
            read_ssc_limit_100MHz_0_value = data_low and ssc_limit_100MHz_0_mask
        end If

    End Sub

    Sub write
        If flag_ssc_limit_100MHz_0 = &H0 Then read
        If flag_ssc_limit_100MHz_0 = &H0 Then write_ssc_limit_100MHz_0_value = get_ssc_limit_100MHz_0

        regValue = leftShift((write_ssc_limit_100MHz_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_100MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_100MHz_0_mask = mask then
                read_ssc_limit_100MHz_0_value = data_low
            else
                read_ssc_limit_100MHz_0_value = (data_low - H8000_0000) and ssc_limit_100MHz_0_mask
            end If
        else
            read_ssc_limit_100MHz_0_value = data_low and ssc_limit_100MHz_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_limit_100MHz_0_value = &H0
        flag_ssc_limit_100MHz_0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_step_100MHz                            [15:0]           get_ssc_step_100MHz
''                                                             set_ssc_step_100MHz
''                                                             read_ssc_step_100MHz
''                                                             write_ssc_step_100MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol2
    Private write_ssc_step_100MHz_value
    Private read_ssc_step_100MHz_value
    Private flag_ssc_step_100MHz

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

    Property Get get_ssc_step_100MHz
        get_ssc_step_100MHz = read_ssc_step_100MHz_value
    End Property

    Property Let set_ssc_step_100MHz(aData)
        write_ssc_step_100MHz_value = aData
        flag_ssc_step_100MHz        = &H1
    End Property

    Property Get read_ssc_step_100MHz
        read
        read_ssc_step_100MHz = read_ssc_step_100MHz_value
    End Property

    Property Let write_ssc_step_100MHz(aData)
        set_ssc_step_100MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_100MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_100MHz_mask = mask then
                read_ssc_step_100MHz_value = data_low
            else
                read_ssc_step_100MHz_value = (data_low - H8000_0000) and ssc_step_100MHz_mask
            end If
        else
            read_ssc_step_100MHz_value = data_low and ssc_step_100MHz_mask
        end If

    End Sub

    Sub write
        If flag_ssc_step_100MHz = &H0 Then read
        If flag_ssc_step_100MHz = &H0 Then write_ssc_step_100MHz_value = get_ssc_step_100MHz

        regValue = leftShift((write_ssc_step_100MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_100MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_100MHz_mask = mask then
                read_ssc_step_100MHz_value = data_low
            else
                read_ssc_step_100MHz_value = (data_low - H8000_0000) and ssc_step_100MHz_mask
            end If
        else
            read_ssc_step_100MHz_value = data_low and ssc_step_100MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_step_100MHz_value = &H0
        flag_ssc_step_100MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_clock_divider_52MHz                    [13:10]          get_ssc_clock_divider_52MHz
''                                                             set_ssc_clock_divider_52MHz
''                                                             read_ssc_clock_divider_52MHz
''                                                             write_ssc_clock_divider_52MHz
''---------------------------------------------------------------------------------
'' ssc_limit_52MHz_1                          [9:7]            get_ssc_limit_52MHz_1
''                                                             set_ssc_limit_52MHz_1
''                                                             read_ssc_limit_52MHz_1
''                                                             write_ssc_limit_52MHz_1
''---------------------------------------------------------------------------------
'' ssc_clock_divider_54MHz                    [6:3]            get_ssc_clock_divider_54MHz
''                                                             set_ssc_clock_divider_54MHz
''                                                             read_ssc_clock_divider_54MHz
''                                                             write_ssc_clock_divider_54MHz
''---------------------------------------------------------------------------------
'' ssc_limit_54MHz_1                          [2:0]            get_ssc_limit_54MHz_1
''                                                             set_ssc_limit_54MHz_1
''                                                             read_ssc_limit_54MHz_1
''                                                             write_ssc_limit_54MHz_1
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol3
    Private write_ssc_clock_divider_52MHz_value
    Private read_ssc_clock_divider_52MHz_value
    Private flag_ssc_clock_divider_52MHz
    Private write_ssc_limit_52MHz_1_value
    Private read_ssc_limit_52MHz_1_value
    Private flag_ssc_limit_52MHz_1
    Private write_ssc_clock_divider_54MHz_value
    Private read_ssc_clock_divider_54MHz_value
    Private flag_ssc_clock_divider_54MHz
    Private write_ssc_limit_54MHz_1_value
    Private read_ssc_limit_54MHz_1_value
    Private flag_ssc_limit_54MHz_1

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

    Property Get get_ssc_clock_divider_52MHz
        get_ssc_clock_divider_52MHz = read_ssc_clock_divider_52MHz_value
    End Property

    Property Let set_ssc_clock_divider_52MHz(aData)
        write_ssc_clock_divider_52MHz_value = aData
        flag_ssc_clock_divider_52MHz        = &H1
    End Property

    Property Get read_ssc_clock_divider_52MHz
        read
        read_ssc_clock_divider_52MHz = read_ssc_clock_divider_52MHz_value
    End Property

    Property Let write_ssc_clock_divider_52MHz(aData)
        set_ssc_clock_divider_52MHz = aData
        write
    End Property

    Property Get get_ssc_limit_52MHz_1
        get_ssc_limit_52MHz_1 = read_ssc_limit_52MHz_1_value
    End Property

    Property Let set_ssc_limit_52MHz_1(aData)
        write_ssc_limit_52MHz_1_value = aData
        flag_ssc_limit_52MHz_1        = &H1
    End Property

    Property Get read_ssc_limit_52MHz_1
        read
        read_ssc_limit_52MHz_1 = read_ssc_limit_52MHz_1_value
    End Property

    Property Let write_ssc_limit_52MHz_1(aData)
        set_ssc_limit_52MHz_1 = aData
        write
    End Property

    Property Get get_ssc_clock_divider_54MHz
        get_ssc_clock_divider_54MHz = read_ssc_clock_divider_54MHz_value
    End Property

    Property Let set_ssc_clock_divider_54MHz(aData)
        write_ssc_clock_divider_54MHz_value = aData
        flag_ssc_clock_divider_54MHz        = &H1
    End Property

    Property Get read_ssc_clock_divider_54MHz
        read
        read_ssc_clock_divider_54MHz = read_ssc_clock_divider_54MHz_value
    End Property

    Property Let write_ssc_clock_divider_54MHz(aData)
        set_ssc_clock_divider_54MHz = aData
        write
    End Property

    Property Get get_ssc_limit_54MHz_1
        get_ssc_limit_54MHz_1 = read_ssc_limit_54MHz_1_value
    End Property

    Property Let set_ssc_limit_54MHz_1(aData)
        write_ssc_limit_54MHz_1_value = aData
        flag_ssc_limit_54MHz_1        = &H1
    End Property

    Property Get read_ssc_limit_54MHz_1
        read
        read_ssc_limit_54MHz_1 = read_ssc_limit_54MHz_1_value
    End Property

    Property Let write_ssc_limit_54MHz_1(aData)
        set_ssc_limit_54MHz_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ssc_clock_divider_52MHz_value = rightShift(data_low, 10) and &Hf
        read_ssc_limit_52MHz_1_value = rightShift(data_low, 7) and &H7
        read_ssc_clock_divider_54MHz_value = rightShift(data_low, 3) and &Hf
        ssc_limit_54MHz_1_mask = &H7
        if data_low > LONG_MAX then
            if ssc_limit_54MHz_1_mask = mask then
                read_ssc_limit_54MHz_1_value = data_low
            else
                read_ssc_limit_54MHz_1_value = (data_low - H8000_0000) and ssc_limit_54MHz_1_mask
            end If
        else
            read_ssc_limit_54MHz_1_value = data_low and ssc_limit_54MHz_1_mask
        end If

    End Sub

    Sub write
        If flag_ssc_clock_divider_52MHz = &H0 or flag_ssc_limit_52MHz_1 = &H0 or flag_ssc_clock_divider_54MHz = &H0 or flag_ssc_limit_54MHz_1 = &H0 Then read
        If flag_ssc_clock_divider_52MHz = &H0 Then write_ssc_clock_divider_52MHz_value = get_ssc_clock_divider_52MHz
        If flag_ssc_limit_52MHz_1 = &H0 Then write_ssc_limit_52MHz_1_value = get_ssc_limit_52MHz_1
        If flag_ssc_clock_divider_54MHz = &H0 Then write_ssc_clock_divider_54MHz_value = get_ssc_clock_divider_54MHz
        If flag_ssc_limit_54MHz_1 = &H0 Then write_ssc_limit_54MHz_1_value = get_ssc_limit_54MHz_1

        regValue = leftShift((write_ssc_clock_divider_52MHz_value and &Hf), 10) + leftShift((write_ssc_limit_52MHz_1_value and &H7), 7) + leftShift((write_ssc_clock_divider_54MHz_value and &Hf), 3) + leftShift((write_ssc_limit_54MHz_1_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ssc_clock_divider_52MHz_value = rightShift(data_low, 10) and &Hf
        read_ssc_limit_52MHz_1_value = rightShift(data_low, 7) and &H7
        read_ssc_clock_divider_54MHz_value = rightShift(data_low, 3) and &Hf
        ssc_limit_54MHz_1_mask = &H7
        if data_low > LONG_MAX then
            if ssc_limit_54MHz_1_mask = mask then
                read_ssc_limit_54MHz_1_value = data_low
            else
                read_ssc_limit_54MHz_1_value = (data_low - H8000_0000) and ssc_limit_54MHz_1_mask
            end If
        else
            read_ssc_limit_54MHz_1_value = data_low and ssc_limit_54MHz_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_clock_divider_52MHz_value = &H0
        flag_ssc_clock_divider_52MHz        = &H0
        write_ssc_limit_52MHz_1_value = &H0
        flag_ssc_limit_52MHz_1        = &H0
        write_ssc_clock_divider_54MHz_value = &H0
        flag_ssc_clock_divider_54MHz        = &H0
        write_ssc_limit_54MHz_1_value = &H0
        flag_ssc_limit_54MHz_1        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_limit_54MHz_0                          [15:0]           get_ssc_limit_54MHz_0
''                                                             set_ssc_limit_54MHz_0
''                                                             read_ssc_limit_54MHz_0
''                                                             write_ssc_limit_54MHz_0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol4
    Private write_ssc_limit_54MHz_0_value
    Private read_ssc_limit_54MHz_0_value
    Private flag_ssc_limit_54MHz_0

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

    Property Get get_ssc_limit_54MHz_0
        get_ssc_limit_54MHz_0 = read_ssc_limit_54MHz_0_value
    End Property

    Property Let set_ssc_limit_54MHz_0(aData)
        write_ssc_limit_54MHz_0_value = aData
        flag_ssc_limit_54MHz_0        = &H1
    End Property

    Property Get read_ssc_limit_54MHz_0
        read
        read_ssc_limit_54MHz_0 = read_ssc_limit_54MHz_0_value
    End Property

    Property Let write_ssc_limit_54MHz_0(aData)
        set_ssc_limit_54MHz_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_54MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_54MHz_0_mask = mask then
                read_ssc_limit_54MHz_0_value = data_low
            else
                read_ssc_limit_54MHz_0_value = (data_low - H8000_0000) and ssc_limit_54MHz_0_mask
            end If
        else
            read_ssc_limit_54MHz_0_value = data_low and ssc_limit_54MHz_0_mask
        end If

    End Sub

    Sub write
        If flag_ssc_limit_54MHz_0 = &H0 Then read
        If flag_ssc_limit_54MHz_0 = &H0 Then write_ssc_limit_54MHz_0_value = get_ssc_limit_54MHz_0

        regValue = leftShift((write_ssc_limit_54MHz_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_54MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_54MHz_0_mask = mask then
                read_ssc_limit_54MHz_0_value = data_low
            else
                read_ssc_limit_54MHz_0_value = (data_low - H8000_0000) and ssc_limit_54MHz_0_mask
            end If
        else
            read_ssc_limit_54MHz_0_value = data_low and ssc_limit_54MHz_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_limit_54MHz_0_value = &H0
        flag_ssc_limit_54MHz_0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_step_54MHz                             [15:0]           get_ssc_step_54MHz
''                                                             set_ssc_step_54MHz
''                                                             read_ssc_step_54MHz
''                                                             write_ssc_step_54MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol5
    Private write_ssc_step_54MHz_value
    Private read_ssc_step_54MHz_value
    Private flag_ssc_step_54MHz

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

    Property Get get_ssc_step_54MHz
        get_ssc_step_54MHz = read_ssc_step_54MHz_value
    End Property

    Property Let set_ssc_step_54MHz(aData)
        write_ssc_step_54MHz_value = aData
        flag_ssc_step_54MHz        = &H1
    End Property

    Property Get read_ssc_step_54MHz
        read
        read_ssc_step_54MHz = read_ssc_step_54MHz_value
    End Property

    Property Let write_ssc_step_54MHz(aData)
        set_ssc_step_54MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_54MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_54MHz_mask = mask then
                read_ssc_step_54MHz_value = data_low
            else
                read_ssc_step_54MHz_value = (data_low - H8000_0000) and ssc_step_54MHz_mask
            end If
        else
            read_ssc_step_54MHz_value = data_low and ssc_step_54MHz_mask
        end If

    End Sub

    Sub write
        If flag_ssc_step_54MHz = &H0 Then read
        If flag_ssc_step_54MHz = &H0 Then write_ssc_step_54MHz_value = get_ssc_step_54MHz

        regValue = leftShift((write_ssc_step_54MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_54MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_54MHz_mask = mask then
                read_ssc_step_54MHz_value = data_low
            else
                read_ssc_step_54MHz_value = (data_low - H8000_0000) and ssc_step_54MHz_mask
            end If
        else
            read_ssc_step_54MHz_value = data_low and ssc_step_54MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_step_54MHz_value = &H0
        flag_ssc_step_54MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_limit_52MHz_0                          [15:0]           get_ssc_limit_52MHz_0
''                                                             set_ssc_limit_52MHz_0
''                                                             read_ssc_limit_52MHz_0
''                                                             write_ssc_limit_52MHz_0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol6
    Private write_ssc_limit_52MHz_0_value
    Private read_ssc_limit_52MHz_0_value
    Private flag_ssc_limit_52MHz_0

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

    Property Get get_ssc_limit_52MHz_0
        get_ssc_limit_52MHz_0 = read_ssc_limit_52MHz_0_value
    End Property

    Property Let set_ssc_limit_52MHz_0(aData)
        write_ssc_limit_52MHz_0_value = aData
        flag_ssc_limit_52MHz_0        = &H1
    End Property

    Property Get read_ssc_limit_52MHz_0
        read
        read_ssc_limit_52MHz_0 = read_ssc_limit_52MHz_0_value
    End Property

    Property Let write_ssc_limit_52MHz_0(aData)
        set_ssc_limit_52MHz_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_52MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_52MHz_0_mask = mask then
                read_ssc_limit_52MHz_0_value = data_low
            else
                read_ssc_limit_52MHz_0_value = (data_low - H8000_0000) and ssc_limit_52MHz_0_mask
            end If
        else
            read_ssc_limit_52MHz_0_value = data_low and ssc_limit_52MHz_0_mask
        end If

    End Sub

    Sub write
        If flag_ssc_limit_52MHz_0 = &H0 Then read
        If flag_ssc_limit_52MHz_0 = &H0 Then write_ssc_limit_52MHz_0_value = get_ssc_limit_52MHz_0

        regValue = leftShift((write_ssc_limit_52MHz_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_52MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_52MHz_0_mask = mask then
                read_ssc_limit_52MHz_0_value = data_low
            else
                read_ssc_limit_52MHz_0_value = (data_low - H8000_0000) and ssc_limit_52MHz_0_mask
            end If
        else
            read_ssc_limit_52MHz_0_value = data_low and ssc_limit_52MHz_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_limit_52MHz_0_value = &H0
        flag_ssc_limit_52MHz_0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_step_52MHz                             [15:0]           get_ssc_step_52MHz
''                                                             set_ssc_step_52MHz
''                                                             read_ssc_step_52MHz
''                                                             write_ssc_step_52MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol7
    Private write_ssc_step_52MHz_value
    Private read_ssc_step_52MHz_value
    Private flag_ssc_step_52MHz

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

    Property Get get_ssc_step_52MHz
        get_ssc_step_52MHz = read_ssc_step_52MHz_value
    End Property

    Property Let set_ssc_step_52MHz(aData)
        write_ssc_step_52MHz_value = aData
        flag_ssc_step_52MHz        = &H1
    End Property

    Property Get read_ssc_step_52MHz
        read
        read_ssc_step_52MHz = read_ssc_step_52MHz_value
    End Property

    Property Let write_ssc_step_52MHz(aData)
        set_ssc_step_52MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_52MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_52MHz_mask = mask then
                read_ssc_step_52MHz_value = data_low
            else
                read_ssc_step_52MHz_value = (data_low - H8000_0000) and ssc_step_52MHz_mask
            end If
        else
            read_ssc_step_52MHz_value = data_low and ssc_step_52MHz_mask
        end If

    End Sub

    Sub write
        If flag_ssc_step_52MHz = &H0 Then read
        If flag_ssc_step_52MHz = &H0 Then write_ssc_step_52MHz_value = get_ssc_step_52MHz

        regValue = leftShift((write_ssc_step_52MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_52MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_52MHz_mask = mask then
                read_ssc_step_52MHz_value = data_low
            else
                read_ssc_step_52MHz_value = (data_low - H8000_0000) and ssc_step_52MHz_mask
            end If
        else
            read_ssc_step_52MHz_value = data_low and ssc_step_52MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_step_52MHz_value = &H0
        flag_ssc_step_52MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_limit_50MHz_0                          [15:0]           get_ssc_limit_50MHz_0
''                                                             set_ssc_limit_50MHz_0
''                                                             read_ssc_limit_50MHz_0
''                                                             write_ssc_limit_50MHz_0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol8
    Private write_ssc_limit_50MHz_0_value
    Private read_ssc_limit_50MHz_0_value
    Private flag_ssc_limit_50MHz_0

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

    Property Get get_ssc_limit_50MHz_0
        get_ssc_limit_50MHz_0 = read_ssc_limit_50MHz_0_value
    End Property

    Property Let set_ssc_limit_50MHz_0(aData)
        write_ssc_limit_50MHz_0_value = aData
        flag_ssc_limit_50MHz_0        = &H1
    End Property

    Property Get read_ssc_limit_50MHz_0
        read
        read_ssc_limit_50MHz_0 = read_ssc_limit_50MHz_0_value
    End Property

    Property Let write_ssc_limit_50MHz_0(aData)
        set_ssc_limit_50MHz_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_50MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_50MHz_0_mask = mask then
                read_ssc_limit_50MHz_0_value = data_low
            else
                read_ssc_limit_50MHz_0_value = (data_low - H8000_0000) and ssc_limit_50MHz_0_mask
            end If
        else
            read_ssc_limit_50MHz_0_value = data_low and ssc_limit_50MHz_0_mask
        end If

    End Sub

    Sub write
        If flag_ssc_limit_50MHz_0 = &H0 Then read
        If flag_ssc_limit_50MHz_0 = &H0 Then write_ssc_limit_50MHz_0_value = get_ssc_limit_50MHz_0

        regValue = leftShift((write_ssc_limit_50MHz_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_50MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_50MHz_0_mask = mask then
                read_ssc_limit_50MHz_0_value = data_low
            else
                read_ssc_limit_50MHz_0_value = (data_low - H8000_0000) and ssc_limit_50MHz_0_mask
            end If
        else
            read_ssc_limit_50MHz_0_value = data_low and ssc_limit_50MHz_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_limit_50MHz_0_value = &H0
        flag_ssc_limit_50MHz_0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_step_50MHz                             [15:0]           get_ssc_step_50MHz
''                                                             set_ssc_step_50MHz
''                                                             read_ssc_step_50MHz
''                                                             write_ssc_step_50MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol9
    Private write_ssc_step_50MHz_value
    Private read_ssc_step_50MHz_value
    Private flag_ssc_step_50MHz

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

    Property Get get_ssc_step_50MHz
        get_ssc_step_50MHz = read_ssc_step_50MHz_value
    End Property

    Property Let set_ssc_step_50MHz(aData)
        write_ssc_step_50MHz_value = aData
        flag_ssc_step_50MHz        = &H1
    End Property

    Property Get read_ssc_step_50MHz
        read
        read_ssc_step_50MHz = read_ssc_step_50MHz_value
    End Property

    Property Let write_ssc_step_50MHz(aData)
        set_ssc_step_50MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_50MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_50MHz_mask = mask then
                read_ssc_step_50MHz_value = data_low
            else
                read_ssc_step_50MHz_value = (data_low - H8000_0000) and ssc_step_50MHz_mask
            end If
        else
            read_ssc_step_50MHz_value = data_low and ssc_step_50MHz_mask
        end If

    End Sub

    Sub write
        If flag_ssc_step_50MHz = &H0 Then read
        If flag_ssc_step_50MHz = &H0 Then write_ssc_step_50MHz_value = get_ssc_step_50MHz

        regValue = leftShift((write_ssc_step_50MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_50MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_50MHz_mask = mask then
                read_ssc_step_50MHz_value = data_low
            else
                read_ssc_step_50MHz_value = (data_low - H8000_0000) and ssc_step_50MHz_mask
            end If
        else
            read_ssc_step_50MHz_value = data_low and ssc_step_50MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_step_50MHz_value = &H0
        flag_ssc_step_50MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_ssccontrol10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ndiv_int_delay                             [10:7]           get_ndiv_int_delay
''                                                             set_ndiv_int_delay
''                                                             read_ndiv_int_delay
''                                                             write_ndiv_int_delay
''---------------------------------------------------------------------------------
'' ssc_clock_divider_50MHz                    [6:3]            get_ssc_clock_divider_50MHz
''                                                             set_ssc_clock_divider_50MHz
''                                                             read_ssc_clock_divider_50MHz
''                                                             write_ssc_clock_divider_50MHz
''---------------------------------------------------------------------------------
'' ssc_limit_50MHz_1                          [2:0]            get_ssc_limit_50MHz_1
''                                                             set_ssc_limit_50MHz_1
''                                                             read_ssc_limit_50MHz_1
''                                                             write_ssc_limit_50MHz_1
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol10
    Private write_ndiv_int_delay_value
    Private read_ndiv_int_delay_value
    Private flag_ndiv_int_delay
    Private write_ssc_clock_divider_50MHz_value
    Private read_ssc_clock_divider_50MHz_value
    Private flag_ssc_clock_divider_50MHz
    Private write_ssc_limit_50MHz_1_value
    Private read_ssc_limit_50MHz_1_value
    Private flag_ssc_limit_50MHz_1

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

    Property Get get_ndiv_int_delay
        get_ndiv_int_delay = read_ndiv_int_delay_value
    End Property

    Property Let set_ndiv_int_delay(aData)
        write_ndiv_int_delay_value = aData
        flag_ndiv_int_delay        = &H1
    End Property

    Property Get read_ndiv_int_delay
        read
        read_ndiv_int_delay = read_ndiv_int_delay_value
    End Property

    Property Let write_ndiv_int_delay(aData)
        set_ndiv_int_delay = aData
        write
    End Property

    Property Get get_ssc_clock_divider_50MHz
        get_ssc_clock_divider_50MHz = read_ssc_clock_divider_50MHz_value
    End Property

    Property Let set_ssc_clock_divider_50MHz(aData)
        write_ssc_clock_divider_50MHz_value = aData
        flag_ssc_clock_divider_50MHz        = &H1
    End Property

    Property Get read_ssc_clock_divider_50MHz
        read
        read_ssc_clock_divider_50MHz = read_ssc_clock_divider_50MHz_value
    End Property

    Property Let write_ssc_clock_divider_50MHz(aData)
        set_ssc_clock_divider_50MHz = aData
        write
    End Property

    Property Get get_ssc_limit_50MHz_1
        get_ssc_limit_50MHz_1 = read_ssc_limit_50MHz_1_value
    End Property

    Property Let set_ssc_limit_50MHz_1(aData)
        write_ssc_limit_50MHz_1_value = aData
        flag_ssc_limit_50MHz_1        = &H1
    End Property

    Property Get read_ssc_limit_50MHz_1
        read
        read_ssc_limit_50MHz_1 = read_ssc_limit_50MHz_1_value
    End Property

    Property Let write_ssc_limit_50MHz_1(aData)
        set_ssc_limit_50MHz_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ndiv_int_delay_value = rightShift(data_low, 7) and &Hf
        read_ssc_clock_divider_50MHz_value = rightShift(data_low, 3) and &Hf
        ssc_limit_50MHz_1_mask = &H7
        if data_low > LONG_MAX then
            if ssc_limit_50MHz_1_mask = mask then
                read_ssc_limit_50MHz_1_value = data_low
            else
                read_ssc_limit_50MHz_1_value = (data_low - H8000_0000) and ssc_limit_50MHz_1_mask
            end If
        else
            read_ssc_limit_50MHz_1_value = data_low and ssc_limit_50MHz_1_mask
        end If

    End Sub

    Sub write
        If flag_ndiv_int_delay = &H0 or flag_ssc_clock_divider_50MHz = &H0 or flag_ssc_limit_50MHz_1 = &H0 Then read
        If flag_ndiv_int_delay = &H0 Then write_ndiv_int_delay_value = get_ndiv_int_delay
        If flag_ssc_clock_divider_50MHz = &H0 Then write_ssc_clock_divider_50MHz_value = get_ssc_clock_divider_50MHz
        If flag_ssc_limit_50MHz_1 = &H0 Then write_ssc_limit_50MHz_1_value = get_ssc_limit_50MHz_1

        regValue = leftShift((write_ndiv_int_delay_value and &Hf), 7) + leftShift((write_ssc_clock_divider_50MHz_value and &Hf), 3) + leftShift((write_ssc_limit_50MHz_1_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ndiv_int_delay_value = rightShift(data_low, 7) and &Hf
        read_ssc_clock_divider_50MHz_value = rightShift(data_low, 3) and &Hf
        ssc_limit_50MHz_1_mask = &H7
        if data_low > LONG_MAX then
            if ssc_limit_50MHz_1_mask = mask then
                read_ssc_limit_50MHz_1_value = data_low
            else
                read_ssc_limit_50MHz_1_value = (data_low - H8000_0000) and ssc_limit_50MHz_1_mask
            end If
        else
            read_ssc_limit_50MHz_1_value = data_low and ssc_limit_50MHz_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ndiv_int_delay_value = &H0
        flag_ndiv_int_delay        = &H0
        write_ssc_clock_divider_50MHz_value = &H0
        flag_ssc_clock_divider_50MHz        = &H0
        write_ssc_limit_50MHz_1_value = &H0
        flag_ssc_limit_50MHz_1        = &H0
    End Sub
End Class


'' @REGISTER : PCIE1__SGMIIPCIE_X1_tcatimer0
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
Class REGISTER_PCIE1__SGMIIPCIE_X1_tcatimer0
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


'' @REGISTER : PCIE1__SGMIIPCIE_X1_tcatimer1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tca_fine_timer                             [13:0]           get_tca_fine_timer
''                                                             set_tca_fine_timer
''                                                             read_tca_fine_timer
''                                                             write_tca_fine_timer
''---------------------------------------------------------------------------------
Class REGISTER_PCIE1__SGMIIPCIE_X1_tcatimer1
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
        If flag_tca_fine_timer = &H0 Then read
        If flag_tca_fine_timer = &H0 Then write_tca_fine_timer_value = get_tca_fine_timer

        regValue = leftShift((write_tca_fine_timer_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
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
        write_tca_fine_timer_value = &H0
        flag_tca_fine_timer        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCIE1__SGMIIPCIE_X1_INSTANCE

    Public control
    Public status
    Public ssccontrol0
    Public ssccontrol1
    Public ssccontrol2
    Public ssccontrol3
    Public ssccontrol4
    Public ssccontrol5
    Public ssccontrol6
    Public ssccontrol7
    Public ssccontrol8
    Public ssccontrol9
    Public ssccontrol10
    Public tcatimer0
    Public tcatimer1


    Public default function Init(aBaseAddr)
        Set control = (New REGISTER_PCIE1__SGMIIPCIE_X1_control)(aBaseAddr, 16)
        Set status = (New REGISTER_PCIE1__SGMIIPCIE_X1_status)(aBaseAddr, 16)
        Set ssccontrol0 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol0)(aBaseAddr, 16)
        Set ssccontrol1 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol1)(aBaseAddr, 16)
        Set ssccontrol2 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol2)(aBaseAddr, 16)
        Set ssccontrol3 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol3)(aBaseAddr, 16)
        Set ssccontrol4 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol4)(aBaseAddr, 16)
        Set ssccontrol5 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol5)(aBaseAddr, 16)
        Set ssccontrol6 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol6)(aBaseAddr, 16)
        Set ssccontrol7 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol7)(aBaseAddr, 16)
        Set ssccontrol8 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol8)(aBaseAddr, 16)
        Set ssccontrol9 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol9)(aBaseAddr, 16)
        Set ssccontrol10 = (New REGISTER_PCIE1__SGMIIPCIE_X1_ssccontrol10)(aBaseAddr, 16)
        Set tcatimer0 = (New REGISTER_PCIE1__SGMIIPCIE_X1_tcatimer0)(aBaseAddr, 16)
        Set tcatimer1 = (New REGISTER_PCIE1__SGMIIPCIE_X1_tcatimer1)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCIE1__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PCIE1__SGMIIPCIE_X1.Add ((New PCIE1__SGMIIPCIE_X1_INSTANCE)(&H4ade2200))


