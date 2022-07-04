

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


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_pol_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PC0                                        [0:0]            get_PC0
''                                                             set_PC0
''                                                             read_PC0
''                                                             write_PC0
''---------------------------------------------------------------------------------
'' PC1                                        [1:1]            get_PC1
''                                                             set_PC1
''                                                             read_PC1
''                                                             write_PC1
''---------------------------------------------------------------------------------
'' PC2                                        [2:2]            get_PC2
''                                                             set_PC2
''                                                             read_PC2
''                                                             write_PC2
''---------------------------------------------------------------------------------
'' PC3                                        [3:3]            get_PC3
''                                                             set_PC3
''                                                             read_PC3
''                                                             write_PC3
''---------------------------------------------------------------------------------
'' PC4                                        [4:4]            get_PC4
''                                                             set_PC4
''                                                             read_PC4
''                                                             write_PC4
''---------------------------------------------------------------------------------
'' PC5                                        [5:5]            get_PC5
''                                                             set_PC5
''                                                             read_PC5
''                                                             write_PC5
''---------------------------------------------------------------------------------
'' PC6                                        [6:6]            get_PC6
''                                                             set_PC6
''                                                             read_PC6
''                                                             write_PC6
''---------------------------------------------------------------------------------
'' PC7                                        [7:7]            get_PC7
''                                                             set_PC7
''                                                             read_PC7
''                                                             write_PC7
''---------------------------------------------------------------------------------
'' PC8                                        [8:8]            get_PC8
''                                                             set_PC8
''                                                             read_PC8
''                                                             write_PC8
''---------------------------------------------------------------------------------
'' PC9                                        [9:9]            get_PC9
''                                                             set_PC9
''                                                             read_PC9
''                                                             write_PC9
''---------------------------------------------------------------------------------
'' PC10                                       [10:10]          get_PC10
''                                                             set_PC10
''                                                             read_PC10
''                                                             write_PC10
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_pol_ctrl
    Private write_PC0_value
    Private read_PC0_value
    Private flag_PC0
    Private write_PC1_value
    Private read_PC1_value
    Private flag_PC1
    Private write_PC2_value
    Private read_PC2_value
    Private flag_PC2
    Private write_PC3_value
    Private read_PC3_value
    Private flag_PC3
    Private write_PC4_value
    Private read_PC4_value
    Private flag_PC4
    Private write_PC5_value
    Private read_PC5_value
    Private flag_PC5
    Private write_PC6_value
    Private read_PC6_value
    Private flag_PC6
    Private write_PC7_value
    Private read_PC7_value
    Private flag_PC7
    Private write_PC8_value
    Private read_PC8_value
    Private flag_PC8
    Private write_PC9_value
    Private read_PC9_value
    Private flag_PC9
    Private write_PC10_value
    Private read_PC10_value
    Private flag_PC10

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PC0
        get_PC0 = read_PC0_value
    End Property

    Property Let set_PC0(aData)
        write_PC0_value = aData
        flag_PC0        = &H1
    End Property

    Property Get read_PC0
        read
        read_PC0 = read_PC0_value
    End Property

    Property Let write_PC0(aData)
        set_PC0 = aData
        write
    End Property

    Property Get get_PC1
        get_PC1 = read_PC1_value
    End Property

    Property Let set_PC1(aData)
        write_PC1_value = aData
        flag_PC1        = &H1
    End Property

    Property Get read_PC1
        read
        read_PC1 = read_PC1_value
    End Property

    Property Let write_PC1(aData)
        set_PC1 = aData
        write
    End Property

    Property Get get_PC2
        get_PC2 = read_PC2_value
    End Property

    Property Let set_PC2(aData)
        write_PC2_value = aData
        flag_PC2        = &H1
    End Property

    Property Get read_PC2
        read
        read_PC2 = read_PC2_value
    End Property

    Property Let write_PC2(aData)
        set_PC2 = aData
        write
    End Property

    Property Get get_PC3
        get_PC3 = read_PC3_value
    End Property

    Property Let set_PC3(aData)
        write_PC3_value = aData
        flag_PC3        = &H1
    End Property

    Property Get read_PC3
        read
        read_PC3 = read_PC3_value
    End Property

    Property Let write_PC3(aData)
        set_PC3 = aData
        write
    End Property

    Property Get get_PC4
        get_PC4 = read_PC4_value
    End Property

    Property Let set_PC4(aData)
        write_PC4_value = aData
        flag_PC4        = &H1
    End Property

    Property Get read_PC4
        read
        read_PC4 = read_PC4_value
    End Property

    Property Let write_PC4(aData)
        set_PC4 = aData
        write
    End Property

    Property Get get_PC5
        get_PC5 = read_PC5_value
    End Property

    Property Let set_PC5(aData)
        write_PC5_value = aData
        flag_PC5        = &H1
    End Property

    Property Get read_PC5
        read
        read_PC5 = read_PC5_value
    End Property

    Property Let write_PC5(aData)
        set_PC5 = aData
        write
    End Property

    Property Get get_PC6
        get_PC6 = read_PC6_value
    End Property

    Property Let set_PC6(aData)
        write_PC6_value = aData
        flag_PC6        = &H1
    End Property

    Property Get read_PC6
        read
        read_PC6 = read_PC6_value
    End Property

    Property Let write_PC6(aData)
        set_PC6 = aData
        write
    End Property

    Property Get get_PC7
        get_PC7 = read_PC7_value
    End Property

    Property Let set_PC7(aData)
        write_PC7_value = aData
        flag_PC7        = &H1
    End Property

    Property Get read_PC7
        read
        read_PC7 = read_PC7_value
    End Property

    Property Let write_PC7(aData)
        set_PC7 = aData
        write
    End Property

    Property Get get_PC8
        get_PC8 = read_PC8_value
    End Property

    Property Let set_PC8(aData)
        write_PC8_value = aData
        flag_PC8        = &H1
    End Property

    Property Get read_PC8
        read
        read_PC8 = read_PC8_value
    End Property

    Property Let write_PC8(aData)
        set_PC8 = aData
        write
    End Property

    Property Get get_PC9
        get_PC9 = read_PC9_value
    End Property

    Property Let set_PC9(aData)
        write_PC9_value = aData
        flag_PC9        = &H1
    End Property

    Property Get read_PC9
        read
        read_PC9 = read_PC9_value
    End Property

    Property Let write_PC9(aData)
        set_PC9 = aData
        write
    End Property

    Property Get get_PC10
        get_PC10 = read_PC10_value
    End Property

    Property Let set_PC10(aData)
        write_PC10_value = aData
        flag_PC10        = &H1
    End Property

    Property Get read_PC10
        read
        read_PC10 = read_PC10_value
    End Property

    Property Let write_PC10(aData)
        set_PC10 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PC0_mask = &H1
        if data_low > LONG_MAX then
            if PC0_mask = mask then
                read_PC0_value = data_low
            else
                read_PC0_value = (data_low - H8000_0000) and PC0_mask
            end If
        else
            read_PC0_value = data_low and PC0_mask
        end If
        read_PC1_value = rightShift(data_low, 1) and &H1
        read_PC2_value = rightShift(data_low, 2) and &H1
        read_PC3_value = rightShift(data_low, 3) and &H1
        read_PC4_value = rightShift(data_low, 4) and &H1
        read_PC5_value = rightShift(data_low, 5) and &H1
        read_PC6_value = rightShift(data_low, 6) and &H1
        read_PC7_value = rightShift(data_low, 7) and &H1
        read_PC8_value = rightShift(data_low, 8) and &H1
        read_PC9_value = rightShift(data_low, 9) and &H1
        read_PC10_value = rightShift(data_low, 10) and &H1

    End Sub

    Sub write
        If flag_PC0 = &H0 or flag_PC1 = &H0 or flag_PC2 = &H0 or flag_PC3 = &H0 or flag_PC4 = &H0 or flag_PC5 = &H0 or flag_PC6 = &H0 or flag_PC7 = &H0 or flag_PC8 = &H0 or flag_PC9 = &H0 or flag_PC10 = &H0 Then read
        If flag_PC0 = &H0 Then write_PC0_value = get_PC0
        If flag_PC1 = &H0 Then write_PC1_value = get_PC1
        If flag_PC2 = &H0 Then write_PC2_value = get_PC2
        If flag_PC3 = &H0 Then write_PC3_value = get_PC3
        If flag_PC4 = &H0 Then write_PC4_value = get_PC4
        If flag_PC5 = &H0 Then write_PC5_value = get_PC5
        If flag_PC6 = &H0 Then write_PC6_value = get_PC6
        If flag_PC7 = &H0 Then write_PC7_value = get_PC7
        If flag_PC8 = &H0 Then write_PC8_value = get_PC8
        If flag_PC9 = &H0 Then write_PC9_value = get_PC9
        If flag_PC10 = &H0 Then write_PC10_value = get_PC10

        regValue = leftShift((write_PC0_value and &H1), 0) + leftShift((write_PC1_value and &H1), 1) + leftShift((write_PC2_value and &H1), 2) + leftShift((write_PC3_value and &H1), 3) + leftShift((write_PC4_value and &H1), 4) + leftShift((write_PC5_value and &H1), 5) + leftShift((write_PC6_value and &H1), 6) + leftShift((write_PC7_value and &H1), 7) + leftShift((write_PC8_value and &H1), 8) + leftShift((write_PC9_value and &H1), 9) + leftShift((write_PC10_value and &H1), 10)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PC0_mask = &H1
        if data_low > LONG_MAX then
            if PC0_mask = mask then
                read_PC0_value = data_low
            else
                read_PC0_value = (data_low - H8000_0000) and PC0_mask
            end If
        else
            read_PC0_value = data_low and PC0_mask
        end If
        read_PC1_value = rightShift(data_low, 1) and &H1
        read_PC2_value = rightShift(data_low, 2) and &H1
        read_PC3_value = rightShift(data_low, 3) and &H1
        read_PC4_value = rightShift(data_low, 4) and &H1
        read_PC5_value = rightShift(data_low, 5) and &H1
        read_PC6_value = rightShift(data_low, 6) and &H1
        read_PC7_value = rightShift(data_low, 7) and &H1
        read_PC8_value = rightShift(data_low, 8) and &H1
        read_PC9_value = rightShift(data_low, 9) and &H1
        read_PC10_value = rightShift(data_low, 10) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PC0_value = &H0
        flag_PC0        = &H0
        write_PC1_value = &H0
        flag_PC1        = &H0
        write_PC2_value = &H0
        flag_PC2        = &H0
        write_PC3_value = &H0
        flag_PC3        = &H0
        write_PC4_value = &H0
        flag_PC4        = &H0
        write_PC5_value = &H0
        flag_PC5        = &H0
        write_PC6_value = &H0
        flag_PC6        = &H0
        write_PC7_value = &H0
        flag_PC7        = &H0
        write_PC8_value = &H0
        flag_PC8        = &H0
        write_PC9_value = &H0
        flag_PC9        = &H0
        write_PC10_value = &H0
        flag_PC10        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_type_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' type_control_0                             [0:0]            get_type_control_0
''                                                             set_type_control_0
''                                                             read_type_control_0
''                                                             write_type_control_0
''---------------------------------------------------------------------------------
'' type_control_1                             [1:1]            get_type_control_1
''                                                             set_type_control_1
''                                                             read_type_control_1
''                                                             write_type_control_1
''---------------------------------------------------------------------------------
'' type_control_2                             [2:2]            get_type_control_2
''                                                             set_type_control_2
''                                                             read_type_control_2
''                                                             write_type_control_2
''---------------------------------------------------------------------------------
'' type_control_3                             [3:3]            get_type_control_3
''                                                             set_type_control_3
''                                                             read_type_control_3
''                                                             write_type_control_3
''---------------------------------------------------------------------------------
'' type_control_4                             [4:4]            get_type_control_4
''                                                             set_type_control_4
''                                                             read_type_control_4
''                                                             write_type_control_4
''---------------------------------------------------------------------------------
'' type_control_5                             [5:5]            get_type_control_5
''                                                             set_type_control_5
''                                                             read_type_control_5
''                                                             write_type_control_5
''---------------------------------------------------------------------------------
'' type_control_6                             [6:6]            get_type_control_6
''                                                             set_type_control_6
''                                                             read_type_control_6
''                                                             write_type_control_6
''---------------------------------------------------------------------------------
'' type_control_7                             [7:7]            get_type_control_7
''                                                             set_type_control_7
''                                                             read_type_control_7
''                                                             write_type_control_7
''---------------------------------------------------------------------------------
'' type_control_8                             [8:8]            get_type_control_8
''                                                             set_type_control_8
''                                                             read_type_control_8
''                                                             write_type_control_8
''---------------------------------------------------------------------------------
'' type_control_9                             [9:9]            get_type_control_9
''                                                             set_type_control_9
''                                                             read_type_control_9
''                                                             write_type_control_9
''---------------------------------------------------------------------------------
'' type_control_10                            [10:10]          get_type_control_10
''                                                             set_type_control_10
''                                                             read_type_control_10
''                                                             write_type_control_10
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_type_ctrl
    Private write_type_control_0_value
    Private read_type_control_0_value
    Private flag_type_control_0
    Private write_type_control_1_value
    Private read_type_control_1_value
    Private flag_type_control_1
    Private write_type_control_2_value
    Private read_type_control_2_value
    Private flag_type_control_2
    Private write_type_control_3_value
    Private read_type_control_3_value
    Private flag_type_control_3
    Private write_type_control_4_value
    Private read_type_control_4_value
    Private flag_type_control_4
    Private write_type_control_5_value
    Private read_type_control_5_value
    Private flag_type_control_5
    Private write_type_control_6_value
    Private read_type_control_6_value
    Private flag_type_control_6
    Private write_type_control_7_value
    Private read_type_control_7_value
    Private flag_type_control_7
    Private write_type_control_8_value
    Private read_type_control_8_value
    Private flag_type_control_8
    Private write_type_control_9_value
    Private read_type_control_9_value
    Private flag_type_control_9
    Private write_type_control_10_value
    Private read_type_control_10_value
    Private flag_type_control_10

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_type_control_0
        get_type_control_0 = read_type_control_0_value
    End Property

    Property Let set_type_control_0(aData)
        write_type_control_0_value = aData
        flag_type_control_0        = &H1
    End Property

    Property Get read_type_control_0
        read
        read_type_control_0 = read_type_control_0_value
    End Property

    Property Let write_type_control_0(aData)
        set_type_control_0 = aData
        write
    End Property

    Property Get get_type_control_1
        get_type_control_1 = read_type_control_1_value
    End Property

    Property Let set_type_control_1(aData)
        write_type_control_1_value = aData
        flag_type_control_1        = &H1
    End Property

    Property Get read_type_control_1
        read
        read_type_control_1 = read_type_control_1_value
    End Property

    Property Let write_type_control_1(aData)
        set_type_control_1 = aData
        write
    End Property

    Property Get get_type_control_2
        get_type_control_2 = read_type_control_2_value
    End Property

    Property Let set_type_control_2(aData)
        write_type_control_2_value = aData
        flag_type_control_2        = &H1
    End Property

    Property Get read_type_control_2
        read
        read_type_control_2 = read_type_control_2_value
    End Property

    Property Let write_type_control_2(aData)
        set_type_control_2 = aData
        write
    End Property

    Property Get get_type_control_3
        get_type_control_3 = read_type_control_3_value
    End Property

    Property Let set_type_control_3(aData)
        write_type_control_3_value = aData
        flag_type_control_3        = &H1
    End Property

    Property Get read_type_control_3
        read
        read_type_control_3 = read_type_control_3_value
    End Property

    Property Let write_type_control_3(aData)
        set_type_control_3 = aData
        write
    End Property

    Property Get get_type_control_4
        get_type_control_4 = read_type_control_4_value
    End Property

    Property Let set_type_control_4(aData)
        write_type_control_4_value = aData
        flag_type_control_4        = &H1
    End Property

    Property Get read_type_control_4
        read
        read_type_control_4 = read_type_control_4_value
    End Property

    Property Let write_type_control_4(aData)
        set_type_control_4 = aData
        write
    End Property

    Property Get get_type_control_5
        get_type_control_5 = read_type_control_5_value
    End Property

    Property Let set_type_control_5(aData)
        write_type_control_5_value = aData
        flag_type_control_5        = &H1
    End Property

    Property Get read_type_control_5
        read
        read_type_control_5 = read_type_control_5_value
    End Property

    Property Let write_type_control_5(aData)
        set_type_control_5 = aData
        write
    End Property

    Property Get get_type_control_6
        get_type_control_6 = read_type_control_6_value
    End Property

    Property Let set_type_control_6(aData)
        write_type_control_6_value = aData
        flag_type_control_6        = &H1
    End Property

    Property Get read_type_control_6
        read
        read_type_control_6 = read_type_control_6_value
    End Property

    Property Let write_type_control_6(aData)
        set_type_control_6 = aData
        write
    End Property

    Property Get get_type_control_7
        get_type_control_7 = read_type_control_7_value
    End Property

    Property Let set_type_control_7(aData)
        write_type_control_7_value = aData
        flag_type_control_7        = &H1
    End Property

    Property Get read_type_control_7
        read
        read_type_control_7 = read_type_control_7_value
    End Property

    Property Let write_type_control_7(aData)
        set_type_control_7 = aData
        write
    End Property

    Property Get get_type_control_8
        get_type_control_8 = read_type_control_8_value
    End Property

    Property Let set_type_control_8(aData)
        write_type_control_8_value = aData
        flag_type_control_8        = &H1
    End Property

    Property Get read_type_control_8
        read
        read_type_control_8 = read_type_control_8_value
    End Property

    Property Let write_type_control_8(aData)
        set_type_control_8 = aData
        write
    End Property

    Property Get get_type_control_9
        get_type_control_9 = read_type_control_9_value
    End Property

    Property Let set_type_control_9(aData)
        write_type_control_9_value = aData
        flag_type_control_9        = &H1
    End Property

    Property Get read_type_control_9
        read
        read_type_control_9 = read_type_control_9_value
    End Property

    Property Let write_type_control_9(aData)
        set_type_control_9 = aData
        write
    End Property

    Property Get get_type_control_10
        get_type_control_10 = read_type_control_10_value
    End Property

    Property Let set_type_control_10(aData)
        write_type_control_10_value = aData
        flag_type_control_10        = &H1
    End Property

    Property Get read_type_control_10
        read
        read_type_control_10 = read_type_control_10_value
    End Property

    Property Let write_type_control_10(aData)
        set_type_control_10 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        type_control_0_mask = &H1
        if data_low > LONG_MAX then
            if type_control_0_mask = mask then
                read_type_control_0_value = data_low
            else
                read_type_control_0_value = (data_low - H8000_0000) and type_control_0_mask
            end If
        else
            read_type_control_0_value = data_low and type_control_0_mask
        end If
        read_type_control_1_value = rightShift(data_low, 1) and &H1
        read_type_control_2_value = rightShift(data_low, 2) and &H1
        read_type_control_3_value = rightShift(data_low, 3) and &H1
        read_type_control_4_value = rightShift(data_low, 4) and &H1
        read_type_control_5_value = rightShift(data_low, 5) and &H1
        read_type_control_6_value = rightShift(data_low, 6) and &H1
        read_type_control_7_value = rightShift(data_low, 7) and &H1
        read_type_control_8_value = rightShift(data_low, 8) and &H1
        read_type_control_9_value = rightShift(data_low, 9) and &H1
        read_type_control_10_value = rightShift(data_low, 10) and &H1

    End Sub

    Sub write
        If flag_type_control_0 = &H0 or flag_type_control_1 = &H0 or flag_type_control_2 = &H0 or flag_type_control_3 = &H0 or flag_type_control_4 = &H0 or flag_type_control_5 = &H0 or flag_type_control_6 = &H0 or flag_type_control_7 = &H0 or flag_type_control_8 = &H0 or flag_type_control_9 = &H0 or flag_type_control_10 = &H0 Then read
        If flag_type_control_0 = &H0 Then write_type_control_0_value = get_type_control_0
        If flag_type_control_1 = &H0 Then write_type_control_1_value = get_type_control_1
        If flag_type_control_2 = &H0 Then write_type_control_2_value = get_type_control_2
        If flag_type_control_3 = &H0 Then write_type_control_3_value = get_type_control_3
        If flag_type_control_4 = &H0 Then write_type_control_4_value = get_type_control_4
        If flag_type_control_5 = &H0 Then write_type_control_5_value = get_type_control_5
        If flag_type_control_6 = &H0 Then write_type_control_6_value = get_type_control_6
        If flag_type_control_7 = &H0 Then write_type_control_7_value = get_type_control_7
        If flag_type_control_8 = &H0 Then write_type_control_8_value = get_type_control_8
        If flag_type_control_9 = &H0 Then write_type_control_9_value = get_type_control_9
        If flag_type_control_10 = &H0 Then write_type_control_10_value = get_type_control_10

        regValue = leftShift((write_type_control_0_value and &H1), 0) + leftShift((write_type_control_1_value and &H1), 1) + leftShift((write_type_control_2_value and &H1), 2) + leftShift((write_type_control_3_value and &H1), 3) + leftShift((write_type_control_4_value and &H1), 4) + leftShift((write_type_control_5_value and &H1), 5) + leftShift((write_type_control_6_value and &H1), 6) + leftShift((write_type_control_7_value and &H1), 7) + leftShift((write_type_control_8_value and &H1), 8) + leftShift((write_type_control_9_value and &H1), 9) + leftShift((write_type_control_10_value and &H1), 10)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        type_control_0_mask = &H1
        if data_low > LONG_MAX then
            if type_control_0_mask = mask then
                read_type_control_0_value = data_low
            else
                read_type_control_0_value = (data_low - H8000_0000) and type_control_0_mask
            end If
        else
            read_type_control_0_value = data_low and type_control_0_mask
        end If
        read_type_control_1_value = rightShift(data_low, 1) and &H1
        read_type_control_2_value = rightShift(data_low, 2) and &H1
        read_type_control_3_value = rightShift(data_low, 3) and &H1
        read_type_control_4_value = rightShift(data_low, 4) and &H1
        read_type_control_5_value = rightShift(data_low, 5) and &H1
        read_type_control_6_value = rightShift(data_low, 6) and &H1
        read_type_control_7_value = rightShift(data_low, 7) and &H1
        read_type_control_8_value = rightShift(data_low, 8) and &H1
        read_type_control_9_value = rightShift(data_low, 9) and &H1
        read_type_control_10_value = rightShift(data_low, 10) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_type_control_0_value = &H0
        flag_type_control_0        = &H0
        write_type_control_1_value = &H0
        flag_type_control_1        = &H0
        write_type_control_2_value = &H0
        flag_type_control_2        = &H0
        write_type_control_3_value = &H0
        flag_type_control_3        = &H0
        write_type_control_4_value = &H0
        flag_type_control_4        = &H0
        write_type_control_5_value = &H0
        flag_type_control_5        = &H0
        write_type_control_6_value = &H0
        flag_type_control_6        = &H0
        write_type_control_7_value = &H0
        flag_type_control_7        = &H0
        write_type_control_8_value = &H0
        flag_type_control_8        = &H0
        write_type_control_9_value = &H0
        flag_type_control_9        = &H0
        write_type_control_10_value = &H0
        flag_type_control_10        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_enable_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable_control                             [10:0]           get_enable_control
''                                                             set_enable_control
''                                                             read_enable_control
''                                                             write_enable_control
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_enable_ctrl
    Private write_enable_control_value
    Private read_enable_control_value
    Private flag_enable_control

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enable_control
        get_enable_control = read_enable_control_value
    End Property

    Property Let set_enable_control(aData)
        write_enable_control_value = aData
        flag_enable_control        = &H1
    End Property

    Property Get read_enable_control
        read
        read_enable_control = read_enable_control_value
    End Property

    Property Let write_enable_control(aData)
        set_enable_control = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_control_mask = &H7ff
        if data_low > LONG_MAX then
            if enable_control_mask = mask then
                read_enable_control_value = data_low
            else
                read_enable_control_value = (data_low - H8000_0000) and enable_control_mask
            end If
        else
            read_enable_control_value = data_low and enable_control_mask
        end If

    End Sub

    Sub write
        If flag_enable_control = &H0 Then read
        If flag_enable_control = &H0 Then write_enable_control_value = get_enable_control

        regValue = leftShift((write_enable_control_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_control_mask = &H7ff
        if data_low > LONG_MAX then
            if enable_control_mask = mask then
                read_enable_control_value = data_low
            else
                read_enable_control_value = (data_low - H8000_0000) and enable_control_mask
            end If
        else
            read_enable_control_value = data_low and enable_control_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_control_value = &H0
        flag_enable_control        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_raw_stat_enable_set
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raw_status_enable_set                      [10:0]           get_raw_status_enable_set
''                                                             set_raw_status_enable_set
''                                                             read_raw_status_enable_set
''                                                             write_raw_status_enable_set
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_raw_stat_enable_set
    Private write_raw_status_enable_set_value
    Private read_raw_status_enable_set_value
    Private flag_raw_status_enable_set

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raw_status_enable_set
        get_raw_status_enable_set = read_raw_status_enable_set_value
    End Property

    Property Let set_raw_status_enable_set(aData)
        write_raw_status_enable_set_value = aData
        flag_raw_status_enable_set        = &H1
    End Property

    Property Get read_raw_status_enable_set
        read
        read_raw_status_enable_set = read_raw_status_enable_set_value
    End Property

    Property Let write_raw_status_enable_set(aData)
        set_raw_status_enable_set = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raw_status_enable_set_mask = &H7ff
        if data_low > LONG_MAX then
            if raw_status_enable_set_mask = mask then
                read_raw_status_enable_set_value = data_low
            else
                read_raw_status_enable_set_value = (data_low - H8000_0000) and raw_status_enable_set_mask
            end If
        else
            read_raw_status_enable_set_value = data_low and raw_status_enable_set_mask
        end If

    End Sub

    Sub write
        If flag_raw_status_enable_set = &H0 Then read
        If flag_raw_status_enable_set = &H0 Then write_raw_status_enable_set_value = get_raw_status_enable_set

        regValue = leftShift((write_raw_status_enable_set_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raw_status_enable_set_mask = &H7ff
        if data_low > LONG_MAX then
            if raw_status_enable_set_mask = mask then
                read_raw_status_enable_set_value = data_low
            else
                read_raw_status_enable_set_value = (data_low - H8000_0000) and raw_status_enable_set_mask
            end If
        else
            read_raw_status_enable_set_value = data_low and raw_status_enable_set_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raw_status_enable_set_value = &H0
        flag_raw_status_enable_set        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_enabled_stat_ack
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enabled_status_ack                         [10:0]           get_enabled_status_ack
''                                                             set_enabled_status_ack
''                                                             read_enabled_status_ack
''                                                             write_enabled_status_ack
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_enabled_stat_ack
    Private write_enabled_status_ack_value
    Private read_enabled_status_ack_value
    Private flag_enabled_status_ack

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enabled_status_ack
        get_enabled_status_ack = read_enabled_status_ack_value
    End Property

    Property Let set_enabled_status_ack(aData)
        write_enabled_status_ack_value = aData
        flag_enabled_status_ack        = &H1
    End Property

    Property Get read_enabled_status_ack
        read
        read_enabled_status_ack = read_enabled_status_ack_value
    End Property

    Property Let write_enabled_status_ack(aData)
        set_enabled_status_ack = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enabled_status_ack_mask = &H7ff
        if data_low > LONG_MAX then
            if enabled_status_ack_mask = mask then
                read_enabled_status_ack_value = data_low
            else
                read_enabled_status_ack_value = (data_low - H8000_0000) and enabled_status_ack_mask
            end If
        else
            read_enabled_status_ack_value = data_low and enabled_status_ack_mask
        end If

    End Sub

    Sub write
        If flag_enabled_status_ack = &H0 Then read
        If flag_enabled_status_ack = &H0 Then write_enabled_status_ack_value = get_enabled_status_ack

        regValue = leftShift((write_enabled_status_ack_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enabled_status_ack_mask = &H7ff
        if data_low > LONG_MAX then
            if enabled_status_ack_mask = mask then
                read_enabled_status_ack_value = data_low
            else
                read_enabled_status_ack_value = (data_low - H8000_0000) and enabled_status_ack_mask
            end If
        else
            read_enabled_status_ack_value = data_low and enabled_status_ack_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enabled_status_ack_value = &H0
        flag_enabled_status_ack        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_enable_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable_clr                                 [10:0]           get_enable_clr
''                                                             set_enable_clr
''                                                             read_enable_clr
''                                                             write_enable_clr
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_enable_clr
    Private write_enable_clr_value
    Private read_enable_clr_value
    Private flag_enable_clr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enable_clr
        get_enable_clr = read_enable_clr_value
    End Property

    Property Let set_enable_clr(aData)
        write_enable_clr_value = aData
        flag_enable_clr        = &H1
    End Property

    Property Get read_enable_clr
        read
        read_enable_clr = read_enable_clr_value
    End Property

    Property Let write_enable_clr(aData)
        set_enable_clr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_clr_mask = &H7ff
        if data_low > LONG_MAX then
            if enable_clr_mask = mask then
                read_enable_clr_value = data_low
            else
                read_enable_clr_value = (data_low - H8000_0000) and enable_clr_mask
            end If
        else
            read_enable_clr_value = data_low and enable_clr_mask
        end If

    End Sub

    Sub write
        If flag_enable_clr = &H0 Then read
        If flag_enable_clr = &H0 Then write_enable_clr_value = get_enable_clr

        regValue = leftShift((write_enable_clr_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_clr_mask = &H7ff
        if data_low > LONG_MAX then
            if enable_clr_mask = mask then
                read_enable_clr_value = data_low
            else
                read_enable_clr_value = (data_low - H8000_0000) and enable_clr_mask
            end If
        else
            read_enable_clr_value = data_low and enable_clr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_clr_value = &H0
        flag_enable_clr        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_options
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' nr_of_inputs                               [5:0]            get_nr_of_inputs
''                                                             set_nr_of_inputs
''                                                             read_nr_of_inputs
''                                                             write_nr_of_inputs
''---------------------------------------------------------------------------------
'' ext_reg_map                                [7:7]            get_ext_reg_map
''                                                             set_ext_reg_map
''                                                             read_ext_reg_map
''                                                             write_ext_reg_map
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_options
    Private write_nr_of_inputs_value
    Private read_nr_of_inputs_value
    Private flag_nr_of_inputs
    Private write_ext_reg_map_value
    Private read_ext_reg_map_value
    Private flag_ext_reg_map

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_nr_of_inputs
        get_nr_of_inputs = read_nr_of_inputs_value
    End Property

    Property Let set_nr_of_inputs(aData)
        write_nr_of_inputs_value = aData
        flag_nr_of_inputs        = &H1
    End Property

    Property Get read_nr_of_inputs
        read
        read_nr_of_inputs = read_nr_of_inputs_value
    End Property

    Property Let write_nr_of_inputs(aData)
        set_nr_of_inputs = aData
        write
    End Property

    Property Get get_ext_reg_map
        get_ext_reg_map = read_ext_reg_map_value
    End Property

    Property Let set_ext_reg_map(aData)
        write_ext_reg_map_value = aData
        flag_ext_reg_map        = &H1
    End Property

    Property Get read_ext_reg_map
        read
        read_ext_reg_map = read_ext_reg_map_value
    End Property

    Property Let write_ext_reg_map(aData)
        set_ext_reg_map = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        nr_of_inputs_mask = &H3f
        if data_low > LONG_MAX then
            if nr_of_inputs_mask = mask then
                read_nr_of_inputs_value = data_low
            else
                read_nr_of_inputs_value = (data_low - H8000_0000) and nr_of_inputs_mask
            end If
        else
            read_nr_of_inputs_value = data_low and nr_of_inputs_mask
        end If
        read_ext_reg_map_value = rightShift(data_low, 7) and &H1

    End Sub

    Sub write
        If flag_nr_of_inputs = &H0 or flag_ext_reg_map = &H0 Then read
        If flag_nr_of_inputs = &H0 Then write_nr_of_inputs_value = get_nr_of_inputs
        If flag_ext_reg_map = &H0 Then write_ext_reg_map_value = get_ext_reg_map

        regValue = leftShift((write_nr_of_inputs_value and &H3f), 0) + leftShift((write_ext_reg_map_value and &H1), 7)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        nr_of_inputs_mask = &H3f
        if data_low > LONG_MAX then
            if nr_of_inputs_mask = mask then
                read_nr_of_inputs_value = data_low
            else
                read_nr_of_inputs_value = (data_low - H8000_0000) and nr_of_inputs_mask
            end If
        else
            read_nr_of_inputs_value = data_low and nr_of_inputs_mask
        end If
        read_ext_reg_map_value = rightShift(data_low, 7) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_nr_of_inputs_value = &H0
        flag_nr_of_inputs        = &H0
        write_ext_reg_map_value = &H0
        flag_ext_reg_map        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_AIC_AIC_REGS_aic_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' eip_number                                 [7:0]            get_eip_number
''                                                             set_eip_number
''                                                             read_eip_number
''                                                             write_eip_number
''---------------------------------------------------------------------------------
'' eip_number_compl                           [15:8]           get_eip_number_compl
''                                                             set_eip_number_compl
''                                                             read_eip_number_compl
''                                                             write_eip_number_compl
''---------------------------------------------------------------------------------
'' patch_level                                [19:16]          get_patch_level
''                                                             set_patch_level
''                                                             read_patch_level
''                                                             write_patch_level
''---------------------------------------------------------------------------------
'' minor_version                              [23:20]          get_minor_version
''                                                             set_minor_version
''                                                             read_minor_version
''                                                             write_minor_version
''---------------------------------------------------------------------------------
'' major_version                              [27:24]          get_major_version
''                                                             set_major_version
''                                                             read_major_version
''                                                             write_major_version
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_version
    Private write_eip_number_value
    Private read_eip_number_value
    Private flag_eip_number
    Private write_eip_number_compl_value
    Private read_eip_number_compl_value
    Private flag_eip_number_compl
    Private write_patch_level_value
    Private read_patch_level_value
    Private flag_patch_level
    Private write_minor_version_value
    Private read_minor_version_value
    Private flag_minor_version
    Private write_major_version_value
    Private read_major_version_value
    Private flag_major_version

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20e1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_eip_number
        get_eip_number = read_eip_number_value
    End Property

    Property Let set_eip_number(aData)
        write_eip_number_value = aData
        flag_eip_number        = &H1
    End Property

    Property Get read_eip_number
        read
        read_eip_number = read_eip_number_value
    End Property

    Property Let write_eip_number(aData)
        set_eip_number = aData
        write
    End Property

    Property Get get_eip_number_compl
        get_eip_number_compl = read_eip_number_compl_value
    End Property

    Property Let set_eip_number_compl(aData)
        write_eip_number_compl_value = aData
        flag_eip_number_compl        = &H1
    End Property

    Property Get read_eip_number_compl
        read
        read_eip_number_compl = read_eip_number_compl_value
    End Property

    Property Let write_eip_number_compl(aData)
        set_eip_number_compl = aData
        write
    End Property

    Property Get get_patch_level
        get_patch_level = read_patch_level_value
    End Property

    Property Let set_patch_level(aData)
        write_patch_level_value = aData
        flag_patch_level        = &H1
    End Property

    Property Get read_patch_level
        read
        read_patch_level = read_patch_level_value
    End Property

    Property Let write_patch_level(aData)
        set_patch_level = aData
        write
    End Property

    Property Get get_minor_version
        get_minor_version = read_minor_version_value
    End Property

    Property Let set_minor_version(aData)
        write_minor_version_value = aData
        flag_minor_version        = &H1
    End Property

    Property Get read_minor_version
        read
        read_minor_version = read_minor_version_value
    End Property

    Property Let write_minor_version(aData)
        set_minor_version = aData
        write
    End Property

    Property Get get_major_version
        get_major_version = read_major_version_value
    End Property

    Property Let set_major_version(aData)
        write_major_version_value = aData
        flag_major_version        = &H1
    End Property

    Property Get read_major_version
        read
        read_major_version = read_major_version_value
    End Property

    Property Let write_major_version(aData)
        set_major_version = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        eip_number_mask = &Hff
        if data_low > LONG_MAX then
            if eip_number_mask = mask then
                read_eip_number_value = data_low
            else
                read_eip_number_value = (data_low - H8000_0000) and eip_number_mask
            end If
        else
            read_eip_number_value = data_low and eip_number_mask
        end If
        read_eip_number_compl_value = rightShift(data_low, 8) and &Hff
        read_patch_level_value = rightShift(data_low, 16) and &Hf
        read_minor_version_value = rightShift(data_low, 20) and &Hf
        read_major_version_value = rightShift(data_low, 24) and &Hf

    End Sub

    Sub write
        If flag_eip_number = &H0 or flag_eip_number_compl = &H0 or flag_patch_level = &H0 or flag_minor_version = &H0 or flag_major_version = &H0 Then read
        If flag_eip_number = &H0 Then write_eip_number_value = get_eip_number
        If flag_eip_number_compl = &H0 Then write_eip_number_compl_value = get_eip_number_compl
        If flag_patch_level = &H0 Then write_patch_level_value = get_patch_level
        If flag_minor_version = &H0 Then write_minor_version_value = get_minor_version
        If flag_major_version = &H0 Then write_major_version_value = get_major_version

        regValue = leftShift((write_eip_number_value and &Hff), 0) + leftShift((write_eip_number_compl_value and &Hff), 8) + leftShift((write_patch_level_value and &Hf), 16) + leftShift((write_minor_version_value and &Hf), 20) + leftShift((write_major_version_value and &Hf), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        eip_number_mask = &Hff
        if data_low > LONG_MAX then
            if eip_number_mask = mask then
                read_eip_number_value = data_low
            else
                read_eip_number_value = (data_low - H8000_0000) and eip_number_mask
            end If
        else
            read_eip_number_value = data_low and eip_number_mask
        end If
        read_eip_number_compl_value = rightShift(data_low, 8) and &Hff
        read_patch_level_value = rightShift(data_low, 16) and &Hf
        read_minor_version_value = rightShift(data_low, 20) and &Hf
        read_major_version_value = rightShift(data_low, 24) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_eip_number_value = &H0
        flag_eip_number        = &H0
        write_eip_number_compl_value = &H0
        flag_eip_number_compl        = &H0
        write_patch_level_value = &H0
        flag_patch_level        = &H0
        write_minor_version_value = &H0
        flag_minor_version        = &H0
        write_major_version_value = &H0
        flag_major_version        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_AIC_AIC_REGS_INSTANCE

    Public aic_pol_ctrl
    Public aic_type_ctrl
    Public aic_enable_ctrl
    Public aic_raw_stat_enable_set
    Public aic_enabled_stat_ack
    Public aic_enable_clr
    Public aic_options
    Public aic_version


    Public default function Init(aBaseAddr)
        Set aic_pol_ctrl = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_pol_ctrl)(aBaseAddr, 32)
        Set aic_type_ctrl = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_type_ctrl)(aBaseAddr, 32)
        Set aic_enable_ctrl = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_enable_ctrl)(aBaseAddr, 32)
        Set aic_raw_stat_enable_set = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_raw_stat_enable_set)(aBaseAddr, 32)
        Set aic_enabled_stat_ack = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_enabled_stat_ack)(aBaseAddr, 32)
        Set aic_enable_clr = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_enable_clr)(aBaseAddr, 32)
        Set aic_options = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_options)(aBaseAddr, 32)
        Set aic_version = (New REGISTER_EIP165S_EIP165_AIC_AIC_REGS_aic_version)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_AIC_AIC_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_AIC_AIC_REGS.Add ((New EIP165S_EIP165_AIC_AIC_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_AIC_AIC_REGS.Add ((New EIP165S_EIP165_AIC_AIC_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_AIC_AIC_REGS.Add ((New EIP165S_EIP165_AIC_AIC_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_AIC_AIC_REGS.Add ((New EIP165S_EIP165_AIC_AIC_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_AIC_AIC_REGS.Add ((New EIP165S_EIP165_AIC_AIC_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_AIC_AIC_REGS.Add ((New EIP165S_EIP165_AIC_AIC_REGS_INSTANCE)(&H4d510000))


