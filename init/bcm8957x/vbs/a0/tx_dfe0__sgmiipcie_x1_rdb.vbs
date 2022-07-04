

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


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_status0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' gloopback                                  [8:8]            get_gloopback
''                                                             set_gloopback
''                                                             read_gloopback
''                                                             write_gloopback
''---------------------------------------------------------------------------------
'' dig2ana_tx_ElecIdle                        [6:6]            get_dig2ana_tx_ElecIdle
''                                                             set_dig2ana_tx_ElecIdle
''                                                             read_dig2ana_tx_ElecIdle
''                                                             write_dig2ana_tx_ElecIdle
''---------------------------------------------------------------------------------
'' rltxferr_stky                              [1:1]            get_rltxferr_stky
''                                                             set_rltxferr_stky
''                                                             read_rltxferr_stky
''                                                             write_rltxferr_stky
''---------------------------------------------------------------------------------
'' txpll_lock                                 [0:0]            get_txpll_lock
''                                                             set_txpll_lock
''                                                             read_txpll_lock
''                                                             write_txpll_lock
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_status0
    Private write_gloopback_value
    Private read_gloopback_value
    Private flag_gloopback
    Private write_dig2ana_tx_ElecIdle_value
    Private read_dig2ana_tx_ElecIdle_value
    Private flag_dig2ana_tx_ElecIdle
    Private write_rltxferr_stky_value
    Private read_rltxferr_stky_value
    Private flag_rltxferr_stky
    Private write_txpll_lock_value
    Private read_txpll_lock_value
    Private flag_txpll_lock

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

    Property Get get_gloopback
        get_gloopback = read_gloopback_value
    End Property

    Property Let set_gloopback(aData)
        write_gloopback_value = aData
        flag_gloopback        = &H1
    End Property

    Property Get read_gloopback
        read
        read_gloopback = read_gloopback_value
    End Property

    Property Let write_gloopback(aData)
        set_gloopback = aData
        write
    End Property

    Property Get get_dig2ana_tx_ElecIdle
        get_dig2ana_tx_ElecIdle = read_dig2ana_tx_ElecIdle_value
    End Property

    Property Let set_dig2ana_tx_ElecIdle(aData)
        write_dig2ana_tx_ElecIdle_value = aData
        flag_dig2ana_tx_ElecIdle        = &H1
    End Property

    Property Get read_dig2ana_tx_ElecIdle
        read
        read_dig2ana_tx_ElecIdle = read_dig2ana_tx_ElecIdle_value
    End Property

    Property Let write_dig2ana_tx_ElecIdle(aData)
        set_dig2ana_tx_ElecIdle = aData
        write
    End Property

    Property Get get_rltxferr_stky
        get_rltxferr_stky = read_rltxferr_stky_value
    End Property

    Property Let set_rltxferr_stky(aData)
        write_rltxferr_stky_value = aData
        flag_rltxferr_stky        = &H1
    End Property

    Property Get read_rltxferr_stky
        read
        read_rltxferr_stky = read_rltxferr_stky_value
    End Property

    Property Let write_rltxferr_stky(aData)
        set_rltxferr_stky = aData
        write
    End Property

    Property Get get_txpll_lock
        get_txpll_lock = read_txpll_lock_value
    End Property

    Property Let set_txpll_lock(aData)
        write_txpll_lock_value = aData
        flag_txpll_lock        = &H1
    End Property

    Property Get read_txpll_lock
        read
        read_txpll_lock = read_txpll_lock_value
    End Property

    Property Let write_txpll_lock(aData)
        set_txpll_lock = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_gloopback_value = rightShift(data_low, 8) and &H1
        read_dig2ana_tx_ElecIdle_value = rightShift(data_low, 6) and &H1
        read_rltxferr_stky_value = rightShift(data_low, 1) and &H1
        txpll_lock_mask = &H1
        if data_low > LONG_MAX then
            if txpll_lock_mask = mask then
                read_txpll_lock_value = data_low
            else
                read_txpll_lock_value = (data_low - H8000_0000) and txpll_lock_mask
            end If
        else
            read_txpll_lock_value = data_low and txpll_lock_mask
        end If

    End Sub

    Sub write
        If flag_gloopback = &H0 or flag_dig2ana_tx_ElecIdle = &H0 or flag_rltxferr_stky = &H0 or flag_txpll_lock = &H0 Then read
        If flag_gloopback = &H0 Then write_gloopback_value = get_gloopback
        If flag_dig2ana_tx_ElecIdle = &H0 Then write_dig2ana_tx_ElecIdle_value = get_dig2ana_tx_ElecIdle
        If flag_rltxferr_stky = &H0 Then write_rltxferr_stky_value = get_rltxferr_stky
        If flag_txpll_lock = &H0 Then write_txpll_lock_value = get_txpll_lock

        regValue = leftShift((write_gloopback_value and &H1), 8) + leftShift((write_dig2ana_tx_ElecIdle_value and &H1), 6) + leftShift((write_rltxferr_stky_value and &H1), 1) + leftShift((write_txpll_lock_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_gloopback_value = rightShift(data_low, 8) and &H1
        read_dig2ana_tx_ElecIdle_value = rightShift(data_low, 6) and &H1
        read_rltxferr_stky_value = rightShift(data_low, 1) and &H1
        txpll_lock_mask = &H1
        if data_low > LONG_MAX then
            if txpll_lock_mask = mask then
                read_txpll_lock_value = data_low
            else
                read_txpll_lock_value = (data_low - H8000_0000) and txpll_lock_mask
            end If
        else
            read_txpll_lock_value = data_low and txpll_lock_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_gloopback_value = &H0
        flag_gloopback        = &H0
        write_dig2ana_tx_ElecIdle_value = &H0
        flag_dig2ana_tx_ElecIdle        = &H0
        write_rltxferr_stky_value = &H0
        flag_rltxferr_stky        = &H0
        write_txpll_lock_value = &H0
        flag_txpll_lock        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_control0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_force_SM                              [15:15]          get_mdio_force_SM
''                                                             set_mdio_force_SM
''                                                             read_mdio_force_SM
''                                                             write_mdio_force_SM
''---------------------------------------------------------------------------------
'' L0s_test_SM                                [14:14]          get_L0s_test_SM
''                                                             set_L0s_test_SM
''                                                             read_L0s_test_SM
''                                                             write_L0s_test_SM
''---------------------------------------------------------------------------------
'' gloopOutDis_r                              [9:9]            get_gloopOutDis_r
''                                                             set_gloopOutDis_r
''                                                             read_gloopOutDis_r
''                                                             write_gloopOutDis_r
''---------------------------------------------------------------------------------
'' prbs_en_r                                  [8:8]            get_prbs_en_r
''                                                             set_prbs_en_r
''                                                             read_prbs_en_r
''                                                             write_prbs_en_r
''---------------------------------------------------------------------------------
'' pkt_en_r                                   [7:7]            get_pkt_en_r
''                                                             set_pkt_en_r
''                                                             read_pkt_en_r
''                                                             write_pkt_en_r
''---------------------------------------------------------------------------------
'' pkt_strt_r                                 [6:6]            get_pkt_strt_r
''                                                             set_pkt_strt_r
''                                                             read_pkt_strt_r
''                                                             write_pkt_strt_r
''---------------------------------------------------------------------------------
'' txpol_flip                                 [5:5]            get_txpol_flip
''                                                             set_txpol_flip
''                                                             read_txpol_flip
''                                                             write_txpol_flip
''---------------------------------------------------------------------------------
'' force_disError_SM                          [4:4]            get_force_disError_SM
''                                                             set_force_disError_SM
''                                                             read_force_disError_SM
''                                                             write_force_disError_SM
''---------------------------------------------------------------------------------
'' eden_r                                     [3:3]            get_eden_r
''                                                             set_eden_r
''                                                             read_eden_r
''                                                             write_eden_r
''---------------------------------------------------------------------------------
'' eden_force_r                               [2:2]            get_eden_force_r
''                                                             set_eden_force_r
''                                                             read_eden_force_r
''                                                             write_eden_force_r
''---------------------------------------------------------------------------------
'' txpat_seq_en_SM                            [1:1]            get_txpat_seq_en_SM
''                                                             set_txpat_seq_en_SM
''                                                             read_txpat_seq_en_SM
''                                                             write_txpat_seq_en_SM
''---------------------------------------------------------------------------------
'' tx_mdata_en_SM                             [0:0]            get_tx_mdata_en_SM
''                                                             set_tx_mdata_en_SM
''                                                             read_tx_mdata_en_SM
''                                                             write_tx_mdata_en_SM
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_control0
    Private write_mdio_force_SM_value
    Private read_mdio_force_SM_value
    Private flag_mdio_force_SM
    Private write_L0s_test_SM_value
    Private read_L0s_test_SM_value
    Private flag_L0s_test_SM
    Private write_gloopOutDis_r_value
    Private read_gloopOutDis_r_value
    Private flag_gloopOutDis_r
    Private write_prbs_en_r_value
    Private read_prbs_en_r_value
    Private flag_prbs_en_r
    Private write_pkt_en_r_value
    Private read_pkt_en_r_value
    Private flag_pkt_en_r
    Private write_pkt_strt_r_value
    Private read_pkt_strt_r_value
    Private flag_pkt_strt_r
    Private write_txpol_flip_value
    Private read_txpol_flip_value
    Private flag_txpol_flip
    Private write_force_disError_SM_value
    Private read_force_disError_SM_value
    Private flag_force_disError_SM
    Private write_eden_r_value
    Private read_eden_r_value
    Private flag_eden_r
    Private write_eden_force_r_value
    Private read_eden_force_r_value
    Private flag_eden_force_r
    Private write_txpat_seq_en_SM_value
    Private read_txpat_seq_en_SM_value
    Private flag_txpat_seq_en_SM
    Private write_tx_mdata_en_SM_value
    Private read_tx_mdata_en_SM_value
    Private flag_tx_mdata_en_SM

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

    Property Get get_mdio_force_SM
        get_mdio_force_SM = read_mdio_force_SM_value
    End Property

    Property Let set_mdio_force_SM(aData)
        write_mdio_force_SM_value = aData
        flag_mdio_force_SM        = &H1
    End Property

    Property Get read_mdio_force_SM
        read
        read_mdio_force_SM = read_mdio_force_SM_value
    End Property

    Property Let write_mdio_force_SM(aData)
        set_mdio_force_SM = aData
        write
    End Property

    Property Get get_L0s_test_SM
        get_L0s_test_SM = read_L0s_test_SM_value
    End Property

    Property Let set_L0s_test_SM(aData)
        write_L0s_test_SM_value = aData
        flag_L0s_test_SM        = &H1
    End Property

    Property Get read_L0s_test_SM
        read
        read_L0s_test_SM = read_L0s_test_SM_value
    End Property

    Property Let write_L0s_test_SM(aData)
        set_L0s_test_SM = aData
        write
    End Property

    Property Get get_gloopOutDis_r
        get_gloopOutDis_r = read_gloopOutDis_r_value
    End Property

    Property Let set_gloopOutDis_r(aData)
        write_gloopOutDis_r_value = aData
        flag_gloopOutDis_r        = &H1
    End Property

    Property Get read_gloopOutDis_r
        read
        read_gloopOutDis_r = read_gloopOutDis_r_value
    End Property

    Property Let write_gloopOutDis_r(aData)
        set_gloopOutDis_r = aData
        write
    End Property

    Property Get get_prbs_en_r
        get_prbs_en_r = read_prbs_en_r_value
    End Property

    Property Let set_prbs_en_r(aData)
        write_prbs_en_r_value = aData
        flag_prbs_en_r        = &H1
    End Property

    Property Get read_prbs_en_r
        read
        read_prbs_en_r = read_prbs_en_r_value
    End Property

    Property Let write_prbs_en_r(aData)
        set_prbs_en_r = aData
        write
    End Property

    Property Get get_pkt_en_r
        get_pkt_en_r = read_pkt_en_r_value
    End Property

    Property Let set_pkt_en_r(aData)
        write_pkt_en_r_value = aData
        flag_pkt_en_r        = &H1
    End Property

    Property Get read_pkt_en_r
        read
        read_pkt_en_r = read_pkt_en_r_value
    End Property

    Property Let write_pkt_en_r(aData)
        set_pkt_en_r = aData
        write
    End Property

    Property Get get_pkt_strt_r
        get_pkt_strt_r = read_pkt_strt_r_value
    End Property

    Property Let set_pkt_strt_r(aData)
        write_pkt_strt_r_value = aData
        flag_pkt_strt_r        = &H1
    End Property

    Property Get read_pkt_strt_r
        read
        read_pkt_strt_r = read_pkt_strt_r_value
    End Property

    Property Let write_pkt_strt_r(aData)
        set_pkt_strt_r = aData
        write
    End Property

    Property Get get_txpol_flip
        get_txpol_flip = read_txpol_flip_value
    End Property

    Property Let set_txpol_flip(aData)
        write_txpol_flip_value = aData
        flag_txpol_flip        = &H1
    End Property

    Property Get read_txpol_flip
        read
        read_txpol_flip = read_txpol_flip_value
    End Property

    Property Let write_txpol_flip(aData)
        set_txpol_flip = aData
        write
    End Property

    Property Get get_force_disError_SM
        get_force_disError_SM = read_force_disError_SM_value
    End Property

    Property Let set_force_disError_SM(aData)
        write_force_disError_SM_value = aData
        flag_force_disError_SM        = &H1
    End Property

    Property Get read_force_disError_SM
        read
        read_force_disError_SM = read_force_disError_SM_value
    End Property

    Property Let write_force_disError_SM(aData)
        set_force_disError_SM = aData
        write
    End Property

    Property Get get_eden_r
        get_eden_r = read_eden_r_value
    End Property

    Property Let set_eden_r(aData)
        write_eden_r_value = aData
        flag_eden_r        = &H1
    End Property

    Property Get read_eden_r
        read
        read_eden_r = read_eden_r_value
    End Property

    Property Let write_eden_r(aData)
        set_eden_r = aData
        write
    End Property

    Property Get get_eden_force_r
        get_eden_force_r = read_eden_force_r_value
    End Property

    Property Let set_eden_force_r(aData)
        write_eden_force_r_value = aData
        flag_eden_force_r        = &H1
    End Property

    Property Get read_eden_force_r
        read
        read_eden_force_r = read_eden_force_r_value
    End Property

    Property Let write_eden_force_r(aData)
        set_eden_force_r = aData
        write
    End Property

    Property Get get_txpat_seq_en_SM
        get_txpat_seq_en_SM = read_txpat_seq_en_SM_value
    End Property

    Property Let set_txpat_seq_en_SM(aData)
        write_txpat_seq_en_SM_value = aData
        flag_txpat_seq_en_SM        = &H1
    End Property

    Property Get read_txpat_seq_en_SM
        read
        read_txpat_seq_en_SM = read_txpat_seq_en_SM_value
    End Property

    Property Let write_txpat_seq_en_SM(aData)
        set_txpat_seq_en_SM = aData
        write
    End Property

    Property Get get_tx_mdata_en_SM
        get_tx_mdata_en_SM = read_tx_mdata_en_SM_value
    End Property

    Property Let set_tx_mdata_en_SM(aData)
        write_tx_mdata_en_SM_value = aData
        flag_tx_mdata_en_SM        = &H1
    End Property

    Property Get read_tx_mdata_en_SM
        read
        read_tx_mdata_en_SM = read_tx_mdata_en_SM_value
    End Property

    Property Let write_tx_mdata_en_SM(aData)
        set_tx_mdata_en_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_force_SM_value = rightShift(data_low, 15) and &H1
        read_L0s_test_SM_value = rightShift(data_low, 14) and &H1
        read_gloopOutDis_r_value = rightShift(data_low, 9) and &H1
        read_prbs_en_r_value = rightShift(data_low, 8) and &H1
        read_pkt_en_r_value = rightShift(data_low, 7) and &H1
        read_pkt_strt_r_value = rightShift(data_low, 6) and &H1
        read_txpol_flip_value = rightShift(data_low, 5) and &H1
        read_force_disError_SM_value = rightShift(data_low, 4) and &H1
        read_eden_r_value = rightShift(data_low, 3) and &H1
        read_eden_force_r_value = rightShift(data_low, 2) and &H1
        read_txpat_seq_en_SM_value = rightShift(data_low, 1) and &H1
        tx_mdata_en_SM_mask = &H1
        if data_low > LONG_MAX then
            if tx_mdata_en_SM_mask = mask then
                read_tx_mdata_en_SM_value = data_low
            else
                read_tx_mdata_en_SM_value = (data_low - H8000_0000) and tx_mdata_en_SM_mask
            end If
        else
            read_tx_mdata_en_SM_value = data_low and tx_mdata_en_SM_mask
        end If

    End Sub

    Sub write
        If flag_mdio_force_SM = &H0 or flag_L0s_test_SM = &H0 or flag_gloopOutDis_r = &H0 or flag_prbs_en_r = &H0 or flag_pkt_en_r = &H0 or flag_pkt_strt_r = &H0 or flag_txpol_flip = &H0 or flag_force_disError_SM = &H0 or flag_eden_r = &H0 or flag_eden_force_r = &H0 or flag_txpat_seq_en_SM = &H0 or flag_tx_mdata_en_SM = &H0 Then read
        If flag_mdio_force_SM = &H0 Then write_mdio_force_SM_value = get_mdio_force_SM
        If flag_L0s_test_SM = &H0 Then write_L0s_test_SM_value = get_L0s_test_SM
        If flag_gloopOutDis_r = &H0 Then write_gloopOutDis_r_value = get_gloopOutDis_r
        If flag_prbs_en_r = &H0 Then write_prbs_en_r_value = get_prbs_en_r
        If flag_pkt_en_r = &H0 Then write_pkt_en_r_value = get_pkt_en_r
        If flag_pkt_strt_r = &H0 Then write_pkt_strt_r_value = get_pkt_strt_r
        If flag_txpol_flip = &H0 Then write_txpol_flip_value = get_txpol_flip
        If flag_force_disError_SM = &H0 Then write_force_disError_SM_value = get_force_disError_SM
        If flag_eden_r = &H0 Then write_eden_r_value = get_eden_r
        If flag_eden_force_r = &H0 Then write_eden_force_r_value = get_eden_force_r
        If flag_txpat_seq_en_SM = &H0 Then write_txpat_seq_en_SM_value = get_txpat_seq_en_SM
        If flag_tx_mdata_en_SM = &H0 Then write_tx_mdata_en_SM_value = get_tx_mdata_en_SM

        regValue = leftShift((write_mdio_force_SM_value and &H1), 15) + leftShift((write_L0s_test_SM_value and &H1), 14) + leftShift((write_gloopOutDis_r_value and &H1), 9) + leftShift((write_prbs_en_r_value and &H1), 8) + leftShift((write_pkt_en_r_value and &H1), 7) + leftShift((write_pkt_strt_r_value and &H1), 6) + leftShift((write_txpol_flip_value and &H1), 5) + leftShift((write_force_disError_SM_value and &H1), 4) + leftShift((write_eden_r_value and &H1), 3) + leftShift((write_eden_force_r_value and &H1), 2) + leftShift((write_txpat_seq_en_SM_value and &H1), 1) + leftShift((write_tx_mdata_en_SM_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_force_SM_value = rightShift(data_low, 15) and &H1
        read_L0s_test_SM_value = rightShift(data_low, 14) and &H1
        read_gloopOutDis_r_value = rightShift(data_low, 9) and &H1
        read_prbs_en_r_value = rightShift(data_low, 8) and &H1
        read_pkt_en_r_value = rightShift(data_low, 7) and &H1
        read_pkt_strt_r_value = rightShift(data_low, 6) and &H1
        read_txpol_flip_value = rightShift(data_low, 5) and &H1
        read_force_disError_SM_value = rightShift(data_low, 4) and &H1
        read_eden_r_value = rightShift(data_low, 3) and &H1
        read_eden_force_r_value = rightShift(data_low, 2) and &H1
        read_txpat_seq_en_SM_value = rightShift(data_low, 1) and &H1
        tx_mdata_en_SM_mask = &H1
        if data_low > LONG_MAX then
            if tx_mdata_en_SM_mask = mask then
                read_tx_mdata_en_SM_value = data_low
            else
                read_tx_mdata_en_SM_value = (data_low - H8000_0000) and tx_mdata_en_SM_mask
            end If
        else
            read_tx_mdata_en_SM_value = data_low and tx_mdata_en_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_force_SM_value = &H0
        flag_mdio_force_SM        = &H0
        write_L0s_test_SM_value = &H0
        flag_L0s_test_SM        = &H0
        write_gloopOutDis_r_value = &H0
        flag_gloopOutDis_r        = &H0
        write_prbs_en_r_value = &H0
        flag_prbs_en_r        = &H0
        write_pkt_en_r_value = &H0
        flag_pkt_en_r        = &H0
        write_pkt_strt_r_value = &H0
        flag_pkt_strt_r        = &H0
        write_txpol_flip_value = &H0
        flag_txpol_flip        = &H0
        write_force_disError_SM_value = &H0
        flag_force_disError_SM        = &H0
        write_eden_r_value = &H0
        flag_eden_r        = &H0
        write_eden_force_r_value = &H0
        flag_eden_force_r        = &H0
        write_txpat_seq_en_SM_value = &H0
        flag_txpat_seq_en_SM        = &H0
        write_tx_mdata_en_SM_value = &H0
        flag_tx_mdata_en_SM        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_mdata0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata0                                     [15:0]           get_mdata0
''                                                             set_mdata0
''                                                             read_mdata0
''                                                             write_mdata0
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_mdata0
    Private write_mdata0_value
    Private read_mdata0_value
    Private flag_mdata0

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

    Property Get get_mdata0
        get_mdata0 = read_mdata0_value
    End Property

    Property Let set_mdata0(aData)
        write_mdata0_value = aData
        flag_mdata0        = &H1
    End Property

    Property Get read_mdata0
        read
        read_mdata0 = read_mdata0_value
    End Property

    Property Let write_mdata0(aData)
        set_mdata0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata0_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata0_mask = mask then
                read_mdata0_value = data_low
            else
                read_mdata0_value = (data_low - H8000_0000) and mdata0_mask
            end If
        else
            read_mdata0_value = data_low and mdata0_mask
        end If

    End Sub

    Sub write
        If flag_mdata0 = &H0 Then read
        If flag_mdata0 = &H0 Then write_mdata0_value = get_mdata0

        regValue = leftShift((write_mdata0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata0_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata0_mask = mask then
                read_mdata0_value = data_low
            else
                read_mdata0_value = (data_low - H8000_0000) and mdata0_mask
            end If
        else
            read_mdata0_value = data_low and mdata0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata0_value = &H0
        flag_mdata0        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_mdata1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdata1                                     [15:0]           get_mdata1
''                                                             set_mdata1
''                                                             read_mdata1
''                                                             write_mdata1
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_mdata1
    Private write_mdata1_value
    Private read_mdata1_value
    Private flag_mdata1

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

    Property Get get_mdata1
        get_mdata1 = read_mdata1_value
    End Property

    Property Let set_mdata1(aData)
        write_mdata1_value = aData
        flag_mdata1        = &H1
    End Property

    Property Get read_mdata1
        read
        read_mdata1 = read_mdata1_value
    End Property

    Property Let write_mdata1(aData)
        set_mdata1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata1_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata1_mask = mask then
                read_mdata1_value = data_low
            else
                read_mdata1_value = (data_low - H8000_0000) and mdata1_mask
            end If
        else
            read_mdata1_value = data_low and mdata1_mask
        end If

    End Sub

    Sub write
        If flag_mdata1 = &H0 Then read
        If flag_mdata1 = &H0 Then write_mdata1_value = get_mdata1

        regValue = leftShift((write_mdata1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdata1_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata1_mask = mask then
                read_mdata1_value = data_low
            else
                read_mdata1_value = (data_low - H8000_0000) and mdata1_mask
            end If
        else
            read_mdata1_value = data_low and mdata1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdata1_value = &H0
        flag_mdata1        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_status1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Status1                                    [15:0]           get_Status1
''                                                             set_Status1
''                                                             read_Status1
''                                                             write_Status1
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_status1
    Private write_Status1_value
    Private read_Status1_value
    Private flag_Status1

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

    Property Get get_Status1
        get_Status1 = read_Status1_value
    End Property

    Property Let set_Status1(aData)
        write_Status1_value = aData
        flag_Status1        = &H1
    End Property

    Property Get read_Status1
        read
        read_Status1 = read_Status1_value
    End Property

    Property Let write_Status1(aData)
        set_Status1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Status1_mask = &Hffff
        if data_low > LONG_MAX then
            if Status1_mask = mask then
                read_Status1_value = data_low
            else
                read_Status1_value = (data_low - H8000_0000) and Status1_mask
            end If
        else
            read_Status1_value = data_low and Status1_mask
        end If

    End Sub

    Sub write
        If flag_Status1 = &H0 Then read
        If flag_Status1 = &H0 Then write_Status1_value = get_Status1

        regValue = leftShift((write_Status1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Status1_mask = &Hffff
        if data_low > LONG_MAX then
            if Status1_mask = mask then
                read_Status1_value = data_low
            else
                read_Status1_value = (data_low - H8000_0000) and Status1_mask
            end If
        else
            read_Status1_value = data_low and Status1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Status1_value = &H0
        flag_Status1        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_control1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rlfifo_tstsel                              [12:10]          get_rlfifo_tstsel
''                                                             set_rlfifo_tstsel
''                                                             read_rlfifo_tstsel
''                                                             write_rlfifo_tstsel
''---------------------------------------------------------------------------------
'' prbs_seed_ld                               [9:9]            get_prbs_seed_ld
''                                                             set_prbs_seed_ld
''                                                             read_prbs_seed_ld
''                                                             write_prbs_seed_ld
''---------------------------------------------------------------------------------
'' L0s_timer_ld                               [8:8]            get_L0s_timer_ld
''                                                             set_L0s_timer_ld
''                                                             read_L0s_timer_ld
''                                                             write_L0s_timer_ld
''---------------------------------------------------------------------------------
'' pktBurst_en                                [7:7]            get_pktBurst_en
''                                                             set_pktBurst_en
''                                                             read_pktBurst_en
''                                                             write_pktBurst_en
''---------------------------------------------------------------------------------
'' pktRndm_en                                 [6:6]            get_pktRndm_en
''                                                             set_pktRndm_en
''                                                             read_pktRndm_en
''                                                             write_pktRndm_en
''---------------------------------------------------------------------------------
'' ipgLngth                                   [5:4]            get_ipgLngth
''                                                             set_ipgLngth
''                                                             read_ipgLngth
''                                                             write_ipgLngth
''---------------------------------------------------------------------------------
'' RcvrDetectReqBypSel                        [3:3]            get_RcvrDetectReqBypSel
''                                                             set_RcvrDetectReqBypSel
''                                                             read_RcvrDetectReqBypSel
''                                                             write_RcvrDetectReqBypSel
''---------------------------------------------------------------------------------
'' RcvrDetectReqBypVal                        [2:2]            get_RcvrDetectReqBypVal
''                                                             set_RcvrDetectReqBypVal
''                                                             read_RcvrDetectReqBypVal
''                                                             write_RcvrDetectReqBypVal
''---------------------------------------------------------------------------------
'' pre_emph_stair_rev_en                      [1:1]            get_pre_emph_stair_rev_en
''                                                             set_pre_emph_stair_rev_en
''                                                             read_pre_emph_stair_rev_en
''                                                             write_pre_emph_stair_rev_en
''---------------------------------------------------------------------------------
'' pre_emph_stair_en                          [0:0]            get_pre_emph_stair_en
''                                                             set_pre_emph_stair_en
''                                                             read_pre_emph_stair_en
''                                                             write_pre_emph_stair_en
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_control1
    Private write_rlfifo_tstsel_value
    Private read_rlfifo_tstsel_value
    Private flag_rlfifo_tstsel
    Private write_prbs_seed_ld_value
    Private read_prbs_seed_ld_value
    Private flag_prbs_seed_ld
    Private write_L0s_timer_ld_value
    Private read_L0s_timer_ld_value
    Private flag_L0s_timer_ld
    Private write_pktBurst_en_value
    Private read_pktBurst_en_value
    Private flag_pktBurst_en
    Private write_pktRndm_en_value
    Private read_pktRndm_en_value
    Private flag_pktRndm_en
    Private write_ipgLngth_value
    Private read_ipgLngth_value
    Private flag_ipgLngth
    Private write_RcvrDetectReqBypSel_value
    Private read_RcvrDetectReqBypSel_value
    Private flag_RcvrDetectReqBypSel
    Private write_RcvrDetectReqBypVal_value
    Private read_RcvrDetectReqBypVal_value
    Private flag_RcvrDetectReqBypVal
    Private write_pre_emph_stair_rev_en_value
    Private read_pre_emph_stair_rev_en_value
    Private flag_pre_emph_stair_rev_en
    Private write_pre_emph_stair_en_value
    Private read_pre_emph_stair_en_value
    Private flag_pre_emph_stair_en

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

    Property Get get_rlfifo_tstsel
        get_rlfifo_tstsel = read_rlfifo_tstsel_value
    End Property

    Property Let set_rlfifo_tstsel(aData)
        write_rlfifo_tstsel_value = aData
        flag_rlfifo_tstsel        = &H1
    End Property

    Property Get read_rlfifo_tstsel
        read
        read_rlfifo_tstsel = read_rlfifo_tstsel_value
    End Property

    Property Let write_rlfifo_tstsel(aData)
        set_rlfifo_tstsel = aData
        write
    End Property

    Property Get get_prbs_seed_ld
        get_prbs_seed_ld = read_prbs_seed_ld_value
    End Property

    Property Let set_prbs_seed_ld(aData)
        write_prbs_seed_ld_value = aData
        flag_prbs_seed_ld        = &H1
    End Property

    Property Get read_prbs_seed_ld
        read
        read_prbs_seed_ld = read_prbs_seed_ld_value
    End Property

    Property Let write_prbs_seed_ld(aData)
        set_prbs_seed_ld = aData
        write
    End Property

    Property Get get_L0s_timer_ld
        get_L0s_timer_ld = read_L0s_timer_ld_value
    End Property

    Property Let set_L0s_timer_ld(aData)
        write_L0s_timer_ld_value = aData
        flag_L0s_timer_ld        = &H1
    End Property

    Property Get read_L0s_timer_ld
        read
        read_L0s_timer_ld = read_L0s_timer_ld_value
    End Property

    Property Let write_L0s_timer_ld(aData)
        set_L0s_timer_ld = aData
        write
    End Property

    Property Get get_pktBurst_en
        get_pktBurst_en = read_pktBurst_en_value
    End Property

    Property Let set_pktBurst_en(aData)
        write_pktBurst_en_value = aData
        flag_pktBurst_en        = &H1
    End Property

    Property Get read_pktBurst_en
        read
        read_pktBurst_en = read_pktBurst_en_value
    End Property

    Property Let write_pktBurst_en(aData)
        set_pktBurst_en = aData
        write
    End Property

    Property Get get_pktRndm_en
        get_pktRndm_en = read_pktRndm_en_value
    End Property

    Property Let set_pktRndm_en(aData)
        write_pktRndm_en_value = aData
        flag_pktRndm_en        = &H1
    End Property

    Property Get read_pktRndm_en
        read
        read_pktRndm_en = read_pktRndm_en_value
    End Property

    Property Let write_pktRndm_en(aData)
        set_pktRndm_en = aData
        write
    End Property

    Property Get get_ipgLngth
        get_ipgLngth = read_ipgLngth_value
    End Property

    Property Let set_ipgLngth(aData)
        write_ipgLngth_value = aData
        flag_ipgLngth        = &H1
    End Property

    Property Get read_ipgLngth
        read
        read_ipgLngth = read_ipgLngth_value
    End Property

    Property Let write_ipgLngth(aData)
        set_ipgLngth = aData
        write
    End Property

    Property Get get_RcvrDetectReqBypSel
        get_RcvrDetectReqBypSel = read_RcvrDetectReqBypSel_value
    End Property

    Property Let set_RcvrDetectReqBypSel(aData)
        write_RcvrDetectReqBypSel_value = aData
        flag_RcvrDetectReqBypSel        = &H1
    End Property

    Property Get read_RcvrDetectReqBypSel
        read
        read_RcvrDetectReqBypSel = read_RcvrDetectReqBypSel_value
    End Property

    Property Let write_RcvrDetectReqBypSel(aData)
        set_RcvrDetectReqBypSel = aData
        write
    End Property

    Property Get get_RcvrDetectReqBypVal
        get_RcvrDetectReqBypVal = read_RcvrDetectReqBypVal_value
    End Property

    Property Let set_RcvrDetectReqBypVal(aData)
        write_RcvrDetectReqBypVal_value = aData
        flag_RcvrDetectReqBypVal        = &H1
    End Property

    Property Get read_RcvrDetectReqBypVal
        read
        read_RcvrDetectReqBypVal = read_RcvrDetectReqBypVal_value
    End Property

    Property Let write_RcvrDetectReqBypVal(aData)
        set_RcvrDetectReqBypVal = aData
        write
    End Property

    Property Get get_pre_emph_stair_rev_en
        get_pre_emph_stair_rev_en = read_pre_emph_stair_rev_en_value
    End Property

    Property Let set_pre_emph_stair_rev_en(aData)
        write_pre_emph_stair_rev_en_value = aData
        flag_pre_emph_stair_rev_en        = &H1
    End Property

    Property Get read_pre_emph_stair_rev_en
        read
        read_pre_emph_stair_rev_en = read_pre_emph_stair_rev_en_value
    End Property

    Property Let write_pre_emph_stair_rev_en(aData)
        set_pre_emph_stair_rev_en = aData
        write
    End Property

    Property Get get_pre_emph_stair_en
        get_pre_emph_stair_en = read_pre_emph_stair_en_value
    End Property

    Property Let set_pre_emph_stair_en(aData)
        write_pre_emph_stair_en_value = aData
        flag_pre_emph_stair_en        = &H1
    End Property

    Property Get read_pre_emph_stair_en
        read
        read_pre_emph_stair_en = read_pre_emph_stair_en_value
    End Property

    Property Let write_pre_emph_stair_en(aData)
        set_pre_emph_stair_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rlfifo_tstsel_value = rightShift(data_low, 10) and &H7
        read_prbs_seed_ld_value = rightShift(data_low, 9) and &H1
        read_L0s_timer_ld_value = rightShift(data_low, 8) and &H1
        read_pktBurst_en_value = rightShift(data_low, 7) and &H1
        read_pktRndm_en_value = rightShift(data_low, 6) and &H1
        read_ipgLngth_value = rightShift(data_low, 4) and &H3
        read_RcvrDetectReqBypSel_value = rightShift(data_low, 3) and &H1
        read_RcvrDetectReqBypVal_value = rightShift(data_low, 2) and &H1
        read_pre_emph_stair_rev_en_value = rightShift(data_low, 1) and &H1
        pre_emph_stair_en_mask = &H1
        if data_low > LONG_MAX then
            if pre_emph_stair_en_mask = mask then
                read_pre_emph_stair_en_value = data_low
            else
                read_pre_emph_stair_en_value = (data_low - H8000_0000) and pre_emph_stair_en_mask
            end If
        else
            read_pre_emph_stair_en_value = data_low and pre_emph_stair_en_mask
        end If

    End Sub

    Sub write
        If flag_rlfifo_tstsel = &H0 or flag_prbs_seed_ld = &H0 or flag_L0s_timer_ld = &H0 or flag_pktBurst_en = &H0 or flag_pktRndm_en = &H0 or flag_ipgLngth = &H0 or flag_RcvrDetectReqBypSel = &H0 or flag_RcvrDetectReqBypVal = &H0 or flag_pre_emph_stair_rev_en = &H0 or flag_pre_emph_stair_en = &H0 Then read
        If flag_rlfifo_tstsel = &H0 Then write_rlfifo_tstsel_value = get_rlfifo_tstsel
        If flag_prbs_seed_ld = &H0 Then write_prbs_seed_ld_value = get_prbs_seed_ld
        If flag_L0s_timer_ld = &H0 Then write_L0s_timer_ld_value = get_L0s_timer_ld
        If flag_pktBurst_en = &H0 Then write_pktBurst_en_value = get_pktBurst_en
        If flag_pktRndm_en = &H0 Then write_pktRndm_en_value = get_pktRndm_en
        If flag_ipgLngth = &H0 Then write_ipgLngth_value = get_ipgLngth
        If flag_RcvrDetectReqBypSel = &H0 Then write_RcvrDetectReqBypSel_value = get_RcvrDetectReqBypSel
        If flag_RcvrDetectReqBypVal = &H0 Then write_RcvrDetectReqBypVal_value = get_RcvrDetectReqBypVal
        If flag_pre_emph_stair_rev_en = &H0 Then write_pre_emph_stair_rev_en_value = get_pre_emph_stair_rev_en
        If flag_pre_emph_stair_en = &H0 Then write_pre_emph_stair_en_value = get_pre_emph_stair_en

        regValue = leftShift((write_rlfifo_tstsel_value and &H7), 10) + leftShift((write_prbs_seed_ld_value and &H1), 9) + leftShift((write_L0s_timer_ld_value and &H1), 8) + leftShift((write_pktBurst_en_value and &H1), 7) + leftShift((write_pktRndm_en_value and &H1), 6) + leftShift((write_ipgLngth_value and &H3), 4) + leftShift((write_RcvrDetectReqBypSel_value and &H1), 3) + leftShift((write_RcvrDetectReqBypVal_value and &H1), 2) + leftShift((write_pre_emph_stair_rev_en_value and &H1), 1) + leftShift((write_pre_emph_stair_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rlfifo_tstsel_value = rightShift(data_low, 10) and &H7
        read_prbs_seed_ld_value = rightShift(data_low, 9) and &H1
        read_L0s_timer_ld_value = rightShift(data_low, 8) and &H1
        read_pktBurst_en_value = rightShift(data_low, 7) and &H1
        read_pktRndm_en_value = rightShift(data_low, 6) and &H1
        read_ipgLngth_value = rightShift(data_low, 4) and &H3
        read_RcvrDetectReqBypSel_value = rightShift(data_low, 3) and &H1
        read_RcvrDetectReqBypVal_value = rightShift(data_low, 2) and &H1
        read_pre_emph_stair_rev_en_value = rightShift(data_low, 1) and &H1
        pre_emph_stair_en_mask = &H1
        if data_low > LONG_MAX then
            if pre_emph_stair_en_mask = mask then
                read_pre_emph_stair_en_value = data_low
            else
                read_pre_emph_stair_en_value = (data_low - H8000_0000) and pre_emph_stair_en_mask
            end If
        else
            read_pre_emph_stair_en_value = data_low and pre_emph_stair_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rlfifo_tstsel_value = &H0
        flag_rlfifo_tstsel        = &H0
        write_prbs_seed_ld_value = &H0
        flag_prbs_seed_ld        = &H0
        write_L0s_timer_ld_value = &H0
        flag_L0s_timer_ld        = &H0
        write_pktBurst_en_value = &H0
        flag_pktBurst_en        = &H0
        write_pktRndm_en_value = &H0
        flag_pktRndm_en        = &H0
        write_ipgLngth_value = &H0
        flag_ipgLngth        = &H0
        write_RcvrDetectReqBypSel_value = &H0
        flag_RcvrDetectReqBypSel        = &H0
        write_RcvrDetectReqBypVal_value = &H0
        flag_RcvrDetectReqBypVal        = &H0
        write_pre_emph_stair_rev_en_value = &H0
        flag_pre_emph_stair_rev_en        = &H0
        write_pre_emph_stair_en_value = &H0
        flag_pre_emph_stair_en        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_control2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_control2

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


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_control3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pre_emph0                                  [9:5]            get_pre_emph0
''                                                             set_pre_emph0
''                                                             read_pre_emph0
''                                                             write_pre_emph0
''---------------------------------------------------------------------------------
'' g1_volt_swing0                             [4:0]            get_g1_volt_swing0
''                                                             set_g1_volt_swing0
''                                                             read_g1_volt_swing0
''                                                             write_g1_volt_swing0
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_control3
    Private write_pre_emph0_value
    Private read_pre_emph0_value
    Private flag_pre_emph0
    Private write_g1_volt_swing0_value
    Private read_g1_volt_swing0_value
    Private flag_g1_volt_swing0

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

    Property Get get_pre_emph0
        get_pre_emph0 = read_pre_emph0_value
    End Property

    Property Let set_pre_emph0(aData)
        write_pre_emph0_value = aData
        flag_pre_emph0        = &H1
    End Property

    Property Get read_pre_emph0
        read
        read_pre_emph0 = read_pre_emph0_value
    End Property

    Property Let write_pre_emph0(aData)
        set_pre_emph0 = aData
        write
    End Property

    Property Get get_g1_volt_swing0
        get_g1_volt_swing0 = read_g1_volt_swing0_value
    End Property

    Property Let set_g1_volt_swing0(aData)
        write_g1_volt_swing0_value = aData
        flag_g1_volt_swing0        = &H1
    End Property

    Property Get read_g1_volt_swing0
        read
        read_g1_volt_swing0 = read_g1_volt_swing0_value
    End Property

    Property Let write_g1_volt_swing0(aData)
        set_g1_volt_swing0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pre_emph0_value = rightShift(data_low, 5) and &H1f
        g1_volt_swing0_mask = &H1f
        if data_low > LONG_MAX then
            if g1_volt_swing0_mask = mask then
                read_g1_volt_swing0_value = data_low
            else
                read_g1_volt_swing0_value = (data_low - H8000_0000) and g1_volt_swing0_mask
            end If
        else
            read_g1_volt_swing0_value = data_low and g1_volt_swing0_mask
        end If

    End Sub

    Sub write
        If flag_pre_emph0 = &H0 or flag_g1_volt_swing0 = &H0 Then read
        If flag_pre_emph0 = &H0 Then write_pre_emph0_value = get_pre_emph0
        If flag_g1_volt_swing0 = &H0 Then write_g1_volt_swing0_value = get_g1_volt_swing0

        regValue = leftShift((write_pre_emph0_value and &H1f), 5) + leftShift((write_g1_volt_swing0_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pre_emph0_value = rightShift(data_low, 5) and &H1f
        g1_volt_swing0_mask = &H1f
        if data_low > LONG_MAX then
            if g1_volt_swing0_mask = mask then
                read_g1_volt_swing0_value = data_low
            else
                read_g1_volt_swing0_value = (data_low - H8000_0000) and g1_volt_swing0_mask
            end If
        else
            read_g1_volt_swing0_value = data_low and g1_volt_swing0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pre_emph0_value = &H0
        flag_pre_emph0        = &H0
        write_g1_volt_swing0_value = &H0
        flag_g1_volt_swing0        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_controlb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' G2TxEiDlyFallInv                           [15:15]          get_G2TxEiDlyFallInv
''                                                             set_G2TxEiDlyFallInv
''                                                             read_G2TxEiDlyFallInv
''                                                             write_G2TxEiDlyFallInv
''---------------------------------------------------------------------------------
'' G2TxEiDlyFall                              [14:12]          get_G2TxEiDlyFall
''                                                             set_G2TxEiDlyFall
''                                                             read_G2TxEiDlyFall
''                                                             write_G2TxEiDlyFall
''---------------------------------------------------------------------------------
'' G2TxEiDlyRiseInv                           [11:11]          get_G2TxEiDlyRiseInv
''                                                             set_G2TxEiDlyRiseInv
''                                                             read_G2TxEiDlyRiseInv
''                                                             write_G2TxEiDlyRiseInv
''---------------------------------------------------------------------------------
'' G2TxEiDlyRise                              [10:8]           get_G2TxEiDlyRise
''                                                             set_G2TxEiDlyRise
''                                                             read_G2TxEiDlyRise
''                                                             write_G2TxEiDlyRise
''---------------------------------------------------------------------------------
'' G1TxEiDlyFallInv                           [7:7]            get_G1TxEiDlyFallInv
''                                                             set_G1TxEiDlyFallInv
''                                                             read_G1TxEiDlyFallInv
''                                                             write_G1TxEiDlyFallInv
''---------------------------------------------------------------------------------
'' G1TxEiDlyFall                              [6:4]            get_G1TxEiDlyFall
''                                                             set_G1TxEiDlyFall
''                                                             read_G1TxEiDlyFall
''                                                             write_G1TxEiDlyFall
''---------------------------------------------------------------------------------
'' G1TxEiDlyRiseInv                           [3:3]            get_G1TxEiDlyRiseInv
''                                                             set_G1TxEiDlyRiseInv
''                                                             read_G1TxEiDlyRiseInv
''                                                             write_G1TxEiDlyRiseInv
''---------------------------------------------------------------------------------
'' G1TxEiDlyRise                              [2:0]            get_G1TxEiDlyRise
''                                                             set_G1TxEiDlyRise
''                                                             read_G1TxEiDlyRise
''                                                             write_G1TxEiDlyRise
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_controlb
    Private write_G2TxEiDlyFallInv_value
    Private read_G2TxEiDlyFallInv_value
    Private flag_G2TxEiDlyFallInv
    Private write_G2TxEiDlyFall_value
    Private read_G2TxEiDlyFall_value
    Private flag_G2TxEiDlyFall
    Private write_G2TxEiDlyRiseInv_value
    Private read_G2TxEiDlyRiseInv_value
    Private flag_G2TxEiDlyRiseInv
    Private write_G2TxEiDlyRise_value
    Private read_G2TxEiDlyRise_value
    Private flag_G2TxEiDlyRise
    Private write_G1TxEiDlyFallInv_value
    Private read_G1TxEiDlyFallInv_value
    Private flag_G1TxEiDlyFallInv
    Private write_G1TxEiDlyFall_value
    Private read_G1TxEiDlyFall_value
    Private flag_G1TxEiDlyFall
    Private write_G1TxEiDlyRiseInv_value
    Private read_G1TxEiDlyRiseInv_value
    Private flag_G1TxEiDlyRiseInv
    Private write_G1TxEiDlyRise_value
    Private read_G1TxEiDlyRise_value
    Private flag_G1TxEiDlyRise

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

    Property Get get_G2TxEiDlyFallInv
        get_G2TxEiDlyFallInv = read_G2TxEiDlyFallInv_value
    End Property

    Property Let set_G2TxEiDlyFallInv(aData)
        write_G2TxEiDlyFallInv_value = aData
        flag_G2TxEiDlyFallInv        = &H1
    End Property

    Property Get read_G2TxEiDlyFallInv
        read
        read_G2TxEiDlyFallInv = read_G2TxEiDlyFallInv_value
    End Property

    Property Let write_G2TxEiDlyFallInv(aData)
        set_G2TxEiDlyFallInv = aData
        write
    End Property

    Property Get get_G2TxEiDlyFall
        get_G2TxEiDlyFall = read_G2TxEiDlyFall_value
    End Property

    Property Let set_G2TxEiDlyFall(aData)
        write_G2TxEiDlyFall_value = aData
        flag_G2TxEiDlyFall        = &H1
    End Property

    Property Get read_G2TxEiDlyFall
        read
        read_G2TxEiDlyFall = read_G2TxEiDlyFall_value
    End Property

    Property Let write_G2TxEiDlyFall(aData)
        set_G2TxEiDlyFall = aData
        write
    End Property

    Property Get get_G2TxEiDlyRiseInv
        get_G2TxEiDlyRiseInv = read_G2TxEiDlyRiseInv_value
    End Property

    Property Let set_G2TxEiDlyRiseInv(aData)
        write_G2TxEiDlyRiseInv_value = aData
        flag_G2TxEiDlyRiseInv        = &H1
    End Property

    Property Get read_G2TxEiDlyRiseInv
        read
        read_G2TxEiDlyRiseInv = read_G2TxEiDlyRiseInv_value
    End Property

    Property Let write_G2TxEiDlyRiseInv(aData)
        set_G2TxEiDlyRiseInv = aData
        write
    End Property

    Property Get get_G2TxEiDlyRise
        get_G2TxEiDlyRise = read_G2TxEiDlyRise_value
    End Property

    Property Let set_G2TxEiDlyRise(aData)
        write_G2TxEiDlyRise_value = aData
        flag_G2TxEiDlyRise        = &H1
    End Property

    Property Get read_G2TxEiDlyRise
        read
        read_G2TxEiDlyRise = read_G2TxEiDlyRise_value
    End Property

    Property Let write_G2TxEiDlyRise(aData)
        set_G2TxEiDlyRise = aData
        write
    End Property

    Property Get get_G1TxEiDlyFallInv
        get_G1TxEiDlyFallInv = read_G1TxEiDlyFallInv_value
    End Property

    Property Let set_G1TxEiDlyFallInv(aData)
        write_G1TxEiDlyFallInv_value = aData
        flag_G1TxEiDlyFallInv        = &H1
    End Property

    Property Get read_G1TxEiDlyFallInv
        read
        read_G1TxEiDlyFallInv = read_G1TxEiDlyFallInv_value
    End Property

    Property Let write_G1TxEiDlyFallInv(aData)
        set_G1TxEiDlyFallInv = aData
        write
    End Property

    Property Get get_G1TxEiDlyFall
        get_G1TxEiDlyFall = read_G1TxEiDlyFall_value
    End Property

    Property Let set_G1TxEiDlyFall(aData)
        write_G1TxEiDlyFall_value = aData
        flag_G1TxEiDlyFall        = &H1
    End Property

    Property Get read_G1TxEiDlyFall
        read
        read_G1TxEiDlyFall = read_G1TxEiDlyFall_value
    End Property

    Property Let write_G1TxEiDlyFall(aData)
        set_G1TxEiDlyFall = aData
        write
    End Property

    Property Get get_G1TxEiDlyRiseInv
        get_G1TxEiDlyRiseInv = read_G1TxEiDlyRiseInv_value
    End Property

    Property Let set_G1TxEiDlyRiseInv(aData)
        write_G1TxEiDlyRiseInv_value = aData
        flag_G1TxEiDlyRiseInv        = &H1
    End Property

    Property Get read_G1TxEiDlyRiseInv
        read
        read_G1TxEiDlyRiseInv = read_G1TxEiDlyRiseInv_value
    End Property

    Property Let write_G1TxEiDlyRiseInv(aData)
        set_G1TxEiDlyRiseInv = aData
        write
    End Property

    Property Get get_G1TxEiDlyRise
        get_G1TxEiDlyRise = read_G1TxEiDlyRise_value
    End Property

    Property Let set_G1TxEiDlyRise(aData)
        write_G1TxEiDlyRise_value = aData
        flag_G1TxEiDlyRise        = &H1
    End Property

    Property Get read_G1TxEiDlyRise
        read
        read_G1TxEiDlyRise = read_G1TxEiDlyRise_value
    End Property

    Property Let write_G1TxEiDlyRise(aData)
        set_G1TxEiDlyRise = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_G2TxEiDlyFallInv_value = rightShift(data_low, 15) and &H1
        read_G2TxEiDlyFall_value = rightShift(data_low, 12) and &H7
        read_G2TxEiDlyRiseInv_value = rightShift(data_low, 11) and &H1
        read_G2TxEiDlyRise_value = rightShift(data_low, 8) and &H7
        read_G1TxEiDlyFallInv_value = rightShift(data_low, 7) and &H1
        read_G1TxEiDlyFall_value = rightShift(data_low, 4) and &H7
        read_G1TxEiDlyRiseInv_value = rightShift(data_low, 3) and &H1
        G1TxEiDlyRise_mask = &H7
        if data_low > LONG_MAX then
            if G1TxEiDlyRise_mask = mask then
                read_G1TxEiDlyRise_value = data_low
            else
                read_G1TxEiDlyRise_value = (data_low - H8000_0000) and G1TxEiDlyRise_mask
            end If
        else
            read_G1TxEiDlyRise_value = data_low and G1TxEiDlyRise_mask
        end If

    End Sub

    Sub write
        If flag_G2TxEiDlyFallInv = &H0 or flag_G2TxEiDlyFall = &H0 or flag_G2TxEiDlyRiseInv = &H0 or flag_G2TxEiDlyRise = &H0 or flag_G1TxEiDlyFallInv = &H0 or flag_G1TxEiDlyFall = &H0 or flag_G1TxEiDlyRiseInv = &H0 or flag_G1TxEiDlyRise = &H0 Then read
        If flag_G2TxEiDlyFallInv = &H0 Then write_G2TxEiDlyFallInv_value = get_G2TxEiDlyFallInv
        If flag_G2TxEiDlyFall = &H0 Then write_G2TxEiDlyFall_value = get_G2TxEiDlyFall
        If flag_G2TxEiDlyRiseInv = &H0 Then write_G2TxEiDlyRiseInv_value = get_G2TxEiDlyRiseInv
        If flag_G2TxEiDlyRise = &H0 Then write_G2TxEiDlyRise_value = get_G2TxEiDlyRise
        If flag_G1TxEiDlyFallInv = &H0 Then write_G1TxEiDlyFallInv_value = get_G1TxEiDlyFallInv
        If flag_G1TxEiDlyFall = &H0 Then write_G1TxEiDlyFall_value = get_G1TxEiDlyFall
        If flag_G1TxEiDlyRiseInv = &H0 Then write_G1TxEiDlyRiseInv_value = get_G1TxEiDlyRiseInv
        If flag_G1TxEiDlyRise = &H0 Then write_G1TxEiDlyRise_value = get_G1TxEiDlyRise

        regValue = leftShift((write_G2TxEiDlyFallInv_value and &H1), 15) + leftShift((write_G2TxEiDlyFall_value and &H7), 12) + leftShift((write_G2TxEiDlyRiseInv_value and &H1), 11) + leftShift((write_G2TxEiDlyRise_value and &H7), 8) + leftShift((write_G1TxEiDlyFallInv_value and &H1), 7) + leftShift((write_G1TxEiDlyFall_value and &H7), 4) + leftShift((write_G1TxEiDlyRiseInv_value and &H1), 3) + leftShift((write_G1TxEiDlyRise_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_G2TxEiDlyFallInv_value = rightShift(data_low, 15) and &H1
        read_G2TxEiDlyFall_value = rightShift(data_low, 12) and &H7
        read_G2TxEiDlyRiseInv_value = rightShift(data_low, 11) and &H1
        read_G2TxEiDlyRise_value = rightShift(data_low, 8) and &H7
        read_G1TxEiDlyFallInv_value = rightShift(data_low, 7) and &H1
        read_G1TxEiDlyFall_value = rightShift(data_low, 4) and &H7
        read_G1TxEiDlyRiseInv_value = rightShift(data_low, 3) and &H1
        G1TxEiDlyRise_mask = &H7
        if data_low > LONG_MAX then
            if G1TxEiDlyRise_mask = mask then
                read_G1TxEiDlyRise_value = data_low
            else
                read_G1TxEiDlyRise_value = (data_low - H8000_0000) and G1TxEiDlyRise_mask
            end If
        else
            read_G1TxEiDlyRise_value = data_low and G1TxEiDlyRise_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_G2TxEiDlyFallInv_value = &H0
        flag_G2TxEiDlyFallInv        = &H0
        write_G2TxEiDlyFall_value = &H0
        flag_G2TxEiDlyFall        = &H0
        write_G2TxEiDlyRiseInv_value = &H0
        flag_G2TxEiDlyRiseInv        = &H0
        write_G2TxEiDlyRise_value = &H0
        flag_G2TxEiDlyRise        = &H0
        write_G1TxEiDlyFallInv_value = &H0
        flag_G1TxEiDlyFallInv        = &H0
        write_G1TxEiDlyFall_value = &H0
        flag_G1TxEiDlyFall        = &H0
        write_G1TxEiDlyRiseInv_value = &H0
        flag_G1TxEiDlyRiseInv        = &H0
        write_G1TxEiDlyRise_value = &H0
        flag_G1TxEiDlyRise        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_controlc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ElecIdleBypSel                             [15:15]          get_ElecIdleBypSel
''                                                             set_ElecIdleBypSel
''                                                             read_ElecIdleBypSel
''                                                             write_ElecIdleBypSel
''---------------------------------------------------------------------------------
'' ElecIdleBypVal                             [14:14]          get_ElecIdleBypVal
''                                                             set_ElecIdleBypVal
''                                                             read_ElecIdleBypVal
''                                                             write_ElecIdleBypVal
''---------------------------------------------------------------------------------
'' G1RloopEiDly                               [13:0]           get_G1RloopEiDly
''                                                             set_G1RloopEiDly
''                                                             read_G1RloopEiDly
''                                                             write_G1RloopEiDly
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_controlc
    Private write_ElecIdleBypSel_value
    Private read_ElecIdleBypSel_value
    Private flag_ElecIdleBypSel
    Private write_ElecIdleBypVal_value
    Private read_ElecIdleBypVal_value
    Private flag_ElecIdleBypVal
    Private write_G1RloopEiDly_value
    Private read_G1RloopEiDly_value
    Private flag_G1RloopEiDly

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

    Property Get get_ElecIdleBypSel
        get_ElecIdleBypSel = read_ElecIdleBypSel_value
    End Property

    Property Let set_ElecIdleBypSel(aData)
        write_ElecIdleBypSel_value = aData
        flag_ElecIdleBypSel        = &H1
    End Property

    Property Get read_ElecIdleBypSel
        read
        read_ElecIdleBypSel = read_ElecIdleBypSel_value
    End Property

    Property Let write_ElecIdleBypSel(aData)
        set_ElecIdleBypSel = aData
        write
    End Property

    Property Get get_ElecIdleBypVal
        get_ElecIdleBypVal = read_ElecIdleBypVal_value
    End Property

    Property Let set_ElecIdleBypVal(aData)
        write_ElecIdleBypVal_value = aData
        flag_ElecIdleBypVal        = &H1
    End Property

    Property Get read_ElecIdleBypVal
        read
        read_ElecIdleBypVal = read_ElecIdleBypVal_value
    End Property

    Property Let write_ElecIdleBypVal(aData)
        set_ElecIdleBypVal = aData
        write
    End Property

    Property Get get_G1RloopEiDly
        get_G1RloopEiDly = read_G1RloopEiDly_value
    End Property

    Property Let set_G1RloopEiDly(aData)
        write_G1RloopEiDly_value = aData
        flag_G1RloopEiDly        = &H1
    End Property

    Property Get read_G1RloopEiDly
        read
        read_G1RloopEiDly = read_G1RloopEiDly_value
    End Property

    Property Let write_G1RloopEiDly(aData)
        set_G1RloopEiDly = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ElecIdleBypSel_value = rightShift(data_low, 15) and &H1
        read_ElecIdleBypVal_value = rightShift(data_low, 14) and &H1
        G1RloopEiDly_mask = &H3fff
        if data_low > LONG_MAX then
            if G1RloopEiDly_mask = mask then
                read_G1RloopEiDly_value = data_low
            else
                read_G1RloopEiDly_value = (data_low - H8000_0000) and G1RloopEiDly_mask
            end If
        else
            read_G1RloopEiDly_value = data_low and G1RloopEiDly_mask
        end If

    End Sub

    Sub write
        If flag_ElecIdleBypSel = &H0 or flag_ElecIdleBypVal = &H0 or flag_G1RloopEiDly = &H0 Then read
        If flag_ElecIdleBypSel = &H0 Then write_ElecIdleBypSel_value = get_ElecIdleBypSel
        If flag_ElecIdleBypVal = &H0 Then write_ElecIdleBypVal_value = get_ElecIdleBypVal
        If flag_G1RloopEiDly = &H0 Then write_G1RloopEiDly_value = get_G1RloopEiDly

        regValue = leftShift((write_ElecIdleBypSel_value and &H1), 15) + leftShift((write_ElecIdleBypVal_value and &H1), 14) + leftShift((write_G1RloopEiDly_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ElecIdleBypSel_value = rightShift(data_low, 15) and &H1
        read_ElecIdleBypVal_value = rightShift(data_low, 14) and &H1
        G1RloopEiDly_mask = &H3fff
        if data_low > LONG_MAX then
            if G1RloopEiDly_mask = mask then
                read_G1RloopEiDly_value = data_low
            else
                read_G1RloopEiDly_value = (data_low - H8000_0000) and G1RloopEiDly_mask
            end If
        else
            read_G1RloopEiDly_value = data_low and G1RloopEiDly_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ElecIdleBypSel_value = &H0
        flag_ElecIdleBypSel        = &H0
        write_ElecIdleBypVal_value = &H0
        flag_ElecIdleBypVal        = &H0
        write_G1RloopEiDly_value = &H0
        flag_G1RloopEiDly        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_controld
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TxTmuxSel                                  [15:13]          get_TxTmuxSel
''                                                             set_TxTmuxSel
''                                                             read_TxTmuxSel
''                                                             write_TxTmuxSel
''---------------------------------------------------------------------------------
'' TxMarginBypNum                             [12:10]          get_TxMarginBypNum
''                                                             set_TxMarginBypNum
''                                                             read_TxMarginBypNum
''                                                             write_TxMarginBypNum
''---------------------------------------------------------------------------------
'' TxMarginBypSel                             [9:9]            get_TxMarginBypSel
''                                                             set_TxMarginBypSel
''                                                             read_TxMarginBypSel
''                                                             write_TxMarginBypSel
''---------------------------------------------------------------------------------
'' TxMarginBypVal                             [8:8]            get_TxMarginBypVal
''                                                             set_TxMarginBypVal
''                                                             read_TxMarginBypVal
''                                                             write_TxMarginBypVal
''---------------------------------------------------------------------------------
'' TxDeemphBypSel                             [7:7]            get_TxDeemphBypSel
''                                                             set_TxDeemphBypSel
''                                                             read_TxDeemphBypSel
''                                                             write_TxDeemphBypSel
''---------------------------------------------------------------------------------
'' TxDeemphBypVal                             [6:6]            get_TxDeemphBypVal
''                                                             set_TxDeemphBypVal
''                                                             read_TxDeemphBypVal
''                                                             write_TxDeemphBypVal
''---------------------------------------------------------------------------------
'' TxSwingBypSel                              [5:5]            get_TxSwingBypSel
''                                                             set_TxSwingBypSel
''                                                             read_TxSwingBypSel
''                                                             write_TxSwingBypSel
''---------------------------------------------------------------------------------
'' TxSwingBypVal                              [4:4]            get_TxSwingBypVal
''                                                             set_TxSwingBypVal
''                                                             read_TxSwingBypVal
''                                                             write_TxSwingBypVal
''---------------------------------------------------------------------------------
'' RcvrDetectStatusBypSel                     [3:3]            get_RcvrDetectStatusBypSel
''                                                             set_RcvrDetectStatusBypSel
''                                                             read_RcvrDetectStatusBypSel
''                                                             write_RcvrDetectStatusBypSel
''---------------------------------------------------------------------------------
'' RcvrDetectStatusBypVal                     [2:2]            get_RcvrDetectStatusBypVal
''                                                             set_RcvrDetectStatusBypVal
''                                                             read_RcvrDetectStatusBypVal
''                                                             write_RcvrDetectStatusBypVal
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_controld
    Private write_TxTmuxSel_value
    Private read_TxTmuxSel_value
    Private flag_TxTmuxSel
    Private write_TxMarginBypNum_value
    Private read_TxMarginBypNum_value
    Private flag_TxMarginBypNum
    Private write_TxMarginBypSel_value
    Private read_TxMarginBypSel_value
    Private flag_TxMarginBypSel
    Private write_TxMarginBypVal_value
    Private read_TxMarginBypVal_value
    Private flag_TxMarginBypVal
    Private write_TxDeemphBypSel_value
    Private read_TxDeemphBypSel_value
    Private flag_TxDeemphBypSel
    Private write_TxDeemphBypVal_value
    Private read_TxDeemphBypVal_value
    Private flag_TxDeemphBypVal
    Private write_TxSwingBypSel_value
    Private read_TxSwingBypSel_value
    Private flag_TxSwingBypSel
    Private write_TxSwingBypVal_value
    Private read_TxSwingBypVal_value
    Private flag_TxSwingBypVal
    Private write_RcvrDetectStatusBypSel_value
    Private read_RcvrDetectStatusBypSel_value
    Private flag_RcvrDetectStatusBypSel
    Private write_RcvrDetectStatusBypVal_value
    Private read_RcvrDetectStatusBypVal_value
    Private flag_RcvrDetectStatusBypVal

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

    Property Get get_TxTmuxSel
        get_TxTmuxSel = read_TxTmuxSel_value
    End Property

    Property Let set_TxTmuxSel(aData)
        write_TxTmuxSel_value = aData
        flag_TxTmuxSel        = &H1
    End Property

    Property Get read_TxTmuxSel
        read
        read_TxTmuxSel = read_TxTmuxSel_value
    End Property

    Property Let write_TxTmuxSel(aData)
        set_TxTmuxSel = aData
        write
    End Property

    Property Get get_TxMarginBypNum
        get_TxMarginBypNum = read_TxMarginBypNum_value
    End Property

    Property Let set_TxMarginBypNum(aData)
        write_TxMarginBypNum_value = aData
        flag_TxMarginBypNum        = &H1
    End Property

    Property Get read_TxMarginBypNum
        read
        read_TxMarginBypNum = read_TxMarginBypNum_value
    End Property

    Property Let write_TxMarginBypNum(aData)
        set_TxMarginBypNum = aData
        write
    End Property

    Property Get get_TxMarginBypSel
        get_TxMarginBypSel = read_TxMarginBypSel_value
    End Property

    Property Let set_TxMarginBypSel(aData)
        write_TxMarginBypSel_value = aData
        flag_TxMarginBypSel        = &H1
    End Property

    Property Get read_TxMarginBypSel
        read
        read_TxMarginBypSel = read_TxMarginBypSel_value
    End Property

    Property Let write_TxMarginBypSel(aData)
        set_TxMarginBypSel = aData
        write
    End Property

    Property Get get_TxMarginBypVal
        get_TxMarginBypVal = read_TxMarginBypVal_value
    End Property

    Property Let set_TxMarginBypVal(aData)
        write_TxMarginBypVal_value = aData
        flag_TxMarginBypVal        = &H1
    End Property

    Property Get read_TxMarginBypVal
        read
        read_TxMarginBypVal = read_TxMarginBypVal_value
    End Property

    Property Let write_TxMarginBypVal(aData)
        set_TxMarginBypVal = aData
        write
    End Property

    Property Get get_TxDeemphBypSel
        get_TxDeemphBypSel = read_TxDeemphBypSel_value
    End Property

    Property Let set_TxDeemphBypSel(aData)
        write_TxDeemphBypSel_value = aData
        flag_TxDeemphBypSel        = &H1
    End Property

    Property Get read_TxDeemphBypSel
        read
        read_TxDeemphBypSel = read_TxDeemphBypSel_value
    End Property

    Property Let write_TxDeemphBypSel(aData)
        set_TxDeemphBypSel = aData
        write
    End Property

    Property Get get_TxDeemphBypVal
        get_TxDeemphBypVal = read_TxDeemphBypVal_value
    End Property

    Property Let set_TxDeemphBypVal(aData)
        write_TxDeemphBypVal_value = aData
        flag_TxDeemphBypVal        = &H1
    End Property

    Property Get read_TxDeemphBypVal
        read
        read_TxDeemphBypVal = read_TxDeemphBypVal_value
    End Property

    Property Let write_TxDeemphBypVal(aData)
        set_TxDeemphBypVal = aData
        write
    End Property

    Property Get get_TxSwingBypSel
        get_TxSwingBypSel = read_TxSwingBypSel_value
    End Property

    Property Let set_TxSwingBypSel(aData)
        write_TxSwingBypSel_value = aData
        flag_TxSwingBypSel        = &H1
    End Property

    Property Get read_TxSwingBypSel
        read
        read_TxSwingBypSel = read_TxSwingBypSel_value
    End Property

    Property Let write_TxSwingBypSel(aData)
        set_TxSwingBypSel = aData
        write
    End Property

    Property Get get_TxSwingBypVal
        get_TxSwingBypVal = read_TxSwingBypVal_value
    End Property

    Property Let set_TxSwingBypVal(aData)
        write_TxSwingBypVal_value = aData
        flag_TxSwingBypVal        = &H1
    End Property

    Property Get read_TxSwingBypVal
        read
        read_TxSwingBypVal = read_TxSwingBypVal_value
    End Property

    Property Let write_TxSwingBypVal(aData)
        set_TxSwingBypVal = aData
        write
    End Property

    Property Get get_RcvrDetectStatusBypSel
        get_RcvrDetectStatusBypSel = read_RcvrDetectStatusBypSel_value
    End Property

    Property Let set_RcvrDetectStatusBypSel(aData)
        write_RcvrDetectStatusBypSel_value = aData
        flag_RcvrDetectStatusBypSel        = &H1
    End Property

    Property Get read_RcvrDetectStatusBypSel
        read
        read_RcvrDetectStatusBypSel = read_RcvrDetectStatusBypSel_value
    End Property

    Property Let write_RcvrDetectStatusBypSel(aData)
        set_RcvrDetectStatusBypSel = aData
        write
    End Property

    Property Get get_RcvrDetectStatusBypVal
        get_RcvrDetectStatusBypVal = read_RcvrDetectStatusBypVal_value
    End Property

    Property Let set_RcvrDetectStatusBypVal(aData)
        write_RcvrDetectStatusBypVal_value = aData
        flag_RcvrDetectStatusBypVal        = &H1
    End Property

    Property Get read_RcvrDetectStatusBypVal
        read
        read_RcvrDetectStatusBypVal = read_RcvrDetectStatusBypVal_value
    End Property

    Property Let write_RcvrDetectStatusBypVal(aData)
        set_RcvrDetectStatusBypVal = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TxTmuxSel_value = rightShift(data_low, 13) and &H7
        read_TxMarginBypNum_value = rightShift(data_low, 10) and &H7
        read_TxMarginBypSel_value = rightShift(data_low, 9) and &H1
        read_TxMarginBypVal_value = rightShift(data_low, 8) and &H1
        read_TxDeemphBypSel_value = rightShift(data_low, 7) and &H1
        read_TxDeemphBypVal_value = rightShift(data_low, 6) and &H1
        read_TxSwingBypSel_value = rightShift(data_low, 5) and &H1
        read_TxSwingBypVal_value = rightShift(data_low, 4) and &H1
        read_RcvrDetectStatusBypSel_value = rightShift(data_low, 3) and &H1
        read_RcvrDetectStatusBypVal_value = rightShift(data_low, 2) and &H1

    End Sub

    Sub write
        If flag_TxTmuxSel = &H0 or flag_TxMarginBypNum = &H0 or flag_TxMarginBypSel = &H0 or flag_TxMarginBypVal = &H0 or flag_TxDeemphBypSel = &H0 or flag_TxDeemphBypVal = &H0 or flag_TxSwingBypSel = &H0 or flag_TxSwingBypVal = &H0 or flag_RcvrDetectStatusBypSel = &H0 or flag_RcvrDetectStatusBypVal = &H0 Then read
        If flag_TxTmuxSel = &H0 Then write_TxTmuxSel_value = get_TxTmuxSel
        If flag_TxMarginBypNum = &H0 Then write_TxMarginBypNum_value = get_TxMarginBypNum
        If flag_TxMarginBypSel = &H0 Then write_TxMarginBypSel_value = get_TxMarginBypSel
        If flag_TxMarginBypVal = &H0 Then write_TxMarginBypVal_value = get_TxMarginBypVal
        If flag_TxDeemphBypSel = &H0 Then write_TxDeemphBypSel_value = get_TxDeemphBypSel
        If flag_TxDeemphBypVal = &H0 Then write_TxDeemphBypVal_value = get_TxDeemphBypVal
        If flag_TxSwingBypSel = &H0 Then write_TxSwingBypSel_value = get_TxSwingBypSel
        If flag_TxSwingBypVal = &H0 Then write_TxSwingBypVal_value = get_TxSwingBypVal
        If flag_RcvrDetectStatusBypSel = &H0 Then write_RcvrDetectStatusBypSel_value = get_RcvrDetectStatusBypSel
        If flag_RcvrDetectStatusBypVal = &H0 Then write_RcvrDetectStatusBypVal_value = get_RcvrDetectStatusBypVal

        regValue = leftShift((write_TxTmuxSel_value and &H7), 13) + leftShift((write_TxMarginBypNum_value and &H7), 10) + leftShift((write_TxMarginBypSel_value and &H1), 9) + leftShift((write_TxMarginBypVal_value and &H1), 8) + leftShift((write_TxDeemphBypSel_value and &H1), 7) + leftShift((write_TxDeemphBypVal_value and &H1), 6) + leftShift((write_TxSwingBypSel_value and &H1), 5) + leftShift((write_TxSwingBypVal_value and &H1), 4) + leftShift((write_RcvrDetectStatusBypSel_value and &H1), 3) + leftShift((write_RcvrDetectStatusBypVal_value and &H1), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TxTmuxSel_value = rightShift(data_low, 13) and &H7
        read_TxMarginBypNum_value = rightShift(data_low, 10) and &H7
        read_TxMarginBypSel_value = rightShift(data_low, 9) and &H1
        read_TxMarginBypVal_value = rightShift(data_low, 8) and &H1
        read_TxDeemphBypSel_value = rightShift(data_low, 7) and &H1
        read_TxDeemphBypVal_value = rightShift(data_low, 6) and &H1
        read_TxSwingBypSel_value = rightShift(data_low, 5) and &H1
        read_TxSwingBypVal_value = rightShift(data_low, 4) and &H1
        read_RcvrDetectStatusBypSel_value = rightShift(data_low, 3) and &H1
        read_RcvrDetectStatusBypVal_value = rightShift(data_low, 2) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TxTmuxSel_value = &H0
        flag_TxTmuxSel        = &H0
        write_TxMarginBypNum_value = &H0
        flag_TxMarginBypNum        = &H0
        write_TxMarginBypSel_value = &H0
        flag_TxMarginBypSel        = &H0
        write_TxMarginBypVal_value = &H0
        flag_TxMarginBypVal        = &H0
        write_TxDeemphBypSel_value = &H0
        flag_TxDeemphBypSel        = &H0
        write_TxDeemphBypVal_value = &H0
        flag_TxDeemphBypVal        = &H0
        write_TxSwingBypSel_value = &H0
        flag_TxSwingBypSel        = &H0
        write_TxSwingBypVal_value = &H0
        flag_TxSwingBypVal        = &H0
        write_RcvrDetectStatusBypSel_value = &H0
        flag_RcvrDetectStatusBypSel        = &H0
        write_RcvrDetectStatusBypVal_value = &H0
        flag_RcvrDetectStatusBypVal        = &H0
    End Sub
End Class


'' @REGISTER : TX_DFE0__SGMIIPCIE_X1_controle
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' G2RloopEiDly                               [13:0]           get_G2RloopEiDly
''                                                             set_G2RloopEiDly
''                                                             read_G2RloopEiDly
''                                                             write_G2RloopEiDly
''---------------------------------------------------------------------------------
Class REGISTER_TX_DFE0__SGMIIPCIE_X1_controle
    Private write_G2RloopEiDly_value
    Private read_G2RloopEiDly_value
    Private flag_G2RloopEiDly

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

    Property Get get_G2RloopEiDly
        get_G2RloopEiDly = read_G2RloopEiDly_value
    End Property

    Property Let set_G2RloopEiDly(aData)
        write_G2RloopEiDly_value = aData
        flag_G2RloopEiDly        = &H1
    End Property

    Property Get read_G2RloopEiDly
        read
        read_G2RloopEiDly = read_G2RloopEiDly_value
    End Property

    Property Let write_G2RloopEiDly(aData)
        set_G2RloopEiDly = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        G2RloopEiDly_mask = &H3fff
        if data_low > LONG_MAX then
            if G2RloopEiDly_mask = mask then
                read_G2RloopEiDly_value = data_low
            else
                read_G2RloopEiDly_value = (data_low - H8000_0000) and G2RloopEiDly_mask
            end If
        else
            read_G2RloopEiDly_value = data_low and G2RloopEiDly_mask
        end If

    End Sub

    Sub write
        If flag_G2RloopEiDly = &H0 Then read
        If flag_G2RloopEiDly = &H0 Then write_G2RloopEiDly_value = get_G2RloopEiDly

        regValue = leftShift((write_G2RloopEiDly_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        G2RloopEiDly_mask = &H3fff
        if data_low > LONG_MAX then
            if G2RloopEiDly_mask = mask then
                read_G2RloopEiDly_value = data_low
            else
                read_G2RloopEiDly_value = (data_low - H8000_0000) and G2RloopEiDly_mask
            end If
        else
            read_G2RloopEiDly_value = data_low and G2RloopEiDly_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_G2RloopEiDly_value = &H0
        flag_G2RloopEiDly        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class TX_DFE0__SGMIIPCIE_X1_INSTANCE

    Public status0
    Public control0
    Public mdata0
    Public mdata1
    Public status1
    Public control1
    Public control2
    Public control3
    Public controlb
    Public controlc
    Public controld
    Public controle


    Public default function Init(aBaseAddr)
        Set status0 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_status0)(aBaseAddr, 16)
        Set control0 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_control0)(aBaseAddr, 16)
        Set mdata0 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_mdata0)(aBaseAddr, 16)
        Set mdata1 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_mdata1)(aBaseAddr, 16)
        Set status1 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_status1)(aBaseAddr, 16)
        Set control1 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_control1)(aBaseAddr, 16)
        Set control2 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_control2)(aBaseAddr, 16)
        Set control3 = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_control3)(aBaseAddr, 16)
        Set controlb = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_controlb)(aBaseAddr, 16)
        Set controlc = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_controlc)(aBaseAddr, 16)
        Set controld = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_controld)(aBaseAddr, 16)
        Set controle = (New REGISTER_TX_DFE0__SGMIIPCIE_X1_controle)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_DFE0__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
TX_DFE0__SGMIIPCIE_X1.Add ((New TX_DFE0__SGMIIPCIE_X1_INSTANCE)(&H4adea000))


