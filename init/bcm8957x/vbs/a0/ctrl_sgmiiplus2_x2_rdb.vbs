

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


'' @REGISTER : CTRL_SGMIIPLUS2_X2_lanectrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' gloop1g                                    [8:8]            get_gloop1g
''                                                             set_gloop1g
''                                                             read_gloop1g
''                                                             write_gloop1g
''---------------------------------------------------------------------------------
'' PMD_txdisable                              [4:4]            get_PMD_txdisable
''                                                             set_PMD_txdisable
''                                                             read_PMD_txdisable
''                                                             write_PMD_txdisable
''---------------------------------------------------------------------------------
'' eden                                       [3:3]            get_eden
''                                                             set_eden
''                                                             read_eden
''                                                             write_eden
''---------------------------------------------------------------------------------
'' cdet                                       [2:2]            get_cdet
''                                                             set_cdet
''                                                             read_cdet
''                                                             write_cdet
''---------------------------------------------------------------------------------
'' pcs_en_rx                                  [1:1]            get_pcs_en_rx
''                                                             set_pcs_en_rx
''                                                             read_pcs_en_rx
''                                                             write_pcs_en_rx
''---------------------------------------------------------------------------------
'' pcs_en_tx                                  [0:0]            get_pcs_en_tx
''                                                             set_pcs_en_tx
''                                                             read_pcs_en_tx
''                                                             write_pcs_en_tx
''---------------------------------------------------------------------------------
Class REGISTER_CTRL_SGMIIPLUS2_X2_lanectrl
    Private write_gloop1g_value
    Private read_gloop1g_value
    Private flag_gloop1g
    Private write_PMD_txdisable_value
    Private read_PMD_txdisable_value
    Private flag_PMD_txdisable
    Private write_eden_value
    Private read_eden_value
    Private flag_eden
    Private write_cdet_value
    Private read_cdet_value
    Private flag_cdet
    Private write_pcs_en_rx_value
    Private read_pcs_en_rx_value
    Private flag_pcs_en_rx
    Private write_pcs_en_tx_value
    Private read_pcs_en_tx_value
    Private flag_pcs_en_tx

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

    Property Get get_gloop1g
        get_gloop1g = read_gloop1g_value
    End Property

    Property Let set_gloop1g(aData)
        write_gloop1g_value = aData
        flag_gloop1g        = &H1
    End Property

    Property Get read_gloop1g
        read
        read_gloop1g = read_gloop1g_value
    End Property

    Property Let write_gloop1g(aData)
        set_gloop1g = aData
        write
    End Property

    Property Get get_PMD_txdisable
        get_PMD_txdisable = read_PMD_txdisable_value
    End Property

    Property Let set_PMD_txdisable(aData)
        write_PMD_txdisable_value = aData
        flag_PMD_txdisable        = &H1
    End Property

    Property Get read_PMD_txdisable
        read
        read_PMD_txdisable = read_PMD_txdisable_value
    End Property

    Property Let write_PMD_txdisable(aData)
        set_PMD_txdisable = aData
        write
    End Property

    Property Get get_eden
        get_eden = read_eden_value
    End Property

    Property Let set_eden(aData)
        write_eden_value = aData
        flag_eden        = &H1
    End Property

    Property Get read_eden
        read
        read_eden = read_eden_value
    End Property

    Property Let write_eden(aData)
        set_eden = aData
        write
    End Property

    Property Get get_cdet
        get_cdet = read_cdet_value
    End Property

    Property Let set_cdet(aData)
        write_cdet_value = aData
        flag_cdet        = &H1
    End Property

    Property Get read_cdet
        read
        read_cdet = read_cdet_value
    End Property

    Property Let write_cdet(aData)
        set_cdet = aData
        write
    End Property

    Property Get get_pcs_en_rx
        get_pcs_en_rx = read_pcs_en_rx_value
    End Property

    Property Let set_pcs_en_rx(aData)
        write_pcs_en_rx_value = aData
        flag_pcs_en_rx        = &H1
    End Property

    Property Get read_pcs_en_rx
        read
        read_pcs_en_rx = read_pcs_en_rx_value
    End Property

    Property Let write_pcs_en_rx(aData)
        set_pcs_en_rx = aData
        write
    End Property

    Property Get get_pcs_en_tx
        get_pcs_en_tx = read_pcs_en_tx_value
    End Property

    Property Let set_pcs_en_tx(aData)
        write_pcs_en_tx_value = aData
        flag_pcs_en_tx        = &H1
    End Property

    Property Get read_pcs_en_tx
        read
        read_pcs_en_tx = read_pcs_en_tx_value
    End Property

    Property Let write_pcs_en_tx(aData)
        set_pcs_en_tx = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_gloop1g_value = rightShift(data_low, 8) and &H1
        read_PMD_txdisable_value = rightShift(data_low, 4) and &H1
        read_eden_value = rightShift(data_low, 3) and &H1
        read_cdet_value = rightShift(data_low, 2) and &H1
        read_pcs_en_rx_value = rightShift(data_low, 1) and &H1
        pcs_en_tx_mask = &H1
        if data_low > LONG_MAX then
            if pcs_en_tx_mask = mask then
                read_pcs_en_tx_value = data_low
            else
                read_pcs_en_tx_value = (data_low - H8000_0000) and pcs_en_tx_mask
            end If
        else
            read_pcs_en_tx_value = data_low and pcs_en_tx_mask
        end If

    End Sub

    Sub write
        If flag_gloop1g = &H0 or flag_PMD_txdisable = &H0 or flag_eden = &H0 or flag_cdet = &H0 or flag_pcs_en_rx = &H0 or flag_pcs_en_tx = &H0 Then read
        If flag_gloop1g = &H0 Then write_gloop1g_value = get_gloop1g
        If flag_PMD_txdisable = &H0 Then write_PMD_txdisable_value = get_PMD_txdisable
        If flag_eden = &H0 Then write_eden_value = get_eden
        If flag_cdet = &H0 Then write_cdet_value = get_cdet
        If flag_pcs_en_rx = &H0 Then write_pcs_en_rx_value = get_pcs_en_rx
        If flag_pcs_en_tx = &H0 Then write_pcs_en_tx_value = get_pcs_en_tx

        regValue = leftShift((write_gloop1g_value and &H1), 8) + leftShift((write_PMD_txdisable_value and &H1), 4) + leftShift((write_eden_value and &H1), 3) + leftShift((write_cdet_value and &H1), 2) + leftShift((write_pcs_en_rx_value and &H1), 1) + leftShift((write_pcs_en_tx_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_gloop1g_value = rightShift(data_low, 8) and &H1
        read_PMD_txdisable_value = rightShift(data_low, 4) and &H1
        read_eden_value = rightShift(data_low, 3) and &H1
        read_cdet_value = rightShift(data_low, 2) and &H1
        read_pcs_en_rx_value = rightShift(data_low, 1) and &H1
        pcs_en_tx_mask = &H1
        if data_low > LONG_MAX then
            if pcs_en_tx_mask = mask then
                read_pcs_en_tx_value = data_low
            else
                read_pcs_en_tx_value = (data_low - H8000_0000) and pcs_en_tx_mask
            end If
        else
            read_pcs_en_tx_value = data_low and pcs_en_tx_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_gloop1g_value = &H0
        flag_gloop1g        = &H0
        write_PMD_txdisable_value = &H0
        flag_PMD_txdisable        = &H0
        write_eden_value = &H0
        flag_eden        = &H0
        write_cdet_value = &H0
        flag_cdet        = &H0
        write_pcs_en_rx_value = &H0
        flag_pcs_en_rx        = &H0
        write_pcs_en_tx_value = &H0
        flag_pcs_en_tx        = &H0
    End Sub
End Class


'' @REGISTER : CTRL_SGMIIPLUS2_X2_mode1g
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx1g_mode                                  [3:2]            get_rx1g_mode
''                                                             set_rx1g_mode
''                                                             read_rx1g_mode
''                                                             write_rx1g_mode
''---------------------------------------------------------------------------------
'' tx1g_mode                                  [1:0]            get_tx1g_mode
''                                                             set_tx1g_mode
''                                                             read_tx1g_mode
''                                                             write_tx1g_mode
''---------------------------------------------------------------------------------
Class REGISTER_CTRL_SGMIIPLUS2_X2_mode1g
    Private write_rx1g_mode_value
    Private read_rx1g_mode_value
    Private flag_rx1g_mode
    Private write_tx1g_mode_value
    Private read_tx1g_mode_value
    Private flag_tx1g_mode

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

    Property Get get_rx1g_mode
        get_rx1g_mode = read_rx1g_mode_value
    End Property

    Property Let set_rx1g_mode(aData)
        write_rx1g_mode_value = aData
        flag_rx1g_mode        = &H1
    End Property

    Property Get read_rx1g_mode
        read
        read_rx1g_mode = read_rx1g_mode_value
    End Property

    Property Let write_rx1g_mode(aData)
        set_rx1g_mode = aData
        write
    End Property

    Property Get get_tx1g_mode
        get_tx1g_mode = read_tx1g_mode_value
    End Property

    Property Let set_tx1g_mode(aData)
        write_tx1g_mode_value = aData
        flag_tx1g_mode        = &H1
    End Property

    Property Get read_tx1g_mode
        read
        read_tx1g_mode = read_tx1g_mode_value
    End Property

    Property Let write_tx1g_mode(aData)
        set_tx1g_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx1g_mode_value = rightShift(data_low, 2) and &H3
        tx1g_mode_mask = &H3
        if data_low > LONG_MAX then
            if tx1g_mode_mask = mask then
                read_tx1g_mode_value = data_low
            else
                read_tx1g_mode_value = (data_low - H8000_0000) and tx1g_mode_mask
            end If
        else
            read_tx1g_mode_value = data_low and tx1g_mode_mask
        end If

    End Sub

    Sub write
        If flag_rx1g_mode = &H0 or flag_tx1g_mode = &H0 Then read
        If flag_rx1g_mode = &H0 Then write_rx1g_mode_value = get_rx1g_mode
        If flag_tx1g_mode = &H0 Then write_tx1g_mode_value = get_tx1g_mode

        regValue = leftShift((write_rx1g_mode_value and &H3), 2) + leftShift((write_tx1g_mode_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx1g_mode_value = rightShift(data_low, 2) and &H3
        tx1g_mode_mask = &H3
        if data_low > LONG_MAX then
            if tx1g_mode_mask = mask then
                read_tx1g_mode_value = data_low
            else
                read_tx1g_mode_value = (data_low - H8000_0000) and tx1g_mode_mask
            end If
        else
            read_tx1g_mode_value = data_low and tx1g_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx1g_mode_value = &H0
        flag_rx1g_mode        = &H0
        write_tx1g_mode_value = &H0
        flag_tx1g_mode        = &H0
    End Sub
End Class


'' @REGISTER : CTRL_SGMIIPLUS2_X2_pwrrst
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reset_rx                                   [9:9]            get_reset_rx
''                                                             set_reset_rx
''                                                             read_reset_rx
''                                                             write_reset_rx
''---------------------------------------------------------------------------------
'' pwrdn_rx                                   [8:8]            get_pwrdn_rx
''                                                             set_pwrdn_rx
''                                                             read_pwrdn_rx
''                                                             write_pwrdn_rx
''---------------------------------------------------------------------------------
'' reset_tx                                   [1:1]            get_reset_tx
''                                                             set_reset_tx
''                                                             read_reset_tx
''                                                             write_reset_tx
''---------------------------------------------------------------------------------
'' pwrdn_tx                                   [0:0]            get_pwrdn_tx
''                                                             set_pwrdn_tx
''                                                             read_pwrdn_tx
''                                                             write_pwrdn_tx
''---------------------------------------------------------------------------------
Class REGISTER_CTRL_SGMIIPLUS2_X2_pwrrst
    Private write_reset_rx_value
    Private read_reset_rx_value
    Private flag_reset_rx
    Private write_pwrdn_rx_value
    Private read_pwrdn_rx_value
    Private flag_pwrdn_rx
    Private write_reset_tx_value
    Private read_reset_tx_value
    Private flag_reset_tx
    Private write_pwrdn_tx_value
    Private read_pwrdn_tx_value
    Private flag_pwrdn_tx

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

    Property Get get_reset_rx
        get_reset_rx = read_reset_rx_value
    End Property

    Property Let set_reset_rx(aData)
        write_reset_rx_value = aData
        flag_reset_rx        = &H1
    End Property

    Property Get read_reset_rx
        read
        read_reset_rx = read_reset_rx_value
    End Property

    Property Let write_reset_rx(aData)
        set_reset_rx = aData
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

    Property Get get_reset_tx
        get_reset_tx = read_reset_tx_value
    End Property

    Property Let set_reset_tx(aData)
        write_reset_tx_value = aData
        flag_reset_tx        = &H1
    End Property

    Property Get read_reset_tx
        read
        read_reset_tx = read_reset_tx_value
    End Property

    Property Let write_reset_tx(aData)
        set_reset_tx = aData
        write
    End Property

    Property Get get_pwrdn_tx
        get_pwrdn_tx = read_pwrdn_tx_value
    End Property

    Property Let set_pwrdn_tx(aData)
        write_pwrdn_tx_value = aData
        flag_pwrdn_tx        = &H1
    End Property

    Property Get read_pwrdn_tx
        read
        read_pwrdn_tx = read_pwrdn_tx_value
    End Property

    Property Let write_pwrdn_tx(aData)
        set_pwrdn_tx = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reset_rx_value = rightShift(data_low, 9) and &H1
        read_pwrdn_rx_value = rightShift(data_low, 8) and &H1
        read_reset_tx_value = rightShift(data_low, 1) and &H1
        pwrdn_tx_mask = &H1
        if data_low > LONG_MAX then
            if pwrdn_tx_mask = mask then
                read_pwrdn_tx_value = data_low
            else
                read_pwrdn_tx_value = (data_low - H8000_0000) and pwrdn_tx_mask
            end If
        else
            read_pwrdn_tx_value = data_low and pwrdn_tx_mask
        end If

    End Sub

    Sub write
        If flag_reset_rx = &H0 or flag_pwrdn_rx = &H0 or flag_reset_tx = &H0 or flag_pwrdn_tx = &H0 Then read
        If flag_reset_rx = &H0 Then write_reset_rx_value = get_reset_rx
        If flag_pwrdn_rx = &H0 Then write_pwrdn_rx_value = get_pwrdn_rx
        If flag_reset_tx = &H0 Then write_reset_tx_value = get_reset_tx
        If flag_pwrdn_tx = &H0 Then write_pwrdn_tx_value = get_pwrdn_tx

        regValue = leftShift((write_reset_rx_value and &H1), 9) + leftShift((write_pwrdn_rx_value and &H1), 8) + leftShift((write_reset_tx_value and &H1), 1) + leftShift((write_pwrdn_tx_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reset_rx_value = rightShift(data_low, 9) and &H1
        read_pwrdn_rx_value = rightShift(data_low, 8) and &H1
        read_reset_tx_value = rightShift(data_low, 1) and &H1
        pwrdn_tx_mask = &H1
        if data_low > LONG_MAX then
            if pwrdn_tx_mask = mask then
                read_pwrdn_tx_value = data_low
            else
                read_pwrdn_tx_value = (data_low - H8000_0000) and pwrdn_tx_mask
            end If
        else
            read_pwrdn_tx_value = data_low and pwrdn_tx_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reset_rx_value = &H0
        flag_reset_rx        = &H0
        write_pwrdn_rx_value = &H0
        flag_pwrdn_rx        = &H0
        write_reset_tx_value = &H0
        flag_reset_tx        = &H0
        write_pwrdn_tx_value = &H0
        flag_pwrdn_tx        = &H0
    End Sub
End Class


'' @REGISTER : CTRL_SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_CTRL_SGMIIPLUS2_X2_blockaddress
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

Class CTRL_SGMIIPLUS2_X2_INSTANCE

    Public lanectrl
    Public mode1g
    Public pwrrst
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set lanectrl = (New REGISTER_CTRL_SGMIIPLUS2_X2_lanectrl)(aBaseAddr, 16)
        Set mode1g = (New REGISTER_CTRL_SGMIIPLUS2_X2_mode1g)(aBaseAddr, 16)
        Set pwrrst = (New REGISTER_CTRL_SGMIIPLUS2_X2_pwrrst)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_CTRL_SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CTRL_SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
CTRL_SGMIIPLUS2_X2.Add ((New CTRL_SGMIIPLUS2_X2_INSTANCE)(&H4acd0c00))
CTRL_SGMIIPLUS2_X2.Add ((New CTRL_SGMIIPLUS2_X2_INSTANCE)(&H4acf0c00))


