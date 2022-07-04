

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


'' @REGISTER : BR_PCS_exp90
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' JABBER_DET                                 [15:15]          get_JABBER_DET
''                                                             set_JABBER_DET
''                                                             read_JABBER_DET
''                                                             write_JABBER_DET
''---------------------------------------------------------------------------------
'' BR_SCR_STATUS                              [14:13]          get_BR_SCR_STATUS
''                                                             set_BR_SCR_STATUS
''                                                             read_BR_SCR_STATUS
''                                                             write_BR_SCR_STATUS
''---------------------------------------------------------------------------------
'' BR_ALIGN_STATE                             [12:10]          get_BR_ALIGN_STATE
''                                                             set_BR_ALIGN_STATE
''                                                             read_BR_ALIGN_STATE
''                                                             write_BR_ALIGN_STATE
''---------------------------------------------------------------------------------
'' BR_RX_STATE                                [9:6]            get_BR_RX_STATE
''                                                             set_BR_RX_STATE
''                                                             read_BR_RX_STATE
''                                                             write_BR_RX_STATE
''---------------------------------------------------------------------------------
'' BR_PCS_STATE                               [5:2]            get_BR_PCS_STATE
''                                                             set_BR_PCS_STATE
''                                                             read_BR_PCS_STATE
''                                                             write_BR_PCS_STATE
''---------------------------------------------------------------------------------
'' BR_FORCE_LINK_CTL                          [1:1]            get_BR_FORCE_LINK_CTL
''                                                             set_BR_FORCE_LINK_CTL
''                                                             read_BR_FORCE_LINK_CTL
''                                                             write_BR_FORCE_LINK_CTL
''---------------------------------------------------------------------------------
'' BR_EN                                      [0:0]            get_BR_EN
''                                                             set_BR_EN
''                                                             read_BR_EN
''                                                             write_BR_EN
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp90
    Private write_JABBER_DET_value
    Private read_JABBER_DET_value
    Private flag_JABBER_DET
    Private write_BR_SCR_STATUS_value
    Private read_BR_SCR_STATUS_value
    Private flag_BR_SCR_STATUS
    Private write_BR_ALIGN_STATE_value
    Private read_BR_ALIGN_STATE_value
    Private flag_BR_ALIGN_STATE
    Private write_BR_RX_STATE_value
    Private read_BR_RX_STATE_value
    Private flag_BR_RX_STATE
    Private write_BR_PCS_STATE_value
    Private read_BR_PCS_STATE_value
    Private flag_BR_PCS_STATE
    Private write_BR_FORCE_LINK_CTL_value
    Private read_BR_FORCE_LINK_CTL_value
    Private flag_BR_FORCE_LINK_CTL
    Private write_BR_EN_value
    Private read_BR_EN_value
    Private flag_BR_EN

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

    Property Get get_JABBER_DET
        get_JABBER_DET = read_JABBER_DET_value
    End Property

    Property Let set_JABBER_DET(aData)
        write_JABBER_DET_value = aData
        flag_JABBER_DET        = &H1
    End Property

    Property Get read_JABBER_DET
        read
        read_JABBER_DET = read_JABBER_DET_value
    End Property

    Property Let write_JABBER_DET(aData)
        set_JABBER_DET = aData
        write
    End Property

    Property Get get_BR_SCR_STATUS
        get_BR_SCR_STATUS = read_BR_SCR_STATUS_value
    End Property

    Property Let set_BR_SCR_STATUS(aData)
        write_BR_SCR_STATUS_value = aData
        flag_BR_SCR_STATUS        = &H1
    End Property

    Property Get read_BR_SCR_STATUS
        read
        read_BR_SCR_STATUS = read_BR_SCR_STATUS_value
    End Property

    Property Let write_BR_SCR_STATUS(aData)
        set_BR_SCR_STATUS = aData
        write
    End Property

    Property Get get_BR_ALIGN_STATE
        get_BR_ALIGN_STATE = read_BR_ALIGN_STATE_value
    End Property

    Property Let set_BR_ALIGN_STATE(aData)
        write_BR_ALIGN_STATE_value = aData
        flag_BR_ALIGN_STATE        = &H1
    End Property

    Property Get read_BR_ALIGN_STATE
        read
        read_BR_ALIGN_STATE = read_BR_ALIGN_STATE_value
    End Property

    Property Let write_BR_ALIGN_STATE(aData)
        set_BR_ALIGN_STATE = aData
        write
    End Property

    Property Get get_BR_RX_STATE
        get_BR_RX_STATE = read_BR_RX_STATE_value
    End Property

    Property Let set_BR_RX_STATE(aData)
        write_BR_RX_STATE_value = aData
        flag_BR_RX_STATE        = &H1
    End Property

    Property Get read_BR_RX_STATE
        read
        read_BR_RX_STATE = read_BR_RX_STATE_value
    End Property

    Property Let write_BR_RX_STATE(aData)
        set_BR_RX_STATE = aData
        write
    End Property

    Property Get get_BR_PCS_STATE
        get_BR_PCS_STATE = read_BR_PCS_STATE_value
    End Property

    Property Let set_BR_PCS_STATE(aData)
        write_BR_PCS_STATE_value = aData
        flag_BR_PCS_STATE        = &H1
    End Property

    Property Get read_BR_PCS_STATE
        read
        read_BR_PCS_STATE = read_BR_PCS_STATE_value
    End Property

    Property Let write_BR_PCS_STATE(aData)
        set_BR_PCS_STATE = aData
        write
    End Property

    Property Get get_BR_FORCE_LINK_CTL
        get_BR_FORCE_LINK_CTL = read_BR_FORCE_LINK_CTL_value
    End Property

    Property Let set_BR_FORCE_LINK_CTL(aData)
        write_BR_FORCE_LINK_CTL_value = aData
        flag_BR_FORCE_LINK_CTL        = &H1
    End Property

    Property Get read_BR_FORCE_LINK_CTL
        read
        read_BR_FORCE_LINK_CTL = read_BR_FORCE_LINK_CTL_value
    End Property

    Property Let write_BR_FORCE_LINK_CTL(aData)
        set_BR_FORCE_LINK_CTL = aData
        write
    End Property

    Property Get get_BR_EN
        get_BR_EN = read_BR_EN_value
    End Property

    Property Let set_BR_EN(aData)
        write_BR_EN_value = aData
        flag_BR_EN        = &H1
    End Property

    Property Get read_BR_EN
        read
        read_BR_EN = read_BR_EN_value
    End Property

    Property Let write_BR_EN(aData)
        set_BR_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_JABBER_DET_value = rightShift(data_low, 15) and &H1
        read_BR_SCR_STATUS_value = rightShift(data_low, 13) and &H3
        read_BR_ALIGN_STATE_value = rightShift(data_low, 10) and &H7
        read_BR_RX_STATE_value = rightShift(data_low, 6) and &Hf
        read_BR_PCS_STATE_value = rightShift(data_low, 2) and &Hf
        read_BR_FORCE_LINK_CTL_value = rightShift(data_low, 1) and &H1
        BR_EN_mask = &H1
        if data_low > LONG_MAX then
            if BR_EN_mask = mask then
                read_BR_EN_value = data_low
            else
                read_BR_EN_value = (data_low - H8000_0000) and BR_EN_mask
            end If
        else
            read_BR_EN_value = data_low and BR_EN_mask
        end If

    End Sub

    Sub write
        If flag_JABBER_DET = &H0 or flag_BR_SCR_STATUS = &H0 or flag_BR_ALIGN_STATE = &H0 or flag_BR_RX_STATE = &H0 or flag_BR_PCS_STATE = &H0 or flag_BR_FORCE_LINK_CTL = &H0 or flag_BR_EN = &H0 Then read
        If flag_JABBER_DET = &H0 Then write_JABBER_DET_value = get_JABBER_DET
        If flag_BR_SCR_STATUS = &H0 Then write_BR_SCR_STATUS_value = get_BR_SCR_STATUS
        If flag_BR_ALIGN_STATE = &H0 Then write_BR_ALIGN_STATE_value = get_BR_ALIGN_STATE
        If flag_BR_RX_STATE = &H0 Then write_BR_RX_STATE_value = get_BR_RX_STATE
        If flag_BR_PCS_STATE = &H0 Then write_BR_PCS_STATE_value = get_BR_PCS_STATE
        If flag_BR_FORCE_LINK_CTL = &H0 Then write_BR_FORCE_LINK_CTL_value = get_BR_FORCE_LINK_CTL
        If flag_BR_EN = &H0 Then write_BR_EN_value = get_BR_EN

        regValue = leftShift((write_JABBER_DET_value and &H1), 15) + leftShift((write_BR_SCR_STATUS_value and &H3), 13) + leftShift((write_BR_ALIGN_STATE_value and &H7), 10) + leftShift((write_BR_RX_STATE_value and &Hf), 6) + leftShift((write_BR_PCS_STATE_value and &Hf), 2) + leftShift((write_BR_FORCE_LINK_CTL_value and &H1), 1) + leftShift((write_BR_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_JABBER_DET_value = rightShift(data_low, 15) and &H1
        read_BR_SCR_STATUS_value = rightShift(data_low, 13) and &H3
        read_BR_ALIGN_STATE_value = rightShift(data_low, 10) and &H7
        read_BR_RX_STATE_value = rightShift(data_low, 6) and &Hf
        read_BR_PCS_STATE_value = rightShift(data_low, 2) and &Hf
        read_BR_FORCE_LINK_CTL_value = rightShift(data_low, 1) and &H1
        BR_EN_mask = &H1
        if data_low > LONG_MAX then
            if BR_EN_mask = mask then
                read_BR_EN_value = data_low
            else
                read_BR_EN_value = (data_low - H8000_0000) and BR_EN_mask
            end If
        else
            read_BR_EN_value = data_low and BR_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_JABBER_DET_value = &H0
        flag_JABBER_DET        = &H0
        write_BR_SCR_STATUS_value = &H0
        flag_BR_SCR_STATUS        = &H0
        write_BR_ALIGN_STATE_value = &H0
        flag_BR_ALIGN_STATE        = &H0
        write_BR_RX_STATE_value = &H0
        flag_BR_RX_STATE        = &H0
        write_BR_PCS_STATE_value = &H0
        flag_BR_PCS_STATE        = &H0
        write_BR_FORCE_LINK_CTL_value = &H0
        flag_BR_FORCE_LINK_CTL        = &H0
        write_BR_EN_value = &H0
        flag_BR_EN        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp91
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BR_N_TOGGLE_DIS_OV                         [14:14]          get_BR_N_TOGGLE_DIS_OV
''                                                             set_BR_N_TOGGLE_DIS_OV
''                                                             read_BR_N_TOGGLE_DIS_OV
''                                                             write_BR_N_TOGGLE_DIS_OV
''---------------------------------------------------------------------------------
'' PAIR_CFG                                   [7:6]            get_PAIR_CFG
''                                                             set_PAIR_CFG
''                                                             read_PAIR_CFG
''                                                             write_PAIR_CFG
''---------------------------------------------------------------------------------
'' UNIDIR_AB                                  [5:5]            get_UNIDIR_AB
''                                                             set_UNIDIR_AB
''                                                             read_UNIDIR_AB
''                                                             write_UNIDIR_AB
''---------------------------------------------------------------------------------
'' UNIDIR_EN                                  [4:4]            get_UNIDIR_EN
''                                                             set_UNIDIR_EN
''                                                             read_UNIDIR_EN
''                                                             write_UNIDIR_EN
''---------------------------------------------------------------------------------
'' BR_N_TOGGLE_DIS_OV_VAL                     [2:2]            get_BR_N_TOGGLE_DIS_OV_VAL
''                                                             set_BR_N_TOGGLE_DIS_OV_VAL
''                                                             read_BR_N_TOGGLE_DIS_OV_VAL
''                                                             write_BR_N_TOGGLE_DIS_OV_VAL
''---------------------------------------------------------------------------------
'' TXSCR_ZERO_SEED                            [1:1]            get_TXSCR_ZERO_SEED
''                                                             set_TXSCR_ZERO_SEED
''                                                             read_TXSCR_ZERO_SEED
''                                                             write_TXSCR_ZERO_SEED
''---------------------------------------------------------------------------------
'' RXSCR_ZERO_SEED                            [0:0]            get_RXSCR_ZERO_SEED
''                                                             set_RXSCR_ZERO_SEED
''                                                             read_RXSCR_ZERO_SEED
''                                                             write_RXSCR_ZERO_SEED
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp91
    Private write_BR_N_TOGGLE_DIS_OV_value
    Private read_BR_N_TOGGLE_DIS_OV_value
    Private flag_BR_N_TOGGLE_DIS_OV
    Private write_PAIR_CFG_value
    Private read_PAIR_CFG_value
    Private flag_PAIR_CFG
    Private write_UNIDIR_AB_value
    Private read_UNIDIR_AB_value
    Private flag_UNIDIR_AB
    Private write_UNIDIR_EN_value
    Private read_UNIDIR_EN_value
    Private flag_UNIDIR_EN
    Private write_BR_N_TOGGLE_DIS_OV_VAL_value
    Private read_BR_N_TOGGLE_DIS_OV_VAL_value
    Private flag_BR_N_TOGGLE_DIS_OV_VAL
    Private write_TXSCR_ZERO_SEED_value
    Private read_TXSCR_ZERO_SEED_value
    Private flag_TXSCR_ZERO_SEED
    Private write_RXSCR_ZERO_SEED_value
    Private read_RXSCR_ZERO_SEED_value
    Private flag_RXSCR_ZERO_SEED

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

    Property Get get_BR_N_TOGGLE_DIS_OV
        get_BR_N_TOGGLE_DIS_OV = read_BR_N_TOGGLE_DIS_OV_value
    End Property

    Property Let set_BR_N_TOGGLE_DIS_OV(aData)
        write_BR_N_TOGGLE_DIS_OV_value = aData
        flag_BR_N_TOGGLE_DIS_OV        = &H1
    End Property

    Property Get read_BR_N_TOGGLE_DIS_OV
        read
        read_BR_N_TOGGLE_DIS_OV = read_BR_N_TOGGLE_DIS_OV_value
    End Property

    Property Let write_BR_N_TOGGLE_DIS_OV(aData)
        set_BR_N_TOGGLE_DIS_OV = aData
        write
    End Property

    Property Get get_PAIR_CFG
        get_PAIR_CFG = read_PAIR_CFG_value
    End Property

    Property Let set_PAIR_CFG(aData)
        write_PAIR_CFG_value = aData
        flag_PAIR_CFG        = &H1
    End Property

    Property Get read_PAIR_CFG
        read
        read_PAIR_CFG = read_PAIR_CFG_value
    End Property

    Property Let write_PAIR_CFG(aData)
        set_PAIR_CFG = aData
        write
    End Property

    Property Get get_UNIDIR_AB
        get_UNIDIR_AB = read_UNIDIR_AB_value
    End Property

    Property Let set_UNIDIR_AB(aData)
        write_UNIDIR_AB_value = aData
        flag_UNIDIR_AB        = &H1
    End Property

    Property Get read_UNIDIR_AB
        read
        read_UNIDIR_AB = read_UNIDIR_AB_value
    End Property

    Property Let write_UNIDIR_AB(aData)
        set_UNIDIR_AB = aData
        write
    End Property

    Property Get get_UNIDIR_EN
        get_UNIDIR_EN = read_UNIDIR_EN_value
    End Property

    Property Let set_UNIDIR_EN(aData)
        write_UNIDIR_EN_value = aData
        flag_UNIDIR_EN        = &H1
    End Property

    Property Get read_UNIDIR_EN
        read
        read_UNIDIR_EN = read_UNIDIR_EN_value
    End Property

    Property Let write_UNIDIR_EN(aData)
        set_UNIDIR_EN = aData
        write
    End Property

    Property Get get_BR_N_TOGGLE_DIS_OV_VAL
        get_BR_N_TOGGLE_DIS_OV_VAL = read_BR_N_TOGGLE_DIS_OV_VAL_value
    End Property

    Property Let set_BR_N_TOGGLE_DIS_OV_VAL(aData)
        write_BR_N_TOGGLE_DIS_OV_VAL_value = aData
        flag_BR_N_TOGGLE_DIS_OV_VAL        = &H1
    End Property

    Property Get read_BR_N_TOGGLE_DIS_OV_VAL
        read
        read_BR_N_TOGGLE_DIS_OV_VAL = read_BR_N_TOGGLE_DIS_OV_VAL_value
    End Property

    Property Let write_BR_N_TOGGLE_DIS_OV_VAL(aData)
        set_BR_N_TOGGLE_DIS_OV_VAL = aData
        write
    End Property

    Property Get get_TXSCR_ZERO_SEED
        get_TXSCR_ZERO_SEED = read_TXSCR_ZERO_SEED_value
    End Property

    Property Let set_TXSCR_ZERO_SEED(aData)
        write_TXSCR_ZERO_SEED_value = aData
        flag_TXSCR_ZERO_SEED        = &H1
    End Property

    Property Get read_TXSCR_ZERO_SEED
        read
        read_TXSCR_ZERO_SEED = read_TXSCR_ZERO_SEED_value
    End Property

    Property Let write_TXSCR_ZERO_SEED(aData)
        set_TXSCR_ZERO_SEED = aData
        write
    End Property

    Property Get get_RXSCR_ZERO_SEED
        get_RXSCR_ZERO_SEED = read_RXSCR_ZERO_SEED_value
    End Property

    Property Let set_RXSCR_ZERO_SEED(aData)
        write_RXSCR_ZERO_SEED_value = aData
        flag_RXSCR_ZERO_SEED        = &H1
    End Property

    Property Get read_RXSCR_ZERO_SEED
        read
        read_RXSCR_ZERO_SEED = read_RXSCR_ZERO_SEED_value
    End Property

    Property Let write_RXSCR_ZERO_SEED(aData)
        set_RXSCR_ZERO_SEED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_N_TOGGLE_DIS_OV_value = rightShift(data_low, 14) and &H1
        read_PAIR_CFG_value = rightShift(data_low, 6) and &H3
        read_UNIDIR_AB_value = rightShift(data_low, 5) and &H1
        read_UNIDIR_EN_value = rightShift(data_low, 4) and &H1
        read_BR_N_TOGGLE_DIS_OV_VAL_value = rightShift(data_low, 2) and &H1
        read_TXSCR_ZERO_SEED_value = rightShift(data_low, 1) and &H1
        RXSCR_ZERO_SEED_mask = &H1
        if data_low > LONG_MAX then
            if RXSCR_ZERO_SEED_mask = mask then
                read_RXSCR_ZERO_SEED_value = data_low
            else
                read_RXSCR_ZERO_SEED_value = (data_low - H8000_0000) and RXSCR_ZERO_SEED_mask
            end If
        else
            read_RXSCR_ZERO_SEED_value = data_low and RXSCR_ZERO_SEED_mask
        end If

    End Sub

    Sub write
        If flag_BR_N_TOGGLE_DIS_OV = &H0 or flag_PAIR_CFG = &H0 or flag_UNIDIR_AB = &H0 or flag_UNIDIR_EN = &H0 or flag_BR_N_TOGGLE_DIS_OV_VAL = &H0 or flag_TXSCR_ZERO_SEED = &H0 or flag_RXSCR_ZERO_SEED = &H0 Then read
        If flag_BR_N_TOGGLE_DIS_OV = &H0 Then write_BR_N_TOGGLE_DIS_OV_value = get_BR_N_TOGGLE_DIS_OV
        If flag_PAIR_CFG = &H0 Then write_PAIR_CFG_value = get_PAIR_CFG
        If flag_UNIDIR_AB = &H0 Then write_UNIDIR_AB_value = get_UNIDIR_AB
        If flag_UNIDIR_EN = &H0 Then write_UNIDIR_EN_value = get_UNIDIR_EN
        If flag_BR_N_TOGGLE_DIS_OV_VAL = &H0 Then write_BR_N_TOGGLE_DIS_OV_VAL_value = get_BR_N_TOGGLE_DIS_OV_VAL
        If flag_TXSCR_ZERO_SEED = &H0 Then write_TXSCR_ZERO_SEED_value = get_TXSCR_ZERO_SEED
        If flag_RXSCR_ZERO_SEED = &H0 Then write_RXSCR_ZERO_SEED_value = get_RXSCR_ZERO_SEED

        regValue = leftShift((write_BR_N_TOGGLE_DIS_OV_value and &H1), 14) + leftShift((write_PAIR_CFG_value and &H3), 6) + leftShift((write_UNIDIR_AB_value and &H1), 5) + leftShift((write_UNIDIR_EN_value and &H1), 4) + leftShift((write_BR_N_TOGGLE_DIS_OV_VAL_value and &H1), 2) + leftShift((write_TXSCR_ZERO_SEED_value and &H1), 1) + leftShift((write_RXSCR_ZERO_SEED_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_N_TOGGLE_DIS_OV_value = rightShift(data_low, 14) and &H1
        read_PAIR_CFG_value = rightShift(data_low, 6) and &H3
        read_UNIDIR_AB_value = rightShift(data_low, 5) and &H1
        read_UNIDIR_EN_value = rightShift(data_low, 4) and &H1
        read_BR_N_TOGGLE_DIS_OV_VAL_value = rightShift(data_low, 2) and &H1
        read_TXSCR_ZERO_SEED_value = rightShift(data_low, 1) and &H1
        RXSCR_ZERO_SEED_mask = &H1
        if data_low > LONG_MAX then
            if RXSCR_ZERO_SEED_mask = mask then
                read_RXSCR_ZERO_SEED_value = data_low
            else
                read_RXSCR_ZERO_SEED_value = (data_low - H8000_0000) and RXSCR_ZERO_SEED_mask
            end If
        else
            read_RXSCR_ZERO_SEED_value = data_low and RXSCR_ZERO_SEED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BR_N_TOGGLE_DIS_OV_value = &H0
        flag_BR_N_TOGGLE_DIS_OV        = &H0
        write_PAIR_CFG_value = &H0
        flag_PAIR_CFG        = &H0
        write_UNIDIR_AB_value = &H0
        flag_UNIDIR_AB        = &H0
        write_UNIDIR_EN_value = &H0
        flag_UNIDIR_EN        = &H0
        write_BR_N_TOGGLE_DIS_OV_VAL_value = &H0
        flag_BR_N_TOGGLE_DIS_OV_VAL        = &H0
        write_TXSCR_ZERO_SEED_value = &H0
        flag_TXSCR_ZERO_SEED        = &H0
        write_RXSCR_ZERO_SEED_value = &H0
        flag_RXSCR_ZERO_SEED        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp92
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DLLCONV_OV_EN                              [15:15]          get_DLLCONV_OV_EN
''                                                             set_DLLCONV_OV_EN
''                                                             read_DLLCONV_OV_EN
''                                                             write_DLLCONV_OV_EN
''---------------------------------------------------------------------------------
'' DLLCONV_OV_VAL                             [14:14]          get_DLLCONV_OV_VAL
''                                                             set_DLLCONV_OV_VAL
''                                                             read_DLLCONV_OV_VAL
''                                                             write_DLLCONV_OV_VAL
''---------------------------------------------------------------------------------
'' BR_SLAVE_POL_COR_EN                        [13:13]          get_BR_SLAVE_POL_COR_EN
''                                                             set_BR_SLAVE_POL_COR_EN
''                                                             read_BR_SLAVE_POL_COR_EN
''                                                             write_BR_SLAVE_POL_COR_EN
''---------------------------------------------------------------------------------
'' BR_EDGE_RATE_SEL                           [12:11]          get_BR_EDGE_RATE_SEL
''                                                             set_BR_EDGE_RATE_SEL
''                                                             read_BR_EDGE_RATE_SEL
''                                                             write_BR_EDGE_RATE_SEL
''---------------------------------------------------------------------------------
'' BR_PCS_RRNOK_POL_EN                        [10:10]          get_BR_PCS_RRNOK_POL_EN
''                                                             set_BR_PCS_RRNOK_POL_EN
''                                                             read_BR_PCS_RRNOK_POL_EN
''                                                             write_BR_PCS_RRNOK_POL_EN
''---------------------------------------------------------------------------------
'' REM_RCV_2NDPCS_DET                         [9:9]            get_REM_RCV_2NDPCS_DET
''                                                             set_REM_RCV_2NDPCS_DET
''                                                             read_REM_RCV_2NDPCS_DET
''                                                             write_REM_RCV_2NDPCS_DET
''---------------------------------------------------------------------------------
'' BR_PCS_POL_EN                              [8:8]            get_BR_PCS_POL_EN
''                                                             set_BR_PCS_POL_EN
''                                                             read_BR_PCS_POL_EN
''                                                             write_BR_PCS_POL_EN
''---------------------------------------------------------------------------------
'' JAB_MON_DIS                                [7:7]            get_JAB_MON_DIS
''                                                             set_JAB_MON_DIS
''                                                             read_JAB_MON_DIS
''                                                             write_JAB_MON_DIS
''---------------------------------------------------------------------------------
'' BR_AGCSID_TMR_EN                           [6:6]            get_BR_AGCSID_TMR_EN
''                                                             set_BR_AGCSID_TMR_EN
''                                                             read_BR_AGCSID_TMR_EN
''                                                             write_BR_AGCSID_TMR_EN
''---------------------------------------------------------------------------------
'' BR_SYM_XSCR_EN                             [5:5]            get_BR_SYM_XSCR_EN
''                                                             set_BR_SYM_XSCR_EN
''                                                             read_BR_SYM_XSCR_EN
''                                                             write_BR_SYM_XSCR_EN
''---------------------------------------------------------------------------------
'' CHK_DELIMITER                              [4:4]            get_CHK_DELIMITER
''                                                             set_CHK_DELIMITER
''                                                             read_CHK_DELIMITER
''                                                             write_CHK_DELIMITER
''---------------------------------------------------------------------------------
'' TX_READ_DLY                                [3:2]            get_TX_READ_DLY
''                                                             set_TX_READ_DLY
''                                                             read_TX_READ_DLY
''                                                             write_TX_READ_DLY
''---------------------------------------------------------------------------------
'' RX_READ_DLY                                [1:0]            get_RX_READ_DLY
''                                                             set_RX_READ_DLY
''                                                             read_RX_READ_DLY
''                                                             write_RX_READ_DLY
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp92
    Private write_DLLCONV_OV_EN_value
    Private read_DLLCONV_OV_EN_value
    Private flag_DLLCONV_OV_EN
    Private write_DLLCONV_OV_VAL_value
    Private read_DLLCONV_OV_VAL_value
    Private flag_DLLCONV_OV_VAL
    Private write_BR_SLAVE_POL_COR_EN_value
    Private read_BR_SLAVE_POL_COR_EN_value
    Private flag_BR_SLAVE_POL_COR_EN
    Private write_BR_EDGE_RATE_SEL_value
    Private read_BR_EDGE_RATE_SEL_value
    Private flag_BR_EDGE_RATE_SEL
    Private write_BR_PCS_RRNOK_POL_EN_value
    Private read_BR_PCS_RRNOK_POL_EN_value
    Private flag_BR_PCS_RRNOK_POL_EN
    Private write_REM_RCV_2NDPCS_DET_value
    Private read_REM_RCV_2NDPCS_DET_value
    Private flag_REM_RCV_2NDPCS_DET
    Private write_BR_PCS_POL_EN_value
    Private read_BR_PCS_POL_EN_value
    Private flag_BR_PCS_POL_EN
    Private write_JAB_MON_DIS_value
    Private read_JAB_MON_DIS_value
    Private flag_JAB_MON_DIS
    Private write_BR_AGCSID_TMR_EN_value
    Private read_BR_AGCSID_TMR_EN_value
    Private flag_BR_AGCSID_TMR_EN
    Private write_BR_SYM_XSCR_EN_value
    Private read_BR_SYM_XSCR_EN_value
    Private flag_BR_SYM_XSCR_EN
    Private write_CHK_DELIMITER_value
    Private read_CHK_DELIMITER_value
    Private flag_CHK_DELIMITER
    Private write_TX_READ_DLY_value
    Private read_TX_READ_DLY_value
    Private flag_TX_READ_DLY
    Private write_RX_READ_DLY_value
    Private read_RX_READ_DLY_value
    Private flag_RX_READ_DLY

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

    Property Get get_DLLCONV_OV_EN
        get_DLLCONV_OV_EN = read_DLLCONV_OV_EN_value
    End Property

    Property Let set_DLLCONV_OV_EN(aData)
        write_DLLCONV_OV_EN_value = aData
        flag_DLLCONV_OV_EN        = &H1
    End Property

    Property Get read_DLLCONV_OV_EN
        read
        read_DLLCONV_OV_EN = read_DLLCONV_OV_EN_value
    End Property

    Property Let write_DLLCONV_OV_EN(aData)
        set_DLLCONV_OV_EN = aData
        write
    End Property

    Property Get get_DLLCONV_OV_VAL
        get_DLLCONV_OV_VAL = read_DLLCONV_OV_VAL_value
    End Property

    Property Let set_DLLCONV_OV_VAL(aData)
        write_DLLCONV_OV_VAL_value = aData
        flag_DLLCONV_OV_VAL        = &H1
    End Property

    Property Get read_DLLCONV_OV_VAL
        read
        read_DLLCONV_OV_VAL = read_DLLCONV_OV_VAL_value
    End Property

    Property Let write_DLLCONV_OV_VAL(aData)
        set_DLLCONV_OV_VAL = aData
        write
    End Property

    Property Get get_BR_SLAVE_POL_COR_EN
        get_BR_SLAVE_POL_COR_EN = read_BR_SLAVE_POL_COR_EN_value
    End Property

    Property Let set_BR_SLAVE_POL_COR_EN(aData)
        write_BR_SLAVE_POL_COR_EN_value = aData
        flag_BR_SLAVE_POL_COR_EN        = &H1
    End Property

    Property Get read_BR_SLAVE_POL_COR_EN
        read
        read_BR_SLAVE_POL_COR_EN = read_BR_SLAVE_POL_COR_EN_value
    End Property

    Property Let write_BR_SLAVE_POL_COR_EN(aData)
        set_BR_SLAVE_POL_COR_EN = aData
        write
    End Property

    Property Get get_BR_EDGE_RATE_SEL
        get_BR_EDGE_RATE_SEL = read_BR_EDGE_RATE_SEL_value
    End Property

    Property Let set_BR_EDGE_RATE_SEL(aData)
        write_BR_EDGE_RATE_SEL_value = aData
        flag_BR_EDGE_RATE_SEL        = &H1
    End Property

    Property Get read_BR_EDGE_RATE_SEL
        read
        read_BR_EDGE_RATE_SEL = read_BR_EDGE_RATE_SEL_value
    End Property

    Property Let write_BR_EDGE_RATE_SEL(aData)
        set_BR_EDGE_RATE_SEL = aData
        write
    End Property

    Property Get get_BR_PCS_RRNOK_POL_EN
        get_BR_PCS_RRNOK_POL_EN = read_BR_PCS_RRNOK_POL_EN_value
    End Property

    Property Let set_BR_PCS_RRNOK_POL_EN(aData)
        write_BR_PCS_RRNOK_POL_EN_value = aData
        flag_BR_PCS_RRNOK_POL_EN        = &H1
    End Property

    Property Get read_BR_PCS_RRNOK_POL_EN
        read
        read_BR_PCS_RRNOK_POL_EN = read_BR_PCS_RRNOK_POL_EN_value
    End Property

    Property Let write_BR_PCS_RRNOK_POL_EN(aData)
        set_BR_PCS_RRNOK_POL_EN = aData
        write
    End Property

    Property Get get_REM_RCV_2NDPCS_DET
        get_REM_RCV_2NDPCS_DET = read_REM_RCV_2NDPCS_DET_value
    End Property

    Property Let set_REM_RCV_2NDPCS_DET(aData)
        write_REM_RCV_2NDPCS_DET_value = aData
        flag_REM_RCV_2NDPCS_DET        = &H1
    End Property

    Property Get read_REM_RCV_2NDPCS_DET
        read
        read_REM_RCV_2NDPCS_DET = read_REM_RCV_2NDPCS_DET_value
    End Property

    Property Let write_REM_RCV_2NDPCS_DET(aData)
        set_REM_RCV_2NDPCS_DET = aData
        write
    End Property

    Property Get get_BR_PCS_POL_EN
        get_BR_PCS_POL_EN = read_BR_PCS_POL_EN_value
    End Property

    Property Let set_BR_PCS_POL_EN(aData)
        write_BR_PCS_POL_EN_value = aData
        flag_BR_PCS_POL_EN        = &H1
    End Property

    Property Get read_BR_PCS_POL_EN
        read
        read_BR_PCS_POL_EN = read_BR_PCS_POL_EN_value
    End Property

    Property Let write_BR_PCS_POL_EN(aData)
        set_BR_PCS_POL_EN = aData
        write
    End Property

    Property Get get_JAB_MON_DIS
        get_JAB_MON_DIS = read_JAB_MON_DIS_value
    End Property

    Property Let set_JAB_MON_DIS(aData)
        write_JAB_MON_DIS_value = aData
        flag_JAB_MON_DIS        = &H1
    End Property

    Property Get read_JAB_MON_DIS
        read
        read_JAB_MON_DIS = read_JAB_MON_DIS_value
    End Property

    Property Let write_JAB_MON_DIS(aData)
        set_JAB_MON_DIS = aData
        write
    End Property

    Property Get get_BR_AGCSID_TMR_EN
        get_BR_AGCSID_TMR_EN = read_BR_AGCSID_TMR_EN_value
    End Property

    Property Let set_BR_AGCSID_TMR_EN(aData)
        write_BR_AGCSID_TMR_EN_value = aData
        flag_BR_AGCSID_TMR_EN        = &H1
    End Property

    Property Get read_BR_AGCSID_TMR_EN
        read
        read_BR_AGCSID_TMR_EN = read_BR_AGCSID_TMR_EN_value
    End Property

    Property Let write_BR_AGCSID_TMR_EN(aData)
        set_BR_AGCSID_TMR_EN = aData
        write
    End Property

    Property Get get_BR_SYM_XSCR_EN
        get_BR_SYM_XSCR_EN = read_BR_SYM_XSCR_EN_value
    End Property

    Property Let set_BR_SYM_XSCR_EN(aData)
        write_BR_SYM_XSCR_EN_value = aData
        flag_BR_SYM_XSCR_EN        = &H1
    End Property

    Property Get read_BR_SYM_XSCR_EN
        read
        read_BR_SYM_XSCR_EN = read_BR_SYM_XSCR_EN_value
    End Property

    Property Let write_BR_SYM_XSCR_EN(aData)
        set_BR_SYM_XSCR_EN = aData
        write
    End Property

    Property Get get_CHK_DELIMITER
        get_CHK_DELIMITER = read_CHK_DELIMITER_value
    End Property

    Property Let set_CHK_DELIMITER(aData)
        write_CHK_DELIMITER_value = aData
        flag_CHK_DELIMITER        = &H1
    End Property

    Property Get read_CHK_DELIMITER
        read
        read_CHK_DELIMITER = read_CHK_DELIMITER_value
    End Property

    Property Let write_CHK_DELIMITER(aData)
        set_CHK_DELIMITER = aData
        write
    End Property

    Property Get get_TX_READ_DLY
        get_TX_READ_DLY = read_TX_READ_DLY_value
    End Property

    Property Let set_TX_READ_DLY(aData)
        write_TX_READ_DLY_value = aData
        flag_TX_READ_DLY        = &H1
    End Property

    Property Get read_TX_READ_DLY
        read
        read_TX_READ_DLY = read_TX_READ_DLY_value
    End Property

    Property Let write_TX_READ_DLY(aData)
        set_TX_READ_DLY = aData
        write
    End Property

    Property Get get_RX_READ_DLY
        get_RX_READ_DLY = read_RX_READ_DLY_value
    End Property

    Property Let set_RX_READ_DLY(aData)
        write_RX_READ_DLY_value = aData
        flag_RX_READ_DLY        = &H1
    End Property

    Property Get read_RX_READ_DLY
        read
        read_RX_READ_DLY = read_RX_READ_DLY_value
    End Property

    Property Let write_RX_READ_DLY(aData)
        set_RX_READ_DLY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DLLCONV_OV_EN_value = rightShift(data_low, 15) and &H1
        read_DLLCONV_OV_VAL_value = rightShift(data_low, 14) and &H1
        read_BR_SLAVE_POL_COR_EN_value = rightShift(data_low, 13) and &H1
        read_BR_EDGE_RATE_SEL_value = rightShift(data_low, 11) and &H3
        read_BR_PCS_RRNOK_POL_EN_value = rightShift(data_low, 10) and &H1
        read_REM_RCV_2NDPCS_DET_value = rightShift(data_low, 9) and &H1
        read_BR_PCS_POL_EN_value = rightShift(data_low, 8) and &H1
        read_JAB_MON_DIS_value = rightShift(data_low, 7) and &H1
        read_BR_AGCSID_TMR_EN_value = rightShift(data_low, 6) and &H1
        read_BR_SYM_XSCR_EN_value = rightShift(data_low, 5) and &H1
        read_CHK_DELIMITER_value = rightShift(data_low, 4) and &H1
        read_TX_READ_DLY_value = rightShift(data_low, 2) and &H3
        RX_READ_DLY_mask = &H3
        if data_low > LONG_MAX then
            if RX_READ_DLY_mask = mask then
                read_RX_READ_DLY_value = data_low
            else
                read_RX_READ_DLY_value = (data_low - H8000_0000) and RX_READ_DLY_mask
            end If
        else
            read_RX_READ_DLY_value = data_low and RX_READ_DLY_mask
        end If

    End Sub

    Sub write
        If flag_DLLCONV_OV_EN = &H0 or flag_DLLCONV_OV_VAL = &H0 or flag_BR_SLAVE_POL_COR_EN = &H0 or flag_BR_EDGE_RATE_SEL = &H0 or flag_BR_PCS_RRNOK_POL_EN = &H0 or flag_REM_RCV_2NDPCS_DET = &H0 or flag_BR_PCS_POL_EN = &H0 or flag_JAB_MON_DIS = &H0 or flag_BR_AGCSID_TMR_EN = &H0 or flag_BR_SYM_XSCR_EN = &H0 or flag_CHK_DELIMITER = &H0 or flag_TX_READ_DLY = &H0 or flag_RX_READ_DLY = &H0 Then read
        If flag_DLLCONV_OV_EN = &H0 Then write_DLLCONV_OV_EN_value = get_DLLCONV_OV_EN
        If flag_DLLCONV_OV_VAL = &H0 Then write_DLLCONV_OV_VAL_value = get_DLLCONV_OV_VAL
        If flag_BR_SLAVE_POL_COR_EN = &H0 Then write_BR_SLAVE_POL_COR_EN_value = get_BR_SLAVE_POL_COR_EN
        If flag_BR_EDGE_RATE_SEL = &H0 Then write_BR_EDGE_RATE_SEL_value = get_BR_EDGE_RATE_SEL
        If flag_BR_PCS_RRNOK_POL_EN = &H0 Then write_BR_PCS_RRNOK_POL_EN_value = get_BR_PCS_RRNOK_POL_EN
        If flag_REM_RCV_2NDPCS_DET = &H0 Then write_REM_RCV_2NDPCS_DET_value = get_REM_RCV_2NDPCS_DET
        If flag_BR_PCS_POL_EN = &H0 Then write_BR_PCS_POL_EN_value = get_BR_PCS_POL_EN
        If flag_JAB_MON_DIS = &H0 Then write_JAB_MON_DIS_value = get_JAB_MON_DIS
        If flag_BR_AGCSID_TMR_EN = &H0 Then write_BR_AGCSID_TMR_EN_value = get_BR_AGCSID_TMR_EN
        If flag_BR_SYM_XSCR_EN = &H0 Then write_BR_SYM_XSCR_EN_value = get_BR_SYM_XSCR_EN
        If flag_CHK_DELIMITER = &H0 Then write_CHK_DELIMITER_value = get_CHK_DELIMITER
        If flag_TX_READ_DLY = &H0 Then write_TX_READ_DLY_value = get_TX_READ_DLY
        If flag_RX_READ_DLY = &H0 Then write_RX_READ_DLY_value = get_RX_READ_DLY

        regValue = leftShift((write_DLLCONV_OV_EN_value and &H1), 15) + leftShift((write_DLLCONV_OV_VAL_value and &H1), 14) + leftShift((write_BR_SLAVE_POL_COR_EN_value and &H1), 13) + leftShift((write_BR_EDGE_RATE_SEL_value and &H3), 11) + leftShift((write_BR_PCS_RRNOK_POL_EN_value and &H1), 10) + leftShift((write_REM_RCV_2NDPCS_DET_value and &H1), 9) + leftShift((write_BR_PCS_POL_EN_value and &H1), 8) + leftShift((write_JAB_MON_DIS_value and &H1), 7) + leftShift((write_BR_AGCSID_TMR_EN_value and &H1), 6) + leftShift((write_BR_SYM_XSCR_EN_value and &H1), 5) + leftShift((write_CHK_DELIMITER_value and &H1), 4) + leftShift((write_TX_READ_DLY_value and &H3), 2) + leftShift((write_RX_READ_DLY_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DLLCONV_OV_EN_value = rightShift(data_low, 15) and &H1
        read_DLLCONV_OV_VAL_value = rightShift(data_low, 14) and &H1
        read_BR_SLAVE_POL_COR_EN_value = rightShift(data_low, 13) and &H1
        read_BR_EDGE_RATE_SEL_value = rightShift(data_low, 11) and &H3
        read_BR_PCS_RRNOK_POL_EN_value = rightShift(data_low, 10) and &H1
        read_REM_RCV_2NDPCS_DET_value = rightShift(data_low, 9) and &H1
        read_BR_PCS_POL_EN_value = rightShift(data_low, 8) and &H1
        read_JAB_MON_DIS_value = rightShift(data_low, 7) and &H1
        read_BR_AGCSID_TMR_EN_value = rightShift(data_low, 6) and &H1
        read_BR_SYM_XSCR_EN_value = rightShift(data_low, 5) and &H1
        read_CHK_DELIMITER_value = rightShift(data_low, 4) and &H1
        read_TX_READ_DLY_value = rightShift(data_low, 2) and &H3
        RX_READ_DLY_mask = &H3
        if data_low > LONG_MAX then
            if RX_READ_DLY_mask = mask then
                read_RX_READ_DLY_value = data_low
            else
                read_RX_READ_DLY_value = (data_low - H8000_0000) and RX_READ_DLY_mask
            end If
        else
            read_RX_READ_DLY_value = data_low and RX_READ_DLY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DLLCONV_OV_EN_value = &H0
        flag_DLLCONV_OV_EN        = &H0
        write_DLLCONV_OV_VAL_value = &H0
        flag_DLLCONV_OV_VAL        = &H0
        write_BR_SLAVE_POL_COR_EN_value = &H0
        flag_BR_SLAVE_POL_COR_EN        = &H0
        write_BR_EDGE_RATE_SEL_value = &H0
        flag_BR_EDGE_RATE_SEL        = &H0
        write_BR_PCS_RRNOK_POL_EN_value = &H0
        flag_BR_PCS_RRNOK_POL_EN        = &H0
        write_REM_RCV_2NDPCS_DET_value = &H0
        flag_REM_RCV_2NDPCS_DET        = &H0
        write_BR_PCS_POL_EN_value = &H0
        flag_BR_PCS_POL_EN        = &H0
        write_JAB_MON_DIS_value = &H0
        flag_JAB_MON_DIS        = &H0
        write_BR_AGCSID_TMR_EN_value = &H0
        flag_BR_AGCSID_TMR_EN        = &H0
        write_BR_SYM_XSCR_EN_value = &H0
        flag_BR_SYM_XSCR_EN        = &H0
        write_CHK_DELIMITER_value = &H0
        flag_CHK_DELIMITER        = &H0
        write_TX_READ_DLY_value = &H0
        flag_TX_READ_DLY        = &H0
        write_RX_READ_DLY_value = &H0
        flag_RX_READ_DLY        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp93
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:12]          get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' PMS_RX_BLOCK_DIS                           [11:11]          get_PMS_RX_BLOCK_DIS
''                                                             set_PMS_RX_BLOCK_DIS
''                                                             read_PMS_RX_BLOCK_DIS
''                                                             write_PMS_RX_BLOCK_DIS
''---------------------------------------------------------------------------------
'' CONTI_LPS_DIS                              [10:10]          get_CONTI_LPS_DIS
''                                                             set_CONTI_LPS_DIS
''                                                             read_CONTI_LPS_DIS
''                                                             write_CONTI_LPS_DIS
''---------------------------------------------------------------------------------
'' TX_LPS_WUR_OPT                             [9:8]            get_TX_LPS_WUR_OPT
''                                                             set_TX_LPS_WUR_OPT
''                                                             read_TX_LPS_WUR_OPT
''                                                             write_TX_LPS_WUR_OPT
''---------------------------------------------------------------------------------
'' SEND_Z_DET_OPT                             [7:6]            get_SEND_Z_DET_OPT
''                                                             set_SEND_Z_DET_OPT
''                                                             read_SEND_Z_DET_OPT
''                                                             write_SEND_Z_DET_OPT
''---------------------------------------------------------------------------------
'' TX_CHANNEL_DISABLE_AB                      [5:4]            get_TX_CHANNEL_DISABLE_AB
''                                                             set_TX_CHANNEL_DISABLE_AB
''                                                             read_TX_CHANNEL_DISABLE_AB
''                                                             write_TX_CHANNEL_DISABLE_AB
''---------------------------------------------------------------------------------
'' PACKET_SIZE                                [2:2]            get_PACKET_SIZE
''                                                             set_PACKET_SIZE
''                                                             read_PACKET_SIZE
''                                                             write_PACKET_SIZE
''---------------------------------------------------------------------------------
'' SCRAMBLER_TEST                             [1:1]            get_SCRAMBLER_TEST
''                                                             set_SCRAMBLER_TEST
''                                                             read_SCRAMBLER_TEST
''                                                             write_SCRAMBLER_TEST
''---------------------------------------------------------------------------------
'' PMS_FASTSIM_MODE                           [0:0]            get_PMS_FASTSIM_MODE
''                                                             set_PMS_FASTSIM_MODE
''                                                             read_PMS_FASTSIM_MODE
''                                                             write_PMS_FASTSIM_MODE
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp93
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_PMS_RX_BLOCK_DIS_value
    Private read_PMS_RX_BLOCK_DIS_value
    Private flag_PMS_RX_BLOCK_DIS
    Private write_CONTI_LPS_DIS_value
    Private read_CONTI_LPS_DIS_value
    Private flag_CONTI_LPS_DIS
    Private write_TX_LPS_WUR_OPT_value
    Private read_TX_LPS_WUR_OPT_value
    Private flag_TX_LPS_WUR_OPT
    Private write_SEND_Z_DET_OPT_value
    Private read_SEND_Z_DET_OPT_value
    Private flag_SEND_Z_DET_OPT
    Private write_TX_CHANNEL_DISABLE_AB_value
    Private read_TX_CHANNEL_DISABLE_AB_value
    Private flag_TX_CHANNEL_DISABLE_AB
    Private write_PACKET_SIZE_value
    Private read_PACKET_SIZE_value
    Private flag_PACKET_SIZE
    Private write_SCRAMBLER_TEST_value
    Private read_SCRAMBLER_TEST_value
    Private flag_SCRAMBLER_TEST
    Private write_PMS_FASTSIM_MODE_value
    Private read_PMS_FASTSIM_MODE_value
    Private flag_PMS_FASTSIM_MODE

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_PMS_RX_BLOCK_DIS
        get_PMS_RX_BLOCK_DIS = read_PMS_RX_BLOCK_DIS_value
    End Property

    Property Let set_PMS_RX_BLOCK_DIS(aData)
        write_PMS_RX_BLOCK_DIS_value = aData
        flag_PMS_RX_BLOCK_DIS        = &H1
    End Property

    Property Get read_PMS_RX_BLOCK_DIS
        read
        read_PMS_RX_BLOCK_DIS = read_PMS_RX_BLOCK_DIS_value
    End Property

    Property Let write_PMS_RX_BLOCK_DIS(aData)
        set_PMS_RX_BLOCK_DIS = aData
        write
    End Property

    Property Get get_CONTI_LPS_DIS
        get_CONTI_LPS_DIS = read_CONTI_LPS_DIS_value
    End Property

    Property Let set_CONTI_LPS_DIS(aData)
        write_CONTI_LPS_DIS_value = aData
        flag_CONTI_LPS_DIS        = &H1
    End Property

    Property Get read_CONTI_LPS_DIS
        read
        read_CONTI_LPS_DIS = read_CONTI_LPS_DIS_value
    End Property

    Property Let write_CONTI_LPS_DIS(aData)
        set_CONTI_LPS_DIS = aData
        write
    End Property

    Property Get get_TX_LPS_WUR_OPT
        get_TX_LPS_WUR_OPT = read_TX_LPS_WUR_OPT_value
    End Property

    Property Let set_TX_LPS_WUR_OPT(aData)
        write_TX_LPS_WUR_OPT_value = aData
        flag_TX_LPS_WUR_OPT        = &H1
    End Property

    Property Get read_TX_LPS_WUR_OPT
        read
        read_TX_LPS_WUR_OPT = read_TX_LPS_WUR_OPT_value
    End Property

    Property Let write_TX_LPS_WUR_OPT(aData)
        set_TX_LPS_WUR_OPT = aData
        write
    End Property

    Property Get get_SEND_Z_DET_OPT
        get_SEND_Z_DET_OPT = read_SEND_Z_DET_OPT_value
    End Property

    Property Let set_SEND_Z_DET_OPT(aData)
        write_SEND_Z_DET_OPT_value = aData
        flag_SEND_Z_DET_OPT        = &H1
    End Property

    Property Get read_SEND_Z_DET_OPT
        read
        read_SEND_Z_DET_OPT = read_SEND_Z_DET_OPT_value
    End Property

    Property Let write_SEND_Z_DET_OPT(aData)
        set_SEND_Z_DET_OPT = aData
        write
    End Property

    Property Get get_TX_CHANNEL_DISABLE_AB
        get_TX_CHANNEL_DISABLE_AB = read_TX_CHANNEL_DISABLE_AB_value
    End Property

    Property Let set_TX_CHANNEL_DISABLE_AB(aData)
        write_TX_CHANNEL_DISABLE_AB_value = aData
        flag_TX_CHANNEL_DISABLE_AB        = &H1
    End Property

    Property Get read_TX_CHANNEL_DISABLE_AB
        read
        read_TX_CHANNEL_DISABLE_AB = read_TX_CHANNEL_DISABLE_AB_value
    End Property

    Property Let write_TX_CHANNEL_DISABLE_AB(aData)
        set_TX_CHANNEL_DISABLE_AB = aData
        write
    End Property

    Property Get get_PACKET_SIZE
        get_PACKET_SIZE = read_PACKET_SIZE_value
    End Property

    Property Let set_PACKET_SIZE(aData)
        write_PACKET_SIZE_value = aData
        flag_PACKET_SIZE        = &H1
    End Property

    Property Get read_PACKET_SIZE
        read
        read_PACKET_SIZE = read_PACKET_SIZE_value
    End Property

    Property Let write_PACKET_SIZE(aData)
        set_PACKET_SIZE = aData
        write
    End Property

    Property Get get_SCRAMBLER_TEST
        get_SCRAMBLER_TEST = read_SCRAMBLER_TEST_value
    End Property

    Property Let set_SCRAMBLER_TEST(aData)
        write_SCRAMBLER_TEST_value = aData
        flag_SCRAMBLER_TEST        = &H1
    End Property

    Property Get read_SCRAMBLER_TEST
        read
        read_SCRAMBLER_TEST = read_SCRAMBLER_TEST_value
    End Property

    Property Let write_SCRAMBLER_TEST(aData)
        set_SCRAMBLER_TEST = aData
        write
    End Property

    Property Get get_PMS_FASTSIM_MODE
        get_PMS_FASTSIM_MODE = read_PMS_FASTSIM_MODE_value
    End Property

    Property Let set_PMS_FASTSIM_MODE(aData)
        write_PMS_FASTSIM_MODE_value = aData
        flag_PMS_FASTSIM_MODE        = &H1
    End Property

    Property Get read_PMS_FASTSIM_MODE
        read
        read_PMS_FASTSIM_MODE = read_PMS_FASTSIM_MODE_value
    End Property

    Property Let write_PMS_FASTSIM_MODE(aData)
        set_PMS_FASTSIM_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 12) and &Hf
        read_PMS_RX_BLOCK_DIS_value = rightShift(data_low, 11) and &H1
        read_CONTI_LPS_DIS_value = rightShift(data_low, 10) and &H1
        read_TX_LPS_WUR_OPT_value = rightShift(data_low, 8) and &H3
        read_SEND_Z_DET_OPT_value = rightShift(data_low, 6) and &H3
        read_TX_CHANNEL_DISABLE_AB_value = rightShift(data_low, 4) and &H3
        read_PACKET_SIZE_value = rightShift(data_low, 2) and &H1
        read_SCRAMBLER_TEST_value = rightShift(data_low, 1) and &H1
        PMS_FASTSIM_MODE_mask = &H1
        if data_low > LONG_MAX then
            if PMS_FASTSIM_MODE_mask = mask then
                read_PMS_FASTSIM_MODE_value = data_low
            else
                read_PMS_FASTSIM_MODE_value = (data_low - H8000_0000) and PMS_FASTSIM_MODE_mask
            end If
        else
            read_PMS_FASTSIM_MODE_value = data_low and PMS_FASTSIM_MODE_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 or flag_PMS_RX_BLOCK_DIS = &H0 or flag_CONTI_LPS_DIS = &H0 or flag_TX_LPS_WUR_OPT = &H0 or flag_SEND_Z_DET_OPT = &H0 or flag_TX_CHANNEL_DISABLE_AB = &H0 or flag_PACKET_SIZE = &H0 or flag_SCRAMBLER_TEST = &H0 or flag_PMS_FASTSIM_MODE = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_PMS_RX_BLOCK_DIS = &H0 Then write_PMS_RX_BLOCK_DIS_value = get_PMS_RX_BLOCK_DIS
        If flag_CONTI_LPS_DIS = &H0 Then write_CONTI_LPS_DIS_value = get_CONTI_LPS_DIS
        If flag_TX_LPS_WUR_OPT = &H0 Then write_TX_LPS_WUR_OPT_value = get_TX_LPS_WUR_OPT
        If flag_SEND_Z_DET_OPT = &H0 Then write_SEND_Z_DET_OPT_value = get_SEND_Z_DET_OPT
        If flag_TX_CHANNEL_DISABLE_AB = &H0 Then write_TX_CHANNEL_DISABLE_AB_value = get_TX_CHANNEL_DISABLE_AB
        If flag_PACKET_SIZE = &H0 Then write_PACKET_SIZE_value = get_PACKET_SIZE
        If flag_SCRAMBLER_TEST = &H0 Then write_SCRAMBLER_TEST_value = get_SCRAMBLER_TEST
        If flag_PMS_FASTSIM_MODE = &H0 Then write_PMS_FASTSIM_MODE_value = get_PMS_FASTSIM_MODE

        regValue = leftShift((write_Reserved_value and &Hf), 12) + leftShift((write_PMS_RX_BLOCK_DIS_value and &H1), 11) + leftShift((write_CONTI_LPS_DIS_value and &H1), 10) + leftShift((write_TX_LPS_WUR_OPT_value and &H3), 8) + leftShift((write_SEND_Z_DET_OPT_value and &H3), 6) + leftShift((write_TX_CHANNEL_DISABLE_AB_value and &H3), 4) + leftShift((write_PACKET_SIZE_value and &H1), 2) + leftShift((write_SCRAMBLER_TEST_value and &H1), 1) + leftShift((write_PMS_FASTSIM_MODE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 12) and &Hf
        read_PMS_RX_BLOCK_DIS_value = rightShift(data_low, 11) and &H1
        read_CONTI_LPS_DIS_value = rightShift(data_low, 10) and &H1
        read_TX_LPS_WUR_OPT_value = rightShift(data_low, 8) and &H3
        read_SEND_Z_DET_OPT_value = rightShift(data_low, 6) and &H3
        read_TX_CHANNEL_DISABLE_AB_value = rightShift(data_low, 4) and &H3
        read_PACKET_SIZE_value = rightShift(data_low, 2) and &H1
        read_SCRAMBLER_TEST_value = rightShift(data_low, 1) and &H1
        PMS_FASTSIM_MODE_mask = &H1
        if data_low > LONG_MAX then
            if PMS_FASTSIM_MODE_mask = mask then
                read_PMS_FASTSIM_MODE_value = data_low
            else
                read_PMS_FASTSIM_MODE_value = (data_low - H8000_0000) and PMS_FASTSIM_MODE_mask
            end If
        else
            read_PMS_FASTSIM_MODE_value = data_low and PMS_FASTSIM_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_PMS_RX_BLOCK_DIS_value = &H0
        flag_PMS_RX_BLOCK_DIS        = &H0
        write_CONTI_LPS_DIS_value = &H0
        flag_CONTI_LPS_DIS        = &H0
        write_TX_LPS_WUR_OPT_value = &H0
        flag_TX_LPS_WUR_OPT        = &H0
        write_SEND_Z_DET_OPT_value = &H0
        flag_SEND_Z_DET_OPT        = &H0
        write_TX_CHANNEL_DISABLE_AB_value = &H0
        flag_TX_CHANNEL_DISABLE_AB        = &H0
        write_PACKET_SIZE_value = &H0
        flag_PACKET_SIZE        = &H0
        write_SCRAMBLER_TEST_value = &H0
        flag_SCRAMBLER_TEST        = &H0
        write_PMS_FASTSIM_MODE_value = &H0
        flag_PMS_FASTSIM_MODE        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp94
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:0]           get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp94
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Reserved_mask = &Hffff
        if data_low > LONG_MAX then
            if Reserved_mask = mask then
                read_Reserved_value = data_low
            else
                read_Reserved_value = (data_low - H8000_0000) and Reserved_mask
            end If
        else
            read_Reserved_value = data_low and Reserved_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved

        regValue = leftShift((write_Reserved_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Reserved_mask = &Hffff
        if data_low > LONG_MAX then
            if Reserved_mask = mask then
                read_Reserved_value = data_low
            else
                read_Reserved_value = (data_low - H8000_0000) and Reserved_mask
            end If
        else
            read_Reserved_value = data_low and Reserved_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp95
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:0]           get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp95
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Reserved_mask = &Hffff
        if data_low > LONG_MAX then
            if Reserved_mask = mask then
                read_Reserved_value = data_low
            else
                read_Reserved_value = (data_low - H8000_0000) and Reserved_mask
            end If
        else
            read_Reserved_value = data_low and Reserved_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved

        regValue = leftShift((write_Reserved_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Reserved_mask = &Hffff
        if data_low > LONG_MAX then
            if Reserved_mask = mask then
                read_Reserved_value = data_low
            else
                read_Reserved_value = (data_low - H8000_0000) and Reserved_mask
            end If
        else
            read_Reserved_value = data_low and Reserved_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp96
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SKEW_ADJ_A                                 [15:12]          get_SKEW_ADJ_A
''                                                             set_SKEW_ADJ_A
''                                                             read_SKEW_ADJ_A
''                                                             write_SKEW_ADJ_A
''---------------------------------------------------------------------------------
'' SKEW_ADJ_B                                 [11:8]           get_SKEW_ADJ_B
''                                                             set_SKEW_ADJ_B
''                                                             read_SKEW_ADJ_B
''                                                             write_SKEW_ADJ_B
''---------------------------------------------------------------------------------
'' error_pair_swap                            [6:6]            get_error_pair_swap
''                                                             set_error_pair_swap
''                                                             read_error_pair_swap
''                                                             write_error_pair_swap
''---------------------------------------------------------------------------------
'' pairSettingsValid                          [5:5]            get_pairSettingsValid
''                                                             set_pairSettingsValid
''                                                             read_pairSettingsValid
''                                                             write_pairSettingsValid
''---------------------------------------------------------------------------------
'' swapAB                                     [4:4]            get_swapAB
''                                                             set_swapAB
''                                                             read_swapAB
''                                                             write_swapAB
''---------------------------------------------------------------------------------
'' polarityB                                  [3:3]            get_polarityB
''                                                             set_polarityB
''                                                             read_polarityB
''                                                             write_polarityB
''---------------------------------------------------------------------------------
'' polarityA                                  [2:2]            get_polarityA
''                                                             set_polarityA
''                                                             read_polarityA
''                                                             write_polarityA
''---------------------------------------------------------------------------------
'' pairBSelect                                [1:1]            get_pairBSelect
''                                                             set_pairBSelect
''                                                             read_pairBSelect
''                                                             write_pairBSelect
''---------------------------------------------------------------------------------
'' pairASelect                                [0:0]            get_pairASelect
''                                                             set_pairASelect
''                                                             read_pairASelect
''                                                             write_pairASelect
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp96
    Private write_SKEW_ADJ_A_value
    Private read_SKEW_ADJ_A_value
    Private flag_SKEW_ADJ_A
    Private write_SKEW_ADJ_B_value
    Private read_SKEW_ADJ_B_value
    Private flag_SKEW_ADJ_B
    Private write_error_pair_swap_value
    Private read_error_pair_swap_value
    Private flag_error_pair_swap
    Private write_pairSettingsValid_value
    Private read_pairSettingsValid_value
    Private flag_pairSettingsValid
    Private write_swapAB_value
    Private read_swapAB_value
    Private flag_swapAB
    Private write_polarityB_value
    Private read_polarityB_value
    Private flag_polarityB
    Private write_polarityA_value
    Private read_polarityA_value
    Private flag_polarityA
    Private write_pairBSelect_value
    Private read_pairBSelect_value
    Private flag_pairBSelect
    Private write_pairASelect_value
    Private read_pairASelect_value
    Private flag_pairASelect

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

    Property Get get_SKEW_ADJ_A
        get_SKEW_ADJ_A = read_SKEW_ADJ_A_value
    End Property

    Property Let set_SKEW_ADJ_A(aData)
        write_SKEW_ADJ_A_value = aData
        flag_SKEW_ADJ_A        = &H1
    End Property

    Property Get read_SKEW_ADJ_A
        read
        read_SKEW_ADJ_A = read_SKEW_ADJ_A_value
    End Property

    Property Let write_SKEW_ADJ_A(aData)
        set_SKEW_ADJ_A = aData
        write
    End Property

    Property Get get_SKEW_ADJ_B
        get_SKEW_ADJ_B = read_SKEW_ADJ_B_value
    End Property

    Property Let set_SKEW_ADJ_B(aData)
        write_SKEW_ADJ_B_value = aData
        flag_SKEW_ADJ_B        = &H1
    End Property

    Property Get read_SKEW_ADJ_B
        read
        read_SKEW_ADJ_B = read_SKEW_ADJ_B_value
    End Property

    Property Let write_SKEW_ADJ_B(aData)
        set_SKEW_ADJ_B = aData
        write
    End Property

    Property Get get_error_pair_swap
        get_error_pair_swap = read_error_pair_swap_value
    End Property

    Property Let set_error_pair_swap(aData)
        write_error_pair_swap_value = aData
        flag_error_pair_swap        = &H1
    End Property

    Property Get read_error_pair_swap
        read
        read_error_pair_swap = read_error_pair_swap_value
    End Property

    Property Let write_error_pair_swap(aData)
        set_error_pair_swap = aData
        write
    End Property

    Property Get get_pairSettingsValid
        get_pairSettingsValid = read_pairSettingsValid_value
    End Property

    Property Let set_pairSettingsValid(aData)
        write_pairSettingsValid_value = aData
        flag_pairSettingsValid        = &H1
    End Property

    Property Get read_pairSettingsValid
        read
        read_pairSettingsValid = read_pairSettingsValid_value
    End Property

    Property Let write_pairSettingsValid(aData)
        set_pairSettingsValid = aData
        write
    End Property

    Property Get get_swapAB
        get_swapAB = read_swapAB_value
    End Property

    Property Let set_swapAB(aData)
        write_swapAB_value = aData
        flag_swapAB        = &H1
    End Property

    Property Get read_swapAB
        read
        read_swapAB = read_swapAB_value
    End Property

    Property Let write_swapAB(aData)
        set_swapAB = aData
        write
    End Property

    Property Get get_polarityB
        get_polarityB = read_polarityB_value
    End Property

    Property Let set_polarityB(aData)
        write_polarityB_value = aData
        flag_polarityB        = &H1
    End Property

    Property Get read_polarityB
        read
        read_polarityB = read_polarityB_value
    End Property

    Property Let write_polarityB(aData)
        set_polarityB = aData
        write
    End Property

    Property Get get_polarityA
        get_polarityA = read_polarityA_value
    End Property

    Property Let set_polarityA(aData)
        write_polarityA_value = aData
        flag_polarityA        = &H1
    End Property

    Property Get read_polarityA
        read
        read_polarityA = read_polarityA_value
    End Property

    Property Let write_polarityA(aData)
        set_polarityA = aData
        write
    End Property

    Property Get get_pairBSelect
        get_pairBSelect = read_pairBSelect_value
    End Property

    Property Let set_pairBSelect(aData)
        write_pairBSelect_value = aData
        flag_pairBSelect        = &H1
    End Property

    Property Get read_pairBSelect
        read
        read_pairBSelect = read_pairBSelect_value
    End Property

    Property Let write_pairBSelect(aData)
        set_pairBSelect = aData
        write
    End Property

    Property Get get_pairASelect
        get_pairASelect = read_pairASelect_value
    End Property

    Property Let set_pairASelect(aData)
        write_pairASelect_value = aData
        flag_pairASelect        = &H1
    End Property

    Property Get read_pairASelect
        read
        read_pairASelect = read_pairASelect_value
    End Property

    Property Let write_pairASelect(aData)
        set_pairASelect = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SKEW_ADJ_A_value = rightShift(data_low, 12) and &Hf
        read_SKEW_ADJ_B_value = rightShift(data_low, 8) and &Hf
        read_error_pair_swap_value = rightShift(data_low, 6) and &H1
        read_pairSettingsValid_value = rightShift(data_low, 5) and &H1
        read_swapAB_value = rightShift(data_low, 4) and &H1
        read_polarityB_value = rightShift(data_low, 3) and &H1
        read_polarityA_value = rightShift(data_low, 2) and &H1
        read_pairBSelect_value = rightShift(data_low, 1) and &H1
        pairASelect_mask = &H1
        if data_low > LONG_MAX then
            if pairASelect_mask = mask then
                read_pairASelect_value = data_low
            else
                read_pairASelect_value = (data_low - H8000_0000) and pairASelect_mask
            end If
        else
            read_pairASelect_value = data_low and pairASelect_mask
        end If

    End Sub

    Sub write
        If flag_SKEW_ADJ_A = &H0 or flag_SKEW_ADJ_B = &H0 or flag_error_pair_swap = &H0 or flag_pairSettingsValid = &H0 or flag_swapAB = &H0 or flag_polarityB = &H0 or flag_polarityA = &H0 or flag_pairBSelect = &H0 or flag_pairASelect = &H0 Then read
        If flag_SKEW_ADJ_A = &H0 Then write_SKEW_ADJ_A_value = get_SKEW_ADJ_A
        If flag_SKEW_ADJ_B = &H0 Then write_SKEW_ADJ_B_value = get_SKEW_ADJ_B
        If flag_error_pair_swap = &H0 Then write_error_pair_swap_value = get_error_pair_swap
        If flag_pairSettingsValid = &H0 Then write_pairSettingsValid_value = get_pairSettingsValid
        If flag_swapAB = &H0 Then write_swapAB_value = get_swapAB
        If flag_polarityB = &H0 Then write_polarityB_value = get_polarityB
        If flag_polarityA = &H0 Then write_polarityA_value = get_polarityA
        If flag_pairBSelect = &H0 Then write_pairBSelect_value = get_pairBSelect
        If flag_pairASelect = &H0 Then write_pairASelect_value = get_pairASelect

        regValue = leftShift((write_SKEW_ADJ_A_value and &Hf), 12) + leftShift((write_SKEW_ADJ_B_value and &Hf), 8) + leftShift((write_error_pair_swap_value and &H1), 6) + leftShift((write_pairSettingsValid_value and &H1), 5) + leftShift((write_swapAB_value and &H1), 4) + leftShift((write_polarityB_value and &H1), 3) + leftShift((write_polarityA_value and &H1), 2) + leftShift((write_pairBSelect_value and &H1), 1) + leftShift((write_pairASelect_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SKEW_ADJ_A_value = rightShift(data_low, 12) and &Hf
        read_SKEW_ADJ_B_value = rightShift(data_low, 8) and &Hf
        read_error_pair_swap_value = rightShift(data_low, 6) and &H1
        read_pairSettingsValid_value = rightShift(data_low, 5) and &H1
        read_swapAB_value = rightShift(data_low, 4) and &H1
        read_polarityB_value = rightShift(data_low, 3) and &H1
        read_polarityA_value = rightShift(data_low, 2) and &H1
        read_pairBSelect_value = rightShift(data_low, 1) and &H1
        pairASelect_mask = &H1
        if data_low > LONG_MAX then
            if pairASelect_mask = mask then
                read_pairASelect_value = data_low
            else
                read_pairASelect_value = (data_low - H8000_0000) and pairASelect_mask
            end If
        else
            read_pairASelect_value = data_low and pairASelect_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SKEW_ADJ_A_value = &H0
        flag_SKEW_ADJ_A        = &H0
        write_SKEW_ADJ_B_value = &H0
        flag_SKEW_ADJ_B        = &H0
        write_error_pair_swap_value = &H0
        flag_error_pair_swap        = &H0
        write_pairSettingsValid_value = &H0
        flag_pairSettingsValid        = &H0
        write_swapAB_value = &H0
        flag_swapAB        = &H0
        write_polarityB_value = &H0
        flag_polarityB        = &H0
        write_polarityA_value = &H0
        flag_polarityA        = &H0
        write_pairBSelect_value = &H0
        flag_pairBSelect        = &H0
        write_pairASelect_value = &H0
        flag_pairASelect        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp97
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' idle_count                                 [7:0]            get_idle_count
''                                                             set_idle_count
''                                                             read_idle_count
''                                                             write_idle_count
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp97
    Private write_idle_count_value
    Private read_idle_count_value
    Private flag_idle_count

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

    Property Get get_idle_count
        get_idle_count = read_idle_count_value
    End Property

    Property Let set_idle_count(aData)
        write_idle_count_value = aData
        flag_idle_count        = &H1
    End Property

    Property Get read_idle_count
        read
        read_idle_count = read_idle_count_value
    End Property

    Property Let write_idle_count(aData)
        set_idle_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        idle_count_mask = &Hff
        if data_low > LONG_MAX then
            if idle_count_mask = mask then
                read_idle_count_value = data_low
            else
                read_idle_count_value = (data_low - H8000_0000) and idle_count_mask
            end If
        else
            read_idle_count_value = data_low and idle_count_mask
        end If

    End Sub

    Sub write
        If flag_idle_count = &H0 Then read
        If flag_idle_count = &H0 Then write_idle_count_value = get_idle_count

        regValue = leftShift((write_idle_count_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        idle_count_mask = &Hff
        if data_low > LONG_MAX then
            if idle_count_mask = mask then
                read_idle_count_value = data_low
            else
                read_idle_count_value = (data_low - H8000_0000) and idle_count_mask
            end If
        else
            read_idle_count_value = data_low and idle_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_idle_count_value = &H0
        flag_idle_count        = &H0
    End Sub
End Class


'' @REGISTER : BR_PCS_exp9b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BR_RATE_OV                                 [15:13]          get_BR_RATE_OV
''                                                             set_BR_RATE_OV
''                                                             read_BR_RATE_OV
''                                                             write_BR_RATE_OV
''---------------------------------------------------------------------------------
'' BR_PLL_CTL_EN                              [0:0]            get_BR_PLL_CTL_EN
''                                                             set_BR_PLL_CTL_EN
''                                                             read_BR_PLL_CTL_EN
''                                                             write_BR_PLL_CTL_EN
''---------------------------------------------------------------------------------
Class REGISTER_BR_PCS_exp9b
    Private write_BR_RATE_OV_value
    Private read_BR_RATE_OV_value
    Private flag_BR_RATE_OV
    Private write_BR_PLL_CTL_EN_value
    Private read_BR_PLL_CTL_EN_value
    Private flag_BR_PLL_CTL_EN

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

    Property Get get_BR_RATE_OV
        get_BR_RATE_OV = read_BR_RATE_OV_value
    End Property

    Property Let set_BR_RATE_OV(aData)
        write_BR_RATE_OV_value = aData
        flag_BR_RATE_OV        = &H1
    End Property

    Property Get read_BR_RATE_OV
        read
        read_BR_RATE_OV = read_BR_RATE_OV_value
    End Property

    Property Let write_BR_RATE_OV(aData)
        set_BR_RATE_OV = aData
        write
    End Property

    Property Get get_BR_PLL_CTL_EN
        get_BR_PLL_CTL_EN = read_BR_PLL_CTL_EN_value
    End Property

    Property Let set_BR_PLL_CTL_EN(aData)
        write_BR_PLL_CTL_EN_value = aData
        flag_BR_PLL_CTL_EN        = &H1
    End Property

    Property Get read_BR_PLL_CTL_EN
        read
        read_BR_PLL_CTL_EN = read_BR_PLL_CTL_EN_value
    End Property

    Property Let write_BR_PLL_CTL_EN(aData)
        set_BR_PLL_CTL_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_RATE_OV_value = rightShift(data_low, 13) and &H7
        BR_PLL_CTL_EN_mask = &H1
        if data_low > LONG_MAX then
            if BR_PLL_CTL_EN_mask = mask then
                read_BR_PLL_CTL_EN_value = data_low
            else
                read_BR_PLL_CTL_EN_value = (data_low - H8000_0000) and BR_PLL_CTL_EN_mask
            end If
        else
            read_BR_PLL_CTL_EN_value = data_low and BR_PLL_CTL_EN_mask
        end If

    End Sub

    Sub write
        If flag_BR_RATE_OV = &H0 or flag_BR_PLL_CTL_EN = &H0 Then read
        If flag_BR_RATE_OV = &H0 Then write_BR_RATE_OV_value = get_BR_RATE_OV
        If flag_BR_PLL_CTL_EN = &H0 Then write_BR_PLL_CTL_EN_value = get_BR_PLL_CTL_EN

        regValue = leftShift((write_BR_RATE_OV_value and &H7), 13) + leftShift((write_BR_PLL_CTL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_RATE_OV_value = rightShift(data_low, 13) and &H7
        BR_PLL_CTL_EN_mask = &H1
        if data_low > LONG_MAX then
            if BR_PLL_CTL_EN_mask = mask then
                read_BR_PLL_CTL_EN_value = data_low
            else
                read_BR_PLL_CTL_EN_value = (data_low - H8000_0000) and BR_PLL_CTL_EN_mask
            end If
        else
            read_BR_PLL_CTL_EN_value = data_low and BR_PLL_CTL_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BR_RATE_OV_value = &H0
        flag_BR_RATE_OV        = &H0
        write_BR_PLL_CTL_EN_value = &H0
        flag_BR_PLL_CTL_EN        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class BR_PCS_INSTANCE

    Public exp90
    Public exp91
    Public exp92
    Public exp93
    Public exp94
    Public exp95
    Public exp96
    Public exp97
    Public exp9b


    Public default function Init(aBaseAddr)
        Set exp90 = (New REGISTER_BR_PCS_exp90)(aBaseAddr, 16)
        Set exp91 = (New REGISTER_BR_PCS_exp91)(aBaseAddr, 16)
        Set exp92 = (New REGISTER_BR_PCS_exp92)(aBaseAddr, 16)
        Set exp93 = (New REGISTER_BR_PCS_exp93)(aBaseAddr, 16)
        Set exp94 = (New REGISTER_BR_PCS_exp94)(aBaseAddr, 16)
        Set exp95 = (New REGISTER_BR_PCS_exp95)(aBaseAddr, 16)
        Set exp96 = (New REGISTER_BR_PCS_exp96)(aBaseAddr, 16)
        Set exp97 = (New REGISTER_BR_PCS_exp97)(aBaseAddr, 16)
        Set exp9b = (New REGISTER_BR_PCS_exp9b)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set BR_PCS = CreateObject("System.Collections.ArrayList")
BR_PCS.Add ((New BR_PCS_INSTANCE)(&H49031600))


