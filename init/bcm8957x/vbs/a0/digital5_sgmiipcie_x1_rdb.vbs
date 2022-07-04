

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


'' @REGISTER : DIGITAL5_SGMIIPCIE_X1_misc8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' force_oscdr_mode                           [3:0]            get_force_oscdr_mode
''                                                             set_force_oscdr_mode
''                                                             read_force_oscdr_mode
''                                                             write_force_oscdr_mode
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL5_SGMIIPCIE_X1_misc8
    Private write_force_oscdr_mode_value
    Private read_force_oscdr_mode_value
    Private flag_force_oscdr_mode

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

    Property Get get_force_oscdr_mode
        get_force_oscdr_mode = read_force_oscdr_mode_value
    End Property

    Property Let set_force_oscdr_mode(aData)
        write_force_oscdr_mode_value = aData
        flag_force_oscdr_mode        = &H1
    End Property

    Property Get read_force_oscdr_mode
        read
        read_force_oscdr_mode = read_force_oscdr_mode_value
    End Property

    Property Let write_force_oscdr_mode(aData)
        set_force_oscdr_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        force_oscdr_mode_mask = &Hf
        if data_low > LONG_MAX then
            if force_oscdr_mode_mask = mask then
                read_force_oscdr_mode_value = data_low
            else
                read_force_oscdr_mode_value = (data_low - H8000_0000) and force_oscdr_mode_mask
            end If
        else
            read_force_oscdr_mode_value = data_low and force_oscdr_mode_mask
        end If

    End Sub

    Sub write
        If flag_force_oscdr_mode = &H0 Then read
        If flag_force_oscdr_mode = &H0 Then write_force_oscdr_mode_value = get_force_oscdr_mode

        regValue = leftShift((write_force_oscdr_mode_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        force_oscdr_mode_mask = &Hf
        if data_low > LONG_MAX then
            if force_oscdr_mode_mask = mask then
                read_force_oscdr_mode_value = data_low
            else
                read_force_oscdr_mode_value = (data_low - H8000_0000) and force_oscdr_mode_mask
            end If
        else
            read_force_oscdr_mode_value = data_low and force_oscdr_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_force_oscdr_mode_value = &H0
        flag_force_oscdr_mode        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL5_SGMIIPCIE_X1_link_speed
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Link_Speed_Status                          [2:0]            get_Link_Speed_Status
''                                                             set_Link_Speed_Status
''                                                             read_Link_Speed_Status
''                                                             write_Link_Speed_Status
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL5_SGMIIPCIE_X1_link_speed
    Private write_Link_Speed_Status_value
    Private read_Link_Speed_Status_value
    Private flag_Link_Speed_Status

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

    Property Get get_Link_Speed_Status
        get_Link_Speed_Status = read_Link_Speed_Status_value
    End Property

    Property Let set_Link_Speed_Status(aData)
        write_Link_Speed_Status_value = aData
        flag_Link_Speed_Status        = &H1
    End Property

    Property Get read_Link_Speed_Status
        read
        read_Link_Speed_Status = read_Link_Speed_Status_value
    End Property

    Property Let write_Link_Speed_Status(aData)
        set_Link_Speed_Status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Link_Speed_Status_mask = &H7
        if data_low > LONG_MAX then
            if Link_Speed_Status_mask = mask then
                read_Link_Speed_Status_value = data_low
            else
                read_Link_Speed_Status_value = (data_low - H8000_0000) and Link_Speed_Status_mask
            end If
        else
            read_Link_Speed_Status_value = data_low and Link_Speed_Status_mask
        end If

    End Sub

    Sub write
        If flag_Link_Speed_Status = &H0 Then read
        If flag_Link_Speed_Status = &H0 Then write_Link_Speed_Status_value = get_Link_Speed_Status

        regValue = leftShift((write_Link_Speed_Status_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Link_Speed_Status_mask = &H7
        if data_low > LONG_MAX then
            if Link_Speed_Status_mask = mask then
                read_Link_Speed_Status_value = data_low
            else
                read_Link_Speed_Status_value = (data_low - H8000_0000) and Link_Speed_Status_mask
            end If
        else
            read_Link_Speed_Status_value = data_low and Link_Speed_Status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Link_Speed_Status_value = &H0
        flag_Link_Speed_Status        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL5_SGMIIPCIE_X1_blockaddress
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
Class REGISTER_DIGITAL5_SGMIIPCIE_X1_blockaddress
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

Class DIGITAL5_SGMIIPCIE_X1_INSTANCE

    Public misc8
    Public link_speed
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set misc8 = (New REGISTER_DIGITAL5_SGMIIPCIE_X1_misc8)(aBaseAddr, 16)
        Set link_speed = (New REGISTER_DIGITAL5_SGMIIPCIE_X1_link_speed)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_DIGITAL5_SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DIGITAL5_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
DIGITAL5_SGMIIPCIE_X1.Add ((New DIGITAL5_SGMIIPCIE_X1_INSTANCE)(&H4add0680))


