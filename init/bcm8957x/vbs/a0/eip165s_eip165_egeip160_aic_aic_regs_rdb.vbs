

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_pol_ctrl
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
'' PC11                                       [11:11]          get_PC11
''                                                             set_PC11
''                                                             read_PC11
''                                                             write_PC11
''---------------------------------------------------------------------------------
'' PC12                                       [12:12]          get_PC12
''                                                             set_PC12
''                                                             read_PC12
''                                                             write_PC12
''---------------------------------------------------------------------------------
'' PC13                                       [13:13]          get_PC13
''                                                             set_PC13
''                                                             read_PC13
''                                                             write_PC13
''---------------------------------------------------------------------------------
'' PC14                                       [14:14]          get_PC14
''                                                             set_PC14
''                                                             read_PC14
''                                                             write_PC14
''---------------------------------------------------------------------------------
'' PC15                                       [15:15]          get_PC15
''                                                             set_PC15
''                                                             read_PC15
''                                                             write_PC15
''---------------------------------------------------------------------------------
'' PC16                                       [16:16]          get_PC16
''                                                             set_PC16
''                                                             read_PC16
''                                                             write_PC16
''---------------------------------------------------------------------------------
'' PC17                                       [17:17]          get_PC17
''                                                             set_PC17
''                                                             read_PC17
''                                                             write_PC17
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_pol_ctrl
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
    Private write_PC11_value
    Private read_PC11_value
    Private flag_PC11
    Private write_PC12_value
    Private read_PC12_value
    Private flag_PC12
    Private write_PC13_value
    Private read_PC13_value
    Private flag_PC13
    Private write_PC14_value
    Private read_PC14_value
    Private flag_PC14
    Private write_PC15_value
    Private read_PC15_value
    Private flag_PC15
    Private write_PC16_value
    Private read_PC16_value
    Private flag_PC16
    Private write_PC17_value
    Private read_PC17_value
    Private flag_PC17

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f800
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

    Property Get get_PC11
        get_PC11 = read_PC11_value
    End Property

    Property Let set_PC11(aData)
        write_PC11_value = aData
        flag_PC11        = &H1
    End Property

    Property Get read_PC11
        read
        read_PC11 = read_PC11_value
    End Property

    Property Let write_PC11(aData)
        set_PC11 = aData
        write
    End Property

    Property Get get_PC12
        get_PC12 = read_PC12_value
    End Property

    Property Let set_PC12(aData)
        write_PC12_value = aData
        flag_PC12        = &H1
    End Property

    Property Get read_PC12
        read
        read_PC12 = read_PC12_value
    End Property

    Property Let write_PC12(aData)
        set_PC12 = aData
        write
    End Property

    Property Get get_PC13
        get_PC13 = read_PC13_value
    End Property

    Property Let set_PC13(aData)
        write_PC13_value = aData
        flag_PC13        = &H1
    End Property

    Property Get read_PC13
        read
        read_PC13 = read_PC13_value
    End Property

    Property Let write_PC13(aData)
        set_PC13 = aData
        write
    End Property

    Property Get get_PC14
        get_PC14 = read_PC14_value
    End Property

    Property Let set_PC14(aData)
        write_PC14_value = aData
        flag_PC14        = &H1
    End Property

    Property Get read_PC14
        read
        read_PC14 = read_PC14_value
    End Property

    Property Let write_PC14(aData)
        set_PC14 = aData
        write
    End Property

    Property Get get_PC15
        get_PC15 = read_PC15_value
    End Property

    Property Let set_PC15(aData)
        write_PC15_value = aData
        flag_PC15        = &H1
    End Property

    Property Get read_PC15
        read
        read_PC15 = read_PC15_value
    End Property

    Property Let write_PC15(aData)
        set_PC15 = aData
        write
    End Property

    Property Get get_PC16
        get_PC16 = read_PC16_value
    End Property

    Property Let set_PC16(aData)
        write_PC16_value = aData
        flag_PC16        = &H1
    End Property

    Property Get read_PC16
        read
        read_PC16 = read_PC16_value
    End Property

    Property Let write_PC16(aData)
        set_PC16 = aData
        write
    End Property

    Property Get get_PC17
        get_PC17 = read_PC17_value
    End Property

    Property Let set_PC17(aData)
        write_PC17_value = aData
        flag_PC17        = &H1
    End Property

    Property Get read_PC17
        read
        read_PC17 = read_PC17_value
    End Property

    Property Let write_PC17(aData)
        set_PC17 = aData
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
        read_PC11_value = rightShift(data_low, 11) and &H1
        read_PC12_value = rightShift(data_low, 12) and &H1
        read_PC13_value = rightShift(data_low, 13) and &H1
        read_PC14_value = rightShift(data_low, 14) and &H1
        read_PC15_value = rightShift(data_low, 15) and &H1
        read_PC16_value = rightShift(data_low, 16) and &H1
        read_PC17_value = rightShift(data_low, 17) and &H1

    End Sub

    Sub write
        If flag_PC0 = &H0 or flag_PC1 = &H0 or flag_PC2 = &H0 or flag_PC3 = &H0 or flag_PC4 = &H0 or flag_PC5 = &H0 or flag_PC6 = &H0 or flag_PC7 = &H0 or flag_PC8 = &H0 or flag_PC9 = &H0 or flag_PC10 = &H0 or flag_PC11 = &H0 or flag_PC12 = &H0 or flag_PC13 = &H0 or flag_PC14 = &H0 or flag_PC15 = &H0 or flag_PC16 = &H0 or flag_PC17 = &H0 Then read
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
        If flag_PC11 = &H0 Then write_PC11_value = get_PC11
        If flag_PC12 = &H0 Then write_PC12_value = get_PC12
        If flag_PC13 = &H0 Then write_PC13_value = get_PC13
        If flag_PC14 = &H0 Then write_PC14_value = get_PC14
        If flag_PC15 = &H0 Then write_PC15_value = get_PC15
        If flag_PC16 = &H0 Then write_PC16_value = get_PC16
        If flag_PC17 = &H0 Then write_PC17_value = get_PC17

        regValue = leftShift((write_PC0_value and &H1), 0) + leftShift((write_PC1_value and &H1), 1) + leftShift((write_PC2_value and &H1), 2) + leftShift((write_PC3_value and &H1), 3) + leftShift((write_PC4_value and &H1), 4) + leftShift((write_PC5_value and &H1), 5) + leftShift((write_PC6_value and &H1), 6) + leftShift((write_PC7_value and &H1), 7) + leftShift((write_PC8_value and &H1), 8) + leftShift((write_PC9_value and &H1), 9) + leftShift((write_PC10_value and &H1), 10) + leftShift((write_PC11_value and &H1), 11) + leftShift((write_PC12_value and &H1), 12) + leftShift((write_PC13_value and &H1), 13) + leftShift((write_PC14_value and &H1), 14) + leftShift((write_PC15_value and &H1), 15) + leftShift((write_PC16_value and &H1), 16) + leftShift((write_PC17_value and &H1), 17)
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
        read_PC11_value = rightShift(data_low, 11) and &H1
        read_PC12_value = rightShift(data_low, 12) and &H1
        read_PC13_value = rightShift(data_low, 13) and &H1
        read_PC14_value = rightShift(data_low, 14) and &H1
        read_PC15_value = rightShift(data_low, 15) and &H1
        read_PC16_value = rightShift(data_low, 16) and &H1
        read_PC17_value = rightShift(data_low, 17) and &H1

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
        write_PC11_value = &H0
        flag_PC11        = &H0
        write_PC12_value = &H0
        flag_PC12        = &H0
        write_PC13_value = &H0
        flag_PC13        = &H0
        write_PC14_value = &H0
        flag_PC14        = &H0
        write_PC15_value = &H0
        flag_PC15        = &H0
        write_PC16_value = &H0
        flag_PC16        = &H0
        write_PC17_value = &H0
        flag_PC17        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_type_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TYPE_CONT_0                                [0:0]            get_TYPE_CONT_0
''                                                             set_TYPE_CONT_0
''                                                             read_TYPE_CONT_0
''                                                             write_TYPE_CONT_0
''---------------------------------------------------------------------------------
'' TYPE_CONT_1                                [1:1]            get_TYPE_CONT_1
''                                                             set_TYPE_CONT_1
''                                                             read_TYPE_CONT_1
''                                                             write_TYPE_CONT_1
''---------------------------------------------------------------------------------
'' TYPE_CONT_2                                [2:2]            get_TYPE_CONT_2
''                                                             set_TYPE_CONT_2
''                                                             read_TYPE_CONT_2
''                                                             write_TYPE_CONT_2
''---------------------------------------------------------------------------------
'' TYPE_CONT_3                                [3:3]            get_TYPE_CONT_3
''                                                             set_TYPE_CONT_3
''                                                             read_TYPE_CONT_3
''                                                             write_TYPE_CONT_3
''---------------------------------------------------------------------------------
'' TYPE_CONT_4                                [4:4]            get_TYPE_CONT_4
''                                                             set_TYPE_CONT_4
''                                                             read_TYPE_CONT_4
''                                                             write_TYPE_CONT_4
''---------------------------------------------------------------------------------
'' TYPE_CONT_5                                [5:5]            get_TYPE_CONT_5
''                                                             set_TYPE_CONT_5
''                                                             read_TYPE_CONT_5
''                                                             write_TYPE_CONT_5
''---------------------------------------------------------------------------------
'' TYPE_CONT_6                                [6:6]            get_TYPE_CONT_6
''                                                             set_TYPE_CONT_6
''                                                             read_TYPE_CONT_6
''                                                             write_TYPE_CONT_6
''---------------------------------------------------------------------------------
'' TYPE_CONT_7                                [7:7]            get_TYPE_CONT_7
''                                                             set_TYPE_CONT_7
''                                                             read_TYPE_CONT_7
''                                                             write_TYPE_CONT_7
''---------------------------------------------------------------------------------
'' TYPE_CONT_8                                [8:8]            get_TYPE_CONT_8
''                                                             set_TYPE_CONT_8
''                                                             read_TYPE_CONT_8
''                                                             write_TYPE_CONT_8
''---------------------------------------------------------------------------------
'' TYPE_CONT_9                                [9:9]            get_TYPE_CONT_9
''                                                             set_TYPE_CONT_9
''                                                             read_TYPE_CONT_9
''                                                             write_TYPE_CONT_9
''---------------------------------------------------------------------------------
'' TYPE_CONT_10                               [10:10]          get_TYPE_CONT_10
''                                                             set_TYPE_CONT_10
''                                                             read_TYPE_CONT_10
''                                                             write_TYPE_CONT_10
''---------------------------------------------------------------------------------
'' TYPE_CONT_11                               [11:11]          get_TYPE_CONT_11
''                                                             set_TYPE_CONT_11
''                                                             read_TYPE_CONT_11
''                                                             write_TYPE_CONT_11
''---------------------------------------------------------------------------------
'' TYPE_CONT_12                               [12:12]          get_TYPE_CONT_12
''                                                             set_TYPE_CONT_12
''                                                             read_TYPE_CONT_12
''                                                             write_TYPE_CONT_12
''---------------------------------------------------------------------------------
'' TYPE_CONT_13                               [13:13]          get_TYPE_CONT_13
''                                                             set_TYPE_CONT_13
''                                                             read_TYPE_CONT_13
''                                                             write_TYPE_CONT_13
''---------------------------------------------------------------------------------
'' TYPE_CONT_14                               [14:14]          get_TYPE_CONT_14
''                                                             set_TYPE_CONT_14
''                                                             read_TYPE_CONT_14
''                                                             write_TYPE_CONT_14
''---------------------------------------------------------------------------------
'' TYPE_CONT_15                               [15:15]          get_TYPE_CONT_15
''                                                             set_TYPE_CONT_15
''                                                             read_TYPE_CONT_15
''                                                             write_TYPE_CONT_15
''---------------------------------------------------------------------------------
'' TYPE_CONT_16                               [16:16]          get_TYPE_CONT_16
''                                                             set_TYPE_CONT_16
''                                                             read_TYPE_CONT_16
''                                                             write_TYPE_CONT_16
''---------------------------------------------------------------------------------
'' TYPE_CONT_17                               [17:17]          get_TYPE_CONT_17
''                                                             set_TYPE_CONT_17
''                                                             read_TYPE_CONT_17
''                                                             write_TYPE_CONT_17
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_type_ctrl
    Private write_TYPE_CONT_0_value
    Private read_TYPE_CONT_0_value
    Private flag_TYPE_CONT_0
    Private write_TYPE_CONT_1_value
    Private read_TYPE_CONT_1_value
    Private flag_TYPE_CONT_1
    Private write_TYPE_CONT_2_value
    Private read_TYPE_CONT_2_value
    Private flag_TYPE_CONT_2
    Private write_TYPE_CONT_3_value
    Private read_TYPE_CONT_3_value
    Private flag_TYPE_CONT_3
    Private write_TYPE_CONT_4_value
    Private read_TYPE_CONT_4_value
    Private flag_TYPE_CONT_4
    Private write_TYPE_CONT_5_value
    Private read_TYPE_CONT_5_value
    Private flag_TYPE_CONT_5
    Private write_TYPE_CONT_6_value
    Private read_TYPE_CONT_6_value
    Private flag_TYPE_CONT_6
    Private write_TYPE_CONT_7_value
    Private read_TYPE_CONT_7_value
    Private flag_TYPE_CONT_7
    Private write_TYPE_CONT_8_value
    Private read_TYPE_CONT_8_value
    Private flag_TYPE_CONT_8
    Private write_TYPE_CONT_9_value
    Private read_TYPE_CONT_9_value
    Private flag_TYPE_CONT_9
    Private write_TYPE_CONT_10_value
    Private read_TYPE_CONT_10_value
    Private flag_TYPE_CONT_10
    Private write_TYPE_CONT_11_value
    Private read_TYPE_CONT_11_value
    Private flag_TYPE_CONT_11
    Private write_TYPE_CONT_12_value
    Private read_TYPE_CONT_12_value
    Private flag_TYPE_CONT_12
    Private write_TYPE_CONT_13_value
    Private read_TYPE_CONT_13_value
    Private flag_TYPE_CONT_13
    Private write_TYPE_CONT_14_value
    Private read_TYPE_CONT_14_value
    Private flag_TYPE_CONT_14
    Private write_TYPE_CONT_15_value
    Private read_TYPE_CONT_15_value
    Private flag_TYPE_CONT_15
    Private write_TYPE_CONT_16_value
    Private read_TYPE_CONT_16_value
    Private flag_TYPE_CONT_16
    Private write_TYPE_CONT_17_value
    Private read_TYPE_CONT_17_value
    Private flag_TYPE_CONT_17

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f804
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TYPE_CONT_0
        get_TYPE_CONT_0 = read_TYPE_CONT_0_value
    End Property

    Property Let set_TYPE_CONT_0(aData)
        write_TYPE_CONT_0_value = aData
        flag_TYPE_CONT_0        = &H1
    End Property

    Property Get read_TYPE_CONT_0
        read
        read_TYPE_CONT_0 = read_TYPE_CONT_0_value
    End Property

    Property Let write_TYPE_CONT_0(aData)
        set_TYPE_CONT_0 = aData
        write
    End Property

    Property Get get_TYPE_CONT_1
        get_TYPE_CONT_1 = read_TYPE_CONT_1_value
    End Property

    Property Let set_TYPE_CONT_1(aData)
        write_TYPE_CONT_1_value = aData
        flag_TYPE_CONT_1        = &H1
    End Property

    Property Get read_TYPE_CONT_1
        read
        read_TYPE_CONT_1 = read_TYPE_CONT_1_value
    End Property

    Property Let write_TYPE_CONT_1(aData)
        set_TYPE_CONT_1 = aData
        write
    End Property

    Property Get get_TYPE_CONT_2
        get_TYPE_CONT_2 = read_TYPE_CONT_2_value
    End Property

    Property Let set_TYPE_CONT_2(aData)
        write_TYPE_CONT_2_value = aData
        flag_TYPE_CONT_2        = &H1
    End Property

    Property Get read_TYPE_CONT_2
        read
        read_TYPE_CONT_2 = read_TYPE_CONT_2_value
    End Property

    Property Let write_TYPE_CONT_2(aData)
        set_TYPE_CONT_2 = aData
        write
    End Property

    Property Get get_TYPE_CONT_3
        get_TYPE_CONT_3 = read_TYPE_CONT_3_value
    End Property

    Property Let set_TYPE_CONT_3(aData)
        write_TYPE_CONT_3_value = aData
        flag_TYPE_CONT_3        = &H1
    End Property

    Property Get read_TYPE_CONT_3
        read
        read_TYPE_CONT_3 = read_TYPE_CONT_3_value
    End Property

    Property Let write_TYPE_CONT_3(aData)
        set_TYPE_CONT_3 = aData
        write
    End Property

    Property Get get_TYPE_CONT_4
        get_TYPE_CONT_4 = read_TYPE_CONT_4_value
    End Property

    Property Let set_TYPE_CONT_4(aData)
        write_TYPE_CONT_4_value = aData
        flag_TYPE_CONT_4        = &H1
    End Property

    Property Get read_TYPE_CONT_4
        read
        read_TYPE_CONT_4 = read_TYPE_CONT_4_value
    End Property

    Property Let write_TYPE_CONT_4(aData)
        set_TYPE_CONT_4 = aData
        write
    End Property

    Property Get get_TYPE_CONT_5
        get_TYPE_CONT_5 = read_TYPE_CONT_5_value
    End Property

    Property Let set_TYPE_CONT_5(aData)
        write_TYPE_CONT_5_value = aData
        flag_TYPE_CONT_5        = &H1
    End Property

    Property Get read_TYPE_CONT_5
        read
        read_TYPE_CONT_5 = read_TYPE_CONT_5_value
    End Property

    Property Let write_TYPE_CONT_5(aData)
        set_TYPE_CONT_5 = aData
        write
    End Property

    Property Get get_TYPE_CONT_6
        get_TYPE_CONT_6 = read_TYPE_CONT_6_value
    End Property

    Property Let set_TYPE_CONT_6(aData)
        write_TYPE_CONT_6_value = aData
        flag_TYPE_CONT_6        = &H1
    End Property

    Property Get read_TYPE_CONT_6
        read
        read_TYPE_CONT_6 = read_TYPE_CONT_6_value
    End Property

    Property Let write_TYPE_CONT_6(aData)
        set_TYPE_CONT_6 = aData
        write
    End Property

    Property Get get_TYPE_CONT_7
        get_TYPE_CONT_7 = read_TYPE_CONT_7_value
    End Property

    Property Let set_TYPE_CONT_7(aData)
        write_TYPE_CONT_7_value = aData
        flag_TYPE_CONT_7        = &H1
    End Property

    Property Get read_TYPE_CONT_7
        read
        read_TYPE_CONT_7 = read_TYPE_CONT_7_value
    End Property

    Property Let write_TYPE_CONT_7(aData)
        set_TYPE_CONT_7 = aData
        write
    End Property

    Property Get get_TYPE_CONT_8
        get_TYPE_CONT_8 = read_TYPE_CONT_8_value
    End Property

    Property Let set_TYPE_CONT_8(aData)
        write_TYPE_CONT_8_value = aData
        flag_TYPE_CONT_8        = &H1
    End Property

    Property Get read_TYPE_CONT_8
        read
        read_TYPE_CONT_8 = read_TYPE_CONT_8_value
    End Property

    Property Let write_TYPE_CONT_8(aData)
        set_TYPE_CONT_8 = aData
        write
    End Property

    Property Get get_TYPE_CONT_9
        get_TYPE_CONT_9 = read_TYPE_CONT_9_value
    End Property

    Property Let set_TYPE_CONT_9(aData)
        write_TYPE_CONT_9_value = aData
        flag_TYPE_CONT_9        = &H1
    End Property

    Property Get read_TYPE_CONT_9
        read
        read_TYPE_CONT_9 = read_TYPE_CONT_9_value
    End Property

    Property Let write_TYPE_CONT_9(aData)
        set_TYPE_CONT_9 = aData
        write
    End Property

    Property Get get_TYPE_CONT_10
        get_TYPE_CONT_10 = read_TYPE_CONT_10_value
    End Property

    Property Let set_TYPE_CONT_10(aData)
        write_TYPE_CONT_10_value = aData
        flag_TYPE_CONT_10        = &H1
    End Property

    Property Get read_TYPE_CONT_10
        read
        read_TYPE_CONT_10 = read_TYPE_CONT_10_value
    End Property

    Property Let write_TYPE_CONT_10(aData)
        set_TYPE_CONT_10 = aData
        write
    End Property

    Property Get get_TYPE_CONT_11
        get_TYPE_CONT_11 = read_TYPE_CONT_11_value
    End Property

    Property Let set_TYPE_CONT_11(aData)
        write_TYPE_CONT_11_value = aData
        flag_TYPE_CONT_11        = &H1
    End Property

    Property Get read_TYPE_CONT_11
        read
        read_TYPE_CONT_11 = read_TYPE_CONT_11_value
    End Property

    Property Let write_TYPE_CONT_11(aData)
        set_TYPE_CONT_11 = aData
        write
    End Property

    Property Get get_TYPE_CONT_12
        get_TYPE_CONT_12 = read_TYPE_CONT_12_value
    End Property

    Property Let set_TYPE_CONT_12(aData)
        write_TYPE_CONT_12_value = aData
        flag_TYPE_CONT_12        = &H1
    End Property

    Property Get read_TYPE_CONT_12
        read
        read_TYPE_CONT_12 = read_TYPE_CONT_12_value
    End Property

    Property Let write_TYPE_CONT_12(aData)
        set_TYPE_CONT_12 = aData
        write
    End Property

    Property Get get_TYPE_CONT_13
        get_TYPE_CONT_13 = read_TYPE_CONT_13_value
    End Property

    Property Let set_TYPE_CONT_13(aData)
        write_TYPE_CONT_13_value = aData
        flag_TYPE_CONT_13        = &H1
    End Property

    Property Get read_TYPE_CONT_13
        read
        read_TYPE_CONT_13 = read_TYPE_CONT_13_value
    End Property

    Property Let write_TYPE_CONT_13(aData)
        set_TYPE_CONT_13 = aData
        write
    End Property

    Property Get get_TYPE_CONT_14
        get_TYPE_CONT_14 = read_TYPE_CONT_14_value
    End Property

    Property Let set_TYPE_CONT_14(aData)
        write_TYPE_CONT_14_value = aData
        flag_TYPE_CONT_14        = &H1
    End Property

    Property Get read_TYPE_CONT_14
        read
        read_TYPE_CONT_14 = read_TYPE_CONT_14_value
    End Property

    Property Let write_TYPE_CONT_14(aData)
        set_TYPE_CONT_14 = aData
        write
    End Property

    Property Get get_TYPE_CONT_15
        get_TYPE_CONT_15 = read_TYPE_CONT_15_value
    End Property

    Property Let set_TYPE_CONT_15(aData)
        write_TYPE_CONT_15_value = aData
        flag_TYPE_CONT_15        = &H1
    End Property

    Property Get read_TYPE_CONT_15
        read
        read_TYPE_CONT_15 = read_TYPE_CONT_15_value
    End Property

    Property Let write_TYPE_CONT_15(aData)
        set_TYPE_CONT_15 = aData
        write
    End Property

    Property Get get_TYPE_CONT_16
        get_TYPE_CONT_16 = read_TYPE_CONT_16_value
    End Property

    Property Let set_TYPE_CONT_16(aData)
        write_TYPE_CONT_16_value = aData
        flag_TYPE_CONT_16        = &H1
    End Property

    Property Get read_TYPE_CONT_16
        read
        read_TYPE_CONT_16 = read_TYPE_CONT_16_value
    End Property

    Property Let write_TYPE_CONT_16(aData)
        set_TYPE_CONT_16 = aData
        write
    End Property

    Property Get get_TYPE_CONT_17
        get_TYPE_CONT_17 = read_TYPE_CONT_17_value
    End Property

    Property Let set_TYPE_CONT_17(aData)
        write_TYPE_CONT_17_value = aData
        flag_TYPE_CONT_17        = &H1
    End Property

    Property Get read_TYPE_CONT_17
        read
        read_TYPE_CONT_17 = read_TYPE_CONT_17_value
    End Property

    Property Let write_TYPE_CONT_17(aData)
        set_TYPE_CONT_17 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TYPE_CONT_0_mask = &H1
        if data_low > LONG_MAX then
            if TYPE_CONT_0_mask = mask then
                read_TYPE_CONT_0_value = data_low
            else
                read_TYPE_CONT_0_value = (data_low - H8000_0000) and TYPE_CONT_0_mask
            end If
        else
            read_TYPE_CONT_0_value = data_low and TYPE_CONT_0_mask
        end If
        read_TYPE_CONT_1_value = rightShift(data_low, 1) and &H1
        read_TYPE_CONT_2_value = rightShift(data_low, 2) and &H1
        read_TYPE_CONT_3_value = rightShift(data_low, 3) and &H1
        read_TYPE_CONT_4_value = rightShift(data_low, 4) and &H1
        read_TYPE_CONT_5_value = rightShift(data_low, 5) and &H1
        read_TYPE_CONT_6_value = rightShift(data_low, 6) and &H1
        read_TYPE_CONT_7_value = rightShift(data_low, 7) and &H1
        read_TYPE_CONT_8_value = rightShift(data_low, 8) and &H1
        read_TYPE_CONT_9_value = rightShift(data_low, 9) and &H1
        read_TYPE_CONT_10_value = rightShift(data_low, 10) and &H1
        read_TYPE_CONT_11_value = rightShift(data_low, 11) and &H1
        read_TYPE_CONT_12_value = rightShift(data_low, 12) and &H1
        read_TYPE_CONT_13_value = rightShift(data_low, 13) and &H1
        read_TYPE_CONT_14_value = rightShift(data_low, 14) and &H1
        read_TYPE_CONT_15_value = rightShift(data_low, 15) and &H1
        read_TYPE_CONT_16_value = rightShift(data_low, 16) and &H1
        read_TYPE_CONT_17_value = rightShift(data_low, 17) and &H1

    End Sub

    Sub write
        If flag_TYPE_CONT_0 = &H0 or flag_TYPE_CONT_1 = &H0 or flag_TYPE_CONT_2 = &H0 or flag_TYPE_CONT_3 = &H0 or flag_TYPE_CONT_4 = &H0 or flag_TYPE_CONT_5 = &H0 or flag_TYPE_CONT_6 = &H0 or flag_TYPE_CONT_7 = &H0 or flag_TYPE_CONT_8 = &H0 or flag_TYPE_CONT_9 = &H0 or flag_TYPE_CONT_10 = &H0 or flag_TYPE_CONT_11 = &H0 or flag_TYPE_CONT_12 = &H0 or flag_TYPE_CONT_13 = &H0 or flag_TYPE_CONT_14 = &H0 or flag_TYPE_CONT_15 = &H0 or flag_TYPE_CONT_16 = &H0 or flag_TYPE_CONT_17 = &H0 Then read
        If flag_TYPE_CONT_0 = &H0 Then write_TYPE_CONT_0_value = get_TYPE_CONT_0
        If flag_TYPE_CONT_1 = &H0 Then write_TYPE_CONT_1_value = get_TYPE_CONT_1
        If flag_TYPE_CONT_2 = &H0 Then write_TYPE_CONT_2_value = get_TYPE_CONT_2
        If flag_TYPE_CONT_3 = &H0 Then write_TYPE_CONT_3_value = get_TYPE_CONT_3
        If flag_TYPE_CONT_4 = &H0 Then write_TYPE_CONT_4_value = get_TYPE_CONT_4
        If flag_TYPE_CONT_5 = &H0 Then write_TYPE_CONT_5_value = get_TYPE_CONT_5
        If flag_TYPE_CONT_6 = &H0 Then write_TYPE_CONT_6_value = get_TYPE_CONT_6
        If flag_TYPE_CONT_7 = &H0 Then write_TYPE_CONT_7_value = get_TYPE_CONT_7
        If flag_TYPE_CONT_8 = &H0 Then write_TYPE_CONT_8_value = get_TYPE_CONT_8
        If flag_TYPE_CONT_9 = &H0 Then write_TYPE_CONT_9_value = get_TYPE_CONT_9
        If flag_TYPE_CONT_10 = &H0 Then write_TYPE_CONT_10_value = get_TYPE_CONT_10
        If flag_TYPE_CONT_11 = &H0 Then write_TYPE_CONT_11_value = get_TYPE_CONT_11
        If flag_TYPE_CONT_12 = &H0 Then write_TYPE_CONT_12_value = get_TYPE_CONT_12
        If flag_TYPE_CONT_13 = &H0 Then write_TYPE_CONT_13_value = get_TYPE_CONT_13
        If flag_TYPE_CONT_14 = &H0 Then write_TYPE_CONT_14_value = get_TYPE_CONT_14
        If flag_TYPE_CONT_15 = &H0 Then write_TYPE_CONT_15_value = get_TYPE_CONT_15
        If flag_TYPE_CONT_16 = &H0 Then write_TYPE_CONT_16_value = get_TYPE_CONT_16
        If flag_TYPE_CONT_17 = &H0 Then write_TYPE_CONT_17_value = get_TYPE_CONT_17

        regValue = leftShift((write_TYPE_CONT_0_value and &H1), 0) + leftShift((write_TYPE_CONT_1_value and &H1), 1) + leftShift((write_TYPE_CONT_2_value and &H1), 2) + leftShift((write_TYPE_CONT_3_value and &H1), 3) + leftShift((write_TYPE_CONT_4_value and &H1), 4) + leftShift((write_TYPE_CONT_5_value and &H1), 5) + leftShift((write_TYPE_CONT_6_value and &H1), 6) + leftShift((write_TYPE_CONT_7_value and &H1), 7) + leftShift((write_TYPE_CONT_8_value and &H1), 8) + leftShift((write_TYPE_CONT_9_value and &H1), 9) + leftShift((write_TYPE_CONT_10_value and &H1), 10) + leftShift((write_TYPE_CONT_11_value and &H1), 11) + leftShift((write_TYPE_CONT_12_value and &H1), 12) + leftShift((write_TYPE_CONT_13_value and &H1), 13) + leftShift((write_TYPE_CONT_14_value and &H1), 14) + leftShift((write_TYPE_CONT_15_value and &H1), 15) + leftShift((write_TYPE_CONT_16_value and &H1), 16) + leftShift((write_TYPE_CONT_17_value and &H1), 17)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TYPE_CONT_0_mask = &H1
        if data_low > LONG_MAX then
            if TYPE_CONT_0_mask = mask then
                read_TYPE_CONT_0_value = data_low
            else
                read_TYPE_CONT_0_value = (data_low - H8000_0000) and TYPE_CONT_0_mask
            end If
        else
            read_TYPE_CONT_0_value = data_low and TYPE_CONT_0_mask
        end If
        read_TYPE_CONT_1_value = rightShift(data_low, 1) and &H1
        read_TYPE_CONT_2_value = rightShift(data_low, 2) and &H1
        read_TYPE_CONT_3_value = rightShift(data_low, 3) and &H1
        read_TYPE_CONT_4_value = rightShift(data_low, 4) and &H1
        read_TYPE_CONT_5_value = rightShift(data_low, 5) and &H1
        read_TYPE_CONT_6_value = rightShift(data_low, 6) and &H1
        read_TYPE_CONT_7_value = rightShift(data_low, 7) and &H1
        read_TYPE_CONT_8_value = rightShift(data_low, 8) and &H1
        read_TYPE_CONT_9_value = rightShift(data_low, 9) and &H1
        read_TYPE_CONT_10_value = rightShift(data_low, 10) and &H1
        read_TYPE_CONT_11_value = rightShift(data_low, 11) and &H1
        read_TYPE_CONT_12_value = rightShift(data_low, 12) and &H1
        read_TYPE_CONT_13_value = rightShift(data_low, 13) and &H1
        read_TYPE_CONT_14_value = rightShift(data_low, 14) and &H1
        read_TYPE_CONT_15_value = rightShift(data_low, 15) and &H1
        read_TYPE_CONT_16_value = rightShift(data_low, 16) and &H1
        read_TYPE_CONT_17_value = rightShift(data_low, 17) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TYPE_CONT_0_value = &H0
        flag_TYPE_CONT_0        = &H0
        write_TYPE_CONT_1_value = &H0
        flag_TYPE_CONT_1        = &H0
        write_TYPE_CONT_2_value = &H0
        flag_TYPE_CONT_2        = &H0
        write_TYPE_CONT_3_value = &H0
        flag_TYPE_CONT_3        = &H0
        write_TYPE_CONT_4_value = &H0
        flag_TYPE_CONT_4        = &H0
        write_TYPE_CONT_5_value = &H0
        flag_TYPE_CONT_5        = &H0
        write_TYPE_CONT_6_value = &H0
        flag_TYPE_CONT_6        = &H0
        write_TYPE_CONT_7_value = &H0
        flag_TYPE_CONT_7        = &H0
        write_TYPE_CONT_8_value = &H0
        flag_TYPE_CONT_8        = &H0
        write_TYPE_CONT_9_value = &H0
        flag_TYPE_CONT_9        = &H0
        write_TYPE_CONT_10_value = &H0
        flag_TYPE_CONT_10        = &H0
        write_TYPE_CONT_11_value = &H0
        flag_TYPE_CONT_11        = &H0
        write_TYPE_CONT_12_value = &H0
        flag_TYPE_CONT_12        = &H0
        write_TYPE_CONT_13_value = &H0
        flag_TYPE_CONT_13        = &H0
        write_TYPE_CONT_14_value = &H0
        flag_TYPE_CONT_14        = &H0
        write_TYPE_CONT_15_value = &H0
        flag_TYPE_CONT_15        = &H0
        write_TYPE_CONT_16_value = &H0
        flag_TYPE_CONT_16        = &H0
        write_TYPE_CONT_17_value = &H0
        flag_TYPE_CONT_17        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enable_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENAB_CONT                                  [17:0]           get_ENAB_CONT
''                                                             set_ENAB_CONT
''                                                             read_ENAB_CONT
''                                                             write_ENAB_CONT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enable_ctrl
    Private write_ENAB_CONT_value
    Private read_ENAB_CONT_value
    Private flag_ENAB_CONT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f808
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ENAB_CONT
        get_ENAB_CONT = read_ENAB_CONT_value
    End Property

    Property Let set_ENAB_CONT(aData)
        write_ENAB_CONT_value = aData
        flag_ENAB_CONT        = &H1
    End Property

    Property Get read_ENAB_CONT
        read
        read_ENAB_CONT = read_ENAB_CONT_value
    End Property

    Property Let write_ENAB_CONT(aData)
        set_ENAB_CONT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ENAB_CONT_mask = &H3ffff
        if data_low > LONG_MAX then
            if ENAB_CONT_mask = mask then
                read_ENAB_CONT_value = data_low
            else
                read_ENAB_CONT_value = (data_low - H8000_0000) and ENAB_CONT_mask
            end If
        else
            read_ENAB_CONT_value = data_low and ENAB_CONT_mask
        end If

    End Sub

    Sub write
        If flag_ENAB_CONT = &H0 Then read
        If flag_ENAB_CONT = &H0 Then write_ENAB_CONT_value = get_ENAB_CONT

        regValue = leftShift((write_ENAB_CONT_value and &H3ffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ENAB_CONT_mask = &H3ffff
        if data_low > LONG_MAX then
            if ENAB_CONT_mask = mask then
                read_ENAB_CONT_value = data_low
            else
                read_ENAB_CONT_value = (data_low - H8000_0000) and ENAB_CONT_mask
            end If
        else
            read_ENAB_CONT_value = data_low and ENAB_CONT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENAB_CONT_value = &H0
        flag_ENAB_CONT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_raw_stat_enable_set
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RSES                                       [17:0]           get_RSES
''                                                             set_RSES
''                                                             read_RSES
''                                                             write_RSES
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_raw_stat_enable_set
    Private write_RSES_value
    Private read_RSES_value
    Private flag_RSES

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f80c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RSES
        get_RSES = read_RSES_value
    End Property

    Property Let set_RSES(aData)
        write_RSES_value = aData
        flag_RSES        = &H1
    End Property

    Property Get read_RSES
        read
        read_RSES = read_RSES_value
    End Property

    Property Let write_RSES(aData)
        set_RSES = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RSES_mask = &H3ffff
        if data_low > LONG_MAX then
            if RSES_mask = mask then
                read_RSES_value = data_low
            else
                read_RSES_value = (data_low - H8000_0000) and RSES_mask
            end If
        else
            read_RSES_value = data_low and RSES_mask
        end If

    End Sub

    Sub write
        If flag_RSES = &H0 Then read
        If flag_RSES = &H0 Then write_RSES_value = get_RSES

        regValue = leftShift((write_RSES_value and &H3ffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RSES_mask = &H3ffff
        if data_low > LONG_MAX then
            if RSES_mask = mask then
                read_RSES_value = data_low
            else
                read_RSES_value = (data_low - H8000_0000) and RSES_mask
            end If
        else
            read_RSES_value = data_low and RSES_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RSES_value = &H0
        flag_RSES        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enabled_stat_ack
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ESA                                        [17:0]           get_ESA
''                                                             set_ESA
''                                                             read_ESA
''                                                             write_ESA
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enabled_stat_ack
    Private write_ESA_value
    Private read_ESA_value
    Private flag_ESA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f810
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ESA
        get_ESA = read_ESA_value
    End Property

    Property Let set_ESA(aData)
        write_ESA_value = aData
        flag_ESA        = &H1
    End Property

    Property Get read_ESA
        read
        read_ESA = read_ESA_value
    End Property

    Property Let write_ESA(aData)
        set_ESA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ESA_mask = &H3ffff
        if data_low > LONG_MAX then
            if ESA_mask = mask then
                read_ESA_value = data_low
            else
                read_ESA_value = (data_low - H8000_0000) and ESA_mask
            end If
        else
            read_ESA_value = data_low and ESA_mask
        end If

    End Sub

    Sub write
        If flag_ESA = &H0 Then read
        If flag_ESA = &H0 Then write_ESA_value = get_ESA

        regValue = leftShift((write_ESA_value and &H3ffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ESA_mask = &H3ffff
        if data_low > LONG_MAX then
            if ESA_mask = mask then
                read_ESA_value = data_low
            else
                read_ESA_value = (data_low - H8000_0000) and ESA_mask
            end If
        else
            read_ESA_value = data_low and ESA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ESA_value = &H0
        flag_ESA        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enable_clr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENABLE_CLR                                 [17:0]           get_ENABLE_CLR
''                                                             set_ENABLE_CLR
''                                                             read_ENABLE_CLR
''                                                             write_ENABLE_CLR
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enable_clr
    Private write_ENABLE_CLR_value
    Private read_ENABLE_CLR_value
    Private flag_ENABLE_CLR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f814
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ENABLE_CLR
        get_ENABLE_CLR = read_ENABLE_CLR_value
    End Property

    Property Let set_ENABLE_CLR(aData)
        write_ENABLE_CLR_value = aData
        flag_ENABLE_CLR        = &H1
    End Property

    Property Get read_ENABLE_CLR
        read
        read_ENABLE_CLR = read_ENABLE_CLR_value
    End Property

    Property Let write_ENABLE_CLR(aData)
        set_ENABLE_CLR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ENABLE_CLR_mask = &H3ffff
        if data_low > LONG_MAX then
            if ENABLE_CLR_mask = mask then
                read_ENABLE_CLR_value = data_low
            else
                read_ENABLE_CLR_value = (data_low - H8000_0000) and ENABLE_CLR_mask
            end If
        else
            read_ENABLE_CLR_value = data_low and ENABLE_CLR_mask
        end If

    End Sub

    Sub write
        If flag_ENABLE_CLR = &H0 Then read
        If flag_ENABLE_CLR = &H0 Then write_ENABLE_CLR_value = get_ENABLE_CLR

        regValue = leftShift((write_ENABLE_CLR_value and &H3ffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ENABLE_CLR_mask = &H3ffff
        if data_low > LONG_MAX then
            if ENABLE_CLR_mask = mask then
                read_ENABLE_CLR_value = data_low
            else
                read_ENABLE_CLR_value = (data_low - H8000_0000) and ENABLE_CLR_mask
            end If
        else
            read_ENABLE_CLR_value = data_low and ENABLE_CLR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENABLE_CLR_value = &H0
        flag_ENABLE_CLR        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_options
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NR_OF_INPUTS                               [5:0]            get_NR_OF_INPUTS
''                                                             set_NR_OF_INPUTS
''                                                             read_NR_OF_INPUTS
''                                                             write_NR_OF_INPUTS
''---------------------------------------------------------------------------------
'' EXT_REG_MAP                                [7:7]            get_EXT_REG_MAP
''                                                             set_EXT_REG_MAP
''                                                             read_EXT_REG_MAP
''                                                             write_EXT_REG_MAP
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_options
    Private write_NR_OF_INPUTS_value
    Private read_NR_OF_INPUTS_value
    Private flag_NR_OF_INPUTS
    Private write_EXT_REG_MAP_value
    Private read_EXT_REG_MAP_value
    Private flag_EXT_REG_MAP

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f818
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NR_OF_INPUTS
        get_NR_OF_INPUTS = read_NR_OF_INPUTS_value
    End Property

    Property Let set_NR_OF_INPUTS(aData)
        write_NR_OF_INPUTS_value = aData
        flag_NR_OF_INPUTS        = &H1
    End Property

    Property Get read_NR_OF_INPUTS
        read
        read_NR_OF_INPUTS = read_NR_OF_INPUTS_value
    End Property

    Property Let write_NR_OF_INPUTS(aData)
        set_NR_OF_INPUTS = aData
        write
    End Property

    Property Get get_EXT_REG_MAP
        get_EXT_REG_MAP = read_EXT_REG_MAP_value
    End Property

    Property Let set_EXT_REG_MAP(aData)
        write_EXT_REG_MAP_value = aData
        flag_EXT_REG_MAP        = &H1
    End Property

    Property Get read_EXT_REG_MAP
        read
        read_EXT_REG_MAP = read_EXT_REG_MAP_value
    End Property

    Property Let write_EXT_REG_MAP(aData)
        set_EXT_REG_MAP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NR_OF_INPUTS_mask = &H3f
        if data_low > LONG_MAX then
            if NR_OF_INPUTS_mask = mask then
                read_NR_OF_INPUTS_value = data_low
            else
                read_NR_OF_INPUTS_value = (data_low - H8000_0000) and NR_OF_INPUTS_mask
            end If
        else
            read_NR_OF_INPUTS_value = data_low and NR_OF_INPUTS_mask
        end If
        read_EXT_REG_MAP_value = rightShift(data_low, 7) and &H1

    End Sub

    Sub write
        If flag_NR_OF_INPUTS = &H0 or flag_EXT_REG_MAP = &H0 Then read
        If flag_NR_OF_INPUTS = &H0 Then write_NR_OF_INPUTS_value = get_NR_OF_INPUTS
        If flag_EXT_REG_MAP = &H0 Then write_EXT_REG_MAP_value = get_EXT_REG_MAP

        regValue = leftShift((write_NR_OF_INPUTS_value and &H3f), 0) + leftShift((write_EXT_REG_MAP_value and &H1), 7)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NR_OF_INPUTS_mask = &H3f
        if data_low > LONG_MAX then
            if NR_OF_INPUTS_mask = mask then
                read_NR_OF_INPUTS_value = data_low
            else
                read_NR_OF_INPUTS_value = (data_low - H8000_0000) and NR_OF_INPUTS_mask
            end If
        else
            read_NR_OF_INPUTS_value = data_low and NR_OF_INPUTS_mask
        end If
        read_EXT_REG_MAP_value = rightShift(data_low, 7) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NR_OF_INPUTS_value = &H0
        flag_NR_OF_INPUTS        = &H0
        write_EXT_REG_MAP_value = &H0
        flag_EXT_REG_MAP        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EIP_NUMBER                                 [7:0]            get_EIP_NUMBER
''                                                             set_EIP_NUMBER
''                                                             read_EIP_NUMBER
''                                                             write_EIP_NUMBER
''---------------------------------------------------------------------------------
'' ENC                                        [15:8]           get_ENC
''                                                             set_ENC
''                                                             read_ENC
''                                                             write_ENC
''---------------------------------------------------------------------------------
'' PATCH_LEVEL                                [19:16]          get_PATCH_LEVEL
''                                                             set_PATCH_LEVEL
''                                                             read_PATCH_LEVEL
''                                                             write_PATCH_LEVEL
''---------------------------------------------------------------------------------
'' MINO_VERS                                  [23:20]          get_MINO_VERS
''                                                             set_MINO_VERS
''                                                             read_MINO_VERS
''                                                             write_MINO_VERS
''---------------------------------------------------------------------------------
'' MAJO_VERS                                  [27:24]          get_MAJO_VERS
''                                                             set_MAJO_VERS
''                                                             read_MAJO_VERS
''                                                             write_MAJO_VERS
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_version
    Private write_EIP_NUMBER_value
    Private read_EIP_NUMBER_value
    Private flag_EIP_NUMBER
    Private write_ENC_value
    Private read_ENC_value
    Private flag_ENC
    Private write_PATCH_LEVEL_value
    Private read_PATCH_LEVEL_value
    Private flag_PATCH_LEVEL
    Private write_MINO_VERS_value
    Private read_MINO_VERS_value
    Private flag_MINO_VERS
    Private write_MAJO_VERS_value
    Private read_MAJO_VERS_value
    Private flag_MAJO_VERS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1f81c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EIP_NUMBER
        get_EIP_NUMBER = read_EIP_NUMBER_value
    End Property

    Property Let set_EIP_NUMBER(aData)
        write_EIP_NUMBER_value = aData
        flag_EIP_NUMBER        = &H1
    End Property

    Property Get read_EIP_NUMBER
        read
        read_EIP_NUMBER = read_EIP_NUMBER_value
    End Property

    Property Let write_EIP_NUMBER(aData)
        set_EIP_NUMBER = aData
        write
    End Property

    Property Get get_ENC
        get_ENC = read_ENC_value
    End Property

    Property Let set_ENC(aData)
        write_ENC_value = aData
        flag_ENC        = &H1
    End Property

    Property Get read_ENC
        read
        read_ENC = read_ENC_value
    End Property

    Property Let write_ENC(aData)
        set_ENC = aData
        write
    End Property

    Property Get get_PATCH_LEVEL
        get_PATCH_LEVEL = read_PATCH_LEVEL_value
    End Property

    Property Let set_PATCH_LEVEL(aData)
        write_PATCH_LEVEL_value = aData
        flag_PATCH_LEVEL        = &H1
    End Property

    Property Get read_PATCH_LEVEL
        read
        read_PATCH_LEVEL = read_PATCH_LEVEL_value
    End Property

    Property Let write_PATCH_LEVEL(aData)
        set_PATCH_LEVEL = aData
        write
    End Property

    Property Get get_MINO_VERS
        get_MINO_VERS = read_MINO_VERS_value
    End Property

    Property Let set_MINO_VERS(aData)
        write_MINO_VERS_value = aData
        flag_MINO_VERS        = &H1
    End Property

    Property Get read_MINO_VERS
        read
        read_MINO_VERS = read_MINO_VERS_value
    End Property

    Property Let write_MINO_VERS(aData)
        set_MINO_VERS = aData
        write
    End Property

    Property Get get_MAJO_VERS
        get_MAJO_VERS = read_MAJO_VERS_value
    End Property

    Property Let set_MAJO_VERS(aData)
        write_MAJO_VERS_value = aData
        flag_MAJO_VERS        = &H1
    End Property

    Property Get read_MAJO_VERS
        read
        read_MAJO_VERS = read_MAJO_VERS_value
    End Property

    Property Let write_MAJO_VERS(aData)
        set_MAJO_VERS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EIP_NUMBER_mask = &Hff
        if data_low > LONG_MAX then
            if EIP_NUMBER_mask = mask then
                read_EIP_NUMBER_value = data_low
            else
                read_EIP_NUMBER_value = (data_low - H8000_0000) and EIP_NUMBER_mask
            end If
        else
            read_EIP_NUMBER_value = data_low and EIP_NUMBER_mask
        end If
        read_ENC_value = rightShift(data_low, 8) and &Hff
        read_PATCH_LEVEL_value = rightShift(data_low, 16) and &Hf
        read_MINO_VERS_value = rightShift(data_low, 20) and &Hf
        read_MAJO_VERS_value = rightShift(data_low, 24) and &Hf

    End Sub

    Sub write
        If flag_EIP_NUMBER = &H0 or flag_ENC = &H0 or flag_PATCH_LEVEL = &H0 or flag_MINO_VERS = &H0 or flag_MAJO_VERS = &H0 Then read
        If flag_EIP_NUMBER = &H0 Then write_EIP_NUMBER_value = get_EIP_NUMBER
        If flag_ENC = &H0 Then write_ENC_value = get_ENC
        If flag_PATCH_LEVEL = &H0 Then write_PATCH_LEVEL_value = get_PATCH_LEVEL
        If flag_MINO_VERS = &H0 Then write_MINO_VERS_value = get_MINO_VERS
        If flag_MAJO_VERS = &H0 Then write_MAJO_VERS_value = get_MAJO_VERS

        regValue = leftShift((write_EIP_NUMBER_value and &Hff), 0) + leftShift((write_ENC_value and &Hff), 8) + leftShift((write_PATCH_LEVEL_value and &Hf), 16) + leftShift((write_MINO_VERS_value and &Hf), 20) + leftShift((write_MAJO_VERS_value and &Hf), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EIP_NUMBER_mask = &Hff
        if data_low > LONG_MAX then
            if EIP_NUMBER_mask = mask then
                read_EIP_NUMBER_value = data_low
            else
                read_EIP_NUMBER_value = (data_low - H8000_0000) and EIP_NUMBER_mask
            end If
        else
            read_EIP_NUMBER_value = data_low and EIP_NUMBER_mask
        end If
        read_ENC_value = rightShift(data_low, 8) and &Hff
        read_PATCH_LEVEL_value = rightShift(data_low, 16) and &Hf
        read_MINO_VERS_value = rightShift(data_low, 20) and &Hf
        read_MAJO_VERS_value = rightShift(data_low, 24) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EIP_NUMBER_value = &H0
        flag_EIP_NUMBER        = &H0
        write_ENC_value = &H0
        flag_ENC        = &H0
        write_PATCH_LEVEL_value = &H0
        flag_PATCH_LEVEL        = &H0
        write_MINO_VERS_value = &H0
        flag_MINO_VERS        = &H0
        write_MAJO_VERS_value = &H0
        flag_MAJO_VERS        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_INSTANCE

    Public aic_pol_ctrl
    Public aic_type_ctrl
    Public aic_enable_ctrl
    Public aic_raw_stat_enable_set
    Public aic_enabled_stat_ack
    Public aic_enable_clr
    Public aic_options
    Public aic_version


    Public default function Init(aBaseAddr)
        Set aic_pol_ctrl = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_pol_ctrl)(aBaseAddr, 32)
        Set aic_type_ctrl = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_type_ctrl)(aBaseAddr, 32)
        Set aic_enable_ctrl = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enable_ctrl)(aBaseAddr, 32)
        Set aic_raw_stat_enable_set = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_raw_stat_enable_set)(aBaseAddr, 32)
        Set aic_enabled_stat_ack = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enabled_stat_ack)(aBaseAddr, 32)
        Set aic_enable_clr = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_enable_clr)(aBaseAddr, 32)
        Set aic_options = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_options)(aBaseAddr, 32)
        Set aic_version = (New REGISTER_EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_aic_version)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_AIC_AIC_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_AIC_AIC_REGS.Add ((New EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_AIC_AIC_REGS.Add ((New EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_AIC_AIC_REGS.Add ((New EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_AIC_AIC_REGS.Add ((New EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_AIC_AIC_REGS.Add ((New EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_AIC_AIC_REGS.Add ((New EIP165S_EIP165_EGEIP160_AIC_AIC_REGS_INSTANCE)(&H4d510000))


