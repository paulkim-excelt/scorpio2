

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_tcam_count_frame_thr_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CFT310                                     [31:0]           get_CFT310
''                                                             set_CFT310
''                                                             read_CFT310
''                                                             write_CFT310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_tcam_count_frame_thr_1
    Private write_CFT310_value
    Private read_CFT310_value
    Private flag_CFT310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4420
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CFT310
        get_CFT310 = read_CFT310_value
    End Property

    Property Let set_CFT310(aData)
        write_CFT310_value = aData
        flag_CFT310        = &H1
    End Property

    Property Get read_CFT310
        read
        read_CFT310 = read_CFT310_value
    End Property

    Property Let write_CFT310(aData)
        set_CFT310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CFT310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CFT310_mask = mask then
                read_CFT310_value = data_low
            else
                read_CFT310_value = (data_low - H8000_0000) and CFT310_mask
            end If
        else
            read_CFT310_value = data_low and CFT310_mask
        end If

    End Sub

    Sub write
        If flag_CFT310 = &H0 Then read
        If flag_CFT310 = &H0 Then write_CFT310_value = get_CFT310

        regValue = leftShift(write_CFT310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CFT310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CFT310_mask = mask then
                read_CFT310_value = data_low
            else
                read_CFT310_value = (data_low - H8000_0000) and CFT310_mask
            end If
        else
            read_CFT310_value = data_low and CFT310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CFT310_value = &H0
        flag_CFT310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_tcam_count_frame_thr_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CFT6332                                    [31:0]           get_CFT6332
''                                                             set_CFT6332
''                                                             read_CFT6332
''                                                             write_CFT6332
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_tcam_count_frame_thr_2
    Private write_CFT6332_value
    Private read_CFT6332_value
    Private flag_CFT6332

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4424
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CFT6332
        get_CFT6332 = read_CFT6332_value
    End Property

    Property Let set_CFT6332(aData)
        write_CFT6332_value = aData
        flag_CFT6332        = &H1
    End Property

    Property Get read_CFT6332
        read
        read_CFT6332 = read_CFT6332_value
    End Property

    Property Let write_CFT6332(aData)
        set_CFT6332 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CFT6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CFT6332_mask = mask then
                read_CFT6332_value = data_low
            else
                read_CFT6332_value = (data_low - H8000_0000) and CFT6332_mask
            end If
        else
            read_CFT6332_value = data_low and CFT6332_mask
        end If

    End Sub

    Sub write
        If flag_CFT6332 = &H0 Then read
        If flag_CFT6332 = &H0 Then write_CFT6332_value = get_CFT6332

        regValue = leftShift(write_CFT6332_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CFT6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CFT6332_mask = mask then
                read_CFT6332_value = data_low
            else
                read_CFT6332_value = (data_low - H8000_0000) and CFT6332_mask
            end If
        else
            read_CFT6332_value = data_low and CFT6332_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CFT6332_value = &H0
        flag_CFT6332        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_INSTANCE

    Public tcam_count_frame_thr_1
    Public tcam_count_frame_thr_2


    Public default function Init(aBaseAddr)
        Set tcam_count_frame_thr_1 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_tcam_count_frame_thr_1)(aBaseAddr, 32)
        Set tcam_count_frame_thr_2 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_tcam_count_frame_thr_2)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_SUMMARY_THRESHOLDS_INSTANCE)(&H4d510000))


