

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


'' @REGISTER : PCSCOM_SGMIIPLUS2_X2_pcs_maskdata
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pcs_maskdata                               [15:0]           get_pcs_maskdata
''                                                             set_pcs_maskdata
''                                                             read_pcs_maskdata
''                                                             write_pcs_maskdata
''---------------------------------------------------------------------------------
Class REGISTER_PCSCOM_SGMIIPLUS2_X2_pcs_maskdata
    Private write_pcs_maskdata_value
    Private read_pcs_maskdata_value
    Private flag_pcs_maskdata

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

    Property Get get_pcs_maskdata
        get_pcs_maskdata = read_pcs_maskdata_value
    End Property

    Property Let set_pcs_maskdata(aData)
        write_pcs_maskdata_value = aData
        flag_pcs_maskdata        = &H1
    End Property

    Property Get read_pcs_maskdata
        read
        read_pcs_maskdata = read_pcs_maskdata_value
    End Property

    Property Let write_pcs_maskdata(aData)
        set_pcs_maskdata = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcs_maskdata_mask = &Hffff
        if data_low > LONG_MAX then
            if pcs_maskdata_mask = mask then
                read_pcs_maskdata_value = data_low
            else
                read_pcs_maskdata_value = (data_low - H8000_0000) and pcs_maskdata_mask
            end If
        else
            read_pcs_maskdata_value = data_low and pcs_maskdata_mask
        end If

    End Sub

    Sub write
        If flag_pcs_maskdata = &H0 Then read
        If flag_pcs_maskdata = &H0 Then write_pcs_maskdata_value = get_pcs_maskdata

        regValue = leftShift((write_pcs_maskdata_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcs_maskdata_mask = &Hffff
        if data_low > LONG_MAX then
            if pcs_maskdata_mask = mask then
                read_pcs_maskdata_value = data_low
            else
                read_pcs_maskdata_value = (data_low - H8000_0000) and pcs_maskdata_mask
            end If
        else
            read_pcs_maskdata_value = data_low and pcs_maskdata_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pcs_maskdata_value = &H0
        flag_pcs_maskdata        = &H0
    End Sub
End Class


'' @REGISTER : PCSCOM_SGMIIPLUS2_X2_pcs_maskdata_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pcs_maskdata_bus_assign                    [1:0]            get_pcs_maskdata_bus_assign
''                                                             set_pcs_maskdata_bus_assign
''                                                             read_pcs_maskdata_bus_assign
''                                                             write_pcs_maskdata_bus_assign
''---------------------------------------------------------------------------------
Class REGISTER_PCSCOM_SGMIIPLUS2_X2_pcs_maskdata_ctrl
    Private write_pcs_maskdata_bus_assign_value
    Private read_pcs_maskdata_bus_assign_value
    Private flag_pcs_maskdata_bus_assign

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

    Property Get get_pcs_maskdata_bus_assign
        get_pcs_maskdata_bus_assign = read_pcs_maskdata_bus_assign_value
    End Property

    Property Let set_pcs_maskdata_bus_assign(aData)
        write_pcs_maskdata_bus_assign_value = aData
        flag_pcs_maskdata_bus_assign        = &H1
    End Property

    Property Get read_pcs_maskdata_bus_assign
        read
        read_pcs_maskdata_bus_assign = read_pcs_maskdata_bus_assign_value
    End Property

    Property Let write_pcs_maskdata_bus_assign(aData)
        set_pcs_maskdata_bus_assign = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcs_maskdata_bus_assign_mask = &H3
        if data_low > LONG_MAX then
            if pcs_maskdata_bus_assign_mask = mask then
                read_pcs_maskdata_bus_assign_value = data_low
            else
                read_pcs_maskdata_bus_assign_value = (data_low - H8000_0000) and pcs_maskdata_bus_assign_mask
            end If
        else
            read_pcs_maskdata_bus_assign_value = data_low and pcs_maskdata_bus_assign_mask
        end If

    End Sub

    Sub write
        If flag_pcs_maskdata_bus_assign = &H0 Then read
        If flag_pcs_maskdata_bus_assign = &H0 Then write_pcs_maskdata_bus_assign_value = get_pcs_maskdata_bus_assign

        regValue = leftShift((write_pcs_maskdata_bus_assign_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcs_maskdata_bus_assign_mask = &H3
        if data_low > LONG_MAX then
            if pcs_maskdata_bus_assign_mask = mask then
                read_pcs_maskdata_bus_assign_value = data_low
            else
                read_pcs_maskdata_bus_assign_value = (data_low - H8000_0000) and pcs_maskdata_bus_assign_mask
            end If
        else
            read_pcs_maskdata_bus_assign_value = data_low and pcs_maskdata_bus_assign_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pcs_maskdata_bus_assign_value = &H0
        flag_pcs_maskdata_bus_assign        = &H0
    End Sub
End Class


'' @REGISTER : PCSCOM_SGMIIPLUS2_X2_pcs_ln_offset
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pcs_ln_offset                              [4:0]            get_pcs_ln_offset
''                                                             set_pcs_ln_offset
''                                                             read_pcs_ln_offset
''                                                             write_pcs_ln_offset
''---------------------------------------------------------------------------------
Class REGISTER_PCSCOM_SGMIIPLUS2_X2_pcs_ln_offset
    Private write_pcs_ln_offset_value
    Private read_pcs_ln_offset_value
    Private flag_pcs_ln_offset

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

    Property Get get_pcs_ln_offset
        get_pcs_ln_offset = read_pcs_ln_offset_value
    End Property

    Property Let set_pcs_ln_offset(aData)
        write_pcs_ln_offset_value = aData
        flag_pcs_ln_offset        = &H1
    End Property

    Property Get read_pcs_ln_offset
        read
        read_pcs_ln_offset = read_pcs_ln_offset_value
    End Property

    Property Let write_pcs_ln_offset(aData)
        set_pcs_ln_offset = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcs_ln_offset_mask = &H1f
        if data_low > LONG_MAX then
            if pcs_ln_offset_mask = mask then
                read_pcs_ln_offset_value = data_low
            else
                read_pcs_ln_offset_value = (data_low - H8000_0000) and pcs_ln_offset_mask
            end If
        else
            read_pcs_ln_offset_value = data_low and pcs_ln_offset_mask
        end If

    End Sub

    Sub write
        If flag_pcs_ln_offset = &H0 Then read
        If flag_pcs_ln_offset = &H0 Then write_pcs_ln_offset_value = get_pcs_ln_offset

        regValue = leftShift((write_pcs_ln_offset_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pcs_ln_offset_mask = &H1f
        if data_low > LONG_MAX then
            if pcs_ln_offset_mask = mask then
                read_pcs_ln_offset_value = data_low
            else
                read_pcs_ln_offset_value = (data_low - H8000_0000) and pcs_ln_offset_mask
            end If
        else
            read_pcs_ln_offset_value = data_low and pcs_ln_offset_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pcs_ln_offset_value = &H0
        flag_pcs_ln_offset        = &H0
    End Sub
End Class


'' @REGISTER : PCSCOM_SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_PCSCOM_SGMIIPLUS2_X2_blockaddress
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

Class PCSCOM_SGMIIPLUS2_X2_INSTANCE

    Public pcs_maskdata
    Public pcs_maskdata_ctrl
    Public pcs_ln_offset
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set pcs_maskdata = (New REGISTER_PCSCOM_SGMIIPLUS2_X2_pcs_maskdata)(aBaseAddr, 16)
        Set pcs_maskdata_ctrl = (New REGISTER_PCSCOM_SGMIIPLUS2_X2_pcs_maskdata_ctrl)(aBaseAddr, 16)
        Set pcs_ln_offset = (New REGISTER_PCSCOM_SGMIIPLUS2_X2_pcs_ln_offset)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_PCSCOM_SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCSCOM_SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
PCSCOM_SGMIIPLUS2_X2.Add ((New PCSCOM_SGMIIPLUS2_X2_INSTANCE)(&H4acd0320))


