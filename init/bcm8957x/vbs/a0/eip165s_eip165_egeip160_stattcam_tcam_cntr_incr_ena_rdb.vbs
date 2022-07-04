

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_tcam_count_incen1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIE                                        [0:0]            get_TIE
''                                                             set_TIE
''                                                             read_TIE
''                                                             write_TIE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_tcam_count_incen1
    Private write_TIE_value
    Private read_TIE_value
    Private flag_TIE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TIE
        get_TIE = read_TIE_value
    End Property

    Property Let set_TIE(aData)
        write_TIE_value = aData
        flag_TIE        = &H1
    End Property

    Property Get read_TIE
        read
        read_TIE = read_TIE_value
    End Property

    Property Let write_TIE(aData)
        set_TIE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIE_mask = &H1
        if data_low > LONG_MAX then
            if TIE_mask = mask then
                read_TIE_value = data_low
            else
                read_TIE_value = (data_low - H8000_0000) and TIE_mask
            end If
        else
            read_TIE_value = data_low and TIE_mask
        end If

    End Sub

    Sub write
        If flag_TIE = &H0 Then read
        If flag_TIE = &H0 Then write_TIE_value = get_TIE

        regValue = leftShift((write_TIE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIE_mask = &H1
        if data_low > LONG_MAX then
            if TIE_mask = mask then
                read_TIE_value = data_low
            else
                read_TIE_value = (data_low - H8000_0000) and TIE_mask
            end If
        else
            read_TIE_value = data_low and TIE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIE_value = &H0
        flag_TIE        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_tcam_count_incen2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GIE                                        [2:0]            get_GIE
''                                                             set_GIE
''                                                             read_GIE
''                                                             write_GIE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_tcam_count_incen2
    Private write_GIE_value
    Private read_GIE_value
    Private flag_GIE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14418
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_GIE
        get_GIE = read_GIE_value
    End Property

    Property Let set_GIE(aData)
        write_GIE_value = aData
        flag_GIE        = &H1
    End Property

    Property Get read_GIE
        read
        read_GIE = read_GIE_value
    End Property

    Property Let write_GIE(aData)
        set_GIE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GIE_mask = &H7
        if data_low > LONG_MAX then
            if GIE_mask = mask then
                read_GIE_value = data_low
            else
                read_GIE_value = (data_low - H8000_0000) and GIE_mask
            end If
        else
            read_GIE_value = data_low and GIE_mask
        end If

    End Sub

    Sub write
        If flag_GIE = &H0 Then read
        If flag_GIE = &H0 Then write_GIE_value = get_GIE

        regValue = leftShift((write_GIE_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GIE_mask = &H7
        if data_low > LONG_MAX then
            if GIE_mask = mask then
                read_GIE_value = data_low
            else
                read_GIE_value = (data_low - H8000_0000) and GIE_mask
            end If
        else
            read_GIE_value = data_low and GIE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GIE_value = &H0
        flag_GIE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_INSTANCE

    Public tcam_count_incen1
    Public tcam_count_incen2


    Public default function Init(aBaseAddr)
        Set tcam_count_incen1 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_tcam_count_incen1)(aBaseAddr, 32)
        Set tcam_count_incen2 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_tcam_count_incen2)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_INCR_ENA_INSTANCE)(&H4d510000))


