

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


'' @REGISTER : AFE_ANA_spare_start_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_START_ADDR                           [15:0]           get_SPARE_START_ADDR
''                                                             set_SPARE_START_ADDR
''                                                             read_SPARE_START_ADDR
''                                                             write_SPARE_START_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_AFE_ANA_spare_start_addr
    Private write_SPARE_START_ADDR_value
    Private read_SPARE_START_ADDR_value
    Private flag_SPARE_START_ADDR

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

    Property Get get_SPARE_START_ADDR
        get_SPARE_START_ADDR = read_SPARE_START_ADDR_value
    End Property

    Property Let set_SPARE_START_ADDR(aData)
        write_SPARE_START_ADDR_value = aData
        flag_SPARE_START_ADDR        = &H1
    End Property

    Property Get read_SPARE_START_ADDR
        read
        read_SPARE_START_ADDR = read_SPARE_START_ADDR_value
    End Property

    Property Let write_SPARE_START_ADDR(aData)
        set_SPARE_START_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_START_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_START_ADDR_mask = mask then
                read_SPARE_START_ADDR_value = data_low
            else
                read_SPARE_START_ADDR_value = (data_low - H8000_0000) and SPARE_START_ADDR_mask
            end If
        else
            read_SPARE_START_ADDR_value = data_low and SPARE_START_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_START_ADDR = &H0 Then read
        If flag_SPARE_START_ADDR = &H0 Then write_SPARE_START_ADDR_value = get_SPARE_START_ADDR

        regValue = leftShift((write_SPARE_START_ADDR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_START_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_START_ADDR_mask = mask then
                read_SPARE_START_ADDR_value = data_low
            else
                read_SPARE_START_ADDR_value = (data_low - H8000_0000) and SPARE_START_ADDR_mask
            end If
        else
            read_SPARE_START_ADDR_value = data_low and SPARE_START_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_START_ADDR_value = &H0
        flag_SPARE_START_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : AFE_ANA_spare_end_addr
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
Class REGISTER_AFE_ANA_spare_end_addr
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
        offset = &Hbfe
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

Class AFE_ANA_INSTANCE

    Public spare_start_addr
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set spare_start_addr = (New REGISTER_AFE_ANA_spare_start_addr)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_AFE_ANA_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AFE_ANA = CreateObject("System.Collections.ArrayList")
AFE_ANA.Add ((New AFE_ANA_INSTANCE)(&H49036000))


