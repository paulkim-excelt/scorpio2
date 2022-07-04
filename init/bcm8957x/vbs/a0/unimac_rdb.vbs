

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


'' @REGISTER : UNIMAC_line_unimac_ipg_hd_bkp_cntl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3     [31:7]           get_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
''                                                             set_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
''                                                             read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
''                                                             write_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
''---------------------------------------------------------------------------------
'' IPG_HD_BKP_CNTL_IPG_CONFIG_RX              [6:2]            get_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
''                                                             set_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
''                                                             read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
''                                                             write_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
''---------------------------------------------------------------------------------
'' IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK             [1:1]            get_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
''                                                             set_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
''                                                             read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
''                                                             write_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
''---------------------------------------------------------------------------------
'' IPG_HD_BKP_CNTL_HD_FC_ENA                  [0:0]            get_IPG_HD_BKP_CNTL_HD_FC_ENA
''                                                             set_IPG_HD_BKP_CNTL_HD_FC_ENA
''                                                             read_IPG_HD_BKP_CNTL_HD_FC_ENA
''                                                             write_IPG_HD_BKP_CNTL_HD_FC_ENA
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_ipg_hd_bkp_cntl
    Private write_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value
    Private read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value
    Private flag_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
    Private write_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value
    Private read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value
    Private flag_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
    Private write_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value
    Private read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value
    Private flag_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
    Private write_IPG_HD_BKP_CNTL_HD_FC_ENA_value
    Private read_IPG_HD_BKP_CNTL_HD_FC_ENA_value
    Private flag_IPG_HD_BKP_CNTL_HD_FC_ENA

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

    Property Get get_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
        get_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3 = read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value
    End Property

    Property Let set_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3(aData)
        write_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value = aData
        flag_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3        = &H1
    End Property

    Property Get read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
        read
        read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3 = read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value
    End Property

    Property Let write_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3(aData)
        set_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3 = aData
        write
    End Property

    Property Get get_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
        get_IPG_HD_BKP_CNTL_IPG_CONFIG_RX = read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value
    End Property

    Property Let set_IPG_HD_BKP_CNTL_IPG_CONFIG_RX(aData)
        write_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value = aData
        flag_IPG_HD_BKP_CNTL_IPG_CONFIG_RX        = &H1
    End Property

    Property Get read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
        read
        read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX = read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value
    End Property

    Property Let write_IPG_HD_BKP_CNTL_IPG_CONFIG_RX(aData)
        set_IPG_HD_BKP_CNTL_IPG_CONFIG_RX = aData
        write
    End Property

    Property Get get_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
        get_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK = read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value
    End Property

    Property Let set_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK(aData)
        write_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value = aData
        flag_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK        = &H1
    End Property

    Property Get read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
        read
        read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK = read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value
    End Property

    Property Let write_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK(aData)
        set_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK = aData
        write
    End Property

    Property Get get_IPG_HD_BKP_CNTL_HD_FC_ENA
        get_IPG_HD_BKP_CNTL_HD_FC_ENA = read_IPG_HD_BKP_CNTL_HD_FC_ENA_value
    End Property

    Property Let set_IPG_HD_BKP_CNTL_HD_FC_ENA(aData)
        write_IPG_HD_BKP_CNTL_HD_FC_ENA_value = aData
        flag_IPG_HD_BKP_CNTL_HD_FC_ENA        = &H1
    End Property

    Property Get read_IPG_HD_BKP_CNTL_HD_FC_ENA
        read
        read_IPG_HD_BKP_CNTL_HD_FC_ENA = read_IPG_HD_BKP_CNTL_HD_FC_ENA_value
    End Property

    Property Let write_IPG_HD_BKP_CNTL_HD_FC_ENA(aData)
        set_IPG_HD_BKP_CNTL_HD_FC_ENA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value = rightShift(data_low, 7) and &H1ffffff
        read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value = rightShift(data_low, 2) and &H1f
        read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value = rightShift(data_low, 1) and &H1
        IPG_HD_BKP_CNTL_HD_FC_ENA_mask = &H1
        if data_low > LONG_MAX then
            if IPG_HD_BKP_CNTL_HD_FC_ENA_mask = mask then
                read_IPG_HD_BKP_CNTL_HD_FC_ENA_value = data_low
            else
                read_IPG_HD_BKP_CNTL_HD_FC_ENA_value = (data_low - H8000_0000) and IPG_HD_BKP_CNTL_HD_FC_ENA_mask
            end If
        else
            read_IPG_HD_BKP_CNTL_HD_FC_ENA_value = data_low and IPG_HD_BKP_CNTL_HD_FC_ENA_mask
        end If

    End Sub

    Sub write
        If flag_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3 = &H0 or flag_IPG_HD_BKP_CNTL_IPG_CONFIG_RX = &H0 or flag_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK = &H0 or flag_IPG_HD_BKP_CNTL_HD_FC_ENA = &H0 Then read
        If flag_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3 = &H0 Then write_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value = get_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3
        If flag_IPG_HD_BKP_CNTL_IPG_CONFIG_RX = &H0 Then write_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value = get_IPG_HD_BKP_CNTL_IPG_CONFIG_RX
        If flag_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK = &H0 Then write_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value = get_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK
        If flag_IPG_HD_BKP_CNTL_HD_FC_ENA = &H0 Then write_IPG_HD_BKP_CNTL_HD_FC_ENA_value = get_IPG_HD_BKP_CNTL_HD_FC_ENA

        regValue = leftShift((write_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value and &H1ffffff), 7) + leftShift((write_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value and &H1f), 2) + leftShift((write_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value and &H1), 1) + leftShift((write_IPG_HD_BKP_CNTL_HD_FC_ENA_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value = rightShift(data_low, 7) and &H1ffffff
        read_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value = rightShift(data_low, 2) and &H1f
        read_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value = rightShift(data_low, 1) and &H1
        IPG_HD_BKP_CNTL_HD_FC_ENA_mask = &H1
        if data_low > LONG_MAX then
            if IPG_HD_BKP_CNTL_HD_FC_ENA_mask = mask then
                read_IPG_HD_BKP_CNTL_HD_FC_ENA_value = data_low
            else
                read_IPG_HD_BKP_CNTL_HD_FC_ENA_value = (data_low - H8000_0000) and IPG_HD_BKP_CNTL_HD_FC_ENA_mask
            end If
        else
            read_IPG_HD_BKP_CNTL_HD_FC_ENA_value = data_low and IPG_HD_BKP_CNTL_HD_FC_ENA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3_value = &H0
        flag_IPG_HD_BKP_CNTL_IPG_HD_BKP_CNTL_RSVD_3        = &H0
        write_IPG_HD_BKP_CNTL_IPG_CONFIG_RX_value = &H0
        flag_IPG_HD_BKP_CNTL_IPG_CONFIG_RX        = &H0
        write_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK_value = &H0
        flag_IPG_HD_BKP_CNTL_HD_FC_BKOFF_OK        = &H0
        write_IPG_HD_BKP_CNTL_HD_FC_ENA_value = &H0
        flag_IPG_HD_BKP_CNTL_HD_FC_ENA        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_command_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28      [31:31]          get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
''                                                             set_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
''                                                             read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
''                                                             write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_RUNT_FILTER_DIS             [30:30]          get_COMMAND_CONFIG_RUNT_FILTER_DIS
''                                                             set_COMMAND_CONFIG_RUNT_FILTER_DIS
''                                                             read_COMMAND_CONFIG_RUNT_FILTER_DIS
''                                                             write_COMMAND_CONFIG_RUNT_FILTER_DIS
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_OOB_EFC_EN                  [29:29]          get_COMMAND_CONFIG_OOB_EFC_EN
''                                                             set_COMMAND_CONFIG_OOB_EFC_EN
''                                                             read_COMMAND_CONFIG_OOB_EFC_EN
''                                                             write_COMMAND_CONFIG_OOB_EFC_EN
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_IGNORE_TX_PAUSE             [28:28]          get_COMMAND_CONFIG_IGNORE_TX_PAUSE
''                                                             set_COMMAND_CONFIG_IGNORE_TX_PAUSE
''                                                             read_COMMAND_CONFIG_IGNORE_TX_PAUSE
''                                                             write_COMMAND_CONFIG_IGNORE_TX_PAUSE
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_FD_TX_URUN_FIX_EN           [27:27]          get_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
''                                                             set_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
''                                                             read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
''                                                             write_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_RX_ERR_DISC                 [26:26]          get_COMMAND_CONFIG_RX_ERR_DISC
''                                                             set_COMMAND_CONFIG_RX_ERR_DISC
''                                                             read_COMMAND_CONFIG_RX_ERR_DISC
''                                                             write_COMMAND_CONFIG_RX_ERR_DISC
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_LINE_LOOPBACK               [25:25]          get_COMMAND_CONFIG_LINE_LOOPBACK
''                                                             set_COMMAND_CONFIG_LINE_LOOPBACK
''                                                             read_COMMAND_CONFIG_LINE_LOOPBACK
''                                                             write_COMMAND_CONFIG_LINE_LOOPBACK
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_NO_LGTH_CHECK               [24:24]          get_COMMAND_CONFIG_NO_LGTH_CHECK
''                                                             set_COMMAND_CONFIG_NO_LGTH_CHECK
''                                                             read_COMMAND_CONFIG_NO_LGTH_CHECK
''                                                             write_COMMAND_CONFIG_NO_LGTH_CHECK
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_CNTL_FRM_ENA                [23:23]          get_COMMAND_CONFIG_CNTL_FRM_ENA
''                                                             set_COMMAND_CONFIG_CNTL_FRM_ENA
''                                                             read_COMMAND_CONFIG_CNTL_FRM_ENA
''                                                             write_COMMAND_CONFIG_CNTL_FRM_ENA
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_ENA_EXT_CONFIG              [22:22]          get_COMMAND_CONFIG_ENA_EXT_CONFIG
''                                                             set_COMMAND_CONFIG_ENA_EXT_CONFIG
''                                                             read_COMMAND_CONFIG_ENA_EXT_CONFIG
''                                                             write_COMMAND_CONFIG_ENA_EXT_CONFIG
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_EN_INTERNAL_TX_CRS          [21:21]          get_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
''                                                             set_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
''                                                             read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
''                                                             write_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18      [20:19]          get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
''                                                             set_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
''                                                             read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
''                                                             write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_SW_OVERRIDE_RX              [18:18]          get_COMMAND_CONFIG_SW_OVERRIDE_RX
''                                                             set_COMMAND_CONFIG_SW_OVERRIDE_RX
''                                                             read_COMMAND_CONFIG_SW_OVERRIDE_RX
''                                                             write_COMMAND_CONFIG_SW_OVERRIDE_RX
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_SW_OVERRIDE_TX              [17:17]          get_COMMAND_CONFIG_SW_OVERRIDE_TX
''                                                             set_COMMAND_CONFIG_SW_OVERRIDE_TX
''                                                             read_COMMAND_CONFIG_SW_OVERRIDE_TX
''                                                             write_COMMAND_CONFIG_SW_OVERRIDE_TX
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_MAC_LOOP_CON                [16:16]          get_COMMAND_CONFIG_MAC_LOOP_CON
''                                                             set_COMMAND_CONFIG_MAC_LOOP_CON
''                                                             read_COMMAND_CONFIG_MAC_LOOP_CON
''                                                             write_COMMAND_CONFIG_MAC_LOOP_CON
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_LOOP_ENA                    [15:15]          get_COMMAND_CONFIG_LOOP_ENA
''                                                             set_COMMAND_CONFIG_LOOP_ENA
''                                                             read_COMMAND_CONFIG_LOOP_ENA
''                                                             write_COMMAND_CONFIG_LOOP_ENA
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_FCS_CORRUPT_URUN_EN         [14:14]          get_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
''                                                             set_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
''                                                             read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
''                                                             write_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_SW_RESET                    [13:13]          get_COMMAND_CONFIG_SW_RESET
''                                                             set_COMMAND_CONFIG_SW_RESET
''                                                             read_COMMAND_CONFIG_SW_RESET
''                                                             write_COMMAND_CONFIG_SW_RESET
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_OVERFLOW_EN                 [12:12]          get_COMMAND_CONFIG_OVERFLOW_EN
''                                                             set_COMMAND_CONFIG_OVERFLOW_EN
''                                                             read_COMMAND_CONFIG_OVERFLOW_EN
''                                                             write_COMMAND_CONFIG_OVERFLOW_EN
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_RX_LOW_LATENCY_EN           [11:11]          get_COMMAND_CONFIG_RX_LOW_LATENCY_EN
''                                                             set_COMMAND_CONFIG_RX_LOW_LATENCY_EN
''                                                             read_COMMAND_CONFIG_RX_LOW_LATENCY_EN
''                                                             write_COMMAND_CONFIG_RX_LOW_LATENCY_EN
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_HD_ENA                      [10:10]          get_COMMAND_CONFIG_HD_ENA
''                                                             set_COMMAND_CONFIG_HD_ENA
''                                                             read_COMMAND_CONFIG_HD_ENA
''                                                             write_COMMAND_CONFIG_HD_ENA
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_TX_ADDR_INS                 [9:9]            get_COMMAND_CONFIG_TX_ADDR_INS
''                                                             set_COMMAND_CONFIG_TX_ADDR_INS
''                                                             read_COMMAND_CONFIG_TX_ADDR_INS
''                                                             write_COMMAND_CONFIG_TX_ADDR_INS
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_PAUSE_IGNORE                [8:8]            get_COMMAND_CONFIG_PAUSE_IGNORE
''                                                             set_COMMAND_CONFIG_PAUSE_IGNORE
''                                                             read_COMMAND_CONFIG_PAUSE_IGNORE
''                                                             write_COMMAND_CONFIG_PAUSE_IGNORE
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_PAUSE_FWD                   [7:7]            get_COMMAND_CONFIG_PAUSE_FWD
''                                                             set_COMMAND_CONFIG_PAUSE_FWD
''                                                             read_COMMAND_CONFIG_PAUSE_FWD
''                                                             write_COMMAND_CONFIG_PAUSE_FWD
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_CRC_FWD                     [6:6]            get_COMMAND_CONFIG_CRC_FWD
''                                                             set_COMMAND_CONFIG_CRC_FWD
''                                                             read_COMMAND_CONFIG_CRC_FWD
''                                                             write_COMMAND_CONFIG_CRC_FWD
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_PAD_EN                      [5:5]            get_COMMAND_CONFIG_PAD_EN
''                                                             set_COMMAND_CONFIG_PAD_EN
''                                                             read_COMMAND_CONFIG_PAD_EN
''                                                             write_COMMAND_CONFIG_PAD_EN
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_PROMIS_EN                   [4:4]            get_COMMAND_CONFIG_PROMIS_EN
''                                                             set_COMMAND_CONFIG_PROMIS_EN
''                                                             read_COMMAND_CONFIG_PROMIS_EN
''                                                             write_COMMAND_CONFIG_PROMIS_EN
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_ETH_SPEED                   [3:2]            get_COMMAND_CONFIG_ETH_SPEED
''                                                             set_COMMAND_CONFIG_ETH_SPEED
''                                                             read_COMMAND_CONFIG_ETH_SPEED
''                                                             write_COMMAND_CONFIG_ETH_SPEED
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_RX_ENA                      [1:1]            get_COMMAND_CONFIG_RX_ENA
''                                                             set_COMMAND_CONFIG_RX_ENA
''                                                             read_COMMAND_CONFIG_RX_ENA
''                                                             write_COMMAND_CONFIG_RX_ENA
''---------------------------------------------------------------------------------
'' COMMAND_CONFIG_TX_ENA                      [0:0]            get_COMMAND_CONFIG_TX_ENA
''                                                             set_COMMAND_CONFIG_TX_ENA
''                                                             read_COMMAND_CONFIG_TX_ENA
''                                                             write_COMMAND_CONFIG_TX_ENA
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_command_config
    Private write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value
    Private read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value
    Private flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
    Private write_COMMAND_CONFIG_RUNT_FILTER_DIS_value
    Private read_COMMAND_CONFIG_RUNT_FILTER_DIS_value
    Private flag_COMMAND_CONFIG_RUNT_FILTER_DIS
    Private write_COMMAND_CONFIG_OOB_EFC_EN_value
    Private read_COMMAND_CONFIG_OOB_EFC_EN_value
    Private flag_COMMAND_CONFIG_OOB_EFC_EN
    Private write_COMMAND_CONFIG_IGNORE_TX_PAUSE_value
    Private read_COMMAND_CONFIG_IGNORE_TX_PAUSE_value
    Private flag_COMMAND_CONFIG_IGNORE_TX_PAUSE
    Private write_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value
    Private read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value
    Private flag_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
    Private write_COMMAND_CONFIG_RX_ERR_DISC_value
    Private read_COMMAND_CONFIG_RX_ERR_DISC_value
    Private flag_COMMAND_CONFIG_RX_ERR_DISC
    Private write_COMMAND_CONFIG_LINE_LOOPBACK_value
    Private read_COMMAND_CONFIG_LINE_LOOPBACK_value
    Private flag_COMMAND_CONFIG_LINE_LOOPBACK
    Private write_COMMAND_CONFIG_NO_LGTH_CHECK_value
    Private read_COMMAND_CONFIG_NO_LGTH_CHECK_value
    Private flag_COMMAND_CONFIG_NO_LGTH_CHECK
    Private write_COMMAND_CONFIG_CNTL_FRM_ENA_value
    Private read_COMMAND_CONFIG_CNTL_FRM_ENA_value
    Private flag_COMMAND_CONFIG_CNTL_FRM_ENA
    Private write_COMMAND_CONFIG_ENA_EXT_CONFIG_value
    Private read_COMMAND_CONFIG_ENA_EXT_CONFIG_value
    Private flag_COMMAND_CONFIG_ENA_EXT_CONFIG
    Private write_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value
    Private read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value
    Private flag_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
    Private write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value
    Private read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value
    Private flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
    Private write_COMMAND_CONFIG_SW_OVERRIDE_RX_value
    Private read_COMMAND_CONFIG_SW_OVERRIDE_RX_value
    Private flag_COMMAND_CONFIG_SW_OVERRIDE_RX
    Private write_COMMAND_CONFIG_SW_OVERRIDE_TX_value
    Private read_COMMAND_CONFIG_SW_OVERRIDE_TX_value
    Private flag_COMMAND_CONFIG_SW_OVERRIDE_TX
    Private write_COMMAND_CONFIG_MAC_LOOP_CON_value
    Private read_COMMAND_CONFIG_MAC_LOOP_CON_value
    Private flag_COMMAND_CONFIG_MAC_LOOP_CON
    Private write_COMMAND_CONFIG_LOOP_ENA_value
    Private read_COMMAND_CONFIG_LOOP_ENA_value
    Private flag_COMMAND_CONFIG_LOOP_ENA
    Private write_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value
    Private read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value
    Private flag_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
    Private write_COMMAND_CONFIG_SW_RESET_value
    Private read_COMMAND_CONFIG_SW_RESET_value
    Private flag_COMMAND_CONFIG_SW_RESET
    Private write_COMMAND_CONFIG_OVERFLOW_EN_value
    Private read_COMMAND_CONFIG_OVERFLOW_EN_value
    Private flag_COMMAND_CONFIG_OVERFLOW_EN
    Private write_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value
    Private read_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value
    Private flag_COMMAND_CONFIG_RX_LOW_LATENCY_EN
    Private write_COMMAND_CONFIG_HD_ENA_value
    Private read_COMMAND_CONFIG_HD_ENA_value
    Private flag_COMMAND_CONFIG_HD_ENA
    Private write_COMMAND_CONFIG_TX_ADDR_INS_value
    Private read_COMMAND_CONFIG_TX_ADDR_INS_value
    Private flag_COMMAND_CONFIG_TX_ADDR_INS
    Private write_COMMAND_CONFIG_PAUSE_IGNORE_value
    Private read_COMMAND_CONFIG_PAUSE_IGNORE_value
    Private flag_COMMAND_CONFIG_PAUSE_IGNORE
    Private write_COMMAND_CONFIG_PAUSE_FWD_value
    Private read_COMMAND_CONFIG_PAUSE_FWD_value
    Private flag_COMMAND_CONFIG_PAUSE_FWD
    Private write_COMMAND_CONFIG_CRC_FWD_value
    Private read_COMMAND_CONFIG_CRC_FWD_value
    Private flag_COMMAND_CONFIG_CRC_FWD
    Private write_COMMAND_CONFIG_PAD_EN_value
    Private read_COMMAND_CONFIG_PAD_EN_value
    Private flag_COMMAND_CONFIG_PAD_EN
    Private write_COMMAND_CONFIG_PROMIS_EN_value
    Private read_COMMAND_CONFIG_PROMIS_EN_value
    Private flag_COMMAND_CONFIG_PROMIS_EN
    Private write_COMMAND_CONFIG_ETH_SPEED_value
    Private read_COMMAND_CONFIG_ETH_SPEED_value
    Private flag_COMMAND_CONFIG_ETH_SPEED
    Private write_COMMAND_CONFIG_RX_ENA_value
    Private read_COMMAND_CONFIG_RX_ENA_value
    Private flag_COMMAND_CONFIG_RX_ENA
    Private write_COMMAND_CONFIG_TX_ENA_value
    Private read_COMMAND_CONFIG_TX_ENA_value
    Private flag_COMMAND_CONFIG_TX_ENA

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

    Property Get get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
        get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28 = read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value
    End Property

    Property Let set_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28(aData)
        write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value = aData
        flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
        read
        read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28 = read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value
    End Property

    Property Let write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28(aData)
        set_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28 = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_RUNT_FILTER_DIS
        get_COMMAND_CONFIG_RUNT_FILTER_DIS = read_COMMAND_CONFIG_RUNT_FILTER_DIS_value
    End Property

    Property Let set_COMMAND_CONFIG_RUNT_FILTER_DIS(aData)
        write_COMMAND_CONFIG_RUNT_FILTER_DIS_value = aData
        flag_COMMAND_CONFIG_RUNT_FILTER_DIS        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_RUNT_FILTER_DIS
        read
        read_COMMAND_CONFIG_RUNT_FILTER_DIS = read_COMMAND_CONFIG_RUNT_FILTER_DIS_value
    End Property

    Property Let write_COMMAND_CONFIG_RUNT_FILTER_DIS(aData)
        set_COMMAND_CONFIG_RUNT_FILTER_DIS = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_OOB_EFC_EN
        get_COMMAND_CONFIG_OOB_EFC_EN = read_COMMAND_CONFIG_OOB_EFC_EN_value
    End Property

    Property Let set_COMMAND_CONFIG_OOB_EFC_EN(aData)
        write_COMMAND_CONFIG_OOB_EFC_EN_value = aData
        flag_COMMAND_CONFIG_OOB_EFC_EN        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_OOB_EFC_EN
        read
        read_COMMAND_CONFIG_OOB_EFC_EN = read_COMMAND_CONFIG_OOB_EFC_EN_value
    End Property

    Property Let write_COMMAND_CONFIG_OOB_EFC_EN(aData)
        set_COMMAND_CONFIG_OOB_EFC_EN = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_IGNORE_TX_PAUSE
        get_COMMAND_CONFIG_IGNORE_TX_PAUSE = read_COMMAND_CONFIG_IGNORE_TX_PAUSE_value
    End Property

    Property Let set_COMMAND_CONFIG_IGNORE_TX_PAUSE(aData)
        write_COMMAND_CONFIG_IGNORE_TX_PAUSE_value = aData
        flag_COMMAND_CONFIG_IGNORE_TX_PAUSE        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_IGNORE_TX_PAUSE
        read
        read_COMMAND_CONFIG_IGNORE_TX_PAUSE = read_COMMAND_CONFIG_IGNORE_TX_PAUSE_value
    End Property

    Property Let write_COMMAND_CONFIG_IGNORE_TX_PAUSE(aData)
        set_COMMAND_CONFIG_IGNORE_TX_PAUSE = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
        get_COMMAND_CONFIG_FD_TX_URUN_FIX_EN = read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value
    End Property

    Property Let set_COMMAND_CONFIG_FD_TX_URUN_FIX_EN(aData)
        write_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value = aData
        flag_COMMAND_CONFIG_FD_TX_URUN_FIX_EN        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
        read
        read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN = read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value
    End Property

    Property Let write_COMMAND_CONFIG_FD_TX_URUN_FIX_EN(aData)
        set_COMMAND_CONFIG_FD_TX_URUN_FIX_EN = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_RX_ERR_DISC
        get_COMMAND_CONFIG_RX_ERR_DISC = read_COMMAND_CONFIG_RX_ERR_DISC_value
    End Property

    Property Let set_COMMAND_CONFIG_RX_ERR_DISC(aData)
        write_COMMAND_CONFIG_RX_ERR_DISC_value = aData
        flag_COMMAND_CONFIG_RX_ERR_DISC        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_RX_ERR_DISC
        read
        read_COMMAND_CONFIG_RX_ERR_DISC = read_COMMAND_CONFIG_RX_ERR_DISC_value
    End Property

    Property Let write_COMMAND_CONFIG_RX_ERR_DISC(aData)
        set_COMMAND_CONFIG_RX_ERR_DISC = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_LINE_LOOPBACK
        get_COMMAND_CONFIG_LINE_LOOPBACK = read_COMMAND_CONFIG_LINE_LOOPBACK_value
    End Property

    Property Let set_COMMAND_CONFIG_LINE_LOOPBACK(aData)
        write_COMMAND_CONFIG_LINE_LOOPBACK_value = aData
        flag_COMMAND_CONFIG_LINE_LOOPBACK        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_LINE_LOOPBACK
        read
        read_COMMAND_CONFIG_LINE_LOOPBACK = read_COMMAND_CONFIG_LINE_LOOPBACK_value
    End Property

    Property Let write_COMMAND_CONFIG_LINE_LOOPBACK(aData)
        set_COMMAND_CONFIG_LINE_LOOPBACK = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_NO_LGTH_CHECK
        get_COMMAND_CONFIG_NO_LGTH_CHECK = read_COMMAND_CONFIG_NO_LGTH_CHECK_value
    End Property

    Property Let set_COMMAND_CONFIG_NO_LGTH_CHECK(aData)
        write_COMMAND_CONFIG_NO_LGTH_CHECK_value = aData
        flag_COMMAND_CONFIG_NO_LGTH_CHECK        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_NO_LGTH_CHECK
        read
        read_COMMAND_CONFIG_NO_LGTH_CHECK = read_COMMAND_CONFIG_NO_LGTH_CHECK_value
    End Property

    Property Let write_COMMAND_CONFIG_NO_LGTH_CHECK(aData)
        set_COMMAND_CONFIG_NO_LGTH_CHECK = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_CNTL_FRM_ENA
        get_COMMAND_CONFIG_CNTL_FRM_ENA = read_COMMAND_CONFIG_CNTL_FRM_ENA_value
    End Property

    Property Let set_COMMAND_CONFIG_CNTL_FRM_ENA(aData)
        write_COMMAND_CONFIG_CNTL_FRM_ENA_value = aData
        flag_COMMAND_CONFIG_CNTL_FRM_ENA        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_CNTL_FRM_ENA
        read
        read_COMMAND_CONFIG_CNTL_FRM_ENA = read_COMMAND_CONFIG_CNTL_FRM_ENA_value
    End Property

    Property Let write_COMMAND_CONFIG_CNTL_FRM_ENA(aData)
        set_COMMAND_CONFIG_CNTL_FRM_ENA = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_ENA_EXT_CONFIG
        get_COMMAND_CONFIG_ENA_EXT_CONFIG = read_COMMAND_CONFIG_ENA_EXT_CONFIG_value
    End Property

    Property Let set_COMMAND_CONFIG_ENA_EXT_CONFIG(aData)
        write_COMMAND_CONFIG_ENA_EXT_CONFIG_value = aData
        flag_COMMAND_CONFIG_ENA_EXT_CONFIG        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_ENA_EXT_CONFIG
        read
        read_COMMAND_CONFIG_ENA_EXT_CONFIG = read_COMMAND_CONFIG_ENA_EXT_CONFIG_value
    End Property

    Property Let write_COMMAND_CONFIG_ENA_EXT_CONFIG(aData)
        set_COMMAND_CONFIG_ENA_EXT_CONFIG = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
        get_COMMAND_CONFIG_EN_INTERNAL_TX_CRS = read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value
    End Property

    Property Let set_COMMAND_CONFIG_EN_INTERNAL_TX_CRS(aData)
        write_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value = aData
        flag_COMMAND_CONFIG_EN_INTERNAL_TX_CRS        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
        read
        read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS = read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value
    End Property

    Property Let write_COMMAND_CONFIG_EN_INTERNAL_TX_CRS(aData)
        set_COMMAND_CONFIG_EN_INTERNAL_TX_CRS = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
        get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18 = read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value
    End Property

    Property Let set_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18(aData)
        write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value = aData
        flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
        read
        read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18 = read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value
    End Property

    Property Let write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18(aData)
        set_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18 = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_SW_OVERRIDE_RX
        get_COMMAND_CONFIG_SW_OVERRIDE_RX = read_COMMAND_CONFIG_SW_OVERRIDE_RX_value
    End Property

    Property Let set_COMMAND_CONFIG_SW_OVERRIDE_RX(aData)
        write_COMMAND_CONFIG_SW_OVERRIDE_RX_value = aData
        flag_COMMAND_CONFIG_SW_OVERRIDE_RX        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_SW_OVERRIDE_RX
        read
        read_COMMAND_CONFIG_SW_OVERRIDE_RX = read_COMMAND_CONFIG_SW_OVERRIDE_RX_value
    End Property

    Property Let write_COMMAND_CONFIG_SW_OVERRIDE_RX(aData)
        set_COMMAND_CONFIG_SW_OVERRIDE_RX = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_SW_OVERRIDE_TX
        get_COMMAND_CONFIG_SW_OVERRIDE_TX = read_COMMAND_CONFIG_SW_OVERRIDE_TX_value
    End Property

    Property Let set_COMMAND_CONFIG_SW_OVERRIDE_TX(aData)
        write_COMMAND_CONFIG_SW_OVERRIDE_TX_value = aData
        flag_COMMAND_CONFIG_SW_OVERRIDE_TX        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_SW_OVERRIDE_TX
        read
        read_COMMAND_CONFIG_SW_OVERRIDE_TX = read_COMMAND_CONFIG_SW_OVERRIDE_TX_value
    End Property

    Property Let write_COMMAND_CONFIG_SW_OVERRIDE_TX(aData)
        set_COMMAND_CONFIG_SW_OVERRIDE_TX = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_MAC_LOOP_CON
        get_COMMAND_CONFIG_MAC_LOOP_CON = read_COMMAND_CONFIG_MAC_LOOP_CON_value
    End Property

    Property Let set_COMMAND_CONFIG_MAC_LOOP_CON(aData)
        write_COMMAND_CONFIG_MAC_LOOP_CON_value = aData
        flag_COMMAND_CONFIG_MAC_LOOP_CON        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_MAC_LOOP_CON
        read
        read_COMMAND_CONFIG_MAC_LOOP_CON = read_COMMAND_CONFIG_MAC_LOOP_CON_value
    End Property

    Property Let write_COMMAND_CONFIG_MAC_LOOP_CON(aData)
        set_COMMAND_CONFIG_MAC_LOOP_CON = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_LOOP_ENA
        get_COMMAND_CONFIG_LOOP_ENA = read_COMMAND_CONFIG_LOOP_ENA_value
    End Property

    Property Let set_COMMAND_CONFIG_LOOP_ENA(aData)
        write_COMMAND_CONFIG_LOOP_ENA_value = aData
        flag_COMMAND_CONFIG_LOOP_ENA        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_LOOP_ENA
        read
        read_COMMAND_CONFIG_LOOP_ENA = read_COMMAND_CONFIG_LOOP_ENA_value
    End Property

    Property Let write_COMMAND_CONFIG_LOOP_ENA(aData)
        set_COMMAND_CONFIG_LOOP_ENA = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
        get_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN = read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value
    End Property

    Property Let set_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN(aData)
        write_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value = aData
        flag_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
        read
        read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN = read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value
    End Property

    Property Let write_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN(aData)
        set_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_SW_RESET
        get_COMMAND_CONFIG_SW_RESET = read_COMMAND_CONFIG_SW_RESET_value
    End Property

    Property Let set_COMMAND_CONFIG_SW_RESET(aData)
        write_COMMAND_CONFIG_SW_RESET_value = aData
        flag_COMMAND_CONFIG_SW_RESET        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_SW_RESET
        read
        read_COMMAND_CONFIG_SW_RESET = read_COMMAND_CONFIG_SW_RESET_value
    End Property

    Property Let write_COMMAND_CONFIG_SW_RESET(aData)
        set_COMMAND_CONFIG_SW_RESET = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_OVERFLOW_EN
        get_COMMAND_CONFIG_OVERFLOW_EN = read_COMMAND_CONFIG_OVERFLOW_EN_value
    End Property

    Property Let set_COMMAND_CONFIG_OVERFLOW_EN(aData)
        write_COMMAND_CONFIG_OVERFLOW_EN_value = aData
        flag_COMMAND_CONFIG_OVERFLOW_EN        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_OVERFLOW_EN
        read
        read_COMMAND_CONFIG_OVERFLOW_EN = read_COMMAND_CONFIG_OVERFLOW_EN_value
    End Property

    Property Let write_COMMAND_CONFIG_OVERFLOW_EN(aData)
        set_COMMAND_CONFIG_OVERFLOW_EN = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_RX_LOW_LATENCY_EN
        get_COMMAND_CONFIG_RX_LOW_LATENCY_EN = read_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value
    End Property

    Property Let set_COMMAND_CONFIG_RX_LOW_LATENCY_EN(aData)
        write_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value = aData
        flag_COMMAND_CONFIG_RX_LOW_LATENCY_EN        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_RX_LOW_LATENCY_EN
        read
        read_COMMAND_CONFIG_RX_LOW_LATENCY_EN = read_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value
    End Property

    Property Let write_COMMAND_CONFIG_RX_LOW_LATENCY_EN(aData)
        set_COMMAND_CONFIG_RX_LOW_LATENCY_EN = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_HD_ENA
        get_COMMAND_CONFIG_HD_ENA = read_COMMAND_CONFIG_HD_ENA_value
    End Property

    Property Let set_COMMAND_CONFIG_HD_ENA(aData)
        write_COMMAND_CONFIG_HD_ENA_value = aData
        flag_COMMAND_CONFIG_HD_ENA        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_HD_ENA
        read
        read_COMMAND_CONFIG_HD_ENA = read_COMMAND_CONFIG_HD_ENA_value
    End Property

    Property Let write_COMMAND_CONFIG_HD_ENA(aData)
        set_COMMAND_CONFIG_HD_ENA = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_TX_ADDR_INS
        get_COMMAND_CONFIG_TX_ADDR_INS = read_COMMAND_CONFIG_TX_ADDR_INS_value
    End Property

    Property Let set_COMMAND_CONFIG_TX_ADDR_INS(aData)
        write_COMMAND_CONFIG_TX_ADDR_INS_value = aData
        flag_COMMAND_CONFIG_TX_ADDR_INS        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_TX_ADDR_INS
        read
        read_COMMAND_CONFIG_TX_ADDR_INS = read_COMMAND_CONFIG_TX_ADDR_INS_value
    End Property

    Property Let write_COMMAND_CONFIG_TX_ADDR_INS(aData)
        set_COMMAND_CONFIG_TX_ADDR_INS = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_PAUSE_IGNORE
        get_COMMAND_CONFIG_PAUSE_IGNORE = read_COMMAND_CONFIG_PAUSE_IGNORE_value
    End Property

    Property Let set_COMMAND_CONFIG_PAUSE_IGNORE(aData)
        write_COMMAND_CONFIG_PAUSE_IGNORE_value = aData
        flag_COMMAND_CONFIG_PAUSE_IGNORE        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_PAUSE_IGNORE
        read
        read_COMMAND_CONFIG_PAUSE_IGNORE = read_COMMAND_CONFIG_PAUSE_IGNORE_value
    End Property

    Property Let write_COMMAND_CONFIG_PAUSE_IGNORE(aData)
        set_COMMAND_CONFIG_PAUSE_IGNORE = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_PAUSE_FWD
        get_COMMAND_CONFIG_PAUSE_FWD = read_COMMAND_CONFIG_PAUSE_FWD_value
    End Property

    Property Let set_COMMAND_CONFIG_PAUSE_FWD(aData)
        write_COMMAND_CONFIG_PAUSE_FWD_value = aData
        flag_COMMAND_CONFIG_PAUSE_FWD        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_PAUSE_FWD
        read
        read_COMMAND_CONFIG_PAUSE_FWD = read_COMMAND_CONFIG_PAUSE_FWD_value
    End Property

    Property Let write_COMMAND_CONFIG_PAUSE_FWD(aData)
        set_COMMAND_CONFIG_PAUSE_FWD = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_CRC_FWD
        get_COMMAND_CONFIG_CRC_FWD = read_COMMAND_CONFIG_CRC_FWD_value
    End Property

    Property Let set_COMMAND_CONFIG_CRC_FWD(aData)
        write_COMMAND_CONFIG_CRC_FWD_value = aData
        flag_COMMAND_CONFIG_CRC_FWD        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_CRC_FWD
        read
        read_COMMAND_CONFIG_CRC_FWD = read_COMMAND_CONFIG_CRC_FWD_value
    End Property

    Property Let write_COMMAND_CONFIG_CRC_FWD(aData)
        set_COMMAND_CONFIG_CRC_FWD = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_PAD_EN
        get_COMMAND_CONFIG_PAD_EN = read_COMMAND_CONFIG_PAD_EN_value
    End Property

    Property Let set_COMMAND_CONFIG_PAD_EN(aData)
        write_COMMAND_CONFIG_PAD_EN_value = aData
        flag_COMMAND_CONFIG_PAD_EN        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_PAD_EN
        read
        read_COMMAND_CONFIG_PAD_EN = read_COMMAND_CONFIG_PAD_EN_value
    End Property

    Property Let write_COMMAND_CONFIG_PAD_EN(aData)
        set_COMMAND_CONFIG_PAD_EN = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_PROMIS_EN
        get_COMMAND_CONFIG_PROMIS_EN = read_COMMAND_CONFIG_PROMIS_EN_value
    End Property

    Property Let set_COMMAND_CONFIG_PROMIS_EN(aData)
        write_COMMAND_CONFIG_PROMIS_EN_value = aData
        flag_COMMAND_CONFIG_PROMIS_EN        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_PROMIS_EN
        read
        read_COMMAND_CONFIG_PROMIS_EN = read_COMMAND_CONFIG_PROMIS_EN_value
    End Property

    Property Let write_COMMAND_CONFIG_PROMIS_EN(aData)
        set_COMMAND_CONFIG_PROMIS_EN = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_ETH_SPEED
        get_COMMAND_CONFIG_ETH_SPEED = read_COMMAND_CONFIG_ETH_SPEED_value
    End Property

    Property Let set_COMMAND_CONFIG_ETH_SPEED(aData)
        write_COMMAND_CONFIG_ETH_SPEED_value = aData
        flag_COMMAND_CONFIG_ETH_SPEED        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_ETH_SPEED
        read
        read_COMMAND_CONFIG_ETH_SPEED = read_COMMAND_CONFIG_ETH_SPEED_value
    End Property

    Property Let write_COMMAND_CONFIG_ETH_SPEED(aData)
        set_COMMAND_CONFIG_ETH_SPEED = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_RX_ENA
        get_COMMAND_CONFIG_RX_ENA = read_COMMAND_CONFIG_RX_ENA_value
    End Property

    Property Let set_COMMAND_CONFIG_RX_ENA(aData)
        write_COMMAND_CONFIG_RX_ENA_value = aData
        flag_COMMAND_CONFIG_RX_ENA        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_RX_ENA
        read
        read_COMMAND_CONFIG_RX_ENA = read_COMMAND_CONFIG_RX_ENA_value
    End Property

    Property Let write_COMMAND_CONFIG_RX_ENA(aData)
        set_COMMAND_CONFIG_RX_ENA = aData
        write
    End Property

    Property Get get_COMMAND_CONFIG_TX_ENA
        get_COMMAND_CONFIG_TX_ENA = read_COMMAND_CONFIG_TX_ENA_value
    End Property

    Property Let set_COMMAND_CONFIG_TX_ENA(aData)
        write_COMMAND_CONFIG_TX_ENA_value = aData
        flag_COMMAND_CONFIG_TX_ENA        = &H1
    End Property

    Property Get read_COMMAND_CONFIG_TX_ENA
        read
        read_COMMAND_CONFIG_TX_ENA = read_COMMAND_CONFIG_TX_ENA_value
    End Property

    Property Let write_COMMAND_CONFIG_TX_ENA(aData)
        set_COMMAND_CONFIG_TX_ENA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value = rightShift(data_low, 31) and &H1
        read_COMMAND_CONFIG_RUNT_FILTER_DIS_value = rightShift(data_low, 30) and &H1
        read_COMMAND_CONFIG_OOB_EFC_EN_value = rightShift(data_low, 29) and &H1
        read_COMMAND_CONFIG_IGNORE_TX_PAUSE_value = rightShift(data_low, 28) and &H1
        read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value = rightShift(data_low, 27) and &H1
        read_COMMAND_CONFIG_RX_ERR_DISC_value = rightShift(data_low, 26) and &H1
        read_COMMAND_CONFIG_LINE_LOOPBACK_value = rightShift(data_low, 25) and &H1
        read_COMMAND_CONFIG_NO_LGTH_CHECK_value = rightShift(data_low, 24) and &H1
        read_COMMAND_CONFIG_CNTL_FRM_ENA_value = rightShift(data_low, 23) and &H1
        read_COMMAND_CONFIG_ENA_EXT_CONFIG_value = rightShift(data_low, 22) and &H1
        read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value = rightShift(data_low, 21) and &H1
        read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value = rightShift(data_low, 19) and &H3
        read_COMMAND_CONFIG_SW_OVERRIDE_RX_value = rightShift(data_low, 18) and &H1
        read_COMMAND_CONFIG_SW_OVERRIDE_TX_value = rightShift(data_low, 17) and &H1
        read_COMMAND_CONFIG_MAC_LOOP_CON_value = rightShift(data_low, 16) and &H1
        read_COMMAND_CONFIG_LOOP_ENA_value = rightShift(data_low, 15) and &H1
        read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value = rightShift(data_low, 14) and &H1
        read_COMMAND_CONFIG_SW_RESET_value = rightShift(data_low, 13) and &H1
        read_COMMAND_CONFIG_OVERFLOW_EN_value = rightShift(data_low, 12) and &H1
        read_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value = rightShift(data_low, 11) and &H1
        read_COMMAND_CONFIG_HD_ENA_value = rightShift(data_low, 10) and &H1
        read_COMMAND_CONFIG_TX_ADDR_INS_value = rightShift(data_low, 9) and &H1
        read_COMMAND_CONFIG_PAUSE_IGNORE_value = rightShift(data_low, 8) and &H1
        read_COMMAND_CONFIG_PAUSE_FWD_value = rightShift(data_low, 7) and &H1
        read_COMMAND_CONFIG_CRC_FWD_value = rightShift(data_low, 6) and &H1
        read_COMMAND_CONFIG_PAD_EN_value = rightShift(data_low, 5) and &H1
        read_COMMAND_CONFIG_PROMIS_EN_value = rightShift(data_low, 4) and &H1
        read_COMMAND_CONFIG_ETH_SPEED_value = rightShift(data_low, 2) and &H3
        read_COMMAND_CONFIG_RX_ENA_value = rightShift(data_low, 1) and &H1
        COMMAND_CONFIG_TX_ENA_mask = &H1
        if data_low > LONG_MAX then
            if COMMAND_CONFIG_TX_ENA_mask = mask then
                read_COMMAND_CONFIG_TX_ENA_value = data_low
            else
                read_COMMAND_CONFIG_TX_ENA_value = (data_low - H8000_0000) and COMMAND_CONFIG_TX_ENA_mask
            end If
        else
            read_COMMAND_CONFIG_TX_ENA_value = data_low and COMMAND_CONFIG_TX_ENA_mask
        end If

    End Sub

    Sub write
        If flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28 = &H0 or flag_COMMAND_CONFIG_RUNT_FILTER_DIS = &H0 or flag_COMMAND_CONFIG_OOB_EFC_EN = &H0 or flag_COMMAND_CONFIG_IGNORE_TX_PAUSE = &H0 or flag_COMMAND_CONFIG_FD_TX_URUN_FIX_EN = &H0 or flag_COMMAND_CONFIG_RX_ERR_DISC = &H0 or flag_COMMAND_CONFIG_LINE_LOOPBACK = &H0 or flag_COMMAND_CONFIG_NO_LGTH_CHECK = &H0 or flag_COMMAND_CONFIG_CNTL_FRM_ENA = &H0 or flag_COMMAND_CONFIG_ENA_EXT_CONFIG = &H0 or flag_COMMAND_CONFIG_EN_INTERNAL_TX_CRS = &H0 or flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18 = &H0 or flag_COMMAND_CONFIG_SW_OVERRIDE_RX = &H0 or flag_COMMAND_CONFIG_SW_OVERRIDE_TX = &H0 or flag_COMMAND_CONFIG_MAC_LOOP_CON = &H0 or flag_COMMAND_CONFIG_LOOP_ENA = &H0 or flag_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN = &H0 or flag_COMMAND_CONFIG_SW_RESET = &H0 or flag_COMMAND_CONFIG_OVERFLOW_EN = &H0 or flag_COMMAND_CONFIG_RX_LOW_LATENCY_EN = &H0 or flag_COMMAND_CONFIG_HD_ENA = &H0 or flag_COMMAND_CONFIG_TX_ADDR_INS = &H0 or flag_COMMAND_CONFIG_PAUSE_IGNORE = &H0 or flag_COMMAND_CONFIG_PAUSE_FWD = &H0 or flag_COMMAND_CONFIG_CRC_FWD = &H0 or flag_COMMAND_CONFIG_PAD_EN = &H0 or flag_COMMAND_CONFIG_PROMIS_EN = &H0 or flag_COMMAND_CONFIG_ETH_SPEED = &H0 or flag_COMMAND_CONFIG_RX_ENA = &H0 or flag_COMMAND_CONFIG_TX_ENA = &H0 Then read
        If flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28 = &H0 Then write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value = get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28
        If flag_COMMAND_CONFIG_RUNT_FILTER_DIS = &H0 Then write_COMMAND_CONFIG_RUNT_FILTER_DIS_value = get_COMMAND_CONFIG_RUNT_FILTER_DIS
        If flag_COMMAND_CONFIG_OOB_EFC_EN = &H0 Then write_COMMAND_CONFIG_OOB_EFC_EN_value = get_COMMAND_CONFIG_OOB_EFC_EN
        If flag_COMMAND_CONFIG_IGNORE_TX_PAUSE = &H0 Then write_COMMAND_CONFIG_IGNORE_TX_PAUSE_value = get_COMMAND_CONFIG_IGNORE_TX_PAUSE
        If flag_COMMAND_CONFIG_FD_TX_URUN_FIX_EN = &H0 Then write_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value = get_COMMAND_CONFIG_FD_TX_URUN_FIX_EN
        If flag_COMMAND_CONFIG_RX_ERR_DISC = &H0 Then write_COMMAND_CONFIG_RX_ERR_DISC_value = get_COMMAND_CONFIG_RX_ERR_DISC
        If flag_COMMAND_CONFIG_LINE_LOOPBACK = &H0 Then write_COMMAND_CONFIG_LINE_LOOPBACK_value = get_COMMAND_CONFIG_LINE_LOOPBACK
        If flag_COMMAND_CONFIG_NO_LGTH_CHECK = &H0 Then write_COMMAND_CONFIG_NO_LGTH_CHECK_value = get_COMMAND_CONFIG_NO_LGTH_CHECK
        If flag_COMMAND_CONFIG_CNTL_FRM_ENA = &H0 Then write_COMMAND_CONFIG_CNTL_FRM_ENA_value = get_COMMAND_CONFIG_CNTL_FRM_ENA
        If flag_COMMAND_CONFIG_ENA_EXT_CONFIG = &H0 Then write_COMMAND_CONFIG_ENA_EXT_CONFIG_value = get_COMMAND_CONFIG_ENA_EXT_CONFIG
        If flag_COMMAND_CONFIG_EN_INTERNAL_TX_CRS = &H0 Then write_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value = get_COMMAND_CONFIG_EN_INTERNAL_TX_CRS
        If flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18 = &H0 Then write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value = get_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18
        If flag_COMMAND_CONFIG_SW_OVERRIDE_RX = &H0 Then write_COMMAND_CONFIG_SW_OVERRIDE_RX_value = get_COMMAND_CONFIG_SW_OVERRIDE_RX
        If flag_COMMAND_CONFIG_SW_OVERRIDE_TX = &H0 Then write_COMMAND_CONFIG_SW_OVERRIDE_TX_value = get_COMMAND_CONFIG_SW_OVERRIDE_TX
        If flag_COMMAND_CONFIG_MAC_LOOP_CON = &H0 Then write_COMMAND_CONFIG_MAC_LOOP_CON_value = get_COMMAND_CONFIG_MAC_LOOP_CON
        If flag_COMMAND_CONFIG_LOOP_ENA = &H0 Then write_COMMAND_CONFIG_LOOP_ENA_value = get_COMMAND_CONFIG_LOOP_ENA
        If flag_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN = &H0 Then write_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value = get_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN
        If flag_COMMAND_CONFIG_SW_RESET = &H0 Then write_COMMAND_CONFIG_SW_RESET_value = get_COMMAND_CONFIG_SW_RESET
        If flag_COMMAND_CONFIG_OVERFLOW_EN = &H0 Then write_COMMAND_CONFIG_OVERFLOW_EN_value = get_COMMAND_CONFIG_OVERFLOW_EN
        If flag_COMMAND_CONFIG_RX_LOW_LATENCY_EN = &H0 Then write_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value = get_COMMAND_CONFIG_RX_LOW_LATENCY_EN
        If flag_COMMAND_CONFIG_HD_ENA = &H0 Then write_COMMAND_CONFIG_HD_ENA_value = get_COMMAND_CONFIG_HD_ENA
        If flag_COMMAND_CONFIG_TX_ADDR_INS = &H0 Then write_COMMAND_CONFIG_TX_ADDR_INS_value = get_COMMAND_CONFIG_TX_ADDR_INS
        If flag_COMMAND_CONFIG_PAUSE_IGNORE = &H0 Then write_COMMAND_CONFIG_PAUSE_IGNORE_value = get_COMMAND_CONFIG_PAUSE_IGNORE
        If flag_COMMAND_CONFIG_PAUSE_FWD = &H0 Then write_COMMAND_CONFIG_PAUSE_FWD_value = get_COMMAND_CONFIG_PAUSE_FWD
        If flag_COMMAND_CONFIG_CRC_FWD = &H0 Then write_COMMAND_CONFIG_CRC_FWD_value = get_COMMAND_CONFIG_CRC_FWD
        If flag_COMMAND_CONFIG_PAD_EN = &H0 Then write_COMMAND_CONFIG_PAD_EN_value = get_COMMAND_CONFIG_PAD_EN
        If flag_COMMAND_CONFIG_PROMIS_EN = &H0 Then write_COMMAND_CONFIG_PROMIS_EN_value = get_COMMAND_CONFIG_PROMIS_EN
        If flag_COMMAND_CONFIG_ETH_SPEED = &H0 Then write_COMMAND_CONFIG_ETH_SPEED_value = get_COMMAND_CONFIG_ETH_SPEED
        If flag_COMMAND_CONFIG_RX_ENA = &H0 Then write_COMMAND_CONFIG_RX_ENA_value = get_COMMAND_CONFIG_RX_ENA
        If flag_COMMAND_CONFIG_TX_ENA = &H0 Then write_COMMAND_CONFIG_TX_ENA_value = get_COMMAND_CONFIG_TX_ENA

        regValue = leftShift((write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value and &H1), 31) + leftShift((write_COMMAND_CONFIG_RUNT_FILTER_DIS_value and &H1), 30) + leftShift((write_COMMAND_CONFIG_OOB_EFC_EN_value and &H1), 29) + leftShift((write_COMMAND_CONFIG_IGNORE_TX_PAUSE_value and &H1), 28) + leftShift((write_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value and &H1), 27) + leftShift((write_COMMAND_CONFIG_RX_ERR_DISC_value and &H1), 26) + leftShift((write_COMMAND_CONFIG_LINE_LOOPBACK_value and &H1), 25) + leftShift((write_COMMAND_CONFIG_NO_LGTH_CHECK_value and &H1), 24) + leftShift((write_COMMAND_CONFIG_CNTL_FRM_ENA_value and &H1), 23) + leftShift((write_COMMAND_CONFIG_ENA_EXT_CONFIG_value and &H1), 22) + leftShift((write_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value and &H1), 21) + leftShift((write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value and &H3), 19) + leftShift((write_COMMAND_CONFIG_SW_OVERRIDE_RX_value and &H1), 18) + leftShift((write_COMMAND_CONFIG_SW_OVERRIDE_TX_value and &H1), 17) + leftShift((write_COMMAND_CONFIG_MAC_LOOP_CON_value and &H1), 16) + leftShift((write_COMMAND_CONFIG_LOOP_ENA_value and &H1), 15) + leftShift((write_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value and &H1), 14) + leftShift((write_COMMAND_CONFIG_SW_RESET_value and &H1), 13) + leftShift((write_COMMAND_CONFIG_OVERFLOW_EN_value and &H1), 12) + leftShift((write_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value and &H1), 11) + leftShift((write_COMMAND_CONFIG_HD_ENA_value and &H1), 10) + leftShift((write_COMMAND_CONFIG_TX_ADDR_INS_value and &H1), 9) + leftShift((write_COMMAND_CONFIG_PAUSE_IGNORE_value and &H1), 8) + leftShift((write_COMMAND_CONFIG_PAUSE_FWD_value and &H1), 7) + leftShift((write_COMMAND_CONFIG_CRC_FWD_value and &H1), 6) + leftShift((write_COMMAND_CONFIG_PAD_EN_value and &H1), 5) + leftShift((write_COMMAND_CONFIG_PROMIS_EN_value and &H1), 4) + leftShift((write_COMMAND_CONFIG_ETH_SPEED_value and &H3), 2) + leftShift((write_COMMAND_CONFIG_RX_ENA_value and &H1), 1) + leftShift((write_COMMAND_CONFIG_TX_ENA_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value = rightShift(data_low, 31) and &H1
        read_COMMAND_CONFIG_RUNT_FILTER_DIS_value = rightShift(data_low, 30) and &H1
        read_COMMAND_CONFIG_OOB_EFC_EN_value = rightShift(data_low, 29) and &H1
        read_COMMAND_CONFIG_IGNORE_TX_PAUSE_value = rightShift(data_low, 28) and &H1
        read_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value = rightShift(data_low, 27) and &H1
        read_COMMAND_CONFIG_RX_ERR_DISC_value = rightShift(data_low, 26) and &H1
        read_COMMAND_CONFIG_LINE_LOOPBACK_value = rightShift(data_low, 25) and &H1
        read_COMMAND_CONFIG_NO_LGTH_CHECK_value = rightShift(data_low, 24) and &H1
        read_COMMAND_CONFIG_CNTL_FRM_ENA_value = rightShift(data_low, 23) and &H1
        read_COMMAND_CONFIG_ENA_EXT_CONFIG_value = rightShift(data_low, 22) and &H1
        read_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value = rightShift(data_low, 21) and &H1
        read_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value = rightShift(data_low, 19) and &H3
        read_COMMAND_CONFIG_SW_OVERRIDE_RX_value = rightShift(data_low, 18) and &H1
        read_COMMAND_CONFIG_SW_OVERRIDE_TX_value = rightShift(data_low, 17) and &H1
        read_COMMAND_CONFIG_MAC_LOOP_CON_value = rightShift(data_low, 16) and &H1
        read_COMMAND_CONFIG_LOOP_ENA_value = rightShift(data_low, 15) and &H1
        read_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value = rightShift(data_low, 14) and &H1
        read_COMMAND_CONFIG_SW_RESET_value = rightShift(data_low, 13) and &H1
        read_COMMAND_CONFIG_OVERFLOW_EN_value = rightShift(data_low, 12) and &H1
        read_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value = rightShift(data_low, 11) and &H1
        read_COMMAND_CONFIG_HD_ENA_value = rightShift(data_low, 10) and &H1
        read_COMMAND_CONFIG_TX_ADDR_INS_value = rightShift(data_low, 9) and &H1
        read_COMMAND_CONFIG_PAUSE_IGNORE_value = rightShift(data_low, 8) and &H1
        read_COMMAND_CONFIG_PAUSE_FWD_value = rightShift(data_low, 7) and &H1
        read_COMMAND_CONFIG_CRC_FWD_value = rightShift(data_low, 6) and &H1
        read_COMMAND_CONFIG_PAD_EN_value = rightShift(data_low, 5) and &H1
        read_COMMAND_CONFIG_PROMIS_EN_value = rightShift(data_low, 4) and &H1
        read_COMMAND_CONFIG_ETH_SPEED_value = rightShift(data_low, 2) and &H3
        read_COMMAND_CONFIG_RX_ENA_value = rightShift(data_low, 1) and &H1
        COMMAND_CONFIG_TX_ENA_mask = &H1
        if data_low > LONG_MAX then
            if COMMAND_CONFIG_TX_ENA_mask = mask then
                read_COMMAND_CONFIG_TX_ENA_value = data_low
            else
                read_COMMAND_CONFIG_TX_ENA_value = (data_low - H8000_0000) and COMMAND_CONFIG_TX_ENA_mask
            end If
        else
            read_COMMAND_CONFIG_TX_ENA_value = data_low and COMMAND_CONFIG_TX_ENA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28_value = &H0
        flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_28        = &H0
        write_COMMAND_CONFIG_RUNT_FILTER_DIS_value = &H0
        flag_COMMAND_CONFIG_RUNT_FILTER_DIS        = &H0
        write_COMMAND_CONFIG_OOB_EFC_EN_value = &H0
        flag_COMMAND_CONFIG_OOB_EFC_EN        = &H0
        write_COMMAND_CONFIG_IGNORE_TX_PAUSE_value = &H0
        flag_COMMAND_CONFIG_IGNORE_TX_PAUSE        = &H0
        write_COMMAND_CONFIG_FD_TX_URUN_FIX_EN_value = &H0
        flag_COMMAND_CONFIG_FD_TX_URUN_FIX_EN        = &H0
        write_COMMAND_CONFIG_RX_ERR_DISC_value = &H0
        flag_COMMAND_CONFIG_RX_ERR_DISC        = &H0
        write_COMMAND_CONFIG_LINE_LOOPBACK_value = &H0
        flag_COMMAND_CONFIG_LINE_LOOPBACK        = &H0
        write_COMMAND_CONFIG_NO_LGTH_CHECK_value = &H0
        flag_COMMAND_CONFIG_NO_LGTH_CHECK        = &H0
        write_COMMAND_CONFIG_CNTL_FRM_ENA_value = &H0
        flag_COMMAND_CONFIG_CNTL_FRM_ENA        = &H0
        write_COMMAND_CONFIG_ENA_EXT_CONFIG_value = &H0
        flag_COMMAND_CONFIG_ENA_EXT_CONFIG        = &H0
        write_COMMAND_CONFIG_EN_INTERNAL_TX_CRS_value = &H0
        flag_COMMAND_CONFIG_EN_INTERNAL_TX_CRS        = &H0
        write_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18_value = &H0
        flag_COMMAND_CONFIG_COMMAND_CONFIG_RSVD_18        = &H0
        write_COMMAND_CONFIG_SW_OVERRIDE_RX_value = &H0
        flag_COMMAND_CONFIG_SW_OVERRIDE_RX        = &H0
        write_COMMAND_CONFIG_SW_OVERRIDE_TX_value = &H0
        flag_COMMAND_CONFIG_SW_OVERRIDE_TX        = &H0
        write_COMMAND_CONFIG_MAC_LOOP_CON_value = &H0
        flag_COMMAND_CONFIG_MAC_LOOP_CON        = &H0
        write_COMMAND_CONFIG_LOOP_ENA_value = &H0
        flag_COMMAND_CONFIG_LOOP_ENA        = &H0
        write_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN_value = &H0
        flag_COMMAND_CONFIG_FCS_CORRUPT_URUN_EN        = &H0
        write_COMMAND_CONFIG_SW_RESET_value = &H0
        flag_COMMAND_CONFIG_SW_RESET        = &H0
        write_COMMAND_CONFIG_OVERFLOW_EN_value = &H0
        flag_COMMAND_CONFIG_OVERFLOW_EN        = &H0
        write_COMMAND_CONFIG_RX_LOW_LATENCY_EN_value = &H0
        flag_COMMAND_CONFIG_RX_LOW_LATENCY_EN        = &H0
        write_COMMAND_CONFIG_HD_ENA_value = &H0
        flag_COMMAND_CONFIG_HD_ENA        = &H0
        write_COMMAND_CONFIG_TX_ADDR_INS_value = &H0
        flag_COMMAND_CONFIG_TX_ADDR_INS        = &H0
        write_COMMAND_CONFIG_PAUSE_IGNORE_value = &H0
        flag_COMMAND_CONFIG_PAUSE_IGNORE        = &H0
        write_COMMAND_CONFIG_PAUSE_FWD_value = &H0
        flag_COMMAND_CONFIG_PAUSE_FWD        = &H0
        write_COMMAND_CONFIG_CRC_FWD_value = &H0
        flag_COMMAND_CONFIG_CRC_FWD        = &H0
        write_COMMAND_CONFIG_PAD_EN_value = &H0
        flag_COMMAND_CONFIG_PAD_EN        = &H0
        write_COMMAND_CONFIG_PROMIS_EN_value = &H0
        flag_COMMAND_CONFIG_PROMIS_EN        = &H0
        write_COMMAND_CONFIG_ETH_SPEED_value = &H0
        flag_COMMAND_CONFIG_ETH_SPEED        = &H0
        write_COMMAND_CONFIG_RX_ENA_value = &H0
        flag_COMMAND_CONFIG_RX_ENA        = &H0
        write_COMMAND_CONFIG_TX_ENA_value = &H0
        flag_COMMAND_CONFIG_TX_ENA        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_0_MAC_ADDR0                            [31:0]           get_MAC_0_MAC_ADDR0
''                                                             set_MAC_0_MAC_ADDR0
''                                                             read_MAC_0_MAC_ADDR0
''                                                             write_MAC_0_MAC_ADDR0
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_0
    Private write_MAC_0_MAC_ADDR0_value
    Private read_MAC_0_MAC_ADDR0_value
    Private flag_MAC_0_MAC_ADDR0

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

    Property Get get_MAC_0_MAC_ADDR0
        get_MAC_0_MAC_ADDR0 = read_MAC_0_MAC_ADDR0_value
    End Property

    Property Let set_MAC_0_MAC_ADDR0(aData)
        write_MAC_0_MAC_ADDR0_value = aData
        flag_MAC_0_MAC_ADDR0        = &H1
    End Property

    Property Get read_MAC_0_MAC_ADDR0
        read
        read_MAC_0_MAC_ADDR0 = read_MAC_0_MAC_ADDR0_value
    End Property

    Property Let write_MAC_0_MAC_ADDR0(aData)
        set_MAC_0_MAC_ADDR0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAC_0_MAC_ADDR0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MAC_0_MAC_ADDR0_mask = mask then
                read_MAC_0_MAC_ADDR0_value = data_low
            else
                read_MAC_0_MAC_ADDR0_value = (data_low - H8000_0000) and MAC_0_MAC_ADDR0_mask
            end If
        else
            read_MAC_0_MAC_ADDR0_value = data_low and MAC_0_MAC_ADDR0_mask
        end If

    End Sub

    Sub write
        If flag_MAC_0_MAC_ADDR0 = &H0 Then read
        If flag_MAC_0_MAC_ADDR0 = &H0 Then write_MAC_0_MAC_ADDR0_value = get_MAC_0_MAC_ADDR0

        regValue = leftShift(write_MAC_0_MAC_ADDR0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAC_0_MAC_ADDR0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MAC_0_MAC_ADDR0_mask = mask then
                read_MAC_0_MAC_ADDR0_value = data_low
            else
                read_MAC_0_MAC_ADDR0_value = (data_low - H8000_0000) and MAC_0_MAC_ADDR0_mask
            end If
        else
            read_MAC_0_MAC_ADDR0_value = data_low and MAC_0_MAC_ADDR0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_0_MAC_ADDR0_value = &H0
        flag_MAC_0_MAC_ADDR0        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_1_MAC_1_RSVD_1                         [31:16]          get_MAC_1_MAC_1_RSVD_1
''                                                             set_MAC_1_MAC_1_RSVD_1
''                                                             read_MAC_1_MAC_1_RSVD_1
''                                                             write_MAC_1_MAC_1_RSVD_1
''---------------------------------------------------------------------------------
'' MAC_1_MAC_ADDR1                            [15:0]           get_MAC_1_MAC_ADDR1
''                                                             set_MAC_1_MAC_ADDR1
''                                                             read_MAC_1_MAC_ADDR1
''                                                             write_MAC_1_MAC_ADDR1
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_1
    Private write_MAC_1_MAC_1_RSVD_1_value
    Private read_MAC_1_MAC_1_RSVD_1_value
    Private flag_MAC_1_MAC_1_RSVD_1
    Private write_MAC_1_MAC_ADDR1_value
    Private read_MAC_1_MAC_ADDR1_value
    Private flag_MAC_1_MAC_ADDR1

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

    Property Get get_MAC_1_MAC_1_RSVD_1
        get_MAC_1_MAC_1_RSVD_1 = read_MAC_1_MAC_1_RSVD_1_value
    End Property

    Property Let set_MAC_1_MAC_1_RSVD_1(aData)
        write_MAC_1_MAC_1_RSVD_1_value = aData
        flag_MAC_1_MAC_1_RSVD_1        = &H1
    End Property

    Property Get read_MAC_1_MAC_1_RSVD_1
        read
        read_MAC_1_MAC_1_RSVD_1 = read_MAC_1_MAC_1_RSVD_1_value
    End Property

    Property Let write_MAC_1_MAC_1_RSVD_1(aData)
        set_MAC_1_MAC_1_RSVD_1 = aData
        write
    End Property

    Property Get get_MAC_1_MAC_ADDR1
        get_MAC_1_MAC_ADDR1 = read_MAC_1_MAC_ADDR1_value
    End Property

    Property Let set_MAC_1_MAC_ADDR1(aData)
        write_MAC_1_MAC_ADDR1_value = aData
        flag_MAC_1_MAC_ADDR1        = &H1
    End Property

    Property Get read_MAC_1_MAC_ADDR1
        read
        read_MAC_1_MAC_ADDR1 = read_MAC_1_MAC_ADDR1_value
    End Property

    Property Let write_MAC_1_MAC_ADDR1(aData)
        set_MAC_1_MAC_ADDR1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_1_MAC_1_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_1_MAC_ADDR1_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_1_MAC_ADDR1_mask = mask then
                read_MAC_1_MAC_ADDR1_value = data_low
            else
                read_MAC_1_MAC_ADDR1_value = (data_low - H8000_0000) and MAC_1_MAC_ADDR1_mask
            end If
        else
            read_MAC_1_MAC_ADDR1_value = data_low and MAC_1_MAC_ADDR1_mask
        end If

    End Sub

    Sub write
        If flag_MAC_1_MAC_1_RSVD_1 = &H0 or flag_MAC_1_MAC_ADDR1 = &H0 Then read
        If flag_MAC_1_MAC_1_RSVD_1 = &H0 Then write_MAC_1_MAC_1_RSVD_1_value = get_MAC_1_MAC_1_RSVD_1
        If flag_MAC_1_MAC_ADDR1 = &H0 Then write_MAC_1_MAC_ADDR1_value = get_MAC_1_MAC_ADDR1

        regValue = leftShift((write_MAC_1_MAC_1_RSVD_1_value and &Hffff), 16) + leftShift((write_MAC_1_MAC_ADDR1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_1_MAC_1_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_1_MAC_ADDR1_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_1_MAC_ADDR1_mask = mask then
                read_MAC_1_MAC_ADDR1_value = data_low
            else
                read_MAC_1_MAC_ADDR1_value = (data_low - H8000_0000) and MAC_1_MAC_ADDR1_mask
            end If
        else
            read_MAC_1_MAC_ADDR1_value = data_low and MAC_1_MAC_ADDR1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_1_MAC_1_RSVD_1_value = &H0
        flag_MAC_1_MAC_1_RSVD_1        = &H0
        write_MAC_1_MAC_ADDR1_value = &H0
        flag_MAC_1_MAC_ADDR1        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_frm_length
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FRM_LENGTH_FRM_LENGTH_RSVD_1               [31:14]          get_FRM_LENGTH_FRM_LENGTH_RSVD_1
''                                                             set_FRM_LENGTH_FRM_LENGTH_RSVD_1
''                                                             read_FRM_LENGTH_FRM_LENGTH_RSVD_1
''                                                             write_FRM_LENGTH_FRM_LENGTH_RSVD_1
''---------------------------------------------------------------------------------
'' FRM_LENGTH_MAXFR                           [13:0]           get_FRM_LENGTH_MAXFR
''                                                             set_FRM_LENGTH_MAXFR
''                                                             read_FRM_LENGTH_MAXFR
''                                                             write_FRM_LENGTH_MAXFR
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_frm_length
    Private write_FRM_LENGTH_FRM_LENGTH_RSVD_1_value
    Private read_FRM_LENGTH_FRM_LENGTH_RSVD_1_value
    Private flag_FRM_LENGTH_FRM_LENGTH_RSVD_1
    Private write_FRM_LENGTH_MAXFR_value
    Private read_FRM_LENGTH_MAXFR_value
    Private flag_FRM_LENGTH_MAXFR

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

    Property Get get_FRM_LENGTH_FRM_LENGTH_RSVD_1
        get_FRM_LENGTH_FRM_LENGTH_RSVD_1 = read_FRM_LENGTH_FRM_LENGTH_RSVD_1_value
    End Property

    Property Let set_FRM_LENGTH_FRM_LENGTH_RSVD_1(aData)
        write_FRM_LENGTH_FRM_LENGTH_RSVD_1_value = aData
        flag_FRM_LENGTH_FRM_LENGTH_RSVD_1        = &H1
    End Property

    Property Get read_FRM_LENGTH_FRM_LENGTH_RSVD_1
        read
        read_FRM_LENGTH_FRM_LENGTH_RSVD_1 = read_FRM_LENGTH_FRM_LENGTH_RSVD_1_value
    End Property

    Property Let write_FRM_LENGTH_FRM_LENGTH_RSVD_1(aData)
        set_FRM_LENGTH_FRM_LENGTH_RSVD_1 = aData
        write
    End Property

    Property Get get_FRM_LENGTH_MAXFR
        get_FRM_LENGTH_MAXFR = read_FRM_LENGTH_MAXFR_value
    End Property

    Property Let set_FRM_LENGTH_MAXFR(aData)
        write_FRM_LENGTH_MAXFR_value = aData
        flag_FRM_LENGTH_MAXFR        = &H1
    End Property

    Property Get read_FRM_LENGTH_MAXFR
        read
        read_FRM_LENGTH_MAXFR = read_FRM_LENGTH_MAXFR_value
    End Property

    Property Let write_FRM_LENGTH_MAXFR(aData)
        set_FRM_LENGTH_MAXFR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FRM_LENGTH_FRM_LENGTH_RSVD_1_value = rightShift(data_low, 14) and &H3ffff
        FRM_LENGTH_MAXFR_mask = &H3fff
        if data_low > LONG_MAX then
            if FRM_LENGTH_MAXFR_mask = mask then
                read_FRM_LENGTH_MAXFR_value = data_low
            else
                read_FRM_LENGTH_MAXFR_value = (data_low - H8000_0000) and FRM_LENGTH_MAXFR_mask
            end If
        else
            read_FRM_LENGTH_MAXFR_value = data_low and FRM_LENGTH_MAXFR_mask
        end If

    End Sub

    Sub write
        If flag_FRM_LENGTH_FRM_LENGTH_RSVD_1 = &H0 or flag_FRM_LENGTH_MAXFR = &H0 Then read
        If flag_FRM_LENGTH_FRM_LENGTH_RSVD_1 = &H0 Then write_FRM_LENGTH_FRM_LENGTH_RSVD_1_value = get_FRM_LENGTH_FRM_LENGTH_RSVD_1
        If flag_FRM_LENGTH_MAXFR = &H0 Then write_FRM_LENGTH_MAXFR_value = get_FRM_LENGTH_MAXFR

        regValue = leftShift((write_FRM_LENGTH_FRM_LENGTH_RSVD_1_value and &H3ffff), 14) + leftShift((write_FRM_LENGTH_MAXFR_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FRM_LENGTH_FRM_LENGTH_RSVD_1_value = rightShift(data_low, 14) and &H3ffff
        FRM_LENGTH_MAXFR_mask = &H3fff
        if data_low > LONG_MAX then
            if FRM_LENGTH_MAXFR_mask = mask then
                read_FRM_LENGTH_MAXFR_value = data_low
            else
                read_FRM_LENGTH_MAXFR_value = (data_low - H8000_0000) and FRM_LENGTH_MAXFR_mask
            end If
        else
            read_FRM_LENGTH_MAXFR_value = data_low and FRM_LENGTH_MAXFR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FRM_LENGTH_FRM_LENGTH_RSVD_1_value = &H0
        flag_FRM_LENGTH_FRM_LENGTH_RSVD_1        = &H0
        write_FRM_LENGTH_MAXFR_value = &H0
        flag_FRM_LENGTH_MAXFR        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_pause_quant
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PAUSE_QUANT_PAUSE_QUANT_RSVD_1             [31:16]          get_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
''                                                             set_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
''                                                             read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
''                                                             write_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
''---------------------------------------------------------------------------------
'' PAUSE_QUANT_STAD2                          [15:0]           get_PAUSE_QUANT_STAD2
''                                                             set_PAUSE_QUANT_STAD2
''                                                             read_PAUSE_QUANT_STAD2
''                                                             write_PAUSE_QUANT_STAD2
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_pause_quant
    Private write_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value
    Private read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value
    Private flag_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
    Private write_PAUSE_QUANT_STAD2_value
    Private read_PAUSE_QUANT_STAD2_value
    Private flag_PAUSE_QUANT_STAD2

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

    Property Get get_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
        get_PAUSE_QUANT_PAUSE_QUANT_RSVD_1 = read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value
    End Property

    Property Let set_PAUSE_QUANT_PAUSE_QUANT_RSVD_1(aData)
        write_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value = aData
        flag_PAUSE_QUANT_PAUSE_QUANT_RSVD_1        = &H1
    End Property

    Property Get read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
        read
        read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1 = read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value
    End Property

    Property Let write_PAUSE_QUANT_PAUSE_QUANT_RSVD_1(aData)
        set_PAUSE_QUANT_PAUSE_QUANT_RSVD_1 = aData
        write
    End Property

    Property Get get_PAUSE_QUANT_STAD2
        get_PAUSE_QUANT_STAD2 = read_PAUSE_QUANT_STAD2_value
    End Property

    Property Let set_PAUSE_QUANT_STAD2(aData)
        write_PAUSE_QUANT_STAD2_value = aData
        flag_PAUSE_QUANT_STAD2        = &H1
    End Property

    Property Get read_PAUSE_QUANT_STAD2
        read
        read_PAUSE_QUANT_STAD2 = read_PAUSE_QUANT_STAD2_value
    End Property

    Property Let write_PAUSE_QUANT_STAD2(aData)
        set_PAUSE_QUANT_STAD2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        PAUSE_QUANT_STAD2_mask = &Hffff
        if data_low > LONG_MAX then
            if PAUSE_QUANT_STAD2_mask = mask then
                read_PAUSE_QUANT_STAD2_value = data_low
            else
                read_PAUSE_QUANT_STAD2_value = (data_low - H8000_0000) and PAUSE_QUANT_STAD2_mask
            end If
        else
            read_PAUSE_QUANT_STAD2_value = data_low and PAUSE_QUANT_STAD2_mask
        end If

    End Sub

    Sub write
        If flag_PAUSE_QUANT_PAUSE_QUANT_RSVD_1 = &H0 or flag_PAUSE_QUANT_STAD2 = &H0 Then read
        If flag_PAUSE_QUANT_PAUSE_QUANT_RSVD_1 = &H0 Then write_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value = get_PAUSE_QUANT_PAUSE_QUANT_RSVD_1
        If flag_PAUSE_QUANT_STAD2 = &H0 Then write_PAUSE_QUANT_STAD2_value = get_PAUSE_QUANT_STAD2

        regValue = leftShift((write_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value and &Hffff), 16) + leftShift((write_PAUSE_QUANT_STAD2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        PAUSE_QUANT_STAD2_mask = &Hffff
        if data_low > LONG_MAX then
            if PAUSE_QUANT_STAD2_mask = mask then
                read_PAUSE_QUANT_STAD2_value = data_low
            else
                read_PAUSE_QUANT_STAD2_value = (data_low - H8000_0000) and PAUSE_QUANT_STAD2_mask
            end If
        else
            read_PAUSE_QUANT_STAD2_value = data_low and PAUSE_QUANT_STAD2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PAUSE_QUANT_PAUSE_QUANT_RSVD_1_value = &H0
        flag_PAUSE_QUANT_PAUSE_QUANT_RSVD_1        = &H0
        write_PAUSE_QUANT_STAD2_value = &H0
        flag_PAUSE_QUANT_STAD2        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_tx_ts_seq_id
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2           [31:17]          get_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
''                                                             set_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
''                                                             read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
''                                                             write_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
''---------------------------------------------------------------------------------
'' TX_TS_SEQ_ID_TSTS_VALID                    [16:16]          get_TX_TS_SEQ_ID_TSTS_VALID
''                                                             set_TX_TS_SEQ_ID_TSTS_VALID
''                                                             read_TX_TS_SEQ_ID_TSTS_VALID
''                                                             write_TX_TS_SEQ_ID_TSTS_VALID
''---------------------------------------------------------------------------------
'' TX_TS_SEQ_ID_TSTS_SEQ_ID                   [15:0]           get_TX_TS_SEQ_ID_TSTS_SEQ_ID
''                                                             set_TX_TS_SEQ_ID_TSTS_SEQ_ID
''                                                             read_TX_TS_SEQ_ID_TSTS_SEQ_ID
''                                                             write_TX_TS_SEQ_ID_TSTS_SEQ_ID
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_tx_ts_seq_id
    Private write_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value
    Private read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value
    Private flag_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
    Private write_TX_TS_SEQ_ID_TSTS_VALID_value
    Private read_TX_TS_SEQ_ID_TSTS_VALID_value
    Private flag_TX_TS_SEQ_ID_TSTS_VALID
    Private write_TX_TS_SEQ_ID_TSTS_SEQ_ID_value
    Private read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value
    Private flag_TX_TS_SEQ_ID_TSTS_SEQ_ID

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
        get_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2 = read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value
    End Property

    Property Let set_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2(aData)
        write_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value = aData
        flag_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2        = &H1
    End Property

    Property Get read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
        read
        read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2 = read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value
    End Property

    Property Let write_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2(aData)
        set_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2 = aData
        write
    End Property

    Property Get get_TX_TS_SEQ_ID_TSTS_VALID
        get_TX_TS_SEQ_ID_TSTS_VALID = read_TX_TS_SEQ_ID_TSTS_VALID_value
    End Property

    Property Let set_TX_TS_SEQ_ID_TSTS_VALID(aData)
        write_TX_TS_SEQ_ID_TSTS_VALID_value = aData
        flag_TX_TS_SEQ_ID_TSTS_VALID        = &H1
    End Property

    Property Get read_TX_TS_SEQ_ID_TSTS_VALID
        read
        read_TX_TS_SEQ_ID_TSTS_VALID = read_TX_TS_SEQ_ID_TSTS_VALID_value
    End Property

    Property Let write_TX_TS_SEQ_ID_TSTS_VALID(aData)
        set_TX_TS_SEQ_ID_TSTS_VALID = aData
        write
    End Property

    Property Get get_TX_TS_SEQ_ID_TSTS_SEQ_ID
        get_TX_TS_SEQ_ID_TSTS_SEQ_ID = read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value
    End Property

    Property Let set_TX_TS_SEQ_ID_TSTS_SEQ_ID(aData)
        write_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = aData
        flag_TX_TS_SEQ_ID_TSTS_SEQ_ID        = &H1
    End Property

    Property Get read_TX_TS_SEQ_ID_TSTS_SEQ_ID
        read
        read_TX_TS_SEQ_ID_TSTS_SEQ_ID = read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value
    End Property

    Property Let write_TX_TS_SEQ_ID_TSTS_SEQ_ID(aData)
        set_TX_TS_SEQ_ID_TSTS_SEQ_ID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value = rightShift(data_low, 17) and &H7fff
        read_TX_TS_SEQ_ID_TSTS_VALID_value = rightShift(data_low, 16) and &H1
        TX_TS_SEQ_ID_TSTS_SEQ_ID_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_TS_SEQ_ID_TSTS_SEQ_ID_mask = mask then
                read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = data_low
            else
                read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = (data_low - H8000_0000) and TX_TS_SEQ_ID_TSTS_SEQ_ID_mask
            end If
        else
            read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = data_low and TX_TS_SEQ_ID_TSTS_SEQ_ID_mask
        end If

    End Sub

    Sub write
        If flag_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2 = &H0 or flag_TX_TS_SEQ_ID_TSTS_VALID = &H0 or flag_TX_TS_SEQ_ID_TSTS_SEQ_ID = &H0 Then read
        If flag_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2 = &H0 Then write_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value = get_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2
        If flag_TX_TS_SEQ_ID_TSTS_VALID = &H0 Then write_TX_TS_SEQ_ID_TSTS_VALID_value = get_TX_TS_SEQ_ID_TSTS_VALID
        If flag_TX_TS_SEQ_ID_TSTS_SEQ_ID = &H0 Then write_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = get_TX_TS_SEQ_ID_TSTS_SEQ_ID

        regValue = leftShift((write_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value and &H7fff), 17) + leftShift((write_TX_TS_SEQ_ID_TSTS_VALID_value and &H1), 16) + leftShift((write_TX_TS_SEQ_ID_TSTS_SEQ_ID_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value = rightShift(data_low, 17) and &H7fff
        read_TX_TS_SEQ_ID_TSTS_VALID_value = rightShift(data_low, 16) and &H1
        TX_TS_SEQ_ID_TSTS_SEQ_ID_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_TS_SEQ_ID_TSTS_SEQ_ID_mask = mask then
                read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = data_low
            else
                read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = (data_low - H8000_0000) and TX_TS_SEQ_ID_TSTS_SEQ_ID_mask
            end If
        else
            read_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = data_low and TX_TS_SEQ_ID_TSTS_SEQ_ID_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2_value = &H0
        flag_TX_TS_SEQ_ID_TX_TS_SEQ_ID_RSVD_2        = &H0
        write_TX_TS_SEQ_ID_TSTS_VALID_value = &H0
        flag_TX_TS_SEQ_ID_TSTS_VALID        = &H0
        write_TX_TS_SEQ_ID_TSTS_SEQ_ID_value = &H0
        flag_TX_TS_SEQ_ID_TSTS_SEQ_ID        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_sfd_offset
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SFD_OFFSET_SFD_OFFSET_RSVD_1               [31:4]           get_SFD_OFFSET_SFD_OFFSET_RSVD_1
''                                                             set_SFD_OFFSET_SFD_OFFSET_RSVD_1
''                                                             read_SFD_OFFSET_SFD_OFFSET_RSVD_1
''                                                             write_SFD_OFFSET_SFD_OFFSET_RSVD_1
''---------------------------------------------------------------------------------
'' SFD_OFFSET_SFD_OFFSET                      [3:0]            get_SFD_OFFSET_SFD_OFFSET
''                                                             set_SFD_OFFSET_SFD_OFFSET
''                                                             read_SFD_OFFSET_SFD_OFFSET
''                                                             write_SFD_OFFSET_SFD_OFFSET
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_sfd_offset
    Private write_SFD_OFFSET_SFD_OFFSET_RSVD_1_value
    Private read_SFD_OFFSET_SFD_OFFSET_RSVD_1_value
    Private flag_SFD_OFFSET_SFD_OFFSET_RSVD_1
    Private write_SFD_OFFSET_SFD_OFFSET_value
    Private read_SFD_OFFSET_SFD_OFFSET_value
    Private flag_SFD_OFFSET_SFD_OFFSET

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

    Property Get get_SFD_OFFSET_SFD_OFFSET_RSVD_1
        get_SFD_OFFSET_SFD_OFFSET_RSVD_1 = read_SFD_OFFSET_SFD_OFFSET_RSVD_1_value
    End Property

    Property Let set_SFD_OFFSET_SFD_OFFSET_RSVD_1(aData)
        write_SFD_OFFSET_SFD_OFFSET_RSVD_1_value = aData
        flag_SFD_OFFSET_SFD_OFFSET_RSVD_1        = &H1
    End Property

    Property Get read_SFD_OFFSET_SFD_OFFSET_RSVD_1
        read
        read_SFD_OFFSET_SFD_OFFSET_RSVD_1 = read_SFD_OFFSET_SFD_OFFSET_RSVD_1_value
    End Property

    Property Let write_SFD_OFFSET_SFD_OFFSET_RSVD_1(aData)
        set_SFD_OFFSET_SFD_OFFSET_RSVD_1 = aData
        write
    End Property

    Property Get get_SFD_OFFSET_SFD_OFFSET
        get_SFD_OFFSET_SFD_OFFSET = read_SFD_OFFSET_SFD_OFFSET_value
    End Property

    Property Let set_SFD_OFFSET_SFD_OFFSET(aData)
        write_SFD_OFFSET_SFD_OFFSET_value = aData
        flag_SFD_OFFSET_SFD_OFFSET        = &H1
    End Property

    Property Get read_SFD_OFFSET_SFD_OFFSET
        read
        read_SFD_OFFSET_SFD_OFFSET = read_SFD_OFFSET_SFD_OFFSET_value
    End Property

    Property Let write_SFD_OFFSET_SFD_OFFSET(aData)
        set_SFD_OFFSET_SFD_OFFSET = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SFD_OFFSET_SFD_OFFSET_RSVD_1_value = rightShift(data_low, 4) and &Hfffffff
        SFD_OFFSET_SFD_OFFSET_mask = &Hf
        if data_low > LONG_MAX then
            if SFD_OFFSET_SFD_OFFSET_mask = mask then
                read_SFD_OFFSET_SFD_OFFSET_value = data_low
            else
                read_SFD_OFFSET_SFD_OFFSET_value = (data_low - H8000_0000) and SFD_OFFSET_SFD_OFFSET_mask
            end If
        else
            read_SFD_OFFSET_SFD_OFFSET_value = data_low and SFD_OFFSET_SFD_OFFSET_mask
        end If

    End Sub

    Sub write
        If flag_SFD_OFFSET_SFD_OFFSET_RSVD_1 = &H0 or flag_SFD_OFFSET_SFD_OFFSET = &H0 Then read
        If flag_SFD_OFFSET_SFD_OFFSET_RSVD_1 = &H0 Then write_SFD_OFFSET_SFD_OFFSET_RSVD_1_value = get_SFD_OFFSET_SFD_OFFSET_RSVD_1
        If flag_SFD_OFFSET_SFD_OFFSET = &H0 Then write_SFD_OFFSET_SFD_OFFSET_value = get_SFD_OFFSET_SFD_OFFSET

        regValue = leftShift((write_SFD_OFFSET_SFD_OFFSET_RSVD_1_value and &Hfffffff), 4) + leftShift((write_SFD_OFFSET_SFD_OFFSET_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SFD_OFFSET_SFD_OFFSET_RSVD_1_value = rightShift(data_low, 4) and &Hfffffff
        SFD_OFFSET_SFD_OFFSET_mask = &Hf
        if data_low > LONG_MAX then
            if SFD_OFFSET_SFD_OFFSET_mask = mask then
                read_SFD_OFFSET_SFD_OFFSET_value = data_low
            else
                read_SFD_OFFSET_SFD_OFFSET_value = (data_low - H8000_0000) and SFD_OFFSET_SFD_OFFSET_mask
            end If
        else
            read_SFD_OFFSET_SFD_OFFSET_value = data_low and SFD_OFFSET_SFD_OFFSET_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SFD_OFFSET_SFD_OFFSET_RSVD_1_value = &H0
        flag_SFD_OFFSET_SFD_OFFSET_RSVD_1        = &H0
        write_SFD_OFFSET_SFD_OFFSET_value = &H0
        flag_SFD_OFFSET_SFD_OFFSET        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_mode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_MODE_MAC_MODE_RSVD_5                   [31:6]           get_MAC_MODE_MAC_MODE_RSVD_5
''                                                             set_MAC_MODE_MAC_MODE_RSVD_5
''                                                             read_MAC_MODE_MAC_MODE_RSVD_5
''                                                             write_MAC_MODE_MAC_MODE_RSVD_5
''---------------------------------------------------------------------------------
'' MAC_MODE_LINK_STATUS                       [5:5]            get_MAC_MODE_LINK_STATUS
''                                                             set_MAC_MODE_LINK_STATUS
''                                                             read_MAC_MODE_LINK_STATUS
''                                                             write_MAC_MODE_LINK_STATUS
''---------------------------------------------------------------------------------
'' MAC_MODE_MAC_TX_PAUSE                      [4:4]            get_MAC_MODE_MAC_TX_PAUSE
''                                                             set_MAC_MODE_MAC_TX_PAUSE
''                                                             read_MAC_MODE_MAC_TX_PAUSE
''                                                             write_MAC_MODE_MAC_TX_PAUSE
''---------------------------------------------------------------------------------
'' MAC_MODE_MAC_RX_PAUSE                      [3:3]            get_MAC_MODE_MAC_RX_PAUSE
''                                                             set_MAC_MODE_MAC_RX_PAUSE
''                                                             read_MAC_MODE_MAC_RX_PAUSE
''                                                             write_MAC_MODE_MAC_RX_PAUSE
''---------------------------------------------------------------------------------
'' MAC_MODE_MAC_DUPLEX                        [2:2]            get_MAC_MODE_MAC_DUPLEX
''                                                             set_MAC_MODE_MAC_DUPLEX
''                                                             read_MAC_MODE_MAC_DUPLEX
''                                                             write_MAC_MODE_MAC_DUPLEX
''---------------------------------------------------------------------------------
'' MAC_MODE_MAC_SPEED                         [1:0]            get_MAC_MODE_MAC_SPEED
''                                                             set_MAC_MODE_MAC_SPEED
''                                                             read_MAC_MODE_MAC_SPEED
''                                                             write_MAC_MODE_MAC_SPEED
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_mode
    Private write_MAC_MODE_MAC_MODE_RSVD_5_value
    Private read_MAC_MODE_MAC_MODE_RSVD_5_value
    Private flag_MAC_MODE_MAC_MODE_RSVD_5
    Private write_MAC_MODE_LINK_STATUS_value
    Private read_MAC_MODE_LINK_STATUS_value
    Private flag_MAC_MODE_LINK_STATUS
    Private write_MAC_MODE_MAC_TX_PAUSE_value
    Private read_MAC_MODE_MAC_TX_PAUSE_value
    Private flag_MAC_MODE_MAC_TX_PAUSE
    Private write_MAC_MODE_MAC_RX_PAUSE_value
    Private read_MAC_MODE_MAC_RX_PAUSE_value
    Private flag_MAC_MODE_MAC_RX_PAUSE
    Private write_MAC_MODE_MAC_DUPLEX_value
    Private read_MAC_MODE_MAC_DUPLEX_value
    Private flag_MAC_MODE_MAC_DUPLEX
    Private write_MAC_MODE_MAC_SPEED_value
    Private read_MAC_MODE_MAC_SPEED_value
    Private flag_MAC_MODE_MAC_SPEED

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

    Property Get get_MAC_MODE_MAC_MODE_RSVD_5
        get_MAC_MODE_MAC_MODE_RSVD_5 = read_MAC_MODE_MAC_MODE_RSVD_5_value
    End Property

    Property Let set_MAC_MODE_MAC_MODE_RSVD_5(aData)
        write_MAC_MODE_MAC_MODE_RSVD_5_value = aData
        flag_MAC_MODE_MAC_MODE_RSVD_5        = &H1
    End Property

    Property Get read_MAC_MODE_MAC_MODE_RSVD_5
        read
        read_MAC_MODE_MAC_MODE_RSVD_5 = read_MAC_MODE_MAC_MODE_RSVD_5_value
    End Property

    Property Let write_MAC_MODE_MAC_MODE_RSVD_5(aData)
        set_MAC_MODE_MAC_MODE_RSVD_5 = aData
        write
    End Property

    Property Get get_MAC_MODE_LINK_STATUS
        get_MAC_MODE_LINK_STATUS = read_MAC_MODE_LINK_STATUS_value
    End Property

    Property Let set_MAC_MODE_LINK_STATUS(aData)
        write_MAC_MODE_LINK_STATUS_value = aData
        flag_MAC_MODE_LINK_STATUS        = &H1
    End Property

    Property Get read_MAC_MODE_LINK_STATUS
        read
        read_MAC_MODE_LINK_STATUS = read_MAC_MODE_LINK_STATUS_value
    End Property

    Property Let write_MAC_MODE_LINK_STATUS(aData)
        set_MAC_MODE_LINK_STATUS = aData
        write
    End Property

    Property Get get_MAC_MODE_MAC_TX_PAUSE
        get_MAC_MODE_MAC_TX_PAUSE = read_MAC_MODE_MAC_TX_PAUSE_value
    End Property

    Property Let set_MAC_MODE_MAC_TX_PAUSE(aData)
        write_MAC_MODE_MAC_TX_PAUSE_value = aData
        flag_MAC_MODE_MAC_TX_PAUSE        = &H1
    End Property

    Property Get read_MAC_MODE_MAC_TX_PAUSE
        read
        read_MAC_MODE_MAC_TX_PAUSE = read_MAC_MODE_MAC_TX_PAUSE_value
    End Property

    Property Let write_MAC_MODE_MAC_TX_PAUSE(aData)
        set_MAC_MODE_MAC_TX_PAUSE = aData
        write
    End Property

    Property Get get_MAC_MODE_MAC_RX_PAUSE
        get_MAC_MODE_MAC_RX_PAUSE = read_MAC_MODE_MAC_RX_PAUSE_value
    End Property

    Property Let set_MAC_MODE_MAC_RX_PAUSE(aData)
        write_MAC_MODE_MAC_RX_PAUSE_value = aData
        flag_MAC_MODE_MAC_RX_PAUSE        = &H1
    End Property

    Property Get read_MAC_MODE_MAC_RX_PAUSE
        read
        read_MAC_MODE_MAC_RX_PAUSE = read_MAC_MODE_MAC_RX_PAUSE_value
    End Property

    Property Let write_MAC_MODE_MAC_RX_PAUSE(aData)
        set_MAC_MODE_MAC_RX_PAUSE = aData
        write
    End Property

    Property Get get_MAC_MODE_MAC_DUPLEX
        get_MAC_MODE_MAC_DUPLEX = read_MAC_MODE_MAC_DUPLEX_value
    End Property

    Property Let set_MAC_MODE_MAC_DUPLEX(aData)
        write_MAC_MODE_MAC_DUPLEX_value = aData
        flag_MAC_MODE_MAC_DUPLEX        = &H1
    End Property

    Property Get read_MAC_MODE_MAC_DUPLEX
        read
        read_MAC_MODE_MAC_DUPLEX = read_MAC_MODE_MAC_DUPLEX_value
    End Property

    Property Let write_MAC_MODE_MAC_DUPLEX(aData)
        set_MAC_MODE_MAC_DUPLEX = aData
        write
    End Property

    Property Get get_MAC_MODE_MAC_SPEED
        get_MAC_MODE_MAC_SPEED = read_MAC_MODE_MAC_SPEED_value
    End Property

    Property Let set_MAC_MODE_MAC_SPEED(aData)
        write_MAC_MODE_MAC_SPEED_value = aData
        flag_MAC_MODE_MAC_SPEED        = &H1
    End Property

    Property Get read_MAC_MODE_MAC_SPEED
        read
        read_MAC_MODE_MAC_SPEED = read_MAC_MODE_MAC_SPEED_value
    End Property

    Property Let write_MAC_MODE_MAC_SPEED(aData)
        set_MAC_MODE_MAC_SPEED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_MODE_MAC_MODE_RSVD_5_value = rightShift(data_low, 6) and &H3ffffff
        read_MAC_MODE_LINK_STATUS_value = rightShift(data_low, 5) and &H1
        read_MAC_MODE_MAC_TX_PAUSE_value = rightShift(data_low, 4) and &H1
        read_MAC_MODE_MAC_RX_PAUSE_value = rightShift(data_low, 3) and &H1
        read_MAC_MODE_MAC_DUPLEX_value = rightShift(data_low, 2) and &H1
        MAC_MODE_MAC_SPEED_mask = &H3
        if data_low > LONG_MAX then
            if MAC_MODE_MAC_SPEED_mask = mask then
                read_MAC_MODE_MAC_SPEED_value = data_low
            else
                read_MAC_MODE_MAC_SPEED_value = (data_low - H8000_0000) and MAC_MODE_MAC_SPEED_mask
            end If
        else
            read_MAC_MODE_MAC_SPEED_value = data_low and MAC_MODE_MAC_SPEED_mask
        end If

    End Sub

    Sub write
        If flag_MAC_MODE_MAC_MODE_RSVD_5 = &H0 or flag_MAC_MODE_LINK_STATUS = &H0 or flag_MAC_MODE_MAC_TX_PAUSE = &H0 or flag_MAC_MODE_MAC_RX_PAUSE = &H0 or flag_MAC_MODE_MAC_DUPLEX = &H0 or flag_MAC_MODE_MAC_SPEED = &H0 Then read
        If flag_MAC_MODE_MAC_MODE_RSVD_5 = &H0 Then write_MAC_MODE_MAC_MODE_RSVD_5_value = get_MAC_MODE_MAC_MODE_RSVD_5
        If flag_MAC_MODE_LINK_STATUS = &H0 Then write_MAC_MODE_LINK_STATUS_value = get_MAC_MODE_LINK_STATUS
        If flag_MAC_MODE_MAC_TX_PAUSE = &H0 Then write_MAC_MODE_MAC_TX_PAUSE_value = get_MAC_MODE_MAC_TX_PAUSE
        If flag_MAC_MODE_MAC_RX_PAUSE = &H0 Then write_MAC_MODE_MAC_RX_PAUSE_value = get_MAC_MODE_MAC_RX_PAUSE
        If flag_MAC_MODE_MAC_DUPLEX = &H0 Then write_MAC_MODE_MAC_DUPLEX_value = get_MAC_MODE_MAC_DUPLEX
        If flag_MAC_MODE_MAC_SPEED = &H0 Then write_MAC_MODE_MAC_SPEED_value = get_MAC_MODE_MAC_SPEED

        regValue = leftShift((write_MAC_MODE_MAC_MODE_RSVD_5_value and &H3ffffff), 6) + leftShift((write_MAC_MODE_LINK_STATUS_value and &H1), 5) + leftShift((write_MAC_MODE_MAC_TX_PAUSE_value and &H1), 4) + leftShift((write_MAC_MODE_MAC_RX_PAUSE_value and &H1), 3) + leftShift((write_MAC_MODE_MAC_DUPLEX_value and &H1), 2) + leftShift((write_MAC_MODE_MAC_SPEED_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_MODE_MAC_MODE_RSVD_5_value = rightShift(data_low, 6) and &H3ffffff
        read_MAC_MODE_LINK_STATUS_value = rightShift(data_low, 5) and &H1
        read_MAC_MODE_MAC_TX_PAUSE_value = rightShift(data_low, 4) and &H1
        read_MAC_MODE_MAC_RX_PAUSE_value = rightShift(data_low, 3) and &H1
        read_MAC_MODE_MAC_DUPLEX_value = rightShift(data_low, 2) and &H1
        MAC_MODE_MAC_SPEED_mask = &H3
        if data_low > LONG_MAX then
            if MAC_MODE_MAC_SPEED_mask = mask then
                read_MAC_MODE_MAC_SPEED_value = data_low
            else
                read_MAC_MODE_MAC_SPEED_value = (data_low - H8000_0000) and MAC_MODE_MAC_SPEED_mask
            end If
        else
            read_MAC_MODE_MAC_SPEED_value = data_low and MAC_MODE_MAC_SPEED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_MODE_MAC_MODE_RSVD_5_value = &H0
        flag_MAC_MODE_MAC_MODE_RSVD_5        = &H0
        write_MAC_MODE_LINK_STATUS_value = &H0
        flag_MAC_MODE_LINK_STATUS        = &H0
        write_MAC_MODE_MAC_TX_PAUSE_value = &H0
        flag_MAC_MODE_MAC_TX_PAUSE        = &H0
        write_MAC_MODE_MAC_RX_PAUSE_value = &H0
        flag_MAC_MODE_MAC_RX_PAUSE        = &H0
        write_MAC_MODE_MAC_DUPLEX_value = &H0
        flag_MAC_MODE_MAC_DUPLEX        = &H0
        write_MAC_MODE_MAC_SPEED_value = &H0
        flag_MAC_MODE_MAC_SPEED        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_tag_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TAG_0_TAG_0_RSVD_2                         [31:17]          get_TAG_0_TAG_0_RSVD_2
''                                                             set_TAG_0_TAG_0_RSVD_2
''                                                             read_TAG_0_TAG_0_RSVD_2
''                                                             write_TAG_0_TAG_0_RSVD_2
''---------------------------------------------------------------------------------
'' TAG_0_CONFIG_OUTER_TPID_ENABLE             [16:16]          get_TAG_0_CONFIG_OUTER_TPID_ENABLE
''                                                             set_TAG_0_CONFIG_OUTER_TPID_ENABLE
''                                                             read_TAG_0_CONFIG_OUTER_TPID_ENABLE
''                                                             write_TAG_0_CONFIG_OUTER_TPID_ENABLE
''---------------------------------------------------------------------------------
'' TAG_0_FRM_TAG_0                            [15:0]           get_TAG_0_FRM_TAG_0
''                                                             set_TAG_0_FRM_TAG_0
''                                                             read_TAG_0_FRM_TAG_0
''                                                             write_TAG_0_FRM_TAG_0
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_tag_0
    Private write_TAG_0_TAG_0_RSVD_2_value
    Private read_TAG_0_TAG_0_RSVD_2_value
    Private flag_TAG_0_TAG_0_RSVD_2
    Private write_TAG_0_CONFIG_OUTER_TPID_ENABLE_value
    Private read_TAG_0_CONFIG_OUTER_TPID_ENABLE_value
    Private flag_TAG_0_CONFIG_OUTER_TPID_ENABLE
    Private write_TAG_0_FRM_TAG_0_value
    Private read_TAG_0_FRM_TAG_0_value
    Private flag_TAG_0_FRM_TAG_0

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

    Property Get get_TAG_0_TAG_0_RSVD_2
        get_TAG_0_TAG_0_RSVD_2 = read_TAG_0_TAG_0_RSVD_2_value
    End Property

    Property Let set_TAG_0_TAG_0_RSVD_2(aData)
        write_TAG_0_TAG_0_RSVD_2_value = aData
        flag_TAG_0_TAG_0_RSVD_2        = &H1
    End Property

    Property Get read_TAG_0_TAG_0_RSVD_2
        read
        read_TAG_0_TAG_0_RSVD_2 = read_TAG_0_TAG_0_RSVD_2_value
    End Property

    Property Let write_TAG_0_TAG_0_RSVD_2(aData)
        set_TAG_0_TAG_0_RSVD_2 = aData
        write
    End Property

    Property Get get_TAG_0_CONFIG_OUTER_TPID_ENABLE
        get_TAG_0_CONFIG_OUTER_TPID_ENABLE = read_TAG_0_CONFIG_OUTER_TPID_ENABLE_value
    End Property

    Property Let set_TAG_0_CONFIG_OUTER_TPID_ENABLE(aData)
        write_TAG_0_CONFIG_OUTER_TPID_ENABLE_value = aData
        flag_TAG_0_CONFIG_OUTER_TPID_ENABLE        = &H1
    End Property

    Property Get read_TAG_0_CONFIG_OUTER_TPID_ENABLE
        read
        read_TAG_0_CONFIG_OUTER_TPID_ENABLE = read_TAG_0_CONFIG_OUTER_TPID_ENABLE_value
    End Property

    Property Let write_TAG_0_CONFIG_OUTER_TPID_ENABLE(aData)
        set_TAG_0_CONFIG_OUTER_TPID_ENABLE = aData
        write
    End Property

    Property Get get_TAG_0_FRM_TAG_0
        get_TAG_0_FRM_TAG_0 = read_TAG_0_FRM_TAG_0_value
    End Property

    Property Let set_TAG_0_FRM_TAG_0(aData)
        write_TAG_0_FRM_TAG_0_value = aData
        flag_TAG_0_FRM_TAG_0        = &H1
    End Property

    Property Get read_TAG_0_FRM_TAG_0
        read
        read_TAG_0_FRM_TAG_0 = read_TAG_0_FRM_TAG_0_value
    End Property

    Property Let write_TAG_0_FRM_TAG_0(aData)
        set_TAG_0_FRM_TAG_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TAG_0_TAG_0_RSVD_2_value = rightShift(data_low, 17) and &H7fff
        read_TAG_0_CONFIG_OUTER_TPID_ENABLE_value = rightShift(data_low, 16) and &H1
        TAG_0_FRM_TAG_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TAG_0_FRM_TAG_0_mask = mask then
                read_TAG_0_FRM_TAG_0_value = data_low
            else
                read_TAG_0_FRM_TAG_0_value = (data_low - H8000_0000) and TAG_0_FRM_TAG_0_mask
            end If
        else
            read_TAG_0_FRM_TAG_0_value = data_low and TAG_0_FRM_TAG_0_mask
        end If

    End Sub

    Sub write
        If flag_TAG_0_TAG_0_RSVD_2 = &H0 or flag_TAG_0_CONFIG_OUTER_TPID_ENABLE = &H0 or flag_TAG_0_FRM_TAG_0 = &H0 Then read
        If flag_TAG_0_TAG_0_RSVD_2 = &H0 Then write_TAG_0_TAG_0_RSVD_2_value = get_TAG_0_TAG_0_RSVD_2
        If flag_TAG_0_CONFIG_OUTER_TPID_ENABLE = &H0 Then write_TAG_0_CONFIG_OUTER_TPID_ENABLE_value = get_TAG_0_CONFIG_OUTER_TPID_ENABLE
        If flag_TAG_0_FRM_TAG_0 = &H0 Then write_TAG_0_FRM_TAG_0_value = get_TAG_0_FRM_TAG_0

        regValue = leftShift((write_TAG_0_TAG_0_RSVD_2_value and &H7fff), 17) + leftShift((write_TAG_0_CONFIG_OUTER_TPID_ENABLE_value and &H1), 16) + leftShift((write_TAG_0_FRM_TAG_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TAG_0_TAG_0_RSVD_2_value = rightShift(data_low, 17) and &H7fff
        read_TAG_0_CONFIG_OUTER_TPID_ENABLE_value = rightShift(data_low, 16) and &H1
        TAG_0_FRM_TAG_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TAG_0_FRM_TAG_0_mask = mask then
                read_TAG_0_FRM_TAG_0_value = data_low
            else
                read_TAG_0_FRM_TAG_0_value = (data_low - H8000_0000) and TAG_0_FRM_TAG_0_mask
            end If
        else
            read_TAG_0_FRM_TAG_0_value = data_low and TAG_0_FRM_TAG_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TAG_0_TAG_0_RSVD_2_value = &H0
        flag_TAG_0_TAG_0_RSVD_2        = &H0
        write_TAG_0_CONFIG_OUTER_TPID_ENABLE_value = &H0
        flag_TAG_0_CONFIG_OUTER_TPID_ENABLE        = &H0
        write_TAG_0_FRM_TAG_0_value = &H0
        flag_TAG_0_FRM_TAG_0        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_tag_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TAG_1_TAG_1_RSVD_2                         [31:17]          get_TAG_1_TAG_1_RSVD_2
''                                                             set_TAG_1_TAG_1_RSVD_2
''                                                             read_TAG_1_TAG_1_RSVD_2
''                                                             write_TAG_1_TAG_1_RSVD_2
''---------------------------------------------------------------------------------
'' TAG_1_CONFIG_INNER_TPID_ENABLE             [16:16]          get_TAG_1_CONFIG_INNER_TPID_ENABLE
''                                                             set_TAG_1_CONFIG_INNER_TPID_ENABLE
''                                                             read_TAG_1_CONFIG_INNER_TPID_ENABLE
''                                                             write_TAG_1_CONFIG_INNER_TPID_ENABLE
''---------------------------------------------------------------------------------
'' TAG_1_FRM_TAG_1                            [15:0]           get_TAG_1_FRM_TAG_1
''                                                             set_TAG_1_FRM_TAG_1
''                                                             read_TAG_1_FRM_TAG_1
''                                                             write_TAG_1_FRM_TAG_1
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_tag_1
    Private write_TAG_1_TAG_1_RSVD_2_value
    Private read_TAG_1_TAG_1_RSVD_2_value
    Private flag_TAG_1_TAG_1_RSVD_2
    Private write_TAG_1_CONFIG_INNER_TPID_ENABLE_value
    Private read_TAG_1_CONFIG_INNER_TPID_ENABLE_value
    Private flag_TAG_1_CONFIG_INNER_TPID_ENABLE
    Private write_TAG_1_FRM_TAG_1_value
    Private read_TAG_1_FRM_TAG_1_value
    Private flag_TAG_1_FRM_TAG_1

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

    Property Get get_TAG_1_TAG_1_RSVD_2
        get_TAG_1_TAG_1_RSVD_2 = read_TAG_1_TAG_1_RSVD_2_value
    End Property

    Property Let set_TAG_1_TAG_1_RSVD_2(aData)
        write_TAG_1_TAG_1_RSVD_2_value = aData
        flag_TAG_1_TAG_1_RSVD_2        = &H1
    End Property

    Property Get read_TAG_1_TAG_1_RSVD_2
        read
        read_TAG_1_TAG_1_RSVD_2 = read_TAG_1_TAG_1_RSVD_2_value
    End Property

    Property Let write_TAG_1_TAG_1_RSVD_2(aData)
        set_TAG_1_TAG_1_RSVD_2 = aData
        write
    End Property

    Property Get get_TAG_1_CONFIG_INNER_TPID_ENABLE
        get_TAG_1_CONFIG_INNER_TPID_ENABLE = read_TAG_1_CONFIG_INNER_TPID_ENABLE_value
    End Property

    Property Let set_TAG_1_CONFIG_INNER_TPID_ENABLE(aData)
        write_TAG_1_CONFIG_INNER_TPID_ENABLE_value = aData
        flag_TAG_1_CONFIG_INNER_TPID_ENABLE        = &H1
    End Property

    Property Get read_TAG_1_CONFIG_INNER_TPID_ENABLE
        read
        read_TAG_1_CONFIG_INNER_TPID_ENABLE = read_TAG_1_CONFIG_INNER_TPID_ENABLE_value
    End Property

    Property Let write_TAG_1_CONFIG_INNER_TPID_ENABLE(aData)
        set_TAG_1_CONFIG_INNER_TPID_ENABLE = aData
        write
    End Property

    Property Get get_TAG_1_FRM_TAG_1
        get_TAG_1_FRM_TAG_1 = read_TAG_1_FRM_TAG_1_value
    End Property

    Property Let set_TAG_1_FRM_TAG_1(aData)
        write_TAG_1_FRM_TAG_1_value = aData
        flag_TAG_1_FRM_TAG_1        = &H1
    End Property

    Property Get read_TAG_1_FRM_TAG_1
        read
        read_TAG_1_FRM_TAG_1 = read_TAG_1_FRM_TAG_1_value
    End Property

    Property Let write_TAG_1_FRM_TAG_1(aData)
        set_TAG_1_FRM_TAG_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TAG_1_TAG_1_RSVD_2_value = rightShift(data_low, 17) and &H7fff
        read_TAG_1_CONFIG_INNER_TPID_ENABLE_value = rightShift(data_low, 16) and &H1
        TAG_1_FRM_TAG_1_mask = &Hffff
        if data_low > LONG_MAX then
            if TAG_1_FRM_TAG_1_mask = mask then
                read_TAG_1_FRM_TAG_1_value = data_low
            else
                read_TAG_1_FRM_TAG_1_value = (data_low - H8000_0000) and TAG_1_FRM_TAG_1_mask
            end If
        else
            read_TAG_1_FRM_TAG_1_value = data_low and TAG_1_FRM_TAG_1_mask
        end If

    End Sub

    Sub write
        If flag_TAG_1_TAG_1_RSVD_2 = &H0 or flag_TAG_1_CONFIG_INNER_TPID_ENABLE = &H0 or flag_TAG_1_FRM_TAG_1 = &H0 Then read
        If flag_TAG_1_TAG_1_RSVD_2 = &H0 Then write_TAG_1_TAG_1_RSVD_2_value = get_TAG_1_TAG_1_RSVD_2
        If flag_TAG_1_CONFIG_INNER_TPID_ENABLE = &H0 Then write_TAG_1_CONFIG_INNER_TPID_ENABLE_value = get_TAG_1_CONFIG_INNER_TPID_ENABLE
        If flag_TAG_1_FRM_TAG_1 = &H0 Then write_TAG_1_FRM_TAG_1_value = get_TAG_1_FRM_TAG_1

        regValue = leftShift((write_TAG_1_TAG_1_RSVD_2_value and &H7fff), 17) + leftShift((write_TAG_1_CONFIG_INNER_TPID_ENABLE_value and &H1), 16) + leftShift((write_TAG_1_FRM_TAG_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TAG_1_TAG_1_RSVD_2_value = rightShift(data_low, 17) and &H7fff
        read_TAG_1_CONFIG_INNER_TPID_ENABLE_value = rightShift(data_low, 16) and &H1
        TAG_1_FRM_TAG_1_mask = &Hffff
        if data_low > LONG_MAX then
            if TAG_1_FRM_TAG_1_mask = mask then
                read_TAG_1_FRM_TAG_1_value = data_low
            else
                read_TAG_1_FRM_TAG_1_value = (data_low - H8000_0000) and TAG_1_FRM_TAG_1_mask
            end If
        else
            read_TAG_1_FRM_TAG_1_value = data_low and TAG_1_FRM_TAG_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TAG_1_TAG_1_RSVD_2_value = &H0
        flag_TAG_1_TAG_1_RSVD_2        = &H0
        write_TAG_1_CONFIG_INNER_TPID_ENABLE_value = &H0
        flag_TAG_1_CONFIG_INNER_TPID_ENABLE        = &H0
        write_TAG_1_FRM_TAG_1_value = &H0
        flag_TAG_1_FRM_TAG_1        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_rx_pause_quanta_scale
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RPQSRPQSR3                                 [31:18]          get_RPQSRPQSR3
''                                                             set_RPQSRPQSR3
''                                                             read_RPQSRPQSR3
''                                                             write_RPQSRPQSR3
''---------------------------------------------------------------------------------
'' RX_PAUSE_QUANTA_SCALE_SCALE_FIX            [17:17]          get_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
''                                                             set_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
''                                                             read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
''                                                             write_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
''---------------------------------------------------------------------------------
'' RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL        [16:16]          get_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
''                                                             set_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
''                                                             read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
''                                                             write_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
''---------------------------------------------------------------------------------
'' RX_PAUSE_QUANTA_SCALE_SCALE_VALUE          [15:0]           get_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE
''                                                             set_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE
''                                                             read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE
''                                                             write_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_rx_pause_quanta_scale
    Private write_RPQSRPQSR3_value
    Private read_RPQSRPQSR3_value
    Private flag_RPQSRPQSR3
    Private write_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value
    Private read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value
    Private flag_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
    Private write_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value
    Private read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value
    Private flag_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
    Private write_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value
    Private read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value
    Private flag_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE

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

    Property Get get_RPQSRPQSR3
        get_RPQSRPQSR3 = read_RPQSRPQSR3_value
    End Property

    Property Let set_RPQSRPQSR3(aData)
        write_RPQSRPQSR3_value = aData
        flag_RPQSRPQSR3        = &H1
    End Property

    Property Get read_RPQSRPQSR3
        read
        read_RPQSRPQSR3 = read_RPQSRPQSR3_value
    End Property

    Property Let write_RPQSRPQSR3(aData)
        set_RPQSRPQSR3 = aData
        write
    End Property

    Property Get get_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
        get_RX_PAUSE_QUANTA_SCALE_SCALE_FIX = read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value
    End Property

    Property Let set_RX_PAUSE_QUANTA_SCALE_SCALE_FIX(aData)
        write_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value = aData
        flag_RX_PAUSE_QUANTA_SCALE_SCALE_FIX        = &H1
    End Property

    Property Get read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
        read
        read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX = read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value
    End Property

    Property Let write_RX_PAUSE_QUANTA_SCALE_SCALE_FIX(aData)
        set_RX_PAUSE_QUANTA_SCALE_SCALE_FIX = aData
        write
    End Property

    Property Get get_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
        get_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL = read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value
    End Property

    Property Let set_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL(aData)
        write_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value = aData
        flag_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL        = &H1
    End Property

    Property Get read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
        read
        read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL = read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value
    End Property

    Property Let write_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL(aData)
        set_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL = aData
        write
    End Property

    Property Get get_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE
        get_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE = read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value
    End Property

    Property Let set_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE(aData)
        write_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = aData
        flag_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE        = &H1
    End Property

    Property Get read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE
        read
        read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE = read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value
    End Property

    Property Let write_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE(aData)
        set_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RPQSRPQSR3_value = rightShift(data_low, 18) and &H3fff
        read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value = rightShift(data_low, 17) and &H1
        read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value = rightShift(data_low, 16) and &H1
        RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask = mask then
                read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = data_low
            else
                read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = (data_low - H8000_0000) and RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask
            end If
        else
            read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = data_low and RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_RPQSRPQSR3 = &H0 or flag_RX_PAUSE_QUANTA_SCALE_SCALE_FIX = &H0 or flag_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL = &H0 or flag_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE = &H0 Then read
        If flag_RPQSRPQSR3 = &H0 Then write_RPQSRPQSR3_value = get_RPQSRPQSR3
        If flag_RX_PAUSE_QUANTA_SCALE_SCALE_FIX = &H0 Then write_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value = get_RX_PAUSE_QUANTA_SCALE_SCALE_FIX
        If flag_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL = &H0 Then write_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value = get_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL
        If flag_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE = &H0 Then write_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = get_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE

        regValue = leftShift((write_RPQSRPQSR3_value and &H3fff), 18) + leftShift((write_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value and &H1), 17) + leftShift((write_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value and &H1), 16) + leftShift((write_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RPQSRPQSR3_value = rightShift(data_low, 18) and &H3fff
        read_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value = rightShift(data_low, 17) and &H1
        read_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value = rightShift(data_low, 16) and &H1
        RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask = mask then
                read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = data_low
            else
                read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = (data_low - H8000_0000) and RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask
            end If
        else
            read_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = data_low and RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RPQSRPQSR3_value = &H0
        flag_RPQSRPQSR3        = &H0
        write_RX_PAUSE_QUANTA_SCALE_SCALE_FIX_value = &H0
        flag_RX_PAUSE_QUANTA_SCALE_SCALE_FIX        = &H0
        write_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL_value = &H0
        flag_RX_PAUSE_QUANTA_SCALE_SCALE_CONTROL        = &H0
        write_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE_value = &H0
        flag_RX_PAUSE_QUANTA_SCALE_SCALE_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_tx_preamble
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PREAMBLE_TX_PREAMBLE_RSVD_1             [31:3]           get_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
''                                                             set_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
''                                                             read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
''                                                             write_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
''---------------------------------------------------------------------------------
'' TX_PREAMBLE_TX_PREAMBLE                    [2:0]            get_TX_PREAMBLE_TX_PREAMBLE
''                                                             set_TX_PREAMBLE_TX_PREAMBLE
''                                                             read_TX_PREAMBLE_TX_PREAMBLE
''                                                             write_TX_PREAMBLE_TX_PREAMBLE
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_tx_preamble
    Private write_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value
    Private read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value
    Private flag_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
    Private write_TX_PREAMBLE_TX_PREAMBLE_value
    Private read_TX_PREAMBLE_TX_PREAMBLE_value
    Private flag_TX_PREAMBLE_TX_PREAMBLE

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

    Property Get get_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
        get_TX_PREAMBLE_TX_PREAMBLE_RSVD_1 = read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value
    End Property

    Property Let set_TX_PREAMBLE_TX_PREAMBLE_RSVD_1(aData)
        write_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value = aData
        flag_TX_PREAMBLE_TX_PREAMBLE_RSVD_1        = &H1
    End Property

    Property Get read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
        read
        read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1 = read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value
    End Property

    Property Let write_TX_PREAMBLE_TX_PREAMBLE_RSVD_1(aData)
        set_TX_PREAMBLE_TX_PREAMBLE_RSVD_1 = aData
        write
    End Property

    Property Get get_TX_PREAMBLE_TX_PREAMBLE
        get_TX_PREAMBLE_TX_PREAMBLE = read_TX_PREAMBLE_TX_PREAMBLE_value
    End Property

    Property Let set_TX_PREAMBLE_TX_PREAMBLE(aData)
        write_TX_PREAMBLE_TX_PREAMBLE_value = aData
        flag_TX_PREAMBLE_TX_PREAMBLE        = &H1
    End Property

    Property Get read_TX_PREAMBLE_TX_PREAMBLE
        read
        read_TX_PREAMBLE_TX_PREAMBLE = read_TX_PREAMBLE_TX_PREAMBLE_value
    End Property

    Property Let write_TX_PREAMBLE_TX_PREAMBLE(aData)
        set_TX_PREAMBLE_TX_PREAMBLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value = rightShift(data_low, 3) and &H1fffffff
        TX_PREAMBLE_TX_PREAMBLE_mask = &H7
        if data_low > LONG_MAX then
            if TX_PREAMBLE_TX_PREAMBLE_mask = mask then
                read_TX_PREAMBLE_TX_PREAMBLE_value = data_low
            else
                read_TX_PREAMBLE_TX_PREAMBLE_value = (data_low - H8000_0000) and TX_PREAMBLE_TX_PREAMBLE_mask
            end If
        else
            read_TX_PREAMBLE_TX_PREAMBLE_value = data_low and TX_PREAMBLE_TX_PREAMBLE_mask
        end If

    End Sub

    Sub write
        If flag_TX_PREAMBLE_TX_PREAMBLE_RSVD_1 = &H0 or flag_TX_PREAMBLE_TX_PREAMBLE = &H0 Then read
        If flag_TX_PREAMBLE_TX_PREAMBLE_RSVD_1 = &H0 Then write_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value = get_TX_PREAMBLE_TX_PREAMBLE_RSVD_1
        If flag_TX_PREAMBLE_TX_PREAMBLE = &H0 Then write_TX_PREAMBLE_TX_PREAMBLE_value = get_TX_PREAMBLE_TX_PREAMBLE

        regValue = leftShift((write_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value and &H1fffffff), 3) + leftShift((write_TX_PREAMBLE_TX_PREAMBLE_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value = rightShift(data_low, 3) and &H1fffffff
        TX_PREAMBLE_TX_PREAMBLE_mask = &H7
        if data_low > LONG_MAX then
            if TX_PREAMBLE_TX_PREAMBLE_mask = mask then
                read_TX_PREAMBLE_TX_PREAMBLE_value = data_low
            else
                read_TX_PREAMBLE_TX_PREAMBLE_value = (data_low - H8000_0000) and TX_PREAMBLE_TX_PREAMBLE_mask
            end If
        else
            read_TX_PREAMBLE_TX_PREAMBLE_value = data_low and TX_PREAMBLE_TX_PREAMBLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PREAMBLE_TX_PREAMBLE_RSVD_1_value = &H0
        flag_TX_PREAMBLE_TX_PREAMBLE_RSVD_1        = &H0
        write_TX_PREAMBLE_TX_PREAMBLE_value = &H0
        flag_TX_PREAMBLE_TX_PREAMBLE        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_tx_ipg_length
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1         [31:7]           get_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
''                                                             set_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
''                                                             read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
''                                                             write_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
''---------------------------------------------------------------------------------
'' TX_IPG_LENGTH_TX_IPG_LENGTH                [6:0]            get_TX_IPG_LENGTH_TX_IPG_LENGTH
''                                                             set_TX_IPG_LENGTH_TX_IPG_LENGTH
''                                                             read_TX_IPG_LENGTH_TX_IPG_LENGTH
''                                                             write_TX_IPG_LENGTH_TX_IPG_LENGTH
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_tx_ipg_length
    Private write_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value
    Private read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value
    Private flag_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
    Private write_TX_IPG_LENGTH_TX_IPG_LENGTH_value
    Private read_TX_IPG_LENGTH_TX_IPG_LENGTH_value
    Private flag_TX_IPG_LENGTH_TX_IPG_LENGTH

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
        get_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1 = read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value
    End Property

    Property Let set_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1(aData)
        write_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value = aData
        flag_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1        = &H1
    End Property

    Property Get read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
        read
        read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1 = read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value
    End Property

    Property Let write_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1(aData)
        set_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1 = aData
        write
    End Property

    Property Get get_TX_IPG_LENGTH_TX_IPG_LENGTH
        get_TX_IPG_LENGTH_TX_IPG_LENGTH = read_TX_IPG_LENGTH_TX_IPG_LENGTH_value
    End Property

    Property Let set_TX_IPG_LENGTH_TX_IPG_LENGTH(aData)
        write_TX_IPG_LENGTH_TX_IPG_LENGTH_value = aData
        flag_TX_IPG_LENGTH_TX_IPG_LENGTH        = &H1
    End Property

    Property Get read_TX_IPG_LENGTH_TX_IPG_LENGTH
        read
        read_TX_IPG_LENGTH_TX_IPG_LENGTH = read_TX_IPG_LENGTH_TX_IPG_LENGTH_value
    End Property

    Property Let write_TX_IPG_LENGTH_TX_IPG_LENGTH(aData)
        set_TX_IPG_LENGTH_TX_IPG_LENGTH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value = rightShift(data_low, 7) and &H1ffffff
        TX_IPG_LENGTH_TX_IPG_LENGTH_mask = &H7f
        if data_low > LONG_MAX then
            if TX_IPG_LENGTH_TX_IPG_LENGTH_mask = mask then
                read_TX_IPG_LENGTH_TX_IPG_LENGTH_value = data_low
            else
                read_TX_IPG_LENGTH_TX_IPG_LENGTH_value = (data_low - H8000_0000) and TX_IPG_LENGTH_TX_IPG_LENGTH_mask
            end If
        else
            read_TX_IPG_LENGTH_TX_IPG_LENGTH_value = data_low and TX_IPG_LENGTH_TX_IPG_LENGTH_mask
        end If

    End Sub

    Sub write
        If flag_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1 = &H0 or flag_TX_IPG_LENGTH_TX_IPG_LENGTH = &H0 Then read
        If flag_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1 = &H0 Then write_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value = get_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1
        If flag_TX_IPG_LENGTH_TX_IPG_LENGTH = &H0 Then write_TX_IPG_LENGTH_TX_IPG_LENGTH_value = get_TX_IPG_LENGTH_TX_IPG_LENGTH

        regValue = leftShift((write_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value and &H1ffffff), 7) + leftShift((write_TX_IPG_LENGTH_TX_IPG_LENGTH_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value = rightShift(data_low, 7) and &H1ffffff
        TX_IPG_LENGTH_TX_IPG_LENGTH_mask = &H7f
        if data_low > LONG_MAX then
            if TX_IPG_LENGTH_TX_IPG_LENGTH_mask = mask then
                read_TX_IPG_LENGTH_TX_IPG_LENGTH_value = data_low
            else
                read_TX_IPG_LENGTH_TX_IPG_LENGTH_value = (data_low - H8000_0000) and TX_IPG_LENGTH_TX_IPG_LENGTH_mask
            end If
        else
            read_TX_IPG_LENGTH_TX_IPG_LENGTH_value = data_low and TX_IPG_LENGTH_TX_IPG_LENGTH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1_value = &H0
        flag_TX_IPG_LENGTH_TX_IPG_LENGTH_RSVD_1        = &H0
        write_TX_IPG_LENGTH_TX_IPG_LENGTH_value = &H0
        flag_TX_IPG_LENGTH_TX_IPG_LENGTH        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_pfc_xoff_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1       [31:16]          get_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
''                                                             set_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
''                                                             read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
''                                                             write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
''---------------------------------------------------------------------------------
'' PFC_XOFF_TIMER_PFC_XOFF_TIMER              [15:0]           get_PFC_XOFF_TIMER_PFC_XOFF_TIMER
''                                                             set_PFC_XOFF_TIMER_PFC_XOFF_TIMER
''                                                             read_PFC_XOFF_TIMER_PFC_XOFF_TIMER
''                                                             write_PFC_XOFF_TIMER_PFC_XOFF_TIMER
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_pfc_xoff_timer
    Private write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value
    Private read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value
    Private flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
    Private write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value
    Private read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value
    Private flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
        get_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1 = read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value
    End Property

    Property Let set_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1(aData)
        write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value = aData
        flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1        = &H1
    End Property

    Property Get read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
        read
        read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1 = read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value
    End Property

    Property Let write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1(aData)
        set_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1 = aData
        write
    End Property

    Property Get get_PFC_XOFF_TIMER_PFC_XOFF_TIMER
        get_PFC_XOFF_TIMER_PFC_XOFF_TIMER = read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value
    End Property

    Property Let set_PFC_XOFF_TIMER_PFC_XOFF_TIMER(aData)
        write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = aData
        flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER        = &H1
    End Property

    Property Get read_PFC_XOFF_TIMER_PFC_XOFF_TIMER
        read
        read_PFC_XOFF_TIMER_PFC_XOFF_TIMER = read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value
    End Property

    Property Let write_PFC_XOFF_TIMER_PFC_XOFF_TIMER(aData)
        set_PFC_XOFF_TIMER_PFC_XOFF_TIMER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask = &Hffff
        if data_low > LONG_MAX then
            if PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask = mask then
                read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = data_low
            else
                read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = (data_low - H8000_0000) and PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask
            end If
        else
            read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = data_low and PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask
        end If

    End Sub

    Sub write
        If flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1 = &H0 or flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER = &H0 Then read
        If flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1 = &H0 Then write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value = get_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1
        If flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER = &H0 Then write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = get_PFC_XOFF_TIMER_PFC_XOFF_TIMER

        regValue = leftShift((write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value and &Hffff), 16) + leftShift((write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask = &Hffff
        if data_low > LONG_MAX then
            if PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask = mask then
                read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = data_low
            else
                read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = (data_low - H8000_0000) and PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask
            end If
        else
            read_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = data_low and PFC_XOFF_TIMER_PFC_XOFF_TIMER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1_value = &H0
        flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER_RSVD_1        = &H0
        write_PFC_XOFF_TIMER_PFC_XOFF_TIMER_value = &H0
        flag_PFC_XOFF_TIMER_PFC_XOFF_TIMER        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_umac_eee_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5         [31:8]           get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
''                                                             set_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
''                                                             read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
''                                                             write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
''---------------------------------------------------------------------------------
'' UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE      [7:7]            get_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
''                                                             set_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
''                                                             read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
''                                                             write_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
''---------------------------------------------------------------------------------
'' UMAC_EEE_CTRL_DIS_EEE_10M                  [6:6]            get_UMAC_EEE_CTRL_DIS_EEE_10M
''                                                             set_UMAC_EEE_CTRL_DIS_EEE_10M
''                                                             read_UMAC_EEE_CTRL_DIS_EEE_10M
''                                                             write_UMAC_EEE_CTRL_DIS_EEE_10M
''---------------------------------------------------------------------------------
'' UMAC_EEE_CTRL_EEE_TXCLK_DIS                [5:5]            get_UMAC_EEE_CTRL_EEE_TXCLK_DIS
''                                                             set_UMAC_EEE_CTRL_EEE_TXCLK_DIS
''                                                             read_UMAC_EEE_CTRL_EEE_TXCLK_DIS
''                                                             write_UMAC_EEE_CTRL_EEE_TXCLK_DIS
''---------------------------------------------------------------------------------
'' UMAC_EEE_CTRL_RX_FIFO_CHECK                [4:4]            get_UMAC_EEE_CTRL_RX_FIFO_CHECK
''                                                             set_UMAC_EEE_CTRL_RX_FIFO_CHECK
''                                                             read_UMAC_EEE_CTRL_RX_FIFO_CHECK
''                                                             write_UMAC_EEE_CTRL_RX_FIFO_CHECK
''---------------------------------------------------------------------------------
'' UMAC_EEE_CTRL_EEE_EN                       [3:3]            get_UMAC_EEE_CTRL_EEE_EN
''                                                             set_UMAC_EEE_CTRL_EEE_EN
''                                                             read_UMAC_EEE_CTRL_EEE_EN
''                                                             write_UMAC_EEE_CTRL_EEE_EN
''---------------------------------------------------------------------------------
'' UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1         [2:0]            get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1
''                                                             set_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1
''                                                             read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1
''                                                             write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_umac_eee_ctrl
    Private write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value
    Private read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value
    Private flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
    Private write_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value
    Private read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value
    Private flag_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
    Private write_UMAC_EEE_CTRL_DIS_EEE_10M_value
    Private read_UMAC_EEE_CTRL_DIS_EEE_10M_value
    Private flag_UMAC_EEE_CTRL_DIS_EEE_10M
    Private write_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value
    Private read_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value
    Private flag_UMAC_EEE_CTRL_EEE_TXCLK_DIS
    Private write_UMAC_EEE_CTRL_RX_FIFO_CHECK_value
    Private read_UMAC_EEE_CTRL_RX_FIFO_CHECK_value
    Private flag_UMAC_EEE_CTRL_RX_FIFO_CHECK
    Private write_UMAC_EEE_CTRL_EEE_EN_value
    Private read_UMAC_EEE_CTRL_EEE_EN_value
    Private flag_UMAC_EEE_CTRL_EEE_EN
    Private write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value
    Private read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value
    Private flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H64
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
        get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5 = read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value
    End Property

    Property Let set_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5(aData)
        write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value = aData
        flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5        = &H1
    End Property

    Property Get read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
        read
        read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5 = read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value
    End Property

    Property Let write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5(aData)
        set_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5 = aData
        write
    End Property

    Property Get get_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
        get_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE = read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value
    End Property

    Property Let set_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE(aData)
        write_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value = aData
        flag_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE        = &H1
    End Property

    Property Get read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
        read
        read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE = read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value
    End Property

    Property Let write_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE(aData)
        set_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE = aData
        write
    End Property

    Property Get get_UMAC_EEE_CTRL_DIS_EEE_10M
        get_UMAC_EEE_CTRL_DIS_EEE_10M = read_UMAC_EEE_CTRL_DIS_EEE_10M_value
    End Property

    Property Let set_UMAC_EEE_CTRL_DIS_EEE_10M(aData)
        write_UMAC_EEE_CTRL_DIS_EEE_10M_value = aData
        flag_UMAC_EEE_CTRL_DIS_EEE_10M        = &H1
    End Property

    Property Get read_UMAC_EEE_CTRL_DIS_EEE_10M
        read
        read_UMAC_EEE_CTRL_DIS_EEE_10M = read_UMAC_EEE_CTRL_DIS_EEE_10M_value
    End Property

    Property Let write_UMAC_EEE_CTRL_DIS_EEE_10M(aData)
        set_UMAC_EEE_CTRL_DIS_EEE_10M = aData
        write
    End Property

    Property Get get_UMAC_EEE_CTRL_EEE_TXCLK_DIS
        get_UMAC_EEE_CTRL_EEE_TXCLK_DIS = read_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value
    End Property

    Property Let set_UMAC_EEE_CTRL_EEE_TXCLK_DIS(aData)
        write_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value = aData
        flag_UMAC_EEE_CTRL_EEE_TXCLK_DIS        = &H1
    End Property

    Property Get read_UMAC_EEE_CTRL_EEE_TXCLK_DIS
        read
        read_UMAC_EEE_CTRL_EEE_TXCLK_DIS = read_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value
    End Property

    Property Let write_UMAC_EEE_CTRL_EEE_TXCLK_DIS(aData)
        set_UMAC_EEE_CTRL_EEE_TXCLK_DIS = aData
        write
    End Property

    Property Get get_UMAC_EEE_CTRL_RX_FIFO_CHECK
        get_UMAC_EEE_CTRL_RX_FIFO_CHECK = read_UMAC_EEE_CTRL_RX_FIFO_CHECK_value
    End Property

    Property Let set_UMAC_EEE_CTRL_RX_FIFO_CHECK(aData)
        write_UMAC_EEE_CTRL_RX_FIFO_CHECK_value = aData
        flag_UMAC_EEE_CTRL_RX_FIFO_CHECK        = &H1
    End Property

    Property Get read_UMAC_EEE_CTRL_RX_FIFO_CHECK
        read
        read_UMAC_EEE_CTRL_RX_FIFO_CHECK = read_UMAC_EEE_CTRL_RX_FIFO_CHECK_value
    End Property

    Property Let write_UMAC_EEE_CTRL_RX_FIFO_CHECK(aData)
        set_UMAC_EEE_CTRL_RX_FIFO_CHECK = aData
        write
    End Property

    Property Get get_UMAC_EEE_CTRL_EEE_EN
        get_UMAC_EEE_CTRL_EEE_EN = read_UMAC_EEE_CTRL_EEE_EN_value
    End Property

    Property Let set_UMAC_EEE_CTRL_EEE_EN(aData)
        write_UMAC_EEE_CTRL_EEE_EN_value = aData
        flag_UMAC_EEE_CTRL_EEE_EN        = &H1
    End Property

    Property Get read_UMAC_EEE_CTRL_EEE_EN
        read
        read_UMAC_EEE_CTRL_EEE_EN = read_UMAC_EEE_CTRL_EEE_EN_value
    End Property

    Property Let write_UMAC_EEE_CTRL_EEE_EN(aData)
        set_UMAC_EEE_CTRL_EEE_EN = aData
        write
    End Property

    Property Get get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1
        get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1 = read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value
    End Property

    Property Let set_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1(aData)
        write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = aData
        flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1        = &H1
    End Property

    Property Get read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1
        read
        read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1 = read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value
    End Property

    Property Let write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1(aData)
        set_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value = rightShift(data_low, 8) and &Hffffff
        read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value = rightShift(data_low, 7) and &H1
        read_UMAC_EEE_CTRL_DIS_EEE_10M_value = rightShift(data_low, 6) and &H1
        read_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value = rightShift(data_low, 5) and &H1
        read_UMAC_EEE_CTRL_RX_FIFO_CHECK_value = rightShift(data_low, 4) and &H1
        read_UMAC_EEE_CTRL_EEE_EN_value = rightShift(data_low, 3) and &H1
        UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask = &H7
        if data_low > LONG_MAX then
            if UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask = mask then
                read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = data_low
            else
                read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = (data_low - H8000_0000) and UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask
            end If
        else
            read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = data_low and UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask
        end If

    End Sub

    Sub write
        If flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5 = &H0 or flag_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE = &H0 or flag_UMAC_EEE_CTRL_DIS_EEE_10M = &H0 or flag_UMAC_EEE_CTRL_EEE_TXCLK_DIS = &H0 or flag_UMAC_EEE_CTRL_RX_FIFO_CHECK = &H0 or flag_UMAC_EEE_CTRL_EEE_EN = &H0 or flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1 = &H0 Then read
        If flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5 = &H0 Then write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value = get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5
        If flag_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE = &H0 Then write_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value = get_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE
        If flag_UMAC_EEE_CTRL_DIS_EEE_10M = &H0 Then write_UMAC_EEE_CTRL_DIS_EEE_10M_value = get_UMAC_EEE_CTRL_DIS_EEE_10M
        If flag_UMAC_EEE_CTRL_EEE_TXCLK_DIS = &H0 Then write_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value = get_UMAC_EEE_CTRL_EEE_TXCLK_DIS
        If flag_UMAC_EEE_CTRL_RX_FIFO_CHECK = &H0 Then write_UMAC_EEE_CTRL_RX_FIFO_CHECK_value = get_UMAC_EEE_CTRL_RX_FIFO_CHECK
        If flag_UMAC_EEE_CTRL_EEE_EN = &H0 Then write_UMAC_EEE_CTRL_EEE_EN_value = get_UMAC_EEE_CTRL_EEE_EN
        If flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1 = &H0 Then write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = get_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1

        regValue = leftShift((write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value and &Hffffff), 8) + leftShift((write_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value and &H1), 7) + leftShift((write_UMAC_EEE_CTRL_DIS_EEE_10M_value and &H1), 6) + leftShift((write_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value and &H1), 5) + leftShift((write_UMAC_EEE_CTRL_RX_FIFO_CHECK_value and &H1), 4) + leftShift((write_UMAC_EEE_CTRL_EEE_EN_value and &H1), 3) + leftShift((write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value = rightShift(data_low, 8) and &Hffffff
        read_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value = rightShift(data_low, 7) and &H1
        read_UMAC_EEE_CTRL_DIS_EEE_10M_value = rightShift(data_low, 6) and &H1
        read_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value = rightShift(data_low, 5) and &H1
        read_UMAC_EEE_CTRL_RX_FIFO_CHECK_value = rightShift(data_low, 4) and &H1
        read_UMAC_EEE_CTRL_EEE_EN_value = rightShift(data_low, 3) and &H1
        UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask = &H7
        if data_low > LONG_MAX then
            if UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask = mask then
                read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = data_low
            else
                read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = (data_low - H8000_0000) and UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask
            end If
        else
            read_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = data_low and UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5_value = &H0
        flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_5        = &H0
        write_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE_value = &H0
        flag_UMAC_EEE_CTRL_LP_IDLE_PREDICTION_MODE        = &H0
        write_UMAC_EEE_CTRL_DIS_EEE_10M_value = &H0
        flag_UMAC_EEE_CTRL_DIS_EEE_10M        = &H0
        write_UMAC_EEE_CTRL_EEE_TXCLK_DIS_value = &H0
        flag_UMAC_EEE_CTRL_EEE_TXCLK_DIS        = &H0
        write_UMAC_EEE_CTRL_RX_FIFO_CHECK_value = &H0
        flag_UMAC_EEE_CTRL_RX_FIFO_CHECK        = &H0
        write_UMAC_EEE_CTRL_EEE_EN_value = &H0
        flag_UMAC_EEE_CTRL_EEE_EN        = &H0
        write_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1_value = &H0
        flag_UMAC_EEE_CTRL_UMAC_EEE_CTRL_RSVD_1        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mii_eee_delay_entry_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MEDETMELT                                  [31:0]           get_MEDETMELT
''                                                             set_MEDETMELT
''                                                             read_MEDETMELT
''                                                             write_MEDETMELT
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mii_eee_delay_entry_timer
    Private write_MEDETMELT_value
    Private read_MEDETMELT_value
    Private flag_MEDETMELT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H68
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MEDETMELT
        get_MEDETMELT = read_MEDETMELT_value
    End Property

    Property Let set_MEDETMELT(aData)
        write_MEDETMELT_value = aData
        flag_MEDETMELT        = &H1
    End Property

    Property Get read_MEDETMELT
        read
        read_MEDETMELT = read_MEDETMELT_value
    End Property

    Property Let write_MEDETMELT(aData)
        set_MEDETMELT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MEDETMELT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MEDETMELT_mask = mask then
                read_MEDETMELT_value = data_low
            else
                read_MEDETMELT_value = (data_low - H8000_0000) and MEDETMELT_mask
            end If
        else
            read_MEDETMELT_value = data_low and MEDETMELT_mask
        end If

    End Sub

    Sub write
        If flag_MEDETMELT = &H0 Then read
        If flag_MEDETMELT = &H0 Then write_MEDETMELT_value = get_MEDETMELT

        regValue = leftShift(write_MEDETMELT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MEDETMELT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MEDETMELT_mask = mask then
                read_MEDETMELT_value = data_low
            else
                read_MEDETMELT_value = (data_low - H8000_0000) and MEDETMELT_mask
            end If
        else
            read_MEDETMELT_value = data_low and MEDETMELT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MEDETMELT_value = &H0
        flag_MEDETMELT        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_gmii_eee_delay_entry_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GEDETGELT                                  [31:0]           get_GEDETGELT
''                                                             set_GEDETGELT
''                                                             read_GEDETGELT
''                                                             write_GEDETGELT
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_gmii_eee_delay_entry_timer
    Private write_GEDETGELT_value
    Private read_GEDETGELT_value
    Private flag_GEDETGELT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_GEDETGELT
        get_GEDETGELT = read_GEDETGELT_value
    End Property

    Property Let set_GEDETGELT(aData)
        write_GEDETGELT_value = aData
        flag_GEDETGELT        = &H1
    End Property

    Property Get read_GEDETGELT
        read
        read_GEDETGELT = read_GEDETGELT_value
    End Property

    Property Let write_GEDETGELT(aData)
        set_GEDETGELT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GEDETGELT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if GEDETGELT_mask = mask then
                read_GEDETGELT_value = data_low
            else
                read_GEDETGELT_value = (data_low - H8000_0000) and GEDETGELT_mask
            end If
        else
            read_GEDETGELT_value = data_low and GEDETGELT_mask
        end If

    End Sub

    Sub write
        If flag_GEDETGELT = &H0 Then read
        If flag_GEDETGELT = &H0 Then write_GEDETGELT_value = get_GEDETGELT

        regValue = leftShift(write_GEDETGELT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GEDETGELT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if GEDETGELT_mask = mask then
                read_GEDETGELT_value = data_low
            else
                read_GEDETGELT_value = (data_low - H8000_0000) and GEDETGELT_mask
            end If
        else
            read_GEDETGELT_value = data_low and GEDETGELT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GEDETGELT_value = &H0
        flag_GEDETGELT        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_umac_eee_ref_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UERCUERCR1                                 [31:16]          get_UERCUERCR1
''                                                             set_UERCUERCR1
''                                                             read_UERCUERCR1
''                                                             write_UERCUERCR1
''---------------------------------------------------------------------------------
'' UMAC_EEE_REF_COUNT_EEE_REF_COUNT           [15:0]           get_UMAC_EEE_REF_COUNT_EEE_REF_COUNT
''                                                             set_UMAC_EEE_REF_COUNT_EEE_REF_COUNT
''                                                             read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT
''                                                             write_UMAC_EEE_REF_COUNT_EEE_REF_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_umac_eee_ref_count
    Private write_UERCUERCR1_value
    Private read_UERCUERCR1_value
    Private flag_UERCUERCR1
    Private write_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value
    Private read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value
    Private flag_UMAC_EEE_REF_COUNT_EEE_REF_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H70
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UERCUERCR1
        get_UERCUERCR1 = read_UERCUERCR1_value
    End Property

    Property Let set_UERCUERCR1(aData)
        write_UERCUERCR1_value = aData
        flag_UERCUERCR1        = &H1
    End Property

    Property Get read_UERCUERCR1
        read
        read_UERCUERCR1 = read_UERCUERCR1_value
    End Property

    Property Let write_UERCUERCR1(aData)
        set_UERCUERCR1 = aData
        write
    End Property

    Property Get get_UMAC_EEE_REF_COUNT_EEE_REF_COUNT
        get_UMAC_EEE_REF_COUNT_EEE_REF_COUNT = read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value
    End Property

    Property Let set_UMAC_EEE_REF_COUNT_EEE_REF_COUNT(aData)
        write_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = aData
        flag_UMAC_EEE_REF_COUNT_EEE_REF_COUNT        = &H1
    End Property

    Property Get read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT
        read
        read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT = read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value
    End Property

    Property Let write_UMAC_EEE_REF_COUNT_EEE_REF_COUNT(aData)
        set_UMAC_EEE_REF_COUNT_EEE_REF_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_UERCUERCR1_value = rightShift(data_low, 16) and &Hffff
        UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask = mask then
                read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = data_low
            else
                read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = (data_low - H8000_0000) and UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask
            end If
        else
            read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = data_low and UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_UERCUERCR1 = &H0 or flag_UMAC_EEE_REF_COUNT_EEE_REF_COUNT = &H0 Then read
        If flag_UERCUERCR1 = &H0 Then write_UERCUERCR1_value = get_UERCUERCR1
        If flag_UMAC_EEE_REF_COUNT_EEE_REF_COUNT = &H0 Then write_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = get_UMAC_EEE_REF_COUNT_EEE_REF_COUNT

        regValue = leftShift((write_UERCUERCR1_value and &Hffff), 16) + leftShift((write_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_UERCUERCR1_value = rightShift(data_low, 16) and &Hffff
        UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask = &Hffff
        if data_low > LONG_MAX then
            if UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask = mask then
                read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = data_low
            else
                read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = (data_low - H8000_0000) and UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask
            end If
        else
            read_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = data_low and UMAC_EEE_REF_COUNT_EEE_REF_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UERCUERCR1_value = &H0
        flag_UERCUERCR1        = &H0
        write_UMAC_EEE_REF_COUNT_EEE_REF_COUNT_value = &H0
        flag_UMAC_EEE_REF_COUNT_EEE_REF_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_umac_timestamp_adjust
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD     [31:11]          get_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
''                                                             set_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
''                                                             read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
''                                                             write_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
''---------------------------------------------------------------------------------
'' AUTO_ADJUST                                [10:10]          get_AUTO_ADJUST
''                                                             set_AUTO_ADJUST
''                                                             read_AUTO_ADJUST
''                                                             write_AUTO_ADJUST
''---------------------------------------------------------------------------------
'' EN_1588                                    [9:9]            get_EN_1588
''                                                             set_EN_1588
''                                                             read_EN_1588
''                                                             write_EN_1588
''---------------------------------------------------------------------------------
'' ADJUST                                     [8:0]            get_ADJUST
''                                                             set_ADJUST
''                                                             read_ADJUST
''                                                             write_ADJUST
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_umac_timestamp_adjust
    Private write_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value
    Private read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value
    Private flag_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
    Private write_AUTO_ADJUST_value
    Private read_AUTO_ADJUST_value
    Private flag_AUTO_ADJUST
    Private write_EN_1588_value
    Private read_EN_1588_value
    Private flag_EN_1588
    Private write_ADJUST_value
    Private read_ADJUST_value
    Private flag_ADJUST

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H74
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
        get_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD = read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value
    End Property

    Property Let set_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD(aData)
        write_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value = aData
        flag_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD        = &H1
    End Property

    Property Get read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
        read
        read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD = read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value
    End Property

    Property Let write_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD(aData)
        set_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD = aData
        write
    End Property

    Property Get get_AUTO_ADJUST
        get_AUTO_ADJUST = read_AUTO_ADJUST_value
    End Property

    Property Let set_AUTO_ADJUST(aData)
        write_AUTO_ADJUST_value = aData
        flag_AUTO_ADJUST        = &H1
    End Property

    Property Get read_AUTO_ADJUST
        read
        read_AUTO_ADJUST = read_AUTO_ADJUST_value
    End Property

    Property Let write_AUTO_ADJUST(aData)
        set_AUTO_ADJUST = aData
        write
    End Property

    Property Get get_EN_1588
        get_EN_1588 = read_EN_1588_value
    End Property

    Property Let set_EN_1588(aData)
        write_EN_1588_value = aData
        flag_EN_1588        = &H1
    End Property

    Property Get read_EN_1588
        read
        read_EN_1588 = read_EN_1588_value
    End Property

    Property Let write_EN_1588(aData)
        set_EN_1588 = aData
        write
    End Property

    Property Get get_ADJUST
        get_ADJUST = read_ADJUST_value
    End Property

    Property Let set_ADJUST(aData)
        write_ADJUST_value = aData
        flag_ADJUST        = &H1
    End Property

    Property Get read_ADJUST
        read
        read_ADJUST = read_ADJUST_value
    End Property

    Property Let write_ADJUST(aData)
        set_ADJUST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value = rightShift(data_low, 11) and &H1fffff
        read_AUTO_ADJUST_value = rightShift(data_low, 10) and &H1
        read_EN_1588_value = rightShift(data_low, 9) and &H1
        ADJUST_mask = &H1ff
        if data_low > LONG_MAX then
            if ADJUST_mask = mask then
                read_ADJUST_value = data_low
            else
                read_ADJUST_value = (data_low - H8000_0000) and ADJUST_mask
            end If
        else
            read_ADJUST_value = data_low and ADJUST_mask
        end If

    End Sub

    Sub write
        If flag_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD = &H0 or flag_AUTO_ADJUST = &H0 or flag_EN_1588 = &H0 or flag_ADJUST = &H0 Then read
        If flag_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD = &H0 Then write_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value = get_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD
        If flag_AUTO_ADJUST = &H0 Then write_AUTO_ADJUST_value = get_AUTO_ADJUST
        If flag_EN_1588 = &H0 Then write_EN_1588_value = get_EN_1588
        If flag_ADJUST = &H0 Then write_ADJUST_value = get_ADJUST

        regValue = leftShift((write_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value and &H1fffff), 11) + leftShift((write_AUTO_ADJUST_value and &H1), 10) + leftShift((write_EN_1588_value and &H1), 9) + leftShift((write_ADJUST_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value = rightShift(data_low, 11) and &H1fffff
        read_AUTO_ADJUST_value = rightShift(data_low, 10) and &H1
        read_EN_1588_value = rightShift(data_low, 9) and &H1
        ADJUST_mask = &H1ff
        if data_low > LONG_MAX then
            if ADJUST_mask = mask then
                read_ADJUST_value = data_low
            else
                read_ADJUST_value = (data_low - H8000_0000) and ADJUST_mask
            end If
        else
            read_ADJUST_value = data_low and ADJUST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD_value = &H0
        flag_LINE_UNIMAC_UMAC_TIMESTAMP_ADJUST_RSVD        = &H0
        write_AUTO_ADJUST_value = &H0
        flag_AUTO_ADJUST        = &H0
        write_EN_1588_value = &H0
        flag_EN_1588        = &H0
        write_ADJUST_value = &H0
        flag_ADJUST        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_umac_rx_pkt_drop_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' URPDSURPDSR1                               [31:1]           get_URPDSURPDSR1
''                                                             set_URPDSURPDSR1
''                                                             read_URPDSURPDSR1
''                                                             write_URPDSURPDSR1
''---------------------------------------------------------------------------------
'' UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL       [0:0]            get_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL
''                                                             set_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL
''                                                             read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL
''                                                             write_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_umac_rx_pkt_drop_status
    Private write_URPDSURPDSR1_value
    Private read_URPDSURPDSR1_value
    Private flag_URPDSURPDSR1
    Private write_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value
    Private read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value
    Private flag_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_URPDSURPDSR1
        get_URPDSURPDSR1 = read_URPDSURPDSR1_value
    End Property

    Property Let set_URPDSURPDSR1(aData)
        write_URPDSURPDSR1_value = aData
        flag_URPDSURPDSR1        = &H1
    End Property

    Property Get read_URPDSURPDSR1
        read
        read_URPDSURPDSR1 = read_URPDSURPDSR1_value
    End Property

    Property Let write_URPDSURPDSR1(aData)
        set_URPDSURPDSR1 = aData
        write
    End Property

    Property Get get_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL
        get_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL = read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value
    End Property

    Property Let set_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL(aData)
        write_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = aData
        flag_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL        = &H1
    End Property

    Property Get read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL
        read
        read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL = read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value
    End Property

    Property Let write_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL(aData)
        set_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_URPDSURPDSR1_value = rightShift(data_low, 1) and &H7fffffff
        UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask = &H1
        if data_low > LONG_MAX then
            if UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask = mask then
                read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = data_low
            else
                read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = (data_low - H8000_0000) and UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask
            end If
        else
            read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = data_low and UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask
        end If

    End Sub

    Sub write
        If flag_URPDSURPDSR1 = &H0 or flag_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL = &H0 Then read
        If flag_URPDSURPDSR1 = &H0 Then write_URPDSURPDSR1_value = get_URPDSURPDSR1
        If flag_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL = &H0 Then write_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = get_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL

        regValue = leftShift((write_URPDSURPDSR1_value and &H7fffffff), 1) + leftShift((write_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_URPDSURPDSR1_value = rightShift(data_low, 1) and &H7fffffff
        UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask = &H1
        if data_low > LONG_MAX then
            if UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask = mask then
                read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = data_low
            else
                read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = (data_low - H8000_0000) and UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask
            end If
        else
            read_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = data_low and UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_URPDSURPDSR1_value = &H0
        flag_URPDSURPDSR1        = &H0
        write_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL_value = &H0
        flag_UMAC_RX_PKT_DROP_STATUS_RX_IPG_INVAL        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_umac_symmetric_idle_threshold
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' USITUSITR1                                 [31:16]          get_USITUSITR1
''                                                             set_USITUSITR1
''                                                             read_USITUSITR1
''                                                             write_USITUSITR1
''---------------------------------------------------------------------------------
'' USITTV                                     [15:0]           get_USITTV
''                                                             set_USITTV
''                                                             read_USITTV
''                                                             write_USITTV
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_umac_symmetric_idle_threshold
    Private write_USITUSITR1_value
    Private read_USITUSITR1_value
    Private flag_USITUSITR1
    Private write_USITTV_value
    Private read_USITTV_value
    Private flag_USITTV

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_USITUSITR1
        get_USITUSITR1 = read_USITUSITR1_value
    End Property

    Property Let set_USITUSITR1(aData)
        write_USITUSITR1_value = aData
        flag_USITUSITR1        = &H1
    End Property

    Property Get read_USITUSITR1
        read
        read_USITUSITR1 = read_USITUSITR1_value
    End Property

    Property Let write_USITUSITR1(aData)
        set_USITUSITR1 = aData
        write
    End Property

    Property Get get_USITTV
        get_USITTV = read_USITTV_value
    End Property

    Property Let set_USITTV(aData)
        write_USITTV_value = aData
        flag_USITTV        = &H1
    End Property

    Property Get read_USITTV
        read
        read_USITTV = read_USITTV_value
    End Property

    Property Let write_USITTV(aData)
        set_USITTV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_USITUSITR1_value = rightShift(data_low, 16) and &Hffff
        USITTV_mask = &Hffff
        if data_low > LONG_MAX then
            if USITTV_mask = mask then
                read_USITTV_value = data_low
            else
                read_USITTV_value = (data_low - H8000_0000) and USITTV_mask
            end If
        else
            read_USITTV_value = data_low and USITTV_mask
        end If

    End Sub

    Sub write
        If flag_USITUSITR1 = &H0 or flag_USITTV = &H0 Then read
        If flag_USITUSITR1 = &H0 Then write_USITUSITR1_value = get_USITUSITR1
        If flag_USITTV = &H0 Then write_USITTV_value = get_USITTV

        regValue = leftShift((write_USITUSITR1_value and &Hffff), 16) + leftShift((write_USITTV_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_USITUSITR1_value = rightShift(data_low, 16) and &Hffff
        USITTV_mask = &Hffff
        if data_low > LONG_MAX then
            if USITTV_mask = mask then
                read_USITTV_value = data_low
            else
                read_USITTV_value = (data_low - H8000_0000) and USITTV_mask
            end If
        else
            read_USITTV_value = data_low and USITTV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_USITUSITR1_value = &H0
        flag_USITUSITR1        = &H0
        write_USITTV_value = &H0
        flag_USITTV        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mii_eee_wake_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MEWTMEWTR1                                 [31:16]          get_MEWTMEWTR1
''                                                             set_MEWTMEWTR1
''                                                             read_MEWTMEWTR1
''                                                             write_MEWTMEWTR1
''---------------------------------------------------------------------------------
'' MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER      [15:0]           get_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER
''                                                             set_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER
''                                                             read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER
''                                                             write_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mii_eee_wake_timer
    Private write_MEWTMEWTR1_value
    Private read_MEWTMEWTR1_value
    Private flag_MEWTMEWTR1
    Private write_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value
    Private read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value
    Private flag_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER

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

    Property Get get_MEWTMEWTR1
        get_MEWTMEWTR1 = read_MEWTMEWTR1_value
    End Property

    Property Let set_MEWTMEWTR1(aData)
        write_MEWTMEWTR1_value = aData
        flag_MEWTMEWTR1        = &H1
    End Property

    Property Get read_MEWTMEWTR1
        read
        read_MEWTMEWTR1 = read_MEWTMEWTR1_value
    End Property

    Property Let write_MEWTMEWTR1(aData)
        set_MEWTMEWTR1 = aData
        write
    End Property

    Property Get get_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER
        get_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER = read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value
    End Property

    Property Let set_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER(aData)
        write_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = aData
        flag_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER        = &H1
    End Property

    Property Get read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER
        read
        read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER = read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value
    End Property

    Property Let write_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER(aData)
        set_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MEWTMEWTR1_value = rightShift(data_low, 16) and &Hffff
        MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask = &Hffff
        if data_low > LONG_MAX then
            if MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask = mask then
                read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = data_low
            else
                read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = (data_low - H8000_0000) and MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask
            end If
        else
            read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = data_low and MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask
        end If

    End Sub

    Sub write
        If flag_MEWTMEWTR1 = &H0 or flag_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER = &H0 Then read
        If flag_MEWTMEWTR1 = &H0 Then write_MEWTMEWTR1_value = get_MEWTMEWTR1
        If flag_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER = &H0 Then write_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = get_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER

        regValue = leftShift((write_MEWTMEWTR1_value and &Hffff), 16) + leftShift((write_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MEWTMEWTR1_value = rightShift(data_low, 16) and &Hffff
        MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask = &Hffff
        if data_low > LONG_MAX then
            if MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask = mask then
                read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = data_low
            else
                read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = (data_low - H8000_0000) and MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask
            end If
        else
            read_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = data_low and MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MEWTMEWTR1_value = &H0
        flag_MEWTMEWTR1        = &H0
        write_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER_value = &H0
        flag_MII_EEE_WAKE_TIMER_MII_EEE_WAKE_TIMER        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_gmii_eee_wake_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GEWTGEWTR1                                 [31:16]          get_GEWTGEWTR1
''                                                             set_GEWTGEWTR1
''                                                             read_GEWTGEWTR1
''                                                             write_GEWTGEWTR1
''---------------------------------------------------------------------------------
'' GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER    [15:0]           get_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER
''                                                             set_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER
''                                                             read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER
''                                                             write_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_gmii_eee_wake_timer
    Private write_GEWTGEWTR1_value
    Private read_GEWTGEWTR1_value
    Private flag_GEWTGEWTR1
    Private write_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value
    Private read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value
    Private flag_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER

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

    Property Get get_GEWTGEWTR1
        get_GEWTGEWTR1 = read_GEWTGEWTR1_value
    End Property

    Property Let set_GEWTGEWTR1(aData)
        write_GEWTGEWTR1_value = aData
        flag_GEWTGEWTR1        = &H1
    End Property

    Property Get read_GEWTGEWTR1
        read
        read_GEWTGEWTR1 = read_GEWTGEWTR1_value
    End Property

    Property Let write_GEWTGEWTR1(aData)
        set_GEWTGEWTR1 = aData
        write
    End Property

    Property Get get_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER
        get_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER = read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value
    End Property

    Property Let set_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER(aData)
        write_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = aData
        flag_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER        = &H1
    End Property

    Property Get read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER
        read
        read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER = read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value
    End Property

    Property Let write_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER(aData)
        set_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GEWTGEWTR1_value = rightShift(data_low, 16) and &Hffff
        GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask = mask then
                read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = data_low
            else
                read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = (data_low - H8000_0000) and GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask
            end If
        else
            read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = data_low and GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask
        end If

    End Sub

    Sub write
        If flag_GEWTGEWTR1 = &H0 or flag_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER = &H0 Then read
        If flag_GEWTGEWTR1 = &H0 Then write_GEWTGEWTR1_value = get_GEWTGEWTR1
        If flag_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER = &H0 Then write_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = get_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER

        regValue = leftShift((write_GEWTGEWTR1_value and &Hffff), 16) + leftShift((write_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_GEWTGEWTR1_value = rightShift(data_low, 16) and &Hffff
        GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask = mask then
                read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = data_low
            else
                read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = (data_low - H8000_0000) and GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask
            end If
        else
            read_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = data_low and GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GEWTGEWTR1_value = &H0
        flag_GEWTGEWTR1        = &H0
        write_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER_value = &H0
        flag_GMII_EEE_WAKE_TIMER_GMII_EEE_WAKE_TIMER        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_umac_rev_id
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UMAC_REV_ID_UMAC_REV_ID_RSVD_3             [31:24]          get_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
''                                                             set_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
''                                                             read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
''                                                             write_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
''---------------------------------------------------------------------------------
'' UMAC_REV_ID_REVISION_ID_MAJOR              [23:16]          get_UMAC_REV_ID_REVISION_ID_MAJOR
''                                                             set_UMAC_REV_ID_REVISION_ID_MAJOR
''                                                             read_UMAC_REV_ID_REVISION_ID_MAJOR
''                                                             write_UMAC_REV_ID_REVISION_ID_MAJOR
''---------------------------------------------------------------------------------
'' UMAC_REV_ID_REVISION_ID_MINOR              [15:8]           get_UMAC_REV_ID_REVISION_ID_MINOR
''                                                             set_UMAC_REV_ID_REVISION_ID_MINOR
''                                                             read_UMAC_REV_ID_REVISION_ID_MINOR
''                                                             write_UMAC_REV_ID_REVISION_ID_MINOR
''---------------------------------------------------------------------------------
'' UMAC_REV_ID_PATCH                          [7:0]            get_UMAC_REV_ID_PATCH
''                                                             set_UMAC_REV_ID_PATCH
''                                                             read_UMAC_REV_ID_PATCH
''                                                             write_UMAC_REV_ID_PATCH
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_umac_rev_id
    Private write_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value
    Private read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value
    Private flag_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
    Private write_UMAC_REV_ID_REVISION_ID_MAJOR_value
    Private read_UMAC_REV_ID_REVISION_ID_MAJOR_value
    Private flag_UMAC_REV_ID_REVISION_ID_MAJOR
    Private write_UMAC_REV_ID_REVISION_ID_MINOR_value
    Private read_UMAC_REV_ID_REVISION_ID_MINOR_value
    Private flag_UMAC_REV_ID_REVISION_ID_MINOR
    Private write_UMAC_REV_ID_PATCH_value
    Private read_UMAC_REV_ID_PATCH_value
    Private flag_UMAC_REV_ID_PATCH

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
        get_UMAC_REV_ID_UMAC_REV_ID_RSVD_3 = read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value
    End Property

    Property Let set_UMAC_REV_ID_UMAC_REV_ID_RSVD_3(aData)
        write_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value = aData
        flag_UMAC_REV_ID_UMAC_REV_ID_RSVD_3        = &H1
    End Property

    Property Get read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
        read
        read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3 = read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value
    End Property

    Property Let write_UMAC_REV_ID_UMAC_REV_ID_RSVD_3(aData)
        set_UMAC_REV_ID_UMAC_REV_ID_RSVD_3 = aData
        write
    End Property

    Property Get get_UMAC_REV_ID_REVISION_ID_MAJOR
        get_UMAC_REV_ID_REVISION_ID_MAJOR = read_UMAC_REV_ID_REVISION_ID_MAJOR_value
    End Property

    Property Let set_UMAC_REV_ID_REVISION_ID_MAJOR(aData)
        write_UMAC_REV_ID_REVISION_ID_MAJOR_value = aData
        flag_UMAC_REV_ID_REVISION_ID_MAJOR        = &H1
    End Property

    Property Get read_UMAC_REV_ID_REVISION_ID_MAJOR
        read
        read_UMAC_REV_ID_REVISION_ID_MAJOR = read_UMAC_REV_ID_REVISION_ID_MAJOR_value
    End Property

    Property Let write_UMAC_REV_ID_REVISION_ID_MAJOR(aData)
        set_UMAC_REV_ID_REVISION_ID_MAJOR = aData
        write
    End Property

    Property Get get_UMAC_REV_ID_REVISION_ID_MINOR
        get_UMAC_REV_ID_REVISION_ID_MINOR = read_UMAC_REV_ID_REVISION_ID_MINOR_value
    End Property

    Property Let set_UMAC_REV_ID_REVISION_ID_MINOR(aData)
        write_UMAC_REV_ID_REVISION_ID_MINOR_value = aData
        flag_UMAC_REV_ID_REVISION_ID_MINOR        = &H1
    End Property

    Property Get read_UMAC_REV_ID_REVISION_ID_MINOR
        read
        read_UMAC_REV_ID_REVISION_ID_MINOR = read_UMAC_REV_ID_REVISION_ID_MINOR_value
    End Property

    Property Let write_UMAC_REV_ID_REVISION_ID_MINOR(aData)
        set_UMAC_REV_ID_REVISION_ID_MINOR = aData
        write
    End Property

    Property Get get_UMAC_REV_ID_PATCH
        get_UMAC_REV_ID_PATCH = read_UMAC_REV_ID_PATCH_value
    End Property

    Property Let set_UMAC_REV_ID_PATCH(aData)
        write_UMAC_REV_ID_PATCH_value = aData
        flag_UMAC_REV_ID_PATCH        = &H1
    End Property

    Property Get read_UMAC_REV_ID_PATCH
        read
        read_UMAC_REV_ID_PATCH = read_UMAC_REV_ID_PATCH_value
    End Property

    Property Let write_UMAC_REV_ID_PATCH(aData)
        set_UMAC_REV_ID_PATCH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value = rightShift(data_low, 24) and &Hff
        read_UMAC_REV_ID_REVISION_ID_MAJOR_value = rightShift(data_low, 16) and &Hff
        read_UMAC_REV_ID_REVISION_ID_MINOR_value = rightShift(data_low, 8) and &Hff
        UMAC_REV_ID_PATCH_mask = &Hff
        if data_low > LONG_MAX then
            if UMAC_REV_ID_PATCH_mask = mask then
                read_UMAC_REV_ID_PATCH_value = data_low
            else
                read_UMAC_REV_ID_PATCH_value = (data_low - H8000_0000) and UMAC_REV_ID_PATCH_mask
            end If
        else
            read_UMAC_REV_ID_PATCH_value = data_low and UMAC_REV_ID_PATCH_mask
        end If

    End Sub

    Sub write
        If flag_UMAC_REV_ID_UMAC_REV_ID_RSVD_3 = &H0 or flag_UMAC_REV_ID_REVISION_ID_MAJOR = &H0 or flag_UMAC_REV_ID_REVISION_ID_MINOR = &H0 or flag_UMAC_REV_ID_PATCH = &H0 Then read
        If flag_UMAC_REV_ID_UMAC_REV_ID_RSVD_3 = &H0 Then write_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value = get_UMAC_REV_ID_UMAC_REV_ID_RSVD_3
        If flag_UMAC_REV_ID_REVISION_ID_MAJOR = &H0 Then write_UMAC_REV_ID_REVISION_ID_MAJOR_value = get_UMAC_REV_ID_REVISION_ID_MAJOR
        If flag_UMAC_REV_ID_REVISION_ID_MINOR = &H0 Then write_UMAC_REV_ID_REVISION_ID_MINOR_value = get_UMAC_REV_ID_REVISION_ID_MINOR
        If flag_UMAC_REV_ID_PATCH = &H0 Then write_UMAC_REV_ID_PATCH_value = get_UMAC_REV_ID_PATCH

        regValue = leftShift((write_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value and &Hff), 24) + leftShift((write_UMAC_REV_ID_REVISION_ID_MAJOR_value and &Hff), 16) + leftShift((write_UMAC_REV_ID_REVISION_ID_MINOR_value and &Hff), 8) + leftShift((write_UMAC_REV_ID_PATCH_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value = rightShift(data_low, 24) and &Hff
        read_UMAC_REV_ID_REVISION_ID_MAJOR_value = rightShift(data_low, 16) and &Hff
        read_UMAC_REV_ID_REVISION_ID_MINOR_value = rightShift(data_low, 8) and &Hff
        UMAC_REV_ID_PATCH_mask = &Hff
        if data_low > LONG_MAX then
            if UMAC_REV_ID_PATCH_mask = mask then
                read_UMAC_REV_ID_PATCH_value = data_low
            else
                read_UMAC_REV_ID_PATCH_value = (data_low - H8000_0000) and UMAC_REV_ID_PATCH_mask
            end If
        else
            read_UMAC_REV_ID_PATCH_value = data_low and UMAC_REV_ID_PATCH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UMAC_REV_ID_UMAC_REV_ID_RSVD_3_value = &H0
        flag_UMAC_REV_ID_UMAC_REV_ID_RSVD_3        = &H0
        write_UMAC_REV_ID_REVISION_ID_MAJOR_value = &H0
        flag_UMAC_REV_ID_REVISION_ID_MAJOR        = &H0
        write_UMAC_REV_ID_REVISION_ID_MINOR_value = &H0
        flag_UMAC_REV_ID_REVISION_ID_MINOR        = &H0
        write_UMAC_REV_ID_PATCH_value = &H0
        flag_UMAC_REV_ID_PATCH        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_pfc_type
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1           [31:16]          get_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
''                                                             set_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
''                                                             read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
''                                                             write_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
''---------------------------------------------------------------------------------
'' MAC_PFC_TYPE_PFC_ETH_TYPE                  [15:0]           get_MAC_PFC_TYPE_PFC_ETH_TYPE
''                                                             set_MAC_PFC_TYPE_PFC_ETH_TYPE
''                                                             read_MAC_PFC_TYPE_PFC_ETH_TYPE
''                                                             write_MAC_PFC_TYPE_PFC_ETH_TYPE
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_pfc_type
    Private write_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value
    Private read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value
    Private flag_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
    Private write_MAC_PFC_TYPE_PFC_ETH_TYPE_value
    Private read_MAC_PFC_TYPE_PFC_ETH_TYPE_value
    Private flag_MAC_PFC_TYPE_PFC_ETH_TYPE

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

    Property Get get_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
        get_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1 = read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value
    End Property

    Property Let set_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1(aData)
        write_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value = aData
        flag_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1        = &H1
    End Property

    Property Get read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
        read
        read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1 = read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value
    End Property

    Property Let write_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1(aData)
        set_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1 = aData
        write
    End Property

    Property Get get_MAC_PFC_TYPE_PFC_ETH_TYPE
        get_MAC_PFC_TYPE_PFC_ETH_TYPE = read_MAC_PFC_TYPE_PFC_ETH_TYPE_value
    End Property

    Property Let set_MAC_PFC_TYPE_PFC_ETH_TYPE(aData)
        write_MAC_PFC_TYPE_PFC_ETH_TYPE_value = aData
        flag_MAC_PFC_TYPE_PFC_ETH_TYPE        = &H1
    End Property

    Property Get read_MAC_PFC_TYPE_PFC_ETH_TYPE
        read
        read_MAC_PFC_TYPE_PFC_ETH_TYPE = read_MAC_PFC_TYPE_PFC_ETH_TYPE_value
    End Property

    Property Let write_MAC_PFC_TYPE_PFC_ETH_TYPE(aData)
        set_MAC_PFC_TYPE_PFC_ETH_TYPE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_PFC_TYPE_PFC_ETH_TYPE_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_PFC_TYPE_PFC_ETH_TYPE_mask = mask then
                read_MAC_PFC_TYPE_PFC_ETH_TYPE_value = data_low
            else
                read_MAC_PFC_TYPE_PFC_ETH_TYPE_value = (data_low - H8000_0000) and MAC_PFC_TYPE_PFC_ETH_TYPE_mask
            end If
        else
            read_MAC_PFC_TYPE_PFC_ETH_TYPE_value = data_low and MAC_PFC_TYPE_PFC_ETH_TYPE_mask
        end If

    End Sub

    Sub write
        If flag_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1 = &H0 or flag_MAC_PFC_TYPE_PFC_ETH_TYPE = &H0 Then read
        If flag_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1 = &H0 Then write_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value = get_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1
        If flag_MAC_PFC_TYPE_PFC_ETH_TYPE = &H0 Then write_MAC_PFC_TYPE_PFC_ETH_TYPE_value = get_MAC_PFC_TYPE_PFC_ETH_TYPE

        regValue = leftShift((write_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value and &Hffff), 16) + leftShift((write_MAC_PFC_TYPE_PFC_ETH_TYPE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_PFC_TYPE_PFC_ETH_TYPE_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_PFC_TYPE_PFC_ETH_TYPE_mask = mask then
                read_MAC_PFC_TYPE_PFC_ETH_TYPE_value = data_low
            else
                read_MAC_PFC_TYPE_PFC_ETH_TYPE_value = (data_low - H8000_0000) and MAC_PFC_TYPE_PFC_ETH_TYPE_mask
            end If
        else
            read_MAC_PFC_TYPE_PFC_ETH_TYPE_value = data_low and MAC_PFC_TYPE_PFC_ETH_TYPE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1_value = &H0
        flag_MAC_PFC_TYPE_MAC_PFC_TYPE_RSVD_1        = &H0
        write_MAC_PFC_TYPE_PFC_ETH_TYPE_value = &H0
        flag_MAC_PFC_TYPE_PFC_ETH_TYPE        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_pfc_opcode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1       [31:16]          get_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
''                                                             set_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
''                                                             read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
''                                                             write_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
''---------------------------------------------------------------------------------
'' MAC_PFC_OPCODE_PFC_OPCODE                  [15:0]           get_MAC_PFC_OPCODE_PFC_OPCODE
''                                                             set_MAC_PFC_OPCODE_PFC_OPCODE
''                                                             read_MAC_PFC_OPCODE_PFC_OPCODE
''                                                             write_MAC_PFC_OPCODE_PFC_OPCODE
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_pfc_opcode
    Private write_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value
    Private read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value
    Private flag_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
    Private write_MAC_PFC_OPCODE_PFC_OPCODE_value
    Private read_MAC_PFC_OPCODE_PFC_OPCODE_value
    Private flag_MAC_PFC_OPCODE_PFC_OPCODE

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

    Property Get get_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
        get_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1 = read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value
    End Property

    Property Let set_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1(aData)
        write_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value = aData
        flag_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1        = &H1
    End Property

    Property Get read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
        read
        read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1 = read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value
    End Property

    Property Let write_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1(aData)
        set_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1 = aData
        write
    End Property

    Property Get get_MAC_PFC_OPCODE_PFC_OPCODE
        get_MAC_PFC_OPCODE_PFC_OPCODE = read_MAC_PFC_OPCODE_PFC_OPCODE_value
    End Property

    Property Let set_MAC_PFC_OPCODE_PFC_OPCODE(aData)
        write_MAC_PFC_OPCODE_PFC_OPCODE_value = aData
        flag_MAC_PFC_OPCODE_PFC_OPCODE        = &H1
    End Property

    Property Get read_MAC_PFC_OPCODE_PFC_OPCODE
        read
        read_MAC_PFC_OPCODE_PFC_OPCODE = read_MAC_PFC_OPCODE_PFC_OPCODE_value
    End Property

    Property Let write_MAC_PFC_OPCODE_PFC_OPCODE(aData)
        set_MAC_PFC_OPCODE_PFC_OPCODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_PFC_OPCODE_PFC_OPCODE_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_PFC_OPCODE_PFC_OPCODE_mask = mask then
                read_MAC_PFC_OPCODE_PFC_OPCODE_value = data_low
            else
                read_MAC_PFC_OPCODE_PFC_OPCODE_value = (data_low - H8000_0000) and MAC_PFC_OPCODE_PFC_OPCODE_mask
            end If
        else
            read_MAC_PFC_OPCODE_PFC_OPCODE_value = data_low and MAC_PFC_OPCODE_PFC_OPCODE_mask
        end If

    End Sub

    Sub write
        If flag_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1 = &H0 or flag_MAC_PFC_OPCODE_PFC_OPCODE = &H0 Then read
        If flag_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1 = &H0 Then write_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value = get_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1
        If flag_MAC_PFC_OPCODE_PFC_OPCODE = &H0 Then write_MAC_PFC_OPCODE_PFC_OPCODE_value = get_MAC_PFC_OPCODE_PFC_OPCODE

        regValue = leftShift((write_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value and &Hffff), 16) + leftShift((write_MAC_PFC_OPCODE_PFC_OPCODE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_PFC_OPCODE_PFC_OPCODE_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_PFC_OPCODE_PFC_OPCODE_mask = mask then
                read_MAC_PFC_OPCODE_PFC_OPCODE_value = data_low
            else
                read_MAC_PFC_OPCODE_PFC_OPCODE_value = (data_low - H8000_0000) and MAC_PFC_OPCODE_PFC_OPCODE_mask
            end If
        else
            read_MAC_PFC_OPCODE_PFC_OPCODE_value = data_low and MAC_PFC_OPCODE_PFC_OPCODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1_value = &H0
        flag_MAC_PFC_OPCODE_MAC_PFC_OPCODE_RSVD_1        = &H0
        write_MAC_PFC_OPCODE_PFC_OPCODE_value = &H0
        flag_MAC_PFC_OPCODE_PFC_OPCODE        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_pfc_da_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_PFC_DA_0_PFC_MACDA_0                   [31:0]           get_MAC_PFC_DA_0_PFC_MACDA_0
''                                                             set_MAC_PFC_DA_0_PFC_MACDA_0
''                                                             read_MAC_PFC_DA_0_PFC_MACDA_0
''                                                             write_MAC_PFC_DA_0_PFC_MACDA_0
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_pfc_da_0
    Private write_MAC_PFC_DA_0_PFC_MACDA_0_value
    Private read_MAC_PFC_DA_0_PFC_MACDA_0_value
    Private flag_MAC_PFC_DA_0_PFC_MACDA_0

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

    Property Get get_MAC_PFC_DA_0_PFC_MACDA_0
        get_MAC_PFC_DA_0_PFC_MACDA_0 = read_MAC_PFC_DA_0_PFC_MACDA_0_value
    End Property

    Property Let set_MAC_PFC_DA_0_PFC_MACDA_0(aData)
        write_MAC_PFC_DA_0_PFC_MACDA_0_value = aData
        flag_MAC_PFC_DA_0_PFC_MACDA_0        = &H1
    End Property

    Property Get read_MAC_PFC_DA_0_PFC_MACDA_0
        read
        read_MAC_PFC_DA_0_PFC_MACDA_0 = read_MAC_PFC_DA_0_PFC_MACDA_0_value
    End Property

    Property Let write_MAC_PFC_DA_0_PFC_MACDA_0(aData)
        set_MAC_PFC_DA_0_PFC_MACDA_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAC_PFC_DA_0_PFC_MACDA_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MAC_PFC_DA_0_PFC_MACDA_0_mask = mask then
                read_MAC_PFC_DA_0_PFC_MACDA_0_value = data_low
            else
                read_MAC_PFC_DA_0_PFC_MACDA_0_value = (data_low - H8000_0000) and MAC_PFC_DA_0_PFC_MACDA_0_mask
            end If
        else
            read_MAC_PFC_DA_0_PFC_MACDA_0_value = data_low and MAC_PFC_DA_0_PFC_MACDA_0_mask
        end If

    End Sub

    Sub write
        If flag_MAC_PFC_DA_0_PFC_MACDA_0 = &H0 Then read
        If flag_MAC_PFC_DA_0_PFC_MACDA_0 = &H0 Then write_MAC_PFC_DA_0_PFC_MACDA_0_value = get_MAC_PFC_DA_0_PFC_MACDA_0

        regValue = leftShift(write_MAC_PFC_DA_0_PFC_MACDA_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAC_PFC_DA_0_PFC_MACDA_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MAC_PFC_DA_0_PFC_MACDA_0_mask = mask then
                read_MAC_PFC_DA_0_PFC_MACDA_0_value = data_low
            else
                read_MAC_PFC_DA_0_PFC_MACDA_0_value = (data_low - H8000_0000) and MAC_PFC_DA_0_PFC_MACDA_0_mask
            end If
        else
            read_MAC_PFC_DA_0_PFC_MACDA_0_value = data_low and MAC_PFC_DA_0_PFC_MACDA_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_PFC_DA_0_PFC_MACDA_0_value = &H0
        flag_MAC_PFC_DA_0_PFC_MACDA_0        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_pfc_da_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1           [31:16]          get_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
''                                                             set_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
''                                                             read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
''                                                             write_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
''---------------------------------------------------------------------------------
'' MAC_PFC_DA_1_PFC_MACDA_1                   [15:0]           get_MAC_PFC_DA_1_PFC_MACDA_1
''                                                             set_MAC_PFC_DA_1_PFC_MACDA_1
''                                                             read_MAC_PFC_DA_1_PFC_MACDA_1
''                                                             write_MAC_PFC_DA_1_PFC_MACDA_1
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_pfc_da_1
    Private write_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value
    Private read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value
    Private flag_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
    Private write_MAC_PFC_DA_1_PFC_MACDA_1_value
    Private read_MAC_PFC_DA_1_PFC_MACDA_1_value
    Private flag_MAC_PFC_DA_1_PFC_MACDA_1

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

    Property Get get_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
        get_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1 = read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value
    End Property

    Property Let set_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1(aData)
        write_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value = aData
        flag_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1        = &H1
    End Property

    Property Get read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
        read
        read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1 = read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value
    End Property

    Property Let write_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1(aData)
        set_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1 = aData
        write
    End Property

    Property Get get_MAC_PFC_DA_1_PFC_MACDA_1
        get_MAC_PFC_DA_1_PFC_MACDA_1 = read_MAC_PFC_DA_1_PFC_MACDA_1_value
    End Property

    Property Let set_MAC_PFC_DA_1_PFC_MACDA_1(aData)
        write_MAC_PFC_DA_1_PFC_MACDA_1_value = aData
        flag_MAC_PFC_DA_1_PFC_MACDA_1        = &H1
    End Property

    Property Get read_MAC_PFC_DA_1_PFC_MACDA_1
        read
        read_MAC_PFC_DA_1_PFC_MACDA_1 = read_MAC_PFC_DA_1_PFC_MACDA_1_value
    End Property

    Property Let write_MAC_PFC_DA_1_PFC_MACDA_1(aData)
        set_MAC_PFC_DA_1_PFC_MACDA_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_PFC_DA_1_PFC_MACDA_1_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_PFC_DA_1_PFC_MACDA_1_mask = mask then
                read_MAC_PFC_DA_1_PFC_MACDA_1_value = data_low
            else
                read_MAC_PFC_DA_1_PFC_MACDA_1_value = (data_low - H8000_0000) and MAC_PFC_DA_1_PFC_MACDA_1_mask
            end If
        else
            read_MAC_PFC_DA_1_PFC_MACDA_1_value = data_low and MAC_PFC_DA_1_PFC_MACDA_1_mask
        end If

    End Sub

    Sub write
        If flag_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1 = &H0 or flag_MAC_PFC_DA_1_PFC_MACDA_1 = &H0 Then read
        If flag_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1 = &H0 Then write_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value = get_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1
        If flag_MAC_PFC_DA_1_PFC_MACDA_1 = &H0 Then write_MAC_PFC_DA_1_PFC_MACDA_1_value = get_MAC_PFC_DA_1_PFC_MACDA_1

        regValue = leftShift((write_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value and &Hffff), 16) + leftShift((write_MAC_PFC_DA_1_PFC_MACDA_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value = rightShift(data_low, 16) and &Hffff
        MAC_PFC_DA_1_PFC_MACDA_1_mask = &Hffff
        if data_low > LONG_MAX then
            if MAC_PFC_DA_1_PFC_MACDA_1_mask = mask then
                read_MAC_PFC_DA_1_PFC_MACDA_1_value = data_low
            else
                read_MAC_PFC_DA_1_PFC_MACDA_1_value = (data_low - H8000_0000) and MAC_PFC_DA_1_PFC_MACDA_1_mask
            end If
        else
            read_MAC_PFC_DA_1_PFC_MACDA_1_value = data_low and MAC_PFC_DA_1_PFC_MACDA_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1_value = &H0
        flag_MAC_PFC_DA_1_MAC_PFC_DA_1_RSVD_1        = &H0
        write_MAC_PFC_DA_1_PFC_MACDA_1_value = &H0
        flag_MAC_PFC_DA_1_PFC_MACDA_1        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_macsec_prog_tx_crc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MACSEC_PROG_TX_CRC                         [31:0]           get_MACSEC_PROG_TX_CRC
''                                                             set_MACSEC_PROG_TX_CRC
''                                                             read_MACSEC_PROG_TX_CRC
''                                                             write_MACSEC_PROG_TX_CRC
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_macsec_prog_tx_crc
    Private write_MACSEC_PROG_TX_CRC_value
    Private read_MACSEC_PROG_TX_CRC_value
    Private flag_MACSEC_PROG_TX_CRC

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

    Property Get get_MACSEC_PROG_TX_CRC
        get_MACSEC_PROG_TX_CRC = read_MACSEC_PROG_TX_CRC_value
    End Property

    Property Let set_MACSEC_PROG_TX_CRC(aData)
        write_MACSEC_PROG_TX_CRC_value = aData
        flag_MACSEC_PROG_TX_CRC        = &H1
    End Property

    Property Get read_MACSEC_PROG_TX_CRC
        read
        read_MACSEC_PROG_TX_CRC = read_MACSEC_PROG_TX_CRC_value
    End Property

    Property Let write_MACSEC_PROG_TX_CRC(aData)
        set_MACSEC_PROG_TX_CRC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MACSEC_PROG_TX_CRC_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MACSEC_PROG_TX_CRC_mask = mask then
                read_MACSEC_PROG_TX_CRC_value = data_low
            else
                read_MACSEC_PROG_TX_CRC_value = (data_low - H8000_0000) and MACSEC_PROG_TX_CRC_mask
            end If
        else
            read_MACSEC_PROG_TX_CRC_value = data_low and MACSEC_PROG_TX_CRC_mask
        end If

    End Sub

    Sub write
        If flag_MACSEC_PROG_TX_CRC = &H0 Then read
        If flag_MACSEC_PROG_TX_CRC = &H0 Then write_MACSEC_PROG_TX_CRC_value = get_MACSEC_PROG_TX_CRC

        regValue = leftShift(write_MACSEC_PROG_TX_CRC_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MACSEC_PROG_TX_CRC_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MACSEC_PROG_TX_CRC_mask = mask then
                read_MACSEC_PROG_TX_CRC_value = data_low
            else
                read_MACSEC_PROG_TX_CRC_value = (data_low - H8000_0000) and MACSEC_PROG_TX_CRC_mask
            end If
        else
            read_MACSEC_PROG_TX_CRC_value = data_low and MACSEC_PROG_TX_CRC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MACSEC_PROG_TX_CRC_value = &H0
        flag_MACSEC_PROG_TX_CRC        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_macsec_cntrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4           [31:4]           get_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
''                                                             set_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
''                                                             read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
''                                                             write_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
''---------------------------------------------------------------------------------
'' MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG        [3:3]            get_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
''                                                             set_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
''                                                             read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
''                                                             write_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
''---------------------------------------------------------------------------------
'' MACSEC_CNTRL_TX_CRC_PROGRAM                [2:2]            get_MACSEC_CNTRL_TX_CRC_PROGRAM
''                                                             set_MACSEC_CNTRL_TX_CRC_PROGRAM
''                                                             read_MACSEC_CNTRL_TX_CRC_PROGRAM
''                                                             write_MACSEC_CNTRL_TX_CRC_PROGRAM
''---------------------------------------------------------------------------------
'' MACSEC_CNTRL_TX_CRC_CORUPT_EN              [1:1]            get_MACSEC_CNTRL_TX_CRC_CORUPT_EN
''                                                             set_MACSEC_CNTRL_TX_CRC_CORUPT_EN
''                                                             read_MACSEC_CNTRL_TX_CRC_CORUPT_EN
''                                                             write_MACSEC_CNTRL_TX_CRC_CORUPT_EN
''---------------------------------------------------------------------------------
'' MACSEC_CNTRL_TX_LAUNCH_EN                  [0:0]            get_MACSEC_CNTRL_TX_LAUNCH_EN
''                                                             set_MACSEC_CNTRL_TX_LAUNCH_EN
''                                                             read_MACSEC_CNTRL_TX_LAUNCH_EN
''                                                             write_MACSEC_CNTRL_TX_LAUNCH_EN
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_macsec_cntrl
    Private write_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value
    Private read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value
    Private flag_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
    Private write_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value
    Private read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value
    Private flag_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
    Private write_MACSEC_CNTRL_TX_CRC_PROGRAM_value
    Private read_MACSEC_CNTRL_TX_CRC_PROGRAM_value
    Private flag_MACSEC_CNTRL_TX_CRC_PROGRAM
    Private write_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value
    Private read_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value
    Private flag_MACSEC_CNTRL_TX_CRC_CORUPT_EN
    Private write_MACSEC_CNTRL_TX_LAUNCH_EN_value
    Private read_MACSEC_CNTRL_TX_LAUNCH_EN_value
    Private flag_MACSEC_CNTRL_TX_LAUNCH_EN

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

    Property Get get_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
        get_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4 = read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value
    End Property

    Property Let set_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4(aData)
        write_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value = aData
        flag_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4        = &H1
    End Property

    Property Get read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
        read
        read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4 = read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value
    End Property

    Property Let write_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4(aData)
        set_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4 = aData
        write
    End Property

    Property Get get_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
        get_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG = read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value
    End Property

    Property Let set_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG(aData)
        write_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value = aData
        flag_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG        = &H1
    End Property

    Property Get read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
        read
        read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG = read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value
    End Property

    Property Let write_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG(aData)
        set_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG = aData
        write
    End Property

    Property Get get_MACSEC_CNTRL_TX_CRC_PROGRAM
        get_MACSEC_CNTRL_TX_CRC_PROGRAM = read_MACSEC_CNTRL_TX_CRC_PROGRAM_value
    End Property

    Property Let set_MACSEC_CNTRL_TX_CRC_PROGRAM(aData)
        write_MACSEC_CNTRL_TX_CRC_PROGRAM_value = aData
        flag_MACSEC_CNTRL_TX_CRC_PROGRAM        = &H1
    End Property

    Property Get read_MACSEC_CNTRL_TX_CRC_PROGRAM
        read
        read_MACSEC_CNTRL_TX_CRC_PROGRAM = read_MACSEC_CNTRL_TX_CRC_PROGRAM_value
    End Property

    Property Let write_MACSEC_CNTRL_TX_CRC_PROGRAM(aData)
        set_MACSEC_CNTRL_TX_CRC_PROGRAM = aData
        write
    End Property

    Property Get get_MACSEC_CNTRL_TX_CRC_CORUPT_EN
        get_MACSEC_CNTRL_TX_CRC_CORUPT_EN = read_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value
    End Property

    Property Let set_MACSEC_CNTRL_TX_CRC_CORUPT_EN(aData)
        write_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value = aData
        flag_MACSEC_CNTRL_TX_CRC_CORUPT_EN        = &H1
    End Property

    Property Get read_MACSEC_CNTRL_TX_CRC_CORUPT_EN
        read
        read_MACSEC_CNTRL_TX_CRC_CORUPT_EN = read_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value
    End Property

    Property Let write_MACSEC_CNTRL_TX_CRC_CORUPT_EN(aData)
        set_MACSEC_CNTRL_TX_CRC_CORUPT_EN = aData
        write
    End Property

    Property Get get_MACSEC_CNTRL_TX_LAUNCH_EN
        get_MACSEC_CNTRL_TX_LAUNCH_EN = read_MACSEC_CNTRL_TX_LAUNCH_EN_value
    End Property

    Property Let set_MACSEC_CNTRL_TX_LAUNCH_EN(aData)
        write_MACSEC_CNTRL_TX_LAUNCH_EN_value = aData
        flag_MACSEC_CNTRL_TX_LAUNCH_EN        = &H1
    End Property

    Property Get read_MACSEC_CNTRL_TX_LAUNCH_EN
        read
        read_MACSEC_CNTRL_TX_LAUNCH_EN = read_MACSEC_CNTRL_TX_LAUNCH_EN_value
    End Property

    Property Let write_MACSEC_CNTRL_TX_LAUNCH_EN(aData)
        set_MACSEC_CNTRL_TX_LAUNCH_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value = rightShift(data_low, 4) and &Hfffffff
        read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value = rightShift(data_low, 3) and &H1
        read_MACSEC_CNTRL_TX_CRC_PROGRAM_value = rightShift(data_low, 2) and &H1
        read_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value = rightShift(data_low, 1) and &H1
        MACSEC_CNTRL_TX_LAUNCH_EN_mask = &H1
        if data_low > LONG_MAX then
            if MACSEC_CNTRL_TX_LAUNCH_EN_mask = mask then
                read_MACSEC_CNTRL_TX_LAUNCH_EN_value = data_low
            else
                read_MACSEC_CNTRL_TX_LAUNCH_EN_value = (data_low - H8000_0000) and MACSEC_CNTRL_TX_LAUNCH_EN_mask
            end If
        else
            read_MACSEC_CNTRL_TX_LAUNCH_EN_value = data_low and MACSEC_CNTRL_TX_LAUNCH_EN_mask
        end If

    End Sub

    Sub write
        If flag_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4 = &H0 or flag_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG = &H0 or flag_MACSEC_CNTRL_TX_CRC_PROGRAM = &H0 or flag_MACSEC_CNTRL_TX_CRC_CORUPT_EN = &H0 or flag_MACSEC_CNTRL_TX_LAUNCH_EN = &H0 Then read
        If flag_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4 = &H0 Then write_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value = get_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4
        If flag_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG = &H0 Then write_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value = get_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG
        If flag_MACSEC_CNTRL_TX_CRC_PROGRAM = &H0 Then write_MACSEC_CNTRL_TX_CRC_PROGRAM_value = get_MACSEC_CNTRL_TX_CRC_PROGRAM
        If flag_MACSEC_CNTRL_TX_CRC_CORUPT_EN = &H0 Then write_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value = get_MACSEC_CNTRL_TX_CRC_CORUPT_EN
        If flag_MACSEC_CNTRL_TX_LAUNCH_EN = &H0 Then write_MACSEC_CNTRL_TX_LAUNCH_EN_value = get_MACSEC_CNTRL_TX_LAUNCH_EN

        regValue = leftShift((write_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value and &Hfffffff), 4) + leftShift((write_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value and &H1), 3) + leftShift((write_MACSEC_CNTRL_TX_CRC_PROGRAM_value and &H1), 2) + leftShift((write_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value and &H1), 1) + leftShift((write_MACSEC_CNTRL_TX_LAUNCH_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value = rightShift(data_low, 4) and &Hfffffff
        read_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value = rightShift(data_low, 3) and &H1
        read_MACSEC_CNTRL_TX_CRC_PROGRAM_value = rightShift(data_low, 2) and &H1
        read_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value = rightShift(data_low, 1) and &H1
        MACSEC_CNTRL_TX_LAUNCH_EN_mask = &H1
        if data_low > LONG_MAX then
            if MACSEC_CNTRL_TX_LAUNCH_EN_mask = mask then
                read_MACSEC_CNTRL_TX_LAUNCH_EN_value = data_low
            else
                read_MACSEC_CNTRL_TX_LAUNCH_EN_value = (data_low - H8000_0000) and MACSEC_CNTRL_TX_LAUNCH_EN_mask
            end If
        else
            read_MACSEC_CNTRL_TX_LAUNCH_EN_value = data_low and MACSEC_CNTRL_TX_LAUNCH_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4_value = &H0
        flag_MACSEC_CNTRL_MACSEC_CNTRL_RSVD_4        = &H0
        write_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG_value = &H0
        flag_MACSEC_CNTRL_DIS_PAUSE_DATA_VAR_IPG        = &H0
        write_MACSEC_CNTRL_TX_CRC_PROGRAM_value = &H0
        flag_MACSEC_CNTRL_TX_CRC_PROGRAM        = &H0
        write_MACSEC_CNTRL_TX_CRC_CORUPT_EN_value = &H0
        flag_MACSEC_CNTRL_TX_CRC_CORUPT_EN        = &H0
        write_MACSEC_CNTRL_TX_LAUNCH_EN_value = &H0
        flag_MACSEC_CNTRL_TX_LAUNCH_EN        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_ts_status_cntrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3     [31:5]           get_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
''                                                             set_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
''                                                             read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
''                                                             write_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
''---------------------------------------------------------------------------------
'' TS_STATUS_CNTRL_WORD_AVAIL                 [4:2]            get_TS_STATUS_CNTRL_WORD_AVAIL
''                                                             set_TS_STATUS_CNTRL_WORD_AVAIL
''                                                             read_TS_STATUS_CNTRL_WORD_AVAIL
''                                                             write_TS_STATUS_CNTRL_WORD_AVAIL
''---------------------------------------------------------------------------------
'' TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY           [1:1]            get_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
''                                                             set_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
''                                                             read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
''                                                             write_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
''---------------------------------------------------------------------------------
'' TS_STATUS_CNTRL_TX_TS_FIFO_FULL            [0:0]            get_TS_STATUS_CNTRL_TX_TS_FIFO_FULL
''                                                             set_TS_STATUS_CNTRL_TX_TS_FIFO_FULL
''                                                             read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL
''                                                             write_TS_STATUS_CNTRL_TX_TS_FIFO_FULL
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_ts_status_cntrl
    Private write_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value
    Private read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value
    Private flag_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
    Private write_TS_STATUS_CNTRL_WORD_AVAIL_value
    Private read_TS_STATUS_CNTRL_WORD_AVAIL_value
    Private flag_TS_STATUS_CNTRL_WORD_AVAIL
    Private write_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value
    Private read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value
    Private flag_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
    Private write_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value
    Private read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value
    Private flag_TS_STATUS_CNTRL_TX_TS_FIFO_FULL

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

    Property Get get_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
        get_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3 = read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value
    End Property

    Property Let set_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3(aData)
        write_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value = aData
        flag_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3        = &H1
    End Property

    Property Get read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
        read
        read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3 = read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value
    End Property

    Property Let write_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3(aData)
        set_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3 = aData
        write
    End Property

    Property Get get_TS_STATUS_CNTRL_WORD_AVAIL
        get_TS_STATUS_CNTRL_WORD_AVAIL = read_TS_STATUS_CNTRL_WORD_AVAIL_value
    End Property

    Property Let set_TS_STATUS_CNTRL_WORD_AVAIL(aData)
        write_TS_STATUS_CNTRL_WORD_AVAIL_value = aData
        flag_TS_STATUS_CNTRL_WORD_AVAIL        = &H1
    End Property

    Property Get read_TS_STATUS_CNTRL_WORD_AVAIL
        read
        read_TS_STATUS_CNTRL_WORD_AVAIL = read_TS_STATUS_CNTRL_WORD_AVAIL_value
    End Property

    Property Let write_TS_STATUS_CNTRL_WORD_AVAIL(aData)
        set_TS_STATUS_CNTRL_WORD_AVAIL = aData
        write
    End Property

    Property Get get_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
        get_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY = read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value
    End Property

    Property Let set_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY(aData)
        write_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value = aData
        flag_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY        = &H1
    End Property

    Property Get read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
        read
        read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY = read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value
    End Property

    Property Let write_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY(aData)
        set_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY = aData
        write
    End Property

    Property Get get_TS_STATUS_CNTRL_TX_TS_FIFO_FULL
        get_TS_STATUS_CNTRL_TX_TS_FIFO_FULL = read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value
    End Property

    Property Let set_TS_STATUS_CNTRL_TX_TS_FIFO_FULL(aData)
        write_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = aData
        flag_TS_STATUS_CNTRL_TX_TS_FIFO_FULL        = &H1
    End Property

    Property Get read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL
        read
        read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL = read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value
    End Property

    Property Let write_TS_STATUS_CNTRL_TX_TS_FIFO_FULL(aData)
        set_TS_STATUS_CNTRL_TX_TS_FIFO_FULL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value = rightShift(data_low, 5) and &H7ffffff
        read_TS_STATUS_CNTRL_WORD_AVAIL_value = rightShift(data_low, 2) and &H7
        read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value = rightShift(data_low, 1) and &H1
        TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask = &H1
        if data_low > LONG_MAX then
            if TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask = mask then
                read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = data_low
            else
                read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = (data_low - H8000_0000) and TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask
            end If
        else
            read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = data_low and TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask
        end If

    End Sub

    Sub write
        If flag_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3 = &H0 or flag_TS_STATUS_CNTRL_WORD_AVAIL = &H0 or flag_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY = &H0 or flag_TS_STATUS_CNTRL_TX_TS_FIFO_FULL = &H0 Then read
        If flag_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3 = &H0 Then write_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value = get_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3
        If flag_TS_STATUS_CNTRL_WORD_AVAIL = &H0 Then write_TS_STATUS_CNTRL_WORD_AVAIL_value = get_TS_STATUS_CNTRL_WORD_AVAIL
        If flag_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY = &H0 Then write_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value = get_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY
        If flag_TS_STATUS_CNTRL_TX_TS_FIFO_FULL = &H0 Then write_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = get_TS_STATUS_CNTRL_TX_TS_FIFO_FULL

        regValue = leftShift((write_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value and &H7ffffff), 5) + leftShift((write_TS_STATUS_CNTRL_WORD_AVAIL_value and &H7), 2) + leftShift((write_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value and &H1), 1) + leftShift((write_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value = rightShift(data_low, 5) and &H7ffffff
        read_TS_STATUS_CNTRL_WORD_AVAIL_value = rightShift(data_low, 2) and &H7
        read_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value = rightShift(data_low, 1) and &H1
        TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask = &H1
        if data_low > LONG_MAX then
            if TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask = mask then
                read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = data_low
            else
                read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = (data_low - H8000_0000) and TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask
            end If
        else
            read_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = data_low and TS_STATUS_CNTRL_TX_TS_FIFO_FULL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3_value = &H0
        flag_TS_STATUS_CNTRL_TS_STATUS_CNTRL_RSVD_3        = &H0
        write_TS_STATUS_CNTRL_WORD_AVAIL_value = &H0
        flag_TS_STATUS_CNTRL_WORD_AVAIL        = &H0
        write_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY_value = &H0
        flag_TS_STATUS_CNTRL_TX_TS_FIFO_EMPTY        = &H0
        write_TS_STATUS_CNTRL_TX_TS_FIFO_FULL_value = &H0
        flag_TS_STATUS_CNTRL_TX_TS_FIFO_FULL        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_tx_ts_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_TS_DATA_TX_TS_DATA                      [31:0]           get_TX_TS_DATA_TX_TS_DATA
''                                                             set_TX_TS_DATA_TX_TS_DATA
''                                                             read_TX_TS_DATA_TX_TS_DATA
''                                                             write_TX_TS_DATA_TX_TS_DATA
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_tx_ts_data
    Private write_TX_TS_DATA_TX_TS_DATA_value
    Private read_TX_TS_DATA_TX_TS_DATA_value
    Private flag_TX_TS_DATA_TX_TS_DATA

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

    Property Get get_TX_TS_DATA_TX_TS_DATA
        get_TX_TS_DATA_TX_TS_DATA = read_TX_TS_DATA_TX_TS_DATA_value
    End Property

    Property Let set_TX_TS_DATA_TX_TS_DATA(aData)
        write_TX_TS_DATA_TX_TS_DATA_value = aData
        flag_TX_TS_DATA_TX_TS_DATA        = &H1
    End Property

    Property Get read_TX_TS_DATA_TX_TS_DATA
        read
        read_TX_TS_DATA_TX_TS_DATA = read_TX_TS_DATA_TX_TS_DATA_value
    End Property

    Property Let write_TX_TS_DATA_TX_TS_DATA(aData)
        set_TX_TS_DATA_TX_TS_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_TS_DATA_TX_TS_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TX_TS_DATA_TX_TS_DATA_mask = mask then
                read_TX_TS_DATA_TX_TS_DATA_value = data_low
            else
                read_TX_TS_DATA_TX_TS_DATA_value = (data_low - H8000_0000) and TX_TS_DATA_TX_TS_DATA_mask
            end If
        else
            read_TX_TS_DATA_TX_TS_DATA_value = data_low and TX_TS_DATA_TX_TS_DATA_mask
        end If

    End Sub

    Sub write
        If flag_TX_TS_DATA_TX_TS_DATA = &H0 Then read
        If flag_TX_TS_DATA_TX_TS_DATA = &H0 Then write_TX_TS_DATA_TX_TS_DATA_value = get_TX_TS_DATA_TX_TS_DATA

        regValue = leftShift(write_TX_TS_DATA_TX_TS_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_TS_DATA_TX_TS_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if TX_TS_DATA_TX_TS_DATA_mask = mask then
                read_TX_TS_DATA_TX_TS_DATA_value = data_low
            else
                read_TX_TS_DATA_TX_TS_DATA_value = (data_low - H8000_0000) and TX_TS_DATA_TX_TS_DATA_mask
            end If
        else
            read_TX_TS_DATA_TX_TS_DATA_value = data_low and TX_TS_DATA_TX_TS_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_TS_DATA_TX_TS_DATA_value = &H0
        flag_TX_TS_DATA_TX_TS_DATA        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_pause_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2         [31:18]          get_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
''                                                             set_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
''                                                             read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
''                                                             write_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
''---------------------------------------------------------------------------------
'' PAUSE_CONTROL_ENABLE                       [17:17]          get_PAUSE_CONTROL_ENABLE
''                                                             set_PAUSE_CONTROL_ENABLE
''                                                             read_PAUSE_CONTROL_ENABLE
''                                                             write_PAUSE_CONTROL_ENABLE
''---------------------------------------------------------------------------------
'' PAUSE_CONTROL_VALUE                        [16:0]           get_PAUSE_CONTROL_VALUE
''                                                             set_PAUSE_CONTROL_VALUE
''                                                             read_PAUSE_CONTROL_VALUE
''                                                             write_PAUSE_CONTROL_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_pause_control
    Private write_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value
    Private read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value
    Private flag_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
    Private write_PAUSE_CONTROL_ENABLE_value
    Private read_PAUSE_CONTROL_ENABLE_value
    Private flag_PAUSE_CONTROL_ENABLE
    Private write_PAUSE_CONTROL_VALUE_value
    Private read_PAUSE_CONTROL_VALUE_value
    Private flag_PAUSE_CONTROL_VALUE

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

    Property Get get_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
        get_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2 = read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value
    End Property

    Property Let set_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2(aData)
        write_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value = aData
        flag_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2        = &H1
    End Property

    Property Get read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
        read
        read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2 = read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value
    End Property

    Property Let write_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2(aData)
        set_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2 = aData
        write
    End Property

    Property Get get_PAUSE_CONTROL_ENABLE
        get_PAUSE_CONTROL_ENABLE = read_PAUSE_CONTROL_ENABLE_value
    End Property

    Property Let set_PAUSE_CONTROL_ENABLE(aData)
        write_PAUSE_CONTROL_ENABLE_value = aData
        flag_PAUSE_CONTROL_ENABLE        = &H1
    End Property

    Property Get read_PAUSE_CONTROL_ENABLE
        read
        read_PAUSE_CONTROL_ENABLE = read_PAUSE_CONTROL_ENABLE_value
    End Property

    Property Let write_PAUSE_CONTROL_ENABLE(aData)
        set_PAUSE_CONTROL_ENABLE = aData
        write
    End Property

    Property Get get_PAUSE_CONTROL_VALUE
        get_PAUSE_CONTROL_VALUE = read_PAUSE_CONTROL_VALUE_value
    End Property

    Property Let set_PAUSE_CONTROL_VALUE(aData)
        write_PAUSE_CONTROL_VALUE_value = aData
        flag_PAUSE_CONTROL_VALUE        = &H1
    End Property

    Property Get read_PAUSE_CONTROL_VALUE
        read
        read_PAUSE_CONTROL_VALUE = read_PAUSE_CONTROL_VALUE_value
    End Property

    Property Let write_PAUSE_CONTROL_VALUE(aData)
        set_PAUSE_CONTROL_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value = rightShift(data_low, 18) and &H3fff
        read_PAUSE_CONTROL_ENABLE_value = rightShift(data_low, 17) and &H1
        PAUSE_CONTROL_VALUE_mask = &H1ffff
        if data_low > LONG_MAX then
            if PAUSE_CONTROL_VALUE_mask = mask then
                read_PAUSE_CONTROL_VALUE_value = data_low
            else
                read_PAUSE_CONTROL_VALUE_value = (data_low - H8000_0000) and PAUSE_CONTROL_VALUE_mask
            end If
        else
            read_PAUSE_CONTROL_VALUE_value = data_low and PAUSE_CONTROL_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2 = &H0 or flag_PAUSE_CONTROL_ENABLE = &H0 or flag_PAUSE_CONTROL_VALUE = &H0 Then read
        If flag_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2 = &H0 Then write_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value = get_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2
        If flag_PAUSE_CONTROL_ENABLE = &H0 Then write_PAUSE_CONTROL_ENABLE_value = get_PAUSE_CONTROL_ENABLE
        If flag_PAUSE_CONTROL_VALUE = &H0 Then write_PAUSE_CONTROL_VALUE_value = get_PAUSE_CONTROL_VALUE

        regValue = leftShift((write_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value and &H3fff), 18) + leftShift((write_PAUSE_CONTROL_ENABLE_value and &H1), 17) + leftShift((write_PAUSE_CONTROL_VALUE_value and &H1ffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value = rightShift(data_low, 18) and &H3fff
        read_PAUSE_CONTROL_ENABLE_value = rightShift(data_low, 17) and &H1
        PAUSE_CONTROL_VALUE_mask = &H1ffff
        if data_low > LONG_MAX then
            if PAUSE_CONTROL_VALUE_mask = mask then
                read_PAUSE_CONTROL_VALUE_value = data_low
            else
                read_PAUSE_CONTROL_VALUE_value = (data_low - H8000_0000) and PAUSE_CONTROL_VALUE_mask
            end If
        else
            read_PAUSE_CONTROL_VALUE_value = data_low and PAUSE_CONTROL_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2_value = &H0
        flag_PAUSE_CONTROL_PAUSE_CONTROL_RSVD_2        = &H0
        write_PAUSE_CONTROL_ENABLE_value = &H0
        flag_PAUSE_CONTROL_ENABLE        = &H0
        write_PAUSE_CONTROL_VALUE_value = &H0
        flag_PAUSE_CONTROL_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_flush_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1         [31:1]           get_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
''                                                             set_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
''                                                             read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
''                                                             write_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
''---------------------------------------------------------------------------------
'' FLUSH_CONTROL_FLUSH                        [0:0]            get_FLUSH_CONTROL_FLUSH
''                                                             set_FLUSH_CONTROL_FLUSH
''                                                             read_FLUSH_CONTROL_FLUSH
''                                                             write_FLUSH_CONTROL_FLUSH
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_flush_control
    Private write_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value
    Private read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value
    Private flag_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
    Private write_FLUSH_CONTROL_FLUSH_value
    Private read_FLUSH_CONTROL_FLUSH_value
    Private flag_FLUSH_CONTROL_FLUSH

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

    Property Get get_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
        get_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1 = read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value
    End Property

    Property Let set_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1(aData)
        write_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value = aData
        flag_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1        = &H1
    End Property

    Property Get read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
        read
        read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1 = read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value
    End Property

    Property Let write_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1(aData)
        set_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1 = aData
        write
    End Property

    Property Get get_FLUSH_CONTROL_FLUSH
        get_FLUSH_CONTROL_FLUSH = read_FLUSH_CONTROL_FLUSH_value
    End Property

    Property Let set_FLUSH_CONTROL_FLUSH(aData)
        write_FLUSH_CONTROL_FLUSH_value = aData
        flag_FLUSH_CONTROL_FLUSH        = &H1
    End Property

    Property Get read_FLUSH_CONTROL_FLUSH
        read
        read_FLUSH_CONTROL_FLUSH = read_FLUSH_CONTROL_FLUSH_value
    End Property

    Property Let write_FLUSH_CONTROL_FLUSH(aData)
        set_FLUSH_CONTROL_FLUSH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value = rightShift(data_low, 1) and &H7fffffff
        FLUSH_CONTROL_FLUSH_mask = &H1
        if data_low > LONG_MAX then
            if FLUSH_CONTROL_FLUSH_mask = mask then
                read_FLUSH_CONTROL_FLUSH_value = data_low
            else
                read_FLUSH_CONTROL_FLUSH_value = (data_low - H8000_0000) and FLUSH_CONTROL_FLUSH_mask
            end If
        else
            read_FLUSH_CONTROL_FLUSH_value = data_low and FLUSH_CONTROL_FLUSH_mask
        end If

    End Sub

    Sub write
        If flag_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1 = &H0 or flag_FLUSH_CONTROL_FLUSH = &H0 Then read
        If flag_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1 = &H0 Then write_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value = get_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1
        If flag_FLUSH_CONTROL_FLUSH = &H0 Then write_FLUSH_CONTROL_FLUSH_value = get_FLUSH_CONTROL_FLUSH

        regValue = leftShift((write_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value and &H7fffffff), 1) + leftShift((write_FLUSH_CONTROL_FLUSH_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value = rightShift(data_low, 1) and &H7fffffff
        FLUSH_CONTROL_FLUSH_mask = &H1
        if data_low > LONG_MAX then
            if FLUSH_CONTROL_FLUSH_mask = mask then
                read_FLUSH_CONTROL_FLUSH_value = data_low
            else
                read_FLUSH_CONTROL_FLUSH_value = (data_low - H8000_0000) and FLUSH_CONTROL_FLUSH_mask
            end If
        else
            read_FLUSH_CONTROL_FLUSH_value = data_low and FLUSH_CONTROL_FLUSH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1_value = &H0
        flag_FLUSH_CONTROL_FLUSH_CONTROL_RSVD_1        = &H0
        write_FLUSH_CONTROL_FLUSH_value = &H0
        flag_FLUSH_CONTROL_FLUSH        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_rxfifo_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXFIFO_STAT_RXFIFO_STAT_RSVD_2             [31:2]           get_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
''                                                             set_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
''                                                             read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
''                                                             write_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
''---------------------------------------------------------------------------------
'' RXFIFO_STAT_RXFIFO_OVERRUN                 [1:1]            get_RXFIFO_STAT_RXFIFO_OVERRUN
''                                                             set_RXFIFO_STAT_RXFIFO_OVERRUN
''                                                             read_RXFIFO_STAT_RXFIFO_OVERRUN
''                                                             write_RXFIFO_STAT_RXFIFO_OVERRUN
''---------------------------------------------------------------------------------
'' RXFIFO_STAT_RXFIFO_UNDERRUN                [0:0]            get_RXFIFO_STAT_RXFIFO_UNDERRUN
''                                                             set_RXFIFO_STAT_RXFIFO_UNDERRUN
''                                                             read_RXFIFO_STAT_RXFIFO_UNDERRUN
''                                                             write_RXFIFO_STAT_RXFIFO_UNDERRUN
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_rxfifo_stat
    Private write_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value
    Private read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value
    Private flag_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
    Private write_RXFIFO_STAT_RXFIFO_OVERRUN_value
    Private read_RXFIFO_STAT_RXFIFO_OVERRUN_value
    Private flag_RXFIFO_STAT_RXFIFO_OVERRUN
    Private write_RXFIFO_STAT_RXFIFO_UNDERRUN_value
    Private read_RXFIFO_STAT_RXFIFO_UNDERRUN_value
    Private flag_RXFIFO_STAT_RXFIFO_UNDERRUN

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

    Property Get get_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
        get_RXFIFO_STAT_RXFIFO_STAT_RSVD_2 = read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value
    End Property

    Property Let set_RXFIFO_STAT_RXFIFO_STAT_RSVD_2(aData)
        write_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value = aData
        flag_RXFIFO_STAT_RXFIFO_STAT_RSVD_2        = &H1
    End Property

    Property Get read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
        read
        read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2 = read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value
    End Property

    Property Let write_RXFIFO_STAT_RXFIFO_STAT_RSVD_2(aData)
        set_RXFIFO_STAT_RXFIFO_STAT_RSVD_2 = aData
        write
    End Property

    Property Get get_RXFIFO_STAT_RXFIFO_OVERRUN
        get_RXFIFO_STAT_RXFIFO_OVERRUN = read_RXFIFO_STAT_RXFIFO_OVERRUN_value
    End Property

    Property Let set_RXFIFO_STAT_RXFIFO_OVERRUN(aData)
        write_RXFIFO_STAT_RXFIFO_OVERRUN_value = aData
        flag_RXFIFO_STAT_RXFIFO_OVERRUN        = &H1
    End Property

    Property Get read_RXFIFO_STAT_RXFIFO_OVERRUN
        read
        read_RXFIFO_STAT_RXFIFO_OVERRUN = read_RXFIFO_STAT_RXFIFO_OVERRUN_value
    End Property

    Property Let write_RXFIFO_STAT_RXFIFO_OVERRUN(aData)
        set_RXFIFO_STAT_RXFIFO_OVERRUN = aData
        write
    End Property

    Property Get get_RXFIFO_STAT_RXFIFO_UNDERRUN
        get_RXFIFO_STAT_RXFIFO_UNDERRUN = read_RXFIFO_STAT_RXFIFO_UNDERRUN_value
    End Property

    Property Let set_RXFIFO_STAT_RXFIFO_UNDERRUN(aData)
        write_RXFIFO_STAT_RXFIFO_UNDERRUN_value = aData
        flag_RXFIFO_STAT_RXFIFO_UNDERRUN        = &H1
    End Property

    Property Get read_RXFIFO_STAT_RXFIFO_UNDERRUN
        read
        read_RXFIFO_STAT_RXFIFO_UNDERRUN = read_RXFIFO_STAT_RXFIFO_UNDERRUN_value
    End Property

    Property Let write_RXFIFO_STAT_RXFIFO_UNDERRUN(aData)
        set_RXFIFO_STAT_RXFIFO_UNDERRUN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value = rightShift(data_low, 2) and &H3fffffff
        read_RXFIFO_STAT_RXFIFO_OVERRUN_value = rightShift(data_low, 1) and &H1
        RXFIFO_STAT_RXFIFO_UNDERRUN_mask = &H1
        if data_low > LONG_MAX then
            if RXFIFO_STAT_RXFIFO_UNDERRUN_mask = mask then
                read_RXFIFO_STAT_RXFIFO_UNDERRUN_value = data_low
            else
                read_RXFIFO_STAT_RXFIFO_UNDERRUN_value = (data_low - H8000_0000) and RXFIFO_STAT_RXFIFO_UNDERRUN_mask
            end If
        else
            read_RXFIFO_STAT_RXFIFO_UNDERRUN_value = data_low and RXFIFO_STAT_RXFIFO_UNDERRUN_mask
        end If

    End Sub

    Sub write
        If flag_RXFIFO_STAT_RXFIFO_STAT_RSVD_2 = &H0 or flag_RXFIFO_STAT_RXFIFO_OVERRUN = &H0 or flag_RXFIFO_STAT_RXFIFO_UNDERRUN = &H0 Then read
        If flag_RXFIFO_STAT_RXFIFO_STAT_RSVD_2 = &H0 Then write_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value = get_RXFIFO_STAT_RXFIFO_STAT_RSVD_2
        If flag_RXFIFO_STAT_RXFIFO_OVERRUN = &H0 Then write_RXFIFO_STAT_RXFIFO_OVERRUN_value = get_RXFIFO_STAT_RXFIFO_OVERRUN
        If flag_RXFIFO_STAT_RXFIFO_UNDERRUN = &H0 Then write_RXFIFO_STAT_RXFIFO_UNDERRUN_value = get_RXFIFO_STAT_RXFIFO_UNDERRUN

        regValue = leftShift((write_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value and &H3fffffff), 2) + leftShift((write_RXFIFO_STAT_RXFIFO_OVERRUN_value and &H1), 1) + leftShift((write_RXFIFO_STAT_RXFIFO_UNDERRUN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value = rightShift(data_low, 2) and &H3fffffff
        read_RXFIFO_STAT_RXFIFO_OVERRUN_value = rightShift(data_low, 1) and &H1
        RXFIFO_STAT_RXFIFO_UNDERRUN_mask = &H1
        if data_low > LONG_MAX then
            if RXFIFO_STAT_RXFIFO_UNDERRUN_mask = mask then
                read_RXFIFO_STAT_RXFIFO_UNDERRUN_value = data_low
            else
                read_RXFIFO_STAT_RXFIFO_UNDERRUN_value = (data_low - H8000_0000) and RXFIFO_STAT_RXFIFO_UNDERRUN_mask
            end If
        else
            read_RXFIFO_STAT_RXFIFO_UNDERRUN_value = data_low and RXFIFO_STAT_RXFIFO_UNDERRUN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXFIFO_STAT_RXFIFO_STAT_RSVD_2_value = &H0
        flag_RXFIFO_STAT_RXFIFO_STAT_RSVD_2        = &H0
        write_RXFIFO_STAT_RXFIFO_OVERRUN_value = &H0
        flag_RXFIFO_STAT_RXFIFO_OVERRUN        = &H0
        write_RXFIFO_STAT_RXFIFO_UNDERRUN_value = &H0
        flag_RXFIFO_STAT_RXFIFO_UNDERRUN        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_txfifo_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXFIFO_STAT_TXFIFO_STAT_RSVD_2             [31:2]           get_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
''                                                             set_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
''                                                             read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
''                                                             write_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
''---------------------------------------------------------------------------------
'' TXFIFO_STAT_TXFIFO_OVERRUN                 [1:1]            get_TXFIFO_STAT_TXFIFO_OVERRUN
''                                                             set_TXFIFO_STAT_TXFIFO_OVERRUN
''                                                             read_TXFIFO_STAT_TXFIFO_OVERRUN
''                                                             write_TXFIFO_STAT_TXFIFO_OVERRUN
''---------------------------------------------------------------------------------
'' TXFIFO_STAT_TXFIFO_UNDERRUN                [0:0]            get_TXFIFO_STAT_TXFIFO_UNDERRUN
''                                                             set_TXFIFO_STAT_TXFIFO_UNDERRUN
''                                                             read_TXFIFO_STAT_TXFIFO_UNDERRUN
''                                                             write_TXFIFO_STAT_TXFIFO_UNDERRUN
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_txfifo_stat
    Private write_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value
    Private read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value
    Private flag_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
    Private write_TXFIFO_STAT_TXFIFO_OVERRUN_value
    Private read_TXFIFO_STAT_TXFIFO_OVERRUN_value
    Private flag_TXFIFO_STAT_TXFIFO_OVERRUN
    Private write_TXFIFO_STAT_TXFIFO_UNDERRUN_value
    Private read_TXFIFO_STAT_TXFIFO_UNDERRUN_value
    Private flag_TXFIFO_STAT_TXFIFO_UNDERRUN

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

    Property Get get_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
        get_TXFIFO_STAT_TXFIFO_STAT_RSVD_2 = read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value
    End Property

    Property Let set_TXFIFO_STAT_TXFIFO_STAT_RSVD_2(aData)
        write_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value = aData
        flag_TXFIFO_STAT_TXFIFO_STAT_RSVD_2        = &H1
    End Property

    Property Get read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
        read
        read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2 = read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value
    End Property

    Property Let write_TXFIFO_STAT_TXFIFO_STAT_RSVD_2(aData)
        set_TXFIFO_STAT_TXFIFO_STAT_RSVD_2 = aData
        write
    End Property

    Property Get get_TXFIFO_STAT_TXFIFO_OVERRUN
        get_TXFIFO_STAT_TXFIFO_OVERRUN = read_TXFIFO_STAT_TXFIFO_OVERRUN_value
    End Property

    Property Let set_TXFIFO_STAT_TXFIFO_OVERRUN(aData)
        write_TXFIFO_STAT_TXFIFO_OVERRUN_value = aData
        flag_TXFIFO_STAT_TXFIFO_OVERRUN        = &H1
    End Property

    Property Get read_TXFIFO_STAT_TXFIFO_OVERRUN
        read
        read_TXFIFO_STAT_TXFIFO_OVERRUN = read_TXFIFO_STAT_TXFIFO_OVERRUN_value
    End Property

    Property Let write_TXFIFO_STAT_TXFIFO_OVERRUN(aData)
        set_TXFIFO_STAT_TXFIFO_OVERRUN = aData
        write
    End Property

    Property Get get_TXFIFO_STAT_TXFIFO_UNDERRUN
        get_TXFIFO_STAT_TXFIFO_UNDERRUN = read_TXFIFO_STAT_TXFIFO_UNDERRUN_value
    End Property

    Property Let set_TXFIFO_STAT_TXFIFO_UNDERRUN(aData)
        write_TXFIFO_STAT_TXFIFO_UNDERRUN_value = aData
        flag_TXFIFO_STAT_TXFIFO_UNDERRUN        = &H1
    End Property

    Property Get read_TXFIFO_STAT_TXFIFO_UNDERRUN
        read
        read_TXFIFO_STAT_TXFIFO_UNDERRUN = read_TXFIFO_STAT_TXFIFO_UNDERRUN_value
    End Property

    Property Let write_TXFIFO_STAT_TXFIFO_UNDERRUN(aData)
        set_TXFIFO_STAT_TXFIFO_UNDERRUN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value = rightShift(data_low, 2) and &H3fffffff
        read_TXFIFO_STAT_TXFIFO_OVERRUN_value = rightShift(data_low, 1) and &H1
        TXFIFO_STAT_TXFIFO_UNDERRUN_mask = &H1
        if data_low > LONG_MAX then
            if TXFIFO_STAT_TXFIFO_UNDERRUN_mask = mask then
                read_TXFIFO_STAT_TXFIFO_UNDERRUN_value = data_low
            else
                read_TXFIFO_STAT_TXFIFO_UNDERRUN_value = (data_low - H8000_0000) and TXFIFO_STAT_TXFIFO_UNDERRUN_mask
            end If
        else
            read_TXFIFO_STAT_TXFIFO_UNDERRUN_value = data_low and TXFIFO_STAT_TXFIFO_UNDERRUN_mask
        end If

    End Sub

    Sub write
        If flag_TXFIFO_STAT_TXFIFO_STAT_RSVD_2 = &H0 or flag_TXFIFO_STAT_TXFIFO_OVERRUN = &H0 or flag_TXFIFO_STAT_TXFIFO_UNDERRUN = &H0 Then read
        If flag_TXFIFO_STAT_TXFIFO_STAT_RSVD_2 = &H0 Then write_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value = get_TXFIFO_STAT_TXFIFO_STAT_RSVD_2
        If flag_TXFIFO_STAT_TXFIFO_OVERRUN = &H0 Then write_TXFIFO_STAT_TXFIFO_OVERRUN_value = get_TXFIFO_STAT_TXFIFO_OVERRUN
        If flag_TXFIFO_STAT_TXFIFO_UNDERRUN = &H0 Then write_TXFIFO_STAT_TXFIFO_UNDERRUN_value = get_TXFIFO_STAT_TXFIFO_UNDERRUN

        regValue = leftShift((write_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value and &H3fffffff), 2) + leftShift((write_TXFIFO_STAT_TXFIFO_OVERRUN_value and &H1), 1) + leftShift((write_TXFIFO_STAT_TXFIFO_UNDERRUN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value = rightShift(data_low, 2) and &H3fffffff
        read_TXFIFO_STAT_TXFIFO_OVERRUN_value = rightShift(data_low, 1) and &H1
        TXFIFO_STAT_TXFIFO_UNDERRUN_mask = &H1
        if data_low > LONG_MAX then
            if TXFIFO_STAT_TXFIFO_UNDERRUN_mask = mask then
                read_TXFIFO_STAT_TXFIFO_UNDERRUN_value = data_low
            else
                read_TXFIFO_STAT_TXFIFO_UNDERRUN_value = (data_low - H8000_0000) and TXFIFO_STAT_TXFIFO_UNDERRUN_mask
            end If
        else
            read_TXFIFO_STAT_TXFIFO_UNDERRUN_value = data_low and TXFIFO_STAT_TXFIFO_UNDERRUN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXFIFO_STAT_TXFIFO_STAT_RSVD_2_value = &H0
        flag_TXFIFO_STAT_TXFIFO_STAT_RSVD_2        = &H0
        write_TXFIFO_STAT_TXFIFO_OVERRUN_value = &H0
        flag_TXFIFO_STAT_TXFIFO_OVERRUN        = &H0
        write_TXFIFO_STAT_TXFIFO_UNDERRUN_value = &H0
        flag_TXFIFO_STAT_TXFIFO_UNDERRUN        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_pfc_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5           [31:6]           get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
''                                                             set_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
''                                                             read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
''                                                             write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
''---------------------------------------------------------------------------------
'' MAC_PFC_CTRL_PFC_STATS_EN                  [5:5]            get_MAC_PFC_CTRL_PFC_STATS_EN
''                                                             set_MAC_PFC_CTRL_PFC_STATS_EN
''                                                             read_MAC_PFC_CTRL_PFC_STATS_EN
''                                                             write_MAC_PFC_CTRL_PFC_STATS_EN
''---------------------------------------------------------------------------------
'' MAC_PFC_CTRL_RX_PASS_PFC_FRM               [4:4]            get_MAC_PFC_CTRL_RX_PASS_PFC_FRM
''                                                             set_MAC_PFC_CTRL_RX_PASS_PFC_FRM
''                                                             read_MAC_PFC_CTRL_RX_PASS_PFC_FRM
''                                                             write_MAC_PFC_CTRL_RX_PASS_PFC_FRM
''---------------------------------------------------------------------------------
'' MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3           [3:3]            get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
''                                                             set_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
''                                                             read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
''                                                             write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
''---------------------------------------------------------------------------------
'' MAC_PFC_CTRL_FORCE_PFC_XON                 [2:2]            get_MAC_PFC_CTRL_FORCE_PFC_XON
''                                                             set_MAC_PFC_CTRL_FORCE_PFC_XON
''                                                             read_MAC_PFC_CTRL_FORCE_PFC_XON
''                                                             write_MAC_PFC_CTRL_FORCE_PFC_XON
''---------------------------------------------------------------------------------
'' MAC_PFC_CTRL_PFC_RX_ENBL                   [1:1]            get_MAC_PFC_CTRL_PFC_RX_ENBL
''                                                             set_MAC_PFC_CTRL_PFC_RX_ENBL
''                                                             read_MAC_PFC_CTRL_PFC_RX_ENBL
''                                                             write_MAC_PFC_CTRL_PFC_RX_ENBL
''---------------------------------------------------------------------------------
'' MAC_PFC_CTRL_PFC_TX_ENBL                   [0:0]            get_MAC_PFC_CTRL_PFC_TX_ENBL
''                                                             set_MAC_PFC_CTRL_PFC_TX_ENBL
''                                                             read_MAC_PFC_CTRL_PFC_TX_ENBL
''                                                             write_MAC_PFC_CTRL_PFC_TX_ENBL
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_pfc_ctrl
    Private write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value
    Private read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value
    Private flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
    Private write_MAC_PFC_CTRL_PFC_STATS_EN_value
    Private read_MAC_PFC_CTRL_PFC_STATS_EN_value
    Private flag_MAC_PFC_CTRL_PFC_STATS_EN
    Private write_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value
    Private read_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value
    Private flag_MAC_PFC_CTRL_RX_PASS_PFC_FRM
    Private write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value
    Private read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value
    Private flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
    Private write_MAC_PFC_CTRL_FORCE_PFC_XON_value
    Private read_MAC_PFC_CTRL_FORCE_PFC_XON_value
    Private flag_MAC_PFC_CTRL_FORCE_PFC_XON
    Private write_MAC_PFC_CTRL_PFC_RX_ENBL_value
    Private read_MAC_PFC_CTRL_PFC_RX_ENBL_value
    Private flag_MAC_PFC_CTRL_PFC_RX_ENBL
    Private write_MAC_PFC_CTRL_PFC_TX_ENBL_value
    Private read_MAC_PFC_CTRL_PFC_TX_ENBL_value
    Private flag_MAC_PFC_CTRL_PFC_TX_ENBL

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

    Property Get get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
        get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5 = read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value
    End Property

    Property Let set_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5(aData)
        write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value = aData
        flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5        = &H1
    End Property

    Property Get read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
        read
        read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5 = read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value
    End Property

    Property Let write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5(aData)
        set_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5 = aData
        write
    End Property

    Property Get get_MAC_PFC_CTRL_PFC_STATS_EN
        get_MAC_PFC_CTRL_PFC_STATS_EN = read_MAC_PFC_CTRL_PFC_STATS_EN_value
    End Property

    Property Let set_MAC_PFC_CTRL_PFC_STATS_EN(aData)
        write_MAC_PFC_CTRL_PFC_STATS_EN_value = aData
        flag_MAC_PFC_CTRL_PFC_STATS_EN        = &H1
    End Property

    Property Get read_MAC_PFC_CTRL_PFC_STATS_EN
        read
        read_MAC_PFC_CTRL_PFC_STATS_EN = read_MAC_PFC_CTRL_PFC_STATS_EN_value
    End Property

    Property Let write_MAC_PFC_CTRL_PFC_STATS_EN(aData)
        set_MAC_PFC_CTRL_PFC_STATS_EN = aData
        write
    End Property

    Property Get get_MAC_PFC_CTRL_RX_PASS_PFC_FRM
        get_MAC_PFC_CTRL_RX_PASS_PFC_FRM = read_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value
    End Property

    Property Let set_MAC_PFC_CTRL_RX_PASS_PFC_FRM(aData)
        write_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value = aData
        flag_MAC_PFC_CTRL_RX_PASS_PFC_FRM        = &H1
    End Property

    Property Get read_MAC_PFC_CTRL_RX_PASS_PFC_FRM
        read
        read_MAC_PFC_CTRL_RX_PASS_PFC_FRM = read_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value
    End Property

    Property Let write_MAC_PFC_CTRL_RX_PASS_PFC_FRM(aData)
        set_MAC_PFC_CTRL_RX_PASS_PFC_FRM = aData
        write
    End Property

    Property Get get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
        get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3 = read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value
    End Property

    Property Let set_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3(aData)
        write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value = aData
        flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3        = &H1
    End Property

    Property Get read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
        read
        read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3 = read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value
    End Property

    Property Let write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3(aData)
        set_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3 = aData
        write
    End Property

    Property Get get_MAC_PFC_CTRL_FORCE_PFC_XON
        get_MAC_PFC_CTRL_FORCE_PFC_XON = read_MAC_PFC_CTRL_FORCE_PFC_XON_value
    End Property

    Property Let set_MAC_PFC_CTRL_FORCE_PFC_XON(aData)
        write_MAC_PFC_CTRL_FORCE_PFC_XON_value = aData
        flag_MAC_PFC_CTRL_FORCE_PFC_XON        = &H1
    End Property

    Property Get read_MAC_PFC_CTRL_FORCE_PFC_XON
        read
        read_MAC_PFC_CTRL_FORCE_PFC_XON = read_MAC_PFC_CTRL_FORCE_PFC_XON_value
    End Property

    Property Let write_MAC_PFC_CTRL_FORCE_PFC_XON(aData)
        set_MAC_PFC_CTRL_FORCE_PFC_XON = aData
        write
    End Property

    Property Get get_MAC_PFC_CTRL_PFC_RX_ENBL
        get_MAC_PFC_CTRL_PFC_RX_ENBL = read_MAC_PFC_CTRL_PFC_RX_ENBL_value
    End Property

    Property Let set_MAC_PFC_CTRL_PFC_RX_ENBL(aData)
        write_MAC_PFC_CTRL_PFC_RX_ENBL_value = aData
        flag_MAC_PFC_CTRL_PFC_RX_ENBL        = &H1
    End Property

    Property Get read_MAC_PFC_CTRL_PFC_RX_ENBL
        read
        read_MAC_PFC_CTRL_PFC_RX_ENBL = read_MAC_PFC_CTRL_PFC_RX_ENBL_value
    End Property

    Property Let write_MAC_PFC_CTRL_PFC_RX_ENBL(aData)
        set_MAC_PFC_CTRL_PFC_RX_ENBL = aData
        write
    End Property

    Property Get get_MAC_PFC_CTRL_PFC_TX_ENBL
        get_MAC_PFC_CTRL_PFC_TX_ENBL = read_MAC_PFC_CTRL_PFC_TX_ENBL_value
    End Property

    Property Let set_MAC_PFC_CTRL_PFC_TX_ENBL(aData)
        write_MAC_PFC_CTRL_PFC_TX_ENBL_value = aData
        flag_MAC_PFC_CTRL_PFC_TX_ENBL        = &H1
    End Property

    Property Get read_MAC_PFC_CTRL_PFC_TX_ENBL
        read
        read_MAC_PFC_CTRL_PFC_TX_ENBL = read_MAC_PFC_CTRL_PFC_TX_ENBL_value
    End Property

    Property Let write_MAC_PFC_CTRL_PFC_TX_ENBL(aData)
        set_MAC_PFC_CTRL_PFC_TX_ENBL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value = rightShift(data_low, 6) and &H3ffffff
        read_MAC_PFC_CTRL_PFC_STATS_EN_value = rightShift(data_low, 5) and &H1
        read_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value = rightShift(data_low, 4) and &H1
        read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value = rightShift(data_low, 3) and &H1
        read_MAC_PFC_CTRL_FORCE_PFC_XON_value = rightShift(data_low, 2) and &H1
        read_MAC_PFC_CTRL_PFC_RX_ENBL_value = rightShift(data_low, 1) and &H1
        MAC_PFC_CTRL_PFC_TX_ENBL_mask = &H1
        if data_low > LONG_MAX then
            if MAC_PFC_CTRL_PFC_TX_ENBL_mask = mask then
                read_MAC_PFC_CTRL_PFC_TX_ENBL_value = data_low
            else
                read_MAC_PFC_CTRL_PFC_TX_ENBL_value = (data_low - H8000_0000) and MAC_PFC_CTRL_PFC_TX_ENBL_mask
            end If
        else
            read_MAC_PFC_CTRL_PFC_TX_ENBL_value = data_low and MAC_PFC_CTRL_PFC_TX_ENBL_mask
        end If

    End Sub

    Sub write
        If flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5 = &H0 or flag_MAC_PFC_CTRL_PFC_STATS_EN = &H0 or flag_MAC_PFC_CTRL_RX_PASS_PFC_FRM = &H0 or flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3 = &H0 or flag_MAC_PFC_CTRL_FORCE_PFC_XON = &H0 or flag_MAC_PFC_CTRL_PFC_RX_ENBL = &H0 or flag_MAC_PFC_CTRL_PFC_TX_ENBL = &H0 Then read
        If flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5 = &H0 Then write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value = get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5
        If flag_MAC_PFC_CTRL_PFC_STATS_EN = &H0 Then write_MAC_PFC_CTRL_PFC_STATS_EN_value = get_MAC_PFC_CTRL_PFC_STATS_EN
        If flag_MAC_PFC_CTRL_RX_PASS_PFC_FRM = &H0 Then write_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value = get_MAC_PFC_CTRL_RX_PASS_PFC_FRM
        If flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3 = &H0 Then write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value = get_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3
        If flag_MAC_PFC_CTRL_FORCE_PFC_XON = &H0 Then write_MAC_PFC_CTRL_FORCE_PFC_XON_value = get_MAC_PFC_CTRL_FORCE_PFC_XON
        If flag_MAC_PFC_CTRL_PFC_RX_ENBL = &H0 Then write_MAC_PFC_CTRL_PFC_RX_ENBL_value = get_MAC_PFC_CTRL_PFC_RX_ENBL
        If flag_MAC_PFC_CTRL_PFC_TX_ENBL = &H0 Then write_MAC_PFC_CTRL_PFC_TX_ENBL_value = get_MAC_PFC_CTRL_PFC_TX_ENBL

        regValue = leftShift((write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value and &H3ffffff), 6) + leftShift((write_MAC_PFC_CTRL_PFC_STATS_EN_value and &H1), 5) + leftShift((write_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value and &H1), 4) + leftShift((write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value and &H1), 3) + leftShift((write_MAC_PFC_CTRL_FORCE_PFC_XON_value and &H1), 2) + leftShift((write_MAC_PFC_CTRL_PFC_RX_ENBL_value and &H1), 1) + leftShift((write_MAC_PFC_CTRL_PFC_TX_ENBL_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value = rightShift(data_low, 6) and &H3ffffff
        read_MAC_PFC_CTRL_PFC_STATS_EN_value = rightShift(data_low, 5) and &H1
        read_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value = rightShift(data_low, 4) and &H1
        read_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value = rightShift(data_low, 3) and &H1
        read_MAC_PFC_CTRL_FORCE_PFC_XON_value = rightShift(data_low, 2) and &H1
        read_MAC_PFC_CTRL_PFC_RX_ENBL_value = rightShift(data_low, 1) and &H1
        MAC_PFC_CTRL_PFC_TX_ENBL_mask = &H1
        if data_low > LONG_MAX then
            if MAC_PFC_CTRL_PFC_TX_ENBL_mask = mask then
                read_MAC_PFC_CTRL_PFC_TX_ENBL_value = data_low
            else
                read_MAC_PFC_CTRL_PFC_TX_ENBL_value = (data_low - H8000_0000) and MAC_PFC_CTRL_PFC_TX_ENBL_mask
            end If
        else
            read_MAC_PFC_CTRL_PFC_TX_ENBL_value = data_low and MAC_PFC_CTRL_PFC_TX_ENBL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5_value = &H0
        flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_5        = &H0
        write_MAC_PFC_CTRL_PFC_STATS_EN_value = &H0
        flag_MAC_PFC_CTRL_PFC_STATS_EN        = &H0
        write_MAC_PFC_CTRL_RX_PASS_PFC_FRM_value = &H0
        flag_MAC_PFC_CTRL_RX_PASS_PFC_FRM        = &H0
        write_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3_value = &H0
        flag_MAC_PFC_CTRL_MAC_PFC_CTRL_RSVD_3        = &H0
        write_MAC_PFC_CTRL_FORCE_PFC_XON_value = &H0
        flag_MAC_PFC_CTRL_FORCE_PFC_XON        = &H0
        write_MAC_PFC_CTRL_PFC_RX_ENBL_value = &H0
        flag_MAC_PFC_CTRL_PFC_RX_ENBL        = &H0
        write_MAC_PFC_CTRL_PFC_TX_ENBL_value = &H0
        flag_MAC_PFC_CTRL_PFC_TX_ENBL        = &H0
    End Sub
End Class


'' @REGISTER : UNIMAC_line_unimac_mac_pfc_refresh_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER     [31:16]          get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
''                                                             set_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
''                                                             read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
''                                                             write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
''---------------------------------------------------------------------------------
'' MPRCMPRCR1                                 [15:1]           get_MPRCMPRCR1
''                                                             set_MPRCMPRCR1
''                                                             read_MPRCMPRCR1
''                                                             write_MPRCMPRCR1
''---------------------------------------------------------------------------------
'' MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN        [0:0]            get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN
''                                                             set_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN
''                                                             read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN
''                                                             write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN
''---------------------------------------------------------------------------------
Class REGISTER_UNIMAC_line_unimac_mac_pfc_refresh_ctrl
    Private write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value
    Private read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value
    Private flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
    Private write_MPRCMPRCR1_value
    Private read_MPRCMPRCR1_value
    Private flag_MPRCMPRCR1
    Private write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value
    Private read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value
    Private flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN

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

    Property Get get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
        get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER = read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value
    End Property

    Property Let set_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER(aData)
        write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value = aData
        flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER        = &H1
    End Property

    Property Get read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
        read
        read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER = read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value
    End Property

    Property Let write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER(aData)
        set_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER = aData
        write
    End Property

    Property Get get_MPRCMPRCR1
        get_MPRCMPRCR1 = read_MPRCMPRCR1_value
    End Property

    Property Let set_MPRCMPRCR1(aData)
        write_MPRCMPRCR1_value = aData
        flag_MPRCMPRCR1        = &H1
    End Property

    Property Get read_MPRCMPRCR1
        read
        read_MPRCMPRCR1 = read_MPRCMPRCR1_value
    End Property

    Property Let write_MPRCMPRCR1(aData)
        set_MPRCMPRCR1 = aData
        write
    End Property

    Property Get get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN
        get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN = read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value
    End Property

    Property Let set_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN(aData)
        write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = aData
        flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN        = &H1
    End Property

    Property Get read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN
        read
        read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN = read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value
    End Property

    Property Let write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN(aData)
        set_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value = rightShift(data_low, 16) and &Hffff
        read_MPRCMPRCR1_value = rightShift(data_low, 1) and &H7fff
        MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask = &H1
        if data_low > LONG_MAX then
            if MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask = mask then
                read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = data_low
            else
                read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = (data_low - H8000_0000) and MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask
            end If
        else
            read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = data_low and MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask
        end If

    End Sub

    Sub write
        If flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER = &H0 or flag_MPRCMPRCR1 = &H0 or flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN = &H0 Then read
        If flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER = &H0 Then write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value = get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER
        If flag_MPRCMPRCR1 = &H0 Then write_MPRCMPRCR1_value = get_MPRCMPRCR1
        If flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN = &H0 Then write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = get_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN

        regValue = leftShift((write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value and &Hffff), 16) + leftShift((write_MPRCMPRCR1_value and &H7fff), 1) + leftShift((write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value = rightShift(data_low, 16) and &Hffff
        read_MPRCMPRCR1_value = rightShift(data_low, 1) and &H7fff
        MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask = &H1
        if data_low > LONG_MAX then
            if MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask = mask then
                read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = data_low
            else
                read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = (data_low - H8000_0000) and MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask
            end If
        else
            read_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = data_low and MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER_value = &H0
        flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_TIMER        = &H0
        write_MPRCMPRCR1_value = &H0
        flag_MPRCMPRCR1        = &H0
        write_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN_value = &H0
        flag_MAC_PFC_REFRESH_CTRL_PFC_REFRESH_EN        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class UNIMAC_INSTANCE

    Public line_unimac_ipg_hd_bkp_cntl
    Public line_unimac_command_config
    Public line_unimac_mac_0
    Public line_unimac_mac_1
    Public line_unimac_frm_length
    Public line_unimac_pause_quant
    Public line_unimac_tx_ts_seq_id
    Public line_unimac_sfd_offset
    Public line_unimac_mac_mode
    Public line_unimac_tag_0
    Public line_unimac_tag_1
    Public line_unimac_rx_pause_quanta_scale
    Public line_unimac_tx_preamble
    Public line_unimac_tx_ipg_length
    Public line_unimac_pfc_xoff_timer
    Public line_unimac_umac_eee_ctrl
    Public line_unimac_mii_eee_delay_entry_timer
    Public line_unimac_gmii_eee_delay_entry_timer
    Public line_unimac_umac_eee_ref_count
    Public line_unimac_umac_timestamp_adjust
    Public line_unimac_umac_rx_pkt_drop_status
    Public line_unimac_umac_symmetric_idle_threshold
    Public line_unimac_mii_eee_wake_timer
    Public line_unimac_gmii_eee_wake_timer
    Public line_unimac_umac_rev_id
    Public line_unimac_mac_pfc_type
    Public line_unimac_mac_pfc_opcode
    Public line_unimac_mac_pfc_da_0
    Public line_unimac_mac_pfc_da_1
    Public line_unimac_macsec_prog_tx_crc
    Public line_unimac_macsec_cntrl
    Public line_unimac_ts_status_cntrl
    Public line_unimac_tx_ts_data
    Public line_unimac_pause_control
    Public line_unimac_flush_control
    Public line_unimac_rxfifo_stat
    Public line_unimac_txfifo_stat
    Public line_unimac_mac_pfc_ctrl
    Public line_unimac_mac_pfc_refresh_ctrl


    Public default function Init(aBaseAddr)
        Set line_unimac_ipg_hd_bkp_cntl = (New REGISTER_UNIMAC_line_unimac_ipg_hd_bkp_cntl)(aBaseAddr, 32)
        Set line_unimac_command_config = (New REGISTER_UNIMAC_line_unimac_command_config)(aBaseAddr, 32)
        Set line_unimac_mac_0 = (New REGISTER_UNIMAC_line_unimac_mac_0)(aBaseAddr, 32)
        Set line_unimac_mac_1 = (New REGISTER_UNIMAC_line_unimac_mac_1)(aBaseAddr, 32)
        Set line_unimac_frm_length = (New REGISTER_UNIMAC_line_unimac_frm_length)(aBaseAddr, 32)
        Set line_unimac_pause_quant = (New REGISTER_UNIMAC_line_unimac_pause_quant)(aBaseAddr, 32)
        Set line_unimac_tx_ts_seq_id = (New REGISTER_UNIMAC_line_unimac_tx_ts_seq_id)(aBaseAddr, 32)
        Set line_unimac_sfd_offset = (New REGISTER_UNIMAC_line_unimac_sfd_offset)(aBaseAddr, 32)
        Set line_unimac_mac_mode = (New REGISTER_UNIMAC_line_unimac_mac_mode)(aBaseAddr, 32)
        Set line_unimac_tag_0 = (New REGISTER_UNIMAC_line_unimac_tag_0)(aBaseAddr, 32)
        Set line_unimac_tag_1 = (New REGISTER_UNIMAC_line_unimac_tag_1)(aBaseAddr, 32)
        Set line_unimac_rx_pause_quanta_scale = (New REGISTER_UNIMAC_line_unimac_rx_pause_quanta_scale)(aBaseAddr, 32)
        Set line_unimac_tx_preamble = (New REGISTER_UNIMAC_line_unimac_tx_preamble)(aBaseAddr, 32)
        Set line_unimac_tx_ipg_length = (New REGISTER_UNIMAC_line_unimac_tx_ipg_length)(aBaseAddr, 32)
        Set line_unimac_pfc_xoff_timer = (New REGISTER_UNIMAC_line_unimac_pfc_xoff_timer)(aBaseAddr, 32)
        Set line_unimac_umac_eee_ctrl = (New REGISTER_UNIMAC_line_unimac_umac_eee_ctrl)(aBaseAddr, 32)
        Set line_unimac_mii_eee_delay_entry_timer = (New REGISTER_UNIMAC_line_unimac_mii_eee_delay_entry_timer)(aBaseAddr, 32)
        Set line_unimac_gmii_eee_delay_entry_timer = (New REGISTER_UNIMAC_line_unimac_gmii_eee_delay_entry_timer)(aBaseAddr, 32)
        Set line_unimac_umac_eee_ref_count = (New REGISTER_UNIMAC_line_unimac_umac_eee_ref_count)(aBaseAddr, 32)
        Set line_unimac_umac_timestamp_adjust = (New REGISTER_UNIMAC_line_unimac_umac_timestamp_adjust)(aBaseAddr, 32)
        Set line_unimac_umac_rx_pkt_drop_status = (New REGISTER_UNIMAC_line_unimac_umac_rx_pkt_drop_status)(aBaseAddr, 32)
        Set line_unimac_umac_symmetric_idle_threshold = (New REGISTER_UNIMAC_line_unimac_umac_symmetric_idle_threshold)(aBaseAddr, 32)
        Set line_unimac_mii_eee_wake_timer = (New REGISTER_UNIMAC_line_unimac_mii_eee_wake_timer)(aBaseAddr, 32)
        Set line_unimac_gmii_eee_wake_timer = (New REGISTER_UNIMAC_line_unimac_gmii_eee_wake_timer)(aBaseAddr, 32)
        Set line_unimac_umac_rev_id = (New REGISTER_UNIMAC_line_unimac_umac_rev_id)(aBaseAddr, 32)
        Set line_unimac_mac_pfc_type = (New REGISTER_UNIMAC_line_unimac_mac_pfc_type)(aBaseAddr, 32)
        Set line_unimac_mac_pfc_opcode = (New REGISTER_UNIMAC_line_unimac_mac_pfc_opcode)(aBaseAddr, 32)
        Set line_unimac_mac_pfc_da_0 = (New REGISTER_UNIMAC_line_unimac_mac_pfc_da_0)(aBaseAddr, 32)
        Set line_unimac_mac_pfc_da_1 = (New REGISTER_UNIMAC_line_unimac_mac_pfc_da_1)(aBaseAddr, 32)
        Set line_unimac_macsec_prog_tx_crc = (New REGISTER_UNIMAC_line_unimac_macsec_prog_tx_crc)(aBaseAddr, 32)
        Set line_unimac_macsec_cntrl = (New REGISTER_UNIMAC_line_unimac_macsec_cntrl)(aBaseAddr, 32)
        Set line_unimac_ts_status_cntrl = (New REGISTER_UNIMAC_line_unimac_ts_status_cntrl)(aBaseAddr, 32)
        Set line_unimac_tx_ts_data = (New REGISTER_UNIMAC_line_unimac_tx_ts_data)(aBaseAddr, 32)
        Set line_unimac_pause_control = (New REGISTER_UNIMAC_line_unimac_pause_control)(aBaseAddr, 32)
        Set line_unimac_flush_control = (New REGISTER_UNIMAC_line_unimac_flush_control)(aBaseAddr, 32)
        Set line_unimac_rxfifo_stat = (New REGISTER_UNIMAC_line_unimac_rxfifo_stat)(aBaseAddr, 32)
        Set line_unimac_txfifo_stat = (New REGISTER_UNIMAC_line_unimac_txfifo_stat)(aBaseAddr, 32)
        Set line_unimac_mac_pfc_ctrl = (New REGISTER_UNIMAC_line_unimac_mac_pfc_ctrl)(aBaseAddr, 32)
        Set line_unimac_mac_pfc_refresh_ctrl = (New REGISTER_UNIMAC_line_unimac_mac_pfc_refresh_ctrl)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set UNIMAC = CreateObject("System.Collections.ArrayList")
UNIMAC.Add ((New UNIMAC_INSTANCE)(&H4b014000))
UNIMAC.Add ((New UNIMAC_INSTANCE)(&H4b015000))


