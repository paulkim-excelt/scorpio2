

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


'' @REGISTER : AFE_DIG_afe_misc_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVE_1510                               [15:10]          get_RESERVE_1510
''                                                             set_RESERVE_1510
''                                                             read_RESERVE_1510
''                                                             write_RESERVE_1510
''---------------------------------------------------------------------------------
'' PASSIVE_TERM_EN_OV                         [9:9]            get_PASSIVE_TERM_EN_OV
''                                                             set_PASSIVE_TERM_EN_OV
''                                                             read_PASSIVE_TERM_EN_OV
''                                                             write_PASSIVE_TERM_EN_OV
''---------------------------------------------------------------------------------
'' PASSIVE_TERM_EN                            [8:8]            get_PASSIVE_TERM_EN
''                                                             set_PASSIVE_TERM_EN
''                                                             read_PASSIVE_TERM_EN
''                                                             write_PASSIVE_TERM_EN
''---------------------------------------------------------------------------------
'' RESET_CAL_OV                               [7:7]            get_RESET_CAL_OV
''                                                             set_RESET_CAL_OV
''                                                             read_RESET_CAL_OV
''                                                             write_RESET_CAL_OV
''---------------------------------------------------------------------------------
'' RESET_CAL                                  [6:6]            get_RESET_CAL
''                                                             set_RESET_CAL
''                                                             read_RESET_CAL
''                                                             write_RESET_CAL
''---------------------------------------------------------------------------------
'' RX_PWRDWN_OV                               [5:5]            get_RX_PWRDWN_OV
''                                                             set_RX_PWRDWN_OV
''                                                             read_RX_PWRDWN_OV
''                                                             write_RX_PWRDWN_OV
''---------------------------------------------------------------------------------
'' RX_PWRDWN                                  [4:4]            get_RX_PWRDWN
''                                                             set_RX_PWRDWN
''                                                             read_RX_PWRDWN
''                                                             write_RX_PWRDWN
''---------------------------------------------------------------------------------
'' RX_RESETB_OV                               [3:3]            get_RX_RESETB_OV
''                                                             set_RX_RESETB_OV
''                                                             read_RX_RESETB_OV
''                                                             write_RX_RESETB_OV
''---------------------------------------------------------------------------------
'' RX_RESETB                                  [2:2]            get_RX_RESETB
''                                                             set_RX_RESETB
''                                                             read_RX_RESETB
''                                                             write_RX_RESETB
''---------------------------------------------------------------------------------
'' TX_PWRDWN_OV                               [1:1]            get_TX_PWRDWN_OV
''                                                             set_TX_PWRDWN_OV
''                                                             read_TX_PWRDWN_OV
''                                                             write_TX_PWRDWN_OV
''---------------------------------------------------------------------------------
'' TX_PWRDWN                                  [0:0]            get_TX_PWRDWN
''                                                             set_TX_PWRDWN
''                                                             read_TX_PWRDWN
''                                                             write_TX_PWRDWN
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_misc_ctrl
    Private write_RESERVE_1510_value
    Private read_RESERVE_1510_value
    Private flag_RESERVE_1510
    Private write_PASSIVE_TERM_EN_OV_value
    Private read_PASSIVE_TERM_EN_OV_value
    Private flag_PASSIVE_TERM_EN_OV
    Private write_PASSIVE_TERM_EN_value
    Private read_PASSIVE_TERM_EN_value
    Private flag_PASSIVE_TERM_EN
    Private write_RESET_CAL_OV_value
    Private read_RESET_CAL_OV_value
    Private flag_RESET_CAL_OV
    Private write_RESET_CAL_value
    Private read_RESET_CAL_value
    Private flag_RESET_CAL
    Private write_RX_PWRDWN_OV_value
    Private read_RX_PWRDWN_OV_value
    Private flag_RX_PWRDWN_OV
    Private write_RX_PWRDWN_value
    Private read_RX_PWRDWN_value
    Private flag_RX_PWRDWN
    Private write_RX_RESETB_OV_value
    Private read_RX_RESETB_OV_value
    Private flag_RX_RESETB_OV
    Private write_RX_RESETB_value
    Private read_RX_RESETB_value
    Private flag_RX_RESETB
    Private write_TX_PWRDWN_OV_value
    Private read_TX_PWRDWN_OV_value
    Private flag_TX_PWRDWN_OV
    Private write_TX_PWRDWN_value
    Private read_TX_PWRDWN_value
    Private flag_TX_PWRDWN

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

    Property Get get_RESERVE_1510
        get_RESERVE_1510 = read_RESERVE_1510_value
    End Property

    Property Let set_RESERVE_1510(aData)
        write_RESERVE_1510_value = aData
        flag_RESERVE_1510        = &H1
    End Property

    Property Get read_RESERVE_1510
        read
        read_RESERVE_1510 = read_RESERVE_1510_value
    End Property

    Property Let write_RESERVE_1510(aData)
        set_RESERVE_1510 = aData
        write
    End Property

    Property Get get_PASSIVE_TERM_EN_OV
        get_PASSIVE_TERM_EN_OV = read_PASSIVE_TERM_EN_OV_value
    End Property

    Property Let set_PASSIVE_TERM_EN_OV(aData)
        write_PASSIVE_TERM_EN_OV_value = aData
        flag_PASSIVE_TERM_EN_OV        = &H1
    End Property

    Property Get read_PASSIVE_TERM_EN_OV
        read
        read_PASSIVE_TERM_EN_OV = read_PASSIVE_TERM_EN_OV_value
    End Property

    Property Let write_PASSIVE_TERM_EN_OV(aData)
        set_PASSIVE_TERM_EN_OV = aData
        write
    End Property

    Property Get get_PASSIVE_TERM_EN
        get_PASSIVE_TERM_EN = read_PASSIVE_TERM_EN_value
    End Property

    Property Let set_PASSIVE_TERM_EN(aData)
        write_PASSIVE_TERM_EN_value = aData
        flag_PASSIVE_TERM_EN        = &H1
    End Property

    Property Get read_PASSIVE_TERM_EN
        read
        read_PASSIVE_TERM_EN = read_PASSIVE_TERM_EN_value
    End Property

    Property Let write_PASSIVE_TERM_EN(aData)
        set_PASSIVE_TERM_EN = aData
        write
    End Property

    Property Get get_RESET_CAL_OV
        get_RESET_CAL_OV = read_RESET_CAL_OV_value
    End Property

    Property Let set_RESET_CAL_OV(aData)
        write_RESET_CAL_OV_value = aData
        flag_RESET_CAL_OV        = &H1
    End Property

    Property Get read_RESET_CAL_OV
        read
        read_RESET_CAL_OV = read_RESET_CAL_OV_value
    End Property

    Property Let write_RESET_CAL_OV(aData)
        set_RESET_CAL_OV = aData
        write
    End Property

    Property Get get_RESET_CAL
        get_RESET_CAL = read_RESET_CAL_value
    End Property

    Property Let set_RESET_CAL(aData)
        write_RESET_CAL_value = aData
        flag_RESET_CAL        = &H1
    End Property

    Property Get read_RESET_CAL
        read
        read_RESET_CAL = read_RESET_CAL_value
    End Property

    Property Let write_RESET_CAL(aData)
        set_RESET_CAL = aData
        write
    End Property

    Property Get get_RX_PWRDWN_OV
        get_RX_PWRDWN_OV = read_RX_PWRDWN_OV_value
    End Property

    Property Let set_RX_PWRDWN_OV(aData)
        write_RX_PWRDWN_OV_value = aData
        flag_RX_PWRDWN_OV        = &H1
    End Property

    Property Get read_RX_PWRDWN_OV
        read
        read_RX_PWRDWN_OV = read_RX_PWRDWN_OV_value
    End Property

    Property Let write_RX_PWRDWN_OV(aData)
        set_RX_PWRDWN_OV = aData
        write
    End Property

    Property Get get_RX_PWRDWN
        get_RX_PWRDWN = read_RX_PWRDWN_value
    End Property

    Property Let set_RX_PWRDWN(aData)
        write_RX_PWRDWN_value = aData
        flag_RX_PWRDWN        = &H1
    End Property

    Property Get read_RX_PWRDWN
        read
        read_RX_PWRDWN = read_RX_PWRDWN_value
    End Property

    Property Let write_RX_PWRDWN(aData)
        set_RX_PWRDWN = aData
        write
    End Property

    Property Get get_RX_RESETB_OV
        get_RX_RESETB_OV = read_RX_RESETB_OV_value
    End Property

    Property Let set_RX_RESETB_OV(aData)
        write_RX_RESETB_OV_value = aData
        flag_RX_RESETB_OV        = &H1
    End Property

    Property Get read_RX_RESETB_OV
        read
        read_RX_RESETB_OV = read_RX_RESETB_OV_value
    End Property

    Property Let write_RX_RESETB_OV(aData)
        set_RX_RESETB_OV = aData
        write
    End Property

    Property Get get_RX_RESETB
        get_RX_RESETB = read_RX_RESETB_value
    End Property

    Property Let set_RX_RESETB(aData)
        write_RX_RESETB_value = aData
        flag_RX_RESETB        = &H1
    End Property

    Property Get read_RX_RESETB
        read
        read_RX_RESETB = read_RX_RESETB_value
    End Property

    Property Let write_RX_RESETB(aData)
        set_RX_RESETB = aData
        write
    End Property

    Property Get get_TX_PWRDWN_OV
        get_TX_PWRDWN_OV = read_TX_PWRDWN_OV_value
    End Property

    Property Let set_TX_PWRDWN_OV(aData)
        write_TX_PWRDWN_OV_value = aData
        flag_TX_PWRDWN_OV        = &H1
    End Property

    Property Get read_TX_PWRDWN_OV
        read
        read_TX_PWRDWN_OV = read_TX_PWRDWN_OV_value
    End Property

    Property Let write_TX_PWRDWN_OV(aData)
        set_TX_PWRDWN_OV = aData
        write
    End Property

    Property Get get_TX_PWRDWN
        get_TX_PWRDWN = read_TX_PWRDWN_value
    End Property

    Property Let set_TX_PWRDWN(aData)
        write_TX_PWRDWN_value = aData
        flag_TX_PWRDWN        = &H1
    End Property

    Property Get read_TX_PWRDWN
        read
        read_TX_PWRDWN = read_TX_PWRDWN_value
    End Property

    Property Let write_TX_PWRDWN(aData)
        set_TX_PWRDWN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVE_1510_value = rightShift(data_low, 10) and &H3f
        read_PASSIVE_TERM_EN_OV_value = rightShift(data_low, 9) and &H1
        read_PASSIVE_TERM_EN_value = rightShift(data_low, 8) and &H1
        read_RESET_CAL_OV_value = rightShift(data_low, 7) and &H1
        read_RESET_CAL_value = rightShift(data_low, 6) and &H1
        read_RX_PWRDWN_OV_value = rightShift(data_low, 5) and &H1
        read_RX_PWRDWN_value = rightShift(data_low, 4) and &H1
        read_RX_RESETB_OV_value = rightShift(data_low, 3) and &H1
        read_RX_RESETB_value = rightShift(data_low, 2) and &H1
        read_TX_PWRDWN_OV_value = rightShift(data_low, 1) and &H1
        TX_PWRDWN_mask = &H1
        if data_low > LONG_MAX then
            if TX_PWRDWN_mask = mask then
                read_TX_PWRDWN_value = data_low
            else
                read_TX_PWRDWN_value = (data_low - H8000_0000) and TX_PWRDWN_mask
            end If
        else
            read_TX_PWRDWN_value = data_low and TX_PWRDWN_mask
        end If

    End Sub

    Sub write
        If flag_RESERVE_1510 = &H0 or flag_PASSIVE_TERM_EN_OV = &H0 or flag_PASSIVE_TERM_EN = &H0 or flag_RESET_CAL_OV = &H0 or flag_RESET_CAL = &H0 or flag_RX_PWRDWN_OV = &H0 or flag_RX_PWRDWN = &H0 or flag_RX_RESETB_OV = &H0 or flag_RX_RESETB = &H0 or flag_TX_PWRDWN_OV = &H0 or flag_TX_PWRDWN = &H0 Then read
        If flag_RESERVE_1510 = &H0 Then write_RESERVE_1510_value = get_RESERVE_1510
        If flag_PASSIVE_TERM_EN_OV = &H0 Then write_PASSIVE_TERM_EN_OV_value = get_PASSIVE_TERM_EN_OV
        If flag_PASSIVE_TERM_EN = &H0 Then write_PASSIVE_TERM_EN_value = get_PASSIVE_TERM_EN
        If flag_RESET_CAL_OV = &H0 Then write_RESET_CAL_OV_value = get_RESET_CAL_OV
        If flag_RESET_CAL = &H0 Then write_RESET_CAL_value = get_RESET_CAL
        If flag_RX_PWRDWN_OV = &H0 Then write_RX_PWRDWN_OV_value = get_RX_PWRDWN_OV
        If flag_RX_PWRDWN = &H0 Then write_RX_PWRDWN_value = get_RX_PWRDWN
        If flag_RX_RESETB_OV = &H0 Then write_RX_RESETB_OV_value = get_RX_RESETB_OV
        If flag_RX_RESETB = &H0 Then write_RX_RESETB_value = get_RX_RESETB
        If flag_TX_PWRDWN_OV = &H0 Then write_TX_PWRDWN_OV_value = get_TX_PWRDWN_OV
        If flag_TX_PWRDWN = &H0 Then write_TX_PWRDWN_value = get_TX_PWRDWN

        regValue = leftShift((write_RESERVE_1510_value and &H3f), 10) + leftShift((write_PASSIVE_TERM_EN_OV_value and &H1), 9) + leftShift((write_PASSIVE_TERM_EN_value and &H1), 8) + leftShift((write_RESET_CAL_OV_value and &H1), 7) + leftShift((write_RESET_CAL_value and &H1), 6) + leftShift((write_RX_PWRDWN_OV_value and &H1), 5) + leftShift((write_RX_PWRDWN_value and &H1), 4) + leftShift((write_RX_RESETB_OV_value and &H1), 3) + leftShift((write_RX_RESETB_value and &H1), 2) + leftShift((write_TX_PWRDWN_OV_value and &H1), 1) + leftShift((write_TX_PWRDWN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVE_1510_value = rightShift(data_low, 10) and &H3f
        read_PASSIVE_TERM_EN_OV_value = rightShift(data_low, 9) and &H1
        read_PASSIVE_TERM_EN_value = rightShift(data_low, 8) and &H1
        read_RESET_CAL_OV_value = rightShift(data_low, 7) and &H1
        read_RESET_CAL_value = rightShift(data_low, 6) and &H1
        read_RX_PWRDWN_OV_value = rightShift(data_low, 5) and &H1
        read_RX_PWRDWN_value = rightShift(data_low, 4) and &H1
        read_RX_RESETB_OV_value = rightShift(data_low, 3) and &H1
        read_RX_RESETB_value = rightShift(data_low, 2) and &H1
        read_TX_PWRDWN_OV_value = rightShift(data_low, 1) and &H1
        TX_PWRDWN_mask = &H1
        if data_low > LONG_MAX then
            if TX_PWRDWN_mask = mask then
                read_TX_PWRDWN_value = data_low
            else
                read_TX_PWRDWN_value = (data_low - H8000_0000) and TX_PWRDWN_mask
            end If
        else
            read_TX_PWRDWN_value = data_low and TX_PWRDWN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVE_1510_value = &H0
        flag_RESERVE_1510        = &H0
        write_PASSIVE_TERM_EN_OV_value = &H0
        flag_PASSIVE_TERM_EN_OV        = &H0
        write_PASSIVE_TERM_EN_value = &H0
        flag_PASSIVE_TERM_EN        = &H0
        write_RESET_CAL_OV_value = &H0
        flag_RESET_CAL_OV        = &H0
        write_RESET_CAL_value = &H0
        flag_RESET_CAL        = &H0
        write_RX_PWRDWN_OV_value = &H0
        flag_RX_PWRDWN_OV        = &H0
        write_RX_PWRDWN_value = &H0
        flag_RX_PWRDWN        = &H0
        write_RX_RESETB_OV_value = &H0
        flag_RX_RESETB_OV        = &H0
        write_RX_RESETB_value = &H0
        flag_RX_RESETB        = &H0
        write_TX_PWRDWN_OV_value = &H0
        flag_TX_PWRDWN_OV        = &H0
        write_TX_PWRDWN_value = &H0
        flag_TX_PWRDWN        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' POR_CLEAN                                  [15:15]          get_POR_CLEAN
''                                                             set_POR_CLEAN
''                                                             read_POR_CLEAN
''                                                             write_POR_CLEAN
''---------------------------------------------------------------------------------
'' IDDQ_IDAC                                  [14:14]          get_IDDQ_IDAC
''                                                             set_IDDQ_IDAC
''                                                             read_IDDQ_IDAC
''                                                             write_IDDQ_IDAC
''---------------------------------------------------------------------------------
'' IDAC_CM_RTUNE                              [13:12]          get_IDAC_CM_RTUNE
''                                                             set_IDAC_CM_RTUNE
''                                                             read_IDAC_CM_RTUNE
''                                                             write_IDAC_CM_RTUNE
''---------------------------------------------------------------------------------
'' IDAC_CUR_FTUNE                             [11:9]           get_IDAC_CUR_FTUNE
''                                                             set_IDAC_CUR_FTUNE
''                                                             read_IDAC_CUR_FTUNE
''                                                             write_IDAC_CUR_FTUNE
''---------------------------------------------------------------------------------
'' IDAC_C_BIAS                                [8:6]            get_IDAC_C_BIAS
''                                                             set_IDAC_C_BIAS
''                                                             read_IDAC_C_BIAS
''                                                             write_IDAC_C_BIAS
''---------------------------------------------------------------------------------
'' IDAC_SW_ENB                                [5:5]            get_IDAC_SW_ENB
''                                                             set_IDAC_SW_ENB
''                                                             read_IDAC_SW_ENB
''                                                             write_IDAC_SW_ENB
''---------------------------------------------------------------------------------
'' I100BT_CURRENT_0                           [4:1]            get_I100BT_CURRENT_0
''                                                             set_I100BT_CURRENT_0
''                                                             read_I100BT_CURRENT_0
''                                                             write_I100BT_CURRENT_0
''---------------------------------------------------------------------------------
'' INC_CURRENT                                [0:0]            get_INC_CURRENT
''                                                             set_INC_CURRENT
''                                                             read_INC_CURRENT
''                                                             write_INC_CURRENT
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_0
    Private write_POR_CLEAN_value
    Private read_POR_CLEAN_value
    Private flag_POR_CLEAN
    Private write_IDDQ_IDAC_value
    Private read_IDDQ_IDAC_value
    Private flag_IDDQ_IDAC
    Private write_IDAC_CM_RTUNE_value
    Private read_IDAC_CM_RTUNE_value
    Private flag_IDAC_CM_RTUNE
    Private write_IDAC_CUR_FTUNE_value
    Private read_IDAC_CUR_FTUNE_value
    Private flag_IDAC_CUR_FTUNE
    Private write_IDAC_C_BIAS_value
    Private read_IDAC_C_BIAS_value
    Private flag_IDAC_C_BIAS
    Private write_IDAC_SW_ENB_value
    Private read_IDAC_SW_ENB_value
    Private flag_IDAC_SW_ENB
    Private write_I100BT_CURRENT_0_value
    Private read_I100BT_CURRENT_0_value
    Private flag_I100BT_CURRENT_0
    Private write_INC_CURRENT_value
    Private read_INC_CURRENT_value
    Private flag_INC_CURRENT

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

    Property Get get_POR_CLEAN
        get_POR_CLEAN = read_POR_CLEAN_value
    End Property

    Property Let set_POR_CLEAN(aData)
        write_POR_CLEAN_value = aData
        flag_POR_CLEAN        = &H1
    End Property

    Property Get read_POR_CLEAN
        read
        read_POR_CLEAN = read_POR_CLEAN_value
    End Property

    Property Let write_POR_CLEAN(aData)
        set_POR_CLEAN = aData
        write
    End Property

    Property Get get_IDDQ_IDAC
        get_IDDQ_IDAC = read_IDDQ_IDAC_value
    End Property

    Property Let set_IDDQ_IDAC(aData)
        write_IDDQ_IDAC_value = aData
        flag_IDDQ_IDAC        = &H1
    End Property

    Property Get read_IDDQ_IDAC
        read
        read_IDDQ_IDAC = read_IDDQ_IDAC_value
    End Property

    Property Let write_IDDQ_IDAC(aData)
        set_IDDQ_IDAC = aData
        write
    End Property

    Property Get get_IDAC_CM_RTUNE
        get_IDAC_CM_RTUNE = read_IDAC_CM_RTUNE_value
    End Property

    Property Let set_IDAC_CM_RTUNE(aData)
        write_IDAC_CM_RTUNE_value = aData
        flag_IDAC_CM_RTUNE        = &H1
    End Property

    Property Get read_IDAC_CM_RTUNE
        read
        read_IDAC_CM_RTUNE = read_IDAC_CM_RTUNE_value
    End Property

    Property Let write_IDAC_CM_RTUNE(aData)
        set_IDAC_CM_RTUNE = aData
        write
    End Property

    Property Get get_IDAC_CUR_FTUNE
        get_IDAC_CUR_FTUNE = read_IDAC_CUR_FTUNE_value
    End Property

    Property Let set_IDAC_CUR_FTUNE(aData)
        write_IDAC_CUR_FTUNE_value = aData
        flag_IDAC_CUR_FTUNE        = &H1
    End Property

    Property Get read_IDAC_CUR_FTUNE
        read
        read_IDAC_CUR_FTUNE = read_IDAC_CUR_FTUNE_value
    End Property

    Property Let write_IDAC_CUR_FTUNE(aData)
        set_IDAC_CUR_FTUNE = aData
        write
    End Property

    Property Get get_IDAC_C_BIAS
        get_IDAC_C_BIAS = read_IDAC_C_BIAS_value
    End Property

    Property Let set_IDAC_C_BIAS(aData)
        write_IDAC_C_BIAS_value = aData
        flag_IDAC_C_BIAS        = &H1
    End Property

    Property Get read_IDAC_C_BIAS
        read
        read_IDAC_C_BIAS = read_IDAC_C_BIAS_value
    End Property

    Property Let write_IDAC_C_BIAS(aData)
        set_IDAC_C_BIAS = aData
        write
    End Property

    Property Get get_IDAC_SW_ENB
        get_IDAC_SW_ENB = read_IDAC_SW_ENB_value
    End Property

    Property Let set_IDAC_SW_ENB(aData)
        write_IDAC_SW_ENB_value = aData
        flag_IDAC_SW_ENB        = &H1
    End Property

    Property Get read_IDAC_SW_ENB
        read
        read_IDAC_SW_ENB = read_IDAC_SW_ENB_value
    End Property

    Property Let write_IDAC_SW_ENB(aData)
        set_IDAC_SW_ENB = aData
        write
    End Property

    Property Get get_I100BT_CURRENT_0
        get_I100BT_CURRENT_0 = read_I100BT_CURRENT_0_value
    End Property

    Property Let set_I100BT_CURRENT_0(aData)
        write_I100BT_CURRENT_0_value = aData
        flag_I100BT_CURRENT_0        = &H1
    End Property

    Property Get read_I100BT_CURRENT_0
        read
        read_I100BT_CURRENT_0 = read_I100BT_CURRENT_0_value
    End Property

    Property Let write_I100BT_CURRENT_0(aData)
        set_I100BT_CURRENT_0 = aData
        write
    End Property

    Property Get get_INC_CURRENT
        get_INC_CURRENT = read_INC_CURRENT_value
    End Property

    Property Let set_INC_CURRENT(aData)
        write_INC_CURRENT_value = aData
        flag_INC_CURRENT        = &H1
    End Property

    Property Get read_INC_CURRENT
        read
        read_INC_CURRENT = read_INC_CURRENT_value
    End Property

    Property Let write_INC_CURRENT(aData)
        set_INC_CURRENT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_POR_CLEAN_value = rightShift(data_low, 15) and &H1
        read_IDDQ_IDAC_value = rightShift(data_low, 14) and &H1
        read_IDAC_CM_RTUNE_value = rightShift(data_low, 12) and &H3
        read_IDAC_CUR_FTUNE_value = rightShift(data_low, 9) and &H7
        read_IDAC_C_BIAS_value = rightShift(data_low, 6) and &H7
        read_IDAC_SW_ENB_value = rightShift(data_low, 5) and &H1
        read_I100BT_CURRENT_0_value = rightShift(data_low, 1) and &Hf
        INC_CURRENT_mask = &H1
        if data_low > LONG_MAX then
            if INC_CURRENT_mask = mask then
                read_INC_CURRENT_value = data_low
            else
                read_INC_CURRENT_value = (data_low - H8000_0000) and INC_CURRENT_mask
            end If
        else
            read_INC_CURRENT_value = data_low and INC_CURRENT_mask
        end If

    End Sub

    Sub write
        If flag_POR_CLEAN = &H0 or flag_IDDQ_IDAC = &H0 or flag_IDAC_CM_RTUNE = &H0 or flag_IDAC_CUR_FTUNE = &H0 or flag_IDAC_C_BIAS = &H0 or flag_IDAC_SW_ENB = &H0 or flag_I100BT_CURRENT_0 = &H0 or flag_INC_CURRENT = &H0 Then read
        If flag_POR_CLEAN = &H0 Then write_POR_CLEAN_value = get_POR_CLEAN
        If flag_IDDQ_IDAC = &H0 Then write_IDDQ_IDAC_value = get_IDDQ_IDAC
        If flag_IDAC_CM_RTUNE = &H0 Then write_IDAC_CM_RTUNE_value = get_IDAC_CM_RTUNE
        If flag_IDAC_CUR_FTUNE = &H0 Then write_IDAC_CUR_FTUNE_value = get_IDAC_CUR_FTUNE
        If flag_IDAC_C_BIAS = &H0 Then write_IDAC_C_BIAS_value = get_IDAC_C_BIAS
        If flag_IDAC_SW_ENB = &H0 Then write_IDAC_SW_ENB_value = get_IDAC_SW_ENB
        If flag_I100BT_CURRENT_0 = &H0 Then write_I100BT_CURRENT_0_value = get_I100BT_CURRENT_0
        If flag_INC_CURRENT = &H0 Then write_INC_CURRENT_value = get_INC_CURRENT

        regValue = leftShift((write_POR_CLEAN_value and &H1), 15) + leftShift((write_IDDQ_IDAC_value and &H1), 14) + leftShift((write_IDAC_CM_RTUNE_value and &H3), 12) + leftShift((write_IDAC_CUR_FTUNE_value and &H7), 9) + leftShift((write_IDAC_C_BIAS_value and &H7), 6) + leftShift((write_IDAC_SW_ENB_value and &H1), 5) + leftShift((write_I100BT_CURRENT_0_value and &Hf), 1) + leftShift((write_INC_CURRENT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_POR_CLEAN_value = rightShift(data_low, 15) and &H1
        read_IDDQ_IDAC_value = rightShift(data_low, 14) and &H1
        read_IDAC_CM_RTUNE_value = rightShift(data_low, 12) and &H3
        read_IDAC_CUR_FTUNE_value = rightShift(data_low, 9) and &H7
        read_IDAC_C_BIAS_value = rightShift(data_low, 6) and &H7
        read_IDAC_SW_ENB_value = rightShift(data_low, 5) and &H1
        read_I100BT_CURRENT_0_value = rightShift(data_low, 1) and &Hf
        INC_CURRENT_mask = &H1
        if data_low > LONG_MAX then
            if INC_CURRENT_mask = mask then
                read_INC_CURRENT_value = data_low
            else
                read_INC_CURRENT_value = (data_low - H8000_0000) and INC_CURRENT_mask
            end If
        else
            read_INC_CURRENT_value = data_low and INC_CURRENT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_POR_CLEAN_value = &H0
        flag_POR_CLEAN        = &H0
        write_IDDQ_IDAC_value = &H0
        flag_IDDQ_IDAC        = &H0
        write_IDAC_CM_RTUNE_value = &H0
        flag_IDAC_CM_RTUNE        = &H0
        write_IDAC_CUR_FTUNE_value = &H0
        flag_IDAC_CUR_FTUNE        = &H0
        write_IDAC_C_BIAS_value = &H0
        flag_IDAC_C_BIAS        = &H0
        write_IDAC_SW_ENB_value = &H0
        flag_IDAC_SW_ENB        = &H0
        write_I100BT_CURRENT_0_value = &H0
        flag_I100BT_CURRENT_0        = &H0
        write_INC_CURRENT_value = &H0
        flag_INC_CURRENT        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLT_PD_CTL                                 [15:14]          get_FLT_PD_CTL
''                                                             set_FLT_PD_CTL
''                                                             read_FLT_PD_CTL
''                                                             write_FLT_PD_CTL
''---------------------------------------------------------------------------------
'' LD_PD_FORCE                                [13:13]          get_LD_PD_FORCE
''                                                             set_LD_PD_FORCE
''                                                             read_LD_PD_FORCE
''                                                             write_LD_PD_FORCE
''---------------------------------------------------------------------------------
'' I100BT_CURRENT_2                           [12:9]           get_I100BT_CURRENT_2
''                                                             set_I100BT_CURRENT_2
''                                                             read_I100BT_CURRENT_2
''                                                             write_I100BT_CURRENT_2
''---------------------------------------------------------------------------------
'' TUND_LD_FB                                 [8:4]            get_TUND_LD_FB
''                                                             set_TUND_LD_FB
''                                                             read_TUND_LD_FB
''                                                             write_TUND_LD_FB
''---------------------------------------------------------------------------------
'' I100BT_CURRENT_1                           [3:0]            get_I100BT_CURRENT_1
''                                                             set_I100BT_CURRENT_1
''                                                             read_I100BT_CURRENT_1
''                                                             write_I100BT_CURRENT_1
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_1
    Private write_FLT_PD_CTL_value
    Private read_FLT_PD_CTL_value
    Private flag_FLT_PD_CTL
    Private write_LD_PD_FORCE_value
    Private read_LD_PD_FORCE_value
    Private flag_LD_PD_FORCE
    Private write_I100BT_CURRENT_2_value
    Private read_I100BT_CURRENT_2_value
    Private flag_I100BT_CURRENT_2
    Private write_TUND_LD_FB_value
    Private read_TUND_LD_FB_value
    Private flag_TUND_LD_FB
    Private write_I100BT_CURRENT_1_value
    Private read_I100BT_CURRENT_1_value
    Private flag_I100BT_CURRENT_1

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

    Property Get get_FLT_PD_CTL
        get_FLT_PD_CTL = read_FLT_PD_CTL_value
    End Property

    Property Let set_FLT_PD_CTL(aData)
        write_FLT_PD_CTL_value = aData
        flag_FLT_PD_CTL        = &H1
    End Property

    Property Get read_FLT_PD_CTL
        read
        read_FLT_PD_CTL = read_FLT_PD_CTL_value
    End Property

    Property Let write_FLT_PD_CTL(aData)
        set_FLT_PD_CTL = aData
        write
    End Property

    Property Get get_LD_PD_FORCE
        get_LD_PD_FORCE = read_LD_PD_FORCE_value
    End Property

    Property Let set_LD_PD_FORCE(aData)
        write_LD_PD_FORCE_value = aData
        flag_LD_PD_FORCE        = &H1
    End Property

    Property Get read_LD_PD_FORCE
        read
        read_LD_PD_FORCE = read_LD_PD_FORCE_value
    End Property

    Property Let write_LD_PD_FORCE(aData)
        set_LD_PD_FORCE = aData
        write
    End Property

    Property Get get_I100BT_CURRENT_2
        get_I100BT_CURRENT_2 = read_I100BT_CURRENT_2_value
    End Property

    Property Let set_I100BT_CURRENT_2(aData)
        write_I100BT_CURRENT_2_value = aData
        flag_I100BT_CURRENT_2        = &H1
    End Property

    Property Get read_I100BT_CURRENT_2
        read
        read_I100BT_CURRENT_2 = read_I100BT_CURRENT_2_value
    End Property

    Property Let write_I100BT_CURRENT_2(aData)
        set_I100BT_CURRENT_2 = aData
        write
    End Property

    Property Get get_TUND_LD_FB
        get_TUND_LD_FB = read_TUND_LD_FB_value
    End Property

    Property Let set_TUND_LD_FB(aData)
        write_TUND_LD_FB_value = aData
        flag_TUND_LD_FB        = &H1
    End Property

    Property Get read_TUND_LD_FB
        read
        read_TUND_LD_FB = read_TUND_LD_FB_value
    End Property

    Property Let write_TUND_LD_FB(aData)
        set_TUND_LD_FB = aData
        write
    End Property

    Property Get get_I100BT_CURRENT_1
        get_I100BT_CURRENT_1 = read_I100BT_CURRENT_1_value
    End Property

    Property Let set_I100BT_CURRENT_1(aData)
        write_I100BT_CURRENT_1_value = aData
        flag_I100BT_CURRENT_1        = &H1
    End Property

    Property Get read_I100BT_CURRENT_1
        read
        read_I100BT_CURRENT_1 = read_I100BT_CURRENT_1_value
    End Property

    Property Let write_I100BT_CURRENT_1(aData)
        set_I100BT_CURRENT_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLT_PD_CTL_value = rightShift(data_low, 14) and &H3
        read_LD_PD_FORCE_value = rightShift(data_low, 13) and &H1
        read_I100BT_CURRENT_2_value = rightShift(data_low, 9) and &Hf
        read_TUND_LD_FB_value = rightShift(data_low, 4) and &H1f
        I100BT_CURRENT_1_mask = &Hf
        if data_low > LONG_MAX then
            if I100BT_CURRENT_1_mask = mask then
                read_I100BT_CURRENT_1_value = data_low
            else
                read_I100BT_CURRENT_1_value = (data_low - H8000_0000) and I100BT_CURRENT_1_mask
            end If
        else
            read_I100BT_CURRENT_1_value = data_low and I100BT_CURRENT_1_mask
        end If

    End Sub

    Sub write
        If flag_FLT_PD_CTL = &H0 or flag_LD_PD_FORCE = &H0 or flag_I100BT_CURRENT_2 = &H0 or flag_TUND_LD_FB = &H0 or flag_I100BT_CURRENT_1 = &H0 Then read
        If flag_FLT_PD_CTL = &H0 Then write_FLT_PD_CTL_value = get_FLT_PD_CTL
        If flag_LD_PD_FORCE = &H0 Then write_LD_PD_FORCE_value = get_LD_PD_FORCE
        If flag_I100BT_CURRENT_2 = &H0 Then write_I100BT_CURRENT_2_value = get_I100BT_CURRENT_2
        If flag_TUND_LD_FB = &H0 Then write_TUND_LD_FB_value = get_TUND_LD_FB
        If flag_I100BT_CURRENT_1 = &H0 Then write_I100BT_CURRENT_1_value = get_I100BT_CURRENT_1

        regValue = leftShift((write_FLT_PD_CTL_value and &H3), 14) + leftShift((write_LD_PD_FORCE_value and &H1), 13) + leftShift((write_I100BT_CURRENT_2_value and &Hf), 9) + leftShift((write_TUND_LD_FB_value and &H1f), 4) + leftShift((write_I100BT_CURRENT_1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLT_PD_CTL_value = rightShift(data_low, 14) and &H3
        read_LD_PD_FORCE_value = rightShift(data_low, 13) and &H1
        read_I100BT_CURRENT_2_value = rightShift(data_low, 9) and &Hf
        read_TUND_LD_FB_value = rightShift(data_low, 4) and &H1f
        I100BT_CURRENT_1_mask = &Hf
        if data_low > LONG_MAX then
            if I100BT_CURRENT_1_mask = mask then
                read_I100BT_CURRENT_1_value = data_low
            else
                read_I100BT_CURRENT_1_value = (data_low - H8000_0000) and I100BT_CURRENT_1_mask
            end If
        else
            read_I100BT_CURRENT_1_value = data_low and I100BT_CURRENT_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLT_PD_CTL_value = &H0
        flag_FLT_PD_CTL        = &H0
        write_LD_PD_FORCE_value = &H0
        flag_LD_PD_FORCE        = &H0
        write_I100BT_CURRENT_2_value = &H0
        flag_I100BT_CURRENT_2        = &H0
        write_TUND_LD_FB_value = &H0
        flag_TUND_LD_FB        = &H0
        write_I100BT_CURRENT_1_value = &H0
        flag_I100BT_CURRENT_1        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IDAC_CMFB_OFF                              [15:15]          get_IDAC_CMFB_OFF
''                                                             set_IDAC_CMFB_OFF
''                                                             read_IDAC_CMFB_OFF
''                                                             write_IDAC_CMFB_OFF
''---------------------------------------------------------------------------------
'' LD_CMV_CTRL                                [14:13]          get_LD_CMV_CTRL
''                                                             set_LD_CMV_CTRL
''                                                             read_LD_CMV_CTRL
''                                                             write_LD_CMV_CTRL
''---------------------------------------------------------------------------------
'' FORCE_OFF_100BT                            [12:12]          get_FORCE_OFF_100BT
''                                                             set_FORCE_OFF_100BT
''                                                             read_FORCE_OFF_100BT
''                                                             write_FORCE_OFF_100BT
''---------------------------------------------------------------------------------
'' FORCE_ACD_ON                               [11:11]          get_FORCE_ACD_ON
''                                                             set_FORCE_ACD_ON
''                                                             read_FORCE_ACD_ON
''                                                             write_FORCE_ACD_ON
''---------------------------------------------------------------------------------
'' EN_FORCE_RCCAL                             [10:10]          get_EN_FORCE_RCCAL
''                                                             set_EN_FORCE_RCCAL
''                                                             read_EN_FORCE_RCCAL
''                                                             write_EN_FORCE_RCCAL
''---------------------------------------------------------------------------------
'' FILTER_BW_100BT                            [9:5]            get_FILTER_BW_100BT
''                                                             set_FILTER_BW_100BT
''                                                             read_FILTER_BW_100BT
''                                                             write_FILTER_BW_100BT
''---------------------------------------------------------------------------------
'' FT_BYPASS_EN                               [4:4]            get_FT_BYPASS_EN
''                                                             set_FT_BYPASS_EN
''                                                             read_FT_BYPASS_EN
''                                                             write_FT_BYPASS_EN
''---------------------------------------------------------------------------------
'' FT_IDDQ                                    [3:3]            get_FT_IDDQ
''                                                             set_FT_IDDQ
''                                                             read_FT_IDDQ
''                                                             write_FT_IDDQ
''---------------------------------------------------------------------------------
'' PASSIVE_TERM_BYP                           [2:2]            get_PASSIVE_TERM_BYP
''                                                             set_PASSIVE_TERM_BYP
''                                                             read_PASSIVE_TERM_BYP
''                                                             write_PASSIVE_TERM_BYP
''---------------------------------------------------------------------------------
'' FLTR_BW_INC                                [1:1]            get_FLTR_BW_INC
''                                                             set_FLTR_BW_INC
''                                                             read_FLTR_BW_INC
''                                                             write_FLTR_BW_INC
''---------------------------------------------------------------------------------
'' RESERVED_0                                 [0:0]            get_RESERVED_0
''                                                             set_RESERVED_0
''                                                             read_RESERVED_0
''                                                             write_RESERVED_0
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_2
    Private write_IDAC_CMFB_OFF_value
    Private read_IDAC_CMFB_OFF_value
    Private flag_IDAC_CMFB_OFF
    Private write_LD_CMV_CTRL_value
    Private read_LD_CMV_CTRL_value
    Private flag_LD_CMV_CTRL
    Private write_FORCE_OFF_100BT_value
    Private read_FORCE_OFF_100BT_value
    Private flag_FORCE_OFF_100BT
    Private write_FORCE_ACD_ON_value
    Private read_FORCE_ACD_ON_value
    Private flag_FORCE_ACD_ON
    Private write_EN_FORCE_RCCAL_value
    Private read_EN_FORCE_RCCAL_value
    Private flag_EN_FORCE_RCCAL
    Private write_FILTER_BW_100BT_value
    Private read_FILTER_BW_100BT_value
    Private flag_FILTER_BW_100BT
    Private write_FT_BYPASS_EN_value
    Private read_FT_BYPASS_EN_value
    Private flag_FT_BYPASS_EN
    Private write_FT_IDDQ_value
    Private read_FT_IDDQ_value
    Private flag_FT_IDDQ
    Private write_PASSIVE_TERM_BYP_value
    Private read_PASSIVE_TERM_BYP_value
    Private flag_PASSIVE_TERM_BYP
    Private write_FLTR_BW_INC_value
    Private read_FLTR_BW_INC_value
    Private flag_FLTR_BW_INC
    Private write_RESERVED_0_value
    Private read_RESERVED_0_value
    Private flag_RESERVED_0

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

    Property Get get_IDAC_CMFB_OFF
        get_IDAC_CMFB_OFF = read_IDAC_CMFB_OFF_value
    End Property

    Property Let set_IDAC_CMFB_OFF(aData)
        write_IDAC_CMFB_OFF_value = aData
        flag_IDAC_CMFB_OFF        = &H1
    End Property

    Property Get read_IDAC_CMFB_OFF
        read
        read_IDAC_CMFB_OFF = read_IDAC_CMFB_OFF_value
    End Property

    Property Let write_IDAC_CMFB_OFF(aData)
        set_IDAC_CMFB_OFF = aData
        write
    End Property

    Property Get get_LD_CMV_CTRL
        get_LD_CMV_CTRL = read_LD_CMV_CTRL_value
    End Property

    Property Let set_LD_CMV_CTRL(aData)
        write_LD_CMV_CTRL_value = aData
        flag_LD_CMV_CTRL        = &H1
    End Property

    Property Get read_LD_CMV_CTRL
        read
        read_LD_CMV_CTRL = read_LD_CMV_CTRL_value
    End Property

    Property Let write_LD_CMV_CTRL(aData)
        set_LD_CMV_CTRL = aData
        write
    End Property

    Property Get get_FORCE_OFF_100BT
        get_FORCE_OFF_100BT = read_FORCE_OFF_100BT_value
    End Property

    Property Let set_FORCE_OFF_100BT(aData)
        write_FORCE_OFF_100BT_value = aData
        flag_FORCE_OFF_100BT        = &H1
    End Property

    Property Get read_FORCE_OFF_100BT
        read
        read_FORCE_OFF_100BT = read_FORCE_OFF_100BT_value
    End Property

    Property Let write_FORCE_OFF_100BT(aData)
        set_FORCE_OFF_100BT = aData
        write
    End Property

    Property Get get_FORCE_ACD_ON
        get_FORCE_ACD_ON = read_FORCE_ACD_ON_value
    End Property

    Property Let set_FORCE_ACD_ON(aData)
        write_FORCE_ACD_ON_value = aData
        flag_FORCE_ACD_ON        = &H1
    End Property

    Property Get read_FORCE_ACD_ON
        read
        read_FORCE_ACD_ON = read_FORCE_ACD_ON_value
    End Property

    Property Let write_FORCE_ACD_ON(aData)
        set_FORCE_ACD_ON = aData
        write
    End Property

    Property Get get_EN_FORCE_RCCAL
        get_EN_FORCE_RCCAL = read_EN_FORCE_RCCAL_value
    End Property

    Property Let set_EN_FORCE_RCCAL(aData)
        write_EN_FORCE_RCCAL_value = aData
        flag_EN_FORCE_RCCAL        = &H1
    End Property

    Property Get read_EN_FORCE_RCCAL
        read
        read_EN_FORCE_RCCAL = read_EN_FORCE_RCCAL_value
    End Property

    Property Let write_EN_FORCE_RCCAL(aData)
        set_EN_FORCE_RCCAL = aData
        write
    End Property

    Property Get get_FILTER_BW_100BT
        get_FILTER_BW_100BT = read_FILTER_BW_100BT_value
    End Property

    Property Let set_FILTER_BW_100BT(aData)
        write_FILTER_BW_100BT_value = aData
        flag_FILTER_BW_100BT        = &H1
    End Property

    Property Get read_FILTER_BW_100BT
        read
        read_FILTER_BW_100BT = read_FILTER_BW_100BT_value
    End Property

    Property Let write_FILTER_BW_100BT(aData)
        set_FILTER_BW_100BT = aData
        write
    End Property

    Property Get get_FT_BYPASS_EN
        get_FT_BYPASS_EN = read_FT_BYPASS_EN_value
    End Property

    Property Let set_FT_BYPASS_EN(aData)
        write_FT_BYPASS_EN_value = aData
        flag_FT_BYPASS_EN        = &H1
    End Property

    Property Get read_FT_BYPASS_EN
        read
        read_FT_BYPASS_EN = read_FT_BYPASS_EN_value
    End Property

    Property Let write_FT_BYPASS_EN(aData)
        set_FT_BYPASS_EN = aData
        write
    End Property

    Property Get get_FT_IDDQ
        get_FT_IDDQ = read_FT_IDDQ_value
    End Property

    Property Let set_FT_IDDQ(aData)
        write_FT_IDDQ_value = aData
        flag_FT_IDDQ        = &H1
    End Property

    Property Get read_FT_IDDQ
        read
        read_FT_IDDQ = read_FT_IDDQ_value
    End Property

    Property Let write_FT_IDDQ(aData)
        set_FT_IDDQ = aData
        write
    End Property

    Property Get get_PASSIVE_TERM_BYP
        get_PASSIVE_TERM_BYP = read_PASSIVE_TERM_BYP_value
    End Property

    Property Let set_PASSIVE_TERM_BYP(aData)
        write_PASSIVE_TERM_BYP_value = aData
        flag_PASSIVE_TERM_BYP        = &H1
    End Property

    Property Get read_PASSIVE_TERM_BYP
        read
        read_PASSIVE_TERM_BYP = read_PASSIVE_TERM_BYP_value
    End Property

    Property Let write_PASSIVE_TERM_BYP(aData)
        set_PASSIVE_TERM_BYP = aData
        write
    End Property

    Property Get get_FLTR_BW_INC
        get_FLTR_BW_INC = read_FLTR_BW_INC_value
    End Property

    Property Let set_FLTR_BW_INC(aData)
        write_FLTR_BW_INC_value = aData
        flag_FLTR_BW_INC        = &H1
    End Property

    Property Get read_FLTR_BW_INC
        read
        read_FLTR_BW_INC = read_FLTR_BW_INC_value
    End Property

    Property Let write_FLTR_BW_INC(aData)
        set_FLTR_BW_INC = aData
        write
    End Property

    Property Get get_RESERVED_0
        get_RESERVED_0 = read_RESERVED_0_value
    End Property

    Property Let set_RESERVED_0(aData)
        write_RESERVED_0_value = aData
        flag_RESERVED_0        = &H1
    End Property

    Property Get read_RESERVED_0
        read
        read_RESERVED_0 = read_RESERVED_0_value
    End Property

    Property Let write_RESERVED_0(aData)
        set_RESERVED_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IDAC_CMFB_OFF_value = rightShift(data_low, 15) and &H1
        read_LD_CMV_CTRL_value = rightShift(data_low, 13) and &H3
        read_FORCE_OFF_100BT_value = rightShift(data_low, 12) and &H1
        read_FORCE_ACD_ON_value = rightShift(data_low, 11) and &H1
        read_EN_FORCE_RCCAL_value = rightShift(data_low, 10) and &H1
        read_FILTER_BW_100BT_value = rightShift(data_low, 5) and &H1f
        read_FT_BYPASS_EN_value = rightShift(data_low, 4) and &H1
        read_FT_IDDQ_value = rightShift(data_low, 3) and &H1
        read_PASSIVE_TERM_BYP_value = rightShift(data_low, 2) and &H1
        read_FLTR_BW_INC_value = rightShift(data_low, 1) and &H1
        RESERVED_0_mask = &H1
        if data_low > LONG_MAX then
            if RESERVED_0_mask = mask then
                read_RESERVED_0_value = data_low
            else
                read_RESERVED_0_value = (data_low - H8000_0000) and RESERVED_0_mask
            end If
        else
            read_RESERVED_0_value = data_low and RESERVED_0_mask
        end If

    End Sub

    Sub write
        If flag_IDAC_CMFB_OFF = &H0 or flag_LD_CMV_CTRL = &H0 or flag_FORCE_OFF_100BT = &H0 or flag_FORCE_ACD_ON = &H0 or flag_EN_FORCE_RCCAL = &H0 or flag_FILTER_BW_100BT = &H0 or flag_FT_BYPASS_EN = &H0 or flag_FT_IDDQ = &H0 or flag_PASSIVE_TERM_BYP = &H0 or flag_FLTR_BW_INC = &H0 or flag_RESERVED_0 = &H0 Then read
        If flag_IDAC_CMFB_OFF = &H0 Then write_IDAC_CMFB_OFF_value = get_IDAC_CMFB_OFF
        If flag_LD_CMV_CTRL = &H0 Then write_LD_CMV_CTRL_value = get_LD_CMV_CTRL
        If flag_FORCE_OFF_100BT = &H0 Then write_FORCE_OFF_100BT_value = get_FORCE_OFF_100BT
        If flag_FORCE_ACD_ON = &H0 Then write_FORCE_ACD_ON_value = get_FORCE_ACD_ON
        If flag_EN_FORCE_RCCAL = &H0 Then write_EN_FORCE_RCCAL_value = get_EN_FORCE_RCCAL
        If flag_FILTER_BW_100BT = &H0 Then write_FILTER_BW_100BT_value = get_FILTER_BW_100BT
        If flag_FT_BYPASS_EN = &H0 Then write_FT_BYPASS_EN_value = get_FT_BYPASS_EN
        If flag_FT_IDDQ = &H0 Then write_FT_IDDQ_value = get_FT_IDDQ
        If flag_PASSIVE_TERM_BYP = &H0 Then write_PASSIVE_TERM_BYP_value = get_PASSIVE_TERM_BYP
        If flag_FLTR_BW_INC = &H0 Then write_FLTR_BW_INC_value = get_FLTR_BW_INC
        If flag_RESERVED_0 = &H0 Then write_RESERVED_0_value = get_RESERVED_0

        regValue = leftShift((write_IDAC_CMFB_OFF_value and &H1), 15) + leftShift((write_LD_CMV_CTRL_value and &H3), 13) + leftShift((write_FORCE_OFF_100BT_value and &H1), 12) + leftShift((write_FORCE_ACD_ON_value and &H1), 11) + leftShift((write_EN_FORCE_RCCAL_value and &H1), 10) + leftShift((write_FILTER_BW_100BT_value and &H1f), 5) + leftShift((write_FT_BYPASS_EN_value and &H1), 4) + leftShift((write_FT_IDDQ_value and &H1), 3) + leftShift((write_PASSIVE_TERM_BYP_value and &H1), 2) + leftShift((write_FLTR_BW_INC_value and &H1), 1) + leftShift((write_RESERVED_0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IDAC_CMFB_OFF_value = rightShift(data_low, 15) and &H1
        read_LD_CMV_CTRL_value = rightShift(data_low, 13) and &H3
        read_FORCE_OFF_100BT_value = rightShift(data_low, 12) and &H1
        read_FORCE_ACD_ON_value = rightShift(data_low, 11) and &H1
        read_EN_FORCE_RCCAL_value = rightShift(data_low, 10) and &H1
        read_FILTER_BW_100BT_value = rightShift(data_low, 5) and &H1f
        read_FT_BYPASS_EN_value = rightShift(data_low, 4) and &H1
        read_FT_IDDQ_value = rightShift(data_low, 3) and &H1
        read_PASSIVE_TERM_BYP_value = rightShift(data_low, 2) and &H1
        read_FLTR_BW_INC_value = rightShift(data_low, 1) and &H1
        RESERVED_0_mask = &H1
        if data_low > LONG_MAX then
            if RESERVED_0_mask = mask then
                read_RESERVED_0_value = data_low
            else
                read_RESERVED_0_value = (data_low - H8000_0000) and RESERVED_0_mask
            end If
        else
            read_RESERVED_0_value = data_low and RESERVED_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IDAC_CMFB_OFF_value = &H0
        flag_IDAC_CMFB_OFF        = &H0
        write_LD_CMV_CTRL_value = &H0
        flag_LD_CMV_CTRL        = &H0
        write_FORCE_OFF_100BT_value = &H0
        flag_FORCE_OFF_100BT        = &H0
        write_FORCE_ACD_ON_value = &H0
        flag_FORCE_ACD_ON        = &H0
        write_EN_FORCE_RCCAL_value = &H0
        flag_EN_FORCE_RCCAL        = &H0
        write_FILTER_BW_100BT_value = &H0
        flag_FILTER_BW_100BT        = &H0
        write_FT_BYPASS_EN_value = &H0
        flag_FT_BYPASS_EN        = &H0
        write_FT_IDDQ_value = &H0
        flag_FT_IDDQ        = &H0
        write_PASSIVE_TERM_BYP_value = &H0
        flag_PASSIVE_TERM_BYP        = &H0
        write_FLTR_BW_INC_value = &H0
        flag_FLTR_BW_INC        = &H0
        write_RESERVED_0_value = &H0
        flag_RESERVED_0        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1514                              [15:14]          get_RESERVED_1514
''                                                             set_RESERVED_1514
''                                                             read_RESERVED_1514
''                                                             write_RESERVED_1514
''---------------------------------------------------------------------------------
'' IDAC_ITUNE_100BT                           [13:10]          get_IDAC_ITUNE_100BT
''                                                             set_IDAC_ITUNE_100BT
''                                                             read_IDAC_ITUNE_100BT
''                                                             write_IDAC_ITUNE_100BT
''---------------------------------------------------------------------------------
'' IDAC_LD_HI_CURR                            [9:9]            get_IDAC_LD_HI_CURR
''                                                             set_IDAC_LD_HI_CURR
''                                                             read_IDAC_LD_HI_CURR
''                                                             write_IDAC_LD_HI_CURR
''---------------------------------------------------------------------------------
'' DOUBLE_IDAC                                [8:8]            get_DOUBLE_IDAC
''                                                             set_DOUBLE_IDAC
''                                                             read_DOUBLE_IDAC
''                                                             write_DOUBLE_IDAC
''---------------------------------------------------------------------------------
'' IDAC_TUNE                                  [7:4]            get_IDAC_TUNE
''                                                             set_IDAC_TUNE
''                                                             read_IDAC_TUNE
''                                                             write_IDAC_TUNE
''---------------------------------------------------------------------------------
'' LD_CLAMP                                   [3:0]            get_LD_CLAMP
''                                                             set_LD_CLAMP
''                                                             read_LD_CLAMP
''                                                             write_LD_CLAMP
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_3
    Private write_RESERVED_1514_value
    Private read_RESERVED_1514_value
    Private flag_RESERVED_1514
    Private write_IDAC_ITUNE_100BT_value
    Private read_IDAC_ITUNE_100BT_value
    Private flag_IDAC_ITUNE_100BT
    Private write_IDAC_LD_HI_CURR_value
    Private read_IDAC_LD_HI_CURR_value
    Private flag_IDAC_LD_HI_CURR
    Private write_DOUBLE_IDAC_value
    Private read_DOUBLE_IDAC_value
    Private flag_DOUBLE_IDAC
    Private write_IDAC_TUNE_value
    Private read_IDAC_TUNE_value
    Private flag_IDAC_TUNE
    Private write_LD_CLAMP_value
    Private read_LD_CLAMP_value
    Private flag_LD_CLAMP

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

    Property Get get_RESERVED_1514
        get_RESERVED_1514 = read_RESERVED_1514_value
    End Property

    Property Let set_RESERVED_1514(aData)
        write_RESERVED_1514_value = aData
        flag_RESERVED_1514        = &H1
    End Property

    Property Get read_RESERVED_1514
        read
        read_RESERVED_1514 = read_RESERVED_1514_value
    End Property

    Property Let write_RESERVED_1514(aData)
        set_RESERVED_1514 = aData
        write
    End Property

    Property Get get_IDAC_ITUNE_100BT
        get_IDAC_ITUNE_100BT = read_IDAC_ITUNE_100BT_value
    End Property

    Property Let set_IDAC_ITUNE_100BT(aData)
        write_IDAC_ITUNE_100BT_value = aData
        flag_IDAC_ITUNE_100BT        = &H1
    End Property

    Property Get read_IDAC_ITUNE_100BT
        read
        read_IDAC_ITUNE_100BT = read_IDAC_ITUNE_100BT_value
    End Property

    Property Let write_IDAC_ITUNE_100BT(aData)
        set_IDAC_ITUNE_100BT = aData
        write
    End Property

    Property Get get_IDAC_LD_HI_CURR
        get_IDAC_LD_HI_CURR = read_IDAC_LD_HI_CURR_value
    End Property

    Property Let set_IDAC_LD_HI_CURR(aData)
        write_IDAC_LD_HI_CURR_value = aData
        flag_IDAC_LD_HI_CURR        = &H1
    End Property

    Property Get read_IDAC_LD_HI_CURR
        read
        read_IDAC_LD_HI_CURR = read_IDAC_LD_HI_CURR_value
    End Property

    Property Let write_IDAC_LD_HI_CURR(aData)
        set_IDAC_LD_HI_CURR = aData
        write
    End Property

    Property Get get_DOUBLE_IDAC
        get_DOUBLE_IDAC = read_DOUBLE_IDAC_value
    End Property

    Property Let set_DOUBLE_IDAC(aData)
        write_DOUBLE_IDAC_value = aData
        flag_DOUBLE_IDAC        = &H1
    End Property

    Property Get read_DOUBLE_IDAC
        read
        read_DOUBLE_IDAC = read_DOUBLE_IDAC_value
    End Property

    Property Let write_DOUBLE_IDAC(aData)
        set_DOUBLE_IDAC = aData
        write
    End Property

    Property Get get_IDAC_TUNE
        get_IDAC_TUNE = read_IDAC_TUNE_value
    End Property

    Property Let set_IDAC_TUNE(aData)
        write_IDAC_TUNE_value = aData
        flag_IDAC_TUNE        = &H1
    End Property

    Property Get read_IDAC_TUNE
        read
        read_IDAC_TUNE = read_IDAC_TUNE_value
    End Property

    Property Let write_IDAC_TUNE(aData)
        set_IDAC_TUNE = aData
        write
    End Property

    Property Get get_LD_CLAMP
        get_LD_CLAMP = read_LD_CLAMP_value
    End Property

    Property Let set_LD_CLAMP(aData)
        write_LD_CLAMP_value = aData
        flag_LD_CLAMP        = &H1
    End Property

    Property Get read_LD_CLAMP
        read
        read_LD_CLAMP = read_LD_CLAMP_value
    End Property

    Property Let write_LD_CLAMP(aData)
        set_LD_CLAMP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1514_value = rightShift(data_low, 14) and &H3
        read_IDAC_ITUNE_100BT_value = rightShift(data_low, 10) and &Hf
        read_IDAC_LD_HI_CURR_value = rightShift(data_low, 9) and &H1
        read_DOUBLE_IDAC_value = rightShift(data_low, 8) and &H1
        read_IDAC_TUNE_value = rightShift(data_low, 4) and &Hf
        LD_CLAMP_mask = &Hf
        if data_low > LONG_MAX then
            if LD_CLAMP_mask = mask then
                read_LD_CLAMP_value = data_low
            else
                read_LD_CLAMP_value = (data_low - H8000_0000) and LD_CLAMP_mask
            end If
        else
            read_LD_CLAMP_value = data_low and LD_CLAMP_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1514 = &H0 or flag_IDAC_ITUNE_100BT = &H0 or flag_IDAC_LD_HI_CURR = &H0 or flag_DOUBLE_IDAC = &H0 or flag_IDAC_TUNE = &H0 or flag_LD_CLAMP = &H0 Then read
        If flag_RESERVED_1514 = &H0 Then write_RESERVED_1514_value = get_RESERVED_1514
        If flag_IDAC_ITUNE_100BT = &H0 Then write_IDAC_ITUNE_100BT_value = get_IDAC_ITUNE_100BT
        If flag_IDAC_LD_HI_CURR = &H0 Then write_IDAC_LD_HI_CURR_value = get_IDAC_LD_HI_CURR
        If flag_DOUBLE_IDAC = &H0 Then write_DOUBLE_IDAC_value = get_DOUBLE_IDAC
        If flag_IDAC_TUNE = &H0 Then write_IDAC_TUNE_value = get_IDAC_TUNE
        If flag_LD_CLAMP = &H0 Then write_LD_CLAMP_value = get_LD_CLAMP

        regValue = leftShift((write_RESERVED_1514_value and &H3), 14) + leftShift((write_IDAC_ITUNE_100BT_value and &Hf), 10) + leftShift((write_IDAC_LD_HI_CURR_value and &H1), 9) + leftShift((write_DOUBLE_IDAC_value and &H1), 8) + leftShift((write_IDAC_TUNE_value and &Hf), 4) + leftShift((write_LD_CLAMP_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1514_value = rightShift(data_low, 14) and &H3
        read_IDAC_ITUNE_100BT_value = rightShift(data_low, 10) and &Hf
        read_IDAC_LD_HI_CURR_value = rightShift(data_low, 9) and &H1
        read_DOUBLE_IDAC_value = rightShift(data_low, 8) and &H1
        read_IDAC_TUNE_value = rightShift(data_low, 4) and &Hf
        LD_CLAMP_mask = &Hf
        if data_low > LONG_MAX then
            if LD_CLAMP_mask = mask then
                read_LD_CLAMP_value = data_low
            else
                read_LD_CLAMP_value = (data_low - H8000_0000) and LD_CLAMP_mask
            end If
        else
            read_LD_CLAMP_value = data_low and LD_CLAMP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1514_value = &H0
        flag_RESERVED_1514        = &H0
        write_IDAC_ITUNE_100BT_value = &H0
        flag_IDAC_ITUNE_100BT        = &H0
        write_IDAC_LD_HI_CURR_value = &H0
        flag_IDAC_LD_HI_CURR        = &H0
        write_DOUBLE_IDAC_value = &H0
        flag_DOUBLE_IDAC        = &H0
        write_IDAC_TUNE_value = &H0
        flag_IDAC_TUNE        = &H0
        write_LD_CLAMP_value = &H0
        flag_LD_CLAMP        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LD_IN_BIAS_TUNE                            [15:12]          get_LD_IN_BIAS_TUNE
''                                                             set_LD_IN_BIAS_TUNE
''                                                             read_LD_IN_BIAS_TUNE
''                                                             write_LD_IN_BIAS_TUNE
''---------------------------------------------------------------------------------
'' LD_OUT_BIAS_TUNE                           [11:8]           get_LD_OUT_BIAS_TUNE
''                                                             set_LD_OUT_BIAS_TUNE
''                                                             read_LD_OUT_BIAS_TUNE
''                                                             write_LD_OUT_BIAS_TUNE
''---------------------------------------------------------------------------------
'' LD_OUT_IQ_TUNE                             [7:4]            get_LD_OUT_IQ_TUNE
''                                                             set_LD_OUT_IQ_TUNE
''                                                             read_LD_OUT_IQ_TUNE
''                                                             write_LD_OUT_IQ_TUNE
''---------------------------------------------------------------------------------
'' LD_OUT_CM_TUNE                             [3:0]            get_LD_OUT_CM_TUNE
''                                                             set_LD_OUT_CM_TUNE
''                                                             read_LD_OUT_CM_TUNE
''                                                             write_LD_OUT_CM_TUNE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_4
    Private write_LD_IN_BIAS_TUNE_value
    Private read_LD_IN_BIAS_TUNE_value
    Private flag_LD_IN_BIAS_TUNE
    Private write_LD_OUT_BIAS_TUNE_value
    Private read_LD_OUT_BIAS_TUNE_value
    Private flag_LD_OUT_BIAS_TUNE
    Private write_LD_OUT_IQ_TUNE_value
    Private read_LD_OUT_IQ_TUNE_value
    Private flag_LD_OUT_IQ_TUNE
    Private write_LD_OUT_CM_TUNE_value
    Private read_LD_OUT_CM_TUNE_value
    Private flag_LD_OUT_CM_TUNE

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

    Property Get get_LD_IN_BIAS_TUNE
        get_LD_IN_BIAS_TUNE = read_LD_IN_BIAS_TUNE_value
    End Property

    Property Let set_LD_IN_BIAS_TUNE(aData)
        write_LD_IN_BIAS_TUNE_value = aData
        flag_LD_IN_BIAS_TUNE        = &H1
    End Property

    Property Get read_LD_IN_BIAS_TUNE
        read
        read_LD_IN_BIAS_TUNE = read_LD_IN_BIAS_TUNE_value
    End Property

    Property Let write_LD_IN_BIAS_TUNE(aData)
        set_LD_IN_BIAS_TUNE = aData
        write
    End Property

    Property Get get_LD_OUT_BIAS_TUNE
        get_LD_OUT_BIAS_TUNE = read_LD_OUT_BIAS_TUNE_value
    End Property

    Property Let set_LD_OUT_BIAS_TUNE(aData)
        write_LD_OUT_BIAS_TUNE_value = aData
        flag_LD_OUT_BIAS_TUNE        = &H1
    End Property

    Property Get read_LD_OUT_BIAS_TUNE
        read
        read_LD_OUT_BIAS_TUNE = read_LD_OUT_BIAS_TUNE_value
    End Property

    Property Let write_LD_OUT_BIAS_TUNE(aData)
        set_LD_OUT_BIAS_TUNE = aData
        write
    End Property

    Property Get get_LD_OUT_IQ_TUNE
        get_LD_OUT_IQ_TUNE = read_LD_OUT_IQ_TUNE_value
    End Property

    Property Let set_LD_OUT_IQ_TUNE(aData)
        write_LD_OUT_IQ_TUNE_value = aData
        flag_LD_OUT_IQ_TUNE        = &H1
    End Property

    Property Get read_LD_OUT_IQ_TUNE
        read
        read_LD_OUT_IQ_TUNE = read_LD_OUT_IQ_TUNE_value
    End Property

    Property Let write_LD_OUT_IQ_TUNE(aData)
        set_LD_OUT_IQ_TUNE = aData
        write
    End Property

    Property Get get_LD_OUT_CM_TUNE
        get_LD_OUT_CM_TUNE = read_LD_OUT_CM_TUNE_value
    End Property

    Property Let set_LD_OUT_CM_TUNE(aData)
        write_LD_OUT_CM_TUNE_value = aData
        flag_LD_OUT_CM_TUNE        = &H1
    End Property

    Property Get read_LD_OUT_CM_TUNE
        read
        read_LD_OUT_CM_TUNE = read_LD_OUT_CM_TUNE_value
    End Property

    Property Let write_LD_OUT_CM_TUNE(aData)
        set_LD_OUT_CM_TUNE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_IN_BIAS_TUNE_value = rightShift(data_low, 12) and &Hf
        read_LD_OUT_BIAS_TUNE_value = rightShift(data_low, 8) and &Hf
        read_LD_OUT_IQ_TUNE_value = rightShift(data_low, 4) and &Hf
        LD_OUT_CM_TUNE_mask = &Hf
        if data_low > LONG_MAX then
            if LD_OUT_CM_TUNE_mask = mask then
                read_LD_OUT_CM_TUNE_value = data_low
            else
                read_LD_OUT_CM_TUNE_value = (data_low - H8000_0000) and LD_OUT_CM_TUNE_mask
            end If
        else
            read_LD_OUT_CM_TUNE_value = data_low and LD_OUT_CM_TUNE_mask
        end If

    End Sub

    Sub write
        If flag_LD_IN_BIAS_TUNE = &H0 or flag_LD_OUT_BIAS_TUNE = &H0 or flag_LD_OUT_IQ_TUNE = &H0 or flag_LD_OUT_CM_TUNE = &H0 Then read
        If flag_LD_IN_BIAS_TUNE = &H0 Then write_LD_IN_BIAS_TUNE_value = get_LD_IN_BIAS_TUNE
        If flag_LD_OUT_BIAS_TUNE = &H0 Then write_LD_OUT_BIAS_TUNE_value = get_LD_OUT_BIAS_TUNE
        If flag_LD_OUT_IQ_TUNE = &H0 Then write_LD_OUT_IQ_TUNE_value = get_LD_OUT_IQ_TUNE
        If flag_LD_OUT_CM_TUNE = &H0 Then write_LD_OUT_CM_TUNE_value = get_LD_OUT_CM_TUNE

        regValue = leftShift((write_LD_IN_BIAS_TUNE_value and &Hf), 12) + leftShift((write_LD_OUT_BIAS_TUNE_value and &Hf), 8) + leftShift((write_LD_OUT_IQ_TUNE_value and &Hf), 4) + leftShift((write_LD_OUT_CM_TUNE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_IN_BIAS_TUNE_value = rightShift(data_low, 12) and &Hf
        read_LD_OUT_BIAS_TUNE_value = rightShift(data_low, 8) and &Hf
        read_LD_OUT_IQ_TUNE_value = rightShift(data_low, 4) and &Hf
        LD_OUT_CM_TUNE_mask = &Hf
        if data_low > LONG_MAX then
            if LD_OUT_CM_TUNE_mask = mask then
                read_LD_OUT_CM_TUNE_value = data_low
            else
                read_LD_OUT_CM_TUNE_value = (data_low - H8000_0000) and LD_OUT_CM_TUNE_mask
            end If
        else
            read_LD_OUT_CM_TUNE_value = data_low and LD_OUT_CM_TUNE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LD_IN_BIAS_TUNE_value = &H0
        flag_LD_IN_BIAS_TUNE        = &H0
        write_LD_OUT_BIAS_TUNE_value = &H0
        flag_LD_OUT_BIAS_TUNE        = &H0
        write_LD_OUT_IQ_TUNE_value = &H0
        flag_LD_OUT_IQ_TUNE        = &H0
        write_LD_OUT_CM_TUNE_value = &H0
        flag_LD_OUT_CM_TUNE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IDAC_CM_LOOP_BIAS                          [15:12]          get_IDAC_CM_LOOP_BIAS
''                                                             set_IDAC_CM_LOOP_BIAS
''                                                             read_IDAC_CM_LOOP_BIAS
''                                                             write_IDAC_CM_LOOP_BIAS
''---------------------------------------------------------------------------------
'' IDAC_CASCODE_BIAS                          [11:8]           get_IDAC_CASCODE_BIAS
''                                                             set_IDAC_CASCODE_BIAS
''                                                             read_IDAC_CASCODE_BIAS
''                                                             write_IDAC_CASCODE_BIAS
''---------------------------------------------------------------------------------
'' RESERVED_0704                              [7:4]            get_RESERVED_0704
''                                                             set_RESERVED_0704
''                                                             read_RESERVED_0704
''                                                             write_RESERVED_0704
''---------------------------------------------------------------------------------
'' LD_IN_BTUNE_1G                             [3:0]            get_LD_IN_BTUNE_1G
''                                                             set_LD_IN_BTUNE_1G
''                                                             read_LD_IN_BTUNE_1G
''                                                             write_LD_IN_BTUNE_1G
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_5
    Private write_IDAC_CM_LOOP_BIAS_value
    Private read_IDAC_CM_LOOP_BIAS_value
    Private flag_IDAC_CM_LOOP_BIAS
    Private write_IDAC_CASCODE_BIAS_value
    Private read_IDAC_CASCODE_BIAS_value
    Private flag_IDAC_CASCODE_BIAS
    Private write_RESERVED_0704_value
    Private read_RESERVED_0704_value
    Private flag_RESERVED_0704
    Private write_LD_IN_BTUNE_1G_value
    Private read_LD_IN_BTUNE_1G_value
    Private flag_LD_IN_BTUNE_1G

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

    Property Get get_IDAC_CM_LOOP_BIAS
        get_IDAC_CM_LOOP_BIAS = read_IDAC_CM_LOOP_BIAS_value
    End Property

    Property Let set_IDAC_CM_LOOP_BIAS(aData)
        write_IDAC_CM_LOOP_BIAS_value = aData
        flag_IDAC_CM_LOOP_BIAS        = &H1
    End Property

    Property Get read_IDAC_CM_LOOP_BIAS
        read
        read_IDAC_CM_LOOP_BIAS = read_IDAC_CM_LOOP_BIAS_value
    End Property

    Property Let write_IDAC_CM_LOOP_BIAS(aData)
        set_IDAC_CM_LOOP_BIAS = aData
        write
    End Property

    Property Get get_IDAC_CASCODE_BIAS
        get_IDAC_CASCODE_BIAS = read_IDAC_CASCODE_BIAS_value
    End Property

    Property Let set_IDAC_CASCODE_BIAS(aData)
        write_IDAC_CASCODE_BIAS_value = aData
        flag_IDAC_CASCODE_BIAS        = &H1
    End Property

    Property Get read_IDAC_CASCODE_BIAS
        read
        read_IDAC_CASCODE_BIAS = read_IDAC_CASCODE_BIAS_value
    End Property

    Property Let write_IDAC_CASCODE_BIAS(aData)
        set_IDAC_CASCODE_BIAS = aData
        write
    End Property

    Property Get get_RESERVED_0704
        get_RESERVED_0704 = read_RESERVED_0704_value
    End Property

    Property Let set_RESERVED_0704(aData)
        write_RESERVED_0704_value = aData
        flag_RESERVED_0704        = &H1
    End Property

    Property Get read_RESERVED_0704
        read
        read_RESERVED_0704 = read_RESERVED_0704_value
    End Property

    Property Let write_RESERVED_0704(aData)
        set_RESERVED_0704 = aData
        write
    End Property

    Property Get get_LD_IN_BTUNE_1G
        get_LD_IN_BTUNE_1G = read_LD_IN_BTUNE_1G_value
    End Property

    Property Let set_LD_IN_BTUNE_1G(aData)
        write_LD_IN_BTUNE_1G_value = aData
        flag_LD_IN_BTUNE_1G        = &H1
    End Property

    Property Get read_LD_IN_BTUNE_1G
        read
        read_LD_IN_BTUNE_1G = read_LD_IN_BTUNE_1G_value
    End Property

    Property Let write_LD_IN_BTUNE_1G(aData)
        set_LD_IN_BTUNE_1G = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IDAC_CM_LOOP_BIAS_value = rightShift(data_low, 12) and &Hf
        read_IDAC_CASCODE_BIAS_value = rightShift(data_low, 8) and &Hf
        read_RESERVED_0704_value = rightShift(data_low, 4) and &Hf
        LD_IN_BTUNE_1G_mask = &Hf
        if data_low > LONG_MAX then
            if LD_IN_BTUNE_1G_mask = mask then
                read_LD_IN_BTUNE_1G_value = data_low
            else
                read_LD_IN_BTUNE_1G_value = (data_low - H8000_0000) and LD_IN_BTUNE_1G_mask
            end If
        else
            read_LD_IN_BTUNE_1G_value = data_low and LD_IN_BTUNE_1G_mask
        end If

    End Sub

    Sub write
        If flag_IDAC_CM_LOOP_BIAS = &H0 or flag_IDAC_CASCODE_BIAS = &H0 or flag_RESERVED_0704 = &H0 or flag_LD_IN_BTUNE_1G = &H0 Then read
        If flag_IDAC_CM_LOOP_BIAS = &H0 Then write_IDAC_CM_LOOP_BIAS_value = get_IDAC_CM_LOOP_BIAS
        If flag_IDAC_CASCODE_BIAS = &H0 Then write_IDAC_CASCODE_BIAS_value = get_IDAC_CASCODE_BIAS
        If flag_RESERVED_0704 = &H0 Then write_RESERVED_0704_value = get_RESERVED_0704
        If flag_LD_IN_BTUNE_1G = &H0 Then write_LD_IN_BTUNE_1G_value = get_LD_IN_BTUNE_1G

        regValue = leftShift((write_IDAC_CM_LOOP_BIAS_value and &Hf), 12) + leftShift((write_IDAC_CASCODE_BIAS_value and &Hf), 8) + leftShift((write_RESERVED_0704_value and &Hf), 4) + leftShift((write_LD_IN_BTUNE_1G_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IDAC_CM_LOOP_BIAS_value = rightShift(data_low, 12) and &Hf
        read_IDAC_CASCODE_BIAS_value = rightShift(data_low, 8) and &Hf
        read_RESERVED_0704_value = rightShift(data_low, 4) and &Hf
        LD_IN_BTUNE_1G_mask = &Hf
        if data_low > LONG_MAX then
            if LD_IN_BTUNE_1G_mask = mask then
                read_LD_IN_BTUNE_1G_value = data_low
            else
                read_LD_IN_BTUNE_1G_value = (data_low - H8000_0000) and LD_IN_BTUNE_1G_mask
            end If
        else
            read_LD_IN_BTUNE_1G_value = data_low and LD_IN_BTUNE_1G_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IDAC_CM_LOOP_BIAS_value = &H0
        flag_IDAC_CM_LOOP_BIAS        = &H0
        write_IDAC_CASCODE_BIAS_value = &H0
        flag_IDAC_CASCODE_BIAS        = &H0
        write_RESERVED_0704_value = &H0
        flag_RESERVED_0704        = &H0
        write_LD_IN_BTUNE_1G_value = &H0
        flag_LD_IN_BTUNE_1G        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LD_IN_BTUNE_100                            [15:12]          get_LD_IN_BTUNE_100
''                                                             set_LD_IN_BTUNE_100
''                                                             read_LD_IN_BTUNE_100
''                                                             write_LD_IN_BTUNE_100
''---------------------------------------------------------------------------------
'' LD_OUT_B_TUNE_100                          [11:8]           get_LD_OUT_B_TUNE_100
''                                                             set_LD_OUT_B_TUNE_100
''                                                             read_LD_OUT_B_TUNE_100
''                                                             write_LD_OUT_B_TUNE_100
''---------------------------------------------------------------------------------
'' LD_OUT_IQTUNE_100                          [7:4]            get_LD_OUT_IQTUNE_100
''                                                             set_LD_OUT_IQTUNE_100
''                                                             read_LD_OUT_IQTUNE_100
''                                                             write_LD_OUT_IQTUNE_100
''---------------------------------------------------------------------------------
'' LD_CM_TUNE_100                             [3:0]            get_LD_CM_TUNE_100
''                                                             set_LD_CM_TUNE_100
''                                                             read_LD_CM_TUNE_100
''                                                             write_LD_CM_TUNE_100
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_6
    Private write_LD_IN_BTUNE_100_value
    Private read_LD_IN_BTUNE_100_value
    Private flag_LD_IN_BTUNE_100
    Private write_LD_OUT_B_TUNE_100_value
    Private read_LD_OUT_B_TUNE_100_value
    Private flag_LD_OUT_B_TUNE_100
    Private write_LD_OUT_IQTUNE_100_value
    Private read_LD_OUT_IQTUNE_100_value
    Private flag_LD_OUT_IQTUNE_100
    Private write_LD_CM_TUNE_100_value
    Private read_LD_CM_TUNE_100_value
    Private flag_LD_CM_TUNE_100

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

    Property Get get_LD_IN_BTUNE_100
        get_LD_IN_BTUNE_100 = read_LD_IN_BTUNE_100_value
    End Property

    Property Let set_LD_IN_BTUNE_100(aData)
        write_LD_IN_BTUNE_100_value = aData
        flag_LD_IN_BTUNE_100        = &H1
    End Property

    Property Get read_LD_IN_BTUNE_100
        read
        read_LD_IN_BTUNE_100 = read_LD_IN_BTUNE_100_value
    End Property

    Property Let write_LD_IN_BTUNE_100(aData)
        set_LD_IN_BTUNE_100 = aData
        write
    End Property

    Property Get get_LD_OUT_B_TUNE_100
        get_LD_OUT_B_TUNE_100 = read_LD_OUT_B_TUNE_100_value
    End Property

    Property Let set_LD_OUT_B_TUNE_100(aData)
        write_LD_OUT_B_TUNE_100_value = aData
        flag_LD_OUT_B_TUNE_100        = &H1
    End Property

    Property Get read_LD_OUT_B_TUNE_100
        read
        read_LD_OUT_B_TUNE_100 = read_LD_OUT_B_TUNE_100_value
    End Property

    Property Let write_LD_OUT_B_TUNE_100(aData)
        set_LD_OUT_B_TUNE_100 = aData
        write
    End Property

    Property Get get_LD_OUT_IQTUNE_100
        get_LD_OUT_IQTUNE_100 = read_LD_OUT_IQTUNE_100_value
    End Property

    Property Let set_LD_OUT_IQTUNE_100(aData)
        write_LD_OUT_IQTUNE_100_value = aData
        flag_LD_OUT_IQTUNE_100        = &H1
    End Property

    Property Get read_LD_OUT_IQTUNE_100
        read
        read_LD_OUT_IQTUNE_100 = read_LD_OUT_IQTUNE_100_value
    End Property

    Property Let write_LD_OUT_IQTUNE_100(aData)
        set_LD_OUT_IQTUNE_100 = aData
        write
    End Property

    Property Get get_LD_CM_TUNE_100
        get_LD_CM_TUNE_100 = read_LD_CM_TUNE_100_value
    End Property

    Property Let set_LD_CM_TUNE_100(aData)
        write_LD_CM_TUNE_100_value = aData
        flag_LD_CM_TUNE_100        = &H1
    End Property

    Property Get read_LD_CM_TUNE_100
        read
        read_LD_CM_TUNE_100 = read_LD_CM_TUNE_100_value
    End Property

    Property Let write_LD_CM_TUNE_100(aData)
        set_LD_CM_TUNE_100 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_IN_BTUNE_100_value = rightShift(data_low, 12) and &Hf
        read_LD_OUT_B_TUNE_100_value = rightShift(data_low, 8) and &Hf
        read_LD_OUT_IQTUNE_100_value = rightShift(data_low, 4) and &Hf
        LD_CM_TUNE_100_mask = &Hf
        if data_low > LONG_MAX then
            if LD_CM_TUNE_100_mask = mask then
                read_LD_CM_TUNE_100_value = data_low
            else
                read_LD_CM_TUNE_100_value = (data_low - H8000_0000) and LD_CM_TUNE_100_mask
            end If
        else
            read_LD_CM_TUNE_100_value = data_low and LD_CM_TUNE_100_mask
        end If

    End Sub

    Sub write
        If flag_LD_IN_BTUNE_100 = &H0 or flag_LD_OUT_B_TUNE_100 = &H0 or flag_LD_OUT_IQTUNE_100 = &H0 or flag_LD_CM_TUNE_100 = &H0 Then read
        If flag_LD_IN_BTUNE_100 = &H0 Then write_LD_IN_BTUNE_100_value = get_LD_IN_BTUNE_100
        If flag_LD_OUT_B_TUNE_100 = &H0 Then write_LD_OUT_B_TUNE_100_value = get_LD_OUT_B_TUNE_100
        If flag_LD_OUT_IQTUNE_100 = &H0 Then write_LD_OUT_IQTUNE_100_value = get_LD_OUT_IQTUNE_100
        If flag_LD_CM_TUNE_100 = &H0 Then write_LD_CM_TUNE_100_value = get_LD_CM_TUNE_100

        regValue = leftShift((write_LD_IN_BTUNE_100_value and &Hf), 12) + leftShift((write_LD_OUT_B_TUNE_100_value and &Hf), 8) + leftShift((write_LD_OUT_IQTUNE_100_value and &Hf), 4) + leftShift((write_LD_CM_TUNE_100_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LD_IN_BTUNE_100_value = rightShift(data_low, 12) and &Hf
        read_LD_OUT_B_TUNE_100_value = rightShift(data_low, 8) and &Hf
        read_LD_OUT_IQTUNE_100_value = rightShift(data_low, 4) and &Hf
        LD_CM_TUNE_100_mask = &Hf
        if data_low > LONG_MAX then
            if LD_CM_TUNE_100_mask = mask then
                read_LD_CM_TUNE_100_value = data_low
            else
                read_LD_CM_TUNE_100_value = (data_low - H8000_0000) and LD_CM_TUNE_100_mask
            end If
        else
            read_LD_CM_TUNE_100_value = data_low and LD_CM_TUNE_100_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LD_IN_BTUNE_100_value = &H0
        flag_LD_IN_BTUNE_100        = &H0
        write_LD_OUT_B_TUNE_100_value = &H0
        flag_LD_OUT_B_TUNE_100        = &H0
        write_LD_OUT_IQTUNE_100_value = &H0
        flag_LD_OUT_IQTUNE_100        = &H0
        write_LD_CM_TUNE_100_value = &H0
        flag_LD_CM_TUNE_100        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1505                              [15:11]          get_RESERVED_1505
''                                                             set_RESERVED_1505
''                                                             read_RESERVED_1505
''                                                             write_RESERVED_1505
''---------------------------------------------------------------------------------
'' FLTR_BW_INC_AUTONEG                        [10:10]          get_FLTR_BW_INC_AUTONEG
''                                                             set_FLTR_BW_INC_AUTONEG
''                                                             read_FLTR_BW_INC_AUTONEG
''                                                             write_FLTR_BW_INC_AUTONEG
''---------------------------------------------------------------------------------
'' FILTER_BW_AUTONEG                          [9:5]            get_FILTER_BW_AUTONEG
''                                                             set_FILTER_BW_AUTONEG
''                                                             read_FILTER_BW_AUTONEG
''                                                             write_FILTER_BW_AUTONEG
''---------------------------------------------------------------------------------
'' ECD_FILTER_BW_CTRL                         [4:0]            get_ECD_FILTER_BW_CTRL
''                                                             set_ECD_FILTER_BW_CTRL
''                                                             read_ECD_FILTER_BW_CTRL
''                                                             write_ECD_FILTER_BW_CTRL
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_7
    Private write_RESERVED_1505_value
    Private read_RESERVED_1505_value
    Private flag_RESERVED_1505
    Private write_FLTR_BW_INC_AUTONEG_value
    Private read_FLTR_BW_INC_AUTONEG_value
    Private flag_FLTR_BW_INC_AUTONEG
    Private write_FILTER_BW_AUTONEG_value
    Private read_FILTER_BW_AUTONEG_value
    Private flag_FILTER_BW_AUTONEG
    Private write_ECD_FILTER_BW_CTRL_value
    Private read_ECD_FILTER_BW_CTRL_value
    Private flag_ECD_FILTER_BW_CTRL

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

    Property Get get_RESERVED_1505
        get_RESERVED_1505 = read_RESERVED_1505_value
    End Property

    Property Let set_RESERVED_1505(aData)
        write_RESERVED_1505_value = aData
        flag_RESERVED_1505        = &H1
    End Property

    Property Get read_RESERVED_1505
        read
        read_RESERVED_1505 = read_RESERVED_1505_value
    End Property

    Property Let write_RESERVED_1505(aData)
        set_RESERVED_1505 = aData
        write
    End Property

    Property Get get_FLTR_BW_INC_AUTONEG
        get_FLTR_BW_INC_AUTONEG = read_FLTR_BW_INC_AUTONEG_value
    End Property

    Property Let set_FLTR_BW_INC_AUTONEG(aData)
        write_FLTR_BW_INC_AUTONEG_value = aData
        flag_FLTR_BW_INC_AUTONEG        = &H1
    End Property

    Property Get read_FLTR_BW_INC_AUTONEG
        read
        read_FLTR_BW_INC_AUTONEG = read_FLTR_BW_INC_AUTONEG_value
    End Property

    Property Let write_FLTR_BW_INC_AUTONEG(aData)
        set_FLTR_BW_INC_AUTONEG = aData
        write
    End Property

    Property Get get_FILTER_BW_AUTONEG
        get_FILTER_BW_AUTONEG = read_FILTER_BW_AUTONEG_value
    End Property

    Property Let set_FILTER_BW_AUTONEG(aData)
        write_FILTER_BW_AUTONEG_value = aData
        flag_FILTER_BW_AUTONEG        = &H1
    End Property

    Property Get read_FILTER_BW_AUTONEG
        read
        read_FILTER_BW_AUTONEG = read_FILTER_BW_AUTONEG_value
    End Property

    Property Let write_FILTER_BW_AUTONEG(aData)
        set_FILTER_BW_AUTONEG = aData
        write
    End Property

    Property Get get_ECD_FILTER_BW_CTRL
        get_ECD_FILTER_BW_CTRL = read_ECD_FILTER_BW_CTRL_value
    End Property

    Property Let set_ECD_FILTER_BW_CTRL(aData)
        write_ECD_FILTER_BW_CTRL_value = aData
        flag_ECD_FILTER_BW_CTRL        = &H1
    End Property

    Property Get read_ECD_FILTER_BW_CTRL
        read
        read_ECD_FILTER_BW_CTRL = read_ECD_FILTER_BW_CTRL_value
    End Property

    Property Let write_ECD_FILTER_BW_CTRL(aData)
        set_ECD_FILTER_BW_CTRL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1505_value = rightShift(data_low, 11) and &H1f
        read_FLTR_BW_INC_AUTONEG_value = rightShift(data_low, 10) and &H1
        read_FILTER_BW_AUTONEG_value = rightShift(data_low, 5) and &H1f
        ECD_FILTER_BW_CTRL_mask = &H1f
        if data_low > LONG_MAX then
            if ECD_FILTER_BW_CTRL_mask = mask then
                read_ECD_FILTER_BW_CTRL_value = data_low
            else
                read_ECD_FILTER_BW_CTRL_value = (data_low - H8000_0000) and ECD_FILTER_BW_CTRL_mask
            end If
        else
            read_ECD_FILTER_BW_CTRL_value = data_low and ECD_FILTER_BW_CTRL_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1505 = &H0 or flag_FLTR_BW_INC_AUTONEG = &H0 or flag_FILTER_BW_AUTONEG = &H0 or flag_ECD_FILTER_BW_CTRL = &H0 Then read
        If flag_RESERVED_1505 = &H0 Then write_RESERVED_1505_value = get_RESERVED_1505
        If flag_FLTR_BW_INC_AUTONEG = &H0 Then write_FLTR_BW_INC_AUTONEG_value = get_FLTR_BW_INC_AUTONEG
        If flag_FILTER_BW_AUTONEG = &H0 Then write_FILTER_BW_AUTONEG_value = get_FILTER_BW_AUTONEG
        If flag_ECD_FILTER_BW_CTRL = &H0 Then write_ECD_FILTER_BW_CTRL_value = get_ECD_FILTER_BW_CTRL

        regValue = leftShift((write_RESERVED_1505_value and &H1f), 11) + leftShift((write_FLTR_BW_INC_AUTONEG_value and &H1), 10) + leftShift((write_FILTER_BW_AUTONEG_value and &H1f), 5) + leftShift((write_ECD_FILTER_BW_CTRL_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1505_value = rightShift(data_low, 11) and &H1f
        read_FLTR_BW_INC_AUTONEG_value = rightShift(data_low, 10) and &H1
        read_FILTER_BW_AUTONEG_value = rightShift(data_low, 5) and &H1f
        ECD_FILTER_BW_CTRL_mask = &H1f
        if data_low > LONG_MAX then
            if ECD_FILTER_BW_CTRL_mask = mask then
                read_ECD_FILTER_BW_CTRL_value = data_low
            else
                read_ECD_FILTER_BW_CTRL_value = (data_low - H8000_0000) and ECD_FILTER_BW_CTRL_mask
            end If
        else
            read_ECD_FILTER_BW_CTRL_value = data_low and ECD_FILTER_BW_CTRL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1505_value = &H0
        flag_RESERVED_1505        = &H0
        write_FLTR_BW_INC_AUTONEG_value = &H0
        flag_FLTR_BW_INC_AUTONEG        = &H0
        write_FILTER_BW_AUTONEG_value = &H0
        flag_FILTER_BW_AUTONEG        = &H0
        write_ECD_FILTER_BW_CTRL_value = &H0
        flag_ECD_FILTER_BW_CTRL        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_tx_cfg_aneg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1504                              [15:8]           get_RESERVED_1504
''                                                             set_RESERVED_1504
''                                                             read_RESERVED_1504
''                                                             write_RESERVED_1504
''---------------------------------------------------------------------------------
'' IDAC_TUNE_LINKSYNC                         [7:4]            get_IDAC_TUNE_LINKSYNC
''                                                             set_IDAC_TUNE_LINKSYNC
''                                                             read_IDAC_TUNE_LINKSYNC
''                                                             write_IDAC_TUNE_LINKSYNC
''---------------------------------------------------------------------------------
'' IDAC_ITUNE_ANEG                            [3:0]            get_IDAC_ITUNE_ANEG
''                                                             set_IDAC_ITUNE_ANEG
''                                                             read_IDAC_ITUNE_ANEG
''                                                             write_IDAC_ITUNE_ANEG
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_tx_cfg_aneg
    Private write_RESERVED_1504_value
    Private read_RESERVED_1504_value
    Private flag_RESERVED_1504
    Private write_IDAC_TUNE_LINKSYNC_value
    Private read_IDAC_TUNE_LINKSYNC_value
    Private flag_IDAC_TUNE_LINKSYNC
    Private write_IDAC_ITUNE_ANEG_value
    Private read_IDAC_ITUNE_ANEG_value
    Private flag_IDAC_ITUNE_ANEG

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

    Property Get get_RESERVED_1504
        get_RESERVED_1504 = read_RESERVED_1504_value
    End Property

    Property Let set_RESERVED_1504(aData)
        write_RESERVED_1504_value = aData
        flag_RESERVED_1504        = &H1
    End Property

    Property Get read_RESERVED_1504
        read
        read_RESERVED_1504 = read_RESERVED_1504_value
    End Property

    Property Let write_RESERVED_1504(aData)
        set_RESERVED_1504 = aData
        write
    End Property

    Property Get get_IDAC_TUNE_LINKSYNC
        get_IDAC_TUNE_LINKSYNC = read_IDAC_TUNE_LINKSYNC_value
    End Property

    Property Let set_IDAC_TUNE_LINKSYNC(aData)
        write_IDAC_TUNE_LINKSYNC_value = aData
        flag_IDAC_TUNE_LINKSYNC        = &H1
    End Property

    Property Get read_IDAC_TUNE_LINKSYNC
        read
        read_IDAC_TUNE_LINKSYNC = read_IDAC_TUNE_LINKSYNC_value
    End Property

    Property Let write_IDAC_TUNE_LINKSYNC(aData)
        set_IDAC_TUNE_LINKSYNC = aData
        write
    End Property

    Property Get get_IDAC_ITUNE_ANEG
        get_IDAC_ITUNE_ANEG = read_IDAC_ITUNE_ANEG_value
    End Property

    Property Let set_IDAC_ITUNE_ANEG(aData)
        write_IDAC_ITUNE_ANEG_value = aData
        flag_IDAC_ITUNE_ANEG        = &H1
    End Property

    Property Get read_IDAC_ITUNE_ANEG
        read
        read_IDAC_ITUNE_ANEG = read_IDAC_ITUNE_ANEG_value
    End Property

    Property Let write_IDAC_ITUNE_ANEG(aData)
        set_IDAC_ITUNE_ANEG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1504_value = rightShift(data_low, 8) and &Hff
        read_IDAC_TUNE_LINKSYNC_value = rightShift(data_low, 4) and &Hf
        IDAC_ITUNE_ANEG_mask = &Hf
        if data_low > LONG_MAX then
            if IDAC_ITUNE_ANEG_mask = mask then
                read_IDAC_ITUNE_ANEG_value = data_low
            else
                read_IDAC_ITUNE_ANEG_value = (data_low - H8000_0000) and IDAC_ITUNE_ANEG_mask
            end If
        else
            read_IDAC_ITUNE_ANEG_value = data_low and IDAC_ITUNE_ANEG_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1504 = &H0 or flag_IDAC_TUNE_LINKSYNC = &H0 or flag_IDAC_ITUNE_ANEG = &H0 Then read
        If flag_RESERVED_1504 = &H0 Then write_RESERVED_1504_value = get_RESERVED_1504
        If flag_IDAC_TUNE_LINKSYNC = &H0 Then write_IDAC_TUNE_LINKSYNC_value = get_IDAC_TUNE_LINKSYNC
        If flag_IDAC_ITUNE_ANEG = &H0 Then write_IDAC_ITUNE_ANEG_value = get_IDAC_ITUNE_ANEG

        regValue = leftShift((write_RESERVED_1504_value and &Hff), 8) + leftShift((write_IDAC_TUNE_LINKSYNC_value and &Hf), 4) + leftShift((write_IDAC_ITUNE_ANEG_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1504_value = rightShift(data_low, 8) and &Hff
        read_IDAC_TUNE_LINKSYNC_value = rightShift(data_low, 4) and &Hf
        IDAC_ITUNE_ANEG_mask = &Hf
        if data_low > LONG_MAX then
            if IDAC_ITUNE_ANEG_mask = mask then
                read_IDAC_ITUNE_ANEG_value = data_low
            else
                read_IDAC_ITUNE_ANEG_value = (data_low - H8000_0000) and IDAC_ITUNE_ANEG_mask
            end If
        else
            read_IDAC_ITUNE_ANEG_value = data_low and IDAC_ITUNE_ANEG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1504_value = &H0
        flag_RESERVED_1504        = &H0
        write_IDAC_TUNE_LINKSYNC_value = &H0
        flag_IDAC_TUNE_LINKSYNC        = &H0
        write_IDAC_ITUNE_ANEG_value = &H0
        flag_IDAC_ITUNE_ANEG        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_hyb_cfg_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CURRENT_CTRL                               [15:12]          get_CURRENT_CTRL
''                                                             set_CURRENT_CTRL
''                                                             read_CURRENT_CTRL
''                                                             write_CURRENT_CTRL
''---------------------------------------------------------------------------------
'' PAG_AMP_1ST                                [11:8]           get_PAG_AMP_1ST
''                                                             set_PAG_AMP_1ST
''                                                             read_PAG_AMP_1ST
''                                                             write_PAG_AMP_1ST
''---------------------------------------------------------------------------------
'' PAG_AMP_2ND                                [7:4]            get_PAG_AMP_2ND
''                                                             set_PAG_AMP_2ND
''                                                             read_PAG_AMP_2ND
''                                                             write_PAG_AMP_2ND
''---------------------------------------------------------------------------------
'' PGA_AMP_CMFB                               [3:0]            get_PGA_AMP_CMFB
''                                                             set_PGA_AMP_CMFB
''                                                             read_PGA_AMP_CMFB
''                                                             write_PGA_AMP_CMFB
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_hyb_cfg_0
    Private write_CURRENT_CTRL_value
    Private read_CURRENT_CTRL_value
    Private flag_CURRENT_CTRL
    Private write_PAG_AMP_1ST_value
    Private read_PAG_AMP_1ST_value
    Private flag_PAG_AMP_1ST
    Private write_PAG_AMP_2ND_value
    Private read_PAG_AMP_2ND_value
    Private flag_PAG_AMP_2ND
    Private write_PGA_AMP_CMFB_value
    Private read_PGA_AMP_CMFB_value
    Private flag_PGA_AMP_CMFB

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

    Property Get get_CURRENT_CTRL
        get_CURRENT_CTRL = read_CURRENT_CTRL_value
    End Property

    Property Let set_CURRENT_CTRL(aData)
        write_CURRENT_CTRL_value = aData
        flag_CURRENT_CTRL        = &H1
    End Property

    Property Get read_CURRENT_CTRL
        read
        read_CURRENT_CTRL = read_CURRENT_CTRL_value
    End Property

    Property Let write_CURRENT_CTRL(aData)
        set_CURRENT_CTRL = aData
        write
    End Property

    Property Get get_PAG_AMP_1ST
        get_PAG_AMP_1ST = read_PAG_AMP_1ST_value
    End Property

    Property Let set_PAG_AMP_1ST(aData)
        write_PAG_AMP_1ST_value = aData
        flag_PAG_AMP_1ST        = &H1
    End Property

    Property Get read_PAG_AMP_1ST
        read
        read_PAG_AMP_1ST = read_PAG_AMP_1ST_value
    End Property

    Property Let write_PAG_AMP_1ST(aData)
        set_PAG_AMP_1ST = aData
        write
    End Property

    Property Get get_PAG_AMP_2ND
        get_PAG_AMP_2ND = read_PAG_AMP_2ND_value
    End Property

    Property Let set_PAG_AMP_2ND(aData)
        write_PAG_AMP_2ND_value = aData
        flag_PAG_AMP_2ND        = &H1
    End Property

    Property Get read_PAG_AMP_2ND
        read
        read_PAG_AMP_2ND = read_PAG_AMP_2ND_value
    End Property

    Property Let write_PAG_AMP_2ND(aData)
        set_PAG_AMP_2ND = aData
        write
    End Property

    Property Get get_PGA_AMP_CMFB
        get_PGA_AMP_CMFB = read_PGA_AMP_CMFB_value
    End Property

    Property Let set_PGA_AMP_CMFB(aData)
        write_PGA_AMP_CMFB_value = aData
        flag_PGA_AMP_CMFB        = &H1
    End Property

    Property Get read_PGA_AMP_CMFB
        read
        read_PGA_AMP_CMFB = read_PGA_AMP_CMFB_value
    End Property

    Property Let write_PGA_AMP_CMFB(aData)
        set_PGA_AMP_CMFB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CURRENT_CTRL_value = rightShift(data_low, 12) and &Hf
        read_PAG_AMP_1ST_value = rightShift(data_low, 8) and &Hf
        read_PAG_AMP_2ND_value = rightShift(data_low, 4) and &Hf
        PGA_AMP_CMFB_mask = &Hf
        if data_low > LONG_MAX then
            if PGA_AMP_CMFB_mask = mask then
                read_PGA_AMP_CMFB_value = data_low
            else
                read_PGA_AMP_CMFB_value = (data_low - H8000_0000) and PGA_AMP_CMFB_mask
            end If
        else
            read_PGA_AMP_CMFB_value = data_low and PGA_AMP_CMFB_mask
        end If

    End Sub

    Sub write
        If flag_CURRENT_CTRL = &H0 or flag_PAG_AMP_1ST = &H0 or flag_PAG_AMP_2ND = &H0 or flag_PGA_AMP_CMFB = &H0 Then read
        If flag_CURRENT_CTRL = &H0 Then write_CURRENT_CTRL_value = get_CURRENT_CTRL
        If flag_PAG_AMP_1ST = &H0 Then write_PAG_AMP_1ST_value = get_PAG_AMP_1ST
        If flag_PAG_AMP_2ND = &H0 Then write_PAG_AMP_2ND_value = get_PAG_AMP_2ND
        If flag_PGA_AMP_CMFB = &H0 Then write_PGA_AMP_CMFB_value = get_PGA_AMP_CMFB

        regValue = leftShift((write_CURRENT_CTRL_value and &Hf), 12) + leftShift((write_PAG_AMP_1ST_value and &Hf), 8) + leftShift((write_PAG_AMP_2ND_value and &Hf), 4) + leftShift((write_PGA_AMP_CMFB_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CURRENT_CTRL_value = rightShift(data_low, 12) and &Hf
        read_PAG_AMP_1ST_value = rightShift(data_low, 8) and &Hf
        read_PAG_AMP_2ND_value = rightShift(data_low, 4) and &Hf
        PGA_AMP_CMFB_mask = &Hf
        if data_low > LONG_MAX then
            if PGA_AMP_CMFB_mask = mask then
                read_PGA_AMP_CMFB_value = data_low
            else
                read_PGA_AMP_CMFB_value = (data_low - H8000_0000) and PGA_AMP_CMFB_mask
            end If
        else
            read_PGA_AMP_CMFB_value = data_low and PGA_AMP_CMFB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CURRENT_CTRL_value = &H0
        flag_CURRENT_CTRL        = &H0
        write_PAG_AMP_1ST_value = &H0
        flag_PAG_AMP_1ST        = &H0
        write_PAG_AMP_2ND_value = &H0
        flag_PAG_AMP_2ND        = &H0
        write_PGA_AMP_CMFB_value = &H0
        flag_PGA_AMP_CMFB        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_hyb_cfg_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' HYB_COMPEN_CAP                             [15:12]          get_HYB_COMPEN_CAP
''                                                             set_HYB_COMPEN_CAP
''                                                             read_HYB_COMPEN_CAP
''                                                             write_HYB_COMPEN_CAP
''---------------------------------------------------------------------------------
'' CM_CLAMP_PD_1000                           [11:11]          get_CM_CLAMP_PD_1000
''                                                             set_CM_CLAMP_PD_1000
''                                                             read_CM_CLAMP_PD_1000
''                                                             write_CM_CLAMP_PD_1000
''---------------------------------------------------------------------------------
'' BOOTSTRAP_PD_CTRL                          [10:10]          get_BOOTSTRAP_PD_CTRL
''                                                             set_BOOTSTRAP_PD_CTRL
''                                                             read_BOOTSTRAP_PD_CTRL
''                                                             write_BOOTSTRAP_PD_CTRL
''---------------------------------------------------------------------------------
'' CM_CLAMP_PD_100BT                          [9:9]            get_CM_CLAMP_PD_100BT
''                                                             set_CM_CLAMP_PD_100BT
''                                                             read_CM_CLAMP_PD_100BT
''                                                             write_CM_CLAMP_PD_100BT
''---------------------------------------------------------------------------------
'' RESERVED_0808                              [8:8]            get_RESERVED_0808
''                                                             set_RESERVED_0808
''                                                             read_RESERVED_0808
''                                                             write_RESERVED_0808
''---------------------------------------------------------------------------------
'' CM_CLAMP_OUT_TUNE                          [7:4]            get_CM_CLAMP_OUT_TUNE
''                                                             set_CM_CLAMP_OUT_TUNE
''                                                             read_CM_CLAMP_OUT_TUNE
''                                                             write_CM_CLAMP_OUT_TUNE
''---------------------------------------------------------------------------------
'' CM_CLAMP_IN_TUNE                           [3:0]            get_CM_CLAMP_IN_TUNE
''                                                             set_CM_CLAMP_IN_TUNE
''                                                             read_CM_CLAMP_IN_TUNE
''                                                             write_CM_CLAMP_IN_TUNE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_hyb_cfg_1
    Private write_HYB_COMPEN_CAP_value
    Private read_HYB_COMPEN_CAP_value
    Private flag_HYB_COMPEN_CAP
    Private write_CM_CLAMP_PD_1000_value
    Private read_CM_CLAMP_PD_1000_value
    Private flag_CM_CLAMP_PD_1000
    Private write_BOOTSTRAP_PD_CTRL_value
    Private read_BOOTSTRAP_PD_CTRL_value
    Private flag_BOOTSTRAP_PD_CTRL
    Private write_CM_CLAMP_PD_100BT_value
    Private read_CM_CLAMP_PD_100BT_value
    Private flag_CM_CLAMP_PD_100BT
    Private write_RESERVED_0808_value
    Private read_RESERVED_0808_value
    Private flag_RESERVED_0808
    Private write_CM_CLAMP_OUT_TUNE_value
    Private read_CM_CLAMP_OUT_TUNE_value
    Private flag_CM_CLAMP_OUT_TUNE
    Private write_CM_CLAMP_IN_TUNE_value
    Private read_CM_CLAMP_IN_TUNE_value
    Private flag_CM_CLAMP_IN_TUNE

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

    Property Get get_HYB_COMPEN_CAP
        get_HYB_COMPEN_CAP = read_HYB_COMPEN_CAP_value
    End Property

    Property Let set_HYB_COMPEN_CAP(aData)
        write_HYB_COMPEN_CAP_value = aData
        flag_HYB_COMPEN_CAP        = &H1
    End Property

    Property Get read_HYB_COMPEN_CAP
        read
        read_HYB_COMPEN_CAP = read_HYB_COMPEN_CAP_value
    End Property

    Property Let write_HYB_COMPEN_CAP(aData)
        set_HYB_COMPEN_CAP = aData
        write
    End Property

    Property Get get_CM_CLAMP_PD_1000
        get_CM_CLAMP_PD_1000 = read_CM_CLAMP_PD_1000_value
    End Property

    Property Let set_CM_CLAMP_PD_1000(aData)
        write_CM_CLAMP_PD_1000_value = aData
        flag_CM_CLAMP_PD_1000        = &H1
    End Property

    Property Get read_CM_CLAMP_PD_1000
        read
        read_CM_CLAMP_PD_1000 = read_CM_CLAMP_PD_1000_value
    End Property

    Property Let write_CM_CLAMP_PD_1000(aData)
        set_CM_CLAMP_PD_1000 = aData
        write
    End Property

    Property Get get_BOOTSTRAP_PD_CTRL
        get_BOOTSTRAP_PD_CTRL = read_BOOTSTRAP_PD_CTRL_value
    End Property

    Property Let set_BOOTSTRAP_PD_CTRL(aData)
        write_BOOTSTRAP_PD_CTRL_value = aData
        flag_BOOTSTRAP_PD_CTRL        = &H1
    End Property

    Property Get read_BOOTSTRAP_PD_CTRL
        read
        read_BOOTSTRAP_PD_CTRL = read_BOOTSTRAP_PD_CTRL_value
    End Property

    Property Let write_BOOTSTRAP_PD_CTRL(aData)
        set_BOOTSTRAP_PD_CTRL = aData
        write
    End Property

    Property Get get_CM_CLAMP_PD_100BT
        get_CM_CLAMP_PD_100BT = read_CM_CLAMP_PD_100BT_value
    End Property

    Property Let set_CM_CLAMP_PD_100BT(aData)
        write_CM_CLAMP_PD_100BT_value = aData
        flag_CM_CLAMP_PD_100BT        = &H1
    End Property

    Property Get read_CM_CLAMP_PD_100BT
        read
        read_CM_CLAMP_PD_100BT = read_CM_CLAMP_PD_100BT_value
    End Property

    Property Let write_CM_CLAMP_PD_100BT(aData)
        set_CM_CLAMP_PD_100BT = aData
        write
    End Property

    Property Get get_RESERVED_0808
        get_RESERVED_0808 = read_RESERVED_0808_value
    End Property

    Property Let set_RESERVED_0808(aData)
        write_RESERVED_0808_value = aData
        flag_RESERVED_0808        = &H1
    End Property

    Property Get read_RESERVED_0808
        read
        read_RESERVED_0808 = read_RESERVED_0808_value
    End Property

    Property Let write_RESERVED_0808(aData)
        set_RESERVED_0808 = aData
        write
    End Property

    Property Get get_CM_CLAMP_OUT_TUNE
        get_CM_CLAMP_OUT_TUNE = read_CM_CLAMP_OUT_TUNE_value
    End Property

    Property Let set_CM_CLAMP_OUT_TUNE(aData)
        write_CM_CLAMP_OUT_TUNE_value = aData
        flag_CM_CLAMP_OUT_TUNE        = &H1
    End Property

    Property Get read_CM_CLAMP_OUT_TUNE
        read
        read_CM_CLAMP_OUT_TUNE = read_CM_CLAMP_OUT_TUNE_value
    End Property

    Property Let write_CM_CLAMP_OUT_TUNE(aData)
        set_CM_CLAMP_OUT_TUNE = aData
        write
    End Property

    Property Get get_CM_CLAMP_IN_TUNE
        get_CM_CLAMP_IN_TUNE = read_CM_CLAMP_IN_TUNE_value
    End Property

    Property Let set_CM_CLAMP_IN_TUNE(aData)
        write_CM_CLAMP_IN_TUNE_value = aData
        flag_CM_CLAMP_IN_TUNE        = &H1
    End Property

    Property Get read_CM_CLAMP_IN_TUNE
        read
        read_CM_CLAMP_IN_TUNE = read_CM_CLAMP_IN_TUNE_value
    End Property

    Property Let write_CM_CLAMP_IN_TUNE(aData)
        set_CM_CLAMP_IN_TUNE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HYB_COMPEN_CAP_value = rightShift(data_low, 12) and &Hf
        read_CM_CLAMP_PD_1000_value = rightShift(data_low, 11) and &H1
        read_BOOTSTRAP_PD_CTRL_value = rightShift(data_low, 10) and &H1
        read_CM_CLAMP_PD_100BT_value = rightShift(data_low, 9) and &H1
        read_RESERVED_0808_value = rightShift(data_low, 8) and &H1
        read_CM_CLAMP_OUT_TUNE_value = rightShift(data_low, 4) and &Hf
        CM_CLAMP_IN_TUNE_mask = &Hf
        if data_low > LONG_MAX then
            if CM_CLAMP_IN_TUNE_mask = mask then
                read_CM_CLAMP_IN_TUNE_value = data_low
            else
                read_CM_CLAMP_IN_TUNE_value = (data_low - H8000_0000) and CM_CLAMP_IN_TUNE_mask
            end If
        else
            read_CM_CLAMP_IN_TUNE_value = data_low and CM_CLAMP_IN_TUNE_mask
        end If

    End Sub

    Sub write
        If flag_HYB_COMPEN_CAP = &H0 or flag_CM_CLAMP_PD_1000 = &H0 or flag_BOOTSTRAP_PD_CTRL = &H0 or flag_CM_CLAMP_PD_100BT = &H0 or flag_RESERVED_0808 = &H0 or flag_CM_CLAMP_OUT_TUNE = &H0 or flag_CM_CLAMP_IN_TUNE = &H0 Then read
        If flag_HYB_COMPEN_CAP = &H0 Then write_HYB_COMPEN_CAP_value = get_HYB_COMPEN_CAP
        If flag_CM_CLAMP_PD_1000 = &H0 Then write_CM_CLAMP_PD_1000_value = get_CM_CLAMP_PD_1000
        If flag_BOOTSTRAP_PD_CTRL = &H0 Then write_BOOTSTRAP_PD_CTRL_value = get_BOOTSTRAP_PD_CTRL
        If flag_CM_CLAMP_PD_100BT = &H0 Then write_CM_CLAMP_PD_100BT_value = get_CM_CLAMP_PD_100BT
        If flag_RESERVED_0808 = &H0 Then write_RESERVED_0808_value = get_RESERVED_0808
        If flag_CM_CLAMP_OUT_TUNE = &H0 Then write_CM_CLAMP_OUT_TUNE_value = get_CM_CLAMP_OUT_TUNE
        If flag_CM_CLAMP_IN_TUNE = &H0 Then write_CM_CLAMP_IN_TUNE_value = get_CM_CLAMP_IN_TUNE

        regValue = leftShift((write_HYB_COMPEN_CAP_value and &Hf), 12) + leftShift((write_CM_CLAMP_PD_1000_value and &H1), 11) + leftShift((write_BOOTSTRAP_PD_CTRL_value and &H1), 10) + leftShift((write_CM_CLAMP_PD_100BT_value and &H1), 9) + leftShift((write_RESERVED_0808_value and &H1), 8) + leftShift((write_CM_CLAMP_OUT_TUNE_value and &Hf), 4) + leftShift((write_CM_CLAMP_IN_TUNE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HYB_COMPEN_CAP_value = rightShift(data_low, 12) and &Hf
        read_CM_CLAMP_PD_1000_value = rightShift(data_low, 11) and &H1
        read_BOOTSTRAP_PD_CTRL_value = rightShift(data_low, 10) and &H1
        read_CM_CLAMP_PD_100BT_value = rightShift(data_low, 9) and &H1
        read_RESERVED_0808_value = rightShift(data_low, 8) and &H1
        read_CM_CLAMP_OUT_TUNE_value = rightShift(data_low, 4) and &Hf
        CM_CLAMP_IN_TUNE_mask = &Hf
        if data_low > LONG_MAX then
            if CM_CLAMP_IN_TUNE_mask = mask then
                read_CM_CLAMP_IN_TUNE_value = data_low
            else
                read_CM_CLAMP_IN_TUNE_value = (data_low - H8000_0000) and CM_CLAMP_IN_TUNE_mask
            end If
        else
            read_CM_CLAMP_IN_TUNE_value = data_low and CM_CLAMP_IN_TUNE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_HYB_COMPEN_CAP_value = &H0
        flag_HYB_COMPEN_CAP        = &H0
        write_CM_CLAMP_PD_1000_value = &H0
        flag_CM_CLAMP_PD_1000        = &H0
        write_BOOTSTRAP_PD_CTRL_value = &H0
        flag_BOOTSTRAP_PD_CTRL        = &H0
        write_CM_CLAMP_PD_100BT_value = &H0
        flag_CM_CLAMP_PD_100BT        = &H0
        write_RESERVED_0808_value = &H0
        flag_RESERVED_0808        = &H0
        write_CM_CLAMP_OUT_TUNE_value = &H0
        flag_CM_CLAMP_OUT_TUNE        = &H0
        write_CM_CLAMP_IN_TUNE_value = &H0
        flag_CM_CLAMP_IN_TUNE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_lpf_hpf_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1514                              [15:14]          get_RESERVED_1514
''                                                             set_RESERVED_1514
''                                                             read_RESERVED_1514
''                                                             write_RESERVED_1514
''---------------------------------------------------------------------------------
'' RXHPF_1GBT                                 [13:12]          get_RXHPF_1GBT
''                                                             set_RXHPF_1GBT
''                                                             read_RXHPF_1GBT
''                                                             write_RXHPF_1GBT
''---------------------------------------------------------------------------------
'' RXLPF_1GBT                                 [11:8]           get_RXLPF_1GBT
''                                                             set_RXLPF_1GBT
''                                                             read_RXLPF_1GBT
''                                                             write_RXLPF_1GBT
''---------------------------------------------------------------------------------
'' RESERVED_0707                              [7:7]            get_RESERVED_0707
''                                                             set_RESERVED_0707
''                                                             read_RESERVED_0707
''                                                             write_RESERVED_0707
''---------------------------------------------------------------------------------
'' RXHPF_100BT                                [6:4]            get_RXHPF_100BT
''                                                             set_RXHPF_100BT
''                                                             read_RXHPF_100BT
''                                                             write_RXHPF_100BT
''---------------------------------------------------------------------------------
'' RESERVED_0303                              [3:3]            get_RESERVED_0303
''                                                             set_RESERVED_0303
''                                                             read_RESERVED_0303
''                                                             write_RESERVED_0303
''---------------------------------------------------------------------------------
'' RXLPF_100BT                                [2:0]            get_RXLPF_100BT
''                                                             set_RXLPF_100BT
''                                                             read_RXLPF_100BT
''                                                             write_RXLPF_100BT
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_lpf_hpf_ctrl
    Private write_RESERVED_1514_value
    Private read_RESERVED_1514_value
    Private flag_RESERVED_1514
    Private write_RXHPF_1GBT_value
    Private read_RXHPF_1GBT_value
    Private flag_RXHPF_1GBT
    Private write_RXLPF_1GBT_value
    Private read_RXLPF_1GBT_value
    Private flag_RXLPF_1GBT
    Private write_RESERVED_0707_value
    Private read_RESERVED_0707_value
    Private flag_RESERVED_0707
    Private write_RXHPF_100BT_value
    Private read_RXHPF_100BT_value
    Private flag_RXHPF_100BT
    Private write_RESERVED_0303_value
    Private read_RESERVED_0303_value
    Private flag_RESERVED_0303
    Private write_RXLPF_100BT_value
    Private read_RXLPF_100BT_value
    Private flag_RXLPF_100BT

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

    Property Get get_RESERVED_1514
        get_RESERVED_1514 = read_RESERVED_1514_value
    End Property

    Property Let set_RESERVED_1514(aData)
        write_RESERVED_1514_value = aData
        flag_RESERVED_1514        = &H1
    End Property

    Property Get read_RESERVED_1514
        read
        read_RESERVED_1514 = read_RESERVED_1514_value
    End Property

    Property Let write_RESERVED_1514(aData)
        set_RESERVED_1514 = aData
        write
    End Property

    Property Get get_RXHPF_1GBT
        get_RXHPF_1GBT = read_RXHPF_1GBT_value
    End Property

    Property Let set_RXHPF_1GBT(aData)
        write_RXHPF_1GBT_value = aData
        flag_RXHPF_1GBT        = &H1
    End Property

    Property Get read_RXHPF_1GBT
        read
        read_RXHPF_1GBT = read_RXHPF_1GBT_value
    End Property

    Property Let write_RXHPF_1GBT(aData)
        set_RXHPF_1GBT = aData
        write
    End Property

    Property Get get_RXLPF_1GBT
        get_RXLPF_1GBT = read_RXLPF_1GBT_value
    End Property

    Property Let set_RXLPF_1GBT(aData)
        write_RXLPF_1GBT_value = aData
        flag_RXLPF_1GBT        = &H1
    End Property

    Property Get read_RXLPF_1GBT
        read
        read_RXLPF_1GBT = read_RXLPF_1GBT_value
    End Property

    Property Let write_RXLPF_1GBT(aData)
        set_RXLPF_1GBT = aData
        write
    End Property

    Property Get get_RESERVED_0707
        get_RESERVED_0707 = read_RESERVED_0707_value
    End Property

    Property Let set_RESERVED_0707(aData)
        write_RESERVED_0707_value = aData
        flag_RESERVED_0707        = &H1
    End Property

    Property Get read_RESERVED_0707
        read
        read_RESERVED_0707 = read_RESERVED_0707_value
    End Property

    Property Let write_RESERVED_0707(aData)
        set_RESERVED_0707 = aData
        write
    End Property

    Property Get get_RXHPF_100BT
        get_RXHPF_100BT = read_RXHPF_100BT_value
    End Property

    Property Let set_RXHPF_100BT(aData)
        write_RXHPF_100BT_value = aData
        flag_RXHPF_100BT        = &H1
    End Property

    Property Get read_RXHPF_100BT
        read
        read_RXHPF_100BT = read_RXHPF_100BT_value
    End Property

    Property Let write_RXHPF_100BT(aData)
        set_RXHPF_100BT = aData
        write
    End Property

    Property Get get_RESERVED_0303
        get_RESERVED_0303 = read_RESERVED_0303_value
    End Property

    Property Let set_RESERVED_0303(aData)
        write_RESERVED_0303_value = aData
        flag_RESERVED_0303        = &H1
    End Property

    Property Get read_RESERVED_0303
        read
        read_RESERVED_0303 = read_RESERVED_0303_value
    End Property

    Property Let write_RESERVED_0303(aData)
        set_RESERVED_0303 = aData
        write
    End Property

    Property Get get_RXLPF_100BT
        get_RXLPF_100BT = read_RXLPF_100BT_value
    End Property

    Property Let set_RXLPF_100BT(aData)
        write_RXLPF_100BT_value = aData
        flag_RXLPF_100BT        = &H1
    End Property

    Property Get read_RXLPF_100BT
        read
        read_RXLPF_100BT = read_RXLPF_100BT_value
    End Property

    Property Let write_RXLPF_100BT(aData)
        set_RXLPF_100BT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1514_value = rightShift(data_low, 14) and &H3
        read_RXHPF_1GBT_value = rightShift(data_low, 12) and &H3
        read_RXLPF_1GBT_value = rightShift(data_low, 8) and &Hf
        read_RESERVED_0707_value = rightShift(data_low, 7) and &H1
        read_RXHPF_100BT_value = rightShift(data_low, 4) and &H7
        read_RESERVED_0303_value = rightShift(data_low, 3) and &H1
        RXLPF_100BT_mask = &H7
        if data_low > LONG_MAX then
            if RXLPF_100BT_mask = mask then
                read_RXLPF_100BT_value = data_low
            else
                read_RXLPF_100BT_value = (data_low - H8000_0000) and RXLPF_100BT_mask
            end If
        else
            read_RXLPF_100BT_value = data_low and RXLPF_100BT_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1514 = &H0 or flag_RXHPF_1GBT = &H0 or flag_RXLPF_1GBT = &H0 or flag_RESERVED_0707 = &H0 or flag_RXHPF_100BT = &H0 or flag_RESERVED_0303 = &H0 or flag_RXLPF_100BT = &H0 Then read
        If flag_RESERVED_1514 = &H0 Then write_RESERVED_1514_value = get_RESERVED_1514
        If flag_RXHPF_1GBT = &H0 Then write_RXHPF_1GBT_value = get_RXHPF_1GBT
        If flag_RXLPF_1GBT = &H0 Then write_RXLPF_1GBT_value = get_RXLPF_1GBT
        If flag_RESERVED_0707 = &H0 Then write_RESERVED_0707_value = get_RESERVED_0707
        If flag_RXHPF_100BT = &H0 Then write_RXHPF_100BT_value = get_RXHPF_100BT
        If flag_RESERVED_0303 = &H0 Then write_RESERVED_0303_value = get_RESERVED_0303
        If flag_RXLPF_100BT = &H0 Then write_RXLPF_100BT_value = get_RXLPF_100BT

        regValue = leftShift((write_RESERVED_1514_value and &H3), 14) + leftShift((write_RXHPF_1GBT_value and &H3), 12) + leftShift((write_RXLPF_1GBT_value and &Hf), 8) + leftShift((write_RESERVED_0707_value and &H1), 7) + leftShift((write_RXHPF_100BT_value and &H7), 4) + leftShift((write_RESERVED_0303_value and &H1), 3) + leftShift((write_RXLPF_100BT_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1514_value = rightShift(data_low, 14) and &H3
        read_RXHPF_1GBT_value = rightShift(data_low, 12) and &H3
        read_RXLPF_1GBT_value = rightShift(data_low, 8) and &Hf
        read_RESERVED_0707_value = rightShift(data_low, 7) and &H1
        read_RXHPF_100BT_value = rightShift(data_low, 4) and &H7
        read_RESERVED_0303_value = rightShift(data_low, 3) and &H1
        RXLPF_100BT_mask = &H7
        if data_low > LONG_MAX then
            if RXLPF_100BT_mask = mask then
                read_RXLPF_100BT_value = data_low
            else
                read_RXLPF_100BT_value = (data_low - H8000_0000) and RXLPF_100BT_mask
            end If
        else
            read_RXLPF_100BT_value = data_low and RXLPF_100BT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1514_value = &H0
        flag_RESERVED_1514        = &H0
        write_RXHPF_1GBT_value = &H0
        flag_RXHPF_1GBT        = &H0
        write_RXLPF_1GBT_value = &H0
        flag_RXLPF_1GBT        = &H0
        write_RESERVED_0707_value = &H0
        flag_RESERVED_0707        = &H0
        write_RXHPF_100BT_value = &H0
        flag_RXHPF_100BT        = &H0
        write_RESERVED_0303_value = &H0
        flag_RESERVED_0303        = &H0
        write_RXLPF_100BT_value = &H0
        flag_RXLPF_100BT        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADC_CTRL_LSB                               [15:4]           get_ADC_CTRL_LSB
''                                                             set_ADC_CTRL_LSB
''                                                             read_ADC_CTRL_LSB
''                                                             write_ADC_CTRL_LSB
''---------------------------------------------------------------------------------
'' ADC_PH_SEL                                 [3:2]            get_ADC_PH_SEL
''                                                             set_ADC_PH_SEL
''                                                             read_ADC_PH_SEL
''                                                             write_ADC_PH_SEL
''---------------------------------------------------------------------------------
'' DAC_BIAS_CTRL                              [1:0]            get_DAC_BIAS_CTRL
''                                                             set_DAC_BIAS_CTRL
''                                                             read_DAC_BIAS_CTRL
''                                                             write_DAC_BIAS_CTRL
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_0
    Private write_ADC_CTRL_LSB_value
    Private read_ADC_CTRL_LSB_value
    Private flag_ADC_CTRL_LSB
    Private write_ADC_PH_SEL_value
    Private read_ADC_PH_SEL_value
    Private flag_ADC_PH_SEL
    Private write_DAC_BIAS_CTRL_value
    Private read_DAC_BIAS_CTRL_value
    Private flag_DAC_BIAS_CTRL

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

    Property Get get_ADC_CTRL_LSB
        get_ADC_CTRL_LSB = read_ADC_CTRL_LSB_value
    End Property

    Property Let set_ADC_CTRL_LSB(aData)
        write_ADC_CTRL_LSB_value = aData
        flag_ADC_CTRL_LSB        = &H1
    End Property

    Property Get read_ADC_CTRL_LSB
        read
        read_ADC_CTRL_LSB = read_ADC_CTRL_LSB_value
    End Property

    Property Let write_ADC_CTRL_LSB(aData)
        set_ADC_CTRL_LSB = aData
        write
    End Property

    Property Get get_ADC_PH_SEL
        get_ADC_PH_SEL = read_ADC_PH_SEL_value
    End Property

    Property Let set_ADC_PH_SEL(aData)
        write_ADC_PH_SEL_value = aData
        flag_ADC_PH_SEL        = &H1
    End Property

    Property Get read_ADC_PH_SEL
        read
        read_ADC_PH_SEL = read_ADC_PH_SEL_value
    End Property

    Property Let write_ADC_PH_SEL(aData)
        set_ADC_PH_SEL = aData
        write
    End Property

    Property Get get_DAC_BIAS_CTRL
        get_DAC_BIAS_CTRL = read_DAC_BIAS_CTRL_value
    End Property

    Property Let set_DAC_BIAS_CTRL(aData)
        write_DAC_BIAS_CTRL_value = aData
        flag_DAC_BIAS_CTRL        = &H1
    End Property

    Property Get read_DAC_BIAS_CTRL
        read
        read_DAC_BIAS_CTRL = read_DAC_BIAS_CTRL_value
    End Property

    Property Let write_DAC_BIAS_CTRL(aData)
        set_DAC_BIAS_CTRL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ADC_CTRL_LSB_value = rightShift(data_low, 4) and &Hfff
        read_ADC_PH_SEL_value = rightShift(data_low, 2) and &H3
        DAC_BIAS_CTRL_mask = &H3
        if data_low > LONG_MAX then
            if DAC_BIAS_CTRL_mask = mask then
                read_DAC_BIAS_CTRL_value = data_low
            else
                read_DAC_BIAS_CTRL_value = (data_low - H8000_0000) and DAC_BIAS_CTRL_mask
            end If
        else
            read_DAC_BIAS_CTRL_value = data_low and DAC_BIAS_CTRL_mask
        end If

    End Sub

    Sub write
        If flag_ADC_CTRL_LSB = &H0 or flag_ADC_PH_SEL = &H0 or flag_DAC_BIAS_CTRL = &H0 Then read
        If flag_ADC_CTRL_LSB = &H0 Then write_ADC_CTRL_LSB_value = get_ADC_CTRL_LSB
        If flag_ADC_PH_SEL = &H0 Then write_ADC_PH_SEL_value = get_ADC_PH_SEL
        If flag_DAC_BIAS_CTRL = &H0 Then write_DAC_BIAS_CTRL_value = get_DAC_BIAS_CTRL

        regValue = leftShift((write_ADC_CTRL_LSB_value and &Hfff), 4) + leftShift((write_ADC_PH_SEL_value and &H3), 2) + leftShift((write_DAC_BIAS_CTRL_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ADC_CTRL_LSB_value = rightShift(data_low, 4) and &Hfff
        read_ADC_PH_SEL_value = rightShift(data_low, 2) and &H3
        DAC_BIAS_CTRL_mask = &H3
        if data_low > LONG_MAX then
            if DAC_BIAS_CTRL_mask = mask then
                read_DAC_BIAS_CTRL_value = data_low
            else
                read_DAC_BIAS_CTRL_value = (data_low - H8000_0000) and DAC_BIAS_CTRL_mask
            end If
        else
            read_DAC_BIAS_CTRL_value = data_low and DAC_BIAS_CTRL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADC_CTRL_LSB_value = &H0
        flag_ADC_CTRL_LSB        = &H0
        write_ADC_PH_SEL_value = &H0
        flag_ADC_PH_SEL        = &H0
        write_DAC_BIAS_CTRL_value = &H0
        flag_DAC_BIAS_CTRL        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1513                              [15:13]          get_RESERVED_1513
''                                                             set_RESERVED_1513
''                                                             read_RESERVED_1513
''                                                             write_RESERVED_1513
''---------------------------------------------------------------------------------
'' ADC_LANE_CTRL                              [12:10]          get_ADC_LANE_CTRL
''                                                             set_ADC_LANE_CTRL
''                                                             read_ADC_LANE_CTRL
''                                                             write_ADC_LANE_CTRL
''---------------------------------------------------------------------------------
'' CTRL_COMPS_9                               [9:9]            get_CTRL_COMPS_9
''                                                             set_CTRL_COMPS_9
''                                                             read_CTRL_COMPS_9
''                                                             write_CTRL_COMPS_9
''---------------------------------------------------------------------------------
'' CTRL_COMPS_8                               [8:8]            get_CTRL_COMPS_8
''                                                             set_CTRL_COMPS_8
''                                                             read_CTRL_COMPS_8
''                                                             write_CTRL_COMPS_8
''---------------------------------------------------------------------------------
'' CTRL_COMPS_7                               [7:7]            get_CTRL_COMPS_7
''                                                             set_CTRL_COMPS_7
''                                                             read_CTRL_COMPS_7
''                                                             write_CTRL_COMPS_7
''---------------------------------------------------------------------------------
'' ADC_CTRL_MSB                               [6:0]            get_ADC_CTRL_MSB
''                                                             set_ADC_CTRL_MSB
''                                                             read_ADC_CTRL_MSB
''                                                             write_ADC_CTRL_MSB
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_1
    Private write_RESERVED_1513_value
    Private read_RESERVED_1513_value
    Private flag_RESERVED_1513
    Private write_ADC_LANE_CTRL_value
    Private read_ADC_LANE_CTRL_value
    Private flag_ADC_LANE_CTRL
    Private write_CTRL_COMPS_9_value
    Private read_CTRL_COMPS_9_value
    Private flag_CTRL_COMPS_9
    Private write_CTRL_COMPS_8_value
    Private read_CTRL_COMPS_8_value
    Private flag_CTRL_COMPS_8
    Private write_CTRL_COMPS_7_value
    Private read_CTRL_COMPS_7_value
    Private flag_CTRL_COMPS_7
    Private write_ADC_CTRL_MSB_value
    Private read_ADC_CTRL_MSB_value
    Private flag_ADC_CTRL_MSB

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

    Property Get get_RESERVED_1513
        get_RESERVED_1513 = read_RESERVED_1513_value
    End Property

    Property Let set_RESERVED_1513(aData)
        write_RESERVED_1513_value = aData
        flag_RESERVED_1513        = &H1
    End Property

    Property Get read_RESERVED_1513
        read
        read_RESERVED_1513 = read_RESERVED_1513_value
    End Property

    Property Let write_RESERVED_1513(aData)
        set_RESERVED_1513 = aData
        write
    End Property

    Property Get get_ADC_LANE_CTRL
        get_ADC_LANE_CTRL = read_ADC_LANE_CTRL_value
    End Property

    Property Let set_ADC_LANE_CTRL(aData)
        write_ADC_LANE_CTRL_value = aData
        flag_ADC_LANE_CTRL        = &H1
    End Property

    Property Get read_ADC_LANE_CTRL
        read
        read_ADC_LANE_CTRL = read_ADC_LANE_CTRL_value
    End Property

    Property Let write_ADC_LANE_CTRL(aData)
        set_ADC_LANE_CTRL = aData
        write
    End Property

    Property Get get_CTRL_COMPS_9
        get_CTRL_COMPS_9 = read_CTRL_COMPS_9_value
    End Property

    Property Let set_CTRL_COMPS_9(aData)
        write_CTRL_COMPS_9_value = aData
        flag_CTRL_COMPS_9        = &H1
    End Property

    Property Get read_CTRL_COMPS_9
        read
        read_CTRL_COMPS_9 = read_CTRL_COMPS_9_value
    End Property

    Property Let write_CTRL_COMPS_9(aData)
        set_CTRL_COMPS_9 = aData
        write
    End Property

    Property Get get_CTRL_COMPS_8
        get_CTRL_COMPS_8 = read_CTRL_COMPS_8_value
    End Property

    Property Let set_CTRL_COMPS_8(aData)
        write_CTRL_COMPS_8_value = aData
        flag_CTRL_COMPS_8        = &H1
    End Property

    Property Get read_CTRL_COMPS_8
        read
        read_CTRL_COMPS_8 = read_CTRL_COMPS_8_value
    End Property

    Property Let write_CTRL_COMPS_8(aData)
        set_CTRL_COMPS_8 = aData
        write
    End Property

    Property Get get_CTRL_COMPS_7
        get_CTRL_COMPS_7 = read_CTRL_COMPS_7_value
    End Property

    Property Let set_CTRL_COMPS_7(aData)
        write_CTRL_COMPS_7_value = aData
        flag_CTRL_COMPS_7        = &H1
    End Property

    Property Get read_CTRL_COMPS_7
        read
        read_CTRL_COMPS_7 = read_CTRL_COMPS_7_value
    End Property

    Property Let write_CTRL_COMPS_7(aData)
        set_CTRL_COMPS_7 = aData
        write
    End Property

    Property Get get_ADC_CTRL_MSB
        get_ADC_CTRL_MSB = read_ADC_CTRL_MSB_value
    End Property

    Property Let set_ADC_CTRL_MSB(aData)
        write_ADC_CTRL_MSB_value = aData
        flag_ADC_CTRL_MSB        = &H1
    End Property

    Property Get read_ADC_CTRL_MSB
        read
        read_ADC_CTRL_MSB = read_ADC_CTRL_MSB_value
    End Property

    Property Let write_ADC_CTRL_MSB(aData)
        set_ADC_CTRL_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1513_value = rightShift(data_low, 13) and &H7
        read_ADC_LANE_CTRL_value = rightShift(data_low, 10) and &H7
        read_CTRL_COMPS_9_value = rightShift(data_low, 9) and &H1
        read_CTRL_COMPS_8_value = rightShift(data_low, 8) and &H1
        read_CTRL_COMPS_7_value = rightShift(data_low, 7) and &H1
        ADC_CTRL_MSB_mask = &H7f
        if data_low > LONG_MAX then
            if ADC_CTRL_MSB_mask = mask then
                read_ADC_CTRL_MSB_value = data_low
            else
                read_ADC_CTRL_MSB_value = (data_low - H8000_0000) and ADC_CTRL_MSB_mask
            end If
        else
            read_ADC_CTRL_MSB_value = data_low and ADC_CTRL_MSB_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1513 = &H0 or flag_ADC_LANE_CTRL = &H0 or flag_CTRL_COMPS_9 = &H0 or flag_CTRL_COMPS_8 = &H0 or flag_CTRL_COMPS_7 = &H0 or flag_ADC_CTRL_MSB = &H0 Then read
        If flag_RESERVED_1513 = &H0 Then write_RESERVED_1513_value = get_RESERVED_1513
        If flag_ADC_LANE_CTRL = &H0 Then write_ADC_LANE_CTRL_value = get_ADC_LANE_CTRL
        If flag_CTRL_COMPS_9 = &H0 Then write_CTRL_COMPS_9_value = get_CTRL_COMPS_9
        If flag_CTRL_COMPS_8 = &H0 Then write_CTRL_COMPS_8_value = get_CTRL_COMPS_8
        If flag_CTRL_COMPS_7 = &H0 Then write_CTRL_COMPS_7_value = get_CTRL_COMPS_7
        If flag_ADC_CTRL_MSB = &H0 Then write_ADC_CTRL_MSB_value = get_ADC_CTRL_MSB

        regValue = leftShift((write_RESERVED_1513_value and &H7), 13) + leftShift((write_ADC_LANE_CTRL_value and &H7), 10) + leftShift((write_CTRL_COMPS_9_value and &H1), 9) + leftShift((write_CTRL_COMPS_8_value and &H1), 8) + leftShift((write_CTRL_COMPS_7_value and &H1), 7) + leftShift((write_ADC_CTRL_MSB_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1513_value = rightShift(data_low, 13) and &H7
        read_ADC_LANE_CTRL_value = rightShift(data_low, 10) and &H7
        read_CTRL_COMPS_9_value = rightShift(data_low, 9) and &H1
        read_CTRL_COMPS_8_value = rightShift(data_low, 8) and &H1
        read_CTRL_COMPS_7_value = rightShift(data_low, 7) and &H1
        ADC_CTRL_MSB_mask = &H7f
        if data_low > LONG_MAX then
            if ADC_CTRL_MSB_mask = mask then
                read_ADC_CTRL_MSB_value = data_low
            else
                read_ADC_CTRL_MSB_value = (data_low - H8000_0000) and ADC_CTRL_MSB_mask
            end If
        else
            read_ADC_CTRL_MSB_value = data_low and ADC_CTRL_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1513_value = &H0
        flag_RESERVED_1513        = &H0
        write_ADC_LANE_CTRL_value = &H0
        flag_ADC_LANE_CTRL        = &H0
        write_CTRL_COMPS_9_value = &H0
        flag_CTRL_COMPS_9        = &H0
        write_CTRL_COMPS_8_value = &H0
        flag_CTRL_COMPS_8        = &H0
        write_CTRL_COMPS_7_value = &H0
        flag_CTRL_COMPS_7        = &H0
        write_ADC_CTRL_MSB_value = &H0
        flag_ADC_CTRL_MSB        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1505                              [15:5]           get_RESERVED_1505
''                                                             set_RESERVED_1505
''                                                             read_RESERVED_1505
''                                                             write_RESERVED_1505
''---------------------------------------------------------------------------------
'' DIGITAL_A0_CTRL0                           [4:4]            get_DIGITAL_A0_CTRL0
''                                                             set_DIGITAL_A0_CTRL0
''                                                             read_DIGITAL_A0_CTRL0
''                                                             write_DIGITAL_A0_CTRL0
''---------------------------------------------------------------------------------
'' DIGITAL_A0_CTRL1                           [3:0]            get_DIGITAL_A0_CTRL1
''                                                             set_DIGITAL_A0_CTRL1
''                                                             read_DIGITAL_A0_CTRL1
''                                                             write_DIGITAL_A0_CTRL1
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_2
    Private write_RESERVED_1505_value
    Private read_RESERVED_1505_value
    Private flag_RESERVED_1505
    Private write_DIGITAL_A0_CTRL0_value
    Private read_DIGITAL_A0_CTRL0_value
    Private flag_DIGITAL_A0_CTRL0
    Private write_DIGITAL_A0_CTRL1_value
    Private read_DIGITAL_A0_CTRL1_value
    Private flag_DIGITAL_A0_CTRL1

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

    Property Get get_RESERVED_1505
        get_RESERVED_1505 = read_RESERVED_1505_value
    End Property

    Property Let set_RESERVED_1505(aData)
        write_RESERVED_1505_value = aData
        flag_RESERVED_1505        = &H1
    End Property

    Property Get read_RESERVED_1505
        read
        read_RESERVED_1505 = read_RESERVED_1505_value
    End Property

    Property Let write_RESERVED_1505(aData)
        set_RESERVED_1505 = aData
        write
    End Property

    Property Get get_DIGITAL_A0_CTRL0
        get_DIGITAL_A0_CTRL0 = read_DIGITAL_A0_CTRL0_value
    End Property

    Property Let set_DIGITAL_A0_CTRL0(aData)
        write_DIGITAL_A0_CTRL0_value = aData
        flag_DIGITAL_A0_CTRL0        = &H1
    End Property

    Property Get read_DIGITAL_A0_CTRL0
        read
        read_DIGITAL_A0_CTRL0 = read_DIGITAL_A0_CTRL0_value
    End Property

    Property Let write_DIGITAL_A0_CTRL0(aData)
        set_DIGITAL_A0_CTRL0 = aData
        write
    End Property

    Property Get get_DIGITAL_A0_CTRL1
        get_DIGITAL_A0_CTRL1 = read_DIGITAL_A0_CTRL1_value
    End Property

    Property Let set_DIGITAL_A0_CTRL1(aData)
        write_DIGITAL_A0_CTRL1_value = aData
        flag_DIGITAL_A0_CTRL1        = &H1
    End Property

    Property Get read_DIGITAL_A0_CTRL1
        read
        read_DIGITAL_A0_CTRL1 = read_DIGITAL_A0_CTRL1_value
    End Property

    Property Let write_DIGITAL_A0_CTRL1(aData)
        set_DIGITAL_A0_CTRL1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1505_value = rightShift(data_low, 5) and &H7ff
        read_DIGITAL_A0_CTRL0_value = rightShift(data_low, 4) and &H1
        DIGITAL_A0_CTRL1_mask = &Hf
        if data_low > LONG_MAX then
            if DIGITAL_A0_CTRL1_mask = mask then
                read_DIGITAL_A0_CTRL1_value = data_low
            else
                read_DIGITAL_A0_CTRL1_value = (data_low - H8000_0000) and DIGITAL_A0_CTRL1_mask
            end If
        else
            read_DIGITAL_A0_CTRL1_value = data_low and DIGITAL_A0_CTRL1_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1505 = &H0 or flag_DIGITAL_A0_CTRL0 = &H0 or flag_DIGITAL_A0_CTRL1 = &H0 Then read
        If flag_RESERVED_1505 = &H0 Then write_RESERVED_1505_value = get_RESERVED_1505
        If flag_DIGITAL_A0_CTRL0 = &H0 Then write_DIGITAL_A0_CTRL0_value = get_DIGITAL_A0_CTRL0
        If flag_DIGITAL_A0_CTRL1 = &H0 Then write_DIGITAL_A0_CTRL1_value = get_DIGITAL_A0_CTRL1

        regValue = leftShift((write_RESERVED_1505_value and &H7ff), 5) + leftShift((write_DIGITAL_A0_CTRL0_value and &H1), 4) + leftShift((write_DIGITAL_A0_CTRL1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1505_value = rightShift(data_low, 5) and &H7ff
        read_DIGITAL_A0_CTRL0_value = rightShift(data_low, 4) and &H1
        DIGITAL_A0_CTRL1_mask = &Hf
        if data_low > LONG_MAX then
            if DIGITAL_A0_CTRL1_mask = mask then
                read_DIGITAL_A0_CTRL1_value = data_low
            else
                read_DIGITAL_A0_CTRL1_value = (data_low - H8000_0000) and DIGITAL_A0_CTRL1_mask
            end If
        else
            read_DIGITAL_A0_CTRL1_value = data_low and DIGITAL_A0_CTRL1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1505_value = &H0
        flag_RESERVED_1505        = &H0
        write_DIGITAL_A0_CTRL0_value = &H0
        flag_DIGITAL_A0_CTRL0        = &H0
        write_DIGITAL_A0_CTRL1_value = &H0
        flag_DIGITAL_A0_CTRL1        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PREAMP_REFVOL_LSB                          [15:14]          get_PREAMP_REFVOL_LSB
''                                                             set_PREAMP_REFVOL_LSB
''                                                             read_PREAMP_REFVOL_LSB
''                                                             write_PREAMP_REFVOL_LSB
''---------------------------------------------------------------------------------
'' CUR_SRC_CTRL                               [13:11]          get_CUR_SRC_CTRL
''                                                             set_CUR_SRC_CTRL
''                                                             read_CUR_SRC_CTRL
''                                                             write_CUR_SRC_CTRL
''---------------------------------------------------------------------------------
'' LOAD_RES_CTRL                              [10:9]           get_LOAD_RES_CTRL
''                                                             set_LOAD_RES_CTRL
''                                                             read_LOAD_RES_CTRL
''                                                             write_LOAD_RES_CTRL
''---------------------------------------------------------------------------------
'' TAIL_CUR_CTRL                              [8:6]            get_TAIL_CUR_CTRL
''                                                             set_TAIL_CUR_CTRL
''                                                             read_TAIL_CUR_CTRL
''                                                             write_TAIL_CUR_CTRL
''---------------------------------------------------------------------------------
'' PRBS_CTRL                                  [5:0]            get_PRBS_CTRL
''                                                             set_PRBS_CTRL
''                                                             read_PRBS_CTRL
''                                                             write_PRBS_CTRL
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_3
    Private write_PREAMP_REFVOL_LSB_value
    Private read_PREAMP_REFVOL_LSB_value
    Private flag_PREAMP_REFVOL_LSB
    Private write_CUR_SRC_CTRL_value
    Private read_CUR_SRC_CTRL_value
    Private flag_CUR_SRC_CTRL
    Private write_LOAD_RES_CTRL_value
    Private read_LOAD_RES_CTRL_value
    Private flag_LOAD_RES_CTRL
    Private write_TAIL_CUR_CTRL_value
    Private read_TAIL_CUR_CTRL_value
    Private flag_TAIL_CUR_CTRL
    Private write_PRBS_CTRL_value
    Private read_PRBS_CTRL_value
    Private flag_PRBS_CTRL

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

    Property Get get_PREAMP_REFVOL_LSB
        get_PREAMP_REFVOL_LSB = read_PREAMP_REFVOL_LSB_value
    End Property

    Property Let set_PREAMP_REFVOL_LSB(aData)
        write_PREAMP_REFVOL_LSB_value = aData
        flag_PREAMP_REFVOL_LSB        = &H1
    End Property

    Property Get read_PREAMP_REFVOL_LSB
        read
        read_PREAMP_REFVOL_LSB = read_PREAMP_REFVOL_LSB_value
    End Property

    Property Let write_PREAMP_REFVOL_LSB(aData)
        set_PREAMP_REFVOL_LSB = aData
        write
    End Property

    Property Get get_CUR_SRC_CTRL
        get_CUR_SRC_CTRL = read_CUR_SRC_CTRL_value
    End Property

    Property Let set_CUR_SRC_CTRL(aData)
        write_CUR_SRC_CTRL_value = aData
        flag_CUR_SRC_CTRL        = &H1
    End Property

    Property Get read_CUR_SRC_CTRL
        read
        read_CUR_SRC_CTRL = read_CUR_SRC_CTRL_value
    End Property

    Property Let write_CUR_SRC_CTRL(aData)
        set_CUR_SRC_CTRL = aData
        write
    End Property

    Property Get get_LOAD_RES_CTRL
        get_LOAD_RES_CTRL = read_LOAD_RES_CTRL_value
    End Property

    Property Let set_LOAD_RES_CTRL(aData)
        write_LOAD_RES_CTRL_value = aData
        flag_LOAD_RES_CTRL        = &H1
    End Property

    Property Get read_LOAD_RES_CTRL
        read
        read_LOAD_RES_CTRL = read_LOAD_RES_CTRL_value
    End Property

    Property Let write_LOAD_RES_CTRL(aData)
        set_LOAD_RES_CTRL = aData
        write
    End Property

    Property Get get_TAIL_CUR_CTRL
        get_TAIL_CUR_CTRL = read_TAIL_CUR_CTRL_value
    End Property

    Property Let set_TAIL_CUR_CTRL(aData)
        write_TAIL_CUR_CTRL_value = aData
        flag_TAIL_CUR_CTRL        = &H1
    End Property

    Property Get read_TAIL_CUR_CTRL
        read
        read_TAIL_CUR_CTRL = read_TAIL_CUR_CTRL_value
    End Property

    Property Let write_TAIL_CUR_CTRL(aData)
        set_TAIL_CUR_CTRL = aData
        write
    End Property

    Property Get get_PRBS_CTRL
        get_PRBS_CTRL = read_PRBS_CTRL_value
    End Property

    Property Let set_PRBS_CTRL(aData)
        write_PRBS_CTRL_value = aData
        flag_PRBS_CTRL        = &H1
    End Property

    Property Get read_PRBS_CTRL
        read
        read_PRBS_CTRL = read_PRBS_CTRL_value
    End Property

    Property Let write_PRBS_CTRL(aData)
        set_PRBS_CTRL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PREAMP_REFVOL_LSB_value = rightShift(data_low, 14) and &H3
        read_CUR_SRC_CTRL_value = rightShift(data_low, 11) and &H7
        read_LOAD_RES_CTRL_value = rightShift(data_low, 9) and &H3
        read_TAIL_CUR_CTRL_value = rightShift(data_low, 6) and &H7
        PRBS_CTRL_mask = &H3f
        if data_low > LONG_MAX then
            if PRBS_CTRL_mask = mask then
                read_PRBS_CTRL_value = data_low
            else
                read_PRBS_CTRL_value = (data_low - H8000_0000) and PRBS_CTRL_mask
            end If
        else
            read_PRBS_CTRL_value = data_low and PRBS_CTRL_mask
        end If

    End Sub

    Sub write
        If flag_PREAMP_REFVOL_LSB = &H0 or flag_CUR_SRC_CTRL = &H0 or flag_LOAD_RES_CTRL = &H0 or flag_TAIL_CUR_CTRL = &H0 or flag_PRBS_CTRL = &H0 Then read
        If flag_PREAMP_REFVOL_LSB = &H0 Then write_PREAMP_REFVOL_LSB_value = get_PREAMP_REFVOL_LSB
        If flag_CUR_SRC_CTRL = &H0 Then write_CUR_SRC_CTRL_value = get_CUR_SRC_CTRL
        If flag_LOAD_RES_CTRL = &H0 Then write_LOAD_RES_CTRL_value = get_LOAD_RES_CTRL
        If flag_TAIL_CUR_CTRL = &H0 Then write_TAIL_CUR_CTRL_value = get_TAIL_CUR_CTRL
        If flag_PRBS_CTRL = &H0 Then write_PRBS_CTRL_value = get_PRBS_CTRL

        regValue = leftShift((write_PREAMP_REFVOL_LSB_value and &H3), 14) + leftShift((write_CUR_SRC_CTRL_value and &H7), 11) + leftShift((write_LOAD_RES_CTRL_value and &H3), 9) + leftShift((write_TAIL_CUR_CTRL_value and &H7), 6) + leftShift((write_PRBS_CTRL_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PREAMP_REFVOL_LSB_value = rightShift(data_low, 14) and &H3
        read_CUR_SRC_CTRL_value = rightShift(data_low, 11) and &H7
        read_LOAD_RES_CTRL_value = rightShift(data_low, 9) and &H3
        read_TAIL_CUR_CTRL_value = rightShift(data_low, 6) and &H7
        PRBS_CTRL_mask = &H3f
        if data_low > LONG_MAX then
            if PRBS_CTRL_mask = mask then
                read_PRBS_CTRL_value = data_low
            else
                read_PRBS_CTRL_value = (data_low - H8000_0000) and PRBS_CTRL_mask
            end If
        else
            read_PRBS_CTRL_value = data_low and PRBS_CTRL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PREAMP_REFVOL_LSB_value = &H0
        flag_PREAMP_REFVOL_LSB        = &H0
        write_CUR_SRC_CTRL_value = &H0
        flag_CUR_SRC_CTRL        = &H0
        write_LOAD_RES_CTRL_value = &H0
        flag_LOAD_RES_CTRL        = &H0
        write_TAIL_CUR_CTRL_value = &H0
        flag_TAIL_CUR_CTRL        = &H0
        write_PRBS_CTRL_value = &H0
        flag_PRBS_CTRL        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1510                              [15:10]          get_RESERVED_1510
''                                                             set_RESERVED_1510
''                                                             read_RESERVED_1510
''                                                             write_RESERVED_1510
''---------------------------------------------------------------------------------
'' DAC_CM_CTRL                                [9:8]            get_DAC_CM_CTRL
''                                                             set_DAC_CM_CTRL
''                                                             read_DAC_CM_CTRL
''                                                             write_DAC_CM_CTRL
''---------------------------------------------------------------------------------
'' RESERVED_0706                              [7:6]            get_RESERVED_0706
''                                                             set_RESERVED_0706
''                                                             read_RESERVED_0706
''                                                             write_RESERVED_0706
''---------------------------------------------------------------------------------
'' DAC_ACT_CTRL                               [5:5]            get_DAC_ACT_CTRL
''                                                             set_DAC_ACT_CTRL
''                                                             read_DAC_ACT_CTRL
''                                                             write_DAC_ACT_CTRL
''---------------------------------------------------------------------------------
'' RESERVED_0404                              [4:4]            get_RESERVED_0404
''                                                             set_RESERVED_0404
''                                                             read_RESERVED_0404
''                                                             write_RESERVED_0404
''---------------------------------------------------------------------------------
'' PREAMP_B_IOUT                              [3:2]            get_PREAMP_B_IOUT
''                                                             set_PREAMP_B_IOUT
''                                                             read_PREAMP_B_IOUT
''                                                             write_PREAMP_B_IOUT
''---------------------------------------------------------------------------------
'' PREAMP_REFVOL_MSB                          [1:0]            get_PREAMP_REFVOL_MSB
''                                                             set_PREAMP_REFVOL_MSB
''                                                             read_PREAMP_REFVOL_MSB
''                                                             write_PREAMP_REFVOL_MSB
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_4
    Private write_RESERVED_1510_value
    Private read_RESERVED_1510_value
    Private flag_RESERVED_1510
    Private write_DAC_CM_CTRL_value
    Private read_DAC_CM_CTRL_value
    Private flag_DAC_CM_CTRL
    Private write_RESERVED_0706_value
    Private read_RESERVED_0706_value
    Private flag_RESERVED_0706
    Private write_DAC_ACT_CTRL_value
    Private read_DAC_ACT_CTRL_value
    Private flag_DAC_ACT_CTRL
    Private write_RESERVED_0404_value
    Private read_RESERVED_0404_value
    Private flag_RESERVED_0404
    Private write_PREAMP_B_IOUT_value
    Private read_PREAMP_B_IOUT_value
    Private flag_PREAMP_B_IOUT
    Private write_PREAMP_REFVOL_MSB_value
    Private read_PREAMP_REFVOL_MSB_value
    Private flag_PREAMP_REFVOL_MSB

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

    Property Get get_RESERVED_1510
        get_RESERVED_1510 = read_RESERVED_1510_value
    End Property

    Property Let set_RESERVED_1510(aData)
        write_RESERVED_1510_value = aData
        flag_RESERVED_1510        = &H1
    End Property

    Property Get read_RESERVED_1510
        read
        read_RESERVED_1510 = read_RESERVED_1510_value
    End Property

    Property Let write_RESERVED_1510(aData)
        set_RESERVED_1510 = aData
        write
    End Property

    Property Get get_DAC_CM_CTRL
        get_DAC_CM_CTRL = read_DAC_CM_CTRL_value
    End Property

    Property Let set_DAC_CM_CTRL(aData)
        write_DAC_CM_CTRL_value = aData
        flag_DAC_CM_CTRL        = &H1
    End Property

    Property Get read_DAC_CM_CTRL
        read
        read_DAC_CM_CTRL = read_DAC_CM_CTRL_value
    End Property

    Property Let write_DAC_CM_CTRL(aData)
        set_DAC_CM_CTRL = aData
        write
    End Property

    Property Get get_RESERVED_0706
        get_RESERVED_0706 = read_RESERVED_0706_value
    End Property

    Property Let set_RESERVED_0706(aData)
        write_RESERVED_0706_value = aData
        flag_RESERVED_0706        = &H1
    End Property

    Property Get read_RESERVED_0706
        read
        read_RESERVED_0706 = read_RESERVED_0706_value
    End Property

    Property Let write_RESERVED_0706(aData)
        set_RESERVED_0706 = aData
        write
    End Property

    Property Get get_DAC_ACT_CTRL
        get_DAC_ACT_CTRL = read_DAC_ACT_CTRL_value
    End Property

    Property Let set_DAC_ACT_CTRL(aData)
        write_DAC_ACT_CTRL_value = aData
        flag_DAC_ACT_CTRL        = &H1
    End Property

    Property Get read_DAC_ACT_CTRL
        read
        read_DAC_ACT_CTRL = read_DAC_ACT_CTRL_value
    End Property

    Property Let write_DAC_ACT_CTRL(aData)
        set_DAC_ACT_CTRL = aData
        write
    End Property

    Property Get get_RESERVED_0404
        get_RESERVED_0404 = read_RESERVED_0404_value
    End Property

    Property Let set_RESERVED_0404(aData)
        write_RESERVED_0404_value = aData
        flag_RESERVED_0404        = &H1
    End Property

    Property Get read_RESERVED_0404
        read
        read_RESERVED_0404 = read_RESERVED_0404_value
    End Property

    Property Let write_RESERVED_0404(aData)
        set_RESERVED_0404 = aData
        write
    End Property

    Property Get get_PREAMP_B_IOUT
        get_PREAMP_B_IOUT = read_PREAMP_B_IOUT_value
    End Property

    Property Let set_PREAMP_B_IOUT(aData)
        write_PREAMP_B_IOUT_value = aData
        flag_PREAMP_B_IOUT        = &H1
    End Property

    Property Get read_PREAMP_B_IOUT
        read
        read_PREAMP_B_IOUT = read_PREAMP_B_IOUT_value
    End Property

    Property Let write_PREAMP_B_IOUT(aData)
        set_PREAMP_B_IOUT = aData
        write
    End Property

    Property Get get_PREAMP_REFVOL_MSB
        get_PREAMP_REFVOL_MSB = read_PREAMP_REFVOL_MSB_value
    End Property

    Property Let set_PREAMP_REFVOL_MSB(aData)
        write_PREAMP_REFVOL_MSB_value = aData
        flag_PREAMP_REFVOL_MSB        = &H1
    End Property

    Property Get read_PREAMP_REFVOL_MSB
        read
        read_PREAMP_REFVOL_MSB = read_PREAMP_REFVOL_MSB_value
    End Property

    Property Let write_PREAMP_REFVOL_MSB(aData)
        set_PREAMP_REFVOL_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1510_value = rightShift(data_low, 10) and &H3f
        read_DAC_CM_CTRL_value = rightShift(data_low, 8) and &H3
        read_RESERVED_0706_value = rightShift(data_low, 6) and &H3
        read_DAC_ACT_CTRL_value = rightShift(data_low, 5) and &H1
        read_RESERVED_0404_value = rightShift(data_low, 4) and &H1
        read_PREAMP_B_IOUT_value = rightShift(data_low, 2) and &H3
        PREAMP_REFVOL_MSB_mask = &H3
        if data_low > LONG_MAX then
            if PREAMP_REFVOL_MSB_mask = mask then
                read_PREAMP_REFVOL_MSB_value = data_low
            else
                read_PREAMP_REFVOL_MSB_value = (data_low - H8000_0000) and PREAMP_REFVOL_MSB_mask
            end If
        else
            read_PREAMP_REFVOL_MSB_value = data_low and PREAMP_REFVOL_MSB_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1510 = &H0 or flag_DAC_CM_CTRL = &H0 or flag_RESERVED_0706 = &H0 or flag_DAC_ACT_CTRL = &H0 or flag_RESERVED_0404 = &H0 or flag_PREAMP_B_IOUT = &H0 or flag_PREAMP_REFVOL_MSB = &H0 Then read
        If flag_RESERVED_1510 = &H0 Then write_RESERVED_1510_value = get_RESERVED_1510
        If flag_DAC_CM_CTRL = &H0 Then write_DAC_CM_CTRL_value = get_DAC_CM_CTRL
        If flag_RESERVED_0706 = &H0 Then write_RESERVED_0706_value = get_RESERVED_0706
        If flag_DAC_ACT_CTRL = &H0 Then write_DAC_ACT_CTRL_value = get_DAC_ACT_CTRL
        If flag_RESERVED_0404 = &H0 Then write_RESERVED_0404_value = get_RESERVED_0404
        If flag_PREAMP_B_IOUT = &H0 Then write_PREAMP_B_IOUT_value = get_PREAMP_B_IOUT
        If flag_PREAMP_REFVOL_MSB = &H0 Then write_PREAMP_REFVOL_MSB_value = get_PREAMP_REFVOL_MSB

        regValue = leftShift((write_RESERVED_1510_value and &H3f), 10) + leftShift((write_DAC_CM_CTRL_value and &H3), 8) + leftShift((write_RESERVED_0706_value and &H3), 6) + leftShift((write_DAC_ACT_CTRL_value and &H1), 5) + leftShift((write_RESERVED_0404_value and &H1), 4) + leftShift((write_PREAMP_B_IOUT_value and &H3), 2) + leftShift((write_PREAMP_REFVOL_MSB_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1510_value = rightShift(data_low, 10) and &H3f
        read_DAC_CM_CTRL_value = rightShift(data_low, 8) and &H3
        read_RESERVED_0706_value = rightShift(data_low, 6) and &H3
        read_DAC_ACT_CTRL_value = rightShift(data_low, 5) and &H1
        read_RESERVED_0404_value = rightShift(data_low, 4) and &H1
        read_PREAMP_B_IOUT_value = rightShift(data_low, 2) and &H3
        PREAMP_REFVOL_MSB_mask = &H3
        if data_low > LONG_MAX then
            if PREAMP_REFVOL_MSB_mask = mask then
                read_PREAMP_REFVOL_MSB_value = data_low
            else
                read_PREAMP_REFVOL_MSB_value = (data_low - H8000_0000) and PREAMP_REFVOL_MSB_mask
            end If
        else
            read_PREAMP_REFVOL_MSB_value = data_low and PREAMP_REFVOL_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1510_value = &H0
        flag_RESERVED_1510        = &H0
        write_DAC_CM_CTRL_value = &H0
        flag_DAC_CM_CTRL        = &H0
        write_RESERVED_0706_value = &H0
        flag_RESERVED_0706        = &H0
        write_DAC_ACT_CTRL_value = &H0
        flag_DAC_ACT_CTRL        = &H0
        write_RESERVED_0404_value = &H0
        flag_RESERVED_0404        = &H0
        write_PREAMP_B_IOUT_value = &H0
        flag_PREAMP_B_IOUT        = &H0
        write_PREAMP_REFVOL_MSB_value = &H0
        flag_PREAMP_REFVOL_MSB        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADC_5                                      [15:0]           get_ADC_5
''                                                             set_ADC_5
''                                                             read_ADC_5
''                                                             write_ADC_5
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_5
    Private write_ADC_5_value
    Private read_ADC_5_value
    Private flag_ADC_5

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

    Property Get get_ADC_5
        get_ADC_5 = read_ADC_5_value
    End Property

    Property Let set_ADC_5(aData)
        write_ADC_5_value = aData
        flag_ADC_5        = &H1
    End Property

    Property Get read_ADC_5
        read
        read_ADC_5 = read_ADC_5_value
    End Property

    Property Let write_ADC_5(aData)
        set_ADC_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADC_5_mask = &Hffff
        if data_low > LONG_MAX then
            if ADC_5_mask = mask then
                read_ADC_5_value = data_low
            else
                read_ADC_5_value = (data_low - H8000_0000) and ADC_5_mask
            end If
        else
            read_ADC_5_value = data_low and ADC_5_mask
        end If

    End Sub

    Sub write
        If flag_ADC_5 = &H0 Then read
        If flag_ADC_5 = &H0 Then write_ADC_5_value = get_ADC_5

        regValue = leftShift((write_ADC_5_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADC_5_mask = &Hffff
        if data_low > LONG_MAX then
            if ADC_5_mask = mask then
                read_ADC_5_value = data_low
            else
                read_ADC_5_value = (data_low - H8000_0000) and ADC_5_mask
            end If
        else
            read_ADC_5_value = data_low and ADC_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADC_5_value = &H0
        flag_ADC_5        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVER_1514                              [15:14]          get_RESERVER_1514
''                                                             set_RESERVER_1514
''                                                             read_RESERVER_1514
''                                                             write_RESERVER_1514
''---------------------------------------------------------------------------------
'' REFBUF_OPAMP                               [13:5]           get_REFBUF_OPAMP
''                                                             set_REFBUF_OPAMP
''                                                             read_REFBUF_OPAMP
''                                                             write_REFBUF_OPAMP
''---------------------------------------------------------------------------------
'' RES_AMPS_BIAS                              [4:0]            get_RES_AMPS_BIAS
''                                                             set_RES_AMPS_BIAS
''                                                             read_RES_AMPS_BIAS
''                                                             write_RES_AMPS_BIAS
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_6
    Private write_RESERVER_1514_value
    Private read_RESERVER_1514_value
    Private flag_RESERVER_1514
    Private write_REFBUF_OPAMP_value
    Private read_REFBUF_OPAMP_value
    Private flag_REFBUF_OPAMP
    Private write_RES_AMPS_BIAS_value
    Private read_RES_AMPS_BIAS_value
    Private flag_RES_AMPS_BIAS

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

    Property Get get_RESERVER_1514
        get_RESERVER_1514 = read_RESERVER_1514_value
    End Property

    Property Let set_RESERVER_1514(aData)
        write_RESERVER_1514_value = aData
        flag_RESERVER_1514        = &H1
    End Property

    Property Get read_RESERVER_1514
        read
        read_RESERVER_1514 = read_RESERVER_1514_value
    End Property

    Property Let write_RESERVER_1514(aData)
        set_RESERVER_1514 = aData
        write
    End Property

    Property Get get_REFBUF_OPAMP
        get_REFBUF_OPAMP = read_REFBUF_OPAMP_value
    End Property

    Property Let set_REFBUF_OPAMP(aData)
        write_REFBUF_OPAMP_value = aData
        flag_REFBUF_OPAMP        = &H1
    End Property

    Property Get read_REFBUF_OPAMP
        read
        read_REFBUF_OPAMP = read_REFBUF_OPAMP_value
    End Property

    Property Let write_REFBUF_OPAMP(aData)
        set_REFBUF_OPAMP = aData
        write
    End Property

    Property Get get_RES_AMPS_BIAS
        get_RES_AMPS_BIAS = read_RES_AMPS_BIAS_value
    End Property

    Property Let set_RES_AMPS_BIAS(aData)
        write_RES_AMPS_BIAS_value = aData
        flag_RES_AMPS_BIAS        = &H1
    End Property

    Property Get read_RES_AMPS_BIAS
        read
        read_RES_AMPS_BIAS = read_RES_AMPS_BIAS_value
    End Property

    Property Let write_RES_AMPS_BIAS(aData)
        set_RES_AMPS_BIAS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVER_1514_value = rightShift(data_low, 14) and &H3
        read_REFBUF_OPAMP_value = rightShift(data_low, 5) and &H1ff
        RES_AMPS_BIAS_mask = &H1f
        if data_low > LONG_MAX then
            if RES_AMPS_BIAS_mask = mask then
                read_RES_AMPS_BIAS_value = data_low
            else
                read_RES_AMPS_BIAS_value = (data_low - H8000_0000) and RES_AMPS_BIAS_mask
            end If
        else
            read_RES_AMPS_BIAS_value = data_low and RES_AMPS_BIAS_mask
        end If

    End Sub

    Sub write
        If flag_RESERVER_1514 = &H0 or flag_REFBUF_OPAMP = &H0 or flag_RES_AMPS_BIAS = &H0 Then read
        If flag_RESERVER_1514 = &H0 Then write_RESERVER_1514_value = get_RESERVER_1514
        If flag_REFBUF_OPAMP = &H0 Then write_REFBUF_OPAMP_value = get_REFBUF_OPAMP
        If flag_RES_AMPS_BIAS = &H0 Then write_RES_AMPS_BIAS_value = get_RES_AMPS_BIAS

        regValue = leftShift((write_RESERVER_1514_value and &H3), 14) + leftShift((write_REFBUF_OPAMP_value and &H1ff), 5) + leftShift((write_RES_AMPS_BIAS_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVER_1514_value = rightShift(data_low, 14) and &H3
        read_REFBUF_OPAMP_value = rightShift(data_low, 5) and &H1ff
        RES_AMPS_BIAS_mask = &H1f
        if data_low > LONG_MAX then
            if RES_AMPS_BIAS_mask = mask then
                read_RES_AMPS_BIAS_value = data_low
            else
                read_RES_AMPS_BIAS_value = (data_low - H8000_0000) and RES_AMPS_BIAS_mask
            end If
        else
            read_RES_AMPS_BIAS_value = data_low and RES_AMPS_BIAS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVER_1514_value = &H0
        flag_RESERVER_1514        = &H0
        write_REFBUF_OPAMP_value = &H0
        flag_REFBUF_OPAMP        = &H0
        write_RES_AMPS_BIAS_value = &H0
        flag_RES_AMPS_BIAS        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1506                              [15:6]           get_RESERVED_1506
''                                                             set_RESERVED_1506
''                                                             read_RESERVED_1506
''                                                             write_RESERVED_1506
''---------------------------------------------------------------------------------
'' CLKGEN_CTRL                                [5:5]            get_CLKGEN_CTRL
''                                                             set_CLKGEN_CTRL
''                                                             read_CLKGEN_CTRL
''                                                             write_CLKGEN_CTRL
''---------------------------------------------------------------------------------
'' BIAS_VREF_CTRL                             [4:4]            get_BIAS_VREF_CTRL
''                                                             set_BIAS_VREF_CTRL
''                                                             read_BIAS_VREF_CTRL
''                                                             write_BIAS_VREF_CTRL
''---------------------------------------------------------------------------------
'' BIAS_VREF_VAL                              [3:1]            get_BIAS_VREF_VAL
''                                                             set_BIAS_VREF_VAL
''                                                             read_BIAS_VREF_VAL
''                                                             write_BIAS_VREF_VAL
''---------------------------------------------------------------------------------
'' RESERVED_0000                              [0:0]            get_RESERVED_0000
''                                                             set_RESERVED_0000
''                                                             read_RESERVED_0000
''                                                             write_RESERVED_0000
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_7
    Private write_RESERVED_1506_value
    Private read_RESERVED_1506_value
    Private flag_RESERVED_1506
    Private write_CLKGEN_CTRL_value
    Private read_CLKGEN_CTRL_value
    Private flag_CLKGEN_CTRL
    Private write_BIAS_VREF_CTRL_value
    Private read_BIAS_VREF_CTRL_value
    Private flag_BIAS_VREF_CTRL
    Private write_BIAS_VREF_VAL_value
    Private read_BIAS_VREF_VAL_value
    Private flag_BIAS_VREF_VAL
    Private write_RESERVED_0000_value
    Private read_RESERVED_0000_value
    Private flag_RESERVED_0000

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

    Property Get get_RESERVED_1506
        get_RESERVED_1506 = read_RESERVED_1506_value
    End Property

    Property Let set_RESERVED_1506(aData)
        write_RESERVED_1506_value = aData
        flag_RESERVED_1506        = &H1
    End Property

    Property Get read_RESERVED_1506
        read
        read_RESERVED_1506 = read_RESERVED_1506_value
    End Property

    Property Let write_RESERVED_1506(aData)
        set_RESERVED_1506 = aData
        write
    End Property

    Property Get get_CLKGEN_CTRL
        get_CLKGEN_CTRL = read_CLKGEN_CTRL_value
    End Property

    Property Let set_CLKGEN_CTRL(aData)
        write_CLKGEN_CTRL_value = aData
        flag_CLKGEN_CTRL        = &H1
    End Property

    Property Get read_CLKGEN_CTRL
        read
        read_CLKGEN_CTRL = read_CLKGEN_CTRL_value
    End Property

    Property Let write_CLKGEN_CTRL(aData)
        set_CLKGEN_CTRL = aData
        write
    End Property

    Property Get get_BIAS_VREF_CTRL
        get_BIAS_VREF_CTRL = read_BIAS_VREF_CTRL_value
    End Property

    Property Let set_BIAS_VREF_CTRL(aData)
        write_BIAS_VREF_CTRL_value = aData
        flag_BIAS_VREF_CTRL        = &H1
    End Property

    Property Get read_BIAS_VREF_CTRL
        read
        read_BIAS_VREF_CTRL = read_BIAS_VREF_CTRL_value
    End Property

    Property Let write_BIAS_VREF_CTRL(aData)
        set_BIAS_VREF_CTRL = aData
        write
    End Property

    Property Get get_BIAS_VREF_VAL
        get_BIAS_VREF_VAL = read_BIAS_VREF_VAL_value
    End Property

    Property Let set_BIAS_VREF_VAL(aData)
        write_BIAS_VREF_VAL_value = aData
        flag_BIAS_VREF_VAL        = &H1
    End Property

    Property Get read_BIAS_VREF_VAL
        read
        read_BIAS_VREF_VAL = read_BIAS_VREF_VAL_value
    End Property

    Property Let write_BIAS_VREF_VAL(aData)
        set_BIAS_VREF_VAL = aData
        write
    End Property

    Property Get get_RESERVED_0000
        get_RESERVED_0000 = read_RESERVED_0000_value
    End Property

    Property Let set_RESERVED_0000(aData)
        write_RESERVED_0000_value = aData
        flag_RESERVED_0000        = &H1
    End Property

    Property Get read_RESERVED_0000
        read
        read_RESERVED_0000 = read_RESERVED_0000_value
    End Property

    Property Let write_RESERVED_0000(aData)
        set_RESERVED_0000 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1506_value = rightShift(data_low, 6) and &H3ff
        read_CLKGEN_CTRL_value = rightShift(data_low, 5) and &H1
        read_BIAS_VREF_CTRL_value = rightShift(data_low, 4) and &H1
        read_BIAS_VREF_VAL_value = rightShift(data_low, 1) and &H7
        RESERVED_0000_mask = &H1
        if data_low > LONG_MAX then
            if RESERVED_0000_mask = mask then
                read_RESERVED_0000_value = data_low
            else
                read_RESERVED_0000_value = (data_low - H8000_0000) and RESERVED_0000_mask
            end If
        else
            read_RESERVED_0000_value = data_low and RESERVED_0000_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1506 = &H0 or flag_CLKGEN_CTRL = &H0 or flag_BIAS_VREF_CTRL = &H0 or flag_BIAS_VREF_VAL = &H0 or flag_RESERVED_0000 = &H0 Then read
        If flag_RESERVED_1506 = &H0 Then write_RESERVED_1506_value = get_RESERVED_1506
        If flag_CLKGEN_CTRL = &H0 Then write_CLKGEN_CTRL_value = get_CLKGEN_CTRL
        If flag_BIAS_VREF_CTRL = &H0 Then write_BIAS_VREF_CTRL_value = get_BIAS_VREF_CTRL
        If flag_BIAS_VREF_VAL = &H0 Then write_BIAS_VREF_VAL_value = get_BIAS_VREF_VAL
        If flag_RESERVED_0000 = &H0 Then write_RESERVED_0000_value = get_RESERVED_0000

        regValue = leftShift((write_RESERVED_1506_value and &H3ff), 6) + leftShift((write_CLKGEN_CTRL_value and &H1), 5) + leftShift((write_BIAS_VREF_CTRL_value and &H1), 4) + leftShift((write_BIAS_VREF_VAL_value and &H7), 1) + leftShift((write_RESERVED_0000_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1506_value = rightShift(data_low, 6) and &H3ff
        read_CLKGEN_CTRL_value = rightShift(data_low, 5) and &H1
        read_BIAS_VREF_CTRL_value = rightShift(data_low, 4) and &H1
        read_BIAS_VREF_VAL_value = rightShift(data_low, 1) and &H7
        RESERVED_0000_mask = &H1
        if data_low > LONG_MAX then
            if RESERVED_0000_mask = mask then
                read_RESERVED_0000_value = data_low
            else
                read_RESERVED_0000_value = (data_low - H8000_0000) and RESERVED_0000_mask
            end If
        else
            read_RESERVED_0000_value = data_low and RESERVED_0000_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1506_value = &H0
        flag_RESERVED_1506        = &H0
        write_CLKGEN_CTRL_value = &H0
        flag_CLKGEN_CTRL        = &H0
        write_BIAS_VREF_CTRL_value = &H0
        flag_BIAS_VREF_CTRL        = &H0
        write_BIAS_VREF_VAL_value = &H0
        flag_BIAS_VREF_VAL        = &H0
        write_RESERVED_0000_value = &H0
        flag_RESERVED_0000        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PGA1_BIAS_CUR                              [15:13]          get_PGA1_BIAS_CUR
''                                                             set_PGA1_BIAS_CUR
''                                                             read_PGA1_BIAS_CUR
''                                                             write_PGA1_BIAS_CUR
''---------------------------------------------------------------------------------
'' PGA2_BIAS_CUR                              [12:10]          get_PGA2_BIAS_CUR
''                                                             set_PGA2_BIAS_CUR
''                                                             read_PGA2_BIAS_CUR
''                                                             write_PGA2_BIAS_CUR
''---------------------------------------------------------------------------------
'' LPF_BIAS_CUR                               [9:7]            get_LPF_BIAS_CUR
''                                                             set_LPF_BIAS_CUR
''                                                             read_LPF_BIAS_CUR
''                                                             write_LPF_BIAS_CUR
''---------------------------------------------------------------------------------
'' LPF_CNR_CODE                               [6:4]            get_LPF_CNR_CODE
''                                                             set_LPF_CNR_CODE
''                                                             read_LPF_CNR_CODE
''                                                             write_LPF_CNR_CODE
''---------------------------------------------------------------------------------
'' ACD_HPF_OVR                                [3:3]            get_ACD_HPF_OVR
''                                                             set_ACD_HPF_OVR
''                                                             read_ACD_HPF_OVR
''                                                             write_ACD_HPF_OVR
''---------------------------------------------------------------------------------
'' ACD_CNR_OVR                                [2:2]            get_ACD_CNR_OVR
''                                                             set_ACD_CNR_OVR
''                                                             read_ACD_CNR_OVR
''                                                             write_ACD_CNR_OVR
''---------------------------------------------------------------------------------
'' FLTR_DIS                                   [1:1]            get_FLTR_DIS
''                                                             set_FLTR_DIS
''                                                             read_FLTR_DIS
''                                                             write_FLTR_DIS
''---------------------------------------------------------------------------------
'' OPENUP_FLTR_VW                             [0:0]            get_OPENUP_FLTR_VW
''                                                             set_OPENUP_FLTR_VW
''                                                             read_OPENUP_FLTR_VW
''                                                             write_OPENUP_FLTR_VW
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_8
    Private write_PGA1_BIAS_CUR_value
    Private read_PGA1_BIAS_CUR_value
    Private flag_PGA1_BIAS_CUR
    Private write_PGA2_BIAS_CUR_value
    Private read_PGA2_BIAS_CUR_value
    Private flag_PGA2_BIAS_CUR
    Private write_LPF_BIAS_CUR_value
    Private read_LPF_BIAS_CUR_value
    Private flag_LPF_BIAS_CUR
    Private write_LPF_CNR_CODE_value
    Private read_LPF_CNR_CODE_value
    Private flag_LPF_CNR_CODE
    Private write_ACD_HPF_OVR_value
    Private read_ACD_HPF_OVR_value
    Private flag_ACD_HPF_OVR
    Private write_ACD_CNR_OVR_value
    Private read_ACD_CNR_OVR_value
    Private flag_ACD_CNR_OVR
    Private write_FLTR_DIS_value
    Private read_FLTR_DIS_value
    Private flag_FLTR_DIS
    Private write_OPENUP_FLTR_VW_value
    Private read_OPENUP_FLTR_VW_value
    Private flag_OPENUP_FLTR_VW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PGA1_BIAS_CUR
        get_PGA1_BIAS_CUR = read_PGA1_BIAS_CUR_value
    End Property

    Property Let set_PGA1_BIAS_CUR(aData)
        write_PGA1_BIAS_CUR_value = aData
        flag_PGA1_BIAS_CUR        = &H1
    End Property

    Property Get read_PGA1_BIAS_CUR
        read
        read_PGA1_BIAS_CUR = read_PGA1_BIAS_CUR_value
    End Property

    Property Let write_PGA1_BIAS_CUR(aData)
        set_PGA1_BIAS_CUR = aData
        write
    End Property

    Property Get get_PGA2_BIAS_CUR
        get_PGA2_BIAS_CUR = read_PGA2_BIAS_CUR_value
    End Property

    Property Let set_PGA2_BIAS_CUR(aData)
        write_PGA2_BIAS_CUR_value = aData
        flag_PGA2_BIAS_CUR        = &H1
    End Property

    Property Get read_PGA2_BIAS_CUR
        read
        read_PGA2_BIAS_CUR = read_PGA2_BIAS_CUR_value
    End Property

    Property Let write_PGA2_BIAS_CUR(aData)
        set_PGA2_BIAS_CUR = aData
        write
    End Property

    Property Get get_LPF_BIAS_CUR
        get_LPF_BIAS_CUR = read_LPF_BIAS_CUR_value
    End Property

    Property Let set_LPF_BIAS_CUR(aData)
        write_LPF_BIAS_CUR_value = aData
        flag_LPF_BIAS_CUR        = &H1
    End Property

    Property Get read_LPF_BIAS_CUR
        read
        read_LPF_BIAS_CUR = read_LPF_BIAS_CUR_value
    End Property

    Property Let write_LPF_BIAS_CUR(aData)
        set_LPF_BIAS_CUR = aData
        write
    End Property

    Property Get get_LPF_CNR_CODE
        get_LPF_CNR_CODE = read_LPF_CNR_CODE_value
    End Property

    Property Let set_LPF_CNR_CODE(aData)
        write_LPF_CNR_CODE_value = aData
        flag_LPF_CNR_CODE        = &H1
    End Property

    Property Get read_LPF_CNR_CODE
        read
        read_LPF_CNR_CODE = read_LPF_CNR_CODE_value
    End Property

    Property Let write_LPF_CNR_CODE(aData)
        set_LPF_CNR_CODE = aData
        write
    End Property

    Property Get get_ACD_HPF_OVR
        get_ACD_HPF_OVR = read_ACD_HPF_OVR_value
    End Property

    Property Let set_ACD_HPF_OVR(aData)
        write_ACD_HPF_OVR_value = aData
        flag_ACD_HPF_OVR        = &H1
    End Property

    Property Get read_ACD_HPF_OVR
        read
        read_ACD_HPF_OVR = read_ACD_HPF_OVR_value
    End Property

    Property Let write_ACD_HPF_OVR(aData)
        set_ACD_HPF_OVR = aData
        write
    End Property

    Property Get get_ACD_CNR_OVR
        get_ACD_CNR_OVR = read_ACD_CNR_OVR_value
    End Property

    Property Let set_ACD_CNR_OVR(aData)
        write_ACD_CNR_OVR_value = aData
        flag_ACD_CNR_OVR        = &H1
    End Property

    Property Get read_ACD_CNR_OVR
        read
        read_ACD_CNR_OVR = read_ACD_CNR_OVR_value
    End Property

    Property Let write_ACD_CNR_OVR(aData)
        set_ACD_CNR_OVR = aData
        write
    End Property

    Property Get get_FLTR_DIS
        get_FLTR_DIS = read_FLTR_DIS_value
    End Property

    Property Let set_FLTR_DIS(aData)
        write_FLTR_DIS_value = aData
        flag_FLTR_DIS        = &H1
    End Property

    Property Get read_FLTR_DIS
        read
        read_FLTR_DIS = read_FLTR_DIS_value
    End Property

    Property Let write_FLTR_DIS(aData)
        set_FLTR_DIS = aData
        write
    End Property

    Property Get get_OPENUP_FLTR_VW
        get_OPENUP_FLTR_VW = read_OPENUP_FLTR_VW_value
    End Property

    Property Let set_OPENUP_FLTR_VW(aData)
        write_OPENUP_FLTR_VW_value = aData
        flag_OPENUP_FLTR_VW        = &H1
    End Property

    Property Get read_OPENUP_FLTR_VW
        read
        read_OPENUP_FLTR_VW = read_OPENUP_FLTR_VW_value
    End Property

    Property Let write_OPENUP_FLTR_VW(aData)
        set_OPENUP_FLTR_VW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PGA1_BIAS_CUR_value = rightShift(data_low, 13) and &H7
        read_PGA2_BIAS_CUR_value = rightShift(data_low, 10) and &H7
        read_LPF_BIAS_CUR_value = rightShift(data_low, 7) and &H7
        read_LPF_CNR_CODE_value = rightShift(data_low, 4) and &H7
        read_ACD_HPF_OVR_value = rightShift(data_low, 3) and &H1
        read_ACD_CNR_OVR_value = rightShift(data_low, 2) and &H1
        read_FLTR_DIS_value = rightShift(data_low, 1) and &H1
        OPENUP_FLTR_VW_mask = &H1
        if data_low > LONG_MAX then
            if OPENUP_FLTR_VW_mask = mask then
                read_OPENUP_FLTR_VW_value = data_low
            else
                read_OPENUP_FLTR_VW_value = (data_low - H8000_0000) and OPENUP_FLTR_VW_mask
            end If
        else
            read_OPENUP_FLTR_VW_value = data_low and OPENUP_FLTR_VW_mask
        end If

    End Sub

    Sub write
        If flag_PGA1_BIAS_CUR = &H0 or flag_PGA2_BIAS_CUR = &H0 or flag_LPF_BIAS_CUR = &H0 or flag_LPF_CNR_CODE = &H0 or flag_ACD_HPF_OVR = &H0 or flag_ACD_CNR_OVR = &H0 or flag_FLTR_DIS = &H0 or flag_OPENUP_FLTR_VW = &H0 Then read
        If flag_PGA1_BIAS_CUR = &H0 Then write_PGA1_BIAS_CUR_value = get_PGA1_BIAS_CUR
        If flag_PGA2_BIAS_CUR = &H0 Then write_PGA2_BIAS_CUR_value = get_PGA2_BIAS_CUR
        If flag_LPF_BIAS_CUR = &H0 Then write_LPF_BIAS_CUR_value = get_LPF_BIAS_CUR
        If flag_LPF_CNR_CODE = &H0 Then write_LPF_CNR_CODE_value = get_LPF_CNR_CODE
        If flag_ACD_HPF_OVR = &H0 Then write_ACD_HPF_OVR_value = get_ACD_HPF_OVR
        If flag_ACD_CNR_OVR = &H0 Then write_ACD_CNR_OVR_value = get_ACD_CNR_OVR
        If flag_FLTR_DIS = &H0 Then write_FLTR_DIS_value = get_FLTR_DIS
        If flag_OPENUP_FLTR_VW = &H0 Then write_OPENUP_FLTR_VW_value = get_OPENUP_FLTR_VW

        regValue = leftShift((write_PGA1_BIAS_CUR_value and &H7), 13) + leftShift((write_PGA2_BIAS_CUR_value and &H7), 10) + leftShift((write_LPF_BIAS_CUR_value and &H7), 7) + leftShift((write_LPF_CNR_CODE_value and &H7), 4) + leftShift((write_ACD_HPF_OVR_value and &H1), 3) + leftShift((write_ACD_CNR_OVR_value and &H1), 2) + leftShift((write_FLTR_DIS_value and &H1), 1) + leftShift((write_OPENUP_FLTR_VW_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PGA1_BIAS_CUR_value = rightShift(data_low, 13) and &H7
        read_PGA2_BIAS_CUR_value = rightShift(data_low, 10) and &H7
        read_LPF_BIAS_CUR_value = rightShift(data_low, 7) and &H7
        read_LPF_CNR_CODE_value = rightShift(data_low, 4) and &H7
        read_ACD_HPF_OVR_value = rightShift(data_low, 3) and &H1
        read_ACD_CNR_OVR_value = rightShift(data_low, 2) and &H1
        read_FLTR_DIS_value = rightShift(data_low, 1) and &H1
        OPENUP_FLTR_VW_mask = &H1
        if data_low > LONG_MAX then
            if OPENUP_FLTR_VW_mask = mask then
                read_OPENUP_FLTR_VW_value = data_low
            else
                read_OPENUP_FLTR_VW_value = (data_low - H8000_0000) and OPENUP_FLTR_VW_mask
            end If
        else
            read_OPENUP_FLTR_VW_value = data_low and OPENUP_FLTR_VW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PGA1_BIAS_CUR_value = &H0
        flag_PGA1_BIAS_CUR        = &H0
        write_PGA2_BIAS_CUR_value = &H0
        flag_PGA2_BIAS_CUR        = &H0
        write_LPF_BIAS_CUR_value = &H0
        flag_LPF_BIAS_CUR        = &H0
        write_LPF_CNR_CODE_value = &H0
        flag_LPF_CNR_CODE        = &H0
        write_ACD_HPF_OVR_value = &H0
        flag_ACD_HPF_OVR        = &H0
        write_ACD_CNR_OVR_value = &H0
        flag_ACD_CNR_OVR        = &H0
        write_FLTR_DIS_value = &H0
        flag_FLTR_DIS        = &H0
        write_OPENUP_FLTR_VW_value = &H0
        flag_OPENUP_FLTR_VW        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1511                              [15:11]          get_RESERVED_1511
''                                                             set_RESERVED_1511
''                                                             read_RESERVED_1511
''                                                             write_RESERVED_1511
''---------------------------------------------------------------------------------
'' PGA_STEP_PTR                               [10:5]           get_PGA_STEP_PTR
''                                                             set_PGA_STEP_PTR
''                                                             read_PGA_STEP_PTR
''                                                             write_PGA_STEP_PTR
''---------------------------------------------------------------------------------
'' PGA_LUT_SELECT                             [4:4]            get_PGA_LUT_SELECT
''                                                             set_PGA_LUT_SELECT
''                                                             read_PGA_LUT_SELECT
''                                                             write_PGA_LUT_SELECT
''---------------------------------------------------------------------------------
'' PGA_LUT_FORCE_EN                           [3:3]            get_PGA_LUT_FORCE_EN
''                                                             set_PGA_LUT_FORCE_EN
''                                                             read_PGA_LUT_FORCE_EN
''                                                             write_PGA_LUT_FORCE_EN
''---------------------------------------------------------------------------------
'' PGA_CM_LVL                                 [2:1]            get_PGA_CM_LVL
''                                                             set_PGA_CM_LVL
''                                                             read_PGA_CM_LVL
''                                                             write_PGA_CM_LVL
''---------------------------------------------------------------------------------
'' AUTO_35DB_EN                               [0:0]            get_AUTO_35DB_EN
''                                                             set_AUTO_35DB_EN
''                                                             read_AUTO_35DB_EN
''                                                             write_AUTO_35DB_EN
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_9
    Private write_RESERVED_1511_value
    Private read_RESERVED_1511_value
    Private flag_RESERVED_1511
    Private write_PGA_STEP_PTR_value
    Private read_PGA_STEP_PTR_value
    Private flag_PGA_STEP_PTR
    Private write_PGA_LUT_SELECT_value
    Private read_PGA_LUT_SELECT_value
    Private flag_PGA_LUT_SELECT
    Private write_PGA_LUT_FORCE_EN_value
    Private read_PGA_LUT_FORCE_EN_value
    Private flag_PGA_LUT_FORCE_EN
    Private write_PGA_CM_LVL_value
    Private read_PGA_CM_LVL_value
    Private flag_PGA_CM_LVL
    Private write_AUTO_35DB_EN_value
    Private read_AUTO_35DB_EN_value
    Private flag_AUTO_35DB_EN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RESERVED_1511
        get_RESERVED_1511 = read_RESERVED_1511_value
    End Property

    Property Let set_RESERVED_1511(aData)
        write_RESERVED_1511_value = aData
        flag_RESERVED_1511        = &H1
    End Property

    Property Get read_RESERVED_1511
        read
        read_RESERVED_1511 = read_RESERVED_1511_value
    End Property

    Property Let write_RESERVED_1511(aData)
        set_RESERVED_1511 = aData
        write
    End Property

    Property Get get_PGA_STEP_PTR
        get_PGA_STEP_PTR = read_PGA_STEP_PTR_value
    End Property

    Property Let set_PGA_STEP_PTR(aData)
        write_PGA_STEP_PTR_value = aData
        flag_PGA_STEP_PTR        = &H1
    End Property

    Property Get read_PGA_STEP_PTR
        read
        read_PGA_STEP_PTR = read_PGA_STEP_PTR_value
    End Property

    Property Let write_PGA_STEP_PTR(aData)
        set_PGA_STEP_PTR = aData
        write
    End Property

    Property Get get_PGA_LUT_SELECT
        get_PGA_LUT_SELECT = read_PGA_LUT_SELECT_value
    End Property

    Property Let set_PGA_LUT_SELECT(aData)
        write_PGA_LUT_SELECT_value = aData
        flag_PGA_LUT_SELECT        = &H1
    End Property

    Property Get read_PGA_LUT_SELECT
        read
        read_PGA_LUT_SELECT = read_PGA_LUT_SELECT_value
    End Property

    Property Let write_PGA_LUT_SELECT(aData)
        set_PGA_LUT_SELECT = aData
        write
    End Property

    Property Get get_PGA_LUT_FORCE_EN
        get_PGA_LUT_FORCE_EN = read_PGA_LUT_FORCE_EN_value
    End Property

    Property Let set_PGA_LUT_FORCE_EN(aData)
        write_PGA_LUT_FORCE_EN_value = aData
        flag_PGA_LUT_FORCE_EN        = &H1
    End Property

    Property Get read_PGA_LUT_FORCE_EN
        read
        read_PGA_LUT_FORCE_EN = read_PGA_LUT_FORCE_EN_value
    End Property

    Property Let write_PGA_LUT_FORCE_EN(aData)
        set_PGA_LUT_FORCE_EN = aData
        write
    End Property

    Property Get get_PGA_CM_LVL
        get_PGA_CM_LVL = read_PGA_CM_LVL_value
    End Property

    Property Let set_PGA_CM_LVL(aData)
        write_PGA_CM_LVL_value = aData
        flag_PGA_CM_LVL        = &H1
    End Property

    Property Get read_PGA_CM_LVL
        read
        read_PGA_CM_LVL = read_PGA_CM_LVL_value
    End Property

    Property Let write_PGA_CM_LVL(aData)
        set_PGA_CM_LVL = aData
        write
    End Property

    Property Get get_AUTO_35DB_EN
        get_AUTO_35DB_EN = read_AUTO_35DB_EN_value
    End Property

    Property Let set_AUTO_35DB_EN(aData)
        write_AUTO_35DB_EN_value = aData
        flag_AUTO_35DB_EN        = &H1
    End Property

    Property Get read_AUTO_35DB_EN
        read
        read_AUTO_35DB_EN = read_AUTO_35DB_EN_value
    End Property

    Property Let write_AUTO_35DB_EN(aData)
        set_AUTO_35DB_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1511_value = rightShift(data_low, 11) and &H1f
        read_PGA_STEP_PTR_value = rightShift(data_low, 5) and &H3f
        read_PGA_LUT_SELECT_value = rightShift(data_low, 4) and &H1
        read_PGA_LUT_FORCE_EN_value = rightShift(data_low, 3) and &H1
        read_PGA_CM_LVL_value = rightShift(data_low, 1) and &H3
        AUTO_35DB_EN_mask = &H1
        if data_low > LONG_MAX then
            if AUTO_35DB_EN_mask = mask then
                read_AUTO_35DB_EN_value = data_low
            else
                read_AUTO_35DB_EN_value = (data_low - H8000_0000) and AUTO_35DB_EN_mask
            end If
        else
            read_AUTO_35DB_EN_value = data_low and AUTO_35DB_EN_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1511 = &H0 or flag_PGA_STEP_PTR = &H0 or flag_PGA_LUT_SELECT = &H0 or flag_PGA_LUT_FORCE_EN = &H0 or flag_PGA_CM_LVL = &H0 or flag_AUTO_35DB_EN = &H0 Then read
        If flag_RESERVED_1511 = &H0 Then write_RESERVED_1511_value = get_RESERVED_1511
        If flag_PGA_STEP_PTR = &H0 Then write_PGA_STEP_PTR_value = get_PGA_STEP_PTR
        If flag_PGA_LUT_SELECT = &H0 Then write_PGA_LUT_SELECT_value = get_PGA_LUT_SELECT
        If flag_PGA_LUT_FORCE_EN = &H0 Then write_PGA_LUT_FORCE_EN_value = get_PGA_LUT_FORCE_EN
        If flag_PGA_CM_LVL = &H0 Then write_PGA_CM_LVL_value = get_PGA_CM_LVL
        If flag_AUTO_35DB_EN = &H0 Then write_AUTO_35DB_EN_value = get_AUTO_35DB_EN

        regValue = leftShift((write_RESERVED_1511_value and &H1f), 11) + leftShift((write_PGA_STEP_PTR_value and &H3f), 5) + leftShift((write_PGA_LUT_SELECT_value and &H1), 4) + leftShift((write_PGA_LUT_FORCE_EN_value and &H1), 3) + leftShift((write_PGA_CM_LVL_value and &H3), 1) + leftShift((write_AUTO_35DB_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1511_value = rightShift(data_low, 11) and &H1f
        read_PGA_STEP_PTR_value = rightShift(data_low, 5) and &H3f
        read_PGA_LUT_SELECT_value = rightShift(data_low, 4) and &H1
        read_PGA_LUT_FORCE_EN_value = rightShift(data_low, 3) and &H1
        read_PGA_CM_LVL_value = rightShift(data_low, 1) and &H3
        AUTO_35DB_EN_mask = &H1
        if data_low > LONG_MAX then
            if AUTO_35DB_EN_mask = mask then
                read_AUTO_35DB_EN_value = data_low
            else
                read_AUTO_35DB_EN_value = (data_low - H8000_0000) and AUTO_35DB_EN_mask
            end If
        else
            read_AUTO_35DB_EN_value = data_low and AUTO_35DB_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1511_value = &H0
        flag_RESERVED_1511        = &H0
        write_PGA_STEP_PTR_value = &H0
        flag_PGA_STEP_PTR        = &H0
        write_PGA_LUT_SELECT_value = &H0
        flag_PGA_LUT_SELECT        = &H0
        write_PGA_LUT_FORCE_EN_value = &H0
        flag_PGA_LUT_FORCE_EN        = &H0
        write_PGA_CM_LVL_value = &H0
        flag_PGA_CM_LVL        = &H0
        write_AUTO_35DB_EN_value = &H0
        flag_AUTO_35DB_EN        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AGC_GAIN_FREEZE                            [15:15]          get_AGC_GAIN_FREEZE
''                                                             set_AGC_GAIN_FREEZE
''                                                             read_AGC_GAIN_FREEZE
''                                                             write_AGC_GAIN_FREEZE
''---------------------------------------------------------------------------------
'' FORCE_PGA_RDY                              [14:14]          get_FORCE_PGA_RDY
''                                                             set_FORCE_PGA_RDY
''                                                             read_FORCE_PGA_RDY
''                                                             write_FORCE_PGA_RDY
''---------------------------------------------------------------------------------
'' RST_PGA_BYPS                               [13:13]          get_RST_PGA_BYPS
''                                                             set_RST_PGA_BYPS
''                                                             read_RST_PGA_BYPS
''                                                             write_RST_PGA_BYPS
''---------------------------------------------------------------------------------
'' INIT_PGA_SEL                               [12:6]           get_INIT_PGA_SEL
''                                                             set_INIT_PGA_SEL
''                                                             read_INIT_PGA_SEL
''                                                             write_INIT_PGA_SEL
''---------------------------------------------------------------------------------
'' PGA_SLOPE_SEL                              [5:3]            get_PGA_SLOPE_SEL
''                                                             set_PGA_SLOPE_SEL
''                                                             read_PGA_SLOPE_SEL
''                                                             write_PGA_SLOPE_SEL
''---------------------------------------------------------------------------------
'' PGA_RDY_DELAY                              [2:0]            get_PGA_RDY_DELAY
''                                                             set_PGA_RDY_DELAY
''                                                             read_PGA_RDY_DELAY
''                                                             write_PGA_RDY_DELAY
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_10
    Private write_AGC_GAIN_FREEZE_value
    Private read_AGC_GAIN_FREEZE_value
    Private flag_AGC_GAIN_FREEZE
    Private write_FORCE_PGA_RDY_value
    Private read_FORCE_PGA_RDY_value
    Private flag_FORCE_PGA_RDY
    Private write_RST_PGA_BYPS_value
    Private read_RST_PGA_BYPS_value
    Private flag_RST_PGA_BYPS
    Private write_INIT_PGA_SEL_value
    Private read_INIT_PGA_SEL_value
    Private flag_INIT_PGA_SEL
    Private write_PGA_SLOPE_SEL_value
    Private read_PGA_SLOPE_SEL_value
    Private flag_PGA_SLOPE_SEL
    Private write_PGA_RDY_DELAY_value
    Private read_PGA_RDY_DELAY_value
    Private flag_PGA_RDY_DELAY

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AGC_GAIN_FREEZE
        get_AGC_GAIN_FREEZE = read_AGC_GAIN_FREEZE_value
    End Property

    Property Let set_AGC_GAIN_FREEZE(aData)
        write_AGC_GAIN_FREEZE_value = aData
        flag_AGC_GAIN_FREEZE        = &H1
    End Property

    Property Get read_AGC_GAIN_FREEZE
        read
        read_AGC_GAIN_FREEZE = read_AGC_GAIN_FREEZE_value
    End Property

    Property Let write_AGC_GAIN_FREEZE(aData)
        set_AGC_GAIN_FREEZE = aData
        write
    End Property

    Property Get get_FORCE_PGA_RDY
        get_FORCE_PGA_RDY = read_FORCE_PGA_RDY_value
    End Property

    Property Let set_FORCE_PGA_RDY(aData)
        write_FORCE_PGA_RDY_value = aData
        flag_FORCE_PGA_RDY        = &H1
    End Property

    Property Get read_FORCE_PGA_RDY
        read
        read_FORCE_PGA_RDY = read_FORCE_PGA_RDY_value
    End Property

    Property Let write_FORCE_PGA_RDY(aData)
        set_FORCE_PGA_RDY = aData
        write
    End Property

    Property Get get_RST_PGA_BYPS
        get_RST_PGA_BYPS = read_RST_PGA_BYPS_value
    End Property

    Property Let set_RST_PGA_BYPS(aData)
        write_RST_PGA_BYPS_value = aData
        flag_RST_PGA_BYPS        = &H1
    End Property

    Property Get read_RST_PGA_BYPS
        read
        read_RST_PGA_BYPS = read_RST_PGA_BYPS_value
    End Property

    Property Let write_RST_PGA_BYPS(aData)
        set_RST_PGA_BYPS = aData
        write
    End Property

    Property Get get_INIT_PGA_SEL
        get_INIT_PGA_SEL = read_INIT_PGA_SEL_value
    End Property

    Property Let set_INIT_PGA_SEL(aData)
        write_INIT_PGA_SEL_value = aData
        flag_INIT_PGA_SEL        = &H1
    End Property

    Property Get read_INIT_PGA_SEL
        read
        read_INIT_PGA_SEL = read_INIT_PGA_SEL_value
    End Property

    Property Let write_INIT_PGA_SEL(aData)
        set_INIT_PGA_SEL = aData
        write
    End Property

    Property Get get_PGA_SLOPE_SEL
        get_PGA_SLOPE_SEL = read_PGA_SLOPE_SEL_value
    End Property

    Property Let set_PGA_SLOPE_SEL(aData)
        write_PGA_SLOPE_SEL_value = aData
        flag_PGA_SLOPE_SEL        = &H1
    End Property

    Property Get read_PGA_SLOPE_SEL
        read
        read_PGA_SLOPE_SEL = read_PGA_SLOPE_SEL_value
    End Property

    Property Let write_PGA_SLOPE_SEL(aData)
        set_PGA_SLOPE_SEL = aData
        write
    End Property

    Property Get get_PGA_RDY_DELAY
        get_PGA_RDY_DELAY = read_PGA_RDY_DELAY_value
    End Property

    Property Let set_PGA_RDY_DELAY(aData)
        write_PGA_RDY_DELAY_value = aData
        flag_PGA_RDY_DELAY        = &H1
    End Property

    Property Get read_PGA_RDY_DELAY
        read
        read_PGA_RDY_DELAY = read_PGA_RDY_DELAY_value
    End Property

    Property Let write_PGA_RDY_DELAY(aData)
        set_PGA_RDY_DELAY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AGC_GAIN_FREEZE_value = rightShift(data_low, 15) and &H1
        read_FORCE_PGA_RDY_value = rightShift(data_low, 14) and &H1
        read_RST_PGA_BYPS_value = rightShift(data_low, 13) and &H1
        read_INIT_PGA_SEL_value = rightShift(data_low, 6) and &H7f
        read_PGA_SLOPE_SEL_value = rightShift(data_low, 3) and &H7
        PGA_RDY_DELAY_mask = &H7
        if data_low > LONG_MAX then
            if PGA_RDY_DELAY_mask = mask then
                read_PGA_RDY_DELAY_value = data_low
            else
                read_PGA_RDY_DELAY_value = (data_low - H8000_0000) and PGA_RDY_DELAY_mask
            end If
        else
            read_PGA_RDY_DELAY_value = data_low and PGA_RDY_DELAY_mask
        end If

    End Sub

    Sub write
        If flag_AGC_GAIN_FREEZE = &H0 or flag_FORCE_PGA_RDY = &H0 or flag_RST_PGA_BYPS = &H0 or flag_INIT_PGA_SEL = &H0 or flag_PGA_SLOPE_SEL = &H0 or flag_PGA_RDY_DELAY = &H0 Then read
        If flag_AGC_GAIN_FREEZE = &H0 Then write_AGC_GAIN_FREEZE_value = get_AGC_GAIN_FREEZE
        If flag_FORCE_PGA_RDY = &H0 Then write_FORCE_PGA_RDY_value = get_FORCE_PGA_RDY
        If flag_RST_PGA_BYPS = &H0 Then write_RST_PGA_BYPS_value = get_RST_PGA_BYPS
        If flag_INIT_PGA_SEL = &H0 Then write_INIT_PGA_SEL_value = get_INIT_PGA_SEL
        If flag_PGA_SLOPE_SEL = &H0 Then write_PGA_SLOPE_SEL_value = get_PGA_SLOPE_SEL
        If flag_PGA_RDY_DELAY = &H0 Then write_PGA_RDY_DELAY_value = get_PGA_RDY_DELAY

        regValue = leftShift((write_AGC_GAIN_FREEZE_value and &H1), 15) + leftShift((write_FORCE_PGA_RDY_value and &H1), 14) + leftShift((write_RST_PGA_BYPS_value and &H1), 13) + leftShift((write_INIT_PGA_SEL_value and &H7f), 6) + leftShift((write_PGA_SLOPE_SEL_value and &H7), 3) + leftShift((write_PGA_RDY_DELAY_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AGC_GAIN_FREEZE_value = rightShift(data_low, 15) and &H1
        read_FORCE_PGA_RDY_value = rightShift(data_low, 14) and &H1
        read_RST_PGA_BYPS_value = rightShift(data_low, 13) and &H1
        read_INIT_PGA_SEL_value = rightShift(data_low, 6) and &H7f
        read_PGA_SLOPE_SEL_value = rightShift(data_low, 3) and &H7
        PGA_RDY_DELAY_mask = &H7
        if data_low > LONG_MAX then
            if PGA_RDY_DELAY_mask = mask then
                read_PGA_RDY_DELAY_value = data_low
            else
                read_PGA_RDY_DELAY_value = (data_low - H8000_0000) and PGA_RDY_DELAY_mask
            end If
        else
            read_PGA_RDY_DELAY_value = data_low and PGA_RDY_DELAY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AGC_GAIN_FREEZE_value = &H0
        flag_AGC_GAIN_FREEZE        = &H0
        write_FORCE_PGA_RDY_value = &H0
        flag_FORCE_PGA_RDY        = &H0
        write_RST_PGA_BYPS_value = &H0
        flag_RST_PGA_BYPS        = &H0
        write_INIT_PGA_SEL_value = &H0
        flag_INIT_PGA_SEL        = &H0
        write_PGA_SLOPE_SEL_value = &H0
        flag_PGA_SLOPE_SEL        = &H0
        write_PGA_RDY_DELAY_value = &H0
        flag_PGA_RDY_DELAY        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1502                              [15:2]           get_RESERVED_1502
''                                                             set_RESERVED_1502
''                                                             read_RESERVED_1502
''                                                             write_RESERVED_1502
''---------------------------------------------------------------------------------
'' RST_PGA_FORCE                              [1:1]            get_RST_PGA_FORCE
''                                                             set_RST_PGA_FORCE
''                                                             read_RST_PGA_FORCE
''                                                             write_RST_PGA_FORCE
''---------------------------------------------------------------------------------
'' RST_PGA_VALUE                              [0:0]            get_RST_PGA_VALUE
''                                                             set_RST_PGA_VALUE
''                                                             read_RST_PGA_VALUE
''                                                             write_RST_PGA_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_11
    Private write_RESERVED_1502_value
    Private read_RESERVED_1502_value
    Private flag_RESERVED_1502
    Private write_RST_PGA_FORCE_value
    Private read_RST_PGA_FORCE_value
    Private flag_RST_PGA_FORCE
    Private write_RST_PGA_VALUE_value
    Private read_RST_PGA_VALUE_value
    Private flag_RST_PGA_VALUE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RESERVED_1502
        get_RESERVED_1502 = read_RESERVED_1502_value
    End Property

    Property Let set_RESERVED_1502(aData)
        write_RESERVED_1502_value = aData
        flag_RESERVED_1502        = &H1
    End Property

    Property Get read_RESERVED_1502
        read
        read_RESERVED_1502 = read_RESERVED_1502_value
    End Property

    Property Let write_RESERVED_1502(aData)
        set_RESERVED_1502 = aData
        write
    End Property

    Property Get get_RST_PGA_FORCE
        get_RST_PGA_FORCE = read_RST_PGA_FORCE_value
    End Property

    Property Let set_RST_PGA_FORCE(aData)
        write_RST_PGA_FORCE_value = aData
        flag_RST_PGA_FORCE        = &H1
    End Property

    Property Get read_RST_PGA_FORCE
        read
        read_RST_PGA_FORCE = read_RST_PGA_FORCE_value
    End Property

    Property Let write_RST_PGA_FORCE(aData)
        set_RST_PGA_FORCE = aData
        write
    End Property

    Property Get get_RST_PGA_VALUE
        get_RST_PGA_VALUE = read_RST_PGA_VALUE_value
    End Property

    Property Let set_RST_PGA_VALUE(aData)
        write_RST_PGA_VALUE_value = aData
        flag_RST_PGA_VALUE        = &H1
    End Property

    Property Get read_RST_PGA_VALUE
        read
        read_RST_PGA_VALUE = read_RST_PGA_VALUE_value
    End Property

    Property Let write_RST_PGA_VALUE(aData)
        set_RST_PGA_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1502_value = rightShift(data_low, 2) and &H3fff
        read_RST_PGA_FORCE_value = rightShift(data_low, 1) and &H1
        RST_PGA_VALUE_mask = &H1
        if data_low > LONG_MAX then
            if RST_PGA_VALUE_mask = mask then
                read_RST_PGA_VALUE_value = data_low
            else
                read_RST_PGA_VALUE_value = (data_low - H8000_0000) and RST_PGA_VALUE_mask
            end If
        else
            read_RST_PGA_VALUE_value = data_low and RST_PGA_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1502 = &H0 or flag_RST_PGA_FORCE = &H0 or flag_RST_PGA_VALUE = &H0 Then read
        If flag_RESERVED_1502 = &H0 Then write_RESERVED_1502_value = get_RESERVED_1502
        If flag_RST_PGA_FORCE = &H0 Then write_RST_PGA_FORCE_value = get_RST_PGA_FORCE
        If flag_RST_PGA_VALUE = &H0 Then write_RST_PGA_VALUE_value = get_RST_PGA_VALUE

        regValue = leftShift((write_RESERVED_1502_value and &H3fff), 2) + leftShift((write_RST_PGA_FORCE_value and &H1), 1) + leftShift((write_RST_PGA_VALUE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1502_value = rightShift(data_low, 2) and &H3fff
        read_RST_PGA_FORCE_value = rightShift(data_low, 1) and &H1
        RST_PGA_VALUE_mask = &H1
        if data_low > LONG_MAX then
            if RST_PGA_VALUE_mask = mask then
                read_RST_PGA_VALUE_value = data_low
            else
                read_RST_PGA_VALUE_value = (data_low - H8000_0000) and RST_PGA_VALUE_mask
            end If
        else
            read_RST_PGA_VALUE_value = data_low and RST_PGA_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1502_value = &H0
        flag_RESERVED_1502        = &H0
        write_RST_PGA_FORCE_value = &H0
        flag_RST_PGA_FORCE        = &H0
        write_RST_PGA_VALUE_value = &H0
        flag_RST_PGA_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BYP_BIAS_AMP                               [15:15]          get_BYP_BIAS_AMP
''                                                             set_BYP_BIAS_AMP
''                                                             read_BYP_BIAS_AMP
''                                                             write_BYP_BIAS_AMP
''---------------------------------------------------------------------------------
'' FLTR_CTRL_VOL                              [14:13]          get_FLTR_CTRL_VOL
''                                                             set_FLTR_CTRL_VOL
''                                                             read_FLTR_CTRL_VOL
''                                                             write_FLTR_CTRL_VOL
''---------------------------------------------------------------------------------
'' FLTR_CTRL_CUR                              [12:12]          get_FLTR_CTRL_CUR
''                                                             set_FLTR_CTRL_CUR
''                                                             read_FLTR_CTRL_CUR
''                                                             write_FLTR_CTRL_CUR
''---------------------------------------------------------------------------------
'' CMFB_CUR_CTRL                              [11:10]          get_CMFB_CUR_CTRL
''                                                             set_CMFB_CUR_CTRL
''                                                             read_CMFB_CUR_CTRL
''                                                             write_CMFB_CUR_CTRL
''---------------------------------------------------------------------------------
'' FLTR_CTRL_IBCUR                            [9:9]            get_FLTR_CTRL_IBCUR
''                                                             set_FLTR_CTRL_IBCUR
''                                                             read_FLTR_CTRL_IBCUR
''                                                             write_FLTR_CTRL_IBCUR
''---------------------------------------------------------------------------------
'' FLTR_CTRL_OBCUR                            [8:8]            get_FLTR_CTRL_OBCUR
''                                                             set_FLTR_CTRL_OBCUR
''                                                             read_FLTR_CTRL_OBCUR
''                                                             write_FLTR_CTRL_OBCUR
''---------------------------------------------------------------------------------
'' FLTR_CTRL_RESPD                            [7:6]            get_FLTR_CTRL_RESPD
''                                                             set_FLTR_CTRL_RESPD
''                                                             read_FLTR_CTRL_RESPD
''                                                             write_FLTR_CTRL_RESPD
''---------------------------------------------------------------------------------
'' BIAS_AMP_VNCAS                             [5:4]            get_BIAS_AMP_VNCAS
''                                                             set_BIAS_AMP_VNCAS
''                                                             read_BIAS_AMP_VNCAS
''                                                             write_BIAS_AMP_VNCAS
''---------------------------------------------------------------------------------
'' CMFB_AMP_VNCAS                             [3:2]            get_CMFB_AMP_VNCAS
''                                                             set_CMFB_AMP_VNCAS
''                                                             read_CMFB_AMP_VNCAS
''                                                             write_CMFB_AMP_VNCAS
''---------------------------------------------------------------------------------
'' FLTR_CTRL_VCM                              [1:0]            get_FLTR_CTRL_VCM
''                                                             set_FLTR_CTRL_VCM
''                                                             read_FLTR_CTRL_VCM
''                                                             write_FLTR_CTRL_VCM
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_12
    Private write_BYP_BIAS_AMP_value
    Private read_BYP_BIAS_AMP_value
    Private flag_BYP_BIAS_AMP
    Private write_FLTR_CTRL_VOL_value
    Private read_FLTR_CTRL_VOL_value
    Private flag_FLTR_CTRL_VOL
    Private write_FLTR_CTRL_CUR_value
    Private read_FLTR_CTRL_CUR_value
    Private flag_FLTR_CTRL_CUR
    Private write_CMFB_CUR_CTRL_value
    Private read_CMFB_CUR_CTRL_value
    Private flag_CMFB_CUR_CTRL
    Private write_FLTR_CTRL_IBCUR_value
    Private read_FLTR_CTRL_IBCUR_value
    Private flag_FLTR_CTRL_IBCUR
    Private write_FLTR_CTRL_OBCUR_value
    Private read_FLTR_CTRL_OBCUR_value
    Private flag_FLTR_CTRL_OBCUR
    Private write_FLTR_CTRL_RESPD_value
    Private read_FLTR_CTRL_RESPD_value
    Private flag_FLTR_CTRL_RESPD
    Private write_BIAS_AMP_VNCAS_value
    Private read_BIAS_AMP_VNCAS_value
    Private flag_BIAS_AMP_VNCAS
    Private write_CMFB_AMP_VNCAS_value
    Private read_CMFB_AMP_VNCAS_value
    Private flag_CMFB_AMP_VNCAS
    Private write_FLTR_CTRL_VCM_value
    Private read_FLTR_CTRL_VCM_value
    Private flag_FLTR_CTRL_VCM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BYP_BIAS_AMP
        get_BYP_BIAS_AMP = read_BYP_BIAS_AMP_value
    End Property

    Property Let set_BYP_BIAS_AMP(aData)
        write_BYP_BIAS_AMP_value = aData
        flag_BYP_BIAS_AMP        = &H1
    End Property

    Property Get read_BYP_BIAS_AMP
        read
        read_BYP_BIAS_AMP = read_BYP_BIAS_AMP_value
    End Property

    Property Let write_BYP_BIAS_AMP(aData)
        set_BYP_BIAS_AMP = aData
        write
    End Property

    Property Get get_FLTR_CTRL_VOL
        get_FLTR_CTRL_VOL = read_FLTR_CTRL_VOL_value
    End Property

    Property Let set_FLTR_CTRL_VOL(aData)
        write_FLTR_CTRL_VOL_value = aData
        flag_FLTR_CTRL_VOL        = &H1
    End Property

    Property Get read_FLTR_CTRL_VOL
        read
        read_FLTR_CTRL_VOL = read_FLTR_CTRL_VOL_value
    End Property

    Property Let write_FLTR_CTRL_VOL(aData)
        set_FLTR_CTRL_VOL = aData
        write
    End Property

    Property Get get_FLTR_CTRL_CUR
        get_FLTR_CTRL_CUR = read_FLTR_CTRL_CUR_value
    End Property

    Property Let set_FLTR_CTRL_CUR(aData)
        write_FLTR_CTRL_CUR_value = aData
        flag_FLTR_CTRL_CUR        = &H1
    End Property

    Property Get read_FLTR_CTRL_CUR
        read
        read_FLTR_CTRL_CUR = read_FLTR_CTRL_CUR_value
    End Property

    Property Let write_FLTR_CTRL_CUR(aData)
        set_FLTR_CTRL_CUR = aData
        write
    End Property

    Property Get get_CMFB_CUR_CTRL
        get_CMFB_CUR_CTRL = read_CMFB_CUR_CTRL_value
    End Property

    Property Let set_CMFB_CUR_CTRL(aData)
        write_CMFB_CUR_CTRL_value = aData
        flag_CMFB_CUR_CTRL        = &H1
    End Property

    Property Get read_CMFB_CUR_CTRL
        read
        read_CMFB_CUR_CTRL = read_CMFB_CUR_CTRL_value
    End Property

    Property Let write_CMFB_CUR_CTRL(aData)
        set_CMFB_CUR_CTRL = aData
        write
    End Property

    Property Get get_FLTR_CTRL_IBCUR
        get_FLTR_CTRL_IBCUR = read_FLTR_CTRL_IBCUR_value
    End Property

    Property Let set_FLTR_CTRL_IBCUR(aData)
        write_FLTR_CTRL_IBCUR_value = aData
        flag_FLTR_CTRL_IBCUR        = &H1
    End Property

    Property Get read_FLTR_CTRL_IBCUR
        read
        read_FLTR_CTRL_IBCUR = read_FLTR_CTRL_IBCUR_value
    End Property

    Property Let write_FLTR_CTRL_IBCUR(aData)
        set_FLTR_CTRL_IBCUR = aData
        write
    End Property

    Property Get get_FLTR_CTRL_OBCUR
        get_FLTR_CTRL_OBCUR = read_FLTR_CTRL_OBCUR_value
    End Property

    Property Let set_FLTR_CTRL_OBCUR(aData)
        write_FLTR_CTRL_OBCUR_value = aData
        flag_FLTR_CTRL_OBCUR        = &H1
    End Property

    Property Get read_FLTR_CTRL_OBCUR
        read
        read_FLTR_CTRL_OBCUR = read_FLTR_CTRL_OBCUR_value
    End Property

    Property Let write_FLTR_CTRL_OBCUR(aData)
        set_FLTR_CTRL_OBCUR = aData
        write
    End Property

    Property Get get_FLTR_CTRL_RESPD
        get_FLTR_CTRL_RESPD = read_FLTR_CTRL_RESPD_value
    End Property

    Property Let set_FLTR_CTRL_RESPD(aData)
        write_FLTR_CTRL_RESPD_value = aData
        flag_FLTR_CTRL_RESPD        = &H1
    End Property

    Property Get read_FLTR_CTRL_RESPD
        read
        read_FLTR_CTRL_RESPD = read_FLTR_CTRL_RESPD_value
    End Property

    Property Let write_FLTR_CTRL_RESPD(aData)
        set_FLTR_CTRL_RESPD = aData
        write
    End Property

    Property Get get_BIAS_AMP_VNCAS
        get_BIAS_AMP_VNCAS = read_BIAS_AMP_VNCAS_value
    End Property

    Property Let set_BIAS_AMP_VNCAS(aData)
        write_BIAS_AMP_VNCAS_value = aData
        flag_BIAS_AMP_VNCAS        = &H1
    End Property

    Property Get read_BIAS_AMP_VNCAS
        read
        read_BIAS_AMP_VNCAS = read_BIAS_AMP_VNCAS_value
    End Property

    Property Let write_BIAS_AMP_VNCAS(aData)
        set_BIAS_AMP_VNCAS = aData
        write
    End Property

    Property Get get_CMFB_AMP_VNCAS
        get_CMFB_AMP_VNCAS = read_CMFB_AMP_VNCAS_value
    End Property

    Property Let set_CMFB_AMP_VNCAS(aData)
        write_CMFB_AMP_VNCAS_value = aData
        flag_CMFB_AMP_VNCAS        = &H1
    End Property

    Property Get read_CMFB_AMP_VNCAS
        read
        read_CMFB_AMP_VNCAS = read_CMFB_AMP_VNCAS_value
    End Property

    Property Let write_CMFB_AMP_VNCAS(aData)
        set_CMFB_AMP_VNCAS = aData
        write
    End Property

    Property Get get_FLTR_CTRL_VCM
        get_FLTR_CTRL_VCM = read_FLTR_CTRL_VCM_value
    End Property

    Property Let set_FLTR_CTRL_VCM(aData)
        write_FLTR_CTRL_VCM_value = aData
        flag_FLTR_CTRL_VCM        = &H1
    End Property

    Property Get read_FLTR_CTRL_VCM
        read
        read_FLTR_CTRL_VCM = read_FLTR_CTRL_VCM_value
    End Property

    Property Let write_FLTR_CTRL_VCM(aData)
        set_FLTR_CTRL_VCM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BYP_BIAS_AMP_value = rightShift(data_low, 15) and &H1
        read_FLTR_CTRL_VOL_value = rightShift(data_low, 13) and &H3
        read_FLTR_CTRL_CUR_value = rightShift(data_low, 12) and &H1
        read_CMFB_CUR_CTRL_value = rightShift(data_low, 10) and &H3
        read_FLTR_CTRL_IBCUR_value = rightShift(data_low, 9) and &H1
        read_FLTR_CTRL_OBCUR_value = rightShift(data_low, 8) and &H1
        read_FLTR_CTRL_RESPD_value = rightShift(data_low, 6) and &H3
        read_BIAS_AMP_VNCAS_value = rightShift(data_low, 4) and &H3
        read_CMFB_AMP_VNCAS_value = rightShift(data_low, 2) and &H3
        FLTR_CTRL_VCM_mask = &H3
        if data_low > LONG_MAX then
            if FLTR_CTRL_VCM_mask = mask then
                read_FLTR_CTRL_VCM_value = data_low
            else
                read_FLTR_CTRL_VCM_value = (data_low - H8000_0000) and FLTR_CTRL_VCM_mask
            end If
        else
            read_FLTR_CTRL_VCM_value = data_low and FLTR_CTRL_VCM_mask
        end If

    End Sub

    Sub write
        If flag_BYP_BIAS_AMP = &H0 or flag_FLTR_CTRL_VOL = &H0 or flag_FLTR_CTRL_CUR = &H0 or flag_CMFB_CUR_CTRL = &H0 or flag_FLTR_CTRL_IBCUR = &H0 or flag_FLTR_CTRL_OBCUR = &H0 or flag_FLTR_CTRL_RESPD = &H0 or flag_BIAS_AMP_VNCAS = &H0 or flag_CMFB_AMP_VNCAS = &H0 or flag_FLTR_CTRL_VCM = &H0 Then read
        If flag_BYP_BIAS_AMP = &H0 Then write_BYP_BIAS_AMP_value = get_BYP_BIAS_AMP
        If flag_FLTR_CTRL_VOL = &H0 Then write_FLTR_CTRL_VOL_value = get_FLTR_CTRL_VOL
        If flag_FLTR_CTRL_CUR = &H0 Then write_FLTR_CTRL_CUR_value = get_FLTR_CTRL_CUR
        If flag_CMFB_CUR_CTRL = &H0 Then write_CMFB_CUR_CTRL_value = get_CMFB_CUR_CTRL
        If flag_FLTR_CTRL_IBCUR = &H0 Then write_FLTR_CTRL_IBCUR_value = get_FLTR_CTRL_IBCUR
        If flag_FLTR_CTRL_OBCUR = &H0 Then write_FLTR_CTRL_OBCUR_value = get_FLTR_CTRL_OBCUR
        If flag_FLTR_CTRL_RESPD = &H0 Then write_FLTR_CTRL_RESPD_value = get_FLTR_CTRL_RESPD
        If flag_BIAS_AMP_VNCAS = &H0 Then write_BIAS_AMP_VNCAS_value = get_BIAS_AMP_VNCAS
        If flag_CMFB_AMP_VNCAS = &H0 Then write_CMFB_AMP_VNCAS_value = get_CMFB_AMP_VNCAS
        If flag_FLTR_CTRL_VCM = &H0 Then write_FLTR_CTRL_VCM_value = get_FLTR_CTRL_VCM

        regValue = leftShift((write_BYP_BIAS_AMP_value and &H1), 15) + leftShift((write_FLTR_CTRL_VOL_value and &H3), 13) + leftShift((write_FLTR_CTRL_CUR_value and &H1), 12) + leftShift((write_CMFB_CUR_CTRL_value and &H3), 10) + leftShift((write_FLTR_CTRL_IBCUR_value and &H1), 9) + leftShift((write_FLTR_CTRL_OBCUR_value and &H1), 8) + leftShift((write_FLTR_CTRL_RESPD_value and &H3), 6) + leftShift((write_BIAS_AMP_VNCAS_value and &H3), 4) + leftShift((write_CMFB_AMP_VNCAS_value and &H3), 2) + leftShift((write_FLTR_CTRL_VCM_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BYP_BIAS_AMP_value = rightShift(data_low, 15) and &H1
        read_FLTR_CTRL_VOL_value = rightShift(data_low, 13) and &H3
        read_FLTR_CTRL_CUR_value = rightShift(data_low, 12) and &H1
        read_CMFB_CUR_CTRL_value = rightShift(data_low, 10) and &H3
        read_FLTR_CTRL_IBCUR_value = rightShift(data_low, 9) and &H1
        read_FLTR_CTRL_OBCUR_value = rightShift(data_low, 8) and &H1
        read_FLTR_CTRL_RESPD_value = rightShift(data_low, 6) and &H3
        read_BIAS_AMP_VNCAS_value = rightShift(data_low, 4) and &H3
        read_CMFB_AMP_VNCAS_value = rightShift(data_low, 2) and &H3
        FLTR_CTRL_VCM_mask = &H3
        if data_low > LONG_MAX then
            if FLTR_CTRL_VCM_mask = mask then
                read_FLTR_CTRL_VCM_value = data_low
            else
                read_FLTR_CTRL_VCM_value = (data_low - H8000_0000) and FLTR_CTRL_VCM_mask
            end If
        else
            read_FLTR_CTRL_VCM_value = data_low and FLTR_CTRL_VCM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BYP_BIAS_AMP_value = &H0
        flag_BYP_BIAS_AMP        = &H0
        write_FLTR_CTRL_VOL_value = &H0
        flag_FLTR_CTRL_VOL        = &H0
        write_FLTR_CTRL_CUR_value = &H0
        flag_FLTR_CTRL_CUR        = &H0
        write_CMFB_CUR_CTRL_value = &H0
        flag_CMFB_CUR_CTRL        = &H0
        write_FLTR_CTRL_IBCUR_value = &H0
        flag_FLTR_CTRL_IBCUR        = &H0
        write_FLTR_CTRL_OBCUR_value = &H0
        flag_FLTR_CTRL_OBCUR        = &H0
        write_FLTR_CTRL_RESPD_value = &H0
        flag_FLTR_CTRL_RESPD        = &H0
        write_BIAS_AMP_VNCAS_value = &H0
        flag_BIAS_AMP_VNCAS        = &H0
        write_CMFB_AMP_VNCAS_value = &H0
        flag_CMFB_AMP_VNCAS        = &H0
        write_FLTR_CTRL_VCM_value = &H0
        flag_FLTR_CTRL_VCM        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1505                              [15:5]           get_RESERVED_1505
''                                                             set_RESERVED_1505
''                                                             read_RESERVED_1505
''                                                             write_RESERVED_1505
''---------------------------------------------------------------------------------
'' PGA_CM_MASK                                [4:4]            get_PGA_CM_MASK
''                                                             set_PGA_CM_MASK
''                                                             read_PGA_CM_MASK
''                                                             write_PGA_CM_MASK
''---------------------------------------------------------------------------------
'' PGA_CM_TUNE_LV                             [3:0]            get_PGA_CM_TUNE_LV
''                                                             set_PGA_CM_TUNE_LV
''                                                             read_PGA_CM_TUNE_LV
''                                                             write_PGA_CM_TUNE_LV
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_13
    Private write_RESERVED_1505_value
    Private read_RESERVED_1505_value
    Private flag_RESERVED_1505
    Private write_PGA_CM_MASK_value
    Private read_PGA_CM_MASK_value
    Private flag_PGA_CM_MASK
    Private write_PGA_CM_TUNE_LV_value
    Private read_PGA_CM_TUNE_LV_value
    Private flag_PGA_CM_TUNE_LV

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RESERVED_1505
        get_RESERVED_1505 = read_RESERVED_1505_value
    End Property

    Property Let set_RESERVED_1505(aData)
        write_RESERVED_1505_value = aData
        flag_RESERVED_1505        = &H1
    End Property

    Property Get read_RESERVED_1505
        read
        read_RESERVED_1505 = read_RESERVED_1505_value
    End Property

    Property Let write_RESERVED_1505(aData)
        set_RESERVED_1505 = aData
        write
    End Property

    Property Get get_PGA_CM_MASK
        get_PGA_CM_MASK = read_PGA_CM_MASK_value
    End Property

    Property Let set_PGA_CM_MASK(aData)
        write_PGA_CM_MASK_value = aData
        flag_PGA_CM_MASK        = &H1
    End Property

    Property Get read_PGA_CM_MASK
        read
        read_PGA_CM_MASK = read_PGA_CM_MASK_value
    End Property

    Property Let write_PGA_CM_MASK(aData)
        set_PGA_CM_MASK = aData
        write
    End Property

    Property Get get_PGA_CM_TUNE_LV
        get_PGA_CM_TUNE_LV = read_PGA_CM_TUNE_LV_value
    End Property

    Property Let set_PGA_CM_TUNE_LV(aData)
        write_PGA_CM_TUNE_LV_value = aData
        flag_PGA_CM_TUNE_LV        = &H1
    End Property

    Property Get read_PGA_CM_TUNE_LV
        read
        read_PGA_CM_TUNE_LV = read_PGA_CM_TUNE_LV_value
    End Property

    Property Let write_PGA_CM_TUNE_LV(aData)
        set_PGA_CM_TUNE_LV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1505_value = rightShift(data_low, 5) and &H7ff
        read_PGA_CM_MASK_value = rightShift(data_low, 4) and &H1
        PGA_CM_TUNE_LV_mask = &Hf
        if data_low > LONG_MAX then
            if PGA_CM_TUNE_LV_mask = mask then
                read_PGA_CM_TUNE_LV_value = data_low
            else
                read_PGA_CM_TUNE_LV_value = (data_low - H8000_0000) and PGA_CM_TUNE_LV_mask
            end If
        else
            read_PGA_CM_TUNE_LV_value = data_low and PGA_CM_TUNE_LV_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1505 = &H0 or flag_PGA_CM_MASK = &H0 or flag_PGA_CM_TUNE_LV = &H0 Then read
        If flag_RESERVED_1505 = &H0 Then write_RESERVED_1505_value = get_RESERVED_1505
        If flag_PGA_CM_MASK = &H0 Then write_PGA_CM_MASK_value = get_PGA_CM_MASK
        If flag_PGA_CM_TUNE_LV = &H0 Then write_PGA_CM_TUNE_LV_value = get_PGA_CM_TUNE_LV

        regValue = leftShift((write_RESERVED_1505_value and &H7ff), 5) + leftShift((write_PGA_CM_MASK_value and &H1), 4) + leftShift((write_PGA_CM_TUNE_LV_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1505_value = rightShift(data_low, 5) and &H7ff
        read_PGA_CM_MASK_value = rightShift(data_low, 4) and &H1
        PGA_CM_TUNE_LV_mask = &Hf
        if data_low > LONG_MAX then
            if PGA_CM_TUNE_LV_mask = mask then
                read_PGA_CM_TUNE_LV_value = data_low
            else
                read_PGA_CM_TUNE_LV_value = (data_low - H8000_0000) and PGA_CM_TUNE_LV_mask
            end If
        else
            read_PGA_CM_TUNE_LV_value = data_low and PGA_CM_TUNE_LV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1505_value = &H0
        flag_RESERVED_1505        = &H0
        write_PGA_CM_MASK_value = &H0
        flag_PGA_CM_MASK        = &H0
        write_PGA_CM_TUNE_LV_value = &H0
        flag_PGA_CM_TUNE_LV        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BIAS_CUR_FPGA                              [15:14]          get_BIAS_CUR_FPGA
''                                                             set_BIAS_CUR_FPGA
''                                                             read_BIAS_CUR_FPGA
''                                                             write_BIAS_CUR_FPGA
''---------------------------------------------------------------------------------
'' BIAS_CUR_FLTR                              [13:12]          get_BIAS_CUR_FLTR
''                                                             set_BIAS_CUR_FLTR
''                                                             read_BIAS_CUR_FLTR
''                                                             write_BIAS_CUR_FLTR
''---------------------------------------------------------------------------------
'' BIAS_CUR_RAMP                              [11:10]          get_BIAS_CUR_RAMP
''                                                             set_BIAS_CUR_RAMP
''                                                             read_BIAS_CUR_RAMP
''                                                             write_BIAS_CUR_RAMP
''---------------------------------------------------------------------------------
'' BIAS_CUR_PREAMP                            [9:8]            get_BIAS_CUR_PREAMP
''                                                             set_BIAS_CUR_PREAMP
''                                                             read_BIAS_CUR_PREAMP
''                                                             write_BIAS_CUR_PREAMP
''---------------------------------------------------------------------------------
'' BIAS_CUR_REF_BUF                           [7:6]            get_BIAS_CUR_REF_BUF
''                                                             set_BIAS_CUR_REF_BUF
''                                                             read_BIAS_CUR_REF_BUF
''                                                             write_BIAS_CUR_REF_BUF
''---------------------------------------------------------------------------------
'' BIAS_CUR_RXPI                              [5:4]            get_BIAS_CUR_RXPI
''                                                             set_BIAS_CUR_RXPI
''                                                             read_BIAS_CUR_RXPI
''                                                             write_BIAS_CUR_RXPI
''---------------------------------------------------------------------------------
'' RX_BIAS_PMOS_CUR                           [3:2]            get_RX_BIAS_PMOS_CUR
''                                                             set_RX_BIAS_PMOS_CUR
''                                                             read_RX_BIAS_PMOS_CUR
''                                                             write_RX_BIAS_PMOS_CUR
''---------------------------------------------------------------------------------
'' RX_BIAS_PMOS_CUR2                          [1:0]            get_RX_BIAS_PMOS_CUR2
''                                                             set_RX_BIAS_PMOS_CUR2
''                                                             read_RX_BIAS_PMOS_CUR2
''                                                             write_RX_BIAS_PMOS_CUR2
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_14
    Private write_BIAS_CUR_FPGA_value
    Private read_BIAS_CUR_FPGA_value
    Private flag_BIAS_CUR_FPGA
    Private write_BIAS_CUR_FLTR_value
    Private read_BIAS_CUR_FLTR_value
    Private flag_BIAS_CUR_FLTR
    Private write_BIAS_CUR_RAMP_value
    Private read_BIAS_CUR_RAMP_value
    Private flag_BIAS_CUR_RAMP
    Private write_BIAS_CUR_PREAMP_value
    Private read_BIAS_CUR_PREAMP_value
    Private flag_BIAS_CUR_PREAMP
    Private write_BIAS_CUR_REF_BUF_value
    Private read_BIAS_CUR_REF_BUF_value
    Private flag_BIAS_CUR_REF_BUF
    Private write_BIAS_CUR_RXPI_value
    Private read_BIAS_CUR_RXPI_value
    Private flag_BIAS_CUR_RXPI
    Private write_RX_BIAS_PMOS_CUR_value
    Private read_RX_BIAS_PMOS_CUR_value
    Private flag_RX_BIAS_PMOS_CUR
    Private write_RX_BIAS_PMOS_CUR2_value
    Private read_RX_BIAS_PMOS_CUR2_value
    Private flag_RX_BIAS_PMOS_CUR2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BIAS_CUR_FPGA
        get_BIAS_CUR_FPGA = read_BIAS_CUR_FPGA_value
    End Property

    Property Let set_BIAS_CUR_FPGA(aData)
        write_BIAS_CUR_FPGA_value = aData
        flag_BIAS_CUR_FPGA        = &H1
    End Property

    Property Get read_BIAS_CUR_FPGA
        read
        read_BIAS_CUR_FPGA = read_BIAS_CUR_FPGA_value
    End Property

    Property Let write_BIAS_CUR_FPGA(aData)
        set_BIAS_CUR_FPGA = aData
        write
    End Property

    Property Get get_BIAS_CUR_FLTR
        get_BIAS_CUR_FLTR = read_BIAS_CUR_FLTR_value
    End Property

    Property Let set_BIAS_CUR_FLTR(aData)
        write_BIAS_CUR_FLTR_value = aData
        flag_BIAS_CUR_FLTR        = &H1
    End Property

    Property Get read_BIAS_CUR_FLTR
        read
        read_BIAS_CUR_FLTR = read_BIAS_CUR_FLTR_value
    End Property

    Property Let write_BIAS_CUR_FLTR(aData)
        set_BIAS_CUR_FLTR = aData
        write
    End Property

    Property Get get_BIAS_CUR_RAMP
        get_BIAS_CUR_RAMP = read_BIAS_CUR_RAMP_value
    End Property

    Property Let set_BIAS_CUR_RAMP(aData)
        write_BIAS_CUR_RAMP_value = aData
        flag_BIAS_CUR_RAMP        = &H1
    End Property

    Property Get read_BIAS_CUR_RAMP
        read
        read_BIAS_CUR_RAMP = read_BIAS_CUR_RAMP_value
    End Property

    Property Let write_BIAS_CUR_RAMP(aData)
        set_BIAS_CUR_RAMP = aData
        write
    End Property

    Property Get get_BIAS_CUR_PREAMP
        get_BIAS_CUR_PREAMP = read_BIAS_CUR_PREAMP_value
    End Property

    Property Let set_BIAS_CUR_PREAMP(aData)
        write_BIAS_CUR_PREAMP_value = aData
        flag_BIAS_CUR_PREAMP        = &H1
    End Property

    Property Get read_BIAS_CUR_PREAMP
        read
        read_BIAS_CUR_PREAMP = read_BIAS_CUR_PREAMP_value
    End Property

    Property Let write_BIAS_CUR_PREAMP(aData)
        set_BIAS_CUR_PREAMP = aData
        write
    End Property

    Property Get get_BIAS_CUR_REF_BUF
        get_BIAS_CUR_REF_BUF = read_BIAS_CUR_REF_BUF_value
    End Property

    Property Let set_BIAS_CUR_REF_BUF(aData)
        write_BIAS_CUR_REF_BUF_value = aData
        flag_BIAS_CUR_REF_BUF        = &H1
    End Property

    Property Get read_BIAS_CUR_REF_BUF
        read
        read_BIAS_CUR_REF_BUF = read_BIAS_CUR_REF_BUF_value
    End Property

    Property Let write_BIAS_CUR_REF_BUF(aData)
        set_BIAS_CUR_REF_BUF = aData
        write
    End Property

    Property Get get_BIAS_CUR_RXPI
        get_BIAS_CUR_RXPI = read_BIAS_CUR_RXPI_value
    End Property

    Property Let set_BIAS_CUR_RXPI(aData)
        write_BIAS_CUR_RXPI_value = aData
        flag_BIAS_CUR_RXPI        = &H1
    End Property

    Property Get read_BIAS_CUR_RXPI
        read
        read_BIAS_CUR_RXPI = read_BIAS_CUR_RXPI_value
    End Property

    Property Let write_BIAS_CUR_RXPI(aData)
        set_BIAS_CUR_RXPI = aData
        write
    End Property

    Property Get get_RX_BIAS_PMOS_CUR
        get_RX_BIAS_PMOS_CUR = read_RX_BIAS_PMOS_CUR_value
    End Property

    Property Let set_RX_BIAS_PMOS_CUR(aData)
        write_RX_BIAS_PMOS_CUR_value = aData
        flag_RX_BIAS_PMOS_CUR        = &H1
    End Property

    Property Get read_RX_BIAS_PMOS_CUR
        read
        read_RX_BIAS_PMOS_CUR = read_RX_BIAS_PMOS_CUR_value
    End Property

    Property Let write_RX_BIAS_PMOS_CUR(aData)
        set_RX_BIAS_PMOS_CUR = aData
        write
    End Property

    Property Get get_RX_BIAS_PMOS_CUR2
        get_RX_BIAS_PMOS_CUR2 = read_RX_BIAS_PMOS_CUR2_value
    End Property

    Property Let set_RX_BIAS_PMOS_CUR2(aData)
        write_RX_BIAS_PMOS_CUR2_value = aData
        flag_RX_BIAS_PMOS_CUR2        = &H1
    End Property

    Property Get read_RX_BIAS_PMOS_CUR2
        read
        read_RX_BIAS_PMOS_CUR2 = read_RX_BIAS_PMOS_CUR2_value
    End Property

    Property Let write_RX_BIAS_PMOS_CUR2(aData)
        set_RX_BIAS_PMOS_CUR2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BIAS_CUR_FPGA_value = rightShift(data_low, 14) and &H3
        read_BIAS_CUR_FLTR_value = rightShift(data_low, 12) and &H3
        read_BIAS_CUR_RAMP_value = rightShift(data_low, 10) and &H3
        read_BIAS_CUR_PREAMP_value = rightShift(data_low, 8) and &H3
        read_BIAS_CUR_REF_BUF_value = rightShift(data_low, 6) and &H3
        read_BIAS_CUR_RXPI_value = rightShift(data_low, 4) and &H3
        read_RX_BIAS_PMOS_CUR_value = rightShift(data_low, 2) and &H3
        RX_BIAS_PMOS_CUR2_mask = &H3
        if data_low > LONG_MAX then
            if RX_BIAS_PMOS_CUR2_mask = mask then
                read_RX_BIAS_PMOS_CUR2_value = data_low
            else
                read_RX_BIAS_PMOS_CUR2_value = (data_low - H8000_0000) and RX_BIAS_PMOS_CUR2_mask
            end If
        else
            read_RX_BIAS_PMOS_CUR2_value = data_low and RX_BIAS_PMOS_CUR2_mask
        end If

    End Sub

    Sub write
        If flag_BIAS_CUR_FPGA = &H0 or flag_BIAS_CUR_FLTR = &H0 or flag_BIAS_CUR_RAMP = &H0 or flag_BIAS_CUR_PREAMP = &H0 or flag_BIAS_CUR_REF_BUF = &H0 or flag_BIAS_CUR_RXPI = &H0 or flag_RX_BIAS_PMOS_CUR = &H0 or flag_RX_BIAS_PMOS_CUR2 = &H0 Then read
        If flag_BIAS_CUR_FPGA = &H0 Then write_BIAS_CUR_FPGA_value = get_BIAS_CUR_FPGA
        If flag_BIAS_CUR_FLTR = &H0 Then write_BIAS_CUR_FLTR_value = get_BIAS_CUR_FLTR
        If flag_BIAS_CUR_RAMP = &H0 Then write_BIAS_CUR_RAMP_value = get_BIAS_CUR_RAMP
        If flag_BIAS_CUR_PREAMP = &H0 Then write_BIAS_CUR_PREAMP_value = get_BIAS_CUR_PREAMP
        If flag_BIAS_CUR_REF_BUF = &H0 Then write_BIAS_CUR_REF_BUF_value = get_BIAS_CUR_REF_BUF
        If flag_BIAS_CUR_RXPI = &H0 Then write_BIAS_CUR_RXPI_value = get_BIAS_CUR_RXPI
        If flag_RX_BIAS_PMOS_CUR = &H0 Then write_RX_BIAS_PMOS_CUR_value = get_RX_BIAS_PMOS_CUR
        If flag_RX_BIAS_PMOS_CUR2 = &H0 Then write_RX_BIAS_PMOS_CUR2_value = get_RX_BIAS_PMOS_CUR2

        regValue = leftShift((write_BIAS_CUR_FPGA_value and &H3), 14) + leftShift((write_BIAS_CUR_FLTR_value and &H3), 12) + leftShift((write_BIAS_CUR_RAMP_value and &H3), 10) + leftShift((write_BIAS_CUR_PREAMP_value and &H3), 8) + leftShift((write_BIAS_CUR_REF_BUF_value and &H3), 6) + leftShift((write_BIAS_CUR_RXPI_value and &H3), 4) + leftShift((write_RX_BIAS_PMOS_CUR_value and &H3), 2) + leftShift((write_RX_BIAS_PMOS_CUR2_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BIAS_CUR_FPGA_value = rightShift(data_low, 14) and &H3
        read_BIAS_CUR_FLTR_value = rightShift(data_low, 12) and &H3
        read_BIAS_CUR_RAMP_value = rightShift(data_low, 10) and &H3
        read_BIAS_CUR_PREAMP_value = rightShift(data_low, 8) and &H3
        read_BIAS_CUR_REF_BUF_value = rightShift(data_low, 6) and &H3
        read_BIAS_CUR_RXPI_value = rightShift(data_low, 4) and &H3
        read_RX_BIAS_PMOS_CUR_value = rightShift(data_low, 2) and &H3
        RX_BIAS_PMOS_CUR2_mask = &H3
        if data_low > LONG_MAX then
            if RX_BIAS_PMOS_CUR2_mask = mask then
                read_RX_BIAS_PMOS_CUR2_value = data_low
            else
                read_RX_BIAS_PMOS_CUR2_value = (data_low - H8000_0000) and RX_BIAS_PMOS_CUR2_mask
            end If
        else
            read_RX_BIAS_PMOS_CUR2_value = data_low and RX_BIAS_PMOS_CUR2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BIAS_CUR_FPGA_value = &H0
        flag_BIAS_CUR_FPGA        = &H0
        write_BIAS_CUR_FLTR_value = &H0
        flag_BIAS_CUR_FLTR        = &H0
        write_BIAS_CUR_RAMP_value = &H0
        flag_BIAS_CUR_RAMP        = &H0
        write_BIAS_CUR_PREAMP_value = &H0
        flag_BIAS_CUR_PREAMP        = &H0
        write_BIAS_CUR_REF_BUF_value = &H0
        flag_BIAS_CUR_REF_BUF        = &H0
        write_BIAS_CUR_RXPI_value = &H0
        flag_BIAS_CUR_RXPI        = &H0
        write_RX_BIAS_PMOS_CUR_value = &H0
        flag_RX_BIAS_PMOS_CUR        = &H0
        write_RX_BIAS_PMOS_CUR2_value = &H0
        flag_RX_BIAS_PMOS_CUR2        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_rx_cfg_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1506                              [15:6]           get_RESERVED_1506
''                                                             set_RESERVED_1506
''                                                             read_RESERVED_1506
''                                                             write_RESERVED_1506
''---------------------------------------------------------------------------------
'' BIAS_CUR_DIODE_100M                        [5:4]            get_BIAS_CUR_DIODE_100M
''                                                             set_BIAS_CUR_DIODE_100M
''                                                             read_BIAS_CUR_DIODE_100M
''                                                             write_BIAS_CUR_DIODE_100M
''---------------------------------------------------------------------------------
'' BIAS_CUR_CASCODE_100M                      [3:2]            get_BIAS_CUR_CASCODE_100M
''                                                             set_BIAS_CUR_CASCODE_100M
''                                                             read_BIAS_CUR_CASCODE_100M
''                                                             write_BIAS_CUR_CASCODE_100M
''---------------------------------------------------------------------------------
'' BIAS_CUR_CAL_BUF_100M                      [1:0]            get_BIAS_CUR_CAL_BUF_100M
''                                                             set_BIAS_CUR_CAL_BUF_100M
''                                                             read_BIAS_CUR_CAL_BUF_100M
''                                                             write_BIAS_CUR_CAL_BUF_100M
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_rx_cfg_15
    Private write_RESERVED_1506_value
    Private read_RESERVED_1506_value
    Private flag_RESERVED_1506
    Private write_BIAS_CUR_DIODE_100M_value
    Private read_BIAS_CUR_DIODE_100M_value
    Private flag_BIAS_CUR_DIODE_100M
    Private write_BIAS_CUR_CASCODE_100M_value
    Private read_BIAS_CUR_CASCODE_100M_value
    Private flag_BIAS_CUR_CASCODE_100M
    Private write_BIAS_CUR_CAL_BUF_100M_value
    Private read_BIAS_CUR_CAL_BUF_100M_value
    Private flag_BIAS_CUR_CAL_BUF_100M

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H38
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RESERVED_1506
        get_RESERVED_1506 = read_RESERVED_1506_value
    End Property

    Property Let set_RESERVED_1506(aData)
        write_RESERVED_1506_value = aData
        flag_RESERVED_1506        = &H1
    End Property

    Property Get read_RESERVED_1506
        read
        read_RESERVED_1506 = read_RESERVED_1506_value
    End Property

    Property Let write_RESERVED_1506(aData)
        set_RESERVED_1506 = aData
        write
    End Property

    Property Get get_BIAS_CUR_DIODE_100M
        get_BIAS_CUR_DIODE_100M = read_BIAS_CUR_DIODE_100M_value
    End Property

    Property Let set_BIAS_CUR_DIODE_100M(aData)
        write_BIAS_CUR_DIODE_100M_value = aData
        flag_BIAS_CUR_DIODE_100M        = &H1
    End Property

    Property Get read_BIAS_CUR_DIODE_100M
        read
        read_BIAS_CUR_DIODE_100M = read_BIAS_CUR_DIODE_100M_value
    End Property

    Property Let write_BIAS_CUR_DIODE_100M(aData)
        set_BIAS_CUR_DIODE_100M = aData
        write
    End Property

    Property Get get_BIAS_CUR_CASCODE_100M
        get_BIAS_CUR_CASCODE_100M = read_BIAS_CUR_CASCODE_100M_value
    End Property

    Property Let set_BIAS_CUR_CASCODE_100M(aData)
        write_BIAS_CUR_CASCODE_100M_value = aData
        flag_BIAS_CUR_CASCODE_100M        = &H1
    End Property

    Property Get read_BIAS_CUR_CASCODE_100M
        read
        read_BIAS_CUR_CASCODE_100M = read_BIAS_CUR_CASCODE_100M_value
    End Property

    Property Let write_BIAS_CUR_CASCODE_100M(aData)
        set_BIAS_CUR_CASCODE_100M = aData
        write
    End Property

    Property Get get_BIAS_CUR_CAL_BUF_100M
        get_BIAS_CUR_CAL_BUF_100M = read_BIAS_CUR_CAL_BUF_100M_value
    End Property

    Property Let set_BIAS_CUR_CAL_BUF_100M(aData)
        write_BIAS_CUR_CAL_BUF_100M_value = aData
        flag_BIAS_CUR_CAL_BUF_100M        = &H1
    End Property

    Property Get read_BIAS_CUR_CAL_BUF_100M
        read
        read_BIAS_CUR_CAL_BUF_100M = read_BIAS_CUR_CAL_BUF_100M_value
    End Property

    Property Let write_BIAS_CUR_CAL_BUF_100M(aData)
        set_BIAS_CUR_CAL_BUF_100M = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1506_value = rightShift(data_low, 6) and &H3ff
        read_BIAS_CUR_DIODE_100M_value = rightShift(data_low, 4) and &H3
        read_BIAS_CUR_CASCODE_100M_value = rightShift(data_low, 2) and &H3
        BIAS_CUR_CAL_BUF_100M_mask = &H3
        if data_low > LONG_MAX then
            if BIAS_CUR_CAL_BUF_100M_mask = mask then
                read_BIAS_CUR_CAL_BUF_100M_value = data_low
            else
                read_BIAS_CUR_CAL_BUF_100M_value = (data_low - H8000_0000) and BIAS_CUR_CAL_BUF_100M_mask
            end If
        else
            read_BIAS_CUR_CAL_BUF_100M_value = data_low and BIAS_CUR_CAL_BUF_100M_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1506 = &H0 or flag_BIAS_CUR_DIODE_100M = &H0 or flag_BIAS_CUR_CASCODE_100M = &H0 or flag_BIAS_CUR_CAL_BUF_100M = &H0 Then read
        If flag_RESERVED_1506 = &H0 Then write_RESERVED_1506_value = get_RESERVED_1506
        If flag_BIAS_CUR_DIODE_100M = &H0 Then write_BIAS_CUR_DIODE_100M_value = get_BIAS_CUR_DIODE_100M
        If flag_BIAS_CUR_CASCODE_100M = &H0 Then write_BIAS_CUR_CASCODE_100M_value = get_BIAS_CUR_CASCODE_100M
        If flag_BIAS_CUR_CAL_BUF_100M = &H0 Then write_BIAS_CUR_CAL_BUF_100M_value = get_BIAS_CUR_CAL_BUF_100M

        regValue = leftShift((write_RESERVED_1506_value and &H3ff), 6) + leftShift((write_BIAS_CUR_DIODE_100M_value and &H3), 4) + leftShift((write_BIAS_CUR_CASCODE_100M_value and &H3), 2) + leftShift((write_BIAS_CUR_CAL_BUF_100M_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1506_value = rightShift(data_low, 6) and &H3ff
        read_BIAS_CUR_DIODE_100M_value = rightShift(data_low, 4) and &H3
        read_BIAS_CUR_CASCODE_100M_value = rightShift(data_low, 2) and &H3
        BIAS_CUR_CAL_BUF_100M_mask = &H3
        if data_low > LONG_MAX then
            if BIAS_CUR_CAL_BUF_100M_mask = mask then
                read_BIAS_CUR_CAL_BUF_100M_value = data_low
            else
                read_BIAS_CUR_CAL_BUF_100M_value = (data_low - H8000_0000) and BIAS_CUR_CAL_BUF_100M_mask
            end If
        else
            read_BIAS_CUR_CAL_BUF_100M_value = data_low and BIAS_CUR_CAL_BUF_100M_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1506_value = &H0
        flag_RESERVED_1506        = &H0
        write_BIAS_CUR_DIODE_100M_value = &H0
        flag_BIAS_CUR_DIODE_100M        = &H0
        write_BIAS_CUR_CASCODE_100M_value = &H0
        flag_BIAS_CUR_CASCODE_100M        = &H0
        write_BIAS_CUR_CAL_BUF_100M_value = &H0
        flag_BIAS_CUR_CAL_BUF_100M        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_acb_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ACB_RESET                                  [15:15]          get_ACB_RESET
''                                                             set_ACB_RESET
''                                                             read_ACB_RESET
''                                                             write_ACB_RESET
''---------------------------------------------------------------------------------
'' ACB_STROBE                                 [14:14]          get_ACB_STROBE
''                                                             set_ACB_STROBE
''                                                             read_ACB_STROBE
''                                                             write_ACB_STROBE
''---------------------------------------------------------------------------------
'' RESERVED_1311                              [13:11]          get_RESERVED_1311
''                                                             set_RESERVED_1311
''                                                             read_RESERVED_1311
''                                                             write_RESERVED_1311
''---------------------------------------------------------------------------------
'' ACB_ADDRESS                                [10:0]           get_ACB_ADDRESS
''                                                             set_ACB_ADDRESS
''                                                             read_ACB_ADDRESS
''                                                             write_ACB_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_acb_ctrl
    Private write_ACB_RESET_value
    Private read_ACB_RESET_value
    Private flag_ACB_RESET
    Private write_ACB_STROBE_value
    Private read_ACB_STROBE_value
    Private flag_ACB_STROBE
    Private write_RESERVED_1311_value
    Private read_RESERVED_1311_value
    Private flag_RESERVED_1311
    Private write_ACB_ADDRESS_value
    Private read_ACB_ADDRESS_value
    Private flag_ACB_ADDRESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ACB_RESET
        get_ACB_RESET = read_ACB_RESET_value
    End Property

    Property Let set_ACB_RESET(aData)
        write_ACB_RESET_value = aData
        flag_ACB_RESET        = &H1
    End Property

    Property Get read_ACB_RESET
        read
        read_ACB_RESET = read_ACB_RESET_value
    End Property

    Property Let write_ACB_RESET(aData)
        set_ACB_RESET = aData
        write
    End Property

    Property Get get_ACB_STROBE
        get_ACB_STROBE = read_ACB_STROBE_value
    End Property

    Property Let set_ACB_STROBE(aData)
        write_ACB_STROBE_value = aData
        flag_ACB_STROBE        = &H1
    End Property

    Property Get read_ACB_STROBE
        read
        read_ACB_STROBE = read_ACB_STROBE_value
    End Property

    Property Let write_ACB_STROBE(aData)
        set_ACB_STROBE = aData
        write
    End Property

    Property Get get_RESERVED_1311
        get_RESERVED_1311 = read_RESERVED_1311_value
    End Property

    Property Let set_RESERVED_1311(aData)
        write_RESERVED_1311_value = aData
        flag_RESERVED_1311        = &H1
    End Property

    Property Get read_RESERVED_1311
        read
        read_RESERVED_1311 = read_RESERVED_1311_value
    End Property

    Property Let write_RESERVED_1311(aData)
        set_RESERVED_1311 = aData
        write
    End Property

    Property Get get_ACB_ADDRESS
        get_ACB_ADDRESS = read_ACB_ADDRESS_value
    End Property

    Property Let set_ACB_ADDRESS(aData)
        write_ACB_ADDRESS_value = aData
        flag_ACB_ADDRESS        = &H1
    End Property

    Property Get read_ACB_ADDRESS
        read
        read_ACB_ADDRESS = read_ACB_ADDRESS_value
    End Property

    Property Let write_ACB_ADDRESS(aData)
        set_ACB_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ACB_RESET_value = rightShift(data_low, 15) and &H1
        read_ACB_STROBE_value = rightShift(data_low, 14) and &H1
        read_RESERVED_1311_value = rightShift(data_low, 11) and &H7
        ACB_ADDRESS_mask = &H7ff
        if data_low > LONG_MAX then
            if ACB_ADDRESS_mask = mask then
                read_ACB_ADDRESS_value = data_low
            else
                read_ACB_ADDRESS_value = (data_low - H8000_0000) and ACB_ADDRESS_mask
            end If
        else
            read_ACB_ADDRESS_value = data_low and ACB_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_ACB_RESET = &H0 or flag_ACB_STROBE = &H0 or flag_RESERVED_1311 = &H0 or flag_ACB_ADDRESS = &H0 Then read
        If flag_ACB_RESET = &H0 Then write_ACB_RESET_value = get_ACB_RESET
        If flag_ACB_STROBE = &H0 Then write_ACB_STROBE_value = get_ACB_STROBE
        If flag_RESERVED_1311 = &H0 Then write_RESERVED_1311_value = get_RESERVED_1311
        If flag_ACB_ADDRESS = &H0 Then write_ACB_ADDRESS_value = get_ACB_ADDRESS

        regValue = leftShift((write_ACB_RESET_value and &H1), 15) + leftShift((write_ACB_STROBE_value and &H1), 14) + leftShift((write_RESERVED_1311_value and &H7), 11) + leftShift((write_ACB_ADDRESS_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ACB_RESET_value = rightShift(data_low, 15) and &H1
        read_ACB_STROBE_value = rightShift(data_low, 14) and &H1
        read_RESERVED_1311_value = rightShift(data_low, 11) and &H7
        ACB_ADDRESS_mask = &H7ff
        if data_low > LONG_MAX then
            if ACB_ADDRESS_mask = mask then
                read_ACB_ADDRESS_value = data_low
            else
                read_ACB_ADDRESS_value = (data_low - H8000_0000) and ACB_ADDRESS_mask
            end If
        else
            read_ACB_ADDRESS_value = data_low and ACB_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ACB_RESET_value = &H0
        flag_ACB_RESET        = &H0
        write_ACB_STROBE_value = &H0
        flag_ACB_STROBE        = &H0
        write_RESERVED_1311_value = &H0
        flag_RESERVED_1311        = &H0
        write_ACB_ADDRESS_value = &H0
        flag_ACB_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_acb_wrdata
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ACB_WRDATA                                 [15:0]           get_ACB_WRDATA
''                                                             set_ACB_WRDATA
''                                                             read_ACB_WRDATA
''                                                             write_ACB_WRDATA
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_acb_wrdata
    Private write_ACB_WRDATA_value
    Private read_ACB_WRDATA_value
    Private flag_ACB_WRDATA

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

    Property Get get_ACB_WRDATA
        get_ACB_WRDATA = read_ACB_WRDATA_value
    End Property

    Property Let set_ACB_WRDATA(aData)
        write_ACB_WRDATA_value = aData
        flag_ACB_WRDATA        = &H1
    End Property

    Property Get read_ACB_WRDATA
        read
        read_ACB_WRDATA = read_ACB_WRDATA_value
    End Property

    Property Let write_ACB_WRDATA(aData)
        set_ACB_WRDATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ACB_WRDATA_mask = &Hffff
        if data_low > LONG_MAX then
            if ACB_WRDATA_mask = mask then
                read_ACB_WRDATA_value = data_low
            else
                read_ACB_WRDATA_value = (data_low - H8000_0000) and ACB_WRDATA_mask
            end If
        else
            read_ACB_WRDATA_value = data_low and ACB_WRDATA_mask
        end If

    End Sub

    Sub write
        If flag_ACB_WRDATA = &H0 Then read
        If flag_ACB_WRDATA = &H0 Then write_ACB_WRDATA_value = get_ACB_WRDATA

        regValue = leftShift((write_ACB_WRDATA_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ACB_WRDATA_mask = &Hffff
        if data_low > LONG_MAX then
            if ACB_WRDATA_mask = mask then
                read_ACB_WRDATA_value = data_low
            else
                read_ACB_WRDATA_value = (data_low - H8000_0000) and ACB_WRDATA_mask
            end If
        else
            read_ACB_WRDATA_value = data_low and ACB_WRDATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ACB_WRDATA_value = &H0
        flag_ACB_WRDATA        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_acb_rddata
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ACB_RDDATA                                 [15:0]           get_ACB_RDDATA
''                                                             set_ACB_RDDATA
''                                                             read_ACB_RDDATA
''                                                             write_ACB_RDDATA
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_acb_rddata
    Private write_ACB_RDDATA_value
    Private read_ACB_RDDATA_value
    Private flag_ACB_RDDATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ACB_RDDATA
        get_ACB_RDDATA = read_ACB_RDDATA_value
    End Property

    Property Let set_ACB_RDDATA(aData)
        write_ACB_RDDATA_value = aData
        flag_ACB_RDDATA        = &H1
    End Property

    Property Get read_ACB_RDDATA
        read
        read_ACB_RDDATA = read_ACB_RDDATA_value
    End Property

    Property Let write_ACB_RDDATA(aData)
        set_ACB_RDDATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ACB_RDDATA_mask = &Hffff
        if data_low > LONG_MAX then
            if ACB_RDDATA_mask = mask then
                read_ACB_RDDATA_value = data_low
            else
                read_ACB_RDDATA_value = (data_low - H8000_0000) and ACB_RDDATA_mask
            end If
        else
            read_ACB_RDDATA_value = data_low and ACB_RDDATA_mask
        end If

    End Sub

    Sub write
        If flag_ACB_RDDATA = &H0 Then read
        If flag_ACB_RDDATA = &H0 Then write_ACB_RDDATA_value = get_ACB_RDDATA

        regValue = leftShift((write_ACB_RDDATA_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ACB_RDDATA_mask = &Hffff
        if data_low > LONG_MAX then
            if ACB_RDDATA_mask = mask then
                read_ACB_RDDATA_value = data_low
            else
                read_ACB_RDDATA_value = (data_low - H8000_0000) and ACB_RDDATA_mask
            end If
        else
            read_ACB_RDDATA_value = data_low and ACB_RDDATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ACB_RDDATA_value = &H0
        flag_ACB_RDDATA        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_pll_cfg_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VALUE                                      [15:0]           get_VALUE
''                                                             set_VALUE
''                                                             read_VALUE
''                                                             write_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_pll_cfg_0
    Private write_VALUE_value
    Private read_VALUE_value
    Private flag_VALUE

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

    Property Get get_VALUE
        get_VALUE = read_VALUE_value
    End Property

    Property Let set_VALUE(aData)
        write_VALUE_value = aData
        flag_VALUE        = &H1
    End Property

    Property Get read_VALUE
        read
        read_VALUE = read_VALUE_value
    End Property

    Property Let write_VALUE(aData)
        set_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

    End Sub

    Sub write
        If flag_VALUE = &H0 Then read
        If flag_VALUE = &H0 Then write_VALUE_value = get_VALUE

        regValue = leftShift((write_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VALUE_value = &H0
        flag_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_pll_cfg_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VALUE                                      [15:0]           get_VALUE
''                                                             set_VALUE
''                                                             read_VALUE
''                                                             write_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_pll_cfg_1
    Private write_VALUE_value
    Private read_VALUE_value
    Private flag_VALUE

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

    Property Get get_VALUE
        get_VALUE = read_VALUE_value
    End Property

    Property Let set_VALUE(aData)
        write_VALUE_value = aData
        flag_VALUE        = &H1
    End Property

    Property Get read_VALUE
        read
        read_VALUE = read_VALUE_value
    End Property

    Property Let write_VALUE(aData)
        set_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

    End Sub

    Sub write
        If flag_VALUE = &H0 Then read
        If flag_VALUE = &H0 Then write_VALUE_value = get_VALUE

        regValue = leftShift((write_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VALUE_value = &H0
        flag_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_pll_cfg_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VALUE                                      [15:0]           get_VALUE
''                                                             set_VALUE
''                                                             read_VALUE
''                                                             write_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_pll_cfg_2
    Private write_VALUE_value
    Private read_VALUE_value
    Private flag_VALUE

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

    Property Get get_VALUE
        get_VALUE = read_VALUE_value
    End Property

    Property Let set_VALUE(aData)
        write_VALUE_value = aData
        flag_VALUE        = &H1
    End Property

    Property Get read_VALUE
        read
        read_VALUE = read_VALUE_value
    End Property

    Property Let write_VALUE(aData)
        set_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

    End Sub

    Sub write
        If flag_VALUE = &H0 Then read
        If flag_VALUE = &H0 Then write_VALUE_value = get_VALUE

        regValue = leftShift((write_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VALUE_value = &H0
        flag_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_pll_cfg_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VALUE                                      [15:0]           get_VALUE
''                                                             set_VALUE
''                                                             read_VALUE
''                                                             write_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_pll_cfg_3
    Private write_VALUE_value
    Private read_VALUE_value
    Private flag_VALUE

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

    Property Get get_VALUE
        get_VALUE = read_VALUE_value
    End Property

    Property Let set_VALUE(aData)
        write_VALUE_value = aData
        flag_VALUE        = &H1
    End Property

    Property Get read_VALUE
        read
        read_VALUE = read_VALUE_value
    End Property

    Property Let write_VALUE(aData)
        set_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

    End Sub

    Sub write
        If flag_VALUE = &H0 Then read
        If flag_VALUE = &H0 Then write_VALUE_value = get_VALUE

        regValue = leftShift((write_VALUE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VALUE_mask = &Hffff
        if data_low > LONG_MAX then
            if VALUE_mask = mask then
                read_VALUE_value = data_low
            else
                read_VALUE_value = (data_low - H8000_0000) and VALUE_mask
            end If
        else
            read_VALUE_value = data_low and VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VALUE_value = &H0
        flag_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_pll_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1510                              [15:10]          get_RESERVED_1510
''                                                             set_RESERVED_1510
''                                                             read_RESERVED_1510
''                                                             write_RESERVED_1510
''---------------------------------------------------------------------------------
'' CMOS_REFCLK_EN_OV                          [9:9]            get_CMOS_REFCLK_EN_OV
''                                                             set_CMOS_REFCLK_EN_OV
''                                                             read_CMOS_REFCLK_EN_OV
''                                                             write_CMOS_REFCLK_EN_OV
''---------------------------------------------------------------------------------
'' CMOS_REFCLK_EN                             [8:8]            get_CMOS_REFCLK_EN
''                                                             set_CMOS_REFCLK_EN
''                                                             read_CMOS_REFCLK_EN
''                                                             write_CMOS_REFCLK_EN
''---------------------------------------------------------------------------------
'' CLK_RSTB_OV                                [7:7]            get_CLK_RSTB_OV
''                                                             set_CLK_RSTB_OV
''                                                             read_CLK_RSTB_OV
''                                                             write_CLK_RSTB_OV
''---------------------------------------------------------------------------------
'' CLK_RESET                                  [6:6]            get_CLK_RESET
''                                                             set_CLK_RESET
''                                                             read_CLK_RESET
''                                                             write_CLK_RESET
''---------------------------------------------------------------------------------
'' PLL_POWER_ON_OV                            [5:5]            get_PLL_POWER_ON_OV
''                                                             set_PLL_POWER_ON_OV
''                                                             read_PLL_POWER_ON_OV
''                                                             write_PLL_POWER_ON_OV
''---------------------------------------------------------------------------------
'' PLL_POWER_ON                               [4:4]            get_PLL_POWER_ON
''                                                             set_PLL_POWER_ON
''                                                             read_PLL_POWER_ON
''                                                             write_PLL_POWER_ON
''---------------------------------------------------------------------------------
'' PLL_RESETB_OV                              [3:3]            get_PLL_RESETB_OV
''                                                             set_PLL_RESETB_OV
''                                                             read_PLL_RESETB_OV
''                                                             write_PLL_RESETB_OV
''---------------------------------------------------------------------------------
'' PLL_RESETB                                 [2:2]            get_PLL_RESETB
''                                                             set_PLL_RESETB
''                                                             read_PLL_RESETB
''                                                             write_PLL_RESETB
''---------------------------------------------------------------------------------
'' PLL_TEST_EN                                [1:1]            get_PLL_TEST_EN
''                                                             set_PLL_TEST_EN
''                                                             read_PLL_TEST_EN
''                                                             write_PLL_TEST_EN
''---------------------------------------------------------------------------------
'' PLLBYP                                     [0:0]            get_PLLBYP
''                                                             set_PLLBYP
''                                                             read_PLLBYP
''                                                             write_PLLBYP
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_pll_ctrl
    Private write_RESERVED_1510_value
    Private read_RESERVED_1510_value
    Private flag_RESERVED_1510
    Private write_CMOS_REFCLK_EN_OV_value
    Private read_CMOS_REFCLK_EN_OV_value
    Private flag_CMOS_REFCLK_EN_OV
    Private write_CMOS_REFCLK_EN_value
    Private read_CMOS_REFCLK_EN_value
    Private flag_CMOS_REFCLK_EN
    Private write_CLK_RSTB_OV_value
    Private read_CLK_RSTB_OV_value
    Private flag_CLK_RSTB_OV
    Private write_CLK_RESET_value
    Private read_CLK_RESET_value
    Private flag_CLK_RESET
    Private write_PLL_POWER_ON_OV_value
    Private read_PLL_POWER_ON_OV_value
    Private flag_PLL_POWER_ON_OV
    Private write_PLL_POWER_ON_value
    Private read_PLL_POWER_ON_value
    Private flag_PLL_POWER_ON
    Private write_PLL_RESETB_OV_value
    Private read_PLL_RESETB_OV_value
    Private flag_PLL_RESETB_OV
    Private write_PLL_RESETB_value
    Private read_PLL_RESETB_value
    Private flag_PLL_RESETB
    Private write_PLL_TEST_EN_value
    Private read_PLL_TEST_EN_value
    Private flag_PLL_TEST_EN
    Private write_PLLBYP_value
    Private read_PLLBYP_value
    Private flag_PLLBYP

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

    Property Get get_RESERVED_1510
        get_RESERVED_1510 = read_RESERVED_1510_value
    End Property

    Property Let set_RESERVED_1510(aData)
        write_RESERVED_1510_value = aData
        flag_RESERVED_1510        = &H1
    End Property

    Property Get read_RESERVED_1510
        read
        read_RESERVED_1510 = read_RESERVED_1510_value
    End Property

    Property Let write_RESERVED_1510(aData)
        set_RESERVED_1510 = aData
        write
    End Property

    Property Get get_CMOS_REFCLK_EN_OV
        get_CMOS_REFCLK_EN_OV = read_CMOS_REFCLK_EN_OV_value
    End Property

    Property Let set_CMOS_REFCLK_EN_OV(aData)
        write_CMOS_REFCLK_EN_OV_value = aData
        flag_CMOS_REFCLK_EN_OV        = &H1
    End Property

    Property Get read_CMOS_REFCLK_EN_OV
        read
        read_CMOS_REFCLK_EN_OV = read_CMOS_REFCLK_EN_OV_value
    End Property

    Property Let write_CMOS_REFCLK_EN_OV(aData)
        set_CMOS_REFCLK_EN_OV = aData
        write
    End Property

    Property Get get_CMOS_REFCLK_EN
        get_CMOS_REFCLK_EN = read_CMOS_REFCLK_EN_value
    End Property

    Property Let set_CMOS_REFCLK_EN(aData)
        write_CMOS_REFCLK_EN_value = aData
        flag_CMOS_REFCLK_EN        = &H1
    End Property

    Property Get read_CMOS_REFCLK_EN
        read
        read_CMOS_REFCLK_EN = read_CMOS_REFCLK_EN_value
    End Property

    Property Let write_CMOS_REFCLK_EN(aData)
        set_CMOS_REFCLK_EN = aData
        write
    End Property

    Property Get get_CLK_RSTB_OV
        get_CLK_RSTB_OV = read_CLK_RSTB_OV_value
    End Property

    Property Let set_CLK_RSTB_OV(aData)
        write_CLK_RSTB_OV_value = aData
        flag_CLK_RSTB_OV        = &H1
    End Property

    Property Get read_CLK_RSTB_OV
        read
        read_CLK_RSTB_OV = read_CLK_RSTB_OV_value
    End Property

    Property Let write_CLK_RSTB_OV(aData)
        set_CLK_RSTB_OV = aData
        write
    End Property

    Property Get get_CLK_RESET
        get_CLK_RESET = read_CLK_RESET_value
    End Property

    Property Let set_CLK_RESET(aData)
        write_CLK_RESET_value = aData
        flag_CLK_RESET        = &H1
    End Property

    Property Get read_CLK_RESET
        read
        read_CLK_RESET = read_CLK_RESET_value
    End Property

    Property Let write_CLK_RESET(aData)
        set_CLK_RESET = aData
        write
    End Property

    Property Get get_PLL_POWER_ON_OV
        get_PLL_POWER_ON_OV = read_PLL_POWER_ON_OV_value
    End Property

    Property Let set_PLL_POWER_ON_OV(aData)
        write_PLL_POWER_ON_OV_value = aData
        flag_PLL_POWER_ON_OV        = &H1
    End Property

    Property Get read_PLL_POWER_ON_OV
        read
        read_PLL_POWER_ON_OV = read_PLL_POWER_ON_OV_value
    End Property

    Property Let write_PLL_POWER_ON_OV(aData)
        set_PLL_POWER_ON_OV = aData
        write
    End Property

    Property Get get_PLL_POWER_ON
        get_PLL_POWER_ON = read_PLL_POWER_ON_value
    End Property

    Property Let set_PLL_POWER_ON(aData)
        write_PLL_POWER_ON_value = aData
        flag_PLL_POWER_ON        = &H1
    End Property

    Property Get read_PLL_POWER_ON
        read
        read_PLL_POWER_ON = read_PLL_POWER_ON_value
    End Property

    Property Let write_PLL_POWER_ON(aData)
        set_PLL_POWER_ON = aData
        write
    End Property

    Property Get get_PLL_RESETB_OV
        get_PLL_RESETB_OV = read_PLL_RESETB_OV_value
    End Property

    Property Let set_PLL_RESETB_OV(aData)
        write_PLL_RESETB_OV_value = aData
        flag_PLL_RESETB_OV        = &H1
    End Property

    Property Get read_PLL_RESETB_OV
        read
        read_PLL_RESETB_OV = read_PLL_RESETB_OV_value
    End Property

    Property Let write_PLL_RESETB_OV(aData)
        set_PLL_RESETB_OV = aData
        write
    End Property

    Property Get get_PLL_RESETB
        get_PLL_RESETB = read_PLL_RESETB_value
    End Property

    Property Let set_PLL_RESETB(aData)
        write_PLL_RESETB_value = aData
        flag_PLL_RESETB        = &H1
    End Property

    Property Get read_PLL_RESETB
        read
        read_PLL_RESETB = read_PLL_RESETB_value
    End Property

    Property Let write_PLL_RESETB(aData)
        set_PLL_RESETB = aData
        write
    End Property

    Property Get get_PLL_TEST_EN
        get_PLL_TEST_EN = read_PLL_TEST_EN_value
    End Property

    Property Let set_PLL_TEST_EN(aData)
        write_PLL_TEST_EN_value = aData
        flag_PLL_TEST_EN        = &H1
    End Property

    Property Get read_PLL_TEST_EN
        read
        read_PLL_TEST_EN = read_PLL_TEST_EN_value
    End Property

    Property Let write_PLL_TEST_EN(aData)
        set_PLL_TEST_EN = aData
        write
    End Property

    Property Get get_PLLBYP
        get_PLLBYP = read_PLLBYP_value
    End Property

    Property Let set_PLLBYP(aData)
        write_PLLBYP_value = aData
        flag_PLLBYP        = &H1
    End Property

    Property Get read_PLLBYP
        read
        read_PLLBYP = read_PLLBYP_value
    End Property

    Property Let write_PLLBYP(aData)
        set_PLLBYP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1510_value = rightShift(data_low, 10) and &H3f
        read_CMOS_REFCLK_EN_OV_value = rightShift(data_low, 9) and &H1
        read_CMOS_REFCLK_EN_value = rightShift(data_low, 8) and &H1
        read_CLK_RSTB_OV_value = rightShift(data_low, 7) and &H1
        read_CLK_RESET_value = rightShift(data_low, 6) and &H1
        read_PLL_POWER_ON_OV_value = rightShift(data_low, 5) and &H1
        read_PLL_POWER_ON_value = rightShift(data_low, 4) and &H1
        read_PLL_RESETB_OV_value = rightShift(data_low, 3) and &H1
        read_PLL_RESETB_value = rightShift(data_low, 2) and &H1
        read_PLL_TEST_EN_value = rightShift(data_low, 1) and &H1
        PLLBYP_mask = &H1
        if data_low > LONG_MAX then
            if PLLBYP_mask = mask then
                read_PLLBYP_value = data_low
            else
                read_PLLBYP_value = (data_low - H8000_0000) and PLLBYP_mask
            end If
        else
            read_PLLBYP_value = data_low and PLLBYP_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1510 = &H0 or flag_CMOS_REFCLK_EN_OV = &H0 or flag_CMOS_REFCLK_EN = &H0 or flag_CLK_RSTB_OV = &H0 or flag_CLK_RESET = &H0 or flag_PLL_POWER_ON_OV = &H0 or flag_PLL_POWER_ON = &H0 or flag_PLL_RESETB_OV = &H0 or flag_PLL_RESETB = &H0 or flag_PLL_TEST_EN = &H0 or flag_PLLBYP = &H0 Then read
        If flag_RESERVED_1510 = &H0 Then write_RESERVED_1510_value = get_RESERVED_1510
        If flag_CMOS_REFCLK_EN_OV = &H0 Then write_CMOS_REFCLK_EN_OV_value = get_CMOS_REFCLK_EN_OV
        If flag_CMOS_REFCLK_EN = &H0 Then write_CMOS_REFCLK_EN_value = get_CMOS_REFCLK_EN
        If flag_CLK_RSTB_OV = &H0 Then write_CLK_RSTB_OV_value = get_CLK_RSTB_OV
        If flag_CLK_RESET = &H0 Then write_CLK_RESET_value = get_CLK_RESET
        If flag_PLL_POWER_ON_OV = &H0 Then write_PLL_POWER_ON_OV_value = get_PLL_POWER_ON_OV
        If flag_PLL_POWER_ON = &H0 Then write_PLL_POWER_ON_value = get_PLL_POWER_ON
        If flag_PLL_RESETB_OV = &H0 Then write_PLL_RESETB_OV_value = get_PLL_RESETB_OV
        If flag_PLL_RESETB = &H0 Then write_PLL_RESETB_value = get_PLL_RESETB
        If flag_PLL_TEST_EN = &H0 Then write_PLL_TEST_EN_value = get_PLL_TEST_EN
        If flag_PLLBYP = &H0 Then write_PLLBYP_value = get_PLLBYP

        regValue = leftShift((write_RESERVED_1510_value and &H3f), 10) + leftShift((write_CMOS_REFCLK_EN_OV_value and &H1), 9) + leftShift((write_CMOS_REFCLK_EN_value and &H1), 8) + leftShift((write_CLK_RSTB_OV_value and &H1), 7) + leftShift((write_CLK_RESET_value and &H1), 6) + leftShift((write_PLL_POWER_ON_OV_value and &H1), 5) + leftShift((write_PLL_POWER_ON_value and &H1), 4) + leftShift((write_PLL_RESETB_OV_value and &H1), 3) + leftShift((write_PLL_RESETB_value and &H1), 2) + leftShift((write_PLL_TEST_EN_value and &H1), 1) + leftShift((write_PLLBYP_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1510_value = rightShift(data_low, 10) and &H3f
        read_CMOS_REFCLK_EN_OV_value = rightShift(data_low, 9) and &H1
        read_CMOS_REFCLK_EN_value = rightShift(data_low, 8) and &H1
        read_CLK_RSTB_OV_value = rightShift(data_low, 7) and &H1
        read_CLK_RESET_value = rightShift(data_low, 6) and &H1
        read_PLL_POWER_ON_OV_value = rightShift(data_low, 5) and &H1
        read_PLL_POWER_ON_value = rightShift(data_low, 4) and &H1
        read_PLL_RESETB_OV_value = rightShift(data_low, 3) and &H1
        read_PLL_RESETB_value = rightShift(data_low, 2) and &H1
        read_PLL_TEST_EN_value = rightShift(data_low, 1) and &H1
        PLLBYP_mask = &H1
        if data_low > LONG_MAX then
            if PLLBYP_mask = mask then
                read_PLLBYP_value = data_low
            else
                read_PLLBYP_value = (data_low - H8000_0000) and PLLBYP_mask
            end If
        else
            read_PLLBYP_value = data_low and PLLBYP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1510_value = &H0
        flag_RESERVED_1510        = &H0
        write_CMOS_REFCLK_EN_OV_value = &H0
        flag_CMOS_REFCLK_EN_OV        = &H0
        write_CMOS_REFCLK_EN_value = &H0
        flag_CMOS_REFCLK_EN        = &H0
        write_CLK_RSTB_OV_value = &H0
        flag_CLK_RSTB_OV        = &H0
        write_CLK_RESET_value = &H0
        flag_CLK_RESET        = &H0
        write_PLL_POWER_ON_OV_value = &H0
        flag_PLL_POWER_ON_OV        = &H0
        write_PLL_POWER_ON_value = &H0
        flag_PLL_POWER_ON        = &H0
        write_PLL_RESETB_OV_value = &H0
        flag_PLL_RESETB_OV        = &H0
        write_PLL_RESETB_value = &H0
        flag_PLL_RESETB        = &H0
        write_PLL_TEST_EN_value = &H0
        flag_PLL_TEST_EN        = &H0
        write_PLLBYP_value = &H0
        flag_PLLBYP        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_clk_cfg_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED                                   [15:0]           get_RESERVED
''                                                             set_RESERVED
''                                                             read_RESERVED
''                                                             write_RESERVED
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_clk_cfg_0
    Private write_RESERVED_value
    Private read_RESERVED_value
    Private flag_RESERVED

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

    Property Get get_RESERVED
        get_RESERVED = read_RESERVED_value
    End Property

    Property Let set_RESERVED(aData)
        write_RESERVED_value = aData
        flag_RESERVED        = &H1
    End Property

    Property Get read_RESERVED
        read
        read_RESERVED = read_RESERVED_value
    End Property

    Property Let write_RESERVED(aData)
        set_RESERVED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED = &H0 Then read
        If flag_RESERVED = &H0 Then write_RESERVED_value = get_RESERVED

        regValue = leftShift((write_RESERVED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_value = &H0
        flag_RESERVED        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_clk_cfg_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED                                   [15:0]           get_RESERVED
''                                                             set_RESERVED
''                                                             read_RESERVED
''                                                             write_RESERVED
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_clk_cfg_1
    Private write_RESERVED_value
    Private read_RESERVED_value
    Private flag_RESERVED

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

    Property Get get_RESERVED
        get_RESERVED = read_RESERVED_value
    End Property

    Property Let set_RESERVED(aData)
        write_RESERVED_value = aData
        flag_RESERVED        = &H1
    End Property

    Property Get read_RESERVED
        read
        read_RESERVED = read_RESERVED_value
    End Property

    Property Let write_RESERVED(aData)
        set_RESERVED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED = &H0 Then read
        If flag_RESERVED = &H0 Then write_RESERVED_value = get_RESERVED

        regValue = leftShift((write_RESERVED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_value = &H0
        flag_RESERVED        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_clk_cfg_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED                                   [15:0]           get_RESERVED
''                                                             set_RESERVED
''                                                             read_RESERVED
''                                                             write_RESERVED
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_clk_cfg_2
    Private write_RESERVED_value
    Private read_RESERVED_value
    Private flag_RESERVED

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

    Property Get get_RESERVED
        get_RESERVED = read_RESERVED_value
    End Property

    Property Let set_RESERVED(aData)
        write_RESERVED_value = aData
        flag_RESERVED        = &H1
    End Property

    Property Get read_RESERVED
        read
        read_RESERVED = read_RESERVED_value
    End Property

    Property Let write_RESERVED(aData)
        set_RESERVED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED = &H0 Then read
        If flag_RESERVED = &H0 Then write_RESERVED_value = get_RESERVED

        regValue = leftShift((write_RESERVED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_value = &H0
        flag_RESERVED        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_clk_cfg_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED                                   [15:0]           get_RESERVED
''                                                             set_RESERVED
''                                                             read_RESERVED
''                                                             write_RESERVED
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_clk_cfg_3
    Private write_RESERVED_value
    Private read_RESERVED_value
    Private flag_RESERVED

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

    Property Get get_RESERVED
        get_RESERVED = read_RESERVED_value
    End Property

    Property Let set_RESERVED(aData)
        write_RESERVED_value = aData
        flag_RESERVED        = &H1
    End Property

    Property Get read_RESERVED
        read
        read_RESERVED = read_RESERVED_value
    End Property

    Property Let write_RESERVED(aData)
        set_RESERVED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED = &H0 Then read
        If flag_RESERVED = &H0 Then write_RESERVED_value = get_RESERVED

        regValue = leftShift((write_RESERVED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESERVED_mask = &Hffff
        if data_low > LONG_MAX then
            if RESERVED_mask = mask then
                read_RESERVED_value = data_low
            else
                read_RESERVED_value = (data_low - H8000_0000) and RESERVED_mask
            end If
        else
            read_RESERVED_value = data_low and RESERVED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_value = &H0
        flag_RESERVED        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_clk_cfg_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PI_INI_PHASE                               [15:12]          get_PI_INI_PHASE
''                                                             set_PI_INI_PHASE
''                                                             read_PI_INI_PHASE
''                                                             write_PI_INI_PHASE
''---------------------------------------------------------------------------------
'' CKGEN_BIAS_CTRL                            [11:0]           get_CKGEN_BIAS_CTRL
''                                                             set_CKGEN_BIAS_CTRL
''                                                             read_CKGEN_BIAS_CTRL
''                                                             write_CKGEN_BIAS_CTRL
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_clk_cfg_4
    Private write_PI_INI_PHASE_value
    Private read_PI_INI_PHASE_value
    Private flag_PI_INI_PHASE
    Private write_CKGEN_BIAS_CTRL_value
    Private read_CKGEN_BIAS_CTRL_value
    Private flag_CKGEN_BIAS_CTRL

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

    Property Get get_PI_INI_PHASE
        get_PI_INI_PHASE = read_PI_INI_PHASE_value
    End Property

    Property Let set_PI_INI_PHASE(aData)
        write_PI_INI_PHASE_value = aData
        flag_PI_INI_PHASE        = &H1
    End Property

    Property Get read_PI_INI_PHASE
        read
        read_PI_INI_PHASE = read_PI_INI_PHASE_value
    End Property

    Property Let write_PI_INI_PHASE(aData)
        set_PI_INI_PHASE = aData
        write
    End Property

    Property Get get_CKGEN_BIAS_CTRL
        get_CKGEN_BIAS_CTRL = read_CKGEN_BIAS_CTRL_value
    End Property

    Property Let set_CKGEN_BIAS_CTRL(aData)
        write_CKGEN_BIAS_CTRL_value = aData
        flag_CKGEN_BIAS_CTRL        = &H1
    End Property

    Property Get read_CKGEN_BIAS_CTRL
        read
        read_CKGEN_BIAS_CTRL = read_CKGEN_BIAS_CTRL_value
    End Property

    Property Let write_CKGEN_BIAS_CTRL(aData)
        set_CKGEN_BIAS_CTRL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PI_INI_PHASE_value = rightShift(data_low, 12) and &Hf
        CKGEN_BIAS_CTRL_mask = &Hfff
        if data_low > LONG_MAX then
            if CKGEN_BIAS_CTRL_mask = mask then
                read_CKGEN_BIAS_CTRL_value = data_low
            else
                read_CKGEN_BIAS_CTRL_value = (data_low - H8000_0000) and CKGEN_BIAS_CTRL_mask
            end If
        else
            read_CKGEN_BIAS_CTRL_value = data_low and CKGEN_BIAS_CTRL_mask
        end If

    End Sub

    Sub write
        If flag_PI_INI_PHASE = &H0 or flag_CKGEN_BIAS_CTRL = &H0 Then read
        If flag_PI_INI_PHASE = &H0 Then write_PI_INI_PHASE_value = get_PI_INI_PHASE
        If flag_CKGEN_BIAS_CTRL = &H0 Then write_CKGEN_BIAS_CTRL_value = get_CKGEN_BIAS_CTRL

        regValue = leftShift((write_PI_INI_PHASE_value and &Hf), 12) + leftShift((write_CKGEN_BIAS_CTRL_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PI_INI_PHASE_value = rightShift(data_low, 12) and &Hf
        CKGEN_BIAS_CTRL_mask = &Hfff
        if data_low > LONG_MAX then
            if CKGEN_BIAS_CTRL_mask = mask then
                read_CKGEN_BIAS_CTRL_value = data_low
            else
                read_CKGEN_BIAS_CTRL_value = (data_low - H8000_0000) and CKGEN_BIAS_CTRL_mask
            end If
        else
            read_CKGEN_BIAS_CTRL_value = data_low and CKGEN_BIAS_CTRL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PI_INI_PHASE_value = &H0
        flag_PI_INI_PHASE        = &H0
        write_CKGEN_BIAS_CTRL_value = &H0
        flag_CKGEN_BIAS_CTRL        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_afe_bias_cfg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TVCO_INPUT_EN                              [15:15]          get_TVCO_INPUT_EN
''                                                             set_TVCO_INPUT_EN
''                                                             read_TVCO_INPUT_EN
''                                                             write_TVCO_INPUT_EN
''---------------------------------------------------------------------------------
'' TVCO_MUX_EN                                [14:14]          get_TVCO_MUX_EN
''                                                             set_TVCO_MUX_EN
''                                                             read_TVCO_MUX_EN
''                                                             write_TVCO_MUX_EN
''---------------------------------------------------------------------------------
'' CMOS_BUF_AMP_CTRL                          [13:11]          get_CMOS_BUF_AMP_CTRL
''                                                             set_CMOS_BUF_AMP_CTRL
''                                                             read_CMOS_BUF_AMP_CTRL
''                                                             write_CMOS_BUF_AMP_CTRL
''---------------------------------------------------------------------------------
'' CMOS_BUF_STRENGTH                          [10:7]           get_CMOS_BUF_STRENGTH
''                                                             set_CMOS_BUF_STRENGTH
''                                                             read_CMOS_BUF_STRENGTH
''                                                             write_CMOS_BUF_STRENGTH
''---------------------------------------------------------------------------------
'' FREF_BIAS_INC                              [6:5]            get_FREF_BIAS_INC
''                                                             set_FREF_BIAS_INC
''                                                             read_FREF_BIAS_INC
''                                                             write_FREF_BIAS_INC
''---------------------------------------------------------------------------------
'' CAL_CLK_OVR                                [4:4]            get_CAL_CLK_OVR
''                                                             set_CAL_CLK_OVR
''                                                             read_CAL_CLK_OVR
''                                                             write_CAL_CLK_OVR
''---------------------------------------------------------------------------------
'' TVCO_BIASCUR_TUNE                          [3:0]            get_TVCO_BIASCUR_TUNE
''                                                             set_TVCO_BIASCUR_TUNE
''                                                             read_TVCO_BIASCUR_TUNE
''                                                             write_TVCO_BIASCUR_TUNE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_afe_bias_cfg
    Private write_TVCO_INPUT_EN_value
    Private read_TVCO_INPUT_EN_value
    Private flag_TVCO_INPUT_EN
    Private write_TVCO_MUX_EN_value
    Private read_TVCO_MUX_EN_value
    Private flag_TVCO_MUX_EN
    Private write_CMOS_BUF_AMP_CTRL_value
    Private read_CMOS_BUF_AMP_CTRL_value
    Private flag_CMOS_BUF_AMP_CTRL
    Private write_CMOS_BUF_STRENGTH_value
    Private read_CMOS_BUF_STRENGTH_value
    Private flag_CMOS_BUF_STRENGTH
    Private write_FREF_BIAS_INC_value
    Private read_FREF_BIAS_INC_value
    Private flag_FREF_BIAS_INC
    Private write_CAL_CLK_OVR_value
    Private read_CAL_CLK_OVR_value
    Private flag_CAL_CLK_OVR
    Private write_TVCO_BIASCUR_TUNE_value
    Private read_TVCO_BIASCUR_TUNE_value
    Private flag_TVCO_BIASCUR_TUNE

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

    Property Get get_TVCO_INPUT_EN
        get_TVCO_INPUT_EN = read_TVCO_INPUT_EN_value
    End Property

    Property Let set_TVCO_INPUT_EN(aData)
        write_TVCO_INPUT_EN_value = aData
        flag_TVCO_INPUT_EN        = &H1
    End Property

    Property Get read_TVCO_INPUT_EN
        read
        read_TVCO_INPUT_EN = read_TVCO_INPUT_EN_value
    End Property

    Property Let write_TVCO_INPUT_EN(aData)
        set_TVCO_INPUT_EN = aData
        write
    End Property

    Property Get get_TVCO_MUX_EN
        get_TVCO_MUX_EN = read_TVCO_MUX_EN_value
    End Property

    Property Let set_TVCO_MUX_EN(aData)
        write_TVCO_MUX_EN_value = aData
        flag_TVCO_MUX_EN        = &H1
    End Property

    Property Get read_TVCO_MUX_EN
        read
        read_TVCO_MUX_EN = read_TVCO_MUX_EN_value
    End Property

    Property Let write_TVCO_MUX_EN(aData)
        set_TVCO_MUX_EN = aData
        write
    End Property

    Property Get get_CMOS_BUF_AMP_CTRL
        get_CMOS_BUF_AMP_CTRL = read_CMOS_BUF_AMP_CTRL_value
    End Property

    Property Let set_CMOS_BUF_AMP_CTRL(aData)
        write_CMOS_BUF_AMP_CTRL_value = aData
        flag_CMOS_BUF_AMP_CTRL        = &H1
    End Property

    Property Get read_CMOS_BUF_AMP_CTRL
        read
        read_CMOS_BUF_AMP_CTRL = read_CMOS_BUF_AMP_CTRL_value
    End Property

    Property Let write_CMOS_BUF_AMP_CTRL(aData)
        set_CMOS_BUF_AMP_CTRL = aData
        write
    End Property

    Property Get get_CMOS_BUF_STRENGTH
        get_CMOS_BUF_STRENGTH = read_CMOS_BUF_STRENGTH_value
    End Property

    Property Let set_CMOS_BUF_STRENGTH(aData)
        write_CMOS_BUF_STRENGTH_value = aData
        flag_CMOS_BUF_STRENGTH        = &H1
    End Property

    Property Get read_CMOS_BUF_STRENGTH
        read
        read_CMOS_BUF_STRENGTH = read_CMOS_BUF_STRENGTH_value
    End Property

    Property Let write_CMOS_BUF_STRENGTH(aData)
        set_CMOS_BUF_STRENGTH = aData
        write
    End Property

    Property Get get_FREF_BIAS_INC
        get_FREF_BIAS_INC = read_FREF_BIAS_INC_value
    End Property

    Property Let set_FREF_BIAS_INC(aData)
        write_FREF_BIAS_INC_value = aData
        flag_FREF_BIAS_INC        = &H1
    End Property

    Property Get read_FREF_BIAS_INC
        read
        read_FREF_BIAS_INC = read_FREF_BIAS_INC_value
    End Property

    Property Let write_FREF_BIAS_INC(aData)
        set_FREF_BIAS_INC = aData
        write
    End Property

    Property Get get_CAL_CLK_OVR
        get_CAL_CLK_OVR = read_CAL_CLK_OVR_value
    End Property

    Property Let set_CAL_CLK_OVR(aData)
        write_CAL_CLK_OVR_value = aData
        flag_CAL_CLK_OVR        = &H1
    End Property

    Property Get read_CAL_CLK_OVR
        read
        read_CAL_CLK_OVR = read_CAL_CLK_OVR_value
    End Property

    Property Let write_CAL_CLK_OVR(aData)
        set_CAL_CLK_OVR = aData
        write
    End Property

    Property Get get_TVCO_BIASCUR_TUNE
        get_TVCO_BIASCUR_TUNE = read_TVCO_BIASCUR_TUNE_value
    End Property

    Property Let set_TVCO_BIASCUR_TUNE(aData)
        write_TVCO_BIASCUR_TUNE_value = aData
        flag_TVCO_BIASCUR_TUNE        = &H1
    End Property

    Property Get read_TVCO_BIASCUR_TUNE
        read
        read_TVCO_BIASCUR_TUNE = read_TVCO_BIASCUR_TUNE_value
    End Property

    Property Let write_TVCO_BIASCUR_TUNE(aData)
        set_TVCO_BIASCUR_TUNE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TVCO_INPUT_EN_value = rightShift(data_low, 15) and &H1
        read_TVCO_MUX_EN_value = rightShift(data_low, 14) and &H1
        read_CMOS_BUF_AMP_CTRL_value = rightShift(data_low, 11) and &H7
        read_CMOS_BUF_STRENGTH_value = rightShift(data_low, 7) and &Hf
        read_FREF_BIAS_INC_value = rightShift(data_low, 5) and &H3
        read_CAL_CLK_OVR_value = rightShift(data_low, 4) and &H1
        TVCO_BIASCUR_TUNE_mask = &Hf
        if data_low > LONG_MAX then
            if TVCO_BIASCUR_TUNE_mask = mask then
                read_TVCO_BIASCUR_TUNE_value = data_low
            else
                read_TVCO_BIASCUR_TUNE_value = (data_low - H8000_0000) and TVCO_BIASCUR_TUNE_mask
            end If
        else
            read_TVCO_BIASCUR_TUNE_value = data_low and TVCO_BIASCUR_TUNE_mask
        end If

    End Sub

    Sub write
        If flag_TVCO_INPUT_EN = &H0 or flag_TVCO_MUX_EN = &H0 or flag_CMOS_BUF_AMP_CTRL = &H0 or flag_CMOS_BUF_STRENGTH = &H0 or flag_FREF_BIAS_INC = &H0 or flag_CAL_CLK_OVR = &H0 or flag_TVCO_BIASCUR_TUNE = &H0 Then read
        If flag_TVCO_INPUT_EN = &H0 Then write_TVCO_INPUT_EN_value = get_TVCO_INPUT_EN
        If flag_TVCO_MUX_EN = &H0 Then write_TVCO_MUX_EN_value = get_TVCO_MUX_EN
        If flag_CMOS_BUF_AMP_CTRL = &H0 Then write_CMOS_BUF_AMP_CTRL_value = get_CMOS_BUF_AMP_CTRL
        If flag_CMOS_BUF_STRENGTH = &H0 Then write_CMOS_BUF_STRENGTH_value = get_CMOS_BUF_STRENGTH
        If flag_FREF_BIAS_INC = &H0 Then write_FREF_BIAS_INC_value = get_FREF_BIAS_INC
        If flag_CAL_CLK_OVR = &H0 Then write_CAL_CLK_OVR_value = get_CAL_CLK_OVR
        If flag_TVCO_BIASCUR_TUNE = &H0 Then write_TVCO_BIASCUR_TUNE_value = get_TVCO_BIASCUR_TUNE

        regValue = leftShift((write_TVCO_INPUT_EN_value and &H1), 15) + leftShift((write_TVCO_MUX_EN_value and &H1), 14) + leftShift((write_CMOS_BUF_AMP_CTRL_value and &H7), 11) + leftShift((write_CMOS_BUF_STRENGTH_value and &Hf), 7) + leftShift((write_FREF_BIAS_INC_value and &H3), 5) + leftShift((write_CAL_CLK_OVR_value and &H1), 4) + leftShift((write_TVCO_BIASCUR_TUNE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TVCO_INPUT_EN_value = rightShift(data_low, 15) and &H1
        read_TVCO_MUX_EN_value = rightShift(data_low, 14) and &H1
        read_CMOS_BUF_AMP_CTRL_value = rightShift(data_low, 11) and &H7
        read_CMOS_BUF_STRENGTH_value = rightShift(data_low, 7) and &Hf
        read_FREF_BIAS_INC_value = rightShift(data_low, 5) and &H3
        read_CAL_CLK_OVR_value = rightShift(data_low, 4) and &H1
        TVCO_BIASCUR_TUNE_mask = &Hf
        if data_low > LONG_MAX then
            if TVCO_BIASCUR_TUNE_mask = mask then
                read_TVCO_BIASCUR_TUNE_value = data_low
            else
                read_TVCO_BIASCUR_TUNE_value = (data_low - H8000_0000) and TVCO_BIASCUR_TUNE_mask
            end If
        else
            read_TVCO_BIASCUR_TUNE_value = data_low and TVCO_BIASCUR_TUNE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TVCO_INPUT_EN_value = &H0
        flag_TVCO_INPUT_EN        = &H0
        write_TVCO_MUX_EN_value = &H0
        flag_TVCO_MUX_EN        = &H0
        write_CMOS_BUF_AMP_CTRL_value = &H0
        flag_CMOS_BUF_AMP_CTRL        = &H0
        write_CMOS_BUF_STRENGTH_value = &H0
        flag_CMOS_BUF_STRENGTH        = &H0
        write_FREF_BIAS_INC_value = &H0
        flag_FREF_BIAS_INC        = &H0
        write_CAL_CLK_OVR_value = &H0
        flag_CAL_CLK_OVR        = &H0
        write_TVCO_BIASCUR_TUNE_value = &H0
        flag_TVCO_BIASCUR_TUNE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_rcal_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RCAL_ADDER                                 [15:11]          get_RCAL_ADDER
''                                                             set_RCAL_ADDER
''                                                             read_RCAL_ADDER
''                                                             write_RCAL_ADDER
''---------------------------------------------------------------------------------
'' R_OFFSET                                   [10:8]           get_R_OFFSET
''                                                             set_R_OFFSET
''                                                             read_R_OFFSET
''                                                             write_R_OFFSET
''---------------------------------------------------------------------------------
'' R_PRESET                                   [7:7]            get_R_PRESET
''                                                             set_R_PRESET
''                                                             read_R_PRESET
''                                                             write_R_PRESET
''---------------------------------------------------------------------------------
'' R_PRESET_VAL                               [5:1]            get_R_PRESET_VAL
''                                                             set_R_PRESET_VAL
''                                                             read_R_PRESET_VAL
''                                                             write_R_PRESET_VAL
''---------------------------------------------------------------------------------
'' R_RESET                                    [0:0]            get_R_RESET
''                                                             set_R_RESET
''                                                             read_R_RESET
''                                                             write_R_RESET
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_rcal_ctrl
    Private write_RCAL_ADDER_value
    Private read_RCAL_ADDER_value
    Private flag_RCAL_ADDER
    Private write_R_OFFSET_value
    Private read_R_OFFSET_value
    Private flag_R_OFFSET
    Private write_R_PRESET_value
    Private read_R_PRESET_value
    Private flag_R_PRESET
    Private write_R_PRESET_VAL_value
    Private read_R_PRESET_VAL_value
    Private flag_R_PRESET_VAL
    Private write_R_RESET_value
    Private read_R_RESET_value
    Private flag_R_RESET

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

    Property Get get_RCAL_ADDER
        get_RCAL_ADDER = read_RCAL_ADDER_value
    End Property

    Property Let set_RCAL_ADDER(aData)
        write_RCAL_ADDER_value = aData
        flag_RCAL_ADDER        = &H1
    End Property

    Property Get read_RCAL_ADDER
        read
        read_RCAL_ADDER = read_RCAL_ADDER_value
    End Property

    Property Let write_RCAL_ADDER(aData)
        set_RCAL_ADDER = aData
        write
    End Property

    Property Get get_R_OFFSET
        get_R_OFFSET = read_R_OFFSET_value
    End Property

    Property Let set_R_OFFSET(aData)
        write_R_OFFSET_value = aData
        flag_R_OFFSET        = &H1
    End Property

    Property Get read_R_OFFSET
        read
        read_R_OFFSET = read_R_OFFSET_value
    End Property

    Property Let write_R_OFFSET(aData)
        set_R_OFFSET = aData
        write
    End Property

    Property Get get_R_PRESET
        get_R_PRESET = read_R_PRESET_value
    End Property

    Property Let set_R_PRESET(aData)
        write_R_PRESET_value = aData
        flag_R_PRESET        = &H1
    End Property

    Property Get read_R_PRESET
        read
        read_R_PRESET = read_R_PRESET_value
    End Property

    Property Let write_R_PRESET(aData)
        set_R_PRESET = aData
        write
    End Property

    Property Get get_R_PRESET_VAL
        get_R_PRESET_VAL = read_R_PRESET_VAL_value
    End Property

    Property Let set_R_PRESET_VAL(aData)
        write_R_PRESET_VAL_value = aData
        flag_R_PRESET_VAL        = &H1
    End Property

    Property Get read_R_PRESET_VAL
        read
        read_R_PRESET_VAL = read_R_PRESET_VAL_value
    End Property

    Property Let write_R_PRESET_VAL(aData)
        set_R_PRESET_VAL = aData
        write
    End Property

    Property Get get_R_RESET
        get_R_RESET = read_R_RESET_value
    End Property

    Property Let set_R_RESET(aData)
        write_R_RESET_value = aData
        flag_R_RESET        = &H1
    End Property

    Property Get read_R_RESET
        read
        read_R_RESET = read_R_RESET_value
    End Property

    Property Let write_R_RESET(aData)
        set_R_RESET = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RCAL_ADDER_value = rightShift(data_low, 11) and &H1f
        read_R_OFFSET_value = rightShift(data_low, 8) and &H7
        read_R_PRESET_value = rightShift(data_low, 7) and &H1
        read_R_PRESET_VAL_value = rightShift(data_low, 1) and &H1f
        R_RESET_mask = &H1
        if data_low > LONG_MAX then
            if R_RESET_mask = mask then
                read_R_RESET_value = data_low
            else
                read_R_RESET_value = (data_low - H8000_0000) and R_RESET_mask
            end If
        else
            read_R_RESET_value = data_low and R_RESET_mask
        end If

    End Sub

    Sub write
        If flag_RCAL_ADDER = &H0 or flag_R_OFFSET = &H0 or flag_R_PRESET = &H0 or flag_R_PRESET_VAL = &H0 or flag_R_RESET = &H0 Then read
        If flag_RCAL_ADDER = &H0 Then write_RCAL_ADDER_value = get_RCAL_ADDER
        If flag_R_OFFSET = &H0 Then write_R_OFFSET_value = get_R_OFFSET
        If flag_R_PRESET = &H0 Then write_R_PRESET_value = get_R_PRESET
        If flag_R_PRESET_VAL = &H0 Then write_R_PRESET_VAL_value = get_R_PRESET_VAL
        If flag_R_RESET = &H0 Then write_R_RESET_value = get_R_RESET

        regValue = leftShift((write_RCAL_ADDER_value and &H1f), 11) + leftShift((write_R_OFFSET_value and &H7), 8) + leftShift((write_R_PRESET_value and &H1), 7) + leftShift((write_R_PRESET_VAL_value and &H1f), 1) + leftShift((write_R_RESET_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RCAL_ADDER_value = rightShift(data_low, 11) and &H1f
        read_R_OFFSET_value = rightShift(data_low, 8) and &H7
        read_R_PRESET_value = rightShift(data_low, 7) and &H1
        read_R_PRESET_VAL_value = rightShift(data_low, 1) and &H1f
        R_RESET_mask = &H1
        if data_low > LONG_MAX then
            if R_RESET_mask = mask then
                read_R_RESET_value = data_low
            else
                read_R_RESET_value = (data_low - H8000_0000) and R_RESET_mask
            end If
        else
            read_R_RESET_value = data_low and R_RESET_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RCAL_ADDER_value = &H0
        flag_RCAL_ADDER        = &H0
        write_R_OFFSET_value = &H0
        flag_R_OFFSET        = &H0
        write_R_PRESET_value = &H0
        flag_R_PRESET        = &H0
        write_R_PRESET_VAL_value = &H0
        flag_R_PRESET_VAL        = &H0
        write_R_RESET_value = &H0
        flag_R_RESET        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_rccal_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RC_OFFSET                                  [10:8]           get_RC_OFFSET
''                                                             set_RC_OFFSET
''                                                             read_RC_OFFSET
''                                                             write_RC_OFFSET
''---------------------------------------------------------------------------------
'' RC_PRESET                                  [7:7]            get_RC_PRESET
''                                                             set_RC_PRESET
''                                                             read_RC_PRESET
''                                                             write_RC_PRESET
''---------------------------------------------------------------------------------
'' RC_PRESET_VAL                              [6:2]            get_RC_PRESET_VAL
''                                                             set_RC_PRESET_VAL
''                                                             read_RC_PRESET_VAL
''                                                             write_RC_PRESET_VAL
''---------------------------------------------------------------------------------
'' RC_RESET_OV                                [1:1]            get_RC_RESET_OV
''                                                             set_RC_RESET_OV
''                                                             read_RC_RESET_OV
''                                                             write_RC_RESET_OV
''---------------------------------------------------------------------------------
'' RC_RESET                                   [0:0]            get_RC_RESET
''                                                             set_RC_RESET
''                                                             read_RC_RESET
''                                                             write_RC_RESET
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_rccal_ctrl
    Private write_RC_OFFSET_value
    Private read_RC_OFFSET_value
    Private flag_RC_OFFSET
    Private write_RC_PRESET_value
    Private read_RC_PRESET_value
    Private flag_RC_PRESET
    Private write_RC_PRESET_VAL_value
    Private read_RC_PRESET_VAL_value
    Private flag_RC_PRESET_VAL
    Private write_RC_RESET_OV_value
    Private read_RC_RESET_OV_value
    Private flag_RC_RESET_OV
    Private write_RC_RESET_value
    Private read_RC_RESET_value
    Private flag_RC_RESET

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

    Property Get get_RC_OFFSET
        get_RC_OFFSET = read_RC_OFFSET_value
    End Property

    Property Let set_RC_OFFSET(aData)
        write_RC_OFFSET_value = aData
        flag_RC_OFFSET        = &H1
    End Property

    Property Get read_RC_OFFSET
        read
        read_RC_OFFSET = read_RC_OFFSET_value
    End Property

    Property Let write_RC_OFFSET(aData)
        set_RC_OFFSET = aData
        write
    End Property

    Property Get get_RC_PRESET
        get_RC_PRESET = read_RC_PRESET_value
    End Property

    Property Let set_RC_PRESET(aData)
        write_RC_PRESET_value = aData
        flag_RC_PRESET        = &H1
    End Property

    Property Get read_RC_PRESET
        read
        read_RC_PRESET = read_RC_PRESET_value
    End Property

    Property Let write_RC_PRESET(aData)
        set_RC_PRESET = aData
        write
    End Property

    Property Get get_RC_PRESET_VAL
        get_RC_PRESET_VAL = read_RC_PRESET_VAL_value
    End Property

    Property Let set_RC_PRESET_VAL(aData)
        write_RC_PRESET_VAL_value = aData
        flag_RC_PRESET_VAL        = &H1
    End Property

    Property Get read_RC_PRESET_VAL
        read
        read_RC_PRESET_VAL = read_RC_PRESET_VAL_value
    End Property

    Property Let write_RC_PRESET_VAL(aData)
        set_RC_PRESET_VAL = aData
        write
    End Property

    Property Get get_RC_RESET_OV
        get_RC_RESET_OV = read_RC_RESET_OV_value
    End Property

    Property Let set_RC_RESET_OV(aData)
        write_RC_RESET_OV_value = aData
        flag_RC_RESET_OV        = &H1
    End Property

    Property Get read_RC_RESET_OV
        read
        read_RC_RESET_OV = read_RC_RESET_OV_value
    End Property

    Property Let write_RC_RESET_OV(aData)
        set_RC_RESET_OV = aData
        write
    End Property

    Property Get get_RC_RESET
        get_RC_RESET = read_RC_RESET_value
    End Property

    Property Let set_RC_RESET(aData)
        write_RC_RESET_value = aData
        flag_RC_RESET        = &H1
    End Property

    Property Get read_RC_RESET
        read
        read_RC_RESET = read_RC_RESET_value
    End Property

    Property Let write_RC_RESET(aData)
        set_RC_RESET = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OFFSET_value = rightShift(data_low, 8) and &H7
        read_RC_PRESET_value = rightShift(data_low, 7) and &H1
        read_RC_PRESET_VAL_value = rightShift(data_low, 2) and &H1f
        read_RC_RESET_OV_value = rightShift(data_low, 1) and &H1
        RC_RESET_mask = &H1
        if data_low > LONG_MAX then
            if RC_RESET_mask = mask then
                read_RC_RESET_value = data_low
            else
                read_RC_RESET_value = (data_low - H8000_0000) and RC_RESET_mask
            end If
        else
            read_RC_RESET_value = data_low and RC_RESET_mask
        end If

    End Sub

    Sub write
        If flag_RC_OFFSET = &H0 or flag_RC_PRESET = &H0 or flag_RC_PRESET_VAL = &H0 or flag_RC_RESET_OV = &H0 or flag_RC_RESET = &H0 Then read
        If flag_RC_OFFSET = &H0 Then write_RC_OFFSET_value = get_RC_OFFSET
        If flag_RC_PRESET = &H0 Then write_RC_PRESET_value = get_RC_PRESET
        If flag_RC_PRESET_VAL = &H0 Then write_RC_PRESET_VAL_value = get_RC_PRESET_VAL
        If flag_RC_RESET_OV = &H0 Then write_RC_RESET_OV_value = get_RC_RESET_OV
        If flag_RC_RESET = &H0 Then write_RC_RESET_value = get_RC_RESET

        regValue = leftShift((write_RC_OFFSET_value and &H7), 8) + leftShift((write_RC_PRESET_value and &H1), 7) + leftShift((write_RC_PRESET_VAL_value and &H1f), 2) + leftShift((write_RC_RESET_OV_value and &H1), 1) + leftShift((write_RC_RESET_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC_OFFSET_value = rightShift(data_low, 8) and &H7
        read_RC_PRESET_value = rightShift(data_low, 7) and &H1
        read_RC_PRESET_VAL_value = rightShift(data_low, 2) and &H1f
        read_RC_RESET_OV_value = rightShift(data_low, 1) and &H1
        RC_RESET_mask = &H1
        if data_low > LONG_MAX then
            if RC_RESET_mask = mask then
                read_RC_RESET_value = data_low
            else
                read_RC_RESET_value = (data_low - H8000_0000) and RC_RESET_mask
            end If
        else
            read_RC_RESET_value = data_low and RC_RESET_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RC_OFFSET_value = &H0
        flag_RC_OFFSET        = &H0
        write_RC_PRESET_value = &H0
        flag_RC_PRESET        = &H0
        write_RC_PRESET_VAL_value = &H0
        flag_RC_PRESET_VAL        = &H0
        write_RC_RESET_OV_value = &H0
        flag_RC_RESET_OV        = &H0
        write_RC_RESET_value = &H0
        flag_RC_RESET        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_bias_trim_bg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BIAS_BG_TUNE                               [10:8]           get_BIAS_BG_TUNE
''                                                             set_BIAS_BG_TUNE
''                                                             read_BIAS_BG_TUNE
''                                                             write_BIAS_BG_TUNE
''---------------------------------------------------------------------------------
'' BIAS_TRIM_EXT                              [7:4]            get_BIAS_TRIM_EXT
''                                                             set_BIAS_TRIM_EXT
''                                                             read_BIAS_TRIM_EXT
''                                                             write_BIAS_TRIM_EXT
''---------------------------------------------------------------------------------
'' BIAS_TRIM_INT                              [3:0]            get_BIAS_TRIM_INT
''                                                             set_BIAS_TRIM_INT
''                                                             read_BIAS_TRIM_INT
''                                                             write_BIAS_TRIM_INT
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_bias_trim_bg
    Private write_BIAS_BG_TUNE_value
    Private read_BIAS_BG_TUNE_value
    Private flag_BIAS_BG_TUNE
    Private write_BIAS_TRIM_EXT_value
    Private read_BIAS_TRIM_EXT_value
    Private flag_BIAS_TRIM_EXT
    Private write_BIAS_TRIM_INT_value
    Private read_BIAS_TRIM_INT_value
    Private flag_BIAS_TRIM_INT

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

    Property Get get_BIAS_BG_TUNE
        get_BIAS_BG_TUNE = read_BIAS_BG_TUNE_value
    End Property

    Property Let set_BIAS_BG_TUNE(aData)
        write_BIAS_BG_TUNE_value = aData
        flag_BIAS_BG_TUNE        = &H1
    End Property

    Property Get read_BIAS_BG_TUNE
        read
        read_BIAS_BG_TUNE = read_BIAS_BG_TUNE_value
    End Property

    Property Let write_BIAS_BG_TUNE(aData)
        set_BIAS_BG_TUNE = aData
        write
    End Property

    Property Get get_BIAS_TRIM_EXT
        get_BIAS_TRIM_EXT = read_BIAS_TRIM_EXT_value
    End Property

    Property Let set_BIAS_TRIM_EXT(aData)
        write_BIAS_TRIM_EXT_value = aData
        flag_BIAS_TRIM_EXT        = &H1
    End Property

    Property Get read_BIAS_TRIM_EXT
        read
        read_BIAS_TRIM_EXT = read_BIAS_TRIM_EXT_value
    End Property

    Property Let write_BIAS_TRIM_EXT(aData)
        set_BIAS_TRIM_EXT = aData
        write
    End Property

    Property Get get_BIAS_TRIM_INT
        get_BIAS_TRIM_INT = read_BIAS_TRIM_INT_value
    End Property

    Property Let set_BIAS_TRIM_INT(aData)
        write_BIAS_TRIM_INT_value = aData
        flag_BIAS_TRIM_INT        = &H1
    End Property

    Property Get read_BIAS_TRIM_INT
        read
        read_BIAS_TRIM_INT = read_BIAS_TRIM_INT_value
    End Property

    Property Let write_BIAS_TRIM_INT(aData)
        set_BIAS_TRIM_INT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BIAS_BG_TUNE_value = rightShift(data_low, 8) and &H7
        read_BIAS_TRIM_EXT_value = rightShift(data_low, 4) and &Hf
        BIAS_TRIM_INT_mask = &Hf
        if data_low > LONG_MAX then
            if BIAS_TRIM_INT_mask = mask then
                read_BIAS_TRIM_INT_value = data_low
            else
                read_BIAS_TRIM_INT_value = (data_low - H8000_0000) and BIAS_TRIM_INT_mask
            end If
        else
            read_BIAS_TRIM_INT_value = data_low and BIAS_TRIM_INT_mask
        end If

    End Sub

    Sub write
        If flag_BIAS_BG_TUNE = &H0 or flag_BIAS_TRIM_EXT = &H0 or flag_BIAS_TRIM_INT = &H0 Then read
        If flag_BIAS_BG_TUNE = &H0 Then write_BIAS_BG_TUNE_value = get_BIAS_BG_TUNE
        If flag_BIAS_TRIM_EXT = &H0 Then write_BIAS_TRIM_EXT_value = get_BIAS_TRIM_EXT
        If flag_BIAS_TRIM_INT = &H0 Then write_BIAS_TRIM_INT_value = get_BIAS_TRIM_INT

        regValue = leftShift((write_BIAS_BG_TUNE_value and &H7), 8) + leftShift((write_BIAS_TRIM_EXT_value and &Hf), 4) + leftShift((write_BIAS_TRIM_INT_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BIAS_BG_TUNE_value = rightShift(data_low, 8) and &H7
        read_BIAS_TRIM_EXT_value = rightShift(data_low, 4) and &Hf
        BIAS_TRIM_INT_mask = &Hf
        if data_low > LONG_MAX then
            if BIAS_TRIM_INT_mask = mask then
                read_BIAS_TRIM_INT_value = data_low
            else
                read_BIAS_TRIM_INT_value = (data_low - H8000_0000) and BIAS_TRIM_INT_mask
            end If
        else
            read_BIAS_TRIM_INT_value = data_low and BIAS_TRIM_INT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BIAS_BG_TUNE_value = &H0
        flag_BIAS_BG_TUNE        = &H0
        write_BIAS_TRIM_EXT_value = &H0
        flag_BIAS_TRIM_EXT        = &H0
        write_BIAS_TRIM_INT_value = &H0
        flag_BIAS_TRIM_INT        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_idac_abist
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ABIST_OUT                                  [7:4]            get_ABIST_OUT
''                                                             set_ABIST_OUT
''                                                             read_ABIST_OUT
''                                                             write_ABIST_OUT
''---------------------------------------------------------------------------------
'' IDAC_MUX                                   [3:2]            get_IDAC_MUX
''                                                             set_IDAC_MUX
''                                                             read_IDAC_MUX
''                                                             write_IDAC_MUX
''---------------------------------------------------------------------------------
'' IDAC_HALFOUT                               [1:1]            get_IDAC_HALFOUT
''                                                             set_IDAC_HALFOUT
''                                                             read_IDAC_HALFOUT
''                                                             write_IDAC_HALFOUT
''---------------------------------------------------------------------------------
'' IDAC_MODE                                  [0:0]            get_IDAC_MODE
''                                                             set_IDAC_MODE
''                                                             read_IDAC_MODE
''                                                             write_IDAC_MODE
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_idac_abist
    Private write_ABIST_OUT_value
    Private read_ABIST_OUT_value
    Private flag_ABIST_OUT
    Private write_IDAC_MUX_value
    Private read_IDAC_MUX_value
    Private flag_IDAC_MUX
    Private write_IDAC_HALFOUT_value
    Private read_IDAC_HALFOUT_value
    Private flag_IDAC_HALFOUT
    Private write_IDAC_MODE_value
    Private read_IDAC_MODE_value
    Private flag_IDAC_MODE

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

    Property Get get_ABIST_OUT
        get_ABIST_OUT = read_ABIST_OUT_value
    End Property

    Property Let set_ABIST_OUT(aData)
        write_ABIST_OUT_value = aData
        flag_ABIST_OUT        = &H1
    End Property

    Property Get read_ABIST_OUT
        read
        read_ABIST_OUT = read_ABIST_OUT_value
    End Property

    Property Let write_ABIST_OUT(aData)
        set_ABIST_OUT = aData
        write
    End Property

    Property Get get_IDAC_MUX
        get_IDAC_MUX = read_IDAC_MUX_value
    End Property

    Property Let set_IDAC_MUX(aData)
        write_IDAC_MUX_value = aData
        flag_IDAC_MUX        = &H1
    End Property

    Property Get read_IDAC_MUX
        read
        read_IDAC_MUX = read_IDAC_MUX_value
    End Property

    Property Let write_IDAC_MUX(aData)
        set_IDAC_MUX = aData
        write
    End Property

    Property Get get_IDAC_HALFOUT
        get_IDAC_HALFOUT = read_IDAC_HALFOUT_value
    End Property

    Property Let set_IDAC_HALFOUT(aData)
        write_IDAC_HALFOUT_value = aData
        flag_IDAC_HALFOUT        = &H1
    End Property

    Property Get read_IDAC_HALFOUT
        read
        read_IDAC_HALFOUT = read_IDAC_HALFOUT_value
    End Property

    Property Let write_IDAC_HALFOUT(aData)
        set_IDAC_HALFOUT = aData
        write
    End Property

    Property Get get_IDAC_MODE
        get_IDAC_MODE = read_IDAC_MODE_value
    End Property

    Property Let set_IDAC_MODE(aData)
        write_IDAC_MODE_value = aData
        flag_IDAC_MODE        = &H1
    End Property

    Property Get read_IDAC_MODE
        read
        read_IDAC_MODE = read_IDAC_MODE_value
    End Property

    Property Let write_IDAC_MODE(aData)
        set_IDAC_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ABIST_OUT_value = rightShift(data_low, 4) and &Hf
        read_IDAC_MUX_value = rightShift(data_low, 2) and &H3
        read_IDAC_HALFOUT_value = rightShift(data_low, 1) and &H1
        IDAC_MODE_mask = &H1
        if data_low > LONG_MAX then
            if IDAC_MODE_mask = mask then
                read_IDAC_MODE_value = data_low
            else
                read_IDAC_MODE_value = (data_low - H8000_0000) and IDAC_MODE_mask
            end If
        else
            read_IDAC_MODE_value = data_low and IDAC_MODE_mask
        end If

    End Sub

    Sub write
        If flag_ABIST_OUT = &H0 or flag_IDAC_MUX = &H0 or flag_IDAC_HALFOUT = &H0 or flag_IDAC_MODE = &H0 Then read
        If flag_ABIST_OUT = &H0 Then write_ABIST_OUT_value = get_ABIST_OUT
        If flag_IDAC_MUX = &H0 Then write_IDAC_MUX_value = get_IDAC_MUX
        If flag_IDAC_HALFOUT = &H0 Then write_IDAC_HALFOUT_value = get_IDAC_HALFOUT
        If flag_IDAC_MODE = &H0 Then write_IDAC_MODE_value = get_IDAC_MODE

        regValue = leftShift((write_ABIST_OUT_value and &Hf), 4) + leftShift((write_IDAC_MUX_value and &H3), 2) + leftShift((write_IDAC_HALFOUT_value and &H1), 1) + leftShift((write_IDAC_MODE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ABIST_OUT_value = rightShift(data_low, 4) and &Hf
        read_IDAC_MUX_value = rightShift(data_low, 2) and &H3
        read_IDAC_HALFOUT_value = rightShift(data_low, 1) and &H1
        IDAC_MODE_mask = &H1
        if data_low > LONG_MAX then
            if IDAC_MODE_mask = mask then
                read_IDAC_MODE_value = data_low
            else
                read_IDAC_MODE_value = (data_low - H8000_0000) and IDAC_MODE_mask
            end If
        else
            read_IDAC_MODE_value = data_low and IDAC_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ABIST_OUT_value = &H0
        flag_ABIST_OUT        = &H0
        write_IDAC_MUX_value = &H0
        flag_IDAC_MUX        = &H0
        write_IDAC_HALFOUT_value = &H0
        flag_IDAC_HALFOUT        = &H0
        write_IDAC_MODE_value = &H0
        flag_IDAC_MODE        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_txclk_ph
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TXCLK_PH_1GBT                              [12:8]           get_TXCLK_PH_1GBT
''                                                             set_TXCLK_PH_1GBT
''                                                             read_TXCLK_PH_1GBT
''                                                             write_TXCLK_PH_1GBT
''---------------------------------------------------------------------------------
'' TXCLK_PH_100BT                             [4:0]            get_TXCLK_PH_100BT
''                                                             set_TXCLK_PH_100BT
''                                                             read_TXCLK_PH_100BT
''                                                             write_TXCLK_PH_100BT
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_txclk_ph
    Private write_TXCLK_PH_1GBT_value
    Private read_TXCLK_PH_1GBT_value
    Private flag_TXCLK_PH_1GBT
    Private write_TXCLK_PH_100BT_value
    Private read_TXCLK_PH_100BT_value
    Private flag_TXCLK_PH_100BT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TXCLK_PH_1GBT
        get_TXCLK_PH_1GBT = read_TXCLK_PH_1GBT_value
    End Property

    Property Let set_TXCLK_PH_1GBT(aData)
        write_TXCLK_PH_1GBT_value = aData
        flag_TXCLK_PH_1GBT        = &H1
    End Property

    Property Get read_TXCLK_PH_1GBT
        read
        read_TXCLK_PH_1GBT = read_TXCLK_PH_1GBT_value
    End Property

    Property Let write_TXCLK_PH_1GBT(aData)
        set_TXCLK_PH_1GBT = aData
        write
    End Property

    Property Get get_TXCLK_PH_100BT
        get_TXCLK_PH_100BT = read_TXCLK_PH_100BT_value
    End Property

    Property Let set_TXCLK_PH_100BT(aData)
        write_TXCLK_PH_100BT_value = aData
        flag_TXCLK_PH_100BT        = &H1
    End Property

    Property Get read_TXCLK_PH_100BT
        read
        read_TXCLK_PH_100BT = read_TXCLK_PH_100BT_value
    End Property

    Property Let write_TXCLK_PH_100BT(aData)
        set_TXCLK_PH_100BT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXCLK_PH_1GBT_value = rightShift(data_low, 8) and &H1f
        TXCLK_PH_100BT_mask = &H1f
        if data_low > LONG_MAX then
            if TXCLK_PH_100BT_mask = mask then
                read_TXCLK_PH_100BT_value = data_low
            else
                read_TXCLK_PH_100BT_value = (data_low - H8000_0000) and TXCLK_PH_100BT_mask
            end If
        else
            read_TXCLK_PH_100BT_value = data_low and TXCLK_PH_100BT_mask
        end If

    End Sub

    Sub write
        If flag_TXCLK_PH_1GBT = &H0 or flag_TXCLK_PH_100BT = &H0 Then read
        If flag_TXCLK_PH_1GBT = &H0 Then write_TXCLK_PH_1GBT_value = get_TXCLK_PH_1GBT
        If flag_TXCLK_PH_100BT = &H0 Then write_TXCLK_PH_100BT_value = get_TXCLK_PH_100BT

        regValue = leftShift((write_TXCLK_PH_1GBT_value and &H1f), 8) + leftShift((write_TXCLK_PH_100BT_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TXCLK_PH_1GBT_value = rightShift(data_low, 8) and &H1f
        TXCLK_PH_100BT_mask = &H1f
        if data_low > LONG_MAX then
            if TXCLK_PH_100BT_mask = mask then
                read_TXCLK_PH_100BT_value = data_low
            else
                read_TXCLK_PH_100BT_value = (data_low - H8000_0000) and TXCLK_PH_100BT_mask
            end If
        else
            read_TXCLK_PH_100BT_value = data_low and TXCLK_PH_100BT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TXCLK_PH_1GBT_value = &H0
        flag_TXCLK_PH_1GBT        = &H0
        write_TXCLK_PH_100BT_value = &H0
        flag_TXCLK_PH_100BT        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_pll_test
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESERVED_1507                              [15:7]           get_RESERVED_1507
''                                                             set_RESERVED_1507
''                                                             read_RESERVED_1507
''                                                             write_RESERVED_1507
''---------------------------------------------------------------------------------
'' PLL_HQCLK_TM                               [6:1]            get_PLL_HQCLK_TM
''                                                             set_PLL_HQCLK_TM
''                                                             read_PLL_HQCLK_TM
''                                                             write_PLL_HQCLK_TM
''---------------------------------------------------------------------------------
'' PLL_HQCLK_EN                               [0:0]            get_PLL_HQCLK_EN
''                                                             set_PLL_HQCLK_EN
''                                                             read_PLL_HQCLK_EN
''                                                             write_PLL_HQCLK_EN
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_pll_test
    Private write_RESERVED_1507_value
    Private read_RESERVED_1507_value
    Private flag_RESERVED_1507
    Private write_PLL_HQCLK_TM_value
    Private read_PLL_HQCLK_TM_value
    Private flag_PLL_HQCLK_TM
    Private write_PLL_HQCLK_EN_value
    Private read_PLL_HQCLK_EN_value
    Private flag_PLL_HQCLK_EN

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

    Property Get get_RESERVED_1507
        get_RESERVED_1507 = read_RESERVED_1507_value
    End Property

    Property Let set_RESERVED_1507(aData)
        write_RESERVED_1507_value = aData
        flag_RESERVED_1507        = &H1
    End Property

    Property Get read_RESERVED_1507
        read
        read_RESERVED_1507 = read_RESERVED_1507_value
    End Property

    Property Let write_RESERVED_1507(aData)
        set_RESERVED_1507 = aData
        write
    End Property

    Property Get get_PLL_HQCLK_TM
        get_PLL_HQCLK_TM = read_PLL_HQCLK_TM_value
    End Property

    Property Let set_PLL_HQCLK_TM(aData)
        write_PLL_HQCLK_TM_value = aData
        flag_PLL_HQCLK_TM        = &H1
    End Property

    Property Get read_PLL_HQCLK_TM
        read
        read_PLL_HQCLK_TM = read_PLL_HQCLK_TM_value
    End Property

    Property Let write_PLL_HQCLK_TM(aData)
        set_PLL_HQCLK_TM = aData
        write
    End Property

    Property Get get_PLL_HQCLK_EN
        get_PLL_HQCLK_EN = read_PLL_HQCLK_EN_value
    End Property

    Property Let set_PLL_HQCLK_EN(aData)
        write_PLL_HQCLK_EN_value = aData
        flag_PLL_HQCLK_EN        = &H1
    End Property

    Property Get read_PLL_HQCLK_EN
        read
        read_PLL_HQCLK_EN = read_PLL_HQCLK_EN_value
    End Property

    Property Let write_PLL_HQCLK_EN(aData)
        set_PLL_HQCLK_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1507_value = rightShift(data_low, 7) and &H1ff
        read_PLL_HQCLK_TM_value = rightShift(data_low, 1) and &H3f
        PLL_HQCLK_EN_mask = &H1
        if data_low > LONG_MAX then
            if PLL_HQCLK_EN_mask = mask then
                read_PLL_HQCLK_EN_value = data_low
            else
                read_PLL_HQCLK_EN_value = (data_low - H8000_0000) and PLL_HQCLK_EN_mask
            end If
        else
            read_PLL_HQCLK_EN_value = data_low and PLL_HQCLK_EN_mask
        end If

    End Sub

    Sub write
        If flag_RESERVED_1507 = &H0 or flag_PLL_HQCLK_TM = &H0 or flag_PLL_HQCLK_EN = &H0 Then read
        If flag_RESERVED_1507 = &H0 Then write_RESERVED_1507_value = get_RESERVED_1507
        If flag_PLL_HQCLK_TM = &H0 Then write_PLL_HQCLK_TM_value = get_PLL_HQCLK_TM
        If flag_PLL_HQCLK_EN = &H0 Then write_PLL_HQCLK_EN_value = get_PLL_HQCLK_EN

        regValue = leftShift((write_RESERVED_1507_value and &H1ff), 7) + leftShift((write_PLL_HQCLK_TM_value and &H3f), 1) + leftShift((write_PLL_HQCLK_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESERVED_1507_value = rightShift(data_low, 7) and &H1ff
        read_PLL_HQCLK_TM_value = rightShift(data_low, 1) and &H3f
        PLL_HQCLK_EN_mask = &H1
        if data_low > LONG_MAX then
            if PLL_HQCLK_EN_mask = mask then
                read_PLL_HQCLK_EN_value = data_low
            else
                read_PLL_HQCLK_EN_value = (data_low - H8000_0000) and PLL_HQCLK_EN_mask
            end If
        else
            read_PLL_HQCLK_EN_value = data_low and PLL_HQCLK_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESERVED_1507_value = &H0
        flag_RESERVED_1507        = &H0
        write_PLL_HQCLK_TM_value = &H0
        flag_PLL_HQCLK_TM        = &H0
        write_PLL_HQCLK_EN_value = &H0
        flag_PLL_HQCLK_EN        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_r_rc_cal_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' R_CAL_LAT                                  [14:11]          get_R_CAL_LAT
''                                                             set_R_CAL_LAT
''                                                             read_R_CAL_LAT
''                                                             write_R_CAL_LAT
''---------------------------------------------------------------------------------
'' CAL_DONE                                   [10:10]          get_CAL_DONE
''                                                             set_CAL_DONE
''                                                             read_CAL_DONE
''                                                             write_CAL_DONE
''---------------------------------------------------------------------------------
'' R_CAL                                      [9:5]            get_R_CAL
''                                                             set_R_CAL
''                                                             read_R_CAL
''                                                             write_R_CAL
''---------------------------------------------------------------------------------
'' RC_CAL                                     [4:0]            get_RC_CAL
''                                                             set_RC_CAL
''                                                             read_RC_CAL
''                                                             write_RC_CAL
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_r_rc_cal_status
    Private write_R_CAL_LAT_value
    Private read_R_CAL_LAT_value
    Private flag_R_CAL_LAT
    Private write_CAL_DONE_value
    Private read_CAL_DONE_value
    Private flag_CAL_DONE
    Private write_R_CAL_value
    Private read_R_CAL_value
    Private flag_R_CAL
    Private write_RC_CAL_value
    Private read_RC_CAL_value
    Private flag_RC_CAL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H62
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_R_CAL_LAT
        get_R_CAL_LAT = read_R_CAL_LAT_value
    End Property

    Property Let set_R_CAL_LAT(aData)
        write_R_CAL_LAT_value = aData
        flag_R_CAL_LAT        = &H1
    End Property

    Property Get read_R_CAL_LAT
        read
        read_R_CAL_LAT = read_R_CAL_LAT_value
    End Property

    Property Let write_R_CAL_LAT(aData)
        set_R_CAL_LAT = aData
        write
    End Property

    Property Get get_CAL_DONE
        get_CAL_DONE = read_CAL_DONE_value
    End Property

    Property Let set_CAL_DONE(aData)
        write_CAL_DONE_value = aData
        flag_CAL_DONE        = &H1
    End Property

    Property Get read_CAL_DONE
        read
        read_CAL_DONE = read_CAL_DONE_value
    End Property

    Property Let write_CAL_DONE(aData)
        set_CAL_DONE = aData
        write
    End Property

    Property Get get_R_CAL
        get_R_CAL = read_R_CAL_value
    End Property

    Property Let set_R_CAL(aData)
        write_R_CAL_value = aData
        flag_R_CAL        = &H1
    End Property

    Property Get read_R_CAL
        read
        read_R_CAL = read_R_CAL_value
    End Property

    Property Let write_R_CAL(aData)
        set_R_CAL = aData
        write
    End Property

    Property Get get_RC_CAL
        get_RC_CAL = read_RC_CAL_value
    End Property

    Property Let set_RC_CAL(aData)
        write_RC_CAL_value = aData
        flag_RC_CAL        = &H1
    End Property

    Property Get read_RC_CAL
        read
        read_RC_CAL = read_RC_CAL_value
    End Property

    Property Let write_RC_CAL(aData)
        set_RC_CAL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R_CAL_LAT_value = rightShift(data_low, 11) and &Hf
        read_CAL_DONE_value = rightShift(data_low, 10) and &H1
        read_R_CAL_value = rightShift(data_low, 5) and &H1f
        RC_CAL_mask = &H1f
        if data_low > LONG_MAX then
            if RC_CAL_mask = mask then
                read_RC_CAL_value = data_low
            else
                read_RC_CAL_value = (data_low - H8000_0000) and RC_CAL_mask
            end If
        else
            read_RC_CAL_value = data_low and RC_CAL_mask
        end If

    End Sub

    Sub write
        If flag_R_CAL_LAT = &H0 or flag_CAL_DONE = &H0 or flag_R_CAL = &H0 or flag_RC_CAL = &H0 Then read
        If flag_R_CAL_LAT = &H0 Then write_R_CAL_LAT_value = get_R_CAL_LAT
        If flag_CAL_DONE = &H0 Then write_CAL_DONE_value = get_CAL_DONE
        If flag_R_CAL = &H0 Then write_R_CAL_value = get_R_CAL
        If flag_RC_CAL = &H0 Then write_RC_CAL_value = get_RC_CAL

        regValue = leftShift((write_R_CAL_LAT_value and &Hf), 11) + leftShift((write_CAL_DONE_value and &H1), 10) + leftShift((write_R_CAL_value and &H1f), 5) + leftShift((write_RC_CAL_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_R_CAL_LAT_value = rightShift(data_low, 11) and &Hf
        read_CAL_DONE_value = rightShift(data_low, 10) and &H1
        read_R_CAL_value = rightShift(data_low, 5) and &H1f
        RC_CAL_mask = &H1f
        if data_low > LONG_MAX then
            if RC_CAL_mask = mask then
                read_RC_CAL_value = data_low
            else
                read_RC_CAL_value = (data_low - H8000_0000) and RC_CAL_mask
            end If
        else
            read_RC_CAL_value = data_low and RC_CAL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_R_CAL_LAT_value = &H0
        flag_R_CAL_LAT        = &H0
        write_CAL_DONE_value = &H0
        flag_CAL_DONE        = &H0
        write_R_CAL_value = &H0
        flag_R_CAL        = &H0
        write_RC_CAL_value = &H0
        flag_RC_CAL        = &H0
    End Sub
End Class


'' @REGISTER : AFE_DIG_pll_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PLL_FREQ_LOCK                              [12:12]          get_PLL_FREQ_LOCK
''                                                             set_PLL_FREQ_LOCK
''                                                             read_PLL_FREQ_LOCK
''                                                             write_PLL_FREQ_LOCK
''---------------------------------------------------------------------------------
'' PLL_STATUS                                 [11:0]           get_PLL_STATUS
''                                                             set_PLL_STATUS
''                                                             read_PLL_STATUS
''                                                             write_PLL_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_AFE_DIG_pll_status
    Private write_PLL_FREQ_LOCK_value
    Private read_PLL_FREQ_LOCK_value
    Private flag_PLL_FREQ_LOCK
    Private write_PLL_STATUS_value
    Private read_PLL_STATUS_value
    Private flag_PLL_STATUS

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

    Property Get get_PLL_FREQ_LOCK
        get_PLL_FREQ_LOCK = read_PLL_FREQ_LOCK_value
    End Property

    Property Let set_PLL_FREQ_LOCK(aData)
        write_PLL_FREQ_LOCK_value = aData
        flag_PLL_FREQ_LOCK        = &H1
    End Property

    Property Get read_PLL_FREQ_LOCK
        read
        read_PLL_FREQ_LOCK = read_PLL_FREQ_LOCK_value
    End Property

    Property Let write_PLL_FREQ_LOCK(aData)
        set_PLL_FREQ_LOCK = aData
        write
    End Property

    Property Get get_PLL_STATUS
        get_PLL_STATUS = read_PLL_STATUS_value
    End Property

    Property Let set_PLL_STATUS(aData)
        write_PLL_STATUS_value = aData
        flag_PLL_STATUS        = &H1
    End Property

    Property Get read_PLL_STATUS
        read
        read_PLL_STATUS = read_PLL_STATUS_value
    End Property

    Property Let write_PLL_STATUS(aData)
        set_PLL_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_FREQ_LOCK_value = rightShift(data_low, 12) and &H1
        PLL_STATUS_mask = &Hfff
        if data_low > LONG_MAX then
            if PLL_STATUS_mask = mask then
                read_PLL_STATUS_value = data_low
            else
                read_PLL_STATUS_value = (data_low - H8000_0000) and PLL_STATUS_mask
            end If
        else
            read_PLL_STATUS_value = data_low and PLL_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_PLL_FREQ_LOCK = &H0 or flag_PLL_STATUS = &H0 Then read
        If flag_PLL_FREQ_LOCK = &H0 Then write_PLL_FREQ_LOCK_value = get_PLL_FREQ_LOCK
        If flag_PLL_STATUS = &H0 Then write_PLL_STATUS_value = get_PLL_STATUS

        regValue = leftShift((write_PLL_FREQ_LOCK_value and &H1), 12) + leftShift((write_PLL_STATUS_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PLL_FREQ_LOCK_value = rightShift(data_low, 12) and &H1
        PLL_STATUS_mask = &Hfff
        if data_low > LONG_MAX then
            if PLL_STATUS_mask = mask then
                read_PLL_STATUS_value = data_low
            else
                read_PLL_STATUS_value = (data_low - H8000_0000) and PLL_STATUS_mask
            end If
        else
            read_PLL_STATUS_value = data_low and PLL_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PLL_FREQ_LOCK_value = &H0
        flag_PLL_FREQ_LOCK        = &H0
        write_PLL_STATUS_value = &H0
        flag_PLL_STATUS        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class AFE_DIG_INSTANCE

    Public afe_misc_ctrl
    Public afe_tx_cfg_0
    Public afe_tx_cfg_1
    Public afe_tx_cfg_2
    Public afe_tx_cfg_3
    Public afe_tx_cfg_4
    Public afe_tx_cfg_5
    Public afe_tx_cfg_6
    Public afe_tx_cfg_7
    Public afe_tx_cfg_aneg
    Public afe_hyb_cfg_0
    Public afe_hyb_cfg_1
    Public lpf_hpf_ctrl
    Public afe_rx_cfg_0
    Public afe_rx_cfg_1
    Public afe_rx_cfg_2
    Public afe_rx_cfg_3
    Public afe_rx_cfg_4
    Public afe_rx_cfg_5
    Public afe_rx_cfg_6
    Public afe_rx_cfg_7
    Public afe_rx_cfg_8
    Public afe_rx_cfg_9
    Public afe_rx_cfg_10
    Public afe_rx_cfg_11
    Public afe_rx_cfg_12
    Public afe_rx_cfg_13
    Public afe_rx_cfg_14
    Public afe_rx_cfg_15
    Public afe_acb_ctrl
    Public afe_acb_wrdata
    Public afe_acb_rddata
    Public afe_pll_cfg_0
    Public afe_pll_cfg_1
    Public afe_pll_cfg_2
    Public afe_pll_cfg_3
    Public afe_pll_ctrl
    Public afe_clk_cfg_0
    Public afe_clk_cfg_1
    Public afe_clk_cfg_2
    Public afe_clk_cfg_3
    Public afe_clk_cfg_4
    Public afe_bias_cfg
    Public rcal_ctrl
    Public rccal_ctrl
    Public bias_trim_bg
    Public idac_abist
    Public txclk_ph
    Public pll_test
    Public r_rc_cal_status
    Public pll_status


    Public default function Init(aBaseAddr)
        Set afe_misc_ctrl = (New REGISTER_AFE_DIG_afe_misc_ctrl)(aBaseAddr, 16)
        Set afe_tx_cfg_0 = (New REGISTER_AFE_DIG_afe_tx_cfg_0)(aBaseAddr, 16)
        Set afe_tx_cfg_1 = (New REGISTER_AFE_DIG_afe_tx_cfg_1)(aBaseAddr, 16)
        Set afe_tx_cfg_2 = (New REGISTER_AFE_DIG_afe_tx_cfg_2)(aBaseAddr, 16)
        Set afe_tx_cfg_3 = (New REGISTER_AFE_DIG_afe_tx_cfg_3)(aBaseAddr, 16)
        Set afe_tx_cfg_4 = (New REGISTER_AFE_DIG_afe_tx_cfg_4)(aBaseAddr, 16)
        Set afe_tx_cfg_5 = (New REGISTER_AFE_DIG_afe_tx_cfg_5)(aBaseAddr, 16)
        Set afe_tx_cfg_6 = (New REGISTER_AFE_DIG_afe_tx_cfg_6)(aBaseAddr, 16)
        Set afe_tx_cfg_7 = (New REGISTER_AFE_DIG_afe_tx_cfg_7)(aBaseAddr, 16)
        Set afe_tx_cfg_aneg = (New REGISTER_AFE_DIG_afe_tx_cfg_aneg)(aBaseAddr, 16)
        Set afe_hyb_cfg_0 = (New REGISTER_AFE_DIG_afe_hyb_cfg_0)(aBaseAddr, 16)
        Set afe_hyb_cfg_1 = (New REGISTER_AFE_DIG_afe_hyb_cfg_1)(aBaseAddr, 16)
        Set lpf_hpf_ctrl = (New REGISTER_AFE_DIG_lpf_hpf_ctrl)(aBaseAddr, 16)
        Set afe_rx_cfg_0 = (New REGISTER_AFE_DIG_afe_rx_cfg_0)(aBaseAddr, 16)
        Set afe_rx_cfg_1 = (New REGISTER_AFE_DIG_afe_rx_cfg_1)(aBaseAddr, 16)
        Set afe_rx_cfg_2 = (New REGISTER_AFE_DIG_afe_rx_cfg_2)(aBaseAddr, 16)
        Set afe_rx_cfg_3 = (New REGISTER_AFE_DIG_afe_rx_cfg_3)(aBaseAddr, 16)
        Set afe_rx_cfg_4 = (New REGISTER_AFE_DIG_afe_rx_cfg_4)(aBaseAddr, 16)
        Set afe_rx_cfg_5 = (New REGISTER_AFE_DIG_afe_rx_cfg_5)(aBaseAddr, 16)
        Set afe_rx_cfg_6 = (New REGISTER_AFE_DIG_afe_rx_cfg_6)(aBaseAddr, 16)
        Set afe_rx_cfg_7 = (New REGISTER_AFE_DIG_afe_rx_cfg_7)(aBaseAddr, 16)
        Set afe_rx_cfg_8 = (New REGISTER_AFE_DIG_afe_rx_cfg_8)(aBaseAddr, 16)
        Set afe_rx_cfg_9 = (New REGISTER_AFE_DIG_afe_rx_cfg_9)(aBaseAddr, 16)
        Set afe_rx_cfg_10 = (New REGISTER_AFE_DIG_afe_rx_cfg_10)(aBaseAddr, 16)
        Set afe_rx_cfg_11 = (New REGISTER_AFE_DIG_afe_rx_cfg_11)(aBaseAddr, 16)
        Set afe_rx_cfg_12 = (New REGISTER_AFE_DIG_afe_rx_cfg_12)(aBaseAddr, 16)
        Set afe_rx_cfg_13 = (New REGISTER_AFE_DIG_afe_rx_cfg_13)(aBaseAddr, 16)
        Set afe_rx_cfg_14 = (New REGISTER_AFE_DIG_afe_rx_cfg_14)(aBaseAddr, 16)
        Set afe_rx_cfg_15 = (New REGISTER_AFE_DIG_afe_rx_cfg_15)(aBaseAddr, 16)
        Set afe_acb_ctrl = (New REGISTER_AFE_DIG_afe_acb_ctrl)(aBaseAddr, 16)
        Set afe_acb_wrdata = (New REGISTER_AFE_DIG_afe_acb_wrdata)(aBaseAddr, 16)
        Set afe_acb_rddata = (New REGISTER_AFE_DIG_afe_acb_rddata)(aBaseAddr, 16)
        Set afe_pll_cfg_0 = (New REGISTER_AFE_DIG_afe_pll_cfg_0)(aBaseAddr, 16)
        Set afe_pll_cfg_1 = (New REGISTER_AFE_DIG_afe_pll_cfg_1)(aBaseAddr, 16)
        Set afe_pll_cfg_2 = (New REGISTER_AFE_DIG_afe_pll_cfg_2)(aBaseAddr, 16)
        Set afe_pll_cfg_3 = (New REGISTER_AFE_DIG_afe_pll_cfg_3)(aBaseAddr, 16)
        Set afe_pll_ctrl = (New REGISTER_AFE_DIG_afe_pll_ctrl)(aBaseAddr, 16)
        Set afe_clk_cfg_0 = (New REGISTER_AFE_DIG_afe_clk_cfg_0)(aBaseAddr, 16)
        Set afe_clk_cfg_1 = (New REGISTER_AFE_DIG_afe_clk_cfg_1)(aBaseAddr, 16)
        Set afe_clk_cfg_2 = (New REGISTER_AFE_DIG_afe_clk_cfg_2)(aBaseAddr, 16)
        Set afe_clk_cfg_3 = (New REGISTER_AFE_DIG_afe_clk_cfg_3)(aBaseAddr, 16)
        Set afe_clk_cfg_4 = (New REGISTER_AFE_DIG_afe_clk_cfg_4)(aBaseAddr, 16)
        Set afe_bias_cfg = (New REGISTER_AFE_DIG_afe_bias_cfg)(aBaseAddr, 16)
        Set rcal_ctrl = (New REGISTER_AFE_DIG_rcal_ctrl)(aBaseAddr, 16)
        Set rccal_ctrl = (New REGISTER_AFE_DIG_rccal_ctrl)(aBaseAddr, 16)
        Set bias_trim_bg = (New REGISTER_AFE_DIG_bias_trim_bg)(aBaseAddr, 16)
        Set idac_abist = (New REGISTER_AFE_DIG_idac_abist)(aBaseAddr, 16)
        Set txclk_ph = (New REGISTER_AFE_DIG_txclk_ph)(aBaseAddr, 16)
        Set pll_test = (New REGISTER_AFE_DIG_pll_test)(aBaseAddr, 16)
        Set r_rc_cal_status = (New REGISTER_AFE_DIG_r_rc_cal_status)(aBaseAddr, 16)
        Set pll_status = (New REGISTER_AFE_DIG_pll_status)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AFE_DIG = CreateObject("System.Collections.ArrayList")
AFE_DIG.Add ((New AFE_DIG_INSTANCE)(&H49034800))


