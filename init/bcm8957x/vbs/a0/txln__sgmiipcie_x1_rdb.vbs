

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


'' @REGISTER : TXLN__SGMIIPCIE_X1_tx_prbs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bypass_osmode                              [6:6]            get_bypass_osmode
''                                                             set_bypass_osmode
''                                                             read_bypass_osmode
''                                                             write_bypass_osmode
''---------------------------------------------------------------------------------
'' txdatai_sel                                [5:5]            get_txdatai_sel
''                                                             set_txdatai_sel
''                                                             read_txdatai_sel
''                                                             write_txdatai_sel
''---------------------------------------------------------------------------------
'' prbsgen_en                                 [4:4]            get_prbsgen_en
''                                                             set_prbsgen_en
''                                                             read_prbsgen_en
''                                                             write_prbsgen_en
''---------------------------------------------------------------------------------
'' prbsgen_inv                                [3:3]            get_prbsgen_inv
''                                                             set_prbsgen_inv
''                                                             read_prbsgen_inv
''                                                             write_prbsgen_inv
''---------------------------------------------------------------------------------
'' prbsgen_order                              [2:0]            get_prbsgen_order
''                                                             set_prbsgen_order
''                                                             read_prbsgen_order
''                                                             write_prbsgen_order
''---------------------------------------------------------------------------------
Class REGISTER_TXLN__SGMIIPCIE_X1_tx_prbs
    Private write_bypass_osmode_value
    Private read_bypass_osmode_value
    Private flag_bypass_osmode
    Private write_txdatai_sel_value
    Private read_txdatai_sel_value
    Private flag_txdatai_sel
    Private write_prbsgen_en_value
    Private read_prbsgen_en_value
    Private flag_prbsgen_en
    Private write_prbsgen_inv_value
    Private read_prbsgen_inv_value
    Private flag_prbsgen_inv
    Private write_prbsgen_order_value
    Private read_prbsgen_order_value
    Private flag_prbsgen_order

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

    Property Get get_bypass_osmode
        get_bypass_osmode = read_bypass_osmode_value
    End Property

    Property Let set_bypass_osmode(aData)
        write_bypass_osmode_value = aData
        flag_bypass_osmode        = &H1
    End Property

    Property Get read_bypass_osmode
        read
        read_bypass_osmode = read_bypass_osmode_value
    End Property

    Property Let write_bypass_osmode(aData)
        set_bypass_osmode = aData
        write
    End Property

    Property Get get_txdatai_sel
        get_txdatai_sel = read_txdatai_sel_value
    End Property

    Property Let set_txdatai_sel(aData)
        write_txdatai_sel_value = aData
        flag_txdatai_sel        = &H1
    End Property

    Property Get read_txdatai_sel
        read
        read_txdatai_sel = read_txdatai_sel_value
    End Property

    Property Let write_txdatai_sel(aData)
        set_txdatai_sel = aData
        write
    End Property

    Property Get get_prbsgen_en
        get_prbsgen_en = read_prbsgen_en_value
    End Property

    Property Let set_prbsgen_en(aData)
        write_prbsgen_en_value = aData
        flag_prbsgen_en        = &H1
    End Property

    Property Get read_prbsgen_en
        read
        read_prbsgen_en = read_prbsgen_en_value
    End Property

    Property Let write_prbsgen_en(aData)
        set_prbsgen_en = aData
        write
    End Property

    Property Get get_prbsgen_inv
        get_prbsgen_inv = read_prbsgen_inv_value
    End Property

    Property Let set_prbsgen_inv(aData)
        write_prbsgen_inv_value = aData
        flag_prbsgen_inv        = &H1
    End Property

    Property Get read_prbsgen_inv
        read
        read_prbsgen_inv = read_prbsgen_inv_value
    End Property

    Property Let write_prbsgen_inv(aData)
        set_prbsgen_inv = aData
        write
    End Property

    Property Get get_prbsgen_order
        get_prbsgen_order = read_prbsgen_order_value
    End Property

    Property Let set_prbsgen_order(aData)
        write_prbsgen_order_value = aData
        flag_prbsgen_order        = &H1
    End Property

    Property Get read_prbsgen_order
        read
        read_prbsgen_order = read_prbsgen_order_value
    End Property

    Property Let write_prbsgen_order(aData)
        set_prbsgen_order = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_osmode_value = rightShift(data_low, 6) and &H1
        read_txdatai_sel_value = rightShift(data_low, 5) and &H1
        read_prbsgen_en_value = rightShift(data_low, 4) and &H1
        read_prbsgen_inv_value = rightShift(data_low, 3) and &H1
        prbsgen_order_mask = &H7
        if data_low > LONG_MAX then
            if prbsgen_order_mask = mask then
                read_prbsgen_order_value = data_low
            else
                read_prbsgen_order_value = (data_low - H8000_0000) and prbsgen_order_mask
            end If
        else
            read_prbsgen_order_value = data_low and prbsgen_order_mask
        end If

    End Sub

    Sub write
        If flag_bypass_osmode = &H0 or flag_txdatai_sel = &H0 or flag_prbsgen_en = &H0 or flag_prbsgen_inv = &H0 or flag_prbsgen_order = &H0 Then read
        If flag_bypass_osmode = &H0 Then write_bypass_osmode_value = get_bypass_osmode
        If flag_txdatai_sel = &H0 Then write_txdatai_sel_value = get_txdatai_sel
        If flag_prbsgen_en = &H0 Then write_prbsgen_en_value = get_prbsgen_en
        If flag_prbsgen_inv = &H0 Then write_prbsgen_inv_value = get_prbsgen_inv
        If flag_prbsgen_order = &H0 Then write_prbsgen_order_value = get_prbsgen_order

        regValue = leftShift((write_bypass_osmode_value and &H1), 6) + leftShift((write_txdatai_sel_value and &H1), 5) + leftShift((write_prbsgen_en_value and &H1), 4) + leftShift((write_prbsgen_inv_value and &H1), 3) + leftShift((write_prbsgen_order_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_osmode_value = rightShift(data_low, 6) and &H1
        read_txdatai_sel_value = rightShift(data_low, 5) and &H1
        read_prbsgen_en_value = rightShift(data_low, 4) and &H1
        read_prbsgen_inv_value = rightShift(data_low, 3) and &H1
        prbsgen_order_mask = &H7
        if data_low > LONG_MAX then
            if prbsgen_order_mask = mask then
                read_prbsgen_order_value = data_low
            else
                read_prbsgen_order_value = (data_low - H8000_0000) and prbsgen_order_mask
            end If
        else
            read_prbsgen_order_value = data_low and prbsgen_order_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bypass_osmode_value = &H0
        flag_bypass_osmode        = &H0
        write_txdatai_sel_value = &H0
        flag_txdatai_sel        = &H0
        write_prbsgen_en_value = &H0
        flag_prbsgen_en        = &H0
        write_prbsgen_inv_value = &H0
        flag_prbsgen_inv        = &H0
        write_prbsgen_order_value = &H0
        flag_prbsgen_order        = &H0
    End Sub
End Class


'' @REGISTER : TXLN__SGMIIPCIE_X1_txmisc1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LPI_en_tx                                  [14:14]          get_LPI_en_tx
''                                                             set_LPI_en_tx
''                                                             read_LPI_en_tx
''                                                             write_LPI_en_tx
''---------------------------------------------------------------------------------
'' fifo_err_cya2                              [5:5]            get_fifo_err_cya2
''                                                             set_fifo_err_cya2
''                                                             read_fifo_err_cya2
''                                                             write_fifo_err_cya2
''---------------------------------------------------------------------------------
'' tx_underrun_1000_dis                       [1:1]            get_tx_underrun_1000_dis
''                                                             set_tx_underrun_1000_dis
''                                                             read_tx_underrun_1000_dis
''                                                             write_tx_underrun_1000_dis
''---------------------------------------------------------------------------------
'' fifo_err_cya                               [0:0]            get_fifo_err_cya
''                                                             set_fifo_err_cya
''                                                             read_fifo_err_cya
''                                                             write_fifo_err_cya
''---------------------------------------------------------------------------------
Class REGISTER_TXLN__SGMIIPCIE_X1_txmisc1
    Private write_LPI_en_tx_value
    Private read_LPI_en_tx_value
    Private flag_LPI_en_tx
    Private write_fifo_err_cya2_value
    Private read_fifo_err_cya2_value
    Private flag_fifo_err_cya2
    Private write_tx_underrun_1000_dis_value
    Private read_tx_underrun_1000_dis_value
    Private flag_tx_underrun_1000_dis
    Private write_fifo_err_cya_value
    Private read_fifo_err_cya_value
    Private flag_fifo_err_cya

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

    Property Get get_LPI_en_tx
        get_LPI_en_tx = read_LPI_en_tx_value
    End Property

    Property Let set_LPI_en_tx(aData)
        write_LPI_en_tx_value = aData
        flag_LPI_en_tx        = &H1
    End Property

    Property Get read_LPI_en_tx
        read
        read_LPI_en_tx = read_LPI_en_tx_value
    End Property

    Property Let write_LPI_en_tx(aData)
        set_LPI_en_tx = aData
        write
    End Property

    Property Get get_fifo_err_cya2
        get_fifo_err_cya2 = read_fifo_err_cya2_value
    End Property

    Property Let set_fifo_err_cya2(aData)
        write_fifo_err_cya2_value = aData
        flag_fifo_err_cya2        = &H1
    End Property

    Property Get read_fifo_err_cya2
        read
        read_fifo_err_cya2 = read_fifo_err_cya2_value
    End Property

    Property Let write_fifo_err_cya2(aData)
        set_fifo_err_cya2 = aData
        write
    End Property

    Property Get get_tx_underrun_1000_dis
        get_tx_underrun_1000_dis = read_tx_underrun_1000_dis_value
    End Property

    Property Let set_tx_underrun_1000_dis(aData)
        write_tx_underrun_1000_dis_value = aData
        flag_tx_underrun_1000_dis        = &H1
    End Property

    Property Get read_tx_underrun_1000_dis
        read
        read_tx_underrun_1000_dis = read_tx_underrun_1000_dis_value
    End Property

    Property Let write_tx_underrun_1000_dis(aData)
        set_tx_underrun_1000_dis = aData
        write
    End Property

    Property Get get_fifo_err_cya
        get_fifo_err_cya = read_fifo_err_cya_value
    End Property

    Property Let set_fifo_err_cya(aData)
        write_fifo_err_cya_value = aData
        flag_fifo_err_cya        = &H1
    End Property

    Property Get read_fifo_err_cya
        read
        read_fifo_err_cya = read_fifo_err_cya_value
    End Property

    Property Let write_fifo_err_cya(aData)
        set_fifo_err_cya = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_en_tx_value = rightShift(data_low, 14) and &H1
        read_fifo_err_cya2_value = rightShift(data_low, 5) and &H1
        read_tx_underrun_1000_dis_value = rightShift(data_low, 1) and &H1
        fifo_err_cya_mask = &H1
        if data_low > LONG_MAX then
            if fifo_err_cya_mask = mask then
                read_fifo_err_cya_value = data_low
            else
                read_fifo_err_cya_value = (data_low - H8000_0000) and fifo_err_cya_mask
            end If
        else
            read_fifo_err_cya_value = data_low and fifo_err_cya_mask
        end If

    End Sub

    Sub write
        If flag_LPI_en_tx = &H0 or flag_fifo_err_cya2 = &H0 or flag_tx_underrun_1000_dis = &H0 or flag_fifo_err_cya = &H0 Then read
        If flag_LPI_en_tx = &H0 Then write_LPI_en_tx_value = get_LPI_en_tx
        If flag_fifo_err_cya2 = &H0 Then write_fifo_err_cya2_value = get_fifo_err_cya2
        If flag_tx_underrun_1000_dis = &H0 Then write_tx_underrun_1000_dis_value = get_tx_underrun_1000_dis
        If flag_fifo_err_cya = &H0 Then write_fifo_err_cya_value = get_fifo_err_cya

        regValue = leftShift((write_LPI_en_tx_value and &H1), 14) + leftShift((write_fifo_err_cya2_value and &H1), 5) + leftShift((write_tx_underrun_1000_dis_value and &H1), 1) + leftShift((write_fifo_err_cya_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_en_tx_value = rightShift(data_low, 14) and &H1
        read_fifo_err_cya2_value = rightShift(data_low, 5) and &H1
        read_tx_underrun_1000_dis_value = rightShift(data_low, 1) and &H1
        fifo_err_cya_mask = &H1
        if data_low > LONG_MAX then
            if fifo_err_cya_mask = mask then
                read_fifo_err_cya_value = data_low
            else
                read_fifo_err_cya_value = (data_low - H8000_0000) and fifo_err_cya_mask
            end If
        else
            read_fifo_err_cya_value = data_low and fifo_err_cya_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LPI_en_tx_value = &H0
        flag_LPI_en_tx        = &H0
        write_fifo_err_cya2_value = &H0
        flag_fifo_err_cya2        = &H0
        write_tx_underrun_1000_dis_value = &H0
        flag_tx_underrun_1000_dis        = &H0
        write_fifo_err_cya_value = &H0
        flag_fifo_err_cya        = &H0
    End Sub
End Class


'' @REGISTER : TXLN__SGMIIPCIE_X1_blockaddress
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
Class REGISTER_TXLN__SGMIIPCIE_X1_blockaddress
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

Class TXLN__SGMIIPCIE_X1_INSTANCE

    Public tx_prbs
    Public txmisc1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set tx_prbs = (New REGISTER_TXLN__SGMIIPCIE_X1_tx_prbs)(aBaseAddr, 16)
        Set txmisc1 = (New REGISTER_TXLN__SGMIIPCIE_X1_txmisc1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TXLN__SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TXLN__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
TXLN__SGMIIPCIE_X1.Add ((New TXLN__SGMIIPCIE_X1_INSTANCE)(&H4add0100))


