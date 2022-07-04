

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


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_cp_match_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAC_DA_0                                   [0:0]            get_MAC_DA_0
''                                                             set_MAC_DA_0
''                                                             read_MAC_DA_0
''                                                             write_MAC_DA_0
''---------------------------------------------------------------------------------
'' MAC_DA_1                                   [1:1]            get_MAC_DA_1
''                                                             set_MAC_DA_1
''                                                             read_MAC_DA_1
''                                                             write_MAC_DA_1
''---------------------------------------------------------------------------------
'' MAC_DA_2                                   [2:2]            get_MAC_DA_2
''                                                             set_MAC_DA_2
''                                                             read_MAC_DA_2
''                                                             write_MAC_DA_2
''---------------------------------------------------------------------------------
'' MAC_DA_3                                   [3:3]            get_MAC_DA_3
''                                                             set_MAC_DA_3
''                                                             read_MAC_DA_3
''                                                             write_MAC_DA_3
''---------------------------------------------------------------------------------
'' MAC_DA_4                                   [4:4]            get_MAC_DA_4
''                                                             set_MAC_DA_4
''                                                             read_MAC_DA_4
''                                                             write_MAC_DA_4
''---------------------------------------------------------------------------------
'' MAC_DA_5                                   [5:5]            get_MAC_DA_5
''                                                             set_MAC_DA_5
''                                                             read_MAC_DA_5
''                                                             write_MAC_DA_5
''---------------------------------------------------------------------------------
'' MAC_DA_6                                   [6:6]            get_MAC_DA_6
''                                                             set_MAC_DA_6
''                                                             read_MAC_DA_6
''                                                             write_MAC_DA_6
''---------------------------------------------------------------------------------
'' MAC_DA_7                                   [7:7]            get_MAC_DA_7
''                                                             set_MAC_DA_7
''                                                             read_MAC_DA_7
''                                                             write_MAC_DA_7
''---------------------------------------------------------------------------------
'' E_TYPE_0                                   [8:8]            get_E_TYPE_0
''                                                             set_E_TYPE_0
''                                                             read_E_TYPE_0
''                                                             write_E_TYPE_0
''---------------------------------------------------------------------------------
'' E_TYPE_1                                   [9:9]            get_E_TYPE_1
''                                                             set_E_TYPE_1
''                                                             read_E_TYPE_1
''                                                             write_E_TYPE_1
''---------------------------------------------------------------------------------
'' E_TYPE_2                                   [10:10]          get_E_TYPE_2
''                                                             set_E_TYPE_2
''                                                             read_E_TYPE_2
''                                                             write_E_TYPE_2
''---------------------------------------------------------------------------------
'' E_TYPE_3                                   [11:11]          get_E_TYPE_3
''                                                             set_E_TYPE_3
''                                                             read_E_TYPE_3
''                                                             write_E_TYPE_3
''---------------------------------------------------------------------------------
'' E_TYPE_4                                   [12:12]          get_E_TYPE_4
''                                                             set_E_TYPE_4
''                                                             read_E_TYPE_4
''                                                             write_E_TYPE_4
''---------------------------------------------------------------------------------
'' E_TYPE_5                                   [13:13]          get_E_TYPE_5
''                                                             set_E_TYPE_5
''                                                             read_E_TYPE_5
''                                                             write_E_TYPE_5
''---------------------------------------------------------------------------------
'' E_TYPE_6                                   [14:14]          get_E_TYPE_6
''                                                             set_E_TYPE_6
''                                                             read_E_TYPE_6
''                                                             write_E_TYPE_6
''---------------------------------------------------------------------------------
'' E_TYPE_7                                   [15:15]          get_E_TYPE_7
''                                                             set_E_TYPE_7
''                                                             read_E_TYPE_7
''                                                             write_E_TYPE_7
''---------------------------------------------------------------------------------
'' COMB8                                      [16:16]          get_COMB8
''                                                             set_COMB8
''                                                             read_COMB8
''                                                             write_COMB8
''---------------------------------------------------------------------------------
'' COMB9                                      [17:17]          get_COMB9
''                                                             set_COMB9
''                                                             read_COMB9
''                                                             write_COMB9
''---------------------------------------------------------------------------------
'' RANGE                                      [18:18]          get_RANGE
''                                                             set_RANGE
''                                                             read_RANGE
''                                                             write_RANGE
''---------------------------------------------------------------------------------
'' CONST_44                                   [19:19]          get_CONST_44
''                                                             set_CONST_44
''                                                             read_CONST_44
''                                                             write_CONST_44
''---------------------------------------------------------------------------------
'' CONST_48                                   [20:20]          get_CONST_48
''                                                             set_CONST_48
''                                                             read_CONST_48
''                                                             write_CONST_48
''---------------------------------------------------------------------------------
'' MACSEC_KAY                                 [31:31]          get_MACSEC_KAY
''                                                             set_MACSEC_KAY
''                                                             read_MACSEC_KAY
''                                                             write_MACSEC_KAY
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_cp_match_debug
    Private write_MAC_DA_0_value
    Private read_MAC_DA_0_value
    Private flag_MAC_DA_0
    Private write_MAC_DA_1_value
    Private read_MAC_DA_1_value
    Private flag_MAC_DA_1
    Private write_MAC_DA_2_value
    Private read_MAC_DA_2_value
    Private flag_MAC_DA_2
    Private write_MAC_DA_3_value
    Private read_MAC_DA_3_value
    Private flag_MAC_DA_3
    Private write_MAC_DA_4_value
    Private read_MAC_DA_4_value
    Private flag_MAC_DA_4
    Private write_MAC_DA_5_value
    Private read_MAC_DA_5_value
    Private flag_MAC_DA_5
    Private write_MAC_DA_6_value
    Private read_MAC_DA_6_value
    Private flag_MAC_DA_6
    Private write_MAC_DA_7_value
    Private read_MAC_DA_7_value
    Private flag_MAC_DA_7
    Private write_E_TYPE_0_value
    Private read_E_TYPE_0_value
    Private flag_E_TYPE_0
    Private write_E_TYPE_1_value
    Private read_E_TYPE_1_value
    Private flag_E_TYPE_1
    Private write_E_TYPE_2_value
    Private read_E_TYPE_2_value
    Private flag_E_TYPE_2
    Private write_E_TYPE_3_value
    Private read_E_TYPE_3_value
    Private flag_E_TYPE_3
    Private write_E_TYPE_4_value
    Private read_E_TYPE_4_value
    Private flag_E_TYPE_4
    Private write_E_TYPE_5_value
    Private read_E_TYPE_5_value
    Private flag_E_TYPE_5
    Private write_E_TYPE_6_value
    Private read_E_TYPE_6_value
    Private flag_E_TYPE_6
    Private write_E_TYPE_7_value
    Private read_E_TYPE_7_value
    Private flag_E_TYPE_7
    Private write_COMB8_value
    Private read_COMB8_value
    Private flag_COMB8
    Private write_COMB9_value
    Private read_COMB9_value
    Private flag_COMB9
    Private write_RANGE_value
    Private read_RANGE_value
    Private flag_RANGE
    Private write_CONST_44_value
    Private read_CONST_44_value
    Private flag_CONST_44
    Private write_CONST_48_value
    Private read_CONST_48_value
    Private flag_CONST_48
    Private write_MACSEC_KAY_value
    Private read_MACSEC_KAY_value
    Private flag_MACSEC_KAY

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MAC_DA_0
        get_MAC_DA_0 = read_MAC_DA_0_value
    End Property

    Property Let set_MAC_DA_0(aData)
        write_MAC_DA_0_value = aData
        flag_MAC_DA_0        = &H1
    End Property

    Property Get read_MAC_DA_0
        read
        read_MAC_DA_0 = read_MAC_DA_0_value
    End Property

    Property Let write_MAC_DA_0(aData)
        set_MAC_DA_0 = aData
        write
    End Property

    Property Get get_MAC_DA_1
        get_MAC_DA_1 = read_MAC_DA_1_value
    End Property

    Property Let set_MAC_DA_1(aData)
        write_MAC_DA_1_value = aData
        flag_MAC_DA_1        = &H1
    End Property

    Property Get read_MAC_DA_1
        read
        read_MAC_DA_1 = read_MAC_DA_1_value
    End Property

    Property Let write_MAC_DA_1(aData)
        set_MAC_DA_1 = aData
        write
    End Property

    Property Get get_MAC_DA_2
        get_MAC_DA_2 = read_MAC_DA_2_value
    End Property

    Property Let set_MAC_DA_2(aData)
        write_MAC_DA_2_value = aData
        flag_MAC_DA_2        = &H1
    End Property

    Property Get read_MAC_DA_2
        read
        read_MAC_DA_2 = read_MAC_DA_2_value
    End Property

    Property Let write_MAC_DA_2(aData)
        set_MAC_DA_2 = aData
        write
    End Property

    Property Get get_MAC_DA_3
        get_MAC_DA_3 = read_MAC_DA_3_value
    End Property

    Property Let set_MAC_DA_3(aData)
        write_MAC_DA_3_value = aData
        flag_MAC_DA_3        = &H1
    End Property

    Property Get read_MAC_DA_3
        read
        read_MAC_DA_3 = read_MAC_DA_3_value
    End Property

    Property Let write_MAC_DA_3(aData)
        set_MAC_DA_3 = aData
        write
    End Property

    Property Get get_MAC_DA_4
        get_MAC_DA_4 = read_MAC_DA_4_value
    End Property

    Property Let set_MAC_DA_4(aData)
        write_MAC_DA_4_value = aData
        flag_MAC_DA_4        = &H1
    End Property

    Property Get read_MAC_DA_4
        read
        read_MAC_DA_4 = read_MAC_DA_4_value
    End Property

    Property Let write_MAC_DA_4(aData)
        set_MAC_DA_4 = aData
        write
    End Property

    Property Get get_MAC_DA_5
        get_MAC_DA_5 = read_MAC_DA_5_value
    End Property

    Property Let set_MAC_DA_5(aData)
        write_MAC_DA_5_value = aData
        flag_MAC_DA_5        = &H1
    End Property

    Property Get read_MAC_DA_5
        read
        read_MAC_DA_5 = read_MAC_DA_5_value
    End Property

    Property Let write_MAC_DA_5(aData)
        set_MAC_DA_5 = aData
        write
    End Property

    Property Get get_MAC_DA_6
        get_MAC_DA_6 = read_MAC_DA_6_value
    End Property

    Property Let set_MAC_DA_6(aData)
        write_MAC_DA_6_value = aData
        flag_MAC_DA_6        = &H1
    End Property

    Property Get read_MAC_DA_6
        read
        read_MAC_DA_6 = read_MAC_DA_6_value
    End Property

    Property Let write_MAC_DA_6(aData)
        set_MAC_DA_6 = aData
        write
    End Property

    Property Get get_MAC_DA_7
        get_MAC_DA_7 = read_MAC_DA_7_value
    End Property

    Property Let set_MAC_DA_7(aData)
        write_MAC_DA_7_value = aData
        flag_MAC_DA_7        = &H1
    End Property

    Property Get read_MAC_DA_7
        read
        read_MAC_DA_7 = read_MAC_DA_7_value
    End Property

    Property Let write_MAC_DA_7(aData)
        set_MAC_DA_7 = aData
        write
    End Property

    Property Get get_E_TYPE_0
        get_E_TYPE_0 = read_E_TYPE_0_value
    End Property

    Property Let set_E_TYPE_0(aData)
        write_E_TYPE_0_value = aData
        flag_E_TYPE_0        = &H1
    End Property

    Property Get read_E_TYPE_0
        read
        read_E_TYPE_0 = read_E_TYPE_0_value
    End Property

    Property Let write_E_TYPE_0(aData)
        set_E_TYPE_0 = aData
        write
    End Property

    Property Get get_E_TYPE_1
        get_E_TYPE_1 = read_E_TYPE_1_value
    End Property

    Property Let set_E_TYPE_1(aData)
        write_E_TYPE_1_value = aData
        flag_E_TYPE_1        = &H1
    End Property

    Property Get read_E_TYPE_1
        read
        read_E_TYPE_1 = read_E_TYPE_1_value
    End Property

    Property Let write_E_TYPE_1(aData)
        set_E_TYPE_1 = aData
        write
    End Property

    Property Get get_E_TYPE_2
        get_E_TYPE_2 = read_E_TYPE_2_value
    End Property

    Property Let set_E_TYPE_2(aData)
        write_E_TYPE_2_value = aData
        flag_E_TYPE_2        = &H1
    End Property

    Property Get read_E_TYPE_2
        read
        read_E_TYPE_2 = read_E_TYPE_2_value
    End Property

    Property Let write_E_TYPE_2(aData)
        set_E_TYPE_2 = aData
        write
    End Property

    Property Get get_E_TYPE_3
        get_E_TYPE_3 = read_E_TYPE_3_value
    End Property

    Property Let set_E_TYPE_3(aData)
        write_E_TYPE_3_value = aData
        flag_E_TYPE_3        = &H1
    End Property

    Property Get read_E_TYPE_3
        read
        read_E_TYPE_3 = read_E_TYPE_3_value
    End Property

    Property Let write_E_TYPE_3(aData)
        set_E_TYPE_3 = aData
        write
    End Property

    Property Get get_E_TYPE_4
        get_E_TYPE_4 = read_E_TYPE_4_value
    End Property

    Property Let set_E_TYPE_4(aData)
        write_E_TYPE_4_value = aData
        flag_E_TYPE_4        = &H1
    End Property

    Property Get read_E_TYPE_4
        read
        read_E_TYPE_4 = read_E_TYPE_4_value
    End Property

    Property Let write_E_TYPE_4(aData)
        set_E_TYPE_4 = aData
        write
    End Property

    Property Get get_E_TYPE_5
        get_E_TYPE_5 = read_E_TYPE_5_value
    End Property

    Property Let set_E_TYPE_5(aData)
        write_E_TYPE_5_value = aData
        flag_E_TYPE_5        = &H1
    End Property

    Property Get read_E_TYPE_5
        read
        read_E_TYPE_5 = read_E_TYPE_5_value
    End Property

    Property Let write_E_TYPE_5(aData)
        set_E_TYPE_5 = aData
        write
    End Property

    Property Get get_E_TYPE_6
        get_E_TYPE_6 = read_E_TYPE_6_value
    End Property

    Property Let set_E_TYPE_6(aData)
        write_E_TYPE_6_value = aData
        flag_E_TYPE_6        = &H1
    End Property

    Property Get read_E_TYPE_6
        read
        read_E_TYPE_6 = read_E_TYPE_6_value
    End Property

    Property Let write_E_TYPE_6(aData)
        set_E_TYPE_6 = aData
        write
    End Property

    Property Get get_E_TYPE_7
        get_E_TYPE_7 = read_E_TYPE_7_value
    End Property

    Property Let set_E_TYPE_7(aData)
        write_E_TYPE_7_value = aData
        flag_E_TYPE_7        = &H1
    End Property

    Property Get read_E_TYPE_7
        read
        read_E_TYPE_7 = read_E_TYPE_7_value
    End Property

    Property Let write_E_TYPE_7(aData)
        set_E_TYPE_7 = aData
        write
    End Property

    Property Get get_COMB8
        get_COMB8 = read_COMB8_value
    End Property

    Property Let set_COMB8(aData)
        write_COMB8_value = aData
        flag_COMB8        = &H1
    End Property

    Property Get read_COMB8
        read
        read_COMB8 = read_COMB8_value
    End Property

    Property Let write_COMB8(aData)
        set_COMB8 = aData
        write
    End Property

    Property Get get_COMB9
        get_COMB9 = read_COMB9_value
    End Property

    Property Let set_COMB9(aData)
        write_COMB9_value = aData
        flag_COMB9        = &H1
    End Property

    Property Get read_COMB9
        read
        read_COMB9 = read_COMB9_value
    End Property

    Property Let write_COMB9(aData)
        set_COMB9 = aData
        write
    End Property

    Property Get get_RANGE
        get_RANGE = read_RANGE_value
    End Property

    Property Let set_RANGE(aData)
        write_RANGE_value = aData
        flag_RANGE        = &H1
    End Property

    Property Get read_RANGE
        read
        read_RANGE = read_RANGE_value
    End Property

    Property Let write_RANGE(aData)
        set_RANGE = aData
        write
    End Property

    Property Get get_CONST_44
        get_CONST_44 = read_CONST_44_value
    End Property

    Property Let set_CONST_44(aData)
        write_CONST_44_value = aData
        flag_CONST_44        = &H1
    End Property

    Property Get read_CONST_44
        read
        read_CONST_44 = read_CONST_44_value
    End Property

    Property Let write_CONST_44(aData)
        set_CONST_44 = aData
        write
    End Property

    Property Get get_CONST_48
        get_CONST_48 = read_CONST_48_value
    End Property

    Property Let set_CONST_48(aData)
        write_CONST_48_value = aData
        flag_CONST_48        = &H1
    End Property

    Property Get read_CONST_48
        read
        read_CONST_48 = read_CONST_48_value
    End Property

    Property Let write_CONST_48(aData)
        set_CONST_48 = aData
        write
    End Property

    Property Get get_MACSEC_KAY
        get_MACSEC_KAY = read_MACSEC_KAY_value
    End Property

    Property Let set_MACSEC_KAY(aData)
        write_MACSEC_KAY_value = aData
        flag_MACSEC_KAY        = &H1
    End Property

    Property Get read_MACSEC_KAY
        read
        read_MACSEC_KAY = read_MACSEC_KAY_value
    End Property

    Property Let write_MACSEC_KAY(aData)
        set_MACSEC_KAY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAC_DA_0_mask = &H1
        if data_low > LONG_MAX then
            if MAC_DA_0_mask = mask then
                read_MAC_DA_0_value = data_low
            else
                read_MAC_DA_0_value = (data_low - H8000_0000) and MAC_DA_0_mask
            end If
        else
            read_MAC_DA_0_value = data_low and MAC_DA_0_mask
        end If
        read_MAC_DA_1_value = rightShift(data_low, 1) and &H1
        read_MAC_DA_2_value = rightShift(data_low, 2) and &H1
        read_MAC_DA_3_value = rightShift(data_low, 3) and &H1
        read_MAC_DA_4_value = rightShift(data_low, 4) and &H1
        read_MAC_DA_5_value = rightShift(data_low, 5) and &H1
        read_MAC_DA_6_value = rightShift(data_low, 6) and &H1
        read_MAC_DA_7_value = rightShift(data_low, 7) and &H1
        read_E_TYPE_0_value = rightShift(data_low, 8) and &H1
        read_E_TYPE_1_value = rightShift(data_low, 9) and &H1
        read_E_TYPE_2_value = rightShift(data_low, 10) and &H1
        read_E_TYPE_3_value = rightShift(data_low, 11) and &H1
        read_E_TYPE_4_value = rightShift(data_low, 12) and &H1
        read_E_TYPE_5_value = rightShift(data_low, 13) and &H1
        read_E_TYPE_6_value = rightShift(data_low, 14) and &H1
        read_E_TYPE_7_value = rightShift(data_low, 15) and &H1
        read_COMB8_value = rightShift(data_low, 16) and &H1
        read_COMB9_value = rightShift(data_low, 17) and &H1
        read_RANGE_value = rightShift(data_low, 18) and &H1
        read_CONST_44_value = rightShift(data_low, 19) and &H1
        read_CONST_48_value = rightShift(data_low, 20) and &H1
        read_MACSEC_KAY_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_MAC_DA_0 = &H0 or flag_MAC_DA_1 = &H0 or flag_MAC_DA_2 = &H0 or flag_MAC_DA_3 = &H0 or flag_MAC_DA_4 = &H0 or flag_MAC_DA_5 = &H0 or flag_MAC_DA_6 = &H0 or flag_MAC_DA_7 = &H0 or flag_E_TYPE_0 = &H0 or flag_E_TYPE_1 = &H0 or flag_E_TYPE_2 = &H0 or flag_E_TYPE_3 = &H0 or flag_E_TYPE_4 = &H0 or flag_E_TYPE_5 = &H0 or flag_E_TYPE_6 = &H0 or flag_E_TYPE_7 = &H0 or flag_COMB8 = &H0 or flag_COMB9 = &H0 or flag_RANGE = &H0 or flag_CONST_44 = &H0 or flag_CONST_48 = &H0 or flag_MACSEC_KAY = &H0 Then read
        If flag_MAC_DA_0 = &H0 Then write_MAC_DA_0_value = get_MAC_DA_0
        If flag_MAC_DA_1 = &H0 Then write_MAC_DA_1_value = get_MAC_DA_1
        If flag_MAC_DA_2 = &H0 Then write_MAC_DA_2_value = get_MAC_DA_2
        If flag_MAC_DA_3 = &H0 Then write_MAC_DA_3_value = get_MAC_DA_3
        If flag_MAC_DA_4 = &H0 Then write_MAC_DA_4_value = get_MAC_DA_4
        If flag_MAC_DA_5 = &H0 Then write_MAC_DA_5_value = get_MAC_DA_5
        If flag_MAC_DA_6 = &H0 Then write_MAC_DA_6_value = get_MAC_DA_6
        If flag_MAC_DA_7 = &H0 Then write_MAC_DA_7_value = get_MAC_DA_7
        If flag_E_TYPE_0 = &H0 Then write_E_TYPE_0_value = get_E_TYPE_0
        If flag_E_TYPE_1 = &H0 Then write_E_TYPE_1_value = get_E_TYPE_1
        If flag_E_TYPE_2 = &H0 Then write_E_TYPE_2_value = get_E_TYPE_2
        If flag_E_TYPE_3 = &H0 Then write_E_TYPE_3_value = get_E_TYPE_3
        If flag_E_TYPE_4 = &H0 Then write_E_TYPE_4_value = get_E_TYPE_4
        If flag_E_TYPE_5 = &H0 Then write_E_TYPE_5_value = get_E_TYPE_5
        If flag_E_TYPE_6 = &H0 Then write_E_TYPE_6_value = get_E_TYPE_6
        If flag_E_TYPE_7 = &H0 Then write_E_TYPE_7_value = get_E_TYPE_7
        If flag_COMB8 = &H0 Then write_COMB8_value = get_COMB8
        If flag_COMB9 = &H0 Then write_COMB9_value = get_COMB9
        If flag_RANGE = &H0 Then write_RANGE_value = get_RANGE
        If flag_CONST_44 = &H0 Then write_CONST_44_value = get_CONST_44
        If flag_CONST_48 = &H0 Then write_CONST_48_value = get_CONST_48
        If flag_MACSEC_KAY = &H0 Then write_MACSEC_KAY_value = get_MACSEC_KAY

        regValue = leftShift((write_MAC_DA_0_value and &H1), 0) + leftShift((write_MAC_DA_1_value and &H1), 1) + leftShift((write_MAC_DA_2_value and &H1), 2) + leftShift((write_MAC_DA_3_value and &H1), 3) + leftShift((write_MAC_DA_4_value and &H1), 4) + leftShift((write_MAC_DA_5_value and &H1), 5) + leftShift((write_MAC_DA_6_value and &H1), 6) + leftShift((write_MAC_DA_7_value and &H1), 7) + leftShift((write_E_TYPE_0_value and &H1), 8) + leftShift((write_E_TYPE_1_value and &H1), 9) + leftShift((write_E_TYPE_2_value and &H1), 10) + leftShift((write_E_TYPE_3_value and &H1), 11) + leftShift((write_E_TYPE_4_value and &H1), 12) + leftShift((write_E_TYPE_5_value and &H1), 13) + leftShift((write_E_TYPE_6_value and &H1), 14) + leftShift((write_E_TYPE_7_value and &H1), 15) + leftShift((write_COMB8_value and &H1), 16) + leftShift((write_COMB9_value and &H1), 17) + leftShift((write_RANGE_value and &H1), 18) + leftShift((write_CONST_44_value and &H1), 19) + leftShift((write_CONST_48_value and &H1), 20) + leftShift((write_MACSEC_KAY_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MAC_DA_0_mask = &H1
        if data_low > LONG_MAX then
            if MAC_DA_0_mask = mask then
                read_MAC_DA_0_value = data_low
            else
                read_MAC_DA_0_value = (data_low - H8000_0000) and MAC_DA_0_mask
            end If
        else
            read_MAC_DA_0_value = data_low and MAC_DA_0_mask
        end If
        read_MAC_DA_1_value = rightShift(data_low, 1) and &H1
        read_MAC_DA_2_value = rightShift(data_low, 2) and &H1
        read_MAC_DA_3_value = rightShift(data_low, 3) and &H1
        read_MAC_DA_4_value = rightShift(data_low, 4) and &H1
        read_MAC_DA_5_value = rightShift(data_low, 5) and &H1
        read_MAC_DA_6_value = rightShift(data_low, 6) and &H1
        read_MAC_DA_7_value = rightShift(data_low, 7) and &H1
        read_E_TYPE_0_value = rightShift(data_low, 8) and &H1
        read_E_TYPE_1_value = rightShift(data_low, 9) and &H1
        read_E_TYPE_2_value = rightShift(data_low, 10) and &H1
        read_E_TYPE_3_value = rightShift(data_low, 11) and &H1
        read_E_TYPE_4_value = rightShift(data_low, 12) and &H1
        read_E_TYPE_5_value = rightShift(data_low, 13) and &H1
        read_E_TYPE_6_value = rightShift(data_low, 14) and &H1
        read_E_TYPE_7_value = rightShift(data_low, 15) and &H1
        read_COMB8_value = rightShift(data_low, 16) and &H1
        read_COMB9_value = rightShift(data_low, 17) and &H1
        read_RANGE_value = rightShift(data_low, 18) and &H1
        read_CONST_44_value = rightShift(data_low, 19) and &H1
        read_CONST_48_value = rightShift(data_low, 20) and &H1
        read_MACSEC_KAY_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAC_DA_0_value = &H0
        flag_MAC_DA_0        = &H0
        write_MAC_DA_1_value = &H0
        flag_MAC_DA_1        = &H0
        write_MAC_DA_2_value = &H0
        flag_MAC_DA_2        = &H0
        write_MAC_DA_3_value = &H0
        flag_MAC_DA_3        = &H0
        write_MAC_DA_4_value = &H0
        flag_MAC_DA_4        = &H0
        write_MAC_DA_5_value = &H0
        flag_MAC_DA_5        = &H0
        write_MAC_DA_6_value = &H0
        flag_MAC_DA_6        = &H0
        write_MAC_DA_7_value = &H0
        flag_MAC_DA_7        = &H0
        write_E_TYPE_0_value = &H0
        flag_E_TYPE_0        = &H0
        write_E_TYPE_1_value = &H0
        flag_E_TYPE_1        = &H0
        write_E_TYPE_2_value = &H0
        flag_E_TYPE_2        = &H0
        write_E_TYPE_3_value = &H0
        flag_E_TYPE_3        = &H0
        write_E_TYPE_4_value = &H0
        flag_E_TYPE_4        = &H0
        write_E_TYPE_5_value = &H0
        flag_E_TYPE_5        = &H0
        write_E_TYPE_6_value = &H0
        flag_E_TYPE_6        = &H0
        write_E_TYPE_7_value = &H0
        flag_E_TYPE_7        = &H0
        write_COMB8_value = &H0
        flag_COMB8        = &H0
        write_COMB9_value = &H0
        flag_COMB9        = &H0
        write_RANGE_value = &H0
        flag_RANGE        = &H0
        write_CONST_44_value = &H0
        flag_CONST_44        = &H0
        write_CONST_48_value = &H0
        flag_CONST_48        = &H0
        write_MACSEC_KAY_value = &H0
        flag_MACSEC_KAY        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_scp_mpls_match_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_0                                   [0:0]            get_mac_da_0
''                                                             set_mac_da_0
''                                                             read_mac_da_0
''                                                             write_mac_da_0
''---------------------------------------------------------------------------------
'' mac_da_1                                   [1:1]            get_mac_da_1
''                                                             set_mac_da_1
''                                                             read_mac_da_1
''                                                             write_mac_da_1
''---------------------------------------------------------------------------------
'' mac_da_2                                   [2:2]            get_mac_da_2
''                                                             set_mac_da_2
''                                                             read_mac_da_2
''                                                             write_mac_da_2
''---------------------------------------------------------------------------------
'' mac_da_3                                   [3:3]            get_mac_da_3
''                                                             set_mac_da_3
''                                                             read_mac_da_3
''                                                             write_mac_da_3
''---------------------------------------------------------------------------------
'' mac_da_4                                   [4:4]            get_mac_da_4
''                                                             set_mac_da_4
''                                                             read_mac_da_4
''                                                             write_mac_da_4
''---------------------------------------------------------------------------------
'' mac_da_5                                   [5:5]            get_mac_da_5
''                                                             set_mac_da_5
''                                                             read_mac_da_5
''                                                             write_mac_da_5
''---------------------------------------------------------------------------------
'' mac_da_6                                   [6:6]            get_mac_da_6
''                                                             set_mac_da_6
''                                                             read_mac_da_6
''                                                             write_mac_da_6
''---------------------------------------------------------------------------------
'' mac_da_7                                   [7:7]            get_mac_da_7
''                                                             set_mac_da_7
''                                                             read_mac_da_7
''                                                             write_mac_da_7
''---------------------------------------------------------------------------------
'' e_type_0                                   [8:8]            get_e_type_0
''                                                             set_e_type_0
''                                                             read_e_type_0
''                                                             write_e_type_0
''---------------------------------------------------------------------------------
'' e_type_1                                   [9:9]            get_e_type_1
''                                                             set_e_type_1
''                                                             read_e_type_1
''                                                             write_e_type_1
''---------------------------------------------------------------------------------
'' e_type_2                                   [10:10]          get_e_type_2
''                                                             set_e_type_2
''                                                             read_e_type_2
''                                                             write_e_type_2
''---------------------------------------------------------------------------------
'' e_type_3                                   [11:11]          get_e_type_3
''                                                             set_e_type_3
''                                                             read_e_type_3
''                                                             write_e_type_3
''---------------------------------------------------------------------------------
'' e_type_4                                   [12:12]          get_e_type_4
''                                                             set_e_type_4
''                                                             read_e_type_4
''                                                             write_e_type_4
''---------------------------------------------------------------------------------
'' e_type_5                                   [13:13]          get_e_type_5
''                                                             set_e_type_5
''                                                             read_e_type_5
''                                                             write_e_type_5
''---------------------------------------------------------------------------------
'' e_type_6                                   [14:14]          get_e_type_6
''                                                             set_e_type_6
''                                                             read_e_type_6
''                                                             write_e_type_6
''---------------------------------------------------------------------------------
'' e_type_7                                   [15:15]          get_e_type_7
''                                                             set_e_type_7
''                                                             read_e_type_7
''                                                             write_e_type_7
''---------------------------------------------------------------------------------
'' comb8                                      [16:16]          get_comb8
''                                                             set_comb8
''                                                             read_comb8
''                                                             write_comb8
''---------------------------------------------------------------------------------
'' comb9                                      [17:17]          get_comb9
''                                                             set_comb9
''                                                             read_comb9
''                                                             write_comb9
''---------------------------------------------------------------------------------
'' range                                      [18:18]          get_range
''                                                             set_range
''                                                             read_range
''                                                             write_range
''---------------------------------------------------------------------------------
'' const_44                                   [19:19]          get_const_44
''                                                             set_const_44
''                                                             read_const_44
''                                                             write_const_44
''---------------------------------------------------------------------------------
'' const_48                                   [20:20]          get_const_48
''                                                             set_const_48
''                                                             read_const_48
''                                                             write_const_48
''---------------------------------------------------------------------------------
'' MACSEC_KAY1                                [31:31]          get_MACSEC_KAY1
''                                                             set_MACSEC_KAY1
''                                                             read_MACSEC_KAY1
''                                                             write_MACSEC_KAY1
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_scp_mpls_match_debug
    Private write_mac_da_0_value
    Private read_mac_da_0_value
    Private flag_mac_da_0
    Private write_mac_da_1_value
    Private read_mac_da_1_value
    Private flag_mac_da_1
    Private write_mac_da_2_value
    Private read_mac_da_2_value
    Private flag_mac_da_2
    Private write_mac_da_3_value
    Private read_mac_da_3_value
    Private flag_mac_da_3
    Private write_mac_da_4_value
    Private read_mac_da_4_value
    Private flag_mac_da_4
    Private write_mac_da_5_value
    Private read_mac_da_5_value
    Private flag_mac_da_5
    Private write_mac_da_6_value
    Private read_mac_da_6_value
    Private flag_mac_da_6
    Private write_mac_da_7_value
    Private read_mac_da_7_value
    Private flag_mac_da_7
    Private write_e_type_0_value
    Private read_e_type_0_value
    Private flag_e_type_0
    Private write_e_type_1_value
    Private read_e_type_1_value
    Private flag_e_type_1
    Private write_e_type_2_value
    Private read_e_type_2_value
    Private flag_e_type_2
    Private write_e_type_3_value
    Private read_e_type_3_value
    Private flag_e_type_3
    Private write_e_type_4_value
    Private read_e_type_4_value
    Private flag_e_type_4
    Private write_e_type_5_value
    Private read_e_type_5_value
    Private flag_e_type_5
    Private write_e_type_6_value
    Private read_e_type_6_value
    Private flag_e_type_6
    Private write_e_type_7_value
    Private read_e_type_7_value
    Private flag_e_type_7
    Private write_comb8_value
    Private read_comb8_value
    Private flag_comb8
    Private write_comb9_value
    Private read_comb9_value
    Private flag_comb9
    Private write_range_value
    Private read_range_value
    Private flag_range
    Private write_const_44_value
    Private read_const_44_value
    Private flag_const_44
    Private write_const_48_value
    Private read_const_48_value
    Private flag_const_48
    Private write_MACSEC_KAY1_value
    Private read_MACSEC_KAY1_value
    Private flag_MACSEC_KAY1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_0
        get_mac_da_0 = read_mac_da_0_value
    End Property

    Property Let set_mac_da_0(aData)
        write_mac_da_0_value = aData
        flag_mac_da_0        = &H1
    End Property

    Property Get read_mac_da_0
        read
        read_mac_da_0 = read_mac_da_0_value
    End Property

    Property Let write_mac_da_0(aData)
        set_mac_da_0 = aData
        write
    End Property

    Property Get get_mac_da_1
        get_mac_da_1 = read_mac_da_1_value
    End Property

    Property Let set_mac_da_1(aData)
        write_mac_da_1_value = aData
        flag_mac_da_1        = &H1
    End Property

    Property Get read_mac_da_1
        read
        read_mac_da_1 = read_mac_da_1_value
    End Property

    Property Let write_mac_da_1(aData)
        set_mac_da_1 = aData
        write
    End Property

    Property Get get_mac_da_2
        get_mac_da_2 = read_mac_da_2_value
    End Property

    Property Let set_mac_da_2(aData)
        write_mac_da_2_value = aData
        flag_mac_da_2        = &H1
    End Property

    Property Get read_mac_da_2
        read
        read_mac_da_2 = read_mac_da_2_value
    End Property

    Property Let write_mac_da_2(aData)
        set_mac_da_2 = aData
        write
    End Property

    Property Get get_mac_da_3
        get_mac_da_3 = read_mac_da_3_value
    End Property

    Property Let set_mac_da_3(aData)
        write_mac_da_3_value = aData
        flag_mac_da_3        = &H1
    End Property

    Property Get read_mac_da_3
        read
        read_mac_da_3 = read_mac_da_3_value
    End Property

    Property Let write_mac_da_3(aData)
        set_mac_da_3 = aData
        write
    End Property

    Property Get get_mac_da_4
        get_mac_da_4 = read_mac_da_4_value
    End Property

    Property Let set_mac_da_4(aData)
        write_mac_da_4_value = aData
        flag_mac_da_4        = &H1
    End Property

    Property Get read_mac_da_4
        read
        read_mac_da_4 = read_mac_da_4_value
    End Property

    Property Let write_mac_da_4(aData)
        set_mac_da_4 = aData
        write
    End Property

    Property Get get_mac_da_5
        get_mac_da_5 = read_mac_da_5_value
    End Property

    Property Let set_mac_da_5(aData)
        write_mac_da_5_value = aData
        flag_mac_da_5        = &H1
    End Property

    Property Get read_mac_da_5
        read
        read_mac_da_5 = read_mac_da_5_value
    End Property

    Property Let write_mac_da_5(aData)
        set_mac_da_5 = aData
        write
    End Property

    Property Get get_mac_da_6
        get_mac_da_6 = read_mac_da_6_value
    End Property

    Property Let set_mac_da_6(aData)
        write_mac_da_6_value = aData
        flag_mac_da_6        = &H1
    End Property

    Property Get read_mac_da_6
        read
        read_mac_da_6 = read_mac_da_6_value
    End Property

    Property Let write_mac_da_6(aData)
        set_mac_da_6 = aData
        write
    End Property

    Property Get get_mac_da_7
        get_mac_da_7 = read_mac_da_7_value
    End Property

    Property Let set_mac_da_7(aData)
        write_mac_da_7_value = aData
        flag_mac_da_7        = &H1
    End Property

    Property Get read_mac_da_7
        read
        read_mac_da_7 = read_mac_da_7_value
    End Property

    Property Let write_mac_da_7(aData)
        set_mac_da_7 = aData
        write
    End Property

    Property Get get_e_type_0
        get_e_type_0 = read_e_type_0_value
    End Property

    Property Let set_e_type_0(aData)
        write_e_type_0_value = aData
        flag_e_type_0        = &H1
    End Property

    Property Get read_e_type_0
        read
        read_e_type_0 = read_e_type_0_value
    End Property

    Property Let write_e_type_0(aData)
        set_e_type_0 = aData
        write
    End Property

    Property Get get_e_type_1
        get_e_type_1 = read_e_type_1_value
    End Property

    Property Let set_e_type_1(aData)
        write_e_type_1_value = aData
        flag_e_type_1        = &H1
    End Property

    Property Get read_e_type_1
        read
        read_e_type_1 = read_e_type_1_value
    End Property

    Property Let write_e_type_1(aData)
        set_e_type_1 = aData
        write
    End Property

    Property Get get_e_type_2
        get_e_type_2 = read_e_type_2_value
    End Property

    Property Let set_e_type_2(aData)
        write_e_type_2_value = aData
        flag_e_type_2        = &H1
    End Property

    Property Get read_e_type_2
        read
        read_e_type_2 = read_e_type_2_value
    End Property

    Property Let write_e_type_2(aData)
        set_e_type_2 = aData
        write
    End Property

    Property Get get_e_type_3
        get_e_type_3 = read_e_type_3_value
    End Property

    Property Let set_e_type_3(aData)
        write_e_type_3_value = aData
        flag_e_type_3        = &H1
    End Property

    Property Get read_e_type_3
        read
        read_e_type_3 = read_e_type_3_value
    End Property

    Property Let write_e_type_3(aData)
        set_e_type_3 = aData
        write
    End Property

    Property Get get_e_type_4
        get_e_type_4 = read_e_type_4_value
    End Property

    Property Let set_e_type_4(aData)
        write_e_type_4_value = aData
        flag_e_type_4        = &H1
    End Property

    Property Get read_e_type_4
        read
        read_e_type_4 = read_e_type_4_value
    End Property

    Property Let write_e_type_4(aData)
        set_e_type_4 = aData
        write
    End Property

    Property Get get_e_type_5
        get_e_type_5 = read_e_type_5_value
    End Property

    Property Let set_e_type_5(aData)
        write_e_type_5_value = aData
        flag_e_type_5        = &H1
    End Property

    Property Get read_e_type_5
        read
        read_e_type_5 = read_e_type_5_value
    End Property

    Property Let write_e_type_5(aData)
        set_e_type_5 = aData
        write
    End Property

    Property Get get_e_type_6
        get_e_type_6 = read_e_type_6_value
    End Property

    Property Let set_e_type_6(aData)
        write_e_type_6_value = aData
        flag_e_type_6        = &H1
    End Property

    Property Get read_e_type_6
        read
        read_e_type_6 = read_e_type_6_value
    End Property

    Property Let write_e_type_6(aData)
        set_e_type_6 = aData
        write
    End Property

    Property Get get_e_type_7
        get_e_type_7 = read_e_type_7_value
    End Property

    Property Let set_e_type_7(aData)
        write_e_type_7_value = aData
        flag_e_type_7        = &H1
    End Property

    Property Get read_e_type_7
        read
        read_e_type_7 = read_e_type_7_value
    End Property

    Property Let write_e_type_7(aData)
        set_e_type_7 = aData
        write
    End Property

    Property Get get_comb8
        get_comb8 = read_comb8_value
    End Property

    Property Let set_comb8(aData)
        write_comb8_value = aData
        flag_comb8        = &H1
    End Property

    Property Get read_comb8
        read
        read_comb8 = read_comb8_value
    End Property

    Property Let write_comb8(aData)
        set_comb8 = aData
        write
    End Property

    Property Get get_comb9
        get_comb9 = read_comb9_value
    End Property

    Property Let set_comb9(aData)
        write_comb9_value = aData
        flag_comb9        = &H1
    End Property

    Property Get read_comb9
        read
        read_comb9 = read_comb9_value
    End Property

    Property Let write_comb9(aData)
        set_comb9 = aData
        write
    End Property

    Property Get get_range
        get_range = read_range_value
    End Property

    Property Let set_range(aData)
        write_range_value = aData
        flag_range        = &H1
    End Property

    Property Get read_range
        read
        read_range = read_range_value
    End Property

    Property Let write_range(aData)
        set_range = aData
        write
    End Property

    Property Get get_const_44
        get_const_44 = read_const_44_value
    End Property

    Property Let set_const_44(aData)
        write_const_44_value = aData
        flag_const_44        = &H1
    End Property

    Property Get read_const_44
        read
        read_const_44 = read_const_44_value
    End Property

    Property Let write_const_44(aData)
        set_const_44 = aData
        write
    End Property

    Property Get get_const_48
        get_const_48 = read_const_48_value
    End Property

    Property Let set_const_48(aData)
        write_const_48_value = aData
        flag_const_48        = &H1
    End Property

    Property Get read_const_48
        read
        read_const_48 = read_const_48_value
    End Property

    Property Let write_const_48(aData)
        set_const_48 = aData
        write
    End Property

    Property Get get_MACSEC_KAY1
        get_MACSEC_KAY1 = read_MACSEC_KAY1_value
    End Property

    Property Let set_MACSEC_KAY1(aData)
        write_MACSEC_KAY1_value = aData
        flag_MACSEC_KAY1        = &H1
    End Property

    Property Get read_MACSEC_KAY1
        read
        read_MACSEC_KAY1 = read_MACSEC_KAY1_value
    End Property

    Property Let write_MACSEC_KAY1(aData)
        set_MACSEC_KAY1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_0_mask = &H1
        if data_low > LONG_MAX then
            if mac_da_0_mask = mask then
                read_mac_da_0_value = data_low
            else
                read_mac_da_0_value = (data_low - H8000_0000) and mac_da_0_mask
            end If
        else
            read_mac_da_0_value = data_low and mac_da_0_mask
        end If
        read_mac_da_1_value = rightShift(data_low, 1) and &H1
        read_mac_da_2_value = rightShift(data_low, 2) and &H1
        read_mac_da_3_value = rightShift(data_low, 3) and &H1
        read_mac_da_4_value = rightShift(data_low, 4) and &H1
        read_mac_da_5_value = rightShift(data_low, 5) and &H1
        read_mac_da_6_value = rightShift(data_low, 6) and &H1
        read_mac_da_7_value = rightShift(data_low, 7) and &H1
        read_e_type_0_value = rightShift(data_low, 8) and &H1
        read_e_type_1_value = rightShift(data_low, 9) and &H1
        read_e_type_2_value = rightShift(data_low, 10) and &H1
        read_e_type_3_value = rightShift(data_low, 11) and &H1
        read_e_type_4_value = rightShift(data_low, 12) and &H1
        read_e_type_5_value = rightShift(data_low, 13) and &H1
        read_e_type_6_value = rightShift(data_low, 14) and &H1
        read_e_type_7_value = rightShift(data_low, 15) and &H1
        read_comb8_value = rightShift(data_low, 16) and &H1
        read_comb9_value = rightShift(data_low, 17) and &H1
        read_range_value = rightShift(data_low, 18) and &H1
        read_const_44_value = rightShift(data_low, 19) and &H1
        read_const_48_value = rightShift(data_low, 20) and &H1
        read_MACSEC_KAY1_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_mac_da_0 = &H0 or flag_mac_da_1 = &H0 or flag_mac_da_2 = &H0 or flag_mac_da_3 = &H0 or flag_mac_da_4 = &H0 or flag_mac_da_5 = &H0 or flag_mac_da_6 = &H0 or flag_mac_da_7 = &H0 or flag_e_type_0 = &H0 or flag_e_type_1 = &H0 or flag_e_type_2 = &H0 or flag_e_type_3 = &H0 or flag_e_type_4 = &H0 or flag_e_type_5 = &H0 or flag_e_type_6 = &H0 or flag_e_type_7 = &H0 or flag_comb8 = &H0 or flag_comb9 = &H0 or flag_range = &H0 or flag_const_44 = &H0 or flag_const_48 = &H0 or flag_MACSEC_KAY1 = &H0 Then read
        If flag_mac_da_0 = &H0 Then write_mac_da_0_value = get_mac_da_0
        If flag_mac_da_1 = &H0 Then write_mac_da_1_value = get_mac_da_1
        If flag_mac_da_2 = &H0 Then write_mac_da_2_value = get_mac_da_2
        If flag_mac_da_3 = &H0 Then write_mac_da_3_value = get_mac_da_3
        If flag_mac_da_4 = &H0 Then write_mac_da_4_value = get_mac_da_4
        If flag_mac_da_5 = &H0 Then write_mac_da_5_value = get_mac_da_5
        If flag_mac_da_6 = &H0 Then write_mac_da_6_value = get_mac_da_6
        If flag_mac_da_7 = &H0 Then write_mac_da_7_value = get_mac_da_7
        If flag_e_type_0 = &H0 Then write_e_type_0_value = get_e_type_0
        If flag_e_type_1 = &H0 Then write_e_type_1_value = get_e_type_1
        If flag_e_type_2 = &H0 Then write_e_type_2_value = get_e_type_2
        If flag_e_type_3 = &H0 Then write_e_type_3_value = get_e_type_3
        If flag_e_type_4 = &H0 Then write_e_type_4_value = get_e_type_4
        If flag_e_type_5 = &H0 Then write_e_type_5_value = get_e_type_5
        If flag_e_type_6 = &H0 Then write_e_type_6_value = get_e_type_6
        If flag_e_type_7 = &H0 Then write_e_type_7_value = get_e_type_7
        If flag_comb8 = &H0 Then write_comb8_value = get_comb8
        If flag_comb9 = &H0 Then write_comb9_value = get_comb9
        If flag_range = &H0 Then write_range_value = get_range
        If flag_const_44 = &H0 Then write_const_44_value = get_const_44
        If flag_const_48 = &H0 Then write_const_48_value = get_const_48
        If flag_MACSEC_KAY1 = &H0 Then write_MACSEC_KAY1_value = get_MACSEC_KAY1

        regValue = leftShift((write_mac_da_0_value and &H1), 0) + leftShift((write_mac_da_1_value and &H1), 1) + leftShift((write_mac_da_2_value and &H1), 2) + leftShift((write_mac_da_3_value and &H1), 3) + leftShift((write_mac_da_4_value and &H1), 4) + leftShift((write_mac_da_5_value and &H1), 5) + leftShift((write_mac_da_6_value and &H1), 6) + leftShift((write_mac_da_7_value and &H1), 7) + leftShift((write_e_type_0_value and &H1), 8) + leftShift((write_e_type_1_value and &H1), 9) + leftShift((write_e_type_2_value and &H1), 10) + leftShift((write_e_type_3_value and &H1), 11) + leftShift((write_e_type_4_value and &H1), 12) + leftShift((write_e_type_5_value and &H1), 13) + leftShift((write_e_type_6_value and &H1), 14) + leftShift((write_e_type_7_value and &H1), 15) + leftShift((write_comb8_value and &H1), 16) + leftShift((write_comb9_value and &H1), 17) + leftShift((write_range_value and &H1), 18) + leftShift((write_const_44_value and &H1), 19) + leftShift((write_const_48_value and &H1), 20) + leftShift((write_MACSEC_KAY1_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_0_mask = &H1
        if data_low > LONG_MAX then
            if mac_da_0_mask = mask then
                read_mac_da_0_value = data_low
            else
                read_mac_da_0_value = (data_low - H8000_0000) and mac_da_0_mask
            end If
        else
            read_mac_da_0_value = data_low and mac_da_0_mask
        end If
        read_mac_da_1_value = rightShift(data_low, 1) and &H1
        read_mac_da_2_value = rightShift(data_low, 2) and &H1
        read_mac_da_3_value = rightShift(data_low, 3) and &H1
        read_mac_da_4_value = rightShift(data_low, 4) and &H1
        read_mac_da_5_value = rightShift(data_low, 5) and &H1
        read_mac_da_6_value = rightShift(data_low, 6) and &H1
        read_mac_da_7_value = rightShift(data_low, 7) and &H1
        read_e_type_0_value = rightShift(data_low, 8) and &H1
        read_e_type_1_value = rightShift(data_low, 9) and &H1
        read_e_type_2_value = rightShift(data_low, 10) and &H1
        read_e_type_3_value = rightShift(data_low, 11) and &H1
        read_e_type_4_value = rightShift(data_low, 12) and &H1
        read_e_type_5_value = rightShift(data_low, 13) and &H1
        read_e_type_6_value = rightShift(data_low, 14) and &H1
        read_e_type_7_value = rightShift(data_low, 15) and &H1
        read_comb8_value = rightShift(data_low, 16) and &H1
        read_comb9_value = rightShift(data_low, 17) and &H1
        read_range_value = rightShift(data_low, 18) and &H1
        read_const_44_value = rightShift(data_low, 19) and &H1
        read_const_48_value = rightShift(data_low, 20) and &H1
        read_MACSEC_KAY1_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_0_value = &H0
        flag_mac_da_0        = &H0
        write_mac_da_1_value = &H0
        flag_mac_da_1        = &H0
        write_mac_da_2_value = &H0
        flag_mac_da_2        = &H0
        write_mac_da_3_value = &H0
        flag_mac_da_3        = &H0
        write_mac_da_4_value = &H0
        flag_mac_da_4        = &H0
        write_mac_da_5_value = &H0
        flag_mac_da_5        = &H0
        write_mac_da_6_value = &H0
        flag_mac_da_6        = &H0
        write_mac_da_7_value = &H0
        flag_mac_da_7        = &H0
        write_e_type_0_value = &H0
        flag_e_type_0        = &H0
        write_e_type_1_value = &H0
        flag_e_type_1        = &H0
        write_e_type_2_value = &H0
        flag_e_type_2        = &H0
        write_e_type_3_value = &H0
        flag_e_type_3        = &H0
        write_e_type_4_value = &H0
        flag_e_type_4        = &H0
        write_e_type_5_value = &H0
        flag_e_type_5        = &H0
        write_e_type_6_value = &H0
        flag_e_type_6        = &H0
        write_e_type_7_value = &H0
        flag_e_type_7        = &H0
        write_comb8_value = &H0
        flag_comb8        = &H0
        write_comb9_value = &H0
        flag_comb9        = &H0
        write_range_value = &H0
        flag_range        = &H0
        write_const_44_value = &H0
        flag_const_44        = &H0
        write_const_48_value = &H0
        flag_const_48        = &H0
        write_MACSEC_KAY1_value = &H0
        flag_MACSEC_KAY1        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_scp_pbb_match_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_0                                   [0:0]            get_mac_da_0
''                                                             set_mac_da_0
''                                                             read_mac_da_0
''                                                             write_mac_da_0
''---------------------------------------------------------------------------------
'' mac_da_1                                   [1:1]            get_mac_da_1
''                                                             set_mac_da_1
''                                                             read_mac_da_1
''                                                             write_mac_da_1
''---------------------------------------------------------------------------------
'' mac_da_2                                   [2:2]            get_mac_da_2
''                                                             set_mac_da_2
''                                                             read_mac_da_2
''                                                             write_mac_da_2
''---------------------------------------------------------------------------------
'' mac_da_3                                   [3:3]            get_mac_da_3
''                                                             set_mac_da_3
''                                                             read_mac_da_3
''                                                             write_mac_da_3
''---------------------------------------------------------------------------------
'' mac_da_4                                   [4:4]            get_mac_da_4
''                                                             set_mac_da_4
''                                                             read_mac_da_4
''                                                             write_mac_da_4
''---------------------------------------------------------------------------------
'' mac_da_5                                   [5:5]            get_mac_da_5
''                                                             set_mac_da_5
''                                                             read_mac_da_5
''                                                             write_mac_da_5
''---------------------------------------------------------------------------------
'' mac_da_6                                   [6:6]            get_mac_da_6
''                                                             set_mac_da_6
''                                                             read_mac_da_6
''                                                             write_mac_da_6
''---------------------------------------------------------------------------------
'' mac_da_7                                   [7:7]            get_mac_da_7
''                                                             set_mac_da_7
''                                                             read_mac_da_7
''                                                             write_mac_da_7
''---------------------------------------------------------------------------------
'' e_type_0                                   [8:8]            get_e_type_0
''                                                             set_e_type_0
''                                                             read_e_type_0
''                                                             write_e_type_0
''---------------------------------------------------------------------------------
'' e_type_1                                   [9:9]            get_e_type_1
''                                                             set_e_type_1
''                                                             read_e_type_1
''                                                             write_e_type_1
''---------------------------------------------------------------------------------
'' e_type_2                                   [10:10]          get_e_type_2
''                                                             set_e_type_2
''                                                             read_e_type_2
''                                                             write_e_type_2
''---------------------------------------------------------------------------------
'' e_type_3                                   [11:11]          get_e_type_3
''                                                             set_e_type_3
''                                                             read_e_type_3
''                                                             write_e_type_3
''---------------------------------------------------------------------------------
'' e_type_4                                   [12:12]          get_e_type_4
''                                                             set_e_type_4
''                                                             read_e_type_4
''                                                             write_e_type_4
''---------------------------------------------------------------------------------
'' e_type_5                                   [13:13]          get_e_type_5
''                                                             set_e_type_5
''                                                             read_e_type_5
''                                                             write_e_type_5
''---------------------------------------------------------------------------------
'' e_type_6                                   [14:14]          get_e_type_6
''                                                             set_e_type_6
''                                                             read_e_type_6
''                                                             write_e_type_6
''---------------------------------------------------------------------------------
'' e_type_7                                   [15:15]          get_e_type_7
''                                                             set_e_type_7
''                                                             read_e_type_7
''                                                             write_e_type_7
''---------------------------------------------------------------------------------
'' comb8                                      [16:16]          get_comb8
''                                                             set_comb8
''                                                             read_comb8
''                                                             write_comb8
''---------------------------------------------------------------------------------
'' comb9                                      [17:17]          get_comb9
''                                                             set_comb9
''                                                             read_comb9
''                                                             write_comb9
''---------------------------------------------------------------------------------
'' range                                      [18:18]          get_range
''                                                             set_range
''                                                             read_range
''                                                             write_range
''---------------------------------------------------------------------------------
'' const_44                                   [19:19]          get_const_44
''                                                             set_const_44
''                                                             read_const_44
''                                                             write_const_44
''---------------------------------------------------------------------------------
'' const_48                                   [20:20]          get_const_48
''                                                             set_const_48
''                                                             read_const_48
''                                                             write_const_48
''---------------------------------------------------------------------------------
'' MACSEC_KAY2                                [31:31]          get_MACSEC_KAY2
''                                                             set_MACSEC_KAY2
''                                                             read_MACSEC_KAY2
''                                                             write_MACSEC_KAY2
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_scp_pbb_match_debug
    Private write_mac_da_0_value
    Private read_mac_da_0_value
    Private flag_mac_da_0
    Private write_mac_da_1_value
    Private read_mac_da_1_value
    Private flag_mac_da_1
    Private write_mac_da_2_value
    Private read_mac_da_2_value
    Private flag_mac_da_2
    Private write_mac_da_3_value
    Private read_mac_da_3_value
    Private flag_mac_da_3
    Private write_mac_da_4_value
    Private read_mac_da_4_value
    Private flag_mac_da_4
    Private write_mac_da_5_value
    Private read_mac_da_5_value
    Private flag_mac_da_5
    Private write_mac_da_6_value
    Private read_mac_da_6_value
    Private flag_mac_da_6
    Private write_mac_da_7_value
    Private read_mac_da_7_value
    Private flag_mac_da_7
    Private write_e_type_0_value
    Private read_e_type_0_value
    Private flag_e_type_0
    Private write_e_type_1_value
    Private read_e_type_1_value
    Private flag_e_type_1
    Private write_e_type_2_value
    Private read_e_type_2_value
    Private flag_e_type_2
    Private write_e_type_3_value
    Private read_e_type_3_value
    Private flag_e_type_3
    Private write_e_type_4_value
    Private read_e_type_4_value
    Private flag_e_type_4
    Private write_e_type_5_value
    Private read_e_type_5_value
    Private flag_e_type_5
    Private write_e_type_6_value
    Private read_e_type_6_value
    Private flag_e_type_6
    Private write_e_type_7_value
    Private read_e_type_7_value
    Private flag_e_type_7
    Private write_comb8_value
    Private read_comb8_value
    Private flag_comb8
    Private write_comb9_value
    Private read_comb9_value
    Private flag_comb9
    Private write_range_value
    Private read_range_value
    Private flag_range
    Private write_const_44_value
    Private read_const_44_value
    Private flag_const_44
    Private write_const_48_value
    Private read_const_48_value
    Private flag_const_48
    Private write_MACSEC_KAY2_value
    Private read_MACSEC_KAY2_value
    Private flag_MACSEC_KAY2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_0
        get_mac_da_0 = read_mac_da_0_value
    End Property

    Property Let set_mac_da_0(aData)
        write_mac_da_0_value = aData
        flag_mac_da_0        = &H1
    End Property

    Property Get read_mac_da_0
        read
        read_mac_da_0 = read_mac_da_0_value
    End Property

    Property Let write_mac_da_0(aData)
        set_mac_da_0 = aData
        write
    End Property

    Property Get get_mac_da_1
        get_mac_da_1 = read_mac_da_1_value
    End Property

    Property Let set_mac_da_1(aData)
        write_mac_da_1_value = aData
        flag_mac_da_1        = &H1
    End Property

    Property Get read_mac_da_1
        read
        read_mac_da_1 = read_mac_da_1_value
    End Property

    Property Let write_mac_da_1(aData)
        set_mac_da_1 = aData
        write
    End Property

    Property Get get_mac_da_2
        get_mac_da_2 = read_mac_da_2_value
    End Property

    Property Let set_mac_da_2(aData)
        write_mac_da_2_value = aData
        flag_mac_da_2        = &H1
    End Property

    Property Get read_mac_da_2
        read
        read_mac_da_2 = read_mac_da_2_value
    End Property

    Property Let write_mac_da_2(aData)
        set_mac_da_2 = aData
        write
    End Property

    Property Get get_mac_da_3
        get_mac_da_3 = read_mac_da_3_value
    End Property

    Property Let set_mac_da_3(aData)
        write_mac_da_3_value = aData
        flag_mac_da_3        = &H1
    End Property

    Property Get read_mac_da_3
        read
        read_mac_da_3 = read_mac_da_3_value
    End Property

    Property Let write_mac_da_3(aData)
        set_mac_da_3 = aData
        write
    End Property

    Property Get get_mac_da_4
        get_mac_da_4 = read_mac_da_4_value
    End Property

    Property Let set_mac_da_4(aData)
        write_mac_da_4_value = aData
        flag_mac_da_4        = &H1
    End Property

    Property Get read_mac_da_4
        read
        read_mac_da_4 = read_mac_da_4_value
    End Property

    Property Let write_mac_da_4(aData)
        set_mac_da_4 = aData
        write
    End Property

    Property Get get_mac_da_5
        get_mac_da_5 = read_mac_da_5_value
    End Property

    Property Let set_mac_da_5(aData)
        write_mac_da_5_value = aData
        flag_mac_da_5        = &H1
    End Property

    Property Get read_mac_da_5
        read
        read_mac_da_5 = read_mac_da_5_value
    End Property

    Property Let write_mac_da_5(aData)
        set_mac_da_5 = aData
        write
    End Property

    Property Get get_mac_da_6
        get_mac_da_6 = read_mac_da_6_value
    End Property

    Property Let set_mac_da_6(aData)
        write_mac_da_6_value = aData
        flag_mac_da_6        = &H1
    End Property

    Property Get read_mac_da_6
        read
        read_mac_da_6 = read_mac_da_6_value
    End Property

    Property Let write_mac_da_6(aData)
        set_mac_da_6 = aData
        write
    End Property

    Property Get get_mac_da_7
        get_mac_da_7 = read_mac_da_7_value
    End Property

    Property Let set_mac_da_7(aData)
        write_mac_da_7_value = aData
        flag_mac_da_7        = &H1
    End Property

    Property Get read_mac_da_7
        read
        read_mac_da_7 = read_mac_da_7_value
    End Property

    Property Let write_mac_da_7(aData)
        set_mac_da_7 = aData
        write
    End Property

    Property Get get_e_type_0
        get_e_type_0 = read_e_type_0_value
    End Property

    Property Let set_e_type_0(aData)
        write_e_type_0_value = aData
        flag_e_type_0        = &H1
    End Property

    Property Get read_e_type_0
        read
        read_e_type_0 = read_e_type_0_value
    End Property

    Property Let write_e_type_0(aData)
        set_e_type_0 = aData
        write
    End Property

    Property Get get_e_type_1
        get_e_type_1 = read_e_type_1_value
    End Property

    Property Let set_e_type_1(aData)
        write_e_type_1_value = aData
        flag_e_type_1        = &H1
    End Property

    Property Get read_e_type_1
        read
        read_e_type_1 = read_e_type_1_value
    End Property

    Property Let write_e_type_1(aData)
        set_e_type_1 = aData
        write
    End Property

    Property Get get_e_type_2
        get_e_type_2 = read_e_type_2_value
    End Property

    Property Let set_e_type_2(aData)
        write_e_type_2_value = aData
        flag_e_type_2        = &H1
    End Property

    Property Get read_e_type_2
        read
        read_e_type_2 = read_e_type_2_value
    End Property

    Property Let write_e_type_2(aData)
        set_e_type_2 = aData
        write
    End Property

    Property Get get_e_type_3
        get_e_type_3 = read_e_type_3_value
    End Property

    Property Let set_e_type_3(aData)
        write_e_type_3_value = aData
        flag_e_type_3        = &H1
    End Property

    Property Get read_e_type_3
        read
        read_e_type_3 = read_e_type_3_value
    End Property

    Property Let write_e_type_3(aData)
        set_e_type_3 = aData
        write
    End Property

    Property Get get_e_type_4
        get_e_type_4 = read_e_type_4_value
    End Property

    Property Let set_e_type_4(aData)
        write_e_type_4_value = aData
        flag_e_type_4        = &H1
    End Property

    Property Get read_e_type_4
        read
        read_e_type_4 = read_e_type_4_value
    End Property

    Property Let write_e_type_4(aData)
        set_e_type_4 = aData
        write
    End Property

    Property Get get_e_type_5
        get_e_type_5 = read_e_type_5_value
    End Property

    Property Let set_e_type_5(aData)
        write_e_type_5_value = aData
        flag_e_type_5        = &H1
    End Property

    Property Get read_e_type_5
        read
        read_e_type_5 = read_e_type_5_value
    End Property

    Property Let write_e_type_5(aData)
        set_e_type_5 = aData
        write
    End Property

    Property Get get_e_type_6
        get_e_type_6 = read_e_type_6_value
    End Property

    Property Let set_e_type_6(aData)
        write_e_type_6_value = aData
        flag_e_type_6        = &H1
    End Property

    Property Get read_e_type_6
        read
        read_e_type_6 = read_e_type_6_value
    End Property

    Property Let write_e_type_6(aData)
        set_e_type_6 = aData
        write
    End Property

    Property Get get_e_type_7
        get_e_type_7 = read_e_type_7_value
    End Property

    Property Let set_e_type_7(aData)
        write_e_type_7_value = aData
        flag_e_type_7        = &H1
    End Property

    Property Get read_e_type_7
        read
        read_e_type_7 = read_e_type_7_value
    End Property

    Property Let write_e_type_7(aData)
        set_e_type_7 = aData
        write
    End Property

    Property Get get_comb8
        get_comb8 = read_comb8_value
    End Property

    Property Let set_comb8(aData)
        write_comb8_value = aData
        flag_comb8        = &H1
    End Property

    Property Get read_comb8
        read
        read_comb8 = read_comb8_value
    End Property

    Property Let write_comb8(aData)
        set_comb8 = aData
        write
    End Property

    Property Get get_comb9
        get_comb9 = read_comb9_value
    End Property

    Property Let set_comb9(aData)
        write_comb9_value = aData
        flag_comb9        = &H1
    End Property

    Property Get read_comb9
        read
        read_comb9 = read_comb9_value
    End Property

    Property Let write_comb9(aData)
        set_comb9 = aData
        write
    End Property

    Property Get get_range
        get_range = read_range_value
    End Property

    Property Let set_range(aData)
        write_range_value = aData
        flag_range        = &H1
    End Property

    Property Get read_range
        read
        read_range = read_range_value
    End Property

    Property Let write_range(aData)
        set_range = aData
        write
    End Property

    Property Get get_const_44
        get_const_44 = read_const_44_value
    End Property

    Property Let set_const_44(aData)
        write_const_44_value = aData
        flag_const_44        = &H1
    End Property

    Property Get read_const_44
        read
        read_const_44 = read_const_44_value
    End Property

    Property Let write_const_44(aData)
        set_const_44 = aData
        write
    End Property

    Property Get get_const_48
        get_const_48 = read_const_48_value
    End Property

    Property Let set_const_48(aData)
        write_const_48_value = aData
        flag_const_48        = &H1
    End Property

    Property Get read_const_48
        read
        read_const_48 = read_const_48_value
    End Property

    Property Let write_const_48(aData)
        set_const_48 = aData
        write
    End Property

    Property Get get_MACSEC_KAY2
        get_MACSEC_KAY2 = read_MACSEC_KAY2_value
    End Property

    Property Let set_MACSEC_KAY2(aData)
        write_MACSEC_KAY2_value = aData
        flag_MACSEC_KAY2        = &H1
    End Property

    Property Get read_MACSEC_KAY2
        read
        read_MACSEC_KAY2 = read_MACSEC_KAY2_value
    End Property

    Property Let write_MACSEC_KAY2(aData)
        set_MACSEC_KAY2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_0_mask = &H1
        if data_low > LONG_MAX then
            if mac_da_0_mask = mask then
                read_mac_da_0_value = data_low
            else
                read_mac_da_0_value = (data_low - H8000_0000) and mac_da_0_mask
            end If
        else
            read_mac_da_0_value = data_low and mac_da_0_mask
        end If
        read_mac_da_1_value = rightShift(data_low, 1) and &H1
        read_mac_da_2_value = rightShift(data_low, 2) and &H1
        read_mac_da_3_value = rightShift(data_low, 3) and &H1
        read_mac_da_4_value = rightShift(data_low, 4) and &H1
        read_mac_da_5_value = rightShift(data_low, 5) and &H1
        read_mac_da_6_value = rightShift(data_low, 6) and &H1
        read_mac_da_7_value = rightShift(data_low, 7) and &H1
        read_e_type_0_value = rightShift(data_low, 8) and &H1
        read_e_type_1_value = rightShift(data_low, 9) and &H1
        read_e_type_2_value = rightShift(data_low, 10) and &H1
        read_e_type_3_value = rightShift(data_low, 11) and &H1
        read_e_type_4_value = rightShift(data_low, 12) and &H1
        read_e_type_5_value = rightShift(data_low, 13) and &H1
        read_e_type_6_value = rightShift(data_low, 14) and &H1
        read_e_type_7_value = rightShift(data_low, 15) and &H1
        read_comb8_value = rightShift(data_low, 16) and &H1
        read_comb9_value = rightShift(data_low, 17) and &H1
        read_range_value = rightShift(data_low, 18) and &H1
        read_const_44_value = rightShift(data_low, 19) and &H1
        read_const_48_value = rightShift(data_low, 20) and &H1
        read_MACSEC_KAY2_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_mac_da_0 = &H0 or flag_mac_da_1 = &H0 or flag_mac_da_2 = &H0 or flag_mac_da_3 = &H0 or flag_mac_da_4 = &H0 or flag_mac_da_5 = &H0 or flag_mac_da_6 = &H0 or flag_mac_da_7 = &H0 or flag_e_type_0 = &H0 or flag_e_type_1 = &H0 or flag_e_type_2 = &H0 or flag_e_type_3 = &H0 or flag_e_type_4 = &H0 or flag_e_type_5 = &H0 or flag_e_type_6 = &H0 or flag_e_type_7 = &H0 or flag_comb8 = &H0 or flag_comb9 = &H0 or flag_range = &H0 or flag_const_44 = &H0 or flag_const_48 = &H0 or flag_MACSEC_KAY2 = &H0 Then read
        If flag_mac_da_0 = &H0 Then write_mac_da_0_value = get_mac_da_0
        If flag_mac_da_1 = &H0 Then write_mac_da_1_value = get_mac_da_1
        If flag_mac_da_2 = &H0 Then write_mac_da_2_value = get_mac_da_2
        If flag_mac_da_3 = &H0 Then write_mac_da_3_value = get_mac_da_3
        If flag_mac_da_4 = &H0 Then write_mac_da_4_value = get_mac_da_4
        If flag_mac_da_5 = &H0 Then write_mac_da_5_value = get_mac_da_5
        If flag_mac_da_6 = &H0 Then write_mac_da_6_value = get_mac_da_6
        If flag_mac_da_7 = &H0 Then write_mac_da_7_value = get_mac_da_7
        If flag_e_type_0 = &H0 Then write_e_type_0_value = get_e_type_0
        If flag_e_type_1 = &H0 Then write_e_type_1_value = get_e_type_1
        If flag_e_type_2 = &H0 Then write_e_type_2_value = get_e_type_2
        If flag_e_type_3 = &H0 Then write_e_type_3_value = get_e_type_3
        If flag_e_type_4 = &H0 Then write_e_type_4_value = get_e_type_4
        If flag_e_type_5 = &H0 Then write_e_type_5_value = get_e_type_5
        If flag_e_type_6 = &H0 Then write_e_type_6_value = get_e_type_6
        If flag_e_type_7 = &H0 Then write_e_type_7_value = get_e_type_7
        If flag_comb8 = &H0 Then write_comb8_value = get_comb8
        If flag_comb9 = &H0 Then write_comb9_value = get_comb9
        If flag_range = &H0 Then write_range_value = get_range
        If flag_const_44 = &H0 Then write_const_44_value = get_const_44
        If flag_const_48 = &H0 Then write_const_48_value = get_const_48
        If flag_MACSEC_KAY2 = &H0 Then write_MACSEC_KAY2_value = get_MACSEC_KAY2

        regValue = leftShift((write_mac_da_0_value and &H1), 0) + leftShift((write_mac_da_1_value and &H1), 1) + leftShift((write_mac_da_2_value and &H1), 2) + leftShift((write_mac_da_3_value and &H1), 3) + leftShift((write_mac_da_4_value and &H1), 4) + leftShift((write_mac_da_5_value and &H1), 5) + leftShift((write_mac_da_6_value and &H1), 6) + leftShift((write_mac_da_7_value and &H1), 7) + leftShift((write_e_type_0_value and &H1), 8) + leftShift((write_e_type_1_value and &H1), 9) + leftShift((write_e_type_2_value and &H1), 10) + leftShift((write_e_type_3_value and &H1), 11) + leftShift((write_e_type_4_value and &H1), 12) + leftShift((write_e_type_5_value and &H1), 13) + leftShift((write_e_type_6_value and &H1), 14) + leftShift((write_e_type_7_value and &H1), 15) + leftShift((write_comb8_value and &H1), 16) + leftShift((write_comb9_value and &H1), 17) + leftShift((write_range_value and &H1), 18) + leftShift((write_const_44_value and &H1), 19) + leftShift((write_const_48_value and &H1), 20) + leftShift((write_MACSEC_KAY2_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_0_mask = &H1
        if data_low > LONG_MAX then
            if mac_da_0_mask = mask then
                read_mac_da_0_value = data_low
            else
                read_mac_da_0_value = (data_low - H8000_0000) and mac_da_0_mask
            end If
        else
            read_mac_da_0_value = data_low and mac_da_0_mask
        end If
        read_mac_da_1_value = rightShift(data_low, 1) and &H1
        read_mac_da_2_value = rightShift(data_low, 2) and &H1
        read_mac_da_3_value = rightShift(data_low, 3) and &H1
        read_mac_da_4_value = rightShift(data_low, 4) and &H1
        read_mac_da_5_value = rightShift(data_low, 5) and &H1
        read_mac_da_6_value = rightShift(data_low, 6) and &H1
        read_mac_da_7_value = rightShift(data_low, 7) and &H1
        read_e_type_0_value = rightShift(data_low, 8) and &H1
        read_e_type_1_value = rightShift(data_low, 9) and &H1
        read_e_type_2_value = rightShift(data_low, 10) and &H1
        read_e_type_3_value = rightShift(data_low, 11) and &H1
        read_e_type_4_value = rightShift(data_low, 12) and &H1
        read_e_type_5_value = rightShift(data_low, 13) and &H1
        read_e_type_6_value = rightShift(data_low, 14) and &H1
        read_e_type_7_value = rightShift(data_low, 15) and &H1
        read_comb8_value = rightShift(data_low, 16) and &H1
        read_comb9_value = rightShift(data_low, 17) and &H1
        read_range_value = rightShift(data_low, 18) and &H1
        read_const_44_value = rightShift(data_low, 19) and &H1
        read_const_48_value = rightShift(data_low, 20) and &H1
        read_MACSEC_KAY2_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_0_value = &H0
        flag_mac_da_0        = &H0
        write_mac_da_1_value = &H0
        flag_mac_da_1        = &H0
        write_mac_da_2_value = &H0
        flag_mac_da_2        = &H0
        write_mac_da_3_value = &H0
        flag_mac_da_3        = &H0
        write_mac_da_4_value = &H0
        flag_mac_da_4        = &H0
        write_mac_da_5_value = &H0
        flag_mac_da_5        = &H0
        write_mac_da_6_value = &H0
        flag_mac_da_6        = &H0
        write_mac_da_7_value = &H0
        flag_mac_da_7        = &H0
        write_e_type_0_value = &H0
        flag_e_type_0        = &H0
        write_e_type_1_value = &H0
        flag_e_type_1        = &H0
        write_e_type_2_value = &H0
        flag_e_type_2        = &H0
        write_e_type_3_value = &H0
        flag_e_type_3        = &H0
        write_e_type_4_value = &H0
        flag_e_type_4        = &H0
        write_e_type_5_value = &H0
        flag_e_type_5        = &H0
        write_e_type_6_value = &H0
        flag_e_type_6        = &H0
        write_e_type_7_value = &H0
        flag_e_type_7        = &H0
        write_comb8_value = &H0
        flag_comb8        = &H0
        write_comb9_value = &H0
        flag_comb9        = &H0
        write_range_value = &H0
        flag_range        = &H0
        write_const_44_value = &H0
        flag_const_44        = &H0
        write_const_48_value = &H0
        flag_const_48        = &H0
        write_MACSEC_KAY2_value = &H0
        flag_MACSEC_KAY2        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_NR                                      [4:0]            get_SA_NR
''                                                             set_SA_NR
''                                                             read_SA_NR
''                                                             write_SA_NR
''---------------------------------------------------------------------------------
'' RULE_NR                                    [20:16]          get_RULE_NR
''                                                             set_RULE_NR
''                                                             read_RULE_NR
''                                                             write_RULE_NR
''---------------------------------------------------------------------------------
'' SOURCE_PORT                                [25:25]          get_SOURCE_PORT
''                                                             set_SOURCE_PORT
''                                                             read_SOURCE_PORT
''                                                             write_SOURCE_PORT
''---------------------------------------------------------------------------------
'' MACSEC_CLASS                               [27:26]          get_MACSEC_CLASS
''                                                             set_MACSEC_CLASS
''                                                             read_MACSEC_CLASS
''                                                             write_MACSEC_CLASS
''---------------------------------------------------------------------------------
'' CONT_PACK                                  [28:28]          get_CONT_PACK
''                                                             set_CONT_PACK
''                                                             read_CONT_PACK
''                                                             write_CONT_PACK
''---------------------------------------------------------------------------------
'' RULE_HIT                                   [29:29]          get_RULE_HIT
''                                                             set_RULE_HIT
''                                                             read_RULE_HIT
''                                                             write_RULE_HIT
''---------------------------------------------------------------------------------
'' SA_HIT                                     [30:30]          get_SA_HIT
''                                                             set_SA_HIT
''                                                             read_SA_HIT
''                                                             write_SA_HIT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_debug
    Private write_SA_NR_value
    Private read_SA_NR_value
    Private flag_SA_NR
    Private write_RULE_NR_value
    Private read_RULE_NR_value
    Private flag_RULE_NR
    Private write_SOURCE_PORT_value
    Private read_SOURCE_PORT_value
    Private flag_SOURCE_PORT
    Private write_MACSEC_CLASS_value
    Private read_MACSEC_CLASS_value
    Private flag_MACSEC_CLASS
    Private write_CONT_PACK_value
    Private read_CONT_PACK_value
    Private flag_CONT_PACK
    Private write_RULE_HIT_value
    Private read_RULE_HIT_value
    Private flag_RULE_HIT
    Private write_SA_HIT_value
    Private read_SA_HIT_value
    Private flag_SA_HIT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_NR
        get_SA_NR = read_SA_NR_value
    End Property

    Property Let set_SA_NR(aData)
        write_SA_NR_value = aData
        flag_SA_NR        = &H1
    End Property

    Property Get read_SA_NR
        read
        read_SA_NR = read_SA_NR_value
    End Property

    Property Let write_SA_NR(aData)
        set_SA_NR = aData
        write
    End Property

    Property Get get_RULE_NR
        get_RULE_NR = read_RULE_NR_value
    End Property

    Property Let set_RULE_NR(aData)
        write_RULE_NR_value = aData
        flag_RULE_NR        = &H1
    End Property

    Property Get read_RULE_NR
        read
        read_RULE_NR = read_RULE_NR_value
    End Property

    Property Let write_RULE_NR(aData)
        set_RULE_NR = aData
        write
    End Property

    Property Get get_SOURCE_PORT
        get_SOURCE_PORT = read_SOURCE_PORT_value
    End Property

    Property Let set_SOURCE_PORT(aData)
        write_SOURCE_PORT_value = aData
        flag_SOURCE_PORT        = &H1
    End Property

    Property Get read_SOURCE_PORT
        read
        read_SOURCE_PORT = read_SOURCE_PORT_value
    End Property

    Property Let write_SOURCE_PORT(aData)
        set_SOURCE_PORT = aData
        write
    End Property

    Property Get get_MACSEC_CLASS
        get_MACSEC_CLASS = read_MACSEC_CLASS_value
    End Property

    Property Let set_MACSEC_CLASS(aData)
        write_MACSEC_CLASS_value = aData
        flag_MACSEC_CLASS        = &H1
    End Property

    Property Get read_MACSEC_CLASS
        read
        read_MACSEC_CLASS = read_MACSEC_CLASS_value
    End Property

    Property Let write_MACSEC_CLASS(aData)
        set_MACSEC_CLASS = aData
        write
    End Property

    Property Get get_CONT_PACK
        get_CONT_PACK = read_CONT_PACK_value
    End Property

    Property Let set_CONT_PACK(aData)
        write_CONT_PACK_value = aData
        flag_CONT_PACK        = &H1
    End Property

    Property Get read_CONT_PACK
        read
        read_CONT_PACK = read_CONT_PACK_value
    End Property

    Property Let write_CONT_PACK(aData)
        set_CONT_PACK = aData
        write
    End Property

    Property Get get_RULE_HIT
        get_RULE_HIT = read_RULE_HIT_value
    End Property

    Property Let set_RULE_HIT(aData)
        write_RULE_HIT_value = aData
        flag_RULE_HIT        = &H1
    End Property

    Property Get read_RULE_HIT
        read
        read_RULE_HIT = read_RULE_HIT_value
    End Property

    Property Let write_RULE_HIT(aData)
        set_RULE_HIT = aData
        write
    End Property

    Property Get get_SA_HIT
        get_SA_HIT = read_SA_HIT_value
    End Property

    Property Let set_SA_HIT(aData)
        write_SA_HIT_value = aData
        flag_SA_HIT        = &H1
    End Property

    Property Get read_SA_HIT
        read
        read_SA_HIT = read_SA_HIT_value
    End Property

    Property Let write_SA_HIT(aData)
        set_SA_HIT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_NR_mask = &H1f
        if data_low > LONG_MAX then
            if SA_NR_mask = mask then
                read_SA_NR_value = data_low
            else
                read_SA_NR_value = (data_low - H8000_0000) and SA_NR_mask
            end If
        else
            read_SA_NR_value = data_low and SA_NR_mask
        end If
        read_RULE_NR_value = rightShift(data_low, 16) and &H1f
        read_SOURCE_PORT_value = rightShift(data_low, 25) and &H1
        read_MACSEC_CLASS_value = rightShift(data_low, 26) and &H3
        read_CONT_PACK_value = rightShift(data_low, 28) and &H1
        read_RULE_HIT_value = rightShift(data_low, 29) and &H1
        read_SA_HIT_value = rightShift(data_low, 30) and &H1

    End Sub

    Sub write
        If flag_SA_NR = &H0 or flag_RULE_NR = &H0 or flag_SOURCE_PORT = &H0 or flag_MACSEC_CLASS = &H0 or flag_CONT_PACK = &H0 or flag_RULE_HIT = &H0 or flag_SA_HIT = &H0 Then read
        If flag_SA_NR = &H0 Then write_SA_NR_value = get_SA_NR
        If flag_RULE_NR = &H0 Then write_RULE_NR_value = get_RULE_NR
        If flag_SOURCE_PORT = &H0 Then write_SOURCE_PORT_value = get_SOURCE_PORT
        If flag_MACSEC_CLASS = &H0 Then write_MACSEC_CLASS_value = get_MACSEC_CLASS
        If flag_CONT_PACK = &H0 Then write_CONT_PACK_value = get_CONT_PACK
        If flag_RULE_HIT = &H0 Then write_RULE_HIT_value = get_RULE_HIT
        If flag_SA_HIT = &H0 Then write_SA_HIT_value = get_SA_HIT

        regValue = leftShift((write_SA_NR_value and &H1f), 0) + leftShift((write_RULE_NR_value and &H1f), 16) + leftShift((write_SOURCE_PORT_value and &H1), 25) + leftShift((write_MACSEC_CLASS_value and &H3), 26) + leftShift((write_CONT_PACK_value and &H1), 28) + leftShift((write_RULE_HIT_value and &H1), 29) + leftShift((write_SA_HIT_value and &H1), 30)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_NR_mask = &H1f
        if data_low > LONG_MAX then
            if SA_NR_mask = mask then
                read_SA_NR_value = data_low
            else
                read_SA_NR_value = (data_low - H8000_0000) and SA_NR_mask
            end If
        else
            read_SA_NR_value = data_low and SA_NR_mask
        end If
        read_RULE_NR_value = rightShift(data_low, 16) and &H1f
        read_SOURCE_PORT_value = rightShift(data_low, 25) and &H1
        read_MACSEC_CLASS_value = rightShift(data_low, 26) and &H3
        read_CONT_PACK_value = rightShift(data_low, 28) and &H1
        read_RULE_HIT_value = rightShift(data_low, 29) and &H1
        read_SA_HIT_value = rightShift(data_low, 30) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_NR_value = &H0
        flag_SA_NR        = &H0
        write_RULE_NR_value = &H0
        flag_RULE_NR        = &H0
        write_SOURCE_PORT_value = &H0
        flag_SOURCE_PORT        = &H0
        write_MACSEC_CLASS_value = &H0
        flag_MACSEC_CLASS        = &H0
        write_CONT_PACK_value = &H0
        flag_CONT_PACK        = &H0
        write_RULE_HIT_value = &H0
        flag_RULE_HIT        = &H0
        write_SA_HIT_value = &H0
        flag_SA_HIT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_tcam_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VPORT_INDEX                                [3:0]            get_VPORT_INDEX
''                                                             set_VPORT_INDEX
''                                                             read_VPORT_INDEX
''                                                             write_VPORT_INDEX
''---------------------------------------------------------------------------------
'' DROP                                       [15:15]          get_DROP
''                                                             set_DROP
''                                                             read_DROP
''                                                             write_DROP
''---------------------------------------------------------------------------------
'' RULE_NR1                                   [20:16]          get_RULE_NR1
''                                                             set_RULE_NR1
''                                                             read_RULE_NR1
''                                                             write_RULE_NR1
''---------------------------------------------------------------------------------
'' CONT_FRAM                                  [28:28]          get_CONT_FRAM
''                                                             set_CONT_FRAM
''                                                             read_CONT_FRAM
''                                                             write_CONT_FRAM
''---------------------------------------------------------------------------------
'' RULE_HIT1                                  [29:29]          get_RULE_HIT1
''                                                             set_RULE_HIT1
''                                                             read_RULE_HIT1
''                                                             write_RULE_HIT1
''---------------------------------------------------------------------------------
'' RULE_HIT_MULT                              [30:30]          get_RULE_HIT_MULT
''                                                             set_RULE_HIT_MULT
''                                                             read_RULE_HIT_MULT
''                                                             write_RULE_HIT_MULT
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_tcam_debug
    Private write_VPORT_INDEX_value
    Private read_VPORT_INDEX_value
    Private flag_VPORT_INDEX
    Private write_DROP_value
    Private read_DROP_value
    Private flag_DROP
    Private write_RULE_NR1_value
    Private read_RULE_NR1_value
    Private flag_RULE_NR1
    Private write_CONT_FRAM_value
    Private read_CONT_FRAM_value
    Private flag_CONT_FRAM
    Private write_RULE_HIT1_value
    Private read_RULE_HIT1_value
    Private flag_RULE_HIT1
    Private write_RULE_HIT_MULT_value
    Private read_RULE_HIT_MULT_value
    Private flag_RULE_HIT_MULT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c24
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_VPORT_INDEX
        get_VPORT_INDEX = read_VPORT_INDEX_value
    End Property

    Property Let set_VPORT_INDEX(aData)
        write_VPORT_INDEX_value = aData
        flag_VPORT_INDEX        = &H1
    End Property

    Property Get read_VPORT_INDEX
        read
        read_VPORT_INDEX = read_VPORT_INDEX_value
    End Property

    Property Let write_VPORT_INDEX(aData)
        set_VPORT_INDEX = aData
        write
    End Property

    Property Get get_DROP
        get_DROP = read_DROP_value
    End Property

    Property Let set_DROP(aData)
        write_DROP_value = aData
        flag_DROP        = &H1
    End Property

    Property Get read_DROP
        read
        read_DROP = read_DROP_value
    End Property

    Property Let write_DROP(aData)
        set_DROP = aData
        write
    End Property

    Property Get get_RULE_NR1
        get_RULE_NR1 = read_RULE_NR1_value
    End Property

    Property Let set_RULE_NR1(aData)
        write_RULE_NR1_value = aData
        flag_RULE_NR1        = &H1
    End Property

    Property Get read_RULE_NR1
        read
        read_RULE_NR1 = read_RULE_NR1_value
    End Property

    Property Let write_RULE_NR1(aData)
        set_RULE_NR1 = aData
        write
    End Property

    Property Get get_CONT_FRAM
        get_CONT_FRAM = read_CONT_FRAM_value
    End Property

    Property Let set_CONT_FRAM(aData)
        write_CONT_FRAM_value = aData
        flag_CONT_FRAM        = &H1
    End Property

    Property Get read_CONT_FRAM
        read
        read_CONT_FRAM = read_CONT_FRAM_value
    End Property

    Property Let write_CONT_FRAM(aData)
        set_CONT_FRAM = aData
        write
    End Property

    Property Get get_RULE_HIT1
        get_RULE_HIT1 = read_RULE_HIT1_value
    End Property

    Property Let set_RULE_HIT1(aData)
        write_RULE_HIT1_value = aData
        flag_RULE_HIT1        = &H1
    End Property

    Property Get read_RULE_HIT1
        read
        read_RULE_HIT1 = read_RULE_HIT1_value
    End Property

    Property Let write_RULE_HIT1(aData)
        set_RULE_HIT1 = aData
        write
    End Property

    Property Get get_RULE_HIT_MULT
        get_RULE_HIT_MULT = read_RULE_HIT_MULT_value
    End Property

    Property Let set_RULE_HIT_MULT(aData)
        write_RULE_HIT_MULT_value = aData
        flag_RULE_HIT_MULT        = &H1
    End Property

    Property Get read_RULE_HIT_MULT
        read
        read_RULE_HIT_MULT = read_RULE_HIT_MULT_value
    End Property

    Property Let write_RULE_HIT_MULT(aData)
        set_RULE_HIT_MULT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VPORT_INDEX_mask = &Hf
        if data_low > LONG_MAX then
            if VPORT_INDEX_mask = mask then
                read_VPORT_INDEX_value = data_low
            else
                read_VPORT_INDEX_value = (data_low - H8000_0000) and VPORT_INDEX_mask
            end If
        else
            read_VPORT_INDEX_value = data_low and VPORT_INDEX_mask
        end If
        read_DROP_value = rightShift(data_low, 15) and &H1
        read_RULE_NR1_value = rightShift(data_low, 16) and &H1f
        read_CONT_FRAM_value = rightShift(data_low, 28) and &H1
        read_RULE_HIT1_value = rightShift(data_low, 29) and &H1
        read_RULE_HIT_MULT_value = rightShift(data_low, 30) and &H1

    End Sub

    Sub write
        If flag_VPORT_INDEX = &H0 or flag_DROP = &H0 or flag_RULE_NR1 = &H0 or flag_CONT_FRAM = &H0 or flag_RULE_HIT1 = &H0 or flag_RULE_HIT_MULT = &H0 Then read
        If flag_VPORT_INDEX = &H0 Then write_VPORT_INDEX_value = get_VPORT_INDEX
        If flag_DROP = &H0 Then write_DROP_value = get_DROP
        If flag_RULE_NR1 = &H0 Then write_RULE_NR1_value = get_RULE_NR1
        If flag_CONT_FRAM = &H0 Then write_CONT_FRAM_value = get_CONT_FRAM
        If flag_RULE_HIT1 = &H0 Then write_RULE_HIT1_value = get_RULE_HIT1
        If flag_RULE_HIT_MULT = &H0 Then write_RULE_HIT_MULT_value = get_RULE_HIT_MULT

        regValue = leftShift((write_VPORT_INDEX_value and &Hf), 0) + leftShift((write_DROP_value and &H1), 15) + leftShift((write_RULE_NR1_value and &H1f), 16) + leftShift((write_CONT_FRAM_value and &H1), 28) + leftShift((write_RULE_HIT1_value and &H1), 29) + leftShift((write_RULE_HIT_MULT_value and &H1), 30)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VPORT_INDEX_mask = &Hf
        if data_low > LONG_MAX then
            if VPORT_INDEX_mask = mask then
                read_VPORT_INDEX_value = data_low
            else
                read_VPORT_INDEX_value = (data_low - H8000_0000) and VPORT_INDEX_mask
            end If
        else
            read_VPORT_INDEX_value = data_low and VPORT_INDEX_mask
        end If
        read_DROP_value = rightShift(data_low, 15) and &H1
        read_RULE_NR1_value = rightShift(data_low, 16) and &H1f
        read_CONT_FRAM_value = rightShift(data_low, 28) and &H1
        read_RULE_HIT1_value = rightShift(data_low, 29) and &H1
        read_RULE_HIT_MULT_value = rightShift(data_low, 30) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VPORT_INDEX_value = &H0
        flag_VPORT_INDEX        = &H0
        write_DROP_value = &H0
        flag_DROP        = &H0
        write_RULE_NR1_value = &H0
        flag_RULE_NR1        = &H0
        write_CONT_FRAM_value = &H0
        flag_CONT_FRAM        = &H0
        write_RULE_HIT1_value = &H0
        flag_RULE_HIT1        = &H0
        write_RULE_HIT_MULT_value = &H0
        flag_RULE_HIT_MULT        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sectag_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MACSEC_CLASS                               [1:0]            get_MACSEC_CLASS
''                                                             set_MACSEC_CLASS
''                                                             read_MACSEC_CLASS
''                                                             write_MACSEC_CLASS
''---------------------------------------------------------------------------------
'' MSV                                        [2:2]            get_MSV
''                                                             set_MSV
''                                                             read_MSV
''                                                             write_MSV
''---------------------------------------------------------------------------------
'' MSV1                                       [3:3]            get_MSV1
''                                                             set_MSV1
''                                                             read_MSV1
''                                                             write_MSV1
''---------------------------------------------------------------------------------
'' MTV                                        [4:4]            get_MTV
''                                                             set_MTV
''                                                             read_MTV
''                                                             write_MTV
''---------------------------------------------------------------------------------
'' MACSEC_LEN                                 [15:8]           get_MACSEC_LEN
''                                                             set_MACSEC_LEN
''                                                             read_MACSEC_LEN
''                                                             write_MACSEC_LEN
''---------------------------------------------------------------------------------
'' MMC                                        [17:16]          get_MMC
''                                                             set_MMC
''                                                             read_MMC
''                                                             write_MMC
''---------------------------------------------------------------------------------
'' MMSV                                       [18:18]          get_MMSV
''                                                             set_MMSV
''                                                             read_MMSV
''                                                             write_MMSV
''---------------------------------------------------------------------------------
'' MMSV1                                      [19:19]          get_MMSV1
''                                                             set_MMSV1
''                                                             read_MMSV1
''                                                             write_MMSV1
''---------------------------------------------------------------------------------
'' MMTV                                       [20:20]          get_MMTV
''                                                             set_MMTV
''                                                             read_MMTV
''                                                             write_MMTV
''---------------------------------------------------------------------------------
'' MPLS_MACS_LEN                              [31:24]          get_MPLS_MACS_LEN
''                                                             set_MPLS_MACS_LEN
''                                                             read_MPLS_MACS_LEN
''                                                             write_MPLS_MACS_LEN
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sectag_debug
    Private write_MACSEC_CLASS_value
    Private read_MACSEC_CLASS_value
    Private flag_MACSEC_CLASS
    Private write_MSV_value
    Private read_MSV_value
    Private flag_MSV
    Private write_MSV1_value
    Private read_MSV1_value
    Private flag_MSV1
    Private write_MTV_value
    Private read_MTV_value
    Private flag_MTV
    Private write_MACSEC_LEN_value
    Private read_MACSEC_LEN_value
    Private flag_MACSEC_LEN
    Private write_MMC_value
    Private read_MMC_value
    Private flag_MMC
    Private write_MMSV_value
    Private read_MMSV_value
    Private flag_MMSV
    Private write_MMSV1_value
    Private read_MMSV1_value
    Private flag_MMSV1
    Private write_MMTV_value
    Private read_MMTV_value
    Private flag_MMTV
    Private write_MPLS_MACS_LEN_value
    Private read_MPLS_MACS_LEN_value
    Private flag_MPLS_MACS_LEN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MACSEC_CLASS
        get_MACSEC_CLASS = read_MACSEC_CLASS_value
    End Property

    Property Let set_MACSEC_CLASS(aData)
        write_MACSEC_CLASS_value = aData
        flag_MACSEC_CLASS        = &H1
    End Property

    Property Get read_MACSEC_CLASS
        read
        read_MACSEC_CLASS = read_MACSEC_CLASS_value
    End Property

    Property Let write_MACSEC_CLASS(aData)
        set_MACSEC_CLASS = aData
        write
    End Property

    Property Get get_MSV
        get_MSV = read_MSV_value
    End Property

    Property Let set_MSV(aData)
        write_MSV_value = aData
        flag_MSV        = &H1
    End Property

    Property Get read_MSV
        read
        read_MSV = read_MSV_value
    End Property

    Property Let write_MSV(aData)
        set_MSV = aData
        write
    End Property

    Property Get get_MSV1
        get_MSV1 = read_MSV1_value
    End Property

    Property Let set_MSV1(aData)
        write_MSV1_value = aData
        flag_MSV1        = &H1
    End Property

    Property Get read_MSV1
        read
        read_MSV1 = read_MSV1_value
    End Property

    Property Let write_MSV1(aData)
        set_MSV1 = aData
        write
    End Property

    Property Get get_MTV
        get_MTV = read_MTV_value
    End Property

    Property Let set_MTV(aData)
        write_MTV_value = aData
        flag_MTV        = &H1
    End Property

    Property Get read_MTV
        read
        read_MTV = read_MTV_value
    End Property

    Property Let write_MTV(aData)
        set_MTV = aData
        write
    End Property

    Property Get get_MACSEC_LEN
        get_MACSEC_LEN = read_MACSEC_LEN_value
    End Property

    Property Let set_MACSEC_LEN(aData)
        write_MACSEC_LEN_value = aData
        flag_MACSEC_LEN        = &H1
    End Property

    Property Get read_MACSEC_LEN
        read
        read_MACSEC_LEN = read_MACSEC_LEN_value
    End Property

    Property Let write_MACSEC_LEN(aData)
        set_MACSEC_LEN = aData
        write
    End Property

    Property Get get_MMC
        get_MMC = read_MMC_value
    End Property

    Property Let set_MMC(aData)
        write_MMC_value = aData
        flag_MMC        = &H1
    End Property

    Property Get read_MMC
        read
        read_MMC = read_MMC_value
    End Property

    Property Let write_MMC(aData)
        set_MMC = aData
        write
    End Property

    Property Get get_MMSV
        get_MMSV = read_MMSV_value
    End Property

    Property Let set_MMSV(aData)
        write_MMSV_value = aData
        flag_MMSV        = &H1
    End Property

    Property Get read_MMSV
        read
        read_MMSV = read_MMSV_value
    End Property

    Property Let write_MMSV(aData)
        set_MMSV = aData
        write
    End Property

    Property Get get_MMSV1
        get_MMSV1 = read_MMSV1_value
    End Property

    Property Let set_MMSV1(aData)
        write_MMSV1_value = aData
        flag_MMSV1        = &H1
    End Property

    Property Get read_MMSV1
        read
        read_MMSV1 = read_MMSV1_value
    End Property

    Property Let write_MMSV1(aData)
        set_MMSV1 = aData
        write
    End Property

    Property Get get_MMTV
        get_MMTV = read_MMTV_value
    End Property

    Property Let set_MMTV(aData)
        write_MMTV_value = aData
        flag_MMTV        = &H1
    End Property

    Property Get read_MMTV
        read
        read_MMTV = read_MMTV_value
    End Property

    Property Let write_MMTV(aData)
        set_MMTV = aData
        write
    End Property

    Property Get get_MPLS_MACS_LEN
        get_MPLS_MACS_LEN = read_MPLS_MACS_LEN_value
    End Property

    Property Let set_MPLS_MACS_LEN(aData)
        write_MPLS_MACS_LEN_value = aData
        flag_MPLS_MACS_LEN        = &H1
    End Property

    Property Get read_MPLS_MACS_LEN
        read
        read_MPLS_MACS_LEN = read_MPLS_MACS_LEN_value
    End Property

    Property Let write_MPLS_MACS_LEN(aData)
        set_MPLS_MACS_LEN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MACSEC_CLASS_mask = &H3
        if data_low > LONG_MAX then
            if MACSEC_CLASS_mask = mask then
                read_MACSEC_CLASS_value = data_low
            else
                read_MACSEC_CLASS_value = (data_low - H8000_0000) and MACSEC_CLASS_mask
            end If
        else
            read_MACSEC_CLASS_value = data_low and MACSEC_CLASS_mask
        end If
        read_MSV_value = rightShift(data_low, 2) and &H1
        read_MSV1_value = rightShift(data_low, 3) and &H1
        read_MTV_value = rightShift(data_low, 4) and &H1
        read_MACSEC_LEN_value = rightShift(data_low, 8) and &Hff
        read_MMC_value = rightShift(data_low, 16) and &H3
        read_MMSV_value = rightShift(data_low, 18) and &H1
        read_MMSV1_value = rightShift(data_low, 19) and &H1
        read_MMTV_value = rightShift(data_low, 20) and &H1
        read_MPLS_MACS_LEN_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_MACSEC_CLASS = &H0 or flag_MSV = &H0 or flag_MSV1 = &H0 or flag_MTV = &H0 or flag_MACSEC_LEN = &H0 or flag_MMC = &H0 or flag_MMSV = &H0 or flag_MMSV1 = &H0 or flag_MMTV = &H0 or flag_MPLS_MACS_LEN = &H0 Then read
        If flag_MACSEC_CLASS = &H0 Then write_MACSEC_CLASS_value = get_MACSEC_CLASS
        If flag_MSV = &H0 Then write_MSV_value = get_MSV
        If flag_MSV1 = &H0 Then write_MSV1_value = get_MSV1
        If flag_MTV = &H0 Then write_MTV_value = get_MTV
        If flag_MACSEC_LEN = &H0 Then write_MACSEC_LEN_value = get_MACSEC_LEN
        If flag_MMC = &H0 Then write_MMC_value = get_MMC
        If flag_MMSV = &H0 Then write_MMSV_value = get_MMSV
        If flag_MMSV1 = &H0 Then write_MMSV1_value = get_MMSV1
        If flag_MMTV = &H0 Then write_MMTV_value = get_MMTV
        If flag_MPLS_MACS_LEN = &H0 Then write_MPLS_MACS_LEN_value = get_MPLS_MACS_LEN

        regValue = leftShift((write_MACSEC_CLASS_value and &H3), 0) + leftShift((write_MSV_value and &H1), 2) + leftShift((write_MSV1_value and &H1), 3) + leftShift((write_MTV_value and &H1), 4) + leftShift((write_MACSEC_LEN_value and &Hff), 8) + leftShift((write_MMC_value and &H3), 16) + leftShift((write_MMSV_value and &H1), 18) + leftShift((write_MMSV1_value and &H1), 19) + leftShift((write_MMTV_value and &H1), 20) + leftShift((write_MPLS_MACS_LEN_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MACSEC_CLASS_mask = &H3
        if data_low > LONG_MAX then
            if MACSEC_CLASS_mask = mask then
                read_MACSEC_CLASS_value = data_low
            else
                read_MACSEC_CLASS_value = (data_low - H8000_0000) and MACSEC_CLASS_mask
            end If
        else
            read_MACSEC_CLASS_value = data_low and MACSEC_CLASS_mask
        end If
        read_MSV_value = rightShift(data_low, 2) and &H1
        read_MSV1_value = rightShift(data_low, 3) and &H1
        read_MTV_value = rightShift(data_low, 4) and &H1
        read_MACSEC_LEN_value = rightShift(data_low, 8) and &Hff
        read_MMC_value = rightShift(data_low, 16) and &H3
        read_MMSV_value = rightShift(data_low, 18) and &H1
        read_MMSV1_value = rightShift(data_low, 19) and &H1
        read_MMTV_value = rightShift(data_low, 20) and &H1
        read_MPLS_MACS_LEN_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MACSEC_CLASS_value = &H0
        flag_MACSEC_CLASS        = &H0
        write_MSV_value = &H0
        flag_MSV        = &H0
        write_MSV1_value = &H0
        flag_MSV1        = &H0
        write_MTV_value = &H0
        flag_MTV        = &H0
        write_MACSEC_LEN_value = &H0
        flag_MACSEC_LEN        = &H0
        write_MMC_value = &H0
        flag_MMC        = &H0
        write_MMSV_value = &H0
        flag_MMSV        = &H0
        write_MMSV1_value = &H0
        flag_MMSV1        = &H0
        write_MMTV_value = &H0
        flag_MMTV        = &H0
        write_MPLS_MACS_LEN_value = &H0
        flag_MPLS_MACS_LEN        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sc_sa_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_INDEX                                   [4:0]            get_SA_INDEX
''                                                             set_SA_INDEX
''                                                             read_SA_INDEX
''                                                             write_SA_INDEX
''---------------------------------------------------------------------------------
'' SA_IN_USE                                  [15:15]          get_SA_IN_USE
''                                                             set_SA_IN_USE
''                                                             read_SA_IN_USE
''                                                             write_SA_IN_USE
''---------------------------------------------------------------------------------
'' SC_INDEX                                   [19:16]          get_SC_INDEX
''                                                             set_SC_INDEX
''                                                             read_SC_INDEX
''                                                             write_SC_INDEX
''---------------------------------------------------------------------------------
'' SC_CAM_HIT_MULT                            [30:30]          get_SC_CAM_HIT_MULT
''                                                             set_SC_CAM_HIT_MULT
''                                                             read_SC_CAM_HIT_MULT
''                                                             write_SC_CAM_HIT_MULT
''---------------------------------------------------------------------------------
'' SC_FOUND                                   [31:31]          get_SC_FOUND
''                                                             set_SC_FOUND
''                                                             read_SC_FOUND
''                                                             write_SC_FOUND
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sc_sa_debug
    Private write_SA_INDEX_value
    Private read_SA_INDEX_value
    Private flag_SA_INDEX
    Private write_SA_IN_USE_value
    Private read_SA_IN_USE_value
    Private flag_SA_IN_USE
    Private write_SC_INDEX_value
    Private read_SC_INDEX_value
    Private flag_SC_INDEX
    Private write_SC_CAM_HIT_MULT_value
    Private read_SC_CAM_HIT_MULT_value
    Private flag_SC_CAM_HIT_MULT
    Private write_SC_FOUND_value
    Private read_SC_FOUND_value
    Private flag_SC_FOUND

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_INDEX
        get_SA_INDEX = read_SA_INDEX_value
    End Property

    Property Let set_SA_INDEX(aData)
        write_SA_INDEX_value = aData
        flag_SA_INDEX        = &H1
    End Property

    Property Get read_SA_INDEX
        read
        read_SA_INDEX = read_SA_INDEX_value
    End Property

    Property Let write_SA_INDEX(aData)
        set_SA_INDEX = aData
        write
    End Property

    Property Get get_SA_IN_USE
        get_SA_IN_USE = read_SA_IN_USE_value
    End Property

    Property Let set_SA_IN_USE(aData)
        write_SA_IN_USE_value = aData
        flag_SA_IN_USE        = &H1
    End Property

    Property Get read_SA_IN_USE
        read
        read_SA_IN_USE = read_SA_IN_USE_value
    End Property

    Property Let write_SA_IN_USE(aData)
        set_SA_IN_USE = aData
        write
    End Property

    Property Get get_SC_INDEX
        get_SC_INDEX = read_SC_INDEX_value
    End Property

    Property Let set_SC_INDEX(aData)
        write_SC_INDEX_value = aData
        flag_SC_INDEX        = &H1
    End Property

    Property Get read_SC_INDEX
        read
        read_SC_INDEX = read_SC_INDEX_value
    End Property

    Property Let write_SC_INDEX(aData)
        set_SC_INDEX = aData
        write
    End Property

    Property Get get_SC_CAM_HIT_MULT
        get_SC_CAM_HIT_MULT = read_SC_CAM_HIT_MULT_value
    End Property

    Property Let set_SC_CAM_HIT_MULT(aData)
        write_SC_CAM_HIT_MULT_value = aData
        flag_SC_CAM_HIT_MULT        = &H1
    End Property

    Property Get read_SC_CAM_HIT_MULT
        read
        read_SC_CAM_HIT_MULT = read_SC_CAM_HIT_MULT_value
    End Property

    Property Let write_SC_CAM_HIT_MULT(aData)
        set_SC_CAM_HIT_MULT = aData
        write
    End Property

    Property Get get_SC_FOUND
        get_SC_FOUND = read_SC_FOUND_value
    End Property

    Property Let set_SC_FOUND(aData)
        write_SC_FOUND_value = aData
        flag_SC_FOUND        = &H1
    End Property

    Property Get read_SC_FOUND
        read
        read_SC_FOUND = read_SC_FOUND_value
    End Property

    Property Let write_SC_FOUND(aData)
        set_SC_FOUND = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_INDEX_mask = &H1f
        if data_low > LONG_MAX then
            if SA_INDEX_mask = mask then
                read_SA_INDEX_value = data_low
            else
                read_SA_INDEX_value = (data_low - H8000_0000) and SA_INDEX_mask
            end If
        else
            read_SA_INDEX_value = data_low and SA_INDEX_mask
        end If
        read_SA_IN_USE_value = rightShift(data_low, 15) and &H1
        read_SC_INDEX_value = rightShift(data_low, 16) and &Hf
        read_SC_CAM_HIT_MULT_value = rightShift(data_low, 30) and &H1
        read_SC_FOUND_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_SA_INDEX = &H0 or flag_SA_IN_USE = &H0 or flag_SC_INDEX = &H0 or flag_SC_CAM_HIT_MULT = &H0 or flag_SC_FOUND = &H0 Then read
        If flag_SA_INDEX = &H0 Then write_SA_INDEX_value = get_SA_INDEX
        If flag_SA_IN_USE = &H0 Then write_SA_IN_USE_value = get_SA_IN_USE
        If flag_SC_INDEX = &H0 Then write_SC_INDEX_value = get_SC_INDEX
        If flag_SC_CAM_HIT_MULT = &H0 Then write_SC_CAM_HIT_MULT_value = get_SC_CAM_HIT_MULT
        If flag_SC_FOUND = &H0 Then write_SC_FOUND_value = get_SC_FOUND

        regValue = leftShift((write_SA_INDEX_value and &H1f), 0) + leftShift((write_SA_IN_USE_value and &H1), 15) + leftShift((write_SC_INDEX_value and &Hf), 16) + leftShift((write_SC_CAM_HIT_MULT_value and &H1), 30) + leftShift((write_SC_FOUND_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_INDEX_mask = &H1f
        if data_low > LONG_MAX then
            if SA_INDEX_mask = mask then
                read_SA_INDEX_value = data_low
            else
                read_SA_INDEX_value = (data_low - H8000_0000) and SA_INDEX_mask
            end If
        else
            read_SA_INDEX_value = data_low and SA_INDEX_mask
        end If
        read_SA_IN_USE_value = rightShift(data_low, 15) and &H1
        read_SC_INDEX_value = rightShift(data_low, 16) and &Hf
        read_SC_CAM_HIT_MULT_value = rightShift(data_low, 30) and &H1
        read_SC_FOUND_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_INDEX_value = &H0
        flag_SA_INDEX        = &H0
        write_SA_IN_USE_value = &H0
        flag_SA_IN_USE        = &H0
        write_SC_INDEX_value = &H0
        flag_SC_INDEX        = &H0
        write_SC_CAM_HIT_MULT_value = &H0
        flag_SC_CAM_HIT_MULT        = &H0
        write_SC_FOUND_value = &H0
        flag_SC_FOUND        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_tcam_match_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MATCH_31_0                                 [31:0]           get_MATCH_31_0
''                                                             set_MATCH_31_0
''                                                             read_MATCH_31_0
''                                                             write_MATCH_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_tcam_match_debug1
    Private write_MATCH_31_0_value
    Private read_MATCH_31_0_value
    Private flag_MATCH_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MATCH_31_0
        get_MATCH_31_0 = read_MATCH_31_0_value
    End Property

    Property Let set_MATCH_31_0(aData)
        write_MATCH_31_0_value = aData
        flag_MATCH_31_0        = &H1
    End Property

    Property Get read_MATCH_31_0
        read
        read_MATCH_31_0 = read_MATCH_31_0_value
    End Property

    Property Let write_MATCH_31_0(aData)
        set_MATCH_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MATCH_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MATCH_31_0_mask = mask then
                read_MATCH_31_0_value = data_low
            else
                read_MATCH_31_0_value = (data_low - H8000_0000) and MATCH_31_0_mask
            end If
        else
            read_MATCH_31_0_value = data_low and MATCH_31_0_mask
        end If

    End Sub

    Sub write
        If flag_MATCH_31_0 = &H0 Then read
        If flag_MATCH_31_0 = &H0 Then write_MATCH_31_0_value = get_MATCH_31_0

        regValue = leftShift(write_MATCH_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MATCH_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if MATCH_31_0_mask = mask then
                read_MATCH_31_0_value = data_low
            else
                read_MATCH_31_0_value = (data_low - H8000_0000) and MATCH_31_0_mask
            end If
        else
            read_MATCH_31_0_value = data_low and MATCH_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MATCH_31_0_value = &H0
        flag_MATCH_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PARS_ETHE                                  [15:0]           get_PARS_ETHE
''                                                             set_PARS_ETHE
''                                                             read_PARS_ETHE
''                                                             write_PARS_ETHE
''---------------------------------------------------------------------------------
'' PARSED_VLAN                                [27:16]          get_PARSED_VLAN
''                                                             set_PARSED_VLAN
''                                                             read_PARSED_VLAN
''                                                             write_PARSED_VLAN
''---------------------------------------------------------------------------------
'' PARSED_UP                                  [30:28]          get_PARSED_UP
''                                                             set_PARSED_UP
''                                                             read_PARSED_UP
''                                                             write_PARSED_UP
''---------------------------------------------------------------------------------
'' PARSED_DEI                                 [31:31]          get_PARSED_DEI
''                                                             set_PARSED_DEI
''                                                             read_PARSED_DEI
''                                                             write_PARSED_DEI
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug1
    Private write_PARS_ETHE_value
    Private read_PARS_ETHE_value
    Private flag_PARS_ETHE
    Private write_PARSED_VLAN_value
    Private read_PARSED_VLAN_value
    Private flag_PARSED_VLAN
    Private write_PARSED_UP_value
    Private read_PARSED_UP_value
    Private flag_PARSED_UP
    Private write_PARSED_DEI_value
    Private read_PARSED_DEI_value
    Private flag_PARSED_DEI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PARS_ETHE
        get_PARS_ETHE = read_PARS_ETHE_value
    End Property

    Property Let set_PARS_ETHE(aData)
        write_PARS_ETHE_value = aData
        flag_PARS_ETHE        = &H1
    End Property

    Property Get read_PARS_ETHE
        read
        read_PARS_ETHE = read_PARS_ETHE_value
    End Property

    Property Let write_PARS_ETHE(aData)
        set_PARS_ETHE = aData
        write
    End Property

    Property Get get_PARSED_VLAN
        get_PARSED_VLAN = read_PARSED_VLAN_value
    End Property

    Property Let set_PARSED_VLAN(aData)
        write_PARSED_VLAN_value = aData
        flag_PARSED_VLAN        = &H1
    End Property

    Property Get read_PARSED_VLAN
        read
        read_PARSED_VLAN = read_PARSED_VLAN_value
    End Property

    Property Let write_PARSED_VLAN(aData)
        set_PARSED_VLAN = aData
        write
    End Property

    Property Get get_PARSED_UP
        get_PARSED_UP = read_PARSED_UP_value
    End Property

    Property Let set_PARSED_UP(aData)
        write_PARSED_UP_value = aData
        flag_PARSED_UP        = &H1
    End Property

    Property Get read_PARSED_UP
        read
        read_PARSED_UP = read_PARSED_UP_value
    End Property

    Property Let write_PARSED_UP(aData)
        set_PARSED_UP = aData
        write
    End Property

    Property Get get_PARSED_DEI
        get_PARSED_DEI = read_PARSED_DEI_value
    End Property

    Property Let set_PARSED_DEI(aData)
        write_PARSED_DEI_value = aData
        flag_PARSED_DEI        = &H1
    End Property

    Property Get read_PARSED_DEI
        read
        read_PARSED_DEI = read_PARSED_DEI_value
    End Property

    Property Let write_PARSED_DEI(aData)
        set_PARSED_DEI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PARS_ETHE_mask = &Hffff
        if data_low > LONG_MAX then
            if PARS_ETHE_mask = mask then
                read_PARS_ETHE_value = data_low
            else
                read_PARS_ETHE_value = (data_low - H8000_0000) and PARS_ETHE_mask
            end If
        else
            read_PARS_ETHE_value = data_low and PARS_ETHE_mask
        end If
        read_PARSED_VLAN_value = rightShift(data_low, 16) and &Hfff
        read_PARSED_UP_value = rightShift(data_low, 28) and &H7
        read_PARSED_DEI_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_PARS_ETHE = &H0 or flag_PARSED_VLAN = &H0 or flag_PARSED_UP = &H0 or flag_PARSED_DEI = &H0 Then read
        If flag_PARS_ETHE = &H0 Then write_PARS_ETHE_value = get_PARS_ETHE
        If flag_PARSED_VLAN = &H0 Then write_PARSED_VLAN_value = get_PARSED_VLAN
        If flag_PARSED_UP = &H0 Then write_PARSED_UP_value = get_PARSED_UP
        If flag_PARSED_DEI = &H0 Then write_PARSED_DEI_value = get_PARSED_DEI

        regValue = leftShift((write_PARS_ETHE_value and &Hffff), 0) + leftShift((write_PARSED_VLAN_value and &Hfff), 16) + leftShift((write_PARSED_UP_value and &H7), 28) + leftShift((write_PARSED_DEI_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PARS_ETHE_mask = &Hffff
        if data_low > LONG_MAX then
            if PARS_ETHE_mask = mask then
                read_PARS_ETHE_value = data_low
            else
                read_PARS_ETHE_value = (data_low - H8000_0000) and PARS_ETHE_mask
            end If
        else
            read_PARS_ETHE_value = data_low and PARS_ETHE_mask
        end If
        read_PARSED_VLAN_value = rightShift(data_low, 16) and &Hfff
        read_PARSED_UP_value = rightShift(data_low, 28) and &H7
        read_PARSED_DEI_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PARS_ETHE_value = &H0
        flag_PARS_ETHE        = &H0
        write_PARSED_VLAN_value = &H0
        flag_PARSED_VLAN        = &H0
        write_PARSED_UP_value = &H0
        flag_PARSED_UP        = &H0
        write_PARSED_DEI_value = &H0
        flag_PARSED_DEI        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VLAN_VALID                                 [0:0]            get_VLAN_VALID
''                                                             set_VLAN_VALID
''                                                             read_VLAN_VALID
''                                                             write_VLAN_VALID
''---------------------------------------------------------------------------------
'' QINQ_FOUND                                 [1:1]            get_QINQ_FOUND
''                                                             set_QINQ_FOUND
''                                                             read_QINQ_FOUND
''                                                             write_QINQ_FOUND
''---------------------------------------------------------------------------------
'' STAG_VALID                                 [2:2]            get_STAG_VALID
''                                                             set_STAG_VALID
''                                                             read_STAG_VALID
''                                                             write_STAG_VALID
''---------------------------------------------------------------------------------
'' QTAG_VALID                                 [3:3]            get_QTAG_VALID
''                                                             set_QTAG_VALID
''                                                             read_QTAG_VALID
''                                                             write_QTAG_VALID
''---------------------------------------------------------------------------------
'' LPIDLE_PKT                                 [4:4]            get_LPIDLE_PKT
''                                                             set_LPIDLE_PKT
''                                                             read_LPIDLE_PKT
''                                                             write_LPIDLE_PKT
''---------------------------------------------------------------------------------
'' ONE_WORD_PKT                               [5:5]            get_ONE_WORD_PKT
''                                                             set_ONE_WORD_PKT
''                                                             read_ONE_WORD_PKT
''                                                             write_ONE_WORD_PKT
''---------------------------------------------------------------------------------
'' LAST_MTY                                   [9:6]            get_LAST_MTY
''                                                             set_LAST_MTY
''                                                             read_LAST_MTY
''                                                             write_LAST_MTY
''---------------------------------------------------------------------------------
'' ET_VALID                                   [10:10]          get_ET_VALID
''                                                             set_ET_VALID
''                                                             read_ET_VALID
''                                                             write_ET_VALID
''---------------------------------------------------------------------------------
'' SA_VALID                                   [11:11]          get_SA_VALID
''                                                             set_SA_VALID
''                                                             read_SA_VALID
''                                                             write_SA_VALID
''---------------------------------------------------------------------------------
'' DA_VALID                                   [12:12]          get_DA_VALID
''                                                             set_DA_VALID
''                                                             read_DA_VALID
''                                                             write_DA_VALID
''---------------------------------------------------------------------------------
'' OUTE_ET_VALI                               [13:13]          get_OUTE_ET_VALI
''                                                             set_OUTE_ET_VALI
''                                                             read_OUTE_ET_VALI
''                                                             write_OUTE_ET_VALI
''---------------------------------------------------------------------------------
'' NUM_TAGS_LABE                              [18:16]          get_NUM_TAGS_LABE
''                                                             set_NUM_TAGS_LABE
''                                                             read_NUM_TAGS_LABE
''                                                             write_NUM_TAGS_LABE
''---------------------------------------------------------------------------------
'' SNAP_ETH_VALI                              [24:24]          get_SNAP_ETH_VALI
''                                                             set_SNAP_ETH_VALI
''                                                             read_SNAP_ETH_VALI
''                                                             write_SNAP_ETH_VALI
''---------------------------------------------------------------------------------
'' SNAP_VALID                                 [25:25]          get_SNAP_VALID
''                                                             set_SNAP_VALID
''                                                             read_SNAP_VALID
''                                                             write_SNAP_VALID
''---------------------------------------------------------------------------------
'' LLC_VALID                                  [26:26]          get_LLC_VALID
''                                                             set_LLC_VALID
''                                                             read_LLC_VALID
''                                                             write_LLC_VALID
''---------------------------------------------------------------------------------
'' EHV                                        [27:27]          get_EHV
''                                                             set_EHV
''                                                             read_EHV
''                                                             write_EHV
''---------------------------------------------------------------------------------
'' MPLS_VALID                                 [28:28]          get_MPLS_VALID
''                                                             set_MPLS_VALID
''                                                             read_MPLS_VALID
''                                                             write_MPLS_VALID
''---------------------------------------------------------------------------------
'' PBB_VALID                                  [29:29]          get_PBB_VALID
''                                                             set_PBB_VALID
''                                                             read_PBB_VALID
''                                                             write_PBB_VALID
''---------------------------------------------------------------------------------
'' ST_VLAN_VALI                               [30:30]          get_ST_VLAN_VALI
''                                                             set_ST_VLAN_VALI
''                                                             read_ST_VLAN_VALI
''                                                             write_ST_VLAN_VALI
''---------------------------------------------------------------------------------
'' SING_STEP_EN                               [31:31]          get_SING_STEP_EN
''                                                             set_SING_STEP_EN
''                                                             read_SING_STEP_EN
''                                                             write_SING_STEP_EN
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug2
    Private write_VLAN_VALID_value
    Private read_VLAN_VALID_value
    Private flag_VLAN_VALID
    Private write_QINQ_FOUND_value
    Private read_QINQ_FOUND_value
    Private flag_QINQ_FOUND
    Private write_STAG_VALID_value
    Private read_STAG_VALID_value
    Private flag_STAG_VALID
    Private write_QTAG_VALID_value
    Private read_QTAG_VALID_value
    Private flag_QTAG_VALID
    Private write_LPIDLE_PKT_value
    Private read_LPIDLE_PKT_value
    Private flag_LPIDLE_PKT
    Private write_ONE_WORD_PKT_value
    Private read_ONE_WORD_PKT_value
    Private flag_ONE_WORD_PKT
    Private write_LAST_MTY_value
    Private read_LAST_MTY_value
    Private flag_LAST_MTY
    Private write_ET_VALID_value
    Private read_ET_VALID_value
    Private flag_ET_VALID
    Private write_SA_VALID_value
    Private read_SA_VALID_value
    Private flag_SA_VALID
    Private write_DA_VALID_value
    Private read_DA_VALID_value
    Private flag_DA_VALID
    Private write_OUTE_ET_VALI_value
    Private read_OUTE_ET_VALI_value
    Private flag_OUTE_ET_VALI
    Private write_NUM_TAGS_LABE_value
    Private read_NUM_TAGS_LABE_value
    Private flag_NUM_TAGS_LABE
    Private write_SNAP_ETH_VALI_value
    Private read_SNAP_ETH_VALI_value
    Private flag_SNAP_ETH_VALI
    Private write_SNAP_VALID_value
    Private read_SNAP_VALID_value
    Private flag_SNAP_VALID
    Private write_LLC_VALID_value
    Private read_LLC_VALID_value
    Private flag_LLC_VALID
    Private write_EHV_value
    Private read_EHV_value
    Private flag_EHV
    Private write_MPLS_VALID_value
    Private read_MPLS_VALID_value
    Private flag_MPLS_VALID
    Private write_PBB_VALID_value
    Private read_PBB_VALID_value
    Private flag_PBB_VALID
    Private write_ST_VLAN_VALI_value
    Private read_ST_VLAN_VALI_value
    Private flag_ST_VLAN_VALI
    Private write_SING_STEP_EN_value
    Private read_SING_STEP_EN_value
    Private flag_SING_STEP_EN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_VLAN_VALID
        get_VLAN_VALID = read_VLAN_VALID_value
    End Property

    Property Let set_VLAN_VALID(aData)
        write_VLAN_VALID_value = aData
        flag_VLAN_VALID        = &H1
    End Property

    Property Get read_VLAN_VALID
        read
        read_VLAN_VALID = read_VLAN_VALID_value
    End Property

    Property Let write_VLAN_VALID(aData)
        set_VLAN_VALID = aData
        write
    End Property

    Property Get get_QINQ_FOUND
        get_QINQ_FOUND = read_QINQ_FOUND_value
    End Property

    Property Let set_QINQ_FOUND(aData)
        write_QINQ_FOUND_value = aData
        flag_QINQ_FOUND        = &H1
    End Property

    Property Get read_QINQ_FOUND
        read
        read_QINQ_FOUND = read_QINQ_FOUND_value
    End Property

    Property Let write_QINQ_FOUND(aData)
        set_QINQ_FOUND = aData
        write
    End Property

    Property Get get_STAG_VALID
        get_STAG_VALID = read_STAG_VALID_value
    End Property

    Property Let set_STAG_VALID(aData)
        write_STAG_VALID_value = aData
        flag_STAG_VALID        = &H1
    End Property

    Property Get read_STAG_VALID
        read
        read_STAG_VALID = read_STAG_VALID_value
    End Property

    Property Let write_STAG_VALID(aData)
        set_STAG_VALID = aData
        write
    End Property

    Property Get get_QTAG_VALID
        get_QTAG_VALID = read_QTAG_VALID_value
    End Property

    Property Let set_QTAG_VALID(aData)
        write_QTAG_VALID_value = aData
        flag_QTAG_VALID        = &H1
    End Property

    Property Get read_QTAG_VALID
        read
        read_QTAG_VALID = read_QTAG_VALID_value
    End Property

    Property Let write_QTAG_VALID(aData)
        set_QTAG_VALID = aData
        write
    End Property

    Property Get get_LPIDLE_PKT
        get_LPIDLE_PKT = read_LPIDLE_PKT_value
    End Property

    Property Let set_LPIDLE_PKT(aData)
        write_LPIDLE_PKT_value = aData
        flag_LPIDLE_PKT        = &H1
    End Property

    Property Get read_LPIDLE_PKT
        read
        read_LPIDLE_PKT = read_LPIDLE_PKT_value
    End Property

    Property Let write_LPIDLE_PKT(aData)
        set_LPIDLE_PKT = aData
        write
    End Property

    Property Get get_ONE_WORD_PKT
        get_ONE_WORD_PKT = read_ONE_WORD_PKT_value
    End Property

    Property Let set_ONE_WORD_PKT(aData)
        write_ONE_WORD_PKT_value = aData
        flag_ONE_WORD_PKT        = &H1
    End Property

    Property Get read_ONE_WORD_PKT
        read
        read_ONE_WORD_PKT = read_ONE_WORD_PKT_value
    End Property

    Property Let write_ONE_WORD_PKT(aData)
        set_ONE_WORD_PKT = aData
        write
    End Property

    Property Get get_LAST_MTY
        get_LAST_MTY = read_LAST_MTY_value
    End Property

    Property Let set_LAST_MTY(aData)
        write_LAST_MTY_value = aData
        flag_LAST_MTY        = &H1
    End Property

    Property Get read_LAST_MTY
        read
        read_LAST_MTY = read_LAST_MTY_value
    End Property

    Property Let write_LAST_MTY(aData)
        set_LAST_MTY = aData
        write
    End Property

    Property Get get_ET_VALID
        get_ET_VALID = read_ET_VALID_value
    End Property

    Property Let set_ET_VALID(aData)
        write_ET_VALID_value = aData
        flag_ET_VALID        = &H1
    End Property

    Property Get read_ET_VALID
        read
        read_ET_VALID = read_ET_VALID_value
    End Property

    Property Let write_ET_VALID(aData)
        set_ET_VALID = aData
        write
    End Property

    Property Get get_SA_VALID
        get_SA_VALID = read_SA_VALID_value
    End Property

    Property Let set_SA_VALID(aData)
        write_SA_VALID_value = aData
        flag_SA_VALID        = &H1
    End Property

    Property Get read_SA_VALID
        read
        read_SA_VALID = read_SA_VALID_value
    End Property

    Property Let write_SA_VALID(aData)
        set_SA_VALID = aData
        write
    End Property

    Property Get get_DA_VALID
        get_DA_VALID = read_DA_VALID_value
    End Property

    Property Let set_DA_VALID(aData)
        write_DA_VALID_value = aData
        flag_DA_VALID        = &H1
    End Property

    Property Get read_DA_VALID
        read
        read_DA_VALID = read_DA_VALID_value
    End Property

    Property Let write_DA_VALID(aData)
        set_DA_VALID = aData
        write
    End Property

    Property Get get_OUTE_ET_VALI
        get_OUTE_ET_VALI = read_OUTE_ET_VALI_value
    End Property

    Property Let set_OUTE_ET_VALI(aData)
        write_OUTE_ET_VALI_value = aData
        flag_OUTE_ET_VALI        = &H1
    End Property

    Property Get read_OUTE_ET_VALI
        read
        read_OUTE_ET_VALI = read_OUTE_ET_VALI_value
    End Property

    Property Let write_OUTE_ET_VALI(aData)
        set_OUTE_ET_VALI = aData
        write
    End Property

    Property Get get_NUM_TAGS_LABE
        get_NUM_TAGS_LABE = read_NUM_TAGS_LABE_value
    End Property

    Property Let set_NUM_TAGS_LABE(aData)
        write_NUM_TAGS_LABE_value = aData
        flag_NUM_TAGS_LABE        = &H1
    End Property

    Property Get read_NUM_TAGS_LABE
        read
        read_NUM_TAGS_LABE = read_NUM_TAGS_LABE_value
    End Property

    Property Let write_NUM_TAGS_LABE(aData)
        set_NUM_TAGS_LABE = aData
        write
    End Property

    Property Get get_SNAP_ETH_VALI
        get_SNAP_ETH_VALI = read_SNAP_ETH_VALI_value
    End Property

    Property Let set_SNAP_ETH_VALI(aData)
        write_SNAP_ETH_VALI_value = aData
        flag_SNAP_ETH_VALI        = &H1
    End Property

    Property Get read_SNAP_ETH_VALI
        read
        read_SNAP_ETH_VALI = read_SNAP_ETH_VALI_value
    End Property

    Property Let write_SNAP_ETH_VALI(aData)
        set_SNAP_ETH_VALI = aData
        write
    End Property

    Property Get get_SNAP_VALID
        get_SNAP_VALID = read_SNAP_VALID_value
    End Property

    Property Let set_SNAP_VALID(aData)
        write_SNAP_VALID_value = aData
        flag_SNAP_VALID        = &H1
    End Property

    Property Get read_SNAP_VALID
        read
        read_SNAP_VALID = read_SNAP_VALID_value
    End Property

    Property Let write_SNAP_VALID(aData)
        set_SNAP_VALID = aData
        write
    End Property

    Property Get get_LLC_VALID
        get_LLC_VALID = read_LLC_VALID_value
    End Property

    Property Let set_LLC_VALID(aData)
        write_LLC_VALID_value = aData
        flag_LLC_VALID        = &H1
    End Property

    Property Get read_LLC_VALID
        read
        read_LLC_VALID = read_LLC_VALID_value
    End Property

    Property Let write_LLC_VALID(aData)
        set_LLC_VALID = aData
        write
    End Property

    Property Get get_EHV
        get_EHV = read_EHV_value
    End Property

    Property Let set_EHV(aData)
        write_EHV_value = aData
        flag_EHV        = &H1
    End Property

    Property Get read_EHV
        read
        read_EHV = read_EHV_value
    End Property

    Property Let write_EHV(aData)
        set_EHV = aData
        write
    End Property

    Property Get get_MPLS_VALID
        get_MPLS_VALID = read_MPLS_VALID_value
    End Property

    Property Let set_MPLS_VALID(aData)
        write_MPLS_VALID_value = aData
        flag_MPLS_VALID        = &H1
    End Property

    Property Get read_MPLS_VALID
        read
        read_MPLS_VALID = read_MPLS_VALID_value
    End Property

    Property Let write_MPLS_VALID(aData)
        set_MPLS_VALID = aData
        write
    End Property

    Property Get get_PBB_VALID
        get_PBB_VALID = read_PBB_VALID_value
    End Property

    Property Let set_PBB_VALID(aData)
        write_PBB_VALID_value = aData
        flag_PBB_VALID        = &H1
    End Property

    Property Get read_PBB_VALID
        read
        read_PBB_VALID = read_PBB_VALID_value
    End Property

    Property Let write_PBB_VALID(aData)
        set_PBB_VALID = aData
        write
    End Property

    Property Get get_ST_VLAN_VALI
        get_ST_VLAN_VALI = read_ST_VLAN_VALI_value
    End Property

    Property Let set_ST_VLAN_VALI(aData)
        write_ST_VLAN_VALI_value = aData
        flag_ST_VLAN_VALI        = &H1
    End Property

    Property Get read_ST_VLAN_VALI
        read
        read_ST_VLAN_VALI = read_ST_VLAN_VALI_value
    End Property

    Property Let write_ST_VLAN_VALI(aData)
        set_ST_VLAN_VALI = aData
        write
    End Property

    Property Get get_SING_STEP_EN
        get_SING_STEP_EN = read_SING_STEP_EN_value
    End Property

    Property Let set_SING_STEP_EN(aData)
        write_SING_STEP_EN_value = aData
        flag_SING_STEP_EN        = &H1
    End Property

    Property Get read_SING_STEP_EN
        read
        read_SING_STEP_EN = read_SING_STEP_EN_value
    End Property

    Property Let write_SING_STEP_EN(aData)
        set_SING_STEP_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VLAN_VALID_mask = &H1
        if data_low > LONG_MAX then
            if VLAN_VALID_mask = mask then
                read_VLAN_VALID_value = data_low
            else
                read_VLAN_VALID_value = (data_low - H8000_0000) and VLAN_VALID_mask
            end If
        else
            read_VLAN_VALID_value = data_low and VLAN_VALID_mask
        end If
        read_QINQ_FOUND_value = rightShift(data_low, 1) and &H1
        read_STAG_VALID_value = rightShift(data_low, 2) and &H1
        read_QTAG_VALID_value = rightShift(data_low, 3) and &H1
        read_LPIDLE_PKT_value = rightShift(data_low, 4) and &H1
        read_ONE_WORD_PKT_value = rightShift(data_low, 5) and &H1
        read_LAST_MTY_value = rightShift(data_low, 6) and &Hf
        read_ET_VALID_value = rightShift(data_low, 10) and &H1
        read_SA_VALID_value = rightShift(data_low, 11) and &H1
        read_DA_VALID_value = rightShift(data_low, 12) and &H1
        read_OUTE_ET_VALI_value = rightShift(data_low, 13) and &H1
        read_NUM_TAGS_LABE_value = rightShift(data_low, 16) and &H7
        read_SNAP_ETH_VALI_value = rightShift(data_low, 24) and &H1
        read_SNAP_VALID_value = rightShift(data_low, 25) and &H1
        read_LLC_VALID_value = rightShift(data_low, 26) and &H1
        read_EHV_value = rightShift(data_low, 27) and &H1
        read_MPLS_VALID_value = rightShift(data_low, 28) and &H1
        read_PBB_VALID_value = rightShift(data_low, 29) and &H1
        read_ST_VLAN_VALI_value = rightShift(data_low, 30) and &H1
        read_SING_STEP_EN_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_VLAN_VALID = &H0 or flag_QINQ_FOUND = &H0 or flag_STAG_VALID = &H0 or flag_QTAG_VALID = &H0 or flag_LPIDLE_PKT = &H0 or flag_ONE_WORD_PKT = &H0 or flag_LAST_MTY = &H0 or flag_ET_VALID = &H0 or flag_SA_VALID = &H0 or flag_DA_VALID = &H0 or flag_OUTE_ET_VALI = &H0 or flag_NUM_TAGS_LABE = &H0 or flag_SNAP_ETH_VALI = &H0 or flag_SNAP_VALID = &H0 or flag_LLC_VALID = &H0 or flag_EHV = &H0 or flag_MPLS_VALID = &H0 or flag_PBB_VALID = &H0 or flag_ST_VLAN_VALI = &H0 or flag_SING_STEP_EN = &H0 Then read
        If flag_VLAN_VALID = &H0 Then write_VLAN_VALID_value = get_VLAN_VALID
        If flag_QINQ_FOUND = &H0 Then write_QINQ_FOUND_value = get_QINQ_FOUND
        If flag_STAG_VALID = &H0 Then write_STAG_VALID_value = get_STAG_VALID
        If flag_QTAG_VALID = &H0 Then write_QTAG_VALID_value = get_QTAG_VALID
        If flag_LPIDLE_PKT = &H0 Then write_LPIDLE_PKT_value = get_LPIDLE_PKT
        If flag_ONE_WORD_PKT = &H0 Then write_ONE_WORD_PKT_value = get_ONE_WORD_PKT
        If flag_LAST_MTY = &H0 Then write_LAST_MTY_value = get_LAST_MTY
        If flag_ET_VALID = &H0 Then write_ET_VALID_value = get_ET_VALID
        If flag_SA_VALID = &H0 Then write_SA_VALID_value = get_SA_VALID
        If flag_DA_VALID = &H0 Then write_DA_VALID_value = get_DA_VALID
        If flag_OUTE_ET_VALI = &H0 Then write_OUTE_ET_VALI_value = get_OUTE_ET_VALI
        If flag_NUM_TAGS_LABE = &H0 Then write_NUM_TAGS_LABE_value = get_NUM_TAGS_LABE
        If flag_SNAP_ETH_VALI = &H0 Then write_SNAP_ETH_VALI_value = get_SNAP_ETH_VALI
        If flag_SNAP_VALID = &H0 Then write_SNAP_VALID_value = get_SNAP_VALID
        If flag_LLC_VALID = &H0 Then write_LLC_VALID_value = get_LLC_VALID
        If flag_EHV = &H0 Then write_EHV_value = get_EHV
        If flag_MPLS_VALID = &H0 Then write_MPLS_VALID_value = get_MPLS_VALID
        If flag_PBB_VALID = &H0 Then write_PBB_VALID_value = get_PBB_VALID
        If flag_ST_VLAN_VALI = &H0 Then write_ST_VLAN_VALI_value = get_ST_VLAN_VALI
        If flag_SING_STEP_EN = &H0 Then write_SING_STEP_EN_value = get_SING_STEP_EN

        regValue = leftShift((write_VLAN_VALID_value and &H1), 0) + leftShift((write_QINQ_FOUND_value and &H1), 1) + leftShift((write_STAG_VALID_value and &H1), 2) + leftShift((write_QTAG_VALID_value and &H1), 3) + leftShift((write_LPIDLE_PKT_value and &H1), 4) + leftShift((write_ONE_WORD_PKT_value and &H1), 5) + leftShift((write_LAST_MTY_value and &Hf), 6) + leftShift((write_ET_VALID_value and &H1), 10) + leftShift((write_SA_VALID_value and &H1), 11) + leftShift((write_DA_VALID_value and &H1), 12) + leftShift((write_OUTE_ET_VALI_value and &H1), 13) + leftShift((write_NUM_TAGS_LABE_value and &H7), 16) + leftShift((write_SNAP_ETH_VALI_value and &H1), 24) + leftShift((write_SNAP_VALID_value and &H1), 25) + leftShift((write_LLC_VALID_value and &H1), 26) + leftShift((write_EHV_value and &H1), 27) + leftShift((write_MPLS_VALID_value and &H1), 28) + leftShift((write_PBB_VALID_value and &H1), 29) + leftShift((write_ST_VLAN_VALI_value and &H1), 30) + leftShift((write_SING_STEP_EN_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VLAN_VALID_mask = &H1
        if data_low > LONG_MAX then
            if VLAN_VALID_mask = mask then
                read_VLAN_VALID_value = data_low
            else
                read_VLAN_VALID_value = (data_low - H8000_0000) and VLAN_VALID_mask
            end If
        else
            read_VLAN_VALID_value = data_low and VLAN_VALID_mask
        end If
        read_QINQ_FOUND_value = rightShift(data_low, 1) and &H1
        read_STAG_VALID_value = rightShift(data_low, 2) and &H1
        read_QTAG_VALID_value = rightShift(data_low, 3) and &H1
        read_LPIDLE_PKT_value = rightShift(data_low, 4) and &H1
        read_ONE_WORD_PKT_value = rightShift(data_low, 5) and &H1
        read_LAST_MTY_value = rightShift(data_low, 6) and &Hf
        read_ET_VALID_value = rightShift(data_low, 10) and &H1
        read_SA_VALID_value = rightShift(data_low, 11) and &H1
        read_DA_VALID_value = rightShift(data_low, 12) and &H1
        read_OUTE_ET_VALI_value = rightShift(data_low, 13) and &H1
        read_NUM_TAGS_LABE_value = rightShift(data_low, 16) and &H7
        read_SNAP_ETH_VALI_value = rightShift(data_low, 24) and &H1
        read_SNAP_VALID_value = rightShift(data_low, 25) and &H1
        read_LLC_VALID_value = rightShift(data_low, 26) and &H1
        read_EHV_value = rightShift(data_low, 27) and &H1
        read_MPLS_VALID_value = rightShift(data_low, 28) and &H1
        read_PBB_VALID_value = rightShift(data_low, 29) and &H1
        read_ST_VLAN_VALI_value = rightShift(data_low, 30) and &H1
        read_SING_STEP_EN_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VLAN_VALID_value = &H0
        flag_VLAN_VALID        = &H0
        write_QINQ_FOUND_value = &H0
        flag_QINQ_FOUND        = &H0
        write_STAG_VALID_value = &H0
        flag_STAG_VALID        = &H0
        write_QTAG_VALID_value = &H0
        flag_QTAG_VALID        = &H0
        write_LPIDLE_PKT_value = &H0
        flag_LPIDLE_PKT        = &H0
        write_ONE_WORD_PKT_value = &H0
        flag_ONE_WORD_PKT        = &H0
        write_LAST_MTY_value = &H0
        flag_LAST_MTY        = &H0
        write_ET_VALID_value = &H0
        flag_ET_VALID        = &H0
        write_SA_VALID_value = &H0
        flag_SA_VALID        = &H0
        write_DA_VALID_value = &H0
        flag_DA_VALID        = &H0
        write_OUTE_ET_VALI_value = &H0
        flag_OUTE_ET_VALI        = &H0
        write_NUM_TAGS_LABE_value = &H0
        flag_NUM_TAGS_LABE        = &H0
        write_SNAP_ETH_VALI_value = &H0
        flag_SNAP_ETH_VALI        = &H0
        write_SNAP_VALID_value = &H0
        flag_SNAP_VALID        = &H0
        write_LLC_VALID_value = &H0
        flag_LLC_VALID        = &H0
        write_EHV_value = &H0
        flag_EHV        = &H0
        write_MPLS_VALID_value = &H0
        flag_MPLS_VALID        = &H0
        write_PBB_VALID_value = &H0
        flag_PBB_VALID        = &H0
        write_ST_VLAN_VALI_value = &H0
        flag_ST_VLAN_VALI        = &H0
        write_SING_STEP_EN_value = &H0
        flag_SING_STEP_EN        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PVI                                        [11:0]           get_PVI
''                                                             set_PVI
''                                                             read_PVI
''                                                             write_PVI
''---------------------------------------------------------------------------------
'' PARS_UP_INNE                               [14:12]          get_PARS_UP_INNE
''                                                             set_PARS_UP_INNE
''                                                             read_PARS_UP_INNE
''                                                             write_PARS_UP_INNE
''---------------------------------------------------------------------------------
'' PDI                                        [15:15]          get_PDI
''                                                             set_PDI
''                                                             read_PDI
''                                                             write_PDI
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug3
    Private write_PVI_value
    Private read_PVI_value
    Private flag_PVI
    Private write_PARS_UP_INNE_value
    Private read_PARS_UP_INNE_value
    Private flag_PARS_UP_INNE
    Private write_PDI_value
    Private read_PDI_value
    Private flag_PDI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PVI
        get_PVI = read_PVI_value
    End Property

    Property Let set_PVI(aData)
        write_PVI_value = aData
        flag_PVI        = &H1
    End Property

    Property Get read_PVI
        read
        read_PVI = read_PVI_value
    End Property

    Property Let write_PVI(aData)
        set_PVI = aData
        write
    End Property

    Property Get get_PARS_UP_INNE
        get_PARS_UP_INNE = read_PARS_UP_INNE_value
    End Property

    Property Let set_PARS_UP_INNE(aData)
        write_PARS_UP_INNE_value = aData
        flag_PARS_UP_INNE        = &H1
    End Property

    Property Get read_PARS_UP_INNE
        read
        read_PARS_UP_INNE = read_PARS_UP_INNE_value
    End Property

    Property Let write_PARS_UP_INNE(aData)
        set_PARS_UP_INNE = aData
        write
    End Property

    Property Get get_PDI
        get_PDI = read_PDI_value
    End Property

    Property Let set_PDI(aData)
        write_PDI_value = aData
        flag_PDI        = &H1
    End Property

    Property Get read_PDI
        read
        read_PDI = read_PDI_value
    End Property

    Property Let write_PDI(aData)
        set_PDI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PVI_mask = &Hfff
        if data_low > LONG_MAX then
            if PVI_mask = mask then
                read_PVI_value = data_low
            else
                read_PVI_value = (data_low - H8000_0000) and PVI_mask
            end If
        else
            read_PVI_value = data_low and PVI_mask
        end If
        read_PARS_UP_INNE_value = rightShift(data_low, 12) and &H7
        read_PDI_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_PVI = &H0 or flag_PARS_UP_INNE = &H0 or flag_PDI = &H0 Then read
        If flag_PVI = &H0 Then write_PVI_value = get_PVI
        If flag_PARS_UP_INNE = &H0 Then write_PARS_UP_INNE_value = get_PARS_UP_INNE
        If flag_PDI = &H0 Then write_PDI_value = get_PDI

        regValue = leftShift((write_PVI_value and &Hfff), 0) + leftShift((write_PARS_UP_INNE_value and &H7), 12) + leftShift((write_PDI_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PVI_mask = &Hfff
        if data_low > LONG_MAX then
            if PVI_mask = mask then
                read_PVI_value = data_low
            else
                read_PVI_value = (data_low - H8000_0000) and PVI_mask
            end If
        else
            read_PVI_value = data_low and PVI_mask
        end If
        read_PARS_UP_INNE_value = rightShift(data_low, 12) and &H7
        read_PDI_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PVI_value = &H0
        flag_PVI        = &H0
        write_PARS_UP_INNE_value = &H0
        flag_PARS_UP_INNE        = &H0
        write_PDI_value = &H0
        flag_PDI        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_st_vlan_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLOW_ID                                    [11:0]           get_FLOW_ID
''                                                             set_FLOW_ID
''                                                             read_FLOW_ID
''                                                             write_FLOW_ID
''---------------------------------------------------------------------------------
'' E                                          [12:12]          get_E
''                                                             set_E
''                                                             read_E
''                                                             write_E
''---------------------------------------------------------------------------------
'' C                                          [13:13]          get_C
''                                                             set_C
''                                                             read_C
''                                                             write_C
''---------------------------------------------------------------------------------
'' VALID                                      [31:31]          get_VALID
''                                                             set_VALID
''                                                             read_VALID
''                                                             write_VALID
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_st_vlan_debug
    Private write_FLOW_ID_value
    Private read_FLOW_ID_value
    Private flag_FLOW_ID
    Private write_E_value
    Private read_E_value
    Private flag_E
    Private write_C_value
    Private read_C_value
    Private flag_C
    Private write_VALID_value
    Private read_VALID_value
    Private flag_VALID

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FLOW_ID
        get_FLOW_ID = read_FLOW_ID_value
    End Property

    Property Let set_FLOW_ID(aData)
        write_FLOW_ID_value = aData
        flag_FLOW_ID        = &H1
    End Property

    Property Get read_FLOW_ID
        read
        read_FLOW_ID = read_FLOW_ID_value
    End Property

    Property Let write_FLOW_ID(aData)
        set_FLOW_ID = aData
        write
    End Property

    Property Get get_E
        get_E = read_E_value
    End Property

    Property Let set_E(aData)
        write_E_value = aData
        flag_E        = &H1
    End Property

    Property Get read_E
        read
        read_E = read_E_value
    End Property

    Property Let write_E(aData)
        set_E = aData
        write
    End Property

    Property Get get_C
        get_C = read_C_value
    End Property

    Property Let set_C(aData)
        write_C_value = aData
        flag_C        = &H1
    End Property

    Property Get read_C
        read
        read_C = read_C_value
    End Property

    Property Let write_C(aData)
        set_C = aData
        write
    End Property

    Property Get get_VALID
        get_VALID = read_VALID_value
    End Property

    Property Let set_VALID(aData)
        write_VALID_value = aData
        flag_VALID        = &H1
    End Property

    Property Get read_VALID
        read
        read_VALID = read_VALID_value
    End Property

    Property Let write_VALID(aData)
        set_VALID = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLOW_ID_mask = &Hfff
        if data_low > LONG_MAX then
            if FLOW_ID_mask = mask then
                read_FLOW_ID_value = data_low
            else
                read_FLOW_ID_value = (data_low - H8000_0000) and FLOW_ID_mask
            end If
        else
            read_FLOW_ID_value = data_low and FLOW_ID_mask
        end If
        read_E_value = rightShift(data_low, 12) and &H1
        read_C_value = rightShift(data_low, 13) and &H1
        read_VALID_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_FLOW_ID = &H0 or flag_E = &H0 or flag_C = &H0 or flag_VALID = &H0 Then read
        If flag_FLOW_ID = &H0 Then write_FLOW_ID_value = get_FLOW_ID
        If flag_E = &H0 Then write_E_value = get_E
        If flag_C = &H0 Then write_C_value = get_C
        If flag_VALID = &H0 Then write_VALID_value = get_VALID

        regValue = leftShift((write_FLOW_ID_value and &Hfff), 0) + leftShift((write_E_value and &H1), 12) + leftShift((write_C_value and &H1), 13) + leftShift((write_VALID_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLOW_ID_mask = &Hfff
        if data_low > LONG_MAX then
            if FLOW_ID_mask = mask then
                read_FLOW_ID_value = data_low
            else
                read_FLOW_ID_value = (data_low - H8000_0000) and FLOW_ID_mask
            end If
        else
            read_FLOW_ID_value = data_low and FLOW_ID_mask
        end If
        read_E_value = rightShift(data_low, 12) and &H1
        read_C_value = rightShift(data_low, 13) and &H1
        read_VALID_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLOW_ID_value = &H0
        flag_FLOW_ID        = &H0
        write_E_value = &H0
        flag_E        = &H0
        write_C_value = &H0
        flag_C        = &H0
        write_VALID_value = &H0
        flag_VALID        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_ehdr_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VPORT_INDEX                                [15:0]           get_VPORT_INDEX
''                                                             set_VPORT_INDEX
''                                                             read_VPORT_INDEX
''                                                             write_VPORT_INDEX
''---------------------------------------------------------------------------------
'' ACTION                                     [17:16]          get_ACTION
''                                                             set_ACTION
''                                                             read_ACTION
''                                                             write_ACTION
''---------------------------------------------------------------------------------
'' VALID1                                     [31:31]          get_VALID1
''                                                             set_VALID1
''                                                             read_VALID1
''                                                             write_VALID1
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_ehdr_debug
    Private write_VPORT_INDEX_value
    Private read_VPORT_INDEX_value
    Private flag_VPORT_INDEX
    Private write_ACTION_value
    Private read_ACTION_value
    Private flag_ACTION
    Private write_VALID1_value
    Private read_VALID1_value
    Private flag_VALID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_VPORT_INDEX
        get_VPORT_INDEX = read_VPORT_INDEX_value
    End Property

    Property Let set_VPORT_INDEX(aData)
        write_VPORT_INDEX_value = aData
        flag_VPORT_INDEX        = &H1
    End Property

    Property Get read_VPORT_INDEX
        read
        read_VPORT_INDEX = read_VPORT_INDEX_value
    End Property

    Property Let write_VPORT_INDEX(aData)
        set_VPORT_INDEX = aData
        write
    End Property

    Property Get get_ACTION
        get_ACTION = read_ACTION_value
    End Property

    Property Let set_ACTION(aData)
        write_ACTION_value = aData
        flag_ACTION        = &H1
    End Property

    Property Get read_ACTION
        read
        read_ACTION = read_ACTION_value
    End Property

    Property Let write_ACTION(aData)
        set_ACTION = aData
        write
    End Property

    Property Get get_VALID1
        get_VALID1 = read_VALID1_value
    End Property

    Property Let set_VALID1(aData)
        write_VALID1_value = aData
        flag_VALID1        = &H1
    End Property

    Property Get read_VALID1
        read
        read_VALID1 = read_VALID1_value
    End Property

    Property Let write_VALID1(aData)
        set_VALID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VPORT_INDEX_mask = &Hffff
        if data_low > LONG_MAX then
            if VPORT_INDEX_mask = mask then
                read_VPORT_INDEX_value = data_low
            else
                read_VPORT_INDEX_value = (data_low - H8000_0000) and VPORT_INDEX_mask
            end If
        else
            read_VPORT_INDEX_value = data_low and VPORT_INDEX_mask
        end If
        read_ACTION_value = rightShift(data_low, 16) and &H3
        read_VALID1_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_VPORT_INDEX = &H0 or flag_ACTION = &H0 or flag_VALID1 = &H0 Then read
        If flag_VPORT_INDEX = &H0 Then write_VPORT_INDEX_value = get_VPORT_INDEX
        If flag_ACTION = &H0 Then write_ACTION_value = get_ACTION
        If flag_VALID1 = &H0 Then write_VALID1_value = get_VALID1

        regValue = leftShift((write_VPORT_INDEX_value and &Hffff), 0) + leftShift((write_ACTION_value and &H3), 16) + leftShift((write_VALID1_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        VPORT_INDEX_mask = &Hffff
        if data_low > LONG_MAX then
            if VPORT_INDEX_mask = mask then
                read_VPORT_INDEX_value = data_low
            else
                read_VPORT_INDEX_value = (data_low - H8000_0000) and VPORT_INDEX_mask
            end If
        else
            read_VPORT_INDEX_value = data_low and VPORT_INDEX_mask
        end If
        read_ACTION_value = rightShift(data_low, 16) and &H3
        read_VALID1_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VPORT_INDEX_value = &H0
        flag_VPORT_INDEX        = &H0
        write_ACTION_value = &H0
        flag_ACTION        = &H0
        write_VALID1_value = &H0
        flag_VALID1        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_mpls_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MPLS_LABEL1                                [19:0]           get_MPLS_LABEL1
''                                                             set_MPLS_LABEL1
''                                                             read_MPLS_LABEL1
''                                                             write_MPLS_LABEL1
''---------------------------------------------------------------------------------
'' MPLS_EXP1                                  [22:20]          get_MPLS_EXP1
''                                                             set_MPLS_EXP1
''                                                             read_MPLS_EXP1
''                                                             write_MPLS_EXP1
''---------------------------------------------------------------------------------
'' MPLS_S1                                    [23:23]          get_MPLS_S1
''                                                             set_MPLS_S1
''                                                             read_MPLS_S1
''                                                             write_MPLS_S1
''---------------------------------------------------------------------------------
'' NUM_LABELS                                 [26:24]          get_NUM_LABELS
''                                                             set_NUM_LABELS
''                                                             read_NUM_LABELS
''                                                             write_NUM_LABELS
''---------------------------------------------------------------------------------
'' MPLS_VALID1                                [31:31]          get_MPLS_VALID1
''                                                             set_MPLS_VALID1
''                                                             read_MPLS_VALID1
''                                                             write_MPLS_VALID1
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_mpls_debug1
    Private write_MPLS_LABEL1_value
    Private read_MPLS_LABEL1_value
    Private flag_MPLS_LABEL1
    Private write_MPLS_EXP1_value
    Private read_MPLS_EXP1_value
    Private flag_MPLS_EXP1
    Private write_MPLS_S1_value
    Private read_MPLS_S1_value
    Private flag_MPLS_S1
    Private write_NUM_LABELS_value
    Private read_NUM_LABELS_value
    Private flag_NUM_LABELS
    Private write_MPLS_VALID1_value
    Private read_MPLS_VALID1_value
    Private flag_MPLS_VALID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MPLS_LABEL1
        get_MPLS_LABEL1 = read_MPLS_LABEL1_value
    End Property

    Property Let set_MPLS_LABEL1(aData)
        write_MPLS_LABEL1_value = aData
        flag_MPLS_LABEL1        = &H1
    End Property

    Property Get read_MPLS_LABEL1
        read
        read_MPLS_LABEL1 = read_MPLS_LABEL1_value
    End Property

    Property Let write_MPLS_LABEL1(aData)
        set_MPLS_LABEL1 = aData
        write
    End Property

    Property Get get_MPLS_EXP1
        get_MPLS_EXP1 = read_MPLS_EXP1_value
    End Property

    Property Let set_MPLS_EXP1(aData)
        write_MPLS_EXP1_value = aData
        flag_MPLS_EXP1        = &H1
    End Property

    Property Get read_MPLS_EXP1
        read
        read_MPLS_EXP1 = read_MPLS_EXP1_value
    End Property

    Property Let write_MPLS_EXP1(aData)
        set_MPLS_EXP1 = aData
        write
    End Property

    Property Get get_MPLS_S1
        get_MPLS_S1 = read_MPLS_S1_value
    End Property

    Property Let set_MPLS_S1(aData)
        write_MPLS_S1_value = aData
        flag_MPLS_S1        = &H1
    End Property

    Property Get read_MPLS_S1
        read
        read_MPLS_S1 = read_MPLS_S1_value
    End Property

    Property Let write_MPLS_S1(aData)
        set_MPLS_S1 = aData
        write
    End Property

    Property Get get_NUM_LABELS
        get_NUM_LABELS = read_NUM_LABELS_value
    End Property

    Property Let set_NUM_LABELS(aData)
        write_NUM_LABELS_value = aData
        flag_NUM_LABELS        = &H1
    End Property

    Property Get read_NUM_LABELS
        read
        read_NUM_LABELS = read_NUM_LABELS_value
    End Property

    Property Let write_NUM_LABELS(aData)
        set_NUM_LABELS = aData
        write
    End Property

    Property Get get_MPLS_VALID1
        get_MPLS_VALID1 = read_MPLS_VALID1_value
    End Property

    Property Let set_MPLS_VALID1(aData)
        write_MPLS_VALID1_value = aData
        flag_MPLS_VALID1        = &H1
    End Property

    Property Get read_MPLS_VALID1
        read
        read_MPLS_VALID1 = read_MPLS_VALID1_value
    End Property

    Property Let write_MPLS_VALID1(aData)
        set_MPLS_VALID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MPLS_LABEL1_mask = &Hfffff
        if data_low > LONG_MAX then
            if MPLS_LABEL1_mask = mask then
                read_MPLS_LABEL1_value = data_low
            else
                read_MPLS_LABEL1_value = (data_low - H8000_0000) and MPLS_LABEL1_mask
            end If
        else
            read_MPLS_LABEL1_value = data_low and MPLS_LABEL1_mask
        end If
        read_MPLS_EXP1_value = rightShift(data_low, 20) and &H7
        read_MPLS_S1_value = rightShift(data_low, 23) and &H1
        read_NUM_LABELS_value = rightShift(data_low, 24) and &H7
        read_MPLS_VALID1_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_MPLS_LABEL1 = &H0 or flag_MPLS_EXP1 = &H0 or flag_MPLS_S1 = &H0 or flag_NUM_LABELS = &H0 or flag_MPLS_VALID1 = &H0 Then read
        If flag_MPLS_LABEL1 = &H0 Then write_MPLS_LABEL1_value = get_MPLS_LABEL1
        If flag_MPLS_EXP1 = &H0 Then write_MPLS_EXP1_value = get_MPLS_EXP1
        If flag_MPLS_S1 = &H0 Then write_MPLS_S1_value = get_MPLS_S1
        If flag_NUM_LABELS = &H0 Then write_NUM_LABELS_value = get_NUM_LABELS
        If flag_MPLS_VALID1 = &H0 Then write_MPLS_VALID1_value = get_MPLS_VALID1

        regValue = leftShift((write_MPLS_LABEL1_value and &Hfffff), 0) + leftShift((write_MPLS_EXP1_value and &H7), 20) + leftShift((write_MPLS_S1_value and &H1), 23) + leftShift((write_NUM_LABELS_value and &H7), 24) + leftShift((write_MPLS_VALID1_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MPLS_LABEL1_mask = &Hfffff
        if data_low > LONG_MAX then
            if MPLS_LABEL1_mask = mask then
                read_MPLS_LABEL1_value = data_low
            else
                read_MPLS_LABEL1_value = (data_low - H8000_0000) and MPLS_LABEL1_mask
            end If
        else
            read_MPLS_LABEL1_value = data_low and MPLS_LABEL1_mask
        end If
        read_MPLS_EXP1_value = rightShift(data_low, 20) and &H7
        read_MPLS_S1_value = rightShift(data_low, 23) and &H1
        read_NUM_LABELS_value = rightShift(data_low, 24) and &H7
        read_MPLS_VALID1_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MPLS_LABEL1_value = &H0
        flag_MPLS_LABEL1        = &H0
        write_MPLS_EXP1_value = &H0
        flag_MPLS_EXP1        = &H0
        write_MPLS_S1_value = &H0
        flag_MPLS_S1        = &H0
        write_NUM_LABELS_value = &H0
        flag_NUM_LABELS        = &H0
        write_MPLS_VALID1_value = &H0
        flag_MPLS_VALID1        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_mpls_debug2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MPLS_LABEL2                                [19:0]           get_MPLS_LABEL2
''                                                             set_MPLS_LABEL2
''                                                             read_MPLS_LABEL2
''                                                             write_MPLS_LABEL2
''---------------------------------------------------------------------------------
'' MPLS_EXP2                                  [22:20]          get_MPLS_EXP2
''                                                             set_MPLS_EXP2
''                                                             read_MPLS_EXP2
''                                                             write_MPLS_EXP2
''---------------------------------------------------------------------------------
'' MPLS_S2                                    [23:23]          get_MPLS_S2
''                                                             set_MPLS_S2
''                                                             read_MPLS_S2
''                                                             write_MPLS_S2
''---------------------------------------------------------------------------------
'' ECP                                        [29:29]          get_ECP
''                                                             set_ECP
''                                                             read_ECP
''                                                             write_ECP
''---------------------------------------------------------------------------------
'' FCW                                        [30:30]          get_FCW
''                                                             set_FCW
''                                                             read_FCW
''                                                             write_FCW
''---------------------------------------------------------------------------------
'' FLOW_EOMPLS                                [31:31]          get_FLOW_EOMPLS
''                                                             set_FLOW_EOMPLS
''                                                             read_FLOW_EOMPLS
''                                                             write_FLOW_EOMPLS
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_mpls_debug2
    Private write_MPLS_LABEL2_value
    Private read_MPLS_LABEL2_value
    Private flag_MPLS_LABEL2
    Private write_MPLS_EXP2_value
    Private read_MPLS_EXP2_value
    Private flag_MPLS_EXP2
    Private write_MPLS_S2_value
    Private read_MPLS_S2_value
    Private flag_MPLS_S2
    Private write_ECP_value
    Private read_ECP_value
    Private flag_ECP
    Private write_FCW_value
    Private read_FCW_value
    Private flag_FCW
    Private write_FLOW_EOMPLS_value
    Private read_FLOW_EOMPLS_value
    Private flag_FLOW_EOMPLS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17c98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MPLS_LABEL2
        get_MPLS_LABEL2 = read_MPLS_LABEL2_value
    End Property

    Property Let set_MPLS_LABEL2(aData)
        write_MPLS_LABEL2_value = aData
        flag_MPLS_LABEL2        = &H1
    End Property

    Property Get read_MPLS_LABEL2
        read
        read_MPLS_LABEL2 = read_MPLS_LABEL2_value
    End Property

    Property Let write_MPLS_LABEL2(aData)
        set_MPLS_LABEL2 = aData
        write
    End Property

    Property Get get_MPLS_EXP2
        get_MPLS_EXP2 = read_MPLS_EXP2_value
    End Property

    Property Let set_MPLS_EXP2(aData)
        write_MPLS_EXP2_value = aData
        flag_MPLS_EXP2        = &H1
    End Property

    Property Get read_MPLS_EXP2
        read
        read_MPLS_EXP2 = read_MPLS_EXP2_value
    End Property

    Property Let write_MPLS_EXP2(aData)
        set_MPLS_EXP2 = aData
        write
    End Property

    Property Get get_MPLS_S2
        get_MPLS_S2 = read_MPLS_S2_value
    End Property

    Property Let set_MPLS_S2(aData)
        write_MPLS_S2_value = aData
        flag_MPLS_S2        = &H1
    End Property

    Property Get read_MPLS_S2
        read
        read_MPLS_S2 = read_MPLS_S2_value
    End Property

    Property Let write_MPLS_S2(aData)
        set_MPLS_S2 = aData
        write
    End Property

    Property Get get_ECP
        get_ECP = read_ECP_value
    End Property

    Property Let set_ECP(aData)
        write_ECP_value = aData
        flag_ECP        = &H1
    End Property

    Property Get read_ECP
        read
        read_ECP = read_ECP_value
    End Property

    Property Let write_ECP(aData)
        set_ECP = aData
        write
    End Property

    Property Get get_FCW
        get_FCW = read_FCW_value
    End Property

    Property Let set_FCW(aData)
        write_FCW_value = aData
        flag_FCW        = &H1
    End Property

    Property Get read_FCW
        read
        read_FCW = read_FCW_value
    End Property

    Property Let write_FCW(aData)
        set_FCW = aData
        write
    End Property

    Property Get get_FLOW_EOMPLS
        get_FLOW_EOMPLS = read_FLOW_EOMPLS_value
    End Property

    Property Let set_FLOW_EOMPLS(aData)
        write_FLOW_EOMPLS_value = aData
        flag_FLOW_EOMPLS        = &H1
    End Property

    Property Get read_FLOW_EOMPLS
        read
        read_FLOW_EOMPLS = read_FLOW_EOMPLS_value
    End Property

    Property Let write_FLOW_EOMPLS(aData)
        set_FLOW_EOMPLS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MPLS_LABEL2_mask = &Hfffff
        if data_low > LONG_MAX then
            if MPLS_LABEL2_mask = mask then
                read_MPLS_LABEL2_value = data_low
            else
                read_MPLS_LABEL2_value = (data_low - H8000_0000) and MPLS_LABEL2_mask
            end If
        else
            read_MPLS_LABEL2_value = data_low and MPLS_LABEL2_mask
        end If
        read_MPLS_EXP2_value = rightShift(data_low, 20) and &H7
        read_MPLS_S2_value = rightShift(data_low, 23) and &H1
        read_ECP_value = rightShift(data_low, 29) and &H1
        read_FCW_value = rightShift(data_low, 30) and &H1
        read_FLOW_EOMPLS_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_MPLS_LABEL2 = &H0 or flag_MPLS_EXP2 = &H0 or flag_MPLS_S2 = &H0 or flag_ECP = &H0 or flag_FCW = &H0 or flag_FLOW_EOMPLS = &H0 Then read
        If flag_MPLS_LABEL2 = &H0 Then write_MPLS_LABEL2_value = get_MPLS_LABEL2
        If flag_MPLS_EXP2 = &H0 Then write_MPLS_EXP2_value = get_MPLS_EXP2
        If flag_MPLS_S2 = &H0 Then write_MPLS_S2_value = get_MPLS_S2
        If flag_ECP = &H0 Then write_ECP_value = get_ECP
        If flag_FCW = &H0 Then write_FCW_value = get_FCW
        If flag_FLOW_EOMPLS = &H0 Then write_FLOW_EOMPLS_value = get_FLOW_EOMPLS

        regValue = leftShift((write_MPLS_LABEL2_value and &Hfffff), 0) + leftShift((write_MPLS_EXP2_value and &H7), 20) + leftShift((write_MPLS_S2_value and &H1), 23) + leftShift((write_ECP_value and &H1), 29) + leftShift((write_FCW_value and &H1), 30) + leftShift((write_FLOW_EOMPLS_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MPLS_LABEL2_mask = &Hfffff
        if data_low > LONG_MAX then
            if MPLS_LABEL2_mask = mask then
                read_MPLS_LABEL2_value = data_low
            else
                read_MPLS_LABEL2_value = (data_low - H8000_0000) and MPLS_LABEL2_mask
            end If
        else
            read_MPLS_LABEL2_value = data_low and MPLS_LABEL2_mask
        end If
        read_MPLS_EXP2_value = rightShift(data_low, 20) and &H7
        read_MPLS_S2_value = rightShift(data_low, 23) and &H1
        read_ECP_value = rightShift(data_low, 29) and &H1
        read_FCW_value = rightShift(data_low, 30) and &H1
        read_FLOW_EOMPLS_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MPLS_LABEL2_value = &H0
        flag_MPLS_LABEL2        = &H0
        write_MPLS_EXP2_value = &H0
        flag_MPLS_EXP2        = &H0
        write_MPLS_S2_value = &H0
        flag_MPLS_S2        = &H0
        write_ECP_value = &H0
        flag_ECP        = &H0
        write_FCW_value = &H0
        flag_FCW        = &H0
        write_FLOW_EOMPLS_value = &H0
        flag_FLOW_EOMPLS        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_da_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PED310                                     [31:0]           get_PED310
''                                                             set_PED310
''                                                             read_PED310
''                                                             write_PED310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_da_lo
    Private write_PED310_value
    Private read_PED310_value
    Private flag_PED310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17ca0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PED310
        get_PED310 = read_PED310_value
    End Property

    Property Let set_PED310(aData)
        write_PED310_value = aData
        flag_PED310        = &H1
    End Property

    Property Get read_PED310
        read
        read_PED310 = read_PED310_value
    End Property

    Property Let write_PED310(aData)
        set_PED310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PED310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PED310_mask = mask then
                read_PED310_value = data_low
            else
                read_PED310_value = (data_low - H8000_0000) and PED310_mask
            end If
        else
            read_PED310_value = data_low and PED310_mask
        end If

    End Sub

    Sub write
        If flag_PED310 = &H0 Then read
        If flag_PED310 = &H0 Then write_PED310_value = get_PED310

        regValue = leftShift(write_PED310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PED310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PED310_mask = mask then
                read_PED310_value = data_low
            else
                read_PED310_value = (data_low - H8000_0000) and PED310_mask
            end If
        else
            read_PED310_value = data_low and PED310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PED310_value = &H0
        flag_PED310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_da_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PED4732                                    [15:0]           get_PED4732
''                                                             set_PED4732
''                                                             read_PED4732
''                                                             write_PED4732
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_da_hi
    Private write_PED4732_value
    Private read_PED4732_value
    Private flag_PED4732

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17ca4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PED4732
        get_PED4732 = read_PED4732_value
    End Property

    Property Let set_PED4732(aData)
        write_PED4732_value = aData
        flag_PED4732        = &H1
    End Property

    Property Get read_PED4732
        read
        read_PED4732 = read_PED4732_value
    End Property

    Property Let write_PED4732(aData)
        set_PED4732 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PED4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PED4732_mask = mask then
                read_PED4732_value = data_low
            else
                read_PED4732_value = (data_low - H8000_0000) and PED4732_mask
            end If
        else
            read_PED4732_value = data_low and PED4732_mask
        end If

    End Sub

    Sub write
        If flag_PED4732 = &H0 Then read
        If flag_PED4732 = &H0 Then write_PED4732_value = get_PED4732

        regValue = leftShift((write_PED4732_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PED4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PED4732_mask = mask then
                read_PED4732_value = data_low
            else
                read_PED4732_value = (data_low - H8000_0000) and PED4732_mask
            end If
        else
            read_PED4732_value = data_low and PED4732_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PED4732_value = &H0
        flag_PED4732        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_sa_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PEOET                                      [31:16]          get_PEOET
''                                                             set_PEOET
''                                                             read_PEOET
''                                                             write_PEOET
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_sa_hi
    Private write_PEOET_value
    Private read_PEOET_value
    Private flag_PEOET

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17cac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PEOET
        get_PEOET = read_PEOET_value
    End Property

    Property Let set_PEOET(aData)
        write_PEOET_value = aData
        flag_PEOET        = &H1
    End Property

    Property Get read_PEOET
        read
        read_PEOET = read_PEOET_value
    End Property

    Property Let write_PEOET(aData)
        set_PEOET = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PEOET_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_PEOET = &H0 Then read
        If flag_PEOET = &H0 Then write_PEOET_value = get_PEOET

        regValue = leftShift((write_PEOET_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PEOET_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PEOET_value = &H0
        flag_PEOET        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_mpls_sectag_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PS310                                      [31:0]           get_PS310
''                                                             set_PS310
''                                                             read_PS310
''                                                             write_PS310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_mpls_sectag_lo
    Private write_PS310_value
    Private read_PS310_value
    Private flag_PS310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17cb0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PS310
        get_PS310 = read_PS310_value
    End Property

    Property Let set_PS310(aData)
        write_PS310_value = aData
        flag_PS310        = &H1
    End Property

    Property Get read_PS310
        read
        read_PS310 = read_PS310_value
    End Property

    Property Let write_PS310(aData)
        set_PS310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS310_mask = mask then
                read_PS310_value = data_low
            else
                read_PS310_value = (data_low - H8000_0000) and PS310_mask
            end If
        else
            read_PS310_value = data_low and PS310_mask
        end If

    End Sub

    Sub write
        If flag_PS310 = &H0 Then read
        If flag_PS310 = &H0 Then write_PS310_value = get_PS310

        regValue = leftShift(write_PS310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS310_mask = mask then
                read_PS310_value = data_low
            else
                read_PS310_value = (data_low - H8000_0000) and PS310_mask
            end If
        else
            read_PS310_value = data_low and PS310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PS310_value = &H0
        flag_PS310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_mpls_sectag_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PS6332                                     [31:0]           get_PS6332
''                                                             set_PS6332
''                                                             read_PS6332
''                                                             write_PS6332
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_mpls_sectag_hi
    Private write_PS6332_value
    Private read_PS6332_value
    Private flag_PS6332

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17cb4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PS6332
        get_PS6332 = read_PS6332_value
    End Property

    Property Let set_PS6332(aData)
        write_PS6332_value = aData
        flag_PS6332        = &H1
    End Property

    Property Get read_PS6332
        read
        read_PS6332 = read_PS6332_value
    End Property

    Property Let write_PS6332(aData)
        set_PS6332 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS6332_mask = mask then
                read_PS6332_value = data_low
            else
                read_PS6332_value = (data_low - H8000_0000) and PS6332_mask
            end If
        else
            read_PS6332_value = data_low and PS6332_mask
        end If

    End Sub

    Sub write
        If flag_PS6332 = &H0 Then read
        If flag_PS6332 = &H0 Then write_PS6332_value = get_PS6332

        regValue = leftShift(write_PS6332_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS6332_mask = mask then
                read_PS6332_value = data_low
            else
                read_PS6332_value = (data_low - H8000_0000) and PS6332_mask
            end If
        else
            read_PS6332_value = data_low and PS6332_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PS6332_value = &H0
        flag_PS6332        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_da_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMD310                                     [31:0]           get_PMD310
''                                                             set_PMD310
''                                                             read_PMD310
''                                                             write_PMD310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_da_lo
    Private write_PMD310_value
    Private read_PMD310_value
    Private flag_PMD310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMD310
        get_PMD310 = read_PMD310_value
    End Property

    Property Let set_PMD310(aData)
        write_PMD310_value = aData
        flag_PMD310        = &H1
    End Property

    Property Get read_PMD310
        read
        read_PMD310 = read_PMD310_value
    End Property

    Property Let write_PMD310(aData)
        set_PMD310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMD310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PMD310_mask = mask then
                read_PMD310_value = data_low
            else
                read_PMD310_value = (data_low - H8000_0000) and PMD310_mask
            end If
        else
            read_PMD310_value = data_low and PMD310_mask
        end If

    End Sub

    Sub write
        If flag_PMD310 = &H0 Then read
        If flag_PMD310 = &H0 Then write_PMD310_value = get_PMD310

        regValue = leftShift(write_PMD310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMD310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PMD310_mask = mask then
                read_PMD310_value = data_low
            else
                read_PMD310_value = (data_low - H8000_0000) and PMD310_mask
            end If
        else
            read_PMD310_value = data_low and PMD310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMD310_value = &H0
        flag_PMD310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_da_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMD4732                                    [15:0]           get_PMD4732
''                                                             set_PMD4732
''                                                             read_PMD4732
''                                                             write_PMD4732
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_da_hi
    Private write_PMD4732_value
    Private read_PMD4732_value
    Private flag_PMD4732

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMD4732
        get_PMD4732 = read_PMD4732_value
    End Property

    Property Let set_PMD4732(aData)
        write_PMD4732_value = aData
        flag_PMD4732        = &H1
    End Property

    Property Get read_PMD4732
        read
        read_PMD4732 = read_PMD4732_value
    End Property

    Property Let write_PMD4732(aData)
        set_PMD4732 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMD4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PMD4732_mask = mask then
                read_PMD4732_value = data_low
            else
                read_PMD4732_value = (data_low - H8000_0000) and PMD4732_mask
            end If
        else
            read_PMD4732_value = data_low and PMD4732_mask
        end If

    End Sub

    Sub write
        If flag_PMD4732 = &H0 Then read
        If flag_PMD4732 = &H0 Then write_PMD4732_value = get_PMD4732

        regValue = leftShift((write_PMD4732_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMD4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PMD4732_mask = mask then
                read_PMD4732_value = data_low
            else
                read_PMD4732_value = (data_low - H8000_0000) and PMD4732_mask
            end If
        else
            read_PMD4732_value = data_low and PMD4732_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMD4732_value = &H0
        flag_PMD4732        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sa_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMS310                                     [31:0]           get_PMS310
''                                                             set_PMS310
''                                                             read_PMS310
''                                                             write_PMS310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sa_lo
    Private write_PMS310_value
    Private read_PMS310_value
    Private flag_PMS310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMS310
        get_PMS310 = read_PMS310_value
    End Property

    Property Let set_PMS310(aData)
        write_PMS310_value = aData
        flag_PMS310        = &H1
    End Property

    Property Get read_PMS310
        read
        read_PMS310 = read_PMS310_value
    End Property

    Property Let write_PMS310(aData)
        set_PMS310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMS310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PMS310_mask = mask then
                read_PMS310_value = data_low
            else
                read_PMS310_value = (data_low - H8000_0000) and PMS310_mask
            end If
        else
            read_PMS310_value = data_low and PMS310_mask
        end If

    End Sub

    Sub write
        If flag_PMS310 = &H0 Then read
        If flag_PMS310 = &H0 Then write_PMS310_value = get_PMS310

        regValue = leftShift(write_PMS310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMS310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PMS310_mask = mask then
                read_PMS310_value = data_low
            else
                read_PMS310_value = (data_low - H8000_0000) and PMS310_mask
            end If
        else
            read_PMS310_value = data_low and PMS310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMS310_value = &H0
        flag_PMS310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sa_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMS4732                                    [15:0]           get_PMS4732
''                                                             set_PMS4732
''                                                             read_PMS4732
''                                                             write_PMS4732
''---------------------------------------------------------------------------------
'' ORIG_ETH_TYPE                              [31:16]          get_ORIG_ETH_TYPE
''                                                             set_ORIG_ETH_TYPE
''                                                             read_ORIG_ETH_TYPE
''                                                             write_ORIG_ETH_TYPE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sa_hi
    Private write_PMS4732_value
    Private read_PMS4732_value
    Private flag_PMS4732
    Private write_ORIG_ETH_TYPE_value
    Private read_ORIG_ETH_TYPE_value
    Private flag_ORIG_ETH_TYPE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMS4732
        get_PMS4732 = read_PMS4732_value
    End Property

    Property Let set_PMS4732(aData)
        write_PMS4732_value = aData
        flag_PMS4732        = &H1
    End Property

    Property Get read_PMS4732
        read
        read_PMS4732 = read_PMS4732_value
    End Property

    Property Let write_PMS4732(aData)
        set_PMS4732 = aData
        write
    End Property

    Property Get get_ORIG_ETH_TYPE
        get_ORIG_ETH_TYPE = read_ORIG_ETH_TYPE_value
    End Property

    Property Let set_ORIG_ETH_TYPE(aData)
        write_ORIG_ETH_TYPE_value = aData
        flag_ORIG_ETH_TYPE        = &H1
    End Property

    Property Get read_ORIG_ETH_TYPE
        read
        read_ORIG_ETH_TYPE = read_ORIG_ETH_TYPE_value
    End Property

    Property Let write_ORIG_ETH_TYPE(aData)
        set_ORIG_ETH_TYPE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMS4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PMS4732_mask = mask then
                read_PMS4732_value = data_low
            else
                read_PMS4732_value = (data_low - H8000_0000) and PMS4732_mask
            end If
        else
            read_PMS4732_value = data_low and PMS4732_mask
        end If
        read_ORIG_ETH_TYPE_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_PMS4732 = &H0 or flag_ORIG_ETH_TYPE = &H0 Then read
        If flag_PMS4732 = &H0 Then write_PMS4732_value = get_PMS4732
        If flag_ORIG_ETH_TYPE = &H0 Then write_ORIG_ETH_TYPE_value = get_ORIG_ETH_TYPE

        regValue = leftShift((write_PMS4732_value and &Hffff), 0) + leftShift((write_ORIG_ETH_TYPE_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PMS4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PMS4732_mask = mask then
                read_PMS4732_value = data_low
            else
                read_PMS4732_value = (data_low - H8000_0000) and PMS4732_mask
            end If
        else
            read_PMS4732_value = data_low and PMS4732_mask
        end If
        read_ORIG_ETH_TYPE_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMS4732_value = &H0
        flag_PMS4732        = &H0
        write_ORIG_ETH_TYPE_value = &H0
        flag_ORIG_ETH_TYPE        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sectag_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PS310                                      [31:0]           get_PS310
''                                                             set_PS310
''                                                             read_PS310
''                                                             write_PS310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sectag_lo
    Private write_PS310_value
    Private read_PS310_value
    Private flag_PS310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PS310
        get_PS310 = read_PS310_value
    End Property

    Property Let set_PS310(aData)
        write_PS310_value = aData
        flag_PS310        = &H1
    End Property

    Property Get read_PS310
        read
        read_PS310 = read_PS310_value
    End Property

    Property Let write_PS310(aData)
        set_PS310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS310_mask = mask then
                read_PS310_value = data_low
            else
                read_PS310_value = (data_low - H8000_0000) and PS310_mask
            end If
        else
            read_PS310_value = data_low and PS310_mask
        end If

    End Sub

    Sub write
        If flag_PS310 = &H0 Then read
        If flag_PS310 = &H0 Then write_PS310_value = get_PS310

        regValue = leftShift(write_PS310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS310_mask = mask then
                read_PS310_value = data_low
            else
                read_PS310_value = (data_low - H8000_0000) and PS310_mask
            end If
        else
            read_PS310_value = data_low and PS310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PS310_value = &H0
        flag_PS310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sectag_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PS6332                                     [31:0]           get_PS6332
''                                                             set_PS6332
''                                                             read_PS6332
''                                                             write_PS6332
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sectag_hi
    Private write_PS6332_value
    Private read_PS6332_value
    Private flag_PS6332

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PS6332
        get_PS6332 = read_PS6332_value
    End Property

    Property Let set_PS6332(aData)
        write_PS6332_value = aData
        flag_PS6332        = &H1
    End Property

    Property Get read_PS6332
        read
        read_PS6332 = read_PS6332_value
    End Property

    Property Let write_PS6332(aData)
        set_PS6332 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS6332_mask = mask then
                read_PS6332_value = data_low
            else
                read_PS6332_value = (data_low - H8000_0000) and PS6332_mask
            end If
        else
            read_PS6332_value = data_low and PS6332_mask
        end If

    End Sub

    Sub write
        If flag_PS6332 = &H0 Then read
        If flag_PS6332 = &H0 Then write_PS6332_value = get_PS6332

        regValue = leftShift(write_PS6332_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS6332_mask = mask then
                read_PS6332_value = data_low
            else
                read_PS6332_value = (data_low - H8000_0000) and PS6332_mask
            end If
        else
            read_PS6332_value = data_low and PS6332_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PS6332_value = &H0
        flag_PS6332        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sci_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PARS_SCI_31_0                              [31:0]           get_PARS_SCI_31_0
''                                                             set_PARS_SCI_31_0
''                                                             read_PARS_SCI_31_0
''                                                             write_PARS_SCI_31_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sci_lo
    Private write_PARS_SCI_31_0_value
    Private read_PARS_SCI_31_0_value
    Private flag_PARS_SCI_31_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PARS_SCI_31_0
        get_PARS_SCI_31_0 = read_PARS_SCI_31_0_value
    End Property

    Property Let set_PARS_SCI_31_0(aData)
        write_PARS_SCI_31_0_value = aData
        flag_PARS_SCI_31_0        = &H1
    End Property

    Property Get read_PARS_SCI_31_0
        read
        read_PARS_SCI_31_0 = read_PARS_SCI_31_0_value
    End Property

    Property Let write_PARS_SCI_31_0(aData)
        set_PARS_SCI_31_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PARS_SCI_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PARS_SCI_31_0_mask = mask then
                read_PARS_SCI_31_0_value = data_low
            else
                read_PARS_SCI_31_0_value = (data_low - H8000_0000) and PARS_SCI_31_0_mask
            end If
        else
            read_PARS_SCI_31_0_value = data_low and PARS_SCI_31_0_mask
        end If

    End Sub

    Sub write
        If flag_PARS_SCI_31_0 = &H0 Then read
        If flag_PARS_SCI_31_0 = &H0 Then write_PARS_SCI_31_0_value = get_PARS_SCI_31_0

        regValue = leftShift(write_PARS_SCI_31_0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PARS_SCI_31_0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PARS_SCI_31_0_mask = mask then
                read_PARS_SCI_31_0_value = data_low
            else
                read_PARS_SCI_31_0_value = (data_low - H8000_0000) and PARS_SCI_31_0_mask
            end If
        else
            read_PARS_SCI_31_0_value = data_low and PARS_SCI_31_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PARS_SCI_31_0_value = &H0
        flag_PARS_SCI_31_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sci_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PS6332                                     [31:0]           get_PS6332
''                                                             set_PS6332
''                                                             read_PS6332
''                                                             write_PS6332
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sci_hi
    Private write_PS6332_value
    Private read_PS6332_value
    Private flag_PS6332

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PS6332
        get_PS6332 = read_PS6332_value
    End Property

    Property Let set_PS6332(aData)
        write_PS6332_value = aData
        flag_PS6332        = &H1
    End Property

    Property Get read_PS6332
        read
        read_PS6332 = read_PS6332_value
    End Property

    Property Let write_PS6332(aData)
        set_PS6332 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS6332_mask = mask then
                read_PS6332_value = data_low
            else
                read_PS6332_value = (data_low - H8000_0000) and PS6332_mask
            end If
        else
            read_PS6332_value = data_low and PS6332_mask
        end If

    End Sub

    Sub write
        If flag_PS6332 = &H0 Then read
        If flag_PS6332 = &H0 Then write_PS6332_value = get_PS6332

        regValue = leftShift(write_PS6332_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PS6332_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PS6332_mask = mask then
                read_PS6332_value = data_low
            else
                read_PS6332_value = (data_low - H8000_0000) and PS6332_mask
            end If
        else
            read_PS6332_value = data_low and PS6332_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PS6332_value = &H0
        flag_PS6332        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_flow_lookup
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLOW_LOOK_RES                              [31:0]           get_FLOW_LOOK_RES
''                                                             set_FLOW_LOOK_RES
''                                                             read_FLOW_LOOK_RES
''                                                             write_FLOW_LOOK_RES
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_flow_lookup
    Private write_FLOW_LOOK_RES_value
    Private read_FLOW_LOOK_RES_value
    Private flag_FLOW_LOOK_RES

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FLOW_LOOK_RES
        get_FLOW_LOOK_RES = read_FLOW_LOOK_RES_value
    End Property

    Property Let set_FLOW_LOOK_RES(aData)
        write_FLOW_LOOK_RES_value = aData
        flag_FLOW_LOOK_RES        = &H1
    End Property

    Property Get read_FLOW_LOOK_RES
        read
        read_FLOW_LOOK_RES = read_FLOW_LOOK_RES_value
    End Property

    Property Let write_FLOW_LOOK_RES(aData)
        set_FLOW_LOOK_RES = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLOW_LOOK_RES_mask = &Hffffffff
        if data_low > LONG_MAX then
            if FLOW_LOOK_RES_mask = mask then
                read_FLOW_LOOK_RES_value = data_low
            else
                read_FLOW_LOOK_RES_value = (data_low - H8000_0000) and FLOW_LOOK_RES_mask
            end If
        else
            read_FLOW_LOOK_RES_value = data_low and FLOW_LOOK_RES_mask
        end If

    End Sub

    Sub write
        If flag_FLOW_LOOK_RES = &H0 Then read
        If flag_FLOW_LOOK_RES = &H0 Then write_FLOW_LOOK_RES_value = get_FLOW_LOOK_RES

        regValue = leftShift(write_FLOW_LOOK_RES_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLOW_LOOK_RES_mask = &Hffffffff
        if data_low > LONG_MAX then
            if FLOW_LOOK_RES_mask = mask then
                read_FLOW_LOOK_RES_value = data_low
            else
                read_FLOW_LOOK_RES_value = (data_low - H8000_0000) and FLOW_LOOK_RES_mask
            end If
        else
            read_FLOW_LOOK_RES_value = data_low and FLOW_LOOK_RES_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLOW_LOOK_RES_value = &H0
        flag_FLOW_LOOK_RES        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_sa_update
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SUCW                                       [31:0]           get_SUCW
''                                                             set_SUCW
''                                                             read_SUCW
''                                                             write_SUCW
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_sa_update
    Private write_SUCW_value
    Private read_SUCW_value
    Private flag_SUCW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d24
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SUCW
        get_SUCW = read_SUCW_value
    End Property

    Property Let set_SUCW(aData)
        write_SUCW_value = aData
        flag_SUCW        = &H1
    End Property

    Property Get read_SUCW
        read
        read_SUCW = read_SUCW_value
    End Property

    Property Let write_SUCW(aData)
        set_SUCW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SUCW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SUCW_mask = mask then
                read_SUCW_value = data_low
            else
                read_SUCW_value = (data_low - H8000_0000) and SUCW_mask
            end If
        else
            read_SUCW_value = data_low and SUCW_mask
        end If

    End Sub

    Sub write
        If flag_SUCW = &H0 Then read
        If flag_SUCW = &H0 Then write_SUCW_value = get_SUCW

        regValue = leftShift(write_SUCW_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SUCW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if SUCW_mask = mask then
                read_SUCW_value = data_low
            else
                read_SUCW_value = (data_low - H8000_0000) and SUCW_mask
            end If
        else
            read_SUCW_value = data_low and SUCW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SUCW_value = &H0
        flag_SUCW        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_atok_debug_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ATOK_WORD                                  [31:0]           get_ATOK_WORD
''                                                             set_ATOK_WORD
''                                                             read_ATOK_WORD
''                                                             write_ATOK_WORD
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_atok_debug_0
    Private write_ATOK_WORD_value
    Private read_ATOK_WORD_value
    Private flag_ATOK_WORD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ATOK_WORD
        get_ATOK_WORD = read_ATOK_WORD_value
    End Property

    Property Let set_ATOK_WORD(aData)
        write_ATOK_WORD_value = aData
        flag_ATOK_WORD        = &H1
    End Property

    Property Get read_ATOK_WORD
        read
        read_ATOK_WORD = read_ATOK_WORD_value
    End Property

    Property Let write_ATOK_WORD(aData)
        set_ATOK_WORD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ATOK_WORD_mask = &Hffffffff
        if data_low > LONG_MAX then
            if ATOK_WORD_mask = mask then
                read_ATOK_WORD_value = data_low
            else
                read_ATOK_WORD_value = (data_low - H8000_0000) and ATOK_WORD_mask
            end If
        else
            read_ATOK_WORD_value = data_low and ATOK_WORD_mask
        end If

    End Sub

    Sub write
        If flag_ATOK_WORD = &H0 Then read
        If flag_ATOK_WORD = &H0 Then write_ATOK_WORD_value = get_ATOK_WORD

        regValue = leftShift(write_ATOK_WORD_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ATOK_WORD_mask = &Hffffffff
        if data_low > LONG_MAX then
            if ATOK_WORD_mask = mask then
                read_ATOK_WORD_value = data_low
            else
                read_ATOK_WORD_value = (data_low - H8000_0000) and ATOK_WORD_mask
            end If
        else
            read_ATOK_WORD_value = data_low and ATOK_WORD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ATOK_WORD_value = &H0
        flag_ATOK_WORD        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTW                                        [31:0]           get_CTW
''                                                             set_CTW
''                                                             read_CTW
''                                                             write_CTW
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_0
    Private write_CTW_value
    Private read_CTW_value
    Private flag_CTW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTW
        get_CTW = read_CTW_value
    End Property

    Property Let set_CTW(aData)
        write_CTW_value = aData
        flag_CTW        = &H1
    End Property

    Property Get read_CTW
        read
        read_CTW = read_CTW_value
    End Property

    Property Let write_CTW(aData)
        set_CTW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

    End Sub

    Sub write
        If flag_CTW = &H0 Then read
        If flag_CTW = &H0 Then write_CTW_value = get_CTW

        regValue = leftShift(write_CTW_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTW_value = &H0
        flag_CTW        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTW                                        [31:0]           get_CTW
''                                                             set_CTW
''                                                             read_CTW
''                                                             write_CTW
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_1
    Private write_CTW_value
    Private read_CTW_value
    Private flag_CTW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTW
        get_CTW = read_CTW_value
    End Property

    Property Let set_CTW(aData)
        write_CTW_value = aData
        flag_CTW        = &H1
    End Property

    Property Get read_CTW
        read
        read_CTW = read_CTW_value
    End Property

    Property Let write_CTW(aData)
        set_CTW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

    End Sub

    Sub write
        If flag_CTW = &H0 Then read
        If flag_CTW = &H0 Then write_CTW_value = get_CTW

        regValue = leftShift(write_CTW_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTW_value = &H0
        flag_CTW        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTW                                        [31:0]           get_CTW
''                                                             set_CTW
''                                                             read_CTW
''                                                             write_CTW
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_2
    Private write_CTW_value
    Private read_CTW_value
    Private flag_CTW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d38
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTW
        get_CTW = read_CTW_value
    End Property

    Property Let set_CTW(aData)
        write_CTW_value = aData
        flag_CTW        = &H1
    End Property

    Property Get read_CTW
        read
        read_CTW = read_CTW_value
    End Property

    Property Let write_CTW(aData)
        set_CTW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

    End Sub

    Sub write
        If flag_CTW = &H0 Then read
        If flag_CTW = &H0 Then write_CTW_value = get_CTW

        regValue = leftShift(write_CTW_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTW_value = &H0
        flag_CTW        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTW                                        [31:0]           get_CTW
''                                                             set_CTW
''                                                             read_CTW
''                                                             write_CTW
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_3
    Private write_CTW_value
    Private read_CTW_value
    Private flag_CTW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTW
        get_CTW = read_CTW_value
    End Property

    Property Let set_CTW(aData)
        write_CTW_value = aData
        flag_CTW        = &H1
    End Property

    Property Get read_CTW
        read
        read_CTW = read_CTW_value
    End Property

    Property Let write_CTW(aData)
        set_CTW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

    End Sub

    Sub write
        If flag_CTW = &H0 Then read
        If flag_CTW = &H0 Then write_CTW_value = get_CTW

        regValue = leftShift(write_CTW_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTW_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTW_mask = mask then
                read_CTW_value = data_low
            else
                read_CTW_value = (data_low - H8000_0000) and CTW_mask
            end If
        else
            read_CTW_value = data_low and CTW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTW_value = &H0
        flag_CTW        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_pbb_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PBB_BVID                                   [11:0]           get_PBB_BVID
''                                                             set_PBB_BVID
''                                                             read_PBB_BVID
''                                                             write_PBB_BVID
''---------------------------------------------------------------------------------
'' PBB_BPCP                                   [14:12]          get_PBB_BPCP
''                                                             set_PBB_BPCP
''                                                             read_PBB_BPCP
''                                                             write_PBB_BPCP
''---------------------------------------------------------------------------------
'' PBB_BDEI                                   [15:15]          get_PBB_BDEI
''                                                             set_PBB_BDEI
''                                                             read_PBB_BDEI
''                                                             write_PBB_BDEI
''---------------------------------------------------------------------------------
'' NUM_LABELS1                                [26:24]          get_NUM_LABELS1
''                                                             set_NUM_LABELS1
''                                                             read_NUM_LABELS1
''                                                             write_NUM_LABELS1
''---------------------------------------------------------------------------------
'' CONT_PACK1                                 [30:30]          get_CONT_PACK1
''                                                             set_CONT_PACK1
''                                                             read_CONT_PACK1
''                                                             write_CONT_PACK1
''---------------------------------------------------------------------------------
'' PBB_VALID1                                 [31:31]          get_PBB_VALID1
''                                                             set_PBB_VALID1
''                                                             read_PBB_VALID1
''                                                             write_PBB_VALID1
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_pbb_debug1
    Private write_PBB_BVID_value
    Private read_PBB_BVID_value
    Private flag_PBB_BVID
    Private write_PBB_BPCP_value
    Private read_PBB_BPCP_value
    Private flag_PBB_BPCP
    Private write_PBB_BDEI_value
    Private read_PBB_BDEI_value
    Private flag_PBB_BDEI
    Private write_NUM_LABELS1_value
    Private read_NUM_LABELS1_value
    Private flag_NUM_LABELS1
    Private write_CONT_PACK1_value
    Private read_CONT_PACK1_value
    Private flag_CONT_PACK1
    Private write_PBB_VALID1_value
    Private read_PBB_VALID1_value
    Private flag_PBB_VALID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PBB_BVID
        get_PBB_BVID = read_PBB_BVID_value
    End Property

    Property Let set_PBB_BVID(aData)
        write_PBB_BVID_value = aData
        flag_PBB_BVID        = &H1
    End Property

    Property Get read_PBB_BVID
        read
        read_PBB_BVID = read_PBB_BVID_value
    End Property

    Property Let write_PBB_BVID(aData)
        set_PBB_BVID = aData
        write
    End Property

    Property Get get_PBB_BPCP
        get_PBB_BPCP = read_PBB_BPCP_value
    End Property

    Property Let set_PBB_BPCP(aData)
        write_PBB_BPCP_value = aData
        flag_PBB_BPCP        = &H1
    End Property

    Property Get read_PBB_BPCP
        read
        read_PBB_BPCP = read_PBB_BPCP_value
    End Property

    Property Let write_PBB_BPCP(aData)
        set_PBB_BPCP = aData
        write
    End Property

    Property Get get_PBB_BDEI
        get_PBB_BDEI = read_PBB_BDEI_value
    End Property

    Property Let set_PBB_BDEI(aData)
        write_PBB_BDEI_value = aData
        flag_PBB_BDEI        = &H1
    End Property

    Property Get read_PBB_BDEI
        read
        read_PBB_BDEI = read_PBB_BDEI_value
    End Property

    Property Let write_PBB_BDEI(aData)
        set_PBB_BDEI = aData
        write
    End Property

    Property Get get_NUM_LABELS1
        get_NUM_LABELS1 = read_NUM_LABELS1_value
    End Property

    Property Let set_NUM_LABELS1(aData)
        write_NUM_LABELS1_value = aData
        flag_NUM_LABELS1        = &H1
    End Property

    Property Get read_NUM_LABELS1
        read
        read_NUM_LABELS1 = read_NUM_LABELS1_value
    End Property

    Property Let write_NUM_LABELS1(aData)
        set_NUM_LABELS1 = aData
        write
    End Property

    Property Get get_CONT_PACK1
        get_CONT_PACK1 = read_CONT_PACK1_value
    End Property

    Property Let set_CONT_PACK1(aData)
        write_CONT_PACK1_value = aData
        flag_CONT_PACK1        = &H1
    End Property

    Property Get read_CONT_PACK1
        read
        read_CONT_PACK1 = read_CONT_PACK1_value
    End Property

    Property Let write_CONT_PACK1(aData)
        set_CONT_PACK1 = aData
        write
    End Property

    Property Get get_PBB_VALID1
        get_PBB_VALID1 = read_PBB_VALID1_value
    End Property

    Property Let set_PBB_VALID1(aData)
        write_PBB_VALID1_value = aData
        flag_PBB_VALID1        = &H1
    End Property

    Property Get read_PBB_VALID1
        read
        read_PBB_VALID1 = read_PBB_VALID1_value
    End Property

    Property Let write_PBB_VALID1(aData)
        set_PBB_VALID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBB_BVID_mask = &Hfff
        if data_low > LONG_MAX then
            if PBB_BVID_mask = mask then
                read_PBB_BVID_value = data_low
            else
                read_PBB_BVID_value = (data_low - H8000_0000) and PBB_BVID_mask
            end If
        else
            read_PBB_BVID_value = data_low and PBB_BVID_mask
        end If
        read_PBB_BPCP_value = rightShift(data_low, 12) and &H7
        read_PBB_BDEI_value = rightShift(data_low, 15) and &H1
        read_NUM_LABELS1_value = rightShift(data_low, 24) and &H7
        read_CONT_PACK1_value = rightShift(data_low, 30) and &H1
        read_PBB_VALID1_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_PBB_BVID = &H0 or flag_PBB_BPCP = &H0 or flag_PBB_BDEI = &H0 or flag_NUM_LABELS1 = &H0 or flag_CONT_PACK1 = &H0 or flag_PBB_VALID1 = &H0 Then read
        If flag_PBB_BVID = &H0 Then write_PBB_BVID_value = get_PBB_BVID
        If flag_PBB_BPCP = &H0 Then write_PBB_BPCP_value = get_PBB_BPCP
        If flag_PBB_BDEI = &H0 Then write_PBB_BDEI_value = get_PBB_BDEI
        If flag_NUM_LABELS1 = &H0 Then write_NUM_LABELS1_value = get_NUM_LABELS1
        If flag_CONT_PACK1 = &H0 Then write_CONT_PACK1_value = get_CONT_PACK1
        If flag_PBB_VALID1 = &H0 Then write_PBB_VALID1_value = get_PBB_VALID1

        regValue = leftShift((write_PBB_BVID_value and &Hfff), 0) + leftShift((write_PBB_BPCP_value and &H7), 12) + leftShift((write_PBB_BDEI_value and &H1), 15) + leftShift((write_NUM_LABELS1_value and &H7), 24) + leftShift((write_CONT_PACK1_value and &H1), 30) + leftShift((write_PBB_VALID1_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBB_BVID_mask = &Hfff
        if data_low > LONG_MAX then
            if PBB_BVID_mask = mask then
                read_PBB_BVID_value = data_low
            else
                read_PBB_BVID_value = (data_low - H8000_0000) and PBB_BVID_mask
            end If
        else
            read_PBB_BVID_value = data_low and PBB_BVID_mask
        end If
        read_PBB_BPCP_value = rightShift(data_low, 12) and &H7
        read_PBB_BDEI_value = rightShift(data_low, 15) and &H1
        read_NUM_LABELS1_value = rightShift(data_low, 24) and &H7
        read_CONT_PACK1_value = rightShift(data_low, 30) and &H1
        read_PBB_VALID1_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PBB_BVID_value = &H0
        flag_PBB_BVID        = &H0
        write_PBB_BPCP_value = &H0
        flag_PBB_BPCP        = &H0
        write_PBB_BDEI_value = &H0
        flag_PBB_BDEI        = &H0
        write_NUM_LABELS1_value = &H0
        flag_NUM_LABELS1        = &H0
        write_CONT_PACK1_value = &H0
        flag_CONT_PACK1        = &H0
        write_PBB_VALID1_value = &H0
        flag_PBB_VALID1        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_pbb_debug2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PBB_ISID                                   [23:0]           get_PBB_ISID
''                                                             set_PBB_ISID
''                                                             read_PBB_ISID
''                                                             write_PBB_ISID
''---------------------------------------------------------------------------------
'' PBB_IPCP                                   [26:24]          get_PBB_IPCP
''                                                             set_PBB_IPCP
''                                                             read_PBB_IPCP
''                                                             write_PBB_IPCP
''---------------------------------------------------------------------------------
'' PBB_IDEI                                   [27:27]          get_PBB_IDEI
''                                                             set_PBB_IDEI
''                                                             read_PBB_IDEI
''                                                             write_PBB_IDEI
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_pbb_debug2
    Private write_PBB_ISID_value
    Private read_PBB_ISID_value
    Private flag_PBB_ISID
    Private write_PBB_IPCP_value
    Private read_PBB_IPCP_value
    Private flag_PBB_IPCP
    Private write_PBB_IDEI_value
    Private read_PBB_IDEI_value
    Private flag_PBB_IDEI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PBB_ISID
        get_PBB_ISID = read_PBB_ISID_value
    End Property

    Property Let set_PBB_ISID(aData)
        write_PBB_ISID_value = aData
        flag_PBB_ISID        = &H1
    End Property

    Property Get read_PBB_ISID
        read
        read_PBB_ISID = read_PBB_ISID_value
    End Property

    Property Let write_PBB_ISID(aData)
        set_PBB_ISID = aData
        write
    End Property

    Property Get get_PBB_IPCP
        get_PBB_IPCP = read_PBB_IPCP_value
    End Property

    Property Let set_PBB_IPCP(aData)
        write_PBB_IPCP_value = aData
        flag_PBB_IPCP        = &H1
    End Property

    Property Get read_PBB_IPCP
        read
        read_PBB_IPCP = read_PBB_IPCP_value
    End Property

    Property Let write_PBB_IPCP(aData)
        set_PBB_IPCP = aData
        write
    End Property

    Property Get get_PBB_IDEI
        get_PBB_IDEI = read_PBB_IDEI_value
    End Property

    Property Let set_PBB_IDEI(aData)
        write_PBB_IDEI_value = aData
        flag_PBB_IDEI        = &H1
    End Property

    Property Get read_PBB_IDEI
        read
        read_PBB_IDEI = read_PBB_IDEI_value
    End Property

    Property Let write_PBB_IDEI(aData)
        set_PBB_IDEI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBB_ISID_mask = &Hffffff
        if data_low > LONG_MAX then
            if PBB_ISID_mask = mask then
                read_PBB_ISID_value = data_low
            else
                read_PBB_ISID_value = (data_low - H8000_0000) and PBB_ISID_mask
            end If
        else
            read_PBB_ISID_value = data_low and PBB_ISID_mask
        end If
        read_PBB_IPCP_value = rightShift(data_low, 24) and &H7
        read_PBB_IDEI_value = rightShift(data_low, 27) and &H1

    End Sub

    Sub write
        If flag_PBB_ISID = &H0 or flag_PBB_IPCP = &H0 or flag_PBB_IDEI = &H0 Then read
        If flag_PBB_ISID = &H0 Then write_PBB_ISID_value = get_PBB_ISID
        If flag_PBB_IPCP = &H0 Then write_PBB_IPCP_value = get_PBB_IPCP
        If flag_PBB_IDEI = &H0 Then write_PBB_IDEI_value = get_PBB_IDEI

        regValue = leftShift((write_PBB_ISID_value and &Hffffff), 0) + leftShift((write_PBB_IPCP_value and &H7), 24) + leftShift((write_PBB_IDEI_value and &H1), 27)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PBB_ISID_mask = &Hffffff
        if data_low > LONG_MAX then
            if PBB_ISID_mask = mask then
                read_PBB_ISID_value = data_low
            else
                read_PBB_ISID_value = (data_low - H8000_0000) and PBB_ISID_mask
            end If
        else
            read_PBB_ISID_value = data_low and PBB_ISID_mask
        end If
        read_PBB_IPCP_value = rightShift(data_low, 24) and &H7
        read_PBB_IDEI_value = rightShift(data_low, 27) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PBB_ISID_value = &H0
        flag_PBB_ISID        = &H0
        write_PBB_IPCP_value = &H0
        flag_PBB_IPCP        = &H0
        write_PBB_IDEI_value = &H0
        flag_PBB_IDEI        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_cda_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PPC310                                     [31:0]           get_PPC310
''                                                             set_PPC310
''                                                             read_PPC310
''                                                             write_PPC310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_cda_lo
    Private write_PPC310_value
    Private read_PPC310_value
    Private flag_PPC310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PPC310
        get_PPC310 = read_PPC310_value
    End Property

    Property Let set_PPC310(aData)
        write_PPC310_value = aData
        flag_PPC310        = &H1
    End Property

    Property Get read_PPC310
        read
        read_PPC310 = read_PPC310_value
    End Property

    Property Let write_PPC310(aData)
        set_PPC310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PPC310_mask = mask then
                read_PPC310_value = data_low
            else
                read_PPC310_value = (data_low - H8000_0000) and PPC310_mask
            end If
        else
            read_PPC310_value = data_low and PPC310_mask
        end If

    End Sub

    Sub write
        If flag_PPC310 = &H0 Then read
        If flag_PPC310 = &H0 Then write_PPC310_value = get_PPC310

        regValue = leftShift(write_PPC310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PPC310_mask = mask then
                read_PPC310_value = data_low
            else
                read_PPC310_value = (data_low - H8000_0000) and PPC310_mask
            end If
        else
            read_PPC310_value = data_low and PPC310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PPC310_value = &H0
        flag_PPC310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_cda_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PPC4732                                    [15:0]           get_PPC4732
''                                                             set_PPC4732
''                                                             read_PPC4732
''                                                             write_PPC4732
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_cda_hi
    Private write_PPC4732_value
    Private read_PPC4732_value
    Private flag_PPC4732

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d64
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PPC4732
        get_PPC4732 = read_PPC4732_value
    End Property

    Property Let set_PPC4732(aData)
        write_PPC4732_value = aData
        flag_PPC4732        = &H1
    End Property

    Property Get read_PPC4732
        read
        read_PPC4732 = read_PPC4732_value
    End Property

    Property Let write_PPC4732(aData)
        set_PPC4732 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PPC4732_mask = mask then
                read_PPC4732_value = data_low
            else
                read_PPC4732_value = (data_low - H8000_0000) and PPC4732_mask
            end If
        else
            read_PPC4732_value = data_low and PPC4732_mask
        end If

    End Sub

    Sub write
        If flag_PPC4732 = &H0 Then read
        If flag_PPC4732 = &H0 Then write_PPC4732_value = get_PPC4732

        regValue = leftShift((write_PPC4732_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PPC4732_mask = mask then
                read_PPC4732_value = data_low
            else
                read_PPC4732_value = (data_low - H8000_0000) and PPC4732_mask
            end If
        else
            read_PPC4732_value = data_low and PPC4732_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PPC4732_value = &H0
        flag_PPC4732        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_csa_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PPC310                                     [31:0]           get_PPC310
''                                                             set_PPC310
''                                                             read_PPC310
''                                                             write_PPC310
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_csa_lo
    Private write_PPC310_value
    Private read_PPC310_value
    Private flag_PPC310

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d68
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PPC310
        get_PPC310 = read_PPC310_value
    End Property

    Property Let set_PPC310(aData)
        write_PPC310_value = aData
        flag_PPC310        = &H1
    End Property

    Property Get read_PPC310
        read
        read_PPC310 = read_PPC310_value
    End Property

    Property Let write_PPC310(aData)
        set_PPC310 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PPC310_mask = mask then
                read_PPC310_value = data_low
            else
                read_PPC310_value = (data_low - H8000_0000) and PPC310_mask
            end If
        else
            read_PPC310_value = data_low and PPC310_mask
        end If

    End Sub

    Sub write
        If flag_PPC310 = &H0 Then read
        If flag_PPC310 = &H0 Then write_PPC310_value = get_PPC310

        regValue = leftShift(write_PPC310_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC310_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PPC310_mask = mask then
                read_PPC310_value = data_low
            else
                read_PPC310_value = (data_low - H8000_0000) and PPC310_mask
            end If
        else
            read_PPC310_value = data_low and PPC310_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PPC310_value = &H0
        flag_PPC310        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_csa_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PPC4732                                    [15:0]           get_PPC4732
''                                                             set_PPC4732
''                                                             read_PPC4732
''                                                             write_PPC4732
''---------------------------------------------------------------------------------
'' CUST_ETH_TYPE                              [31:16]          get_CUST_ETH_TYPE
''                                                             set_CUST_ETH_TYPE
''                                                             read_CUST_ETH_TYPE
''                                                             write_CUST_ETH_TYPE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_csa_hi
    Private write_PPC4732_value
    Private read_PPC4732_value
    Private flag_PPC4732
    Private write_CUST_ETH_TYPE_value
    Private read_CUST_ETH_TYPE_value
    Private flag_CUST_ETH_TYPE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17d6c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PPC4732
        get_PPC4732 = read_PPC4732_value
    End Property

    Property Let set_PPC4732(aData)
        write_PPC4732_value = aData
        flag_PPC4732        = &H1
    End Property

    Property Get read_PPC4732
        read
        read_PPC4732 = read_PPC4732_value
    End Property

    Property Let write_PPC4732(aData)
        set_PPC4732 = aData
        write
    End Property

    Property Get get_CUST_ETH_TYPE
        get_CUST_ETH_TYPE = read_CUST_ETH_TYPE_value
    End Property

    Property Let set_CUST_ETH_TYPE(aData)
        write_CUST_ETH_TYPE_value = aData
        flag_CUST_ETH_TYPE        = &H1
    End Property

    Property Get read_CUST_ETH_TYPE
        read
        read_CUST_ETH_TYPE = read_CUST_ETH_TYPE_value
    End Property

    Property Let write_CUST_ETH_TYPE(aData)
        set_CUST_ETH_TYPE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PPC4732_mask = mask then
                read_PPC4732_value = data_low
            else
                read_PPC4732_value = (data_low - H8000_0000) and PPC4732_mask
            end If
        else
            read_PPC4732_value = data_low and PPC4732_mask
        end If
        read_CUST_ETH_TYPE_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_PPC4732 = &H0 or flag_CUST_ETH_TYPE = &H0 Then read
        If flag_PPC4732 = &H0 Then write_PPC4732_value = get_PPC4732
        If flag_CUST_ETH_TYPE = &H0 Then write_CUST_ETH_TYPE_value = get_CUST_ETH_TYPE

        regValue = leftShift((write_PPC4732_value and &Hffff), 0) + leftShift((write_CUST_ETH_TYPE_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PPC4732_mask = &Hffff
        if data_low > LONG_MAX then
            if PPC4732_mask = mask then
                read_PPC4732_value = data_low
            else
                read_PPC4732_value = (data_low - H8000_0000) and PPC4732_mask
            end If
        else
            read_PPC4732_value = data_low and PPC4732_mask
        end If
        read_CUST_ETH_TYPE_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PPC4732_value = &H0
        flag_PPC4732        = &H0
        write_CUST_ETH_TYPE_value = &H0
        flag_CUST_ETH_TYPE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_INSTANCE

    Public cp_match_debug
    Public scp_mpls_match_debug
    Public scp_pbb_match_debug
    Public sam_debug
    Public tcam_debug
    Public sectag_debug
    Public sc_sa_debug
    Public tcam_match_debug1
    Public sam_pp_debug1
    Public sam_pp_debug2
    Public sam_pp_debug3
    Public st_vlan_debug
    Public ehdr_debug
    Public mpls_debug1
    Public mpls_debug2
    Public dbg_parsed_eompls_da_lo
    Public dbg_parsed_eompls_da_hi
    Public dbg_parsed_eompls_sa_hi
    Public dbg_parsed_mpls_sectag_lo
    Public dbg_parsed_mpls_sectag_hi
    Public dbg_parsed_da_lo
    Public dbg_parsed_da_hi
    Public dbg_parsed_sa_lo
    Public dbg_parsed_sa_hi
    Public dbg_parsed_sectag_lo
    Public dbg_parsed_sectag_hi
    Public dbg_parsed_sci_lo
    Public dbg_parsed_sci_hi
    Public dbg_flow_lookup
    Public dbg_sa_update
    Public crypto_atok_debug_0
    Public crypto_cmmd_debug_0
    Public crypto_cmmd_debug_1
    Public crypto_cmmd_debug_2
    Public crypto_cmmd_debug_3
    Public pbb_debug1
    Public pbb_debug2
    Public dbg_parsed_pbb_cda_lo
    Public dbg_parsed_pbb_cda_hi
    Public dbg_parsed_pbb_csa_lo
    Public dbg_parsed_pbb_csa_hi


    Public default function Init(aBaseAddr)
        Set cp_match_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_cp_match_debug)(aBaseAddr, 32)
        Set scp_mpls_match_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_scp_mpls_match_debug)(aBaseAddr, 32)
        Set scp_pbb_match_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_scp_pbb_match_debug)(aBaseAddr, 32)
        Set sam_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_debug)(aBaseAddr, 32)
        Set tcam_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_tcam_debug)(aBaseAddr, 32)
        Set sectag_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sectag_debug)(aBaseAddr, 32)
        Set sc_sa_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sc_sa_debug)(aBaseAddr, 32)
        Set tcam_match_debug1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_tcam_match_debug1)(aBaseAddr, 32)
        Set sam_pp_debug1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug1)(aBaseAddr, 32)
        Set sam_pp_debug2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug2)(aBaseAddr, 32)
        Set sam_pp_debug3 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_sam_pp_debug3)(aBaseAddr, 32)
        Set st_vlan_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_st_vlan_debug)(aBaseAddr, 32)
        Set ehdr_debug = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_ehdr_debug)(aBaseAddr, 32)
        Set mpls_debug1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_mpls_debug1)(aBaseAddr, 32)
        Set mpls_debug2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_mpls_debug2)(aBaseAddr, 32)
        Set dbg_parsed_eompls_da_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_da_lo)(aBaseAddr, 32)
        Set dbg_parsed_eompls_da_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_da_hi)(aBaseAddr, 32)
        Set dbg_parsed_eompls_sa_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_eompls_sa_hi)(aBaseAddr, 32)
        Set dbg_parsed_mpls_sectag_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_mpls_sectag_lo)(aBaseAddr, 32)
        Set dbg_parsed_mpls_sectag_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_mpls_sectag_hi)(aBaseAddr, 32)
        Set dbg_parsed_da_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_da_lo)(aBaseAddr, 32)
        Set dbg_parsed_da_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_da_hi)(aBaseAddr, 32)
        Set dbg_parsed_sa_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sa_lo)(aBaseAddr, 32)
        Set dbg_parsed_sa_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sa_hi)(aBaseAddr, 32)
        Set dbg_parsed_sectag_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sectag_lo)(aBaseAddr, 32)
        Set dbg_parsed_sectag_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sectag_hi)(aBaseAddr, 32)
        Set dbg_parsed_sci_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sci_lo)(aBaseAddr, 32)
        Set dbg_parsed_sci_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_sci_hi)(aBaseAddr, 32)
        Set dbg_flow_lookup = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_flow_lookup)(aBaseAddr, 32)
        Set dbg_sa_update = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_sa_update)(aBaseAddr, 32)
        Set crypto_atok_debug_0 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_atok_debug_0)(aBaseAddr, 32)
        Set crypto_cmmd_debug_0 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_0)(aBaseAddr, 32)
        Set crypto_cmmd_debug_1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_1)(aBaseAddr, 32)
        Set crypto_cmmd_debug_2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_2)(aBaseAddr, 32)
        Set crypto_cmmd_debug_3 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_crypto_cmmd_debug_3)(aBaseAddr, 32)
        Set pbb_debug1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_pbb_debug1)(aBaseAddr, 32)
        Set pbb_debug2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_pbb_debug2)(aBaseAddr, 32)
        Set dbg_parsed_pbb_cda_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_cda_lo)(aBaseAddr, 32)
        Set dbg_parsed_pbb_cda_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_cda_hi)(aBaseAddr, 32)
        Set dbg_parsed_pbb_csa_lo = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_csa_lo)(aBaseAddr, 32)
        Set dbg_parsed_pbb_csa_hi = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_dbg_parsed_pbb_csa_hi)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG.Add ((New EIP165S_EIP_160S_E_32_BRCM_CLASSIFIER_DEBUG_INSTANCE)(&H4d510000))


