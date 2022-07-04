

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


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_test_control
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
'' PRBS_ORDE                                  [2:0]            get_PRBS_ORDE
''                                                             set_PRBS_ORDE
''                                                             read_PRBS_ORDE
''                                                             write_PRBS_ORDE
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_test_control
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
    Private write_PRBS_ORDE_value
    Private read_PRBS_ORDE_value
    Private flag_PRBS_ORDE

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

    Property Get get_PRBS_ORDE
        get_PRBS_ORDE = read_PRBS_ORDE_value
    End Property

    Property Let set_PRBS_ORDE(aData)
        write_PRBS_ORDE_value = aData
        flag_PRBS_ORDE        = &H1
    End Property

    Property Get read_PRBS_ORDE
        read
        read_PRBS_ORDE = read_PRBS_ORDE_value
    End Property

    Property Let write_PRBS_ORDE(aData)
        set_PRBS_ORDE = aData
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
        PRBS_ORDE_mask = &H7
        if data_low > LONG_MAX then
            if PRBS_ORDE_mask = mask then
                read_PRBS_ORDE_value = data_low
            else
                read_PRBS_ORDE_value = (data_low - H8000_0000) and PRBS_ORDE_mask
            end If
        else
            read_PRBS_ORDE_value = data_low and PRBS_ORDE_mask
        end If

    End Sub

    Sub write
        If flag_fpat_md = &H0 or flag_prbs_clr_dis = &H0 or flag_Emon_en = &H0 or flag_prbsmon_en = &H0 or flag_prbsmon_inv = &H0 or flag_PRBS_ORDE = &H0 Then read
        If flag_fpat_md = &H0 Then write_fpat_md_value = get_fpat_md
        If flag_prbs_clr_dis = &H0 Then write_prbs_clr_dis_value = get_prbs_clr_dis
        If flag_Emon_en = &H0 Then write_Emon_en_value = get_Emon_en
        If flag_prbsmon_en = &H0 Then write_prbsmon_en_value = get_prbsmon_en
        If flag_prbsmon_inv = &H0 Then write_prbsmon_inv_value = get_prbsmon_inv
        If flag_PRBS_ORDE = &H0 Then write_PRBS_ORDE_value = get_PRBS_ORDE

        regValue = leftShift((write_fpat_md_value and &H1), 15) + leftShift((write_prbs_clr_dis_value and &H1), 12) + leftShift((write_Emon_en_value and &H1), 9) + leftShift((write_prbsmon_en_value and &H1), 4) + leftShift((write_prbsmon_inv_value and &H1), 3) + leftShift((write_PRBS_ORDE_value and &H7), 0)
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
        PRBS_ORDE_mask = &H7
        if data_low > LONG_MAX then
            if PRBS_ORDE_mask = mask then
                read_PRBS_ORDE_value = data_low
            else
                read_PRBS_ORDE_value = (data_low - H8000_0000) and PRBS_ORDE_mask
            end If
        else
            read_PRBS_ORDE_value = data_low and PRBS_ORDE_mask
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
        write_PRBS_ORDE_value = &H0
        flag_PRBS_ORDE        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_test_status
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
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_test_status
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


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMD_RLOO                                   [15:15]          get_PMD_RLOO
''                                                             set_PMD_RLOO
''                                                             read_PMD_RLOO
''                                                             write_PMD_RLOO
''---------------------------------------------------------------------------------
'' PMD_GLOO                                   [14:14]          get_PMD_GLOO
''                                                             set_PMD_GLOO
''                                                             read_PMD_GLOO
''                                                             write_PMD_GLOO
''---------------------------------------------------------------------------------
'' RXPO_FLIP_SM                               [9:9]            get_RXPO_FLIP_SM
''                                                             set_RXPO_FLIP_SM
''                                                             read_RXPO_FLIP_SM
''                                                             write_RXPO_FLIP_SM
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
'' FSFS                                       [5:5]            get_FSFS
''                                                             set_FSFS
''                                                             read_FSFS
''                                                             write_FSFS
''---------------------------------------------------------------------------------
'' freq_sel_SM                                [4:4]            get_freq_sel_SM
''                                                             set_freq_sel_SM
''                                                             read_freq_sel_SM
''                                                             write_freq_sel_SM
''---------------------------------------------------------------------------------
'' RMGSF                                      [3:3]            get_RMGSF
''                                                             set_RMGSF
''                                                             read_RMGSF
''                                                             write_RMGSF
''---------------------------------------------------------------------------------
'' FORC_SM                                    [2:2]            get_FORC_SM
''                                                             set_FORC_SM
''                                                             read_FORC_SM
''                                                             write_FORC_SM
''---------------------------------------------------------------------------------
'' FEP                                        [1:1]            get_FEP
''                                                             set_FEP
''                                                             read_FEP
''                                                             write_FEP
''---------------------------------------------------------------------------------
'' CCD                                        [0:0]            get_CCD
''                                                             set_CCD
''                                                             read_CCD
''                                                             write_CCD
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control0
    Private write_PMD_RLOO_value
    Private read_PMD_RLOO_value
    Private flag_PMD_RLOO
    Private write_PMD_GLOO_value
    Private read_PMD_GLOO_value
    Private flag_PMD_GLOO
    Private write_RXPO_FLIP_SM_value
    Private read_RXPO_FLIP_SM_value
    Private flag_RXPO_FLIP_SM
    Private write_lock_ref_value
    Private read_lock_ref_value
    Private flag_lock_ref
    Private write_phase_sel_SM_value
    Private read_phase_sel_SM_value
    Private flag_phase_sel_SM
    Private write_freq_sel_value
    Private read_freq_sel_value
    Private flag_freq_sel
    Private write_FSFS_value
    Private read_FSFS_value
    Private flag_FSFS
    Private write_freq_sel_SM_value
    Private read_freq_sel_SM_value
    Private flag_freq_sel_SM
    Private write_RMGSF_value
    Private read_RMGSF_value
    Private flag_RMGSF
    Private write_FORC_SM_value
    Private read_FORC_SM_value
    Private flag_FORC_SM
    Private write_FEP_value
    Private read_FEP_value
    Private flag_FEP
    Private write_CCD_value
    Private read_CCD_value
    Private flag_CCD

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

    Property Get get_PMD_RLOO
        get_PMD_RLOO = read_PMD_RLOO_value
    End Property

    Property Let set_PMD_RLOO(aData)
        write_PMD_RLOO_value = aData
        flag_PMD_RLOO        = &H1
    End Property

    Property Get read_PMD_RLOO
        read
        read_PMD_RLOO = read_PMD_RLOO_value
    End Property

    Property Let write_PMD_RLOO(aData)
        set_PMD_RLOO = aData
        write
    End Property

    Property Get get_PMD_GLOO
        get_PMD_GLOO = read_PMD_GLOO_value
    End Property

    Property Let set_PMD_GLOO(aData)
        write_PMD_GLOO_value = aData
        flag_PMD_GLOO        = &H1
    End Property

    Property Get read_PMD_GLOO
        read
        read_PMD_GLOO = read_PMD_GLOO_value
    End Property

    Property Let write_PMD_GLOO(aData)
        set_PMD_GLOO = aData
        write
    End Property

    Property Get get_RXPO_FLIP_SM
        get_RXPO_FLIP_SM = read_RXPO_FLIP_SM_value
    End Property

    Property Let set_RXPO_FLIP_SM(aData)
        write_RXPO_FLIP_SM_value = aData
        flag_RXPO_FLIP_SM        = &H1
    End Property

    Property Get read_RXPO_FLIP_SM
        read
        read_RXPO_FLIP_SM = read_RXPO_FLIP_SM_value
    End Property

    Property Let write_RXPO_FLIP_SM(aData)
        set_RXPO_FLIP_SM = aData
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

    Property Get get_FSFS
        get_FSFS = read_FSFS_value
    End Property

    Property Let set_FSFS(aData)
        write_FSFS_value = aData
        flag_FSFS        = &H1
    End Property

    Property Get read_FSFS
        read
        read_FSFS = read_FSFS_value
    End Property

    Property Let write_FSFS(aData)
        set_FSFS = aData
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

    Property Get get_RMGSF
        get_RMGSF = read_RMGSF_value
    End Property

    Property Let set_RMGSF(aData)
        write_RMGSF_value = aData
        flag_RMGSF        = &H1
    End Property

    Property Get read_RMGSF
        read
        read_RMGSF = read_RMGSF_value
    End Property

    Property Let write_RMGSF(aData)
        set_RMGSF = aData
        write
    End Property

    Property Get get_FORC_SM
        get_FORC_SM = read_FORC_SM_value
    End Property

    Property Let set_FORC_SM(aData)
        write_FORC_SM_value = aData
        flag_FORC_SM        = &H1
    End Property

    Property Get read_FORC_SM
        read
        read_FORC_SM = read_FORC_SM_value
    End Property

    Property Let write_FORC_SM(aData)
        set_FORC_SM = aData
        write
    End Property

    Property Get get_FEP
        get_FEP = read_FEP_value
    End Property

    Property Let set_FEP(aData)
        write_FEP_value = aData
        flag_FEP        = &H1
    End Property

    Property Get read_FEP
        read
        read_FEP = read_FEP_value
    End Property

    Property Let write_FEP(aData)
        set_FEP = aData
        write
    End Property

    Property Get get_CCD
        get_CCD = read_CCD_value
    End Property

    Property Let set_CCD(aData)
        write_CCD_value = aData
        flag_CCD        = &H1
    End Property

    Property Get read_CCD
        read
        read_CCD = read_CCD_value
    End Property

    Property Let write_CCD(aData)
        set_CCD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_RLOO_value = rightShift(data_low, 15) and &H1
        read_PMD_GLOO_value = rightShift(data_low, 14) and &H1
        read_RXPO_FLIP_SM_value = rightShift(data_low, 9) and &H1
        read_lock_ref_value = rightShift(data_low, 8) and &H1
        read_phase_sel_SM_value = rightShift(data_low, 7) and &H1
        read_freq_sel_value = rightShift(data_low, 6) and &H1
        read_FSFS_value = rightShift(data_low, 5) and &H1
        read_freq_sel_SM_value = rightShift(data_low, 4) and &H1
        read_RMGSF_value = rightShift(data_low, 3) and &H1
        read_FORC_SM_value = rightShift(data_low, 2) and &H1
        read_FEP_value = rightShift(data_low, 1) and &H1
        CCD_mask = &H1
        if data_low > LONG_MAX then
            if CCD_mask = mask then
                read_CCD_value = data_low
            else
                read_CCD_value = (data_low - H8000_0000) and CCD_mask
            end If
        else
            read_CCD_value = data_low and CCD_mask
        end If

    End Sub

    Sub write
        If flag_PMD_RLOO = &H0 or flag_PMD_GLOO = &H0 or flag_RXPO_FLIP_SM = &H0 or flag_lock_ref = &H0 or flag_phase_sel_SM = &H0 or flag_freq_sel = &H0 or flag_FSFS = &H0 or flag_freq_sel_SM = &H0 or flag_RMGSF = &H0 or flag_FORC_SM = &H0 or flag_FEP = &H0 or flag_CCD = &H0 Then read
        If flag_PMD_RLOO = &H0 Then write_PMD_RLOO_value = get_PMD_RLOO
        If flag_PMD_GLOO = &H0 Then write_PMD_GLOO_value = get_PMD_GLOO
        If flag_RXPO_FLIP_SM = &H0 Then write_RXPO_FLIP_SM_value = get_RXPO_FLIP_SM
        If flag_lock_ref = &H0 Then write_lock_ref_value = get_lock_ref
        If flag_phase_sel_SM = &H0 Then write_phase_sel_SM_value = get_phase_sel_SM
        If flag_freq_sel = &H0 Then write_freq_sel_value = get_freq_sel
        If flag_FSFS = &H0 Then write_FSFS_value = get_FSFS
        If flag_freq_sel_SM = &H0 Then write_freq_sel_SM_value = get_freq_sel_SM
        If flag_RMGSF = &H0 Then write_RMGSF_value = get_RMGSF
        If flag_FORC_SM = &H0 Then write_FORC_SM_value = get_FORC_SM
        If flag_FEP = &H0 Then write_FEP_value = get_FEP
        If flag_CCD = &H0 Then write_CCD_value = get_CCD

        regValue = leftShift((write_PMD_RLOO_value and &H1), 15) + leftShift((write_PMD_GLOO_value and &H1), 14) + leftShift((write_RXPO_FLIP_SM_value and &H1), 9) + leftShift((write_lock_ref_value and &H1), 8) + leftShift((write_phase_sel_SM_value and &H1), 7) + leftShift((write_freq_sel_value and &H1), 6) + leftShift((write_FSFS_value and &H1), 5) + leftShift((write_freq_sel_SM_value and &H1), 4) + leftShift((write_RMGSF_value and &H1), 3) + leftShift((write_FORC_SM_value and &H1), 2) + leftShift((write_FEP_value and &H1), 1) + leftShift((write_CCD_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_RLOO_value = rightShift(data_low, 15) and &H1
        read_PMD_GLOO_value = rightShift(data_low, 14) and &H1
        read_RXPO_FLIP_SM_value = rightShift(data_low, 9) and &H1
        read_lock_ref_value = rightShift(data_low, 8) and &H1
        read_phase_sel_SM_value = rightShift(data_low, 7) and &H1
        read_freq_sel_value = rightShift(data_low, 6) and &H1
        read_FSFS_value = rightShift(data_low, 5) and &H1
        read_freq_sel_SM_value = rightShift(data_low, 4) and &H1
        read_RMGSF_value = rightShift(data_low, 3) and &H1
        read_FORC_SM_value = rightShift(data_low, 2) and &H1
        read_FEP_value = rightShift(data_low, 1) and &H1
        CCD_mask = &H1
        if data_low > LONG_MAX then
            if CCD_mask = mask then
                read_CCD_value = data_low
            else
                read_CCD_value = (data_low - H8000_0000) and CCD_mask
            end If
        else
            read_CCD_value = data_low and CCD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMD_RLOO_value = &H0
        flag_PMD_RLOO        = &H0
        write_PMD_GLOO_value = &H0
        flag_PMD_GLOO        = &H0
        write_RXPO_FLIP_SM_value = &H0
        flag_RXPO_FLIP_SM        = &H0
        write_lock_ref_value = &H0
        flag_lock_ref        = &H0
        write_phase_sel_SM_value = &H0
        flag_phase_sel_SM        = &H0
        write_freq_sel_value = &H0
        flag_freq_sel        = &H0
        write_FSFS_value = &H0
        flag_FSFS        = &H0
        write_freq_sel_SM_value = &H0
        flag_freq_sel_SM        = &H0
        write_RMGSF_value = &H0
        flag_RMGSF        = &H0
        write_FORC_SM_value = &H0
        flag_FORC_SM        = &H0
        write_FEP_value = &H0
        flag_FEP        = &H0
        write_CCD_value = &H0
        flag_CCD        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control1
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
'' RXSE_SM                                    [11:11]          get_RXSE_SM
''                                                             set_RXSE_SM
''                                                             read_RXSE_SM
''                                                             write_RXSE_SM
''---------------------------------------------------------------------------------
'' ROV                                        [10:10]          get_ROV
''                                                             set_ROV
''                                                             read_ROV
''                                                             write_ROV
''---------------------------------------------------------------------------------
'' RXSI_OVER                                  [9:9]            get_RXSI_OVER
''                                                             set_RXSI_OVER
''                                                             read_RXSI_OVER
''                                                             write_RXSI_OVER
''---------------------------------------------------------------------------------
'' SES                                        [8:8]            get_SES
''                                                             set_SES
''                                                             read_SES
''                                                             write_SES
''---------------------------------------------------------------------------------
'' SES1                                       [7:7]            get_SES1
''                                                             set_SES1
''                                                             read_SES1
''                                                             write_SES1
''---------------------------------------------------------------------------------
'' SES2                                       [6:6]            get_SES2
''                                                             set_SES2
''                                                             read_SES2
''                                                             write_SES2
''---------------------------------------------------------------------------------
'' RXSE_CYA                                   [5:5]            get_RXSE_CYA
''                                                             set_RXSE_CYA
''                                                             read_RXSE_CYA
''                                                             write_RXSE_CYA
''---------------------------------------------------------------------------------
'' SPD_RSTB_DIS_SM                            [4:4]            get_SPD_RSTB_DIS_SM
''                                                             set_SPD_RSTB_DIS_SM
''                                                             read_SPD_RSTB_DIS_SM
''                                                             write_SPD_RSTB_DIS_SM
''---------------------------------------------------------------------------------
'' rtbi_mode                                  [3:3]            get_rtbi_mode
''                                                             set_rtbi_mode
''                                                             read_rtbi_mode
''                                                             write_rtbi_mode
''---------------------------------------------------------------------------------
'' IMER                                       [2:2]            get_IMER
''                                                             set_IMER
''                                                             read_IMER
''                                                             write_IMER
''---------------------------------------------------------------------------------
'' CMER                                       [1:1]            get_CMER
''                                                             set_CMER
''                                                             read_CMER
''                                                             write_CMER
''---------------------------------------------------------------------------------
'' CL36_PCS_EN_RX                             [0:0]            get_CL36_PCS_EN_RX
''                                                             set_CL36_PCS_EN_RX
''                                                             read_CL36_PCS_EN_RX
''                                                             write_CL36_PCS_EN_RX
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control1
    Private write_rx_pf_ctrl_value
    Private read_rx_pf_ctrl_value
    Private flag_rx_pf_ctrl
    Private write_RXSE_SM_value
    Private read_RXSE_SM_value
    Private flag_RXSE_SM
    Private write_ROV_value
    Private read_ROV_value
    Private flag_ROV
    Private write_RXSI_OVER_value
    Private read_RXSI_OVER_value
    Private flag_RXSI_OVER
    Private write_SES_value
    Private read_SES_value
    Private flag_SES
    Private write_SES1_value
    Private read_SES1_value
    Private flag_SES1
    Private write_SES2_value
    Private read_SES2_value
    Private flag_SES2
    Private write_RXSE_CYA_value
    Private read_RXSE_CYA_value
    Private flag_RXSE_CYA
    Private write_SPD_RSTB_DIS_SM_value
    Private read_SPD_RSTB_DIS_SM_value
    Private flag_SPD_RSTB_DIS_SM
    Private write_rtbi_mode_value
    Private read_rtbi_mode_value
    Private flag_rtbi_mode
    Private write_IMER_value
    Private read_IMER_value
    Private flag_IMER
    Private write_CMER_value
    Private read_CMER_value
    Private flag_CMER
    Private write_CL36_PCS_EN_RX_value
    Private read_CL36_PCS_EN_RX_value
    Private flag_CL36_PCS_EN_RX

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

    Property Get get_RXSE_SM
        get_RXSE_SM = read_RXSE_SM_value
    End Property

    Property Let set_RXSE_SM(aData)
        write_RXSE_SM_value = aData
        flag_RXSE_SM        = &H1
    End Property

    Property Get read_RXSE_SM
        read
        read_RXSE_SM = read_RXSE_SM_value
    End Property

    Property Let write_RXSE_SM(aData)
        set_RXSE_SM = aData
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

    Property Get get_RXSI_OVER
        get_RXSI_OVER = read_RXSI_OVER_value
    End Property

    Property Let set_RXSI_OVER(aData)
        write_RXSI_OVER_value = aData
        flag_RXSI_OVER        = &H1
    End Property

    Property Get read_RXSI_OVER
        read
        read_RXSI_OVER = read_RXSI_OVER_value
    End Property

    Property Let write_RXSI_OVER(aData)
        set_RXSI_OVER = aData
        write
    End Property

    Property Get get_SES
        get_SES = read_SES_value
    End Property

    Property Let set_SES(aData)
        write_SES_value = aData
        flag_SES        = &H1
    End Property

    Property Get read_SES
        read
        read_SES = read_SES_value
    End Property

    Property Let write_SES(aData)
        set_SES = aData
        write
    End Property

    Property Get get_SES1
        get_SES1 = read_SES1_value
    End Property

    Property Let set_SES1(aData)
        write_SES1_value = aData
        flag_SES1        = &H1
    End Property

    Property Get read_SES1
        read
        read_SES1 = read_SES1_value
    End Property

    Property Let write_SES1(aData)
        set_SES1 = aData
        write
    End Property

    Property Get get_SES2
        get_SES2 = read_SES2_value
    End Property

    Property Let set_SES2(aData)
        write_SES2_value = aData
        flag_SES2        = &H1
    End Property

    Property Get read_SES2
        read
        read_SES2 = read_SES2_value
    End Property

    Property Let write_SES2(aData)
        set_SES2 = aData
        write
    End Property

    Property Get get_RXSE_CYA
        get_RXSE_CYA = read_RXSE_CYA_value
    End Property

    Property Let set_RXSE_CYA(aData)
        write_RXSE_CYA_value = aData
        flag_RXSE_CYA        = &H1
    End Property

    Property Get read_RXSE_CYA
        read
        read_RXSE_CYA = read_RXSE_CYA_value
    End Property

    Property Let write_RXSE_CYA(aData)
        set_RXSE_CYA = aData
        write
    End Property

    Property Get get_SPD_RSTB_DIS_SM
        get_SPD_RSTB_DIS_SM = read_SPD_RSTB_DIS_SM_value
    End Property

    Property Let set_SPD_RSTB_DIS_SM(aData)
        write_SPD_RSTB_DIS_SM_value = aData
        flag_SPD_RSTB_DIS_SM        = &H1
    End Property

    Property Get read_SPD_RSTB_DIS_SM
        read
        read_SPD_RSTB_DIS_SM = read_SPD_RSTB_DIS_SM_value
    End Property

    Property Let write_SPD_RSTB_DIS_SM(aData)
        set_SPD_RSTB_DIS_SM = aData
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

    Property Get get_IMER
        get_IMER = read_IMER_value
    End Property

    Property Let set_IMER(aData)
        write_IMER_value = aData
        flag_IMER        = &H1
    End Property

    Property Get read_IMER
        read
        read_IMER = read_IMER_value
    End Property

    Property Let write_IMER(aData)
        set_IMER = aData
        write
    End Property

    Property Get get_CMER
        get_CMER = read_CMER_value
    End Property

    Property Let set_CMER(aData)
        write_CMER_value = aData
        flag_CMER        = &H1
    End Property

    Property Get read_CMER
        read
        read_CMER = read_CMER_value
    End Property

    Property Let write_CMER(aData)
        set_CMER = aData
        write
    End Property

    Property Get get_CL36_PCS_EN_RX
        get_CL36_PCS_EN_RX = read_CL36_PCS_EN_RX_value
    End Property

    Property Let set_CL36_PCS_EN_RX(aData)
        write_CL36_PCS_EN_RX_value = aData
        flag_CL36_PCS_EN_RX        = &H1
    End Property

    Property Get read_CL36_PCS_EN_RX
        read
        read_CL36_PCS_EN_RX = read_CL36_PCS_EN_RX_value
    End Property

    Property Let write_CL36_PCS_EN_RX(aData)
        set_CL36_PCS_EN_RX = aData
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
        read_RXSE_SM_value = rightShift(data_low, 11) and &H1
        read_ROV_value = rightShift(data_low, 10) and &H1
        read_RXSI_OVER_value = rightShift(data_low, 9) and &H1
        read_SES_value = rightShift(data_low, 8) and &H1
        read_SES1_value = rightShift(data_low, 7) and &H1
        read_SES2_value = rightShift(data_low, 6) and &H1
        read_RXSE_CYA_value = rightShift(data_low, 5) and &H1
        read_SPD_RSTB_DIS_SM_value = rightShift(data_low, 4) and &H1
        read_rtbi_mode_value = rightShift(data_low, 3) and &H1
        read_IMER_value = rightShift(data_low, 2) and &H1
        read_CMER_value = rightShift(data_low, 1) and &H1
        CL36_PCS_EN_RX_mask = &H1
        if data_low > LONG_MAX then
            if CL36_PCS_EN_RX_mask = mask then
                read_CL36_PCS_EN_RX_value = data_low
            else
                read_CL36_PCS_EN_RX_value = (data_low - H8000_0000) and CL36_PCS_EN_RX_mask
            end If
        else
            read_CL36_PCS_EN_RX_value = data_low and CL36_PCS_EN_RX_mask
        end If

    End Sub

    Sub write
        If flag_rx_pf_ctrl = &H0 or flag_RXSE_SM = &H0 or flag_ROV = &H0 or flag_RXSI_OVER = &H0 or flag_SES = &H0 or flag_SES1 = &H0 or flag_SES2 = &H0 or flag_RXSE_CYA = &H0 or flag_SPD_RSTB_DIS_SM = &H0 or flag_rtbi_mode = &H0 or flag_IMER = &H0 or flag_CMER = &H0 or flag_CL36_PCS_EN_RX = &H0 Then read
        If flag_rx_pf_ctrl = &H0 Then write_rx_pf_ctrl_value = get_rx_pf_ctrl
        If flag_RXSE_SM = &H0 Then write_RXSE_SM_value = get_RXSE_SM
        If flag_ROV = &H0 Then write_ROV_value = get_ROV
        If flag_RXSI_OVER = &H0 Then write_RXSI_OVER_value = get_RXSI_OVER
        If flag_SES = &H0 Then write_SES_value = get_SES
        If flag_SES1 = &H0 Then write_SES1_value = get_SES1
        If flag_SES2 = &H0 Then write_SES2_value = get_SES2
        If flag_RXSE_CYA = &H0 Then write_RXSE_CYA_value = get_RXSE_CYA
        If flag_SPD_RSTB_DIS_SM = &H0 Then write_SPD_RSTB_DIS_SM_value = get_SPD_RSTB_DIS_SM
        If flag_rtbi_mode = &H0 Then write_rtbi_mode_value = get_rtbi_mode
        If flag_IMER = &H0 Then write_IMER_value = get_IMER
        If flag_CMER = &H0 Then write_CMER_value = get_CMER
        If flag_CL36_PCS_EN_RX = &H0 Then write_CL36_PCS_EN_RX_value = get_CL36_PCS_EN_RX

        regValue = leftShift((write_rx_pf_ctrl_value and &Hf), 12) + leftShift((write_RXSE_SM_value and &H1), 11) + leftShift((write_ROV_value and &H1), 10) + leftShift((write_RXSI_OVER_value and &H1), 9) + leftShift((write_SES_value and &H1), 8) + leftShift((write_SES1_value and &H1), 7) + leftShift((write_SES2_value and &H1), 6) + leftShift((write_RXSE_CYA_value and &H1), 5) + leftShift((write_SPD_RSTB_DIS_SM_value and &H1), 4) + leftShift((write_rtbi_mode_value and &H1), 3) + leftShift((write_IMER_value and &H1), 2) + leftShift((write_CMER_value and &H1), 1) + leftShift((write_CL36_PCS_EN_RX_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_pf_ctrl_value = rightShift(data_low, 12) and &Hf
        read_RXSE_SM_value = rightShift(data_low, 11) and &H1
        read_ROV_value = rightShift(data_low, 10) and &H1
        read_RXSI_OVER_value = rightShift(data_low, 9) and &H1
        read_SES_value = rightShift(data_low, 8) and &H1
        read_SES1_value = rightShift(data_low, 7) and &H1
        read_SES2_value = rightShift(data_low, 6) and &H1
        read_RXSE_CYA_value = rightShift(data_low, 5) and &H1
        read_SPD_RSTB_DIS_SM_value = rightShift(data_low, 4) and &H1
        read_rtbi_mode_value = rightShift(data_low, 3) and &H1
        read_IMER_value = rightShift(data_low, 2) and &H1
        read_CMER_value = rightShift(data_low, 1) and &H1
        CL36_PCS_EN_RX_mask = &H1
        if data_low > LONG_MAX then
            if CL36_PCS_EN_RX_mask = mask then
                read_CL36_PCS_EN_RX_value = data_low
            else
                read_CL36_PCS_EN_RX_value = (data_low - H8000_0000) and CL36_PCS_EN_RX_mask
            end If
        else
            read_CL36_PCS_EN_RX_value = data_low and CL36_PCS_EN_RX_mask
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
        write_RXSE_SM_value = &H0
        flag_RXSE_SM        = &H0
        write_ROV_value = &H0
        flag_ROV        = &H0
        write_RXSI_OVER_value = &H0
        flag_RXSI_OVER        = &H0
        write_SES_value = &H0
        flag_SES        = &H0
        write_SES1_value = &H0
        flag_SES1        = &H0
        write_SES2_value = &H0
        flag_SES2        = &H0
        write_RXSE_CYA_value = &H0
        flag_RXSE_CYA        = &H0
        write_SPD_RSTB_DIS_SM_value = &H0
        flag_SPD_RSTB_DIS_SM        = &H0
        write_rtbi_mode_value = &H0
        flag_rtbi_mode        = &H0
        write_IMER_value = &H0
        flag_IMER        = &H0
        write_CMER_value = &H0
        flag_CMER        = &H0
        write_CL36_PCS_EN_RX_value = &H0
        flag_CL36_PCS_EN_RX        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SIGD_MUX_SM                                [15:12]          get_SIGD_MUX_SM
''                                                             set_SIGD_MUX_SM
''                                                             read_SIGD_MUX_SM
''                                                             write_SIGD_MUX_SM
''---------------------------------------------------------------------------------
'' tpctrl_SM                                  [8:4]            get_tpctrl_SM
''                                                             set_tpctrl_SM
''                                                             read_tpctrl_SM
''                                                             write_tpctrl_SM
''---------------------------------------------------------------------------------
'' TEST_SM                                    [3:0]            get_TEST_SM
''                                                             set_TEST_SM
''                                                             read_TEST_SM
''                                                             write_TEST_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control2
    Private write_SIGD_MUX_SM_value
    Private read_SIGD_MUX_SM_value
    Private flag_SIGD_MUX_SM
    Private write_tpctrl_SM_value
    Private read_tpctrl_SM_value
    Private flag_tpctrl_SM
    Private write_TEST_SM_value
    Private read_TEST_SM_value
    Private flag_TEST_SM

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

    Property Get get_SIGD_MUX_SM
        get_SIGD_MUX_SM = read_SIGD_MUX_SM_value
    End Property

    Property Let set_SIGD_MUX_SM(aData)
        write_SIGD_MUX_SM_value = aData
        flag_SIGD_MUX_SM        = &H1
    End Property

    Property Get read_SIGD_MUX_SM
        read
        read_SIGD_MUX_SM = read_SIGD_MUX_SM_value
    End Property

    Property Let write_SIGD_MUX_SM(aData)
        set_SIGD_MUX_SM = aData
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

    Property Get get_TEST_SM
        get_TEST_SM = read_TEST_SM_value
    End Property

    Property Let set_TEST_SM(aData)
        write_TEST_SM_value = aData
        flag_TEST_SM        = &H1
    End Property

    Property Get read_TEST_SM
        read
        read_TEST_SM = read_TEST_SM_value
    End Property

    Property Let write_TEST_SM(aData)
        set_TEST_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SIGD_MUX_SM_value = rightShift(data_low, 12) and &Hf
        read_tpctrl_SM_value = rightShift(data_low, 4) and &H1f
        TEST_SM_mask = &Hf
        if data_low > LONG_MAX then
            if TEST_SM_mask = mask then
                read_TEST_SM_value = data_low
            else
                read_TEST_SM_value = (data_low - H8000_0000) and TEST_SM_mask
            end If
        else
            read_TEST_SM_value = data_low and TEST_SM_mask
        end If

    End Sub

    Sub write
        If flag_SIGD_MUX_SM = &H0 or flag_tpctrl_SM = &H0 or flag_TEST_SM = &H0 Then read
        If flag_SIGD_MUX_SM = &H0 Then write_SIGD_MUX_SM_value = get_SIGD_MUX_SM
        If flag_tpctrl_SM = &H0 Then write_tpctrl_SM_value = get_tpctrl_SM
        If flag_TEST_SM = &H0 Then write_TEST_SM_value = get_TEST_SM

        regValue = leftShift((write_SIGD_MUX_SM_value and &Hf), 12) + leftShift((write_tpctrl_SM_value and &H1f), 4) + leftShift((write_TEST_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SIGD_MUX_SM_value = rightShift(data_low, 12) and &Hf
        read_tpctrl_SM_value = rightShift(data_low, 4) and &H1f
        TEST_SM_mask = &Hf
        if data_low > LONG_MAX then
            if TEST_SM_mask = mask then
                read_TEST_SM_value = data_low
            else
                read_TEST_SM_value = (data_low - H8000_0000) and TEST_SM_mask
            end If
        else
            read_TEST_SM_value = data_low and TEST_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SIGD_MUX_SM_value = &H0
        flag_SIGD_MUX_SM        = &H0
        write_tpctrl_SM_value = &H0
        flag_tpctrl_SM        = &H0
        write_TEST_SM_value = &H0
        flag_TEST_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IRS                                        [5:5]            get_IRS
''                                                             set_IRS
''                                                             read_IRS
''                                                             write_IRS
''---------------------------------------------------------------------------------
'' C4SCLS                                     [4:4]            get_C4SCLS
''                                                             set_C4SCLS
''                                                             read_C4SCLS
''                                                             write_C4SCLS
''---------------------------------------------------------------------------------
'' C4SES                                      [3:3]            get_C4SES
''                                                             set_C4SES
''                                                             read_C4SES
''                                                             write_C4SES
''---------------------------------------------------------------------------------
'' ESES                                       [2:2]            get_ESES
''                                                             set_ESES
''                                                             read_ESES
''                                                             write_ESES
''---------------------------------------------------------------------------------
'' OSES                                       [1:1]            get_OSES
''                                                             set_OSES
''                                                             read_OSES
''                                                             write_OSES
''---------------------------------------------------------------------------------
'' OSVS                                       [0:0]            get_OSVS
''                                                             set_OSVS
''                                                             read_OSVS
''                                                             write_OSVS
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_ctrl0
    Private write_IRS_value
    Private read_IRS_value
    Private flag_IRS
    Private write_C4SCLS_value
    Private read_C4SCLS_value
    Private flag_C4SCLS
    Private write_C4SES_value
    Private read_C4SES_value
    Private flag_C4SES
    Private write_ESES_value
    Private read_ESES_value
    Private flag_ESES
    Private write_OSES_value
    Private read_OSES_value
    Private flag_OSES
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

    Property Get get_IRS
        get_IRS = read_IRS_value
    End Property

    Property Let set_IRS(aData)
        write_IRS_value = aData
        flag_IRS        = &H1
    End Property

    Property Get read_IRS
        read
        read_IRS = read_IRS_value
    End Property

    Property Let write_IRS(aData)
        set_IRS = aData
        write
    End Property

    Property Get get_C4SCLS
        get_C4SCLS = read_C4SCLS_value
    End Property

    Property Let set_C4SCLS(aData)
        write_C4SCLS_value = aData
        flag_C4SCLS        = &H1
    End Property

    Property Get read_C4SCLS
        read
        read_C4SCLS = read_C4SCLS_value
    End Property

    Property Let write_C4SCLS(aData)
        set_C4SCLS = aData
        write
    End Property

    Property Get get_C4SES
        get_C4SES = read_C4SES_value
    End Property

    Property Let set_C4SES(aData)
        write_C4SES_value = aData
        flag_C4SES        = &H1
    End Property

    Property Get read_C4SES
        read
        read_C4SES = read_C4SES_value
    End Property

    Property Let write_C4SES(aData)
        set_C4SES = aData
        write
    End Property

    Property Get get_ESES
        get_ESES = read_ESES_value
    End Property

    Property Let set_ESES(aData)
        write_ESES_value = aData
        flag_ESES        = &H1
    End Property

    Property Get read_ESES
        read
        read_ESES = read_ESES_value
    End Property

    Property Let write_ESES(aData)
        set_ESES = aData
        write
    End Property

    Property Get get_OSES
        get_OSES = read_OSES_value
    End Property

    Property Let set_OSES(aData)
        write_OSES_value = aData
        flag_OSES        = &H1
    End Property

    Property Get read_OSES
        read
        read_OSES = read_OSES_value
    End Property

    Property Let write_OSES(aData)
        set_OSES = aData
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
        read_IRS_value = rightShift(data_low, 5) and &H1
        read_C4SCLS_value = rightShift(data_low, 4) and &H1
        read_C4SES_value = rightShift(data_low, 3) and &H1
        read_ESES_value = rightShift(data_low, 2) and &H1
        read_OSES_value = rightShift(data_low, 1) and &H1
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
        If flag_IRS = &H0 or flag_C4SCLS = &H0 or flag_C4SES = &H0 or flag_ESES = &H0 or flag_OSES = &H0 or flag_OSVS = &H0 Then read
        If flag_IRS = &H0 Then write_IRS_value = get_IRS
        If flag_C4SCLS = &H0 Then write_C4SCLS_value = get_C4SCLS
        If flag_C4SES = &H0 Then write_C4SES_value = get_C4SES
        If flag_ESES = &H0 Then write_ESES_value = get_ESES
        If flag_OSES = &H0 Then write_OSES_value = get_OSES
        If flag_OSVS = &H0 Then write_OSVS_value = get_OSVS

        regValue = leftShift((write_IRS_value and &H1), 5) + leftShift((write_C4SCLS_value and &H1), 4) + leftShift((write_C4SES_value and &H1), 3) + leftShift((write_ESES_value and &H1), 2) + leftShift((write_OSES_value and &H1), 1) + leftShift((write_OSVS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IRS_value = rightShift(data_low, 5) and &H1
        read_C4SCLS_value = rightShift(data_low, 4) and &H1
        read_C4SES_value = rightShift(data_low, 3) and &H1
        read_ESES_value = rightShift(data_low, 2) and &H1
        read_OSES_value = rightShift(data_low, 1) and &H1
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
        write_IRS_value = &H0
        flag_IRS        = &H0
        write_C4SCLS_value = &H0
        flag_C4SCLS        = &H0
        write_C4SES_value = &H0
        flag_C4SES        = &H0
        write_ESES_value = &H0
        flag_ESES        = &H0
        write_OSES_value = &H0
        flag_OSES        = &H0
        write_OSVS_value = &H0
        flag_OSVS        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CX4_SIGD_CNT                               [15:0]           get_CX4_SIGD_CNT
''                                                             set_CX4_SIGD_CNT
''                                                             read_CX4_SIGD_CNT
''                                                             write_CX4_SIGD_CNT
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_ctrl1
    Private write_CX4_SIGD_CNT_value
    Private read_CX4_SIGD_CNT_value
    Private flag_CX4_SIGD_CNT

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

    Property Get get_CX4_SIGD_CNT
        get_CX4_SIGD_CNT = read_CX4_SIGD_CNT_value
    End Property

    Property Let set_CX4_SIGD_CNT(aData)
        write_CX4_SIGD_CNT_value = aData
        flag_CX4_SIGD_CNT        = &H1
    End Property

    Property Get read_CX4_SIGD_CNT
        read
        read_CX4_SIGD_CNT = read_CX4_SIGD_CNT_value
    End Property

    Property Let write_CX4_SIGD_CNT(aData)
        set_CX4_SIGD_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CX4_SIGD_CNT_mask = &Hffff
        if data_low > LONG_MAX then
            if CX4_SIGD_CNT_mask = mask then
                read_CX4_SIGD_CNT_value = data_low
            else
                read_CX4_SIGD_CNT_value = (data_low - H8000_0000) and CX4_SIGD_CNT_mask
            end If
        else
            read_CX4_SIGD_CNT_value = data_low and CX4_SIGD_CNT_mask
        end If

    End Sub

    Sub write
        If flag_CX4_SIGD_CNT = &H0 Then read
        If flag_CX4_SIGD_CNT = &H0 Then write_CX4_SIGD_CNT_value = get_CX4_SIGD_CNT

        regValue = leftShift((write_CX4_SIGD_CNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CX4_SIGD_CNT_mask = &Hffff
        if data_low > LONG_MAX then
            if CX4_SIGD_CNT_mask = mask then
                read_CX4_SIGD_CNT_value = data_low
            else
                read_CX4_SIGD_CNT_value = (data_low - H8000_0000) and CX4_SIGD_CNT_mask
            end If
        else
            read_CX4_SIGD_CNT_value = data_low and CX4_SIGD_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CX4_SIGD_CNT_value = &H0
        flag_CX4_SIGD_CNT        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ROMM                                       [5:2]            get_ROMM
''                                                             set_ROMM
''                                                             read_ROMM
''                                                             write_ROMM
''---------------------------------------------------------------------------------
'' os_1x_mode                                 [1:1]            get_os_1x_mode
''                                                             set_os_1x_mode
''                                                             read_os_1x_mode
''                                                             write_os_1x_mode
''---------------------------------------------------------------------------------
'' PSS                                        [0:0]            get_PSS
''                                                             set_PSS
''                                                             read_PSS
''                                                             write_PSS
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_status
    Private write_ROMM_value
    Private read_ROMM_value
    Private flag_ROMM
    Private write_os_1x_mode_value
    Private read_os_1x_mode_value
    Private flag_os_1x_mode
    Private write_PSS_value
    Private read_PSS_value
    Private flag_PSS

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

    Property Get get_ROMM
        get_ROMM = read_ROMM_value
    End Property

    Property Let set_ROMM(aData)
        write_ROMM_value = aData
        flag_ROMM        = &H1
    End Property

    Property Get read_ROMM
        read
        read_ROMM = read_ROMM_value
    End Property

    Property Let write_ROMM(aData)
        set_ROMM = aData
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

    Property Get get_PSS
        get_PSS = read_PSS_value
    End Property

    Property Let set_PSS(aData)
        write_PSS_value = aData
        flag_PSS        = &H1
    End Property

    Property Get read_PSS
        read
        read_PSS = read_PSS_value
    End Property

    Property Let write_PSS(aData)
        set_PSS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ROMM_value = rightShift(data_low, 2) and &Hf
        read_os_1x_mode_value = rightShift(data_low, 1) and &H1
        PSS_mask = &H1
        if data_low > LONG_MAX then
            if PSS_mask = mask then
                read_PSS_value = data_low
            else
                read_PSS_value = (data_low - H8000_0000) and PSS_mask
            end If
        else
            read_PSS_value = data_low and PSS_mask
        end If

    End Sub

    Sub write
        If flag_ROMM = &H0 or flag_os_1x_mode = &H0 or flag_PSS = &H0 Then read
        If flag_ROMM = &H0 Then write_ROMM_value = get_ROMM
        If flag_os_1x_mode = &H0 Then write_os_1x_mode_value = get_os_1x_mode
        If flag_PSS = &H0 Then write_PSS_value = get_PSS

        regValue = leftShift((write_ROMM_value and &Hf), 2) + leftShift((write_os_1x_mode_value and &H1), 1) + leftShift((write_PSS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ROMM_value = rightShift(data_low, 2) and &Hf
        read_os_1x_mode_value = rightShift(data_low, 1) and &H1
        PSS_mask = &H1
        if data_low > LONG_MAX then
            if PSS_mask = mask then
                read_PSS_value = data_low
            else
                read_PSS_value = (data_low - H8000_0000) and PSS_mask
            end If
        else
            read_PSS_value = data_low and PSS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ROMM_value = &H0
        flag_ROMM        = &H0
        write_os_1x_mode_value = &H0
        flag_os_1x_mode        = &H0
        write_PSS_value = &H0
        flag_PSS        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control3
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
'' O1MO                                       [5:5]            get_O1MO
''                                                             set_O1MO
''                                                             read_O1MO
''                                                             write_O1MO
''---------------------------------------------------------------------------------
'' OMRPO                                      [4:4]            get_OMRPO
''                                                             set_OMRPO
''                                                             read_OMRPO
''                                                             write_OMRPO
''---------------------------------------------------------------------------------
'' OS_MODE_RX_PMD                             [3:0]            get_OS_MODE_RX_PMD
''                                                             set_OS_MODE_RX_PMD
''                                                             read_OS_MODE_RX_PMD
''                                                             write_OS_MODE_RX_PMD
''---------------------------------------------------------------------------------
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control3
    Private write_O1MOV_value
    Private read_O1MOV_value
    Private flag_O1MOV
    Private write_O1MO_value
    Private read_O1MO_value
    Private flag_O1MO
    Private write_OMRPO_value
    Private read_OMRPO_value
    Private flag_OMRPO
    Private write_OS_MODE_RX_PMD_value
    Private read_OS_MODE_RX_PMD_value
    Private flag_OS_MODE_RX_PMD

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

    Property Get get_O1MO
        get_O1MO = read_O1MO_value
    End Property

    Property Let set_O1MO(aData)
        write_O1MO_value = aData
        flag_O1MO        = &H1
    End Property

    Property Get read_O1MO
        read
        read_O1MO = read_O1MO_value
    End Property

    Property Let write_O1MO(aData)
        set_O1MO = aData
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

    Property Get get_OS_MODE_RX_PMD
        get_OS_MODE_RX_PMD = read_OS_MODE_RX_PMD_value
    End Property

    Property Let set_OS_MODE_RX_PMD(aData)
        write_OS_MODE_RX_PMD_value = aData
        flag_OS_MODE_RX_PMD        = &H1
    End Property

    Property Get read_OS_MODE_RX_PMD
        read
        read_OS_MODE_RX_PMD = read_OS_MODE_RX_PMD_value
    End Property

    Property Let write_OS_MODE_RX_PMD(aData)
        set_OS_MODE_RX_PMD = aData
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
        read_O1MO_value = rightShift(data_low, 5) and &H1
        read_OMRPO_value = rightShift(data_low, 4) and &H1
        OS_MODE_RX_PMD_mask = &Hf
        if data_low > LONG_MAX then
            if OS_MODE_RX_PMD_mask = mask then
                read_OS_MODE_RX_PMD_value = data_low
            else
                read_OS_MODE_RX_PMD_value = (data_low - H8000_0000) and OS_MODE_RX_PMD_mask
            end If
        else
            read_OS_MODE_RX_PMD_value = data_low and OS_MODE_RX_PMD_mask
        end If

    End Sub

    Sub write
        If flag_O1MOV = &H0 or flag_O1MO = &H0 or flag_OMRPO = &H0 or flag_OS_MODE_RX_PMD = &H0 Then read
        If flag_O1MOV = &H0 Then write_O1MOV_value = get_O1MOV
        If flag_O1MO = &H0 Then write_O1MO_value = get_O1MO
        If flag_OMRPO = &H0 Then write_OMRPO_value = get_OMRPO
        If flag_OS_MODE_RX_PMD = &H0 Then write_OS_MODE_RX_PMD_value = get_OS_MODE_RX_PMD

        regValue = leftShift((write_O1MOV_value and &H1), 6) + leftShift((write_O1MO_value and &H1), 5) + leftShift((write_OMRPO_value and &H1), 4) + leftShift((write_OS_MODE_RX_PMD_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_O1MOV_value = rightShift(data_low, 6) and &H1
        read_O1MO_value = rightShift(data_low, 5) and &H1
        read_OMRPO_value = rightShift(data_low, 4) and &H1
        OS_MODE_RX_PMD_mask = &Hf
        if data_low > LONG_MAX then
            if OS_MODE_RX_PMD_mask = mask then
                read_OS_MODE_RX_PMD_value = data_low
            else
                read_OS_MODE_RX_PMD_value = (data_low - H8000_0000) and OS_MODE_RX_PMD_mask
            end If
        else
            read_OS_MODE_RX_PMD_value = data_low and OS_MODE_RX_PMD_mask
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
        write_O1MO_value = &H0
        flag_O1MO        = &H0
        write_OMRPO_value = &H0
        flag_OMRPO        = &H0
        write_OS_MODE_RX_PMD_value = &H0
        flag_OS_MODE_RX_PMD        = &H0
    End Sub
End Class


'' @REGISTER : RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_blockaddress
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
Class REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_blockaddress
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

Class RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_INSTANCE

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
        Set rxpmd_test_control = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_test_control)(aBaseAddr, 16)
        Set rxpmd_test_status = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_test_status)(aBaseAddr, 16)
        Set rxpmd_control0 = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control0)(aBaseAddr, 16)
        Set rxpmd_control1 = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control1)(aBaseAddr, 16)
        Set rxpmd_control2 = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control2)(aBaseAddr, 16)
        Set rxpmd_sigdet_ctrl0 = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_ctrl0)(aBaseAddr, 16)
        Set rxpmd_sigdet_ctrl1 = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_ctrl1)(aBaseAddr, 16)
        Set rxpmd_sigdet_status = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_sigdet_status)(aBaseAddr, 16)
        Set rxpmd_control3 = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_rxpmd_control3)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1.Add ((New RX_PMD_TEST_SGMIIPCIE_X1_SGMIIPCIE_X1_INSTANCE)(&H4ad50c40))


