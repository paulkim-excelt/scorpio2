

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_secy_count_incen1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SIE                                        [2:0]            get_SIE
''                                                             set_SIE
''                                                             read_SIE
''                                                             write_SIE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_secy_count_incen1
    Private write_SIE_value
    Private read_SIE_value
    Private flag_SIE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e414
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SIE
        get_SIE = read_SIE_value
    End Property

    Property Let set_SIE(aData)
        write_SIE_value = aData
        flag_SIE        = &H1
    End Property

    Property Get read_SIE
        read
        read_SIE = read_SIE_value
    End Property

    Property Let write_SIE(aData)
        set_SIE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SIE_mask = &H7
        if data_low > LONG_MAX then
            if SIE_mask = mask then
                read_SIE_value = data_low
            else
                read_SIE_value = (data_low - H8000_0000) and SIE_mask
            end If
        else
            read_SIE_value = data_low and SIE_mask
        end If

    End Sub

    Sub write
        If flag_SIE = &H0 Then read
        If flag_SIE = &H0 Then write_SIE_value = get_SIE

        regValue = leftShift((write_SIE_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SIE_mask = &H7
        if data_low > LONG_MAX then
            if SIE_mask = mask then
                read_SIE_value = data_low
            else
                read_SIE_value = (data_low - H8000_0000) and SIE_mask
            end If
        else
            read_SIE_value = data_low and SIE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SIE_value = &H0
        flag_SIE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_INSTANCE

    Public secy_count_incen1


    Public default function Init(aBaseAddr)
        Set secy_count_incen1 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_secy_count_incen1)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_INCR_ENA_INSTANCE)(&H4d510000))


