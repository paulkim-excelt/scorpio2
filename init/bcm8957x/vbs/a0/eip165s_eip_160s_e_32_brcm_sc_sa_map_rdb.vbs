

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


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_0
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13800
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_1
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13808
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_2
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13810
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_3
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13818
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_4
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13820
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_5
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13828
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_6
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13830
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_7
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13838
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_8
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13840
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_9
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13848
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_10
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13850
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_11
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13858
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_12
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13860
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_13
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13868
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_14
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13870
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sa_index0                                  [4:0]            get_sa_index0
''                                                             set_sa_index0
''                                                             read_sa_index0
''                                                             write_sa_index0
''---------------------------------------------------------------------------------
'' sa_index_update0                           [13:13]          get_sa_index_update0
''                                                             set_sa_index_update0
''                                                             read_sa_index_update0
''                                                             write_sa_index_update0
''---------------------------------------------------------------------------------
'' update_time0                               [14:14]          get_update_time0
''                                                             set_update_time0
''                                                             read_update_time0
''                                                             write_update_time0
''---------------------------------------------------------------------------------
'' sa_in_use0                                 [15:15]          get_sa_in_use0
''                                                             set_sa_in_use0
''                                                             read_sa_in_use0
''                                                             write_sa_in_use0
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_15
    Private write_sa_index0_value
    Private read_sa_index0_value
    Private flag_sa_index0
    Private write_sa_index_update0_value
    Private read_sa_index_update0_value
    Private flag_sa_index_update0
    Private write_update_time0_value
    Private read_update_time0_value
    Private flag_update_time0
    Private write_sa_in_use0_value
    Private read_sa_in_use0_value
    Private flag_sa_in_use0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H13878
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_sa_index0
        get_sa_index0 = read_sa_index0_value
    End Property

    Property Let set_sa_index0(aData)
        write_sa_index0_value = aData
        flag_sa_index0        = &H1
    End Property

    Property Get read_sa_index0
        read
        read_sa_index0 = read_sa_index0_value
    End Property

    Property Let write_sa_index0(aData)
        set_sa_index0 = aData
        write
    End Property

    Property Get get_sa_index_update0
        get_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let set_sa_index_update0(aData)
        write_sa_index_update0_value = aData
        flag_sa_index_update0        = &H1
    End Property

    Property Get read_sa_index_update0
        read
        read_sa_index_update0 = read_sa_index_update0_value
    End Property

    Property Let write_sa_index_update0(aData)
        set_sa_index_update0 = aData
        write
    End Property

    Property Get get_update_time0
        get_update_time0 = read_update_time0_value
    End Property

    Property Let set_update_time0(aData)
        write_update_time0_value = aData
        flag_update_time0        = &H1
    End Property

    Property Get read_update_time0
        read
        read_update_time0 = read_update_time0_value
    End Property

    Property Let write_update_time0(aData)
        set_update_time0 = aData
        write
    End Property

    Property Get get_sa_in_use0
        get_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let set_sa_in_use0(aData)
        write_sa_in_use0_value = aData
        flag_sa_in_use0        = &H1
    End Property

    Property Get read_sa_in_use0
        read
        read_sa_in_use0 = read_sa_in_use0_value
    End Property

    Property Let write_sa_in_use0(aData)
        set_sa_in_use0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_sa_index0 = &H0 or flag_sa_index_update0 = &H0 or flag_update_time0 = &H0 or flag_sa_in_use0 = &H0 Then read
        If flag_sa_index0 = &H0 Then write_sa_index0_value = get_sa_index0
        If flag_sa_index_update0 = &H0 Then write_sa_index_update0_value = get_sa_index_update0
        If flag_update_time0 = &H0 Then write_update_time0_value = get_update_time0
        If flag_sa_in_use0 = &H0 Then write_sa_in_use0_value = get_sa_in_use0

        regValue = leftShift((write_sa_index0_value and &H1f), 0) + leftShift((write_sa_index_update0_value and &H1), 13) + leftShift((write_update_time0_value and &H1), 14) + leftShift((write_sa_in_use0_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        sa_index0_mask = &H1f
        if data_low > LONG_MAX then
            if sa_index0_mask = mask then
                read_sa_index0_value = data_low
            else
                read_sa_index0_value = (data_low - H8000_0000) and sa_index0_mask
            end If
        else
            read_sa_index0_value = data_low and sa_index0_mask
        end If
        read_sa_index_update0_value = rightShift(data_low, 13) and &H1
        read_update_time0_value = rightShift(data_low, 14) and &H1
        read_sa_in_use0_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sa_index0_value = &H0
        flag_sa_index0        = &H0
        write_sa_index_update0_value = &H0
        flag_sa_index_update0        = &H0
        write_update_time0_value = &H0
        flag_update_time0        = &H0
        write_sa_in_use0_value = &H0
        flag_sa_in_use0        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_INSTANCE

    Public sam_sc_sa_map1_0
    Public sam_sc_sa_map1_1
    Public sam_sc_sa_map1_2
    Public sam_sc_sa_map1_3
    Public sam_sc_sa_map1_4
    Public sam_sc_sa_map1_5
    Public sam_sc_sa_map1_6
    Public sam_sc_sa_map1_7
    Public sam_sc_sa_map1_8
    Public sam_sc_sa_map1_9
    Public sam_sc_sa_map1_10
    Public sam_sc_sa_map1_11
    Public sam_sc_sa_map1_12
    Public sam_sc_sa_map1_13
    Public sam_sc_sa_map1_14
    Public sam_sc_sa_map1_15


    Public default function Init(aBaseAddr)
        Set sam_sc_sa_map1_0 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_0)(aBaseAddr, 32)
        Set sam_sc_sa_map1_1 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_1)(aBaseAddr, 32)
        Set sam_sc_sa_map1_2 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_2)(aBaseAddr, 32)
        Set sam_sc_sa_map1_3 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_3)(aBaseAddr, 32)
        Set sam_sc_sa_map1_4 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_4)(aBaseAddr, 32)
        Set sam_sc_sa_map1_5 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_5)(aBaseAddr, 32)
        Set sam_sc_sa_map1_6 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_6)(aBaseAddr, 32)
        Set sam_sc_sa_map1_7 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_7)(aBaseAddr, 32)
        Set sam_sc_sa_map1_8 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_8)(aBaseAddr, 32)
        Set sam_sc_sa_map1_9 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_9)(aBaseAddr, 32)
        Set sam_sc_sa_map1_10 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_10)(aBaseAddr, 32)
        Set sam_sc_sa_map1_11 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_11)(aBaseAddr, 32)
        Set sam_sc_sa_map1_12 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_12)(aBaseAddr, 32)
        Set sam_sc_sa_map1_13 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_13)(aBaseAddr, 32)
        Set sam_sc_sa_map1_14 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_14)(aBaseAddr, 32)
        Set sam_sc_sa_map1_15 = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_sam_sc_sa_map1_15)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP.Add ((New EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP.Add ((New EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP.Add ((New EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP.Add ((New EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP.Add ((New EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP.Add ((New EIP165S_EIP_160S_E_32_BRCM_SC_SA_MAP_INSTANCE)(&H4d510000))


