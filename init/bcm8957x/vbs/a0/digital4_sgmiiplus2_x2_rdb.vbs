

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


'' @REGISTER : DIGITAL4_SGMIIPLUS2_X2_misc3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sgmii_ext_sel                              [7:7]            get_sgmii_ext_sel
''                                                             set_sgmii_ext_sel
''                                                             read_sgmii_ext_sel
''                                                             write_sgmii_ext_sel
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL4_SGMIIPLUS2_X2_misc3
    Private write_sgmii_ext_sel_value
    Private read_sgmii_ext_sel_value
    Private flag_sgmii_ext_sel

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

    Property Get get_sgmii_ext_sel
        get_sgmii_ext_sel = read_sgmii_ext_sel_value
    End Property

    Property Let set_sgmii_ext_sel(aData)
        write_sgmii_ext_sel_value = aData
        flag_sgmii_ext_sel        = &H1
    End Property

    Property Get read_sgmii_ext_sel
        read
        read_sgmii_ext_sel = read_sgmii_ext_sel_value
    End Property

    Property Let write_sgmii_ext_sel(aData)
        set_sgmii_ext_sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_ext_sel_value = rightShift(data_low, 7) and &H1

    End Sub

    Sub write
        If flag_sgmii_ext_sel = &H0 Then read
        If flag_sgmii_ext_sel = &H0 Then write_sgmii_ext_sel_value = get_sgmii_ext_sel

        regValue = leftShift((write_sgmii_ext_sel_value and &H1), 7)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sgmii_ext_sel_value = rightShift(data_low, 7) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sgmii_ext_sel_value = &H0
        flag_sgmii_ext_sel        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL4_SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_DIGITAL4_SGMIIPLUS2_X2_blockaddress
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

Class DIGITAL4_SGMIIPLUS2_X2_INSTANCE

    Public misc3
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set misc3 = (New REGISTER_DIGITAL4_SGMIIPLUS2_X2_misc3)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_DIGITAL4_SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DIGITAL4_SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
DIGITAL4_SGMIIPLUS2_X2.Add ((New DIGITAL4_SGMIIPLUS2_X2_INSTANCE)(&H4acd0660))
DIGITAL4_SGMIIPLUS2_X2.Add ((New DIGITAL4_SGMIIPLUS2_X2_INSTANCE)(&H4acf0660))


