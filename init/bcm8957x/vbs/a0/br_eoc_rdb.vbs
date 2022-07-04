

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


'' @REGISTER : BR_EOC_exp90
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DIG_HPF_EN                                 [15:15]          get_DIG_HPF_EN
''                                                             set_DIG_HPF_EN
''                                                             read_DIG_HPF_EN
''                                                             write_DIG_HPF_EN
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
Class REGISTER_BR_EOC_exp90
    Private write_DIG_HPF_EN_value
    Private read_DIG_HPF_EN_value
    Private flag_DIG_HPF_EN
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

    Property Get get_DIG_HPF_EN
        get_DIG_HPF_EN = read_DIG_HPF_EN_value
    End Property

    Property Let set_DIG_HPF_EN(aData)
        write_DIG_HPF_EN_value = aData
        flag_DIG_HPF_EN        = &H1
    End Property

    Property Get read_DIG_HPF_EN
        read
        read_DIG_HPF_EN = read_DIG_HPF_EN_value
    End Property

    Property Let write_DIG_HPF_EN(aData)
        set_DIG_HPF_EN = aData
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
        read_DIG_HPF_EN_value = rightShift(data_low, 15) and &H1
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
        If flag_DIG_HPF_EN = &H0 or flag_BR_SCR_STATUS = &H0 or flag_BR_ALIGN_STATE = &H0 or flag_BR_RX_STATE = &H0 or flag_BR_PCS_STATE = &H0 or flag_BR_FORCE_LINK_CTL = &H0 or flag_BR_EN = &H0 Then read
        If flag_DIG_HPF_EN = &H0 Then write_DIG_HPF_EN_value = get_DIG_HPF_EN
        If flag_BR_SCR_STATUS = &H0 Then write_BR_SCR_STATUS_value = get_BR_SCR_STATUS
        If flag_BR_ALIGN_STATE = &H0 Then write_BR_ALIGN_STATE_value = get_BR_ALIGN_STATE
        If flag_BR_RX_STATE = &H0 Then write_BR_RX_STATE_value = get_BR_RX_STATE
        If flag_BR_PCS_STATE = &H0 Then write_BR_PCS_STATE_value = get_BR_PCS_STATE
        If flag_BR_FORCE_LINK_CTL = &H0 Then write_BR_FORCE_LINK_CTL_value = get_BR_FORCE_LINK_CTL
        If flag_BR_EN = &H0 Then write_BR_EN_value = get_BR_EN

        regValue = leftShift((write_DIG_HPF_EN_value and &H1), 15) + leftShift((write_BR_SCR_STATUS_value and &H3), 13) + leftShift((write_BR_ALIGN_STATE_value and &H7), 10) + leftShift((write_BR_RX_STATE_value and &Hf), 6) + leftShift((write_BR_PCS_STATE_value and &Hf), 2) + leftShift((write_BR_FORCE_LINK_CTL_value and &H1), 1) + leftShift((write_BR_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DIG_HPF_EN_value = rightShift(data_low, 15) and &H1
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
        write_DIG_HPF_EN_value = &H0
        flag_DIG_HPF_EN        = &H0
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


'' @REGISTER : BR_EOC_exp91
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DIG_HPF_OV                                 [15:15]          get_DIG_HPF_OV
''                                                             set_DIG_HPF_OV
''                                                             read_DIG_HPF_OV
''                                                             write_DIG_HPF_OV
''---------------------------------------------------------------------------------
'' BR_N_TOGGLE_DIS_OV                         [14:14]          get_BR_N_TOGGLE_DIS_OV
''                                                             set_BR_N_TOGGLE_DIS_OV
''                                                             read_BR_N_TOGGLE_DIS_OV
''                                                             write_BR_N_TOGGLE_DIS_OV
''---------------------------------------------------------------------------------
'' INV_LRE_GMII_TXC                           [13:13]          get_INV_LRE_GMII_TXC
''                                                             set_INV_LRE_GMII_TXC
''                                                             read_INV_LRE_GMII_TXC
''                                                             write_INV_LRE_GMII_TXC
''---------------------------------------------------------------------------------
'' AGC_AUTOSTAGING_DIS                        [12:12]          get_AGC_AUTOSTAGING_DIS
''                                                             set_AGC_AUTOSTAGING_DIS
''                                                             read_AGC_AUTOSTAGING_DIS
''                                                             write_AGC_AUTOSTAGING_DIS
''---------------------------------------------------------------------------------
'' BRPGA                                      [11:9]           get_BRPGA
''                                                             set_BRPGA
''                                                             read_BRPGA
''                                                             write_BRPGA
''---------------------------------------------------------------------------------
'' BRCONFIG                                   [8:4]            get_BRCONFIG
''                                                             set_BRCONFIG
''                                                             read_BRCONFIG
''                                                             write_BRCONFIG
''---------------------------------------------------------------------------------
'' ACQP_EN_ECO_DIS                            [3:3]            get_ACQP_EN_ECO_DIS
''                                                             set_ACQP_EN_ECO_DIS
''                                                             read_ACQP_EN_ECO_DIS
''                                                             write_ACQP_EN_ECO_DIS
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
Class REGISTER_BR_EOC_exp91
    Private write_DIG_HPF_OV_value
    Private read_DIG_HPF_OV_value
    Private flag_DIG_HPF_OV
    Private write_BR_N_TOGGLE_DIS_OV_value
    Private read_BR_N_TOGGLE_DIS_OV_value
    Private flag_BR_N_TOGGLE_DIS_OV
    Private write_INV_LRE_GMII_TXC_value
    Private read_INV_LRE_GMII_TXC_value
    Private flag_INV_LRE_GMII_TXC
    Private write_AGC_AUTOSTAGING_DIS_value
    Private read_AGC_AUTOSTAGING_DIS_value
    Private flag_AGC_AUTOSTAGING_DIS
    Private write_BRPGA_value
    Private read_BRPGA_value
    Private flag_BRPGA
    Private write_BRCONFIG_value
    Private read_BRCONFIG_value
    Private flag_BRCONFIG
    Private write_ACQP_EN_ECO_DIS_value
    Private read_ACQP_EN_ECO_DIS_value
    Private flag_ACQP_EN_ECO_DIS
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

    Property Get get_DIG_HPF_OV
        get_DIG_HPF_OV = read_DIG_HPF_OV_value
    End Property

    Property Let set_DIG_HPF_OV(aData)
        write_DIG_HPF_OV_value = aData
        flag_DIG_HPF_OV        = &H1
    End Property

    Property Get read_DIG_HPF_OV
        read
        read_DIG_HPF_OV = read_DIG_HPF_OV_value
    End Property

    Property Let write_DIG_HPF_OV(aData)
        set_DIG_HPF_OV = aData
        write
    End Property

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

    Property Get get_INV_LRE_GMII_TXC
        get_INV_LRE_GMII_TXC = read_INV_LRE_GMII_TXC_value
    End Property

    Property Let set_INV_LRE_GMII_TXC(aData)
        write_INV_LRE_GMII_TXC_value = aData
        flag_INV_LRE_GMII_TXC        = &H1
    End Property

    Property Get read_INV_LRE_GMII_TXC
        read
        read_INV_LRE_GMII_TXC = read_INV_LRE_GMII_TXC_value
    End Property

    Property Let write_INV_LRE_GMII_TXC(aData)
        set_INV_LRE_GMII_TXC = aData
        write
    End Property

    Property Get get_AGC_AUTOSTAGING_DIS
        get_AGC_AUTOSTAGING_DIS = read_AGC_AUTOSTAGING_DIS_value
    End Property

    Property Let set_AGC_AUTOSTAGING_DIS(aData)
        write_AGC_AUTOSTAGING_DIS_value = aData
        flag_AGC_AUTOSTAGING_DIS        = &H1
    End Property

    Property Get read_AGC_AUTOSTAGING_DIS
        read
        read_AGC_AUTOSTAGING_DIS = read_AGC_AUTOSTAGING_DIS_value
    End Property

    Property Let write_AGC_AUTOSTAGING_DIS(aData)
        set_AGC_AUTOSTAGING_DIS = aData
        write
    End Property

    Property Get get_BRPGA
        get_BRPGA = read_BRPGA_value
    End Property

    Property Let set_BRPGA(aData)
        write_BRPGA_value = aData
        flag_BRPGA        = &H1
    End Property

    Property Get read_BRPGA
        read
        read_BRPGA = read_BRPGA_value
    End Property

    Property Let write_BRPGA(aData)
        set_BRPGA = aData
        write
    End Property

    Property Get get_BRCONFIG
        get_BRCONFIG = read_BRCONFIG_value
    End Property

    Property Let set_BRCONFIG(aData)
        write_BRCONFIG_value = aData
        flag_BRCONFIG        = &H1
    End Property

    Property Get read_BRCONFIG
        read
        read_BRCONFIG = read_BRCONFIG_value
    End Property

    Property Let write_BRCONFIG(aData)
        set_BRCONFIG = aData
        write
    End Property

    Property Get get_ACQP_EN_ECO_DIS
        get_ACQP_EN_ECO_DIS = read_ACQP_EN_ECO_DIS_value
    End Property

    Property Let set_ACQP_EN_ECO_DIS(aData)
        write_ACQP_EN_ECO_DIS_value = aData
        flag_ACQP_EN_ECO_DIS        = &H1
    End Property

    Property Get read_ACQP_EN_ECO_DIS
        read
        read_ACQP_EN_ECO_DIS = read_ACQP_EN_ECO_DIS_value
    End Property

    Property Let write_ACQP_EN_ECO_DIS(aData)
        set_ACQP_EN_ECO_DIS = aData
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
        read_DIG_HPF_OV_value = rightShift(data_low, 15) and &H1
        read_BR_N_TOGGLE_DIS_OV_value = rightShift(data_low, 14) and &H1
        read_INV_LRE_GMII_TXC_value = rightShift(data_low, 13) and &H1
        read_AGC_AUTOSTAGING_DIS_value = rightShift(data_low, 12) and &H1
        read_BRPGA_value = rightShift(data_low, 9) and &H7
        read_BRCONFIG_value = rightShift(data_low, 4) and &H1f
        read_ACQP_EN_ECO_DIS_value = rightShift(data_low, 3) and &H1
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
        If flag_DIG_HPF_OV = &H0 or flag_BR_N_TOGGLE_DIS_OV = &H0 or flag_INV_LRE_GMII_TXC = &H0 or flag_AGC_AUTOSTAGING_DIS = &H0 or flag_BRPGA = &H0 or flag_BRCONFIG = &H0 or flag_ACQP_EN_ECO_DIS = &H0 or flag_BR_N_TOGGLE_DIS_OV_VAL = &H0 or flag_TXSCR_ZERO_SEED = &H0 or flag_RXSCR_ZERO_SEED = &H0 Then read
        If flag_DIG_HPF_OV = &H0 Then write_DIG_HPF_OV_value = get_DIG_HPF_OV
        If flag_BR_N_TOGGLE_DIS_OV = &H0 Then write_BR_N_TOGGLE_DIS_OV_value = get_BR_N_TOGGLE_DIS_OV
        If flag_INV_LRE_GMII_TXC = &H0 Then write_INV_LRE_GMII_TXC_value = get_INV_LRE_GMII_TXC
        If flag_AGC_AUTOSTAGING_DIS = &H0 Then write_AGC_AUTOSTAGING_DIS_value = get_AGC_AUTOSTAGING_DIS
        If flag_BRPGA = &H0 Then write_BRPGA_value = get_BRPGA
        If flag_BRCONFIG = &H0 Then write_BRCONFIG_value = get_BRCONFIG
        If flag_ACQP_EN_ECO_DIS = &H0 Then write_ACQP_EN_ECO_DIS_value = get_ACQP_EN_ECO_DIS
        If flag_BR_N_TOGGLE_DIS_OV_VAL = &H0 Then write_BR_N_TOGGLE_DIS_OV_VAL_value = get_BR_N_TOGGLE_DIS_OV_VAL
        If flag_TXSCR_ZERO_SEED = &H0 Then write_TXSCR_ZERO_SEED_value = get_TXSCR_ZERO_SEED
        If flag_RXSCR_ZERO_SEED = &H0 Then write_RXSCR_ZERO_SEED_value = get_RXSCR_ZERO_SEED

        regValue = leftShift((write_DIG_HPF_OV_value and &H1), 15) + leftShift((write_BR_N_TOGGLE_DIS_OV_value and &H1), 14) + leftShift((write_INV_LRE_GMII_TXC_value and &H1), 13) + leftShift((write_AGC_AUTOSTAGING_DIS_value and &H1), 12) + leftShift((write_BRPGA_value and &H7), 9) + leftShift((write_BRCONFIG_value and &H1f), 4) + leftShift((write_ACQP_EN_ECO_DIS_value and &H1), 3) + leftShift((write_BR_N_TOGGLE_DIS_OV_VAL_value and &H1), 2) + leftShift((write_TXSCR_ZERO_SEED_value and &H1), 1) + leftShift((write_RXSCR_ZERO_SEED_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DIG_HPF_OV_value = rightShift(data_low, 15) and &H1
        read_BR_N_TOGGLE_DIS_OV_value = rightShift(data_low, 14) and &H1
        read_INV_LRE_GMII_TXC_value = rightShift(data_low, 13) and &H1
        read_AGC_AUTOSTAGING_DIS_value = rightShift(data_low, 12) and &H1
        read_BRPGA_value = rightShift(data_low, 9) and &H7
        read_BRCONFIG_value = rightShift(data_low, 4) and &H1f
        read_ACQP_EN_ECO_DIS_value = rightShift(data_low, 3) and &H1
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
        write_DIG_HPF_OV_value = &H0
        flag_DIG_HPF_OV        = &H0
        write_BR_N_TOGGLE_DIS_OV_value = &H0
        flag_BR_N_TOGGLE_DIS_OV        = &H0
        write_INV_LRE_GMII_TXC_value = &H0
        flag_INV_LRE_GMII_TXC        = &H0
        write_AGC_AUTOSTAGING_DIS_value = &H0
        flag_AGC_AUTOSTAGING_DIS        = &H0
        write_BRPGA_value = &H0
        flag_BRPGA        = &H0
        write_BRCONFIG_value = &H0
        flag_BRCONFIG        = &H0
        write_ACQP_EN_ECO_DIS_value = &H0
        flag_ACQP_EN_ECO_DIS        = &H0
        write_BR_N_TOGGLE_DIS_OV_VAL_value = &H0
        flag_BR_N_TOGGLE_DIS_OV_VAL        = &H0
        write_TXSCR_ZERO_SEED_value = &H0
        flag_TXSCR_ZERO_SEED        = &H0
        write_RXSCR_ZERO_SEED_value = &H0
        flag_RXSCR_ZERO_SEED        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp92
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
'' LDS_LNK_CHK_ECO_DIS                        [9:9]            get_LDS_LNK_CHK_ECO_DIS
''                                                             set_LDS_LNK_CHK_ECO_DIS
''                                                             read_LDS_LNK_CHK_ECO_DIS
''                                                             write_LDS_LNK_CHK_ECO_DIS
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
Class REGISTER_BR_EOC_exp92
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
    Private write_LDS_LNK_CHK_ECO_DIS_value
    Private read_LDS_LNK_CHK_ECO_DIS_value
    Private flag_LDS_LNK_CHK_ECO_DIS
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

    Property Get get_LDS_LNK_CHK_ECO_DIS
        get_LDS_LNK_CHK_ECO_DIS = read_LDS_LNK_CHK_ECO_DIS_value
    End Property

    Property Let set_LDS_LNK_CHK_ECO_DIS(aData)
        write_LDS_LNK_CHK_ECO_DIS_value = aData
        flag_LDS_LNK_CHK_ECO_DIS        = &H1
    End Property

    Property Get read_LDS_LNK_CHK_ECO_DIS
        read
        read_LDS_LNK_CHK_ECO_DIS = read_LDS_LNK_CHK_ECO_DIS_value
    End Property

    Property Let write_LDS_LNK_CHK_ECO_DIS(aData)
        set_LDS_LNK_CHK_ECO_DIS = aData
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
        read_LDS_LNK_CHK_ECO_DIS_value = rightShift(data_low, 9) and &H1
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
        If flag_DLLCONV_OV_EN = &H0 or flag_DLLCONV_OV_VAL = &H0 or flag_BR_SLAVE_POL_COR_EN = &H0 or flag_BR_EDGE_RATE_SEL = &H0 or flag_BR_PCS_RRNOK_POL_EN = &H0 or flag_LDS_LNK_CHK_ECO_DIS = &H0 or flag_BR_PCS_POL_EN = &H0 or flag_JAB_MON_DIS = &H0 or flag_BR_AGCSID_TMR_EN = &H0 or flag_BR_SYM_XSCR_EN = &H0 or flag_CHK_DELIMITER = &H0 or flag_TX_READ_DLY = &H0 or flag_RX_READ_DLY = &H0 Then read
        If flag_DLLCONV_OV_EN = &H0 Then write_DLLCONV_OV_EN_value = get_DLLCONV_OV_EN
        If flag_DLLCONV_OV_VAL = &H0 Then write_DLLCONV_OV_VAL_value = get_DLLCONV_OV_VAL
        If flag_BR_SLAVE_POL_COR_EN = &H0 Then write_BR_SLAVE_POL_COR_EN_value = get_BR_SLAVE_POL_COR_EN
        If flag_BR_EDGE_RATE_SEL = &H0 Then write_BR_EDGE_RATE_SEL_value = get_BR_EDGE_RATE_SEL
        If flag_BR_PCS_RRNOK_POL_EN = &H0 Then write_BR_PCS_RRNOK_POL_EN_value = get_BR_PCS_RRNOK_POL_EN
        If flag_LDS_LNK_CHK_ECO_DIS = &H0 Then write_LDS_LNK_CHK_ECO_DIS_value = get_LDS_LNK_CHK_ECO_DIS
        If flag_BR_PCS_POL_EN = &H0 Then write_BR_PCS_POL_EN_value = get_BR_PCS_POL_EN
        If flag_JAB_MON_DIS = &H0 Then write_JAB_MON_DIS_value = get_JAB_MON_DIS
        If flag_BR_AGCSID_TMR_EN = &H0 Then write_BR_AGCSID_TMR_EN_value = get_BR_AGCSID_TMR_EN
        If flag_BR_SYM_XSCR_EN = &H0 Then write_BR_SYM_XSCR_EN_value = get_BR_SYM_XSCR_EN
        If flag_CHK_DELIMITER = &H0 Then write_CHK_DELIMITER_value = get_CHK_DELIMITER
        If flag_TX_READ_DLY = &H0 Then write_TX_READ_DLY_value = get_TX_READ_DLY
        If flag_RX_READ_DLY = &H0 Then write_RX_READ_DLY_value = get_RX_READ_DLY

        regValue = leftShift((write_DLLCONV_OV_EN_value and &H1), 15) + leftShift((write_DLLCONV_OV_VAL_value and &H1), 14) + leftShift((write_BR_SLAVE_POL_COR_EN_value and &H1), 13) + leftShift((write_BR_EDGE_RATE_SEL_value and &H3), 11) + leftShift((write_BR_PCS_RRNOK_POL_EN_value and &H1), 10) + leftShift((write_LDS_LNK_CHK_ECO_DIS_value and &H1), 9) + leftShift((write_BR_PCS_POL_EN_value and &H1), 8) + leftShift((write_JAB_MON_DIS_value and &H1), 7) + leftShift((write_BR_AGCSID_TMR_EN_value and &H1), 6) + leftShift((write_BR_SYM_XSCR_EN_value and &H1), 5) + leftShift((write_CHK_DELIMITER_value and &H1), 4) + leftShift((write_TX_READ_DLY_value and &H3), 2) + leftShift((write_RX_READ_DLY_value and &H3), 0)
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
        read_LDS_LNK_CHK_ECO_DIS_value = rightShift(data_low, 9) and &H1
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
        write_LDS_LNK_CHK_ECO_DIS_value = &H0
        flag_LDS_LNK_CHK_ECO_DIS        = &H0
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


'' @REGISTER : BR_EOC_exp93
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_CAP_DOWNGRADE_DIS                      [15:15]          get_LDS_CAP_DOWNGRADE_DIS
''                                                             set_LDS_CAP_DOWNGRADE_DIS
''                                                             read_LDS_CAP_DOWNGRADE_DIS
''                                                             write_LDS_CAP_DOWNGRADE_DIS
''---------------------------------------------------------------------------------
'' LDS_REORDER_DIS                            [14:14]          get_LDS_REORDER_DIS
''                                                             set_LDS_REORDER_DIS
''                                                             read_LDS_REORDER_DIS
''                                                             write_LDS_REORDER_DIS
''---------------------------------------------------------------------------------
'' LDS_SIM                                    [13:13]          get_LDS_SIM
''                                                             set_LDS_SIM
''                                                             read_LDS_SIM
''                                                             write_LDS_SIM
''---------------------------------------------------------------------------------
'' LDS_SCR_ON                                 [12:12]          get_LDS_SCR_ON
''                                                             set_LDS_SCR_ON
''                                                             read_LDS_SCR_ON
''                                                             write_LDS_SCR_ON
''---------------------------------------------------------------------------------
'' LDS_PHASE_BYP                              [11:11]          get_LDS_PHASE_BYP
''                                                             set_LDS_PHASE_BYP
''                                                             read_LDS_PHASE_BYP
''                                                             write_LDS_PHASE_BYP
''---------------------------------------------------------------------------------
'' LDS_PHASE_INIT                             [10:8]           get_LDS_PHASE_INIT
''                                                             set_LDS_PHASE_INIT
''                                                             read_LDS_PHASE_INIT
''                                                             write_LDS_PHASE_INIT
''---------------------------------------------------------------------------------
'' LDS_PEAK_THR                               [7:0]            get_LDS_PEAK_THR
''                                                             set_LDS_PEAK_THR
''                                                             read_LDS_PEAK_THR
''                                                             write_LDS_PEAK_THR
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp93
    Private write_LDS_CAP_DOWNGRADE_DIS_value
    Private read_LDS_CAP_DOWNGRADE_DIS_value
    Private flag_LDS_CAP_DOWNGRADE_DIS
    Private write_LDS_REORDER_DIS_value
    Private read_LDS_REORDER_DIS_value
    Private flag_LDS_REORDER_DIS
    Private write_LDS_SIM_value
    Private read_LDS_SIM_value
    Private flag_LDS_SIM
    Private write_LDS_SCR_ON_value
    Private read_LDS_SCR_ON_value
    Private flag_LDS_SCR_ON
    Private write_LDS_PHASE_BYP_value
    Private read_LDS_PHASE_BYP_value
    Private flag_LDS_PHASE_BYP
    Private write_LDS_PHASE_INIT_value
    Private read_LDS_PHASE_INIT_value
    Private flag_LDS_PHASE_INIT
    Private write_LDS_PEAK_THR_value
    Private read_LDS_PEAK_THR_value
    Private flag_LDS_PEAK_THR

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

    Property Get get_LDS_CAP_DOWNGRADE_DIS
        get_LDS_CAP_DOWNGRADE_DIS = read_LDS_CAP_DOWNGRADE_DIS_value
    End Property

    Property Let set_LDS_CAP_DOWNGRADE_DIS(aData)
        write_LDS_CAP_DOWNGRADE_DIS_value = aData
        flag_LDS_CAP_DOWNGRADE_DIS        = &H1
    End Property

    Property Get read_LDS_CAP_DOWNGRADE_DIS
        read
        read_LDS_CAP_DOWNGRADE_DIS = read_LDS_CAP_DOWNGRADE_DIS_value
    End Property

    Property Let write_LDS_CAP_DOWNGRADE_DIS(aData)
        set_LDS_CAP_DOWNGRADE_DIS = aData
        write
    End Property

    Property Get get_LDS_REORDER_DIS
        get_LDS_REORDER_DIS = read_LDS_REORDER_DIS_value
    End Property

    Property Let set_LDS_REORDER_DIS(aData)
        write_LDS_REORDER_DIS_value = aData
        flag_LDS_REORDER_DIS        = &H1
    End Property

    Property Get read_LDS_REORDER_DIS
        read
        read_LDS_REORDER_DIS = read_LDS_REORDER_DIS_value
    End Property

    Property Let write_LDS_REORDER_DIS(aData)
        set_LDS_REORDER_DIS = aData
        write
    End Property

    Property Get get_LDS_SIM
        get_LDS_SIM = read_LDS_SIM_value
    End Property

    Property Let set_LDS_SIM(aData)
        write_LDS_SIM_value = aData
        flag_LDS_SIM        = &H1
    End Property

    Property Get read_LDS_SIM
        read
        read_LDS_SIM = read_LDS_SIM_value
    End Property

    Property Let write_LDS_SIM(aData)
        set_LDS_SIM = aData
        write
    End Property

    Property Get get_LDS_SCR_ON
        get_LDS_SCR_ON = read_LDS_SCR_ON_value
    End Property

    Property Let set_LDS_SCR_ON(aData)
        write_LDS_SCR_ON_value = aData
        flag_LDS_SCR_ON        = &H1
    End Property

    Property Get read_LDS_SCR_ON
        read
        read_LDS_SCR_ON = read_LDS_SCR_ON_value
    End Property

    Property Let write_LDS_SCR_ON(aData)
        set_LDS_SCR_ON = aData
        write
    End Property

    Property Get get_LDS_PHASE_BYP
        get_LDS_PHASE_BYP = read_LDS_PHASE_BYP_value
    End Property

    Property Let set_LDS_PHASE_BYP(aData)
        write_LDS_PHASE_BYP_value = aData
        flag_LDS_PHASE_BYP        = &H1
    End Property

    Property Get read_LDS_PHASE_BYP
        read
        read_LDS_PHASE_BYP = read_LDS_PHASE_BYP_value
    End Property

    Property Let write_LDS_PHASE_BYP(aData)
        set_LDS_PHASE_BYP = aData
        write
    End Property

    Property Get get_LDS_PHASE_INIT
        get_LDS_PHASE_INIT = read_LDS_PHASE_INIT_value
    End Property

    Property Let set_LDS_PHASE_INIT(aData)
        write_LDS_PHASE_INIT_value = aData
        flag_LDS_PHASE_INIT        = &H1
    End Property

    Property Get read_LDS_PHASE_INIT
        read
        read_LDS_PHASE_INIT = read_LDS_PHASE_INIT_value
    End Property

    Property Let write_LDS_PHASE_INIT(aData)
        set_LDS_PHASE_INIT = aData
        write
    End Property

    Property Get get_LDS_PEAK_THR
        get_LDS_PEAK_THR = read_LDS_PEAK_THR_value
    End Property

    Property Let set_LDS_PEAK_THR(aData)
        write_LDS_PEAK_THR_value = aData
        flag_LDS_PEAK_THR        = &H1
    End Property

    Property Get read_LDS_PEAK_THR
        read
        read_LDS_PEAK_THR = read_LDS_PEAK_THR_value
    End Property

    Property Let write_LDS_PEAK_THR(aData)
        set_LDS_PEAK_THR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_CAP_DOWNGRADE_DIS_value = rightShift(data_low, 15) and &H1
        read_LDS_REORDER_DIS_value = rightShift(data_low, 14) and &H1
        read_LDS_SIM_value = rightShift(data_low, 13) and &H1
        read_LDS_SCR_ON_value = rightShift(data_low, 12) and &H1
        read_LDS_PHASE_BYP_value = rightShift(data_low, 11) and &H1
        read_LDS_PHASE_INIT_value = rightShift(data_low, 8) and &H7
        LDS_PEAK_THR_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_PEAK_THR_mask = mask then
                read_LDS_PEAK_THR_value = data_low
            else
                read_LDS_PEAK_THR_value = (data_low - H8000_0000) and LDS_PEAK_THR_mask
            end If
        else
            read_LDS_PEAK_THR_value = data_low and LDS_PEAK_THR_mask
        end If

    End Sub

    Sub write
        If flag_LDS_CAP_DOWNGRADE_DIS = &H0 or flag_LDS_REORDER_DIS = &H0 or flag_LDS_SIM = &H0 or flag_LDS_SCR_ON = &H0 or flag_LDS_PHASE_BYP = &H0 or flag_LDS_PHASE_INIT = &H0 or flag_LDS_PEAK_THR = &H0 Then read
        If flag_LDS_CAP_DOWNGRADE_DIS = &H0 Then write_LDS_CAP_DOWNGRADE_DIS_value = get_LDS_CAP_DOWNGRADE_DIS
        If flag_LDS_REORDER_DIS = &H0 Then write_LDS_REORDER_DIS_value = get_LDS_REORDER_DIS
        If flag_LDS_SIM = &H0 Then write_LDS_SIM_value = get_LDS_SIM
        If flag_LDS_SCR_ON = &H0 Then write_LDS_SCR_ON_value = get_LDS_SCR_ON
        If flag_LDS_PHASE_BYP = &H0 Then write_LDS_PHASE_BYP_value = get_LDS_PHASE_BYP
        If flag_LDS_PHASE_INIT = &H0 Then write_LDS_PHASE_INIT_value = get_LDS_PHASE_INIT
        If flag_LDS_PEAK_THR = &H0 Then write_LDS_PEAK_THR_value = get_LDS_PEAK_THR

        regValue = leftShift((write_LDS_CAP_DOWNGRADE_DIS_value and &H1), 15) + leftShift((write_LDS_REORDER_DIS_value and &H1), 14) + leftShift((write_LDS_SIM_value and &H1), 13) + leftShift((write_LDS_SCR_ON_value and &H1), 12) + leftShift((write_LDS_PHASE_BYP_value and &H1), 11) + leftShift((write_LDS_PHASE_INIT_value and &H7), 8) + leftShift((write_LDS_PEAK_THR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_CAP_DOWNGRADE_DIS_value = rightShift(data_low, 15) and &H1
        read_LDS_REORDER_DIS_value = rightShift(data_low, 14) and &H1
        read_LDS_SIM_value = rightShift(data_low, 13) and &H1
        read_LDS_SCR_ON_value = rightShift(data_low, 12) and &H1
        read_LDS_PHASE_BYP_value = rightShift(data_low, 11) and &H1
        read_LDS_PHASE_INIT_value = rightShift(data_low, 8) and &H7
        LDS_PEAK_THR_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_PEAK_THR_mask = mask then
                read_LDS_PEAK_THR_value = data_low
            else
                read_LDS_PEAK_THR_value = (data_low - H8000_0000) and LDS_PEAK_THR_mask
            end If
        else
            read_LDS_PEAK_THR_value = data_low and LDS_PEAK_THR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_CAP_DOWNGRADE_DIS_value = &H0
        flag_LDS_CAP_DOWNGRADE_DIS        = &H0
        write_LDS_REORDER_DIS_value = &H0
        flag_LDS_REORDER_DIS        = &H0
        write_LDS_SIM_value = &H0
        flag_LDS_SIM        = &H0
        write_LDS_SCR_ON_value = &H0
        flag_LDS_SCR_ON        = &H0
        write_LDS_PHASE_BYP_value = &H0
        flag_LDS_PHASE_BYP        = &H0
        write_LDS_PHASE_INIT_value = &H0
        flag_LDS_PHASE_INIT        = &H0
        write_LDS_PEAK_THR_value = &H0
        flag_LDS_PEAK_THR        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp94
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_LEN_THR1                               [15:8]           get_LDS_LEN_THR1
''                                                             set_LDS_LEN_THR1
''                                                             read_LDS_LEN_THR1
''                                                             write_LDS_LEN_THR1
''---------------------------------------------------------------------------------
'' LDS_LEN_THR0                               [7:0]            get_LDS_LEN_THR0
''                                                             set_LDS_LEN_THR0
''                                                             read_LDS_LEN_THR0
''                                                             write_LDS_LEN_THR0
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp94
    Private write_LDS_LEN_THR1_value
    Private read_LDS_LEN_THR1_value
    Private flag_LDS_LEN_THR1
    Private write_LDS_LEN_THR0_value
    Private read_LDS_LEN_THR0_value
    Private flag_LDS_LEN_THR0

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

    Property Get get_LDS_LEN_THR1
        get_LDS_LEN_THR1 = read_LDS_LEN_THR1_value
    End Property

    Property Let set_LDS_LEN_THR1(aData)
        write_LDS_LEN_THR1_value = aData
        flag_LDS_LEN_THR1        = &H1
    End Property

    Property Get read_LDS_LEN_THR1
        read
        read_LDS_LEN_THR1 = read_LDS_LEN_THR1_value
    End Property

    Property Let write_LDS_LEN_THR1(aData)
        set_LDS_LEN_THR1 = aData
        write
    End Property

    Property Get get_LDS_LEN_THR0
        get_LDS_LEN_THR0 = read_LDS_LEN_THR0_value
    End Property

    Property Let set_LDS_LEN_THR0(aData)
        write_LDS_LEN_THR0_value = aData
        flag_LDS_LEN_THR0        = &H1
    End Property

    Property Get read_LDS_LEN_THR0
        read
        read_LDS_LEN_THR0 = read_LDS_LEN_THR0_value
    End Property

    Property Let write_LDS_LEN_THR0(aData)
        set_LDS_LEN_THR0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR1_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR0_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR0_mask = mask then
                read_LDS_LEN_THR0_value = data_low
            else
                read_LDS_LEN_THR0_value = (data_low - H8000_0000) and LDS_LEN_THR0_mask
            end If
        else
            read_LDS_LEN_THR0_value = data_low and LDS_LEN_THR0_mask
        end If

    End Sub

    Sub write
        If flag_LDS_LEN_THR1 = &H0 or flag_LDS_LEN_THR0 = &H0 Then read
        If flag_LDS_LEN_THR1 = &H0 Then write_LDS_LEN_THR1_value = get_LDS_LEN_THR1
        If flag_LDS_LEN_THR0 = &H0 Then write_LDS_LEN_THR0_value = get_LDS_LEN_THR0

        regValue = leftShift((write_LDS_LEN_THR1_value and &Hff), 8) + leftShift((write_LDS_LEN_THR0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR1_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR0_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR0_mask = mask then
                read_LDS_LEN_THR0_value = data_low
            else
                read_LDS_LEN_THR0_value = (data_low - H8000_0000) and LDS_LEN_THR0_mask
            end If
        else
            read_LDS_LEN_THR0_value = data_low and LDS_LEN_THR0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_LEN_THR1_value = &H0
        flag_LDS_LEN_THR1        = &H0
        write_LDS_LEN_THR0_value = &H0
        flag_LDS_LEN_THR0        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp95
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_LEN_THR3                               [15:8]           get_LDS_LEN_THR3
''                                                             set_LDS_LEN_THR3
''                                                             read_LDS_LEN_THR3
''                                                             write_LDS_LEN_THR3
''---------------------------------------------------------------------------------
'' LDS_LEN_THR2                               [7:0]            get_LDS_LEN_THR2
''                                                             set_LDS_LEN_THR2
''                                                             read_LDS_LEN_THR2
''                                                             write_LDS_LEN_THR2
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp95
    Private write_LDS_LEN_THR3_value
    Private read_LDS_LEN_THR3_value
    Private flag_LDS_LEN_THR3
    Private write_LDS_LEN_THR2_value
    Private read_LDS_LEN_THR2_value
    Private flag_LDS_LEN_THR2

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

    Property Get get_LDS_LEN_THR3
        get_LDS_LEN_THR3 = read_LDS_LEN_THR3_value
    End Property

    Property Let set_LDS_LEN_THR3(aData)
        write_LDS_LEN_THR3_value = aData
        flag_LDS_LEN_THR3        = &H1
    End Property

    Property Get read_LDS_LEN_THR3
        read
        read_LDS_LEN_THR3 = read_LDS_LEN_THR3_value
    End Property

    Property Let write_LDS_LEN_THR3(aData)
        set_LDS_LEN_THR3 = aData
        write
    End Property

    Property Get get_LDS_LEN_THR2
        get_LDS_LEN_THR2 = read_LDS_LEN_THR2_value
    End Property

    Property Let set_LDS_LEN_THR2(aData)
        write_LDS_LEN_THR2_value = aData
        flag_LDS_LEN_THR2        = &H1
    End Property

    Property Get read_LDS_LEN_THR2
        read
        read_LDS_LEN_THR2 = read_LDS_LEN_THR2_value
    End Property

    Property Let write_LDS_LEN_THR2(aData)
        set_LDS_LEN_THR2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR3_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR2_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR2_mask = mask then
                read_LDS_LEN_THR2_value = data_low
            else
                read_LDS_LEN_THR2_value = (data_low - H8000_0000) and LDS_LEN_THR2_mask
            end If
        else
            read_LDS_LEN_THR2_value = data_low and LDS_LEN_THR2_mask
        end If

    End Sub

    Sub write
        If flag_LDS_LEN_THR3 = &H0 or flag_LDS_LEN_THR2 = &H0 Then read
        If flag_LDS_LEN_THR3 = &H0 Then write_LDS_LEN_THR3_value = get_LDS_LEN_THR3
        If flag_LDS_LEN_THR2 = &H0 Then write_LDS_LEN_THR2_value = get_LDS_LEN_THR2

        regValue = leftShift((write_LDS_LEN_THR3_value and &Hff), 8) + leftShift((write_LDS_LEN_THR2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR3_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR2_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR2_mask = mask then
                read_LDS_LEN_THR2_value = data_low
            else
                read_LDS_LEN_THR2_value = (data_low - H8000_0000) and LDS_LEN_THR2_mask
            end If
        else
            read_LDS_LEN_THR2_value = data_low and LDS_LEN_THR2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_LEN_THR3_value = &H0
        flag_LDS_LEN_THR3        = &H0
        write_LDS_LEN_THR2_value = &H0
        flag_LDS_LEN_THR2        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp96
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_TONE_FREQ                              [15:15]          get_LDS_TONE_FREQ
''                                                             set_LDS_TONE_FREQ
''                                                             read_LDS_TONE_FREQ
''                                                             write_LDS_TONE_FREQ
''---------------------------------------------------------------------------------
'' LDS_EXT_AB_DWNGRD                          [14:14]          get_LDS_EXT_AB_DWNGRD
''                                                             set_LDS_EXT_AB_DWNGRD
''                                                             read_LDS_EXT_AB_DWNGRD
''                                                             write_LDS_EXT_AB_DWNGRD
''---------------------------------------------------------------------------------
'' LDS_SCAN_FSM                               [13:12]          get_LDS_SCAN_FSM
''                                                             set_LDS_SCAN_FSM
''                                                             read_LDS_SCAN_FSM
''                                                             write_LDS_SCAN_FSM
''---------------------------------------------------------------------------------
'' CUR_LOC_FNUM                               [11:4]           get_CUR_LOC_FNUM
''                                                             set_CUR_LOC_FNUM
''                                                             read_CUR_LOC_FNUM
''                                                             write_CUR_LOC_FNUM
''---------------------------------------------------------------------------------
'' LDS_SPD                                    [3:0]            get_LDS_SPD
''                                                             set_LDS_SPD
''                                                             read_LDS_SPD
''                                                             write_LDS_SPD
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp96
    Private write_LDS_TONE_FREQ_value
    Private read_LDS_TONE_FREQ_value
    Private flag_LDS_TONE_FREQ
    Private write_LDS_EXT_AB_DWNGRD_value
    Private read_LDS_EXT_AB_DWNGRD_value
    Private flag_LDS_EXT_AB_DWNGRD
    Private write_LDS_SCAN_FSM_value
    Private read_LDS_SCAN_FSM_value
    Private flag_LDS_SCAN_FSM
    Private write_CUR_LOC_FNUM_value
    Private read_CUR_LOC_FNUM_value
    Private flag_CUR_LOC_FNUM
    Private write_LDS_SPD_value
    Private read_LDS_SPD_value
    Private flag_LDS_SPD

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

    Property Get get_LDS_TONE_FREQ
        get_LDS_TONE_FREQ = read_LDS_TONE_FREQ_value
    End Property

    Property Let set_LDS_TONE_FREQ(aData)
        write_LDS_TONE_FREQ_value = aData
        flag_LDS_TONE_FREQ        = &H1
    End Property

    Property Get read_LDS_TONE_FREQ
        read
        read_LDS_TONE_FREQ = read_LDS_TONE_FREQ_value
    End Property

    Property Let write_LDS_TONE_FREQ(aData)
        set_LDS_TONE_FREQ = aData
        write
    End Property

    Property Get get_LDS_EXT_AB_DWNGRD
        get_LDS_EXT_AB_DWNGRD = read_LDS_EXT_AB_DWNGRD_value
    End Property

    Property Let set_LDS_EXT_AB_DWNGRD(aData)
        write_LDS_EXT_AB_DWNGRD_value = aData
        flag_LDS_EXT_AB_DWNGRD        = &H1
    End Property

    Property Get read_LDS_EXT_AB_DWNGRD
        read
        read_LDS_EXT_AB_DWNGRD = read_LDS_EXT_AB_DWNGRD_value
    End Property

    Property Let write_LDS_EXT_AB_DWNGRD(aData)
        set_LDS_EXT_AB_DWNGRD = aData
        write
    End Property

    Property Get get_LDS_SCAN_FSM
        get_LDS_SCAN_FSM = read_LDS_SCAN_FSM_value
    End Property

    Property Let set_LDS_SCAN_FSM(aData)
        write_LDS_SCAN_FSM_value = aData
        flag_LDS_SCAN_FSM        = &H1
    End Property

    Property Get read_LDS_SCAN_FSM
        read
        read_LDS_SCAN_FSM = read_LDS_SCAN_FSM_value
    End Property

    Property Let write_LDS_SCAN_FSM(aData)
        set_LDS_SCAN_FSM = aData
        write
    End Property

    Property Get get_CUR_LOC_FNUM
        get_CUR_LOC_FNUM = read_CUR_LOC_FNUM_value
    End Property

    Property Let set_CUR_LOC_FNUM(aData)
        write_CUR_LOC_FNUM_value = aData
        flag_CUR_LOC_FNUM        = &H1
    End Property

    Property Get read_CUR_LOC_FNUM
        read
        read_CUR_LOC_FNUM = read_CUR_LOC_FNUM_value
    End Property

    Property Let write_CUR_LOC_FNUM(aData)
        set_CUR_LOC_FNUM = aData
        write
    End Property

    Property Get get_LDS_SPD
        get_LDS_SPD = read_LDS_SPD_value
    End Property

    Property Let set_LDS_SPD(aData)
        write_LDS_SPD_value = aData
        flag_LDS_SPD        = &H1
    End Property

    Property Get read_LDS_SPD
        read
        read_LDS_SPD = read_LDS_SPD_value
    End Property

    Property Let write_LDS_SPD(aData)
        set_LDS_SPD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_TONE_FREQ_value = rightShift(data_low, 15) and &H1
        read_LDS_EXT_AB_DWNGRD_value = rightShift(data_low, 14) and &H1
        read_LDS_SCAN_FSM_value = rightShift(data_low, 12) and &H3
        read_CUR_LOC_FNUM_value = rightShift(data_low, 4) and &Hff
        LDS_SPD_mask = &Hf
        if data_low > LONG_MAX then
            if LDS_SPD_mask = mask then
                read_LDS_SPD_value = data_low
            else
                read_LDS_SPD_value = (data_low - H8000_0000) and LDS_SPD_mask
            end If
        else
            read_LDS_SPD_value = data_low and LDS_SPD_mask
        end If

    End Sub

    Sub write
        If flag_LDS_TONE_FREQ = &H0 or flag_LDS_EXT_AB_DWNGRD = &H0 or flag_LDS_SCAN_FSM = &H0 or flag_CUR_LOC_FNUM = &H0 or flag_LDS_SPD = &H0 Then read
        If flag_LDS_TONE_FREQ = &H0 Then write_LDS_TONE_FREQ_value = get_LDS_TONE_FREQ
        If flag_LDS_EXT_AB_DWNGRD = &H0 Then write_LDS_EXT_AB_DWNGRD_value = get_LDS_EXT_AB_DWNGRD
        If flag_LDS_SCAN_FSM = &H0 Then write_LDS_SCAN_FSM_value = get_LDS_SCAN_FSM
        If flag_CUR_LOC_FNUM = &H0 Then write_CUR_LOC_FNUM_value = get_CUR_LOC_FNUM
        If flag_LDS_SPD = &H0 Then write_LDS_SPD_value = get_LDS_SPD

        regValue = leftShift((write_LDS_TONE_FREQ_value and &H1), 15) + leftShift((write_LDS_EXT_AB_DWNGRD_value and &H1), 14) + leftShift((write_LDS_SCAN_FSM_value and &H3), 12) + leftShift((write_CUR_LOC_FNUM_value and &Hff), 4) + leftShift((write_LDS_SPD_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_TONE_FREQ_value = rightShift(data_low, 15) and &H1
        read_LDS_EXT_AB_DWNGRD_value = rightShift(data_low, 14) and &H1
        read_LDS_SCAN_FSM_value = rightShift(data_low, 12) and &H3
        read_CUR_LOC_FNUM_value = rightShift(data_low, 4) and &Hff
        LDS_SPD_mask = &Hf
        if data_low > LONG_MAX then
            if LDS_SPD_mask = mask then
                read_LDS_SPD_value = data_low
            else
                read_LDS_SPD_value = (data_low - H8000_0000) and LDS_SPD_mask
            end If
        else
            read_LDS_SPD_value = data_low and LDS_SPD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_TONE_FREQ_value = &H0
        flag_LDS_TONE_FREQ        = &H0
        write_LDS_EXT_AB_DWNGRD_value = &H0
        flag_LDS_EXT_AB_DWNGRD        = &H0
        write_LDS_SCAN_FSM_value = &H0
        flag_LDS_SCAN_FSM        = &H0
        write_CUR_LOC_FNUM_value = &H0
        flag_CUR_LOC_FNUM        = &H0
        write_LDS_SPD_value = &H0
        flag_LDS_SPD        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp97
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_TX_FSM_H                               [15:12]          get_LDS_TX_FSM_H
''                                                             set_LDS_TX_FSM_H
''                                                             read_LDS_TX_FSM_H
''                                                             write_LDS_TX_FSM_H
''---------------------------------------------------------------------------------
'' LDS_TX_FSM_L                               [11:8]           get_LDS_TX_FSM_L
''                                                             set_LDS_TX_FSM_L
''                                                             read_LDS_TX_FSM_L
''                                                             write_LDS_TX_FSM_L
''---------------------------------------------------------------------------------
'' LDS_ARB_FSM_H                              [7:4]            get_LDS_ARB_FSM_H
''                                                             set_LDS_ARB_FSM_H
''                                                             read_LDS_ARB_FSM_H
''                                                             write_LDS_ARB_FSM_H
''---------------------------------------------------------------------------------
'' LDS_ARB_FSM_L                              [3:0]            get_LDS_ARB_FSM_L
''                                                             set_LDS_ARB_FSM_L
''                                                             read_LDS_ARB_FSM_L
''                                                             write_LDS_ARB_FSM_L
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp97
    Private write_LDS_TX_FSM_H_value
    Private read_LDS_TX_FSM_H_value
    Private flag_LDS_TX_FSM_H
    Private write_LDS_TX_FSM_L_value
    Private read_LDS_TX_FSM_L_value
    Private flag_LDS_TX_FSM_L
    Private write_LDS_ARB_FSM_H_value
    Private read_LDS_ARB_FSM_H_value
    Private flag_LDS_ARB_FSM_H
    Private write_LDS_ARB_FSM_L_value
    Private read_LDS_ARB_FSM_L_value
    Private flag_LDS_ARB_FSM_L

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

    Property Get get_LDS_TX_FSM_H
        get_LDS_TX_FSM_H = read_LDS_TX_FSM_H_value
    End Property

    Property Let set_LDS_TX_FSM_H(aData)
        write_LDS_TX_FSM_H_value = aData
        flag_LDS_TX_FSM_H        = &H1
    End Property

    Property Get read_LDS_TX_FSM_H
        read
        read_LDS_TX_FSM_H = read_LDS_TX_FSM_H_value
    End Property

    Property Let write_LDS_TX_FSM_H(aData)
        set_LDS_TX_FSM_H = aData
        write
    End Property

    Property Get get_LDS_TX_FSM_L
        get_LDS_TX_FSM_L = read_LDS_TX_FSM_L_value
    End Property

    Property Let set_LDS_TX_FSM_L(aData)
        write_LDS_TX_FSM_L_value = aData
        flag_LDS_TX_FSM_L        = &H1
    End Property

    Property Get read_LDS_TX_FSM_L
        read
        read_LDS_TX_FSM_L = read_LDS_TX_FSM_L_value
    End Property

    Property Let write_LDS_TX_FSM_L(aData)
        set_LDS_TX_FSM_L = aData
        write
    End Property

    Property Get get_LDS_ARB_FSM_H
        get_LDS_ARB_FSM_H = read_LDS_ARB_FSM_H_value
    End Property

    Property Let set_LDS_ARB_FSM_H(aData)
        write_LDS_ARB_FSM_H_value = aData
        flag_LDS_ARB_FSM_H        = &H1
    End Property

    Property Get read_LDS_ARB_FSM_H
        read
        read_LDS_ARB_FSM_H = read_LDS_ARB_FSM_H_value
    End Property

    Property Let write_LDS_ARB_FSM_H(aData)
        set_LDS_ARB_FSM_H = aData
        write
    End Property

    Property Get get_LDS_ARB_FSM_L
        get_LDS_ARB_FSM_L = read_LDS_ARB_FSM_L_value
    End Property

    Property Let set_LDS_ARB_FSM_L(aData)
        write_LDS_ARB_FSM_L_value = aData
        flag_LDS_ARB_FSM_L        = &H1
    End Property

    Property Get read_LDS_ARB_FSM_L
        read
        read_LDS_ARB_FSM_L = read_LDS_ARB_FSM_L_value
    End Property

    Property Let write_LDS_ARB_FSM_L(aData)
        set_LDS_ARB_FSM_L = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_TX_FSM_H_value = rightShift(data_low, 12) and &Hf
        read_LDS_TX_FSM_L_value = rightShift(data_low, 8) and &Hf
        read_LDS_ARB_FSM_H_value = rightShift(data_low, 4) and &Hf
        LDS_ARB_FSM_L_mask = &Hf
        if data_low > LONG_MAX then
            if LDS_ARB_FSM_L_mask = mask then
                read_LDS_ARB_FSM_L_value = data_low
            else
                read_LDS_ARB_FSM_L_value = (data_low - H8000_0000) and LDS_ARB_FSM_L_mask
            end If
        else
            read_LDS_ARB_FSM_L_value = data_low and LDS_ARB_FSM_L_mask
        end If

    End Sub

    Sub write
        If flag_LDS_TX_FSM_H = &H0 or flag_LDS_TX_FSM_L = &H0 or flag_LDS_ARB_FSM_H = &H0 or flag_LDS_ARB_FSM_L = &H0 Then read
        If flag_LDS_TX_FSM_H = &H0 Then write_LDS_TX_FSM_H_value = get_LDS_TX_FSM_H
        If flag_LDS_TX_FSM_L = &H0 Then write_LDS_TX_FSM_L_value = get_LDS_TX_FSM_L
        If flag_LDS_ARB_FSM_H = &H0 Then write_LDS_ARB_FSM_H_value = get_LDS_ARB_FSM_H
        If flag_LDS_ARB_FSM_L = &H0 Then write_LDS_ARB_FSM_L_value = get_LDS_ARB_FSM_L

        regValue = leftShift((write_LDS_TX_FSM_H_value and &Hf), 12) + leftShift((write_LDS_TX_FSM_L_value and &Hf), 8) + leftShift((write_LDS_ARB_FSM_H_value and &Hf), 4) + leftShift((write_LDS_ARB_FSM_L_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_TX_FSM_H_value = rightShift(data_low, 12) and &Hf
        read_LDS_TX_FSM_L_value = rightShift(data_low, 8) and &Hf
        read_LDS_ARB_FSM_H_value = rightShift(data_low, 4) and &Hf
        LDS_ARB_FSM_L_mask = &Hf
        if data_low > LONG_MAX then
            if LDS_ARB_FSM_L_mask = mask then
                read_LDS_ARB_FSM_L_value = data_low
            else
                read_LDS_ARB_FSM_L_value = (data_low - H8000_0000) and LDS_ARB_FSM_L_mask
            end If
        else
            read_LDS_ARB_FSM_L_value = data_low and LDS_ARB_FSM_L_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_TX_FSM_H_value = &H0
        flag_LDS_TX_FSM_H        = &H0
        write_LDS_TX_FSM_L_value = &H0
        flag_LDS_TX_FSM_L        = &H0
        write_LDS_ARB_FSM_H_value = &H0
        flag_LDS_ARB_FSM_H        = &H0
        write_LDS_ARB_FSM_L_value = &H0
        flag_LDS_ARB_FSM_L        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp99
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_PGACTRL                                [15:10]          get_LDS_PGACTRL
''                                                             set_LDS_PGACTRL
''                                                             read_LDS_PGACTRL
''                                                             write_LDS_PGACTRL
''---------------------------------------------------------------------------------
'' TXDIS_TMR_OPT                              [9:7]            get_TXDIS_TMR_OPT
''                                                             set_TXDIS_TMR_OPT
''                                                             read_TXDIS_TMR_OPT
''                                                             write_TXDIS_TMR_OPT
''---------------------------------------------------------------------------------
'' LNK_TMR_OPT                                [6:4]            get_LNK_TMR_OPT
''                                                             set_LNK_TMR_OPT
''                                                             read_LNK_TMR_OPT
''                                                             write_LNK_TMR_OPT
''---------------------------------------------------------------------------------
'' BST_TMR_OPT                                [3:1]            get_BST_TMR_OPT
''                                                             set_BST_TMR_OPT
''                                                             read_BST_TMR_OPT
''                                                             write_BST_TMR_OPT
''---------------------------------------------------------------------------------
'' FASTBST                                    [0:0]            get_FASTBST
''                                                             set_FASTBST
''                                                             read_FASTBST
''                                                             write_FASTBST
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp99
    Private write_LDS_PGACTRL_value
    Private read_LDS_PGACTRL_value
    Private flag_LDS_PGACTRL
    Private write_TXDIS_TMR_OPT_value
    Private read_TXDIS_TMR_OPT_value
    Private flag_TXDIS_TMR_OPT
    Private write_LNK_TMR_OPT_value
    Private read_LNK_TMR_OPT_value
    Private flag_LNK_TMR_OPT
    Private write_BST_TMR_OPT_value
    Private read_BST_TMR_OPT_value
    Private flag_BST_TMR_OPT
    Private write_FASTBST_value
    Private read_FASTBST_value
    Private flag_FASTBST

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

    Property Get get_LDS_PGACTRL
        get_LDS_PGACTRL = read_LDS_PGACTRL_value
    End Property

    Property Let set_LDS_PGACTRL(aData)
        write_LDS_PGACTRL_value = aData
        flag_LDS_PGACTRL        = &H1
    End Property

    Property Get read_LDS_PGACTRL
        read
        read_LDS_PGACTRL = read_LDS_PGACTRL_value
    End Property

    Property Let write_LDS_PGACTRL(aData)
        set_LDS_PGACTRL = aData
        write
    End Property

    Property Get get_TXDIS_TMR_OPT
        get_TXDIS_TMR_OPT = read_TXDIS_TMR_OPT_value
    End Property

    Property Let set_TXDIS_TMR_OPT(aData)
        write_TXDIS_TMR_OPT_value = aData
        flag_TXDIS_TMR_OPT        = &H1
    End Property

    Property Get read_TXDIS_TMR_OPT
        read
        read_TXDIS_TMR_OPT = read_TXDIS_TMR_OPT_value
    End Property

    Property Let write_TXDIS_TMR_OPT(aData)
        set_TXDIS_TMR_OPT = aData
        write
    End Property

    Property Get get_LNK_TMR_OPT
        get_LNK_TMR_OPT = read_LNK_TMR_OPT_value
    End Property

    Property Let set_LNK_TMR_OPT(aData)
        write_LNK_TMR_OPT_value = aData
        flag_LNK_TMR_OPT        = &H1
    End Property

    Property Get read_LNK_TMR_OPT
        read
        read_LNK_TMR_OPT = read_LNK_TMR_OPT_value
    End Property

    Property Let write_LNK_TMR_OPT(aData)
        set_LNK_TMR_OPT = aData
        write
    End Property

    Property Get get_BST_TMR_OPT
        get_BST_TMR_OPT = read_BST_TMR_OPT_value
    End Property

    Property Let set_BST_TMR_OPT(aData)
        write_BST_TMR_OPT_value = aData
        flag_BST_TMR_OPT        = &H1
    End Property

    Property Get read_BST_TMR_OPT
        read
        read_BST_TMR_OPT = read_BST_TMR_OPT_value
    End Property

    Property Let write_BST_TMR_OPT(aData)
        set_BST_TMR_OPT = aData
        write
    End Property

    Property Get get_FASTBST
        get_FASTBST = read_FASTBST_value
    End Property

    Property Let set_FASTBST(aData)
        write_FASTBST_value = aData
        flag_FASTBST        = &H1
    End Property

    Property Get read_FASTBST
        read
        read_FASTBST = read_FASTBST_value
    End Property

    Property Let write_FASTBST(aData)
        set_FASTBST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_PGACTRL_value = rightShift(data_low, 10) and &H3f
        read_TXDIS_TMR_OPT_value = rightShift(data_low, 7) and &H7
        read_LNK_TMR_OPT_value = rightShift(data_low, 4) and &H7
        read_BST_TMR_OPT_value = rightShift(data_low, 1) and &H7
        FASTBST_mask = &H1
        if data_low > LONG_MAX then
            if FASTBST_mask = mask then
                read_FASTBST_value = data_low
            else
                read_FASTBST_value = (data_low - H8000_0000) and FASTBST_mask
            end If
        else
            read_FASTBST_value = data_low and FASTBST_mask
        end If

    End Sub

    Sub write
        If flag_LDS_PGACTRL = &H0 or flag_TXDIS_TMR_OPT = &H0 or flag_LNK_TMR_OPT = &H0 or flag_BST_TMR_OPT = &H0 or flag_FASTBST = &H0 Then read
        If flag_LDS_PGACTRL = &H0 Then write_LDS_PGACTRL_value = get_LDS_PGACTRL
        If flag_TXDIS_TMR_OPT = &H0 Then write_TXDIS_TMR_OPT_value = get_TXDIS_TMR_OPT
        If flag_LNK_TMR_OPT = &H0 Then write_LNK_TMR_OPT_value = get_LNK_TMR_OPT
        If flag_BST_TMR_OPT = &H0 Then write_BST_TMR_OPT_value = get_BST_TMR_OPT
        If flag_FASTBST = &H0 Then write_FASTBST_value = get_FASTBST

        regValue = leftShift((write_LDS_PGACTRL_value and &H3f), 10) + leftShift((write_TXDIS_TMR_OPT_value and &H7), 7) + leftShift((write_LNK_TMR_OPT_value and &H7), 4) + leftShift((write_BST_TMR_OPT_value and &H7), 1) + leftShift((write_FASTBST_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_PGACTRL_value = rightShift(data_low, 10) and &H3f
        read_TXDIS_TMR_OPT_value = rightShift(data_low, 7) and &H7
        read_LNK_TMR_OPT_value = rightShift(data_low, 4) and &H7
        read_BST_TMR_OPT_value = rightShift(data_low, 1) and &H7
        FASTBST_mask = &H1
        if data_low > LONG_MAX then
            if FASTBST_mask = mask then
                read_FASTBST_value = data_low
            else
                read_FASTBST_value = (data_low - H8000_0000) and FASTBST_mask
            end If
        else
            read_FASTBST_value = data_low and FASTBST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_PGACTRL_value = &H0
        flag_LDS_PGACTRL        = &H0
        write_TXDIS_TMR_OPT_value = &H0
        flag_TXDIS_TMR_OPT        = &H0
        write_LNK_TMR_OPT_value = &H0
        flag_LNK_TMR_OPT        = &H0
        write_BST_TMR_OPT_value = &H0
        flag_BST_TMR_OPT        = &H0
        write_FASTBST_value = &H0
        flag_FASTBST        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp9a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LRE_REG_OV_EN                              [15:15]          get_LRE_REG_OV_EN
''                                                             set_LRE_REG_OV_EN
''                                                             read_LRE_REG_OV_EN
''                                                             write_LRE_REG_OV_EN
''---------------------------------------------------------------------------------
'' LRE_REG_OV_VAL                             [14:14]          get_LRE_REG_OV_VAL
''                                                             set_LRE_REG_OV_VAL
''                                                             read_LRE_REG_OV_VAL
''                                                             write_LRE_REG_OV_VAL
''---------------------------------------------------------------------------------
'' LRE_REG_ACCESS_STAT                        [13:13]          get_LRE_REG_ACCESS_STAT
''                                                             set_LRE_REG_ACCESS_STAT
''                                                             read_LRE_REG_ACCESS_STAT
''                                                             write_LRE_REG_ACCESS_STAT
''---------------------------------------------------------------------------------
'' LDS_LINK_CHK_EN                            [12:12]          get_LDS_LINK_CHK_EN
''                                                             set_LDS_LINK_CHK_EN
''                                                             read_LDS_LINK_CHK_EN
''                                                             write_LDS_LINK_CHK_EN
''---------------------------------------------------------------------------------
'' BR_AGC_TAR_OV_EN                           [11:11]          get_BR_AGC_TAR_OV_EN
''                                                             set_BR_AGC_TAR_OV_EN
''                                                             read_BR_AGC_TAR_OV_EN
''                                                             write_BR_AGC_TAR_OV_EN
''---------------------------------------------------------------------------------
'' LDS_TIMER_OV_EN                            [10:10]          get_LDS_TIMER_OV_EN
''                                                             set_LDS_TIMER_OV_EN
''                                                             read_LDS_TIMER_OV_EN
''                                                             write_LDS_TIMER_OV_EN
''---------------------------------------------------------------------------------
'' BR_LOST_TOKEN_FIX                          [9:9]            get_BR_LOST_TOKEN_FIX
''                                                             set_BR_LOST_TOKEN_FIX
''                                                             read_BR_LOST_TOKEN_FIX
''                                                             write_BR_LOST_TOKEN_FIX
''---------------------------------------------------------------------------------
'' DLLCONV_EN_MSTR                            [8:8]            get_DLLCONV_EN_MSTR
''                                                             set_DLLCONV_EN_MSTR
''                                                             read_DLLCONV_EN_MSTR
''                                                             write_DLLCONV_EN_MSTR
''---------------------------------------------------------------------------------
'' BR_10M1P_HALFOUT_EN                        [7:7]            get_BR_10M1P_HALFOUT_EN
''                                                             set_BR_10M1P_HALFOUT_EN
''                                                             read_BR_10M1P_HALFOUT_EN
''                                                             write_BR_10M1P_HALFOUT_EN
''---------------------------------------------------------------------------------
'' BR_10M2P_HALFOUT_EN                        [6:6]            get_BR_10M2P_HALFOUT_EN
''                                                             set_BR_10M2P_HALFOUT_EN
''                                                             read_BR_10M2P_HALFOUT_EN
''                                                             write_BR_10M2P_HALFOUT_EN
''---------------------------------------------------------------------------------
'' BR_HALFOUT_EN                              [5:5]            get_BR_HALFOUT_EN
''                                                             set_BR_HALFOUT_EN
''                                                             read_BR_HALFOUT_EN
''                                                             write_BR_HALFOUT_EN
''---------------------------------------------------------------------------------
'' CLK100T_ECO_DIS                            [4:4]            get_CLK100T_ECO_DIS
''                                                             set_CLK100T_ECO_DIS
''                                                             read_CLK100T_ECO_DIS
''                                                             write_CLK100T_ECO_DIS
''---------------------------------------------------------------------------------
'' CH_STATUS                                  [3:0]            get_CH_STATUS
''                                                             set_CH_STATUS
''                                                             read_CH_STATUS
''                                                             write_CH_STATUS
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp9a
    Private write_LRE_REG_OV_EN_value
    Private read_LRE_REG_OV_EN_value
    Private flag_LRE_REG_OV_EN
    Private write_LRE_REG_OV_VAL_value
    Private read_LRE_REG_OV_VAL_value
    Private flag_LRE_REG_OV_VAL
    Private write_LRE_REG_ACCESS_STAT_value
    Private read_LRE_REG_ACCESS_STAT_value
    Private flag_LRE_REG_ACCESS_STAT
    Private write_LDS_LINK_CHK_EN_value
    Private read_LDS_LINK_CHK_EN_value
    Private flag_LDS_LINK_CHK_EN
    Private write_BR_AGC_TAR_OV_EN_value
    Private read_BR_AGC_TAR_OV_EN_value
    Private flag_BR_AGC_TAR_OV_EN
    Private write_LDS_TIMER_OV_EN_value
    Private read_LDS_TIMER_OV_EN_value
    Private flag_LDS_TIMER_OV_EN
    Private write_BR_LOST_TOKEN_FIX_value
    Private read_BR_LOST_TOKEN_FIX_value
    Private flag_BR_LOST_TOKEN_FIX
    Private write_DLLCONV_EN_MSTR_value
    Private read_DLLCONV_EN_MSTR_value
    Private flag_DLLCONV_EN_MSTR
    Private write_BR_10M1P_HALFOUT_EN_value
    Private read_BR_10M1P_HALFOUT_EN_value
    Private flag_BR_10M1P_HALFOUT_EN
    Private write_BR_10M2P_HALFOUT_EN_value
    Private read_BR_10M2P_HALFOUT_EN_value
    Private flag_BR_10M2P_HALFOUT_EN
    Private write_BR_HALFOUT_EN_value
    Private read_BR_HALFOUT_EN_value
    Private flag_BR_HALFOUT_EN
    Private write_CLK100T_ECO_DIS_value
    Private read_CLK100T_ECO_DIS_value
    Private flag_CLK100T_ECO_DIS
    Private write_CH_STATUS_value
    Private read_CH_STATUS_value
    Private flag_CH_STATUS

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

    Property Get get_LRE_REG_OV_EN
        get_LRE_REG_OV_EN = read_LRE_REG_OV_EN_value
    End Property

    Property Let set_LRE_REG_OV_EN(aData)
        write_LRE_REG_OV_EN_value = aData
        flag_LRE_REG_OV_EN        = &H1
    End Property

    Property Get read_LRE_REG_OV_EN
        read
        read_LRE_REG_OV_EN = read_LRE_REG_OV_EN_value
    End Property

    Property Let write_LRE_REG_OV_EN(aData)
        set_LRE_REG_OV_EN = aData
        write
    End Property

    Property Get get_LRE_REG_OV_VAL
        get_LRE_REG_OV_VAL = read_LRE_REG_OV_VAL_value
    End Property

    Property Let set_LRE_REG_OV_VAL(aData)
        write_LRE_REG_OV_VAL_value = aData
        flag_LRE_REG_OV_VAL        = &H1
    End Property

    Property Get read_LRE_REG_OV_VAL
        read
        read_LRE_REG_OV_VAL = read_LRE_REG_OV_VAL_value
    End Property

    Property Let write_LRE_REG_OV_VAL(aData)
        set_LRE_REG_OV_VAL = aData
        write
    End Property

    Property Get get_LRE_REG_ACCESS_STAT
        get_LRE_REG_ACCESS_STAT = read_LRE_REG_ACCESS_STAT_value
    End Property

    Property Let set_LRE_REG_ACCESS_STAT(aData)
        write_LRE_REG_ACCESS_STAT_value = aData
        flag_LRE_REG_ACCESS_STAT        = &H1
    End Property

    Property Get read_LRE_REG_ACCESS_STAT
        read
        read_LRE_REG_ACCESS_STAT = read_LRE_REG_ACCESS_STAT_value
    End Property

    Property Let write_LRE_REG_ACCESS_STAT(aData)
        set_LRE_REG_ACCESS_STAT = aData
        write
    End Property

    Property Get get_LDS_LINK_CHK_EN
        get_LDS_LINK_CHK_EN = read_LDS_LINK_CHK_EN_value
    End Property

    Property Let set_LDS_LINK_CHK_EN(aData)
        write_LDS_LINK_CHK_EN_value = aData
        flag_LDS_LINK_CHK_EN        = &H1
    End Property

    Property Get read_LDS_LINK_CHK_EN
        read
        read_LDS_LINK_CHK_EN = read_LDS_LINK_CHK_EN_value
    End Property

    Property Let write_LDS_LINK_CHK_EN(aData)
        set_LDS_LINK_CHK_EN = aData
        write
    End Property

    Property Get get_BR_AGC_TAR_OV_EN
        get_BR_AGC_TAR_OV_EN = read_BR_AGC_TAR_OV_EN_value
    End Property

    Property Let set_BR_AGC_TAR_OV_EN(aData)
        write_BR_AGC_TAR_OV_EN_value = aData
        flag_BR_AGC_TAR_OV_EN        = &H1
    End Property

    Property Get read_BR_AGC_TAR_OV_EN
        read
        read_BR_AGC_TAR_OV_EN = read_BR_AGC_TAR_OV_EN_value
    End Property

    Property Let write_BR_AGC_TAR_OV_EN(aData)
        set_BR_AGC_TAR_OV_EN = aData
        write
    End Property

    Property Get get_LDS_TIMER_OV_EN
        get_LDS_TIMER_OV_EN = read_LDS_TIMER_OV_EN_value
    End Property

    Property Let set_LDS_TIMER_OV_EN(aData)
        write_LDS_TIMER_OV_EN_value = aData
        flag_LDS_TIMER_OV_EN        = &H1
    End Property

    Property Get read_LDS_TIMER_OV_EN
        read
        read_LDS_TIMER_OV_EN = read_LDS_TIMER_OV_EN_value
    End Property

    Property Let write_LDS_TIMER_OV_EN(aData)
        set_LDS_TIMER_OV_EN = aData
        write
    End Property

    Property Get get_BR_LOST_TOKEN_FIX
        get_BR_LOST_TOKEN_FIX = read_BR_LOST_TOKEN_FIX_value
    End Property

    Property Let set_BR_LOST_TOKEN_FIX(aData)
        write_BR_LOST_TOKEN_FIX_value = aData
        flag_BR_LOST_TOKEN_FIX        = &H1
    End Property

    Property Get read_BR_LOST_TOKEN_FIX
        read
        read_BR_LOST_TOKEN_FIX = read_BR_LOST_TOKEN_FIX_value
    End Property

    Property Let write_BR_LOST_TOKEN_FIX(aData)
        set_BR_LOST_TOKEN_FIX = aData
        write
    End Property

    Property Get get_DLLCONV_EN_MSTR
        get_DLLCONV_EN_MSTR = read_DLLCONV_EN_MSTR_value
    End Property

    Property Let set_DLLCONV_EN_MSTR(aData)
        write_DLLCONV_EN_MSTR_value = aData
        flag_DLLCONV_EN_MSTR        = &H1
    End Property

    Property Get read_DLLCONV_EN_MSTR
        read
        read_DLLCONV_EN_MSTR = read_DLLCONV_EN_MSTR_value
    End Property

    Property Let write_DLLCONV_EN_MSTR(aData)
        set_DLLCONV_EN_MSTR = aData
        write
    End Property

    Property Get get_BR_10M1P_HALFOUT_EN
        get_BR_10M1P_HALFOUT_EN = read_BR_10M1P_HALFOUT_EN_value
    End Property

    Property Let set_BR_10M1P_HALFOUT_EN(aData)
        write_BR_10M1P_HALFOUT_EN_value = aData
        flag_BR_10M1P_HALFOUT_EN        = &H1
    End Property

    Property Get read_BR_10M1P_HALFOUT_EN
        read
        read_BR_10M1P_HALFOUT_EN = read_BR_10M1P_HALFOUT_EN_value
    End Property

    Property Let write_BR_10M1P_HALFOUT_EN(aData)
        set_BR_10M1P_HALFOUT_EN = aData
        write
    End Property

    Property Get get_BR_10M2P_HALFOUT_EN
        get_BR_10M2P_HALFOUT_EN = read_BR_10M2P_HALFOUT_EN_value
    End Property

    Property Let set_BR_10M2P_HALFOUT_EN(aData)
        write_BR_10M2P_HALFOUT_EN_value = aData
        flag_BR_10M2P_HALFOUT_EN        = &H1
    End Property

    Property Get read_BR_10M2P_HALFOUT_EN
        read
        read_BR_10M2P_HALFOUT_EN = read_BR_10M2P_HALFOUT_EN_value
    End Property

    Property Let write_BR_10M2P_HALFOUT_EN(aData)
        set_BR_10M2P_HALFOUT_EN = aData
        write
    End Property

    Property Get get_BR_HALFOUT_EN
        get_BR_HALFOUT_EN = read_BR_HALFOUT_EN_value
    End Property

    Property Let set_BR_HALFOUT_EN(aData)
        write_BR_HALFOUT_EN_value = aData
        flag_BR_HALFOUT_EN        = &H1
    End Property

    Property Get read_BR_HALFOUT_EN
        read
        read_BR_HALFOUT_EN = read_BR_HALFOUT_EN_value
    End Property

    Property Let write_BR_HALFOUT_EN(aData)
        set_BR_HALFOUT_EN = aData
        write
    End Property

    Property Get get_CLK100T_ECO_DIS
        get_CLK100T_ECO_DIS = read_CLK100T_ECO_DIS_value
    End Property

    Property Let set_CLK100T_ECO_DIS(aData)
        write_CLK100T_ECO_DIS_value = aData
        flag_CLK100T_ECO_DIS        = &H1
    End Property

    Property Get read_CLK100T_ECO_DIS
        read
        read_CLK100T_ECO_DIS = read_CLK100T_ECO_DIS_value
    End Property

    Property Let write_CLK100T_ECO_DIS(aData)
        set_CLK100T_ECO_DIS = aData
        write
    End Property

    Property Get get_CH_STATUS
        get_CH_STATUS = read_CH_STATUS_value
    End Property

    Property Let set_CH_STATUS(aData)
        write_CH_STATUS_value = aData
        flag_CH_STATUS        = &H1
    End Property

    Property Get read_CH_STATUS
        read
        read_CH_STATUS = read_CH_STATUS_value
    End Property

    Property Let write_CH_STATUS(aData)
        set_CH_STATUS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LRE_REG_OV_EN_value = rightShift(data_low, 15) and &H1
        read_LRE_REG_OV_VAL_value = rightShift(data_low, 14) and &H1
        read_LRE_REG_ACCESS_STAT_value = rightShift(data_low, 13) and &H1
        read_LDS_LINK_CHK_EN_value = rightShift(data_low, 12) and &H1
        read_BR_AGC_TAR_OV_EN_value = rightShift(data_low, 11) and &H1
        read_LDS_TIMER_OV_EN_value = rightShift(data_low, 10) and &H1
        read_BR_LOST_TOKEN_FIX_value = rightShift(data_low, 9) and &H1
        read_DLLCONV_EN_MSTR_value = rightShift(data_low, 8) and &H1
        read_BR_10M1P_HALFOUT_EN_value = rightShift(data_low, 7) and &H1
        read_BR_10M2P_HALFOUT_EN_value = rightShift(data_low, 6) and &H1
        read_BR_HALFOUT_EN_value = rightShift(data_low, 5) and &H1
        read_CLK100T_ECO_DIS_value = rightShift(data_low, 4) and &H1
        CH_STATUS_mask = &Hf
        if data_low > LONG_MAX then
            if CH_STATUS_mask = mask then
                read_CH_STATUS_value = data_low
            else
                read_CH_STATUS_value = (data_low - H8000_0000) and CH_STATUS_mask
            end If
        else
            read_CH_STATUS_value = data_low and CH_STATUS_mask
        end If

    End Sub

    Sub write
        If flag_LRE_REG_OV_EN = &H0 or flag_LRE_REG_OV_VAL = &H0 or flag_LRE_REG_ACCESS_STAT = &H0 or flag_LDS_LINK_CHK_EN = &H0 or flag_BR_AGC_TAR_OV_EN = &H0 or flag_LDS_TIMER_OV_EN = &H0 or flag_BR_LOST_TOKEN_FIX = &H0 or flag_DLLCONV_EN_MSTR = &H0 or flag_BR_10M1P_HALFOUT_EN = &H0 or flag_BR_10M2P_HALFOUT_EN = &H0 or flag_BR_HALFOUT_EN = &H0 or flag_CLK100T_ECO_DIS = &H0 or flag_CH_STATUS = &H0 Then read
        If flag_LRE_REG_OV_EN = &H0 Then write_LRE_REG_OV_EN_value = get_LRE_REG_OV_EN
        If flag_LRE_REG_OV_VAL = &H0 Then write_LRE_REG_OV_VAL_value = get_LRE_REG_OV_VAL
        If flag_LRE_REG_ACCESS_STAT = &H0 Then write_LRE_REG_ACCESS_STAT_value = get_LRE_REG_ACCESS_STAT
        If flag_LDS_LINK_CHK_EN = &H0 Then write_LDS_LINK_CHK_EN_value = get_LDS_LINK_CHK_EN
        If flag_BR_AGC_TAR_OV_EN = &H0 Then write_BR_AGC_TAR_OV_EN_value = get_BR_AGC_TAR_OV_EN
        If flag_LDS_TIMER_OV_EN = &H0 Then write_LDS_TIMER_OV_EN_value = get_LDS_TIMER_OV_EN
        If flag_BR_LOST_TOKEN_FIX = &H0 Then write_BR_LOST_TOKEN_FIX_value = get_BR_LOST_TOKEN_FIX
        If flag_DLLCONV_EN_MSTR = &H0 Then write_DLLCONV_EN_MSTR_value = get_DLLCONV_EN_MSTR
        If flag_BR_10M1P_HALFOUT_EN = &H0 Then write_BR_10M1P_HALFOUT_EN_value = get_BR_10M1P_HALFOUT_EN
        If flag_BR_10M2P_HALFOUT_EN = &H0 Then write_BR_10M2P_HALFOUT_EN_value = get_BR_10M2P_HALFOUT_EN
        If flag_BR_HALFOUT_EN = &H0 Then write_BR_HALFOUT_EN_value = get_BR_HALFOUT_EN
        If flag_CLK100T_ECO_DIS = &H0 Then write_CLK100T_ECO_DIS_value = get_CLK100T_ECO_DIS
        If flag_CH_STATUS = &H0 Then write_CH_STATUS_value = get_CH_STATUS

        regValue = leftShift((write_LRE_REG_OV_EN_value and &H1), 15) + leftShift((write_LRE_REG_OV_VAL_value and &H1), 14) + leftShift((write_LRE_REG_ACCESS_STAT_value and &H1), 13) + leftShift((write_LDS_LINK_CHK_EN_value and &H1), 12) + leftShift((write_BR_AGC_TAR_OV_EN_value and &H1), 11) + leftShift((write_LDS_TIMER_OV_EN_value and &H1), 10) + leftShift((write_BR_LOST_TOKEN_FIX_value and &H1), 9) + leftShift((write_DLLCONV_EN_MSTR_value and &H1), 8) + leftShift((write_BR_10M1P_HALFOUT_EN_value and &H1), 7) + leftShift((write_BR_10M2P_HALFOUT_EN_value and &H1), 6) + leftShift((write_BR_HALFOUT_EN_value and &H1), 5) + leftShift((write_CLK100T_ECO_DIS_value and &H1), 4) + leftShift((write_CH_STATUS_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LRE_REG_OV_EN_value = rightShift(data_low, 15) and &H1
        read_LRE_REG_OV_VAL_value = rightShift(data_low, 14) and &H1
        read_LRE_REG_ACCESS_STAT_value = rightShift(data_low, 13) and &H1
        read_LDS_LINK_CHK_EN_value = rightShift(data_low, 12) and &H1
        read_BR_AGC_TAR_OV_EN_value = rightShift(data_low, 11) and &H1
        read_LDS_TIMER_OV_EN_value = rightShift(data_low, 10) and &H1
        read_BR_LOST_TOKEN_FIX_value = rightShift(data_low, 9) and &H1
        read_DLLCONV_EN_MSTR_value = rightShift(data_low, 8) and &H1
        read_BR_10M1P_HALFOUT_EN_value = rightShift(data_low, 7) and &H1
        read_BR_10M2P_HALFOUT_EN_value = rightShift(data_low, 6) and &H1
        read_BR_HALFOUT_EN_value = rightShift(data_low, 5) and &H1
        read_CLK100T_ECO_DIS_value = rightShift(data_low, 4) and &H1
        CH_STATUS_mask = &Hf
        if data_low > LONG_MAX then
            if CH_STATUS_mask = mask then
                read_CH_STATUS_value = data_low
            else
                read_CH_STATUS_value = (data_low - H8000_0000) and CH_STATUS_mask
            end If
        else
            read_CH_STATUS_value = data_low and CH_STATUS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LRE_REG_OV_EN_value = &H0
        flag_LRE_REG_OV_EN        = &H0
        write_LRE_REG_OV_VAL_value = &H0
        flag_LRE_REG_OV_VAL        = &H0
        write_LRE_REG_ACCESS_STAT_value = &H0
        flag_LRE_REG_ACCESS_STAT        = &H0
        write_LDS_LINK_CHK_EN_value = &H0
        flag_LDS_LINK_CHK_EN        = &H0
        write_BR_AGC_TAR_OV_EN_value = &H0
        flag_BR_AGC_TAR_OV_EN        = &H0
        write_LDS_TIMER_OV_EN_value = &H0
        flag_LDS_TIMER_OV_EN        = &H0
        write_BR_LOST_TOKEN_FIX_value = &H0
        flag_BR_LOST_TOKEN_FIX        = &H0
        write_DLLCONV_EN_MSTR_value = &H0
        flag_DLLCONV_EN_MSTR        = &H0
        write_BR_10M1P_HALFOUT_EN_value = &H0
        flag_BR_10M1P_HALFOUT_EN        = &H0
        write_BR_10M2P_HALFOUT_EN_value = &H0
        flag_BR_10M2P_HALFOUT_EN        = &H0
        write_BR_HALFOUT_EN_value = &H0
        flag_BR_HALFOUT_EN        = &H0
        write_CLK100T_ECO_DIS_value = &H0
        flag_CLK100T_ECO_DIS        = &H0
        write_CH_STATUS_value = &H0
        flag_CH_STATUS        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp9b
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
'' BR_200MBPS_CLK_EN                          [12:12]          get_BR_200MBPS_CLK_EN
''                                                             set_BR_200MBPS_CLK_EN
''                                                             read_BR_200MBPS_CLK_EN
''                                                             write_BR_200MBPS_CLK_EN
''---------------------------------------------------------------------------------
'' BR_TXCLK_EN                                [11:11]          get_BR_TXCLK_EN
''                                                             set_BR_TXCLK_EN
''                                                             read_BR_TXCLK_EN
''                                                             write_BR_TXCLK_EN
''---------------------------------------------------------------------------------
'' BR_TXRXICLK_EN                             [10:10]          get_BR_TXRXICLK_EN
''                                                             set_BR_TXRXICLK_EN
''                                                             read_BR_TXRXICLK_EN
''                                                             write_BR_TXRXICLK_EN
''---------------------------------------------------------------------------------
'' CLK_1G_DIV20                               [9:9]            get_CLK_1G_DIV20
''                                                             set_CLK_1G_DIV20
''                                                             read_CLK_1G_DIV20
''                                                             write_CLK_1G_DIV20
''---------------------------------------------------------------------------------
'' LVL1_PROG_FREQ_DIV                         [8:5]            get_LVL1_PROG_FREQ_DIV
''                                                             set_LVL1_PROG_FREQ_DIV
''                                                             read_LVL1_PROG_FREQ_DIV
''                                                             write_LVL1_PROG_FREQ_DIV
''---------------------------------------------------------------------------------
'' LVL2_PROG_FREQ_DIV                         [4:1]            get_LVL2_PROG_FREQ_DIV
''                                                             set_LVL2_PROG_FREQ_DIV
''                                                             read_LVL2_PROG_FREQ_DIV
''                                                             write_LVL2_PROG_FREQ_DIV
''---------------------------------------------------------------------------------
'' BR_PLL_CTL_EN                              [0:0]            get_BR_PLL_CTL_EN
''                                                             set_BR_PLL_CTL_EN
''                                                             read_BR_PLL_CTL_EN
''                                                             write_BR_PLL_CTL_EN
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp9b
    Private write_BR_RATE_OV_value
    Private read_BR_RATE_OV_value
    Private flag_BR_RATE_OV
    Private write_BR_200MBPS_CLK_EN_value
    Private read_BR_200MBPS_CLK_EN_value
    Private flag_BR_200MBPS_CLK_EN
    Private write_BR_TXCLK_EN_value
    Private read_BR_TXCLK_EN_value
    Private flag_BR_TXCLK_EN
    Private write_BR_TXRXICLK_EN_value
    Private read_BR_TXRXICLK_EN_value
    Private flag_BR_TXRXICLK_EN
    Private write_CLK_1G_DIV20_value
    Private read_CLK_1G_DIV20_value
    Private flag_CLK_1G_DIV20
    Private write_LVL1_PROG_FREQ_DIV_value
    Private read_LVL1_PROG_FREQ_DIV_value
    Private flag_LVL1_PROG_FREQ_DIV
    Private write_LVL2_PROG_FREQ_DIV_value
    Private read_LVL2_PROG_FREQ_DIV_value
    Private flag_LVL2_PROG_FREQ_DIV
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

    Property Get get_BR_200MBPS_CLK_EN
        get_BR_200MBPS_CLK_EN = read_BR_200MBPS_CLK_EN_value
    End Property

    Property Let set_BR_200MBPS_CLK_EN(aData)
        write_BR_200MBPS_CLK_EN_value = aData
        flag_BR_200MBPS_CLK_EN        = &H1
    End Property

    Property Get read_BR_200MBPS_CLK_EN
        read
        read_BR_200MBPS_CLK_EN = read_BR_200MBPS_CLK_EN_value
    End Property

    Property Let write_BR_200MBPS_CLK_EN(aData)
        set_BR_200MBPS_CLK_EN = aData
        write
    End Property

    Property Get get_BR_TXCLK_EN
        get_BR_TXCLK_EN = read_BR_TXCLK_EN_value
    End Property

    Property Let set_BR_TXCLK_EN(aData)
        write_BR_TXCLK_EN_value = aData
        flag_BR_TXCLK_EN        = &H1
    End Property

    Property Get read_BR_TXCLK_EN
        read
        read_BR_TXCLK_EN = read_BR_TXCLK_EN_value
    End Property

    Property Let write_BR_TXCLK_EN(aData)
        set_BR_TXCLK_EN = aData
        write
    End Property

    Property Get get_BR_TXRXICLK_EN
        get_BR_TXRXICLK_EN = read_BR_TXRXICLK_EN_value
    End Property

    Property Let set_BR_TXRXICLK_EN(aData)
        write_BR_TXRXICLK_EN_value = aData
        flag_BR_TXRXICLK_EN        = &H1
    End Property

    Property Get read_BR_TXRXICLK_EN
        read
        read_BR_TXRXICLK_EN = read_BR_TXRXICLK_EN_value
    End Property

    Property Let write_BR_TXRXICLK_EN(aData)
        set_BR_TXRXICLK_EN = aData
        write
    End Property

    Property Get get_CLK_1G_DIV20
        get_CLK_1G_DIV20 = read_CLK_1G_DIV20_value
    End Property

    Property Let set_CLK_1G_DIV20(aData)
        write_CLK_1G_DIV20_value = aData
        flag_CLK_1G_DIV20        = &H1
    End Property

    Property Get read_CLK_1G_DIV20
        read
        read_CLK_1G_DIV20 = read_CLK_1G_DIV20_value
    End Property

    Property Let write_CLK_1G_DIV20(aData)
        set_CLK_1G_DIV20 = aData
        write
    End Property

    Property Get get_LVL1_PROG_FREQ_DIV
        get_LVL1_PROG_FREQ_DIV = read_LVL1_PROG_FREQ_DIV_value
    End Property

    Property Let set_LVL1_PROG_FREQ_DIV(aData)
        write_LVL1_PROG_FREQ_DIV_value = aData
        flag_LVL1_PROG_FREQ_DIV        = &H1
    End Property

    Property Get read_LVL1_PROG_FREQ_DIV
        read
        read_LVL1_PROG_FREQ_DIV = read_LVL1_PROG_FREQ_DIV_value
    End Property

    Property Let write_LVL1_PROG_FREQ_DIV(aData)
        set_LVL1_PROG_FREQ_DIV = aData
        write
    End Property

    Property Get get_LVL2_PROG_FREQ_DIV
        get_LVL2_PROG_FREQ_DIV = read_LVL2_PROG_FREQ_DIV_value
    End Property

    Property Let set_LVL2_PROG_FREQ_DIV(aData)
        write_LVL2_PROG_FREQ_DIV_value = aData
        flag_LVL2_PROG_FREQ_DIV        = &H1
    End Property

    Property Get read_LVL2_PROG_FREQ_DIV
        read
        read_LVL2_PROG_FREQ_DIV = read_LVL2_PROG_FREQ_DIV_value
    End Property

    Property Let write_LVL2_PROG_FREQ_DIV(aData)
        set_LVL2_PROG_FREQ_DIV = aData
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
        read_BR_200MBPS_CLK_EN_value = rightShift(data_low, 12) and &H1
        read_BR_TXCLK_EN_value = rightShift(data_low, 11) and &H1
        read_BR_TXRXICLK_EN_value = rightShift(data_low, 10) and &H1
        read_CLK_1G_DIV20_value = rightShift(data_low, 9) and &H1
        read_LVL1_PROG_FREQ_DIV_value = rightShift(data_low, 5) and &Hf
        read_LVL2_PROG_FREQ_DIV_value = rightShift(data_low, 1) and &Hf
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
        If flag_BR_RATE_OV = &H0 or flag_BR_200MBPS_CLK_EN = &H0 or flag_BR_TXCLK_EN = &H0 or flag_BR_TXRXICLK_EN = &H0 or flag_CLK_1G_DIV20 = &H0 or flag_LVL1_PROG_FREQ_DIV = &H0 or flag_LVL2_PROG_FREQ_DIV = &H0 or flag_BR_PLL_CTL_EN = &H0 Then read
        If flag_BR_RATE_OV = &H0 Then write_BR_RATE_OV_value = get_BR_RATE_OV
        If flag_BR_200MBPS_CLK_EN = &H0 Then write_BR_200MBPS_CLK_EN_value = get_BR_200MBPS_CLK_EN
        If flag_BR_TXCLK_EN = &H0 Then write_BR_TXCLK_EN_value = get_BR_TXCLK_EN
        If flag_BR_TXRXICLK_EN = &H0 Then write_BR_TXRXICLK_EN_value = get_BR_TXRXICLK_EN
        If flag_CLK_1G_DIV20 = &H0 Then write_CLK_1G_DIV20_value = get_CLK_1G_DIV20
        If flag_LVL1_PROG_FREQ_DIV = &H0 Then write_LVL1_PROG_FREQ_DIV_value = get_LVL1_PROG_FREQ_DIV
        If flag_LVL2_PROG_FREQ_DIV = &H0 Then write_LVL2_PROG_FREQ_DIV_value = get_LVL2_PROG_FREQ_DIV
        If flag_BR_PLL_CTL_EN = &H0 Then write_BR_PLL_CTL_EN_value = get_BR_PLL_CTL_EN

        regValue = leftShift((write_BR_RATE_OV_value and &H7), 13) + leftShift((write_BR_200MBPS_CLK_EN_value and &H1), 12) + leftShift((write_BR_TXCLK_EN_value and &H1), 11) + leftShift((write_BR_TXRXICLK_EN_value and &H1), 10) + leftShift((write_CLK_1G_DIV20_value and &H1), 9) + leftShift((write_LVL1_PROG_FREQ_DIV_value and &Hf), 5) + leftShift((write_LVL2_PROG_FREQ_DIV_value and &Hf), 1) + leftShift((write_BR_PLL_CTL_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_RATE_OV_value = rightShift(data_low, 13) and &H7
        read_BR_200MBPS_CLK_EN_value = rightShift(data_low, 12) and &H1
        read_BR_TXCLK_EN_value = rightShift(data_low, 11) and &H1
        read_BR_TXRXICLK_EN_value = rightShift(data_low, 10) and &H1
        read_CLK_1G_DIV20_value = rightShift(data_low, 9) and &H1
        read_LVL1_PROG_FREQ_DIV_value = rightShift(data_low, 5) and &Hf
        read_LVL2_PROG_FREQ_DIV_value = rightShift(data_low, 1) and &Hf
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
        write_BR_200MBPS_CLK_EN_value = &H0
        flag_BR_200MBPS_CLK_EN        = &H0
        write_BR_TXCLK_EN_value = &H0
        flag_BR_TXCLK_EN        = &H0
        write_BR_TXRXICLK_EN_value = &H0
        flag_BR_TXRXICLK_EN        = &H0
        write_CLK_1G_DIV20_value = &H0
        flag_CLK_1G_DIV20        = &H0
        write_LVL1_PROG_FREQ_DIV_value = &H0
        flag_LVL1_PROG_FREQ_DIV        = &H0
        write_LVL2_PROG_FREQ_DIV_value = &H0
        flag_LVL2_PROG_FREQ_DIV        = &H0
        write_BR_PLL_CTL_EN_value = &H0
        flag_BR_PLL_CTL_EN        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp9d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BR_IPR_BYPASS                              [15:15]          get_BR_IPR_BYPASS
''                                                             set_BR_IPR_BYPASS
''                                                             read_BR_IPR_BYPASS
''                                                             write_BR_IPR_BYPASS
''---------------------------------------------------------------------------------
'' BR_CLOCK_ON_OV_VAL                         [14:14]          get_BR_CLOCK_ON_OV_VAL
''                                                             set_BR_CLOCK_ON_OV_VAL
''                                                             read_BR_CLOCK_ON_OV_VAL
''                                                             write_BR_CLOCK_ON_OV_VAL
''---------------------------------------------------------------------------------
'' BR_CLOCK_ON_OV_EN                          [13:13]          get_BR_CLOCK_ON_OV_EN
''                                                             set_BR_CLOCK_ON_OV_EN
''                                                             read_BR_CLOCK_ON_OV_EN
''                                                             write_BR_CLOCK_ON_OV_EN
''---------------------------------------------------------------------------------
'' LDS_SD_THR                                 [12:8]           get_LDS_SD_THR
''                                                             set_LDS_SD_THR
''                                                             read_LDS_SD_THR
''                                                             write_LDS_SD_THR
''---------------------------------------------------------------------------------
'' LDS_PEAK_THR_T125                          [7:0]            get_LDS_PEAK_THR_T125
''                                                             set_LDS_PEAK_THR_T125
''                                                             read_LDS_PEAK_THR_T125
''                                                             write_LDS_PEAK_THR_T125
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp9d
    Private write_BR_IPR_BYPASS_value
    Private read_BR_IPR_BYPASS_value
    Private flag_BR_IPR_BYPASS
    Private write_BR_CLOCK_ON_OV_VAL_value
    Private read_BR_CLOCK_ON_OV_VAL_value
    Private flag_BR_CLOCK_ON_OV_VAL
    Private write_BR_CLOCK_ON_OV_EN_value
    Private read_BR_CLOCK_ON_OV_EN_value
    Private flag_BR_CLOCK_ON_OV_EN
    Private write_LDS_SD_THR_value
    Private read_LDS_SD_THR_value
    Private flag_LDS_SD_THR
    Private write_LDS_PEAK_THR_T125_value
    Private read_LDS_PEAK_THR_T125_value
    Private flag_LDS_PEAK_THR_T125

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

    Property Get get_BR_IPR_BYPASS
        get_BR_IPR_BYPASS = read_BR_IPR_BYPASS_value
    End Property

    Property Let set_BR_IPR_BYPASS(aData)
        write_BR_IPR_BYPASS_value = aData
        flag_BR_IPR_BYPASS        = &H1
    End Property

    Property Get read_BR_IPR_BYPASS
        read
        read_BR_IPR_BYPASS = read_BR_IPR_BYPASS_value
    End Property

    Property Let write_BR_IPR_BYPASS(aData)
        set_BR_IPR_BYPASS = aData
        write
    End Property

    Property Get get_BR_CLOCK_ON_OV_VAL
        get_BR_CLOCK_ON_OV_VAL = read_BR_CLOCK_ON_OV_VAL_value
    End Property

    Property Let set_BR_CLOCK_ON_OV_VAL(aData)
        write_BR_CLOCK_ON_OV_VAL_value = aData
        flag_BR_CLOCK_ON_OV_VAL        = &H1
    End Property

    Property Get read_BR_CLOCK_ON_OV_VAL
        read
        read_BR_CLOCK_ON_OV_VAL = read_BR_CLOCK_ON_OV_VAL_value
    End Property

    Property Let write_BR_CLOCK_ON_OV_VAL(aData)
        set_BR_CLOCK_ON_OV_VAL = aData
        write
    End Property

    Property Get get_BR_CLOCK_ON_OV_EN
        get_BR_CLOCK_ON_OV_EN = read_BR_CLOCK_ON_OV_EN_value
    End Property

    Property Let set_BR_CLOCK_ON_OV_EN(aData)
        write_BR_CLOCK_ON_OV_EN_value = aData
        flag_BR_CLOCK_ON_OV_EN        = &H1
    End Property

    Property Get read_BR_CLOCK_ON_OV_EN
        read
        read_BR_CLOCK_ON_OV_EN = read_BR_CLOCK_ON_OV_EN_value
    End Property

    Property Let write_BR_CLOCK_ON_OV_EN(aData)
        set_BR_CLOCK_ON_OV_EN = aData
        write
    End Property

    Property Get get_LDS_SD_THR
        get_LDS_SD_THR = read_LDS_SD_THR_value
    End Property

    Property Let set_LDS_SD_THR(aData)
        write_LDS_SD_THR_value = aData
        flag_LDS_SD_THR        = &H1
    End Property

    Property Get read_LDS_SD_THR
        read
        read_LDS_SD_THR = read_LDS_SD_THR_value
    End Property

    Property Let write_LDS_SD_THR(aData)
        set_LDS_SD_THR = aData
        write
    End Property

    Property Get get_LDS_PEAK_THR_T125
        get_LDS_PEAK_THR_T125 = read_LDS_PEAK_THR_T125_value
    End Property

    Property Let set_LDS_PEAK_THR_T125(aData)
        write_LDS_PEAK_THR_T125_value = aData
        flag_LDS_PEAK_THR_T125        = &H1
    End Property

    Property Get read_LDS_PEAK_THR_T125
        read
        read_LDS_PEAK_THR_T125 = read_LDS_PEAK_THR_T125_value
    End Property

    Property Let write_LDS_PEAK_THR_T125(aData)
        set_LDS_PEAK_THR_T125 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_IPR_BYPASS_value = rightShift(data_low, 15) and &H1
        read_BR_CLOCK_ON_OV_VAL_value = rightShift(data_low, 14) and &H1
        read_BR_CLOCK_ON_OV_EN_value = rightShift(data_low, 13) and &H1
        read_LDS_SD_THR_value = rightShift(data_low, 8) and &H1f
        LDS_PEAK_THR_T125_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_PEAK_THR_T125_mask = mask then
                read_LDS_PEAK_THR_T125_value = data_low
            else
                read_LDS_PEAK_THR_T125_value = (data_low - H8000_0000) and LDS_PEAK_THR_T125_mask
            end If
        else
            read_LDS_PEAK_THR_T125_value = data_low and LDS_PEAK_THR_T125_mask
        end If

    End Sub

    Sub write
        If flag_BR_IPR_BYPASS = &H0 or flag_BR_CLOCK_ON_OV_VAL = &H0 or flag_BR_CLOCK_ON_OV_EN = &H0 or flag_LDS_SD_THR = &H0 or flag_LDS_PEAK_THR_T125 = &H0 Then read
        If flag_BR_IPR_BYPASS = &H0 Then write_BR_IPR_BYPASS_value = get_BR_IPR_BYPASS
        If flag_BR_CLOCK_ON_OV_VAL = &H0 Then write_BR_CLOCK_ON_OV_VAL_value = get_BR_CLOCK_ON_OV_VAL
        If flag_BR_CLOCK_ON_OV_EN = &H0 Then write_BR_CLOCK_ON_OV_EN_value = get_BR_CLOCK_ON_OV_EN
        If flag_LDS_SD_THR = &H0 Then write_LDS_SD_THR_value = get_LDS_SD_THR
        If flag_LDS_PEAK_THR_T125 = &H0 Then write_LDS_PEAK_THR_T125_value = get_LDS_PEAK_THR_T125

        regValue = leftShift((write_BR_IPR_BYPASS_value and &H1), 15) + leftShift((write_BR_CLOCK_ON_OV_VAL_value and &H1), 14) + leftShift((write_BR_CLOCK_ON_OV_EN_value and &H1), 13) + leftShift((write_LDS_SD_THR_value and &H1f), 8) + leftShift((write_LDS_PEAK_THR_T125_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_IPR_BYPASS_value = rightShift(data_low, 15) and &H1
        read_BR_CLOCK_ON_OV_VAL_value = rightShift(data_low, 14) and &H1
        read_BR_CLOCK_ON_OV_EN_value = rightShift(data_low, 13) and &H1
        read_LDS_SD_THR_value = rightShift(data_low, 8) and &H1f
        LDS_PEAK_THR_T125_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_PEAK_THR_T125_mask = mask then
                read_LDS_PEAK_THR_T125_value = data_low
            else
                read_LDS_PEAK_THR_T125_value = (data_low - H8000_0000) and LDS_PEAK_THR_T125_mask
            end If
        else
            read_LDS_PEAK_THR_T125_value = data_low and LDS_PEAK_THR_T125_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BR_IPR_BYPASS_value = &H0
        flag_BR_IPR_BYPASS        = &H0
        write_BR_CLOCK_ON_OV_VAL_value = &H0
        flag_BR_CLOCK_ON_OV_VAL        = &H0
        write_BR_CLOCK_ON_OV_EN_value = &H0
        flag_BR_CLOCK_ON_OV_EN        = &H0
        write_LDS_SD_THR_value = &H0
        flag_LDS_SD_THR        = &H0
        write_LDS_PEAK_THR_T125_value = &H0
        flag_LDS_PEAK_THR_T125        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp9e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_LEN_THR1_T125                          [15:8]           get_LDS_LEN_THR1_T125
''                                                             set_LDS_LEN_THR1_T125
''                                                             read_LDS_LEN_THR1_T125
''                                                             write_LDS_LEN_THR1_T125
''---------------------------------------------------------------------------------
'' LDS_LEN_THR0_T125                          [7:0]            get_LDS_LEN_THR0_T125
''                                                             set_LDS_LEN_THR0_T125
''                                                             read_LDS_LEN_THR0_T125
''                                                             write_LDS_LEN_THR0_T125
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp9e
    Private write_LDS_LEN_THR1_T125_value
    Private read_LDS_LEN_THR1_T125_value
    Private flag_LDS_LEN_THR1_T125
    Private write_LDS_LEN_THR0_T125_value
    Private read_LDS_LEN_THR0_T125_value
    Private flag_LDS_LEN_THR0_T125

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

    Property Get get_LDS_LEN_THR1_T125
        get_LDS_LEN_THR1_T125 = read_LDS_LEN_THR1_T125_value
    End Property

    Property Let set_LDS_LEN_THR1_T125(aData)
        write_LDS_LEN_THR1_T125_value = aData
        flag_LDS_LEN_THR1_T125        = &H1
    End Property

    Property Get read_LDS_LEN_THR1_T125
        read
        read_LDS_LEN_THR1_T125 = read_LDS_LEN_THR1_T125_value
    End Property

    Property Let write_LDS_LEN_THR1_T125(aData)
        set_LDS_LEN_THR1_T125 = aData
        write
    End Property

    Property Get get_LDS_LEN_THR0_T125
        get_LDS_LEN_THR0_T125 = read_LDS_LEN_THR0_T125_value
    End Property

    Property Let set_LDS_LEN_THR0_T125(aData)
        write_LDS_LEN_THR0_T125_value = aData
        flag_LDS_LEN_THR0_T125        = &H1
    End Property

    Property Get read_LDS_LEN_THR0_T125
        read
        read_LDS_LEN_THR0_T125 = read_LDS_LEN_THR0_T125_value
    End Property

    Property Let write_LDS_LEN_THR0_T125(aData)
        set_LDS_LEN_THR0_T125 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR1_T125_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR0_T125_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR0_T125_mask = mask then
                read_LDS_LEN_THR0_T125_value = data_low
            else
                read_LDS_LEN_THR0_T125_value = (data_low - H8000_0000) and LDS_LEN_THR0_T125_mask
            end If
        else
            read_LDS_LEN_THR0_T125_value = data_low and LDS_LEN_THR0_T125_mask
        end If

    End Sub

    Sub write
        If flag_LDS_LEN_THR1_T125 = &H0 or flag_LDS_LEN_THR0_T125 = &H0 Then read
        If flag_LDS_LEN_THR1_T125 = &H0 Then write_LDS_LEN_THR1_T125_value = get_LDS_LEN_THR1_T125
        If flag_LDS_LEN_THR0_T125 = &H0 Then write_LDS_LEN_THR0_T125_value = get_LDS_LEN_THR0_T125

        regValue = leftShift((write_LDS_LEN_THR1_T125_value and &Hff), 8) + leftShift((write_LDS_LEN_THR0_T125_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR1_T125_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR0_T125_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR0_T125_mask = mask then
                read_LDS_LEN_THR0_T125_value = data_low
            else
                read_LDS_LEN_THR0_T125_value = (data_low - H8000_0000) and LDS_LEN_THR0_T125_mask
            end If
        else
            read_LDS_LEN_THR0_T125_value = data_low and LDS_LEN_THR0_T125_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_LEN_THR1_T125_value = &H0
        flag_LDS_LEN_THR1_T125        = &H0
        write_LDS_LEN_THR0_T125_value = &H0
        flag_LDS_LEN_THR0_T125        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_exp9f
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LDS_LEN_THR3_T125                          [15:8]           get_LDS_LEN_THR3_T125
''                                                             set_LDS_LEN_THR3_T125
''                                                             read_LDS_LEN_THR3_T125
''                                                             write_LDS_LEN_THR3_T125
''---------------------------------------------------------------------------------
'' LDS_LEN_THR2_T125                          [7:0]            get_LDS_LEN_THR2_T125
''                                                             set_LDS_LEN_THR2_T125
''                                                             read_LDS_LEN_THR2_T125
''                                                             write_LDS_LEN_THR2_T125
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_exp9f
    Private write_LDS_LEN_THR3_T125_value
    Private read_LDS_LEN_THR3_T125_value
    Private flag_LDS_LEN_THR3_T125
    Private write_LDS_LEN_THR2_T125_value
    Private read_LDS_LEN_THR2_T125_value
    Private flag_LDS_LEN_THR2_T125

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

    Property Get get_LDS_LEN_THR3_T125
        get_LDS_LEN_THR3_T125 = read_LDS_LEN_THR3_T125_value
    End Property

    Property Let set_LDS_LEN_THR3_T125(aData)
        write_LDS_LEN_THR3_T125_value = aData
        flag_LDS_LEN_THR3_T125        = &H1
    End Property

    Property Get read_LDS_LEN_THR3_T125
        read
        read_LDS_LEN_THR3_T125 = read_LDS_LEN_THR3_T125_value
    End Property

    Property Let write_LDS_LEN_THR3_T125(aData)
        set_LDS_LEN_THR3_T125 = aData
        write
    End Property

    Property Get get_LDS_LEN_THR2_T125
        get_LDS_LEN_THR2_T125 = read_LDS_LEN_THR2_T125_value
    End Property

    Property Let set_LDS_LEN_THR2_T125(aData)
        write_LDS_LEN_THR2_T125_value = aData
        flag_LDS_LEN_THR2_T125        = &H1
    End Property

    Property Get read_LDS_LEN_THR2_T125
        read
        read_LDS_LEN_THR2_T125 = read_LDS_LEN_THR2_T125_value
    End Property

    Property Let write_LDS_LEN_THR2_T125(aData)
        set_LDS_LEN_THR2_T125 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR3_T125_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR2_T125_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR2_T125_mask = mask then
                read_LDS_LEN_THR2_T125_value = data_low
            else
                read_LDS_LEN_THR2_T125_value = (data_low - H8000_0000) and LDS_LEN_THR2_T125_mask
            end If
        else
            read_LDS_LEN_THR2_T125_value = data_low and LDS_LEN_THR2_T125_mask
        end If

    End Sub

    Sub write
        If flag_LDS_LEN_THR3_T125 = &H0 or flag_LDS_LEN_THR2_T125 = &H0 Then read
        If flag_LDS_LEN_THR3_T125 = &H0 Then write_LDS_LEN_THR3_T125_value = get_LDS_LEN_THR3_T125
        If flag_LDS_LEN_THR2_T125 = &H0 Then write_LDS_LEN_THR2_T125_value = get_LDS_LEN_THR2_T125

        regValue = leftShift((write_LDS_LEN_THR3_T125_value and &Hff), 8) + leftShift((write_LDS_LEN_THR2_T125_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LDS_LEN_THR3_T125_value = rightShift(data_low, 8) and &Hff
        LDS_LEN_THR2_T125_mask = &Hff
        if data_low > LONG_MAX then
            if LDS_LEN_THR2_T125_mask = mask then
                read_LDS_LEN_THR2_T125_value = data_low
            else
                read_LDS_LEN_THR2_T125_value = (data_low - H8000_0000) and LDS_LEN_THR2_T125_mask
            end If
        else
            read_LDS_LEN_THR2_T125_value = data_low and LDS_LEN_THR2_T125_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LDS_LEN_THR3_T125_value = &H0
        flag_LDS_LEN_THR3_T125        = &H0
        write_LDS_LEN_THR2_T125_value = &H0
        flag_LDS_LEN_THR2_T125        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_expa0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EPAGE_SPARE                                [15:2]           get_EPAGE_SPARE
''                                                             set_EPAGE_SPARE
''                                                             read_EPAGE_SPARE
''                                                             write_EPAGE_SPARE
''---------------------------------------------------------------------------------
'' PAIR_1_250MBPS                             [1:1]            get_PAIR_1_250MBPS
''                                                             set_PAIR_1_250MBPS
''                                                             read_PAIR_1_250MBPS
''                                                             write_PAIR_1_250MBPS
''---------------------------------------------------------------------------------
'' PAIR_1_200MBPS                             [0:0]            get_PAIR_1_200MBPS
''                                                             set_PAIR_1_200MBPS
''                                                             read_PAIR_1_200MBPS
''                                                             write_PAIR_1_200MBPS
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_expa0
    Private write_EPAGE_SPARE_value
    Private read_EPAGE_SPARE_value
    Private flag_EPAGE_SPARE
    Private write_PAIR_1_250MBPS_value
    Private read_PAIR_1_250MBPS_value
    Private flag_PAIR_1_250MBPS
    Private write_PAIR_1_200MBPS_value
    Private read_PAIR_1_200MBPS_value
    Private flag_PAIR_1_200MBPS

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

    Property Get get_EPAGE_SPARE
        get_EPAGE_SPARE = read_EPAGE_SPARE_value
    End Property

    Property Let set_EPAGE_SPARE(aData)
        write_EPAGE_SPARE_value = aData
        flag_EPAGE_SPARE        = &H1
    End Property

    Property Get read_EPAGE_SPARE
        read
        read_EPAGE_SPARE = read_EPAGE_SPARE_value
    End Property

    Property Let write_EPAGE_SPARE(aData)
        set_EPAGE_SPARE = aData
        write
    End Property

    Property Get get_PAIR_1_250MBPS
        get_PAIR_1_250MBPS = read_PAIR_1_250MBPS_value
    End Property

    Property Let set_PAIR_1_250MBPS(aData)
        write_PAIR_1_250MBPS_value = aData
        flag_PAIR_1_250MBPS        = &H1
    End Property

    Property Get read_PAIR_1_250MBPS
        read
        read_PAIR_1_250MBPS = read_PAIR_1_250MBPS_value
    End Property

    Property Let write_PAIR_1_250MBPS(aData)
        set_PAIR_1_250MBPS = aData
        write
    End Property

    Property Get get_PAIR_1_200MBPS
        get_PAIR_1_200MBPS = read_PAIR_1_200MBPS_value
    End Property

    Property Let set_PAIR_1_200MBPS(aData)
        write_PAIR_1_200MBPS_value = aData
        flag_PAIR_1_200MBPS        = &H1
    End Property

    Property Get read_PAIR_1_200MBPS
        read
        read_PAIR_1_200MBPS = read_PAIR_1_200MBPS_value
    End Property

    Property Let write_PAIR_1_200MBPS(aData)
        set_PAIR_1_200MBPS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EPAGE_SPARE_value = rightShift(data_low, 2) and &H3fff
        read_PAIR_1_250MBPS_value = rightShift(data_low, 1) and &H1
        PAIR_1_200MBPS_mask = &H1
        if data_low > LONG_MAX then
            if PAIR_1_200MBPS_mask = mask then
                read_PAIR_1_200MBPS_value = data_low
            else
                read_PAIR_1_200MBPS_value = (data_low - H8000_0000) and PAIR_1_200MBPS_mask
            end If
        else
            read_PAIR_1_200MBPS_value = data_low and PAIR_1_200MBPS_mask
        end If

    End Sub

    Sub write
        If flag_EPAGE_SPARE = &H0 or flag_PAIR_1_250MBPS = &H0 or flag_PAIR_1_200MBPS = &H0 Then read
        If flag_EPAGE_SPARE = &H0 Then write_EPAGE_SPARE_value = get_EPAGE_SPARE
        If flag_PAIR_1_250MBPS = &H0 Then write_PAIR_1_250MBPS_value = get_PAIR_1_250MBPS
        If flag_PAIR_1_200MBPS = &H0 Then write_PAIR_1_200MBPS_value = get_PAIR_1_200MBPS

        regValue = leftShift((write_EPAGE_SPARE_value and &H3fff), 2) + leftShift((write_PAIR_1_250MBPS_value and &H1), 1) + leftShift((write_PAIR_1_200MBPS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EPAGE_SPARE_value = rightShift(data_low, 2) and &H3fff
        read_PAIR_1_250MBPS_value = rightShift(data_low, 1) and &H1
        PAIR_1_200MBPS_mask = &H1
        if data_low > LONG_MAX then
            if PAIR_1_200MBPS_mask = mask then
                read_PAIR_1_200MBPS_value = data_low
            else
                read_PAIR_1_200MBPS_value = (data_low - H8000_0000) and PAIR_1_200MBPS_mask
            end If
        else
            read_PAIR_1_200MBPS_value = data_low and PAIR_1_200MBPS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EPAGE_SPARE_value = &H0
        flag_EPAGE_SPARE        = &H0
        write_PAIR_1_250MBPS_value = &H0
        flag_PAIR_1_250MBPS        = &H0
        write_PAIR_1_200MBPS_value = &H0
        flag_PAIR_1_200MBPS        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_expa1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_EPAGE_SPARE                             [15:2]           get_LP_EPAGE_SPARE
''                                                             set_LP_EPAGE_SPARE
''                                                             read_LP_EPAGE_SPARE
''                                                             write_LP_EPAGE_SPARE
''---------------------------------------------------------------------------------
'' LP_PAIR_1_250MBPS                          [1:1]            get_LP_PAIR_1_250MBPS
''                                                             set_LP_PAIR_1_250MBPS
''                                                             read_LP_PAIR_1_250MBPS
''                                                             write_LP_PAIR_1_250MBPS
''---------------------------------------------------------------------------------
'' LP_PAIR_1_200MBPS                          [0:0]            get_LP_PAIR_1_200MBPS
''                                                             set_LP_PAIR_1_200MBPS
''                                                             read_LP_PAIR_1_200MBPS
''                                                             write_LP_PAIR_1_200MBPS
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_expa1
    Private write_LP_EPAGE_SPARE_value
    Private read_LP_EPAGE_SPARE_value
    Private flag_LP_EPAGE_SPARE
    Private write_LP_PAIR_1_250MBPS_value
    Private read_LP_PAIR_1_250MBPS_value
    Private flag_LP_PAIR_1_250MBPS
    Private write_LP_PAIR_1_200MBPS_value
    Private read_LP_PAIR_1_200MBPS_value
    Private flag_LP_PAIR_1_200MBPS

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

    Property Get get_LP_EPAGE_SPARE
        get_LP_EPAGE_SPARE = read_LP_EPAGE_SPARE_value
    End Property

    Property Let set_LP_EPAGE_SPARE(aData)
        write_LP_EPAGE_SPARE_value = aData
        flag_LP_EPAGE_SPARE        = &H1
    End Property

    Property Get read_LP_EPAGE_SPARE
        read
        read_LP_EPAGE_SPARE = read_LP_EPAGE_SPARE_value
    End Property

    Property Let write_LP_EPAGE_SPARE(aData)
        set_LP_EPAGE_SPARE = aData
        write
    End Property

    Property Get get_LP_PAIR_1_250MBPS
        get_LP_PAIR_1_250MBPS = read_LP_PAIR_1_250MBPS_value
    End Property

    Property Let set_LP_PAIR_1_250MBPS(aData)
        write_LP_PAIR_1_250MBPS_value = aData
        flag_LP_PAIR_1_250MBPS        = &H1
    End Property

    Property Get read_LP_PAIR_1_250MBPS
        read
        read_LP_PAIR_1_250MBPS = read_LP_PAIR_1_250MBPS_value
    End Property

    Property Let write_LP_PAIR_1_250MBPS(aData)
        set_LP_PAIR_1_250MBPS = aData
        write
    End Property

    Property Get get_LP_PAIR_1_200MBPS
        get_LP_PAIR_1_200MBPS = read_LP_PAIR_1_200MBPS_value
    End Property

    Property Let set_LP_PAIR_1_200MBPS(aData)
        write_LP_PAIR_1_200MBPS_value = aData
        flag_LP_PAIR_1_200MBPS        = &H1
    End Property

    Property Get read_LP_PAIR_1_200MBPS
        read
        read_LP_PAIR_1_200MBPS = read_LP_PAIR_1_200MBPS_value
    End Property

    Property Let write_LP_PAIR_1_200MBPS(aData)
        set_LP_PAIR_1_200MBPS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_EPAGE_SPARE_value = rightShift(data_low, 2) and &H3fff
        read_LP_PAIR_1_250MBPS_value = rightShift(data_low, 1) and &H1
        LP_PAIR_1_200MBPS_mask = &H1
        if data_low > LONG_MAX then
            if LP_PAIR_1_200MBPS_mask = mask then
                read_LP_PAIR_1_200MBPS_value = data_low
            else
                read_LP_PAIR_1_200MBPS_value = (data_low - H8000_0000) and LP_PAIR_1_200MBPS_mask
            end If
        else
            read_LP_PAIR_1_200MBPS_value = data_low and LP_PAIR_1_200MBPS_mask
        end If

    End Sub

    Sub write
        If flag_LP_EPAGE_SPARE = &H0 or flag_LP_PAIR_1_250MBPS = &H0 or flag_LP_PAIR_1_200MBPS = &H0 Then read
        If flag_LP_EPAGE_SPARE = &H0 Then write_LP_EPAGE_SPARE_value = get_LP_EPAGE_SPARE
        If flag_LP_PAIR_1_250MBPS = &H0 Then write_LP_PAIR_1_250MBPS_value = get_LP_PAIR_1_250MBPS
        If flag_LP_PAIR_1_200MBPS = &H0 Then write_LP_PAIR_1_200MBPS_value = get_LP_PAIR_1_200MBPS

        regValue = leftShift((write_LP_EPAGE_SPARE_value and &H3fff), 2) + leftShift((write_LP_PAIR_1_250MBPS_value and &H1), 1) + leftShift((write_LP_PAIR_1_200MBPS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_EPAGE_SPARE_value = rightShift(data_low, 2) and &H3fff
        read_LP_PAIR_1_250MBPS_value = rightShift(data_low, 1) and &H1
        LP_PAIR_1_200MBPS_mask = &H1
        if data_low > LONG_MAX then
            if LP_PAIR_1_200MBPS_mask = mask then
                read_LP_PAIR_1_200MBPS_value = data_low
            else
                read_LP_PAIR_1_200MBPS_value = (data_low - H8000_0000) and LP_PAIR_1_200MBPS_mask
            end If
        else
            read_LP_PAIR_1_200MBPS_value = data_low and LP_PAIR_1_200MBPS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_EPAGE_SPARE_value = &H0
        flag_LP_EPAGE_SPARE        = &H0
        write_LP_PAIR_1_250MBPS_value = &H0
        flag_LP_PAIR_1_250MBPS        = &H0
        write_LP_PAIR_1_200MBPS_value = &H0
        flag_LP_PAIR_1_200MBPS        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_expa2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TFREQ_SEL_OV_EN                            [15:15]          get_TFREQ_SEL_OV_EN
''                                                             set_TFREQ_SEL_OV_EN
''                                                             read_TFREQ_SEL_OV_EN
''                                                             write_TFREQ_SEL_OV_EN
''---------------------------------------------------------------------------------
'' TFREQ_SEL_OV                               [14:14]          get_TFREQ_SEL_OV
''                                                             set_TFREQ_SEL_OV
''                                                             read_TFREQ_SEL_OV
''                                                             write_TFREQ_SEL_OV
''---------------------------------------------------------------------------------
'' LOW_FREQ_TONE                              [13:13]          get_LOW_FREQ_TONE
''                                                             set_LOW_FREQ_TONE
''                                                             read_LOW_FREQ_TONE
''                                                             write_LOW_FREQ_TONE
''---------------------------------------------------------------------------------
'' BR_MAXWAIT_CTL                             [12:11]          get_BR_MAXWAIT_CTL
''                                                             set_BR_MAXWAIT_CTL
''                                                             read_BR_MAXWAIT_CTL
''                                                             write_BR_MAXWAIT_CTL
''---------------------------------------------------------------------------------
'' BR_M2S2_TMR_CTL                            [10:10]          get_BR_M2S2_TMR_CTL
''                                                             set_BR_M2S2_TMR_CTL
''                                                             read_BR_M2S2_TMR_CTL
''                                                             write_BR_M2S2_TMR_CTL
''---------------------------------------------------------------------------------
'' BR_SKIP_FIFO_FDX_S                         [9:9]            get_BR_SKIP_FIFO_FDX_S
''                                                             set_BR_SKIP_FIFO_FDX_S
''                                                             read_BR_SKIP_FIFO_FDX_S
''                                                             write_BR_SKIP_FIFO_FDX_S
''---------------------------------------------------------------------------------
'' BR_SKIP_FIFO_HDX                           [8:8]            get_BR_SKIP_FIFO_HDX
''                                                             set_BR_SKIP_FIFO_HDX
''                                                             read_BR_SKIP_FIFO_HDX
''                                                             write_BR_SKIP_FIFO_HDX
''---------------------------------------------------------------------------------
'' BR_PSD_TIMER_CTL                           [7:6]            get_BR_PSD_TIMER_CTL
''                                                             set_BR_PSD_TIMER_CTL
''                                                             read_BR_PSD_TIMER_CTL
''                                                             write_BR_PSD_TIMER_CTL
''---------------------------------------------------------------------------------
'' MAN_PHASE_CK1X                             [5:3]            get_MAN_PHASE_CK1X
''                                                             set_MAN_PHASE_CK1X
''                                                             read_MAN_PHASE_CK1X
''                                                             write_MAN_PHASE_CK1X
''---------------------------------------------------------------------------------
'' LDS_PHASE_CK1X                             [2:0]            get_LDS_PHASE_CK1X
''                                                             set_LDS_PHASE_CK1X
''                                                             read_LDS_PHASE_CK1X
''                                                             write_LDS_PHASE_CK1X
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_expa2
    Private write_TFREQ_SEL_OV_EN_value
    Private read_TFREQ_SEL_OV_EN_value
    Private flag_TFREQ_SEL_OV_EN
    Private write_TFREQ_SEL_OV_value
    Private read_TFREQ_SEL_OV_value
    Private flag_TFREQ_SEL_OV
    Private write_LOW_FREQ_TONE_value
    Private read_LOW_FREQ_TONE_value
    Private flag_LOW_FREQ_TONE
    Private write_BR_MAXWAIT_CTL_value
    Private read_BR_MAXWAIT_CTL_value
    Private flag_BR_MAXWAIT_CTL
    Private write_BR_M2S2_TMR_CTL_value
    Private read_BR_M2S2_TMR_CTL_value
    Private flag_BR_M2S2_TMR_CTL
    Private write_BR_SKIP_FIFO_FDX_S_value
    Private read_BR_SKIP_FIFO_FDX_S_value
    Private flag_BR_SKIP_FIFO_FDX_S
    Private write_BR_SKIP_FIFO_HDX_value
    Private read_BR_SKIP_FIFO_HDX_value
    Private flag_BR_SKIP_FIFO_HDX
    Private write_BR_PSD_TIMER_CTL_value
    Private read_BR_PSD_TIMER_CTL_value
    Private flag_BR_PSD_TIMER_CTL
    Private write_MAN_PHASE_CK1X_value
    Private read_MAN_PHASE_CK1X_value
    Private flag_MAN_PHASE_CK1X
    Private write_LDS_PHASE_CK1X_value
    Private read_LDS_PHASE_CK1X_value
    Private flag_LDS_PHASE_CK1X

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

    Property Get get_TFREQ_SEL_OV_EN
        get_TFREQ_SEL_OV_EN = read_TFREQ_SEL_OV_EN_value
    End Property

    Property Let set_TFREQ_SEL_OV_EN(aData)
        write_TFREQ_SEL_OV_EN_value = aData
        flag_TFREQ_SEL_OV_EN        = &H1
    End Property

    Property Get read_TFREQ_SEL_OV_EN
        read
        read_TFREQ_SEL_OV_EN = read_TFREQ_SEL_OV_EN_value
    End Property

    Property Let write_TFREQ_SEL_OV_EN(aData)
        set_TFREQ_SEL_OV_EN = aData
        write
    End Property

    Property Get get_TFREQ_SEL_OV
        get_TFREQ_SEL_OV = read_TFREQ_SEL_OV_value
    End Property

    Property Let set_TFREQ_SEL_OV(aData)
        write_TFREQ_SEL_OV_value = aData
        flag_TFREQ_SEL_OV        = &H1
    End Property

    Property Get read_TFREQ_SEL_OV
        read
        read_TFREQ_SEL_OV = read_TFREQ_SEL_OV_value
    End Property

    Property Let write_TFREQ_SEL_OV(aData)
        set_TFREQ_SEL_OV = aData
        write
    End Property

    Property Get get_LOW_FREQ_TONE
        get_LOW_FREQ_TONE = read_LOW_FREQ_TONE_value
    End Property

    Property Let set_LOW_FREQ_TONE(aData)
        write_LOW_FREQ_TONE_value = aData
        flag_LOW_FREQ_TONE        = &H1
    End Property

    Property Get read_LOW_FREQ_TONE
        read
        read_LOW_FREQ_TONE = read_LOW_FREQ_TONE_value
    End Property

    Property Let write_LOW_FREQ_TONE(aData)
        set_LOW_FREQ_TONE = aData
        write
    End Property

    Property Get get_BR_MAXWAIT_CTL
        get_BR_MAXWAIT_CTL = read_BR_MAXWAIT_CTL_value
    End Property

    Property Let set_BR_MAXWAIT_CTL(aData)
        write_BR_MAXWAIT_CTL_value = aData
        flag_BR_MAXWAIT_CTL        = &H1
    End Property

    Property Get read_BR_MAXWAIT_CTL
        read
        read_BR_MAXWAIT_CTL = read_BR_MAXWAIT_CTL_value
    End Property

    Property Let write_BR_MAXWAIT_CTL(aData)
        set_BR_MAXWAIT_CTL = aData
        write
    End Property

    Property Get get_BR_M2S2_TMR_CTL
        get_BR_M2S2_TMR_CTL = read_BR_M2S2_TMR_CTL_value
    End Property

    Property Let set_BR_M2S2_TMR_CTL(aData)
        write_BR_M2S2_TMR_CTL_value = aData
        flag_BR_M2S2_TMR_CTL        = &H1
    End Property

    Property Get read_BR_M2S2_TMR_CTL
        read
        read_BR_M2S2_TMR_CTL = read_BR_M2S2_TMR_CTL_value
    End Property

    Property Let write_BR_M2S2_TMR_CTL(aData)
        set_BR_M2S2_TMR_CTL = aData
        write
    End Property

    Property Get get_BR_SKIP_FIFO_FDX_S
        get_BR_SKIP_FIFO_FDX_S = read_BR_SKIP_FIFO_FDX_S_value
    End Property

    Property Let set_BR_SKIP_FIFO_FDX_S(aData)
        write_BR_SKIP_FIFO_FDX_S_value = aData
        flag_BR_SKIP_FIFO_FDX_S        = &H1
    End Property

    Property Get read_BR_SKIP_FIFO_FDX_S
        read
        read_BR_SKIP_FIFO_FDX_S = read_BR_SKIP_FIFO_FDX_S_value
    End Property

    Property Let write_BR_SKIP_FIFO_FDX_S(aData)
        set_BR_SKIP_FIFO_FDX_S = aData
        write
    End Property

    Property Get get_BR_SKIP_FIFO_HDX
        get_BR_SKIP_FIFO_HDX = read_BR_SKIP_FIFO_HDX_value
    End Property

    Property Let set_BR_SKIP_FIFO_HDX(aData)
        write_BR_SKIP_FIFO_HDX_value = aData
        flag_BR_SKIP_FIFO_HDX        = &H1
    End Property

    Property Get read_BR_SKIP_FIFO_HDX
        read
        read_BR_SKIP_FIFO_HDX = read_BR_SKIP_FIFO_HDX_value
    End Property

    Property Let write_BR_SKIP_FIFO_HDX(aData)
        set_BR_SKIP_FIFO_HDX = aData
        write
    End Property

    Property Get get_BR_PSD_TIMER_CTL
        get_BR_PSD_TIMER_CTL = read_BR_PSD_TIMER_CTL_value
    End Property

    Property Let set_BR_PSD_TIMER_CTL(aData)
        write_BR_PSD_TIMER_CTL_value = aData
        flag_BR_PSD_TIMER_CTL        = &H1
    End Property

    Property Get read_BR_PSD_TIMER_CTL
        read
        read_BR_PSD_TIMER_CTL = read_BR_PSD_TIMER_CTL_value
    End Property

    Property Let write_BR_PSD_TIMER_CTL(aData)
        set_BR_PSD_TIMER_CTL = aData
        write
    End Property

    Property Get get_MAN_PHASE_CK1X
        get_MAN_PHASE_CK1X = read_MAN_PHASE_CK1X_value
    End Property

    Property Let set_MAN_PHASE_CK1X(aData)
        write_MAN_PHASE_CK1X_value = aData
        flag_MAN_PHASE_CK1X        = &H1
    End Property

    Property Get read_MAN_PHASE_CK1X
        read
        read_MAN_PHASE_CK1X = read_MAN_PHASE_CK1X_value
    End Property

    Property Let write_MAN_PHASE_CK1X(aData)
        set_MAN_PHASE_CK1X = aData
        write
    End Property

    Property Get get_LDS_PHASE_CK1X
        get_LDS_PHASE_CK1X = read_LDS_PHASE_CK1X_value
    End Property

    Property Let set_LDS_PHASE_CK1X(aData)
        write_LDS_PHASE_CK1X_value = aData
        flag_LDS_PHASE_CK1X        = &H1
    End Property

    Property Get read_LDS_PHASE_CK1X
        read
        read_LDS_PHASE_CK1X = read_LDS_PHASE_CK1X_value
    End Property

    Property Let write_LDS_PHASE_CK1X(aData)
        set_LDS_PHASE_CK1X = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TFREQ_SEL_OV_EN_value = rightShift(data_low, 15) and &H1
        read_TFREQ_SEL_OV_value = rightShift(data_low, 14) and &H1
        read_LOW_FREQ_TONE_value = rightShift(data_low, 13) and &H1
        read_BR_MAXWAIT_CTL_value = rightShift(data_low, 11) and &H3
        read_BR_M2S2_TMR_CTL_value = rightShift(data_low, 10) and &H1
        read_BR_SKIP_FIFO_FDX_S_value = rightShift(data_low, 9) and &H1
        read_BR_SKIP_FIFO_HDX_value = rightShift(data_low, 8) and &H1
        read_BR_PSD_TIMER_CTL_value = rightShift(data_low, 6) and &H3
        read_MAN_PHASE_CK1X_value = rightShift(data_low, 3) and &H7
        LDS_PHASE_CK1X_mask = &H7
        if data_low > LONG_MAX then
            if LDS_PHASE_CK1X_mask = mask then
                read_LDS_PHASE_CK1X_value = data_low
            else
                read_LDS_PHASE_CK1X_value = (data_low - H8000_0000) and LDS_PHASE_CK1X_mask
            end If
        else
            read_LDS_PHASE_CK1X_value = data_low and LDS_PHASE_CK1X_mask
        end If

    End Sub

    Sub write
        If flag_TFREQ_SEL_OV_EN = &H0 or flag_TFREQ_SEL_OV = &H0 or flag_LOW_FREQ_TONE = &H0 or flag_BR_MAXWAIT_CTL = &H0 or flag_BR_M2S2_TMR_CTL = &H0 or flag_BR_SKIP_FIFO_FDX_S = &H0 or flag_BR_SKIP_FIFO_HDX = &H0 or flag_BR_PSD_TIMER_CTL = &H0 or flag_MAN_PHASE_CK1X = &H0 or flag_LDS_PHASE_CK1X = &H0 Then read
        If flag_TFREQ_SEL_OV_EN = &H0 Then write_TFREQ_SEL_OV_EN_value = get_TFREQ_SEL_OV_EN
        If flag_TFREQ_SEL_OV = &H0 Then write_TFREQ_SEL_OV_value = get_TFREQ_SEL_OV
        If flag_LOW_FREQ_TONE = &H0 Then write_LOW_FREQ_TONE_value = get_LOW_FREQ_TONE
        If flag_BR_MAXWAIT_CTL = &H0 Then write_BR_MAXWAIT_CTL_value = get_BR_MAXWAIT_CTL
        If flag_BR_M2S2_TMR_CTL = &H0 Then write_BR_M2S2_TMR_CTL_value = get_BR_M2S2_TMR_CTL
        If flag_BR_SKIP_FIFO_FDX_S = &H0 Then write_BR_SKIP_FIFO_FDX_S_value = get_BR_SKIP_FIFO_FDX_S
        If flag_BR_SKIP_FIFO_HDX = &H0 Then write_BR_SKIP_FIFO_HDX_value = get_BR_SKIP_FIFO_HDX
        If flag_BR_PSD_TIMER_CTL = &H0 Then write_BR_PSD_TIMER_CTL_value = get_BR_PSD_TIMER_CTL
        If flag_MAN_PHASE_CK1X = &H0 Then write_MAN_PHASE_CK1X_value = get_MAN_PHASE_CK1X
        If flag_LDS_PHASE_CK1X = &H0 Then write_LDS_PHASE_CK1X_value = get_LDS_PHASE_CK1X

        regValue = leftShift((write_TFREQ_SEL_OV_EN_value and &H1), 15) + leftShift((write_TFREQ_SEL_OV_value and &H1), 14) + leftShift((write_LOW_FREQ_TONE_value and &H1), 13) + leftShift((write_BR_MAXWAIT_CTL_value and &H3), 11) + leftShift((write_BR_M2S2_TMR_CTL_value and &H1), 10) + leftShift((write_BR_SKIP_FIFO_FDX_S_value and &H1), 9) + leftShift((write_BR_SKIP_FIFO_HDX_value and &H1), 8) + leftShift((write_BR_PSD_TIMER_CTL_value and &H3), 6) + leftShift((write_MAN_PHASE_CK1X_value and &H7), 3) + leftShift((write_LDS_PHASE_CK1X_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TFREQ_SEL_OV_EN_value = rightShift(data_low, 15) and &H1
        read_TFREQ_SEL_OV_value = rightShift(data_low, 14) and &H1
        read_LOW_FREQ_TONE_value = rightShift(data_low, 13) and &H1
        read_BR_MAXWAIT_CTL_value = rightShift(data_low, 11) and &H3
        read_BR_M2S2_TMR_CTL_value = rightShift(data_low, 10) and &H1
        read_BR_SKIP_FIFO_FDX_S_value = rightShift(data_low, 9) and &H1
        read_BR_SKIP_FIFO_HDX_value = rightShift(data_low, 8) and &H1
        read_BR_PSD_TIMER_CTL_value = rightShift(data_low, 6) and &H3
        read_MAN_PHASE_CK1X_value = rightShift(data_low, 3) and &H7
        LDS_PHASE_CK1X_mask = &H7
        if data_low > LONG_MAX then
            if LDS_PHASE_CK1X_mask = mask then
                read_LDS_PHASE_CK1X_value = data_low
            else
                read_LDS_PHASE_CK1X_value = (data_low - H8000_0000) and LDS_PHASE_CK1X_mask
            end If
        else
            read_LDS_PHASE_CK1X_value = data_low and LDS_PHASE_CK1X_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TFREQ_SEL_OV_EN_value = &H0
        flag_TFREQ_SEL_OV_EN        = &H0
        write_TFREQ_SEL_OV_value = &H0
        flag_TFREQ_SEL_OV        = &H0
        write_LOW_FREQ_TONE_value = &H0
        flag_LOW_FREQ_TONE        = &H0
        write_BR_MAXWAIT_CTL_value = &H0
        flag_BR_MAXWAIT_CTL        = &H0
        write_BR_M2S2_TMR_CTL_value = &H0
        flag_BR_M2S2_TMR_CTL        = &H0
        write_BR_SKIP_FIFO_FDX_S_value = &H0
        flag_BR_SKIP_FIFO_FDX_S        = &H0
        write_BR_SKIP_FIFO_HDX_value = &H0
        flag_BR_SKIP_FIFO_HDX        = &H0
        write_BR_PSD_TIMER_CTL_value = &H0
        flag_BR_PSD_TIMER_CTL        = &H0
        write_MAN_PHASE_CK1X_value = &H0
        flag_MAN_PHASE_CK1X        = &H0
        write_LDS_PHASE_CK1X_value = &H0
        flag_LDS_PHASE_CK1X        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_br_misc_control_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENABLE_2ND_FILTER                          [15:15]          get_ENABLE_2ND_FILTER
''                                                             set_ENABLE_2ND_FILTER
''                                                             read_ENABLE_2ND_FILTER
''                                                             write_ENABLE_2ND_FILTER
''---------------------------------------------------------------------------------
'' ENABLE_PR_DATAPATH                         [14:14]          get_ENABLE_PR_DATAPATH
''                                                             set_ENABLE_PR_DATAPATH
''                                                             read_ENABLE_PR_DATAPATH
''                                                             write_ENABLE_PR_DATAPATH
''---------------------------------------------------------------------------------
'' BR_1P_PCS_SOL                              [2:0]            get_BR_1P_PCS_SOL
''                                                             set_BR_1P_PCS_SOL
''                                                             read_BR_1P_PCS_SOL
''                                                             write_BR_1P_PCS_SOL
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_br_misc_control_status
    Private write_ENABLE_2ND_FILTER_value
    Private read_ENABLE_2ND_FILTER_value
    Private flag_ENABLE_2ND_FILTER
    Private write_ENABLE_PR_DATAPATH_value
    Private read_ENABLE_PR_DATAPATH_value
    Private flag_ENABLE_PR_DATAPATH
    Private write_BR_1P_PCS_SOL_value
    Private read_BR_1P_PCS_SOL_value
    Private flag_BR_1P_PCS_SOL

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

    Property Get get_ENABLE_2ND_FILTER
        get_ENABLE_2ND_FILTER = read_ENABLE_2ND_FILTER_value
    End Property

    Property Let set_ENABLE_2ND_FILTER(aData)
        write_ENABLE_2ND_FILTER_value = aData
        flag_ENABLE_2ND_FILTER        = &H1
    End Property

    Property Get read_ENABLE_2ND_FILTER
        read
        read_ENABLE_2ND_FILTER = read_ENABLE_2ND_FILTER_value
    End Property

    Property Let write_ENABLE_2ND_FILTER(aData)
        set_ENABLE_2ND_FILTER = aData
        write
    End Property

    Property Get get_ENABLE_PR_DATAPATH
        get_ENABLE_PR_DATAPATH = read_ENABLE_PR_DATAPATH_value
    End Property

    Property Let set_ENABLE_PR_DATAPATH(aData)
        write_ENABLE_PR_DATAPATH_value = aData
        flag_ENABLE_PR_DATAPATH        = &H1
    End Property

    Property Get read_ENABLE_PR_DATAPATH
        read
        read_ENABLE_PR_DATAPATH = read_ENABLE_PR_DATAPATH_value
    End Property

    Property Let write_ENABLE_PR_DATAPATH(aData)
        set_ENABLE_PR_DATAPATH = aData
        write
    End Property

    Property Get get_BR_1P_PCS_SOL
        get_BR_1P_PCS_SOL = read_BR_1P_PCS_SOL_value
    End Property

    Property Let set_BR_1P_PCS_SOL(aData)
        write_BR_1P_PCS_SOL_value = aData
        flag_BR_1P_PCS_SOL        = &H1
    End Property

    Property Get read_BR_1P_PCS_SOL
        read
        read_BR_1P_PCS_SOL = read_BR_1P_PCS_SOL_value
    End Property

    Property Let write_BR_1P_PCS_SOL(aData)
        set_BR_1P_PCS_SOL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENABLE_2ND_FILTER_value = rightShift(data_low, 15) and &H1
        read_ENABLE_PR_DATAPATH_value = rightShift(data_low, 14) and &H1
        BR_1P_PCS_SOL_mask = &H7
        if data_low > LONG_MAX then
            if BR_1P_PCS_SOL_mask = mask then
                read_BR_1P_PCS_SOL_value = data_low
            else
                read_BR_1P_PCS_SOL_value = (data_low - H8000_0000) and BR_1P_PCS_SOL_mask
            end If
        else
            read_BR_1P_PCS_SOL_value = data_low and BR_1P_PCS_SOL_mask
        end If

    End Sub

    Sub write
        If flag_ENABLE_2ND_FILTER = &H0 or flag_ENABLE_PR_DATAPATH = &H0 or flag_BR_1P_PCS_SOL = &H0 Then read
        If flag_ENABLE_2ND_FILTER = &H0 Then write_ENABLE_2ND_FILTER_value = get_ENABLE_2ND_FILTER
        If flag_ENABLE_PR_DATAPATH = &H0 Then write_ENABLE_PR_DATAPATH_value = get_ENABLE_PR_DATAPATH
        If flag_BR_1P_PCS_SOL = &H0 Then write_BR_1P_PCS_SOL_value = get_BR_1P_PCS_SOL

        regValue = leftShift((write_ENABLE_2ND_FILTER_value and &H1), 15) + leftShift((write_ENABLE_PR_DATAPATH_value and &H1), 14) + leftShift((write_BR_1P_PCS_SOL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENABLE_2ND_FILTER_value = rightShift(data_low, 15) and &H1
        read_ENABLE_PR_DATAPATH_value = rightShift(data_low, 14) and &H1
        BR_1P_PCS_SOL_mask = &H7
        if data_low > LONG_MAX then
            if BR_1P_PCS_SOL_mask = mask then
                read_BR_1P_PCS_SOL_value = data_low
            else
                read_BR_1P_PCS_SOL_value = (data_low - H8000_0000) and BR_1P_PCS_SOL_mask
            end If
        else
            read_BR_1P_PCS_SOL_value = data_low and BR_1P_PCS_SOL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENABLE_2ND_FILTER_value = &H0
        flag_ENABLE_2ND_FILTER        = &H0
        write_ENABLE_PR_DATAPATH_value = &H0
        flag_ENABLE_PR_DATAPATH        = &H0
        write_BR_1P_PCS_SOL_value = &H0
        flag_BR_1P_PCS_SOL        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_tc10_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pms_fastsim_mode                           [6:6]            get_pms_fastsim_mode
''                                                             set_pms_fastsim_mode
''                                                             read_pms_fastsim_mode
''                                                             write_pms_fastsim_mode
''---------------------------------------------------------------------------------
'' pms_rx_block_dis                           [5:5]            get_pms_rx_block_dis
''                                                             set_pms_rx_block_dis
''                                                             read_pms_rx_block_dis
''                                                             write_pms_rx_block_dis
''---------------------------------------------------------------------------------
'' conti_lp_dis                               [4:4]            get_conti_lp_dis
''                                                             set_conti_lp_dis
''                                                             read_conti_lp_dis
''                                                             write_conti_lp_dis
''---------------------------------------------------------------------------------
'' tx_lps_opt                                 [3:2]            get_tx_lps_opt
''                                                             set_tx_lps_opt
''                                                             read_tx_lps_opt
''                                                             write_tx_lps_opt
''---------------------------------------------------------------------------------
'' send_z_det_opt                             [1:0]            get_send_z_det_opt
''                                                             set_send_z_det_opt
''                                                             read_send_z_det_opt
''                                                             write_send_z_det_opt
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_tc10_ctrl
    Private write_pms_fastsim_mode_value
    Private read_pms_fastsim_mode_value
    Private flag_pms_fastsim_mode
    Private write_pms_rx_block_dis_value
    Private read_pms_rx_block_dis_value
    Private flag_pms_rx_block_dis
    Private write_conti_lp_dis_value
    Private read_conti_lp_dis_value
    Private flag_conti_lp_dis
    Private write_tx_lps_opt_value
    Private read_tx_lps_opt_value
    Private flag_tx_lps_opt
    Private write_send_z_det_opt_value
    Private read_send_z_det_opt_value
    Private flag_send_z_det_opt

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

    Property Get get_pms_fastsim_mode
        get_pms_fastsim_mode = read_pms_fastsim_mode_value
    End Property

    Property Let set_pms_fastsim_mode(aData)
        write_pms_fastsim_mode_value = aData
        flag_pms_fastsim_mode        = &H1
    End Property

    Property Get read_pms_fastsim_mode
        read
        read_pms_fastsim_mode = read_pms_fastsim_mode_value
    End Property

    Property Let write_pms_fastsim_mode(aData)
        set_pms_fastsim_mode = aData
        write
    End Property

    Property Get get_pms_rx_block_dis
        get_pms_rx_block_dis = read_pms_rx_block_dis_value
    End Property

    Property Let set_pms_rx_block_dis(aData)
        write_pms_rx_block_dis_value = aData
        flag_pms_rx_block_dis        = &H1
    End Property

    Property Get read_pms_rx_block_dis
        read
        read_pms_rx_block_dis = read_pms_rx_block_dis_value
    End Property

    Property Let write_pms_rx_block_dis(aData)
        set_pms_rx_block_dis = aData
        write
    End Property

    Property Get get_conti_lp_dis
        get_conti_lp_dis = read_conti_lp_dis_value
    End Property

    Property Let set_conti_lp_dis(aData)
        write_conti_lp_dis_value = aData
        flag_conti_lp_dis        = &H1
    End Property

    Property Get read_conti_lp_dis
        read
        read_conti_lp_dis = read_conti_lp_dis_value
    End Property

    Property Let write_conti_lp_dis(aData)
        set_conti_lp_dis = aData
        write
    End Property

    Property Get get_tx_lps_opt
        get_tx_lps_opt = read_tx_lps_opt_value
    End Property

    Property Let set_tx_lps_opt(aData)
        write_tx_lps_opt_value = aData
        flag_tx_lps_opt        = &H1
    End Property

    Property Get read_tx_lps_opt
        read
        read_tx_lps_opt = read_tx_lps_opt_value
    End Property

    Property Let write_tx_lps_opt(aData)
        set_tx_lps_opt = aData
        write
    End Property

    Property Get get_send_z_det_opt
        get_send_z_det_opt = read_send_z_det_opt_value
    End Property

    Property Let set_send_z_det_opt(aData)
        write_send_z_det_opt_value = aData
        flag_send_z_det_opt        = &H1
    End Property

    Property Get read_send_z_det_opt
        read
        read_send_z_det_opt = read_send_z_det_opt_value
    End Property

    Property Let write_send_z_det_opt(aData)
        set_send_z_det_opt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pms_fastsim_mode_value = rightShift(data_low, 6) and &H1
        read_pms_rx_block_dis_value = rightShift(data_low, 5) and &H1
        read_conti_lp_dis_value = rightShift(data_low, 4) and &H1
        read_tx_lps_opt_value = rightShift(data_low, 2) and &H3
        send_z_det_opt_mask = &H3
        if data_low > LONG_MAX then
            if send_z_det_opt_mask = mask then
                read_send_z_det_opt_value = data_low
            else
                read_send_z_det_opt_value = (data_low - H8000_0000) and send_z_det_opt_mask
            end If
        else
            read_send_z_det_opt_value = data_low and send_z_det_opt_mask
        end If

    End Sub

    Sub write
        If flag_pms_fastsim_mode = &H0 or flag_pms_rx_block_dis = &H0 or flag_conti_lp_dis = &H0 or flag_tx_lps_opt = &H0 or flag_send_z_det_opt = &H0 Then read
        If flag_pms_fastsim_mode = &H0 Then write_pms_fastsim_mode_value = get_pms_fastsim_mode
        If flag_pms_rx_block_dis = &H0 Then write_pms_rx_block_dis_value = get_pms_rx_block_dis
        If flag_conti_lp_dis = &H0 Then write_conti_lp_dis_value = get_conti_lp_dis
        If flag_tx_lps_opt = &H0 Then write_tx_lps_opt_value = get_tx_lps_opt
        If flag_send_z_det_opt = &H0 Then write_send_z_det_opt_value = get_send_z_det_opt

        regValue = leftShift((write_pms_fastsim_mode_value and &H1), 6) + leftShift((write_pms_rx_block_dis_value and &H1), 5) + leftShift((write_conti_lp_dis_value and &H1), 4) + leftShift((write_tx_lps_opt_value and &H3), 2) + leftShift((write_send_z_det_opt_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pms_fastsim_mode_value = rightShift(data_low, 6) and &H1
        read_pms_rx_block_dis_value = rightShift(data_low, 5) and &H1
        read_conti_lp_dis_value = rightShift(data_low, 4) and &H1
        read_tx_lps_opt_value = rightShift(data_low, 2) and &H3
        send_z_det_opt_mask = &H3
        if data_low > LONG_MAX then
            if send_z_det_opt_mask = mask then
                read_send_z_det_opt_value = data_low
            else
                read_send_z_det_opt_value = (data_low - H8000_0000) and send_z_det_opt_mask
            end If
        else
            read_send_z_det_opt_value = data_low and send_z_det_opt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pms_fastsim_mode_value = &H0
        flag_pms_fastsim_mode        = &H0
        write_pms_rx_block_dis_value = &H0
        flag_pms_rx_block_dis        = &H0
        write_conti_lp_dis_value = &H0
        flag_conti_lp_dis        = &H0
        write_tx_lps_opt_value = &H0
        flag_tx_lps_opt        = &H0
        write_send_z_det_opt_value = &H0
        flag_send_z_det_opt        = &H0
    End Sub
End Class


'' @REGISTER : BR_EOC_expa5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_expa5

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


'' @REGISTER : BR_EOC_expa6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_expa6

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


'' @REGISTER : BR_EOC_expa7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_expa7

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


'' @REGISTER : BR_EOC_br250_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BR_CURR_RATE                               [15:12]          get_BR_CURR_RATE
''                                                             set_BR_CURR_RATE
''                                                             read_BR_CURR_RATE
''                                                             write_BR_CURR_RATE
''---------------------------------------------------------------------------------
'' BR_CURR_PAIR                               [11:10]          get_BR_CURR_PAIR
''                                                             set_BR_CURR_PAIR
''                                                             read_BR_CURR_PAIR
''                                                             write_BR_CURR_PAIR
''---------------------------------------------------------------------------------
'' BR_PAM5_200_sel                            [7:7]            get_BR_PAM5_200_sel
''                                                             set_BR_PAM5_200_sel
''                                                             read_BR_PAM5_200_sel
''                                                             write_BR_PAM5_200_sel
''---------------------------------------------------------------------------------
'' LBKTst2                                    [6:6]            get_LBKTst2
''                                                             set_LBKTst2
''                                                             read_LBKTst2
''                                                             write_LBKTst2
''---------------------------------------------------------------------------------
'' CONF_GPLL_125                              [5:5]            get_CONF_GPLL_125
''                                                             set_CONF_GPLL_125
''                                                             read_CONF_GPLL_125
''                                                             write_CONF_GPLL_125
''---------------------------------------------------------------------------------
'' RXDV_FIX_DIS                               [4:4]            get_RXDV_FIX_DIS
''                                                             set_RXDV_FIX_DIS
''                                                             read_RXDV_FIX_DIS
''                                                             write_RXDV_FIX_DIS
''---------------------------------------------------------------------------------
'' INTRLV_CTL                                 [3:2]            get_INTRLV_CTL
''                                                             set_INTRLV_CTL
''                                                             read_INTRLV_CTL
''                                                             write_INTRLV_CTL
''---------------------------------------------------------------------------------
'' PAIR_CFG                                   [1:0]            get_PAIR_CFG
''                                                             set_PAIR_CFG
''                                                             read_PAIR_CFG
''                                                             write_PAIR_CFG
''---------------------------------------------------------------------------------
Class REGISTER_BR_EOC_br250_ctl
    Private write_BR_CURR_RATE_value
    Private read_BR_CURR_RATE_value
    Private flag_BR_CURR_RATE
    Private write_BR_CURR_PAIR_value
    Private read_BR_CURR_PAIR_value
    Private flag_BR_CURR_PAIR
    Private write_BR_PAM5_200_sel_value
    Private read_BR_PAM5_200_sel_value
    Private flag_BR_PAM5_200_sel
    Private write_LBKTst2_value
    Private read_LBKTst2_value
    Private flag_LBKTst2
    Private write_CONF_GPLL_125_value
    Private read_CONF_GPLL_125_value
    Private flag_CONF_GPLL_125
    Private write_RXDV_FIX_DIS_value
    Private read_RXDV_FIX_DIS_value
    Private flag_RXDV_FIX_DIS
    Private write_INTRLV_CTL_value
    Private read_INTRLV_CTL_value
    Private flag_INTRLV_CTL
    Private write_PAIR_CFG_value
    Private read_PAIR_CFG_value
    Private flag_PAIR_CFG

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

    Property Get get_BR_CURR_RATE
        get_BR_CURR_RATE = read_BR_CURR_RATE_value
    End Property

    Property Let set_BR_CURR_RATE(aData)
        write_BR_CURR_RATE_value = aData
        flag_BR_CURR_RATE        = &H1
    End Property

    Property Get read_BR_CURR_RATE
        read
        read_BR_CURR_RATE = read_BR_CURR_RATE_value
    End Property

    Property Let write_BR_CURR_RATE(aData)
        set_BR_CURR_RATE = aData
        write
    End Property

    Property Get get_BR_CURR_PAIR
        get_BR_CURR_PAIR = read_BR_CURR_PAIR_value
    End Property

    Property Let set_BR_CURR_PAIR(aData)
        write_BR_CURR_PAIR_value = aData
        flag_BR_CURR_PAIR        = &H1
    End Property

    Property Get read_BR_CURR_PAIR
        read
        read_BR_CURR_PAIR = read_BR_CURR_PAIR_value
    End Property

    Property Let write_BR_CURR_PAIR(aData)
        set_BR_CURR_PAIR = aData
        write
    End Property

    Property Get get_BR_PAM5_200_sel
        get_BR_PAM5_200_sel = read_BR_PAM5_200_sel_value
    End Property

    Property Let set_BR_PAM5_200_sel(aData)
        write_BR_PAM5_200_sel_value = aData
        flag_BR_PAM5_200_sel        = &H1
    End Property

    Property Get read_BR_PAM5_200_sel
        read
        read_BR_PAM5_200_sel = read_BR_PAM5_200_sel_value
    End Property

    Property Let write_BR_PAM5_200_sel(aData)
        set_BR_PAM5_200_sel = aData
        write
    End Property

    Property Get get_LBKTst2
        get_LBKTst2 = read_LBKTst2_value
    End Property

    Property Let set_LBKTst2(aData)
        write_LBKTst2_value = aData
        flag_LBKTst2        = &H1
    End Property

    Property Get read_LBKTst2
        read
        read_LBKTst2 = read_LBKTst2_value
    End Property

    Property Let write_LBKTst2(aData)
        set_LBKTst2 = aData
        write
    End Property

    Property Get get_CONF_GPLL_125
        get_CONF_GPLL_125 = read_CONF_GPLL_125_value
    End Property

    Property Let set_CONF_GPLL_125(aData)
        write_CONF_GPLL_125_value = aData
        flag_CONF_GPLL_125        = &H1
    End Property

    Property Get read_CONF_GPLL_125
        read
        read_CONF_GPLL_125 = read_CONF_GPLL_125_value
    End Property

    Property Let write_CONF_GPLL_125(aData)
        set_CONF_GPLL_125 = aData
        write
    End Property

    Property Get get_RXDV_FIX_DIS
        get_RXDV_FIX_DIS = read_RXDV_FIX_DIS_value
    End Property

    Property Let set_RXDV_FIX_DIS(aData)
        write_RXDV_FIX_DIS_value = aData
        flag_RXDV_FIX_DIS        = &H1
    End Property

    Property Get read_RXDV_FIX_DIS
        read
        read_RXDV_FIX_DIS = read_RXDV_FIX_DIS_value
    End Property

    Property Let write_RXDV_FIX_DIS(aData)
        set_RXDV_FIX_DIS = aData
        write
    End Property

    Property Get get_INTRLV_CTL
        get_INTRLV_CTL = read_INTRLV_CTL_value
    End Property

    Property Let set_INTRLV_CTL(aData)
        write_INTRLV_CTL_value = aData
        flag_INTRLV_CTL        = &H1
    End Property

    Property Get read_INTRLV_CTL
        read
        read_INTRLV_CTL = read_INTRLV_CTL_value
    End Property

    Property Let write_INTRLV_CTL(aData)
        set_INTRLV_CTL = aData
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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_CURR_RATE_value = rightShift(data_low, 12) and &Hf
        read_BR_CURR_PAIR_value = rightShift(data_low, 10) and &H3
        read_BR_PAM5_200_sel_value = rightShift(data_low, 7) and &H1
        read_LBKTst2_value = rightShift(data_low, 6) and &H1
        read_CONF_GPLL_125_value = rightShift(data_low, 5) and &H1
        read_RXDV_FIX_DIS_value = rightShift(data_low, 4) and &H1
        read_INTRLV_CTL_value = rightShift(data_low, 2) and &H3
        PAIR_CFG_mask = &H3
        if data_low > LONG_MAX then
            if PAIR_CFG_mask = mask then
                read_PAIR_CFG_value = data_low
            else
                read_PAIR_CFG_value = (data_low - H8000_0000) and PAIR_CFG_mask
            end If
        else
            read_PAIR_CFG_value = data_low and PAIR_CFG_mask
        end If

    End Sub

    Sub write
        If flag_BR_CURR_RATE = &H0 or flag_BR_CURR_PAIR = &H0 or flag_BR_PAM5_200_sel = &H0 or flag_LBKTst2 = &H0 or flag_CONF_GPLL_125 = &H0 or flag_RXDV_FIX_DIS = &H0 or flag_INTRLV_CTL = &H0 or flag_PAIR_CFG = &H0 Then read
        If flag_BR_CURR_RATE = &H0 Then write_BR_CURR_RATE_value = get_BR_CURR_RATE
        If flag_BR_CURR_PAIR = &H0 Then write_BR_CURR_PAIR_value = get_BR_CURR_PAIR
        If flag_BR_PAM5_200_sel = &H0 Then write_BR_PAM5_200_sel_value = get_BR_PAM5_200_sel
        If flag_LBKTst2 = &H0 Then write_LBKTst2_value = get_LBKTst2
        If flag_CONF_GPLL_125 = &H0 Then write_CONF_GPLL_125_value = get_CONF_GPLL_125
        If flag_RXDV_FIX_DIS = &H0 Then write_RXDV_FIX_DIS_value = get_RXDV_FIX_DIS
        If flag_INTRLV_CTL = &H0 Then write_INTRLV_CTL_value = get_INTRLV_CTL
        If flag_PAIR_CFG = &H0 Then write_PAIR_CFG_value = get_PAIR_CFG

        regValue = leftShift((write_BR_CURR_RATE_value and &Hf), 12) + leftShift((write_BR_CURR_PAIR_value and &H3), 10) + leftShift((write_BR_PAM5_200_sel_value and &H1), 7) + leftShift((write_LBKTst2_value and &H1), 6) + leftShift((write_CONF_GPLL_125_value and &H1), 5) + leftShift((write_RXDV_FIX_DIS_value and &H1), 4) + leftShift((write_INTRLV_CTL_value and &H3), 2) + leftShift((write_PAIR_CFG_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BR_CURR_RATE_value = rightShift(data_low, 12) and &Hf
        read_BR_CURR_PAIR_value = rightShift(data_low, 10) and &H3
        read_BR_PAM5_200_sel_value = rightShift(data_low, 7) and &H1
        read_LBKTst2_value = rightShift(data_low, 6) and &H1
        read_CONF_GPLL_125_value = rightShift(data_low, 5) and &H1
        read_RXDV_FIX_DIS_value = rightShift(data_low, 4) and &H1
        read_INTRLV_CTL_value = rightShift(data_low, 2) and &H3
        PAIR_CFG_mask = &H3
        if data_low > LONG_MAX then
            if PAIR_CFG_mask = mask then
                read_PAIR_CFG_value = data_low
            else
                read_PAIR_CFG_value = (data_low - H8000_0000) and PAIR_CFG_mask
            end If
        else
            read_PAIR_CFG_value = data_low and PAIR_CFG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BR_CURR_RATE_value = &H0
        flag_BR_CURR_RATE        = &H0
        write_BR_CURR_PAIR_value = &H0
        flag_BR_CURR_PAIR        = &H0
        write_BR_PAM5_200_sel_value = &H0
        flag_BR_PAM5_200_sel        = &H0
        write_LBKTst2_value = &H0
        flag_LBKTst2        = &H0
        write_CONF_GPLL_125_value = &H0
        flag_CONF_GPLL_125        = &H0
        write_RXDV_FIX_DIS_value = &H0
        flag_RXDV_FIX_DIS        = &H0
        write_INTRLV_CTL_value = &H0
        flag_INTRLV_CTL        = &H0
        write_PAIR_CFG_value = &H0
        flag_PAIR_CFG        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class BR_EOC_INSTANCE

    Public exp90
    Public exp91
    Public exp92
    Public exp93
    Public exp94
    Public exp95
    Public exp96
    Public exp97
    Public exp99
    Public exp9a
    Public exp9b
    Public exp9d
    Public exp9e
    Public exp9f
    Public expa0
    Public expa1
    Public expa2
    Public br_misc_control_status
    Public tc10_ctrl
    Public expa5
    Public expa6
    Public expa7
    Public br250_ctl


    Public default function Init(aBaseAddr)
        Set exp90 = (New REGISTER_BR_EOC_exp90)(aBaseAddr, 16)
        Set exp91 = (New REGISTER_BR_EOC_exp91)(aBaseAddr, 16)
        Set exp92 = (New REGISTER_BR_EOC_exp92)(aBaseAddr, 16)
        Set exp93 = (New REGISTER_BR_EOC_exp93)(aBaseAddr, 16)
        Set exp94 = (New REGISTER_BR_EOC_exp94)(aBaseAddr, 16)
        Set exp95 = (New REGISTER_BR_EOC_exp95)(aBaseAddr, 16)
        Set exp96 = (New REGISTER_BR_EOC_exp96)(aBaseAddr, 16)
        Set exp97 = (New REGISTER_BR_EOC_exp97)(aBaseAddr, 16)
        Set exp99 = (New REGISTER_BR_EOC_exp99)(aBaseAddr, 16)
        Set exp9a = (New REGISTER_BR_EOC_exp9a)(aBaseAddr, 16)
        Set exp9b = (New REGISTER_BR_EOC_exp9b)(aBaseAddr, 16)
        Set exp9d = (New REGISTER_BR_EOC_exp9d)(aBaseAddr, 16)
        Set exp9e = (New REGISTER_BR_EOC_exp9e)(aBaseAddr, 16)
        Set exp9f = (New REGISTER_BR_EOC_exp9f)(aBaseAddr, 16)
        Set expa0 = (New REGISTER_BR_EOC_expa0)(aBaseAddr, 16)
        Set expa1 = (New REGISTER_BR_EOC_expa1)(aBaseAddr, 16)
        Set expa2 = (New REGISTER_BR_EOC_expa2)(aBaseAddr, 16)
        Set br_misc_control_status = (New REGISTER_BR_EOC_br_misc_control_status)(aBaseAddr, 16)
        Set tc10_ctrl = (New REGISTER_BR_EOC_tc10_ctrl)(aBaseAddr, 16)
        Set expa5 = (New REGISTER_BR_EOC_expa5)(aBaseAddr, 16)
        Set expa6 = (New REGISTER_BR_EOC_expa6)(aBaseAddr, 16)
        Set expa7 = (New REGISTER_BR_EOC_expa7)(aBaseAddr, 16)
        Set br250_ctl = (New REGISTER_BR_EOC_br250_ctl)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set BR_EOC = CreateObject("System.Collections.ArrayList")
BR_EOC.Add ((New BR_EOC_INSTANCE)(&H4a4f2600))
BR_EOC.Add ((New BR_EOC_INSTANCE)(&H494f2600))
BR_EOC.Add ((New BR_EOC_INSTANCE)(&H498f2600))
BR_EOC.Add ((New BR_EOC_INSTANCE)(&H49cf2600))
BR_EOC.Add ((New BR_EOC_INSTANCE)(&H4a0f2600))


