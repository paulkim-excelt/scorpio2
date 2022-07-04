

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


'' @REGISTER : TX__SGMIIPLUS2_X2_anatxacontrol0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txpol_flip                                 [5:5]            get_txpol_flip
''                                                             set_txpol_flip
''                                                             read_txpol_flip
''                                                             write_txpol_flip
''---------------------------------------------------------------------------------
'' tx_mdata_en                                [0:0]            get_tx_mdata_en
''                                                             set_tx_mdata_en
''                                                             read_tx_mdata_en
''                                                             write_tx_mdata_en
''---------------------------------------------------------------------------------
Class REGISTER_TX__SGMIIPLUS2_X2_anatxacontrol0
    Private write_txpol_flip_value
    Private read_txpol_flip_value
    Private flag_txpol_flip
    Private write_tx_mdata_en_value
    Private read_tx_mdata_en_value
    Private flag_tx_mdata_en

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

    Property Get get_tx_mdata_en
        get_tx_mdata_en = read_tx_mdata_en_value
    End Property

    Property Let set_tx_mdata_en(aData)
        write_tx_mdata_en_value = aData
        flag_tx_mdata_en        = &H1
    End Property

    Property Get read_tx_mdata_en
        read
        read_tx_mdata_en = read_tx_mdata_en_value
    End Property

    Property Let write_tx_mdata_en(aData)
        set_tx_mdata_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpol_flip_value = rightShift(data_low, 5) and &H1
        tx_mdata_en_mask = &H1
        if data_low > LONG_MAX then
            if tx_mdata_en_mask = mask then
                read_tx_mdata_en_value = data_low
            else
                read_tx_mdata_en_value = (data_low - H8000_0000) and tx_mdata_en_mask
            end If
        else
            read_tx_mdata_en_value = data_low and tx_mdata_en_mask
        end If

    End Sub

    Sub write
        If flag_txpol_flip = &H0 or flag_tx_mdata_en = &H0 Then read
        If flag_txpol_flip = &H0 Then write_txpol_flip_value = get_txpol_flip
        If flag_tx_mdata_en = &H0 Then write_tx_mdata_en_value = get_tx_mdata_en

        regValue = leftShift((write_txpol_flip_value and &H1), 5) + leftShift((write_tx_mdata_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpol_flip_value = rightShift(data_low, 5) and &H1
        tx_mdata_en_mask = &H1
        if data_low > LONG_MAX then
            if tx_mdata_en_mask = mask then
                read_tx_mdata_en_value = data_low
            else
                read_tx_mdata_en_value = (data_low - H8000_0000) and tx_mdata_en_mask
            end If
        else
            read_tx_mdata_en_value = data_low and tx_mdata_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txpol_flip_value = &H0
        flag_txpol_flip        = &H0
        write_tx_mdata_en_value = &H0
        flag_tx_mdata_en        = &H0
    End Sub
End Class


'' @REGISTER : TX__SGMIIPLUS2_X2_anatxmdata0
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
Class REGISTER_TX__SGMIIPLUS2_X2_anatxmdata0
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


'' @REGISTER : TX__SGMIIPLUS2_X2_anatxmdata1
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
Class REGISTER_TX__SGMIIPLUS2_X2_anatxmdata1
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


'' @REGISTER : TX__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_TX__SGMIIPLUS2_X2_blockaddress
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

Class TX__SGMIIPLUS2_X2_INSTANCE

    Public anatxacontrol0
    Public anatxmdata0
    Public anatxmdata1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set anatxacontrol0 = (New REGISTER_TX__SGMIIPLUS2_X2_anatxacontrol0)(aBaseAddr, 16)
        Set anatxmdata0 = (New REGISTER_TX__SGMIIPLUS2_X2_anatxmdata0)(aBaseAddr, 16)
        Set anatxmdata1 = (New REGISTER_TX__SGMIIPLUS2_X2_anatxmdata1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
TX__SGMIIPLUS2_X2.Add ((New TX__SGMIIPLUS2_X2_INSTANCE)(&H4acd00e0))
TX__SGMIIPLUS2_X2.Add ((New TX__SGMIIPLUS2_X2_INSTANCE)(&H4acf00e0))


