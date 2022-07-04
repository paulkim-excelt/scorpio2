

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


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_test_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fpat_md                                    [15:15]          get_fpat_md
''                                                             set_fpat_md
''                                                             read_fpat_md
''                                                             write_fpat_md
''---------------------------------------------------------------------------------
'' prbs_clr_dis                               [12:12]          get_prbs_clr_dis
''                                                             set_prbs_clr_dis
''                                                             read_prbs_clr_dis
''                                                             write_prbs_clr_dis
''---------------------------------------------------------------------------------
'' Emon_en                                    [9:9]            get_Emon_en
''                                                             set_Emon_en
''                                                             read_Emon_en
''                                                             write_Emon_en
''---------------------------------------------------------------------------------
'' prbsmon_en                                 [4:4]            get_prbsmon_en
''                                                             set_prbsmon_en
''                                                             read_prbsmon_en
''                                                             write_prbsmon_en
''---------------------------------------------------------------------------------
'' prbsmon_inv                                [3:3]            get_prbsmon_inv
''                                                             set_prbsmon_inv
''                                                             read_prbsmon_inv
''                                                             write_prbsmon_inv
''---------------------------------------------------------------------------------
'' prbsmon_order                              [2:0]            get_prbsmon_order
''                                                             set_prbsmon_order
''                                                             read_prbsmon_order
''                                                             write_prbsmon_order
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_test_control
    Private write_fpat_md_value
    Private read_fpat_md_value
    Private flag_fpat_md
    Private write_prbs_clr_dis_value
    Private read_prbs_clr_dis_value
    Private flag_prbs_clr_dis
    Private write_Emon_en_value
    Private read_Emon_en_value
    Private flag_Emon_en
    Private write_prbsmon_en_value
    Private read_prbsmon_en_value
    Private flag_prbsmon_en
    Private write_prbsmon_inv_value
    Private read_prbsmon_inv_value
    Private flag_prbsmon_inv
    Private write_prbsmon_order_value
    Private read_prbsmon_order_value
    Private flag_prbsmon_order

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

    Property Get get_fpat_md
        get_fpat_md = read_fpat_md_value
    End Property

    Property Let set_fpat_md(aData)
        write_fpat_md_value = aData
        flag_fpat_md        = &H1
    End Property

    Property Get read_fpat_md
        read
        read_fpat_md = read_fpat_md_value
    End Property

    Property Let write_fpat_md(aData)
        set_fpat_md = aData
        write
    End Property

    Property Get get_prbs_clr_dis
        get_prbs_clr_dis = read_prbs_clr_dis_value
    End Property

    Property Let set_prbs_clr_dis(aData)
        write_prbs_clr_dis_value = aData
        flag_prbs_clr_dis        = &H1
    End Property

    Property Get read_prbs_clr_dis
        read
        read_prbs_clr_dis = read_prbs_clr_dis_value
    End Property

    Property Let write_prbs_clr_dis(aData)
        set_prbs_clr_dis = aData
        write
    End Property

    Property Get get_Emon_en
        get_Emon_en = read_Emon_en_value
    End Property

    Property Let set_Emon_en(aData)
        write_Emon_en_value = aData
        flag_Emon_en        = &H1
    End Property

    Property Get read_Emon_en
        read
        read_Emon_en = read_Emon_en_value
    End Property

    Property Let write_Emon_en(aData)
        set_Emon_en = aData
        write
    End Property

    Property Get get_prbsmon_en
        get_prbsmon_en = read_prbsmon_en_value
    End Property

    Property Let set_prbsmon_en(aData)
        write_prbsmon_en_value = aData
        flag_prbsmon_en        = &H1
    End Property

    Property Get read_prbsmon_en
        read
        read_prbsmon_en = read_prbsmon_en_value
    End Property

    Property Let write_prbsmon_en(aData)
        set_prbsmon_en = aData
        write
    End Property

    Property Get get_prbsmon_inv
        get_prbsmon_inv = read_prbsmon_inv_value
    End Property

    Property Let set_prbsmon_inv(aData)
        write_prbsmon_inv_value = aData
        flag_prbsmon_inv        = &H1
    End Property

    Property Get read_prbsmon_inv
        read
        read_prbsmon_inv = read_prbsmon_inv_value
    End Property

    Property Let write_prbsmon_inv(aData)
        set_prbsmon_inv = aData
        write
    End Property

    Property Get get_prbsmon_order
        get_prbsmon_order = read_prbsmon_order_value
    End Property

    Property Let set_prbsmon_order(aData)
        write_prbsmon_order_value = aData
        flag_prbsmon_order        = &H1
    End Property

    Property Get read_prbsmon_order
        read
        read_prbsmon_order = read_prbsmon_order_value
    End Property

    Property Let write_prbsmon_order(aData)
        set_prbsmon_order = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fpat_md_value = rightShift(data_low, 15) and &H1
        read_prbs_clr_dis_value = rightShift(data_low, 12) and &H1
        read_Emon_en_value = rightShift(data_low, 9) and &H1
        read_prbsmon_en_value = rightShift(data_low, 4) and &H1
        read_prbsmon_inv_value = rightShift(data_low, 3) and &H1
        prbsmon_order_mask = &H7
        if data_low > LONG_MAX then
            if prbsmon_order_mask = mask then
                read_prbsmon_order_value = data_low
            else
                read_prbsmon_order_value = (data_low - H8000_0000) and prbsmon_order_mask
            end If
        else
            read_prbsmon_order_value = data_low and prbsmon_order_mask
        end If

    End Sub

    Sub write
        If flag_fpat_md = &H0 or flag_prbs_clr_dis = &H0 or flag_Emon_en = &H0 or flag_prbsmon_en = &H0 or flag_prbsmon_inv = &H0 or flag_prbsmon_order = &H0 Then read
        If flag_fpat_md = &H0 Then write_fpat_md_value = get_fpat_md
        If flag_prbs_clr_dis = &H0 Then write_prbs_clr_dis_value = get_prbs_clr_dis
        If flag_Emon_en = &H0 Then write_Emon_en_value = get_Emon_en
        If flag_prbsmon_en = &H0 Then write_prbsmon_en_value = get_prbsmon_en
        If flag_prbsmon_inv = &H0 Then write_prbsmon_inv_value = get_prbsmon_inv
        If flag_prbsmon_order = &H0 Then write_prbsmon_order_value = get_prbsmon_order

        regValue = leftShift((write_fpat_md_value and &H1), 15) + leftShift((write_prbs_clr_dis_value and &H1), 12) + leftShift((write_Emon_en_value and &H1), 9) + leftShift((write_prbsmon_en_value and &H1), 4) + leftShift((write_prbsmon_inv_value and &H1), 3) + leftShift((write_prbsmon_order_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fpat_md_value = rightShift(data_low, 15) and &H1
        read_prbs_clr_dis_value = rightShift(data_low, 12) and &H1
        read_Emon_en_value = rightShift(data_low, 9) and &H1
        read_prbsmon_en_value = rightShift(data_low, 4) and &H1
        read_prbsmon_inv_value = rightShift(data_low, 3) and &H1
        prbsmon_order_mask = &H7
        if data_low > LONG_MAX then
            if prbsmon_order_mask = mask then
                read_prbsmon_order_value = data_low
            else
                read_prbsmon_order_value = (data_low - H8000_0000) and prbsmon_order_mask
            end If
        else
            read_prbsmon_order_value = data_low and prbsmon_order_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fpat_md_value = &H0
        flag_fpat_md        = &H0
        write_prbs_clr_dis_value = &H0
        flag_prbs_clr_dis        = &H0
        write_Emon_en_value = &H0
        flag_Emon_en        = &H0
        write_prbsmon_en_value = &H0
        flag_prbsmon_en        = &H0
        write_prbsmon_inv_value = &H0
        flag_prbsmon_inv        = &H0
        write_prbsmon_order_value = &H0
        flag_prbsmon_order        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_test_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prbs_lock                                  [15:15]          get_prbs_lock
''                                                             set_prbs_lock
''                                                             read_prbs_lock
''                                                             write_prbs_lock
''---------------------------------------------------------------------------------
'' prbs_stky                                  [14:14]          get_prbs_stky
''                                                             set_prbs_stky
''                                                             read_prbs_stky
''                                                             write_prbs_stky
''---------------------------------------------------------------------------------
'' prbs_errors                                [13:0]           get_prbs_errors
''                                                             set_prbs_errors
''                                                             read_prbs_errors
''                                                             write_prbs_errors
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_test_status
    Private write_prbs_lock_value
    Private read_prbs_lock_value
    Private flag_prbs_lock
    Private write_prbs_stky_value
    Private read_prbs_stky_value
    Private flag_prbs_stky
    Private write_prbs_errors_value
    Private read_prbs_errors_value
    Private flag_prbs_errors

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

    Property Get get_prbs_lock
        get_prbs_lock = read_prbs_lock_value
    End Property

    Property Let set_prbs_lock(aData)
        write_prbs_lock_value = aData
        flag_prbs_lock        = &H1
    End Property

    Property Get read_prbs_lock
        read
        read_prbs_lock = read_prbs_lock_value
    End Property

    Property Let write_prbs_lock(aData)
        set_prbs_lock = aData
        write
    End Property

    Property Get get_prbs_stky
        get_prbs_stky = read_prbs_stky_value
    End Property

    Property Let set_prbs_stky(aData)
        write_prbs_stky_value = aData
        flag_prbs_stky        = &H1
    End Property

    Property Get read_prbs_stky
        read
        read_prbs_stky = read_prbs_stky_value
    End Property

    Property Let write_prbs_stky(aData)
        set_prbs_stky = aData
        write
    End Property

    Property Get get_prbs_errors
        get_prbs_errors = read_prbs_errors_value
    End Property

    Property Let set_prbs_errors(aData)
        write_prbs_errors_value = aData
        flag_prbs_errors        = &H1
    End Property

    Property Get read_prbs_errors
        read
        read_prbs_errors = read_prbs_errors_value
    End Property

    Property Let write_prbs_errors(aData)
        set_prbs_errors = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_lock_value = rightShift(data_low, 15) and &H1
        read_prbs_stky_value = rightShift(data_low, 14) and &H1
        prbs_errors_mask = &H3fff
        if data_low > LONG_MAX then
            if prbs_errors_mask = mask then
                read_prbs_errors_value = data_low
            else
                read_prbs_errors_value = (data_low - H8000_0000) and prbs_errors_mask
            end If
        else
            read_prbs_errors_value = data_low and prbs_errors_mask
        end If

    End Sub

    Sub write
        If flag_prbs_lock = &H0 or flag_prbs_stky = &H0 or flag_prbs_errors = &H0 Then read
        If flag_prbs_lock = &H0 Then write_prbs_lock_value = get_prbs_lock
        If flag_prbs_stky = &H0 Then write_prbs_stky_value = get_prbs_stky
        If flag_prbs_errors = &H0 Then write_prbs_errors_value = get_prbs_errors

        regValue = leftShift((write_prbs_lock_value and &H1), 15) + leftShift((write_prbs_stky_value and &H1), 14) + leftShift((write_prbs_errors_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_prbs_lock_value = rightShift(data_low, 15) and &H1
        read_prbs_stky_value = rightShift(data_low, 14) and &H1
        prbs_errors_mask = &H3fff
        if data_low > LONG_MAX then
            if prbs_errors_mask = mask then
                read_prbs_errors_value = data_low
            else
                read_prbs_errors_value = (data_low - H8000_0000) and prbs_errors_mask
            end If
        else
            read_prbs_errors_value = data_low and prbs_errors_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prbs_lock_value = &H0
        flag_prbs_lock        = &H0
        write_prbs_stky_value = &H0
        flag_prbs_stky        = &H0
        write_prbs_errors_value = &H0
        flag_prbs_errors        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pmd_rloopback                              [15:15]          get_pmd_rloopback
''                                                             set_pmd_rloopback
''                                                             read_pmd_rloopback
''                                                             write_pmd_rloopback
''---------------------------------------------------------------------------------
'' pmd_gloopback                              [14:14]          get_pmd_gloopback
''                                                             set_pmd_gloopback
''                                                             read_pmd_gloopback
''                                                             write_pmd_gloopback
''---------------------------------------------------------------------------------
'' rxpol_flip_SM                              [9:9]            get_rxpol_flip_SM
''                                                             set_rxpol_flip_SM
''                                                             read_rxpol_flip_SM
''                                                             write_rxpol_flip_SM
''---------------------------------------------------------------------------------
'' lock_ref                                   [8:8]            get_lock_ref
''                                                             set_lock_ref
''                                                             read_lock_ref
''                                                             write_lock_ref
''---------------------------------------------------------------------------------
'' phase_sel_SM                               [7:7]            get_phase_sel_SM
''                                                             set_phase_sel_SM
''                                                             read_phase_sel_SM
''                                                             write_phase_sel_SM
''---------------------------------------------------------------------------------
'' freq_sel                                   [6:6]            get_freq_sel
''                                                             set_freq_sel
''                                                             read_freq_sel
''                                                             write_freq_sel
''---------------------------------------------------------------------------------
'' freq_sel_force_SM                          [5:5]            get_freq_sel_force_SM
''                                                             set_freq_sel_force_SM
''                                                             read_freq_sel_force_SM
''                                                             write_freq_sel_force_SM
''---------------------------------------------------------------------------------
'' freq_sel_SM                                [4:4]            get_freq_sel_SM
''                                                             set_freq_sel_SM
''                                                             read_freq_sel_SM
''                                                             write_freq_sel_SM
''---------------------------------------------------------------------------------
'' rxck_mii_gen_sel_force                     [3:3]            get_rxck_mii_gen_sel_force
''                                                             set_rxck_mii_gen_sel_force
''                                                             read_rxck_mii_gen_sel_force
''                                                             write_rxck_mii_gen_sel_force
''---------------------------------------------------------------------------------
'' forceRxSeqDone_SM                          [2:2]            get_forceRxSeqDone_SM
''                                                             set_forceRxSeqDone_SM
''                                                             read_forceRxSeqDone_SM
''                                                             write_forceRxSeqDone_SM
''---------------------------------------------------------------------------------
'' flip_eyemon_polarity                       [1:1]            get_flip_eyemon_polarity
''                                                             set_flip_eyemon_polarity
''                                                             read_flip_eyemon_polarity
''                                                             write_flip_eyemon_polarity
''---------------------------------------------------------------------------------
'' crc_checker_disable                        [0:0]            get_crc_checker_disable
''                                                             set_crc_checker_disable
''                                                             read_crc_checker_disable
''                                                             write_crc_checker_disable
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control0
    Private write_pmd_rloopback_value
    Private read_pmd_rloopback_value
    Private flag_pmd_rloopback
    Private write_pmd_gloopback_value
    Private read_pmd_gloopback_value
    Private flag_pmd_gloopback
    Private write_rxpol_flip_SM_value
    Private read_rxpol_flip_SM_value
    Private flag_rxpol_flip_SM
    Private write_lock_ref_value
    Private read_lock_ref_value
    Private flag_lock_ref
    Private write_phase_sel_SM_value
    Private read_phase_sel_SM_value
    Private flag_phase_sel_SM
    Private write_freq_sel_value
    Private read_freq_sel_value
    Private flag_freq_sel
    Private write_freq_sel_force_SM_value
    Private read_freq_sel_force_SM_value
    Private flag_freq_sel_force_SM
    Private write_freq_sel_SM_value
    Private read_freq_sel_SM_value
    Private flag_freq_sel_SM
    Private write_rxck_mii_gen_sel_force_value
    Private read_rxck_mii_gen_sel_force_value
    Private flag_rxck_mii_gen_sel_force
    Private write_forceRxSeqDone_SM_value
    Private read_forceRxSeqDone_SM_value
    Private flag_forceRxSeqDone_SM
    Private write_flip_eyemon_polarity_value
    Private read_flip_eyemon_polarity_value
    Private flag_flip_eyemon_polarity
    Private write_crc_checker_disable_value
    Private read_crc_checker_disable_value
    Private flag_crc_checker_disable

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

    Property Get get_pmd_rloopback
        get_pmd_rloopback = read_pmd_rloopback_value
    End Property

    Property Let set_pmd_rloopback(aData)
        write_pmd_rloopback_value = aData
        flag_pmd_rloopback        = &H1
    End Property

    Property Get read_pmd_rloopback
        read
        read_pmd_rloopback = read_pmd_rloopback_value
    End Property

    Property Let write_pmd_rloopback(aData)
        set_pmd_rloopback = aData
        write
    End Property

    Property Get get_pmd_gloopback
        get_pmd_gloopback = read_pmd_gloopback_value
    End Property

    Property Let set_pmd_gloopback(aData)
        write_pmd_gloopback_value = aData
        flag_pmd_gloopback        = &H1
    End Property

    Property Get read_pmd_gloopback
        read
        read_pmd_gloopback = read_pmd_gloopback_value
    End Property

    Property Let write_pmd_gloopback(aData)
        set_pmd_gloopback = aData
        write
    End Property

    Property Get get_rxpol_flip_SM
        get_rxpol_flip_SM = read_rxpol_flip_SM_value
    End Property

    Property Let set_rxpol_flip_SM(aData)
        write_rxpol_flip_SM_value = aData
        flag_rxpol_flip_SM        = &H1
    End Property

    Property Get read_rxpol_flip_SM
        read
        read_rxpol_flip_SM = read_rxpol_flip_SM_value
    End Property

    Property Let write_rxpol_flip_SM(aData)
        set_rxpol_flip_SM = aData
        write
    End Property

    Property Get get_lock_ref
        get_lock_ref = read_lock_ref_value
    End Property

    Property Let set_lock_ref(aData)
        write_lock_ref_value = aData
        flag_lock_ref        = &H1
    End Property

    Property Get read_lock_ref
        read
        read_lock_ref = read_lock_ref_value
    End Property

    Property Let write_lock_ref(aData)
        set_lock_ref = aData
        write
    End Property

    Property Get get_phase_sel_SM
        get_phase_sel_SM = read_phase_sel_SM_value
    End Property

    Property Let set_phase_sel_SM(aData)
        write_phase_sel_SM_value = aData
        flag_phase_sel_SM        = &H1
    End Property

    Property Get read_phase_sel_SM
        read
        read_phase_sel_SM = read_phase_sel_SM_value
    End Property

    Property Let write_phase_sel_SM(aData)
        set_phase_sel_SM = aData
        write
    End Property

    Property Get get_freq_sel
        get_freq_sel = read_freq_sel_value
    End Property

    Property Let set_freq_sel(aData)
        write_freq_sel_value = aData
        flag_freq_sel        = &H1
    End Property

    Property Get read_freq_sel
        read
        read_freq_sel = read_freq_sel_value
    End Property

    Property Let write_freq_sel(aData)
        set_freq_sel = aData
        write
    End Property

    Property Get get_freq_sel_force_SM
        get_freq_sel_force_SM = read_freq_sel_force_SM_value
    End Property

    Property Let set_freq_sel_force_SM(aData)
        write_freq_sel_force_SM_value = aData
        flag_freq_sel_force_SM        = &H1
    End Property

    Property Get read_freq_sel_force_SM
        read
        read_freq_sel_force_SM = read_freq_sel_force_SM_value
    End Property

    Property Let write_freq_sel_force_SM(aData)
        set_freq_sel_force_SM = aData
        write
    End Property

    Property Get get_freq_sel_SM
        get_freq_sel_SM = read_freq_sel_SM_value
    End Property

    Property Let set_freq_sel_SM(aData)
        write_freq_sel_SM_value = aData
        flag_freq_sel_SM        = &H1
    End Property

    Property Get read_freq_sel_SM
        read
        read_freq_sel_SM = read_freq_sel_SM_value
    End Property

    Property Let write_freq_sel_SM(aData)
        set_freq_sel_SM = aData
        write
    End Property

    Property Get get_rxck_mii_gen_sel_force
        get_rxck_mii_gen_sel_force = read_rxck_mii_gen_sel_force_value
    End Property

    Property Let set_rxck_mii_gen_sel_force(aData)
        write_rxck_mii_gen_sel_force_value = aData
        flag_rxck_mii_gen_sel_force        = &H1
    End Property

    Property Get read_rxck_mii_gen_sel_force
        read
        read_rxck_mii_gen_sel_force = read_rxck_mii_gen_sel_force_value
    End Property

    Property Let write_rxck_mii_gen_sel_force(aData)
        set_rxck_mii_gen_sel_force = aData
        write
    End Property

    Property Get get_forceRxSeqDone_SM
        get_forceRxSeqDone_SM = read_forceRxSeqDone_SM_value
    End Property

    Property Let set_forceRxSeqDone_SM(aData)
        write_forceRxSeqDone_SM_value = aData
        flag_forceRxSeqDone_SM        = &H1
    End Property

    Property Get read_forceRxSeqDone_SM
        read
        read_forceRxSeqDone_SM = read_forceRxSeqDone_SM_value
    End Property

    Property Let write_forceRxSeqDone_SM(aData)
        set_forceRxSeqDone_SM = aData
        write
    End Property

    Property Get get_flip_eyemon_polarity
        get_flip_eyemon_polarity = read_flip_eyemon_polarity_value
    End Property

    Property Let set_flip_eyemon_polarity(aData)
        write_flip_eyemon_polarity_value = aData
        flag_flip_eyemon_polarity        = &H1
    End Property

    Property Get read_flip_eyemon_polarity
        read
        read_flip_eyemon_polarity = read_flip_eyemon_polarity_value
    End Property

    Property Let write_flip_eyemon_polarity(aData)
        set_flip_eyemon_polarity = aData
        write
    End Property

    Property Get get_crc_checker_disable
        get_crc_checker_disable = read_crc_checker_disable_value
    End Property

    Property Let set_crc_checker_disable(aData)
        write_crc_checker_disable_value = aData
        flag_crc_checker_disable        = &H1
    End Property

    Property Get read_crc_checker_disable
        read
        read_crc_checker_disable = read_crc_checker_disable_value
    End Property

    Property Let write_crc_checker_disable(aData)
        set_crc_checker_disable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pmd_rloopback_value = rightShift(data_low, 15) and &H1
        read_pmd_gloopback_value = rightShift(data_low, 14) and &H1
        read_rxpol_flip_SM_value = rightShift(data_low, 9) and &H1
        read_lock_ref_value = rightShift(data_low, 8) and &H1
        read_phase_sel_SM_value = rightShift(data_low, 7) and &H1
        read_freq_sel_value = rightShift(data_low, 6) and &H1
        read_freq_sel_force_SM_value = rightShift(data_low, 5) and &H1
        read_freq_sel_SM_value = rightShift(data_low, 4) and &H1
        read_rxck_mii_gen_sel_force_value = rightShift(data_low, 3) and &H1
        read_forceRxSeqDone_SM_value = rightShift(data_low, 2) and &H1
        read_flip_eyemon_polarity_value = rightShift(data_low, 1) and &H1
        crc_checker_disable_mask = &H1
        if data_low > LONG_MAX then
            if crc_checker_disable_mask = mask then
                read_crc_checker_disable_value = data_low
            else
                read_crc_checker_disable_value = (data_low - H8000_0000) and crc_checker_disable_mask
            end If
        else
            read_crc_checker_disable_value = data_low and crc_checker_disable_mask
        end If

    End Sub

    Sub write
        If flag_pmd_rloopback = &H0 or flag_pmd_gloopback = &H0 or flag_rxpol_flip_SM = &H0 or flag_lock_ref = &H0 or flag_phase_sel_SM = &H0 or flag_freq_sel = &H0 or flag_freq_sel_force_SM = &H0 or flag_freq_sel_SM = &H0 or flag_rxck_mii_gen_sel_force = &H0 or flag_forceRxSeqDone_SM = &H0 or flag_flip_eyemon_polarity = &H0 or flag_crc_checker_disable = &H0 Then read
        If flag_pmd_rloopback = &H0 Then write_pmd_rloopback_value = get_pmd_rloopback
        If flag_pmd_gloopback = &H0 Then write_pmd_gloopback_value = get_pmd_gloopback
        If flag_rxpol_flip_SM = &H0 Then write_rxpol_flip_SM_value = get_rxpol_flip_SM
        If flag_lock_ref = &H0 Then write_lock_ref_value = get_lock_ref
        If flag_phase_sel_SM = &H0 Then write_phase_sel_SM_value = get_phase_sel_SM
        If flag_freq_sel = &H0 Then write_freq_sel_value = get_freq_sel
        If flag_freq_sel_force_SM = &H0 Then write_freq_sel_force_SM_value = get_freq_sel_force_SM
        If flag_freq_sel_SM = &H0 Then write_freq_sel_SM_value = get_freq_sel_SM
        If flag_rxck_mii_gen_sel_force = &H0 Then write_rxck_mii_gen_sel_force_value = get_rxck_mii_gen_sel_force
        If flag_forceRxSeqDone_SM = &H0 Then write_forceRxSeqDone_SM_value = get_forceRxSeqDone_SM
        If flag_flip_eyemon_polarity = &H0 Then write_flip_eyemon_polarity_value = get_flip_eyemon_polarity
        If flag_crc_checker_disable = &H0 Then write_crc_checker_disable_value = get_crc_checker_disable

        regValue = leftShift((write_pmd_rloopback_value and &H1), 15) + leftShift((write_pmd_gloopback_value and &H1), 14) + leftShift((write_rxpol_flip_SM_value and &H1), 9) + leftShift((write_lock_ref_value and &H1), 8) + leftShift((write_phase_sel_SM_value and &H1), 7) + leftShift((write_freq_sel_value and &H1), 6) + leftShift((write_freq_sel_force_SM_value and &H1), 5) + leftShift((write_freq_sel_SM_value and &H1), 4) + leftShift((write_rxck_mii_gen_sel_force_value and &H1), 3) + leftShift((write_forceRxSeqDone_SM_value and &H1), 2) + leftShift((write_flip_eyemon_polarity_value and &H1), 1) + leftShift((write_crc_checker_disable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pmd_rloopback_value = rightShift(data_low, 15) and &H1
        read_pmd_gloopback_value = rightShift(data_low, 14) and &H1
        read_rxpol_flip_SM_value = rightShift(data_low, 9) and &H1
        read_lock_ref_value = rightShift(data_low, 8) and &H1
        read_phase_sel_SM_value = rightShift(data_low, 7) and &H1
        read_freq_sel_value = rightShift(data_low, 6) and &H1
        read_freq_sel_force_SM_value = rightShift(data_low, 5) and &H1
        read_freq_sel_SM_value = rightShift(data_low, 4) and &H1
        read_rxck_mii_gen_sel_force_value = rightShift(data_low, 3) and &H1
        read_forceRxSeqDone_SM_value = rightShift(data_low, 2) and &H1
        read_flip_eyemon_polarity_value = rightShift(data_low, 1) and &H1
        crc_checker_disable_mask = &H1
        if data_low > LONG_MAX then
            if crc_checker_disable_mask = mask then
                read_crc_checker_disable_value = data_low
            else
                read_crc_checker_disable_value = (data_low - H8000_0000) and crc_checker_disable_mask
            end If
        else
            read_crc_checker_disable_value = data_low and crc_checker_disable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pmd_rloopback_value = &H0
        flag_pmd_rloopback        = &H0
        write_pmd_gloopback_value = &H0
        flag_pmd_gloopback        = &H0
        write_rxpol_flip_SM_value = &H0
        flag_rxpol_flip_SM        = &H0
        write_lock_ref_value = &H0
        flag_lock_ref        = &H0
        write_phase_sel_SM_value = &H0
        flag_phase_sel_SM        = &H0
        write_freq_sel_value = &H0
        flag_freq_sel        = &H0
        write_freq_sel_force_SM_value = &H0
        flag_freq_sel_force_SM        = &H0
        write_freq_sel_SM_value = &H0
        flag_freq_sel_SM        = &H0
        write_rxck_mii_gen_sel_force_value = &H0
        flag_rxck_mii_gen_sel_force        = &H0
        write_forceRxSeqDone_SM_value = &H0
        flag_forceRxSeqDone_SM        = &H0
        write_flip_eyemon_polarity_value = &H0
        flag_flip_eyemon_polarity        = &H0
        write_crc_checker_disable_value = &H0
        flag_crc_checker_disable        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_pf_ctrl                                 [15:12]          get_rx_pf_ctrl
''                                                             set_rx_pf_ctrl
''                                                             read_rx_pf_ctrl
''                                                             write_rx_pf_ctrl
''---------------------------------------------------------------------------------
'' rxSeqRestart_SM                            [11:11]          get_rxSeqRestart_SM
''                                                             set_rxSeqRestart_SM
''                                                             read_rxSeqRestart_SM
''                                                             write_rxSeqRestart_SM
''---------------------------------------------------------------------------------
'' ROV                                        [10:10]          get_ROV
''                                                             set_ROV
''                                                             read_ROV
''                                                             write_ROV
''---------------------------------------------------------------------------------
'' rxSigdetPwrdn_override                     [9:9]            get_rxSigdetPwrdn_override
''                                                             set_rxSigdetPwrdn_override
''                                                             read_rxSigdetPwrdn_override
''                                                             write_rxSigdetPwrdn_override
''---------------------------------------------------------------------------------
'' sigDetected_en_SM                          [8:8]            get_sigDetected_en_SM
''                                                             set_sigDetected_en_SM
''                                                             read_sigDetected_en_SM
''                                                             write_sigDetected_en_SM
''---------------------------------------------------------------------------------
'' sigdetRestart_en_SM                        [7:7]            get_sigdetRestart_en_SM
''                                                             set_sigdetRestart_en_SM
''                                                             read_sigdetRestart_en_SM
''                                                             write_sigdetRestart_en_SM
''---------------------------------------------------------------------------------
'' sigdetMonitor_en_SM                        [6:6]            get_sigdetMonitor_en_SM
''                                                             set_sigdetMonitor_en_SM
''                                                             read_sigdetMonitor_en_SM
''                                                             write_sigdetMonitor_en_SM
''---------------------------------------------------------------------------------
'' rxSeqDone_cya                              [5:5]            get_rxSeqDone_cya
''                                                             set_rxSeqDone_cya
''                                                             read_rxSeqDone_cya
''                                                             write_rxSeqDone_cya
''---------------------------------------------------------------------------------
'' spd_rstb_dis_SM                            [4:4]            get_spd_rstb_dis_SM
''                                                             set_spd_rstb_dis_SM
''                                                             read_spd_rstb_dis_SM
''                                                             write_spd_rstb_dis_SM
''---------------------------------------------------------------------------------
'' rtbi_mode                                  [3:3]            get_rtbi_mode
''                                                             set_rtbi_mode
''                                                             read_rtbi_mode
''                                                             write_rtbi_mode
''---------------------------------------------------------------------------------
'' indck_mode_en_rx                           [2:2]            get_indck_mode_en_rx
''                                                             set_indck_mode_en_rx
''                                                             read_indck_mode_en_rx
''                                                             write_indck_mode_en_rx
''---------------------------------------------------------------------------------
'' combo_mode_en_rx                           [1:1]            get_combo_mode_en_rx
''                                                             set_combo_mode_en_rx
''                                                             read_combo_mode_en_rx
''                                                             write_combo_mode_en_rx
''---------------------------------------------------------------------------------
'' cl36_pcs_en_rx                             [0:0]            get_cl36_pcs_en_rx
''                                                             set_cl36_pcs_en_rx
''                                                             read_cl36_pcs_en_rx
''                                                             write_cl36_pcs_en_rx
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control1
    Private write_rx_pf_ctrl_value
    Private read_rx_pf_ctrl_value
    Private flag_rx_pf_ctrl
    Private write_rxSeqRestart_SM_value
    Private read_rxSeqRestart_SM_value
    Private flag_rxSeqRestart_SM
    Private write_ROV_value
    Private read_ROV_value
    Private flag_ROV
    Private write_rxSigdetPwrdn_override_value
    Private read_rxSigdetPwrdn_override_value
    Private flag_rxSigdetPwrdn_override
    Private write_sigDetected_en_SM_value
    Private read_sigDetected_en_SM_value
    Private flag_sigDetected_en_SM
    Private write_sigdetRestart_en_SM_value
    Private read_sigdetRestart_en_SM_value
    Private flag_sigdetRestart_en_SM
    Private write_sigdetMonitor_en_SM_value
    Private read_sigdetMonitor_en_SM_value
    Private flag_sigdetMonitor_en_SM
    Private write_rxSeqDone_cya_value
    Private read_rxSeqDone_cya_value
    Private flag_rxSeqDone_cya
    Private write_spd_rstb_dis_SM_value
    Private read_spd_rstb_dis_SM_value
    Private flag_spd_rstb_dis_SM
    Private write_rtbi_mode_value
    Private read_rtbi_mode_value
    Private flag_rtbi_mode
    Private write_indck_mode_en_rx_value
    Private read_indck_mode_en_rx_value
    Private flag_indck_mode_en_rx
    Private write_combo_mode_en_rx_value
    Private read_combo_mode_en_rx_value
    Private flag_combo_mode_en_rx
    Private write_cl36_pcs_en_rx_value
    Private read_cl36_pcs_en_rx_value
    Private flag_cl36_pcs_en_rx

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

    Property Get get_rx_pf_ctrl
        get_rx_pf_ctrl = read_rx_pf_ctrl_value
    End Property

    Property Let set_rx_pf_ctrl(aData)
        write_rx_pf_ctrl_value = aData
        flag_rx_pf_ctrl        = &H1
    End Property

    Property Get read_rx_pf_ctrl
        read
        read_rx_pf_ctrl = read_rx_pf_ctrl_value
    End Property

    Property Let write_rx_pf_ctrl(aData)
        set_rx_pf_ctrl = aData
        write
    End Property

    Property Get get_rxSeqRestart_SM
        get_rxSeqRestart_SM = read_rxSeqRestart_SM_value
    End Property

    Property Let set_rxSeqRestart_SM(aData)
        write_rxSeqRestart_SM_value = aData
        flag_rxSeqRestart_SM        = &H1
    End Property

    Property Get read_rxSeqRestart_SM
        read
        read_rxSeqRestart_SM = read_rxSeqRestart_SM_value
    End Property

    Property Let write_rxSeqRestart_SM(aData)
        set_rxSeqRestart_SM = aData
        write
    End Property

    Property Get get_ROV
        get_ROV = read_ROV_value
    End Property

    Property Let set_ROV(aData)
        write_ROV_value = aData
        flag_ROV        = &H1
    End Property

    Property Get read_ROV
        read
        read_ROV = read_ROV_value
    End Property

    Property Let write_ROV(aData)
        set_ROV = aData
        write
    End Property

    Property Get get_rxSigdetPwrdn_override
        get_rxSigdetPwrdn_override = read_rxSigdetPwrdn_override_value
    End Property

    Property Let set_rxSigdetPwrdn_override(aData)
        write_rxSigdetPwrdn_override_value = aData
        flag_rxSigdetPwrdn_override        = &H1
    End Property

    Property Get read_rxSigdetPwrdn_override
        read
        read_rxSigdetPwrdn_override = read_rxSigdetPwrdn_override_value
    End Property

    Property Let write_rxSigdetPwrdn_override(aData)
        set_rxSigdetPwrdn_override = aData
        write
    End Property

    Property Get get_sigDetected_en_SM
        get_sigDetected_en_SM = read_sigDetected_en_SM_value
    End Property

    Property Let set_sigDetected_en_SM(aData)
        write_sigDetected_en_SM_value = aData
        flag_sigDetected_en_SM        = &H1
    End Property

    Property Get read_sigDetected_en_SM
        read
        read_sigDetected_en_SM = read_sigDetected_en_SM_value
    End Property

    Property Let write_sigDetected_en_SM(aData)
        set_sigDetected_en_SM = aData
        write
    End Property

    Property Get get_sigdetRestart_en_SM
        get_sigdetRestart_en_SM = read_sigdetRestart_en_SM_value
    End Property

    Property Let set_sigdetRestart_en_SM(aData)
        write_sigdetRestart_en_SM_value = aData
        flag_sigdetRestart_en_SM        = &H1
    End Property

    Property Get read_sigdetRestart_en_SM
        read
        read_sigdetRestart_en_SM = read_sigdetRestart_en_SM_value
    End Property

    Property Let write_sigdetRestart_en_SM(aData)
        set_sigdetRestart_en_SM = aData
        write
    End Property

    Property Get get_sigdetMonitor_en_SM
        get_sigdetMonitor_en_SM = read_sigdetMonitor_en_SM_value
    End Property

    Property Let set_sigdetMonitor_en_SM(aData)
        write_sigdetMonitor_en_SM_value = aData
        flag_sigdetMonitor_en_SM        = &H1
    End Property

    Property Get read_sigdetMonitor_en_SM
        read
        read_sigdetMonitor_en_SM = read_sigdetMonitor_en_SM_value
    End Property

    Property Let write_sigdetMonitor_en_SM(aData)
        set_sigdetMonitor_en_SM = aData
        write
    End Property

    Property Get get_rxSeqDone_cya
        get_rxSeqDone_cya = read_rxSeqDone_cya_value
    End Property

    Property Let set_rxSeqDone_cya(aData)
        write_rxSeqDone_cya_value = aData
        flag_rxSeqDone_cya        = &H1
    End Property

    Property Get read_rxSeqDone_cya
        read
        read_rxSeqDone_cya = read_rxSeqDone_cya_value
    End Property

    Property Let write_rxSeqDone_cya(aData)
        set_rxSeqDone_cya = aData
        write
    End Property

    Property Get get_spd_rstb_dis_SM
        get_spd_rstb_dis_SM = read_spd_rstb_dis_SM_value
    End Property

    Property Let set_spd_rstb_dis_SM(aData)
        write_spd_rstb_dis_SM_value = aData
        flag_spd_rstb_dis_SM        = &H1
    End Property

    Property Get read_spd_rstb_dis_SM
        read
        read_spd_rstb_dis_SM = read_spd_rstb_dis_SM_value
    End Property

    Property Let write_spd_rstb_dis_SM(aData)
        set_spd_rstb_dis_SM = aData
        write
    End Property

    Property Get get_rtbi_mode
        get_rtbi_mode = read_rtbi_mode_value
    End Property

    Property Let set_rtbi_mode(aData)
        write_rtbi_mode_value = aData
        flag_rtbi_mode        = &H1
    End Property

    Property Get read_rtbi_mode
        read
        read_rtbi_mode = read_rtbi_mode_value
    End Property

    Property Let write_rtbi_mode(aData)
        set_rtbi_mode = aData
        write
    End Property

    Property Get get_indck_mode_en_rx
        get_indck_mode_en_rx = read_indck_mode_en_rx_value
    End Property

    Property Let set_indck_mode_en_rx(aData)
        write_indck_mode_en_rx_value = aData
        flag_indck_mode_en_rx        = &H1
    End Property

    Property Get read_indck_mode_en_rx
        read
        read_indck_mode_en_rx = read_indck_mode_en_rx_value
    End Property

    Property Let write_indck_mode_en_rx(aData)
        set_indck_mode_en_rx = aData
        write
    End Property

    Property Get get_combo_mode_en_rx
        get_combo_mode_en_rx = read_combo_mode_en_rx_value
    End Property

    Property Let set_combo_mode_en_rx(aData)
        write_combo_mode_en_rx_value = aData
        flag_combo_mode_en_rx        = &H1
    End Property

    Property Get read_combo_mode_en_rx
        read
        read_combo_mode_en_rx = read_combo_mode_en_rx_value
    End Property

    Property Let write_combo_mode_en_rx(aData)
        set_combo_mode_en_rx = aData
        write
    End Property

    Property Get get_cl36_pcs_en_rx
        get_cl36_pcs_en_rx = read_cl36_pcs_en_rx_value
    End Property

    Property Let set_cl36_pcs_en_rx(aData)
        write_cl36_pcs_en_rx_value = aData
        flag_cl36_pcs_en_rx        = &H1
    End Property

    Property Get read_cl36_pcs_en_rx
        read
        read_cl36_pcs_en_rx = read_cl36_pcs_en_rx_value
    End Property

    Property Let write_cl36_pcs_en_rx(aData)
        set_cl36_pcs_en_rx = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_pf_ctrl_value = rightShift(data_low, 12) and &Hf
        read_rxSeqRestart_SM_value = rightShift(data_low, 11) and &H1
        read_ROV_value = rightShift(data_low, 10) and &H1
        read_rxSigdetPwrdn_override_value = rightShift(data_low, 9) and &H1
        read_sigDetected_en_SM_value = rightShift(data_low, 8) and &H1
        read_sigdetRestart_en_SM_value = rightShift(data_low, 7) and &H1
        read_sigdetMonitor_en_SM_value = rightShift(data_low, 6) and &H1
        read_rxSeqDone_cya_value = rightShift(data_low, 5) and &H1
        read_spd_rstb_dis_SM_value = rightShift(data_low, 4) and &H1
        read_rtbi_mode_value = rightShift(data_low, 3) and &H1
        read_indck_mode_en_rx_value = rightShift(data_low, 2) and &H1
        read_combo_mode_en_rx_value = rightShift(data_low, 1) and &H1
        cl36_pcs_en_rx_mask = &H1
        if data_low > LONG_MAX then
            if cl36_pcs_en_rx_mask = mask then
                read_cl36_pcs_en_rx_value = data_low
            else
                read_cl36_pcs_en_rx_value = (data_low - H8000_0000) and cl36_pcs_en_rx_mask
            end If
        else
            read_cl36_pcs_en_rx_value = data_low and cl36_pcs_en_rx_mask
        end If

    End Sub

    Sub write
        If flag_rx_pf_ctrl = &H0 or flag_rxSeqRestart_SM = &H0 or flag_ROV = &H0 or flag_rxSigdetPwrdn_override = &H0 or flag_sigDetected_en_SM = &H0 or flag_sigdetRestart_en_SM = &H0 or flag_sigdetMonitor_en_SM = &H0 or flag_rxSeqDone_cya = &H0 or flag_spd_rstb_dis_SM = &H0 or flag_rtbi_mode = &H0 or flag_indck_mode_en_rx = &H0 or flag_combo_mode_en_rx = &H0 or flag_cl36_pcs_en_rx = &H0 Then read
        If flag_rx_pf_ctrl = &H0 Then write_rx_pf_ctrl_value = get_rx_pf_ctrl
        If flag_rxSeqRestart_SM = &H0 Then write_rxSeqRestart_SM_value = get_rxSeqRestart_SM
        If flag_ROV = &H0 Then write_ROV_value = get_ROV
        If flag_rxSigdetPwrdn_override = &H0 Then write_rxSigdetPwrdn_override_value = get_rxSigdetPwrdn_override
        If flag_sigDetected_en_SM = &H0 Then write_sigDetected_en_SM_value = get_sigDetected_en_SM
        If flag_sigdetRestart_en_SM = &H0 Then write_sigdetRestart_en_SM_value = get_sigdetRestart_en_SM
        If flag_sigdetMonitor_en_SM = &H0 Then write_sigdetMonitor_en_SM_value = get_sigdetMonitor_en_SM
        If flag_rxSeqDone_cya = &H0 Then write_rxSeqDone_cya_value = get_rxSeqDone_cya
        If flag_spd_rstb_dis_SM = &H0 Then write_spd_rstb_dis_SM_value = get_spd_rstb_dis_SM
        If flag_rtbi_mode = &H0 Then write_rtbi_mode_value = get_rtbi_mode
        If flag_indck_mode_en_rx = &H0 Then write_indck_mode_en_rx_value = get_indck_mode_en_rx
        If flag_combo_mode_en_rx = &H0 Then write_combo_mode_en_rx_value = get_combo_mode_en_rx
        If flag_cl36_pcs_en_rx = &H0 Then write_cl36_pcs_en_rx_value = get_cl36_pcs_en_rx

        regValue = leftShift((write_rx_pf_ctrl_value and &Hf), 12) + leftShift((write_rxSeqRestart_SM_value and &H1), 11) + leftShift((write_ROV_value and &H1), 10) + leftShift((write_rxSigdetPwrdn_override_value and &H1), 9) + leftShift((write_sigDetected_en_SM_value and &H1), 8) + leftShift((write_sigdetRestart_en_SM_value and &H1), 7) + leftShift((write_sigdetMonitor_en_SM_value and &H1), 6) + leftShift((write_rxSeqDone_cya_value and &H1), 5) + leftShift((write_spd_rstb_dis_SM_value and &H1), 4) + leftShift((write_rtbi_mode_value and &H1), 3) + leftShift((write_indck_mode_en_rx_value and &H1), 2) + leftShift((write_combo_mode_en_rx_value and &H1), 1) + leftShift((write_cl36_pcs_en_rx_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_pf_ctrl_value = rightShift(data_low, 12) and &Hf
        read_rxSeqRestart_SM_value = rightShift(data_low, 11) and &H1
        read_ROV_value = rightShift(data_low, 10) and &H1
        read_rxSigdetPwrdn_override_value = rightShift(data_low, 9) and &H1
        read_sigDetected_en_SM_value = rightShift(data_low, 8) and &H1
        read_sigdetRestart_en_SM_value = rightShift(data_low, 7) and &H1
        read_sigdetMonitor_en_SM_value = rightShift(data_low, 6) and &H1
        read_rxSeqDone_cya_value = rightShift(data_low, 5) and &H1
        read_spd_rstb_dis_SM_value = rightShift(data_low, 4) and &H1
        read_rtbi_mode_value = rightShift(data_low, 3) and &H1
        read_indck_mode_en_rx_value = rightShift(data_low, 2) and &H1
        read_combo_mode_en_rx_value = rightShift(data_low, 1) and &H1
        cl36_pcs_en_rx_mask = &H1
        if data_low > LONG_MAX then
            if cl36_pcs_en_rx_mask = mask then
                read_cl36_pcs_en_rx_value = data_low
            else
                read_cl36_pcs_en_rx_value = (data_low - H8000_0000) and cl36_pcs_en_rx_mask
            end If
        else
            read_cl36_pcs_en_rx_value = data_low and cl36_pcs_en_rx_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_pf_ctrl_value = &H0
        flag_rx_pf_ctrl        = &H0
        write_rxSeqRestart_SM_value = &H0
        flag_rxSeqRestart_SM        = &H0
        write_ROV_value = &H0
        flag_ROV        = &H0
        write_rxSigdetPwrdn_override_value = &H0
        flag_rxSigdetPwrdn_override        = &H0
        write_sigDetected_en_SM_value = &H0
        flag_sigDetected_en_SM        = &H0
        write_sigdetRestart_en_SM_value = &H0
        flag_sigdetRestart_en_SM        = &H0
        write_sigdetMonitor_en_SM_value = &H0
        flag_sigdetMonitor_en_SM        = &H0
        write_rxSeqDone_cya_value = &H0
        flag_rxSeqDone_cya        = &H0
        write_spd_rstb_dis_SM_value = &H0
        flag_spd_rstb_dis_SM        = &H0
        write_rtbi_mode_value = &H0
        flag_rtbi_mode        = &H0
        write_indck_mode_en_rx_value = &H0
        flag_indck_mode_en_rx        = &H0
        write_combo_mode_en_rx_value = &H0
        flag_combo_mode_en_rx        = &H0
        write_cl36_pcs_en_rx_value = &H0
        flag_cl36_pcs_en_rx        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sigdet_mux_SM                              [15:12]          get_sigdet_mux_SM
''                                                             set_sigdet_mux_SM
''                                                             read_sigdet_mux_SM
''                                                             write_sigdet_mux_SM
''---------------------------------------------------------------------------------
'' tpctrl_SM                                  [8:4]            get_tpctrl_SM
''                                                             set_tpctrl_SM
''                                                             read_tpctrl_SM
''                                                             write_tpctrl_SM
''---------------------------------------------------------------------------------
'' testMuxSelect_SM                           [3:0]            get_testMuxSelect_SM
''                                                             set_testMuxSelect_SM
''                                                             read_testMuxSelect_SM
''                                                             write_testMuxSelect_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control2
    Private write_sigdet_mux_SM_value
    Private read_sigdet_mux_SM_value
    Private flag_sigdet_mux_SM
    Private write_tpctrl_SM_value
    Private read_tpctrl_SM_value
    Private flag_tpctrl_SM
    Private write_testMuxSelect_SM_value
    Private read_testMuxSelect_SM_value
    Private flag_testMuxSelect_SM

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

    Property Get get_sigdet_mux_SM
        get_sigdet_mux_SM = read_sigdet_mux_SM_value
    End Property

    Property Let set_sigdet_mux_SM(aData)
        write_sigdet_mux_SM_value = aData
        flag_sigdet_mux_SM        = &H1
    End Property

    Property Get read_sigdet_mux_SM
        read
        read_sigdet_mux_SM = read_sigdet_mux_SM_value
    End Property

    Property Let write_sigdet_mux_SM(aData)
        set_sigdet_mux_SM = aData
        write
    End Property

    Property Get get_tpctrl_SM
        get_tpctrl_SM = read_tpctrl_SM_value
    End Property

    Property Let set_tpctrl_SM(aData)
        write_tpctrl_SM_value = aData
        flag_tpctrl_SM        = &H1
    End Property

    Property Get read_tpctrl_SM
        read
        read_tpctrl_SM = read_tpctrl_SM_value
    End Property

    Property Let write_tpctrl_SM(aData)
        set_tpctrl_SM = aData
        write
    End Property

    Property Get get_testMuxSelect_SM
        get_testMuxSelect_SM = read_testMuxSelect_SM_value
    End Property

    Property Let set_testMuxSelect_SM(aData)
        write_testMuxSelect_SM_value = aData
        flag_testMuxSelect_SM        = &H1
    End Property

    Property Get read_testMuxSelect_SM
        read
        read_testMuxSelect_SM = read_testMuxSelect_SM_value
    End Property

    Property Let write_testMuxSelect_SM(aData)
        set_testMuxSelect_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdet_mux_SM_value = rightShift(data_low, 12) and &Hf
        read_tpctrl_SM_value = rightShift(data_low, 4) and &H1f
        testMuxSelect_SM_mask = &Hf
        if data_low > LONG_MAX then
            if testMuxSelect_SM_mask = mask then
                read_testMuxSelect_SM_value = data_low
            else
                read_testMuxSelect_SM_value = (data_low - H8000_0000) and testMuxSelect_SM_mask
            end If
        else
            read_testMuxSelect_SM_value = data_low and testMuxSelect_SM_mask
        end If

    End Sub

    Sub write
        If flag_sigdet_mux_SM = &H0 or flag_tpctrl_SM = &H0 or flag_testMuxSelect_SM = &H0 Then read
        If flag_sigdet_mux_SM = &H0 Then write_sigdet_mux_SM_value = get_sigdet_mux_SM
        If flag_tpctrl_SM = &H0 Then write_tpctrl_SM_value = get_tpctrl_SM
        If flag_testMuxSelect_SM = &H0 Then write_testMuxSelect_SM_value = get_testMuxSelect_SM

        regValue = leftShift((write_sigdet_mux_SM_value and &Hf), 12) + leftShift((write_tpctrl_SM_value and &H1f), 4) + leftShift((write_testMuxSelect_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sigdet_mux_SM_value = rightShift(data_low, 12) and &Hf
        read_tpctrl_SM_value = rightShift(data_low, 4) and &H1f
        testMuxSelect_SM_mask = &Hf
        if data_low > LONG_MAX then
            if testMuxSelect_SM_mask = mask then
                read_testMuxSelect_SM_value = data_low
            else
                read_testMuxSelect_SM_value = (data_low - H8000_0000) and testMuxSelect_SM_mask
            end If
        else
            read_testMuxSelect_SM_value = data_low and testMuxSelect_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sigdet_mux_SM_value = &H0
        flag_sigdet_mux_SM        = &H0
        write_tpctrl_SM_value = &H0
        flag_tpctrl_SM        = &H0
        write_testMuxSelect_SM_value = &H0
        flag_testMuxSelect_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' invert_rx_sigdet                           [5:5]            get_invert_rx_sigdet
''                                                             set_invert_rx_sigdet
''                                                             read_invert_rx_sigdet
''                                                             write_invert_rx_sigdet
''---------------------------------------------------------------------------------
'' cx4_sigdet_cnt_ld_SM                       [4:4]            get_cx4_sigdet_cnt_ld_SM
''                                                             set_cx4_sigdet_cnt_ld_SM
''                                                             read_cx4_sigdet_cnt_ld_SM
''                                                             write_cx4_sigdet_cnt_ld_SM
''---------------------------------------------------------------------------------
'' cx4_sigdet_en_SM                           [3:3]            get_cx4_sigdet_en_SM
''                                                             set_cx4_sigdet_en_SM
''                                                             read_cx4_sigdet_en_SM
''                                                             write_cx4_sigdet_en_SM
''---------------------------------------------------------------------------------
'' ext_sigdet_en_SM                           [2:2]            get_ext_sigdet_en_SM
''                                                             set_ext_sigdet_en_SM
''                                                             read_ext_sigdet_en_SM
''                                                             write_ext_sigdet_en_SM
''---------------------------------------------------------------------------------
'' override_sigdet_en_SM                      [1:1]            get_override_sigdet_en_SM
''                                                             set_override_sigdet_en_SM
''                                                             read_override_sigdet_en_SM
''                                                             write_override_sigdet_en_SM
''---------------------------------------------------------------------------------
'' OSVS                                       [0:0]            get_OSVS
''                                                             set_OSVS
''                                                             read_OSVS
''                                                             write_OSVS
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_ctrl0
    Private write_invert_rx_sigdet_value
    Private read_invert_rx_sigdet_value
    Private flag_invert_rx_sigdet
    Private write_cx4_sigdet_cnt_ld_SM_value
    Private read_cx4_sigdet_cnt_ld_SM_value
    Private flag_cx4_sigdet_cnt_ld_SM
    Private write_cx4_sigdet_en_SM_value
    Private read_cx4_sigdet_en_SM_value
    Private flag_cx4_sigdet_en_SM
    Private write_ext_sigdet_en_SM_value
    Private read_ext_sigdet_en_SM_value
    Private flag_ext_sigdet_en_SM
    Private write_override_sigdet_en_SM_value
    Private read_override_sigdet_en_SM_value
    Private flag_override_sigdet_en_SM
    Private write_OSVS_value
    Private read_OSVS_value
    Private flag_OSVS

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

    Property Get get_invert_rx_sigdet
        get_invert_rx_sigdet = read_invert_rx_sigdet_value
    End Property

    Property Let set_invert_rx_sigdet(aData)
        write_invert_rx_sigdet_value = aData
        flag_invert_rx_sigdet        = &H1
    End Property

    Property Get read_invert_rx_sigdet
        read
        read_invert_rx_sigdet = read_invert_rx_sigdet_value
    End Property

    Property Let write_invert_rx_sigdet(aData)
        set_invert_rx_sigdet = aData
        write
    End Property

    Property Get get_cx4_sigdet_cnt_ld_SM
        get_cx4_sigdet_cnt_ld_SM = read_cx4_sigdet_cnt_ld_SM_value
    End Property

    Property Let set_cx4_sigdet_cnt_ld_SM(aData)
        write_cx4_sigdet_cnt_ld_SM_value = aData
        flag_cx4_sigdet_cnt_ld_SM        = &H1
    End Property

    Property Get read_cx4_sigdet_cnt_ld_SM
        read
        read_cx4_sigdet_cnt_ld_SM = read_cx4_sigdet_cnt_ld_SM_value
    End Property

    Property Let write_cx4_sigdet_cnt_ld_SM(aData)
        set_cx4_sigdet_cnt_ld_SM = aData
        write
    End Property

    Property Get get_cx4_sigdet_en_SM
        get_cx4_sigdet_en_SM = read_cx4_sigdet_en_SM_value
    End Property

    Property Let set_cx4_sigdet_en_SM(aData)
        write_cx4_sigdet_en_SM_value = aData
        flag_cx4_sigdet_en_SM        = &H1
    End Property

    Property Get read_cx4_sigdet_en_SM
        read
        read_cx4_sigdet_en_SM = read_cx4_sigdet_en_SM_value
    End Property

    Property Let write_cx4_sigdet_en_SM(aData)
        set_cx4_sigdet_en_SM = aData
        write
    End Property

    Property Get get_ext_sigdet_en_SM
        get_ext_sigdet_en_SM = read_ext_sigdet_en_SM_value
    End Property

    Property Let set_ext_sigdet_en_SM(aData)
        write_ext_sigdet_en_SM_value = aData
        flag_ext_sigdet_en_SM        = &H1
    End Property

    Property Get read_ext_sigdet_en_SM
        read
        read_ext_sigdet_en_SM = read_ext_sigdet_en_SM_value
    End Property

    Property Let write_ext_sigdet_en_SM(aData)
        set_ext_sigdet_en_SM = aData
        write
    End Property

    Property Get get_override_sigdet_en_SM
        get_override_sigdet_en_SM = read_override_sigdet_en_SM_value
    End Property

    Property Let set_override_sigdet_en_SM(aData)
        write_override_sigdet_en_SM_value = aData
        flag_override_sigdet_en_SM        = &H1
    End Property

    Property Get read_override_sigdet_en_SM
        read
        read_override_sigdet_en_SM = read_override_sigdet_en_SM_value
    End Property

    Property Let write_override_sigdet_en_SM(aData)
        set_override_sigdet_en_SM = aData
        write
    End Property

    Property Get get_OSVS
        get_OSVS = read_OSVS_value
    End Property

    Property Let set_OSVS(aData)
        write_OSVS_value = aData
        flag_OSVS        = &H1
    End Property

    Property Get read_OSVS
        read
        read_OSVS = read_OSVS_value
    End Property

    Property Let write_OSVS(aData)
        set_OSVS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_invert_rx_sigdet_value = rightShift(data_low, 5) and &H1
        read_cx4_sigdet_cnt_ld_SM_value = rightShift(data_low, 4) and &H1
        read_cx4_sigdet_en_SM_value = rightShift(data_low, 3) and &H1
        read_ext_sigdet_en_SM_value = rightShift(data_low, 2) and &H1
        read_override_sigdet_en_SM_value = rightShift(data_low, 1) and &H1
        OSVS_mask = &H1
        if data_low > LONG_MAX then
            if OSVS_mask = mask then
                read_OSVS_value = data_low
            else
                read_OSVS_value = (data_low - H8000_0000) and OSVS_mask
            end If
        else
            read_OSVS_value = data_low and OSVS_mask
        end If

    End Sub

    Sub write
        If flag_invert_rx_sigdet = &H0 or flag_cx4_sigdet_cnt_ld_SM = &H0 or flag_cx4_sigdet_en_SM = &H0 or flag_ext_sigdet_en_SM = &H0 or flag_override_sigdet_en_SM = &H0 or flag_OSVS = &H0 Then read
        If flag_invert_rx_sigdet = &H0 Then write_invert_rx_sigdet_value = get_invert_rx_sigdet
        If flag_cx4_sigdet_cnt_ld_SM = &H0 Then write_cx4_sigdet_cnt_ld_SM_value = get_cx4_sigdet_cnt_ld_SM
        If flag_cx4_sigdet_en_SM = &H0 Then write_cx4_sigdet_en_SM_value = get_cx4_sigdet_en_SM
        If flag_ext_sigdet_en_SM = &H0 Then write_ext_sigdet_en_SM_value = get_ext_sigdet_en_SM
        If flag_override_sigdet_en_SM = &H0 Then write_override_sigdet_en_SM_value = get_override_sigdet_en_SM
        If flag_OSVS = &H0 Then write_OSVS_value = get_OSVS

        regValue = leftShift((write_invert_rx_sigdet_value and &H1), 5) + leftShift((write_cx4_sigdet_cnt_ld_SM_value and &H1), 4) + leftShift((write_cx4_sigdet_en_SM_value and &H1), 3) + leftShift((write_ext_sigdet_en_SM_value and &H1), 2) + leftShift((write_override_sigdet_en_SM_value and &H1), 1) + leftShift((write_OSVS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_invert_rx_sigdet_value = rightShift(data_low, 5) and &H1
        read_cx4_sigdet_cnt_ld_SM_value = rightShift(data_low, 4) and &H1
        read_cx4_sigdet_en_SM_value = rightShift(data_low, 3) and &H1
        read_ext_sigdet_en_SM_value = rightShift(data_low, 2) and &H1
        read_override_sigdet_en_SM_value = rightShift(data_low, 1) and &H1
        OSVS_mask = &H1
        if data_low > LONG_MAX then
            if OSVS_mask = mask then
                read_OSVS_value = data_low
            else
                read_OSVS_value = (data_low - H8000_0000) and OSVS_mask
            end If
        else
            read_OSVS_value = data_low and OSVS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_invert_rx_sigdet_value = &H0
        flag_invert_rx_sigdet        = &H0
        write_cx4_sigdet_cnt_ld_SM_value = &H0
        flag_cx4_sigdet_cnt_ld_SM        = &H0
        write_cx4_sigdet_en_SM_value = &H0
        flag_cx4_sigdet_en_SM        = &H0
        write_ext_sigdet_en_SM_value = &H0
        flag_ext_sigdet_en_SM        = &H0
        write_override_sigdet_en_SM_value = &H0
        flag_override_sigdet_en_SM        = &H0
        write_OSVS_value = &H0
        flag_OSVS        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cx4_sigdet_cnt                             [15:0]           get_cx4_sigdet_cnt
''                                                             set_cx4_sigdet_cnt
''                                                             read_cx4_sigdet_cnt
''                                                             write_cx4_sigdet_cnt
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_ctrl1
    Private write_cx4_sigdet_cnt_value
    Private read_cx4_sigdet_cnt_value
    Private flag_cx4_sigdet_cnt

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

    Property Get get_cx4_sigdet_cnt
        get_cx4_sigdet_cnt = read_cx4_sigdet_cnt_value
    End Property

    Property Let set_cx4_sigdet_cnt(aData)
        write_cx4_sigdet_cnt_value = aData
        flag_cx4_sigdet_cnt        = &H1
    End Property

    Property Get read_cx4_sigdet_cnt
        read
        read_cx4_sigdet_cnt = read_cx4_sigdet_cnt_value
    End Property

    Property Let write_cx4_sigdet_cnt(aData)
        set_cx4_sigdet_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cx4_sigdet_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if cx4_sigdet_cnt_mask = mask then
                read_cx4_sigdet_cnt_value = data_low
            else
                read_cx4_sigdet_cnt_value = (data_low - H8000_0000) and cx4_sigdet_cnt_mask
            end If
        else
            read_cx4_sigdet_cnt_value = data_low and cx4_sigdet_cnt_mask
        end If

    End Sub

    Sub write
        If flag_cx4_sigdet_cnt = &H0 Then read
        If flag_cx4_sigdet_cnt = &H0 Then write_cx4_sigdet_cnt_value = get_cx4_sigdet_cnt

        regValue = leftShift((write_cx4_sigdet_cnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cx4_sigdet_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if cx4_sigdet_cnt_mask = mask then
                read_cx4_sigdet_cnt_value = data_low
            else
                read_cx4_sigdet_cnt_value = (data_low - H8000_0000) and cx4_sigdet_cnt_mask
            end If
        else
            read_cx4_sigdet_cnt_value = data_low and cx4_sigdet_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cx4_sigdet_cnt_value = &H0
        flag_cx4_sigdet_cnt        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_os_mode_muxval                          [5:2]            get_rx_os_mode_muxval
''                                                             set_rx_os_mode_muxval
''                                                             read_rx_os_mode_muxval
''                                                             write_rx_os_mode_muxval
''---------------------------------------------------------------------------------
'' os_1x_mode                                 [1:1]            get_os_1x_mode
''                                                             set_os_1x_mode
''                                                             read_os_1x_mode
''                                                             write_os_1x_mode
''---------------------------------------------------------------------------------
'' pmd_sigdet_status                          [0:0]            get_pmd_sigdet_status
''                                                             set_pmd_sigdet_status
''                                                             read_pmd_sigdet_status
''                                                             write_pmd_sigdet_status
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_status
    Private write_rx_os_mode_muxval_value
    Private read_rx_os_mode_muxval_value
    Private flag_rx_os_mode_muxval
    Private write_os_1x_mode_value
    Private read_os_1x_mode_value
    Private flag_os_1x_mode
    Private write_pmd_sigdet_status_value
    Private read_pmd_sigdet_status_value
    Private flag_pmd_sigdet_status

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

    Property Get get_rx_os_mode_muxval
        get_rx_os_mode_muxval = read_rx_os_mode_muxval_value
    End Property

    Property Let set_rx_os_mode_muxval(aData)
        write_rx_os_mode_muxval_value = aData
        flag_rx_os_mode_muxval        = &H1
    End Property

    Property Get read_rx_os_mode_muxval
        read
        read_rx_os_mode_muxval = read_rx_os_mode_muxval_value
    End Property

    Property Let write_rx_os_mode_muxval(aData)
        set_rx_os_mode_muxval = aData
        write
    End Property

    Property Get get_os_1x_mode
        get_os_1x_mode = read_os_1x_mode_value
    End Property

    Property Let set_os_1x_mode(aData)
        write_os_1x_mode_value = aData
        flag_os_1x_mode        = &H1
    End Property

    Property Get read_os_1x_mode
        read
        read_os_1x_mode = read_os_1x_mode_value
    End Property

    Property Let write_os_1x_mode(aData)
        set_os_1x_mode = aData
        write
    End Property

    Property Get get_pmd_sigdet_status
        get_pmd_sigdet_status = read_pmd_sigdet_status_value
    End Property

    Property Let set_pmd_sigdet_status(aData)
        write_pmd_sigdet_status_value = aData
        flag_pmd_sigdet_status        = &H1
    End Property

    Property Get read_pmd_sigdet_status
        read
        read_pmd_sigdet_status = read_pmd_sigdet_status_value
    End Property

    Property Let write_pmd_sigdet_status(aData)
        set_pmd_sigdet_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_os_mode_muxval_value = rightShift(data_low, 2) and &Hf
        read_os_1x_mode_value = rightShift(data_low, 1) and &H1
        pmd_sigdet_status_mask = &H1
        if data_low > LONG_MAX then
            if pmd_sigdet_status_mask = mask then
                read_pmd_sigdet_status_value = data_low
            else
                read_pmd_sigdet_status_value = (data_low - H8000_0000) and pmd_sigdet_status_mask
            end If
        else
            read_pmd_sigdet_status_value = data_low and pmd_sigdet_status_mask
        end If

    End Sub

    Sub write
        If flag_rx_os_mode_muxval = &H0 or flag_os_1x_mode = &H0 or flag_pmd_sigdet_status = &H0 Then read
        If flag_rx_os_mode_muxval = &H0 Then write_rx_os_mode_muxval_value = get_rx_os_mode_muxval
        If flag_os_1x_mode = &H0 Then write_os_1x_mode_value = get_os_1x_mode
        If flag_pmd_sigdet_status = &H0 Then write_pmd_sigdet_status_value = get_pmd_sigdet_status

        regValue = leftShift((write_rx_os_mode_muxval_value and &Hf), 2) + leftShift((write_os_1x_mode_value and &H1), 1) + leftShift((write_pmd_sigdet_status_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_os_mode_muxval_value = rightShift(data_low, 2) and &Hf
        read_os_1x_mode_value = rightShift(data_low, 1) and &H1
        pmd_sigdet_status_mask = &H1
        if data_low > LONG_MAX then
            if pmd_sigdet_status_mask = mask then
                read_pmd_sigdet_status_value = data_low
            else
                read_pmd_sigdet_status_value = (data_low - H8000_0000) and pmd_sigdet_status_mask
            end If
        else
            read_pmd_sigdet_status_value = data_low and pmd_sigdet_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_os_mode_muxval_value = &H0
        flag_rx_os_mode_muxval        = &H0
        write_os_1x_mode_value = &H0
        flag_os_1x_mode        = &H0
        write_pmd_sigdet_status_value = &H0
        flag_pmd_sigdet_status        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' O1MOV                                      [6:6]            get_O1MOV
''                                                             set_O1MOV
''                                                             read_O1MOV
''                                                             write_O1MOV
''---------------------------------------------------------------------------------
'' os_1x_mode_override                        [5:5]            get_os_1x_mode_override
''                                                             set_os_1x_mode_override
''                                                             read_os_1x_mode_override
''                                                             write_os_1x_mode_override
''---------------------------------------------------------------------------------
'' OMRPO                                      [4:4]            get_OMRPO
''                                                             set_OMRPO
''                                                             read_OMRPO
''                                                             write_OMRPO
''---------------------------------------------------------------------------------
'' os_mode_rx_pmd                             [3:0]            get_os_mode_rx_pmd
''                                                             set_os_mode_rx_pmd
''                                                             read_os_mode_rx_pmd
''                                                             write_os_mode_rx_pmd
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control3
    Private write_O1MOV_value
    Private read_O1MOV_value
    Private flag_O1MOV
    Private write_os_1x_mode_override_value
    Private read_os_1x_mode_override_value
    Private flag_os_1x_mode_override
    Private write_OMRPO_value
    Private read_OMRPO_value
    Private flag_OMRPO
    Private write_os_mode_rx_pmd_value
    Private read_os_mode_rx_pmd_value
    Private flag_os_mode_rx_pmd

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

    Property Get get_O1MOV
        get_O1MOV = read_O1MOV_value
    End Property

    Property Let set_O1MOV(aData)
        write_O1MOV_value = aData
        flag_O1MOV        = &H1
    End Property

    Property Get read_O1MOV
        read
        read_O1MOV = read_O1MOV_value
    End Property

    Property Let write_O1MOV(aData)
        set_O1MOV = aData
        write
    End Property

    Property Get get_os_1x_mode_override
        get_os_1x_mode_override = read_os_1x_mode_override_value
    End Property

    Property Let set_os_1x_mode_override(aData)
        write_os_1x_mode_override_value = aData
        flag_os_1x_mode_override        = &H1
    End Property

    Property Get read_os_1x_mode_override
        read
        read_os_1x_mode_override = read_os_1x_mode_override_value
    End Property

    Property Let write_os_1x_mode_override(aData)
        set_os_1x_mode_override = aData
        write
    End Property

    Property Get get_OMRPO
        get_OMRPO = read_OMRPO_value
    End Property

    Property Let set_OMRPO(aData)
        write_OMRPO_value = aData
        flag_OMRPO        = &H1
    End Property

    Property Get read_OMRPO
        read
        read_OMRPO = read_OMRPO_value
    End Property

    Property Let write_OMRPO(aData)
        set_OMRPO = aData
        write
    End Property

    Property Get get_os_mode_rx_pmd
        get_os_mode_rx_pmd = read_os_mode_rx_pmd_value
    End Property

    Property Let set_os_mode_rx_pmd(aData)
        write_os_mode_rx_pmd_value = aData
        flag_os_mode_rx_pmd        = &H1
    End Property

    Property Get read_os_mode_rx_pmd
        read
        read_os_mode_rx_pmd = read_os_mode_rx_pmd_value
    End Property

    Property Let write_os_mode_rx_pmd(aData)
        set_os_mode_rx_pmd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_O1MOV_value = rightShift(data_low, 6) and &H1
        read_os_1x_mode_override_value = rightShift(data_low, 5) and &H1
        read_OMRPO_value = rightShift(data_low, 4) and &H1
        os_mode_rx_pmd_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_rx_pmd_mask = mask then
                read_os_mode_rx_pmd_value = data_low
            else
                read_os_mode_rx_pmd_value = (data_low - H8000_0000) and os_mode_rx_pmd_mask
            end If
        else
            read_os_mode_rx_pmd_value = data_low and os_mode_rx_pmd_mask
        end If

    End Sub

    Sub write
        If flag_O1MOV = &H0 or flag_os_1x_mode_override = &H0 or flag_OMRPO = &H0 or flag_os_mode_rx_pmd = &H0 Then read
        If flag_O1MOV = &H0 Then write_O1MOV_value = get_O1MOV
        If flag_os_1x_mode_override = &H0 Then write_os_1x_mode_override_value = get_os_1x_mode_override
        If flag_OMRPO = &H0 Then write_OMRPO_value = get_OMRPO
        If flag_os_mode_rx_pmd = &H0 Then write_os_mode_rx_pmd_value = get_os_mode_rx_pmd

        regValue = leftShift((write_O1MOV_value and &H1), 6) + leftShift((write_os_1x_mode_override_value and &H1), 5) + leftShift((write_OMRPO_value and &H1), 4) + leftShift((write_os_mode_rx_pmd_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_O1MOV_value = rightShift(data_low, 6) and &H1
        read_os_1x_mode_override_value = rightShift(data_low, 5) and &H1
        read_OMRPO_value = rightShift(data_low, 4) and &H1
        os_mode_rx_pmd_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_rx_pmd_mask = mask then
                read_os_mode_rx_pmd_value = data_low
            else
                read_os_mode_rx_pmd_value = (data_low - H8000_0000) and os_mode_rx_pmd_mask
            end If
        else
            read_os_mode_rx_pmd_value = data_low and os_mode_rx_pmd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_O1MOV_value = &H0
        flag_O1MOV        = &H0
        write_os_1x_mode_override_value = &H0
        flag_os_1x_mode_override        = &H0
        write_OMRPO_value = &H0
        flag_OMRPO        = &H0
        write_os_mode_rx_pmd_value = &H0
        flag_os_mode_rx_pmd        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_blockaddress
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

Class RX_PMD_TEST__SGMIIPLUS2_X2_INSTANCE

    Public rxpmd_test_control
    Public rxpmd_test_status
    Public rxpmd_control0
    Public rxpmd_control1
    Public rxpmd_control2
    Public rxpmd_sigdet_ctrl0
    Public rxpmd_sigdet_ctrl1
    Public rxpmd_sigdet_status
    Public rxpmd_control3
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set rxpmd_test_control = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_test_control)(aBaseAddr, 16)
        Set rxpmd_test_status = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_test_status)(aBaseAddr, 16)
        Set rxpmd_control0 = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control0)(aBaseAddr, 16)
        Set rxpmd_control1 = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control1)(aBaseAddr, 16)
        Set rxpmd_control2 = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control2)(aBaseAddr, 16)
        Set rxpmd_sigdet_ctrl0 = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_ctrl0)(aBaseAddr, 16)
        Set rxpmd_sigdet_ctrl1 = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_ctrl1)(aBaseAddr, 16)
        Set rxpmd_sigdet_status = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_sigdet_status)(aBaseAddr, 16)
        Set rxpmd_control3 = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_rxpmd_control3)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_PMD_TEST__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_PMD_TEST__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
RX_PMD_TEST__SGMIIPLUS2_X2.Add ((New RX_PMD_TEST__SGMIIPLUS2_X2_INSTANCE)(&H4ac50c40))
RX_PMD_TEST__SGMIIPLUS2_X2.Add ((New RX_PMD_TEST__SGMIIPLUS2_X2_INSTANCE)(&H4ac70c40))


