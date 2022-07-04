

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


'' @REGISTER : TX_CHANNEL_tx_channel_ctl_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AFE_TX_T0_T1_SYM_INVERT                    [4:4]            get_AFE_TX_T0_T1_SYM_INVERT
''                                                             set_AFE_TX_T0_T1_SYM_INVERT
''                                                             read_AFE_TX_T0_T1_SYM_INVERT
''                                                             write_AFE_TX_T0_T1_SYM_INVERT
''---------------------------------------------------------------------------------
'' AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER         [3:3]            get_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
''                                                             set_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
''                                                             read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
''                                                             write_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
''---------------------------------------------------------------------------------
'' AFE_TX_T0_T1_SYM_SWAP                      [2:2]            get_AFE_TX_T0_T1_SYM_SWAP
''                                                             set_AFE_TX_T0_T1_SYM_SWAP
''                                                             read_AFE_TX_T0_T1_SYM_SWAP
''                                                             write_AFE_TX_T0_T1_SYM_SWAP
''---------------------------------------------------------------------------------
'' LINK_SYNC_T0_T1_SYM_SWAP                   [1:1]            get_LINK_SYNC_T0_T1_SYM_SWAP
''                                                             set_LINK_SYNC_T0_T1_SYM_SWAP
''                                                             read_LINK_SYNC_T0_T1_SYM_SWAP
''                                                             write_LINK_SYNC_T0_T1_SYM_SWAP
''---------------------------------------------------------------------------------
'' PCS_T0_T1_SYM_SWAP                         [0:0]            get_PCS_T0_T1_SYM_SWAP
''                                                             set_PCS_T0_T1_SYM_SWAP
''                                                             read_PCS_T0_T1_SYM_SWAP
''                                                             write_PCS_T0_T1_SYM_SWAP
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_ctl_a
    Private write_AFE_TX_T0_T1_SYM_INVERT_value
    Private read_AFE_TX_T0_T1_SYM_INVERT_value
    Private flag_AFE_TX_T0_T1_SYM_INVERT
    Private write_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    Private read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    Private flag_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
    Private write_AFE_TX_T0_T1_SYM_SWAP_value
    Private read_AFE_TX_T0_T1_SYM_SWAP_value
    Private flag_AFE_TX_T0_T1_SYM_SWAP
    Private write_LINK_SYNC_T0_T1_SYM_SWAP_value
    Private read_LINK_SYNC_T0_T1_SYM_SWAP_value
    Private flag_LINK_SYNC_T0_T1_SYM_SWAP
    Private write_PCS_T0_T1_SYM_SWAP_value
    Private read_PCS_T0_T1_SYM_SWAP_value
    Private flag_PCS_T0_T1_SYM_SWAP

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

    Property Get get_AFE_TX_T0_T1_SYM_INVERT
        get_AFE_TX_T0_T1_SYM_INVERT = read_AFE_TX_T0_T1_SYM_INVERT_value
    End Property

    Property Let set_AFE_TX_T0_T1_SYM_INVERT(aData)
        write_AFE_TX_T0_T1_SYM_INVERT_value = aData
        flag_AFE_TX_T0_T1_SYM_INVERT        = &H1
    End Property

    Property Get read_AFE_TX_T0_T1_SYM_INVERT
        read
        read_AFE_TX_T0_T1_SYM_INVERT = read_AFE_TX_T0_T1_SYM_INVERT_value
    End Property

    Property Let write_AFE_TX_T0_T1_SYM_INVERT(aData)
        set_AFE_TX_T0_T1_SYM_INVERT = aData
        write
    End Property

    Property Get get_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
        get_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER = read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    End Property

    Property Let set_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER(aData)
        write_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value = aData
        flag_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER        = &H1
    End Property

    Property Get read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
        read
        read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER = read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value
    End Property

    Property Let write_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER(aData)
        set_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER = aData
        write
    End Property

    Property Get get_AFE_TX_T0_T1_SYM_SWAP
        get_AFE_TX_T0_T1_SYM_SWAP = read_AFE_TX_T0_T1_SYM_SWAP_value
    End Property

    Property Let set_AFE_TX_T0_T1_SYM_SWAP(aData)
        write_AFE_TX_T0_T1_SYM_SWAP_value = aData
        flag_AFE_TX_T0_T1_SYM_SWAP        = &H1
    End Property

    Property Get read_AFE_TX_T0_T1_SYM_SWAP
        read
        read_AFE_TX_T0_T1_SYM_SWAP = read_AFE_TX_T0_T1_SYM_SWAP_value
    End Property

    Property Let write_AFE_TX_T0_T1_SYM_SWAP(aData)
        set_AFE_TX_T0_T1_SYM_SWAP = aData
        write
    End Property

    Property Get get_LINK_SYNC_T0_T1_SYM_SWAP
        get_LINK_SYNC_T0_T1_SYM_SWAP = read_LINK_SYNC_T0_T1_SYM_SWAP_value
    End Property

    Property Let set_LINK_SYNC_T0_T1_SYM_SWAP(aData)
        write_LINK_SYNC_T0_T1_SYM_SWAP_value = aData
        flag_LINK_SYNC_T0_T1_SYM_SWAP        = &H1
    End Property

    Property Get read_LINK_SYNC_T0_T1_SYM_SWAP
        read
        read_LINK_SYNC_T0_T1_SYM_SWAP = read_LINK_SYNC_T0_T1_SYM_SWAP_value
    End Property

    Property Let write_LINK_SYNC_T0_T1_SYM_SWAP(aData)
        set_LINK_SYNC_T0_T1_SYM_SWAP = aData
        write
    End Property

    Property Get get_PCS_T0_T1_SYM_SWAP
        get_PCS_T0_T1_SYM_SWAP = read_PCS_T0_T1_SYM_SWAP_value
    End Property

    Property Let set_PCS_T0_T1_SYM_SWAP(aData)
        write_PCS_T0_T1_SYM_SWAP_value = aData
        flag_PCS_T0_T1_SYM_SWAP        = &H1
    End Property

    Property Get read_PCS_T0_T1_SYM_SWAP
        read
        read_PCS_T0_T1_SYM_SWAP = read_PCS_T0_T1_SYM_SWAP_value
    End Property

    Property Let write_PCS_T0_T1_SYM_SWAP(aData)
        set_PCS_T0_T1_SYM_SWAP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AFE_TX_T0_T1_SYM_INVERT_value = rightShift(data_low, 4) and &H1
        read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value = rightShift(data_low, 3) and &H1
        read_AFE_TX_T0_T1_SYM_SWAP_value = rightShift(data_low, 2) and &H1
        read_LINK_SYNC_T0_T1_SYM_SWAP_value = rightShift(data_low, 1) and &H1
        PCS_T0_T1_SYM_SWAP_mask = &H1
        if data_low > LONG_MAX then
            if PCS_T0_T1_SYM_SWAP_mask = mask then
                read_PCS_T0_T1_SYM_SWAP_value = data_low
            else
                read_PCS_T0_T1_SYM_SWAP_value = (data_low - H8000_0000) and PCS_T0_T1_SYM_SWAP_mask
            end If
        else
            read_PCS_T0_T1_SYM_SWAP_value = data_low and PCS_T0_T1_SYM_SWAP_mask
        end If

    End Sub

    Sub write
        If flag_AFE_TX_T0_T1_SYM_INVERT = &H0 or flag_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER = &H0 or flag_AFE_TX_T0_T1_SYM_SWAP = &H0 or flag_LINK_SYNC_T0_T1_SYM_SWAP = &H0 or flag_PCS_T0_T1_SYM_SWAP = &H0 Then read
        If flag_AFE_TX_T0_T1_SYM_INVERT = &H0 Then write_AFE_TX_T0_T1_SYM_INVERT_value = get_AFE_TX_T0_T1_SYM_INVERT
        If flag_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER = &H0 Then write_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value = get_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER
        If flag_AFE_TX_T0_T1_SYM_SWAP = &H0 Then write_AFE_TX_T0_T1_SYM_SWAP_value = get_AFE_TX_T0_T1_SYM_SWAP
        If flag_LINK_SYNC_T0_T1_SYM_SWAP = &H0 Then write_LINK_SYNC_T0_T1_SYM_SWAP_value = get_LINK_SYNC_T0_T1_SYM_SWAP
        If flag_PCS_T0_T1_SYM_SWAP = &H0 Then write_PCS_T0_T1_SYM_SWAP_value = get_PCS_T0_T1_SYM_SWAP

        regValue = leftShift((write_AFE_TX_T0_T1_SYM_INVERT_value and &H1), 4) + leftShift((write_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value and &H1), 3) + leftShift((write_AFE_TX_T0_T1_SYM_SWAP_value and &H1), 2) + leftShift((write_LINK_SYNC_T0_T1_SYM_SWAP_value and &H1), 1) + leftShift((write_PCS_T0_T1_SYM_SWAP_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AFE_TX_T0_T1_SYM_INVERT_value = rightShift(data_low, 4) and &H1
        read_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value = rightShift(data_low, 3) and &H1
        read_AFE_TX_T0_T1_SYM_SWAP_value = rightShift(data_low, 2) and &H1
        read_LINK_SYNC_T0_T1_SYM_SWAP_value = rightShift(data_low, 1) and &H1
        PCS_T0_T1_SYM_SWAP_mask = &H1
        if data_low > LONG_MAX then
            if PCS_T0_T1_SYM_SWAP_mask = mask then
                read_PCS_T0_T1_SYM_SWAP_value = data_low
            else
                read_PCS_T0_T1_SYM_SWAP_value = (data_low - H8000_0000) and PCS_T0_T1_SYM_SWAP_mask
            end If
        else
            read_PCS_T0_T1_SYM_SWAP_value = data_low and PCS_T0_T1_SYM_SWAP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AFE_TX_T0_T1_SYM_INVERT_value = &H0
        flag_AFE_TX_T0_T1_SYM_INVERT        = &H0
        write_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER_value = &H0
        flag_AFE_TX_T0_T1_SYM_BIT_REVERSE_ORDER        = &H0
        write_AFE_TX_T0_T1_SYM_SWAP_value = &H0
        flag_AFE_TX_T0_T1_SYM_SWAP        = &H0
        write_LINK_SYNC_T0_T1_SYM_SWAP_value = &H0
        flag_LINK_SYNC_T0_T1_SYM_SWAP        = &H0
        write_PCS_T0_T1_SYM_SWAP_value = &H0
        flag_PCS_T0_T1_SYM_SWAP        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_ctl_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PRFBYP_1G                                  [15:15]          get_PRFBYP_1G
''                                                             set_PRFBYP_1G
''                                                             read_PRFBYP_1G
''                                                             write_PRFBYP_1G
''---------------------------------------------------------------------------------
'' DISABLE_PCS_RESIDUE_BLOCK                  [14:14]          get_DISABLE_PCS_RESIDUE_BLOCK
''                                                             set_DISABLE_PCS_RESIDUE_BLOCK
''                                                             read_DISABLE_PCS_RESIDUE_BLOCK
''                                                             write_DISABLE_PCS_RESIDUE_BLOCK
''---------------------------------------------------------------------------------
'' HALFOUT                                    [13:13]          get_HALFOUT
''                                                             set_HALFOUT
''                                                             read_HALFOUT
''                                                             write_HALFOUT
''---------------------------------------------------------------------------------
'' BR_RATE                                    [12:10]          get_BR_RATE
''                                                             set_BR_RATE
''                                                             read_BR_RATE
''                                                             write_BR_RATE
''---------------------------------------------------------------------------------
'' BR_PAIR                                    [9:8]            get_BR_PAIR
''                                                             set_BR_PAIR
''                                                             read_BR_PAIR
''                                                             write_BR_PAIR
''---------------------------------------------------------------------------------
'' BR_EDGE_RATE_AUTONEG                       [7:6]            get_BR_EDGE_RATE_AUTONEG
''                                                             set_BR_EDGE_RATE_AUTONEG
''                                                             read_BR_EDGE_RATE_AUTONEG
''                                                             write_BR_EDGE_RATE_AUTONEG
''---------------------------------------------------------------------------------
'' AGC_EN                                     [5:5]            get_AGC_EN
''                                                             set_AGC_EN
''                                                             read_AGC_EN
''                                                             write_AGC_EN
''---------------------------------------------------------------------------------
'' PRFBYP                                     [4:4]            get_PRFBYP
''                                                             set_PRFBYP
''                                                             read_PRFBYP
''                                                             write_PRFBYP
''---------------------------------------------------------------------------------
'' TX_CHANNEL_PWRDWN                          [3:3]            get_TX_CHANNEL_PWRDWN
''                                                             set_TX_CHANNEL_PWRDWN
''                                                             read_TX_CHANNEL_PWRDWN
''                                                             write_TX_CHANNEL_PWRDWN
''---------------------------------------------------------------------------------
'' HYBMODE                                    [2:2]            get_HYBMODE
''                                                             set_HYBMODE
''                                                             read_HYBMODE
''                                                             write_HYBMODE
''---------------------------------------------------------------------------------
'' BR_EDGE_RATE                               [1:0]            get_BR_EDGE_RATE
''                                                             set_BR_EDGE_RATE
''                                                             read_BR_EDGE_RATE
''                                                             write_BR_EDGE_RATE
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_ctl_b
    Private write_PRFBYP_1G_value
    Private read_PRFBYP_1G_value
    Private flag_PRFBYP_1G
    Private write_DISABLE_PCS_RESIDUE_BLOCK_value
    Private read_DISABLE_PCS_RESIDUE_BLOCK_value
    Private flag_DISABLE_PCS_RESIDUE_BLOCK
    Private write_HALFOUT_value
    Private read_HALFOUT_value
    Private flag_HALFOUT
    Private write_BR_RATE_value
    Private read_BR_RATE_value
    Private flag_BR_RATE
    Private write_BR_PAIR_value
    Private read_BR_PAIR_value
    Private flag_BR_PAIR
    Private write_BR_EDGE_RATE_AUTONEG_value
    Private read_BR_EDGE_RATE_AUTONEG_value
    Private flag_BR_EDGE_RATE_AUTONEG
    Private write_AGC_EN_value
    Private read_AGC_EN_value
    Private flag_AGC_EN
    Private write_PRFBYP_value
    Private read_PRFBYP_value
    Private flag_PRFBYP
    Private write_TX_CHANNEL_PWRDWN_value
    Private read_TX_CHANNEL_PWRDWN_value
    Private flag_TX_CHANNEL_PWRDWN
    Private write_HYBMODE_value
    Private read_HYBMODE_value
    Private flag_HYBMODE
    Private write_BR_EDGE_RATE_value
    Private read_BR_EDGE_RATE_value
    Private flag_BR_EDGE_RATE

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

    Property Get get_PRFBYP_1G
        get_PRFBYP_1G = read_PRFBYP_1G_value
    End Property

    Property Let set_PRFBYP_1G(aData)
        write_PRFBYP_1G_value = aData
        flag_PRFBYP_1G        = &H1
    End Property

    Property Get read_PRFBYP_1G
        read
        read_PRFBYP_1G = read_PRFBYP_1G_value
    End Property

    Property Let write_PRFBYP_1G(aData)
        set_PRFBYP_1G = aData
        write
    End Property

    Property Get get_DISABLE_PCS_RESIDUE_BLOCK
        get_DISABLE_PCS_RESIDUE_BLOCK = read_DISABLE_PCS_RESIDUE_BLOCK_value
    End Property

    Property Let set_DISABLE_PCS_RESIDUE_BLOCK(aData)
        write_DISABLE_PCS_RESIDUE_BLOCK_value = aData
        flag_DISABLE_PCS_RESIDUE_BLOCK        = &H1
    End Property

    Property Get read_DISABLE_PCS_RESIDUE_BLOCK
        read
        read_DISABLE_PCS_RESIDUE_BLOCK = read_DISABLE_PCS_RESIDUE_BLOCK_value
    End Property

    Property Let write_DISABLE_PCS_RESIDUE_BLOCK(aData)
        set_DISABLE_PCS_RESIDUE_BLOCK = aData
        write
    End Property

    Property Get get_HALFOUT
        get_HALFOUT = read_HALFOUT_value
    End Property

    Property Let set_HALFOUT(aData)
        write_HALFOUT_value = aData
        flag_HALFOUT        = &H1
    End Property

    Property Get read_HALFOUT
        read
        read_HALFOUT = read_HALFOUT_value
    End Property

    Property Let write_HALFOUT(aData)
        set_HALFOUT = aData
        write
    End Property

    Property Get get_BR_RATE
        get_BR_RATE = read_BR_RATE_value
    End Property

    Property Let set_BR_RATE(aData)
        write_BR_RATE_value = aData
        flag_BR_RATE        = &H1
    End Property

    Property Get read_BR_RATE
        read
        read_BR_RATE = read_BR_RATE_value
    End Property

    Property Let write_BR_RATE(aData)
        set_BR_RATE = aData
        write
    End Property

    Property Get get_BR_PAIR
        get_BR_PAIR = read_BR_PAIR_value
    End Property

    Property Let set_BR_PAIR(aData)
        write_BR_PAIR_value = aData
        flag_BR_PAIR        = &H1
    End Property

    Property Get read_BR_PAIR
        read
        read_BR_PAIR = read_BR_PAIR_value
    End Property

    Property Let write_BR_PAIR(aData)
        set_BR_PAIR = aData
        write
    End Property

    Property Get get_BR_EDGE_RATE_AUTONEG
        get_BR_EDGE_RATE_AUTONEG = read_BR_EDGE_RATE_AUTONEG_value
    End Property

    Property Let set_BR_EDGE_RATE_AUTONEG(aData)
        write_BR_EDGE_RATE_AUTONEG_value = aData
        flag_BR_EDGE_RATE_AUTONEG        = &H1
    End Property

    Property Get read_BR_EDGE_RATE_AUTONEG
        read
        read_BR_EDGE_RATE_AUTONEG = read_BR_EDGE_RATE_AUTONEG_value
    End Property

    Property Let write_BR_EDGE_RATE_AUTONEG(aData)
        set_BR_EDGE_RATE_AUTONEG = aData
        write
    End Property

    Property Get get_AGC_EN
        get_AGC_EN = read_AGC_EN_value
    End Property

    Property Let set_AGC_EN(aData)
        write_AGC_EN_value = aData
        flag_AGC_EN        = &H1
    End Property

    Property Get read_AGC_EN
        read
        read_AGC_EN = read_AGC_EN_value
    End Property

    Property Let write_AGC_EN(aData)
        set_AGC_EN = aData
        write
    End Property

    Property Get get_PRFBYP
        get_PRFBYP = read_PRFBYP_value
    End Property

    Property Let set_PRFBYP(aData)
        write_PRFBYP_value = aData
        flag_PRFBYP        = &H1
    End Property

    Property Get read_PRFBYP
        read
        read_PRFBYP = read_PRFBYP_value
    End Property

    Property Let write_PRFBYP(aData)
        set_PRFBYP = aData
        write
    End Property

    Property Get get_TX_CHANNEL_PWRDWN
        get_TX_CHANNEL_PWRDWN = read_TX_CHANNEL_PWRDWN_value
    End Property

    Property Let set_TX_CHANNEL_PWRDWN(aData)
        write_TX_CHANNEL_PWRDWN_value = aData
        flag_TX_CHANNEL_PWRDWN        = &H1
    End Property

    Property Get read_TX_CHANNEL_PWRDWN
        read
        read_TX_CHANNEL_PWRDWN = read_TX_CHANNEL_PWRDWN_value
    End Property

    Property Let write_TX_CHANNEL_PWRDWN(aData)
        set_TX_CHANNEL_PWRDWN = aData
        write
    End Property

    Property Get get_HYBMODE
        get_HYBMODE = read_HYBMODE_value
    End Property

    Property Let set_HYBMODE(aData)
        write_HYBMODE_value = aData
        flag_HYBMODE        = &H1
    End Property

    Property Get read_HYBMODE
        read
        read_HYBMODE = read_HYBMODE_value
    End Property

    Property Let write_HYBMODE(aData)
        set_HYBMODE = aData
        write
    End Property

    Property Get get_BR_EDGE_RATE
        get_BR_EDGE_RATE = read_BR_EDGE_RATE_value
    End Property

    Property Let set_BR_EDGE_RATE(aData)
        write_BR_EDGE_RATE_value = aData
        flag_BR_EDGE_RATE        = &H1
    End Property

    Property Get read_BR_EDGE_RATE
        read
        read_BR_EDGE_RATE = read_BR_EDGE_RATE_value
    End Property

    Property Let write_BR_EDGE_RATE(aData)
        set_BR_EDGE_RATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PRFBYP_1G_value = rightShift(data_low, 15) and &H1
        read_DISABLE_PCS_RESIDUE_BLOCK_value = rightShift(data_low, 14) and &H1
        read_HALFOUT_value = rightShift(data_low, 13) and &H1
        read_BR_RATE_value = rightShift(data_low, 10) and &H7
        read_BR_PAIR_value = rightShift(data_low, 8) and &H3
        read_BR_EDGE_RATE_AUTONEG_value = rightShift(data_low, 6) and &H3
        read_AGC_EN_value = rightShift(data_low, 5) and &H1
        read_PRFBYP_value = rightShift(data_low, 4) and &H1
        read_TX_CHANNEL_PWRDWN_value = rightShift(data_low, 3) and &H1
        read_HYBMODE_value = rightShift(data_low, 2) and &H1
        BR_EDGE_RATE_mask = &H3
        if data_low > LONG_MAX then
            if BR_EDGE_RATE_mask = mask then
                read_BR_EDGE_RATE_value = data_low
            else
                read_BR_EDGE_RATE_value = (data_low - H8000_0000) and BR_EDGE_RATE_mask
            end If
        else
            read_BR_EDGE_RATE_value = data_low and BR_EDGE_RATE_mask
        end If

    End Sub

    Sub write
        If flag_PRFBYP_1G = &H0 or flag_DISABLE_PCS_RESIDUE_BLOCK = &H0 or flag_HALFOUT = &H0 or flag_BR_RATE = &H0 or flag_BR_PAIR = &H0 or flag_BR_EDGE_RATE_AUTONEG = &H0 or flag_AGC_EN = &H0 or flag_PRFBYP = &H0 or flag_TX_CHANNEL_PWRDWN = &H0 or flag_HYBMODE = &H0 or flag_BR_EDGE_RATE = &H0 Then read
        If flag_PRFBYP_1G = &H0 Then write_PRFBYP_1G_value = get_PRFBYP_1G
        If flag_DISABLE_PCS_RESIDUE_BLOCK = &H0 Then write_DISABLE_PCS_RESIDUE_BLOCK_value = get_DISABLE_PCS_RESIDUE_BLOCK
        If flag_HALFOUT = &H0 Then write_HALFOUT_value = get_HALFOUT
        If flag_BR_RATE = &H0 Then write_BR_RATE_value = get_BR_RATE
        If flag_BR_PAIR = &H0 Then write_BR_PAIR_value = get_BR_PAIR
        If flag_BR_EDGE_RATE_AUTONEG = &H0 Then write_BR_EDGE_RATE_AUTONEG_value = get_BR_EDGE_RATE_AUTONEG
        If flag_AGC_EN = &H0 Then write_AGC_EN_value = get_AGC_EN
        If flag_PRFBYP = &H0 Then write_PRFBYP_value = get_PRFBYP
        If flag_TX_CHANNEL_PWRDWN = &H0 Then write_TX_CHANNEL_PWRDWN_value = get_TX_CHANNEL_PWRDWN
        If flag_HYBMODE = &H0 Then write_HYBMODE_value = get_HYBMODE
        If flag_BR_EDGE_RATE = &H0 Then write_BR_EDGE_RATE_value = get_BR_EDGE_RATE

        regValue = leftShift((write_PRFBYP_1G_value and &H1), 15) + leftShift((write_DISABLE_PCS_RESIDUE_BLOCK_value and &H1), 14) + leftShift((write_HALFOUT_value and &H1), 13) + leftShift((write_BR_RATE_value and &H7), 10) + leftShift((write_BR_PAIR_value and &H3), 8) + leftShift((write_BR_EDGE_RATE_AUTONEG_value and &H3), 6) + leftShift((write_AGC_EN_value and &H1), 5) + leftShift((write_PRFBYP_value and &H1), 4) + leftShift((write_TX_CHANNEL_PWRDWN_value and &H1), 3) + leftShift((write_HYBMODE_value and &H1), 2) + leftShift((write_BR_EDGE_RATE_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PRFBYP_1G_value = rightShift(data_low, 15) and &H1
        read_DISABLE_PCS_RESIDUE_BLOCK_value = rightShift(data_low, 14) and &H1
        read_HALFOUT_value = rightShift(data_low, 13) and &H1
        read_BR_RATE_value = rightShift(data_low, 10) and &H7
        read_BR_PAIR_value = rightShift(data_low, 8) and &H3
        read_BR_EDGE_RATE_AUTONEG_value = rightShift(data_low, 6) and &H3
        read_AGC_EN_value = rightShift(data_low, 5) and &H1
        read_PRFBYP_value = rightShift(data_low, 4) and &H1
        read_TX_CHANNEL_PWRDWN_value = rightShift(data_low, 3) and &H1
        read_HYBMODE_value = rightShift(data_low, 2) and &H1
        BR_EDGE_RATE_mask = &H3
        if data_low > LONG_MAX then
            if BR_EDGE_RATE_mask = mask then
                read_BR_EDGE_RATE_value = data_low
            else
                read_BR_EDGE_RATE_value = (data_low - H8000_0000) and BR_EDGE_RATE_mask
            end If
        else
            read_BR_EDGE_RATE_value = data_low and BR_EDGE_RATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PRFBYP_1G_value = &H0
        flag_PRFBYP_1G        = &H0
        write_DISABLE_PCS_RESIDUE_BLOCK_value = &H0
        flag_DISABLE_PCS_RESIDUE_BLOCK        = &H0
        write_HALFOUT_value = &H0
        flag_HALFOUT        = &H0
        write_BR_RATE_value = &H0
        flag_BR_RATE        = &H0
        write_BR_PAIR_value = &H0
        flag_BR_PAIR        = &H0
        write_BR_EDGE_RATE_AUTONEG_value = &H0
        flag_BR_EDGE_RATE_AUTONEG        = &H0
        write_AGC_EN_value = &H0
        flag_AGC_EN        = &H0
        write_PRFBYP_value = &H0
        flag_PRFBYP        = &H0
        write_TX_CHANNEL_PWRDWN_value = &H0
        flag_TX_CHANNEL_PWRDWN        = &H0
        write_HYBMODE_value = &H0
        flag_HYBMODE        = &H0
        write_BR_EDGE_RATE_value = &H0
        flag_BR_EDGE_RATE        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_ctl_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_CHANNEL_TEMPLATE_MODE                   [4:4]            get_TX_CHANNEL_TEMPLATE_MODE
''                                                             set_TX_CHANNEL_TEMPLATE_MODE
''                                                             read_TX_CHANNEL_TEMPLATE_MODE
''                                                             write_TX_CHANNEL_TEMPLATE_MODE
''---------------------------------------------------------------------------------
'' TX_CHANNEL_TESTMODE_ANA                    [3:3]            get_TX_CHANNEL_TESTMODE_ANA
''                                                             set_TX_CHANNEL_TESTMODE_ANA
''                                                             read_TX_CHANNEL_TESTMODE_ANA
''                                                             write_TX_CHANNEL_TESTMODE_ANA
''---------------------------------------------------------------------------------
'' TX_CHANNEL_TESTMODE                        [2:2]            get_TX_CHANNEL_TESTMODE
''                                                             set_TX_CHANNEL_TESTMODE
''                                                             read_TX_CHANNEL_TESTMODE
''                                                             write_TX_CHANNEL_TESTMODE
''---------------------------------------------------------------------------------
'' DISABLE_TX_IN_PCS_LPBK                     [0:0]            get_DISABLE_TX_IN_PCS_LPBK
''                                                             set_DISABLE_TX_IN_PCS_LPBK
''                                                             read_DISABLE_TX_IN_PCS_LPBK
''                                                             write_DISABLE_TX_IN_PCS_LPBK
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_ctl_c
    Private write_TX_CHANNEL_TEMPLATE_MODE_value
    Private read_TX_CHANNEL_TEMPLATE_MODE_value
    Private flag_TX_CHANNEL_TEMPLATE_MODE
    Private write_TX_CHANNEL_TESTMODE_ANA_value
    Private read_TX_CHANNEL_TESTMODE_ANA_value
    Private flag_TX_CHANNEL_TESTMODE_ANA
    Private write_TX_CHANNEL_TESTMODE_value
    Private read_TX_CHANNEL_TESTMODE_value
    Private flag_TX_CHANNEL_TESTMODE
    Private write_DISABLE_TX_IN_PCS_LPBK_value
    Private read_DISABLE_TX_IN_PCS_LPBK_value
    Private flag_DISABLE_TX_IN_PCS_LPBK

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

    Property Get get_TX_CHANNEL_TEMPLATE_MODE
        get_TX_CHANNEL_TEMPLATE_MODE = read_TX_CHANNEL_TEMPLATE_MODE_value
    End Property

    Property Let set_TX_CHANNEL_TEMPLATE_MODE(aData)
        write_TX_CHANNEL_TEMPLATE_MODE_value = aData
        flag_TX_CHANNEL_TEMPLATE_MODE        = &H1
    End Property

    Property Get read_TX_CHANNEL_TEMPLATE_MODE
        read
        read_TX_CHANNEL_TEMPLATE_MODE = read_TX_CHANNEL_TEMPLATE_MODE_value
    End Property

    Property Let write_TX_CHANNEL_TEMPLATE_MODE(aData)
        set_TX_CHANNEL_TEMPLATE_MODE = aData
        write
    End Property

    Property Get get_TX_CHANNEL_TESTMODE_ANA
        get_TX_CHANNEL_TESTMODE_ANA = read_TX_CHANNEL_TESTMODE_ANA_value
    End Property

    Property Let set_TX_CHANNEL_TESTMODE_ANA(aData)
        write_TX_CHANNEL_TESTMODE_ANA_value = aData
        flag_TX_CHANNEL_TESTMODE_ANA        = &H1
    End Property

    Property Get read_TX_CHANNEL_TESTMODE_ANA
        read
        read_TX_CHANNEL_TESTMODE_ANA = read_TX_CHANNEL_TESTMODE_ANA_value
    End Property

    Property Let write_TX_CHANNEL_TESTMODE_ANA(aData)
        set_TX_CHANNEL_TESTMODE_ANA = aData
        write
    End Property

    Property Get get_TX_CHANNEL_TESTMODE
        get_TX_CHANNEL_TESTMODE = read_TX_CHANNEL_TESTMODE_value
    End Property

    Property Let set_TX_CHANNEL_TESTMODE(aData)
        write_TX_CHANNEL_TESTMODE_value = aData
        flag_TX_CHANNEL_TESTMODE        = &H1
    End Property

    Property Get read_TX_CHANNEL_TESTMODE
        read
        read_TX_CHANNEL_TESTMODE = read_TX_CHANNEL_TESTMODE_value
    End Property

    Property Let write_TX_CHANNEL_TESTMODE(aData)
        set_TX_CHANNEL_TESTMODE = aData
        write
    End Property

    Property Get get_DISABLE_TX_IN_PCS_LPBK
        get_DISABLE_TX_IN_PCS_LPBK = read_DISABLE_TX_IN_PCS_LPBK_value
    End Property

    Property Let set_DISABLE_TX_IN_PCS_LPBK(aData)
        write_DISABLE_TX_IN_PCS_LPBK_value = aData
        flag_DISABLE_TX_IN_PCS_LPBK        = &H1
    End Property

    Property Get read_DISABLE_TX_IN_PCS_LPBK
        read
        read_DISABLE_TX_IN_PCS_LPBK = read_DISABLE_TX_IN_PCS_LPBK_value
    End Property

    Property Let write_DISABLE_TX_IN_PCS_LPBK(aData)
        set_DISABLE_TX_IN_PCS_LPBK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_CHANNEL_TEMPLATE_MODE_value = rightShift(data_low, 4) and &H1
        read_TX_CHANNEL_TESTMODE_ANA_value = rightShift(data_low, 3) and &H1
        read_TX_CHANNEL_TESTMODE_value = rightShift(data_low, 2) and &H1
        DISABLE_TX_IN_PCS_LPBK_mask = &H1
        if data_low > LONG_MAX then
            if DISABLE_TX_IN_PCS_LPBK_mask = mask then
                read_DISABLE_TX_IN_PCS_LPBK_value = data_low
            else
                read_DISABLE_TX_IN_PCS_LPBK_value = (data_low - H8000_0000) and DISABLE_TX_IN_PCS_LPBK_mask
            end If
        else
            read_DISABLE_TX_IN_PCS_LPBK_value = data_low and DISABLE_TX_IN_PCS_LPBK_mask
        end If

    End Sub

    Sub write
        If flag_TX_CHANNEL_TEMPLATE_MODE = &H0 or flag_TX_CHANNEL_TESTMODE_ANA = &H0 or flag_TX_CHANNEL_TESTMODE = &H0 or flag_DISABLE_TX_IN_PCS_LPBK = &H0 Then read
        If flag_TX_CHANNEL_TEMPLATE_MODE = &H0 Then write_TX_CHANNEL_TEMPLATE_MODE_value = get_TX_CHANNEL_TEMPLATE_MODE
        If flag_TX_CHANNEL_TESTMODE_ANA = &H0 Then write_TX_CHANNEL_TESTMODE_ANA_value = get_TX_CHANNEL_TESTMODE_ANA
        If flag_TX_CHANNEL_TESTMODE = &H0 Then write_TX_CHANNEL_TESTMODE_value = get_TX_CHANNEL_TESTMODE
        If flag_DISABLE_TX_IN_PCS_LPBK = &H0 Then write_DISABLE_TX_IN_PCS_LPBK_value = get_DISABLE_TX_IN_PCS_LPBK

        regValue = leftShift((write_TX_CHANNEL_TEMPLATE_MODE_value and &H1), 4) + leftShift((write_TX_CHANNEL_TESTMODE_ANA_value and &H1), 3) + leftShift((write_TX_CHANNEL_TESTMODE_value and &H1), 2) + leftShift((write_DISABLE_TX_IN_PCS_LPBK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_CHANNEL_TEMPLATE_MODE_value = rightShift(data_low, 4) and &H1
        read_TX_CHANNEL_TESTMODE_ANA_value = rightShift(data_low, 3) and &H1
        read_TX_CHANNEL_TESTMODE_value = rightShift(data_low, 2) and &H1
        DISABLE_TX_IN_PCS_LPBK_mask = &H1
        if data_low > LONG_MAX then
            if DISABLE_TX_IN_PCS_LPBK_mask = mask then
                read_DISABLE_TX_IN_PCS_LPBK_value = data_low
            else
                read_DISABLE_TX_IN_PCS_LPBK_value = (data_low - H8000_0000) and DISABLE_TX_IN_PCS_LPBK_mask
            end If
        else
            read_DISABLE_TX_IN_PCS_LPBK_value = data_low and DISABLE_TX_IN_PCS_LPBK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_CHANNEL_TEMPLATE_MODE_value = &H0
        flag_TX_CHANNEL_TEMPLATE_MODE        = &H0
        write_TX_CHANNEL_TESTMODE_ANA_value = &H0
        flag_TX_CHANNEL_TESTMODE_ANA        = &H0
        write_TX_CHANNEL_TESTMODE_value = &H0
        flag_TX_CHANNEL_TESTMODE        = &H0
        write_DISABLE_TX_IN_PCS_LPBK_value = &H0
        flag_DISABLE_TX_IN_PCS_LPBK        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_2                             [14:10]          get_TEMPLATE_CYC_2
''                                                             set_TEMPLATE_CYC_2
''                                                             read_TEMPLATE_CYC_2
''                                                             write_TEMPLATE_CYC_2
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_1                             [9:5]            get_TEMPLATE_CYC_1
''                                                             set_TEMPLATE_CYC_1
''                                                             read_TEMPLATE_CYC_1
''                                                             write_TEMPLATE_CYC_1
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_0                             [4:0]            get_TEMPLATE_CYC_0
''                                                             set_TEMPLATE_CYC_0
''                                                             read_TEMPLATE_CYC_0
''                                                             write_TEMPLATE_CYC_0
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_a
    Private write_TEMPLATE_CYC_2_value
    Private read_TEMPLATE_CYC_2_value
    Private flag_TEMPLATE_CYC_2
    Private write_TEMPLATE_CYC_1_value
    Private read_TEMPLATE_CYC_1_value
    Private flag_TEMPLATE_CYC_1
    Private write_TEMPLATE_CYC_0_value
    Private read_TEMPLATE_CYC_0_value
    Private flag_TEMPLATE_CYC_0

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

    Property Get get_TEMPLATE_CYC_2
        get_TEMPLATE_CYC_2 = read_TEMPLATE_CYC_2_value
    End Property

    Property Let set_TEMPLATE_CYC_2(aData)
        write_TEMPLATE_CYC_2_value = aData
        flag_TEMPLATE_CYC_2        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_2
        read
        read_TEMPLATE_CYC_2 = read_TEMPLATE_CYC_2_value
    End Property

    Property Let write_TEMPLATE_CYC_2(aData)
        set_TEMPLATE_CYC_2 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_1
        get_TEMPLATE_CYC_1 = read_TEMPLATE_CYC_1_value
    End Property

    Property Let set_TEMPLATE_CYC_1(aData)
        write_TEMPLATE_CYC_1_value = aData
        flag_TEMPLATE_CYC_1        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_1
        read
        read_TEMPLATE_CYC_1 = read_TEMPLATE_CYC_1_value
    End Property

    Property Let write_TEMPLATE_CYC_1(aData)
        set_TEMPLATE_CYC_1 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_0
        get_TEMPLATE_CYC_0 = read_TEMPLATE_CYC_0_value
    End Property

    Property Let set_TEMPLATE_CYC_0(aData)
        write_TEMPLATE_CYC_0_value = aData
        flag_TEMPLATE_CYC_0        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_0
        read
        read_TEMPLATE_CYC_0 = read_TEMPLATE_CYC_0_value
    End Property

    Property Let write_TEMPLATE_CYC_0(aData)
        set_TEMPLATE_CYC_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_2_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_1_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_0_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_0_mask = mask then
                read_TEMPLATE_CYC_0_value = data_low
            else
                read_TEMPLATE_CYC_0_value = (data_low - H8000_0000) and TEMPLATE_CYC_0_mask
            end If
        else
            read_TEMPLATE_CYC_0_value = data_low and TEMPLATE_CYC_0_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_2 = &H0 or flag_TEMPLATE_CYC_1 = &H0 or flag_TEMPLATE_CYC_0 = &H0 Then read
        If flag_TEMPLATE_CYC_2 = &H0 Then write_TEMPLATE_CYC_2_value = get_TEMPLATE_CYC_2
        If flag_TEMPLATE_CYC_1 = &H0 Then write_TEMPLATE_CYC_1_value = get_TEMPLATE_CYC_1
        If flag_TEMPLATE_CYC_0 = &H0 Then write_TEMPLATE_CYC_0_value = get_TEMPLATE_CYC_0

        regValue = leftShift((write_TEMPLATE_CYC_2_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_1_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_0_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_2_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_1_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_0_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_0_mask = mask then
                read_TEMPLATE_CYC_0_value = data_low
            else
                read_TEMPLATE_CYC_0_value = (data_low - H8000_0000) and TEMPLATE_CYC_0_mask
            end If
        else
            read_TEMPLATE_CYC_0_value = data_low and TEMPLATE_CYC_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_2_value = &H0
        flag_TEMPLATE_CYC_2        = &H0
        write_TEMPLATE_CYC_1_value = &H0
        flag_TEMPLATE_CYC_1        = &H0
        write_TEMPLATE_CYC_0_value = &H0
        flag_TEMPLATE_CYC_0        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_5                             [14:10]          get_TEMPLATE_CYC_5
''                                                             set_TEMPLATE_CYC_5
''                                                             read_TEMPLATE_CYC_5
''                                                             write_TEMPLATE_CYC_5
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_4                             [9:5]            get_TEMPLATE_CYC_4
''                                                             set_TEMPLATE_CYC_4
''                                                             read_TEMPLATE_CYC_4
''                                                             write_TEMPLATE_CYC_4
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_3                             [4:0]            get_TEMPLATE_CYC_3
''                                                             set_TEMPLATE_CYC_3
''                                                             read_TEMPLATE_CYC_3
''                                                             write_TEMPLATE_CYC_3
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_b
    Private write_TEMPLATE_CYC_5_value
    Private read_TEMPLATE_CYC_5_value
    Private flag_TEMPLATE_CYC_5
    Private write_TEMPLATE_CYC_4_value
    Private read_TEMPLATE_CYC_4_value
    Private flag_TEMPLATE_CYC_4
    Private write_TEMPLATE_CYC_3_value
    Private read_TEMPLATE_CYC_3_value
    Private flag_TEMPLATE_CYC_3

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

    Property Get get_TEMPLATE_CYC_5
        get_TEMPLATE_CYC_5 = read_TEMPLATE_CYC_5_value
    End Property

    Property Let set_TEMPLATE_CYC_5(aData)
        write_TEMPLATE_CYC_5_value = aData
        flag_TEMPLATE_CYC_5        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_5
        read
        read_TEMPLATE_CYC_5 = read_TEMPLATE_CYC_5_value
    End Property

    Property Let write_TEMPLATE_CYC_5(aData)
        set_TEMPLATE_CYC_5 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_4
        get_TEMPLATE_CYC_4 = read_TEMPLATE_CYC_4_value
    End Property

    Property Let set_TEMPLATE_CYC_4(aData)
        write_TEMPLATE_CYC_4_value = aData
        flag_TEMPLATE_CYC_4        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_4
        read
        read_TEMPLATE_CYC_4 = read_TEMPLATE_CYC_4_value
    End Property

    Property Let write_TEMPLATE_CYC_4(aData)
        set_TEMPLATE_CYC_4 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_3
        get_TEMPLATE_CYC_3 = read_TEMPLATE_CYC_3_value
    End Property

    Property Let set_TEMPLATE_CYC_3(aData)
        write_TEMPLATE_CYC_3_value = aData
        flag_TEMPLATE_CYC_3        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_3
        read
        read_TEMPLATE_CYC_3 = read_TEMPLATE_CYC_3_value
    End Property

    Property Let write_TEMPLATE_CYC_3(aData)
        set_TEMPLATE_CYC_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_5_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_4_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_3_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_3_mask = mask then
                read_TEMPLATE_CYC_3_value = data_low
            else
                read_TEMPLATE_CYC_3_value = (data_low - H8000_0000) and TEMPLATE_CYC_3_mask
            end If
        else
            read_TEMPLATE_CYC_3_value = data_low and TEMPLATE_CYC_3_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_5 = &H0 or flag_TEMPLATE_CYC_4 = &H0 or flag_TEMPLATE_CYC_3 = &H0 Then read
        If flag_TEMPLATE_CYC_5 = &H0 Then write_TEMPLATE_CYC_5_value = get_TEMPLATE_CYC_5
        If flag_TEMPLATE_CYC_4 = &H0 Then write_TEMPLATE_CYC_4_value = get_TEMPLATE_CYC_4
        If flag_TEMPLATE_CYC_3 = &H0 Then write_TEMPLATE_CYC_3_value = get_TEMPLATE_CYC_3

        regValue = leftShift((write_TEMPLATE_CYC_5_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_4_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_3_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_5_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_4_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_3_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_3_mask = mask then
                read_TEMPLATE_CYC_3_value = data_low
            else
                read_TEMPLATE_CYC_3_value = (data_low - H8000_0000) and TEMPLATE_CYC_3_mask
            end If
        else
            read_TEMPLATE_CYC_3_value = data_low and TEMPLATE_CYC_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_5_value = &H0
        flag_TEMPLATE_CYC_5        = &H0
        write_TEMPLATE_CYC_4_value = &H0
        flag_TEMPLATE_CYC_4        = &H0
        write_TEMPLATE_CYC_3_value = &H0
        flag_TEMPLATE_CYC_3        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_8                             [14:10]          get_TEMPLATE_CYC_8
''                                                             set_TEMPLATE_CYC_8
''                                                             read_TEMPLATE_CYC_8
''                                                             write_TEMPLATE_CYC_8
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_7                             [9:5]            get_TEMPLATE_CYC_7
''                                                             set_TEMPLATE_CYC_7
''                                                             read_TEMPLATE_CYC_7
''                                                             write_TEMPLATE_CYC_7
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_6                             [4:0]            get_TEMPLATE_CYC_6
''                                                             set_TEMPLATE_CYC_6
''                                                             read_TEMPLATE_CYC_6
''                                                             write_TEMPLATE_CYC_6
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_c
    Private write_TEMPLATE_CYC_8_value
    Private read_TEMPLATE_CYC_8_value
    Private flag_TEMPLATE_CYC_8
    Private write_TEMPLATE_CYC_7_value
    Private read_TEMPLATE_CYC_7_value
    Private flag_TEMPLATE_CYC_7
    Private write_TEMPLATE_CYC_6_value
    Private read_TEMPLATE_CYC_6_value
    Private flag_TEMPLATE_CYC_6

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

    Property Get get_TEMPLATE_CYC_8
        get_TEMPLATE_CYC_8 = read_TEMPLATE_CYC_8_value
    End Property

    Property Let set_TEMPLATE_CYC_8(aData)
        write_TEMPLATE_CYC_8_value = aData
        flag_TEMPLATE_CYC_8        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_8
        read
        read_TEMPLATE_CYC_8 = read_TEMPLATE_CYC_8_value
    End Property

    Property Let write_TEMPLATE_CYC_8(aData)
        set_TEMPLATE_CYC_8 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_7
        get_TEMPLATE_CYC_7 = read_TEMPLATE_CYC_7_value
    End Property

    Property Let set_TEMPLATE_CYC_7(aData)
        write_TEMPLATE_CYC_7_value = aData
        flag_TEMPLATE_CYC_7        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_7
        read
        read_TEMPLATE_CYC_7 = read_TEMPLATE_CYC_7_value
    End Property

    Property Let write_TEMPLATE_CYC_7(aData)
        set_TEMPLATE_CYC_7 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_6
        get_TEMPLATE_CYC_6 = read_TEMPLATE_CYC_6_value
    End Property

    Property Let set_TEMPLATE_CYC_6(aData)
        write_TEMPLATE_CYC_6_value = aData
        flag_TEMPLATE_CYC_6        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_6
        read
        read_TEMPLATE_CYC_6 = read_TEMPLATE_CYC_6_value
    End Property

    Property Let write_TEMPLATE_CYC_6(aData)
        set_TEMPLATE_CYC_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_8_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_7_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_6_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_6_mask = mask then
                read_TEMPLATE_CYC_6_value = data_low
            else
                read_TEMPLATE_CYC_6_value = (data_low - H8000_0000) and TEMPLATE_CYC_6_mask
            end If
        else
            read_TEMPLATE_CYC_6_value = data_low and TEMPLATE_CYC_6_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_8 = &H0 or flag_TEMPLATE_CYC_7 = &H0 or flag_TEMPLATE_CYC_6 = &H0 Then read
        If flag_TEMPLATE_CYC_8 = &H0 Then write_TEMPLATE_CYC_8_value = get_TEMPLATE_CYC_8
        If flag_TEMPLATE_CYC_7 = &H0 Then write_TEMPLATE_CYC_7_value = get_TEMPLATE_CYC_7
        If flag_TEMPLATE_CYC_6 = &H0 Then write_TEMPLATE_CYC_6_value = get_TEMPLATE_CYC_6

        regValue = leftShift((write_TEMPLATE_CYC_8_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_7_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_6_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_8_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_7_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_6_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_6_mask = mask then
                read_TEMPLATE_CYC_6_value = data_low
            else
                read_TEMPLATE_CYC_6_value = (data_low - H8000_0000) and TEMPLATE_CYC_6_mask
            end If
        else
            read_TEMPLATE_CYC_6_value = data_low and TEMPLATE_CYC_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_8_value = &H0
        flag_TEMPLATE_CYC_8        = &H0
        write_TEMPLATE_CYC_7_value = &H0
        flag_TEMPLATE_CYC_7        = &H0
        write_TEMPLATE_CYC_6_value = &H0
        flag_TEMPLATE_CYC_6        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_11                            [14:10]          get_TEMPLATE_CYC_11
''                                                             set_TEMPLATE_CYC_11
''                                                             read_TEMPLATE_CYC_11
''                                                             write_TEMPLATE_CYC_11
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_10                            [9:5]            get_TEMPLATE_CYC_10
''                                                             set_TEMPLATE_CYC_10
''                                                             read_TEMPLATE_CYC_10
''                                                             write_TEMPLATE_CYC_10
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_9                             [4:0]            get_TEMPLATE_CYC_9
''                                                             set_TEMPLATE_CYC_9
''                                                             read_TEMPLATE_CYC_9
''                                                             write_TEMPLATE_CYC_9
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_d
    Private write_TEMPLATE_CYC_11_value
    Private read_TEMPLATE_CYC_11_value
    Private flag_TEMPLATE_CYC_11
    Private write_TEMPLATE_CYC_10_value
    Private read_TEMPLATE_CYC_10_value
    Private flag_TEMPLATE_CYC_10
    Private write_TEMPLATE_CYC_9_value
    Private read_TEMPLATE_CYC_9_value
    Private flag_TEMPLATE_CYC_9

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

    Property Get get_TEMPLATE_CYC_11
        get_TEMPLATE_CYC_11 = read_TEMPLATE_CYC_11_value
    End Property

    Property Let set_TEMPLATE_CYC_11(aData)
        write_TEMPLATE_CYC_11_value = aData
        flag_TEMPLATE_CYC_11        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_11
        read
        read_TEMPLATE_CYC_11 = read_TEMPLATE_CYC_11_value
    End Property

    Property Let write_TEMPLATE_CYC_11(aData)
        set_TEMPLATE_CYC_11 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_10
        get_TEMPLATE_CYC_10 = read_TEMPLATE_CYC_10_value
    End Property

    Property Let set_TEMPLATE_CYC_10(aData)
        write_TEMPLATE_CYC_10_value = aData
        flag_TEMPLATE_CYC_10        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_10
        read
        read_TEMPLATE_CYC_10 = read_TEMPLATE_CYC_10_value
    End Property

    Property Let write_TEMPLATE_CYC_10(aData)
        set_TEMPLATE_CYC_10 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_9
        get_TEMPLATE_CYC_9 = read_TEMPLATE_CYC_9_value
    End Property

    Property Let set_TEMPLATE_CYC_9(aData)
        write_TEMPLATE_CYC_9_value = aData
        flag_TEMPLATE_CYC_9        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_9
        read
        read_TEMPLATE_CYC_9 = read_TEMPLATE_CYC_9_value
    End Property

    Property Let write_TEMPLATE_CYC_9(aData)
        set_TEMPLATE_CYC_9 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_11_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_10_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_9_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_9_mask = mask then
                read_TEMPLATE_CYC_9_value = data_low
            else
                read_TEMPLATE_CYC_9_value = (data_low - H8000_0000) and TEMPLATE_CYC_9_mask
            end If
        else
            read_TEMPLATE_CYC_9_value = data_low and TEMPLATE_CYC_9_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_11 = &H0 or flag_TEMPLATE_CYC_10 = &H0 or flag_TEMPLATE_CYC_9 = &H0 Then read
        If flag_TEMPLATE_CYC_11 = &H0 Then write_TEMPLATE_CYC_11_value = get_TEMPLATE_CYC_11
        If flag_TEMPLATE_CYC_10 = &H0 Then write_TEMPLATE_CYC_10_value = get_TEMPLATE_CYC_10
        If flag_TEMPLATE_CYC_9 = &H0 Then write_TEMPLATE_CYC_9_value = get_TEMPLATE_CYC_9

        regValue = leftShift((write_TEMPLATE_CYC_11_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_10_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_9_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_11_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_10_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_9_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_9_mask = mask then
                read_TEMPLATE_CYC_9_value = data_low
            else
                read_TEMPLATE_CYC_9_value = (data_low - H8000_0000) and TEMPLATE_CYC_9_mask
            end If
        else
            read_TEMPLATE_CYC_9_value = data_low and TEMPLATE_CYC_9_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_11_value = &H0
        flag_TEMPLATE_CYC_11        = &H0
        write_TEMPLATE_CYC_10_value = &H0
        flag_TEMPLATE_CYC_10        = &H0
        write_TEMPLATE_CYC_9_value = &H0
        flag_TEMPLATE_CYC_9        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_14                            [14:10]          get_TEMPLATE_CYC_14
''                                                             set_TEMPLATE_CYC_14
''                                                             read_TEMPLATE_CYC_14
''                                                             write_TEMPLATE_CYC_14
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_13                            [9:5]            get_TEMPLATE_CYC_13
''                                                             set_TEMPLATE_CYC_13
''                                                             read_TEMPLATE_CYC_13
''                                                             write_TEMPLATE_CYC_13
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_12                            [4:0]            get_TEMPLATE_CYC_12
''                                                             set_TEMPLATE_CYC_12
''                                                             read_TEMPLATE_CYC_12
''                                                             write_TEMPLATE_CYC_12
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_e
    Private write_TEMPLATE_CYC_14_value
    Private read_TEMPLATE_CYC_14_value
    Private flag_TEMPLATE_CYC_14
    Private write_TEMPLATE_CYC_13_value
    Private read_TEMPLATE_CYC_13_value
    Private flag_TEMPLATE_CYC_13
    Private write_TEMPLATE_CYC_12_value
    Private read_TEMPLATE_CYC_12_value
    Private flag_TEMPLATE_CYC_12

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

    Property Get get_TEMPLATE_CYC_14
        get_TEMPLATE_CYC_14 = read_TEMPLATE_CYC_14_value
    End Property

    Property Let set_TEMPLATE_CYC_14(aData)
        write_TEMPLATE_CYC_14_value = aData
        flag_TEMPLATE_CYC_14        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_14
        read
        read_TEMPLATE_CYC_14 = read_TEMPLATE_CYC_14_value
    End Property

    Property Let write_TEMPLATE_CYC_14(aData)
        set_TEMPLATE_CYC_14 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_13
        get_TEMPLATE_CYC_13 = read_TEMPLATE_CYC_13_value
    End Property

    Property Let set_TEMPLATE_CYC_13(aData)
        write_TEMPLATE_CYC_13_value = aData
        flag_TEMPLATE_CYC_13        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_13
        read
        read_TEMPLATE_CYC_13 = read_TEMPLATE_CYC_13_value
    End Property

    Property Let write_TEMPLATE_CYC_13(aData)
        set_TEMPLATE_CYC_13 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_12
        get_TEMPLATE_CYC_12 = read_TEMPLATE_CYC_12_value
    End Property

    Property Let set_TEMPLATE_CYC_12(aData)
        write_TEMPLATE_CYC_12_value = aData
        flag_TEMPLATE_CYC_12        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_12
        read
        read_TEMPLATE_CYC_12 = read_TEMPLATE_CYC_12_value
    End Property

    Property Let write_TEMPLATE_CYC_12(aData)
        set_TEMPLATE_CYC_12 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_14_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_13_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_12_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_12_mask = mask then
                read_TEMPLATE_CYC_12_value = data_low
            else
                read_TEMPLATE_CYC_12_value = (data_low - H8000_0000) and TEMPLATE_CYC_12_mask
            end If
        else
            read_TEMPLATE_CYC_12_value = data_low and TEMPLATE_CYC_12_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_14 = &H0 or flag_TEMPLATE_CYC_13 = &H0 or flag_TEMPLATE_CYC_12 = &H0 Then read
        If flag_TEMPLATE_CYC_14 = &H0 Then write_TEMPLATE_CYC_14_value = get_TEMPLATE_CYC_14
        If flag_TEMPLATE_CYC_13 = &H0 Then write_TEMPLATE_CYC_13_value = get_TEMPLATE_CYC_13
        If flag_TEMPLATE_CYC_12 = &H0 Then write_TEMPLATE_CYC_12_value = get_TEMPLATE_CYC_12

        regValue = leftShift((write_TEMPLATE_CYC_14_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_13_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_12_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_14_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_13_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_12_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_12_mask = mask then
                read_TEMPLATE_CYC_12_value = data_low
            else
                read_TEMPLATE_CYC_12_value = (data_low - H8000_0000) and TEMPLATE_CYC_12_mask
            end If
        else
            read_TEMPLATE_CYC_12_value = data_low and TEMPLATE_CYC_12_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_14_value = &H0
        flag_TEMPLATE_CYC_14        = &H0
        write_TEMPLATE_CYC_13_value = &H0
        flag_TEMPLATE_CYC_13        = &H0
        write_TEMPLATE_CYC_12_value = &H0
        flag_TEMPLATE_CYC_12        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_f
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_17                            [14:10]          get_TEMPLATE_CYC_17
''                                                             set_TEMPLATE_CYC_17
''                                                             read_TEMPLATE_CYC_17
''                                                             write_TEMPLATE_CYC_17
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_16                            [9:5]            get_TEMPLATE_CYC_16
''                                                             set_TEMPLATE_CYC_16
''                                                             read_TEMPLATE_CYC_16
''                                                             write_TEMPLATE_CYC_16
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_15                            [4:0]            get_TEMPLATE_CYC_15
''                                                             set_TEMPLATE_CYC_15
''                                                             read_TEMPLATE_CYC_15
''                                                             write_TEMPLATE_CYC_15
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_f
    Private write_TEMPLATE_CYC_17_value
    Private read_TEMPLATE_CYC_17_value
    Private flag_TEMPLATE_CYC_17
    Private write_TEMPLATE_CYC_16_value
    Private read_TEMPLATE_CYC_16_value
    Private flag_TEMPLATE_CYC_16
    Private write_TEMPLATE_CYC_15_value
    Private read_TEMPLATE_CYC_15_value
    Private flag_TEMPLATE_CYC_15

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

    Property Get get_TEMPLATE_CYC_17
        get_TEMPLATE_CYC_17 = read_TEMPLATE_CYC_17_value
    End Property

    Property Let set_TEMPLATE_CYC_17(aData)
        write_TEMPLATE_CYC_17_value = aData
        flag_TEMPLATE_CYC_17        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_17
        read
        read_TEMPLATE_CYC_17 = read_TEMPLATE_CYC_17_value
    End Property

    Property Let write_TEMPLATE_CYC_17(aData)
        set_TEMPLATE_CYC_17 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_16
        get_TEMPLATE_CYC_16 = read_TEMPLATE_CYC_16_value
    End Property

    Property Let set_TEMPLATE_CYC_16(aData)
        write_TEMPLATE_CYC_16_value = aData
        flag_TEMPLATE_CYC_16        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_16
        read
        read_TEMPLATE_CYC_16 = read_TEMPLATE_CYC_16_value
    End Property

    Property Let write_TEMPLATE_CYC_16(aData)
        set_TEMPLATE_CYC_16 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_15
        get_TEMPLATE_CYC_15 = read_TEMPLATE_CYC_15_value
    End Property

    Property Let set_TEMPLATE_CYC_15(aData)
        write_TEMPLATE_CYC_15_value = aData
        flag_TEMPLATE_CYC_15        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_15
        read
        read_TEMPLATE_CYC_15 = read_TEMPLATE_CYC_15_value
    End Property

    Property Let write_TEMPLATE_CYC_15(aData)
        set_TEMPLATE_CYC_15 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_17_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_16_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_15_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_15_mask = mask then
                read_TEMPLATE_CYC_15_value = data_low
            else
                read_TEMPLATE_CYC_15_value = (data_low - H8000_0000) and TEMPLATE_CYC_15_mask
            end If
        else
            read_TEMPLATE_CYC_15_value = data_low and TEMPLATE_CYC_15_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_17 = &H0 or flag_TEMPLATE_CYC_16 = &H0 or flag_TEMPLATE_CYC_15 = &H0 Then read
        If flag_TEMPLATE_CYC_17 = &H0 Then write_TEMPLATE_CYC_17_value = get_TEMPLATE_CYC_17
        If flag_TEMPLATE_CYC_16 = &H0 Then write_TEMPLATE_CYC_16_value = get_TEMPLATE_CYC_16
        If flag_TEMPLATE_CYC_15 = &H0 Then write_TEMPLATE_CYC_15_value = get_TEMPLATE_CYC_15

        regValue = leftShift((write_TEMPLATE_CYC_17_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_16_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_15_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_17_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_16_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_15_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_15_mask = mask then
                read_TEMPLATE_CYC_15_value = data_low
            else
                read_TEMPLATE_CYC_15_value = (data_low - H8000_0000) and TEMPLATE_CYC_15_mask
            end If
        else
            read_TEMPLATE_CYC_15_value = data_low and TEMPLATE_CYC_15_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_17_value = &H0
        flag_TEMPLATE_CYC_17        = &H0
        write_TEMPLATE_CYC_16_value = &H0
        flag_TEMPLATE_CYC_16        = &H0
        write_TEMPLATE_CYC_15_value = &H0
        flag_TEMPLATE_CYC_15        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_g
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_20                            [14:10]          get_TEMPLATE_CYC_20
''                                                             set_TEMPLATE_CYC_20
''                                                             read_TEMPLATE_CYC_20
''                                                             write_TEMPLATE_CYC_20
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_19                            [9:5]            get_TEMPLATE_CYC_19
''                                                             set_TEMPLATE_CYC_19
''                                                             read_TEMPLATE_CYC_19
''                                                             write_TEMPLATE_CYC_19
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_18                            [4:0]            get_TEMPLATE_CYC_18
''                                                             set_TEMPLATE_CYC_18
''                                                             read_TEMPLATE_CYC_18
''                                                             write_TEMPLATE_CYC_18
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_g
    Private write_TEMPLATE_CYC_20_value
    Private read_TEMPLATE_CYC_20_value
    Private flag_TEMPLATE_CYC_20
    Private write_TEMPLATE_CYC_19_value
    Private read_TEMPLATE_CYC_19_value
    Private flag_TEMPLATE_CYC_19
    Private write_TEMPLATE_CYC_18_value
    Private read_TEMPLATE_CYC_18_value
    Private flag_TEMPLATE_CYC_18

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

    Property Get get_TEMPLATE_CYC_20
        get_TEMPLATE_CYC_20 = read_TEMPLATE_CYC_20_value
    End Property

    Property Let set_TEMPLATE_CYC_20(aData)
        write_TEMPLATE_CYC_20_value = aData
        flag_TEMPLATE_CYC_20        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_20
        read
        read_TEMPLATE_CYC_20 = read_TEMPLATE_CYC_20_value
    End Property

    Property Let write_TEMPLATE_CYC_20(aData)
        set_TEMPLATE_CYC_20 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_19
        get_TEMPLATE_CYC_19 = read_TEMPLATE_CYC_19_value
    End Property

    Property Let set_TEMPLATE_CYC_19(aData)
        write_TEMPLATE_CYC_19_value = aData
        flag_TEMPLATE_CYC_19        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_19
        read
        read_TEMPLATE_CYC_19 = read_TEMPLATE_CYC_19_value
    End Property

    Property Let write_TEMPLATE_CYC_19(aData)
        set_TEMPLATE_CYC_19 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_18
        get_TEMPLATE_CYC_18 = read_TEMPLATE_CYC_18_value
    End Property

    Property Let set_TEMPLATE_CYC_18(aData)
        write_TEMPLATE_CYC_18_value = aData
        flag_TEMPLATE_CYC_18        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_18
        read
        read_TEMPLATE_CYC_18 = read_TEMPLATE_CYC_18_value
    End Property

    Property Let write_TEMPLATE_CYC_18(aData)
        set_TEMPLATE_CYC_18 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_20_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_19_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_18_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_18_mask = mask then
                read_TEMPLATE_CYC_18_value = data_low
            else
                read_TEMPLATE_CYC_18_value = (data_low - H8000_0000) and TEMPLATE_CYC_18_mask
            end If
        else
            read_TEMPLATE_CYC_18_value = data_low and TEMPLATE_CYC_18_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_20 = &H0 or flag_TEMPLATE_CYC_19 = &H0 or flag_TEMPLATE_CYC_18 = &H0 Then read
        If flag_TEMPLATE_CYC_20 = &H0 Then write_TEMPLATE_CYC_20_value = get_TEMPLATE_CYC_20
        If flag_TEMPLATE_CYC_19 = &H0 Then write_TEMPLATE_CYC_19_value = get_TEMPLATE_CYC_19
        If flag_TEMPLATE_CYC_18 = &H0 Then write_TEMPLATE_CYC_18_value = get_TEMPLATE_CYC_18

        regValue = leftShift((write_TEMPLATE_CYC_20_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_19_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_18_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_20_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_19_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_18_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_18_mask = mask then
                read_TEMPLATE_CYC_18_value = data_low
            else
                read_TEMPLATE_CYC_18_value = (data_low - H8000_0000) and TEMPLATE_CYC_18_mask
            end If
        else
            read_TEMPLATE_CYC_18_value = data_low and TEMPLATE_CYC_18_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_20_value = &H0
        flag_TEMPLATE_CYC_20        = &H0
        write_TEMPLATE_CYC_19_value = &H0
        flag_TEMPLATE_CYC_19        = &H0
        write_TEMPLATE_CYC_18_value = &H0
        flag_TEMPLATE_CYC_18        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_h
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_23                            [14:10]          get_TEMPLATE_CYC_23
''                                                             set_TEMPLATE_CYC_23
''                                                             read_TEMPLATE_CYC_23
''                                                             write_TEMPLATE_CYC_23
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_22                            [9:5]            get_TEMPLATE_CYC_22
''                                                             set_TEMPLATE_CYC_22
''                                                             read_TEMPLATE_CYC_22
''                                                             write_TEMPLATE_CYC_22
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_21                            [4:0]            get_TEMPLATE_CYC_21
''                                                             set_TEMPLATE_CYC_21
''                                                             read_TEMPLATE_CYC_21
''                                                             write_TEMPLATE_CYC_21
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_h
    Private write_TEMPLATE_CYC_23_value
    Private read_TEMPLATE_CYC_23_value
    Private flag_TEMPLATE_CYC_23
    Private write_TEMPLATE_CYC_22_value
    Private read_TEMPLATE_CYC_22_value
    Private flag_TEMPLATE_CYC_22
    Private write_TEMPLATE_CYC_21_value
    Private read_TEMPLATE_CYC_21_value
    Private flag_TEMPLATE_CYC_21

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

    Property Get get_TEMPLATE_CYC_23
        get_TEMPLATE_CYC_23 = read_TEMPLATE_CYC_23_value
    End Property

    Property Let set_TEMPLATE_CYC_23(aData)
        write_TEMPLATE_CYC_23_value = aData
        flag_TEMPLATE_CYC_23        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_23
        read
        read_TEMPLATE_CYC_23 = read_TEMPLATE_CYC_23_value
    End Property

    Property Let write_TEMPLATE_CYC_23(aData)
        set_TEMPLATE_CYC_23 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_22
        get_TEMPLATE_CYC_22 = read_TEMPLATE_CYC_22_value
    End Property

    Property Let set_TEMPLATE_CYC_22(aData)
        write_TEMPLATE_CYC_22_value = aData
        flag_TEMPLATE_CYC_22        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_22
        read
        read_TEMPLATE_CYC_22 = read_TEMPLATE_CYC_22_value
    End Property

    Property Let write_TEMPLATE_CYC_22(aData)
        set_TEMPLATE_CYC_22 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_21
        get_TEMPLATE_CYC_21 = read_TEMPLATE_CYC_21_value
    End Property

    Property Let set_TEMPLATE_CYC_21(aData)
        write_TEMPLATE_CYC_21_value = aData
        flag_TEMPLATE_CYC_21        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_21
        read
        read_TEMPLATE_CYC_21 = read_TEMPLATE_CYC_21_value
    End Property

    Property Let write_TEMPLATE_CYC_21(aData)
        set_TEMPLATE_CYC_21 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_23_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_22_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_21_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_21_mask = mask then
                read_TEMPLATE_CYC_21_value = data_low
            else
                read_TEMPLATE_CYC_21_value = (data_low - H8000_0000) and TEMPLATE_CYC_21_mask
            end If
        else
            read_TEMPLATE_CYC_21_value = data_low and TEMPLATE_CYC_21_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_23 = &H0 or flag_TEMPLATE_CYC_22 = &H0 or flag_TEMPLATE_CYC_21 = &H0 Then read
        If flag_TEMPLATE_CYC_23 = &H0 Then write_TEMPLATE_CYC_23_value = get_TEMPLATE_CYC_23
        If flag_TEMPLATE_CYC_22 = &H0 Then write_TEMPLATE_CYC_22_value = get_TEMPLATE_CYC_22
        If flag_TEMPLATE_CYC_21 = &H0 Then write_TEMPLATE_CYC_21_value = get_TEMPLATE_CYC_21

        regValue = leftShift((write_TEMPLATE_CYC_23_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_22_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_21_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_23_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_22_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_21_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_21_mask = mask then
                read_TEMPLATE_CYC_21_value = data_low
            else
                read_TEMPLATE_CYC_21_value = (data_low - H8000_0000) and TEMPLATE_CYC_21_mask
            end If
        else
            read_TEMPLATE_CYC_21_value = data_low and TEMPLATE_CYC_21_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_23_value = &H0
        flag_TEMPLATE_CYC_23        = &H0
        write_TEMPLATE_CYC_22_value = &H0
        flag_TEMPLATE_CYC_22        = &H0
        write_TEMPLATE_CYC_21_value = &H0
        flag_TEMPLATE_CYC_21        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_i
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_26                            [14:10]          get_TEMPLATE_CYC_26
''                                                             set_TEMPLATE_CYC_26
''                                                             read_TEMPLATE_CYC_26
''                                                             write_TEMPLATE_CYC_26
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_25                            [9:5]            get_TEMPLATE_CYC_25
''                                                             set_TEMPLATE_CYC_25
''                                                             read_TEMPLATE_CYC_25
''                                                             write_TEMPLATE_CYC_25
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_24                            [4:0]            get_TEMPLATE_CYC_24
''                                                             set_TEMPLATE_CYC_24
''                                                             read_TEMPLATE_CYC_24
''                                                             write_TEMPLATE_CYC_24
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_i
    Private write_TEMPLATE_CYC_26_value
    Private read_TEMPLATE_CYC_26_value
    Private flag_TEMPLATE_CYC_26
    Private write_TEMPLATE_CYC_25_value
    Private read_TEMPLATE_CYC_25_value
    Private flag_TEMPLATE_CYC_25
    Private write_TEMPLATE_CYC_24_value
    Private read_TEMPLATE_CYC_24_value
    Private flag_TEMPLATE_CYC_24

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

    Property Get get_TEMPLATE_CYC_26
        get_TEMPLATE_CYC_26 = read_TEMPLATE_CYC_26_value
    End Property

    Property Let set_TEMPLATE_CYC_26(aData)
        write_TEMPLATE_CYC_26_value = aData
        flag_TEMPLATE_CYC_26        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_26
        read
        read_TEMPLATE_CYC_26 = read_TEMPLATE_CYC_26_value
    End Property

    Property Let write_TEMPLATE_CYC_26(aData)
        set_TEMPLATE_CYC_26 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_25
        get_TEMPLATE_CYC_25 = read_TEMPLATE_CYC_25_value
    End Property

    Property Let set_TEMPLATE_CYC_25(aData)
        write_TEMPLATE_CYC_25_value = aData
        flag_TEMPLATE_CYC_25        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_25
        read
        read_TEMPLATE_CYC_25 = read_TEMPLATE_CYC_25_value
    End Property

    Property Let write_TEMPLATE_CYC_25(aData)
        set_TEMPLATE_CYC_25 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_24
        get_TEMPLATE_CYC_24 = read_TEMPLATE_CYC_24_value
    End Property

    Property Let set_TEMPLATE_CYC_24(aData)
        write_TEMPLATE_CYC_24_value = aData
        flag_TEMPLATE_CYC_24        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_24
        read
        read_TEMPLATE_CYC_24 = read_TEMPLATE_CYC_24_value
    End Property

    Property Let write_TEMPLATE_CYC_24(aData)
        set_TEMPLATE_CYC_24 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_26_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_25_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_24_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_24_mask = mask then
                read_TEMPLATE_CYC_24_value = data_low
            else
                read_TEMPLATE_CYC_24_value = (data_low - H8000_0000) and TEMPLATE_CYC_24_mask
            end If
        else
            read_TEMPLATE_CYC_24_value = data_low and TEMPLATE_CYC_24_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_26 = &H0 or flag_TEMPLATE_CYC_25 = &H0 or flag_TEMPLATE_CYC_24 = &H0 Then read
        If flag_TEMPLATE_CYC_26 = &H0 Then write_TEMPLATE_CYC_26_value = get_TEMPLATE_CYC_26
        If flag_TEMPLATE_CYC_25 = &H0 Then write_TEMPLATE_CYC_25_value = get_TEMPLATE_CYC_25
        If flag_TEMPLATE_CYC_24 = &H0 Then write_TEMPLATE_CYC_24_value = get_TEMPLATE_CYC_24

        regValue = leftShift((write_TEMPLATE_CYC_26_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_25_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_24_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_26_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_25_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_24_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_24_mask = mask then
                read_TEMPLATE_CYC_24_value = data_low
            else
                read_TEMPLATE_CYC_24_value = (data_low - H8000_0000) and TEMPLATE_CYC_24_mask
            end If
        else
            read_TEMPLATE_CYC_24_value = data_low and TEMPLATE_CYC_24_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_26_value = &H0
        flag_TEMPLATE_CYC_26        = &H0
        write_TEMPLATE_CYC_25_value = &H0
        flag_TEMPLATE_CYC_25        = &H0
        write_TEMPLATE_CYC_24_value = &H0
        flag_TEMPLATE_CYC_24        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_j
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_29                            [14:10]          get_TEMPLATE_CYC_29
''                                                             set_TEMPLATE_CYC_29
''                                                             read_TEMPLATE_CYC_29
''                                                             write_TEMPLATE_CYC_29
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_28                            [9:5]            get_TEMPLATE_CYC_28
''                                                             set_TEMPLATE_CYC_28
''                                                             read_TEMPLATE_CYC_28
''                                                             write_TEMPLATE_CYC_28
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_27                            [4:0]            get_TEMPLATE_CYC_27
''                                                             set_TEMPLATE_CYC_27
''                                                             read_TEMPLATE_CYC_27
''                                                             write_TEMPLATE_CYC_27
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_j
    Private write_TEMPLATE_CYC_29_value
    Private read_TEMPLATE_CYC_29_value
    Private flag_TEMPLATE_CYC_29
    Private write_TEMPLATE_CYC_28_value
    Private read_TEMPLATE_CYC_28_value
    Private flag_TEMPLATE_CYC_28
    Private write_TEMPLATE_CYC_27_value
    Private read_TEMPLATE_CYC_27_value
    Private flag_TEMPLATE_CYC_27

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

    Property Get get_TEMPLATE_CYC_29
        get_TEMPLATE_CYC_29 = read_TEMPLATE_CYC_29_value
    End Property

    Property Let set_TEMPLATE_CYC_29(aData)
        write_TEMPLATE_CYC_29_value = aData
        flag_TEMPLATE_CYC_29        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_29
        read
        read_TEMPLATE_CYC_29 = read_TEMPLATE_CYC_29_value
    End Property

    Property Let write_TEMPLATE_CYC_29(aData)
        set_TEMPLATE_CYC_29 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_28
        get_TEMPLATE_CYC_28 = read_TEMPLATE_CYC_28_value
    End Property

    Property Let set_TEMPLATE_CYC_28(aData)
        write_TEMPLATE_CYC_28_value = aData
        flag_TEMPLATE_CYC_28        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_28
        read
        read_TEMPLATE_CYC_28 = read_TEMPLATE_CYC_28_value
    End Property

    Property Let write_TEMPLATE_CYC_28(aData)
        set_TEMPLATE_CYC_28 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_27
        get_TEMPLATE_CYC_27 = read_TEMPLATE_CYC_27_value
    End Property

    Property Let set_TEMPLATE_CYC_27(aData)
        write_TEMPLATE_CYC_27_value = aData
        flag_TEMPLATE_CYC_27        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_27
        read
        read_TEMPLATE_CYC_27 = read_TEMPLATE_CYC_27_value
    End Property

    Property Let write_TEMPLATE_CYC_27(aData)
        set_TEMPLATE_CYC_27 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_29_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_28_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_27_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_27_mask = mask then
                read_TEMPLATE_CYC_27_value = data_low
            else
                read_TEMPLATE_CYC_27_value = (data_low - H8000_0000) and TEMPLATE_CYC_27_mask
            end If
        else
            read_TEMPLATE_CYC_27_value = data_low and TEMPLATE_CYC_27_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_29 = &H0 or flag_TEMPLATE_CYC_28 = &H0 or flag_TEMPLATE_CYC_27 = &H0 Then read
        If flag_TEMPLATE_CYC_29 = &H0 Then write_TEMPLATE_CYC_29_value = get_TEMPLATE_CYC_29
        If flag_TEMPLATE_CYC_28 = &H0 Then write_TEMPLATE_CYC_28_value = get_TEMPLATE_CYC_28
        If flag_TEMPLATE_CYC_27 = &H0 Then write_TEMPLATE_CYC_27_value = get_TEMPLATE_CYC_27

        regValue = leftShift((write_TEMPLATE_CYC_29_value and &H1f), 10) + leftShift((write_TEMPLATE_CYC_28_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_27_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_29_value = rightShift(data_low, 10) and &H1f
        read_TEMPLATE_CYC_28_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_27_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_27_mask = mask then
                read_TEMPLATE_CYC_27_value = data_low
            else
                read_TEMPLATE_CYC_27_value = (data_low - H8000_0000) and TEMPLATE_CYC_27_mask
            end If
        else
            read_TEMPLATE_CYC_27_value = data_low and TEMPLATE_CYC_27_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_29_value = &H0
        flag_TEMPLATE_CYC_29        = &H0
        write_TEMPLATE_CYC_28_value = &H0
        flag_TEMPLATE_CYC_28        = &H0
        write_TEMPLATE_CYC_27_value = &H0
        flag_TEMPLATE_CYC_27        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_tx_channel_template_k
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_31                            [9:5]            get_TEMPLATE_CYC_31
''                                                             set_TEMPLATE_CYC_31
''                                                             read_TEMPLATE_CYC_31
''                                                             write_TEMPLATE_CYC_31
''---------------------------------------------------------------------------------
'' TEMPLATE_CYC_30                            [4:0]            get_TEMPLATE_CYC_30
''                                                             set_TEMPLATE_CYC_30
''                                                             read_TEMPLATE_CYC_30
''                                                             write_TEMPLATE_CYC_30
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_tx_channel_template_k
    Private write_TEMPLATE_CYC_31_value
    Private read_TEMPLATE_CYC_31_value
    Private flag_TEMPLATE_CYC_31
    Private write_TEMPLATE_CYC_30_value
    Private read_TEMPLATE_CYC_30_value
    Private flag_TEMPLATE_CYC_30

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

    Property Get get_TEMPLATE_CYC_31
        get_TEMPLATE_CYC_31 = read_TEMPLATE_CYC_31_value
    End Property

    Property Let set_TEMPLATE_CYC_31(aData)
        write_TEMPLATE_CYC_31_value = aData
        flag_TEMPLATE_CYC_31        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_31
        read
        read_TEMPLATE_CYC_31 = read_TEMPLATE_CYC_31_value
    End Property

    Property Let write_TEMPLATE_CYC_31(aData)
        set_TEMPLATE_CYC_31 = aData
        write
    End Property

    Property Get get_TEMPLATE_CYC_30
        get_TEMPLATE_CYC_30 = read_TEMPLATE_CYC_30_value
    End Property

    Property Let set_TEMPLATE_CYC_30(aData)
        write_TEMPLATE_CYC_30_value = aData
        flag_TEMPLATE_CYC_30        = &H1
    End Property

    Property Get read_TEMPLATE_CYC_30
        read
        read_TEMPLATE_CYC_30 = read_TEMPLATE_CYC_30_value
    End Property

    Property Let write_TEMPLATE_CYC_30(aData)
        set_TEMPLATE_CYC_30 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_31_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_30_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_30_mask = mask then
                read_TEMPLATE_CYC_30_value = data_low
            else
                read_TEMPLATE_CYC_30_value = (data_low - H8000_0000) and TEMPLATE_CYC_30_mask
            end If
        else
            read_TEMPLATE_CYC_30_value = data_low and TEMPLATE_CYC_30_mask
        end If

    End Sub

    Sub write
        If flag_TEMPLATE_CYC_31 = &H0 or flag_TEMPLATE_CYC_30 = &H0 Then read
        If flag_TEMPLATE_CYC_31 = &H0 Then write_TEMPLATE_CYC_31_value = get_TEMPLATE_CYC_31
        If flag_TEMPLATE_CYC_30 = &H0 Then write_TEMPLATE_CYC_30_value = get_TEMPLATE_CYC_30

        regValue = leftShift((write_TEMPLATE_CYC_31_value and &H1f), 5) + leftShift((write_TEMPLATE_CYC_30_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TEMPLATE_CYC_31_value = rightShift(data_low, 5) and &H1f
        TEMPLATE_CYC_30_mask = &H1f
        if data_low > LONG_MAX then
            if TEMPLATE_CYC_30_mask = mask then
                read_TEMPLATE_CYC_30_value = data_low
            else
                read_TEMPLATE_CYC_30_value = (data_low - H8000_0000) and TEMPLATE_CYC_30_mask
            end If
        else
            read_TEMPLATE_CYC_30_value = data_low and TEMPLATE_CYC_30_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TEMPLATE_CYC_31_value = &H0
        flag_TEMPLATE_CYC_31        = &H0
        write_TEMPLATE_CYC_30_value = &H0
        flag_TEMPLATE_CYC_30        = &H0
    End Sub
End Class


'' @REGISTER : TX_CHANNEL_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_END_ADDR                             [15:0]           get_SPARE_END_ADDR
''                                                             set_SPARE_END_ADDR
''                                                             read_SPARE_END_ADDR
''                                                             write_SPARE_END_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_TX_CHANNEL_spare_end_addr
    Private write_SPARE_END_ADDR_value
    Private read_SPARE_END_ADDR_value
    Private flag_SPARE_END_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_END_ADDR
        get_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let set_SPARE_END_ADDR(aData)
        write_SPARE_END_ADDR_value = aData
        flag_SPARE_END_ADDR        = &H1
    End Property

    Property Get read_SPARE_END_ADDR
        read
        read_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let write_SPARE_END_ADDR(aData)
        set_SPARE_END_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_END_ADDR = &H0 Then read
        If flag_SPARE_END_ADDR = &H0 Then write_SPARE_END_ADDR_value = get_SPARE_END_ADDR

        regValue = leftShift((write_SPARE_END_ADDR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_END_ADDR_value = &H0
        flag_SPARE_END_ADDR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class TX_CHANNEL_INSTANCE

    Public tx_channel_ctl_a
    Public tx_channel_ctl_b
    Public tx_channel_ctl_c
    Public tx_channel_template_a
    Public tx_channel_template_b
    Public tx_channel_template_c
    Public tx_channel_template_d
    Public tx_channel_template_e
    Public tx_channel_template_f
    Public tx_channel_template_g
    Public tx_channel_template_h
    Public tx_channel_template_i
    Public tx_channel_template_j
    Public tx_channel_template_k
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set tx_channel_ctl_a = (New REGISTER_TX_CHANNEL_tx_channel_ctl_a)(aBaseAddr, 16)
        Set tx_channel_ctl_b = (New REGISTER_TX_CHANNEL_tx_channel_ctl_b)(aBaseAddr, 16)
        Set tx_channel_ctl_c = (New REGISTER_TX_CHANNEL_tx_channel_ctl_c)(aBaseAddr, 16)
        Set tx_channel_template_a = (New REGISTER_TX_CHANNEL_tx_channel_template_a)(aBaseAddr, 16)
        Set tx_channel_template_b = (New REGISTER_TX_CHANNEL_tx_channel_template_b)(aBaseAddr, 16)
        Set tx_channel_template_c = (New REGISTER_TX_CHANNEL_tx_channel_template_c)(aBaseAddr, 16)
        Set tx_channel_template_d = (New REGISTER_TX_CHANNEL_tx_channel_template_d)(aBaseAddr, 16)
        Set tx_channel_template_e = (New REGISTER_TX_CHANNEL_tx_channel_template_e)(aBaseAddr, 16)
        Set tx_channel_template_f = (New REGISTER_TX_CHANNEL_tx_channel_template_f)(aBaseAddr, 16)
        Set tx_channel_template_g = (New REGISTER_TX_CHANNEL_tx_channel_template_g)(aBaseAddr, 16)
        Set tx_channel_template_h = (New REGISTER_TX_CHANNEL_tx_channel_template_h)(aBaseAddr, 16)
        Set tx_channel_template_i = (New REGISTER_TX_CHANNEL_tx_channel_template_i)(aBaseAddr, 16)
        Set tx_channel_template_j = (New REGISTER_TX_CHANNEL_tx_channel_template_j)(aBaseAddr, 16)
        Set tx_channel_template_k = (New REGISTER_TX_CHANNEL_tx_channel_template_k)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_TX_CHANNEL_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_CHANNEL = CreateObject("System.Collections.ArrayList")
TX_CHANNEL.Add ((New TX_CHANNEL_INSTANCE)(&H49032a00))


