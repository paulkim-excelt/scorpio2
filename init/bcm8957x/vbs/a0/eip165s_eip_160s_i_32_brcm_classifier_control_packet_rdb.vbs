

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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_0
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7800
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_0
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7804
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_1
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7808
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_1
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H780c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_2
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7810
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_2
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7814
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_3
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7818
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_3
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H781c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_4
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7820
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_4
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7824
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_5
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7828
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_5
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H782c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_6
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7830
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_6
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7834
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_7
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7838
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_7
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H783c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start0_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start0_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7860
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start0_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start0_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7864
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end0_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end0_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7868
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end0_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end0_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H786c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start1_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start1_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7870
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start1_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
'' ether_type_match                           [31:16]          get_ether_type_match
''                                                             set_ether_type_match
''                                                             read_ether_type_match
''                                                             write_ether_type_match
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start1_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0
    Private write_ether_type_match_value
    Private read_ether_type_match_value
    Private flag_ether_type_match

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7874
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_ether_type_match
        get_ether_type_match = read_ether_type_match_value
    End Property

    Property Let set_ether_type_match(aData)
        write_ether_type_match_value = aData
        flag_ether_type_match        = &H1
    End Property

    Property Get read_ether_type_match
        read
        read_ether_type_match = read_ether_type_match_value
    End Property

    Property Let write_ether_type_match(aData)
        set_ether_type_match = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 or flag_ether_type_match = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0
        If flag_ether_type_match = &H0 Then write_ether_type_match_value = get_ether_type_match

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8) + leftShift((write_ether_type_match_value and &Hffff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff
        read_ether_type_match_value = rightShift(data_low, 16) and &Hffff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
        write_ether_type_match_value = &H0
        flag_ether_type_match        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end1_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end1_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7878
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end1_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end1_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H787c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7880
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7884
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7888
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H788c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_44_bits_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_44_bits_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7890
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_44_bits_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_4                           [15:12]          get_mac_da_match_7_4
''                                                             set_mac_da_match_7_4
''                                                             read_mac_da_match_7_4
''                                                             write_mac_da_match_7_4
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_44_bits_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_4_value
    Private read_mac_da_match_7_4_value
    Private flag_mac_da_match_7_4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7894
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_4
        get_mac_da_match_7_4 = read_mac_da_match_7_4_value
    End Property

    Property Let set_mac_da_match_7_4(aData)
        write_mac_da_match_7_4_value = aData
        flag_mac_da_match_7_4        = &H1
    End Property

    Property Get read_mac_da_match_7_4
        read
        read_mac_da_match_7_4 = read_mac_da_match_7_4_value
    End Property

    Property Let write_mac_da_match_7_4(aData)
        set_mac_da_match_7_4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_4_value = rightShift(data_low, 12) and &Hf

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_4 = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_4 = &H0 Then write_mac_da_match_7_4_value = get_mac_da_match_7_4

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_4_value and &Hf), 12)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_4_value = rightShift(data_low, 12) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_4_value = &H0
        flag_mac_da_match_7_4        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_48_bits_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_47_40                         [7:0]            get_mac_da_match_47_40
''                                                             set_mac_da_match_47_40
''                                                             read_mac_da_match_47_40
''                                                             write_mac_da_match_47_40
''---------------------------------------------------------------------------------
'' mac_da_match_39_32                         [15:8]           get_mac_da_match_39_32
''                                                             set_mac_da_match_39_32
''                                                             read_mac_da_match_39_32
''                                                             write_mac_da_match_39_32
''---------------------------------------------------------------------------------
'' mac_da_match_31_24                         [23:16]          get_mac_da_match_31_24
''                                                             set_mac_da_match_31_24
''                                                             read_mac_da_match_31_24
''                                                             write_mac_da_match_31_24
''---------------------------------------------------------------------------------
'' mac_da_match_23_16                         [31:24]          get_mac_da_match_23_16
''                                                             set_mac_da_match_23_16
''                                                             read_mac_da_match_23_16
''                                                             write_mac_da_match_23_16
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_48_bits_lo
    Private write_mac_da_match_47_40_value
    Private read_mac_da_match_47_40_value
    Private flag_mac_da_match_47_40
    Private write_mac_da_match_39_32_value
    Private read_mac_da_match_39_32_value
    Private flag_mac_da_match_39_32
    Private write_mac_da_match_31_24_value
    Private read_mac_da_match_31_24_value
    Private flag_mac_da_match_31_24
    Private write_mac_da_match_23_16_value
    Private read_mac_da_match_23_16_value
    Private flag_mac_da_match_23_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7898
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_47_40
        get_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let set_mac_da_match_47_40(aData)
        write_mac_da_match_47_40_value = aData
        flag_mac_da_match_47_40        = &H1
    End Property

    Property Get read_mac_da_match_47_40
        read
        read_mac_da_match_47_40 = read_mac_da_match_47_40_value
    End Property

    Property Let write_mac_da_match_47_40(aData)
        set_mac_da_match_47_40 = aData
        write
    End Property

    Property Get get_mac_da_match_39_32
        get_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let set_mac_da_match_39_32(aData)
        write_mac_da_match_39_32_value = aData
        flag_mac_da_match_39_32        = &H1
    End Property

    Property Get read_mac_da_match_39_32
        read
        read_mac_da_match_39_32 = read_mac_da_match_39_32_value
    End Property

    Property Let write_mac_da_match_39_32(aData)
        set_mac_da_match_39_32 = aData
        write
    End Property

    Property Get get_mac_da_match_31_24
        get_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let set_mac_da_match_31_24(aData)
        write_mac_da_match_31_24_value = aData
        flag_mac_da_match_31_24        = &H1
    End Property

    Property Get read_mac_da_match_31_24
        read
        read_mac_da_match_31_24 = read_mac_da_match_31_24_value
    End Property

    Property Let write_mac_da_match_31_24(aData)
        set_mac_da_match_31_24 = aData
        write
    End Property

    Property Get get_mac_da_match_23_16
        get_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let set_mac_da_match_23_16(aData)
        write_mac_da_match_23_16_value = aData
        flag_mac_da_match_23_16        = &H1
    End Property

    Property Get read_mac_da_match_23_16
        read
        read_mac_da_match_23_16 = read_mac_da_match_23_16_value
    End Property

    Property Let write_mac_da_match_23_16(aData)
        set_mac_da_match_23_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_47_40 = &H0 or flag_mac_da_match_39_32 = &H0 or flag_mac_da_match_31_24 = &H0 or flag_mac_da_match_23_16 = &H0 Then read
        If flag_mac_da_match_47_40 = &H0 Then write_mac_da_match_47_40_value = get_mac_da_match_47_40
        If flag_mac_da_match_39_32 = &H0 Then write_mac_da_match_39_32_value = get_mac_da_match_39_32
        If flag_mac_da_match_31_24 = &H0 Then write_mac_da_match_31_24_value = get_mac_da_match_31_24
        If flag_mac_da_match_23_16 = &H0 Then write_mac_da_match_23_16_value = get_mac_da_match_23_16

        regValue = leftShift((write_mac_da_match_47_40_value and &Hff), 0) + leftShift((write_mac_da_match_39_32_value and &Hff), 8) + leftShift((write_mac_da_match_31_24_value and &Hff), 16) + leftShift((write_mac_da_match_23_16_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_47_40_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_47_40_mask = mask then
                read_mac_da_match_47_40_value = data_low
            else
                read_mac_da_match_47_40_value = (data_low - H8000_0000) and mac_da_match_47_40_mask
            end If
        else
            read_mac_da_match_47_40_value = data_low and mac_da_match_47_40_mask
        end If
        read_mac_da_match_39_32_value = rightShift(data_low, 8) and &Hff
        read_mac_da_match_31_24_value = rightShift(data_low, 16) and &Hff
        read_mac_da_match_23_16_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_47_40_value = &H0
        flag_mac_da_match_47_40        = &H0
        write_mac_da_match_39_32_value = &H0
        flag_mac_da_match_39_32        = &H0
        write_mac_da_match_31_24_value = &H0
        flag_mac_da_match_31_24        = &H0
        write_mac_da_match_23_16_value = &H0
        flag_mac_da_match_23_16        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_48_bits_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mac_da_match_15_8                          [7:0]            get_mac_da_match_15_8
''                                                             set_mac_da_match_15_8
''                                                             read_mac_da_match_15_8
''                                                             write_mac_da_match_15_8
''---------------------------------------------------------------------------------
'' mac_da_match_7_0                           [15:8]           get_mac_da_match_7_0
''                                                             set_mac_da_match_7_0
''                                                             read_mac_da_match_7_0
''                                                             write_mac_da_match_7_0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_48_bits_hi
    Private write_mac_da_match_15_8_value
    Private read_mac_da_match_15_8_value
    Private flag_mac_da_match_15_8
    Private write_mac_da_match_7_0_value
    Private read_mac_da_match_7_0_value
    Private flag_mac_da_match_7_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H789c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mac_da_match_15_8
        get_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let set_mac_da_match_15_8(aData)
        write_mac_da_match_15_8_value = aData
        flag_mac_da_match_15_8        = &H1
    End Property

    Property Get read_mac_da_match_15_8
        read
        read_mac_da_match_15_8 = read_mac_da_match_15_8_value
    End Property

    Property Let write_mac_da_match_15_8(aData)
        set_mac_da_match_15_8 = aData
        write
    End Property

    Property Get get_mac_da_match_7_0
        get_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let set_mac_da_match_7_0(aData)
        write_mac_da_match_7_0_value = aData
        flag_mac_da_match_7_0        = &H1
    End Property

    Property Get read_mac_da_match_7_0
        read
        read_mac_da_match_7_0 = read_mac_da_match_7_0_value
    End Property

    Property Let write_mac_da_match_7_0(aData)
        set_mac_da_match_7_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

    End Sub

    Sub write
        If flag_mac_da_match_15_8 = &H0 or flag_mac_da_match_7_0 = &H0 Then read
        If flag_mac_da_match_15_8 = &H0 Then write_mac_da_match_15_8_value = get_mac_da_match_15_8
        If flag_mac_da_match_7_0 = &H0 Then write_mac_da_match_7_0_value = get_mac_da_match_7_0

        regValue = leftShift((write_mac_da_match_15_8_value and &Hff), 0) + leftShift((write_mac_da_match_7_0_value and &Hff), 8)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mac_da_match_15_8_mask = &Hff
        if data_low > LONG_MAX then
            if mac_da_match_15_8_mask = mask then
                read_mac_da_match_15_8_value = data_low
            else
                read_mac_da_match_15_8_value = (data_low - H8000_0000) and mac_da_match_15_8_mask
            end If
        else
            read_mac_da_match_15_8_value = data_low and mac_da_match_15_8_mask
        end If
        read_mac_da_match_7_0_value = rightShift(data_low, 8) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mac_da_match_15_8_value = &H0
        flag_mac_da_match_15_8        = &H0
        write_mac_da_match_7_0_value = &H0
        flag_mac_da_match_7_0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_tag_enb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' parse_stag0                                [0:0]            get_parse_stag0
''                                                             set_parse_stag0
''                                                             read_parse_stag0
''                                                             write_parse_stag0
''---------------------------------------------------------------------------------
'' parse_stag1                                [1:1]            get_parse_stag1
''                                                             set_parse_stag1
''                                                             read_parse_stag1
''                                                             write_parse_stag1
''---------------------------------------------------------------------------------
'' parse_stag2                                [2:2]            get_parse_stag2
''                                                             set_parse_stag2
''                                                             read_parse_stag2
''                                                             write_parse_stag2
''---------------------------------------------------------------------------------
'' parse_stag3                                [3:3]            get_parse_stag3
''                                                             set_parse_stag3
''                                                             read_parse_stag3
''                                                             write_parse_stag3
''---------------------------------------------------------------------------------
'' parse_qinq                                 [31:31]          get_parse_qinq
''                                                             set_parse_qinq
''                                                             read_parse_qinq
''                                                             write_parse_qinq
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_tag_enb
    Private write_parse_stag0_value
    Private read_parse_stag0_value
    Private flag_parse_stag0
    Private write_parse_stag1_value
    Private read_parse_stag1_value
    Private flag_parse_stag1
    Private write_parse_stag2_value
    Private read_parse_stag2_value
    Private flag_parse_stag2
    Private write_parse_stag3_value
    Private read_parse_stag3_value
    Private flag_parse_stag3
    Private write_parse_qinq_value
    Private read_parse_qinq_value
    Private flag_parse_qinq

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_parse_stag0
        get_parse_stag0 = read_parse_stag0_value
    End Property

    Property Let set_parse_stag0(aData)
        write_parse_stag0_value = aData
        flag_parse_stag0        = &H1
    End Property

    Property Get read_parse_stag0
        read
        read_parse_stag0 = read_parse_stag0_value
    End Property

    Property Let write_parse_stag0(aData)
        set_parse_stag0 = aData
        write
    End Property

    Property Get get_parse_stag1
        get_parse_stag1 = read_parse_stag1_value
    End Property

    Property Let set_parse_stag1(aData)
        write_parse_stag1_value = aData
        flag_parse_stag1        = &H1
    End Property

    Property Get read_parse_stag1
        read
        read_parse_stag1 = read_parse_stag1_value
    End Property

    Property Let write_parse_stag1(aData)
        set_parse_stag1 = aData
        write
    End Property

    Property Get get_parse_stag2
        get_parse_stag2 = read_parse_stag2_value
    End Property

    Property Let set_parse_stag2(aData)
        write_parse_stag2_value = aData
        flag_parse_stag2        = &H1
    End Property

    Property Get read_parse_stag2
        read
        read_parse_stag2 = read_parse_stag2_value
    End Property

    Property Let write_parse_stag2(aData)
        set_parse_stag2 = aData
        write
    End Property

    Property Get get_parse_stag3
        get_parse_stag3 = read_parse_stag3_value
    End Property

    Property Let set_parse_stag3(aData)
        write_parse_stag3_value = aData
        flag_parse_stag3        = &H1
    End Property

    Property Get read_parse_stag3
        read
        read_parse_stag3 = read_parse_stag3_value
    End Property

    Property Let write_parse_stag3(aData)
        set_parse_stag3 = aData
        write
    End Property

    Property Get get_parse_qinq
        get_parse_qinq = read_parse_qinq_value
    End Property

    Property Let set_parse_qinq(aData)
        write_parse_qinq_value = aData
        flag_parse_qinq        = &H1
    End Property

    Property Get read_parse_qinq
        read
        read_parse_qinq = read_parse_qinq_value
    End Property

    Property Let write_parse_qinq(aData)
        set_parse_qinq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        parse_stag0_mask = &H1
        if data_low > LONG_MAX then
            if parse_stag0_mask = mask then
                read_parse_stag0_value = data_low
            else
                read_parse_stag0_value = (data_low - H8000_0000) and parse_stag0_mask
            end If
        else
            read_parse_stag0_value = data_low and parse_stag0_mask
        end If
        read_parse_stag1_value = rightShift(data_low, 1) and &H1
        read_parse_stag2_value = rightShift(data_low, 2) and &H1
        read_parse_stag3_value = rightShift(data_low, 3) and &H1
        read_parse_qinq_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_parse_stag0 = &H0 or flag_parse_stag1 = &H0 or flag_parse_stag2 = &H0 or flag_parse_stag3 = &H0 or flag_parse_qinq = &H0 Then read
        If flag_parse_stag0 = &H0 Then write_parse_stag0_value = get_parse_stag0
        If flag_parse_stag1 = &H0 Then write_parse_stag1_value = get_parse_stag1
        If flag_parse_stag2 = &H0 Then write_parse_stag2_value = get_parse_stag2
        If flag_parse_stag3 = &H0 Then write_parse_stag3_value = get_parse_stag3
        If flag_parse_qinq = &H0 Then write_parse_qinq_value = get_parse_qinq

        regValue = leftShift((write_parse_stag0_value and &H1), 0) + leftShift((write_parse_stag1_value and &H1), 1) + leftShift((write_parse_stag2_value and &H1), 2) + leftShift((write_parse_stag3_value and &H1), 3) + leftShift((write_parse_qinq_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        parse_stag0_mask = &H1
        if data_low > LONG_MAX then
            if parse_stag0_mask = mask then
                read_parse_stag0_value = data_low
            else
                read_parse_stag0_value = (data_low - H8000_0000) and parse_stag0_mask
            end If
        else
            read_parse_stag0_value = data_low and parse_stag0_mask
        end If
        read_parse_stag1_value = rightShift(data_low, 1) and &H1
        read_parse_stag2_value = rightShift(data_low, 2) and &H1
        read_parse_stag3_value = rightShift(data_low, 3) and &H1
        read_parse_qinq_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_parse_stag0_value = &H0
        flag_parse_stag0        = &H0
        write_parse_stag1_value = &H0
        flag_parse_stag1        = &H0
        write_parse_stag2_value = &H0
        flag_parse_stag2        = &H0
        write_parse_stag3_value = &H0
        flag_parse_stag3        = &H0
        write_parse_qinq_value = &H0
        flag_parse_qinq        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_match_mode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' e_type_sel_0                               [8:8]            get_e_type_sel_0
''                                                             set_e_type_sel_0
''                                                             read_e_type_sel_0
''                                                             write_e_type_sel_0
''---------------------------------------------------------------------------------
'' e_type_sel_1                               [9:9]            get_e_type_sel_1
''                                                             set_e_type_sel_1
''                                                             read_e_type_sel_1
''                                                             write_e_type_sel_1
''---------------------------------------------------------------------------------
'' e_type_sel_2                               [10:10]          get_e_type_sel_2
''                                                             set_e_type_sel_2
''                                                             read_e_type_sel_2
''                                                             write_e_type_sel_2
''---------------------------------------------------------------------------------
'' e_type_sel_3                               [11:11]          get_e_type_sel_3
''                                                             set_e_type_sel_3
''                                                             read_e_type_sel_3
''                                                             write_e_type_sel_3
''---------------------------------------------------------------------------------
'' e_type_sel_4                               [12:12]          get_e_type_sel_4
''                                                             set_e_type_sel_4
''                                                             read_e_type_sel_4
''                                                             write_e_type_sel_4
''---------------------------------------------------------------------------------
'' e_type_sel_5                               [13:13]          get_e_type_sel_5
''                                                             set_e_type_sel_5
''                                                             read_e_type_sel_5
''                                                             write_e_type_sel_5
''---------------------------------------------------------------------------------
'' e_type_sel_6                               [14:14]          get_e_type_sel_6
''                                                             set_e_type_sel_6
''                                                             read_e_type_sel_6
''                                                             write_e_type_sel_6
''---------------------------------------------------------------------------------
'' e_type_sel_7                               [15:15]          get_e_type_sel_7
''                                                             set_e_type_sel_7
''                                                             read_e_type_sel_7
''                                                             write_e_type_sel_7
''---------------------------------------------------------------------------------
'' e_type_sel_8                               [16:16]          get_e_type_sel_8
''                                                             set_e_type_sel_8
''                                                             read_e_type_sel_8
''                                                             write_e_type_sel_8
''---------------------------------------------------------------------------------
'' e_type_sel_9                               [17:17]          get_e_type_sel_9
''                                                             set_e_type_sel_9
''                                                             read_e_type_sel_9
''                                                             write_e_type_sel_9
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_match_mode
    Private write_e_type_sel_0_value
    Private read_e_type_sel_0_value
    Private flag_e_type_sel_0
    Private write_e_type_sel_1_value
    Private read_e_type_sel_1_value
    Private flag_e_type_sel_1
    Private write_e_type_sel_2_value
    Private read_e_type_sel_2_value
    Private flag_e_type_sel_2
    Private write_e_type_sel_3_value
    Private read_e_type_sel_3_value
    Private flag_e_type_sel_3
    Private write_e_type_sel_4_value
    Private read_e_type_sel_4_value
    Private flag_e_type_sel_4
    Private write_e_type_sel_5_value
    Private read_e_type_sel_5_value
    Private flag_e_type_sel_5
    Private write_e_type_sel_6_value
    Private read_e_type_sel_6_value
    Private flag_e_type_sel_6
    Private write_e_type_sel_7_value
    Private read_e_type_sel_7_value
    Private flag_e_type_sel_7
    Private write_e_type_sel_8_value
    Private read_e_type_sel_8_value
    Private flag_e_type_sel_8
    Private write_e_type_sel_9_value
    Private read_e_type_sel_9_value
    Private flag_e_type_sel_9

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_e_type_sel_0
        get_e_type_sel_0 = read_e_type_sel_0_value
    End Property

    Property Let set_e_type_sel_0(aData)
        write_e_type_sel_0_value = aData
        flag_e_type_sel_0        = &H1
    End Property

    Property Get read_e_type_sel_0
        read
        read_e_type_sel_0 = read_e_type_sel_0_value
    End Property

    Property Let write_e_type_sel_0(aData)
        set_e_type_sel_0 = aData
        write
    End Property

    Property Get get_e_type_sel_1
        get_e_type_sel_1 = read_e_type_sel_1_value
    End Property

    Property Let set_e_type_sel_1(aData)
        write_e_type_sel_1_value = aData
        flag_e_type_sel_1        = &H1
    End Property

    Property Get read_e_type_sel_1
        read
        read_e_type_sel_1 = read_e_type_sel_1_value
    End Property

    Property Let write_e_type_sel_1(aData)
        set_e_type_sel_1 = aData
        write
    End Property

    Property Get get_e_type_sel_2
        get_e_type_sel_2 = read_e_type_sel_2_value
    End Property

    Property Let set_e_type_sel_2(aData)
        write_e_type_sel_2_value = aData
        flag_e_type_sel_2        = &H1
    End Property

    Property Get read_e_type_sel_2
        read
        read_e_type_sel_2 = read_e_type_sel_2_value
    End Property

    Property Let write_e_type_sel_2(aData)
        set_e_type_sel_2 = aData
        write
    End Property

    Property Get get_e_type_sel_3
        get_e_type_sel_3 = read_e_type_sel_3_value
    End Property

    Property Let set_e_type_sel_3(aData)
        write_e_type_sel_3_value = aData
        flag_e_type_sel_3        = &H1
    End Property

    Property Get read_e_type_sel_3
        read
        read_e_type_sel_3 = read_e_type_sel_3_value
    End Property

    Property Let write_e_type_sel_3(aData)
        set_e_type_sel_3 = aData
        write
    End Property

    Property Get get_e_type_sel_4
        get_e_type_sel_4 = read_e_type_sel_4_value
    End Property

    Property Let set_e_type_sel_4(aData)
        write_e_type_sel_4_value = aData
        flag_e_type_sel_4        = &H1
    End Property

    Property Get read_e_type_sel_4
        read
        read_e_type_sel_4 = read_e_type_sel_4_value
    End Property

    Property Let write_e_type_sel_4(aData)
        set_e_type_sel_4 = aData
        write
    End Property

    Property Get get_e_type_sel_5
        get_e_type_sel_5 = read_e_type_sel_5_value
    End Property

    Property Let set_e_type_sel_5(aData)
        write_e_type_sel_5_value = aData
        flag_e_type_sel_5        = &H1
    End Property

    Property Get read_e_type_sel_5
        read
        read_e_type_sel_5 = read_e_type_sel_5_value
    End Property

    Property Let write_e_type_sel_5(aData)
        set_e_type_sel_5 = aData
        write
    End Property

    Property Get get_e_type_sel_6
        get_e_type_sel_6 = read_e_type_sel_6_value
    End Property

    Property Let set_e_type_sel_6(aData)
        write_e_type_sel_6_value = aData
        flag_e_type_sel_6        = &H1
    End Property

    Property Get read_e_type_sel_6
        read
        read_e_type_sel_6 = read_e_type_sel_6_value
    End Property

    Property Let write_e_type_sel_6(aData)
        set_e_type_sel_6 = aData
        write
    End Property

    Property Get get_e_type_sel_7
        get_e_type_sel_7 = read_e_type_sel_7_value
    End Property

    Property Let set_e_type_sel_7(aData)
        write_e_type_sel_7_value = aData
        flag_e_type_sel_7        = &H1
    End Property

    Property Get read_e_type_sel_7
        read
        read_e_type_sel_7 = read_e_type_sel_7_value
    End Property

    Property Let write_e_type_sel_7(aData)
        set_e_type_sel_7 = aData
        write
    End Property

    Property Get get_e_type_sel_8
        get_e_type_sel_8 = read_e_type_sel_8_value
    End Property

    Property Let set_e_type_sel_8(aData)
        write_e_type_sel_8_value = aData
        flag_e_type_sel_8        = &H1
    End Property

    Property Get read_e_type_sel_8
        read
        read_e_type_sel_8 = read_e_type_sel_8_value
    End Property

    Property Let write_e_type_sel_8(aData)
        set_e_type_sel_8 = aData
        write
    End Property

    Property Get get_e_type_sel_9
        get_e_type_sel_9 = read_e_type_sel_9_value
    End Property

    Property Let set_e_type_sel_9(aData)
        write_e_type_sel_9_value = aData
        flag_e_type_sel_9        = &H1
    End Property

    Property Get read_e_type_sel_9
        read
        read_e_type_sel_9 = read_e_type_sel_9_value
    End Property

    Property Let write_e_type_sel_9(aData)
        set_e_type_sel_9 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_e_type_sel_0_value = rightShift(data_low, 8) and &H1
        read_e_type_sel_1_value = rightShift(data_low, 9) and &H1
        read_e_type_sel_2_value = rightShift(data_low, 10) and &H1
        read_e_type_sel_3_value = rightShift(data_low, 11) and &H1
        read_e_type_sel_4_value = rightShift(data_low, 12) and &H1
        read_e_type_sel_5_value = rightShift(data_low, 13) and &H1
        read_e_type_sel_6_value = rightShift(data_low, 14) and &H1
        read_e_type_sel_7_value = rightShift(data_low, 15) and &H1
        read_e_type_sel_8_value = rightShift(data_low, 16) and &H1
        read_e_type_sel_9_value = rightShift(data_low, 17) and &H1

    End Sub

    Sub write
        If flag_e_type_sel_0 = &H0 or flag_e_type_sel_1 = &H0 or flag_e_type_sel_2 = &H0 or flag_e_type_sel_3 = &H0 or flag_e_type_sel_4 = &H0 or flag_e_type_sel_5 = &H0 or flag_e_type_sel_6 = &H0 or flag_e_type_sel_7 = &H0 or flag_e_type_sel_8 = &H0 or flag_e_type_sel_9 = &H0 Then read
        If flag_e_type_sel_0 = &H0 Then write_e_type_sel_0_value = get_e_type_sel_0
        If flag_e_type_sel_1 = &H0 Then write_e_type_sel_1_value = get_e_type_sel_1
        If flag_e_type_sel_2 = &H0 Then write_e_type_sel_2_value = get_e_type_sel_2
        If flag_e_type_sel_3 = &H0 Then write_e_type_sel_3_value = get_e_type_sel_3
        If flag_e_type_sel_4 = &H0 Then write_e_type_sel_4_value = get_e_type_sel_4
        If flag_e_type_sel_5 = &H0 Then write_e_type_sel_5_value = get_e_type_sel_5
        If flag_e_type_sel_6 = &H0 Then write_e_type_sel_6_value = get_e_type_sel_6
        If flag_e_type_sel_7 = &H0 Then write_e_type_sel_7_value = get_e_type_sel_7
        If flag_e_type_sel_8 = &H0 Then write_e_type_sel_8_value = get_e_type_sel_8
        If flag_e_type_sel_9 = &H0 Then write_e_type_sel_9_value = get_e_type_sel_9

        regValue = leftShift((write_e_type_sel_0_value and &H1), 8) + leftShift((write_e_type_sel_1_value and &H1), 9) + leftShift((write_e_type_sel_2_value and &H1), 10) + leftShift((write_e_type_sel_3_value and &H1), 11) + leftShift((write_e_type_sel_4_value and &H1), 12) + leftShift((write_e_type_sel_5_value and &H1), 13) + leftShift((write_e_type_sel_6_value and &H1), 14) + leftShift((write_e_type_sel_7_value and &H1), 15) + leftShift((write_e_type_sel_8_value and &H1), 16) + leftShift((write_e_type_sel_9_value and &H1), 17)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_e_type_sel_0_value = rightShift(data_low, 8) and &H1
        read_e_type_sel_1_value = rightShift(data_low, 9) and &H1
        read_e_type_sel_2_value = rightShift(data_low, 10) and &H1
        read_e_type_sel_3_value = rightShift(data_low, 11) and &H1
        read_e_type_sel_4_value = rightShift(data_low, 12) and &H1
        read_e_type_sel_5_value = rightShift(data_low, 13) and &H1
        read_e_type_sel_6_value = rightShift(data_low, 14) and &H1
        read_e_type_sel_7_value = rightShift(data_low, 15) and &H1
        read_e_type_sel_8_value = rightShift(data_low, 16) and &H1
        read_e_type_sel_9_value = rightShift(data_low, 17) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_e_type_sel_0_value = &H0
        flag_e_type_sel_0        = &H0
        write_e_type_sel_1_value = &H0
        flag_e_type_sel_1        = &H0
        write_e_type_sel_2_value = &H0
        flag_e_type_sel_2        = &H0
        write_e_type_sel_3_value = &H0
        flag_e_type_sel_3        = &H0
        write_e_type_sel_4_value = &H0
        flag_e_type_sel_4        = &H0
        write_e_type_sel_5_value = &H0
        flag_e_type_sel_5        = &H0
        write_e_type_sel_6_value = &H0
        flag_e_type_sel_6        = &H0
        write_e_type_sel_7_value = &H0
        flag_e_type_sel_7        = &H0
        write_e_type_sel_8_value = &H0
        flag_e_type_sel_8        = &H0
        write_e_type_sel_9_value = &H0
        flag_e_type_sel_9        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_match_enable
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
'' macsec_kay                                 [31:31]          get_macsec_kay
''                                                             set_macsec_kay
''                                                             read_macsec_kay
''                                                             write_macsec_kay
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_match_enable
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
    Private write_macsec_kay_value
    Private read_macsec_kay_value
    Private flag_macsec_kay

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78ec
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

    Property Get get_macsec_kay
        get_macsec_kay = read_macsec_kay_value
    End Property

    Property Let set_macsec_kay(aData)
        write_macsec_kay_value = aData
        flag_macsec_kay        = &H1
    End Property

    Property Get read_macsec_kay
        read
        read_macsec_kay = read_macsec_kay_value
    End Property

    Property Let write_macsec_kay(aData)
        set_macsec_kay = aData
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
        read_macsec_kay_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_mac_da_0 = &H0 or flag_mac_da_1 = &H0 or flag_mac_da_2 = &H0 or flag_mac_da_3 = &H0 or flag_mac_da_4 = &H0 or flag_mac_da_5 = &H0 or flag_mac_da_6 = &H0 or flag_mac_da_7 = &H0 or flag_e_type_0 = &H0 or flag_e_type_1 = &H0 or flag_e_type_2 = &H0 or flag_e_type_3 = &H0 or flag_e_type_4 = &H0 or flag_e_type_5 = &H0 or flag_e_type_6 = &H0 or flag_e_type_7 = &H0 or flag_comb8 = &H0 or flag_comb9 = &H0 or flag_range = &H0 or flag_const_44 = &H0 or flag_const_48 = &H0 or flag_macsec_kay = &H0 Then read
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
        If flag_macsec_kay = &H0 Then write_macsec_kay_value = get_macsec_kay

        regValue = leftShift((write_mac_da_0_value and &H1), 0) + leftShift((write_mac_da_1_value and &H1), 1) + leftShift((write_mac_da_2_value and &H1), 2) + leftShift((write_mac_da_3_value and &H1), 3) + leftShift((write_mac_da_4_value and &H1), 4) + leftShift((write_mac_da_5_value and &H1), 5) + leftShift((write_mac_da_6_value and &H1), 6) + leftShift((write_mac_da_7_value and &H1), 7) + leftShift((write_e_type_0_value and &H1), 8) + leftShift((write_e_type_1_value and &H1), 9) + leftShift((write_e_type_2_value and &H1), 10) + leftShift((write_e_type_3_value and &H1), 11) + leftShift((write_e_type_4_value and &H1), 12) + leftShift((write_e_type_5_value and &H1), 13) + leftShift((write_e_type_6_value and &H1), 14) + leftShift((write_e_type_7_value and &H1), 15) + leftShift((write_comb8_value and &H1), 16) + leftShift((write_comb9_value and &H1), 17) + leftShift((write_range_value and &H1), 18) + leftShift((write_const_44_value and &H1), 19) + leftShift((write_const_48_value and &H1), 20) + leftShift((write_macsec_kay_value and &H1), 31)
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
        read_macsec_kay_value = rightShift(data_low, 31) and &H1

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
        write_macsec_kay_value = &H0
        flag_macsec_kay        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_tag_enb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' parse_stag0                                [0:0]            get_parse_stag0
''                                                             set_parse_stag0
''                                                             read_parse_stag0
''                                                             write_parse_stag0
''---------------------------------------------------------------------------------
'' parse_stag1                                [1:1]            get_parse_stag1
''                                                             set_parse_stag1
''                                                             read_parse_stag1
''                                                             write_parse_stag1
''---------------------------------------------------------------------------------
'' parse_stag2                                [2:2]            get_parse_stag2
''                                                             set_parse_stag2
''                                                             read_parse_stag2
''                                                             write_parse_stag2
''---------------------------------------------------------------------------------
'' parse_stag3                                [3:3]            get_parse_stag3
''                                                             set_parse_stag3
''                                                             read_parse_stag3
''                                                             write_parse_stag3
''---------------------------------------------------------------------------------
'' parse_qinq                                 [31:31]          get_parse_qinq
''                                                             set_parse_qinq
''                                                             read_parse_qinq
''                                                             write_parse_qinq
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_tag_enb
    Private write_parse_stag0_value
    Private read_parse_stag0_value
    Private flag_parse_stag0
    Private write_parse_stag1_value
    Private read_parse_stag1_value
    Private flag_parse_stag1
    Private write_parse_stag2_value
    Private read_parse_stag2_value
    Private flag_parse_stag2
    Private write_parse_stag3_value
    Private read_parse_stag3_value
    Private flag_parse_stag3
    Private write_parse_qinq_value
    Private read_parse_qinq_value
    Private flag_parse_qinq

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_parse_stag0
        get_parse_stag0 = read_parse_stag0_value
    End Property

    Property Let set_parse_stag0(aData)
        write_parse_stag0_value = aData
        flag_parse_stag0        = &H1
    End Property

    Property Get read_parse_stag0
        read
        read_parse_stag0 = read_parse_stag0_value
    End Property

    Property Let write_parse_stag0(aData)
        set_parse_stag0 = aData
        write
    End Property

    Property Get get_parse_stag1
        get_parse_stag1 = read_parse_stag1_value
    End Property

    Property Let set_parse_stag1(aData)
        write_parse_stag1_value = aData
        flag_parse_stag1        = &H1
    End Property

    Property Get read_parse_stag1
        read
        read_parse_stag1 = read_parse_stag1_value
    End Property

    Property Let write_parse_stag1(aData)
        set_parse_stag1 = aData
        write
    End Property

    Property Get get_parse_stag2
        get_parse_stag2 = read_parse_stag2_value
    End Property

    Property Let set_parse_stag2(aData)
        write_parse_stag2_value = aData
        flag_parse_stag2        = &H1
    End Property

    Property Get read_parse_stag2
        read
        read_parse_stag2 = read_parse_stag2_value
    End Property

    Property Let write_parse_stag2(aData)
        set_parse_stag2 = aData
        write
    End Property

    Property Get get_parse_stag3
        get_parse_stag3 = read_parse_stag3_value
    End Property

    Property Let set_parse_stag3(aData)
        write_parse_stag3_value = aData
        flag_parse_stag3        = &H1
    End Property

    Property Get read_parse_stag3
        read
        read_parse_stag3 = read_parse_stag3_value
    End Property

    Property Let write_parse_stag3(aData)
        set_parse_stag3 = aData
        write
    End Property

    Property Get get_parse_qinq
        get_parse_qinq = read_parse_qinq_value
    End Property

    Property Let set_parse_qinq(aData)
        write_parse_qinq_value = aData
        flag_parse_qinq        = &H1
    End Property

    Property Get read_parse_qinq
        read
        read_parse_qinq = read_parse_qinq_value
    End Property

    Property Let write_parse_qinq(aData)
        set_parse_qinq = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        parse_stag0_mask = &H1
        if data_low > LONG_MAX then
            if parse_stag0_mask = mask then
                read_parse_stag0_value = data_low
            else
                read_parse_stag0_value = (data_low - H8000_0000) and parse_stag0_mask
            end If
        else
            read_parse_stag0_value = data_low and parse_stag0_mask
        end If
        read_parse_stag1_value = rightShift(data_low, 1) and &H1
        read_parse_stag2_value = rightShift(data_low, 2) and &H1
        read_parse_stag3_value = rightShift(data_low, 3) and &H1
        read_parse_qinq_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_parse_stag0 = &H0 or flag_parse_stag1 = &H0 or flag_parse_stag2 = &H0 or flag_parse_stag3 = &H0 or flag_parse_qinq = &H0 Then read
        If flag_parse_stag0 = &H0 Then write_parse_stag0_value = get_parse_stag0
        If flag_parse_stag1 = &H0 Then write_parse_stag1_value = get_parse_stag1
        If flag_parse_stag2 = &H0 Then write_parse_stag2_value = get_parse_stag2
        If flag_parse_stag3 = &H0 Then write_parse_stag3_value = get_parse_stag3
        If flag_parse_qinq = &H0 Then write_parse_qinq_value = get_parse_qinq

        regValue = leftShift((write_parse_stag0_value and &H1), 0) + leftShift((write_parse_stag1_value and &H1), 1) + leftShift((write_parse_stag2_value and &H1), 2) + leftShift((write_parse_stag3_value and &H1), 3) + leftShift((write_parse_qinq_value and &H1), 31)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        parse_stag0_mask = &H1
        if data_low > LONG_MAX then
            if parse_stag0_mask = mask then
                read_parse_stag0_value = data_low
            else
                read_parse_stag0_value = (data_low - H8000_0000) and parse_stag0_mask
            end If
        else
            read_parse_stag0_value = data_low and parse_stag0_mask
        end If
        read_parse_stag1_value = rightShift(data_low, 1) and &H1
        read_parse_stag2_value = rightShift(data_low, 2) and &H1
        read_parse_stag3_value = rightShift(data_low, 3) and &H1
        read_parse_qinq_value = rightShift(data_low, 31) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_parse_stag0_value = &H0
        flag_parse_stag0        = &H0
        write_parse_stag1_value = &H0
        flag_parse_stag1        = &H0
        write_parse_stag2_value = &H0
        flag_parse_stag2        = &H0
        write_parse_stag3_value = &H0
        flag_parse_stag3        = &H0
        write_parse_qinq_value = &H0
        flag_parse_qinq        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_match_mode
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' e_type_sel_0                               [8:8]            get_e_type_sel_0
''                                                             set_e_type_sel_0
''                                                             read_e_type_sel_0
''                                                             write_e_type_sel_0
''---------------------------------------------------------------------------------
'' e_type_sel_1                               [9:9]            get_e_type_sel_1
''                                                             set_e_type_sel_1
''                                                             read_e_type_sel_1
''                                                             write_e_type_sel_1
''---------------------------------------------------------------------------------
'' e_type_sel_2                               [10:10]          get_e_type_sel_2
''                                                             set_e_type_sel_2
''                                                             read_e_type_sel_2
''                                                             write_e_type_sel_2
''---------------------------------------------------------------------------------
'' e_type_sel_3                               [11:11]          get_e_type_sel_3
''                                                             set_e_type_sel_3
''                                                             read_e_type_sel_3
''                                                             write_e_type_sel_3
''---------------------------------------------------------------------------------
'' e_type_sel_4                               [12:12]          get_e_type_sel_4
''                                                             set_e_type_sel_4
''                                                             read_e_type_sel_4
''                                                             write_e_type_sel_4
''---------------------------------------------------------------------------------
'' e_type_sel_5                               [13:13]          get_e_type_sel_5
''                                                             set_e_type_sel_5
''                                                             read_e_type_sel_5
''                                                             write_e_type_sel_5
''---------------------------------------------------------------------------------
'' e_type_sel_6                               [14:14]          get_e_type_sel_6
''                                                             set_e_type_sel_6
''                                                             read_e_type_sel_6
''                                                             write_e_type_sel_6
''---------------------------------------------------------------------------------
'' e_type_sel_7                               [15:15]          get_e_type_sel_7
''                                                             set_e_type_sel_7
''                                                             read_e_type_sel_7
''                                                             write_e_type_sel_7
''---------------------------------------------------------------------------------
'' e_type_sel_8                               [16:16]          get_e_type_sel_8
''                                                             set_e_type_sel_8
''                                                             read_e_type_sel_8
''                                                             write_e_type_sel_8
''---------------------------------------------------------------------------------
'' e_type_sel_9                               [17:17]          get_e_type_sel_9
''                                                             set_e_type_sel_9
''                                                             read_e_type_sel_9
''                                                             write_e_type_sel_9
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_match_mode
    Private write_e_type_sel_0_value
    Private read_e_type_sel_0_value
    Private flag_e_type_sel_0
    Private write_e_type_sel_1_value
    Private read_e_type_sel_1_value
    Private flag_e_type_sel_1
    Private write_e_type_sel_2_value
    Private read_e_type_sel_2_value
    Private flag_e_type_sel_2
    Private write_e_type_sel_3_value
    Private read_e_type_sel_3_value
    Private flag_e_type_sel_3
    Private write_e_type_sel_4_value
    Private read_e_type_sel_4_value
    Private flag_e_type_sel_4
    Private write_e_type_sel_5_value
    Private read_e_type_sel_5_value
    Private flag_e_type_sel_5
    Private write_e_type_sel_6_value
    Private read_e_type_sel_6_value
    Private flag_e_type_sel_6
    Private write_e_type_sel_7_value
    Private read_e_type_sel_7_value
    Private flag_e_type_sel_7
    Private write_e_type_sel_8_value
    Private read_e_type_sel_8_value
    Private flag_e_type_sel_8
    Private write_e_type_sel_9_value
    Private read_e_type_sel_9_value
    Private flag_e_type_sel_9

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_e_type_sel_0
        get_e_type_sel_0 = read_e_type_sel_0_value
    End Property

    Property Let set_e_type_sel_0(aData)
        write_e_type_sel_0_value = aData
        flag_e_type_sel_0        = &H1
    End Property

    Property Get read_e_type_sel_0
        read
        read_e_type_sel_0 = read_e_type_sel_0_value
    End Property

    Property Let write_e_type_sel_0(aData)
        set_e_type_sel_0 = aData
        write
    End Property

    Property Get get_e_type_sel_1
        get_e_type_sel_1 = read_e_type_sel_1_value
    End Property

    Property Let set_e_type_sel_1(aData)
        write_e_type_sel_1_value = aData
        flag_e_type_sel_1        = &H1
    End Property

    Property Get read_e_type_sel_1
        read
        read_e_type_sel_1 = read_e_type_sel_1_value
    End Property

    Property Let write_e_type_sel_1(aData)
        set_e_type_sel_1 = aData
        write
    End Property

    Property Get get_e_type_sel_2
        get_e_type_sel_2 = read_e_type_sel_2_value
    End Property

    Property Let set_e_type_sel_2(aData)
        write_e_type_sel_2_value = aData
        flag_e_type_sel_2        = &H1
    End Property

    Property Get read_e_type_sel_2
        read
        read_e_type_sel_2 = read_e_type_sel_2_value
    End Property

    Property Let write_e_type_sel_2(aData)
        set_e_type_sel_2 = aData
        write
    End Property

    Property Get get_e_type_sel_3
        get_e_type_sel_3 = read_e_type_sel_3_value
    End Property

    Property Let set_e_type_sel_3(aData)
        write_e_type_sel_3_value = aData
        flag_e_type_sel_3        = &H1
    End Property

    Property Get read_e_type_sel_3
        read
        read_e_type_sel_3 = read_e_type_sel_3_value
    End Property

    Property Let write_e_type_sel_3(aData)
        set_e_type_sel_3 = aData
        write
    End Property

    Property Get get_e_type_sel_4
        get_e_type_sel_4 = read_e_type_sel_4_value
    End Property

    Property Let set_e_type_sel_4(aData)
        write_e_type_sel_4_value = aData
        flag_e_type_sel_4        = &H1
    End Property

    Property Get read_e_type_sel_4
        read
        read_e_type_sel_4 = read_e_type_sel_4_value
    End Property

    Property Let write_e_type_sel_4(aData)
        set_e_type_sel_4 = aData
        write
    End Property

    Property Get get_e_type_sel_5
        get_e_type_sel_5 = read_e_type_sel_5_value
    End Property

    Property Let set_e_type_sel_5(aData)
        write_e_type_sel_5_value = aData
        flag_e_type_sel_5        = &H1
    End Property

    Property Get read_e_type_sel_5
        read
        read_e_type_sel_5 = read_e_type_sel_5_value
    End Property

    Property Let write_e_type_sel_5(aData)
        set_e_type_sel_5 = aData
        write
    End Property

    Property Get get_e_type_sel_6
        get_e_type_sel_6 = read_e_type_sel_6_value
    End Property

    Property Let set_e_type_sel_6(aData)
        write_e_type_sel_6_value = aData
        flag_e_type_sel_6        = &H1
    End Property

    Property Get read_e_type_sel_6
        read
        read_e_type_sel_6 = read_e_type_sel_6_value
    End Property

    Property Let write_e_type_sel_6(aData)
        set_e_type_sel_6 = aData
        write
    End Property

    Property Get get_e_type_sel_7
        get_e_type_sel_7 = read_e_type_sel_7_value
    End Property

    Property Let set_e_type_sel_7(aData)
        write_e_type_sel_7_value = aData
        flag_e_type_sel_7        = &H1
    End Property

    Property Get read_e_type_sel_7
        read
        read_e_type_sel_7 = read_e_type_sel_7_value
    End Property

    Property Let write_e_type_sel_7(aData)
        set_e_type_sel_7 = aData
        write
    End Property

    Property Get get_e_type_sel_8
        get_e_type_sel_8 = read_e_type_sel_8_value
    End Property

    Property Let set_e_type_sel_8(aData)
        write_e_type_sel_8_value = aData
        flag_e_type_sel_8        = &H1
    End Property

    Property Get read_e_type_sel_8
        read
        read_e_type_sel_8 = read_e_type_sel_8_value
    End Property

    Property Let write_e_type_sel_8(aData)
        set_e_type_sel_8 = aData
        write
    End Property

    Property Get get_e_type_sel_9
        get_e_type_sel_9 = read_e_type_sel_9_value
    End Property

    Property Let set_e_type_sel_9(aData)
        write_e_type_sel_9_value = aData
        flag_e_type_sel_9        = &H1
    End Property

    Property Get read_e_type_sel_9
        read
        read_e_type_sel_9 = read_e_type_sel_9_value
    End Property

    Property Let write_e_type_sel_9(aData)
        set_e_type_sel_9 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_e_type_sel_0_value = rightShift(data_low, 8) and &H1
        read_e_type_sel_1_value = rightShift(data_low, 9) and &H1
        read_e_type_sel_2_value = rightShift(data_low, 10) and &H1
        read_e_type_sel_3_value = rightShift(data_low, 11) and &H1
        read_e_type_sel_4_value = rightShift(data_low, 12) and &H1
        read_e_type_sel_5_value = rightShift(data_low, 13) and &H1
        read_e_type_sel_6_value = rightShift(data_low, 14) and &H1
        read_e_type_sel_7_value = rightShift(data_low, 15) and &H1
        read_e_type_sel_8_value = rightShift(data_low, 16) and &H1
        read_e_type_sel_9_value = rightShift(data_low, 17) and &H1

    End Sub

    Sub write
        If flag_e_type_sel_0 = &H0 or flag_e_type_sel_1 = &H0 or flag_e_type_sel_2 = &H0 or flag_e_type_sel_3 = &H0 or flag_e_type_sel_4 = &H0 or flag_e_type_sel_5 = &H0 or flag_e_type_sel_6 = &H0 or flag_e_type_sel_7 = &H0 or flag_e_type_sel_8 = &H0 or flag_e_type_sel_9 = &H0 Then read
        If flag_e_type_sel_0 = &H0 Then write_e_type_sel_0_value = get_e_type_sel_0
        If flag_e_type_sel_1 = &H0 Then write_e_type_sel_1_value = get_e_type_sel_1
        If flag_e_type_sel_2 = &H0 Then write_e_type_sel_2_value = get_e_type_sel_2
        If flag_e_type_sel_3 = &H0 Then write_e_type_sel_3_value = get_e_type_sel_3
        If flag_e_type_sel_4 = &H0 Then write_e_type_sel_4_value = get_e_type_sel_4
        If flag_e_type_sel_5 = &H0 Then write_e_type_sel_5_value = get_e_type_sel_5
        If flag_e_type_sel_6 = &H0 Then write_e_type_sel_6_value = get_e_type_sel_6
        If flag_e_type_sel_7 = &H0 Then write_e_type_sel_7_value = get_e_type_sel_7
        If flag_e_type_sel_8 = &H0 Then write_e_type_sel_8_value = get_e_type_sel_8
        If flag_e_type_sel_9 = &H0 Then write_e_type_sel_9_value = get_e_type_sel_9

        regValue = leftShift((write_e_type_sel_0_value and &H1), 8) + leftShift((write_e_type_sel_1_value and &H1), 9) + leftShift((write_e_type_sel_2_value and &H1), 10) + leftShift((write_e_type_sel_3_value and &H1), 11) + leftShift((write_e_type_sel_4_value and &H1), 12) + leftShift((write_e_type_sel_5_value and &H1), 13) + leftShift((write_e_type_sel_6_value and &H1), 14) + leftShift((write_e_type_sel_7_value and &H1), 15) + leftShift((write_e_type_sel_8_value and &H1), 16) + leftShift((write_e_type_sel_9_value and &H1), 17)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_e_type_sel_0_value = rightShift(data_low, 8) and &H1
        read_e_type_sel_1_value = rightShift(data_low, 9) and &H1
        read_e_type_sel_2_value = rightShift(data_low, 10) and &H1
        read_e_type_sel_3_value = rightShift(data_low, 11) and &H1
        read_e_type_sel_4_value = rightShift(data_low, 12) and &H1
        read_e_type_sel_5_value = rightShift(data_low, 13) and &H1
        read_e_type_sel_6_value = rightShift(data_low, 14) and &H1
        read_e_type_sel_7_value = rightShift(data_low, 15) and &H1
        read_e_type_sel_8_value = rightShift(data_low, 16) and &H1
        read_e_type_sel_9_value = rightShift(data_low, 17) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_e_type_sel_0_value = &H0
        flag_e_type_sel_0        = &H0
        write_e_type_sel_1_value = &H0
        flag_e_type_sel_1        = &H0
        write_e_type_sel_2_value = &H0
        flag_e_type_sel_2        = &H0
        write_e_type_sel_3_value = &H0
        flag_e_type_sel_3        = &H0
        write_e_type_sel_4_value = &H0
        flag_e_type_sel_4        = &H0
        write_e_type_sel_5_value = &H0
        flag_e_type_sel_5        = &H0
        write_e_type_sel_6_value = &H0
        flag_e_type_sel_6        = &H0
        write_e_type_sel_7_value = &H0
        flag_e_type_sel_7        = &H0
        write_e_type_sel_8_value = &H0
        flag_e_type_sel_8        = &H0
        write_e_type_sel_9_value = &H0
        flag_e_type_sel_9        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_match_enable
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
'' macsec_kay                                 [31:31]          get_macsec_kay
''                                                             set_macsec_kay
''                                                             read_macsec_kay
''                                                             write_macsec_kay
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_match_enable
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
    Private write_macsec_kay_value
    Private read_macsec_kay_value
    Private flag_macsec_kay

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78fc
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

    Property Get get_macsec_kay
        get_macsec_kay = read_macsec_kay_value
    End Property

    Property Let set_macsec_kay(aData)
        write_macsec_kay_value = aData
        flag_macsec_kay        = &H1
    End Property

    Property Get read_macsec_kay
        read
        read_macsec_kay = read_macsec_kay_value
    End Property

    Property Let write_macsec_kay(aData)
        set_macsec_kay = aData
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
        read_macsec_kay_value = rightShift(data_low, 31) and &H1

    End Sub

    Sub write
        If flag_mac_da_0 = &H0 or flag_mac_da_1 = &H0 or flag_mac_da_2 = &H0 or flag_mac_da_3 = &H0 or flag_mac_da_4 = &H0 or flag_mac_da_5 = &H0 or flag_mac_da_6 = &H0 or flag_mac_da_7 = &H0 or flag_e_type_0 = &H0 or flag_e_type_1 = &H0 or flag_e_type_2 = &H0 or flag_e_type_3 = &H0 or flag_e_type_4 = &H0 or flag_e_type_5 = &H0 or flag_e_type_6 = &H0 or flag_e_type_7 = &H0 or flag_comb8 = &H0 or flag_comb9 = &H0 or flag_range = &H0 or flag_const_44 = &H0 or flag_const_48 = &H0 or flag_macsec_kay = &H0 Then read
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
        If flag_macsec_kay = &H0 Then write_macsec_kay_value = get_macsec_kay

        regValue = leftShift((write_mac_da_0_value and &H1), 0) + leftShift((write_mac_da_1_value and &H1), 1) + leftShift((write_mac_da_2_value and &H1), 2) + leftShift((write_mac_da_3_value and &H1), 3) + leftShift((write_mac_da_4_value and &H1), 4) + leftShift((write_mac_da_5_value and &H1), 5) + leftShift((write_mac_da_6_value and &H1), 6) + leftShift((write_mac_da_7_value and &H1), 7) + leftShift((write_e_type_0_value and &H1), 8) + leftShift((write_e_type_1_value and &H1), 9) + leftShift((write_e_type_2_value and &H1), 10) + leftShift((write_e_type_3_value and &H1), 11) + leftShift((write_e_type_4_value and &H1), 12) + leftShift((write_e_type_5_value and &H1), 13) + leftShift((write_e_type_6_value and &H1), 14) + leftShift((write_e_type_7_value and &H1), 15) + leftShift((write_comb8_value and &H1), 16) + leftShift((write_comb9_value and &H1), 17) + leftShift((write_range_value and &H1), 18) + leftShift((write_const_44_value and &H1), 19) + leftShift((write_const_48_value and &H1), 20) + leftShift((write_macsec_kay_value and &H1), 31)
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
        read_macsec_kay_value = rightShift(data_low, 31) and &H1

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
        write_macsec_kay_value = &H0
        flag_macsec_kay        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_INSTANCE

    Public cp_mac_da_match_0
    Public cp_mac_da_et_match_0
    Public cp_mac_da_match_1
    Public cp_mac_da_et_match_1
    Public cp_mac_da_match_2
    Public cp_mac_da_et_match_2
    Public cp_mac_da_match_3
    Public cp_mac_da_et_match_3
    Public cp_mac_da_match_4
    Public cp_mac_da_et_match_4
    Public cp_mac_da_match_5
    Public cp_mac_da_et_match_5
    Public cp_mac_da_match_6
    Public cp_mac_da_et_match_6
    Public cp_mac_da_match_7
    Public cp_mac_da_et_match_7
    Public cp_mac_da_start0_lo
    Public cp_mac_da_start0_hi
    Public cp_mac_da_end0_lo
    Public cp_mac_da_end0_hi
    Public cp_mac_da_start1_lo
    Public cp_mac_da_start1_hi
    Public cp_mac_da_end1_lo
    Public cp_mac_da_end1_hi
    Public cp_mac_da_start_lo
    Public cp_mac_da_start_hi
    Public cp_mac_da_end_lo
    Public cp_mac_da_end_hi
    Public cp_mac_da_44_bits_lo
    Public cp_mac_da_44_bits_hi
    Public cp_mac_da_48_bits_lo
    Public cp_mac_da_48_bits_hi
    Public scp_tag_enb
    Public scp_match_mode
    Public scp_match_enable
    Public cp_tag_enb
    Public cp_match_mode
    Public cp_match_enable


    Public default function Init(aBaseAddr)
        Set cp_mac_da_match_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_0)(aBaseAddr, 32)
        Set cp_mac_da_et_match_0 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_0)(aBaseAddr, 32)
        Set cp_mac_da_match_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_1)(aBaseAddr, 32)
        Set cp_mac_da_et_match_1 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_1)(aBaseAddr, 32)
        Set cp_mac_da_match_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_2)(aBaseAddr, 32)
        Set cp_mac_da_et_match_2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_2)(aBaseAddr, 32)
        Set cp_mac_da_match_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_3)(aBaseAddr, 32)
        Set cp_mac_da_et_match_3 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_3)(aBaseAddr, 32)
        Set cp_mac_da_match_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_4)(aBaseAddr, 32)
        Set cp_mac_da_et_match_4 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_4)(aBaseAddr, 32)
        Set cp_mac_da_match_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_5)(aBaseAddr, 32)
        Set cp_mac_da_et_match_5 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_5)(aBaseAddr, 32)
        Set cp_mac_da_match_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_6)(aBaseAddr, 32)
        Set cp_mac_da_et_match_6 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_6)(aBaseAddr, 32)
        Set cp_mac_da_match_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_match_7)(aBaseAddr, 32)
        Set cp_mac_da_et_match_7 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_et_match_7)(aBaseAddr, 32)
        Set cp_mac_da_start0_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start0_lo)(aBaseAddr, 32)
        Set cp_mac_da_start0_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start0_hi)(aBaseAddr, 32)
        Set cp_mac_da_end0_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end0_lo)(aBaseAddr, 32)
        Set cp_mac_da_end0_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end0_hi)(aBaseAddr, 32)
        Set cp_mac_da_start1_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start1_lo)(aBaseAddr, 32)
        Set cp_mac_da_start1_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start1_hi)(aBaseAddr, 32)
        Set cp_mac_da_end1_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end1_lo)(aBaseAddr, 32)
        Set cp_mac_da_end1_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end1_hi)(aBaseAddr, 32)
        Set cp_mac_da_start_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start_lo)(aBaseAddr, 32)
        Set cp_mac_da_start_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_start_hi)(aBaseAddr, 32)
        Set cp_mac_da_end_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end_lo)(aBaseAddr, 32)
        Set cp_mac_da_end_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_end_hi)(aBaseAddr, 32)
        Set cp_mac_da_44_bits_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_44_bits_lo)(aBaseAddr, 32)
        Set cp_mac_da_44_bits_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_44_bits_hi)(aBaseAddr, 32)
        Set cp_mac_da_48_bits_lo = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_48_bits_lo)(aBaseAddr, 32)
        Set cp_mac_da_48_bits_hi = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_mac_da_48_bits_hi)(aBaseAddr, 32)
        Set scp_tag_enb = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_tag_enb)(aBaseAddr, 32)
        Set scp_match_mode = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_match_mode)(aBaseAddr, 32)
        Set scp_match_enable = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_scp_match_enable)(aBaseAddr, 32)
        Set cp_tag_enb = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_tag_enb)(aBaseAddr, 32)
        Set cp_match_mode = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_match_mode)(aBaseAddr, 32)
        Set cp_match_enable = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_cp_match_enable)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET.Add ((New EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET.Add ((New EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET.Add ((New EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET.Add ((New EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET.Add ((New EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET.Add ((New EIP165S_EIP_160S_I_32_BRCM_CLASSIFIER_CONTROL_PACKET_INSTANCE)(&H4d510000))


