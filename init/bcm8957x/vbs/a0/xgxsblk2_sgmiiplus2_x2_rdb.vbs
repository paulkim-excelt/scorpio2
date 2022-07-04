

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


'' @REGISTER : XGXSBLK2_SGMIIPLUS2_X2_miscreset
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reset_mdio                                 [15:15]          get_reset_mdio
''                                                             set_reset_mdio
''                                                             read_reset_mdio
''                                                             write_reset_mdio
''---------------------------------------------------------------------------------
'' reset_pll                                  [8:8]            get_reset_pll
''                                                             set_reset_pll
''                                                             read_reset_pll
''                                                             write_reset_pll
''---------------------------------------------------------------------------------
Class REGISTER_XGXSBLK2_SGMIIPLUS2_X2_miscreset
    Private write_reset_mdio_value
    Private read_reset_mdio_value
    Private flag_reset_mdio
    Private write_reset_pll_value
    Private read_reset_pll_value
    Private flag_reset_pll

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

    Property Get get_reset_mdio
        get_reset_mdio = read_reset_mdio_value
    End Property

    Property Let set_reset_mdio(aData)
        write_reset_mdio_value = aData
        flag_reset_mdio        = &H1
    End Property

    Property Get read_reset_mdio
        read
        read_reset_mdio = read_reset_mdio_value
    End Property

    Property Let write_reset_mdio(aData)
        set_reset_mdio = aData
        write
    End Property

    Property Get get_reset_pll
        get_reset_pll = read_reset_pll_value
    End Property

    Property Let set_reset_pll(aData)
        write_reset_pll_value = aData
        flag_reset_pll        = &H1
    End Property

    Property Get read_reset_pll
        read
        read_reset_pll = read_reset_pll_value
    End Property

    Property Let write_reset_pll(aData)
        set_reset_pll = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reset_mdio_value = rightShift(data_low, 15) and &H1
        read_reset_pll_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_reset_mdio = &H0 or flag_reset_pll = &H0 Then read
        If flag_reset_mdio = &H0 Then write_reset_mdio_value = get_reset_mdio
        If flag_reset_pll = &H0 Then write_reset_pll_value = get_reset_pll

        regValue = leftShift((write_reset_mdio_value and &H1), 15) + leftShift((write_reset_pll_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reset_mdio_value = rightShift(data_low, 15) and &H1
        read_reset_pll_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reset_mdio_value = &H0
        flag_reset_mdio        = &H0
        write_reset_pll_value = &H0
        flag_reset_pll        = &H0
    End Sub
End Class


'' @REGISTER : XGXSBLK2_SGMIIPLUS2_X2_qsgmii
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' disperror_en_force                         [15:15]          get_disperror_en_force
''                                                             set_disperror_en_force
''                                                             read_disperror_en_force
''                                                             write_disperror_en_force
''---------------------------------------------------------------------------------
'' disperror_en_val                           [14:14]          get_disperror_en_val
''                                                             set_disperror_en_val
''                                                             read_disperror_en_val
''                                                             write_disperror_en_val
''---------------------------------------------------------------------------------
'' disperror_sync_val                         [13:13]          get_disperror_sync_val
''                                                             set_disperror_sync_val
''                                                             read_disperror_sync_val
''                                                             write_disperror_sync_val
''---------------------------------------------------------------------------------
'' disparity_en_val                           [12:12]          get_disparity_en_val
''                                                             set_disparity_en_val
''                                                             read_disparity_en_val
''                                                             write_disparity_en_val
''---------------------------------------------------------------------------------
Class REGISTER_XGXSBLK2_SGMIIPLUS2_X2_qsgmii
    Private write_disperror_en_force_value
    Private read_disperror_en_force_value
    Private flag_disperror_en_force
    Private write_disperror_en_val_value
    Private read_disperror_en_val_value
    Private flag_disperror_en_val
    Private write_disperror_sync_val_value
    Private read_disperror_sync_val_value
    Private flag_disperror_sync_val
    Private write_disparity_en_val_value
    Private read_disparity_en_val_value
    Private flag_disparity_en_val

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

    Property Get get_disperror_en_force
        get_disperror_en_force = read_disperror_en_force_value
    End Property

    Property Let set_disperror_en_force(aData)
        write_disperror_en_force_value = aData
        flag_disperror_en_force        = &H1
    End Property

    Property Get read_disperror_en_force
        read
        read_disperror_en_force = read_disperror_en_force_value
    End Property

    Property Let write_disperror_en_force(aData)
        set_disperror_en_force = aData
        write
    End Property

    Property Get get_disperror_en_val
        get_disperror_en_val = read_disperror_en_val_value
    End Property

    Property Let set_disperror_en_val(aData)
        write_disperror_en_val_value = aData
        flag_disperror_en_val        = &H1
    End Property

    Property Get read_disperror_en_val
        read
        read_disperror_en_val = read_disperror_en_val_value
    End Property

    Property Let write_disperror_en_val(aData)
        set_disperror_en_val = aData
        write
    End Property

    Property Get get_disperror_sync_val
        get_disperror_sync_val = read_disperror_sync_val_value
    End Property

    Property Let set_disperror_sync_val(aData)
        write_disperror_sync_val_value = aData
        flag_disperror_sync_val        = &H1
    End Property

    Property Get read_disperror_sync_val
        read
        read_disperror_sync_val = read_disperror_sync_val_value
    End Property

    Property Let write_disperror_sync_val(aData)
        set_disperror_sync_val = aData
        write
    End Property

    Property Get get_disparity_en_val
        get_disparity_en_val = read_disparity_en_val_value
    End Property

    Property Let set_disparity_en_val(aData)
        write_disparity_en_val_value = aData
        flag_disparity_en_val        = &H1
    End Property

    Property Get read_disparity_en_val
        read
        read_disparity_en_val = read_disparity_en_val_value
    End Property

    Property Let write_disparity_en_val(aData)
        set_disparity_en_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_disperror_en_force_value = rightShift(data_low, 15) and &H1
        read_disperror_en_val_value = rightShift(data_low, 14) and &H1
        read_disperror_sync_val_value = rightShift(data_low, 13) and &H1
        read_disparity_en_val_value = rightShift(data_low, 12) and &H1

    End Sub

    Sub write
        If flag_disperror_en_force = &H0 or flag_disperror_en_val = &H0 or flag_disperror_sync_val = &H0 or flag_disparity_en_val = &H0 Then read
        If flag_disperror_en_force = &H0 Then write_disperror_en_force_value = get_disperror_en_force
        If flag_disperror_en_val = &H0 Then write_disperror_en_val_value = get_disperror_en_val
        If flag_disperror_sync_val = &H0 Then write_disperror_sync_val_value = get_disperror_sync_val
        If flag_disparity_en_val = &H0 Then write_disparity_en_val_value = get_disparity_en_val

        regValue = leftShift((write_disperror_en_force_value and &H1), 15) + leftShift((write_disperror_en_val_value and &H1), 14) + leftShift((write_disperror_sync_val_value and &H1), 13) + leftShift((write_disparity_en_val_value and &H1), 12)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_disperror_en_force_value = rightShift(data_low, 15) and &H1
        read_disperror_en_val_value = rightShift(data_low, 14) and &H1
        read_disperror_sync_val_value = rightShift(data_low, 13) and &H1
        read_disparity_en_val_value = rightShift(data_low, 12) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_disperror_en_force_value = &H0
        flag_disperror_en_force        = &H0
        write_disperror_en_val_value = &H0
        flag_disperror_en_val        = &H0
        write_disperror_sync_val_value = &H0
        flag_disperror_sync_val        = &H0
        write_disparity_en_val_value = &H0
        flag_disparity_en_val        = &H0
    End Sub
End Class


'' @REGISTER : XGXSBLK2_SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_XGXSBLK2_SGMIIPLUS2_X2_blockaddress
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

Class XGXSBLK2_SGMIIPLUS2_X2_INSTANCE

    Public miscreset
    Public qsgmii
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set miscreset = (New REGISTER_XGXSBLK2_SGMIIPLUS2_X2_miscreset)(aBaseAddr, 16)
        Set qsgmii = (New REGISTER_XGXSBLK2_SGMIIPLUS2_X2_qsgmii)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_XGXSBLK2_SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set XGXSBLK2_SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
XGXSBLK2_SGMIIPLUS2_X2.Add ((New XGXSBLK2_SGMIIPLUS2_X2_INSTANCE)(&H4acd0200))


