

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


'' @REGISTER : XGXSBLK1_SGMIIPCIE_X1_lanectrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' force_pll_lock                             [12:12]          get_force_pll_lock
''                                                             set_force_pll_lock
''                                                             read_force_pll_lock
''                                                             write_force_pll_lock
''---------------------------------------------------------------------------------
'' pwrdwn_force                               [11:11]          get_pwrdwn_force
''                                                             set_pwrdwn_force
''                                                             read_pwrdwn_force
''                                                             write_pwrdwn_force
''---------------------------------------------------------------------------------
'' pwrdwn_pll                                 [8:8]            get_pwrdwn_pll
''                                                             set_pwrdwn_pll
''                                                             read_pwrdwn_pll
''                                                             write_pwrdwn_pll
''---------------------------------------------------------------------------------
Class REGISTER_XGXSBLK1_SGMIIPCIE_X1_lanectrl3
    Private write_force_pll_lock_value
    Private read_force_pll_lock_value
    Private flag_force_pll_lock
    Private write_pwrdwn_force_value
    Private read_pwrdwn_force_value
    Private flag_pwrdwn_force
    Private write_pwrdwn_pll_value
    Private read_pwrdwn_pll_value
    Private flag_pwrdwn_pll

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

    Property Get get_force_pll_lock
        get_force_pll_lock = read_force_pll_lock_value
    End Property

    Property Let set_force_pll_lock(aData)
        write_force_pll_lock_value = aData
        flag_force_pll_lock        = &H1
    End Property

    Property Get read_force_pll_lock
        read
        read_force_pll_lock = read_force_pll_lock_value
    End Property

    Property Let write_force_pll_lock(aData)
        set_force_pll_lock = aData
        write
    End Property

    Property Get get_pwrdwn_force
        get_pwrdwn_force = read_pwrdwn_force_value
    End Property

    Property Let set_pwrdwn_force(aData)
        write_pwrdwn_force_value = aData
        flag_pwrdwn_force        = &H1
    End Property

    Property Get read_pwrdwn_force
        read
        read_pwrdwn_force = read_pwrdwn_force_value
    End Property

    Property Let write_pwrdwn_force(aData)
        set_pwrdwn_force = aData
        write
    End Property

    Property Get get_pwrdwn_pll
        get_pwrdwn_pll = read_pwrdwn_pll_value
    End Property

    Property Let set_pwrdwn_pll(aData)
        write_pwrdwn_pll_value = aData
        flag_pwrdwn_pll        = &H1
    End Property

    Property Get read_pwrdwn_pll
        read
        read_pwrdwn_pll = read_pwrdwn_pll_value
    End Property

    Property Let write_pwrdwn_pll(aData)
        set_pwrdwn_pll = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_force_pll_lock_value = rightShift(data_low, 12) and &H1
        read_pwrdwn_force_value = rightShift(data_low, 11) and &H1
        read_pwrdwn_pll_value = rightShift(data_low, 8) and &H1

    End Sub

    Sub write
        If flag_force_pll_lock = &H0 or flag_pwrdwn_force = &H0 or flag_pwrdwn_pll = &H0 Then read
        If flag_force_pll_lock = &H0 Then write_force_pll_lock_value = get_force_pll_lock
        If flag_pwrdwn_force = &H0 Then write_pwrdwn_force_value = get_pwrdwn_force
        If flag_pwrdwn_pll = &H0 Then write_pwrdwn_pll_value = get_pwrdwn_pll

        regValue = leftShift((write_force_pll_lock_value and &H1), 12) + leftShift((write_pwrdwn_force_value and &H1), 11) + leftShift((write_pwrdwn_pll_value and &H1), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_force_pll_lock_value = rightShift(data_low, 12) and &H1
        read_pwrdwn_force_value = rightShift(data_low, 11) and &H1
        read_pwrdwn_pll_value = rightShift(data_low, 8) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_force_pll_lock_value = &H0
        flag_force_pll_lock        = &H0
        write_pwrdwn_force_value = &H0
        flag_pwrdwn_force        = &H0
        write_pwrdwn_pll_value = &H0
        flag_pwrdwn_pll        = &H0
    End Sub
End Class


'' @REGISTER : XGXSBLK1_SGMIIPCIE_X1_blockaddress
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
Class REGISTER_XGXSBLK1_SGMIIPCIE_X1_blockaddress
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

Class XGXSBLK1_SGMIIPCIE_X1_INSTANCE

    Public lanectrl3
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set lanectrl3 = (New REGISTER_XGXSBLK1_SGMIIPCIE_X1_lanectrl3)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_XGXSBLK1_SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set XGXSBLK1_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
XGXSBLK1_SGMIIPCIE_X1.Add ((New XGXSBLK1_SGMIIPCIE_X1_INSTANCE)(&H4add0020))


