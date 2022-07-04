

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


'' @REGISTER : TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_prbsgenctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txpmd_tx_mdata_en                          [7:7]            get_txpmd_tx_mdata_en
''                                                             set_txpmd_tx_mdata_en
''                                                             read_txpmd_tx_mdata_en
''                                                             write_txpmd_tx_mdata_en
''---------------------------------------------------------------------------------
'' txpmd_bypass_osmode                        [6:6]            get_txpmd_bypass_osmode
''                                                             set_txpmd_bypass_osmode
''                                                             read_txpmd_bypass_osmode
''                                                             write_txpmd_bypass_osmode
''---------------------------------------------------------------------------------
'' txpmd_txdatai_sel                          [5:5]            get_txpmd_txdatai_sel
''                                                             set_txpmd_txdatai_sel
''                                                             read_txpmd_txdatai_sel
''                                                             write_txpmd_txdatai_sel
''---------------------------------------------------------------------------------
'' txpmd_prbsgen_en                           [4:4]            get_txpmd_prbsgen_en
''                                                             set_txpmd_prbsgen_en
''                                                             read_txpmd_prbsgen_en
''                                                             write_txpmd_prbsgen_en
''---------------------------------------------------------------------------------
'' txpmd_prbsgen_inv                          [3:3]            get_txpmd_prbsgen_inv
''                                                             set_txpmd_prbsgen_inv
''                                                             read_txpmd_prbsgen_inv
''                                                             write_txpmd_prbsgen_inv
''---------------------------------------------------------------------------------
'' txpmd_prbsgen_order                        [2:0]            get_txpmd_prbsgen_order
''                                                             set_txpmd_prbsgen_order
''                                                             read_txpmd_prbsgen_order
''                                                             write_txpmd_prbsgen_order
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_prbsgenctrl
    Private write_txpmd_tx_mdata_en_value
    Private read_txpmd_tx_mdata_en_value
    Private flag_txpmd_tx_mdata_en
    Private write_txpmd_bypass_osmode_value
    Private read_txpmd_bypass_osmode_value
    Private flag_txpmd_bypass_osmode
    Private write_txpmd_txdatai_sel_value
    Private read_txpmd_txdatai_sel_value
    Private flag_txpmd_txdatai_sel
    Private write_txpmd_prbsgen_en_value
    Private read_txpmd_prbsgen_en_value
    Private flag_txpmd_prbsgen_en
    Private write_txpmd_prbsgen_inv_value
    Private read_txpmd_prbsgen_inv_value
    Private flag_txpmd_prbsgen_inv
    Private write_txpmd_prbsgen_order_value
    Private read_txpmd_prbsgen_order_value
    Private flag_txpmd_prbsgen_order

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

    Property Get get_txpmd_tx_mdata_en
        get_txpmd_tx_mdata_en = read_txpmd_tx_mdata_en_value
    End Property

    Property Let set_txpmd_tx_mdata_en(aData)
        write_txpmd_tx_mdata_en_value = aData
        flag_txpmd_tx_mdata_en        = &H1
    End Property

    Property Get read_txpmd_tx_mdata_en
        read
        read_txpmd_tx_mdata_en = read_txpmd_tx_mdata_en_value
    End Property

    Property Let write_txpmd_tx_mdata_en(aData)
        set_txpmd_tx_mdata_en = aData
        write
    End Property

    Property Get get_txpmd_bypass_osmode
        get_txpmd_bypass_osmode = read_txpmd_bypass_osmode_value
    End Property

    Property Let set_txpmd_bypass_osmode(aData)
        write_txpmd_bypass_osmode_value = aData
        flag_txpmd_bypass_osmode        = &H1
    End Property

    Property Get read_txpmd_bypass_osmode
        read
        read_txpmd_bypass_osmode = read_txpmd_bypass_osmode_value
    End Property

    Property Let write_txpmd_bypass_osmode(aData)
        set_txpmd_bypass_osmode = aData
        write
    End Property

    Property Get get_txpmd_txdatai_sel
        get_txpmd_txdatai_sel = read_txpmd_txdatai_sel_value
    End Property

    Property Let set_txpmd_txdatai_sel(aData)
        write_txpmd_txdatai_sel_value = aData
        flag_txpmd_txdatai_sel        = &H1
    End Property

    Property Get read_txpmd_txdatai_sel
        read
        read_txpmd_txdatai_sel = read_txpmd_txdatai_sel_value
    End Property

    Property Let write_txpmd_txdatai_sel(aData)
        set_txpmd_txdatai_sel = aData
        write
    End Property

    Property Get get_txpmd_prbsgen_en
        get_txpmd_prbsgen_en = read_txpmd_prbsgen_en_value
    End Property

    Property Let set_txpmd_prbsgen_en(aData)
        write_txpmd_prbsgen_en_value = aData
        flag_txpmd_prbsgen_en        = &H1
    End Property

    Property Get read_txpmd_prbsgen_en
        read
        read_txpmd_prbsgen_en = read_txpmd_prbsgen_en_value
    End Property

    Property Let write_txpmd_prbsgen_en(aData)
        set_txpmd_prbsgen_en = aData
        write
    End Property

    Property Get get_txpmd_prbsgen_inv
        get_txpmd_prbsgen_inv = read_txpmd_prbsgen_inv_value
    End Property

    Property Let set_txpmd_prbsgen_inv(aData)
        write_txpmd_prbsgen_inv_value = aData
        flag_txpmd_prbsgen_inv        = &H1
    End Property

    Property Get read_txpmd_prbsgen_inv
        read
        read_txpmd_prbsgen_inv = read_txpmd_prbsgen_inv_value
    End Property

    Property Let write_txpmd_prbsgen_inv(aData)
        set_txpmd_prbsgen_inv = aData
        write
    End Property

    Property Get get_txpmd_prbsgen_order
        get_txpmd_prbsgen_order = read_txpmd_prbsgen_order_value
    End Property

    Property Let set_txpmd_prbsgen_order(aData)
        write_txpmd_prbsgen_order_value = aData
        flag_txpmd_prbsgen_order        = &H1
    End Property

    Property Get read_txpmd_prbsgen_order
        read
        read_txpmd_prbsgen_order = read_txpmd_prbsgen_order_value
    End Property

    Property Let write_txpmd_prbsgen_order(aData)
        set_txpmd_prbsgen_order = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpmd_tx_mdata_en_value = rightShift(data_low, 7) and &H1
        read_txpmd_bypass_osmode_value = rightShift(data_low, 6) and &H1
        read_txpmd_txdatai_sel_value = rightShift(data_low, 5) and &H1
        read_txpmd_prbsgen_en_value = rightShift(data_low, 4) and &H1
        read_txpmd_prbsgen_inv_value = rightShift(data_low, 3) and &H1
        txpmd_prbsgen_order_mask = &H7
        if data_low > LONG_MAX then
            if txpmd_prbsgen_order_mask = mask then
                read_txpmd_prbsgen_order_value = data_low
            else
                read_txpmd_prbsgen_order_value = (data_low - H8000_0000) and txpmd_prbsgen_order_mask
            end If
        else
            read_txpmd_prbsgen_order_value = data_low and txpmd_prbsgen_order_mask
        end If

    End Sub

    Sub write
        If flag_txpmd_tx_mdata_en = &H0 or flag_txpmd_bypass_osmode = &H0 or flag_txpmd_txdatai_sel = &H0 or flag_txpmd_prbsgen_en = &H0 or flag_txpmd_prbsgen_inv = &H0 or flag_txpmd_prbsgen_order = &H0 Then read
        If flag_txpmd_tx_mdata_en = &H0 Then write_txpmd_tx_mdata_en_value = get_txpmd_tx_mdata_en
        If flag_txpmd_bypass_osmode = &H0 Then write_txpmd_bypass_osmode_value = get_txpmd_bypass_osmode
        If flag_txpmd_txdatai_sel = &H0 Then write_txpmd_txdatai_sel_value = get_txpmd_txdatai_sel
        If flag_txpmd_prbsgen_en = &H0 Then write_txpmd_prbsgen_en_value = get_txpmd_prbsgen_en
        If flag_txpmd_prbsgen_inv = &H0 Then write_txpmd_prbsgen_inv_value = get_txpmd_prbsgen_inv
        If flag_txpmd_prbsgen_order = &H0 Then write_txpmd_prbsgen_order_value = get_txpmd_prbsgen_order

        regValue = leftShift((write_txpmd_tx_mdata_en_value and &H1), 7) + leftShift((write_txpmd_bypass_osmode_value and &H1), 6) + leftShift((write_txpmd_txdatai_sel_value and &H1), 5) + leftShift((write_txpmd_prbsgen_en_value and &H1), 4) + leftShift((write_txpmd_prbsgen_inv_value and &H1), 3) + leftShift((write_txpmd_prbsgen_order_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpmd_tx_mdata_en_value = rightShift(data_low, 7) and &H1
        read_txpmd_bypass_osmode_value = rightShift(data_low, 6) and &H1
        read_txpmd_txdatai_sel_value = rightShift(data_low, 5) and &H1
        read_txpmd_prbsgen_en_value = rightShift(data_low, 4) and &H1
        read_txpmd_prbsgen_inv_value = rightShift(data_low, 3) and &H1
        txpmd_prbsgen_order_mask = &H7
        if data_low > LONG_MAX then
            if txpmd_prbsgen_order_mask = mask then
                read_txpmd_prbsgen_order_value = data_low
            else
                read_txpmd_prbsgen_order_value = (data_low - H8000_0000) and txpmd_prbsgen_order_mask
            end If
        else
            read_txpmd_prbsgen_order_value = data_low and txpmd_prbsgen_order_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txpmd_tx_mdata_en_value = &H0
        flag_txpmd_tx_mdata_en        = &H0
        write_txpmd_bypass_osmode_value = &H0
        flag_txpmd_bypass_osmode        = &H0
        write_txpmd_txdatai_sel_value = &H0
        flag_txpmd_txdatai_sel        = &H0
        write_txpmd_prbsgen_en_value = &H0
        flag_txpmd_prbsgen_en        = &H0
        write_txpmd_prbsgen_inv_value = &H0
        flag_txpmd_prbsgen_inv        = &H0
        write_txpmd_prbsgen_order_value = &H0
        flag_txpmd_prbsgen_order        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_txmdata0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TxMdioTstDataL                             [9:0]            get_TxMdioTstDataL
''                                                             set_TxMdioTstDataL
''                                                             read_TxMdioTstDataL
''                                                             write_TxMdioTstDataL
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_txmdata0
    Private write_TxMdioTstDataL_value
    Private read_TxMdioTstDataL_value
    Private flag_TxMdioTstDataL

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

    Property Get get_TxMdioTstDataL
        get_TxMdioTstDataL = read_TxMdioTstDataL_value
    End Property

    Property Let set_TxMdioTstDataL(aData)
        write_TxMdioTstDataL_value = aData
        flag_TxMdioTstDataL        = &H1
    End Property

    Property Get read_TxMdioTstDataL
        read
        read_TxMdioTstDataL = read_TxMdioTstDataL_value
    End Property

    Property Let write_TxMdioTstDataL(aData)
        set_TxMdioTstDataL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TxMdioTstDataL_mask = &H3ff
        if data_low > LONG_MAX then
            if TxMdioTstDataL_mask = mask then
                read_TxMdioTstDataL_value = data_low
            else
                read_TxMdioTstDataL_value = (data_low - H8000_0000) and TxMdioTstDataL_mask
            end If
        else
            read_TxMdioTstDataL_value = data_low and TxMdioTstDataL_mask
        end If

    End Sub

    Sub write
        If flag_TxMdioTstDataL = &H0 Then read
        If flag_TxMdioTstDataL = &H0 Then write_TxMdioTstDataL_value = get_TxMdioTstDataL

        regValue = leftShift((write_TxMdioTstDataL_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TxMdioTstDataL_mask = &H3ff
        if data_low > LONG_MAX then
            if TxMdioTstDataL_mask = mask then
                read_TxMdioTstDataL_value = data_low
            else
                read_TxMdioTstDataL_value = (data_low - H8000_0000) and TxMdioTstDataL_mask
            end If
        else
            read_TxMdioTstDataL_value = data_low and TxMdioTstDataL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TxMdioTstDataL_value = &H0
        flag_TxMdioTstDataL        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_txmdata1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TxMdioTstDataH                             [9:0]            get_TxMdioTstDataH
''                                                             set_TxMdioTstDataH
''                                                             read_TxMdioTstDataH
''                                                             write_TxMdioTstDataH
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_txmdata1
    Private write_TxMdioTstDataH_value
    Private read_TxMdioTstDataH_value
    Private flag_TxMdioTstDataH

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

    Property Get get_TxMdioTstDataH
        get_TxMdioTstDataH = read_TxMdioTstDataH_value
    End Property

    Property Let set_TxMdioTstDataH(aData)
        write_TxMdioTstDataH_value = aData
        flag_TxMdioTstDataH        = &H1
    End Property

    Property Get read_TxMdioTstDataH
        read
        read_TxMdioTstDataH = read_TxMdioTstDataH_value
    End Property

    Property Let write_TxMdioTstDataH(aData)
        set_TxMdioTstDataH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TxMdioTstDataH_mask = &H3ff
        if data_low > LONG_MAX then
            if TxMdioTstDataH_mask = mask then
                read_TxMdioTstDataH_value = data_low
            else
                read_TxMdioTstDataH_value = (data_low - H8000_0000) and TxMdioTstDataH_mask
            end If
        else
            read_TxMdioTstDataH_value = data_low and TxMdioTstDataH_mask
        end If

    End Sub

    Sub write
        If flag_TxMdioTstDataH = &H0 Then read
        If flag_TxMdioTstDataH = &H0 Then write_TxMdioTstDataH_value = get_TxMdioTstDataH

        regValue = leftShift((write_TxMdioTstDataH_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TxMdioTstDataH_mask = &H3ff
        if data_low > LONG_MAX then
            if TxMdioTstDataH_mask = mask then
                read_TxMdioTstDataH_value = data_low
            else
                read_TxMdioTstDataH_value = (data_low - H8000_0000) and TxMdioTstDataH_mask
            end If
        else
            read_TxMdioTstDataH_value = data_low and TxMdioTstDataH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TxMdioTstDataH_value = &H0
        flag_TxMdioTstDataH        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_control0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pmd_txpol_flip                             [10:10]          get_pmd_txpol_flip
''                                                             set_pmd_txpol_flip
''                                                             read_pmd_txpol_flip
''                                                             write_pmd_txpol_flip
''---------------------------------------------------------------------------------
'' pmd_txdisable_ln                           [9:9]            get_pmd_txdisable_ln
''                                                             set_pmd_txdisable_ln
''                                                             read_pmd_txdisable_ln
''                                                             write_pmd_txdisable_ln
''---------------------------------------------------------------------------------
'' pmd_rlfifo_rst                             [8:8]            get_pmd_rlfifo_rst
''                                                             set_pmd_rlfifo_rst
''                                                             read_pmd_rlfifo_rst
''                                                             write_pmd_rlfifo_rst
''---------------------------------------------------------------------------------
'' pmd_rlfifo_tstsel                          [7:5]            get_pmd_rlfifo_tstsel
''                                                             set_pmd_rlfifo_tstsel
''                                                             read_pmd_rlfifo_tstsel
''                                                             write_pmd_rlfifo_tstsel
''---------------------------------------------------------------------------------
'' OMTPO                                      [4:4]            get_OMTPO
''                                                             set_OMTPO
''                                                             read_OMTPO
''                                                             write_OMTPO
''---------------------------------------------------------------------------------
'' os_mode_tx_pmd                             [3:0]            get_os_mode_tx_pmd
''                                                             set_os_mode_tx_pmd
''                                                             read_os_mode_tx_pmd
''                                                             write_os_mode_tx_pmd
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_control0
    Private write_pmd_txpol_flip_value
    Private read_pmd_txpol_flip_value
    Private flag_pmd_txpol_flip
    Private write_pmd_txdisable_ln_value
    Private read_pmd_txdisable_ln_value
    Private flag_pmd_txdisable_ln
    Private write_pmd_rlfifo_rst_value
    Private read_pmd_rlfifo_rst_value
    Private flag_pmd_rlfifo_rst
    Private write_pmd_rlfifo_tstsel_value
    Private read_pmd_rlfifo_tstsel_value
    Private flag_pmd_rlfifo_tstsel
    Private write_OMTPO_value
    Private read_OMTPO_value
    Private flag_OMTPO
    Private write_os_mode_tx_pmd_value
    Private read_os_mode_tx_pmd_value
    Private flag_os_mode_tx_pmd

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

    Property Get get_pmd_txpol_flip
        get_pmd_txpol_flip = read_pmd_txpol_flip_value
    End Property

    Property Let set_pmd_txpol_flip(aData)
        write_pmd_txpol_flip_value = aData
        flag_pmd_txpol_flip        = &H1
    End Property

    Property Get read_pmd_txpol_flip
        read
        read_pmd_txpol_flip = read_pmd_txpol_flip_value
    End Property

    Property Let write_pmd_txpol_flip(aData)
        set_pmd_txpol_flip = aData
        write
    End Property

    Property Get get_pmd_txdisable_ln
        get_pmd_txdisable_ln = read_pmd_txdisable_ln_value
    End Property

    Property Let set_pmd_txdisable_ln(aData)
        write_pmd_txdisable_ln_value = aData
        flag_pmd_txdisable_ln        = &H1
    End Property

    Property Get read_pmd_txdisable_ln
        read
        read_pmd_txdisable_ln = read_pmd_txdisable_ln_value
    End Property

    Property Let write_pmd_txdisable_ln(aData)
        set_pmd_txdisable_ln = aData
        write
    End Property

    Property Get get_pmd_rlfifo_rst
        get_pmd_rlfifo_rst = read_pmd_rlfifo_rst_value
    End Property

    Property Let set_pmd_rlfifo_rst(aData)
        write_pmd_rlfifo_rst_value = aData
        flag_pmd_rlfifo_rst        = &H1
    End Property

    Property Get read_pmd_rlfifo_rst
        read
        read_pmd_rlfifo_rst = read_pmd_rlfifo_rst_value
    End Property

    Property Let write_pmd_rlfifo_rst(aData)
        set_pmd_rlfifo_rst = aData
        write
    End Property

    Property Get get_pmd_rlfifo_tstsel
        get_pmd_rlfifo_tstsel = read_pmd_rlfifo_tstsel_value
    End Property

    Property Let set_pmd_rlfifo_tstsel(aData)
        write_pmd_rlfifo_tstsel_value = aData
        flag_pmd_rlfifo_tstsel        = &H1
    End Property

    Property Get read_pmd_rlfifo_tstsel
        read
        read_pmd_rlfifo_tstsel = read_pmd_rlfifo_tstsel_value
    End Property

    Property Let write_pmd_rlfifo_tstsel(aData)
        set_pmd_rlfifo_tstsel = aData
        write
    End Property

    Property Get get_OMTPO
        get_OMTPO = read_OMTPO_value
    End Property

    Property Let set_OMTPO(aData)
        write_OMTPO_value = aData
        flag_OMTPO        = &H1
    End Property

    Property Get read_OMTPO
        read
        read_OMTPO = read_OMTPO_value
    End Property

    Property Let write_OMTPO(aData)
        set_OMTPO = aData
        write
    End Property

    Property Get get_os_mode_tx_pmd
        get_os_mode_tx_pmd = read_os_mode_tx_pmd_value
    End Property

    Property Let set_os_mode_tx_pmd(aData)
        write_os_mode_tx_pmd_value = aData
        flag_os_mode_tx_pmd        = &H1
    End Property

    Property Get read_os_mode_tx_pmd
        read
        read_os_mode_tx_pmd = read_os_mode_tx_pmd_value
    End Property

    Property Let write_os_mode_tx_pmd(aData)
        set_os_mode_tx_pmd = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pmd_txpol_flip_value = rightShift(data_low, 10) and &H1
        read_pmd_txdisable_ln_value = rightShift(data_low, 9) and &H1
        read_pmd_rlfifo_rst_value = rightShift(data_low, 8) and &H1
        read_pmd_rlfifo_tstsel_value = rightShift(data_low, 5) and &H7
        read_OMTPO_value = rightShift(data_low, 4) and &H1
        os_mode_tx_pmd_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_tx_pmd_mask = mask then
                read_os_mode_tx_pmd_value = data_low
            else
                read_os_mode_tx_pmd_value = (data_low - H8000_0000) and os_mode_tx_pmd_mask
            end If
        else
            read_os_mode_tx_pmd_value = data_low and os_mode_tx_pmd_mask
        end If

    End Sub

    Sub write
        If flag_pmd_txpol_flip = &H0 or flag_pmd_txdisable_ln = &H0 or flag_pmd_rlfifo_rst = &H0 or flag_pmd_rlfifo_tstsel = &H0 or flag_OMTPO = &H0 or flag_os_mode_tx_pmd = &H0 Then read
        If flag_pmd_txpol_flip = &H0 Then write_pmd_txpol_flip_value = get_pmd_txpol_flip
        If flag_pmd_txdisable_ln = &H0 Then write_pmd_txdisable_ln_value = get_pmd_txdisable_ln
        If flag_pmd_rlfifo_rst = &H0 Then write_pmd_rlfifo_rst_value = get_pmd_rlfifo_rst
        If flag_pmd_rlfifo_tstsel = &H0 Then write_pmd_rlfifo_tstsel_value = get_pmd_rlfifo_tstsel
        If flag_OMTPO = &H0 Then write_OMTPO_value = get_OMTPO
        If flag_os_mode_tx_pmd = &H0 Then write_os_mode_tx_pmd_value = get_os_mode_tx_pmd

        regValue = leftShift((write_pmd_txpol_flip_value and &H1), 10) + leftShift((write_pmd_txdisable_ln_value and &H1), 9) + leftShift((write_pmd_rlfifo_rst_value and &H1), 8) + leftShift((write_pmd_rlfifo_tstsel_value and &H7), 5) + leftShift((write_OMTPO_value and &H1), 4) + leftShift((write_os_mode_tx_pmd_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pmd_txpol_flip_value = rightShift(data_low, 10) and &H1
        read_pmd_txdisable_ln_value = rightShift(data_low, 9) and &H1
        read_pmd_rlfifo_rst_value = rightShift(data_low, 8) and &H1
        read_pmd_rlfifo_tstsel_value = rightShift(data_low, 5) and &H7
        read_OMTPO_value = rightShift(data_low, 4) and &H1
        os_mode_tx_pmd_mask = &Hf
        if data_low > LONG_MAX then
            if os_mode_tx_pmd_mask = mask then
                read_os_mode_tx_pmd_value = data_low
            else
                read_os_mode_tx_pmd_value = (data_low - H8000_0000) and os_mode_tx_pmd_mask
            end If
        else
            read_os_mode_tx_pmd_value = data_low and os_mode_tx_pmd_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pmd_txpol_flip_value = &H0
        flag_pmd_txpol_flip        = &H0
        write_pmd_txdisable_ln_value = &H0
        flag_pmd_txdisable_ln        = &H0
        write_pmd_rlfifo_rst_value = &H0
        flag_pmd_rlfifo_rst        = &H0
        write_pmd_rlfifo_tstsel_value = &H0
        flag_pmd_rlfifo_tstsel        = &H0
        write_OMTPO_value = &H0
        flag_OMTPO        = &H0
        write_os_mode_tx_pmd_value = &H0
        flag_os_mode_tx_pmd        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_test_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_os_mode_muxval                          [10:7]           get_tx_os_mode_muxval
''                                                             set_tx_os_mode_muxval
''                                                             read_tx_os_mode_muxval
''                                                             write_tx_os_mode_muxval
''---------------------------------------------------------------------------------
'' rltxfifo_tmux                              [6:1]            get_rltxfifo_tmux
''                                                             set_rltxfifo_tmux
''                                                             read_rltxfifo_tmux
''                                                             write_rltxfifo_tmux
''---------------------------------------------------------------------------------
'' rltxferr_stky                              [0:0]            get_rltxferr_stky
''                                                             set_rltxferr_stky
''                                                             read_rltxferr_stky
''                                                             write_rltxferr_stky
''---------------------------------------------------------------------------------
Class REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_test_status
    Private write_tx_os_mode_muxval_value
    Private read_tx_os_mode_muxval_value
    Private flag_tx_os_mode_muxval
    Private write_rltxfifo_tmux_value
    Private read_rltxfifo_tmux_value
    Private flag_rltxfifo_tmux
    Private write_rltxferr_stky_value
    Private read_rltxferr_stky_value
    Private flag_rltxferr_stky

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

    Property Get get_tx_os_mode_muxval
        get_tx_os_mode_muxval = read_tx_os_mode_muxval_value
    End Property

    Property Let set_tx_os_mode_muxval(aData)
        write_tx_os_mode_muxval_value = aData
        flag_tx_os_mode_muxval        = &H1
    End Property

    Property Get read_tx_os_mode_muxval
        read
        read_tx_os_mode_muxval = read_tx_os_mode_muxval_value
    End Property

    Property Let write_tx_os_mode_muxval(aData)
        set_tx_os_mode_muxval = aData
        write
    End Property

    Property Get get_rltxfifo_tmux
        get_rltxfifo_tmux = read_rltxfifo_tmux_value
    End Property

    Property Let set_rltxfifo_tmux(aData)
        write_rltxfifo_tmux_value = aData
        flag_rltxfifo_tmux        = &H1
    End Property

    Property Get read_rltxfifo_tmux
        read
        read_rltxfifo_tmux = read_rltxfifo_tmux_value
    End Property

    Property Let write_rltxfifo_tmux(aData)
        set_rltxfifo_tmux = aData
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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_os_mode_muxval_value = rightShift(data_low, 7) and &Hf
        read_rltxfifo_tmux_value = rightShift(data_low, 1) and &H3f
        rltxferr_stky_mask = &H1
        if data_low > LONG_MAX then
            if rltxferr_stky_mask = mask then
                read_rltxferr_stky_value = data_low
            else
                read_rltxferr_stky_value = (data_low - H8000_0000) and rltxferr_stky_mask
            end If
        else
            read_rltxferr_stky_value = data_low and rltxferr_stky_mask
        end If

    End Sub

    Sub write
        If flag_tx_os_mode_muxval = &H0 or flag_rltxfifo_tmux = &H0 or flag_rltxferr_stky = &H0 Then read
        If flag_tx_os_mode_muxval = &H0 Then write_tx_os_mode_muxval_value = get_tx_os_mode_muxval
        If flag_rltxfifo_tmux = &H0 Then write_rltxfifo_tmux_value = get_rltxfifo_tmux
        If flag_rltxferr_stky = &H0 Then write_rltxferr_stky_value = get_rltxferr_stky

        regValue = leftShift((write_tx_os_mode_muxval_value and &Hf), 7) + leftShift((write_rltxfifo_tmux_value and &H3f), 1) + leftShift((write_rltxferr_stky_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_os_mode_muxval_value = rightShift(data_low, 7) and &Hf
        read_rltxfifo_tmux_value = rightShift(data_low, 1) and &H3f
        rltxferr_stky_mask = &H1
        if data_low > LONG_MAX then
            if rltxferr_stky_mask = mask then
                read_rltxferr_stky_value = data_low
            else
                read_rltxferr_stky_value = (data_low - H8000_0000) and rltxferr_stky_mask
            end If
        else
            read_rltxferr_stky_value = data_low and rltxferr_stky_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_os_mode_muxval_value = &H0
        flag_tx_os_mode_muxval        = &H0
        write_rltxfifo_tmux_value = &H0
        flag_rltxfifo_tmux        = &H0
        write_rltxferr_stky_value = &H0
        flag_rltxferr_stky        = &H0
    End Sub
End Class


'' @REGISTER : TX_PMD_TEST__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_blockaddress
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

Class TX_PMD_TEST__SGMIIPLUS2_X2_INSTANCE

    Public txpmd_prbsgenctrl
    Public txpmd_txmdata0
    Public txpmd_txmdata1
    Public txpmd_control0
    Public txpmd_test_status
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set txpmd_prbsgenctrl = (New REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_prbsgenctrl)(aBaseAddr, 16)
        Set txpmd_txmdata0 = (New REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_txmdata0)(aBaseAddr, 16)
        Set txpmd_txmdata1 = (New REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_txmdata1)(aBaseAddr, 16)
        Set txpmd_control0 = (New REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_control0)(aBaseAddr, 16)
        Set txpmd_test_status = (New REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_txpmd_test_status)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX_PMD_TEST__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX_PMD_TEST__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
TX_PMD_TEST__SGMIIPLUS2_X2.Add ((New TX_PMD_TEST__SGMIIPLUS2_X2_INSTANCE)(&H4ac50c20))
TX_PMD_TEST__SGMIIPLUS2_X2.Add ((New TX_PMD_TEST__SGMIIPLUS2_X2_INSTANCE)(&H4ac70c20))


