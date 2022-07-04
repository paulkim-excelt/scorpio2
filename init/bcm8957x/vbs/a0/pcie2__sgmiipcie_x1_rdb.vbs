

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


'' @REGISTER : PCIE2__SGMIIPCIE_X1_debug_hook_ctrl_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' dbg_phy_tx_cmn_mode_disable                [3:3]            get_dbg_phy_tx_cmn_mode_disable
''                                                             set_dbg_phy_tx_cmn_mode_disable
''                                                             read_dbg_phy_tx_cmn_mode_disable
''                                                             write_dbg_phy_tx_cmn_mode_disable
''---------------------------------------------------------------------------------
'' dbg_phy_rx_eidle_disable                   [2:2]            get_dbg_phy_rx_eidle_disable
''                                                             set_dbg_phy_rx_eidle_disable
''                                                             read_dbg_phy_rx_eidle_disable
''                                                             write_dbg_phy_rx_eidle_disable
''---------------------------------------------------------------------------------
'' L1x_debug_loop_auto                        [1:1]            get_L1x_debug_loop_auto
''                                                             set_L1x_debug_loop_auto
''                                                             read_L1x_debug_loop_auto
''                                                             write_L1x_debug_loop_auto
''---------------------------------------------------------------------------------
'' L1x_debug_en                               [0:0]            get_L1x_debug_en
''                                                             set_L1x_debug_en
''                                                             read_L1x_debug_en
''                                                             write_L1x_debug_en
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_ctrl_0
    Private write_dbg_phy_tx_cmn_mode_disable_value
    Private read_dbg_phy_tx_cmn_mode_disable_value
    Private flag_dbg_phy_tx_cmn_mode_disable
    Private write_dbg_phy_rx_eidle_disable_value
    Private read_dbg_phy_rx_eidle_disable_value
    Private flag_dbg_phy_rx_eidle_disable
    Private write_L1x_debug_loop_auto_value
    Private read_L1x_debug_loop_auto_value
    Private flag_L1x_debug_loop_auto
    Private write_L1x_debug_en_value
    Private read_L1x_debug_en_value
    Private flag_L1x_debug_en

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

    Property Get get_dbg_phy_tx_cmn_mode_disable
        get_dbg_phy_tx_cmn_mode_disable = read_dbg_phy_tx_cmn_mode_disable_value
    End Property

    Property Let set_dbg_phy_tx_cmn_mode_disable(aData)
        write_dbg_phy_tx_cmn_mode_disable_value = aData
        flag_dbg_phy_tx_cmn_mode_disable        = &H1
    End Property

    Property Get read_dbg_phy_tx_cmn_mode_disable
        read
        read_dbg_phy_tx_cmn_mode_disable = read_dbg_phy_tx_cmn_mode_disable_value
    End Property

    Property Let write_dbg_phy_tx_cmn_mode_disable(aData)
        set_dbg_phy_tx_cmn_mode_disable = aData
        write
    End Property

    Property Get get_dbg_phy_rx_eidle_disable
        get_dbg_phy_rx_eidle_disable = read_dbg_phy_rx_eidle_disable_value
    End Property

    Property Let set_dbg_phy_rx_eidle_disable(aData)
        write_dbg_phy_rx_eidle_disable_value = aData
        flag_dbg_phy_rx_eidle_disable        = &H1
    End Property

    Property Get read_dbg_phy_rx_eidle_disable
        read
        read_dbg_phy_rx_eidle_disable = read_dbg_phy_rx_eidle_disable_value
    End Property

    Property Let write_dbg_phy_rx_eidle_disable(aData)
        set_dbg_phy_rx_eidle_disable = aData
        write
    End Property

    Property Get get_L1x_debug_loop_auto
        get_L1x_debug_loop_auto = read_L1x_debug_loop_auto_value
    End Property

    Property Let set_L1x_debug_loop_auto(aData)
        write_L1x_debug_loop_auto_value = aData
        flag_L1x_debug_loop_auto        = &H1
    End Property

    Property Get read_L1x_debug_loop_auto
        read
        read_L1x_debug_loop_auto = read_L1x_debug_loop_auto_value
    End Property

    Property Let write_L1x_debug_loop_auto(aData)
        set_L1x_debug_loop_auto = aData
        write
    End Property

    Property Get get_L1x_debug_en
        get_L1x_debug_en = read_L1x_debug_en_value
    End Property

    Property Let set_L1x_debug_en(aData)
        write_L1x_debug_en_value = aData
        flag_L1x_debug_en        = &H1
    End Property

    Property Get read_L1x_debug_en
        read
        read_L1x_debug_en = read_L1x_debug_en_value
    End Property

    Property Let write_L1x_debug_en(aData)
        set_L1x_debug_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dbg_phy_tx_cmn_mode_disable_value = rightShift(data_low, 3) and &H1
        read_dbg_phy_rx_eidle_disable_value = rightShift(data_low, 2) and &H1
        read_L1x_debug_loop_auto_value = rightShift(data_low, 1) and &H1
        L1x_debug_en_mask = &H1
        if data_low > LONG_MAX then
            if L1x_debug_en_mask = mask then
                read_L1x_debug_en_value = data_low
            else
                read_L1x_debug_en_value = (data_low - H8000_0000) and L1x_debug_en_mask
            end If
        else
            read_L1x_debug_en_value = data_low and L1x_debug_en_mask
        end If

    End Sub

    Sub write
        If flag_dbg_phy_tx_cmn_mode_disable = &H0 or flag_dbg_phy_rx_eidle_disable = &H0 or flag_L1x_debug_loop_auto = &H0 or flag_L1x_debug_en = &H0 Then read
        If flag_dbg_phy_tx_cmn_mode_disable = &H0 Then write_dbg_phy_tx_cmn_mode_disable_value = get_dbg_phy_tx_cmn_mode_disable
        If flag_dbg_phy_rx_eidle_disable = &H0 Then write_dbg_phy_rx_eidle_disable_value = get_dbg_phy_rx_eidle_disable
        If flag_L1x_debug_loop_auto = &H0 Then write_L1x_debug_loop_auto_value = get_L1x_debug_loop_auto
        If flag_L1x_debug_en = &H0 Then write_L1x_debug_en_value = get_L1x_debug_en

        regValue = leftShift((write_dbg_phy_tx_cmn_mode_disable_value and &H1), 3) + leftShift((write_dbg_phy_rx_eidle_disable_value and &H1), 2) + leftShift((write_L1x_debug_loop_auto_value and &H1), 1) + leftShift((write_L1x_debug_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_dbg_phy_tx_cmn_mode_disable_value = rightShift(data_low, 3) and &H1
        read_dbg_phy_rx_eidle_disable_value = rightShift(data_low, 2) and &H1
        read_L1x_debug_loop_auto_value = rightShift(data_low, 1) and &H1
        L1x_debug_en_mask = &H1
        if data_low > LONG_MAX then
            if L1x_debug_en_mask = mask then
                read_L1x_debug_en_value = data_low
            else
                read_L1x_debug_en_value = (data_low - H8000_0000) and L1x_debug_en_mask
            end If
        else
            read_L1x_debug_en_value = data_low and L1x_debug_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_dbg_phy_tx_cmn_mode_disable_value = &H0
        flag_dbg_phy_tx_cmn_mode_disable        = &H0
        write_dbg_phy_rx_eidle_disable_value = &H0
        flag_dbg_phy_rx_eidle_disable        = &H0
        write_L1x_debug_loop_auto_value = &H0
        flag_L1x_debug_loop_auto        = &H0
        write_L1x_debug_en_value = &H0
        flag_L1x_debug_en        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_debug_hook_l1x_state_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' L1x_state_timer                            [15:0]           get_L1x_state_timer
''                                                             set_L1x_state_timer
''                                                             read_L1x_state_timer
''                                                             write_L1x_state_timer
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_l1x_state_timer
    Private write_L1x_state_timer_value
    Private read_L1x_state_timer_value
    Private flag_L1x_state_timer

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

    Property Get get_L1x_state_timer
        get_L1x_state_timer = read_L1x_state_timer_value
    End Property

    Property Let set_L1x_state_timer(aData)
        write_L1x_state_timer_value = aData
        flag_L1x_state_timer        = &H1
    End Property

    Property Get read_L1x_state_timer
        read
        read_L1x_state_timer = read_L1x_state_timer_value
    End Property

    Property Let write_L1x_state_timer(aData)
        set_L1x_state_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        L1x_state_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if L1x_state_timer_mask = mask then
                read_L1x_state_timer_value = data_low
            else
                read_L1x_state_timer_value = (data_low - H8000_0000) and L1x_state_timer_mask
            end If
        else
            read_L1x_state_timer_value = data_low and L1x_state_timer_mask
        end If

    End Sub

    Sub write
        If flag_L1x_state_timer = &H0 Then read
        If flag_L1x_state_timer = &H0 Then write_L1x_state_timer_value = get_L1x_state_timer

        regValue = leftShift((write_L1x_state_timer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        L1x_state_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if L1x_state_timer_mask = mask then
                read_L1x_state_timer_value = data_low
            else
                read_L1x_state_timer_value = (data_low - H8000_0000) and L1x_state_timer_mask
            end If
        else
            read_L1x_state_timer_value = data_low and L1x_state_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_L1x_state_timer_value = &H0
        flag_L1x_state_timer        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_debug_hook_l0_state_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' L0_state_timer                             [15:0]           get_L0_state_timer
''                                                             set_L0_state_timer
''                                                             read_L0_state_timer
''                                                             write_L0_state_timer
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_l0_state_timer
    Private write_L0_state_timer_value
    Private read_L0_state_timer_value
    Private flag_L0_state_timer

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

    Property Get get_L0_state_timer
        get_L0_state_timer = read_L0_state_timer_value
    End Property

    Property Let set_L0_state_timer(aData)
        write_L0_state_timer_value = aData
        flag_L0_state_timer        = &H1
    End Property

    Property Get read_L0_state_timer
        read
        read_L0_state_timer = read_L0_state_timer_value
    End Property

    Property Let write_L0_state_timer(aData)
        set_L0_state_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        L0_state_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if L0_state_timer_mask = mask then
                read_L0_state_timer_value = data_low
            else
                read_L0_state_timer_value = (data_low - H8000_0000) and L0_state_timer_mask
            end If
        else
            read_L0_state_timer_value = data_low and L0_state_timer_mask
        end If

    End Sub

    Sub write
        If flag_L0_state_timer = &H0 Then read
        If flag_L0_state_timer = &H0 Then write_L0_state_timer_value = get_L0_state_timer

        regValue = leftShift((write_L0_state_timer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        L0_state_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if L0_state_timer_mask = mask then
                read_L0_state_timer_value = data_low
            else
                read_L0_state_timer_value = (data_low - H8000_0000) and L0_state_timer_mask
            end If
        else
            read_L0_state_timer_value = data_low and L0_state_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_L0_state_timer_value = &H0
        flag_L0_state_timer        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_txei_mask_off_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txei_mask_off_timer                        [15:0]           get_txei_mask_off_timer
''                                                             set_txei_mask_off_timer
''                                                             read_txei_mask_off_timer
''                                                             write_txei_mask_off_timer
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_txei_mask_off_timer
    Private write_txei_mask_off_timer_value
    Private read_txei_mask_off_timer_value
    Private flag_txei_mask_off_timer

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

    Property Get get_txei_mask_off_timer
        get_txei_mask_off_timer = read_txei_mask_off_timer_value
    End Property

    Property Let set_txei_mask_off_timer(aData)
        write_txei_mask_off_timer_value = aData
        flag_txei_mask_off_timer        = &H1
    End Property

    Property Get read_txei_mask_off_timer
        read
        read_txei_mask_off_timer = read_txei_mask_off_timer_value
    End Property

    Property Let write_txei_mask_off_timer(aData)
        set_txei_mask_off_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txei_mask_off_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if txei_mask_off_timer_mask = mask then
                read_txei_mask_off_timer_value = data_low
            else
                read_txei_mask_off_timer_value = (data_low - H8000_0000) and txei_mask_off_timer_mask
            end If
        else
            read_txei_mask_off_timer_value = data_low and txei_mask_off_timer_mask
        end If

    End Sub

    Sub write
        If flag_txei_mask_off_timer = &H0 Then read
        If flag_txei_mask_off_timer = &H0 Then write_txei_mask_off_timer_value = get_txei_mask_off_timer

        regValue = leftShift((write_txei_mask_off_timer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txei_mask_off_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if txei_mask_off_timer_mask = mask then
                read_txei_mask_off_timer_value = data_low
            else
                read_txei_mask_off_timer_value = (data_low - H8000_0000) and txei_mask_off_timer_mask
            end If
        else
            read_txei_mask_off_timer_value = data_low and txei_mask_off_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txei_mask_off_timer_value = &H0
        flag_txei_mask_off_timer        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_txei_mask_on_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txei_mask_on_timer                         [15:0]           get_txei_mask_on_timer
''                                                             set_txei_mask_on_timer
''                                                             read_txei_mask_on_timer
''                                                             write_txei_mask_on_timer
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_txei_mask_on_timer
    Private write_txei_mask_on_timer_value
    Private read_txei_mask_on_timer_value
    Private flag_txei_mask_on_timer

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

    Property Get get_txei_mask_on_timer
        get_txei_mask_on_timer = read_txei_mask_on_timer_value
    End Property

    Property Let set_txei_mask_on_timer(aData)
        write_txei_mask_on_timer_value = aData
        flag_txei_mask_on_timer        = &H1
    End Property

    Property Get read_txei_mask_on_timer
        read
        read_txei_mask_on_timer = read_txei_mask_on_timer_value
    End Property

    Property Let write_txei_mask_on_timer(aData)
        set_txei_mask_on_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txei_mask_on_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if txei_mask_on_timer_mask = mask then
                read_txei_mask_on_timer_value = data_low
            else
                read_txei_mask_on_timer_value = (data_low - H8000_0000) and txei_mask_on_timer_mask
            end If
        else
            read_txei_mask_on_timer_value = data_low and txei_mask_on_timer_mask
        end If

    End Sub

    Sub write
        If flag_txei_mask_on_timer = &H0 Then read
        If flag_txei_mask_on_timer = &H0 Then write_txei_mask_on_timer_value = get_txei_mask_on_timer

        regValue = leftShift((write_txei_mask_on_timer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txei_mask_on_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if txei_mask_on_timer_mask = mask then
                read_txei_mask_on_timer_value = data_low
            else
                read_txei_mask_on_timer_value = (data_low - H8000_0000) and txei_mask_on_timer_mask
            end If
        else
            read_txei_mask_on_timer_value = data_low and txei_mask_on_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txei_mask_on_timer_value = &H0
        flag_txei_mask_on_timer        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_lfckcnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' lfckcnt                                    [15:0]           get_lfckcnt
''                                                             set_lfckcnt
''                                                             read_lfckcnt
''                                                             write_lfckcnt
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_lfckcnt
    Private write_lfckcnt_value
    Private read_lfckcnt_value
    Private flag_lfckcnt

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

    Property Get get_lfckcnt
        get_lfckcnt = read_lfckcnt_value
    End Property

    Property Let set_lfckcnt(aData)
        write_lfckcnt_value = aData
        flag_lfckcnt        = &H1
    End Property

    Property Get read_lfckcnt
        read
        read_lfckcnt = read_lfckcnt_value
    End Property

    Property Let write_lfckcnt(aData)
        set_lfckcnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lfckcnt_mask = &Hffff
        if data_low > LONG_MAX then
            if lfckcnt_mask = mask then
                read_lfckcnt_value = data_low
            else
                read_lfckcnt_value = (data_low - H8000_0000) and lfckcnt_mask
            end If
        else
            read_lfckcnt_value = data_low and lfckcnt_mask
        end If

    End Sub

    Sub write
        If flag_lfckcnt = &H0 Then read
        If flag_lfckcnt = &H0 Then write_lfckcnt_value = get_lfckcnt

        regValue = leftShift((write_lfckcnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        lfckcnt_mask = &Hffff
        if data_low > LONG_MAX then
            if lfckcnt_mask = mask then
                read_lfckcnt_value = data_low
            else
                read_lfckcnt_value = (data_low - H8000_0000) and lfckcnt_mask
            end If
        else
            read_lfckcnt_value = data_low and lfckcnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_lfckcnt_value = &H0
        flag_lfckcnt        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_pwrmgmt0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_LTTSM_NoVoltIsland                    [14:8]           get_mdio_LTTSM_NoVoltIsland
''                                                             set_mdio_LTTSM_NoVoltIsland
''                                                             read_mdio_LTTSM_NoVoltIsland
''                                                             write_mdio_LTTSM_NoVoltIsland
''---------------------------------------------------------------------------------
'' mdio_LTTSM_P2                              [6:0]            get_mdio_LTTSM_P2
''                                                             set_mdio_LTTSM_P2
''                                                             read_mdio_LTTSM_P2
''                                                             write_mdio_LTTSM_P2
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt0
    Private write_mdio_LTTSM_NoVoltIsland_value
    Private read_mdio_LTTSM_NoVoltIsland_value
    Private flag_mdio_LTTSM_NoVoltIsland
    Private write_mdio_LTTSM_P2_value
    Private read_mdio_LTTSM_P2_value
    Private flag_mdio_LTTSM_P2

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

    Property Get get_mdio_LTTSM_NoVoltIsland
        get_mdio_LTTSM_NoVoltIsland = read_mdio_LTTSM_NoVoltIsland_value
    End Property

    Property Let set_mdio_LTTSM_NoVoltIsland(aData)
        write_mdio_LTTSM_NoVoltIsland_value = aData
        flag_mdio_LTTSM_NoVoltIsland        = &H1
    End Property

    Property Get read_mdio_LTTSM_NoVoltIsland
        read
        read_mdio_LTTSM_NoVoltIsland = read_mdio_LTTSM_NoVoltIsland_value
    End Property

    Property Let write_mdio_LTTSM_NoVoltIsland(aData)
        set_mdio_LTTSM_NoVoltIsland = aData
        write
    End Property

    Property Get get_mdio_LTTSM_P2
        get_mdio_LTTSM_P2 = read_mdio_LTTSM_P2_value
    End Property

    Property Let set_mdio_LTTSM_P2(aData)
        write_mdio_LTTSM_P2_value = aData
        flag_mdio_LTTSM_P2        = &H1
    End Property

    Property Get read_mdio_LTTSM_P2
        read
        read_mdio_LTTSM_P2 = read_mdio_LTTSM_P2_value
    End Property

    Property Let write_mdio_LTTSM_P2(aData)
        set_mdio_LTTSM_P2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_NoVoltIsland_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_P2_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_P2_mask = mask then
                read_mdio_LTTSM_P2_value = data_low
            else
                read_mdio_LTTSM_P2_value = (data_low - H8000_0000) and mdio_LTTSM_P2_mask
            end If
        else
            read_mdio_LTTSM_P2_value = data_low and mdio_LTTSM_P2_mask
        end If

    End Sub

    Sub write
        If flag_mdio_LTTSM_NoVoltIsland = &H0 or flag_mdio_LTTSM_P2 = &H0 Then read
        If flag_mdio_LTTSM_NoVoltIsland = &H0 Then write_mdio_LTTSM_NoVoltIsland_value = get_mdio_LTTSM_NoVoltIsland
        If flag_mdio_LTTSM_P2 = &H0 Then write_mdio_LTTSM_P2_value = get_mdio_LTTSM_P2

        regValue = leftShift((write_mdio_LTTSM_NoVoltIsland_value and &H7f), 8) + leftShift((write_mdio_LTTSM_P2_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_NoVoltIsland_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_P2_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_P2_mask = mask then
                read_mdio_LTTSM_P2_value = data_low
            else
                read_mdio_LTTSM_P2_value = (data_low - H8000_0000) and mdio_LTTSM_P2_mask
            end If
        else
            read_mdio_LTTSM_P2_value = data_low and mdio_LTTSM_P2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_LTTSM_NoVoltIsland_value = &H0
        flag_mdio_LTTSM_NoVoltIsland        = &H0
        write_mdio_LTTSM_P2_value = &H0
        flag_mdio_LTTSM_P2        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_pwrmgmt1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_LTTSM_FwPwrDn                         [14:8]           get_mdio_LTTSM_FwPwrDn
''                                                             set_mdio_LTTSM_FwPwrDn
''                                                             read_mdio_LTTSM_FwPwrDn
''                                                             write_mdio_LTTSM_FwPwrDn
''---------------------------------------------------------------------------------
'' mdio_LTTSM_LinkPwrDn                       [6:0]            get_mdio_LTTSM_LinkPwrDn
''                                                             set_mdio_LTTSM_LinkPwrDn
''                                                             read_mdio_LTTSM_LinkPwrDn
''                                                             write_mdio_LTTSM_LinkPwrDn
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt1
    Private write_mdio_LTTSM_FwPwrDn_value
    Private read_mdio_LTTSM_FwPwrDn_value
    Private flag_mdio_LTTSM_FwPwrDn
    Private write_mdio_LTTSM_LinkPwrDn_value
    Private read_mdio_LTTSM_LinkPwrDn_value
    Private flag_mdio_LTTSM_LinkPwrDn

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

    Property Get get_mdio_LTTSM_FwPwrDn
        get_mdio_LTTSM_FwPwrDn = read_mdio_LTTSM_FwPwrDn_value
    End Property

    Property Let set_mdio_LTTSM_FwPwrDn(aData)
        write_mdio_LTTSM_FwPwrDn_value = aData
        flag_mdio_LTTSM_FwPwrDn        = &H1
    End Property

    Property Get read_mdio_LTTSM_FwPwrDn
        read
        read_mdio_LTTSM_FwPwrDn = read_mdio_LTTSM_FwPwrDn_value
    End Property

    Property Let write_mdio_LTTSM_FwPwrDn(aData)
        set_mdio_LTTSM_FwPwrDn = aData
        write
    End Property

    Property Get get_mdio_LTTSM_LinkPwrDn
        get_mdio_LTTSM_LinkPwrDn = read_mdio_LTTSM_LinkPwrDn_value
    End Property

    Property Let set_mdio_LTTSM_LinkPwrDn(aData)
        write_mdio_LTTSM_LinkPwrDn_value = aData
        flag_mdio_LTTSM_LinkPwrDn        = &H1
    End Property

    Property Get read_mdio_LTTSM_LinkPwrDn
        read
        read_mdio_LTTSM_LinkPwrDn = read_mdio_LTTSM_LinkPwrDn_value
    End Property

    Property Let write_mdio_LTTSM_LinkPwrDn(aData)
        set_mdio_LTTSM_LinkPwrDn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_FwPwrDn_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_LinkPwrDn_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_LinkPwrDn_mask = mask then
                read_mdio_LTTSM_LinkPwrDn_value = data_low
            else
                read_mdio_LTTSM_LinkPwrDn_value = (data_low - H8000_0000) and mdio_LTTSM_LinkPwrDn_mask
            end If
        else
            read_mdio_LTTSM_LinkPwrDn_value = data_low and mdio_LTTSM_LinkPwrDn_mask
        end If

    End Sub

    Sub write
        If flag_mdio_LTTSM_FwPwrDn = &H0 or flag_mdio_LTTSM_LinkPwrDn = &H0 Then read
        If flag_mdio_LTTSM_FwPwrDn = &H0 Then write_mdio_LTTSM_FwPwrDn_value = get_mdio_LTTSM_FwPwrDn
        If flag_mdio_LTTSM_LinkPwrDn = &H0 Then write_mdio_LTTSM_LinkPwrDn_value = get_mdio_LTTSM_LinkPwrDn

        regValue = leftShift((write_mdio_LTTSM_FwPwrDn_value and &H7f), 8) + leftShift((write_mdio_LTTSM_LinkPwrDn_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_FwPwrDn_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_LinkPwrDn_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_LinkPwrDn_mask = mask then
                read_mdio_LTTSM_LinkPwrDn_value = data_low
            else
                read_mdio_LTTSM_LinkPwrDn_value = (data_low - H8000_0000) and mdio_LTTSM_LinkPwrDn_mask
            end If
        else
            read_mdio_LTTSM_LinkPwrDn_value = data_low and mdio_LTTSM_LinkPwrDn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_LTTSM_FwPwrDn_value = &H0
        flag_mdio_LTTSM_FwPwrDn        = &H0
        write_mdio_LTTSM_LinkPwrDn_value = &H0
        flag_mdio_LTTSM_LinkPwrDn        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_pwrmgmt2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_LTTSM_P1NoClkReqPllPwrDn              [14:8]           get_mdio_LTTSM_P1NoClkReqPllPwrDn
''                                                             set_mdio_LTTSM_P1NoClkReqPllPwrDn
''                                                             read_mdio_LTTSM_P1NoClkReqPllPwrDn
''                                                             write_mdio_LTTSM_P1NoClkReqPllPwrDn
''---------------------------------------------------------------------------------
'' mdio_LTTSM_P1NoClkReq                      [6:0]            get_mdio_LTTSM_P1NoClkReq
''                                                             set_mdio_LTTSM_P1NoClkReq
''                                                             read_mdio_LTTSM_P1NoClkReq
''                                                             write_mdio_LTTSM_P1NoClkReq
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt2
    Private write_mdio_LTTSM_P1NoClkReqPllPwrDn_value
    Private read_mdio_LTTSM_P1NoClkReqPllPwrDn_value
    Private flag_mdio_LTTSM_P1NoClkReqPllPwrDn
    Private write_mdio_LTTSM_P1NoClkReq_value
    Private read_mdio_LTTSM_P1NoClkReq_value
    Private flag_mdio_LTTSM_P1NoClkReq

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

    Property Get get_mdio_LTTSM_P1NoClkReqPllPwrDn
        get_mdio_LTTSM_P1NoClkReqPllPwrDn = read_mdio_LTTSM_P1NoClkReqPllPwrDn_value
    End Property

    Property Let set_mdio_LTTSM_P1NoClkReqPllPwrDn(aData)
        write_mdio_LTTSM_P1NoClkReqPllPwrDn_value = aData
        flag_mdio_LTTSM_P1NoClkReqPllPwrDn        = &H1
    End Property

    Property Get read_mdio_LTTSM_P1NoClkReqPllPwrDn
        read
        read_mdio_LTTSM_P1NoClkReqPllPwrDn = read_mdio_LTTSM_P1NoClkReqPllPwrDn_value
    End Property

    Property Let write_mdio_LTTSM_P1NoClkReqPllPwrDn(aData)
        set_mdio_LTTSM_P1NoClkReqPllPwrDn = aData
        write
    End Property

    Property Get get_mdio_LTTSM_P1NoClkReq
        get_mdio_LTTSM_P1NoClkReq = read_mdio_LTTSM_P1NoClkReq_value
    End Property

    Property Let set_mdio_LTTSM_P1NoClkReq(aData)
        write_mdio_LTTSM_P1NoClkReq_value = aData
        flag_mdio_LTTSM_P1NoClkReq        = &H1
    End Property

    Property Get read_mdio_LTTSM_P1NoClkReq
        read
        read_mdio_LTTSM_P1NoClkReq = read_mdio_LTTSM_P1NoClkReq_value
    End Property

    Property Let write_mdio_LTTSM_P1NoClkReq(aData)
        set_mdio_LTTSM_P1NoClkReq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_P1NoClkReqPllPwrDn_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_P1NoClkReq_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_P1NoClkReq_mask = mask then
                read_mdio_LTTSM_P1NoClkReq_value = data_low
            else
                read_mdio_LTTSM_P1NoClkReq_value = (data_low - H8000_0000) and mdio_LTTSM_P1NoClkReq_mask
            end If
        else
            read_mdio_LTTSM_P1NoClkReq_value = data_low and mdio_LTTSM_P1NoClkReq_mask
        end If

    End Sub

    Sub write
        If flag_mdio_LTTSM_P1NoClkReqPllPwrDn = &H0 or flag_mdio_LTTSM_P1NoClkReq = &H0 Then read
        If flag_mdio_LTTSM_P1NoClkReqPllPwrDn = &H0 Then write_mdio_LTTSM_P1NoClkReqPllPwrDn_value = get_mdio_LTTSM_P1NoClkReqPllPwrDn
        If flag_mdio_LTTSM_P1NoClkReq = &H0 Then write_mdio_LTTSM_P1NoClkReq_value = get_mdio_LTTSM_P1NoClkReq

        regValue = leftShift((write_mdio_LTTSM_P1NoClkReqPllPwrDn_value and &H7f), 8) + leftShift((write_mdio_LTTSM_P1NoClkReq_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_P1NoClkReqPllPwrDn_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_P1NoClkReq_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_P1NoClkReq_mask = mask then
                read_mdio_LTTSM_P1NoClkReq_value = data_low
            else
                read_mdio_LTTSM_P1NoClkReq_value = (data_low - H8000_0000) and mdio_LTTSM_P1NoClkReq_mask
            end If
        else
            read_mdio_LTTSM_P1NoClkReq_value = data_low and mdio_LTTSM_P1NoClkReq_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_LTTSM_P1NoClkReqPllPwrDn_value = &H0
        flag_mdio_LTTSM_P1NoClkReqPllPwrDn        = &H0
        write_mdio_LTTSM_P1NoClkReq_value = &H0
        flag_mdio_LTTSM_P1NoClkReq        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_pwrmgmt3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_LTTSM_P0                              [14:8]           get_mdio_LTTSM_P0
''                                                             set_mdio_LTTSM_P0
''                                                             read_mdio_LTTSM_P0
''                                                             write_mdio_LTTSM_P0
''---------------------------------------------------------------------------------
'' mdio_LTTSM_P1ClkReq                        [6:0]            get_mdio_LTTSM_P1ClkReq
''                                                             set_mdio_LTTSM_P1ClkReq
''                                                             read_mdio_LTTSM_P1ClkReq
''                                                             write_mdio_LTTSM_P1ClkReq
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt3
    Private write_mdio_LTTSM_P0_value
    Private read_mdio_LTTSM_P0_value
    Private flag_mdio_LTTSM_P0
    Private write_mdio_LTTSM_P1ClkReq_value
    Private read_mdio_LTTSM_P1ClkReq_value
    Private flag_mdio_LTTSM_P1ClkReq

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

    Property Get get_mdio_LTTSM_P0
        get_mdio_LTTSM_P0 = read_mdio_LTTSM_P0_value
    End Property

    Property Let set_mdio_LTTSM_P0(aData)
        write_mdio_LTTSM_P0_value = aData
        flag_mdio_LTTSM_P0        = &H1
    End Property

    Property Get read_mdio_LTTSM_P0
        read
        read_mdio_LTTSM_P0 = read_mdio_LTTSM_P0_value
    End Property

    Property Let write_mdio_LTTSM_P0(aData)
        set_mdio_LTTSM_P0 = aData
        write
    End Property

    Property Get get_mdio_LTTSM_P1ClkReq
        get_mdio_LTTSM_P1ClkReq = read_mdio_LTTSM_P1ClkReq_value
    End Property

    Property Let set_mdio_LTTSM_P1ClkReq(aData)
        write_mdio_LTTSM_P1ClkReq_value = aData
        flag_mdio_LTTSM_P1ClkReq        = &H1
    End Property

    Property Get read_mdio_LTTSM_P1ClkReq
        read
        read_mdio_LTTSM_P1ClkReq = read_mdio_LTTSM_P1ClkReq_value
    End Property

    Property Let write_mdio_LTTSM_P1ClkReq(aData)
        set_mdio_LTTSM_P1ClkReq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_P0_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_P1ClkReq_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_P1ClkReq_mask = mask then
                read_mdio_LTTSM_P1ClkReq_value = data_low
            else
                read_mdio_LTTSM_P1ClkReq_value = (data_low - H8000_0000) and mdio_LTTSM_P1ClkReq_mask
            end If
        else
            read_mdio_LTTSM_P1ClkReq_value = data_low and mdio_LTTSM_P1ClkReq_mask
        end If

    End Sub

    Sub write
        If flag_mdio_LTTSM_P0 = &H0 or flag_mdio_LTTSM_P1ClkReq = &H0 Then read
        If flag_mdio_LTTSM_P0 = &H0 Then write_mdio_LTTSM_P0_value = get_mdio_LTTSM_P0
        If flag_mdio_LTTSM_P1ClkReq = &H0 Then write_mdio_LTTSM_P1ClkReq_value = get_mdio_LTTSM_P1ClkReq

        regValue = leftShift((write_mdio_LTTSM_P0_value and &H7f), 8) + leftShift((write_mdio_LTTSM_P1ClkReq_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_LTTSM_P0_value = rightShift(data_low, 8) and &H7f
        mdio_LTTSM_P1ClkReq_mask = &H7f
        if data_low > LONG_MAX then
            if mdio_LTTSM_P1ClkReq_mask = mask then
                read_mdio_LTTSM_P1ClkReq_value = data_low
            else
                read_mdio_LTTSM_P1ClkReq_value = (data_low - H8000_0000) and mdio_LTTSM_P1ClkReq_mask
            end If
        else
            read_mdio_LTTSM_P1ClkReq_value = data_low and mdio_LTTSM_P1ClkReq_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_LTTSM_P0_value = &H0
        flag_mdio_LTTSM_P0        = &H0
        write_mdio_LTTSM_P1ClkReq_value = &H0
        flag_mdio_LTTSM_P1ClkReq        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_pwrmgmt4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_TxIdleCtrl                            [14:11]          get_mdio_TxIdleCtrl
''                                                             set_mdio_TxIdleCtrl
''                                                             read_mdio_TxIdleCtrl
''                                                             write_mdio_TxIdleCtrl
''---------------------------------------------------------------------------------
'' mdio_ClkReq_0                              [10:10]          get_mdio_ClkReq_0
''                                                             set_mdio_ClkReq_0
''                                                             read_mdio_ClkReq_0
''                                                             write_mdio_ClkReq_0
''---------------------------------------------------------------------------------
'' mdio_ClkReqMdioSel_0                       [9:9]            get_mdio_ClkReqMdioSel_0
''                                                             set_mdio_ClkReqMdioSel_0
''                                                             read_mdio_ClkReqMdioSel_0
''                                                             write_mdio_ClkReqMdioSel_0
''---------------------------------------------------------------------------------
'' mdio_AuxClkEnablep                         [8:8]            get_mdio_AuxClkEnablep
''                                                             set_mdio_AuxClkEnablep
''                                                             read_mdio_AuxClkEnablep
''                                                             write_mdio_AuxClkEnablep
''---------------------------------------------------------------------------------
'' mdio_AuxClkEnableMdioSel                   [7:7]            get_mdio_AuxClkEnableMdioSel
''                                                             set_mdio_AuxClkEnableMdioSel
''                                                             read_mdio_AuxClkEnableMdioSel
''                                                             write_mdio_AuxClkEnableMdioSel
''---------------------------------------------------------------------------------
'' MDIO_AUXP1                                 [6:6]            get_MDIO_AUXP1
''                                                             set_MDIO_AUXP1
''                                                             read_MDIO_AUXP1
''                                                             write_MDIO_AUXP1
''---------------------------------------------------------------------------------
'' mdio_LTTSM_P1AnaPwrDnPll                   [5:3]            get_mdio_LTTSM_P1AnaPwrDnPll
''                                                             set_mdio_LTTSM_P1AnaPwrDnPll
''                                                             read_mdio_LTTSM_P1AnaPwrDnPll
''                                                             write_mdio_LTTSM_P1AnaPwrDnPll
''---------------------------------------------------------------------------------
'' mdio_LTTSM_P1AnaPwrDn                      [2:0]            get_mdio_LTTSM_P1AnaPwrDn
''                                                             set_mdio_LTTSM_P1AnaPwrDn
''                                                             read_mdio_LTTSM_P1AnaPwrDn
''                                                             write_mdio_LTTSM_P1AnaPwrDn
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt4
    Private write_mdio_TxIdleCtrl_value
    Private read_mdio_TxIdleCtrl_value
    Private flag_mdio_TxIdleCtrl
    Private write_mdio_ClkReq_0_value
    Private read_mdio_ClkReq_0_value
    Private flag_mdio_ClkReq_0
    Private write_mdio_ClkReqMdioSel_0_value
    Private read_mdio_ClkReqMdioSel_0_value
    Private flag_mdio_ClkReqMdioSel_0
    Private write_mdio_AuxClkEnablep_value
    Private read_mdio_AuxClkEnablep_value
    Private flag_mdio_AuxClkEnablep
    Private write_mdio_AuxClkEnableMdioSel_value
    Private read_mdio_AuxClkEnableMdioSel_value
    Private flag_mdio_AuxClkEnableMdioSel
    Private write_MDIO_AUXP1_value
    Private read_MDIO_AUXP1_value
    Private flag_MDIO_AUXP1
    Private write_mdio_LTTSM_P1AnaPwrDnPll_value
    Private read_mdio_LTTSM_P1AnaPwrDnPll_value
    Private flag_mdio_LTTSM_P1AnaPwrDnPll
    Private write_mdio_LTTSM_P1AnaPwrDn_value
    Private read_mdio_LTTSM_P1AnaPwrDn_value
    Private flag_mdio_LTTSM_P1AnaPwrDn

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

    Property Get get_mdio_TxIdleCtrl
        get_mdio_TxIdleCtrl = read_mdio_TxIdleCtrl_value
    End Property

    Property Let set_mdio_TxIdleCtrl(aData)
        write_mdio_TxIdleCtrl_value = aData
        flag_mdio_TxIdleCtrl        = &H1
    End Property

    Property Get read_mdio_TxIdleCtrl
        read
        read_mdio_TxIdleCtrl = read_mdio_TxIdleCtrl_value
    End Property

    Property Let write_mdio_TxIdleCtrl(aData)
        set_mdio_TxIdleCtrl = aData
        write
    End Property

    Property Get get_mdio_ClkReq_0
        get_mdio_ClkReq_0 = read_mdio_ClkReq_0_value
    End Property

    Property Let set_mdio_ClkReq_0(aData)
        write_mdio_ClkReq_0_value = aData
        flag_mdio_ClkReq_0        = &H1
    End Property

    Property Get read_mdio_ClkReq_0
        read
        read_mdio_ClkReq_0 = read_mdio_ClkReq_0_value
    End Property

    Property Let write_mdio_ClkReq_0(aData)
        set_mdio_ClkReq_0 = aData
        write
    End Property

    Property Get get_mdio_ClkReqMdioSel_0
        get_mdio_ClkReqMdioSel_0 = read_mdio_ClkReqMdioSel_0_value
    End Property

    Property Let set_mdio_ClkReqMdioSel_0(aData)
        write_mdio_ClkReqMdioSel_0_value = aData
        flag_mdio_ClkReqMdioSel_0        = &H1
    End Property

    Property Get read_mdio_ClkReqMdioSel_0
        read
        read_mdio_ClkReqMdioSel_0 = read_mdio_ClkReqMdioSel_0_value
    End Property

    Property Let write_mdio_ClkReqMdioSel_0(aData)
        set_mdio_ClkReqMdioSel_0 = aData
        write
    End Property

    Property Get get_mdio_AuxClkEnablep
        get_mdio_AuxClkEnablep = read_mdio_AuxClkEnablep_value
    End Property

    Property Let set_mdio_AuxClkEnablep(aData)
        write_mdio_AuxClkEnablep_value = aData
        flag_mdio_AuxClkEnablep        = &H1
    End Property

    Property Get read_mdio_AuxClkEnablep
        read
        read_mdio_AuxClkEnablep = read_mdio_AuxClkEnablep_value
    End Property

    Property Let write_mdio_AuxClkEnablep(aData)
        set_mdio_AuxClkEnablep = aData
        write
    End Property

    Property Get get_mdio_AuxClkEnableMdioSel
        get_mdio_AuxClkEnableMdioSel = read_mdio_AuxClkEnableMdioSel_value
    End Property

    Property Let set_mdio_AuxClkEnableMdioSel(aData)
        write_mdio_AuxClkEnableMdioSel_value = aData
        flag_mdio_AuxClkEnableMdioSel        = &H1
    End Property

    Property Get read_mdio_AuxClkEnableMdioSel
        read
        read_mdio_AuxClkEnableMdioSel = read_mdio_AuxClkEnableMdioSel_value
    End Property

    Property Let write_mdio_AuxClkEnableMdioSel(aData)
        set_mdio_AuxClkEnableMdioSel = aData
        write
    End Property

    Property Get get_MDIO_AUXP1
        get_MDIO_AUXP1 = read_MDIO_AUXP1_value
    End Property

    Property Let set_MDIO_AUXP1(aData)
        write_MDIO_AUXP1_value = aData
        flag_MDIO_AUXP1        = &H1
    End Property

    Property Get read_MDIO_AUXP1
        read
        read_MDIO_AUXP1 = read_MDIO_AUXP1_value
    End Property

    Property Let write_MDIO_AUXP1(aData)
        set_MDIO_AUXP1 = aData
        write
    End Property

    Property Get get_mdio_LTTSM_P1AnaPwrDnPll
        get_mdio_LTTSM_P1AnaPwrDnPll = read_mdio_LTTSM_P1AnaPwrDnPll_value
    End Property

    Property Let set_mdio_LTTSM_P1AnaPwrDnPll(aData)
        write_mdio_LTTSM_P1AnaPwrDnPll_value = aData
        flag_mdio_LTTSM_P1AnaPwrDnPll        = &H1
    End Property

    Property Get read_mdio_LTTSM_P1AnaPwrDnPll
        read
        read_mdio_LTTSM_P1AnaPwrDnPll = read_mdio_LTTSM_P1AnaPwrDnPll_value
    End Property

    Property Let write_mdio_LTTSM_P1AnaPwrDnPll(aData)
        set_mdio_LTTSM_P1AnaPwrDnPll = aData
        write
    End Property

    Property Get get_mdio_LTTSM_P1AnaPwrDn
        get_mdio_LTTSM_P1AnaPwrDn = read_mdio_LTTSM_P1AnaPwrDn_value
    End Property

    Property Let set_mdio_LTTSM_P1AnaPwrDn(aData)
        write_mdio_LTTSM_P1AnaPwrDn_value = aData
        flag_mdio_LTTSM_P1AnaPwrDn        = &H1
    End Property

    Property Get read_mdio_LTTSM_P1AnaPwrDn
        read
        read_mdio_LTTSM_P1AnaPwrDn = read_mdio_LTTSM_P1AnaPwrDn_value
    End Property

    Property Let write_mdio_LTTSM_P1AnaPwrDn(aData)
        set_mdio_LTTSM_P1AnaPwrDn = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_TxIdleCtrl_value = rightShift(data_low, 11) and &Hf
        read_mdio_ClkReq_0_value = rightShift(data_low, 10) and &H1
        read_mdio_ClkReqMdioSel_0_value = rightShift(data_low, 9) and &H1
        read_mdio_AuxClkEnablep_value = rightShift(data_low, 8) and &H1
        read_mdio_AuxClkEnableMdioSel_value = rightShift(data_low, 7) and &H1
        read_MDIO_AUXP1_value = rightShift(data_low, 6) and &H1
        read_mdio_LTTSM_P1AnaPwrDnPll_value = rightShift(data_low, 3) and &H7
        mdio_LTTSM_P1AnaPwrDn_mask = &H7
        if data_low > LONG_MAX then
            if mdio_LTTSM_P1AnaPwrDn_mask = mask then
                read_mdio_LTTSM_P1AnaPwrDn_value = data_low
            else
                read_mdio_LTTSM_P1AnaPwrDn_value = (data_low - H8000_0000) and mdio_LTTSM_P1AnaPwrDn_mask
            end If
        else
            read_mdio_LTTSM_P1AnaPwrDn_value = data_low and mdio_LTTSM_P1AnaPwrDn_mask
        end If

    End Sub

    Sub write
        If flag_mdio_TxIdleCtrl = &H0 or flag_mdio_ClkReq_0 = &H0 or flag_mdio_ClkReqMdioSel_0 = &H0 or flag_mdio_AuxClkEnablep = &H0 or flag_mdio_AuxClkEnableMdioSel = &H0 or flag_MDIO_AUXP1 = &H0 or flag_mdio_LTTSM_P1AnaPwrDnPll = &H0 or flag_mdio_LTTSM_P1AnaPwrDn = &H0 Then read
        If flag_mdio_TxIdleCtrl = &H0 Then write_mdio_TxIdleCtrl_value = get_mdio_TxIdleCtrl
        If flag_mdio_ClkReq_0 = &H0 Then write_mdio_ClkReq_0_value = get_mdio_ClkReq_0
        If flag_mdio_ClkReqMdioSel_0 = &H0 Then write_mdio_ClkReqMdioSel_0_value = get_mdio_ClkReqMdioSel_0
        If flag_mdio_AuxClkEnablep = &H0 Then write_mdio_AuxClkEnablep_value = get_mdio_AuxClkEnablep
        If flag_mdio_AuxClkEnableMdioSel = &H0 Then write_mdio_AuxClkEnableMdioSel_value = get_mdio_AuxClkEnableMdioSel
        If flag_MDIO_AUXP1 = &H0 Then write_MDIO_AUXP1_value = get_MDIO_AUXP1
        If flag_mdio_LTTSM_P1AnaPwrDnPll = &H0 Then write_mdio_LTTSM_P1AnaPwrDnPll_value = get_mdio_LTTSM_P1AnaPwrDnPll
        If flag_mdio_LTTSM_P1AnaPwrDn = &H0 Then write_mdio_LTTSM_P1AnaPwrDn_value = get_mdio_LTTSM_P1AnaPwrDn

        regValue = leftShift((write_mdio_TxIdleCtrl_value and &Hf), 11) + leftShift((write_mdio_ClkReq_0_value and &H1), 10) + leftShift((write_mdio_ClkReqMdioSel_0_value and &H1), 9) + leftShift((write_mdio_AuxClkEnablep_value and &H1), 8) + leftShift((write_mdio_AuxClkEnableMdioSel_value and &H1), 7) + leftShift((write_MDIO_AUXP1_value and &H1), 6) + leftShift((write_mdio_LTTSM_P1AnaPwrDnPll_value and &H7), 3) + leftShift((write_mdio_LTTSM_P1AnaPwrDn_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_TxIdleCtrl_value = rightShift(data_low, 11) and &Hf
        read_mdio_ClkReq_0_value = rightShift(data_low, 10) and &H1
        read_mdio_ClkReqMdioSel_0_value = rightShift(data_low, 9) and &H1
        read_mdio_AuxClkEnablep_value = rightShift(data_low, 8) and &H1
        read_mdio_AuxClkEnableMdioSel_value = rightShift(data_low, 7) and &H1
        read_MDIO_AUXP1_value = rightShift(data_low, 6) and &H1
        read_mdio_LTTSM_P1AnaPwrDnPll_value = rightShift(data_low, 3) and &H7
        mdio_LTTSM_P1AnaPwrDn_mask = &H7
        if data_low > LONG_MAX then
            if mdio_LTTSM_P1AnaPwrDn_mask = mask then
                read_mdio_LTTSM_P1AnaPwrDn_value = data_low
            else
                read_mdio_LTTSM_P1AnaPwrDn_value = (data_low - H8000_0000) and mdio_LTTSM_P1AnaPwrDn_mask
            end If
        else
            read_mdio_LTTSM_P1AnaPwrDn_value = data_low and mdio_LTTSM_P1AnaPwrDn_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_TxIdleCtrl_value = &H0
        flag_mdio_TxIdleCtrl        = &H0
        write_mdio_ClkReq_0_value = &H0
        flag_mdio_ClkReq_0        = &H0
        write_mdio_ClkReqMdioSel_0_value = &H0
        flag_mdio_ClkReqMdioSel_0        = &H0
        write_mdio_AuxClkEnablep_value = &H0
        flag_mdio_AuxClkEnablep        = &H0
        write_mdio_AuxClkEnableMdioSel_value = &H0
        flag_mdio_AuxClkEnableMdioSel        = &H0
        write_MDIO_AUXP1_value = &H0
        flag_MDIO_AUXP1        = &H0
        write_mdio_LTTSM_P1AnaPwrDnPll_value = &H0
        flag_mdio_LTTSM_P1AnaPwrDnPll        = &H0
        write_mdio_LTTSM_P1AnaPwrDn_value = &H0
        flag_mdio_LTTSM_P1AnaPwrDn        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_pwrmgmt5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_L2_tx_eidle_ovr                       [10:10]          get_mdio_L2_tx_eidle_ovr
''                                                             set_mdio_L2_tx_eidle_ovr
''                                                             read_mdio_L2_tx_eidle_ovr
''                                                             write_mdio_L2_tx_eidle_ovr
''---------------------------------------------------------------------------------
'' mdio_L2_refclk_ovr                         [9:9]            get_mdio_L2_refclk_ovr
''                                                             set_mdio_L2_refclk_ovr
''                                                             read_mdio_L2_refclk_ovr
''                                                             write_mdio_L2_refclk_ovr
''---------------------------------------------------------------------------------
'' mdio_L2_iddq_ovr                           [8:8]            get_mdio_L2_iddq_ovr
''                                                             set_mdio_L2_iddq_ovr
''                                                             read_mdio_L2_iddq_ovr
''                                                             write_mdio_L2_iddq_ovr
''---------------------------------------------------------------------------------
'' mdio_rx_hiz_disable                        [7:7]            get_mdio_rx_hiz_disable
''                                                             set_mdio_rx_hiz_disable
''                                                             read_mdio_rx_hiz_disable
''                                                             write_mdio_rx_hiz_disable
''---------------------------------------------------------------------------------
'' mdio_RcPllPd_ovrd                          [6:6]            get_mdio_RcPllPd_ovrd
''                                                             set_mdio_RcPllPd_ovrd
''                                                             read_mdio_RcPllPd_ovrd
''                                                             write_mdio_RcPllPd_ovrd
''---------------------------------------------------------------------------------
'' mdio_RcPllPd_val                           [5:5]            get_mdio_RcPllPd_val
''                                                             set_mdio_RcPllPd_val
''                                                             read_mdio_RcPllPd_val
''                                                             write_mdio_RcPllPd_val
''---------------------------------------------------------------------------------
'' MTCMFP2E                                   [4:4]            get_MTCMFP2E
''                                                             set_MTCMFP2E
''                                                             read_MTCMFP2E
''                                                             write_MTCMFP2E
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt5
    Private write_mdio_L2_tx_eidle_ovr_value
    Private read_mdio_L2_tx_eidle_ovr_value
    Private flag_mdio_L2_tx_eidle_ovr
    Private write_mdio_L2_refclk_ovr_value
    Private read_mdio_L2_refclk_ovr_value
    Private flag_mdio_L2_refclk_ovr
    Private write_mdio_L2_iddq_ovr_value
    Private read_mdio_L2_iddq_ovr_value
    Private flag_mdio_L2_iddq_ovr
    Private write_mdio_rx_hiz_disable_value
    Private read_mdio_rx_hiz_disable_value
    Private flag_mdio_rx_hiz_disable
    Private write_mdio_RcPllPd_ovrd_value
    Private read_mdio_RcPllPd_ovrd_value
    Private flag_mdio_RcPllPd_ovrd
    Private write_mdio_RcPllPd_val_value
    Private read_mdio_RcPllPd_val_value
    Private flag_mdio_RcPllPd_val
    Private write_MTCMFP2E_value
    Private read_MTCMFP2E_value
    Private flag_MTCMFP2E

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

    Property Get get_mdio_L2_tx_eidle_ovr
        get_mdio_L2_tx_eidle_ovr = read_mdio_L2_tx_eidle_ovr_value
    End Property

    Property Let set_mdio_L2_tx_eidle_ovr(aData)
        write_mdio_L2_tx_eidle_ovr_value = aData
        flag_mdio_L2_tx_eidle_ovr        = &H1
    End Property

    Property Get read_mdio_L2_tx_eidle_ovr
        read
        read_mdio_L2_tx_eidle_ovr = read_mdio_L2_tx_eidle_ovr_value
    End Property

    Property Let write_mdio_L2_tx_eidle_ovr(aData)
        set_mdio_L2_tx_eidle_ovr = aData
        write
    End Property

    Property Get get_mdio_L2_refclk_ovr
        get_mdio_L2_refclk_ovr = read_mdio_L2_refclk_ovr_value
    End Property

    Property Let set_mdio_L2_refclk_ovr(aData)
        write_mdio_L2_refclk_ovr_value = aData
        flag_mdio_L2_refclk_ovr        = &H1
    End Property

    Property Get read_mdio_L2_refclk_ovr
        read
        read_mdio_L2_refclk_ovr = read_mdio_L2_refclk_ovr_value
    End Property

    Property Let write_mdio_L2_refclk_ovr(aData)
        set_mdio_L2_refclk_ovr = aData
        write
    End Property

    Property Get get_mdio_L2_iddq_ovr
        get_mdio_L2_iddq_ovr = read_mdio_L2_iddq_ovr_value
    End Property

    Property Let set_mdio_L2_iddq_ovr(aData)
        write_mdio_L2_iddq_ovr_value = aData
        flag_mdio_L2_iddq_ovr        = &H1
    End Property

    Property Get read_mdio_L2_iddq_ovr
        read
        read_mdio_L2_iddq_ovr = read_mdio_L2_iddq_ovr_value
    End Property

    Property Let write_mdio_L2_iddq_ovr(aData)
        set_mdio_L2_iddq_ovr = aData
        write
    End Property

    Property Get get_mdio_rx_hiz_disable
        get_mdio_rx_hiz_disable = read_mdio_rx_hiz_disable_value
    End Property

    Property Let set_mdio_rx_hiz_disable(aData)
        write_mdio_rx_hiz_disable_value = aData
        flag_mdio_rx_hiz_disable        = &H1
    End Property

    Property Get read_mdio_rx_hiz_disable
        read
        read_mdio_rx_hiz_disable = read_mdio_rx_hiz_disable_value
    End Property

    Property Let write_mdio_rx_hiz_disable(aData)
        set_mdio_rx_hiz_disable = aData
        write
    End Property

    Property Get get_mdio_RcPllPd_ovrd
        get_mdio_RcPllPd_ovrd = read_mdio_RcPllPd_ovrd_value
    End Property

    Property Let set_mdio_RcPllPd_ovrd(aData)
        write_mdio_RcPllPd_ovrd_value = aData
        flag_mdio_RcPllPd_ovrd        = &H1
    End Property

    Property Get read_mdio_RcPllPd_ovrd
        read
        read_mdio_RcPllPd_ovrd = read_mdio_RcPllPd_ovrd_value
    End Property

    Property Let write_mdio_RcPllPd_ovrd(aData)
        set_mdio_RcPllPd_ovrd = aData
        write
    End Property

    Property Get get_mdio_RcPllPd_val
        get_mdio_RcPllPd_val = read_mdio_RcPllPd_val_value
    End Property

    Property Let set_mdio_RcPllPd_val(aData)
        write_mdio_RcPllPd_val_value = aData
        flag_mdio_RcPllPd_val        = &H1
    End Property

    Property Get read_mdio_RcPllPd_val
        read
        read_mdio_RcPllPd_val = read_mdio_RcPllPd_val_value
    End Property

    Property Let write_mdio_RcPllPd_val(aData)
        set_mdio_RcPllPd_val = aData
        write
    End Property

    Property Get get_MTCMFP2E
        get_MTCMFP2E = read_MTCMFP2E_value
    End Property

    Property Let set_MTCMFP2E(aData)
        write_MTCMFP2E_value = aData
        flag_MTCMFP2E        = &H1
    End Property

    Property Get read_MTCMFP2E
        read
        read_MTCMFP2E = read_MTCMFP2E_value
    End Property

    Property Let write_MTCMFP2E(aData)
        set_MTCMFP2E = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_L2_tx_eidle_ovr_value = rightShift(data_low, 10) and &H1
        read_mdio_L2_refclk_ovr_value = rightShift(data_low, 9) and &H1
        read_mdio_L2_iddq_ovr_value = rightShift(data_low, 8) and &H1
        read_mdio_rx_hiz_disable_value = rightShift(data_low, 7) and &H1
        read_mdio_RcPllPd_ovrd_value = rightShift(data_low, 6) and &H1
        read_mdio_RcPllPd_val_value = rightShift(data_low, 5) and &H1
        read_MTCMFP2E_value = rightShift(data_low, 4) and &H1

    End Sub

    Sub write
        If flag_mdio_L2_tx_eidle_ovr = &H0 or flag_mdio_L2_refclk_ovr = &H0 or flag_mdio_L2_iddq_ovr = &H0 or flag_mdio_rx_hiz_disable = &H0 or flag_mdio_RcPllPd_ovrd = &H0 or flag_mdio_RcPllPd_val = &H0 or flag_MTCMFP2E = &H0 Then read
        If flag_mdio_L2_tx_eidle_ovr = &H0 Then write_mdio_L2_tx_eidle_ovr_value = get_mdio_L2_tx_eidle_ovr
        If flag_mdio_L2_refclk_ovr = &H0 Then write_mdio_L2_refclk_ovr_value = get_mdio_L2_refclk_ovr
        If flag_mdio_L2_iddq_ovr = &H0 Then write_mdio_L2_iddq_ovr_value = get_mdio_L2_iddq_ovr
        If flag_mdio_rx_hiz_disable = &H0 Then write_mdio_rx_hiz_disable_value = get_mdio_rx_hiz_disable
        If flag_mdio_RcPllPd_ovrd = &H0 Then write_mdio_RcPllPd_ovrd_value = get_mdio_RcPllPd_ovrd
        If flag_mdio_RcPllPd_val = &H0 Then write_mdio_RcPllPd_val_value = get_mdio_RcPllPd_val
        If flag_MTCMFP2E = &H0 Then write_MTCMFP2E_value = get_MTCMFP2E

        regValue = leftShift((write_mdio_L2_tx_eidle_ovr_value and &H1), 10) + leftShift((write_mdio_L2_refclk_ovr_value and &H1), 9) + leftShift((write_mdio_L2_iddq_ovr_value and &H1), 8) + leftShift((write_mdio_rx_hiz_disable_value and &H1), 7) + leftShift((write_mdio_RcPllPd_ovrd_value and &H1), 6) + leftShift((write_mdio_RcPllPd_val_value and &H1), 5) + leftShift((write_MTCMFP2E_value and &H1), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_L2_tx_eidle_ovr_value = rightShift(data_low, 10) and &H1
        read_mdio_L2_refclk_ovr_value = rightShift(data_low, 9) and &H1
        read_mdio_L2_iddq_ovr_value = rightShift(data_low, 8) and &H1
        read_mdio_rx_hiz_disable_value = rightShift(data_low, 7) and &H1
        read_mdio_RcPllPd_ovrd_value = rightShift(data_low, 6) and &H1
        read_mdio_RcPllPd_val_value = rightShift(data_low, 5) and &H1
        read_MTCMFP2E_value = rightShift(data_low, 4) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_L2_tx_eidle_ovr_value = &H0
        flag_mdio_L2_tx_eidle_ovr        = &H0
        write_mdio_L2_refclk_ovr_value = &H0
        flag_mdio_L2_refclk_ovr        = &H0
        write_mdio_L2_iddq_ovr_value = &H0
        flag_mdio_L2_iddq_ovr        = &H0
        write_mdio_rx_hiz_disable_value = &H0
        flag_mdio_rx_hiz_disable        = &H0
        write_mdio_RcPllPd_ovrd_value = &H0
        flag_mdio_RcPllPd_ovrd        = &H0
        write_mdio_RcPllPd_val_value = &H0
        flag_mdio_RcPllPd_val        = &H0
        write_MTCMFP2E_value = &H0
        flag_MTCMFP2E        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_pwrmgmt6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_ClkReq_3                              [5:5]            get_mdio_ClkReq_3
''                                                             set_mdio_ClkReq_3
''                                                             read_mdio_ClkReq_3
''                                                             write_mdio_ClkReq_3
''---------------------------------------------------------------------------------
'' mdio_ClkReqMdioSel_3                       [4:4]            get_mdio_ClkReqMdioSel_3
''                                                             set_mdio_ClkReqMdioSel_3
''                                                             read_mdio_ClkReqMdioSel_3
''                                                             write_mdio_ClkReqMdioSel_3
''---------------------------------------------------------------------------------
'' mdio_ClkReq_2                              [3:3]            get_mdio_ClkReq_2
''                                                             set_mdio_ClkReq_2
''                                                             read_mdio_ClkReq_2
''                                                             write_mdio_ClkReq_2
''---------------------------------------------------------------------------------
'' mdio_ClkReqMdioSel_2                       [2:2]            get_mdio_ClkReqMdioSel_2
''                                                             set_mdio_ClkReqMdioSel_2
''                                                             read_mdio_ClkReqMdioSel_2
''                                                             write_mdio_ClkReqMdioSel_2
''---------------------------------------------------------------------------------
'' mdio_ClkReq_1                              [1:1]            get_mdio_ClkReq_1
''                                                             set_mdio_ClkReq_1
''                                                             read_mdio_ClkReq_1
''                                                             write_mdio_ClkReq_1
''---------------------------------------------------------------------------------
'' mdio_ClkReqMdioSel_1                       [0:0]            get_mdio_ClkReqMdioSel_1
''                                                             set_mdio_ClkReqMdioSel_1
''                                                             read_mdio_ClkReqMdioSel_1
''                                                             write_mdio_ClkReqMdioSel_1
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt6
    Private write_mdio_ClkReq_3_value
    Private read_mdio_ClkReq_3_value
    Private flag_mdio_ClkReq_3
    Private write_mdio_ClkReqMdioSel_3_value
    Private read_mdio_ClkReqMdioSel_3_value
    Private flag_mdio_ClkReqMdioSel_3
    Private write_mdio_ClkReq_2_value
    Private read_mdio_ClkReq_2_value
    Private flag_mdio_ClkReq_2
    Private write_mdio_ClkReqMdioSel_2_value
    Private read_mdio_ClkReqMdioSel_2_value
    Private flag_mdio_ClkReqMdioSel_2
    Private write_mdio_ClkReq_1_value
    Private read_mdio_ClkReq_1_value
    Private flag_mdio_ClkReq_1
    Private write_mdio_ClkReqMdioSel_1_value
    Private read_mdio_ClkReqMdioSel_1_value
    Private flag_mdio_ClkReqMdioSel_1

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

    Property Get get_mdio_ClkReq_3
        get_mdio_ClkReq_3 = read_mdio_ClkReq_3_value
    End Property

    Property Let set_mdio_ClkReq_3(aData)
        write_mdio_ClkReq_3_value = aData
        flag_mdio_ClkReq_3        = &H1
    End Property

    Property Get read_mdio_ClkReq_3
        read
        read_mdio_ClkReq_3 = read_mdio_ClkReq_3_value
    End Property

    Property Let write_mdio_ClkReq_3(aData)
        set_mdio_ClkReq_3 = aData
        write
    End Property

    Property Get get_mdio_ClkReqMdioSel_3
        get_mdio_ClkReqMdioSel_3 = read_mdio_ClkReqMdioSel_3_value
    End Property

    Property Let set_mdio_ClkReqMdioSel_3(aData)
        write_mdio_ClkReqMdioSel_3_value = aData
        flag_mdio_ClkReqMdioSel_3        = &H1
    End Property

    Property Get read_mdio_ClkReqMdioSel_3
        read
        read_mdio_ClkReqMdioSel_3 = read_mdio_ClkReqMdioSel_3_value
    End Property

    Property Let write_mdio_ClkReqMdioSel_3(aData)
        set_mdio_ClkReqMdioSel_3 = aData
        write
    End Property

    Property Get get_mdio_ClkReq_2
        get_mdio_ClkReq_2 = read_mdio_ClkReq_2_value
    End Property

    Property Let set_mdio_ClkReq_2(aData)
        write_mdio_ClkReq_2_value = aData
        flag_mdio_ClkReq_2        = &H1
    End Property

    Property Get read_mdio_ClkReq_2
        read
        read_mdio_ClkReq_2 = read_mdio_ClkReq_2_value
    End Property

    Property Let write_mdio_ClkReq_2(aData)
        set_mdio_ClkReq_2 = aData
        write
    End Property

    Property Get get_mdio_ClkReqMdioSel_2
        get_mdio_ClkReqMdioSel_2 = read_mdio_ClkReqMdioSel_2_value
    End Property

    Property Let set_mdio_ClkReqMdioSel_2(aData)
        write_mdio_ClkReqMdioSel_2_value = aData
        flag_mdio_ClkReqMdioSel_2        = &H1
    End Property

    Property Get read_mdio_ClkReqMdioSel_2
        read
        read_mdio_ClkReqMdioSel_2 = read_mdio_ClkReqMdioSel_2_value
    End Property

    Property Let write_mdio_ClkReqMdioSel_2(aData)
        set_mdio_ClkReqMdioSel_2 = aData
        write
    End Property

    Property Get get_mdio_ClkReq_1
        get_mdio_ClkReq_1 = read_mdio_ClkReq_1_value
    End Property

    Property Let set_mdio_ClkReq_1(aData)
        write_mdio_ClkReq_1_value = aData
        flag_mdio_ClkReq_1        = &H1
    End Property

    Property Get read_mdio_ClkReq_1
        read
        read_mdio_ClkReq_1 = read_mdio_ClkReq_1_value
    End Property

    Property Let write_mdio_ClkReq_1(aData)
        set_mdio_ClkReq_1 = aData
        write
    End Property

    Property Get get_mdio_ClkReqMdioSel_1
        get_mdio_ClkReqMdioSel_1 = read_mdio_ClkReqMdioSel_1_value
    End Property

    Property Let set_mdio_ClkReqMdioSel_1(aData)
        write_mdio_ClkReqMdioSel_1_value = aData
        flag_mdio_ClkReqMdioSel_1        = &H1
    End Property

    Property Get read_mdio_ClkReqMdioSel_1
        read
        read_mdio_ClkReqMdioSel_1 = read_mdio_ClkReqMdioSel_1_value
    End Property

    Property Let write_mdio_ClkReqMdioSel_1(aData)
        set_mdio_ClkReqMdioSel_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_ClkReq_3_value = rightShift(data_low, 5) and &H1
        read_mdio_ClkReqMdioSel_3_value = rightShift(data_low, 4) and &H1
        read_mdio_ClkReq_2_value = rightShift(data_low, 3) and &H1
        read_mdio_ClkReqMdioSel_2_value = rightShift(data_low, 2) and &H1
        read_mdio_ClkReq_1_value = rightShift(data_low, 1) and &H1
        mdio_ClkReqMdioSel_1_mask = &H1
        if data_low > LONG_MAX then
            if mdio_ClkReqMdioSel_1_mask = mask then
                read_mdio_ClkReqMdioSel_1_value = data_low
            else
                read_mdio_ClkReqMdioSel_1_value = (data_low - H8000_0000) and mdio_ClkReqMdioSel_1_mask
            end If
        else
            read_mdio_ClkReqMdioSel_1_value = data_low and mdio_ClkReqMdioSel_1_mask
        end If

    End Sub

    Sub write
        If flag_mdio_ClkReq_3 = &H0 or flag_mdio_ClkReqMdioSel_3 = &H0 or flag_mdio_ClkReq_2 = &H0 or flag_mdio_ClkReqMdioSel_2 = &H0 or flag_mdio_ClkReq_1 = &H0 or flag_mdio_ClkReqMdioSel_1 = &H0 Then read
        If flag_mdio_ClkReq_3 = &H0 Then write_mdio_ClkReq_3_value = get_mdio_ClkReq_3
        If flag_mdio_ClkReqMdioSel_3 = &H0 Then write_mdio_ClkReqMdioSel_3_value = get_mdio_ClkReqMdioSel_3
        If flag_mdio_ClkReq_2 = &H0 Then write_mdio_ClkReq_2_value = get_mdio_ClkReq_2
        If flag_mdio_ClkReqMdioSel_2 = &H0 Then write_mdio_ClkReqMdioSel_2_value = get_mdio_ClkReqMdioSel_2
        If flag_mdio_ClkReq_1 = &H0 Then write_mdio_ClkReq_1_value = get_mdio_ClkReq_1
        If flag_mdio_ClkReqMdioSel_1 = &H0 Then write_mdio_ClkReqMdioSel_1_value = get_mdio_ClkReqMdioSel_1

        regValue = leftShift((write_mdio_ClkReq_3_value and &H1), 5) + leftShift((write_mdio_ClkReqMdioSel_3_value and &H1), 4) + leftShift((write_mdio_ClkReq_2_value and &H1), 3) + leftShift((write_mdio_ClkReqMdioSel_2_value and &H1), 2) + leftShift((write_mdio_ClkReq_1_value and &H1), 1) + leftShift((write_mdio_ClkReqMdioSel_1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_ClkReq_3_value = rightShift(data_low, 5) and &H1
        read_mdio_ClkReqMdioSel_3_value = rightShift(data_low, 4) and &H1
        read_mdio_ClkReq_2_value = rightShift(data_low, 3) and &H1
        read_mdio_ClkReqMdioSel_2_value = rightShift(data_low, 2) and &H1
        read_mdio_ClkReq_1_value = rightShift(data_low, 1) and &H1
        mdio_ClkReqMdioSel_1_mask = &H1
        if data_low > LONG_MAX then
            if mdio_ClkReqMdioSel_1_mask = mask then
                read_mdio_ClkReqMdioSel_1_value = data_low
            else
                read_mdio_ClkReqMdioSel_1_value = (data_low - H8000_0000) and mdio_ClkReqMdioSel_1_mask
            end If
        else
            read_mdio_ClkReqMdioSel_1_value = data_low and mdio_ClkReqMdioSel_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_ClkReq_3_value = &H0
        flag_mdio_ClkReq_3        = &H0
        write_mdio_ClkReqMdioSel_3_value = &H0
        flag_mdio_ClkReqMdioSel_3        = &H0
        write_mdio_ClkReq_2_value = &H0
        flag_mdio_ClkReq_2        = &H0
        write_mdio_ClkReqMdioSel_2_value = &H0
        flag_mdio_ClkReqMdioSel_2        = &H0
        write_mdio_ClkReq_1_value = &H0
        flag_mdio_ClkReq_1        = &H0
        write_mdio_ClkReqMdioSel_1_value = &H0
        flag_mdio_ClkReqMdioSel_1        = &H0
    End Sub
End Class


'' @REGISTER : PCIE2__SGMIIPCIE_X1_debug_hook_l0_entry_state_timer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' L0_entry_state_timer                       [15:0]           get_L0_entry_state_timer
''                                                             set_L0_entry_state_timer
''                                                             read_L0_entry_state_timer
''                                                             write_L0_entry_state_timer
''---------------------------------------------------------------------------------
Class REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_l0_entry_state_timer
    Private write_L0_entry_state_timer_value
    Private read_L0_entry_state_timer_value
    Private flag_L0_entry_state_timer

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

    Property Get get_L0_entry_state_timer
        get_L0_entry_state_timer = read_L0_entry_state_timer_value
    End Property

    Property Let set_L0_entry_state_timer(aData)
        write_L0_entry_state_timer_value = aData
        flag_L0_entry_state_timer        = &H1
    End Property

    Property Get read_L0_entry_state_timer
        read
        read_L0_entry_state_timer = read_L0_entry_state_timer_value
    End Property

    Property Let write_L0_entry_state_timer(aData)
        set_L0_entry_state_timer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        L0_entry_state_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if L0_entry_state_timer_mask = mask then
                read_L0_entry_state_timer_value = data_low
            else
                read_L0_entry_state_timer_value = (data_low - H8000_0000) and L0_entry_state_timer_mask
            end If
        else
            read_L0_entry_state_timer_value = data_low and L0_entry_state_timer_mask
        end If

    End Sub

    Sub write
        If flag_L0_entry_state_timer = &H0 Then read
        If flag_L0_entry_state_timer = &H0 Then write_L0_entry_state_timer_value = get_L0_entry_state_timer

        regValue = leftShift((write_L0_entry_state_timer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        L0_entry_state_timer_mask = &Hffff
        if data_low > LONG_MAX then
            if L0_entry_state_timer_mask = mask then
                read_L0_entry_state_timer_value = data_low
            else
                read_L0_entry_state_timer_value = (data_low - H8000_0000) and L0_entry_state_timer_mask
            end If
        else
            read_L0_entry_state_timer_value = data_low and L0_entry_state_timer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_L0_entry_state_timer_value = &H0
        flag_L0_entry_state_timer        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCIE2__SGMIIPCIE_X1_INSTANCE

    Public debug_hook_ctrl_0
    Public debug_hook_l1x_state_timer
    Public debug_hook_l0_state_timer
    Public txei_mask_off_timer
    Public txei_mask_on_timer
    Public lfckcnt
    Public pwrmgmt0
    Public pwrmgmt1
    Public pwrmgmt2
    Public pwrmgmt3
    Public pwrmgmt4
    Public pwrmgmt5
    Public pwrmgmt6
    Public debug_hook_l0_entry_state_timer


    Public default function Init(aBaseAddr)
        Set debug_hook_ctrl_0 = (New REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_ctrl_0)(aBaseAddr, 16)
        Set debug_hook_l1x_state_timer = (New REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_l1x_state_timer)(aBaseAddr, 16)
        Set debug_hook_l0_state_timer = (New REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_l0_state_timer)(aBaseAddr, 16)
        Set txei_mask_off_timer = (New REGISTER_PCIE2__SGMIIPCIE_X1_txei_mask_off_timer)(aBaseAddr, 16)
        Set txei_mask_on_timer = (New REGISTER_PCIE2__SGMIIPCIE_X1_txei_mask_on_timer)(aBaseAddr, 16)
        Set lfckcnt = (New REGISTER_PCIE2__SGMIIPCIE_X1_lfckcnt)(aBaseAddr, 16)
        Set pwrmgmt0 = (New REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt0)(aBaseAddr, 16)
        Set pwrmgmt1 = (New REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt1)(aBaseAddr, 16)
        Set pwrmgmt2 = (New REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt2)(aBaseAddr, 16)
        Set pwrmgmt3 = (New REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt3)(aBaseAddr, 16)
        Set pwrmgmt4 = (New REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt4)(aBaseAddr, 16)
        Set pwrmgmt5 = (New REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt5)(aBaseAddr, 16)
        Set pwrmgmt6 = (New REGISTER_PCIE2__SGMIIPCIE_X1_pwrmgmt6)(aBaseAddr, 16)
        Set debug_hook_l0_entry_state_timer = (New REGISTER_PCIE2__SGMIIPCIE_X1_debug_hook_l0_entry_state_timer)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCIE2__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PCIE2__SGMIIPCIE_X1.Add ((New PCIE2__SGMIIPCIE_X1_INSTANCE)(&H4ade2400))


