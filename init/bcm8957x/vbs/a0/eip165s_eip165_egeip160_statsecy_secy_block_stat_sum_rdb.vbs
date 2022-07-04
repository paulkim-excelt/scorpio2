

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_secy_count_summary_p1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_15_0                                  [15:0]           get_SECY_15_0
''                                                             set_SECY_15_0
''                                                             read_SECY_15_0
''                                                             write_SECY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_secy_count_summary_p1
    Private write_SECY_15_0_value
    Private read_SECY_15_0_value
    Private flag_SECY_15_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e450
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_15_0
        get_SECY_15_0 = read_SECY_15_0_value
    End Property

    Property Let set_SECY_15_0(aData)
        write_SECY_15_0_value = aData
        flag_SECY_15_0        = &H1
    End Property

    Property Get read_SECY_15_0
        read
        read_SECY_15_0 = read_SECY_15_0_value
    End Property

    Property Let write_SECY_15_0(aData)
        set_SECY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if SECY_15_0_mask = mask then
                read_SECY_15_0_value = data_low
            else
                read_SECY_15_0_value = (data_low - H8000_0000) and SECY_15_0_mask
            end If
        else
            read_SECY_15_0_value = data_low and SECY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_SECY_15_0 = &H0 Then read
        If flag_SECY_15_0 = &H0 Then write_SECY_15_0_value = get_SECY_15_0

        regValue = leftShift((write_SECY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if SECY_15_0_mask = mask then
                read_SECY_15_0_value = data_low
            else
                read_SECY_15_0_value = (data_low - H8000_0000) and SECY_15_0_mask
            end If
        else
            read_SECY_15_0_value = data_low and SECY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_15_0_value = &H0
        flag_SECY_15_0        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_INSTANCE

    Public secy_count_summary_p1


    Public default function Init(aBaseAddr)
        Set secy_count_summary_p1 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_secy_count_summary_p1)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_BLOCK_STAT_SUM_INSTANCE)(&H4d510000))


