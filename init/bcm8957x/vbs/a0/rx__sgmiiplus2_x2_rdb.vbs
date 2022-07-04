

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


'' @REGISTER : RX__SGMIIPLUS2_X2_anarxstatus
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cx4_sigdet                                 [1:1]            get_cx4_sigdet
''                                                             set_cx4_sigdet
''                                                             read_cx4_sigdet
''                                                             write_cx4_sigdet
''---------------------------------------------------------------------------------
'' rxSeqDone                                  [0:0]            get_rxSeqDone
''                                                             set_rxSeqDone
''                                                             read_rxSeqDone
''                                                             write_rxSeqDone
''---------------------------------------------------------------------------------
'' rx_sigdet_ll                               [11:11]          get_rx_sigdet_ll
''                                                             set_rx_sigdet_ll
''                                                             read_rx_sigdet_ll
''                                                             write_rx_sigdet_ll
''---------------------------------------------------------------------------------
'' cs4_sigdet_ll                              [10:10]          get_cs4_sigdet_ll
''                                                             set_cs4_sigdet_ll
''                                                             read_cs4_sigdet_ll
''                                                             write_cs4_sigdet_ll
''---------------------------------------------------------------------------------
'' rx_reset                                   [4:4]            get_rx_reset
''                                                             set_rx_reset
''                                                             read_rx_reset
''                                                             write_rx_reset
''---------------------------------------------------------------------------------
'' rx_pwrdn                                   [3:3]            get_rx_pwrdn
''                                                             set_rx_pwrdn
''                                                             read_rx_pwrdn
''                                                             write_rx_pwrdn
''---------------------------------------------------------------------------------
'' test_acq_en                                [10:10]          get_test_acq_en
''                                                             set_test_acq_en
''                                                             read_test_acq_en
''                                                             write_test_acq_en
''---------------------------------------------------------------------------------
'' rxSeqStart                                 [3:3]            get_rxSeqStart
''                                                             set_rxSeqStart
''                                                             read_rxSeqStart
''                                                             write_rxSeqStart
''---------------------------------------------------------------------------------
'' mux_comadj_sync_status                     [7:7]            get_mux_comadj_sync_status
''                                                             set_mux_comadj_sync_status
''                                                             read_mux_comadj_sync_status
''                                                             write_mux_comadj_sync_status
''---------------------------------------------------------------------------------
'' sync_status                                [15:15]          get_sync_status
''                                                             set_sync_status
''                                                             read_sync_status
''                                                             write_sync_status
''---------------------------------------------------------------------------------
'' rx_sigdet                                  [5:5]            get_rx_sigdet
''                                                             set_rx_sigdet
''                                                             read_rx_sigdet
''                                                             write_rx_sigdet
''---------------------------------------------------------------------------------
'' saturate_status                            [2:2]            get_saturate_status
''                                                             set_saturate_status
''                                                             read_saturate_status
''                                                             write_saturate_status
''---------------------------------------------------------------------------------
'' indck_mode_en                              [9:9]            get_indck_mode_en
''                                                             set_indck_mode_en
''                                                             read_indck_mode_en
''                                                             write_indck_mode_en
''---------------------------------------------------------------------------------
'' pci_mode_en                                [8:8]            get_pci_mode_en
''                                                             set_pci_mode_en
''                                                             read_pci_mode_en
''                                                             write_pci_mode_en
''---------------------------------------------------------------------------------
'' rx_polarity                                [7:7]            get_rx_polarity
''                                                             set_rx_polarity
''                                                             read_rx_polarity
''                                                             write_rx_polarity
''---------------------------------------------------------------------------------
'' rxpol_flip                                 [6:6]            get_rxpol_flip
''                                                             set_rxpol_flip
''                                                             read_rxpol_flip
''                                                             write_rxpol_flip
''---------------------------------------------------------------------------------
'' comma_mask                                 [5:5]            get_comma_mask
''                                                             set_comma_mask
''                                                             read_comma_mask
''                                                             write_comma_mask
''---------------------------------------------------------------------------------
'' link_en_r                                  [4:4]            get_link_en_r
''                                                             set_link_en_r
''                                                             read_link_en_r
''                                                             write_link_en_r
''---------------------------------------------------------------------------------
'' comma_adj_en                               [3:3]            get_comma_adj_en
''                                                             set_comma_adj_en
''                                                             read_comma_adj_en
''                                                             write_comma_adj_en
''---------------------------------------------------------------------------------
'' comma_adj_en_ext                           [2:2]            get_comma_adj_en_ext
''                                                             set_comma_adj_en_ext
''                                                             read_comma_adj_en_ext
''                                                             write_comma_adj_en_ext
''---------------------------------------------------------------------------------
'' cdrAcqDone_r2                              [4:4]            get_cdrAcqDone_r2
''                                                             set_cdrAcqDone_r2
''                                                             read_cdrAcqDone_r2
''                                                             write_cdrAcqDone_r2
''---------------------------------------------------------------------------------
'' freq_sel_PC                                [3:3]            get_freq_sel_PC
''                                                             set_freq_sel_PC
''                                                             read_freq_sel_PC
''                                                             write_freq_sel_PC
''---------------------------------------------------------------------------------
'' freq_sel_SM                                [2:2]            get_freq_sel_SM
''                                                             set_freq_sel_SM
''                                                             read_freq_sel_SM
''                                                             write_freq_sel_SM
''---------------------------------------------------------------------------------
'' integ_mode_SM                              [1:0]            get_integ_mode_SM
''                                                             set_integ_mode_SM
''                                                             read_integ_mode_SM
''                                                             write_integ_mode_SM
''---------------------------------------------------------------------------------
'' prop_scale                                 [15:12]          get_prop_scale
''                                                             set_prop_scale
''                                                             read_prop_scale
''                                                             write_prop_scale
''---------------------------------------------------------------------------------
'' integ_scale                                [11:8]           get_integ_scale
''                                                             set_integ_scale
''                                                             read_integ_scale
''                                                             write_integ_scale
''---------------------------------------------------------------------------------
'' prop_scale_acq                             [7:4]            get_prop_scale_acq
''                                                             set_prop_scale_acq
''                                                             read_prop_scale_acq
''                                                             write_prop_scale_acq
''---------------------------------------------------------------------------------
'' integ_scale_acq                            [3:0]            get_integ_scale_acq
''                                                             set_integ_scale_acq
''                                                             read_integ_scale_acq
''                                                             write_integ_scale_acq
''---------------------------------------------------------------------------------
'' rxMuxCkSel                                 [5:5]            get_rxMuxCkSel
''                                                             set_rxMuxCkSel
''                                                             read_rxMuxCkSel
''                                                             write_rxMuxCkSel
''---------------------------------------------------------------------------------
'' glpbk_combo                                [5:5]            get_glpbk_combo
''                                                             set_glpbk_combo
''                                                             read_glpbk_combo
''                                                             write_glpbk_combo
''---------------------------------------------------------------------------------
'' clockSwitchSel                             [4:4]            get_clockSwitchSel
''                                                             set_clockSwitchSel
''                                                             read_clockSwitchSel
''                                                             write_clockSwitchSel
''---------------------------------------------------------------------------------
'' rxck_tst                                   [3:3]            get_rxck_tst
''                                                             set_rxck_tst
''                                                             read_rxck_tst
''                                                             write_rxck_tst
''---------------------------------------------------------------------------------
'' rxck_i                                     [2:2]            get_rxck_i
''                                                             set_rxck_i
''                                                             read_rxck_i
''                                                             write_rxck_i
''---------------------------------------------------------------------------------
'' refclk                                     [1:1]            get_refclk
''                                                             set_refclk
''                                                             read_refclk
''                                                             write_refclk
''---------------------------------------------------------------------------------
'' pll_bypass                                 [0:0]            get_pll_bypass
''                                                             set_pll_bypass
''                                                             read_pll_bypass
''                                                             write_pll_bypass
''---------------------------------------------------------------------------------
'' allow_increment_PC                         [0:0]            get_allow_increment_PC
''                                                             set_allow_increment_PC
''                                                             read_allow_increment_PC
''                                                             write_allow_increment_PC
''---------------------------------------------------------------------------------
'' freq_sel                                   [6:6]            get_freq_sel
''                                                             set_freq_sel
''                                                             read_freq_sel
''                                                             write_freq_sel
''---------------------------------------------------------------------------------
'' pll_lock_rstb                              [5:5]            get_pll_lock_rstb
''                                                             set_pll_lock_rstb
''                                                             read_pll_lock_rstb
''                                                             write_pll_lock_rstb
''---------------------------------------------------------------------------------
'' pwrdn                                      [4:4]            get_pwrdn
''                                                             set_pwrdn
''                                                             read_pwrdn
''                                                             write_pwrdn
''---------------------------------------------------------------------------------
'' reset_anlg                                 [2:2]            get_reset_anlg
''                                                             set_reset_anlg
''                                                             read_reset_anlg
''                                                             write_reset_anlg
''---------------------------------------------------------------------------------
'' pwrdn_rx                                   [1:1]            get_pwrdn_rx
''                                                             set_pwrdn_rx
''                                                             read_pwrdn_rx
''                                                             write_pwrdn_rx
''---------------------------------------------------------------------------------
'' pwrdn_pll                                  [0:0]            get_pwrdn_pll
''                                                             set_pwrdn_pll
''                                                             read_pwrdn_pll
''                                                             write_pwrdn_pll
''---------------------------------------------------------------------------------
'' rxck0_even                                 [4:4]            get_rxck0_even
''                                                             set_rxck0_even
''                                                             read_rxck0_even
''                                                             write_rxck0_even
''---------------------------------------------------------------------------------
'' rxck1_even                                 [3:3]            get_rxck1_even
''                                                             set_rxck1_even
''                                                             read_rxck1_even
''                                                             write_rxck1_even
''---------------------------------------------------------------------------------
'' comdet_even                                [2:2]            get_comdet_even
''                                                             set_comdet_even
''                                                             read_comdet_even
''                                                             write_comdet_even
''---------------------------------------------------------------------------------
'' en_cdet_even                               [1:1]            get_en_cdet_even
''                                                             set_en_cdet_even
''                                                             read_en_cdet_even
''                                                             write_en_cdet_even
''---------------------------------------------------------------------------------
'' comma_adj_en_even                          [0:0]            get_comma_adj_en_even
''                                                             set_comma_adj_en_even
''                                                             read_comma_adj_en_even
''                                                             write_comma_adj_en_even
''---------------------------------------------------------------------------------
'' rxck0_odd                                  [4:4]            get_rxck0_odd
''                                                             set_rxck0_odd
''                                                             read_rxck0_odd
''                                                             write_rxck0_odd
''---------------------------------------------------------------------------------
'' rxck1_odd                                  [3:3]            get_rxck1_odd
''                                                             set_rxck1_odd
''                                                             read_rxck1_odd
''                                                             write_rxck1_odd
''---------------------------------------------------------------------------------
'' comdet_odd                                 [2:2]            get_comdet_odd
''                                                             set_comdet_odd
''                                                             read_comdet_odd
''                                                             write_comdet_odd
''---------------------------------------------------------------------------------
'' en_cdet_odd                                [1:1]            get_en_cdet_odd
''                                                             set_en_cdet_odd
''                                                             read_en_cdet_odd
''                                                             write_en_cdet_odd
''---------------------------------------------------------------------------------
'' comma_adj_en_odd                           [0:0]            get_comma_adj_en_odd
''                                                             set_comma_adj_en_odd
''                                                             read_comma_adj_en_odd
''                                                             write_comma_adj_en_odd
''---------------------------------------------------------------------------------
'' sigdet                                     [0:0]            get_sigdet
''                                                             set_sigdet
''                                                             read_sigdet
''                                                             write_sigdet
''---------------------------------------------------------------------------------
'' prbs_en                                    [6:6]            get_prbs_en
''                                                             set_prbs_en
''                                                             read_prbs_en
''                                                             write_prbs_en
''---------------------------------------------------------------------------------
'' rstb_tst                                   [5:5]            get_rstb_tst
''                                                             set_rstb_tst
''                                                             read_rstb_tst
''                                                             write_rstb_tst
''---------------------------------------------------------------------------------
'' prbs_state                                 [3:0]            get_prbs_state
''                                                             set_prbs_state
''                                                             read_prbs_state
''                                                             write_prbs_state
''---------------------------------------------------------------------------------
'' enable4                                    [5:5]            get_enable4
''                                                             set_enable4
''                                                             read_enable4
''                                                             write_enable4
''---------------------------------------------------------------------------------
'' radr_test                                  [4:0]            get_radr_test
''                                                             set_radr_test
''                                                             read_radr_test
''                                                             write_radr_test
''---------------------------------------------------------------------------------
'' wadr_test                                  [4:0]            get_wadr_test
''                                                             set_wadr_test
''                                                             read_wadr_test
''                                                             write_wadr_test
''---------------------------------------------------------------------------------
'' rxck_66B_tmux                              [5:5]            get_rxck_66B_tmux
''                                                             set_rxck_66B_tmux
''                                                             read_rxck_66B_tmux
''                                                             write_rxck_66B_tmux
''---------------------------------------------------------------------------------
'' rstb_66B                                   [4:4]            get_rstb_66B
''                                                             set_rstb_66B
''                                                             read_rstb_66B
''                                                             write_rstb_66B
''---------------------------------------------------------------------------------
'' prstb_66B_mux                              [3:3]            get_prstb_66B_mux
''                                                             set_prstb_66B_mux
''                                                             read_prstb_66B_mux
''                                                             write_prstb_66B_mux
''---------------------------------------------------------------------------------
'' rxck_i66_tmux                              [2:2]            get_rxck_i66_tmux
''                                                             set_rxck_i66_tmux
''                                                             read_rxck_i66_tmux
''                                                             write_rxck_i66_tmux
''---------------------------------------------------------------------------------
'' rstb_i66                                   [1:1]            get_rstb_i66
''                                                             set_rstb_i66
''                                                             read_rstb_i66
''                                                             write_rstb_i66
''---------------------------------------------------------------------------------
'' prstb_i66_mux                              [0:0]            get_prstb_i66_mux
''                                                             set_prstb_i66_mux
''                                                             read_prstb_i66_mux
''                                                             write_prstb_i66_mux
''---------------------------------------------------------------------------------
'' rfifo_error_r                              [3:2]            get_rfifo_error_r
''                                                             set_rfifo_error_r
''                                                             read_rfifo_error_r
''                                                             write_rfifo_error_r
''---------------------------------------------------------------------------------
'' rfifo_unflow                               [1:1]            get_rfifo_unflow
''                                                             set_rfifo_unflow
''                                                             read_rfifo_unflow
''                                                             write_rfifo_unflow
''---------------------------------------------------------------------------------
'' rfifo_ovflow                               [0:0]            get_rfifo_ovflow
''                                                             set_rfifo_ovflow
''                                                             read_rfifo_ovflow
''                                                             write_rfifo_ovflow
''---------------------------------------------------------------------------------
'' integ_status                               [15:0]           get_integ_status
''                                                             set_integ_status
''                                                             read_integ_status
''                                                             write_integ_status
''---------------------------------------------------------------------------------
'' vco_status                                 [15:0]           get_vco_status
''                                                             set_vco_status
''                                                             read_vco_status
''                                                             write_vco_status
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
'' E_count                                    [14:0]           get_E_count
''                                                             set_E_count
''                                                             read_E_count
''                                                             write_E_count
''---------------------------------------------------------------------------------
Class REGISTER_RX__SGMIIPLUS2_X2_anarxstatus
    Private write_cx4_sigdet_value
    Private read_cx4_sigdet_value
    Private flag_cx4_sigdet
    Private write_rxSeqDone_value
    Private read_rxSeqDone_value
    Private flag_rxSeqDone
    Private write_rx_sigdet_ll_value
    Private read_rx_sigdet_ll_value
    Private flag_rx_sigdet_ll
    Private write_cs4_sigdet_ll_value
    Private read_cs4_sigdet_ll_value
    Private flag_cs4_sigdet_ll
    Private write_rx_reset_value
    Private read_rx_reset_value
    Private flag_rx_reset
    Private write_rx_pwrdn_value
    Private read_rx_pwrdn_value
    Private flag_rx_pwrdn
    Private write_test_acq_en_value
    Private read_test_acq_en_value
    Private flag_test_acq_en
    Private write_rxSeqStart_value
    Private read_rxSeqStart_value
    Private flag_rxSeqStart
    Private write_mux_comadj_sync_status_value
    Private read_mux_comadj_sync_status_value
    Private flag_mux_comadj_sync_status
    Private write_sync_status_value
    Private read_sync_status_value
    Private flag_sync_status
    Private write_rx_sigdet_value
    Private read_rx_sigdet_value
    Private flag_rx_sigdet
    Private write_saturate_status_value
    Private read_saturate_status_value
    Private flag_saturate_status
    Private write_indck_mode_en_value
    Private read_indck_mode_en_value
    Private flag_indck_mode_en
    Private write_pci_mode_en_value
    Private read_pci_mode_en_value
    Private flag_pci_mode_en
    Private write_rx_polarity_value
    Private read_rx_polarity_value
    Private flag_rx_polarity
    Private write_rxpol_flip_value
    Private read_rxpol_flip_value
    Private flag_rxpol_flip
    Private write_comma_mask_value
    Private read_comma_mask_value
    Private flag_comma_mask
    Private write_link_en_r_value
    Private read_link_en_r_value
    Private flag_link_en_r
    Private write_comma_adj_en_value
    Private read_comma_adj_en_value
    Private flag_comma_adj_en
    Private write_comma_adj_en_ext_value
    Private read_comma_adj_en_ext_value
    Private flag_comma_adj_en_ext
    Private write_cdrAcqDone_r2_value
    Private read_cdrAcqDone_r2_value
    Private flag_cdrAcqDone_r2
    Private write_freq_sel_PC_value
    Private read_freq_sel_PC_value
    Private flag_freq_sel_PC
    Private write_freq_sel_SM_value
    Private read_freq_sel_SM_value
    Private flag_freq_sel_SM
    Private write_integ_mode_SM_value
    Private read_integ_mode_SM_value
    Private flag_integ_mode_SM
    Private write_prop_scale_value
    Private read_prop_scale_value
    Private flag_prop_scale
    Private write_integ_scale_value
    Private read_integ_scale_value
    Private flag_integ_scale
    Private write_prop_scale_acq_value
    Private read_prop_scale_acq_value
    Private flag_prop_scale_acq
    Private write_integ_scale_acq_value
    Private read_integ_scale_acq_value
    Private flag_integ_scale_acq
    Private write_rxMuxCkSel_value
    Private read_rxMuxCkSel_value
    Private flag_rxMuxCkSel
    Private write_glpbk_combo_value
    Private read_glpbk_combo_value
    Private flag_glpbk_combo
    Private write_clockSwitchSel_value
    Private read_clockSwitchSel_value
    Private flag_clockSwitchSel
    Private write_rxck_tst_value
    Private read_rxck_tst_value
    Private flag_rxck_tst
    Private write_rxck_i_value
    Private read_rxck_i_value
    Private flag_rxck_i
    Private write_refclk_value
    Private read_refclk_value
    Private flag_refclk
    Private write_pll_bypass_value
    Private read_pll_bypass_value
    Private flag_pll_bypass
    Private write_allow_increment_PC_value
    Private read_allow_increment_PC_value
    Private flag_allow_increment_PC
    Private write_freq_sel_value
    Private read_freq_sel_value
    Private flag_freq_sel
    Private write_pll_lock_rstb_value
    Private read_pll_lock_rstb_value
    Private flag_pll_lock_rstb
    Private write_pwrdn_value
    Private read_pwrdn_value
    Private flag_pwrdn
    Private write_reset_anlg_value
    Private read_reset_anlg_value
    Private flag_reset_anlg
    Private write_pwrdn_rx_value
    Private read_pwrdn_rx_value
    Private flag_pwrdn_rx
    Private write_pwrdn_pll_value
    Private read_pwrdn_pll_value
    Private flag_pwrdn_pll
    Private write_rxck0_even_value
    Private read_rxck0_even_value
    Private flag_rxck0_even
    Private write_rxck1_even_value
    Private read_rxck1_even_value
    Private flag_rxck1_even
    Private write_comdet_even_value
    Private read_comdet_even_value
    Private flag_comdet_even
    Private write_en_cdet_even_value
    Private read_en_cdet_even_value
    Private flag_en_cdet_even
    Private write_comma_adj_en_even_value
    Private read_comma_adj_en_even_value
    Private flag_comma_adj_en_even
    Private write_rxck0_odd_value
    Private read_rxck0_odd_value
    Private flag_rxck0_odd
    Private write_rxck1_odd_value
    Private read_rxck1_odd_value
    Private flag_rxck1_odd
    Private write_comdet_odd_value
    Private read_comdet_odd_value
    Private flag_comdet_odd
    Private write_en_cdet_odd_value
    Private read_en_cdet_odd_value
    Private flag_en_cdet_odd
    Private write_comma_adj_en_odd_value
    Private read_comma_adj_en_odd_value
    Private flag_comma_adj_en_odd
    Private write_sigdet_value
    Private read_sigdet_value
    Private flag_sigdet
    Private write_prbs_en_value
    Private read_prbs_en_value
    Private flag_prbs_en
    Private write_rstb_tst_value
    Private read_rstb_tst_value
    Private flag_rstb_tst
    Private write_prbs_state_value
    Private read_prbs_state_value
    Private flag_prbs_state
    Private write_enable4_value
    Private read_enable4_value
    Private flag_enable4
    Private write_radr_test_value
    Private read_radr_test_value
    Private flag_radr_test
    Private write_wadr_test_value
    Private read_wadr_test_value
    Private flag_wadr_test
    Private write_rxck_66B_tmux_value
    Private read_rxck_66B_tmux_value
    Private flag_rxck_66B_tmux
    Private write_rstb_66B_value
    Private read_rstb_66B_value
    Private flag_rstb_66B
    Private write_prstb_66B_mux_value
    Private read_prstb_66B_mux_value
    Private flag_prstb_66B_mux
    Private write_rxck_i66_tmux_value
    Private read_rxck_i66_tmux_value
    Private flag_rxck_i66_tmux
    Private write_rstb_i66_value
    Private read_rstb_i66_value
    Private flag_rstb_i66
    Private write_prstb_i66_mux_value
    Private read_prstb_i66_mux_value
    Private flag_prstb_i66_mux
    Private write_rfifo_error_r_value
    Private read_rfifo_error_r_value
    Private flag_rfifo_error_r
    Private write_rfifo_unflow_value
    Private read_rfifo_unflow_value
    Private flag_rfifo_unflow
    Private write_rfifo_ovflow_value
    Private read_rfifo_ovflow_value
    Private flag_rfifo_ovflow
    Private write_integ_status_value
    Private read_integ_status_value
    Private flag_integ_status
    Private write_vco_status_value
    Private read_vco_status_value
    Private flag_vco_status
    Private write_prbs_lock_value
    Private read_prbs_lock_value
    Private flag_prbs_lock
    Private write_prbs_stky_value
    Private read_prbs_stky_value
    Private flag_prbs_stky
    Private write_prbs_errors_value
    Private read_prbs_errors_value
    Private flag_prbs_errors
    Private write_E_count_value
    Private read_E_count_value
    Private flag_E_count

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

    Property Get get_cx4_sigdet
        get_cx4_sigdet = read_cx4_sigdet_value
    End Property

    Property Let set_cx4_sigdet(aData)
        write_cx4_sigdet_value = aData
        flag_cx4_sigdet        = &H1
    End Property

    Property Get read_cx4_sigdet
        read
        read_cx4_sigdet = read_cx4_sigdet_value
    End Property

    Property Let write_cx4_sigdet(aData)
        set_cx4_sigdet = aData
        write
    End Property

    Property Get get_rxSeqDone
        get_rxSeqDone = read_rxSeqDone_value
    End Property

    Property Let set_rxSeqDone(aData)
        write_rxSeqDone_value = aData
        flag_rxSeqDone        = &H1
    End Property

    Property Get read_rxSeqDone
        read
        read_rxSeqDone = read_rxSeqDone_value
    End Property

    Property Let write_rxSeqDone(aData)
        set_rxSeqDone = aData
        write
    End Property

    Property Get get_rx_sigdet_ll
        get_rx_sigdet_ll = read_rx_sigdet_ll_value
    End Property

    Property Let set_rx_sigdet_ll(aData)
        write_rx_sigdet_ll_value = aData
        flag_rx_sigdet_ll        = &H1
    End Property

    Property Get read_rx_sigdet_ll
        read
        read_rx_sigdet_ll = read_rx_sigdet_ll_value
    End Property

    Property Let write_rx_sigdet_ll(aData)
        set_rx_sigdet_ll = aData
        write
    End Property

    Property Get get_cs4_sigdet_ll
        get_cs4_sigdet_ll = read_cs4_sigdet_ll_value
    End Property

    Property Let set_cs4_sigdet_ll(aData)
        write_cs4_sigdet_ll_value = aData
        flag_cs4_sigdet_ll        = &H1
    End Property

    Property Get read_cs4_sigdet_ll
        read
        read_cs4_sigdet_ll = read_cs4_sigdet_ll_value
    End Property

    Property Let write_cs4_sigdet_ll(aData)
        set_cs4_sigdet_ll = aData
        write
    End Property

    Property Get get_rx_reset
        get_rx_reset = read_rx_reset_value
    End Property

    Property Let set_rx_reset(aData)
        write_rx_reset_value = aData
        flag_rx_reset        = &H1
    End Property

    Property Get read_rx_reset
        read
        read_rx_reset = read_rx_reset_value
    End Property

    Property Let write_rx_reset(aData)
        set_rx_reset = aData
        write
    End Property

    Property Get get_rx_pwrdn
        get_rx_pwrdn = read_rx_pwrdn_value
    End Property

    Property Let set_rx_pwrdn(aData)
        write_rx_pwrdn_value = aData
        flag_rx_pwrdn        = &H1
    End Property

    Property Get read_rx_pwrdn
        read
        read_rx_pwrdn = read_rx_pwrdn_value
    End Property

    Property Let write_rx_pwrdn(aData)
        set_rx_pwrdn = aData
        write
    End Property

    Property Get get_test_acq_en
        get_test_acq_en = read_test_acq_en_value
    End Property

    Property Let set_test_acq_en(aData)
        write_test_acq_en_value = aData
        flag_test_acq_en        = &H1
    End Property

    Property Get read_test_acq_en
        read
        read_test_acq_en = read_test_acq_en_value
    End Property

    Property Let write_test_acq_en(aData)
        set_test_acq_en = aData
        write
    End Property

    Property Get get_rxSeqStart
        get_rxSeqStart = read_rxSeqStart_value
    End Property

    Property Let set_rxSeqStart(aData)
        write_rxSeqStart_value = aData
        flag_rxSeqStart        = &H1
    End Property

    Property Get read_rxSeqStart
        read
        read_rxSeqStart = read_rxSeqStart_value
    End Property

    Property Let write_rxSeqStart(aData)
        set_rxSeqStart = aData
        write
    End Property

    Property Get get_mux_comadj_sync_status
        get_mux_comadj_sync_status = read_mux_comadj_sync_status_value
    End Property

    Property Let set_mux_comadj_sync_status(aData)
        write_mux_comadj_sync_status_value = aData
        flag_mux_comadj_sync_status        = &H1
    End Property

    Property Get read_mux_comadj_sync_status
        read
        read_mux_comadj_sync_status = read_mux_comadj_sync_status_value
    End Property

    Property Let write_mux_comadj_sync_status(aData)
        set_mux_comadj_sync_status = aData
        write
    End Property

    Property Get get_sync_status
        get_sync_status = read_sync_status_value
    End Property

    Property Let set_sync_status(aData)
        write_sync_status_value = aData
        flag_sync_status        = &H1
    End Property

    Property Get read_sync_status
        read
        read_sync_status = read_sync_status_value
    End Property

    Property Let write_sync_status(aData)
        set_sync_status = aData
        write
    End Property

    Property Get get_rx_sigdet
        get_rx_sigdet = read_rx_sigdet_value
    End Property

    Property Let set_rx_sigdet(aData)
        write_rx_sigdet_value = aData
        flag_rx_sigdet        = &H1
    End Property

    Property Get read_rx_sigdet
        read
        read_rx_sigdet = read_rx_sigdet_value
    End Property

    Property Let write_rx_sigdet(aData)
        set_rx_sigdet = aData
        write
    End Property

    Property Get get_saturate_status
        get_saturate_status = read_saturate_status_value
    End Property

    Property Let set_saturate_status(aData)
        write_saturate_status_value = aData
        flag_saturate_status        = &H1
    End Property

    Property Get read_saturate_status
        read
        read_saturate_status = read_saturate_status_value
    End Property

    Property Let write_saturate_status(aData)
        set_saturate_status = aData
        write
    End Property

    Property Get get_indck_mode_en
        get_indck_mode_en = read_indck_mode_en_value
    End Property

    Property Let set_indck_mode_en(aData)
        write_indck_mode_en_value = aData
        flag_indck_mode_en        = &H1
    End Property

    Property Get read_indck_mode_en
        read
        read_indck_mode_en = read_indck_mode_en_value
    End Property

    Property Let write_indck_mode_en(aData)
        set_indck_mode_en = aData
        write
    End Property

    Property Get get_pci_mode_en
        get_pci_mode_en = read_pci_mode_en_value
    End Property

    Property Let set_pci_mode_en(aData)
        write_pci_mode_en_value = aData
        flag_pci_mode_en        = &H1
    End Property

    Property Get read_pci_mode_en
        read
        read_pci_mode_en = read_pci_mode_en_value
    End Property

    Property Let write_pci_mode_en(aData)
        set_pci_mode_en = aData
        write
    End Property

    Property Get get_rx_polarity
        get_rx_polarity = read_rx_polarity_value
    End Property

    Property Let set_rx_polarity(aData)
        write_rx_polarity_value = aData
        flag_rx_polarity        = &H1
    End Property

    Property Get read_rx_polarity
        read
        read_rx_polarity = read_rx_polarity_value
    End Property

    Property Let write_rx_polarity(aData)
        set_rx_polarity = aData
        write
    End Property

    Property Get get_rxpol_flip
        get_rxpol_flip = read_rxpol_flip_value
    End Property

    Property Let set_rxpol_flip(aData)
        write_rxpol_flip_value = aData
        flag_rxpol_flip        = &H1
    End Property

    Property Get read_rxpol_flip
        read
        read_rxpol_flip = read_rxpol_flip_value
    End Property

    Property Let write_rxpol_flip(aData)
        set_rxpol_flip = aData
        write
    End Property

    Property Get get_comma_mask
        get_comma_mask = read_comma_mask_value
    End Property

    Property Let set_comma_mask(aData)
        write_comma_mask_value = aData
        flag_comma_mask        = &H1
    End Property

    Property Get read_comma_mask
        read
        read_comma_mask = read_comma_mask_value
    End Property

    Property Let write_comma_mask(aData)
        set_comma_mask = aData
        write
    End Property

    Property Get get_link_en_r
        get_link_en_r = read_link_en_r_value
    End Property

    Property Let set_link_en_r(aData)
        write_link_en_r_value = aData
        flag_link_en_r        = &H1
    End Property

    Property Get read_link_en_r
        read
        read_link_en_r = read_link_en_r_value
    End Property

    Property Let write_link_en_r(aData)
        set_link_en_r = aData
        write
    End Property

    Property Get get_comma_adj_en
        get_comma_adj_en = read_comma_adj_en_value
    End Property

    Property Let set_comma_adj_en(aData)
        write_comma_adj_en_value = aData
        flag_comma_adj_en        = &H1
    End Property

    Property Get read_comma_adj_en
        read
        read_comma_adj_en = read_comma_adj_en_value
    End Property

    Property Let write_comma_adj_en(aData)
        set_comma_adj_en = aData
        write
    End Property

    Property Get get_comma_adj_en_ext
        get_comma_adj_en_ext = read_comma_adj_en_ext_value
    End Property

    Property Let set_comma_adj_en_ext(aData)
        write_comma_adj_en_ext_value = aData
        flag_comma_adj_en_ext        = &H1
    End Property

    Property Get read_comma_adj_en_ext
        read
        read_comma_adj_en_ext = read_comma_adj_en_ext_value
    End Property

    Property Let write_comma_adj_en_ext(aData)
        set_comma_adj_en_ext = aData
        write
    End Property

    Property Get get_cdrAcqDone_r2
        get_cdrAcqDone_r2 = read_cdrAcqDone_r2_value
    End Property

    Property Let set_cdrAcqDone_r2(aData)
        write_cdrAcqDone_r2_value = aData
        flag_cdrAcqDone_r2        = &H1
    End Property

    Property Get read_cdrAcqDone_r2
        read
        read_cdrAcqDone_r2 = read_cdrAcqDone_r2_value
    End Property

    Property Let write_cdrAcqDone_r2(aData)
        set_cdrAcqDone_r2 = aData
        write
    End Property

    Property Get get_freq_sel_PC
        get_freq_sel_PC = read_freq_sel_PC_value
    End Property

    Property Let set_freq_sel_PC(aData)
        write_freq_sel_PC_value = aData
        flag_freq_sel_PC        = &H1
    End Property

    Property Get read_freq_sel_PC
        read
        read_freq_sel_PC = read_freq_sel_PC_value
    End Property

    Property Let write_freq_sel_PC(aData)
        set_freq_sel_PC = aData
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

    Property Get get_integ_mode_SM
        get_integ_mode_SM = read_integ_mode_SM_value
    End Property

    Property Let set_integ_mode_SM(aData)
        write_integ_mode_SM_value = aData
        flag_integ_mode_SM        = &H1
    End Property

    Property Get read_integ_mode_SM
        read
        read_integ_mode_SM = read_integ_mode_SM_value
    End Property

    Property Let write_integ_mode_SM(aData)
        set_integ_mode_SM = aData
        write
    End Property

    Property Get get_prop_scale
        get_prop_scale = read_prop_scale_value
    End Property

    Property Let set_prop_scale(aData)
        write_prop_scale_value = aData
        flag_prop_scale        = &H1
    End Property

    Property Get read_prop_scale
        read
        read_prop_scale = read_prop_scale_value
    End Property

    Property Let write_prop_scale(aData)
        set_prop_scale = aData
        write
    End Property

    Property Get get_integ_scale
        get_integ_scale = read_integ_scale_value
    End Property

    Property Let set_integ_scale(aData)
        write_integ_scale_value = aData
        flag_integ_scale        = &H1
    End Property

    Property Get read_integ_scale
        read
        read_integ_scale = read_integ_scale_value
    End Property

    Property Let write_integ_scale(aData)
        set_integ_scale = aData
        write
    End Property

    Property Get get_prop_scale_acq
        get_prop_scale_acq = read_prop_scale_acq_value
    End Property

    Property Let set_prop_scale_acq(aData)
        write_prop_scale_acq_value = aData
        flag_prop_scale_acq        = &H1
    End Property

    Property Get read_prop_scale_acq
        read
        read_prop_scale_acq = read_prop_scale_acq_value
    End Property

    Property Let write_prop_scale_acq(aData)
        set_prop_scale_acq = aData
        write
    End Property

    Property Get get_integ_scale_acq
        get_integ_scale_acq = read_integ_scale_acq_value
    End Property

    Property Let set_integ_scale_acq(aData)
        write_integ_scale_acq_value = aData
        flag_integ_scale_acq        = &H1
    End Property

    Property Get read_integ_scale_acq
        read
        read_integ_scale_acq = read_integ_scale_acq_value
    End Property

    Property Let write_integ_scale_acq(aData)
        set_integ_scale_acq = aData
        write
    End Property

    Property Get get_rxMuxCkSel
        get_rxMuxCkSel = read_rxMuxCkSel_value
    End Property

    Property Let set_rxMuxCkSel(aData)
        write_rxMuxCkSel_value = aData
        flag_rxMuxCkSel        = &H1
    End Property

    Property Get read_rxMuxCkSel
        read
        read_rxMuxCkSel = read_rxMuxCkSel_value
    End Property

    Property Let write_rxMuxCkSel(aData)
        set_rxMuxCkSel = aData
        write
    End Property

    Property Get get_glpbk_combo
        get_glpbk_combo = read_glpbk_combo_value
    End Property

    Property Let set_glpbk_combo(aData)
        write_glpbk_combo_value = aData
        flag_glpbk_combo        = &H1
    End Property

    Property Get read_glpbk_combo
        read
        read_glpbk_combo = read_glpbk_combo_value
    End Property

    Property Let write_glpbk_combo(aData)
        set_glpbk_combo = aData
        write
    End Property

    Property Get get_clockSwitchSel
        get_clockSwitchSel = read_clockSwitchSel_value
    End Property

    Property Let set_clockSwitchSel(aData)
        write_clockSwitchSel_value = aData
        flag_clockSwitchSel        = &H1
    End Property

    Property Get read_clockSwitchSel
        read
        read_clockSwitchSel = read_clockSwitchSel_value
    End Property

    Property Let write_clockSwitchSel(aData)
        set_clockSwitchSel = aData
        write
    End Property

    Property Get get_rxck_tst
        get_rxck_tst = read_rxck_tst_value
    End Property

    Property Let set_rxck_tst(aData)
        write_rxck_tst_value = aData
        flag_rxck_tst        = &H1
    End Property

    Property Get read_rxck_tst
        read
        read_rxck_tst = read_rxck_tst_value
    End Property

    Property Let write_rxck_tst(aData)
        set_rxck_tst = aData
        write
    End Property

    Property Get get_rxck_i
        get_rxck_i = read_rxck_i_value
    End Property

    Property Let set_rxck_i(aData)
        write_rxck_i_value = aData
        flag_rxck_i        = &H1
    End Property

    Property Get read_rxck_i
        read
        read_rxck_i = read_rxck_i_value
    End Property

    Property Let write_rxck_i(aData)
        set_rxck_i = aData
        write
    End Property

    Property Get get_refclk
        get_refclk = read_refclk_value
    End Property

    Property Let set_refclk(aData)
        write_refclk_value = aData
        flag_refclk        = &H1
    End Property

    Property Get read_refclk
        read
        read_refclk = read_refclk_value
    End Property

    Property Let write_refclk(aData)
        set_refclk = aData
        write
    End Property

    Property Get get_pll_bypass
        get_pll_bypass = read_pll_bypass_value
    End Property

    Property Let set_pll_bypass(aData)
        write_pll_bypass_value = aData
        flag_pll_bypass        = &H1
    End Property

    Property Get read_pll_bypass
        read
        read_pll_bypass = read_pll_bypass_value
    End Property

    Property Let write_pll_bypass(aData)
        set_pll_bypass = aData
        write
    End Property

    Property Get get_allow_increment_PC
        get_allow_increment_PC = read_allow_increment_PC_value
    End Property

    Property Let set_allow_increment_PC(aData)
        write_allow_increment_PC_value = aData
        flag_allow_increment_PC        = &H1
    End Property

    Property Get read_allow_increment_PC
        read
        read_allow_increment_PC = read_allow_increment_PC_value
    End Property

    Property Let write_allow_increment_PC(aData)
        set_allow_increment_PC = aData
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

    Property Get get_pll_lock_rstb
        get_pll_lock_rstb = read_pll_lock_rstb_value
    End Property

    Property Let set_pll_lock_rstb(aData)
        write_pll_lock_rstb_value = aData
        flag_pll_lock_rstb        = &H1
    End Property

    Property Get read_pll_lock_rstb
        read
        read_pll_lock_rstb = read_pll_lock_rstb_value
    End Property

    Property Let write_pll_lock_rstb(aData)
        set_pll_lock_rstb = aData
        write
    End Property

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

    Property Get get_reset_anlg
        get_reset_anlg = read_reset_anlg_value
    End Property

    Property Let set_reset_anlg(aData)
        write_reset_anlg_value = aData
        flag_reset_anlg        = &H1
    End Property

    Property Get read_reset_anlg
        read
        read_reset_anlg = read_reset_anlg_value
    End Property

    Property Let write_reset_anlg(aData)
        set_reset_anlg = aData
        write
    End Property

    Property Get get_pwrdn_rx
        get_pwrdn_rx = read_pwrdn_rx_value
    End Property

    Property Let set_pwrdn_rx(aData)
        write_pwrdn_rx_value = aData
        flag_pwrdn_rx        = &H1
    End Property

    Property Get read_pwrdn_rx
        read
        read_pwrdn_rx = read_pwrdn_rx_value
    End Property

    Property Let write_pwrdn_rx(aData)
        set_pwrdn_rx = aData
        write
    End Property

    Property Get get_pwrdn_pll
        get_pwrdn_pll = read_pwrdn_pll_value
    End Property

    Property Let set_pwrdn_pll(aData)
        write_pwrdn_pll_value = aData
        flag_pwrdn_pll        = &H1
    End Property

    Property Get read_pwrdn_pll
        read
        read_pwrdn_pll = read_pwrdn_pll_value
    End Property

    Property Let write_pwrdn_pll(aData)
        set_pwrdn_pll = aData
        write
    End Property

    Property Get get_rxck0_even
        get_rxck0_even = read_rxck0_even_value
    End Property

    Property Let set_rxck0_even(aData)
        write_rxck0_even_value = aData
        flag_rxck0_even        = &H1
    End Property

    Property Get read_rxck0_even
        read
        read_rxck0_even = read_rxck0_even_value
    End Property

    Property Let write_rxck0_even(aData)
        set_rxck0_even = aData
        write
    End Property

    Property Get get_rxck1_even
        get_rxck1_even = read_rxck1_even_value
    End Property

    Property Let set_rxck1_even(aData)
        write_rxck1_even_value = aData
        flag_rxck1_even        = &H1
    End Property

    Property Get read_rxck1_even
        read
        read_rxck1_even = read_rxck1_even_value
    End Property

    Property Let write_rxck1_even(aData)
        set_rxck1_even = aData
        write
    End Property

    Property Get get_comdet_even
        get_comdet_even = read_comdet_even_value
    End Property

    Property Let set_comdet_even(aData)
        write_comdet_even_value = aData
        flag_comdet_even        = &H1
    End Property

    Property Get read_comdet_even
        read
        read_comdet_even = read_comdet_even_value
    End Property

    Property Let write_comdet_even(aData)
        set_comdet_even = aData
        write
    End Property

    Property Get get_en_cdet_even
        get_en_cdet_even = read_en_cdet_even_value
    End Property

    Property Let set_en_cdet_even(aData)
        write_en_cdet_even_value = aData
        flag_en_cdet_even        = &H1
    End Property

    Property Get read_en_cdet_even
        read
        read_en_cdet_even = read_en_cdet_even_value
    End Property

    Property Let write_en_cdet_even(aData)
        set_en_cdet_even = aData
        write
    End Property

    Property Get get_comma_adj_en_even
        get_comma_adj_en_even = read_comma_adj_en_even_value
    End Property

    Property Let set_comma_adj_en_even(aData)
        write_comma_adj_en_even_value = aData
        flag_comma_adj_en_even        = &H1
    End Property

    Property Get read_comma_adj_en_even
        read
        read_comma_adj_en_even = read_comma_adj_en_even_value
    End Property

    Property Let write_comma_adj_en_even(aData)
        set_comma_adj_en_even = aData
        write
    End Property

    Property Get get_rxck0_odd
        get_rxck0_odd = read_rxck0_odd_value
    End Property

    Property Let set_rxck0_odd(aData)
        write_rxck0_odd_value = aData
        flag_rxck0_odd        = &H1
    End Property

    Property Get read_rxck0_odd
        read
        read_rxck0_odd = read_rxck0_odd_value
    End Property

    Property Let write_rxck0_odd(aData)
        set_rxck0_odd = aData
        write
    End Property

    Property Get get_rxck1_odd
        get_rxck1_odd = read_rxck1_odd_value
    End Property

    Property Let set_rxck1_odd(aData)
        write_rxck1_odd_value = aData
        flag_rxck1_odd        = &H1
    End Property

    Property Get read_rxck1_odd
        read
        read_rxck1_odd = read_rxck1_odd_value
    End Property

    Property Let write_rxck1_odd(aData)
        set_rxck1_odd = aData
        write
    End Property

    Property Get get_comdet_odd
        get_comdet_odd = read_comdet_odd_value
    End Property

    Property Let set_comdet_odd(aData)
        write_comdet_odd_value = aData
        flag_comdet_odd        = &H1
    End Property

    Property Get read_comdet_odd
        read
        read_comdet_odd = read_comdet_odd_value
    End Property

    Property Let write_comdet_odd(aData)
        set_comdet_odd = aData
        write
    End Property

    Property Get get_en_cdet_odd
        get_en_cdet_odd = read_en_cdet_odd_value
    End Property

    Property Let set_en_cdet_odd(aData)
        write_en_cdet_odd_value = aData
        flag_en_cdet_odd        = &H1
    End Property

    Property Get read_en_cdet_odd
        read
        read_en_cdet_odd = read_en_cdet_odd_value
    End Property

    Property Let write_en_cdet_odd(aData)
        set_en_cdet_odd = aData
        write
    End Property

    Property Get get_comma_adj_en_odd
        get_comma_adj_en_odd = read_comma_adj_en_odd_value
    End Property

    Property Let set_comma_adj_en_odd(aData)
        write_comma_adj_en_odd_value = aData
        flag_comma_adj_en_odd        = &H1
    End Property

    Property Get read_comma_adj_en_odd
        read
        read_comma_adj_en_odd = read_comma_adj_en_odd_value
    End Property

    Property Let write_comma_adj_en_odd(aData)
        set_comma_adj_en_odd = aData
        write
    End Property

    Property Get get_sigdet
        get_sigdet = read_sigdet_value
    End Property

    Property Let set_sigdet(aData)
        write_sigdet_value = aData
        flag_sigdet        = &H1
    End Property

    Property Get read_sigdet
        read
        read_sigdet = read_sigdet_value
    End Property

    Property Let write_sigdet(aData)
        set_sigdet = aData
        write
    End Property

    Property Get get_prbs_en
        get_prbs_en = read_prbs_en_value
    End Property

    Property Let set_prbs_en(aData)
        write_prbs_en_value = aData
        flag_prbs_en        = &H1
    End Property

    Property Get read_prbs_en
        read
        read_prbs_en = read_prbs_en_value
    End Property

    Property Let write_prbs_en(aData)
        set_prbs_en = aData
        write
    End Property

    Property Get get_rstb_tst
        get_rstb_tst = read_rstb_tst_value
    End Property

    Property Let set_rstb_tst(aData)
        write_rstb_tst_value = aData
        flag_rstb_tst        = &H1
    End Property

    Property Get read_rstb_tst
        read
        read_rstb_tst = read_rstb_tst_value
    End Property

    Property Let write_rstb_tst(aData)
        set_rstb_tst = aData
        write
    End Property

    Property Get get_prbs_state
        get_prbs_state = read_prbs_state_value
    End Property

    Property Let set_prbs_state(aData)
        write_prbs_state_value = aData
        flag_prbs_state        = &H1
    End Property

    Property Get read_prbs_state
        read
        read_prbs_state = read_prbs_state_value
    End Property

    Property Let write_prbs_state(aData)
        set_prbs_state = aData
        write
    End Property

    Property Get get_enable4
        get_enable4 = read_enable4_value
    End Property

    Property Let set_enable4(aData)
        write_enable4_value = aData
        flag_enable4        = &H1
    End Property

    Property Get read_enable4
        read
        read_enable4 = read_enable4_value
    End Property

    Property Let write_enable4(aData)
        set_enable4 = aData
        write
    End Property

    Property Get get_radr_test
        get_radr_test = read_radr_test_value
    End Property

    Property Let set_radr_test(aData)
        write_radr_test_value = aData
        flag_radr_test        = &H1
    End Property

    Property Get read_radr_test
        read
        read_radr_test = read_radr_test_value
    End Property

    Property Let write_radr_test(aData)
        set_radr_test = aData
        write
    End Property

    Property Get get_wadr_test
        get_wadr_test = read_wadr_test_value
    End Property

    Property Let set_wadr_test(aData)
        write_wadr_test_value = aData
        flag_wadr_test        = &H1
    End Property

    Property Get read_wadr_test
        read
        read_wadr_test = read_wadr_test_value
    End Property

    Property Let write_wadr_test(aData)
        set_wadr_test = aData
        write
    End Property

    Property Get get_rxck_66B_tmux
        get_rxck_66B_tmux = read_rxck_66B_tmux_value
    End Property

    Property Let set_rxck_66B_tmux(aData)
        write_rxck_66B_tmux_value = aData
        flag_rxck_66B_tmux        = &H1
    End Property

    Property Get read_rxck_66B_tmux
        read
        read_rxck_66B_tmux = read_rxck_66B_tmux_value
    End Property

    Property Let write_rxck_66B_tmux(aData)
        set_rxck_66B_tmux = aData
        write
    End Property

    Property Get get_rstb_66B
        get_rstb_66B = read_rstb_66B_value
    End Property

    Property Let set_rstb_66B(aData)
        write_rstb_66B_value = aData
        flag_rstb_66B        = &H1
    End Property

    Property Get read_rstb_66B
        read
        read_rstb_66B = read_rstb_66B_value
    End Property

    Property Let write_rstb_66B(aData)
        set_rstb_66B = aData
        write
    End Property

    Property Get get_prstb_66B_mux
        get_prstb_66B_mux = read_prstb_66B_mux_value
    End Property

    Property Let set_prstb_66B_mux(aData)
        write_prstb_66B_mux_value = aData
        flag_prstb_66B_mux        = &H1
    End Property

    Property Get read_prstb_66B_mux
        read
        read_prstb_66B_mux = read_prstb_66B_mux_value
    End Property

    Property Let write_prstb_66B_mux(aData)
        set_prstb_66B_mux = aData
        write
    End Property

    Property Get get_rxck_i66_tmux
        get_rxck_i66_tmux = read_rxck_i66_tmux_value
    End Property

    Property Let set_rxck_i66_tmux(aData)
        write_rxck_i66_tmux_value = aData
        flag_rxck_i66_tmux        = &H1
    End Property

    Property Get read_rxck_i66_tmux
        read
        read_rxck_i66_tmux = read_rxck_i66_tmux_value
    End Property

    Property Let write_rxck_i66_tmux(aData)
        set_rxck_i66_tmux = aData
        write
    End Property

    Property Get get_rstb_i66
        get_rstb_i66 = read_rstb_i66_value
    End Property

    Property Let set_rstb_i66(aData)
        write_rstb_i66_value = aData
        flag_rstb_i66        = &H1
    End Property

    Property Get read_rstb_i66
        read
        read_rstb_i66 = read_rstb_i66_value
    End Property

    Property Let write_rstb_i66(aData)
        set_rstb_i66 = aData
        write
    End Property

    Property Get get_prstb_i66_mux
        get_prstb_i66_mux = read_prstb_i66_mux_value
    End Property

    Property Let set_prstb_i66_mux(aData)
        write_prstb_i66_mux_value = aData
        flag_prstb_i66_mux        = &H1
    End Property

    Property Get read_prstb_i66_mux
        read
        read_prstb_i66_mux = read_prstb_i66_mux_value
    End Property

    Property Let write_prstb_i66_mux(aData)
        set_prstb_i66_mux = aData
        write
    End Property

    Property Get get_rfifo_error_r
        get_rfifo_error_r = read_rfifo_error_r_value
    End Property

    Property Let set_rfifo_error_r(aData)
        write_rfifo_error_r_value = aData
        flag_rfifo_error_r        = &H1
    End Property

    Property Get read_rfifo_error_r
        read
        read_rfifo_error_r = read_rfifo_error_r_value
    End Property

    Property Let write_rfifo_error_r(aData)
        set_rfifo_error_r = aData
        write
    End Property

    Property Get get_rfifo_unflow
        get_rfifo_unflow = read_rfifo_unflow_value
    End Property

    Property Let set_rfifo_unflow(aData)
        write_rfifo_unflow_value = aData
        flag_rfifo_unflow        = &H1
    End Property

    Property Get read_rfifo_unflow
        read
        read_rfifo_unflow = read_rfifo_unflow_value
    End Property

    Property Let write_rfifo_unflow(aData)
        set_rfifo_unflow = aData
        write
    End Property

    Property Get get_rfifo_ovflow
        get_rfifo_ovflow = read_rfifo_ovflow_value
    End Property

    Property Let set_rfifo_ovflow(aData)
        write_rfifo_ovflow_value = aData
        flag_rfifo_ovflow        = &H1
    End Property

    Property Get read_rfifo_ovflow
        read
        read_rfifo_ovflow = read_rfifo_ovflow_value
    End Property

    Property Let write_rfifo_ovflow(aData)
        set_rfifo_ovflow = aData
        write
    End Property

    Property Get get_integ_status
        get_integ_status = read_integ_status_value
    End Property

    Property Let set_integ_status(aData)
        write_integ_status_value = aData
        flag_integ_status        = &H1
    End Property

    Property Get read_integ_status
        read
        read_integ_status = read_integ_status_value
    End Property

    Property Let write_integ_status(aData)
        set_integ_status = aData
        write
    End Property

    Property Get get_vco_status
        get_vco_status = read_vco_status_value
    End Property

    Property Let set_vco_status(aData)
        write_vco_status_value = aData
        flag_vco_status        = &H1
    End Property

    Property Get read_vco_status
        read
        read_vco_status = read_vco_status_value
    End Property

    Property Let write_vco_status(aData)
        set_vco_status = aData
        write
    End Property

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

    Property Get get_E_count
        get_E_count = read_E_count_value
    End Property

    Property Let set_E_count(aData)
        write_E_count_value = aData
        flag_E_count        = &H1
    End Property

    Property Get read_E_count
        read
        read_E_count = read_E_count_value
    End Property

    Property Let write_E_count(aData)
        set_E_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cx4_sigdet_value = rightShift(data_low, 1) and &H1
        rxSeqDone_mask = &H1
        if data_low > LONG_MAX then
            if rxSeqDone_mask = mask then
                read_rxSeqDone_value = data_low
            else
                read_rxSeqDone_value = (data_low - H8000_0000) and rxSeqDone_mask
            end If
        else
            read_rxSeqDone_value = data_low and rxSeqDone_mask
        end If
        read_rx_sigdet_ll_value = rightShift(data_low, 11) and &H1
        read_cs4_sigdet_ll_value = rightShift(data_low, 10) and &H1
        read_rx_reset_value = rightShift(data_low, 4) and &H1
        read_rx_pwrdn_value = rightShift(data_low, 3) and &H1
        read_test_acq_en_value = rightShift(data_low, 10) and &H1
        read_rxSeqStart_value = rightShift(data_low, 3) and &H1
        read_mux_comadj_sync_status_value = rightShift(data_low, 7) and &H1
        read_sync_status_value = rightShift(data_low, 15) and &H1
        read_rx_sigdet_value = rightShift(data_low, 5) and &H1
        read_saturate_status_value = rightShift(data_low, 2) and &H1
        read_indck_mode_en_value = rightShift(data_low, 9) and &H1
        read_pci_mode_en_value = rightShift(data_low, 8) and &H1
        read_rx_polarity_value = rightShift(data_low, 7) and &H1
        read_rxpol_flip_value = rightShift(data_low, 6) and &H1
        read_comma_mask_value = rightShift(data_low, 5) and &H1
        read_link_en_r_value = rightShift(data_low, 4) and &H1
        read_comma_adj_en_value = rightShift(data_low, 3) and &H1
        read_comma_adj_en_ext_value = rightShift(data_low, 2) and &H1
        read_cdrAcqDone_r2_value = rightShift(data_low, 4) and &H1
        read_freq_sel_PC_value = rightShift(data_low, 3) and &H1
        read_freq_sel_SM_value = rightShift(data_low, 2) and &H1
        integ_mode_SM_mask = &H3
        if data_low > LONG_MAX then
            if integ_mode_SM_mask = mask then
                read_integ_mode_SM_value = data_low
            else
                read_integ_mode_SM_value = (data_low - H8000_0000) and integ_mode_SM_mask
            end If
        else
            read_integ_mode_SM_value = data_low and integ_mode_SM_mask
        end If
        read_prop_scale_value = rightShift(data_low, 12) and &Hf
        read_integ_scale_value = rightShift(data_low, 8) and &Hf
        read_prop_scale_acq_value = rightShift(data_low, 4) and &Hf
        integ_scale_acq_mask = &Hf
        if data_low > LONG_MAX then
            if integ_scale_acq_mask = mask then
                read_integ_scale_acq_value = data_low
            else
                read_integ_scale_acq_value = (data_low - H8000_0000) and integ_scale_acq_mask
            end If
        else
            read_integ_scale_acq_value = data_low and integ_scale_acq_mask
        end If
        read_rxMuxCkSel_value = rightShift(data_low, 5) and &H1
        read_glpbk_combo_value = rightShift(data_low, 5) and &H1
        read_clockSwitchSel_value = rightShift(data_low, 4) and &H1
        read_rxck_tst_value = rightShift(data_low, 3) and &H1
        read_rxck_i_value = rightShift(data_low, 2) and &H1
        read_refclk_value = rightShift(data_low, 1) and &H1
        pll_bypass_mask = &H1
        if data_low > LONG_MAX then
            if pll_bypass_mask = mask then
                read_pll_bypass_value = data_low
            else
                read_pll_bypass_value = (data_low - H8000_0000) and pll_bypass_mask
            end If
        else
            read_pll_bypass_value = data_low and pll_bypass_mask
        end If
        allow_increment_PC_mask = &H1
        if data_low > LONG_MAX then
            if allow_increment_PC_mask = mask then
                read_allow_increment_PC_value = data_low
            else
                read_allow_increment_PC_value = (data_low - H8000_0000) and allow_increment_PC_mask
            end If
        else
            read_allow_increment_PC_value = data_low and allow_increment_PC_mask
        end If
        read_freq_sel_value = rightShift(data_low, 6) and &H1
        read_pll_lock_rstb_value = rightShift(data_low, 5) and &H1
        read_pwrdn_value = rightShift(data_low, 4) and &H1
        read_reset_anlg_value = rightShift(data_low, 2) and &H1
        read_pwrdn_rx_value = rightShift(data_low, 1) and &H1
        pwrdn_pll_mask = &H1
        if data_low > LONG_MAX then
            if pwrdn_pll_mask = mask then
                read_pwrdn_pll_value = data_low
            else
                read_pwrdn_pll_value = (data_low - H8000_0000) and pwrdn_pll_mask
            end If
        else
            read_pwrdn_pll_value = data_low and pwrdn_pll_mask
        end If
        read_rxck0_even_value = rightShift(data_low, 4) and &H1
        read_rxck1_even_value = rightShift(data_low, 3) and &H1
        read_comdet_even_value = rightShift(data_low, 2) and &H1
        read_en_cdet_even_value = rightShift(data_low, 1) and &H1
        comma_adj_en_even_mask = &H1
        if data_low > LONG_MAX then
            if comma_adj_en_even_mask = mask then
                read_comma_adj_en_even_value = data_low
            else
                read_comma_adj_en_even_value = (data_low - H8000_0000) and comma_adj_en_even_mask
            end If
        else
            read_comma_adj_en_even_value = data_low and comma_adj_en_even_mask
        end If
        read_rxck0_odd_value = rightShift(data_low, 4) and &H1
        read_rxck1_odd_value = rightShift(data_low, 3) and &H1
        read_comdet_odd_value = rightShift(data_low, 2) and &H1
        read_en_cdet_odd_value = rightShift(data_low, 1) and &H1
        comma_adj_en_odd_mask = &H1
        if data_low > LONG_MAX then
            if comma_adj_en_odd_mask = mask then
                read_comma_adj_en_odd_value = data_low
            else
                read_comma_adj_en_odd_value = (data_low - H8000_0000) and comma_adj_en_odd_mask
            end If
        else
            read_comma_adj_en_odd_value = data_low and comma_adj_en_odd_mask
        end If
        sigdet_mask = &H1
        if data_low > LONG_MAX then
            if sigdet_mask = mask then
                read_sigdet_value = data_low
            else
                read_sigdet_value = (data_low - H8000_0000) and sigdet_mask
            end If
        else
            read_sigdet_value = data_low and sigdet_mask
        end If
        read_prbs_en_value = rightShift(data_low, 6) and &H1
        read_rstb_tst_value = rightShift(data_low, 5) and &H1
        prbs_state_mask = &Hf
        if data_low > LONG_MAX then
            if prbs_state_mask = mask then
                read_prbs_state_value = data_low
            else
                read_prbs_state_value = (data_low - H8000_0000) and prbs_state_mask
            end If
        else
            read_prbs_state_value = data_low and prbs_state_mask
        end If
        read_enable4_value = rightShift(data_low, 5) and &H1
        radr_test_mask = &H1f
        if data_low > LONG_MAX then
            if radr_test_mask = mask then
                read_radr_test_value = data_low
            else
                read_radr_test_value = (data_low - H8000_0000) and radr_test_mask
            end If
        else
            read_radr_test_value = data_low and radr_test_mask
        end If
        wadr_test_mask = &H1f
        if data_low > LONG_MAX then
            if wadr_test_mask = mask then
                read_wadr_test_value = data_low
            else
                read_wadr_test_value = (data_low - H8000_0000) and wadr_test_mask
            end If
        else
            read_wadr_test_value = data_low and wadr_test_mask
        end If
        read_rxck_66B_tmux_value = rightShift(data_low, 5) and &H1
        read_rstb_66B_value = rightShift(data_low, 4) and &H1
        read_prstb_66B_mux_value = rightShift(data_low, 3) and &H1
        read_rxck_i66_tmux_value = rightShift(data_low, 2) and &H1
        read_rstb_i66_value = rightShift(data_low, 1) and &H1
        prstb_i66_mux_mask = &H1
        if data_low > LONG_MAX then
            if prstb_i66_mux_mask = mask then
                read_prstb_i66_mux_value = data_low
            else
                read_prstb_i66_mux_value = (data_low - H8000_0000) and prstb_i66_mux_mask
            end If
        else
            read_prstb_i66_mux_value = data_low and prstb_i66_mux_mask
        end If
        read_rfifo_error_r_value = rightShift(data_low, 2) and &H3
        read_rfifo_unflow_value = rightShift(data_low, 1) and &H1
        rfifo_ovflow_mask = &H1
        if data_low > LONG_MAX then
            if rfifo_ovflow_mask = mask then
                read_rfifo_ovflow_value = data_low
            else
                read_rfifo_ovflow_value = (data_low - H8000_0000) and rfifo_ovflow_mask
            end If
        else
            read_rfifo_ovflow_value = data_low and rfifo_ovflow_mask
        end If
        integ_status_mask = &Hffff
        if data_low > LONG_MAX then
            if integ_status_mask = mask then
                read_integ_status_value = data_low
            else
                read_integ_status_value = (data_low - H8000_0000) and integ_status_mask
            end If
        else
            read_integ_status_value = data_low and integ_status_mask
        end If
        vco_status_mask = &Hffff
        if data_low > LONG_MAX then
            if vco_status_mask = mask then
                read_vco_status_value = data_low
            else
                read_vco_status_value = (data_low - H8000_0000) and vco_status_mask
            end If
        else
            read_vco_status_value = data_low and vco_status_mask
        end If
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
        E_count_mask = &H7fff
        if data_low > LONG_MAX then
            if E_count_mask = mask then
                read_E_count_value = data_low
            else
                read_E_count_value = (data_low - H8000_0000) and E_count_mask
            end If
        else
            read_E_count_value = data_low and E_count_mask
        end If

    End Sub

    Sub write
        If flag_cx4_sigdet = &H0 or flag_rxSeqDone = &H0 or flag_rx_sigdet_ll = &H0 or flag_cs4_sigdet_ll = &H0 or flag_rx_reset = &H0 or flag_rx_pwrdn = &H0 or flag_test_acq_en = &H0 or flag_rxSeqStart = &H0 or flag_mux_comadj_sync_status = &H0 or flag_sync_status = &H0 or flag_rx_sigdet = &H0 or flag_saturate_status = &H0 or flag_indck_mode_en = &H0 or flag_pci_mode_en = &H0 or flag_rx_polarity = &H0 or flag_rxpol_flip = &H0 or flag_comma_mask = &H0 or flag_link_en_r = &H0 or flag_comma_adj_en = &H0 or flag_comma_adj_en_ext = &H0 or flag_cdrAcqDone_r2 = &H0 or flag_freq_sel_PC = &H0 or flag_freq_sel_SM = &H0 or flag_integ_mode_SM = &H0 or flag_prop_scale = &H0 or flag_integ_scale = &H0 or flag_prop_scale_acq = &H0 or flag_integ_scale_acq = &H0 or flag_rxMuxCkSel = &H0 or flag_glpbk_combo = &H0 or flag_clockSwitchSel = &H0 or flag_rxck_tst = &H0 or flag_rxck_i = &H0 or flag_refclk = &H0 or flag_pll_bypass = &H0 or flag_allow_increment_PC = &H0 or flag_freq_sel = &H0 or flag_pll_lock_rstb = &H0 or flag_pwrdn = &H0 or flag_reset_anlg = &H0 or flag_pwrdn_rx = &H0 or flag_pwrdn_pll = &H0 or flag_rxck0_even = &H0 or flag_rxck1_even = &H0 or flag_comdet_even = &H0 or flag_en_cdet_even = &H0 or flag_comma_adj_en_even = &H0 or flag_rxck0_odd = &H0 or flag_rxck1_odd = &H0 or flag_comdet_odd = &H0 or flag_en_cdet_odd = &H0 or flag_comma_adj_en_odd = &H0 or flag_sigdet = &H0 or flag_prbs_en = &H0 or flag_rstb_tst = &H0 or flag_prbs_state = &H0 or flag_enable4 = &H0 or flag_radr_test = &H0 or flag_wadr_test = &H0 or flag_rxck_66B_tmux = &H0 or flag_rstb_66B = &H0 or flag_prstb_66B_mux = &H0 or flag_rxck_i66_tmux = &H0 or flag_rstb_i66 = &H0 or flag_prstb_i66_mux = &H0 or flag_rfifo_error_r = &H0 or flag_rfifo_unflow = &H0 or flag_rfifo_ovflow = &H0 or flag_integ_status = &H0 or flag_vco_status = &H0 or flag_prbs_lock = &H0 or flag_prbs_stky = &H0 or flag_prbs_errors = &H0 or flag_E_count = &H0 Then read
        If flag_cx4_sigdet = &H0 Then write_cx4_sigdet_value = get_cx4_sigdet
        If flag_rxSeqDone = &H0 Then write_rxSeqDone_value = get_rxSeqDone
        If flag_rx_sigdet_ll = &H0 Then write_rx_sigdet_ll_value = get_rx_sigdet_ll
        If flag_cs4_sigdet_ll = &H0 Then write_cs4_sigdet_ll_value = get_cs4_sigdet_ll
        If flag_rx_reset = &H0 Then write_rx_reset_value = get_rx_reset
        If flag_rx_pwrdn = &H0 Then write_rx_pwrdn_value = get_rx_pwrdn
        If flag_test_acq_en = &H0 Then write_test_acq_en_value = get_test_acq_en
        If flag_rxSeqStart = &H0 Then write_rxSeqStart_value = get_rxSeqStart
        If flag_mux_comadj_sync_status = &H0 Then write_mux_comadj_sync_status_value = get_mux_comadj_sync_status
        If flag_sync_status = &H0 Then write_sync_status_value = get_sync_status
        If flag_rx_sigdet = &H0 Then write_rx_sigdet_value = get_rx_sigdet
        If flag_saturate_status = &H0 Then write_saturate_status_value = get_saturate_status
        If flag_indck_mode_en = &H0 Then write_indck_mode_en_value = get_indck_mode_en
        If flag_pci_mode_en = &H0 Then write_pci_mode_en_value = get_pci_mode_en
        If flag_rx_polarity = &H0 Then write_rx_polarity_value = get_rx_polarity
        If flag_rxpol_flip = &H0 Then write_rxpol_flip_value = get_rxpol_flip
        If flag_comma_mask = &H0 Then write_comma_mask_value = get_comma_mask
        If flag_link_en_r = &H0 Then write_link_en_r_value = get_link_en_r
        If flag_comma_adj_en = &H0 Then write_comma_adj_en_value = get_comma_adj_en
        If flag_comma_adj_en_ext = &H0 Then write_comma_adj_en_ext_value = get_comma_adj_en_ext
        If flag_cdrAcqDone_r2 = &H0 Then write_cdrAcqDone_r2_value = get_cdrAcqDone_r2
        If flag_freq_sel_PC = &H0 Then write_freq_sel_PC_value = get_freq_sel_PC
        If flag_freq_sel_SM = &H0 Then write_freq_sel_SM_value = get_freq_sel_SM
        If flag_integ_mode_SM = &H0 Then write_integ_mode_SM_value = get_integ_mode_SM
        If flag_prop_scale = &H0 Then write_prop_scale_value = get_prop_scale
        If flag_integ_scale = &H0 Then write_integ_scale_value = get_integ_scale
        If flag_prop_scale_acq = &H0 Then write_prop_scale_acq_value = get_prop_scale_acq
        If flag_integ_scale_acq = &H0 Then write_integ_scale_acq_value = get_integ_scale_acq
        If flag_rxMuxCkSel = &H0 Then write_rxMuxCkSel_value = get_rxMuxCkSel
        If flag_glpbk_combo = &H0 Then write_glpbk_combo_value = get_glpbk_combo
        If flag_clockSwitchSel = &H0 Then write_clockSwitchSel_value = get_clockSwitchSel
        If flag_rxck_tst = &H0 Then write_rxck_tst_value = get_rxck_tst
        If flag_rxck_i = &H0 Then write_rxck_i_value = get_rxck_i
        If flag_refclk = &H0 Then write_refclk_value = get_refclk
        If flag_pll_bypass = &H0 Then write_pll_bypass_value = get_pll_bypass
        If flag_allow_increment_PC = &H0 Then write_allow_increment_PC_value = get_allow_increment_PC
        If flag_freq_sel = &H0 Then write_freq_sel_value = get_freq_sel
        If flag_pll_lock_rstb = &H0 Then write_pll_lock_rstb_value = get_pll_lock_rstb
        If flag_pwrdn = &H0 Then write_pwrdn_value = get_pwrdn
        If flag_reset_anlg = &H0 Then write_reset_anlg_value = get_reset_anlg
        If flag_pwrdn_rx = &H0 Then write_pwrdn_rx_value = get_pwrdn_rx
        If flag_pwrdn_pll = &H0 Then write_pwrdn_pll_value = get_pwrdn_pll
        If flag_rxck0_even = &H0 Then write_rxck0_even_value = get_rxck0_even
        If flag_rxck1_even = &H0 Then write_rxck1_even_value = get_rxck1_even
        If flag_comdet_even = &H0 Then write_comdet_even_value = get_comdet_even
        If flag_en_cdet_even = &H0 Then write_en_cdet_even_value = get_en_cdet_even
        If flag_comma_adj_en_even = &H0 Then write_comma_adj_en_even_value = get_comma_adj_en_even
        If flag_rxck0_odd = &H0 Then write_rxck0_odd_value = get_rxck0_odd
        If flag_rxck1_odd = &H0 Then write_rxck1_odd_value = get_rxck1_odd
        If flag_comdet_odd = &H0 Then write_comdet_odd_value = get_comdet_odd
        If flag_en_cdet_odd = &H0 Then write_en_cdet_odd_value = get_en_cdet_odd
        If flag_comma_adj_en_odd = &H0 Then write_comma_adj_en_odd_value = get_comma_adj_en_odd
        If flag_sigdet = &H0 Then write_sigdet_value = get_sigdet
        If flag_prbs_en = &H0 Then write_prbs_en_value = get_prbs_en
        If flag_rstb_tst = &H0 Then write_rstb_tst_value = get_rstb_tst
        If flag_prbs_state = &H0 Then write_prbs_state_value = get_prbs_state
        If flag_enable4 = &H0 Then write_enable4_value = get_enable4
        If flag_radr_test = &H0 Then write_radr_test_value = get_radr_test
        If flag_wadr_test = &H0 Then write_wadr_test_value = get_wadr_test
        If flag_rxck_66B_tmux = &H0 Then write_rxck_66B_tmux_value = get_rxck_66B_tmux
        If flag_rstb_66B = &H0 Then write_rstb_66B_value = get_rstb_66B
        If flag_prstb_66B_mux = &H0 Then write_prstb_66B_mux_value = get_prstb_66B_mux
        If flag_rxck_i66_tmux = &H0 Then write_rxck_i66_tmux_value = get_rxck_i66_tmux
        If flag_rstb_i66 = &H0 Then write_rstb_i66_value = get_rstb_i66
        If flag_prstb_i66_mux = &H0 Then write_prstb_i66_mux_value = get_prstb_i66_mux
        If flag_rfifo_error_r = &H0 Then write_rfifo_error_r_value = get_rfifo_error_r
        If flag_rfifo_unflow = &H0 Then write_rfifo_unflow_value = get_rfifo_unflow
        If flag_rfifo_ovflow = &H0 Then write_rfifo_ovflow_value = get_rfifo_ovflow
        If flag_integ_status = &H0 Then write_integ_status_value = get_integ_status
        If flag_vco_status = &H0 Then write_vco_status_value = get_vco_status
        If flag_prbs_lock = &H0 Then write_prbs_lock_value = get_prbs_lock
        If flag_prbs_stky = &H0 Then write_prbs_stky_value = get_prbs_stky
        If flag_prbs_errors = &H0 Then write_prbs_errors_value = get_prbs_errors
        If flag_E_count = &H0 Then write_E_count_value = get_E_count

        regValue = leftShift((write_cx4_sigdet_value and &H1), 1) + leftShift((write_rxSeqDone_value and &H1), 0) + leftShift((write_rx_sigdet_ll_value and &H1), 11) + leftShift((write_cs4_sigdet_ll_value and &H1), 10) + leftShift((write_rx_reset_value and &H1), 4) + leftShift((write_rx_pwrdn_value and &H1), 3) + leftShift((write_test_acq_en_value and &H1), 10) + leftShift((write_rxSeqStart_value and &H1), 3) + leftShift((write_mux_comadj_sync_status_value and &H1), 7) + leftShift((write_sync_status_value and &H1), 15) + leftShift((write_rx_sigdet_value and &H1), 5) + leftShift((write_saturate_status_value and &H1), 2) + leftShift((write_indck_mode_en_value and &H1), 9) + leftShift((write_pci_mode_en_value and &H1), 8) + leftShift((write_rx_polarity_value and &H1), 7) + leftShift((write_rxpol_flip_value and &H1), 6) + leftShift((write_comma_mask_value and &H1), 5) + leftShift((write_link_en_r_value and &H1), 4) + leftShift((write_comma_adj_en_value and &H1), 3) + leftShift((write_comma_adj_en_ext_value and &H1), 2) + leftShift((write_cdrAcqDone_r2_value and &H1), 4) + leftShift((write_freq_sel_PC_value and &H1), 3) + leftShift((write_freq_sel_SM_value and &H1), 2) + leftShift((write_integ_mode_SM_value and &H3), 0) + leftShift((write_prop_scale_value and &Hf), 12) + leftShift((write_integ_scale_value and &Hf), 8) + leftShift((write_prop_scale_acq_value and &Hf), 4) + leftShift((write_integ_scale_acq_value and &Hf), 0) + leftShift((write_rxMuxCkSel_value and &H1), 5) + leftShift((write_glpbk_combo_value and &H1), 5) + leftShift((write_clockSwitchSel_value and &H1), 4) + leftShift((write_rxck_tst_value and &H1), 3) + leftShift((write_rxck_i_value and &H1), 2) + leftShift((write_refclk_value and &H1), 1) + leftShift((write_pll_bypass_value and &H1), 0) + leftShift((write_allow_increment_PC_value and &H1), 0) + leftShift((write_freq_sel_value and &H1), 6) + leftShift((write_pll_lock_rstb_value and &H1), 5) + leftShift((write_pwrdn_value and &H1), 4) + leftShift((write_reset_anlg_value and &H1), 2) + leftShift((write_pwrdn_rx_value and &H1), 1) + leftShift((write_pwrdn_pll_value and &H1), 0) + leftShift((write_rxck0_even_value and &H1), 4) + leftShift((write_rxck1_even_value and &H1), 3) + leftShift((write_comdet_even_value and &H1), 2) + leftShift((write_en_cdet_even_value and &H1), 1) + leftShift((write_comma_adj_en_even_value and &H1), 0) + leftShift((write_rxck0_odd_value and &H1), 4) + leftShift((write_rxck1_odd_value and &H1), 3) + leftShift((write_comdet_odd_value and &H1), 2) + leftShift((write_en_cdet_odd_value and &H1), 1) + leftShift((write_comma_adj_en_odd_value and &H1), 0) + leftShift((write_sigdet_value and &H1), 0) + leftShift((write_prbs_en_value and &H1), 6) + leftShift((write_rstb_tst_value and &H1), 5) + leftShift((write_prbs_state_value and &Hf), 0) + leftShift((write_enable4_value and &H1), 5) + leftShift((write_radr_test_value and &H1f), 0) + leftShift((write_wadr_test_value and &H1f), 0) + leftShift((write_rxck_66B_tmux_value and &H1), 5) + leftShift((write_rstb_66B_value and &H1), 4) + leftShift((write_prstb_66B_mux_value and &H1), 3) + leftShift((write_rxck_i66_tmux_value and &H1), 2) + leftShift((write_rstb_i66_value and &H1), 1) + leftShift((write_prstb_i66_mux_value and &H1), 0) + leftShift((write_rfifo_error_r_value and &H3), 2) + leftShift((write_rfifo_unflow_value and &H1), 1) + leftShift((write_rfifo_ovflow_value and &H1), 0) + leftShift((write_integ_status_value and &Hffff), 0) + leftShift((write_vco_status_value and &Hffff), 0) + leftShift((write_prbs_lock_value and &H1), 15) + leftShift((write_prbs_stky_value and &H1), 14) + leftShift((write_prbs_errors_value and &H3fff), 0) + leftShift((write_E_count_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cx4_sigdet_value = rightShift(data_low, 1) and &H1
        rxSeqDone_mask = &H1
        if data_low > LONG_MAX then
            if rxSeqDone_mask = mask then
                read_rxSeqDone_value = data_low
            else
                read_rxSeqDone_value = (data_low - H8000_0000) and rxSeqDone_mask
            end If
        else
            read_rxSeqDone_value = data_low and rxSeqDone_mask
        end If
        read_rx_sigdet_ll_value = rightShift(data_low, 11) and &H1
        read_cs4_sigdet_ll_value = rightShift(data_low, 10) and &H1
        read_rx_reset_value = rightShift(data_low, 4) and &H1
        read_rx_pwrdn_value = rightShift(data_low, 3) and &H1
        read_test_acq_en_value = rightShift(data_low, 10) and &H1
        read_rxSeqStart_value = rightShift(data_low, 3) and &H1
        read_mux_comadj_sync_status_value = rightShift(data_low, 7) and &H1
        read_sync_status_value = rightShift(data_low, 15) and &H1
        read_rx_sigdet_value = rightShift(data_low, 5) and &H1
        read_saturate_status_value = rightShift(data_low, 2) and &H1
        read_indck_mode_en_value = rightShift(data_low, 9) and &H1
        read_pci_mode_en_value = rightShift(data_low, 8) and &H1
        read_rx_polarity_value = rightShift(data_low, 7) and &H1
        read_rxpol_flip_value = rightShift(data_low, 6) and &H1
        read_comma_mask_value = rightShift(data_low, 5) and &H1
        read_link_en_r_value = rightShift(data_low, 4) and &H1
        read_comma_adj_en_value = rightShift(data_low, 3) and &H1
        read_comma_adj_en_ext_value = rightShift(data_low, 2) and &H1
        read_cdrAcqDone_r2_value = rightShift(data_low, 4) and &H1
        read_freq_sel_PC_value = rightShift(data_low, 3) and &H1
        read_freq_sel_SM_value = rightShift(data_low, 2) and &H1
        integ_mode_SM_mask = &H3
        if data_low > LONG_MAX then
            if integ_mode_SM_mask = mask then
                read_integ_mode_SM_value = data_low
            else
                read_integ_mode_SM_value = (data_low - H8000_0000) and integ_mode_SM_mask
            end If
        else
            read_integ_mode_SM_value = data_low and integ_mode_SM_mask
        end If
        read_prop_scale_value = rightShift(data_low, 12) and &Hf
        read_integ_scale_value = rightShift(data_low, 8) and &Hf
        read_prop_scale_acq_value = rightShift(data_low, 4) and &Hf
        integ_scale_acq_mask = &Hf
        if data_low > LONG_MAX then
            if integ_scale_acq_mask = mask then
                read_integ_scale_acq_value = data_low
            else
                read_integ_scale_acq_value = (data_low - H8000_0000) and integ_scale_acq_mask
            end If
        else
            read_integ_scale_acq_value = data_low and integ_scale_acq_mask
        end If
        read_rxMuxCkSel_value = rightShift(data_low, 5) and &H1
        read_glpbk_combo_value = rightShift(data_low, 5) and &H1
        read_clockSwitchSel_value = rightShift(data_low, 4) and &H1
        read_rxck_tst_value = rightShift(data_low, 3) and &H1
        read_rxck_i_value = rightShift(data_low, 2) and &H1
        read_refclk_value = rightShift(data_low, 1) and &H1
        pll_bypass_mask = &H1
        if data_low > LONG_MAX then
            if pll_bypass_mask = mask then
                read_pll_bypass_value = data_low
            else
                read_pll_bypass_value = (data_low - H8000_0000) and pll_bypass_mask
            end If
        else
            read_pll_bypass_value = data_low and pll_bypass_mask
        end If
        allow_increment_PC_mask = &H1
        if data_low > LONG_MAX then
            if allow_increment_PC_mask = mask then
                read_allow_increment_PC_value = data_low
            else
                read_allow_increment_PC_value = (data_low - H8000_0000) and allow_increment_PC_mask
            end If
        else
            read_allow_increment_PC_value = data_low and allow_increment_PC_mask
        end If
        read_freq_sel_value = rightShift(data_low, 6) and &H1
        read_pll_lock_rstb_value = rightShift(data_low, 5) and &H1
        read_pwrdn_value = rightShift(data_low, 4) and &H1
        read_reset_anlg_value = rightShift(data_low, 2) and &H1
        read_pwrdn_rx_value = rightShift(data_low, 1) and &H1
        pwrdn_pll_mask = &H1
        if data_low > LONG_MAX then
            if pwrdn_pll_mask = mask then
                read_pwrdn_pll_value = data_low
            else
                read_pwrdn_pll_value = (data_low - H8000_0000) and pwrdn_pll_mask
            end If
        else
            read_pwrdn_pll_value = data_low and pwrdn_pll_mask
        end If
        read_rxck0_even_value = rightShift(data_low, 4) and &H1
        read_rxck1_even_value = rightShift(data_low, 3) and &H1
        read_comdet_even_value = rightShift(data_low, 2) and &H1
        read_en_cdet_even_value = rightShift(data_low, 1) and &H1
        comma_adj_en_even_mask = &H1
        if data_low > LONG_MAX then
            if comma_adj_en_even_mask = mask then
                read_comma_adj_en_even_value = data_low
            else
                read_comma_adj_en_even_value = (data_low - H8000_0000) and comma_adj_en_even_mask
            end If
        else
            read_comma_adj_en_even_value = data_low and comma_adj_en_even_mask
        end If
        read_rxck0_odd_value = rightShift(data_low, 4) and &H1
        read_rxck1_odd_value = rightShift(data_low, 3) and &H1
        read_comdet_odd_value = rightShift(data_low, 2) and &H1
        read_en_cdet_odd_value = rightShift(data_low, 1) and &H1
        comma_adj_en_odd_mask = &H1
        if data_low > LONG_MAX then
            if comma_adj_en_odd_mask = mask then
                read_comma_adj_en_odd_value = data_low
            else
                read_comma_adj_en_odd_value = (data_low - H8000_0000) and comma_adj_en_odd_mask
            end If
        else
            read_comma_adj_en_odd_value = data_low and comma_adj_en_odd_mask
        end If
        sigdet_mask = &H1
        if data_low > LONG_MAX then
            if sigdet_mask = mask then
                read_sigdet_value = data_low
            else
                read_sigdet_value = (data_low - H8000_0000) and sigdet_mask
            end If
        else
            read_sigdet_value = data_low and sigdet_mask
        end If
        read_prbs_en_value = rightShift(data_low, 6) and &H1
        read_rstb_tst_value = rightShift(data_low, 5) and &H1
        prbs_state_mask = &Hf
        if data_low > LONG_MAX then
            if prbs_state_mask = mask then
                read_prbs_state_value = data_low
            else
                read_prbs_state_value = (data_low - H8000_0000) and prbs_state_mask
            end If
        else
            read_prbs_state_value = data_low and prbs_state_mask
        end If
        read_enable4_value = rightShift(data_low, 5) and &H1
        radr_test_mask = &H1f
        if data_low > LONG_MAX then
            if radr_test_mask = mask then
                read_radr_test_value = data_low
            else
                read_radr_test_value = (data_low - H8000_0000) and radr_test_mask
            end If
        else
            read_radr_test_value = data_low and radr_test_mask
        end If
        wadr_test_mask = &H1f
        if data_low > LONG_MAX then
            if wadr_test_mask = mask then
                read_wadr_test_value = data_low
            else
                read_wadr_test_value = (data_low - H8000_0000) and wadr_test_mask
            end If
        else
            read_wadr_test_value = data_low and wadr_test_mask
        end If
        read_rxck_66B_tmux_value = rightShift(data_low, 5) and &H1
        read_rstb_66B_value = rightShift(data_low, 4) and &H1
        read_prstb_66B_mux_value = rightShift(data_low, 3) and &H1
        read_rxck_i66_tmux_value = rightShift(data_low, 2) and &H1
        read_rstb_i66_value = rightShift(data_low, 1) and &H1
        prstb_i66_mux_mask = &H1
        if data_low > LONG_MAX then
            if prstb_i66_mux_mask = mask then
                read_prstb_i66_mux_value = data_low
            else
                read_prstb_i66_mux_value = (data_low - H8000_0000) and prstb_i66_mux_mask
            end If
        else
            read_prstb_i66_mux_value = data_low and prstb_i66_mux_mask
        end If
        read_rfifo_error_r_value = rightShift(data_low, 2) and &H3
        read_rfifo_unflow_value = rightShift(data_low, 1) and &H1
        rfifo_ovflow_mask = &H1
        if data_low > LONG_MAX then
            if rfifo_ovflow_mask = mask then
                read_rfifo_ovflow_value = data_low
            else
                read_rfifo_ovflow_value = (data_low - H8000_0000) and rfifo_ovflow_mask
            end If
        else
            read_rfifo_ovflow_value = data_low and rfifo_ovflow_mask
        end If
        integ_status_mask = &Hffff
        if data_low > LONG_MAX then
            if integ_status_mask = mask then
                read_integ_status_value = data_low
            else
                read_integ_status_value = (data_low - H8000_0000) and integ_status_mask
            end If
        else
            read_integ_status_value = data_low and integ_status_mask
        end If
        vco_status_mask = &Hffff
        if data_low > LONG_MAX then
            if vco_status_mask = mask then
                read_vco_status_value = data_low
            else
                read_vco_status_value = (data_low - H8000_0000) and vco_status_mask
            end If
        else
            read_vco_status_value = data_low and vco_status_mask
        end If
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
        E_count_mask = &H7fff
        if data_low > LONG_MAX then
            if E_count_mask = mask then
                read_E_count_value = data_low
            else
                read_E_count_value = (data_low - H8000_0000) and E_count_mask
            end If
        else
            read_E_count_value = data_low and E_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cx4_sigdet_value = &H0
        flag_cx4_sigdet        = &H0
        write_rxSeqDone_value = &H0
        flag_rxSeqDone        = &H0
        write_rx_sigdet_ll_value = &H0
        flag_rx_sigdet_ll        = &H0
        write_cs4_sigdet_ll_value = &H0
        flag_cs4_sigdet_ll        = &H0
        write_rx_reset_value = &H0
        flag_rx_reset        = &H0
        write_rx_pwrdn_value = &H0
        flag_rx_pwrdn        = &H0
        write_test_acq_en_value = &H0
        flag_test_acq_en        = &H0
        write_rxSeqStart_value = &H0
        flag_rxSeqStart        = &H0
        write_mux_comadj_sync_status_value = &H0
        flag_mux_comadj_sync_status        = &H0
        write_sync_status_value = &H0
        flag_sync_status        = &H0
        write_rx_sigdet_value = &H0
        flag_rx_sigdet        = &H0
        write_saturate_status_value = &H0
        flag_saturate_status        = &H0
        write_indck_mode_en_value = &H0
        flag_indck_mode_en        = &H0
        write_pci_mode_en_value = &H0
        flag_pci_mode_en        = &H0
        write_rx_polarity_value = &H0
        flag_rx_polarity        = &H0
        write_rxpol_flip_value = &H0
        flag_rxpol_flip        = &H0
        write_comma_mask_value = &H0
        flag_comma_mask        = &H0
        write_link_en_r_value = &H0
        flag_link_en_r        = &H0
        write_comma_adj_en_value = &H0
        flag_comma_adj_en        = &H0
        write_comma_adj_en_ext_value = &H0
        flag_comma_adj_en_ext        = &H0
        write_cdrAcqDone_r2_value = &H0
        flag_cdrAcqDone_r2        = &H0
        write_freq_sel_PC_value = &H0
        flag_freq_sel_PC        = &H0
        write_freq_sel_SM_value = &H0
        flag_freq_sel_SM        = &H0
        write_integ_mode_SM_value = &H0
        flag_integ_mode_SM        = &H0
        write_prop_scale_value = &H0
        flag_prop_scale        = &H0
        write_integ_scale_value = &H0
        flag_integ_scale        = &H0
        write_prop_scale_acq_value = &H0
        flag_prop_scale_acq        = &H0
        write_integ_scale_acq_value = &H0
        flag_integ_scale_acq        = &H0
        write_rxMuxCkSel_value = &H0
        flag_rxMuxCkSel        = &H0
        write_glpbk_combo_value = &H0
        flag_glpbk_combo        = &H0
        write_clockSwitchSel_value = &H0
        flag_clockSwitchSel        = &H0
        write_rxck_tst_value = &H0
        flag_rxck_tst        = &H0
        write_rxck_i_value = &H0
        flag_rxck_i        = &H0
        write_refclk_value = &H0
        flag_refclk        = &H0
        write_pll_bypass_value = &H0
        flag_pll_bypass        = &H0
        write_allow_increment_PC_value = &H0
        flag_allow_increment_PC        = &H0
        write_freq_sel_value = &H0
        flag_freq_sel        = &H0
        write_pll_lock_rstb_value = &H0
        flag_pll_lock_rstb        = &H0
        write_pwrdn_value = &H0
        flag_pwrdn        = &H0
        write_reset_anlg_value = &H0
        flag_reset_anlg        = &H0
        write_pwrdn_rx_value = &H0
        flag_pwrdn_rx        = &H0
        write_pwrdn_pll_value = &H0
        flag_pwrdn_pll        = &H0
        write_rxck0_even_value = &H0
        flag_rxck0_even        = &H0
        write_rxck1_even_value = &H0
        flag_rxck1_even        = &H0
        write_comdet_even_value = &H0
        flag_comdet_even        = &H0
        write_en_cdet_even_value = &H0
        flag_en_cdet_even        = &H0
        write_comma_adj_en_even_value = &H0
        flag_comma_adj_en_even        = &H0
        write_rxck0_odd_value = &H0
        flag_rxck0_odd        = &H0
        write_rxck1_odd_value = &H0
        flag_rxck1_odd        = &H0
        write_comdet_odd_value = &H0
        flag_comdet_odd        = &H0
        write_en_cdet_odd_value = &H0
        flag_en_cdet_odd        = &H0
        write_comma_adj_en_odd_value = &H0
        flag_comma_adj_en_odd        = &H0
        write_sigdet_value = &H0
        flag_sigdet        = &H0
        write_prbs_en_value = &H0
        flag_prbs_en        = &H0
        write_rstb_tst_value = &H0
        flag_rstb_tst        = &H0
        write_prbs_state_value = &H0
        flag_prbs_state        = &H0
        write_enable4_value = &H0
        flag_enable4        = &H0
        write_radr_test_value = &H0
        flag_radr_test        = &H0
        write_wadr_test_value = &H0
        flag_wadr_test        = &H0
        write_rxck_66B_tmux_value = &H0
        flag_rxck_66B_tmux        = &H0
        write_rstb_66B_value = &H0
        flag_rstb_66B        = &H0
        write_prstb_66B_mux_value = &H0
        flag_prstb_66B_mux        = &H0
        write_rxck_i66_tmux_value = &H0
        flag_rxck_i66_tmux        = &H0
        write_rstb_i66_value = &H0
        flag_rstb_i66        = &H0
        write_prstb_i66_mux_value = &H0
        flag_prstb_i66_mux        = &H0
        write_rfifo_error_r_value = &H0
        flag_rfifo_error_r        = &H0
        write_rfifo_unflow_value = &H0
        flag_rfifo_unflow        = &H0
        write_rfifo_ovflow_value = &H0
        flag_rfifo_ovflow        = &H0
        write_integ_status_value = &H0
        flag_integ_status        = &H0
        write_vco_status_value = &H0
        flag_vco_status        = &H0
        write_prbs_lock_value = &H0
        flag_prbs_lock        = &H0
        write_prbs_stky_value = &H0
        flag_prbs_stky        = &H0
        write_prbs_errors_value = &H0
        flag_prbs_errors        = &H0
        write_E_count_value = &H0
        flag_E_count        = &H0
    End Sub
End Class


'' @REGISTER : RX__SGMIIPLUS2_X2_anarxcontrol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' status_sel                                 [2:0]            get_status_sel
''                                                             set_status_sel
''                                                             read_status_sel
''                                                             write_status_sel
''---------------------------------------------------------------------------------
Class REGISTER_RX__SGMIIPLUS2_X2_anarxcontrol
    Private write_status_sel_value
    Private read_status_sel_value
    Private flag_status_sel

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

    Property Get get_status_sel
        get_status_sel = read_status_sel_value
    End Property

    Property Let set_status_sel(aData)
        write_status_sel_value = aData
        flag_status_sel        = &H1
    End Property

    Property Get read_status_sel
        read
        read_status_sel = read_status_sel_value
    End Property

    Property Let write_status_sel(aData)
        set_status_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status_sel_mask = &H7
        if data_low > LONG_MAX then
            if status_sel_mask = mask then
                read_status_sel_value = data_low
            else
                read_status_sel_value = (data_low - H8000_0000) and status_sel_mask
            end If
        else
            read_status_sel_value = data_low and status_sel_mask
        end If

    End Sub

    Sub write
        If flag_status_sel = &H0 Then read
        If flag_status_sel = &H0 Then write_status_sel_value = get_status_sel

        regValue = leftShift((write_status_sel_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        status_sel_mask = &H7
        if data_low > LONG_MAX then
            if status_sel_mask = mask then
                read_status_sel_value = data_low
            else
                read_status_sel_value = (data_low - H8000_0000) and status_sel_mask
            end If
        else
            read_status_sel_value = data_low and status_sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_status_sel_value = &H0
        flag_status_sel        = &H0
    End Sub
End Class


'' @REGISTER : RX__SGMIIPLUS2_X2_anarxsigdet
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_RX__SGMIIPLUS2_X2_anarxsigdet

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : RX__SGMIIPLUS2_X2_anarxcontrolpci
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_polarity_force_SM                       [3:3]            get_rx_polarity_force_SM
''                                                             set_rx_polarity_force_SM
''                                                             read_rx_polarity_force_SM
''                                                             write_rx_polarity_force_SM
''---------------------------------------------------------------------------------
'' rx_polarity_r                              [2:2]            get_rx_polarity_r
''                                                             set_rx_polarity_r
''                                                             read_rx_polarity_r
''                                                             write_rx_polarity_r
''---------------------------------------------------------------------------------
Class REGISTER_RX__SGMIIPLUS2_X2_anarxcontrolpci
    Private write_rx_polarity_force_SM_value
    Private read_rx_polarity_force_SM_value
    Private flag_rx_polarity_force_SM
    Private write_rx_polarity_r_value
    Private read_rx_polarity_r_value
    Private flag_rx_polarity_r

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

    Property Get get_rx_polarity_force_SM
        get_rx_polarity_force_SM = read_rx_polarity_force_SM_value
    End Property

    Property Let set_rx_polarity_force_SM(aData)
        write_rx_polarity_force_SM_value = aData
        flag_rx_polarity_force_SM        = &H1
    End Property

    Property Get read_rx_polarity_force_SM
        read
        read_rx_polarity_force_SM = read_rx_polarity_force_SM_value
    End Property

    Property Let write_rx_polarity_force_SM(aData)
        set_rx_polarity_force_SM = aData
        write
    End Property

    Property Get get_rx_polarity_r
        get_rx_polarity_r = read_rx_polarity_r_value
    End Property

    Property Let set_rx_polarity_r(aData)
        write_rx_polarity_r_value = aData
        flag_rx_polarity_r        = &H1
    End Property

    Property Get read_rx_polarity_r
        read
        read_rx_polarity_r = read_rx_polarity_r_value
    End Property

    Property Let write_rx_polarity_r(aData)
        set_rx_polarity_r = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_polarity_force_SM_value = rightShift(data_low, 3) and &H1
        read_rx_polarity_r_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_rx_polarity_force_SM = &H0 or flag_rx_polarity_r = &H0 Then read
        If flag_rx_polarity_force_SM = &H0 Then write_rx_polarity_force_SM_value = get_rx_polarity_force_SM
        If flag_rx_polarity_r = &H0 Then write_rx_polarity_r_value = get_rx_polarity_r

        regValue = leftShift((write_rx_polarity_force_SM_value and &H1), 3) + leftShift((write_rx_polarity_r_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_polarity_force_SM_value = rightShift(data_low, 3) and &H1
        read_rx_polarity_r_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_polarity_force_SM_value = &H0
        flag_rx_polarity_force_SM        = &H0
        write_rx_polarity_r_value = &H0
        flag_rx_polarity_r        = &H0
    End Sub
End Class


'' @REGISTER : RX__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_RX__SGMIIPLUS2_X2_blockaddress
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

Class RX__SGMIIPLUS2_X2_INSTANCE

    Public anarxstatus
    Public anarxcontrol
    Public anarxsigdet
    Public anarxcontrolpci
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set anarxstatus = (New REGISTER_RX__SGMIIPLUS2_X2_anarxstatus)(aBaseAddr, 16)
        Set anarxcontrol = (New REGISTER_RX__SGMIIPLUS2_X2_anarxcontrol)(aBaseAddr, 16)
        Set anarxsigdet = (New REGISTER_RX__SGMIIPLUS2_X2_anarxsigdet)(aBaseAddr, 16)
        Set anarxcontrolpci = (New REGISTER_RX__SGMIIPLUS2_X2_anarxcontrolpci)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_RX__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
RX__SGMIIPLUS2_X2.Add ((New RX__SGMIIPLUS2_X2_INSTANCE)(&H4acd0180))
RX__SGMIIPLUS2_X2.Add ((New RX__SGMIIPLUS2_X2_INSTANCE)(&H4acf0180))


