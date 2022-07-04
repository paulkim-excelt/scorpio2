

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_tcam_count_summary_gl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GLOBAL_CNT                                 [31:0]           get_GLOBAL_CNT
''                                                             set_GLOBAL_CNT
''                                                             read_GLOBAL_CNT
''                                                             write_GLOBAL_CNT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_tcam_count_summary_gl
    Private write_GLOBAL_CNT_value
    Private read_GLOBAL_CNT_value
    Private flag_GLOBAL_CNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14440
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_GLOBAL_CNT
        get_GLOBAL_CNT = read_GLOBAL_CNT_value
    End Property

    Property Let set_GLOBAL_CNT(aData)
        write_GLOBAL_CNT_value = aData
        flag_GLOBAL_CNT        = &H1
    End Property

    Property Get read_GLOBAL_CNT
        read
        read_GLOBAL_CNT = read_GLOBAL_CNT_value
    End Property

    Property Let write_GLOBAL_CNT(aData)
        set_GLOBAL_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GLOBAL_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if GLOBAL_CNT_mask = mask then
                read_GLOBAL_CNT_value = data_low
            else
                read_GLOBAL_CNT_value = (data_low - H8000_0000) and GLOBAL_CNT_mask
            end If
        else
            read_GLOBAL_CNT_value = data_low and GLOBAL_CNT_mask
        end If

    End Sub

    Sub write
        If flag_GLOBAL_CNT = &H0 Then read
        If flag_GLOBAL_CNT = &H0 Then write_GLOBAL_CNT_value = get_GLOBAL_CNT

        regValue = leftShift(write_GLOBAL_CNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GLOBAL_CNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if GLOBAL_CNT_mask = mask then
                read_GLOBAL_CNT_value = data_low
            else
                read_GLOBAL_CNT_value = (data_low - H8000_0000) and GLOBAL_CNT_mask
            end If
        else
            read_GLOBAL_CNT_value = data_low and GLOBAL_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GLOBAL_CNT_value = &H0
        flag_GLOBAL_CNT        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_INSTANCE

    Public tcam_count_summary_gl


    Public default function Init(aBaseAddr)
        Set tcam_count_summary_gl = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_tcam_count_summary_gl)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_GLBL_STAT_SUM_INSTANCE)(&H4d510000))


