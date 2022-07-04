

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_ifc_count_incen1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IIE                                        [7:0]            get_IIE
''                                                             set_IIE
''                                                             read_IIE
''                                                             write_IIE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_ifc_count_incen1
    Private write_IIE_value
    Private read_IIE_value
    Private flag_IIE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He614
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IIE
        get_IIE = read_IIE_value
    End Property

    Property Let set_IIE(aData)
        write_IIE_value = aData
        flag_IIE        = &H1
    End Property

    Property Get read_IIE
        read
        read_IIE = read_IIE_value
    End Property

    Property Let write_IIE(aData)
        set_IIE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IIE_mask = &Hff
        if data_low > LONG_MAX then
            if IIE_mask = mask then
                read_IIE_value = data_low
            else
                read_IIE_value = (data_low - H8000_0000) and IIE_mask
            end If
        else
            read_IIE_value = data_low and IIE_mask
        end If

    End Sub

    Sub write
        If flag_IIE = &H0 Then read
        If flag_IIE = &H0 Then write_IIE_value = get_IIE

        regValue = leftShift((write_IIE_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IIE_mask = &Hff
        if data_low > LONG_MAX then
            if IIE_mask = mask then
                read_IIE_value = data_low
            else
                read_IIE_value = (data_low - H8000_0000) and IIE_mask
            end If
        else
            read_IIE_value = data_low and IIE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IIE_value = &H0
        flag_IIE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_INSTANCE

    Public ifc_count_incen1


    Public default function Init(aBaseAddr)
        Set ifc_count_incen1 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_ifc_count_incen1)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_INCR_ENA_INSTANCE)(&H4d510000))


